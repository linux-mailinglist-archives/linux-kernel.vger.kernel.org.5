Return-Path: <linux-kernel+bounces-80314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DBE862D44
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482171C210ED
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C191B962;
	Sun, 25 Feb 2024 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KwdD9WNJ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1E1B94A;
	Sun, 25 Feb 2024 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708897669; cv=none; b=UQqZ/1jZE/Vnao49ctWahUoNGo4Mzaa1MBYoUpnHzB+hxw5fBjOfYCsLWFqzVbr/JbGOe9xDLiwGqF4Koa4YqAtOenX4fiZTqIySkOOcqF+OgLFSh4Wh/OT5sQyNl8KDFPVxyCSCWLJm4vPPSM03Fw43lb7ZdLVd7OzzI4FkfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708897669; c=relaxed/simple;
	bh=JP4NsIvDbGhRWWxqB6q6r/vi6fOSilaEEyZQG7O4lgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyrzvzJxuAkAHYxRO/GYtMDBMYECvTObIm06b85UwRG/x8Ae0QbhfkYDNiQIJ8UYHfXvnLjxwvs0L62jYj1kpVR0bC+MnpURoG3QERv6/gbV/WJI8DfgUax8WyFkKg4iB0zSLi5+t54Gyem1EViZheEEMfMC1iYvp/CdYx7oXTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=KwdD9WNJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708897664;
	bh=kG33ZY0/UWOYVDzZWbOuw9NG206A2AP7X8xzTctJyuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KwdD9WNJ1M9R+g5WPu7Xhw8tZl10ZH2BLunDqsLB4bAamsVSPfNzybSRIYx5yjzT/
	 nNf0CgNiGUr4wMh64HRlZVuBI9FnfpbWXWvd7cBCrF9sJUryCXNxPudY13cKpjv6La
	 ZdFb/lZ39SG2V2Y3X64sUyISfQGpvpPw52/174pLRKci/9RXq3uiqp3TDQlDEYumSM
	 NQtbunGnLam2oaXc4MEg8BM+OpmtuxElLjMeEwVSTSYpnCFR9DBpVIU6bGkA6as9G2
	 BF1LwoN1+Y490ayeJdcz2tdpSlOkKe/j4aUYdukcIjMfnwmbGRrT1Byjq3RhhRIpwk
	 XUcoXpf7a9h+A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TjcmZ648Cz4wc5;
	Mon, 26 Feb 2024 08:47:41 +1100 (AEDT)
Date: Mon, 26 Feb 2024 08:47:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Somalapuram Amaranath
 <Amaranath.Somalapuram@amd.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, zack.rusin@broadcom.com,
 tzimmermann@suse.de, thomas.hellstrom@linux.intel.com, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tvrtko.ursulin@linux.intel.com>, Dave Airlie <airlied@redhat.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20240226084741.2df4d18b@canb.auug.org.au>
In-Reply-To: <20240226084116.4a41527d@canb.auug.org.au>
References: <20240206152850.333f620d@canb.auug.org.au>
	<87y1bp962d.fsf@intel.com>
	<20240220084821.1c852736@canb.auug.org.au>
	<20240226084116.4a41527d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n7ZvyFsp=O0fEulTsTdptU8";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/n7ZvyFsp=O0fEulTsTdptU8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 26 Feb 2024 08:41:16 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> On Tue, 20 Feb 2024 08:48:21 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >=20
> > On Mon, 12 Feb 2024 15:15:54 +0200 Jani Nikula <jani.nikula@linux.intel=
com> wrote: =20
> > >
> > > On Tue, 06 Feb 2024, Stephen Rothwell <sfr@canb.auug.org.au> wrote:  =
 =20
> > > >
> > > > After merging the drm-misc tree, today's linux-next build (i386 def=
config)
> > > > failed like this:
> > > >
> > > > In function 'i915_ttm_placement_from_obj',
> > > >     inlined from 'i915_ttm_get_pages' at drivers/gpu/drm/i915/gem/i=
915_gem_ttm.c:847:2:
> > > > drivers/gpu/drm/i915/gem/i915_gem_ttm.c:165:18: error: 'places[0].f=
lags' is used uninitialized [-Werror=3Duninitialized]
> > > >   165 |         places[0].flags |=3D TTM_PL_FLAG_DESIRED;
> > > >       |         ~~~~~~~~~^~~~~~
> > > > drivers/gpu/drm/i915/gem/i915_gem_ttm.c: In function 'i915_ttm_get_=
pages':
> > > > drivers/gpu/drm/i915/gem/i915_gem_ttm.c:837:26: note: 'places' decl=
ared here
> > > >   837 |         struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1=
];
> > > >       |                          ^~~~~~
> > > >
> > > > Caused by commit
> > > >
> > > >   a78a8da51b36 ("drm/ttm: replace busy placement with flags v6")   =
  =20
> > >=20
> > > Cc: more people.
> > >    =20
> > > >
> > > > I applied the following hack for today:
> > > >
> > > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Date: Tue, 6 Feb 2024 15:17:54 +1100
> > > > Subject: [PATCH] drm/ttm: initialise places
> > > >
> > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > ---
> > > >  drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/=
drm/i915/gem/i915_gem_ttm.c
> > > > index 80c6cafc8887..34e699e67c25 100644
> > > > --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > > > +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > > > @@ -834,7 +834,7 @@ static int __i915_ttm_get_pages(struct drm_i915=
_gem_object *obj,
> > > > =20
> > > >  static int i915_ttm_get_pages(struct drm_i915_gem_object *obj)
> > > >  {
> > > > -	struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1];
> > > > +	struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1] =3D {};
> > > >  	struct ttm_placement placement;
> > > > =20
> > > >  	/* restricted by sg_alloc_table */
> > > > --=20
> > > > 2.43.0     =20
> >=20
> > I am still applying the above patch ... =20
>=20
> Any progress?

And this commit is now in the drm tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/n7ZvyFsp=O0fEulTsTdptU8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXbtX0ACgkQAVBC80lX
0GygNgf9H+xHrJzxrhPsN5jPvw3E886g2FDQdt22OPGdPB0HwaIeneEVCDJ5ecy7
OqSpKH+q8PbYG37DZ1S82jSe3G2P/8ayDPN4FuCwMo9XLmXQCLvPj8jfeOVl6YEm
bs+zSTk+KsiVV27S4uGDz4eLQCTVrnuOzo2rVABD36SiAaQwKwLm7vdzSHdCH87Y
TLB62Y06c0/jEqNd1nFGlACHKoYXwDiuJp3cHWt4b6QeweDVpeTXBg/AkMu/eawI
7Vlajvaz8Jq4RnFg2Uv+eK8tt8WX5rzu3TX6VTkJP+uQUaD8+x2f6V0tIFaXDvi3
ZM37PNXd3eQ211toT+grcnXf93S/ow==
=l2pY
-----END PGP SIGNATURE-----

--Sig_/n7ZvyFsp=O0fEulTsTdptU8--

