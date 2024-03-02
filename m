Return-Path: <linux-kernel+bounces-89597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA986F27A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 22:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49283282F80
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E6440C15;
	Sat,  2 Mar 2024 21:05:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1417C69
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709413518; cv=none; b=QRQ9kissgAjI3YKtxoxVvHMClalVyBorFoySIHxeIUG292Bm3CkJD8iueInNYCvLRWyEoCpLSHsrgKdns7f2UaZjWTTWiSk+cgaM1t1cbSsgvww3Lm2/ZJhYAgMRLEH93SWvGl9UJGmoN5/BVN0Vr1X3B2TG4p2dCdRMaf/hcJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709413518; c=relaxed/simple;
	bh=pPIJ3yApZLbe54NrsOEjiQdYrpXf6sa/2ELrkOiAhy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR8+ajN3wJmtf/H/b+xYjg1N/I3jvVt1QN4uKzUtB9lOuc+VWsoGTabvN1yUDAmqhpZYY5OWN2/JLQ+S3gbc6C0/b71b6G+Lk4wNifW/ML+X9899JRDA/dSsQDUD6ls0/Lhz2ZMjZOLfuuwudyqG5C+tsRAxaeBpuRcdBWiQ7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rgWXg-0005K9-J2; Sat, 02 Mar 2024 22:05:12 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rgWXf-0042Ig-KM; Sat, 02 Mar 2024 22:05:11 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4C01F29C36E;
	Sat,  2 Mar 2024 21:05:11 +0000 (UTC)
Date: Sat, 2 Mar 2024 22:05:09 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] mul_u64_u64_div_u64: Increase precision by conditionally
 swapping a and b
Message-ID: <20240302-deed-greyhound-f0c6c831e4c7-mkl@pengutronix.de>
References: <20240302205426.639205-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vdhplgvmqojqydbk"
Content-Disposition: inline
In-Reply-To: <20240302205426.639205-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--vdhplgvmqojqydbk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.03.2024 21:54:27, Uwe Kleine-K=C3=B6nig wrote:
> As indicated in the added comment, the algorithm works better if b is
> big. As multiplication is commutative, a and b can be swapped. Do this
> If a is bigger than b.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  lib/math/div64.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/lib/math/div64.c b/lib/math/div64.c
> index 55a81782e271..baf6f8681907 100644
> --- a/lib/math/div64.c
> +++ b/lib/math/div64.c
> @@ -190,6 +190,23 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> =20
>  	/* can a * b overflow ? */
>  	if (ilog2(a) + ilog2(b) > 62) {
> +		/*
> +		 * Note that the algorithm after the if block below might loose
> +		 * some precision and the result is more exact for b > a. So
> +		 * exchange a and b if a is bigger than b.
> +		 *
> +		 * For example with a =3D 43980465100800, b =3D 100000000, c =3D 10000=
00000
> +		 * the below calculation doesn't modify b at all because div =3D=3D 0
> +		 * and then shift becomes 45 + 26 - 62 =3D 9 and so the result
> +		 * becomes 4398035251080. However with a and b swapped the exact
> +		 * result is calculated (i.e. 4398046510080).
> +		 */
> +		if (a > b) {
> +			u64 tmp =3D a;
> +			a =3D b;
> +			b =3D tmp;

You can use swap() from linux/minmax.h here.

Marc

> +		}
> +
>  		/*
>  		 * (b * a) / c is equal to
>  		 *
>=20
> base-commit: 1870cdc0e8dee32e3c221704a2977898ba4c10e8
> --=20
> 2.43.0
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vdhplgvmqojqydbk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXjlIIACgkQKDiiPnot
vG+MJAf/b7QUr91MOkjnM0RsU4uetTKQ1Kf7OhsaPJHC4wzqeoezIPdDRYUz/3Iz
o14MmVROUmCNN2s3qeBau+AERjyzPa0Q/pexoAK47GGE2kiR93P9/DwbPAFyE0Qb
Rrdv1pEbc+P+32LcF3gWrNI5tdaW5/PdrIZVbYH/HDHifja+lctvtQFiPbqaoGkU
Xi1+GCvoymigqHnN6p8Jt4ZoqDnS75HYBBaEebmfHARSKZ7bsZ/tK6NIcqQsSZMH
d4pZDFC+aOwAUucGr6i1Gs9W5Y2icJGI/T4/hYyusliD1DoqTzye5HRvLeidDBUw
GHSSIQDjLOW7A/68n/GuHapzx01Mmg==
=SOi2
-----END PGP SIGNATURE-----

--vdhplgvmqojqydbk--

