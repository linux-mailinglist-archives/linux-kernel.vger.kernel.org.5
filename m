Return-Path: <linux-kernel+bounces-92803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E96B87262A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94C31B217BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8AE18038;
	Tue,  5 Mar 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eCpmSp7w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADAD15491;
	Tue,  5 Mar 2024 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661844; cv=none; b=UcbazMDr6El9v5iVti+sXx/l/wnWwAC3nmpSXtbsPNw8C3p4g8VXw4EQiLtMp029cmTIHCL47PXPQnusiNzv/y6flK4GNW1c5dwh7AUTJdDDOXvOMPd/sFE+HKeG/5UQN0aw3XppLECcLPe85uvT3y7ZCbt8pRpouIbaxF+EU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661844; c=relaxed/simple;
	bh=TkRSSXuO84y1vHt1o1dz3khiRaOCVZ90Cf+cb7PCbCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cP9yTqULkyiLG3/eN900FKozXMJPe35IES5IbGMnzIqTSTBp63M+HrApVTlNLmdEEQqSQuTmQms+Co/pWFM53ge38wsWq8vm1QpXeA8VDHaJfRpg3m9inBIk7gIl+4NHZ3mkU+g+Be6Umc2lhpclLINlBZv3zAouaGnt3DXvAI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eCpmSp7w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425G05IO021625;
	Tue, 5 Mar 2024 18:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Av2mb1Kc5Cdu2jRZCAhrELoJozZQqOJF1ySrghSTjG8=; b=eC
	pmSp7wWsZyW2oI/71bieR3USbmLW7hlVawZjh4sj2EabYAYKJzQ2TMBe56fw6Xda
	wZZcYLS6oQ2f4iqCoCTsqIXjDStuPDXaOTnAl6t6lrJh+s1BJiJgDL5AZ9e463LB
	K6lbx1p5EfWba5TdgzinC4GGP7qIwPdtOL0siRFy8NChRG8j5uxW9nnDNOb7LR8k
	bqBoXK//2Y1Z3Yi2SxUMbhpaY2pnClpxfUhpjuYAjOCanAsY4rdnP9Uwf/oIZeJr
	pMf0WIXpcnaP4NUCvXLmf/zms69+7J1jTUtGVgIfFlWCeRRAAD4hHimUy0rH0Byj
	qqzqLHVyzgpS4VPjX0+A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp2uwrubt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 18:03:46 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425I3icl009739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 18:03:44 GMT
Received: from [10.216.51.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 10:03:36 -0800
Message-ID: <986b49f5-6a4a-430d-ba6a-2f387f2a262a@quicinc.com>
Date: Tue, 5 Mar 2024 23:33:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] dt-bindings: usb: qcom,dwc3: Add support for multiple
 power-domains
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_wcheng@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_nkela@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <ulf.hansson@linaro.org>, <sudeep.holla@arm.com>,
        <quic_shazhuss@quicinc.com>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1709657858-8563-2-git-send-email-quic_sriramd@quicinc.com>
 <86371fc0-ef49-4dc9-b98c-7c5131cd1227@linaro.org>
From: Sriram Dash <quic_sriramd@quicinc.com>
In-Reply-To: <86371fc0-ef49-4dc9-b98c-7c5131cd1227@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JustTdGEHBZhhpGdfimgSnESEslb1W-h
X-Proofpoint-ORIG-GUID: JustTdGEHBZhhpGdfimgSnESEslb1W-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_15,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=808 impostorscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050143

On 3/5/2024 10:37 PM, Krzysztof Kozlowski wrote:
> On 05/03/2024 17:57, Sriram Dash wrote:
>> Some target systems allow multiple resources to be managed by firmware.
>> On these targets, tasks related to clocks, regulators, resets, and
>> interconnects can be delegated to the firmware, while the remaining
>> responsibilities are handled by Linux.
>>
>> To support the management of partial resources in Linux and leave the rest
>> to firmware, multiple power domains are introduced. Each power domain can
>> manage one or more resources, depending on the specific use case.
>>
>> These power domains handle SCMI calls to the firmware, enabling the
>> activation and deactivation of firmware-managed resources.
>>
>> Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
>> ---
>>   .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 74 ++++++++++++++++------
>>   .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 49 ++++++++++++--
>>   .../devicetree/bindings/usb/qcom,dwc3.yaml         | 37 ++++++++++-
>>   3 files changed, 130 insertions(+), 30 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>> index 1e2d4dd..53b9ba9 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>> @@ -44,7 +44,32 @@ properties:
>>       maxItems: 5
>>   
>>     power-domains:
>> -    maxItems: 1
>> +    description: specifies a phandle to PM domain provider node
> 
> Please drop all redundant descriptions. Adding them is not even related
> to this patch.
> 

Thanks Krzysztof for the super quick response !
Sure. will drop the description for power-domain
and power-doamin-names.

>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  power-domain-names:
>> +    description:
>> +      A list of power domain name strings sorted in the same order as the
>> +      power-domains property.
>> +
>> +      For platforms where some resource are firmware managed, the name
>> +      corresponding to the index of an SCMI domain provider can be
>> +      "usb_core" or "usb_transfer".
>> +    items:
>> +      - const: usb_core
>> +      - const: usb_transfer
> 
> How is this related to fw-managed? I fail to see it. Don't mix
> independent problems in one patch.
> 

Some of the the resources like clocks, regulators, etc will be 
controlled by the firmware instead of OS. However, some resources
still will be controlled by OS (interrupts for example).

So, to support the management of partial resources in Linux, and
offload the other resource management to firmware, multiple power 
domains are introduced. They will be corresponding to different
hw blocks.

Do you suggest splitting the addition of power-domain-names and
addition of fw-managed property in separate patches for bindings!

>> +
>> +  qmp,fw-managed:
> 
> Please do not upstream vendor code directly, but perform basic
> adjustment to upstream Linux kernel. There is no such company as gmp.
> 
> Run this first through your internal review process.
> 

This property is newly introduced for the qmp superspeed phy and
similar dt properties are introduced for hsphy and dwc3 qcom
controller glue layer driver. It will govern the suspend/ resume
of the resources (by firmware or OS) as required.

>> +    description:
>> +      Some targets allow multiple resources to be managed by firmware.
> 
> You miss clear mapping between compatibles and this property - allOf
> restricting it to specific SoCs.
> 
> Is this different property than qcom,controlled-remotely?
> 

No. unlike "qcom,controlled-remotely", which lets the OS know only to
consume the resources, "qmp,fw-managed" property will decide the
resource management and trigger the suspend/ resume from OS, which
will be handled by the firmware.

Can we reuse the property "qcom,controlled-remotely" here? If so,
we can replace the aformentioned property with qmp phy, hsphy, and
controller glue layer property. Please suggest.

> Best regards,
> Krzysztof
> 

