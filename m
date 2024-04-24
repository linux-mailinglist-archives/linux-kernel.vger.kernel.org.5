Return-Path: <linux-kernel+bounces-156518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF48B03B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368F62820F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459ED158869;
	Wed, 24 Apr 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cm7Dey9+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5D158205;
	Wed, 24 Apr 2024 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945599; cv=none; b=VMT6pVEgKW+3TSOUI9lmjTJYOuZu+m8NAgha/1XCuNZO/jTwtv0vicG0YpSwewXI+Sc2F1l1Q8vfPoCwLocp78dKzybcytQSlp3GTvBB2tpk5zj4Q0Zi0eirTP2sbkn6SvbBD8d0gHaOMASL34lY1lhkKi0iLmgfoqa3PGY8dDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945599; c=relaxed/simple;
	bh=T35gvkuwM5s4iTjUyQmUBzVBzf1+ZNciql8ulW41aiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xdx87oOnk2dvbeTqOkAOViiwBJea4GMW/C1ZceyCNCHh/HilY4CTYiyCSuo5Z50UdwIwICtNhMsWrjK5HhT0BpHkxQnxIvtaI7x77FisI0cDBlaN6nw8K4GnDFmVudg+fLdaC94CWQE07jnExHghDu6rfGZLNZjLTt04cctM/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cm7Dey9+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6WwSl004275;
	Wed, 24 Apr 2024 07:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tRnJdsFGGDrlqFIGZuXEm3psk90P1dcPKPOORvPZCvQ=; b=cm
	7Dey9+6dPHcQEnmKwIcPa4+NORs0DyHFlVqC0GL8OAHtfrlfbm9O011hiuMclzUu
	nCCiqCwTWRwYkjGatqfQAdwMckVEfXuApZ+GFccEv5W5lXpvlhlaw2xE8zNCLJJg
	b+HbzmvHS6Ke1EuM4wV2o7WXzYWvILgMVOB2dGW5OV9fsdBvyxEi61QLk9Y0HNwt
	B2h2GhkXYjl1SAnMSKVjCmZ5ku4PmAaWIIgHK/LyeA47/+Fuc/ujWX+cjQVnN5Dl
	PFDItCtD+4OfRUa+MobOlH++hVCISPeIrP2CD5l2HfIAR3402h6HMfHI5ST+ih4L
	f+VQ7t6vH2Djch2YWAtA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9fg7tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 07:59:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O7xTRu032237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 07:59:29 GMT
Received: from [10.216.52.243] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 00:59:24 -0700
Message-ID: <7122785c-d6cf-4425-82a5-2f65e0a523d9@quicinc.com>
Date: Wed, 24 Apr 2024 13:29:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Remove CTS/RTS configuration
Content-Language: en-US
To: Luca Weiss <luca.weiss@fairphone.com>,
        <cros-qcom-dts-watchers@chromium.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <swboyd@chromium.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rajpat@codeaurora.org>,
        <mka@chromium.org>, <rojay@codeaurora.org>
CC: <quic_msavaliy@quicinc.com>, <quic_anupkulk@quicinc.com>
References: <20240416105650.2626-1-quic_vdadhani@quicinc.com>
 <D0LINETM8WNA.27BORT75W1N0C@fairphone.com>
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
In-Reply-To: <D0LINETM8WNA.27BORT75W1N0C@fairphone.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GCUW2iiJ6IpqGcnBnV84AUMZ8aKdrkGj
X-Proofpoint-GUID: GCUW2iiJ6IpqGcnBnV84AUMZ8aKdrkGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_05,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240034



On 4/16/2024 5:08 PM, Luca Weiss wrote:
> On Tue Apr 16, 2024 at 12:56 PM CEST, Viken Dadhaniya wrote:
>> Remove CTS and RTS pinctrl configuration for UART5 node as
>> it's designed for debug UART for all the board variants of the
>> sc7280 chipset.
>>
>> Also change compatible string to debug UART.
> 
> This change has little to do with the SoC design though and is dependent
> on the usage on a given board, right? Also the QCM6490 datasheet
> mentions gpio21 & gpio22 can be used for UART_CTS and UART_RFR.
> 
> But at least consistency-wise this change makes sense, in practically
> all other SoCs one UART is marked as geni-debug-uart.
> 
> But with this patch you should then also remove some overrides that are
> placed in various boards already?
> 
> arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts:     compatible = "qcom,geni-debug-uart";
> arch/arm64/boot/dts/qcom/qcm6490-idp.dts:       compatible = "qcom,geni-debug-uart";
> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts:   compatible = "qcom,geni-debug-uart";
> arch/arm64/boot/dts/qcom/sc7280-idp.dtsi:       compatible = "qcom,geni-debug-uart";
> arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi:     compatible = "qcom,geni-debug-uart";
> 
> Regards
> Luca
> 

Updated in V2.

>>
>> Fixes: 38cd93f413fd ("arm64: dts: qcom: sc7280: Update QUPv3 UART5 DT node")
>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 ++------------
>>   1 file changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 38c183b2bb26..2a6b4c4639d1 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -1440,12 +1440,12 @@
>>   			};
>>   
>>   			uart5: serial@994000 {
>> -				compatible = "qcom,geni-uart";
>> +				compatible = "qcom,geni-debug-uart";
>>   				reg = <0 0x00994000 0 0x4000>;
>>   				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
>>   				clock-names = "se";
>>   				pinctrl-names = "default";
>> -				pinctrl-0 = <&qup_uart5_cts>, <&qup_uart5_rts>, <&qup_uart5_tx>, <&qup_uart5_rx>;
>> +				pinctrl-0 = <&qup_uart5_tx>, <&qup_uart5_rx>;
>>   				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
>>   				power-domains = <&rpmhpd SC7280_CX>;
>>   				operating-points-v2 = <&qup_opp_table>;
>> @@ -5397,16 +5397,6 @@
>>   				function = "qup04";
>>   			};
>>   
>> -			qup_uart5_cts: qup-uart5-cts-state {
>> -				pins = "gpio20";
>> -				function = "qup05";
>> -			};
>> -
>> -			qup_uart5_rts: qup-uart5-rts-state {
>> -				pins = "gpio21";
>> -				function = "qup05";
>> -			};
>> -
>>   			qup_uart5_tx: qup-uart5-tx-state {
>>   				pins = "gpio22";
>>   				function = "qup05";
> 

