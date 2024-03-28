Return-Path: <linux-kernel+bounces-122407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE3188F68B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A814B2940AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2AE3FBB6;
	Thu, 28 Mar 2024 04:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j2OGHpcP"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7FD20DF7;
	Thu, 28 Mar 2024 04:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601073; cv=none; b=kD9qjyoySYYcc3vpIBw0LcKMzOkO/i26N+rs/rRs9msFbQnOYrfqT9QVrID+oOeLcdixajYSvg6+R6eB4sDJ61u+nUq0Jvy0/4K+RbUlBAZLkE6orQkCTuDaoExWDBvkRaN35z5st3l9F+g0zdTLoC21RGlE0j0zfnhXbJMcSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601073; c=relaxed/simple;
	bh=73mQ4DIK7jO7eY6z8AHtGLh7jz4rlxCQD0iafq2CEkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igyVXWkTLaR8Nx+wXsAUJia3PIbSndGIa7LOcSwgqhUoyX5jWZB3n57y5vQZQbdfYnNNmT6t8GHBSzjPjeKwTYbTUpcC6J2QBQzKmDAFHIvwQ+QvonYBwflDr5Skcj9LldGAcjdVQ4a9PZEmL3VVvO0BYRFfIJEqc1NKv3Srunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=j2OGHpcP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711601068;
	bh=73mQ4DIK7jO7eY6z8AHtGLh7jz4rlxCQD0iafq2CEkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j2OGHpcPo4OMEFfNk0IRKqZp10g7pYZB/itYg9qfO0ajed61IoK+AHj1P1tcFYDMu
	 PefC45pTqOHNeSC7XnzgL1peNc/qxZvF9pJMmDRAXEYTi04JUFSP5YhFvYKhA74qps
	 AePbZjBZXpY0cCFvbWQrDSnXN/o3lE8tv3V7iAKRvnkTZPz4I+24gSqVwic3e9YknQ
	 KZNgo7e2kEcEvno4ug55OhktiozLVl06A1rWjxvjodQCksSdb9g4HKMvx6TQfkjP3Z
	 fRrT1waBJuCrFa2A4tXeu9xvIGGEjIywBOiAVc2/yWeN5vwC1Nxj9murD1QhXiXrJX
	 EndcnEBpoRScA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V4rY83w9Vz4wbv;
	Thu, 28 Mar 2024 15:44:28 +1100 (AEDT)
Date: Thu, 28 Mar 2024 15:44:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew
 Morton <akpm@linux-foundation.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the mm tree
Message-ID: <20240328154427.3e926d21@canb.auug.org.au>
In-Reply-To: <20240328153947.3871cfdf@canb.auug.org.au>
References: <20240325123603.1bdd6588@canb.auug.org.au>
	<CAJuCfpH4Ee00hM9+B7=mi5Dwjrhov8vUK-KwPuoO3wsD7iJSAQ@mail.gmail.com>
	<5e1321ca-0d46-4e9d-a6e5-0560d99f65ff@infradead.org>
	<CAJuCfpFTOz8cNiJFiCU5tMM1u5L=wXRsXqxUhN9g-R0u77CyZw@mail.gmail.com>
	<20240328153947.3871cfdf@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f09pjWL5E=u7CMHFiGcd3P3";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/f09pjWL5E=u7CMHFiGcd3P3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 28 Mar 2024 15:39:47 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 25 Mar 2024 23:16:55 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
> >
> > Thanks! I'll change back all the instances in the documentation where
> > we replaced original names with _noprof versions. =20
>=20
> I now have the following:

Sorry, some of those are not relevant here, just the _noprof stuff.

--=20
Cheers,
Stephen Rothwell

--Sig_/f09pjWL5E=u7CMHFiGcd3P3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYE9asACgkQAVBC80lX
0GxZkwf/R000FNdurcR7mhJvrzsJNDKvw07jyl5+aIU379g5mUchSg2VAv01KmWQ
8QkperFGvZdpr2OA3Z/lv/QvbGEl4MxTlxxU5IEVieKiAlB1Y7qG9xsx3TQAaOvy
kXLUhcJ4dn1NB/jO8iYdyMNNq5uOViHm0yekEIg5+Xh5RW/ZlZe+hYX5chpy8wWy
0vDvlHstdB+4nOMthvGwlrmUbfBbGlSMPQIXYFILVqWWWG4iMlZdKlkii0I4my9K
Q5sGKHJdSa6xlu1aAVw44rruFGLKoaYI0PkBJw6A3lIkBGnzVJFbnhviL5QpKDan
jgUS8sLugQ+JKwjPkwwUU9vhHabl4w==
=9TJl
-----END PGP SIGNATURE-----

--Sig_/f09pjWL5E=u7CMHFiGcd3P3--

