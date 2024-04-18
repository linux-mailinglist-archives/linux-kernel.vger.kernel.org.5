Return-Path: <linux-kernel+bounces-150535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249958AA0B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566D01C21D48
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FA6171E4F;
	Thu, 18 Apr 2024 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQMnnnfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B616F8F3;
	Thu, 18 Apr 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459849; cv=none; b=OVnJDxmtDV+BrCdi0B1X9KTGtZ3M3GEa4HX7zGAXgW48QgNZEeYO3U/qtZO+EPI7yfuEtPiHIGF9wKGVmA9W1tirnGTFe1a6awvr0oZv+Jnd5WzaeridFG4Vgglf+xsTWCDjmR2ppgoBrChY3Kf7eVJ2s9vbawcJavwMDRqQC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459849; c=relaxed/simple;
	bh=+tpRTJtsOFRM7YQSk7tL2XGyEcaVFk2CAaRZfgRJnUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsngf8z9yOUBJVfzEB74ls8SKNcxtNJTgdpzHKjxVCIFcndYT69WTO+YX3nF8Y91yoLFrcxZoeJ6djt4sofwGSB3Cgp70zvykJD2ASDtnSvkTtkE9acff/DrdLTUYQ03ONjScXoXa+pYS73eDBxehZLGxhm+bRZ1C83dfCGdNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQMnnnfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FC4C113CC;
	Thu, 18 Apr 2024 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713459849;
	bh=+tpRTJtsOFRM7YQSk7tL2XGyEcaVFk2CAaRZfgRJnUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQMnnnfSBVUOkNmpDuqpanPgIdPXohtKKPOIs8QK66pW4vJF8MQEPEq5/TUf17sTm
	 YakEmENtf9PxeIL9CSNhGp3C4EtF80Um2m5hh77C5bJUYSs4Zz9174vsy6guICe8DM
	 TiHKlu2dPN5vERV2YsU8PrcUdxN+RpYdigWS94PwI/uUPA0i7VIaKlhmzT6jl6SQdz
	 fUdyYrV8M3ylSy3NPrZlGxMPcpjTMIRhWO4j8XC+PkKcEU0RJBOgUUT6CiPvwmkKDF
	 Kcdbx0VzPVsVz6A6A76A1w6ClOQD6GvVgunRf7gThzj04fQMs50F48O4h80Km4dEVw
	 ErA3uwJndDYlA==
Date: Thu, 18 Apr 2024 18:04:03 +0100
From: Conor Dooley <conor@kernel.org>
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
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v2 1/7] dt-bindings: iommu: riscv: Add bindings for
 RISC-V IOMMU
Message-ID: <20240418-approach-liquefy-04551ddefbc4@spud>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <c37cb93e7baa7042a3f82130bf30be6831b558dc.1713456598.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rqk2Fw9rLZ9f77fo"
Content-Disposition: inline
In-Reply-To: <c37cb93e7baa7042a3f82130bf30be6831b558dc.1713456598.git.tjeznach@rivosinc.com>


--Rqk2Fw9rLZ9f77fo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 09:32:19AM -0700, Tomasz Jeznach wrote:
> Add bindings for the RISC-V IOMMU device drivers.
>=20
> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  .../bindings/iommu/riscv,iommu.yaml           | 149 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/D=
ocumentation/devicetree/bindings/iommu/riscv,iommu.yaml
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

FYI, the + here is probably not needed.

> +  The RISC-V IOMMU provides memory address translation and isolation for
> +  input and output devices, supporting per-device translation context,
> +  shared process address spaces including the ATS and PRI components of
> +  the PCIe specification, two stage address translation and MSI remappin=
g.
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
> +  # actually required. For non-PCIe hardware implementations 'riscv,iomm=
u'
> +  # should be specified along with 'reg' property providing MMIO locatio=
n.

I dunno, I'd like to see soc-specific compatibles for implementations of
the RISC-V IOMMU. If you need a DT compatible for use in QEMU, I'd
suggest doing what was done for the aplic and having a dedicated
compatible for that and disallow having "riscv,iommu" in isolation.

> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: riscv,pci-iommu
> +          - const: pci1efd,edf1
> +      - items:
> +          - const: pci1efd,edf1

Why are both versions allowed? If the former is more understandable,
can't we just go with that?

> +      - items:
> +          - const: riscv,iommu

Other than the compatible setup I think this is pretty decent though,
Conor.

--Rqk2Fw9rLZ9f77fo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiFSgwAKCRB4tDGHoIJi
0l8lAQDVxpOYtqJ5N0VIeqSL5joovSdzpNunYGgrbV4XSnS+VAD/RSNSV7cgp+VK
l9sXMIW7ys3Wzwv8/1/vz3UBCbiDuAo=
=r1Kq
-----END PGP SIGNATURE-----

--Rqk2Fw9rLZ9f77fo--

