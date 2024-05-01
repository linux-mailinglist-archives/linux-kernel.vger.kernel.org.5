Return-Path: <linux-kernel+bounces-165307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768F28B8AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D0B1F22B32
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CB912DDBB;
	Wed,  1 May 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pm4Q5Ph3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84912DD8E;
	Wed,  1 May 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714569358; cv=none; b=MpHkeDcEejLK5FMFij9UUKx7rw/t7HDj2a6KdZrT50LG4jck3RfJy79+rIzSoDkcAHmCZOCiiv2ocUbwj0++4ABL6jjCPY9jYFGbaL4p5m1rJf7R0slHhyMCoiC9SUauM7Xj8zSodcIfaXHzUv7qVIrtGVr/N+J4n4QcK7YfO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714569358; c=relaxed/simple;
	bh=SMu5/M35r01oC6tcgA4Z1ZBtXBnVinplRgHwFdbOwr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMnPFyVmaufPGAVbZvBorXwR0PgHDwwKIk9+L5iAyeQJUk1WbbrzUEXkC0LmWi3GSfP8XKK4oTjSi5IAUEJqc5qxNfeWrPI214d67hQxRL5lyLvy2A+cDQU4ofqrEtdZbIhStuZnNoJj2jQmnpzb4fOhU2L+ixnFfqo74aKQnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pm4Q5Ph3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB29CC113CC;
	Wed,  1 May 2024 13:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714569358;
	bh=SMu5/M35r01oC6tcgA4Z1ZBtXBnVinplRgHwFdbOwr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pm4Q5Ph39GLGiVEE/QaDTi0gKuPAeN1O01XoJX9DrPoh2dcDynVlEYEFGEEAky2IJ
	 +8IyRM5ala3q6kWdwMTZMZIxtkRDAHMA8p7etduck+xjB94Gxpl/vd6SPNWWAzjy7y
	 +IVTDaPtcTR6A6cQlo7qghD5ImdJQIRcMfHH5exIXa49WToCQ0DRaoWpjke7rgmckT
	 8F+tL1/aXnzlKttsx7LTYw6N5lzfFHGSmof+YEpD0hkn3pCS7etdkF3VBMXb8lOOdM
	 lkmXKNZ9nuwa4qvP3uLt0MRt19ovJ4ZA5MYS5ca8rWDSap3x3ie62ODZgoWLbVDJEx
	 IAwqlVdKFC+1Q==
Date: Wed, 1 May 2024 08:15:56 -0500
From: Rob Herring <robh@kernel.org>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v3 1/7] dt-bindings: iommu: riscv: Add bindings for
 RISC-V IOMMU
Message-ID: <20240501131556.GA2931109-robh@kernel.org>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <ef946892252b18f541986a461fc4d37957cc805e.1714494653.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef946892252b18f541986a461fc4d37957cc805e.1714494653.git.tjeznach@rivosinc.com>

On Tue, Apr 30, 2024 at 01:01:51PM -0700, Tomasz Jeznach wrote:
> Add bindings for the RISC-V IOMMU device drivers.
> 
> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  .../bindings/iommu/riscv,iommu.yaml           | 150 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 157 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> new file mode 100644
> index 000000000000..16817525e157
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> @@ -0,0 +1,150 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V IOMMU Architecture Implementation
> +
> +maintainers:
> +  - Tomasz Jeznach <tjeznach@rivosinc.com>
> +
> +description: |
> +  The RISC-V IOMMU provides memory address translation and isolation for
> +  input and output devices, supporting per-device translation context,
> +  shared process address spaces including the ATS and PRI components of
> +  the PCIe specification, two stage address translation and MSI remapping.
> +  It supports identical translation table format to the RISC-V address
> +  translation tables with page level access and protection attributes.
> +  Hardware uses in-memory command and fault reporting queues with wired
> +  interrupt or MSI notifications.
> +
> +  Visit https://github.com/riscv-non-isa/riscv-iommu for more details.
> +
> +  For information on assigning RISC-V IOMMU to its peripheral devices,
> +  see generic IOMMU bindings.
> +
> +properties:
> +  # For PCIe IOMMU hardware compatible property should contain the vendor
> +  # and device ID according to the PCI Bus Binding specification.
> +  # Since PCI provides built-in identification methods, compatible is not
> +  # actually required. For non-PCIe hardware implementations 'riscv,iommu'
> +  # should be specified along with 'reg' property providing MMIO location.
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qemu,iommu

