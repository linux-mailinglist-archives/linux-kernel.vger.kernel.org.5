Return-Path: <linux-kernel+bounces-142104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3887D8A2792
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B382848E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E652502A1;
	Fri, 12 Apr 2024 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Cky2k1nJ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039A5025E;
	Fri, 12 Apr 2024 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905322; cv=none; b=W9CLlSZrtF7IRE5FN3gCfZwXqR/cD0Y5Ysu9qcLDiJ4TPl2arESydaQ9sfJI22jP0byZvQ/y2w1JNWiHc1fdbU8bELWTtGtYxYMBEUqaxLg3DcAt+NBVlT22OP+r8QIEgJuAvZm2kUUYtDXfU9O6dH8NQq568nWjEFsIlBnpBsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905322; c=relaxed/simple;
	bh=4jRWhYC+ZsPWZd0ZNl9ZX4H9dxNs26/+BV6UxpdGhHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/QT6tdvBacoL5tlNB6tkgcs7BLuqZ/ClgTMJEpll6KR6sa9dQI/rlCVzfmRcCjaQFrwyi6oSn14p0TJuL4NQssa0qVfFe+oQgeqnkw3gFAP6ahS0TCmx2dPeOFOkXhwXNoR5+wmx3Yz6dctcAmOQ+wuOIorqmbDeBq4VGgyMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Cky2k1nJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712905315;
	bh=pYSrHJvNgoVbRhpyGhtctqI/U6N/vPxCG9W1zrAdPg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cky2k1nJG7sWLhsaz/5xb30D7729X7iVhFzGz/OWRZNTYTnYqbmdwzqSpoMLCojJf
	 VepfwQyF/KkoOG2DODiXeU1vvyRSC2DHEqWi1RF2PWUmZkyTXdJLX7jguqT7k2HTUJ
	 szWcUafakWku3cdLtJw0j5/d2NQwjkFUi8MvAva6L3hhVssJrDRM31sw9MjN7AU2Sz
	 WbLUJq6MZSClDho1Nw2rK2jiAxHy2t35fuK+Oio6/Vgo4K+h4Dk4ms+asGr9aQ6/3R
	 6habeUemN0ntsIlukOno3t6u2OqYRdTbCxj1aePVpQ75055SOXPuhhSG8GiEgvUCl9
	 UjmPo0j5r3zqQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VG6tq27nrz4wd7;
	Fri, 12 Apr 2024 17:01:55 +1000 (AEST)
Date: Fri, 12 Apr 2024 17:01:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Intel
 Graphics <intel-gfx@lists.freedesktop.org>, DRI
 <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20240412170154.36b0cecf@canb.auug.org.au>
In-Reply-To: <20240412165826.18e8a5f4@canb.auug.org.au>
References: <20240412165826.18e8a5f4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6858CJVZE8hKI9vvrk+z28K";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/6858CJVZE8hKI9vvrk+z28K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 12 Apr 2024 16:58:26 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the drm-misc tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> drivers/gpu/drm/drm_plane.c:1767: warning: expecting prototype for drm_pl=
ane_add_size_hint_property(). Prototype was for drm_plane_add_size_hints_pr=
operty() instead

also

include/drm/drm_mode_config.h:963: warning: Function parameter or struct me=
mber 'size_hints_property' not described in 'drm_mode_config'
\include/drm/drm_mode_config.h:963: warning: Excess struct member 'size_hin=
ts_propertty' description in 'drm_mode_config'

> Introduced by commit
>=20
>   9677547d8362 ("drm: Introduce plane SIZE_HINTS property")

--=20
Cheers,
Stephen Rothwell

--Sig_/6858CJVZE8hKI9vvrk+z28K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYY3GIACgkQAVBC80lX
0GypQwf/TJCngMi4gCVfDSODVrEABJ9kii8AH2B9sS1cRQTWOM5kLbUP2y++PkK6
RH9hssiG6eC4IG9uCniYr+r9IxJpVqTNF0LLEoMsRAyQr6xeHkOGZTTBcf5NGXfp
Hj2uyRCsgaRBaDjXLTPsvTPQiT+4QaQtl5phogyBxXi2EdPPSDTZ8UtPEMeIwuRQ
MJvb7Gd/EBLQogc/CzEI4nsX7NgRO/ej0ktGvUlGl7xlRWrTP4AJQhugOnyNrHdd
0V+YLB9/SKdIK63A+g5B79Bv6NT/kZdbhzk9APThGRPnMBk6RJ2IV6MbK1gWeHMA
nDUMzfg5tNdsM6QKWZlu8MR8QMJ81w==
=1Aab
-----END PGP SIGNATURE-----

--Sig_/6858CJVZE8hKI9vvrk+z28K--

