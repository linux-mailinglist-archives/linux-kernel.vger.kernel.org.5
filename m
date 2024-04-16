Return-Path: <linux-kernel+bounces-146129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9778A611D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507B5B21634
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1CA11181;
	Tue, 16 Apr 2024 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F9JT0Pvj"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C08485;
	Tue, 16 Apr 2024 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713235476; cv=none; b=NGAf7sQf4kTq8ItA0O6C6jXh+XyVE3baiLWUjjwIqyy7CkDAKVPPN+F0Fa465YwOrJ/LAivclr62I0RO1p+qP63d4CCc1VPbtfzFJh1Sdzhv03Ri+8lH6YacR6eHbjiJnj8xancTp91J9Gww7iTEzQXAYQJ4kZlDodcZ7GSNtFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713235476; c=relaxed/simple;
	bh=WOP6vQcoqzks8WSee7OrShtu3+FKMyr2tXm7Fba/t1c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BPzPa/+xAjBFNA+55BU1qJCjzf+qyuvVZ8lJ+jagU0uYwMKynW1gupfTnw4MKPIuvLaZr4LPDfOYuxewNOYNyejRnWBSYamRDh3YCu3O6K5ZhbK3+6LrLcLQLPOp+KhH6DuRCHxeLtM17ktWpDXJhlPLpTe033qwdU1NkjtPz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=F9JT0Pvj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713235470;
	bh=fxHKmx6FXKZbRduyay5x+5YXC7g5gOcmxuvTB4fmgXs=;
	h=Date:From:To:Cc:Subject:From;
	b=F9JT0Pvj5V+l5thEcdKGemIPFQ9HOe253uXXjBukxsZNFQcCoeczklOltNUq5tteB
	 ObkGzhf8w+xiiNA1MnJigWpKTLviFDdaMW170z2I6+W4h0z2y6OzwNQWZrn2JFYFQF
	 UmIQoiVmjZQVtgt9VgshQdaF0I5UoUe30ZuyaiPgxTGXAn4OChiUr+0alI/IY/FcIC
	 M2X/mUwsfleT3CTygdxNaBR7rC82ZUsbwCtWJd7f8Ezgf8YyANM8UysOI0r487mOS7
	 nkP497ODLi9WjrcClqT7OH93Hv/m8GCK0nmBf4mwgDOW0ThAM+vTyePt1Ccilwoo9K
	 vXp6OHkrYj2UA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJSzy1vyhz4wcn;
	Tue, 16 Apr 2024 12:44:29 +1000 (AEST)
Date: Tue, 16 Apr 2024 12:44:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Al
 Viro <viro@ZenIV.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>
Subject: linux-next: manual merge of the block tree with the vfs-brauner,
 vfs trees
Message-ID: <20240416124426.624cfaf9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m8f_evjuhWhg6A1r=yhb4Q6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/m8f_evjuhWhg6A1r=yhb4Q6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  io_uring/rw.c

between commits:

  210a03c9d51a ("fs: claw back a few FMODE_* bits")
  7c98f7cb8fda ("remove call_{read,write}_iter() functions")

from the vfs-brauner, vfs trees and commits:

  a9165b83c193 ("io_uring/rw: always setup io_async_rw for read/write reque=
sts")
  0d10bd77a1be ("io_uring: get rid of struct io_rw_state")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc io_uring/rw.c
index d517a1a29274,3134a6ece1be..000000000000
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@@ -1028,13 -1003,13 +1004,13 @@@ int io_write(struct io_kiocb *req, unsi
  	if (force_nonblock) {
  		/* If the file doesn't support async, just async punt */
  		if (unlikely(!io_file_supports_nowait(req)))
- 			goto copy_iov;
+ 			goto ret_eagain;
 =20
 -		/* File path supports NOWAIT for non-direct_IO only for block devices. =
*/
 +		/* Check if we can support NOWAIT. */
  		if (!(kiocb->ki_flags & IOCB_DIRECT) &&
 -			!(kiocb->ki_filp->f_mode & FMODE_BUF_WASYNC) &&
 -			(req->flags & REQ_F_ISREG))
 +		    !(req->file->f_op->fop_flags & FOP_BUFFER_WASYNC) &&
 +		    (req->flags & REQ_F_ISREG))
- 			goto copy_iov;
+ 			goto ret_eagain;
 =20
  		kiocb->ki_flags |=3D IOCB_NOWAIT;
  	} else {
@@@ -1055,9 -1028,9 +1029,9 @@@
  	kiocb->ki_flags |=3D IOCB_WRITE;
 =20
  	if (likely(req->file->f_op->write_iter))
- 		ret2 =3D req->file->f_op->write_iter(kiocb, &s->iter);
 -		ret2 =3D call_write_iter(req->file, kiocb, &io->iter);
++		ret2 =3D req->file->f_op->write_iter(kiocb, &io->iter);
  	else if (req->file->f_op->write)
- 		ret2 =3D loop_rw_iter(WRITE, rw, &s->iter);
+ 		ret2 =3D loop_rw_iter(WRITE, rw, &io->iter);
  	else
  		ret2 =3D -EINVAL;
 =20

--Sig_/m8f_evjuhWhg6A1r=yhb4Q6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYd5goACgkQAVBC80lX
0Gzdhgf7B/64lJSehzi2t9+TjMayIbnv5trux8hxlGjDICXLRDhuBAE9nCQwddTB
z9osMIAVuYl4D/+4ocJYWPEX7nyhGL1gMP7Gam1fW7XZhdm27veSH2XGkt2NRhVh
BkaGdK5QY+nQsWsyl4+U9ZpbFWFk9EiWaUkRGdakRmclBB7g3K+nWvyPg6BVlGSw
/17/5hO8FGVk6cisBAvqzfvebUNBW+JCuBU1bTilxtC4efcYO/nYd2hBRuraK8ME
lRVcncKv4IRXKcHg2miblzpUqFHxyivAzqguS3GkwjB8W3VMde2TrDSvnrjqn3zP
GcExA4J4DWwz/Wl995OCQhrjudhGSg==
=2tLZ
-----END PGP SIGNATURE-----

--Sig_/m8f_evjuhWhg6A1r=yhb4Q6--

