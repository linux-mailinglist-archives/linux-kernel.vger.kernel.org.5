Return-Path: <linux-kernel+bounces-106680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3AA87F1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC641F22686
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFA459169;
	Mon, 18 Mar 2024 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c7KQe2Yv"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EA226AC7;
	Mon, 18 Mar 2024 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796463; cv=none; b=XSnS9NFuo0AFwhAeBwa68iV3Rim/2GsfJeBt9zvJ/HXvCJcRZdcjW+J6q1LABrRgFIQGnqtgjSSr+8GEl2llmcP78fsO/ZZev62PhZ9oJBI8SqRcDQ20AT6ZaS+I9PMRAUvaU+w4RoFs5UdWCuYDViBMZt3YxVg2FkraG88AoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796463; c=relaxed/simple;
	bh=aJ6CjiZF2hyXHtQozMRnoONYsxKu8VHkBvwiL9mDz1k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=o6gvSVJlWce0gpjTnV+wtgqaajpRjtO1UFLg0cGsh/M79aMvEabOBfnXZR1/koi1/TujBTi5JIUdxusoVuyZTOorXWU16fDADdzkdsGp5NrYwJfjWhLDSUKCDNPNpFYtvl80lTNgviI74Ji6jU/o54fhLrPbJskrK4rxFFsiR5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=c7KQe2Yv; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710796455;
	bh=deHKErowfgRjzg+BZICm3hY4w6A10J4cfRkkakLoAPA=;
	h=Date:From:To:Cc:Subject:From;
	b=c7KQe2YvEOCL6E9r6+p+Qn2T77an8mLLJkDSt4dX1LB/NuAD4ET5zN0/6MpOwhN5j
	 AbNU2UCZKgqzlEtZquF00rww6miOJdmokjTQ+HlXZJ57RBj+lO21d72JB+ikkomX4n
	 Ofhg9FeUh9iMivPCqdXBYE8Ts/QhLXBSWZ1hN/Sbz6/srY4Ttf0x0yD3u761y8PvuG
	 PJnIke4Js7xCN8C0fBeJz/ExbKI56voBP2yi5WZFWoU79EsqjXjMXfyLeCauhaf4lC
	 3TC811ZLdX7gJJrNiLzAoBHmHnUZxHtgURqXQ/vp5pAXOxsYWCHn6sjM3zXxzkeD4U
	 wMLbR28iv/zYA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tz6zp5FTHz4wb0;
	Tue, 19 Mar 2024 08:14:14 +1100 (AEDT)
Date: Tue, 19 Mar 2024 08:14:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20240319081412.750b896d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gt63zEmlVLcvl=VnbfYvrc9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/gt63zEmlVLcvl=VnbfYvrc9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  badc9e33c795 ("net: wan: fsl_qmc_hdlc: Fix module compilation")

Fixes tag

  Fixes: b40f00ecd463 ("net: wan: Add support for QMC HDLC")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: d0f2258e79fd ("net: wan: Add support for QMC HDLC")

--=20
Cheers,
Stephen Rothwell

--Sig_/gt63zEmlVLcvl=VnbfYvrc9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX4rqQACgkQAVBC80lX
0GzSHwf/Xua2r0nzT62DVFbLZHPIkQKpZ7Y2+HoQGVv2y6FlW9gEK4VwVF1QuhxL
ZAjWqcMW4pIUc6t1jdiCEhn8r/l3kkpL9Ps4GebHcGeKCGhl6uQ9B5DzkKZteRnv
0akJDOvIWkJqd8IwW14oIjXdl6bXyDNVW5pP81dkcLgn0kzEAsTxlX6DqUpLfAGT
wV3d6p/0nKumOorY5uPz2vmXo/sLjJT3vh8zYo4Zx1onkCnIXLKjTNQRL8ozrEI2
kdf9vSfu5UZMrQVRKFtDMxMsIpQBqv6QbMJFeD5CytH2MnZLwErXPOGc4XZTKD3z
ok4FUDb5H2vqbILVYtemxfoQ7WuPPw==
=6KH0
-----END PGP SIGNATURE-----

--Sig_/gt63zEmlVLcvl=VnbfYvrc9--