'qemu,iommu' is too broad. Could be other QEMU implementations of an 
IOMMU. So 'qemu,riscv-iommu'.


> +          - const: riscv,iommu
> +      - items:
> +          - enum:
> +              - pci1efd,edf1
> +          - const: riscv,pci-iommu
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      For non-PCI devices this represents base address and size of for the
> +      IOMMU memory mapped registers interface.
> +      For PCI IOMMU hardware implementation this should represent an address
> +      of the IOMMU, as defined in the PCI Bus Binding reference. The reg
> +      property is a five-cell address encoded as (phys.hi phys.mid phys.lo
> +      size.hi size.lo), where phys.hi should contain the device's BDF as
> +      0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be zero.

No need to describe what the PCI address looks like.

> +
> +  '#iommu-cells':
> +    const: 1
> +    description:
> +      Has to be one. The single cell describes the requester id emitted

Drop 'Has to be one'. You already said that with the schema.

> +      by a master to the IOMMU.
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 4
> +    description:
> +      Wired interrupt vectors available for RISC-V IOMMU to notify the
> +      RISC-V HARTS. The cause to interrupt vector is software defined
> +      using IVEC IOMMU register.
> +
> +  msi-parent: true
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#iommu-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    /* Example 1 (IOMMU device with wired interrupts) */
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    iommu1: iommu@1bccd000 {
> +        compatible = "qemu,iommu", "riscv,iommu";
> +        reg = <0x1bccd000 0x1000>;
> +        interrupt-parent = <&aplic_smode>;
> +        interrupts = <32 IRQ_TYPE_LEVEL_HIGH>,
> +                     <33 IRQ_TYPE_LEVEL_HIGH>,
> +                     <34 IRQ_TYPE_LEVEL_HIGH>,
> +                     <35 IRQ_TYPE_LEVEL_HIGH>;
> +        #iommu-cells = <1>;
> +    };
> +
> +    /* Device with two IOMMU device IDs, 0 and 7 */
> +    master1 {
> +        iommus = <&iommu1 0>, <&iommu1 7>;
> +    };
> +
> +  - |+
> +    /* Example 2 (IOMMU device with shared wired interrupt) */
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    iommu2: iommu@1bccd000 {
> +        compatible = "qemu,iommu", "riscv,iommu";
> +        reg = <0x1bccd000 0x1000>;
> +        interrupt-parent = <&aplic_smode>;
> +        interrupts = <32 IRQ_TYPE_LEVEL_HIGH>;
> +        #iommu-cells = <1>;
> +    };
> +
> +  - |+
> +    /* Example 3 (IOMMU device with MSIs) */
> +    iommu3: iommu@1bcdd000 {
> +        compatible = "qemu,iommu", "riscv,iommu";
> +        reg = <0x1bccd000 0x1000>;
> +        msi-parent = <&imsics_smode>;
> +        #iommu-cells = <1>;
> +    };
> +
> +  - |+
> +    /* Example 4 (IOMMU PCIe device with MSIs) */
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@30000000 {
> +            device_type = "pci";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            reg = <0x0 0x30000000  0x0 0x1000000>;
> +            ranges = <0x02000000 0x0 0x41000000  0x0 0x41000000  0x0 0x0f000000>;
> +
> +            /*
> +             * The IOMMU manages all functions in this PCI domain except
> +             * itself. Omit BDF 00:01.0.
> +             */
> +            iommu-map = <0x0 &iommu0 0x0 0x8
> +                         0x9 &iommu0 0x9 0xfff7>;

Bracket each entry.

> +
> +            /* The IOMMU programming interface uses slot 00:01.0 */
> +            iommu0: iommu@1,0 {
> +               compatible = "pci1efd,edf1", "riscv,pci-iommu";
> +               reg = <0x800 0 0 0 0>;
> +               #iommu-cells = <1>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6dc90559341..7fcf7c27ef6b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18958,6 +18958,13 @@ F:	arch/riscv/
>  N:	riscv
>  K:	riscv
>  
> +RISC-V IOMMU
> +M:	Tomasz Jeznach <tjeznach@rivosinc.com>
> +L:	iommu@lists.linux.dev
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> +
>  RISC-V MICROCHIP FPGA SUPPORT
>  M:	Conor Dooley <conor.dooley@microchip.com>
>  M:	Daire McNamara <daire.mcnamara@microchip.com>
> -- 
> 2.34.1
> 

