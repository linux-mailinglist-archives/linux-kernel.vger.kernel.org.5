Return-Path: <linux-kernel+bounces-93437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B4D872FBD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C661C21C76
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C805C914;
	Wed,  6 Mar 2024 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AXE9O5u4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926F171BB;
	Wed,  6 Mar 2024 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710435; cv=none; b=jJfFH0/f1rjtRok+ebxZxINbnNPXFdTCipsHGeNxHUCE2OuD6QbbqndkkvG/8OJX50vGRhfYDeJlhmd6n7aSQJoNOTLA7UoNad4Btfx0H+ZX02l1gU5qucc4hxPom/ru65MzJikk4Cb4BkPw4SPcWLntRDCIxl2hYce3E3ZUDFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710435; c=relaxed/simple;
	bh=9LwIcjfSJuhq4EOzgVx3TMaB2oEXbqURWt5hBLxw1fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=vBx47541nKoYQaQu+ikSq9v6RViBBt/9Mhr8TGe4sFwv9jOXyTqOaDWgXhiK1gH9p2OqkVlBJKDIb6DhNok3003rC9jw9X7S/K5qtXJH0EyD7oX5hbgUTwuex5cwS8vCnBBQUKYpcZBXoPRL0DyQSIYk0RHtgzlhiUfFELhx+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AXE9O5u4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4265sDK4008944;
	Wed, 6 Mar 2024 07:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:cc:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xldv1UnPREtmqS9LLWWTF2pSaiIvufnBwmJJW0C3zks=; b=AX
	E9O5u4Xc7UCCJlicsPDQt2oK7UKo6pVy2UwAW2qftQxG9zcnQ23888yCzQqUAcTb
	GU9imTEp0QcZUZUK53wah9d4etzAWLRqln2vr0cnCXP/m1AdSmGcrUQw3SrDoCBK
	b9GWpUC8zaMirbE2DzhHh2ODARx3Gvt/fy8k08yQRBwVKHksqzMxJBlIvmBwgOq+
	hU+YQcC9bX7CUkbTe7+8cXKYeJSlKE1ws4INVEL+FR9ar5oXmmGwvpaRhPs1urei
	buStvPpHEtYeLeQvb40BzB7HT/B7QIxIXA7jK6QaPI+2KVYuZGu9ivWYtLRk0uiZ
	sEesn5UeDmKiqERPNVLg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpbav11xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 07:33:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4267XbLk018155
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 07:33:37 GMT
Received: from [10.216.23.39] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 23:33:29 -0800
Message-ID: <e441e458-a90b-495f-abf1-448620c14c85@quicinc.com>
Date: Wed, 6 Mar 2024 13:03:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] dt-bindings: usb: qcom,dwc3: Add support for multiple
 power-domains
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sriram Dash
	<quic_sriramd@quicinc.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1709657858-8563-2-git-send-email-quic_sriramd@quicinc.com>
 <86371fc0-ef49-4dc9-b98c-7c5131cd1227@linaro.org>
 <986b49f5-6a4a-430d-ba6a-2f387f2a262a@quicinc.com>
 <84618a4a-be20-4c59-badc-15fa65debf4c@linaro.org>
Content-Language: en-US
CC: <quic_shazhuss@quicinc.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <kishon@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <sudeep.holla@arm.com>, <p.zabel@pengutronix.de>,
        <ulf.hansson@linaro.org>, <conor+dt@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <quic_psodagud@quicinc.com>,
        <quic_nkela@quicinc.com>, <gregkh@linuxfoundation.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <vkoul@kernel.org>
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <84618a4a-be20-4c59-badc-15fa65debf4c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A9fYxT-kTiART89yEKpTt9SUhqZi-ITM
X-Proofpoint-ORIG-GUID: A9fYxT-kTiART89yEKpTt9SUhqZi-ITM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=693 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060059



