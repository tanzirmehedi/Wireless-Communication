
%SK. Tanzir Mehedi Shawon
%ID: IT-14012

clear all;
close all;
clc;

ad=input('Enter sequence of A: ' );
ac=input('Enter the codeword of A: ','s');

fprintf('\n')

bd=input('Enter sequence of B: ' );
bc=input('Enter the Codeword of B: ','s');

ads= num2str(ad)-'0';
bds=num2str(bd)-'0';

acs= num2str(ac)-'0';
bcs=num2str(bc)-'0';

adsl=length(ads);
bdsl=length(bds);

if adsl>bdsl
    bds=[ zeros(1,adsl-bdsl) bds];
elseif bdsl>adsl
    ads=[ zeros(1,bdsl-adsl) ads]; 
elseif adsl==bdsl
    ads=ads(1:adsl);
    bds=bds(1:bdsl);
end

disp('A Dataword :');
ads

disp('A Codeword :');
acs

disp('B Dataword :');
bds

disp('B Codeword :');
bcs

adsll=length(ads);
bdsll=length(bds);

adc_xor_full=[];  

for i=1:adsll
    adc_xor=xor(ads(i),acs);
    adc_xor_full = [adc_xor_full adc_xor];   
end

disp('Dataword XOR Codeword of Signal A');
adc_xor_full

bdc_xor_full=[];  

for i=1:adsll
    bdc_xor=xor(bds(i),bcs);
    bdc_xor_full = [bdc_xor_full bdc_xor];   
end

disp('Dataword XOR Codeword of Signal B');
bdc_xor_full

transmitted=[];

for i=1:length(adc_xor_full)  
    
          if((adc_xor_full(i)==1) && (bdc_xor_full(i)==0))
            transmitted=[transmitted 0];
          end
            
          if((adc_xor_full(i)==0) && (bdc_xor_full(i)==1))
            transmitted=[transmitted 0];
          end
          
          if((adc_xor_full(i)==0) && (bdc_xor_full(i)==0)) 
            transmitted=[transmitted -1];
          end
        
          if((adc_xor_full(i)==1) && (bdc_xor_full(i)==1))
            transmitted=[transmitted 1];
          end
            
end

disp('Transmitted A+B Signal');
transmitted


transmitted_len=length(transmitted);
acs_len=length(acs);
bcs_len=length(bcs);

integrator_len_a=transmitted_len/acs_len;
integrator_len_b=transmitted_len/bcs_len;

acs_inverse=[];

for i=1:acs_len
    
    if(acs(i)==0)
        acs_inverse=[acs_inverse -1];
    end
    
     if(acs(i)==1)
        acs_inverse=[acs_inverse +1];
    end
end

bcs_inverse=[];

for i=1:bcs_len
    
    if(bcs(i)==0)
        bcs_inverse=[bcs_inverse -1];
    end
    
     if(bcs(i)==1)
        bcs_inverse=[bcs_inverse +1];
    end
end

acs_inverse_full=[];

for i=1: integrator_len_a
    acs_inverse_full=[acs_inverse_full acs_inverse];
end

disp('A Codeword at Receiver');
acs_inverse_full

    
bcs_inverse_full=[];

for i=1: integrator_len_b
    bcs_inverse_full=[bcs_inverse_full bcs_inverse];
end

disp('B Codeword at Receiver');
bcs_inverse_full

intregrator_output_a=[];

for i=1:transmitted_len
    intregrator_output=transmitted(i)*acs_inverse_full(i);
    intregrator_output_a=[intregrator_output_a intregrator_output];
end

disp('(A+B) * A Codeword at Receiver');
intregrator_output_a

intregrator_output_b=[];

for i=1:transmitted_len
    intregrator_outputt=transmitted(i)*bcs_inverse_full(i);
    intregrator_output_b=[intregrator_output_b intregrator_outputt];
end

disp('(A+B) * B Codeword at Receiver');
intregrator_output_b

comparator_output_a=[];
final_comparator_output_a=[];

k=0;
for i=1:integrator_len_a
    for j=k+1:acs_len+k
       comparator_output_a=[comparator_output_a intregrator_output_a(j)]; 
     s=j;
    end    
    k=s; 

    final_output_a = any(comparator_output_a(:) > 0) ;
    
    comparator_output_a=[];
     
    final_comparator_output_a=[final_comparator_output_a final_output_a];
end

disp('Comparator Output of A');
final_comparator_output_a

comparator_output_b=[];
final_comparator_output_b=[];

k=0;
for i=1:integrator_len_b
    for j=k+1:bcs_len+k
       comparator_output_b=[comparator_output_b intregrator_output_b(j)]; 
     s=j;
    end    
    k=s; 

    final_output_b = any(comparator_output_b(:) > 0) ;
    
    comparator_output_b=[];
     
    final_comparator_output_b=[final_comparator_output_b final_output_b];
end

disp('Comparator Output of B');
final_comparator_output_b

for i=1:adsl
  final_comparator_output_aa= ~final_comparator_output_a;
end

disp('Recovery Signal of A');
final_comparator_output_aa

for i=1:bdsl
  final_comparator_output_bb = ~final_comparator_output_b;
end

disp('Recovery Signal of B');
final_comparator_output_bb




            

