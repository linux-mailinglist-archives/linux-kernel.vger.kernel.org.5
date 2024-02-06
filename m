Return-Path: <linux-kernel+bounces-54949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F0984B54A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A873B284555
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E5A134CC5;
	Tue,  6 Feb 2024 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OxSz+EmG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0A134CC0;
	Tue,  6 Feb 2024 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222536; cv=none; b=RyLJGvVfWs4jLTFeZnqn4E4S60kGTliV1EotPLWoPRNqZ+NmekvNG/tZyH2u0E5RnO6QPyK+EmRQXZYO1iY+wp3O/xZ6/CNLQmkhsLPpo4AouBLvPp9aHfKUYv26E7CZ4vwf+frldTouZgMKohFPGQvUkJVL8b3deutLWxZwGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222536; c=relaxed/simple;
	bh=gXljQFI0I8iiLMgCyBE2xW7OD3QUmvcs+XTuIaUYAgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cj+ZQCdQu2ixkG35pDorfX2aFcugtyQr0LHjhaaQZvYVtIiT08wJp9niWTZib/hhIWnYL4NZz169yPa/rpeZupWCZnOTTN3/vmwQPZm1HcpjsStYy9LdkDZMAiMig0LC57nzmacdWqx+wmD8ic+GwukHyBeQwyUn5C5sHdbhZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OxSz+EmG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41692XOv025683;
	Tue, 6 Feb 2024 12:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/PPwmVW37d4csbKfWKzToS6ZXkyr+LGxcudMnsG90xs=; b=Ox
	Sz+EmGM813c2sp3oQpOnFv4G/v8NgKUDgVc2W4j2te0xwFbLsSFqhDHBcmOSgXdW
	nsDemccOjx60L8V/d4rjEhpz4gjbjVwXq8X0WPMbTMHsgFzlHAKvFsa4+hFUMNKP
	iZPW5wuZqIF2M3MTFHCaZU17wQ8va50TcmfVQo29egyJHlRUl+7mvZHEC/JkWWVk
	jIMvU5ZnjbnOG9q3koNGFAGbXDiYcWqJBW/gKqtYrZeTH8BGohZHSVASyRXnM2YE
	Mo2VtAYrE6G1poN5mAOZBEFtrLO9+qjKH+ZdyQjDk1I7REi/2ufnjiMZqvxRcGmg
	ugtDLJ3UOmWmFrT2cfiQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3hsercjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 12:28:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416CSn4d030834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 12:28:49 GMT
Received: from [10.216.27.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 04:28:45 -0800
Message-ID: <0470a930-d629-4467-b619-58d3e76f59a7@quicinc.com>
Date: Tue, 6 Feb 2024 17:58:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8295p: Enable tertiary controller
 and its 4 USB ports
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-3-quic_kriskura@quicinc.com>
 <CAA8EJpoed-hu4hPXAcwQxmJAaNRwJ2y5q9qybWaPP8bdMnz_oA@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAA8EJpoed-hu4hPXAcwQxmJAaNRwJ2y5q9qybWaPP8bdMnz_oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UuyQdtT6YBsbHLNGYOR3QtMBfTyjAqf9
X-Proofpoint-GUID: UuyQdtT6YBsbHLNGYOR3QtMBfTyjAqf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=893 mlxscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060087



On 2/6/2024 5:43 PM, Dmitry Baryshkov wrote:
> On Tue, 6 Feb 2024 at 14:03, Krishna Kurapati <quic_kriskura@quicinc.com> wrote:
>>
>> Enable tertiary controller for SA8295P (based on SC8280XP).
>> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
> 
> These are not just pinctrl entries. They hide VBUS regulators. Please
> implement them properly as corresponding vbus regulators.
> 

Hi Dmitry. Apologies, can you elaborate on your comment. I thought this 
implementation was fine as Konrad reviewed it in v13 [1]. I removed his 
RB tag as I made one change of dropping "_state" in labels.

[1]: 
https://lore.kernel.org/all/7141c2dd-9dcd-4186-ba83-829fe925e464@linaro.org/

Regards,
Krishna,

>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 49 ++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> index fd253942e5e5..6da444042f82 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> @@ -9,6 +9,7 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>   #include <dt-bindings/spmi/spmi.h>
>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>
>>   #include "sa8540p.dtsi"
>>   #include "sa8540p-pmics.dtsi"
>> @@ -584,6 +585,16 @@ &usb_1_qmpphy {
>>          status = "okay";
>>   };
>>
>> +&usb_2 {
>> +       pinctrl-0 = <&usb2_en>,
>> +                   <&usb3_en>,
>> +                   <&usb4_en>,
>> +                   <&usb5_en>;
>> +       pinctrl-names = "default";
>> +
>> +       status = "okay";
>> +};
>> +
>>   &usb_2_hsphy0 {
>>          vdda-pll-supply = <&vreg_l5a>;
>>          vdda18-supply = <&vreg_l7g>;
>> @@ -636,6 +647,44 @@ &xo_board_clk {
>>
>>   /* PINCTRL */
>>
>> +&pmm8540c_gpios {
>> +       usb2_en: usb2-en-state {
>> +               pins = "gpio9";
>> +               function = "normal";
>> +               qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
>> +               output-high;
>> +               power-source = <0>;
>> +       };
>> +};
>> +
>> +&pmm8540e_gpios {
>> +       usb3_en: usb3-en-state {
>> +               pins = "gpio5";
>> +               function = "normal";
>> +               qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
>> +               output-high;
>> +               power-source = <0>;
>> +       };
>> +};
>> +
>> +&pmm8540g_gpios {
>> +       usb4_en: usb4-en-state {
>> +               pins = "gpio5";
>> +               function = "normal";
>> +               qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
>> +               output-high;
>> +               power-source = <0>;
>> +       };
>> +
>> +       usb5_en: usb5-en-state {
>> +               pins = "gpio9";
>> +               function = "normal";
>> +               qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
>> +               output-high;
>> +               power-source = <0>;
>> +       };
>> +};
>> +
>>   &tlmm {
>>          pcie2a_default: pcie2a-default-state {
>>                  clkreq-n-pins {
>> --
>> 2.34.1
>>
>>
> 
> 

