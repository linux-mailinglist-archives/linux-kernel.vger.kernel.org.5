Return-Path: <linux-kernel+bounces-93294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D75872D9D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039731C2288F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C83156C2;
	Wed,  6 Mar 2024 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eyKbW3sW"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125414A8B;
	Wed,  6 Mar 2024 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696727; cv=none; b=ZrYsgc1Q10x3Q8cyvhRpSDlyiVltptlyfTC/L/Etr2z2ti4vx+Lb6RCVp1afc+FesEuUp4fcIjrBtHXM6DvrdaBg4qEy+4drQqLxRpBJceLEdQRu7PDFBJ0KpFy44V+4uphhgmPx5ekRbiE4te8lYLTWICqkatxOIzCvLz9m1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696727; c=relaxed/simple;
	bh=MRQeF+r9E0ErdypEVX+co6eFkFqmpyI+yH4YLoLWwHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rrbYPsXMocPGldvNS7PuTlVERj8FD0xnHQVO/8JX/zrKEOEkzSg7wyaNw8z3mR4UMAiyKE1PnHs6qvwDKKF1uK0g6w/ndHuWcuD6B7DvU7PjnkJ9If/nlujFfNPKggPOnEqldXByjPkWtcY7rR6X76vGrJivX+IBvFhNvdJnBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=eyKbW3sW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709696721;
	bh=w77+CpRW1iA7uMlm12vya08A9v4rIuJOg334ptAVVdE=;
	h=Date:From:To:Cc:Subject:From;
	b=eyKbW3sW/NF/Pbxn05U2FVKoZzqkLgSUKCCoyWYbH5tJBSfW1LAb6y/qgr5U26vZr
	 6mls+f6bKbcIy0WvY+KMaK5zMFZp5lEK4hWUWFuhx78ea7hFgTBurRu8e5yHsOWgQZ
	 aUprI/gYy6i58x8u9O6/KORqaSxgmsPWDGuuxjBRSq+GurTT3l/rlEzqAJFZxeZE99
	 lGClhB9r5Lq+xHOlj6Rtra/vM4eDtcUTSJ+zzgX9rL2WgwTGRnpumYu7zcGZmKByE5
	 07gJwmPQ1rO5dZQf+3C03ewaSMYhXr4o8IxPEXpk1SSS9YRQ/Rgm6PtX1rGVO8ZSb+
	 Bo3EiowEqS+MQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqJH42wWNz4wcC;
	Wed,  6 Mar 2024 14:45:20 +1100 (AEDT)
Date: Wed, 6 Mar 2024 14:45:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Srini Kandagatla <srinivas.kandagatla@linaro.org>, Greg KH
 <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the fastrpc tree
Message-ID: <20240306144518.0afed455@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HRksNEK+KA2q4h1MNd3keNw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/HRksNEK+KA2q4h1MNd3keNw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the char-misc.current tree as a different
commit (but the same patch):

  5169a077f22a ("misc: fastrpc: Pass proper arguments to scm call")

This is commit

  a283d7f179ff ("misc: fastrpc: Pass proper arguments to scm call")

in the char-misc.current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/HRksNEK+KA2q4h1MNd3keNw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXn5s4ACgkQAVBC80lX
0GxyvQgAi05E5/d6KqTJYRlGXvJMJAhDPFp25bCUxKFAzWMjDTKEWPKIHJ3gTyir
Ks7YBy1e4ZVv/teYTEXWs89EdpyuDNuiirXFdRyvu8aOyCd/UzUWNZtvPtKE6jQ2
wzKRRmtlyM/9DaW0QSYWtlK3n58XmN76vNY5W9YEQs1LTH4XkaNX4vLFPKLYbgr7
93Vt0NUwY5NkIbugpP96hr2Pcd/G6O6izXD4nEqpq4ABwYBOxe4yZG8nlz7957y9
lQLk3aHzhBWJb1VrVpLcCHr/WGNKporttGC2646xsIdbYie1OWAPRpXmFOenwVzd
sZ5XHXtt20ZUtM2p1hKU3WrjNwVuLw==
=tX+5
-----END PGP SIGNATURE-----

--Sig_/HRksNEK+KA2q4h1MNd3keNw--

