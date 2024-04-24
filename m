Return-Path: <linux-kernel+bounces-156745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DDF8B0799
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92561C22D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF0B159593;
	Wed, 24 Apr 2024 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RreylLs9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372D13D530
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955460; cv=none; b=Qxoz6OCV/ZjPGhxbOZS5nTNCgvEt84Lru35/3u0SlXPZTFZFyOdqHaZO6gLZUjtIzPdkJX84DFK+OjK4Zi1vCwoO9OeXr/5NWF1wIcnDaaQylpMW/G8oJqJk6XkGnlhEyntqClgl/rm6OmNVJkzog+YX8hnbj5aFO2KasmZJXew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955460; c=relaxed/simple;
	bh=pxcrTqMySGCVkz1+SW4pSfn2o4/wRsYgarTqYSbPgQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5ZK4gnaQ45kkhq48wwmCEsL8ZDRI/416/OiRYzi9pQqkgsWIGNMhs0Epvi5WjP27G6ofktUSov1NwQQFpNxBHvVmAhC/5iGLiWxCRtJ/T5djLqJK+eEGu2RtTGaknesNQXXwQMHTzAj+lqW8AvpBA8u61nVCjhy0sCDhNB9NEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RreylLs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B97BC2BD10;
	Wed, 24 Apr 2024 10:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713955460;
	bh=pxcrTqMySGCVkz1+SW4pSfn2o4/wRsYgarTqYSbPgQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RreylLs9xzJy/N92arsIpcrRr9Eft5sVAPuRoXNMRC+wsHuoXbZKtd9NrNegHaxq5
	 C1PlsMzOzln2xI+/S2iCTQM+/Y88ByW97BworA81gprotEl5e1G/ZaMSu+5LPbNkUY
	 yBO+o3CardxQqod2+v+poeXCR5CUs/hKoDtgJIbl5sEmWepjoVz4U6txp8swtxQbjv
	 4mVbxj6wFF+xbx5cBSqmh2lhshM2AVyTRS9WtZgprvysx2mf5lBfWpYI2Wq1wMP2E3
	 y1jsgSm31soPp0PZPLMtpEa8UeiqRZ9jCgmTU/bKy+gIXLRD6INAyUL77berQa3Dun
	 efbB6mBoXIKsA==
Date: Wed, 24 Apr 2024 11:44:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] riscv: Simplify text patching loops
Message-ID: <20240424-cranial-punch-27b38726d3f7@spud>
References: <20240327160520.791322-1-samuel.holland@sifive.com>
 <20240327160520.791322-5-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="McmlA8K/qaTnrTZf"
Content-Disposition: inline
In-Reply-To: <20240327160520.791322-5-samuel.holland@sifive.com>


--McmlA8K/qaTnrTZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 09:04:43AM -0700, Samuel Holland wrote:
> This reduces the number of variables and makes the code easier to parse.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>=20
> Changes in v2:
>  - Further simplify patch_insn_set()/patch_insn_write() loop conditions
>  - Use min() instead of min_t() since both sides are unsigned long
>=20
>  arch/riscv/kernel/patch.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 9a1bce1adf5a..0d1700d1934c 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -155,22 +155,24 @@ NOKPROBE_SYMBOL(__patch_insn_write);
> =20
>  static int patch_insn_set(void *addr, u8 c, size_t len)
>  {
> -	size_t patched =3D 0;
>  	size_t size;
> -	int ret =3D 0;
> =20
>  	/*
>  	 * __patch_insn_set() can only work on 2 pages at a time so call it in a
>  	 * loop with len <=3D 2 * PAGE_SIZE.
>  	 */
> -	while (patched < len && !ret) {
> -		size =3D min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched),=
 len - patched);
> -		ret =3D __patch_insn_set(addr + patched, c, size);
> -
> -		patched +=3D size;
>  	}
> =20
> -	return ret;
>  }

Weren't these actively wrong before, if a non-ultimate
__patch_insn_set() failed we'd just ignore the error?

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--McmlA8K/qaTnrTZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZijigAAKCRB4tDGHoIJi
0q57AP0UAhx5QNtAbU133ScLNzELZcym+MIXcLM8EZQCAH/skQEA2EtGNG7wt3yz
kRcpFCV6rRc3Ypqb47F4ogt+DiOoCA8=
=FbM0
-----END PGP SIGNATURE-----

--McmlA8K/qaTnrTZf--

