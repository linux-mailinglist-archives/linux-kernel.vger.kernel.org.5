Return-Path: <linux-kernel+bounces-72027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4621885ADFE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FCC28421B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429B054747;
	Mon, 19 Feb 2024 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dmLlFUJv"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A7482FC;
	Mon, 19 Feb 2024 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379308; cv=none; b=EO2UVaySt6yYGgrnuyrjq7QdpFACg76ND63qoOveITS3aNF6SIoPjbvMBs1/9xobHitHgMslGJDGR6eVq22wJJb9h7AvvmLsasgYL4+ogvHZMyBf/qttXZsl7vs2Z1J37o0+QE02iXyzDdLmJkS/xeXgvpOJtxlny0FuBuERZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379308; c=relaxed/simple;
	bh=vAB5VsnnjEPxmSYsOYyoReF62USVkDS9DPv2IdkJhzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMA0bQfDHaJIjgWzym1EebXar2jgGcoNJ/87vJZQ6xt6bxWBwI/6s3ekx0BQvlbWNubH2yD1a336Q9ss4NKDbNKl6NC7gCdlLkJLfUrZ57Pt86T2PlD/ZRDXFLhrl/r5EK+5FZXQwXiv0g1UY4JiOd0WO6z/3Xly1FZb8ywy9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dmLlFUJv; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708379304;
	bh=Fp96IBGwOeEO39qKTkido7SbIk7muGQo94mYxjk0sLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dmLlFUJvosK3KwRL5nQbTR2LWuNIjy8ow3fdmDLbPsjFeNnDg0gEcpLFXNgITSK1w
	 FFJwiH6v/Amg/Ss5RmE93dqrf1VhsGjueK4Jzh4CC4L8RzwK8j1zB5nJyOgQyTuZBm
	 wWOLIHk6qCHd4PzHW81WTiMeYFYIMpUKw5E+o4owUtJqEMZcvg38gAWOYU74XXCIzU
	 OuHbx4+hJTTpO1XSWtB6IYvYCkH8PQHZjzx8JOIr7RHtXHxnVujtYSTlb2ajoiLmiQ
	 p9B9GeksJBOTENa9lGUul/CiXWsT93qx3C/M38g02tmOx5+1GKDdTDSaxgIa1IKyUk
	 DyQv1w0R7/LHg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tdx472cdKz4wbr;
	Tue, 20 Feb 2024 08:48:22 +1100 (AEDT)
Date: Tue, 20 Feb 2024 08:48:21 +1100
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
 <tvrtko.ursulin@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20240220084821.1c852736@canb.auug.org.au>
In-Reply-To: <87y1bp962d.fsf@intel.com>
References: <20240206152850.333f620d@canb.auug.org.au>
	<87y1bp962d.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=hETOlCBc/Rva5F/B2qRy/p";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=hETOlCBc/Rva5F/B2qRy/p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 12 Feb 2024 15:15:54 +0200 Jani Nikula <jani.nikula@linux.intel.com=
> wrote:
>
> On Tue, 06 Feb 2024, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the drm-misc tree, today's linux-next build (i386 defconf=
ig)
> > failed like this:
> >
> > In function 'i915_ttm_placement_from_obj',
> >     inlined from 'i915_ttm_get_pages' at drivers/gpu/drm/i915/gem/i915_=
gem_ttm.c:847:2:
> > drivers/gpu/drm/i915/gem/i915_gem_ttm.c:165:18: error: 'places[0].flags=
' is used uninitialized [-Werror=3Duninitialized]
> >   165 |         places[0].flags |=3D TTM_PL_FLAG_DESIRED;
> >       |         ~~~~~~~~~^~~~~~
> > drivers/gpu/drm/i915/gem/i915_gem_ttm.c: In function 'i915_ttm_get_page=
s':
> > drivers/gpu/drm/i915/gem/i915_gem_ttm.c:837:26: note: 'places' declared=
 here
> >   837 |         struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1];
> >       |                          ^~~~~~
> >
> > Caused by commit
> >
> >   a78a8da51b36 ("drm/ttm: replace busy placement with flags v6") =20
>=20
> Cc: more people.
>=20
> >
> > I applied the following hack for today:
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 6 Feb 2024 15:17:54 +1100
> > Subject: [PATCH] drm/ttm: initialise places
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/=
i915/gem/i915_gem_ttm.c
> > index 80c6cafc8887..34e699e67c25 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > @@ -834,7 +834,7 @@ static int __i915_ttm_get_pages(struct drm_i915_gem=
_object *obj,
> > =20
> >  static int i915_ttm_get_pages(struct drm_i915_gem_object *obj)
> >  {
> > -	struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1];
> > +	struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1] =3D {};
> >  	struct ttm_placement placement;
> > =20
> >  	/* restricted by sg_alloc_table */
> > --=20
> > 2.43.0 =20

I am still applying the above patch ...

--=20
Cheers,
Stephen Rothwell

--Sig_/=hETOlCBc/Rva5F/B2qRy/p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXTzKUACgkQAVBC80lX
0GyGDAf9E+BqXJzdj/6Ki83zdwo+fd5+lVvR7hn5dyAE2Z8Fq84gvByR8sifzSA+
1Yqkz1+WPRw29iZbSfsBrw8gQ6hnqe3BtfQ/0PmO3Dr3JOQVZIQw4w6JhdvkRtD2
7meCBF6e0xtIz7UFFcRj2dJEei7nT/s+2jXOyWeEk9Q7QNqx3cZvnIJnW9J9x9wD
dY2ynhbBLS2K+aac2WNDEEY3Q31EhaTC7W34HGslne/hkQac8VfEJ63YasZ23ZBm
kYJphpLjhmlG2JS96gPjOcnb22HLQWyyu8GsnAETTTW/fGssUxBAC0fSryLA1PD+
vuSxAjM3Cmn+KC2wk++mL27uAIcvwg==
=M1WM
-----END PGP SIGNATURE-----

--Sig_/=hETOlCBc/Rva5F/B2qRy/p--

