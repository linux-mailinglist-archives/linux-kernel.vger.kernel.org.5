Return-Path: <linux-kernel+bounces-5483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239FC818B32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D91AB24871
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C3A1D54A;
	Tue, 19 Dec 2023 15:25:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724CA1C6B2;
	Tue, 19 Dec 2023 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11FBE1FB;
	Tue, 19 Dec 2023 07:26:06 -0800 (PST)
Received: from [10.57.85.119] (unknown [10.57.85.119])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B84953F738;
	Tue, 19 Dec 2023 07:25:19 -0800 (PST)
Message-ID: <ab6a34c7-a0f9-4263-a6ea-08026e2bade9@arm.com>
Date: Tue, 19 Dec 2023 15:25:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
Content-Language: en-GB
To: David Heidelberg <david@ixit.cz>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20231216002242.112310-2-david@ixit.cz>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231216002242.112310-2-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-16 12:22 am, David Heidelberg wrote:
> Convert Qualcomm IOMMU v0 implementation to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v5:
>   - updated example (thx @Konrad)
>   - ordering of requirements + dropped > and | and reformatted (thx @Konrad)
> v4:
>   - renamed to qcom,apq8064-iommu as Rob requested
>   - changed title to Qualcomm APQ8064 IOMMU
>   - dropped quotes around URLs
>   - dropped mdp node
>   - dropped unused mdp_port0 label
> 
> v3:
>   - I kept the name as -v0, since we have other binding -v1 and it look
>     good, I can change thou in v4 if requested.
>   - dropped non-existent smmu_clk part (and adjusted example, which was
>     using it)
>   - dropped iommu description
>   - moved iommu-cells description to the property #iommu-cells
> 
> v2:
>   - fix wrong path in binding $id
>   - comment qcom,mdp4 node example (we don't want to validate it yet)
> 
>   .../bindings/iommu/msm,iommu-v0.txt           | 64 ---------------
>   .../bindings/iommu/qcom,apq8064-iommu.yaml    | 82 +++++++++++++++++++
>   2 files changed, 82 insertions(+), 64 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>   create mode 100644 Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> deleted file mode 100644
> index 20236385f26e..000000000000
> --- a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> +++ /dev/null
> @@ -1,64 +0,0 @@
> -* QCOM IOMMU
> -
> -The MSM IOMMU is an implementation compatible with the ARM VMSA short
> -descriptor page tables. It provides address translation for bus masters outside
> -of the CPU, each connected to the IOMMU through a port called micro-TLB.
> -
> -Required Properties:
> -
> -  - compatible: Must contain "qcom,apq8064-iommu".
> -  - reg: Base address and size of the IOMMU registers.
> -  - interrupts: Specifiers for the MMU fault interrupts. For instances that
> -    support secure mode two interrupts must be specified, for non-secure and
> -    secure mode, in that order. For instances that don't support secure mode a
> -    single interrupt must be specified.
> -  - #iommu-cells: The number of cells needed to specify the stream id. This
> -		  is always 1.
> -  - qcom,ncb:	  The total number of context banks in the IOMMU.
> -  - clocks	: List of clocks to be used during SMMU register access. See
> -		  Documentation/devicetree/bindings/clock/clock-bindings.txt
> -		  for information about the format. For each clock specified
> -		  here, there must be a corresponding entry in clock-names
> -		  (see below).
> -
> -  - clock-names	: List of clock names corresponding to the clocks specified in
> -		  the "clocks" property (above).
> -		  Should be "smmu_pclk" for specifying the interface clock
> -		  required for iommu's register accesses.
> -		  Should be "smmu_clk" for specifying the functional clock
> -		  required by iommu for bus accesses.
> -
> -Each bus master connected to an IOMMU must reference the IOMMU in its device
> -node with the following property:
> -
> -  - iommus: A reference to the IOMMU in multiple cells. The first cell is a
> -	    phandle to the IOMMU and the second cell is the stream id.
> -	    A single master device can be connected to more than one iommu
> -	    and multiple contexts in each of the iommu. So multiple entries
> -	    are required to list all the iommus and the stream ids that the
> -	    master is connected to.
> -
> -Example: mdp iommu and its bus master
> -
> -                mdp_port0: iommu@7500000 {
> -			compatible = "qcom,apq8064-iommu";
> -			#iommu-cells = <1>;
> -			clock-names =
> -			    "smmu_pclk",
> -			    "smmu_clk";
> -			clocks =
> -			    <&mmcc SMMU_AHB_CLK>,
> -			    <&mmcc MDP_AXI_CLK>;
> -			reg = <0x07500000 0x100000>;
> -			interrupts =
> -			    <GIC_SPI 63 0>,
> -			    <GIC_SPI 64 0>;
> -			qcom,ncb = <2>;
> -		};
> -
> -		mdp: qcom,mdp@5100000 {
> -			compatible = "qcom,mdp";
> -			...
> -			iommus = <&mdp_port0 0
> -				  &mdp_port0 2>;
> -		};
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml
> new file mode 100644
> index 000000000000..5af59305d277
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/iommu/qcom,apq8064-iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm APQ8064 IOMMU
> +
> +maintainers:
> +  - Will Deacon <will@kernel.org>
> +
> +description:
> +  The MSM IOMMU is an implementation compatible with the ARM VMSA short
> +  descriptor page tables. It provides address translation for bus masters
> +  outside of the CPU, each connected to the IOMMU through a port called micro-TLB.
> +
> +properties:
> +  compatible:
> +    const: qcom,apq8064-iommu
> +
> +  clocks:
> +    items:
> +      - description: interface clock for register accesses
> +      - description: functional clock for bus accesses
> +
> +  clock-names:
> +    items:
> +      - const: smmu_pclk
> +      - const: iommu_clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Specifiers for the MMU fault interrupts.
> +    minItems: 1
> +    items:
> +      - description: non-secure mode interrupt
> +      - description: secure mode interrupt (for instances which supports it)
> +
> +  "#iommu-cells":
> +    const: 1
> +    description:
> +      The first cell is a phandle to the IOMMU and the second cell
> +      is the stream id.
> +      A single master device can be connected to more than one iommu
> +      and multiple contexts in each of the iommu.
> +      So multiple entries are required to list all the iommus and
> +      the stream ids that the master is connected to.

This seems pretty confusing since it's the description for some other 
property, not this one. FWIW I'd just put this as something like "Each 
IOMMU specifier describes a single Stream ID.", and if you think it's 
really worth calling out that clients can have multiple IOMMU 
specifiers, I'd stick that in the overall description.

Thanks,
Robin.

> +
> +  qcom,ncb:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The total number of context banks in the IOMMU.
> +
> +required:
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - qcom,ncb
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    iommu@7500000 {
> +            compatible = "qcom,apq8064-iommu";
> +            reg = <0x07500000 0x100000>;
> +            interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clk SMMU_AHB_CLK>,
> +                     <&clk MDP_AXI_CLK>;
> +            clock-names = "smmu_pclk",
> +                          "iommu_clk";
> +            #iommu-cells = <1>;
> +            qcom,ncb = <2>;
> +    };

