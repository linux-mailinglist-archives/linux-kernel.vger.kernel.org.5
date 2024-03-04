Return-Path: <linux-kernel+bounces-91391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BD28710E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6259E1C22060
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722167C6C6;
	Mon,  4 Mar 2024 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SRI7Jwj9"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3467BAE2;
	Mon,  4 Mar 2024 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593652; cv=none; b=dqr9OHOmVPnNmI1yZpLoGfV3myXWCaacB80UAORnQ2MRsZRbkXrl9TSKJRYOOvJOc7kagDncD1JG4Qsri65GpHcNvmhVjNe0EBh1WwuBuk1mOoYFlQFozJNBNV/deLgXc79aCYepz46Ft7tm8yRsGhFiqb8gyYN4sP3GOyLYqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593652; c=relaxed/simple;
	bh=9acieA//Q5Xsz31MQ10yhpTiIo9kkAvZxHkHanPpuXI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VIZm7osOQyNuWEo2sYe6/kl71l7Qj5XMrtUGX1ETO/ove5aaVphUKbEPi4jYYhUVhZ9qwGC6OBbsh15G7hNmPaokwkW57lxsvSQZddGR3ZHVF3suGu+HDh3CgAUukuPydQvsxdoGedGeEUTOCUMFYlWS4Bi7fBezBRLOu/9sDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=SRI7Jwj9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709593648;
	bh=aZmxmKa05vtfJZ0yKxa5Fc16XjMW5Id4wRkD20jjLow=;
	h=Date:From:To:Cc:Subject:From;
	b=SRI7Jwj9jnkNGPfwW1WUuhxKsRV1+O7q8fMa6maZprY2z38sYVAjdPsaxYX+A/smI
	 kK7yDum8tVxv+LpVN8Nmpxw8+0hKfKnuKyL8IcNrGPBRV7d4EfyP0NCCnBkzDZzNGy
	 ZeGO2BeSM/jjtrSCAOXz+4y7sqmLFeRWTgYbe2dSeOOGJ9499mSAFfoKWs26p9aZY6
	 rsDhqv2SR6j62p7KeaIwG07Cfwmu7EziSlQ0lvrpp5jr66SriM0shpYQOctz1BWGTv
	 zBeku0iG9j6QDejvC3/eMWcxXSCv54l4xuIj9Ocn+sKQRjFsfJvdzCGz4RcIPqPIZ+
	 O5163g0GQ8jfQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpZ8w2jCyz4wcv;
	Tue,  5 Mar 2024 10:07:28 +1100 (AEDT)
Date: Tue, 5 Mar 2024 10:07:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Wiklander <jens.wiklander@linaro.org>, Olof Johansson
 <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc: ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the tee tree
Message-ID: <20240305100727.004a6dcc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H5RD=/xRv6olynryxtv+a5/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/H5RD=/xRv6olynryxtv+a5/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  1d044941d538 ("tee: make tee_bus_type const")

--=20
Cheers,
Stephen Rothwell

--Sig_/H5RD=/xRv6olynryxtv+a5/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXmVC8ACgkQAVBC80lX
0Gzg8wf/fd76J/scXPVnXXoJNLyAkM1NSrrL1QIhvwNKsdBViXoOCxEIPCLN4qq6
vYHFCIEMa9O/WPZtr1gJA0UZgbNT6xckoCk1s9d+2rxn7dKmGuKV/Qenhpf1CQg9
c15MLCMEfQQj4YfxCfphj9RZrsrKehVhYOBgMW1hr6QFaJKGbMDDjODOhDIoX4kJ
YKZek4Wu26HXdhVdP1ka+aEvnwmmFJZNNy8uxPzSUu5CUmMGFU/obiu9qYK0zJkv
BQ0APdenhb4rivpRv7oZQFPcaJ8A3JBGpoESfs5x8KxwZJ3Cihib2PptevHocp8m
DUUw8RAJVYpu38tYnTHDcl0RJPgbmQ==
=zAN3
-----END PGP SIGNATURE-----

--Sig_/H5RD=/xRv6olynryxtv+a5/--

