Return-Path: <linux-kernel+bounces-142529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9A78A2CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233C21F22661
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F4446AE;
	Fri, 12 Apr 2024 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OyAkddjx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873013CF79;
	Fri, 12 Apr 2024 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918930; cv=none; b=bclKpbxDNxLSJHncEr5XCEL1QK4jsfsLDLXttMAsAht8V81sk1SwxLg+szUMeCwFj6RMmtf7M02qLK8ZR+9b6sY3aqLW/hymptKM5vxotES6WayHtPmC0JC/H8WTWInTZXO4rvjEre0PrJpyEinCsDZUej8HsLLgAfZ6HZogF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918930; c=relaxed/simple;
	bh=FDqUajE9GfA8H5Akw2N7P80Hc9nZh1oc2O8o1X0XICw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eNL30wXuVAjtYFpR/lPCndsogsDAHN1k++PIwB31nGgxvUeH45KOV1jneVvwgD8PNbjGTaWF159Nl61kTH3xkeQTjpB6YaipEtLjE1wGtDv+AMovcDpqdIa1hjfNuKEt2FLKD5ULtUdkxc+pgneUO7zPqQnHHCqTkfsa48ph5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OyAkddjx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C4ivdO010574;
	Fri, 12 Apr 2024 10:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=E//2tur9tqzFvXJEtnP+//xNEf8yb1xDRgrFPMK+W7g=; b=Oy
	AkddjxSQwV5lDXSPhDv/sv1XIH+jC8tmnvNJgA5/Uy+HXUNiywhKcw1NiGmYzfO0
	LGKRmI8Vmvry0WPozyokPm8D5A9G+B/y03sk5yQQL4emoG3e5NB61t4ab7D4lhV9
	Ya8bDB/ylsLCAucgqst1KwBh+y9+TsmwopFsx7+1ilfTMKdRERCkzKzbzTOIW+/s
	y4sPDRNNktjsjvo5EYYiZNxpNlbPspFH+ZjNwASMquw+zKbZj27CoR4TakMs5z/l
	4TXc8J8j36kncKmsN+KOlkTsAxhuM4nY+/V1IZPiOQbhsTBVULZb5EtmmgYlgw9E
	7Z2rWFxc3rZLcebg4RVg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xevwegvq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 10:48:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CAmggB024674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 10:48:42 GMT
Received: from [10.216.31.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 03:48:39 -0700
Message-ID: <3ca2f601-ce45-43cf-b0dd-e28865874455@quicinc.com>
Date: Fri, 12 Apr 2024 16:18:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] arm64: dts: qcom: qcs6490-rb3gen2: enable PMIC
 Volume and Power buttons
To: Bjorn Andersson <andersson@kernel.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240403132839.2117675-1-quic_uchheda@quicinc.com>
 <6b3gqfrvljvlfaf365l55kjcbjd4rfmw223tro6rqy5crykxgb@l66dptcrujip>
Content-Language: en-US
From: Umang Chheda <quic_uchheda@quicinc.com>
In-Reply-To: <6b3gqfrvljvlfaf365l55kjcbjd4rfmw223tro6rqy5crykxgb@l66dptcrujip>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9XSzGivasphI21k24OGbDc3i3NJar2Wx
X-Proofpoint-ORIG-GUID: 9XSzGivasphI21k24OGbDc3i3NJar2Wx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_07,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120078

Hi Bjorn,

On 4/9/2024 8:47 PM, Bjorn Andersson wrote:
> On Wed, Apr 03, 2024 at 06:58:39PM +0530, Umang Chheda wrote:
>> The Volume Down & Power buttons are controlled by the PMIC via
>> the PON hardware, and the Volume Up is connected to a PMIC gpio.
>>
>> Enable the necessary hardware and setup the GPIO state for the
>> Volume Up gpio key.
>>
>> Signed-off-by: Umang Chheda <quic_uchheda@quicinc.com>
>> ---
> 
> I suppose this isn't a "resend" either, so please send me a new version
> of this as well.
> 

I had earlier sent [1] for review, on which I hadn't received any review comments.

Hence, I resent this patch again after 2 weeks for review.

[1] https://lore.kernel.org/linux-arm-msm/20240320121016.2878367-1-quic_uchheda@quicinc.com/

Regards,
Umang

> Regards,
> Bjorn
> 
>>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 37 ++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 63ebe0774f1d..73f6d18d2331 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -9,6 +9,8 @@
>>  #define PM7250B_SID 8
>>  #define PM7250B_SID1 9
>>  
>> +#include <dt-bindings/input/linux-event-codes.h>
>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>  #include "sc7280.dtsi"
>>  #include "pm7250b.dtsi"
>> @@ -39,6 +41,22 @@ chosen {
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		pinctrl-0 = <&key_vol_up_default>;
>> +		pinctrl-names = "default";
>> +
>> +		key-volume-up {
>> +			label = "Volume_up";
>> +			gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
>> +			linux,code = <KEY_VOLUMEUP>;
>> +			wakeup-source;
>> +			debounce-interval = <15>;
>> +			linux,can-disable;
>> +		};
>> +	};
>> +
>>  	reserved-memory {
>>  		xbl_mem: xbl@80700000 {
>>  			reg = <0x0 0x80700000 0x0 0x100000>;
>> @@ -471,6 +489,25 @@ &gcc {
>>  			   <GCC_WPSS_RSCP_CLK>;
>>  };
>>  
>> +&pm7325_gpios {
>> +	key_vol_up_default: key-vol-up-state {
>> +		pins = "gpio6";
>> +		function = "normal";
>> +		input-enable;
>> +		bias-pull-up;
>> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
>> +	};
>> +};
>> +
>> +&pon_pwrkey {
>> +	status = "okay";
>> +};
>> +
>> +&pon_resin {
>> +	linux,code = <KEY_VOLUMEDOWN>;
>> +	status = "okay";
>> +};
>> +
>>  &qupv3_id_0 {
>>  	status = "okay";
>>  };
>> -- 
>> 2.25.1
>>

