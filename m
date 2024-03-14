Return-Path: <linux-kernel+bounces-103791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BB87C495
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3196CB21977
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEC376415;
	Thu, 14 Mar 2024 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dvC9ezMZ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C5C5C61C;
	Thu, 14 Mar 2024 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710450608; cv=none; b=Pdl3UGymHGyM0Cedi4+6eIiQFqln0BPGjiUqsQ4egRaa6zJJnf+n8nb+wkoHXKsxOJPsGw5kBSoEPl790mmYDiHd5g0twc6UOOtKwEhvh+OvYF31KUj/M7M5TBKIw+8Pn23cF4u2GC7PjVe7r6TlKKmKiKlx47cO10tHd3ZROgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710450608; c=relaxed/simple;
	bh=8fWjrNl2NSWIClahF6H6EgIMMLTAdQDJP7CTqWJwurQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bPizhUx5PMy3BHncmydpGNt9S+8QXk4xud/r+9cZahDLpckH2YXcjfXhVWa9UxYYc1rPf3W1Jb+3ZZ7sUnGldpC2xrS15RzRINENvw+r4cLRRMYNbKqwRR6ilGDEh6gg8KqPzBej43TuIjsXPB7k+nQmVFSjcocC+EtPN+B5BxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dvC9ezMZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710450601;
	bh=N9GCqKPzjCdK7cE8z+1aAkwTStKPynhCp5hmSKQPXEs=;
	h=Date:From:To:Cc:Subject:From;
	b=dvC9ezMZgScOkgBlgPgLJRRThnJnsB39p1aCbMeMHPeiEm9ODqjuSprU3/5HA33A9
	 WKgrS3vLdu5Sk8/z7+HorJ7U0WBGe75PGC0p6XqONt8eTqzOnBwk63LQzmHxwoPSnh
	 7GzjRlTl4SzJQrU2j1+NbeL6WjkACmH5JTkXaj3EDYzNfOH8AavL8D9yknAZcq4HvN
	 2YrTbDewAP8GwNSl+i7210bv1oX8jv5Npgwn9OkYHhIbADbkmgWz6nSbsKy0e4nzlB
	 d6RPwae8x/r/EkqbWmKW70I01sCfU9IOqOfPsbFcvNfwdvaChpIINQA8kmLJPEIpQB
	 25qFTu7/CUNZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Twg4m5GjYz4wd7;
	Fri, 15 Mar 2024 08:10:00 +1100 (AEDT)
Date: Fri, 15 Mar 2024 08:09:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20240315080958.42ad2d91@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XaP+1XpV+o_QmWQR3DRpFQW";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/XaP+1XpV+o_QmWQR3DRpFQW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4ce937160ba0 ("irqchip/riscv-intc: Fix use of AIA interrupts 32-63 on ris=
cv32")

Fixes tags

  Fixes: bb7921cdea12 ("irqchip/riscv-intc: Add support for RISC-V AIA")
  Fixes: e6bd9b966dc8 ("irqchip/riscv-intc: Fix low-level interrupt handler=
 setup for AIA")

have this problem:

  - Target SHA1s do not exist

Maybe you meant

Fixes: 3c46fc5b5507 ("irqchip/riscv-intc: Add support for RISC-V AIA")
Fixes: 678c607ecf8a ("irqchip/riscv-intc: Fix low-level interrupt handler s=
etup for AIA")

--=20
Cheers,
Stephen Rothwell

--Sig_/XaP+1XpV+o_QmWQR3DRpFQW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXzZ6YACgkQAVBC80lX
0GxWjAf+O3nPh19b6IyzmwnclCASdss3YflvdmsRK5MdE65h+EGwrKg0GG5q+m1+
uMR6t8XbUc9ZCZXbEmhGXUIa+dH2LozOKafITVyoDD6cqZCT0Uql/pOXjkprCE4z
D2Or46W4bwkSlIMqmd6T2Sfg1CLrKaCWk6RiWNLXpvvb0/uTJyIW23aIMvfpk1zg
9PgQvSWUz8q+ee+7y/7zd3GdOvOsKo7wYIOaO+BuXxIdqmUDDpfAtJZ4diMeIPNs
Srq/u4SFRZwIZ9QuWaOCM3UDLwmlsiaYrSp/EKhDk4VDGVHfpR1QUOoeYk4/VcLP
8HmiGB1ijUh5FSLTETQ2jErYI2EYBw==
=xteO
-----END PGP SIGNATURE-----

--Sig_/XaP+1XpV+o_QmWQR3DRpFQW--

