Return-Path: <linux-kernel+bounces-27472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B4C82F0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778E51C2354D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176401BF39;
	Tue, 16 Jan 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFUYMXcf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B646EADF;
	Tue, 16 Jan 2024 14:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEA1C433C7;
	Tue, 16 Jan 2024 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705416261;
	bh=+IrwKlp6UAiY/ETGopdBM6vfi4zQT9+TOVEU95jc+QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFUYMXcfrcBlgMFmeOBG6QK4FPWpIj83Hl7iJD0gWIrgeXnRuvx/EFQ5Bir99Xz2O
	 NlURbUxSzquu2iuaKBp4bgh0i5O4MRaSh2nUrLJlzqqM7EMHqZZTwcZ0KqEmSITu1G
	 TJEH8sexIdawv5r1pF6yuifT/uLlkXjuszqmEPVyFiJasMWpFnmn06zgGyXprZJAQ7
	 C6U2nIBTB+RWBh70+rKtDKE1rCaHduyAjpluD78FIJWCq7Xh80FJvVcVSBqm0vX6tO
	 PiWlcaU3zYVKaNOya3HugBr7Es7jjmKT/IpncFTxda0NAQqQFMNBPxEpiTTbyOb3kh
	 RysVJs8CatXXQ==
Date: Tue, 16 Jan 2024 08:44:19 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: PCI: qcom,pcie-sm8550: move SM8550 to
 dedicated schema
Message-ID: <20240116144419.GA3856889-robh@kernel.org>
References: <20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org>
 <20240108-dt-bindings-pci-qcom-split-v1-1-d541f05f4de0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108-dt-bindings-pci-qcom-split-v1-1-d541f05f4de0@linaro.org>

On Mon, Jan 08, 2024 at 03:19:14PM +0100, Krzysztof Kozlowski wrote:
> The qcom,pcie.yaml binding file containing all possible Qualcomm SoC
> PCIe root complexes gets quite complicated with numerous if:then:
> conditions customizing clocks, interrupts, regs and resets.  Adding and
> reviewing new devices is difficult, so simplify it by having shared
> common binding and file with only one group of compatible devices:
> 
> 1. Copy all common qcom,pcie.yaml properties (so everything except
>    supplies) to a new shared qcom,pcie-common.yaml schema.
> 2. Move SM8550 PCIe compatible devices to dedicated binding file.
> 
> This creates equivalent SM8550 schema file, except missing required
> compatible which is actually redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  98 ++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  | 171 +++++++++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie.yaml         |  38 -----
>  3 files changed, 269 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> new file mode 100644
> index 000000000000..125136176f93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PCI Express Root Complex Common Properties
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +properties:
> +  reg:
> +    minItems: 4
> +    maxItems: 6
> +
> +  reg-names:
> +    minItems: 4
> +    maxItems: 6
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 8
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 8
> +
> +  iommu-map:
> +    minItems: 1
> +    maxItems: 16
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 13
> +
> +  clock-names:
> +    minItems: 3
> +    maxItems: 13
> +
> +  dma-coherent: true
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: pcie-mem
> +      - const: cpu-pcie
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    items:
> +      - const: pciephy
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 12
> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 12
> +
> +  perst-gpios:
> +    description: GPIO controlled connection to PERST# signal
> +    maxItems: 1
> +
> +  wake-gpios:
> +    description: GPIO controlled connection to WAKE# signal
> +    maxItems: 1
> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - clocks
> +  - clock-names
> +
> +anyOf:
> +  - required:
> +      - interrupts
> +      - interrupt-names
> +      - "#interrupt-cells"
> +  - required:
> +      - msi-map
> +      - msi-map-mask
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
> new file mode 100644
> index 000000000000..b6d025f153bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
> @@ -0,0 +1,171 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie-sm8550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM8550 PCI Express Root Complex
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +description:
> +  Qualcomm SM8550 SoC (and compatible) PCIe root complex controller is based on
> +  the Synopsys DesignWare PCIe IP.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: qcom,pcie-sm8550
> +      - items:
> +          - enum:
> +              - qcom,pcie-sm8650
> +          - const: qcom,pcie-sm8550
> +
> +  reg:
> +    minItems: 5
> +    maxItems: 6
> +
> +  reg-names:
> +    minItems: 5
> +    items:
> +      - const: parf # Qualcomm specific registers
> +      - const: dbi # DesignWare PCIe registers
> +      - const: elbi # External local bus interface registers
> +      - const: atu # ATU address space
> +      - const: config # PCIe configuration space
> +      - const: mhi # MHI registers
> +
> +  clocks:
> +    minItems: 7
> +    maxItems: 8
> +
> +  clock-names:
> +    minItems: 7
> +    items:
> +      - const: aux # Auxiliary clock
> +      - const: cfg # Configuration clock
> +      - const: bus_master # Master AXI clock
> +      - const: bus_slave # Slave AXI clock
> +      - const: slave_q2a # Slave Q2A clock
> +      - const: ddrss_sf_tbu # PCIe SF TBU clock
> +      - const: noc_aggr # Aggre NoC PCIe AXI clock
> +      - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 2
> +
> +  reset-names:
> +    minItems: 1
> +    items:
> +      - const: pci # PCIe core reset
> +      - const: link_down # PCIe link down reset
> +
> +oneOf:
> +  - properties:
> +      interrupts:
> +        maxItems: 1
> +      interrupt-names:
> +        items:
> +          - const: msi
> +
> +  - properties:
> +      interrupts:
> +        minItems: 8
> +      interrupt-names:
> +        items:
> +          - const: msi0
> +          - const: msi1
> +          - const: msi2
> +          - const: msi3
> +          - const: msi4
> +          - const: msi5
> +          - const: msi6
> +          - const: msi7

How does a given SoC have 1 or 8 interrupts? I guess it is possible. A 
comment here would be helpful.

Reviewed-by: Rob Herring <robh@kernel.org>

