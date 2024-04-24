Return-Path: <linux-kernel+bounces-156817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01098B089A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948C21F2439A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321215AAAA;
	Wed, 24 Apr 2024 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPZArd9Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B015A4A3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959311; cv=none; b=MVCvGf2eeQ06xMIWFirc77efCQKmhsmJaUGPpyEZCw46WrLViGeEo7l98pdZemDsXXjw7wBVO5tToSv7CGJWMd0qAZiOxJTdM98x3HHF17ak87ZFFDXRqMVstyUq3v9IP7LA5v2cIKmhYtgoVG4BNKq0C8PkBwuVKJQs+xoPGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959311; c=relaxed/simple;
	bh=PO7HEtXuGC+TI0QunfomdbHElXxBffRMMrNGD/K4vzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/sGVB6ql2kpyHnrpS7iJEe5Rg1Gd03RB+JsZVsxWHif4uR859lRBAZgCUZ8M4X/3Bm2NvI6Tko9/u+BcS5hXcQACLpVcKSQS5Gvvi6l6YPIxkTl0tqIa1TjfWqwaz9wOMS7V5wtSMAtttz6g3Tj3HojqyggeFqgxwsvVvttrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPZArd9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E7AC113CE;
	Wed, 24 Apr 2024 11:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713959311;
	bh=PO7HEtXuGC+TI0QunfomdbHElXxBffRMMrNGD/K4vzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPZArd9ZAY5oMK6RVkPMKw+v+1bfHu4kyQ3uM7msjAj9edGK2JFwsSXLvIjClb3Df
	 j7LvoLkaISGN329wmk6j/7FIPqf/eV17x3lWfhbL3GtdHeu4m0jcGV0+yVmEpv/LnT
	 aB0TwULU2N80V6eQ7AfXDWq2f6UlpZ/278kQ2aJP6my6hFcWcy9cmZDCAp+wTUKNHb
	 Yc/mZw/0JrnKVDM5lop926ZmG1WEwnjfJVKTOpLlPQIwtZQ9h4HnRaBYEAzkejj77k
	 Z7vVAS6ZOOyU3SjFlBn5qn1Cwy5Rm7u4ZrCeAomhwJWbC702c0Ns8niLRN5qoeAgFZ
	 xs+iasmtvTllg==
Date: Wed, 24 Apr 2024 12:48:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH riscv/for-next] riscv: cacheflush: Fix warning when
 compiled without CONFIG_SMP
Message-ID: <20240424-aspect-swinger-50d47c3d0a72@spud>
References: <20240417-fix_nosmp_icache-v1-1-921a3c07d4ce@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NanvZTWuCzgHOaYO"
Content-Disposition: inline
In-Reply-To: <20240417-fix_nosmp_icache-v1-1-921a3c07d4ce@rivosinc.com>


--NanvZTWuCzgHOaYO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 04:49:48PM -0700, Charlie Jenkins wrote:
> GCC tries to compile the static function set_icache_stale_mask() even
> when there are no callers. Guard the function with #ifdef CONFIG_SMP.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: 383289e4b071 ("riscv: Include riscv_set_icache_flush_ctx prctl")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404180621.qG7A9Tk0-lkp@i=
ntel.com/
> ---
> Since this is just in for-next Palmer do you want to squash this onto the
> commit that introduced this 383289e4b071?

It's not even in riscv/for-next as far as I can tell, and looks like the
squash into the staging copy has already happened. I'm gonna drop this
=66rom patchwork.

> ---
>  arch/riscv/mm/cacheflush.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 3b03534e57b4..3ef666c7dfc7 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -154,6 +154,7 @@ void __init riscv_init_cbo_blocksizes(void)
>  		riscv_cboz_block_size =3D cboz_block_size;
>  }
> =20
> +#ifdef CONFIG_SMP
>  static void set_icache_stale_mask(void)
>  {
>  	cpumask_t *mask;
> @@ -171,6 +172,7 @@ static void set_icache_stale_mask(void)
>  	cpumask_setall(mask);
>  	cpumask_assign_cpu(smp_processor_id(), mask, stale_cpu);
>  }
> +#endif
> =20
>  /**
>   * riscv_set_icache_flush_ctx() - Enable/disable icache flushing instruc=
tions in
>=20
> ---
> base-commit: a76716f0ec75b9e7ac62d30854d690044c857684
> change-id: 20240417-fix_nosmp_icache-0fc36aeafbe5
> --=20
> - Charlie
>=20
>=20

--NanvZTWuCzgHOaYO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZijxigAKCRB4tDGHoIJi
0iHSAQDMmKslb0ZNvdDMQXGxUh6Nh2yAwGICnXywnCtLSJvYBQEAh0pm2Q+fF4dA
9XYZPXj927z8xflePWNO47VSCEq9SA8=
=dZsw
-----END PGP SIGNATURE-----

--NanvZTWuCzgHOaYO--

