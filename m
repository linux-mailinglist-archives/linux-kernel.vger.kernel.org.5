Return-Path: <linux-kernel+bounces-144538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112C58A478D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8623DB21F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF1B5221;
	Mon, 15 Apr 2024 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KaFKkuYs"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C5A1DFEA;
	Mon, 15 Apr 2024 05:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713158553; cv=none; b=ZPQ4A2We1/M8NNKvpqF6X23Mu/mjL/s2WCBdpziX5st6ZAJrEEzVGo+IEJQntfmByhE/ihVcn5eody03ogOhyI1f2X264Zxa8AQHkHdakK3L+1PNp2+PC/ELOOAksDrzJkHei4CgDcrJPnPoYSu/AQ1sYEKYpf2JZMoOLygYlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713158553; c=relaxed/simple;
	bh=w1CD5sPVgT6NGtShw3akz+SpoAtihwISk9wLuMqIKbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MSAQDB8+pBWCU3GqZNrskhiv5cCRZ3Zk7eSuuzXSrWDl1j3xW+sJ65jxqihH7JYId2bJWuBcXAnJ1F/OTihGRh4n/JX/qx3WSnYJFp/NMdGW1SFAZEw5SfNXGUw0tm2Z60Vln3i6dQQ43nTFZm3Wq6LCTnyNFW1XPQk6gQ6y0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=KaFKkuYs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713158549;
	bh=8mrQmlCDpVg87B4ElQ2n1Es5kn5Xhsvl3ggWqslLfk0=;
	h=Date:From:To:Cc:Subject:From;
	b=KaFKkuYsjmp1FVzMrAxyLQS4b54L4dfrtqCIBQ4glmlAINJDsLrtoPxHpbDvQtb4C
	 OwlWCoGjHLwlwUmx/5I/qNngAvF344agD77bbZ4uEj3M1LRlIzqF7zM6F7CTPm/x6o
	 w7toJcxIvrwrx37EM9r3FHZimEUST6jGcVR5TOJ+qUBaknhZNh2Qxdr3qsqUYPiDZp
	 laktu1nvoy8hHup1Ko38n/6LVa2dsRsRh3PNDMzSqMz+ZCkE5lbxYj72xNLBT/c0IF
	 3neArprE5xI/NfKh2TA7GImdfeZKKG7b7zsv0EVxf9vJH74/YhokWguizH7NszYEhK
	 DV09EPf1z2wNg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VHwXh4nB5z4wcr;
	Mon, 15 Apr 2024 15:22:28 +1000 (AEST)
Date: Mon, 15 Apr 2024 15:22:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the char-misc tree
Message-ID: <20240415152227.14c877a7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SW81YG_z7wKiyoYGzFqHvaL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/SW81YG_z7wKiyoYGzFqHvaL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the char-misc tree, today's linux-next build (htmldocs)
produced this warning:

drivers/uio/uio.c:446: warning: expecting prototype for uio_interrupt(). Pr=
ototype was for uio_interrupt_handler() instead

Introduced by commit

  f8a27dfa4b82 ("uio: use threaded interrupts")

--=20
Cheers,
Stephen Rothwell

--Sig_/SW81YG_z7wKiyoYGzFqHvaL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYcuZMACgkQAVBC80lX
0GxzJAgAkC6eoma7paz3GMBkYNQ4qupcbEWv04XelRbdBWgp8Alj51IT9pcjRujn
k2uFnvz1o34O58zhfniCcdUJtI1fkQ9InpgZFNO85TEMVjFp7FRSkVEElARUowS8
Ixx7LarB107EZ7V3mfT7f7TzC6bPnM4PS/c0p8mlU8p5BMH1z5cnwPWlMcWz4Nq2
emtTg8tdgb8CgtK5vU9DdZvFsAvMS1OTB5X33jM+7v1vS/vlHhA/edEcQdt4oj6F
/2OhVfEWZ71awFx5JmFjFHuLs7EijH1ut6Z4HfzN1zM8G7567I9IfQfTPI28Lyjj
s1fzavXuYrfXPEMVYHNxneSbfN03gA==
=OGIh
-----END PGP SIGNATURE-----

--Sig_/SW81YG_z7wKiyoYGzFqHvaL--

