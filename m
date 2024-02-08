Return-Path: <linux-kernel+bounces-57499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7374484D9DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEAB1F23B40
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CE667E83;
	Thu,  8 Feb 2024 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eCZTKfFA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DBF4C84;
	Thu,  8 Feb 2024 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372858; cv=none; b=n9ZnXaLxKrnUBeFhqENCjqJ/JiLWbEXQ/TGQ/l2SksMA1/y8ygAmVOwEB3IBZwd2qI5C4GrdeoVYUxnNn9uUCFzqPxlEKEfNKC35MX3XRQK0n/fZ15WTiAI/rC08mh4yiSLOj8y/jWJSrhNuOAZipAKiBxw7z0nxATSRKE47NMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372858; c=relaxed/simple;
	bh=SwX5XqArf5xwd6zmj6wvkne/CiOMRaP8kvliDxwOawQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sDQYhGf4WLW785SOYXThox9wYfoy4QAIUDJrzrQ0X00950L5ZwS7c7g5Nyij21q6b/f2gRAZcRF93UYRxm05t6/rWK7a2QAby7b1DFIGGt6FuxrZN9BY+Svz51LgIMMiZI/AGX5oQm+PqJosLaMKDoVIl3TsY5nosLcqy55xS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eCZTKfFA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4185asOE001595;
	Thu, 8 Feb 2024 06:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=r++821xKC0myDxKf9TKAwpRdOzG3nwXg/rQ65HdN2Sk=; b=eC
	ZTKfFA81NFMAca8wq8myhmxfXa9TnhwaRIPcuMDy4MNWl0CWAp7Vu+XgDhIp0W0Z
	H470ZrvTejaCPJXCYWHDQI9lrYmCAwHoaaW4AoC2cUaRUHlNVM7w6DKuZazq2cjs
	JBMdWbQQj3+AB59DWaGOiy61TygJfmvWxKanHQGnpeF6B0+yixM64idEQ3pBnv06
	tzzYnkUHvEmvc0IxwwqncJzNF+f4cbu/ePLyeNLgQhC5zpTqr9+uYquCYYmNbI+1
	AVHtHYq8R4vH0iL8QBuoAWqlY0EZXc5vYz9G3ZSI+KsdztCk1b+g3wrWyISFMX+3
	LSAZbYsVd47V0S8hQDoA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3ywbu9ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 06:14:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4186EASk007793
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 06:14:10 GMT
Received: from [10.216.36.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 22:14:06 -0800
Message-ID: <dec2976e-6e1e-6121-e175-210377ff6925@quicinc.com>
Date: Thu, 8 Feb 2024 11:44:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Add PCIe nodes
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20240207-enable_pcie-v1-1-b684afa6371c@quicinc.com>
 <CAA8EJpqjm_2aE+7BtMkFUdet11q7v_jyHbUEpiDHSBSnzhndYA@mail.gmail.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAA8EJpqjm_2aE+7BtMkFUdet11q7v_jyHbUEpiDHSBSnzhndYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Iq9og3MKBrJaKe10KconyFO7q-MQRpuQ
X-Proofpoint-GUID: Iq9og3MKBrJaKe10KconyFO7q-MQRpuQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080031



On 2/7/2024 5:17 PM, Dmitry Baryshkov wrote:
> On Wed, 7 Feb 2024 at 12:42, Krishna chaitanya chundru
> <quic_krichai@quicinc.com> wrote:
>>
>> Enable PCIe1 controller and its corresponding PHY nodes on
>> qcs6490-rb3g2 platform.
>>
>> PCIe switch is connected to PCIe1, PCIe switch has multiple endpoints
>> connected. For each endpoint a unique BDF will be assigned and should
>> assign unique smmu id. So for each BDF add smmu id.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 42 ++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 8bb7d13d85f6..0082a3399453 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -413,6 +413,32 @@ vreg_bob_3p296: bob {
>>          };
>>   };
>>
>> +&pcie1 {
>> +       perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>> +
>> +       pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
>> +       pinctrl-names = "default";
>> +
>> +       iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
>> +                   <0x100 &apps_smmu 0x1c81 0x1>,
>> +                   <0x208 &apps_smmu 0x1c84 0x1>,
>> +                   <0x210 &apps_smmu 0x1c85 0x1>,
>> +                   <0x218 &apps_smmu 0x1c86 0x1>,
>> +                   <0x300 &apps_smmu 0x1c87 0x1>,
>> +                   <0x400 &apps_smmu 0x1c88 0x1>,
>> +                   <0x500 &apps_smmu 0x1c89 0x1>,
>> +                   <0x501 &apps_smmu 0x1c90 0x1>;
> 
> Is the iommu-map really board specific?
> 
The iommu-map for PCIe varies if PCIe switch is connected.
For this platform a PCIe switch is connected and for that reason
we need to define additional smmu ID's for each BDF.

For that reason we defined here as these ID's are applicable only
for this board.

- Krishna Chaitanya.
>> +
>> +       status = "okay";
>> +};
>> +
>> +&pcie1_phy {
>> +       vdda-phy-supply = <&vreg_l10c_0p88>;
>> +       vdda-pll-supply = <&vreg_l6b_1p2>;
>> +
>> +       status = "okay";
>> +};
>> +
>>   &qupv3_id_0 {
>>          status = "okay";
>>   };
>> @@ -420,6 +446,22 @@ &qupv3_id_0 {
>>   &tlmm {
>>          gpio-reserved-ranges = <32 2>, /* ADSP */
>>                                 <48 4>; /* NFC */
>> +
>> +       pcie1_reset_n: pcie1-reset-n-state {
>> +               pins = "gpio2";
>> +               function = "gpio";
>> +               drive-strength = <16>;
>> +               output-low;
>> +               bias-disable;
>> +       };
>> +
>> +       pcie1_wake_n: pcie1-wake-n-state {
>> +               pins = "gpio3";
>> +               function = "gpio";
>> +               drive-strength = <2>;
>> +               bias-pull-up;
>> +       };
>> +
>>   };
>>
>>   &uart5 {
>>
>> ---
>> base-commit: 70d201a40823acba23899342d62bc2644051ad2e
>> change-id: 20240207-enable_pcie-95b1d6612b27
>>
>> Best regards,
>> --
>> Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>
>>
> 
> 

