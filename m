Return-Path: <linux-kernel+bounces-62261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F148851DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B735282700
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF254654D;
	Mon, 12 Feb 2024 19:12:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215C14642A;
	Mon, 12 Feb 2024 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765151; cv=none; b=cr+DszMHbHrGsFzUOy1Us+THb6RI1ww9c9mwSe2pHcxFrZU63QrdZMNeOu/oBBe1lVHu7KRAEpTiIEA3+ZqX5wsf40rXADJlh3sm8SwB3pEef4ghGamMZAWIeq8kwqy74/W/riGjkf9SxoHoF+EcyY6w95hj++QPWYO/7zTiUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765151; c=relaxed/simple;
	bh=y8IklKVtf4og+m4D1vQAnedpSDWQJGvNYLzT+zZyz78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlBkDp+5Sbd7xl+enkUtML6vkCrwaVCkfAVeK6F904vFFTiGUNPGDAjfJHdUmw/+59EkeiRJ2+u5/AjfsH5jrxGITNSGZerm6o2bXRApBXW7zuIoXbFvhPBYyipCa/zv6723E/zPVvVO2cbcGdmqX7yv8QyRHlJA1aqrMYrfo20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B7FFDA7;
	Mon, 12 Feb 2024 11:13:09 -0800 (PST)
Received: from [10.57.48.89] (unknown [10.57.48.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7635E3F5A1;
	Mon, 12 Feb 2024 11:12:25 -0800 (PST)
Message-ID: <680f9ba7-1f32-4365-abd1-771b8c78e844@arm.com>
Date: Mon, 12 Feb 2024 19:12:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: iommu: Add Translation Buffer Unit
 bindings
To: Rob Herring <robh@kernel.org>, Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, will@kernel.org,
 joro@8bytes.org, iommu@lists.linux.dev, devicetree@vger.kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, robdclark@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com,
 quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com,
 djakov@kernel.org
References: <20240201210529.7728-1-quic_c_gdjako@quicinc.com>
 <20240201210529.7728-2-quic_c_gdjako@quicinc.com>
 <20240202211749.GA1467077-robh@kernel.org>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240202211749.GA1467077-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-02 9:17 pm, Rob Herring wrote:
> On Thu, Feb 01, 2024 at 01:05:20PM -0800, Georgi Djakov wrote:
>> Add common bindings for the TBUs to describe their properties. The
>> TBUs are modelled as child devices of the IOMMU and each of them is
>> described with their compatible, reg and stream-id-range properties.
>> There could be other implementation specific properties to describe
>> any resources like clocks, regulators, power-domains, interconnects
>> that would be needed for TBU operation. Such properties will be
>> documented in a separate vendor-specific TBU schema.
>>
>> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
>> ---
>>   .../devicetree/bindings/iommu/arm,smmu.yaml   | 14 ++++++++++
>>   .../devicetree/bindings/iommu/tbu-common.yaml | 28 +++++++++++++++++++
>>   2 files changed, 42 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iommu/tbu-common.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index a4042ae24770..ba3237023b39 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -235,6 +235,20 @@ properties:
>>         enabled for any given device.
>>       $ref: /schemas/types.yaml#/definitions/phandle
>>   
>> +  '#address-cells':
>> +    enum: [ 1, 2 ]
>> +
>> +  '#size-cells':
>> +    enum: [ 1, 2 ]
>> +
>> +  ranges: true
>> +
>> +patternProperties:
>> +  "^tbu@[0-9a-f]+$":
>> +    description: TBU child nodes
>> +    type: object
>> +    $ref: tbu-common.yaml#
> 
>         additionalProperties: false
> 
> 
> However, that's going to break with the extra QCom properties. In
> json-schema, you can't have 2 schemas and extend the properties of
> their child nodes. The validator doesn't "see" the child node schemas at
> the same time. You are going to have to move QCom SMMU to its own schema
> and remove it from arm,smmu.yaml.

Although this common binding is pretty pointless - sorry I missed the 
previous discussion, but these TBU registers are on obscure debugging 
feature of Qualcomm's own invention and definitely not generic. The 
internal topology of the unmodified Arm MMU-500 implementation isn't 
software-visible at all without getting into its own integration and 
debug registers (and maybe to a lesser extent the PMU), and even then 
everything is proxied through the TCU via an internal AXI stream 
interconnect, so there aren't really any TBU-owned resources which would 
warrant describing as such in DT. If anything, the way this binding is 
defined as an MMIO bus with "ranges" would actively *prevent* being able 
to describe the standard hardware this way, since the internal debug 
stuff all wants to refer to TBUs by numerical index.

Conversely, given that the Qualcomm TBU registers seem to be describing 
their own entirely independent resources and inheriting nothing from the 
parent node, I'm not sure it's necessarily worth all the bother of 
describing and supporting them them as children at all, when they could 
just as well be standalone nodes with a phandle to associate an SMMU 
instance.

Thanks,
Robin.

