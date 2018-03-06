clc 
clear all

%% Atividade de Processamento Digital de Sinais
%{

Aluno: Yuri Loia de Medeiros
Turma 1 Período 2017.1
Professor: Edmar Candeia Gurjão
Projeto de Filtro Passa Faixa com Banda de Passagem de 300Hz até 500Hz
%}

%% Informações Necessárias e utilizadas pelos dois Filtros
%Ordem do Filtro
M = 50;

%Número de Pontos
Num = M+1;

%Frequência de Amostragem (Hz)
Fs = 2000;

%Frequência de Amostragem (rad/s)
OmegaS = 2*pi*Fs

%Frequências de Corte (rad/s)
Omegac1 = 300*2*pi;
Omegac2 = 500*2*pi;

%% Filtro por Amostragem na Frequência

%Coeficientes Kp e Kr para definição da resposta
kp1 = floor(Num*Omegac1/(OmegaS));
kp2 = floor(Num*Omegac2/OmegaS);

%A resposta a frequencia do Filtro
RespostaFrequencia = zeros(1,Num);
for cont = 1:Num
    if(cont>=kp1 & cont<=kp2)
        RespostaFrequencia(cont) = 1;
    end
end

figure(1)
stem(RespostaFrequencia,'MarkerSize',1)

%índice para o somatório
k = 1:M/2+ones(1,M/2);

%Amostragem em Frequência 
for n=1:M
    %hAmostragem(n+1) = (1/Num)*(RespostaFrequencia(1) + 2*sum((-1).^k.*RespostaFrequencia(k+1).*cos(pi.*k*(1+2*n)/Num)));
    hAmostragem(n+1) = (2/Num)*(2*sum((-1).^k.*RespostaFrequencia(k+1).*sin(pi.*k*(1+2*n)/Num)));
end;


%Diagrama de Bode para resposta ao impulso
figure(2)
freqz(hAmostragem)

%% Filtro por janelamento 

%Primeiro Valor
h0 = (Omegac2/Fs - Omegac1/Fs)/pi;

%Resposta da primeira parte
n = 1:M/2;
hMeiaResposta = (sin(Omegac2/Fs.*n) - sin(Omegac1/Fs.*n))./(pi.*n);
%Resposta completa a primeira parte é  
hJanelamento = [fliplr(hMeiaResposta) h0 hMeiaResposta];

%Resposta do Filtro (não funciona)
figure(3)
freqz(hJanelamento)
