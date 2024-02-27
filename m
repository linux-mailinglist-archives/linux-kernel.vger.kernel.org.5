Return-Path: <linux-kernel+bounces-82681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D490186883F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1254D1C221B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACE952F7C;
	Tue, 27 Feb 2024 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EjTxN3Px"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96552F62;
	Tue, 27 Feb 2024 04:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008642; cv=none; b=CSHj0FZhtB+HUVPYYSe+lZ4uIrLiEyTkxiRSeDTDLmj9iuMfOQS2EhMSz1QaTlI4H4bJeQzqTMhBSopngla/hzwH0ZsytU8MlktPnZIDDZkvUoy7IthTy7Q5vgil0bM9QUrDTQAYP6fQJORI8hPeaJJUFYXU7sp+wWYl/bIN4kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008642; c=relaxed/simple;
	bh=5VXHyMBtZa7eWjetbmpYWhwQ9hodabvVz1cNmWR6fdA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lpfHzIjLn622gOKUrcpED1ts25mnWXRSwuRAdkIs8wFPQESA+72rwNsCihJJRrQF6PzLnScsluKEaXGKK0aH2KRmXi33OmKj7PCPJI+UHGumEnn48CEP1LJfNRwxc7r+sBF0JyqBnP6S9HrxTKHX/pAge7ihEKxS5S1faEQ+I0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=EjTxN3Px; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709008637;
	bh=E7/eVl4lj6qFejY+AAFd4Wajv0dcTKtdFSHvNV34V0A=;
	h=Date:From:To:Cc:Subject:From;
	b=EjTxN3Pxqc62nzGsLNwUUirC4idsKmo1Q9Lqb10nkUbyMVraQey0l5VDoK+j1sssO
	 czWY7DtRNb8mnaYxnflYKfMZ1RM8NmwxXDDjJA68cQDXTQPeA3oCuvoHIz6C+Lks+a
	 yKs0Z4O7uKuap8UKvWnx9OhERIcsk0pLUBDPrDLRrmquLiwT3Be/K5/RCPxK6+RF/l
	 m98Y7zRU4QT2CZNZeWNxgm98tV8Z0k9lBjDctIrSMBev9b5ytCpSocPez/jnyl0v1a
	 m2UMRQYVoNoE9gLRDFidLneljhCI0JVz3rzc03ANg6ldpgzLhV22lXYOLWvGfZZzQS
	 RnxV0oXyeqTgw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TkPpj3DM0z4wbh;
	Tue, 27 Feb 2024 15:37:17 +1100 (AEDT)
Date: Tue, 27 Feb 2024 15:37:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Chuck Lever
 <chuck.lever@oracle.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the scsi-mkp tree with the vfs-brauner
 tree
Message-ID: <20240227153716.43e5cbad@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GhCxABn2pMVAxSw4uUz6Pmz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/GhCxABn2pMVAxSw4uUz6Pmz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  include/linux/fs.h

between commit:

  0e4a862174f2 ("libfs: Convert simple directory offsets to use a Maple Tre=
e")

from the vfs-brauner tree and commit:

  fe3944fb245a ("fs: Move enum rw_hint into a new header file")

from the scsi-mkp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/fs.h
index f69c082e0f16,bdabda5dc364..000000000000
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@@ -43,7 -43,7 +43,8 @@@
  #include <linux/cred.h>
  #include <linux/mnt_idmapping.h>
  #include <linux/slab.h>
 +#include <linux/maple_tree.h>
+ #include <linux/rw_hint.h>
 =20
  #include <asm/byteorder.h>
  #include <uapi/linux/fs.h>

--Sig_/GhCxABn2pMVAxSw4uUz6Pmz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXdZvwACgkQAVBC80lX
0GxD/Qf+IABQenKyfyNHoAUuUEX6HKcUDHqYYF6dOtvDa9IbOSbGXmn8oBpSb5lw
qlczuXZVVQME4RJvYZUurunfIMwdEKzWs67Dr4n+zqkgBpvDpYkJSg0R8H4C/gYr
VxDW4h3ouWjAeotAOgz97hPUCmc+QaAnuQf/LTAu6uYNrstfT7vJwWwAUHDB5kh5
W2LSDGS2VENpbOEsXwI7NZcuJRyXokSG9HB4Zc2fP5+HXOua6vcUsaxYd28fl2zN
COqZq9ZtuIr1D6iJkrSDXnbLMhf+OvoqXlWKq6Sb6f2TuGT22i/yXQG3L6b6C49Y
QmqQwqkt1kUxiCU8QHFwGfyjdSqKCw==
=jmVI
-----END PGP SIGNATURE-----

--Sig_/GhCxABn2pMVAxSw4uUz6Pmz--

