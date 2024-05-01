Return-Path: <linux-kernel+bounces-165102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC88B881C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5880F1F21CFB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1C12F382;
	Wed,  1 May 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXiZGDT6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B784D3F;
	Wed,  1 May 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555810; cv=none; b=GdplTVcKtiotKUWYoQQgp0S8hpWvvQ+n+qQ32PcpM3EeY0834Qwg+/94xxcY98FeJFmkvALo2W2pdnbbyXOnoWgeSFhzGscatKuxruymrR8gfSG10KMeV5YBX0s3Ov9cAO8iCcDaqjPH7UCznZODRbMyfAkwmS8zRO5wSYIPqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555810; c=relaxed/simple;
	bh=VKb2Qv4Q48BFrbkgCtOU+TMtJVAe3nV1glvc9i3axIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzDLXWQpPiqwxFezs+NBkABzw80XMQYrrvgVPaqh7l5iTxCXlTQ+k2wHNEMEIJLPfNU59UoiMOGtrgqhW3UYUsYqov1jEVWSPQ9EdIng9UhKAbl6kYaStE5l+Ewnzjwsu9JOS7tobxfuL0E/aIBV7KaesNoJ/u+VTaRWpVcmAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXiZGDT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75548C113CC;
	Wed,  1 May 2024 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714555810;
	bh=VKb2Qv4Q48BFrbkgCtOU+TMtJVAe3nV1glvc9i3axIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uXiZGDT68FNRdgJJs8fQk/wLVPy+9rj+Vple1CDy4aaCAVWDW87ayl5ZHIqmrkSiZ
	 6cd7vIpAbsfRShV61HV5CLeHJM7oqPnlIjz2MnLgMt5V4tWCFlwcqyh91EBc9BwuQV
	 ctStwncTyY+1u0Ec+2T0VwMVn7XifXUyFm5Aj+WcwmhcF0c5sTOQyh9VXelBGfRdKI
	 c+LipyiB5/TL0O+omtfQixm0FEIDLYCEDiQY2CPnowg0kP934YsllnkjPIs22MJMoi
	 U69rn8xUzHUdbIrw7T0UFmAHVAzZO5kjJ4cwB1uv0rnzISIySVOKmyrK10gjs70On3
	 yB4T49c5+rsww==
Date: Wed, 1 May 2024 10:30:04 +0100
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
Subject: Re: [PATCH v3 1/7] dt-bindings: iommu: riscv: Add bindings for
 RISC-V IOMMU
Message-ID: <20240501-glare-occupier-2aee6a0aab06@spud>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <ef946892252b18f541986a461fc4d37957cc805e.1714494653.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Z5SiWKVwvbIGEtZ"
Content-Disposition: inline
In-Reply-To: <ef946892252b18f541986a461fc4d37957cc805e.1714494653.git.tjeznach@rivosinc.com>


--/Z5SiWKVwvbIGEtZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 01:01:51PM -0700, Tomasz Jeznach wrote:
> Add bindings for the RISC-V IOMMU device drivers.
>=20
> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--/Z5SiWKVwvbIGEtZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjILnAAKCRB4tDGHoIJi
0oaeAQDoRn7fJYpDDfUn0qu2MHETNws6s/wADmGEMh9cFwVRSwD/XtiAqhDnwD1g
YDrbG5pZWpjKXqM3zLJ9OKiDXJqO7QE=
=3DCc
-----END PGP SIGNATURE-----

--/Z5SiWKVwvbIGEtZ--

