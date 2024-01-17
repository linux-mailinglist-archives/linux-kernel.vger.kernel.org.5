Return-Path: <linux-kernel+bounces-28469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670182FEE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CA5B24038
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F7E1C13;
	Wed, 17 Jan 2024 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iCvUyiYT"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917FC613C;
	Wed, 17 Jan 2024 02:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705459175; cv=none; b=qXp6q3mynST3hkavdDX50EusPZdZYUDyDVXVpcMTtBFTpQLhpr9hPjlKQlnOCgcvP9Zs06+gMeYmHOTVbqw7KdXCs9R/oS8IF9/GGr6JU8vB79Dz9lbiyZ5uN/xvc6QvsY8pPvleQBH2uLZ5t1ZbGhe6irjW9qpBJqLuiXxkx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705459175; c=relaxed/simple;
	bh=39fOGK68qXnVt0nF/U4NYXUPW5NO+iV9SgDg1z5eAtQ=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type; b=A/VZKJuO81zOxJDXJiUwlWr+QuTkHcX2Or618pqE6wdWM5HaCSPVP6DfTaWWyF960INdsLeK2mKHvPDrDuhN6d+pjOwJjR4dqeMPNpyL8xd1RzUGfWZvs9j4ayT7uG3UbBoXMV7vB/SAg4RyDIzaMHOsDBoZXt5ZTAA2o4EA7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iCvUyiYT; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705459170;
	bh=C6MaZ286cMv4uA8DJZPBGGuLr19lhiPk+7l6nZYDz2s=;
	h=Date:From:To:Cc:Subject:From;
	b=iCvUyiYTqg30vp8oxOOgR3nxi+1nNV45qikGZVtew/x58UArrfcFAHFm7HstSJKyH
	 oHeVvkJyqEDnZaOHA8jX5A9sb19HbHiZQdtImt5nyD9Iba3DABYcgA9pY4Rk2N7bx+
	 YDe94RNywmXcERItb3WJ0dt1u5vCtDNmqW60tEVrwnSooOxwlChvgDVSm4w8HifwHQ
	 sRFQpo8Y976PJwXxqAyCUIg+pcvnHgylD3H1nACp0u48pBpN2GO3ev1uDZDD/8S1RJ
	 MmaY/TGGihj29vHj6NxIuGWvB6eWE2tsIMn4jYUIlUsqoRwUrlHZwEuAAO1+moqlpQ
	 0Z0o4eQ3vJ/LQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TF97k2yPdz4wdD;
	Wed, 17 Jan 2024 13:39:30 +1100 (AEDT)
Date: Wed, 17 Jan 2024 13:39:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20240117133928.0bed3ea8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=zvkJVRy813Rf0D2Xktlpii";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=zvkJVRy813Rf0D2Xktlpii
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/filesystems/index.rst:63: WARNING: toctree contains reference=
 to nonexisting document 'filesystems/ntfs'

Introduced by commit

  9c67092ed339 ("fs: Remove NTFS classic")

--=20
Cheers,
Stephen Rothwell

--Sig_/=zvkJVRy813Rf0D2Xktlpii
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWnPeAACgkQAVBC80lX
0GyjnAf+JbcECos0I083C9tghy3mt0JurPJfmdujm6btT2BrbdtRIsr4hfjwJYkP
fiKq29Ii5sF9+f2D4fcYs9nPRO0WekMyYMNsipcjU5hYTHxVoPdaESdJX5Ww5nwe
hSa8rRTKQudLjBq8cObBvXhb/GuKOzAAX5a37S9DFksblQg0MgenXPlQuMqAYJLQ
sT2ICwlNCdmnfGBG/WLs0U3DKCQ62TslQKU7CO4pzs7AlnznXUsyNCTXCwCjJbv+
ggbaWc7c0sget3kL2VTBwCQj1xwFAV6sGliqj94IkLTEVjecqOAQ132Y94YzczOw
CmzI566cPw+ZfAJZZK64CX3VQz4gHw==
=+Xvj
-----END PGP SIGNATURE-----

--Sig_/=zvkJVRy813Rf0D2Xktlpii--

