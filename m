Return-Path: <linux-kernel+bounces-18917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5F826519
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3A32820CE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6213AEF;
	Sun,  7 Jan 2024 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="KrzuH2Gi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583413AD9;
	Sun,  7 Jan 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 7FE2528B53B;
	Sun,  7 Jan 2024 16:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1704644933;
	bh=CTBOvpaXdX0EsHWrCx2vdZMcdtrL/UMHc/m9ZlVgi4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KrzuH2GiE05EcwsLbrVJmHYfPW+8GtqJYxn7cAjne/9vAJ2hKAyM81H5aIMSJIWDZ
	 GRTKMkOw6HQMWCfFTEkIvDAsUIB1VJZ/AR2wwB54DTTM1W80ykE09YiJzWK2oE8CfR
	 qW2P4lBGwi6aLOTrfCAdaix74mAP3IH/I5Tj2qBg=
Date: Sun, 7 Jan 2024 18:28:52 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/1] tools: iio: fix iio_generic_buffer
Message-ID: <ZZrRRNTUbXaDIgRU@sunspire>
References: <20240104101253.25896-1-petre.rodan@subdimension.ro>
 <20240104101253.25896-2-petre.rodan@subdimension.ro>
 <20240107155333.0e43b041@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zqf1JCAeZ2jJLOAM"
Content-Disposition: inline
In-Reply-To: <20240107155333.0e43b041@jic23-huawei>


--Zqf1JCAeZ2jJLOAM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Jonathan,

On Sun, Jan 07, 2024 at 03:53:33PM +0000, Jonathan Cameron wrote:
> On Thu,  4 Jan 2024 12:12:45 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
>=20
> > Fix code flow problem and floating point exception caused by improper
> > directory stream positioning.
> >=20
> > Fixes: <e58537ccce733> ("staging: iio: update example application.")
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> Hi Petre,
>=20
> This doesn't really explain 'why' seeekdir(dp, 0) is wrong.
> My assumption is that telldir() would not have returned 0 on this particu=
lar
> system?  Could you confirm that and update the message to explain why
> seekdir(dp, 0) is not equivalent to rewinddir(dp).

it looks like there is a 32-bit specific bug in one of the glibc patches th=
at
the stable Gentoo Linux is using [1]. telldir returns (u32)(-1) if seekdir =
is
used which ends up in a floating point exception.

it so happens that the rewinddir() function (which is equivalent) works
correctly. so it is a fix for Gentoo users and should not impact anyone els=
e.

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=3D31212

my very best regards,
peter

> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  tools/iio/iio_utils.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> > index 6a00a6eecaef..c5c5082cb24e 100644
> > --- a/tools/iio/iio_utils.c
> > +++ b/tools/iio/iio_utils.c
> > @@ -376,7 +376,7 @@ int build_channel_array(const char *device_dir, int=
 buffer_idx,
> >  		goto error_close_dir;
> >  	}
> >=20
> > -	seekdir(dp, 0);
> > +	rewinddir(dp);
> >  	while (ent =3D readdir(dp), ent) {
> >  		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
> >  			   "_en") =3D=3D 0) {
> > --
> > 2.41.0

--Zqf1JCAeZ2jJLOAM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWa0UQACgkQzyaZmYRO
fzDovg//VVy5Z6eThxtYXOO6ZHyAlKAr2dAxJeh9tO464Lkzq3VYWfPj5j1FbKjk
WOlUYa0oa3CLew0NQR4WuH4nxbs9TJD5EQxO6TYanZ0JGxVUDv15sz517G3XZ7uS
x60asWALVNH0jWMTUYE+lmSrAnS1fREnkAkZDv+AFCkTvjrEr/WXV0juUtwqxlgR
6mmSRTd1VpEdWJL/NDBaF7M7O059ubRTA8LQeJ7aFaqCtuoWCB6cngK77P9LMqLS
3xxG9eyT+0rzPB9uYoZaNcutPNT80IUZL4DhPESE1Tdo9VsdWBb6NflQ35JAn6tN
YBYUbz0qzXvF9thT5C+M6HJJ44/VOnXml8zFrggjaIRHFKvLO6wx6sFsV4Ls5jvl
IXGMit2OQJHRKA5sz/MNHvlumwC/FNoTlRewYKYRQrxDOZ5TseXxj9QsTx/oxM+7
7KusWUXDl3Zb4lnnzZFTCPwUoznMJlGym/R0IEb2naHW5gOoESbwIjZPrLKC7X2N
fV1+m1zS1HNXOS5iICqelz1pd2qtDVC1m1FkuMlt8rhw5ySYPqvwBSnlS3/GQgJz
D2z8FfgFZ2cwyekStc/fwE1aeYu/9uiQ+xu9X/g8D6OpfMqqG/nIMM3NrM/b7nYA
onHMsex+41aB21Bxe0UnzvPLCw6PhZzirnAyD7UfaZBvk/igcPk=
=5e1c
-----END PGP SIGNATURE-----

--Zqf1JCAeZ2jJLOAM--

