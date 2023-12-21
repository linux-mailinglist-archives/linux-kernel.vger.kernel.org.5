Return-Path: <linux-kernel+bounces-8567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C48781B97C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E821B1F223AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA0F36086;
	Thu, 21 Dec 2023 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc+AlV7s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F676D6E7;
	Thu, 21 Dec 2023 14:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A357C433C7;
	Thu, 21 Dec 2023 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703168733;
	bh=ocQ9EjUsxyh5+RDobb40P0qaPVGGj9nzip9H6VJRjIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pc+AlV7s1dtCyqu4IrWCCGACCZu9yLIdhMIzQRLpBXdoKWGiXBJxvM2Ds9jMZWG0k
	 NUQt/C/vK8TGMgTuTBK5C3c5lmYkqfDw7TRsjzwPFwjLgWZkNodisFNfZTzS77Reiu
	 yzt38yfyi6c2woJl0Ki98nG3tqtaWxmQ/PkWo9Col6uoxU8uc89d8JsY/AbaPZXAix
	 f8STa19wkKXWWTI4qENq2qqU0REDMp+XRrQ8oxq7qyOZf4ISgdCWlinhYhiFT2a+7G
	 S/Uk//E2GOQ3AnVgldnXvquQ3MiY9sDKHa4nFG/5CsIsfRk+6cTuzhppajYOL5MX4p
	 xpKmbmqvyvSSg==
Received: (nullmailer pid 3842774 invoked by uid 1000);
	Thu, 21 Dec 2023 14:25:31 -0000
Date: Thu, 21 Dec 2023 08:25:31 -0600
From: Rob Herring <robh@kernel.org>
To: Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, devicetree@vger.kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com, djakov@kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: iommu: Add Translation Buffer Unit
 bindings
Message-ID: <20231221142531.GA3730284-robh@kernel.org>
References: <20231220060236.18600-1-quic_c_gdjako@quicinc.com>
 <20231220060236.18600-2-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220060236.18600-2-quic_c_gdjako@quicinc.com>

On Tue, Dec 19, 2023 at 10:02:28PM -0800, Georgi Djakov wrote:
> The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
> of the SMMU-500, that consists of a single TCU (Translation Control
> Unit) and multiple TBUs (Translation Buffer Units). The TCU is already
> being described in the generic SMMU DT schema. Add bindings for the
> TBUs to describe their properties and resources that needs to be
> managed in order to operate them.
> 
> In this DT schema, the TBUs are modelled as child devices of the TCU
> and each of them is described with it's register space, clocks, power
> domains, interconnects etc.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 31 ++++++++
>  .../bindings/iommu/qcom,qsmmuv500-tbu.yaml    | 77 +++++++++++++++++++
>  2 files changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index a4042ae24770..a610af2c7e5e 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -235,6 +235,27 @@ properties:
>        enabled for any given device.
>      $ref: /schemas/types.yaml#/definitions/phandle
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
> +  "^tbu@[0-9a-f]+":

Missing '$' on the end.

> +    description: The TBU child node(s)
> +    type: object
> +
> +    properties:
> +      stream-id-range:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description: Stream ID range (address and size) that is assigned by the TBU
> +        items:
> +          minItems: 2
> +          maxItems: 2

This is allowing any property in the TBU nodes. This all needs to move 
to a separate TBU schema.

> +
>  required:
>    - compatible
>    - reg
> @@ -312,6 +333,16 @@ allOf:
>                      through the TCU's programming interface.
>                  - description: bus clock required for the smmu ptw
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,sdm845-smmu-500
> +    then:
> +      patternProperties:
> +        "^tbu@[0-9a-f]+":
> +          $ref: qcom,qsmmuv500-tbu.yaml

TBU nodes are allowed for all other SMMUs. Is that your intent? If not, 
then the node definition up above should be removed and you would just 
have this if/then schema.

> +
>    - if:
>        properties:
>          compatible:
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> new file mode 100644
> index 000000000000..c4f148ae5f38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/qcom,qsmmuv500-tbu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm TBU (Translation Buffer Unit)
> +
> +maintainers:
> +  - Georgi Djakov <quic_c_gdjako@quicinc.com>
> +
> +description:
> +  The Qualcomm SMMU500 implementation consists of TCU and TBU. The TBU contains
> +  a Translation Lookaside Buffer (TLB) that caches page tables. TBUs provides
> +  debug features to trace and trigger debug transactions. There are multiple TBU
> +  instances distributes with each client core.
> +
> +properties:
> +
> +  compatible:
> +    const: qcom,qsmmuv500-tbu
> +
> +  reg:
> +    items:
> +      - description: Address and size of the TBU's register space.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interconnects:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  stream-id-range:
> +    $ref: "arm,smmu.yaml#/patternProperties/^tbu@[0-9a-f]+/properties/stream-id-range"

No. We generally don't reference properties this way. Partly because not 
all regex's work as a path.

You need a base TBU schema of the common properties that is referenced 
at the top level here. That should also solve the above problem.

> +
> +required:
> +  - compatible
> +  - reg
> +  - stream-id-range
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +    #include <dt-bindings/interconnect/qcom,icc.h>
> +    #include <dt-bindings/interconnect/qcom,sdm845.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    apps_smmu: iommu@15000000 {

Drop unused labels.

> +        compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
> +        reg = <0x15000000 0x80000>;
> +        ranges = <0 0 0 0 0xffffffff>;
> +        #iommu-cells = <2>;
> +        #global-interrupts = <1>;
> +        interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        anoc_1_pcie_tbu: tbu@150e1000 {
> +            compatible = "qcom,qsmmuv500-tbu";
> +            reg = <0x0 0x150e1000 0x0 0x1000>;
> +            clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> +            interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
> +                             &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +            power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
> +            stream-id-range = <0x1c00 0x400>;
> +        };
> +    };
> +
> +...

