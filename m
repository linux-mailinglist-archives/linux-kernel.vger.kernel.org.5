Return-Path: <linux-kernel+bounces-61038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC69850C92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EA91C211CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 01:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D715B3;
	Mon, 12 Feb 2024 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="n1Af6FLm"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D4010E3;
	Mon, 12 Feb 2024 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707701123; cv=none; b=BjG3t+TWz1XIhTmiref34VatfhHIKEy9azyy5bscrVe4urKPBQXE9lbqIKq0EBu7rrSYMV11F236g5k6FLKBuFt02cuI/6foiQTbRCrosuw6oY4Y4gE3BkkWUsCDGVqY0ETjOYMIM01x+LjrVijUmJ0aI5Mgw8YCYFgrlcs7GLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707701123; c=relaxed/simple;
	bh=XWNyd93WGKR8pqpLsqtc9/H4L8OIHtDNT7L+k/zJ0dg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdSa1OQNsBmhgbewo42SiIJ+u+msUI1YfpbCdiXZY+E5TOfvKsfPbnLUuHMj0ZjBk4ZX26+g+NJrxgvT+xwAuGoUCGjT8Ni7Ukn4ihJANwLSFq8w+MjPfTRE6RwPy0ymMMYqaFVdJFUB1B0XDh7AiCbQG6wrDOiAAqGhgM+zBN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=n1Af6FLm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707701116;
	bh=OWesm9ZaPP1Ioi7rhwLGfscD4uWjzx5qKU5sLm4C0BU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n1Af6FLmpP5iUjXjnwQj9zU0gwLvuidHJ1gB2y5cYiGTabr+qRn5yWzmoEO2guwVL
	 HQu3rSc/BIMZsif+RMDGOcE6eE5Ph8U2BsNlBeM+fprVdW/87UzA+xMvG2vCrA+/zH
	 a3ACJLgcrDYW2u+2tLYkjsNQt22QS2Q1ZUxor9vORzI5+dBvVCeEmwOdUpQK9YU1Gy
	 E51+yhMhtCiHK3EqzovlxuSXMJoroFhaCwKXabXlyD6fJL21GOl/8VWd4wXs/oEzNd
	 6cpv0LX1wdCrDQnJQDCU+dJgeKWVeH2S7D230gUJ7pBPO3brtMH2YPp5W7PxS/xfIV
	 kNXFF7L3PSrRg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TY6G32QKhz4wcY;
	Mon, 12 Feb 2024 12:25:15 +1100 (AEDT)
Date: Mon, 12 Feb 2024 12:25:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Somalapuram
 Amaranath <Amaranath.Somalapuram@amd.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Dave Airlie <airlied@redhat.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20240212122513.062a3b35@canb.auug.org.au>
In-Reply-To: <20240206152850.333f620d@canb.auug.org.au>
References: <20240206152850.333f620d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x585PivuSvMebdPb5YpnyzL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/x585PivuSvMebdPb5YpnyzL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 6 Feb 2024 15:28:50 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the drm-misc tree, today's linux-next build (i386 defconfig)
> failed like this:
>=20
> In function 'i915_ttm_placement_from_obj',
>     inlined from 'i915_ttm_get_pages' at drivers/gpu/drm/i915/gem/i915_ge=
m_ttm.c:847:2:
> drivers/gpu/drm/i915/gem/i915_gem_ttm.c:165:18: error: 'places[0].flags' =
is used uninitialized [-Werror=3Duninitialized]
>   165 |         places[0].flags |=3D TTM_PL_FLAG_DESIRED;
>       |         ~~~~~~~~~^~~~~~
> drivers/gpu/drm/i915/gem/i915_gem_ttm.c: In function 'i915_ttm_get_pages':
> drivers/gpu/drm/i915/gem/i915_gem_ttm.c:837:26: note: 'places' declared h=
ere
>   837 |         struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1];
>       |                          ^~~~~~
>=20
> Caused by commit
>=20
>   a78a8da51b36 ("drm/ttm: replace busy placement with flags v6")
>=20
> I applied the following hack for today:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 6 Feb 2024 15:17:54 +1100
> Subject: [PATCH] drm/ttm: initialise places
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i9=
15/gem/i915_gem_ttm.c
> index 80c6cafc8887..34e699e67c25 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -834,7 +834,7 @@ static int __i915_ttm_get_pages(struct drm_i915_gem_o=
bject *obj,
> =20
>  static int i915_ttm_get_pages(struct drm_i915_gem_object *obj)
>  {
> -	struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1];
> +	struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1] =3D {};
>  	struct ttm_placement placement;
> =20
>  	/* restricted by sg_alloc_table */
> --=20
> 2.43.0

I am still applying the above patch :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/x585PivuSvMebdPb5YpnyzL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXJc3kACgkQAVBC80lX
0GzyWQf8DEwy3D9cj8T/rxk2jdAB76rQVtp4C8LU3BXNWH9jjryjtoepjKDPtkcW
txcB8O417p3T5fX/UHxamm0B/rWKYqIzdMWxwUpFb0s1MAIt3BxAGrdlH3TaS9BN
u6OrWNQo/3W7ixjuGT5jJJwuEPnGVGPOSlDRswUPON711II3epDR7zuEX/isqByJ
HjXh2DK8vJR4TFX559KwJfM7i7yhOKaleGks1I1t2+iE4zEInibmaCbXAKVYG4i9
OccXLh2o18szdq6feUSts4BzZAIav+tZp9BdcvM9XGphJZvLMbwwqpy8sZcTrAJl
I8cfLQdibIufuKx9+v6vwhQlySWBsw==
=dfOJ
-----END PGP SIGNATURE-----

--Sig_/x585PivuSvMebdPb5YpnyzL--

