Return-Path: <linux-kernel+bounces-99818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908CB878DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F412823F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC712C2E3;
	Tue, 12 Mar 2024 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vCzNUmYl"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207117462;
	Tue, 12 Mar 2024 04:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710217867; cv=none; b=q/8UrsteJsAjfkYBq31CWRTugbn2Kc1t3z1bYOj7Pg251orB1+pr30t3UqbVg/auR24nxoJ7MwFpAw7ixRMl1hdwKngPtirmQw2bltS8eVCLtlomFZvBDNZ3h5RocJNyRo2GpLEsF2tsh0N9pSif8+vF3bQoWjPiRcc1Uof6MBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710217867; c=relaxed/simple;
	bh=UcoVuVXIvJNMYpRj2dxEDV0HJoxnJrVc39BSSg07IpU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FyZGza4RvXyYgHVcHY1kqzLsQhOE0Sv1yNlHcPF3hs43pAvITTDsrLYeQB3apU/ka4VWad4D6a77MeiS35zUhWEJ4AZQ0fTvgrtrKkAN9Lys8DkKLY/0tXpY1BCitwYrcKQxbuWENQmIf6i+uZENshwG+2AvppY9RhLs22bsYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=vCzNUmYl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710217862;
	bh=PYxa1gcg/P1IMNpKblcjvzUUqPcYHk7yF3FHukIGJ0c=;
	h=Date:From:To:Cc:Subject:From;
	b=vCzNUmYlqKfV5hAGeWy3ca9qTOzEvX0+I0GnVsZY169zZSTqonN2/rtoOj6rBtYuF
	 6cPAFVkuIqFV5zDg94Uc98qW4B68aiC9g/gbH+wS3K9J+9rEfgmLROroRMVtwU5a3K
	 rn7C3uSbY6YwKIylOA0fhyTKYBeIXWo5tjulSsjZ1KleCV7JjO0BUi1GbBMMpu0rqX
	 236oSUuIER5pEShqCK6GJOTsHUF6ArghaY1xP/jt2bN84Ke8OnC/3LfH/s5fNMCkJz
	 31S3Nzoj3BEHJEgVZLeAGXBhptPaLarGQzrO9qbfr1csf1kWNb29LSyQFz4od4xNbb
	 lP/U7JtS3MYpg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tv1110mcyz4wb2;
	Tue, 12 Mar 2024 15:31:00 +1100 (AEDT)
Date: Tue, 12 Mar 2024 15:30:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Herve Codina
 <herve.codina@bootlin.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20240312153059.3ffde1b7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7i5b5TOny_nD7GXG9_orHsY";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/7i5b5TOny_nD7GXG9_orHsY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/core-api/kernel-api:90: include/linux/bitmap.h:524: ERROR: Un=
expected indentation.
Documentation/core-api/kernel-api:90: include/linux/bitmap.h:524: CRITICAL:=
 Unexpected section title or transition.

||||||
WARNING: kernel-doc 'scripts/kernel-doc -rst -enable-lineno -sphinx-version=
 7.2.6 -internal include/linux/bitmap.h' processing failed with: Documentat=
ion/core-api/kernel-api:90: include/linux/bitmap.h:524: (SEVERE/4) Unexpect=
ed section title or transition.

||||||

Introduced by commit

  de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather()=
 helpers")

--=20
Cheers,
Stephen Rothwell

--Sig_/7i5b5TOny_nD7GXG9_orHsY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXv2oMACgkQAVBC80lX
0GxVaggAlY2t8o+n1kGdKRCEnxNLyRQq/51McVdfevk45GlfWh+xHl7ojzS6sI06
dJcN+5y9t0fz2ZZycTdJvxLYeVNtMvfPcAdp/LvYJPR9PO+IMPNQunPSiPqMlRII
Z9PEG5Xkc7nDX65V9CYxerS1Ck7U4SBkSFka+b2P02IiSG8rWghyUXK4GWXeDYRL
q7bVq70rma//bJbK1CDc+vz4ZRvSKYDD0nSc7vbXZUqRWK2c7RleXR5v2Pb6QQ/y
yDveExbJoCySbgKRWzGDTuExnh2iUHiA3iELjF+oXaWBVIt1441DHj7/CnSAQPtX
Mgo9SbEv+sNAqWFHmHIZzFYWH4nRKQ==
=IVq9
-----END PGP SIGNATURE-----

--Sig_/7i5b5TOny_nD7GXG9_orHsY--