On 3/6/2024 12:33 PM, Krzysztof Kozlowski wrote:
> On 05/03/2024 19:03, Sriram Dash wrote:
>> On 3/5/2024 10:37 PM, Krzysztof Kozlowski wrote:
>>> On 05/03/2024 17:57, Sriram Dash wrote:
>>>> Some target systems allow multiple resources to be managed by firmware.
>>>> On these targets, tasks related to clocks, regulators, resets, and
>>>> interconnects can be delegated to the firmware, while the remaining
>>>> responsibilities are handled by Linux.
>>>>
>>>> To support the management of partial resources in Linux and leave the rest
>>>> to firmware, multiple power domains are introduced. Each power domain can
>>>> manage one or more resources, depending on the specific use case.
>>>>
>>>> These power domains handle SCMI calls to the firmware, enabling the
>>>> activation and deactivation of firmware-managed resources.
>>>>
>>>> Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
>>>> ---
>>>>    .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 74 ++++++++++++++++------
>>>>    .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 49 ++++++++++++--
>>>>    .../devicetree/bindings/usb/qcom,dwc3.yaml         | 37 ++++++++++-
>>>>    3 files changed, 130 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>>> index 1e2d4dd..53b9ba9 100644
>>>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>>> @@ -44,7 +44,32 @@ properties:
>>>>        maxItems: 5
>>>>    
>>>>      power-domains:
>>>> -    maxItems: 1
>>>> +    description: specifies a phandle to PM domain provider node
>>>
>>> Please drop all redundant descriptions. Adding them is not even related
>>> to this patch.
>>>
>>
>> Thanks Krzysztof for the super quick response !
>> Sure. will drop the description for power-domain
>> and power-doamin-names.
>>
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>>> +
>>>> +  power-domain-names:
>>>> +    description:
>>>> +      A list of power domain name strings sorted in the same order as the
>>>> +      power-domains property.
>>>> +
>>>> +      For platforms where some resource are firmware managed, the name
>>>> +      corresponding to the index of an SCMI domain provider can be
>>>> +      "usb_core" or "usb_transfer".
>>>> +    items:
>>>> +      - const: usb_core
>>>> +      - const: usb_transfer
>>>
>>> How is this related to fw-managed? I fail to see it. Don't mix
>>> independent problems in one patch.
>>>
>>
>> Some of the the resources like clocks, regulators, etc will be
>> controlled by the firmware instead of OS. However, some resources
>> still will be controlled by OS (interrupts for example).
>>
>> So, to support the management of partial resources in Linux, and
>> offload the other resource management to firmware, multiple power
>> domains are introduced. They will be corresponding to different
>> hw blocks.
>>
>> Do you suggest splitting the addition of power-domain-names and
>> addition of fw-managed property in separate patches for bindings!
>>
>>>> +
>>>> +  qmp,fw-managed:
>>>
>>> Please do not upstream vendor code directly, but perform basic
>>> adjustment to upstream Linux kernel. There is no such company as gmp.
>>>
>>> Run this first through your internal review process.
>>>
>>
>> This property is newly introduced for the qmp superspeed phy and
>> similar dt properties are introduced for hsphy and dwc3 qcom
>> controller glue layer driver. It will govern the suspend/ resume
>> of the resources (by firmware or OS) as required.
> 
> So that's your answer to "there is no such company as gmp"? It's not
> relevant at all.
> 
> Please run it through internal review first.
> 
> 
Hi Sriram,

  QMP indicates the driver name "QMP Phy" (for super speed mode of 
operation), not the company name. If this property is for identification 
of fw management to be done / (or not to be done) in QMP Phy, then 
please rename is appropriately. Check how other properties are defined 
in the QMP bindings and add "qcom" at beginning preferably. For 
reference as to how properties were added to femto phy driver: [1].

[1]: 
https://patchwork.kernel.org/project/linux-arm-msm/patch/1662480933-12326-2-git-send-email-quic_kriskura@quicinc.com/

Regards,
Krishna,

