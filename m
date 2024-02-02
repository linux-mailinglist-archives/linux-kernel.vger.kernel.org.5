Return-Path: <linux-kernel+bounces-49171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6FE8466C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D494D28E440
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6744AF9C1;
	Fri,  2 Feb 2024 04:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rMxKknfg"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A15E54E;
	Fri,  2 Feb 2024 04:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846713; cv=none; b=A+xPLVZ8IQTqt5vUolbXkjD5SAl5B7HMwmNk9Ap2dA9si/1gbdWHKCFNezeSfqwBxC+OIk2S/Vim7og4s7/GLD9D20owd2YlL9yTFsvADkUNQTopBi64TTEs1N+wK/2dwZq7DRiiKO9YmSUBunutnvrsl3SXtUdTL9oagnk3M9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846713; c=relaxed/simple;
	bh=Jw1hElvm+csPgqkv8qTrMigYX9yL+XS5VTTdrbpFuLU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YwoRmaR+oAF/c4w+AwKNlTUDtSwty/eRAV4sEBYbqOMduPglHCZCFIrA0UFk0nGvs5lTBMIBxEONk/tovwOm7LMKEQXC6ilSUOqil9KMtrSz7SwuAxM8C1LucMrQiOLLz2E5+n/2Qc+qghQSfm5DU8gG6+cloPZlq50jvBZx1Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rMxKknfg; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706846709;
	bh=ZrGmotBDevwYVbTrda2vy1NJOx3UexgQB5LZDDxTWoU=;
	h=Date:From:To:Cc:Subject:From;
	b=rMxKknfgJ0mfu2KViCf4zR9TxlWm9rI6Xm48vVHXDG5BrMeW0d/lqsSddj3eBgqxd
	 JqSPCSJTfpSJu9YeyV/kVLgzjiAJ8lV3XN7SMUCf4kk2ZFF91XIpwATFxfotqB6FTQ
	 T5gXMO2YrpuPJQ8HKQtpOZD4wuG7ApJhzNi9Hmq/VX5hRIBFoBeCdVgTuwTsaelTtP
	 C0ytQXBj+TB57BV98PWev0AfKfOF4yAxERaxKD4d6WADP0wXTz66AKBaU7n55FWLWN
	 +dfOoec6RjF9+tddiuAfGVuUUsWsFJj7axsj8gHLYdPNpan6ex41+W7RT0O6UHFSGM
	 H2lpcx30Ud5uQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TR2H81XWHz4wcT;
	Fri,  2 Feb 2024 15:05:08 +1100 (AEDT)
Date: Fri, 2 Feb 2024 15:05:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
 Thierry Reding <treding@nvidia.com>, Arnd Bergmann <arnd@arndb.de>
Cc: ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the tegra tree
Message-ID: <20240202150507.468210de@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P_ee485e5U85eUMusTPx26g";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/P_ee485e5U85eUMusTPx26g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in arm-soc-fixes tree as a different commit
(but the same patch):

  d820100a1bde ("soc/tegra: Fix build failure on Tegra241")

this is commit

  1b5af823d703 ("soc/tegra: fix build failure on Tegra241")

in the arm-soc-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/P_ee485e5U85eUMusTPx26g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW8afMACgkQAVBC80lX
0GxMbwf/RbMTdgGODjlwdEX8THaIcagBVb+Ys1xwEtMZNC3UT8izhQtVRCsNRjX+
MlrtulWuj9lRs2LC4k1SVcp2nGsRnQQD0Jurk2Jl3wBmqvi8LS4ZRUvXTHCkKQTQ
zk6vwsWnjVRHUUFjcjm9Xxq5OdCcwuBqEuWEkDxNvdtjGJHxXGqjKwC1EdkNnHW2
e/7GYei/pv/ZTkRc84YHRiOtE61IPFqF6WmwqbFjQyn2GuvFw1LbPdTwsPivmcq9
CLpMT99oLDiPTPw0zoczC2cbzJkOpP8OUrz3GdVnPuGWQyLZKHzYiB3UefiPxL2N
vxmYYSEaNJMMfSWZLwFNbnsDc2yEfA==
=MeHy
-----END PGP SIGNATURE-----

--Sig_/P_ee485e5U85eUMusTPx26g--

