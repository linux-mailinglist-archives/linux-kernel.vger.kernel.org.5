Return-Path: <linux-kernel+bounces-137853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DF689E846
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A157D1C23E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349108489;
	Wed, 10 Apr 2024 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ghhVpQV6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046171C0DF7;
	Wed, 10 Apr 2024 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712717269; cv=none; b=XZdxhbUl6o1q9ZVMU+LdfO7gDgEEyOieVrpJmQ/diEwP3JdvDUYYtAstoi1uXsg5dcOExx2A7JaNfWGW56dliMJpdKzHHVIN/JE8TYvrADMeM+jtNKsvOSh3ZwSWPHfXcskeUJoZC52gZay1MYTKuuVWRgHDrZKhoP59cCUEeZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712717269; c=relaxed/simple;
	bh=mOWD7xTxVomrfTmp8YHIIxoM7MCWN5VLKqDyKnTWfg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVjodMqNDsIPLN/rjz2UDFPHZ+DZH8ZuW5ecQ/3DqgdJSRKg2aFU4VJIXgnSTFamLhJ/1aJxtqoiBNDjKA+Qd3dVm/VuacopAkExq7fcI0j3V17AhbXhTVIKE+DHs4q0JoVEXSHPYnKbc3bqfAasc4oyesrEgFNFrlRfb0q2qQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ghhVpQV6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712717261;
	bh=mLlc3a7A+WiO812az/hZEqjgAVnAiZZT9ETARfh1iIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ghhVpQV6j6zTYnf8M+aMSVN1f9gZri4s+bEJdqtEIOLh1KPMF1KTMt6HWCbCfjoBF
	 RRB4JmWVZFQscEriXNCNxIqxCH0AOHKLcJWp+8Lkk1+58cNHC/lvyl1n4u2Ck+SlA2
	 nVJUmS4CsNykMeINn64MkPmT3HMh2ImdUllN3YfAAd/bWFq/MgoK95zTA/P7ZLQ7b8
	 gnw8X4oBPQP3+zamYColJ+YKsw+nXgSBjbNgYTxzatwkK+BJYxibdEvncrzRdLtwpO
	 cudnNUzSrZn32FePqeZ+J32kAAHSVfxO7zAxsLrTWqmcZOghS9unMhycziPKB9SLj6
	 PIjY+ICZ/rlnA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VDnLL2nwhz4wcn;
	Wed, 10 Apr 2024 12:47:38 +1000 (AEST)
Date: Wed, 10 Apr 2024 12:47:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann
 <arnd@arndb.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH] vdso: Fix powerpc build U64_MAX undeclared error
Message-ID: <20240410124735.4c118aba@canb.auug.org.au>
In-Reply-To: <20240409062639.3393-1-adrian.hunter@intel.com>
References: <20240409062639.3393-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vOfEbzDCAvOKJVGaVwivnDx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/vOfEbzDCAvOKJVGaVwivnDx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Tue,  9 Apr 2024 09:26:39 +0300 Adrian Hunter <adrian.hunter@intel.com> =
wrote:
>
> U64_MAX is not in include/vdso/limits.h, although that isn't noticed on x=
86
> because x86 includes include/linux/limits.h indirectly. However powerpc
> is more selective, resulting in the following build error:
>=20
>   In file included from <command-line>:
>   lib/vdso/gettimeofday.c: In function 'vdso_calc_ns':
>   lib/vdso/gettimeofday.c:11:33: error: 'U64_MAX' undeclared
>      11 | # define VDSO_DELTA_MASK(vd)    U64_MAX
>         |                                 ^~~~~~~
>=20
> Use ULLONG_MAX instead which will work just as well and is in
> include/vdso/limits.h.
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20240409124905.6816db37@canb.auug.org=
au/
> Fixes: c8e3a8b6f2e6 ("vdso: Consolidate vdso_calc_delta()")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  lib/vdso/gettimeofday.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index 9c3a8d2440c9..899850bd6f0b 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -8,7 +8,7 @@
>  #ifndef vdso_calc_ns
> =20
>  #ifdef VDSO_DELTA_NOMASK
> -# define VDSO_DELTA_MASK(vd)	U64_MAX
> +# define VDSO_DELTA_MASK(vd)	ULLONG_MAX
>  #else
>  # define VDSO_DELTA_MASK(vd)	(vd->mask)
>  #endif
> --=20
> 2.34.1
>=20

I have applied that to linux-next today and it builds for me.

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> # build only

--=20
Cheers,
Stephen Rothwell

--Sig_/vOfEbzDCAvOKJVGaVwivnDx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYV/ccACgkQAVBC80lX
0GyhBgf+Jf8pX6z5I6OHsmD8CbYP6GnKCBxvh+gR4ghWc9UAElgV+QAxw5qUh13q
pwIl5H6aCeg7RoNnVXYeIXDu7lzsJCgMWXwAC9Cl5us+ob0kvhCp33VGNZAFNBRr
6I6OSBNcIOpYtvjtMGHuD59I+u6X7v6vFJvQPBh0AdTHT+RnL3FGbV6kJGcF3+fs
HYIU3+af8/QqSYJ6bYu1Mr+YuRtWlQaQf+M+tPgFumWJEqqZnPfswcEHYlEvXU0L
HZrGroFagXi+Cl5pkmHWNaJIIzJpP9w8Fsyrc1D8iutNbEVrrXsiaKx0xROEIIx1
WGN5Qw9igAxfEy8yrGK8VRo74cTy6Q==
=GLls
-----END PGP SIGNATURE-----

--Sig_/vOfEbzDCAvOKJVGaVwivnDx--

