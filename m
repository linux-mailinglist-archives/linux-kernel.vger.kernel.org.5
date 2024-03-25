Return-Path: <linux-kernel+bounces-116570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3663688A0D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F351F3AF16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D9A13C689;
	Mon, 25 Mar 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V7pK78ZW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336F131182;
	Mon, 25 Mar 2024 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711346936; cv=none; b=Xns0WaEEbUf0BTOlhbenkGNwXXpTEp5RErS9oWnOwEUuWzg2+ULLijZm5+qMXF6ugJE97N7WInXJnXXNH1eTQRzgf/8FqUtqlTFVOn2O0iy5dJephsaUEi9d7nwf8WTfyjuyEDMNSIfo7ICBuSjfPvtfUdoOHDhfp/fcStbqgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711346936; c=relaxed/simple;
	bh=0X3lQZCtCIqZxUJ9uhQyObvN2+Yamo7C/RuOYbslsjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LZ35uic28pl1ttQi45yjAEEHkbXVYvkZ6w8NHjPHiIARzHqdtcR4R+Y8KKzfSPJ4vyVLCZHxgR9S++4E5UnE9eZyZkPDJkxicWZfhr4Du9+8FRRsiAR0PCEJKtxT13UKGcKze8DvTir8B6BFZQdQCIMpOZgMmHkozbmy/yjuuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V7pK78ZW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P45YqB018725;
	Mon, 25 Mar 2024 06:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jTiuer+jx0vA1cHECrkYvkC5nmsTdAG13m7SdtO23R4=; b=V7
	pK78ZWCg4CF/s6TAqx/DSeYcMCavgMiJe2dJRApC92VUX1bxIEZ07oWfogy5sn7Q
	Y4FoztN2c4VJR1Kyw4UbvLuiKwuluDBvklQ4PHkVLkgsufaiUeI0KbxmhJldrtcl
	p/0sW0hW52rBu5iDysPyGOtzz7hyW5diD8X8U3s4ThH3TSafUGs932IOHGnW/x3r
	TQ7iBZWNP7eZikIlw7QVOym8deWwTzXtI41xUXv38+PWSqvYjA0E59/sb1CJGrvc
	nnbmLCF4h8pSaxw/Lna1BMHnYSLTzgXHj4kD/PQLZbC8qebOzKz2lb6SsCV0pbhv
	g0RJKUYpWF7SEu9wmzGA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x31wv05v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:08:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42P68mwW015080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:08:48 GMT
Received: from [10.216.57.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 24 Mar
 2024 23:08:42 -0700
Message-ID: <008d574f-9c9e-48c6-b64e-89fb469cbde4@quicinc.com>
Date: Mon, 25 Mar 2024 11:38:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 6/6] arm64: dts: qcom: sm8650: Add video and
 camera clock controllers
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-7-quic_jkona@quicinc.com>
 <CAA8EJppHGS+W-aiXvJ2cE=jCbua8Y0Q+zv_QTs+C9V5+Y1vuZg@mail.gmail.com>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJppHGS+W-aiXvJ2cE=jCbua8Y0Q+zv_QTs+C9V5+Y1vuZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MvdibvDTsYlwh3efMOse4HNen3L1Cein
X-Proofpoint-ORIG-GUID: MvdibvDTsYlwh3efMOse4HNen3L1Cein
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_03,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250031



On 3/21/2024 6:43 PM, Dmitry Baryshkov wrote:
> On Thu, 21 Mar 2024 at 11:27, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>> Add device nodes for video and camera clock controllers on Qualcomm
>> SM8650 platform.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> index 32c0a7b9aded..d862aa6be824 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> @@ -4,6 +4,8 @@
>>    */
>>
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/clock/qcom,sm8450-videocc.h>
>> +#include <dt-bindings/clock/qcom,sm8650-camcc.h>
>>   #include <dt-bindings/clock/qcom,sm8650-dispcc.h>
>>   #include <dt-bindings/clock/qcom,sm8650-gcc.h>
>>   #include <dt-bindings/clock/qcom,sm8650-gpucc.h>
>> @@ -3110,6 +3112,32 @@ opp-202000000 {
>>                          };
>>                  };
>>
>> +               videocc: clock-controller@aaf0000 {
>> +                       compatible = "qcom,sm8650-videocc";
>> +                       reg = <0 0x0aaf0000 0 0x10000>;
>> +                       clocks = <&bi_tcxo_div2>,
>> +                                <&gcc GCC_VIDEO_AHB_CLK>;
>> +                       power-domains = <&rpmhpd RPMHPD_MMCX>;
>> +                       required-opps = <&rpmhpd_opp_low_svs>;
> 
> The required-opps should no longer be necessary.
> 

Sure, will check and remove this if not required.

Thanks,
Jagadeesh

>> +                       #clock-cells = <1>;
>> +                       #reset-cells = <1>;
>> +                       #power-domain-cells = <1>;
>> +               };
>> +
>> +               camcc: clock-controller@ade0000 {
>> +                       compatible = "qcom,sm8650-camcc";
>> +                       reg = <0 0x0ade0000 0 0x20000>;
>> +                       clocks = <&gcc GCC_CAMERA_AHB_CLK>,
>> +                                <&bi_tcxo_div2>,
>> +                                <&bi_tcxo_ao_div2>,
>> +                                <&sleep_clk>;
>> +                       power-domains = <&rpmhpd RPMHPD_MMCX>;
>> +                       required-opps = <&rpmhpd_opp_low_svs>;
>> +                       #clock-cells = <1>;
>> +                       #reset-cells = <1>;
>> +                       #power-domain-cells = <1>;
>> +               };
>> +
>>                  mdss: display-subsystem@ae00000 {
>>                          compatible = "qcom,sm8650-mdss";
>>                          reg = <0 0x0ae00000 0 0x1000>;
>> --
>> 2.43.0
>>
>>
> 
> 

