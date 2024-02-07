Return-Path: <linux-kernel+bounces-57288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2161A84D62C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466691C23D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D5200D5;
	Wed,  7 Feb 2024 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZjtmQbO5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3F1DDEA;
	Wed,  7 Feb 2024 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346758; cv=none; b=cqQXyP8gPBaxnKJ02/6CRpdFHHpryjE2DdBt1z8QQhaidqjynixXbmMGN9/8XXUh56rPmxie2p9/DJldijnJqXjUsQ56svbzuc83CgZYtro+80AStG8xOiFXFb3llnx488P2YuRYtA6+Ifx77wLiYbVDqDLVbF08goy1SLBaMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346758; c=relaxed/simple;
	bh=zPbaayiAZdMgEFMUoltozIj6Imkh38xgAy4mS/Sr88g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gvXxvaV6Kc+Gl53DTgPWGUBlfzbzQtNhaiCFgOiirGwN+rfzOe7df1CDXPMQHxcz0lH0HzylciHWaLkFb/DAVb0hkXjmVquiTYUH4iHNq6am4zBqfnZ8qDkP7LMXEhdl5ixDGKBqHkaZGceVhGqfzEhM5Mnj12+cgFVqfyX/u8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ZjtmQbO5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707346748;
	bh=vmTSClokxjQcRjxwvTaZp0PR2TBsrtf2JDVciil+QS8=;
	h=Date:From:To:Cc:Subject:From;
	b=ZjtmQbO5/eC8uW5iHLCyOe15pOh35b3HDX45BKNg1nbTOG5MGGilXkTYqivgC3y8x
	 4unyetoEXN4nmasQrXjqDI5tMCgl4DvwqvNZjNY7Ct8GWtBleeBr2rZdtK9ukP34jv
	 r1mGPyAzFVJsl+q/bminIwm8ahgbC8rd4cQcO/ZHbtkLSgMbJK3a0+grI8wLFfj/vT
	 vh9sbZf9pvxnNAR4kVikO57nYJn03RlS7of80pMI4mc7nqg2VbIFxfD+Od+n6cDm0P
	 FVC5BY7wvO2YdFxc5eQJma9EbXZIklllHaRcbovcraQ5db5emxNX+Idd1Cs87VxO+z
	 EaFjPZcWbWrBw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVbCH5n1sz4wbk;
	Thu,  8 Feb 2024 09:59:07 +1100 (AEDT)
Date: Thu, 8 Feb 2024 09:59:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Steve French
 <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 CIFS <linux-cifs@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the vfs-brauner tree with the cifs tree
Message-ID: <20240208095906.18567844@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DZJ_LM+4DGfnbd2qs_vcJaB";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/DZJ_LM+4DGfnbd2qs_vcJaB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/smb/client/file.c

between commit:

  ddcd663e2c76 ("cifs: Remove some code that's no longer used, part 2")

from the cifs tree and commit:

  a69ce85ec9af ("filelock: split common fields into struct file_lock_core")

from the vfs-brauner tree.

I fixed it up (this was caused by a pure white space change in the
latter commit on a line that was removed in the former anyway, so I
just used the former) and can carry the fix as necessary. This is now
fixed as far as linux-next is concerned, but any non trivial conflicts
should be mentioned to your upstream maintainer when your tree is
submitted for merging.  You may also want to consider cooperating with
the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/DZJ_LM+4DGfnbd2qs_vcJaB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXECzoACgkQAVBC80lX
0Gzo0Af9Hmvu22w17Vji1ztQuO6D+u590Tev/8qnb0B0uOGAZThZt0FxVjEDWcBi
9aELZq4OATjlRAHvjzQVlkMJOm0hspvQZH+nuV4MIMlGvbExuWz1rYULFm5rgfNL
C0fNIDZTOKEl3QAQBmKAeutActnkGnXywzLGmkYPlUxSRv0NSS7bWvCrNtkdEVaQ
JCUREjh57OZ50DiIGTgF/bcxMM3p0bWITQVGq+APelvyTd4wM/wQi/GP+NR5CqAA
+Qc9y44QF2bdcFTA07Pu2ku6M6InfNd62HQ5WXcPWoeXgPrQclcEwcjFitszyZlz
u5mTcarm3qCel0XpeafUztLyH3qRzQ==
=+Pe3
-----END PGP SIGNATURE-----

--Sig_/DZJ_LM+4DGfnbd2qs_vcJaB--

