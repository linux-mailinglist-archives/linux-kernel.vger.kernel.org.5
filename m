Return-Path: <linux-kernel+bounces-153512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C908ACEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5517F1C21342
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666921509A1;
	Mon, 22 Apr 2024 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feAlIGVk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23CA14F9EB;
	Mon, 22 Apr 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713794658; cv=none; b=fJbikAHjLlRfppVaar5sysWsqwmcInZmSzG6yD9K2MpANNG6Let0mJOy8dajob7akADC649l1NYloy06CWNpnMOmzKxzRHaShOVrKvLdEzF+pw6EB0Rn2dP9bnzO4qcSpLMZqCehWxdIDHGADRqPS8oVmq6wRWVOs2HQh4HB1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713794658; c=relaxed/simple;
	bh=6S2xDWTRnzyPkq2E+nBY5AiINL0m8wq/LI6ka+0jqfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJEq7V5qOy9q24kdQlv/6PZFq7OyijiFZcLjcH/KMnmQCpekbZrTIFeBKlp08fxHJG6FQxpel6pHwy4Tq986+564r0tQTTo8vWGPzg0oHntZb8TVG/t/GLSb8HXsIFhlc08dwkonD01UicsPy4jXAJIDon5HhBfgYOnfslmZYaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feAlIGVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85E4C32781;
	Mon, 22 Apr 2024 14:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713794658;
	bh=6S2xDWTRnzyPkq2E+nBY5AiINL0m8wq/LI6ka+0jqfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=feAlIGVkuaoRq7hj5iefuaj7ZYPf3feZg5AOcaLs3V/HNbwPFl0zvPaN7B5LwVyj3
	 5d2uCBrJDhE8MbYj/b60uGmST/OIqOwZKbijoOBRrWf1D4gtYw1y83NKMdaq8x/s40
	 c+M/EeuRU2NIfITCWIhKw4rv55aME6HNDFmsBN90c1jbkvkUlL5vN05gJpFrMc4ycd
	 FbeKtdhdTIOHkA2CJFdEsb4DFfV1+whzH400oogS34PRRn7EZzwQYiixQ1qRrHlHRU
	 xJRkdLPRhrNM1G/feJks1/AjDJ2y02Lo6hABykjBf/ghONntAHPRy7kR5OFv05ntTm
	 hiZTIqyyf/lgA==
Date: Mon, 22 Apr 2024 09:04:15 -0500
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
Subject: Re: [PATCH v2 1/7] dt-bindings: iommu: riscv: Add bindings for
 RISC-V IOMMU
Message-ID: <20240422140415.GA1139322-robh@kernel.org>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <c37cb93e7baa7042a3f82130bf30be6831b558dc.1713456598.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c37cb93e7baa7042a3f82130bf30be6831b558dc.1713456598.git.tjeznach@rivosinc.com>

On Thu, Apr 18, 2024 at 09:32:19AM -0700, Tomasz Jeznach wrote:
> Add bindings for the RISC-V IOMMU device drivers.
> 
> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  .../bindings/iommu/riscv,iommu.yaml           | 149 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> new file mode 100644
> index 000000000000..d6522ddd43fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> @@ -0,0 +1,149 @@
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
> +description: |+
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
> +          - const: riscv,pci-iommu
> +          - const: pci1efd,edf1

Given the PCI compatible string is a specific vendor and device, it is 
more specific than "riscv,pci-iommu" and should come first.

> +      - items:
> +          - const: pci1efd,edf1

Why do you need to support this without riscv,pci-iommu?

> +      - items:
> +          - const: riscv,iommu

I agree with what Conor said on this.

Rob

