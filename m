Return-Path: <linux-kernel+bounces-62332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD0C851E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0C31C20C15
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD77482ED;
	Mon, 12 Feb 2024 20:26:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA40B41208;
	Mon, 12 Feb 2024 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769561; cv=none; b=WpwykS3czgGQweqTuytdFVsz2mxR4/ZXdWlZUoaF5923gt6jpRKdV8DYGfkEgI4ruWbeqWa07q7ohrfbUKppVXXoto8DSIwLjiDoEvNZSV4P62/lziwyDc2OrP46GOPiNInsB6nKudnKD4kqiD8fQx72I7X/m0lKYY+pCtLvhiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769561; c=relaxed/simple;
	bh=4LzQNYnhDLWF7CpRALP+fSk7Y3GuFx5cvns2xtzlsOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jP8FjXZeudN/8K8XNRsZdgZqtFLzUZF+/Y9odJ4TK4Czqhl6gJzEMfeNhrtwZzC5FOWjNEv4pyW3aRqzvUY4zScCfdOk4oAOs9ZbGVz540zvYA8a0iI4WUMwSv4x268DcUTEEjG85f3Q0vQz988m7gyCqOtFs8joWFjekWgkCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37B6BDA7;
	Mon, 12 Feb 2024 12:26:39 -0800 (PST)
Received: from [10.57.48.89] (unknown [10.57.48.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26C4E3F766;
	Mon, 12 Feb 2024 12:25:55 -0800 (PST)
Message-ID: <cfc87678-0445-42e6-9fc1-b22ef25566ff@arm.com>
Date: Mon, 12 Feb 2024 20:25:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: iommu: Add Translation Buffer Unit
 bindings
Content-Language: en-GB
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, will@kernel.org,
 joro@8bytes.org, iommu@lists.linux.dev
Cc: devicetree@vger.kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, robdclark@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com,
 quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com,
 djakov@kernel.org
References: <20240201210529.7728-1-quic_c_gdjako@quicinc.com>
 <20240201210529.7728-2-quic_c_gdjako@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240201210529.7728-2-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-01 9:05 pm, Georgi Djakov wrote:
> Add common bindings for the TBUs to describe their properties. The
> TBUs are modelled as child devices of the IOMMU and each of them is
> described with their compatible, reg and stream-id-range properties.
> There could be other implementation specific properties to describe
> any resources like clocks, regulators, power-domains, interconnects
> that would be needed for TBU operation. Such properties will be
> documented in a separate vendor-specific TBU schema.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   .../devicetree/bindings/iommu/arm,smmu.yaml   | 14 ++++++++++
>   .../devicetree/bindings/iommu/tbu-common.yaml | 28 +++++++++++++++++++
>   2 files changed, 42 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iommu/tbu-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index a4042ae24770..ba3237023b39 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -235,6 +235,20 @@ properties:
>         enabled for any given device.
>       $ref: /schemas/types.yaml#/definitions/phandle
>   
> +  '#address-cells':
> +    enum: [ 1, 2 ]
> +
> +  '#size-cells':
> +    enum: [ 1, 2 ]
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^tbu@[0-9a-f]+$":
> +    description: TBU child nodes
> +    type: object
> +    $ref: tbu-common.yaml#
> +
>   required:
>     - compatible
>     - reg
> diff --git a/Documentation/devicetree/bindings/iommu/tbu-common.yaml b/Documentation/devicetree/bindings/iommu/tbu-common.yaml
> new file mode 100644
> index 000000000000..3e95b356e572
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/tbu-common.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/tbu-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Translation Buffer Unit (TBU) common properties
> +
> +maintainers:
> +  - Georgi Djakov <quic_c_gdjako@quicinc.com>
> +
> +description:
> +  The SMMU implements a TBU for system masters. It consists if a
> +  Translation Lookaside Buffer (TLB) that caches page tables.
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  stream-id-range:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: Stream ID range (address and size) that is assigned by the TBU
> +    items:
> +      minItems: 2
> +      maxItems: 2

Actually, even this doesn't work - for the 15-bit StreamID config, 
there's no guarantee that the devices behind each TBU will use a single 
contiguous StreamID range. Conversely, for any other config the 
StreamIDs are already uniquely associated with a TBU by their top 5 
bits, so the "size" doesn't matter.

Thanks,
Robin.

> +
> +additionalProperties: true
> +...

