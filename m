Return-Path: <linux-kernel+bounces-9045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D14281BF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE4DB22CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B9B760AB;
	Thu, 21 Dec 2023 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB6D6Rnd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F076088
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B557C433C7;
	Thu, 21 Dec 2023 20:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703190576;
	bh=GLPwYHlJ8x8CC2ZjS/hbGnZAkXoFODBXx25zO0WgP5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RB6D6Rnd1pKUiP8WcHVN4/voeyF/rIxEiRR2YIatXbf5y0c/He+mc41gDaHpXVJlJ
	 sN72jvTnV0UxKgKNZZ/BNRbb0SGrtzG1pqhAu+abK620hbNSihKLuc2eCa/G/oZaAT
	 iGsaJOuTx6Rdt0kXPKatKS9uFiD/k9vWLbmQKJYOGZ5y+6I9RX0n0iOBEBi6esZRhF
	 WbX3TbOF+Jpc9Mw8Cq8tFJbC/h0tC6O0L6FYBxokYyp/Qn8HeVpz/UrVYv35U+GVb1
	 HrBiNRM1WLGuz7010N2ucObjl153Nr2twHNoi50v9t3vVXp4VNhrVy7Jm79p7HywiR
	 gZBDrad7xFEug==
Date: Thu, 21 Dec 2023 20:29:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Maxim Kochetkov <fido_max@inbox.ru>, hch@lst.de
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, jiaxun.yang@flygoat.com, mpe@ellerman.id.au,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 1/1] riscv: set ARCH_DMA_DEFAULT_COHERENT if
 RISCV_DMA_NONCOHERENT is not set
Message-ID: <20231221-discount-decade-e306e5878c46@spud>
References: <20231221185152.327231-1-fido_max@inbox.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m9L8Yh/1MYWrfu4R"
Content-Disposition: inline
In-Reply-To: <20231221185152.327231-1-fido_max@inbox.ru>


--m9L8Yh/1MYWrfu4R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+ Christoph

I don't think this patch is correct. Regardless of whether we support
cache management operations, DMA is assumed to be coherent unless
peripherals etc are specified to otherwise in DT (or however ACPI deals
with that kind of thing).

What problem are you trying to solve here?

On Thu, Dec 21, 2023 at 09:51:52PM +0300, Maxim Kochetkov wrote:
> Not all the RISCV are DMA coherent by default.=20

What is a "RISCV"? I believe this sentence should be "not all RISC-V
systems are DMA coherent." but that is provided for by the
"dma-noncoherent" property, set for peripherals (or buses) that are not
DMA coherent.

> Moreover we have
> RISCV_DMA_NONCOHERENT option.
> So set ARCH_DMA_DEFAULT_COHERENT only when RISCV_DMA_NONCOHERENT is not s=
et
>=20
> Fixes: c00a60d6f4a1 ("of: address: always use dma_default_coherent for de=
fault coherency")
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d6824bec2c00..111c5d92d503 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -14,7 +14,7 @@ config RISCV
>  	def_bool y
>  	select ACPI_GENERIC_GSI if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> -	select ARCH_DMA_DEFAULT_COHERENT
> +	select ARCH_DMA_DEFAULT_COHERENT if !RISCV_DMA_NONCOHERENT

I think this is actually buggy, for things like distro kernels
RISCV_DMA_COHERENT will always be set, but those kernels are expected
to be used on systems that are cache coherent also.

Thanks,
Conor.

>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> --=20
> 2.40.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--m9L8Yh/1MYWrfu4R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYSgLAAKCRB4tDGHoIJi
0u/aAP0QwgAVeaL+V/KwjoqqvHiJTMZXmApkakiQZL1fuV8lgwD/UR0j8eNQzR8R
ztGAgxGUpsmf/LpuMHHnp/xIYdD/BwM=
=U837
-----END PGP SIGNATURE-----

--m9L8Yh/1MYWrfu4R--

