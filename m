Return-Path: <linux-kernel+bounces-77714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AFA86095D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003A91F25883
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E539910A25;
	Fri, 23 Feb 2024 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fFDPhNdW"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C67D26D;
	Fri, 23 Feb 2024 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658754; cv=none; b=sEZ0Taf6XpwMjIpgBFf2KC7VGAK9Y4Re/4+wE23VDPohzz4IHMWomfcThu21liqS08k3c+3hvkCxpSO4Xel43RndIYSUuvfE47vYKsdxSXGYJuiIjM/qcvK4EWm1QU5Y5pguN2zaXJTlCl/H86150j8MaSFAi0iUG/vBhgOB328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658754; c=relaxed/simple;
	bh=n4qpbgJ8v7GPZVfT9Z7r1oiTnMQmcWKFfKrBz37hriw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=F4of1I/noMGxTIKvSuMbKUtn987gdGMpXsxloeSr4agKwFVSzK6oVPLRoPI1fBR6pAUcR3iDX8wlFgWiliTAU70NJlhksXRZrZI23nfOhC0q7SeveC7sFDgKt9KlnAm/+fS8+hxgK65fjEI1pINKidr8S0P2fK0zi5l0KH3/XJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=fFDPhNdW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708658748;
	bh=VPIjp5+R9X3jqT9MsfV+RShmi4vdvyr2GGYCyeKsN/Y=;
	h=Date:From:To:Cc:Subject:From;
	b=fFDPhNdWyCg9kOgSngASEqst2YWGbQ5tJVIS6DOkHo9srR0Gw4lpmss5U2VWXfIbM
	 GC3zWyxWtmdfeDZhsnlNqhR5LDQHsiLPZJ9jtLDWcVLQ6DLvQENOfKxqgn9EuQ2ATD
	 uhWqWryMxKN3q6JoCtDGNQe1bxD3jNEWQvQVpfEjVuWnGLNsCmS1XELDCi3CML7ZyS
	 UyaTB1YVOOLrX0qmKMAgHz2bF3Dr783JGS3J/i0cUcxeEp4aPWYBvsgmtsEucSCtDa
	 k/48DJU3EYewv/8wolG491vcdNx8kC4U/UEd0yjXQZtc9fgFWF9X45+rSB6x1zZED0
	 8y86I9XlxsyXw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgwQ36p7gz4wcb;
	Fri, 23 Feb 2024 14:25:47 +1100 (AEDT)
Date: Fri, 23 Feb 2024 14:25:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael S. Tsirkin" <mst@redhat.com>, Herbert Xu
 <herbert@gondor.apana.org.au>
Cc: Linux Crypto List <linux-crypto@vger.kernel.org>, Li RongQing
 <lirongqing@baidu.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the vhost tree
Message-ID: <20240223142546.073f7c21@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PHhm.IMMHBE0tJ_.+tM7ruv";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/PHhm.IMMHBE0tJ_.+tM7ruv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the crypto tree as a different commit
(but the same patch):

  2374ca8f6556 ("virtio_crypto: remove duplicate check if queue is broken")

This is commit

  633eeefab69e ("crypto: virtio - remove duplicate check if queue is broken=
")

in the crypto tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/PHhm.IMMHBE0tJ_.+tM7ruv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXYEDoACgkQAVBC80lX
0GxKpwf/R0i3r/NTejhG1yI3fIJFZcWxrZbWmh5zYcpAvkAyVpND6guw1wj/47zy
3FkCHMTEAJN4QPIRtumR1WNLvWTnLjnS2uBPpcD4lMMoZOqV3Zh7m0Q/NJhVHPOZ
Yt/sbP3JqNIQtTBOG0sARzRb6uAfaopif5DvisjTaMjSxcO8AZ6tYZ1YVjVLAG9N
/jJtKtFgTLSGO1gazKPVe9OlmaJN9nov6dC9ErpqkMUmRMONDltIjbcEPO7R7K+j
XRyPbQ76ik/3OWMhnjFGI0lNclWV8704ZfT0brMDKfM6RBMgs0zYyG+JZCp3/LZf
7xRC/07yhGE78uDxwoTjhSh1NmUn1Q==
=PhEO
-----END PGP SIGNATURE-----

--Sig_/PHhm.IMMHBE0tJ_.+tM7ruv--

