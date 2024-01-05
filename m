Return-Path: <linux-kernel+bounces-17350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117B4824C13
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40DE2848B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0F17CA;
	Fri,  5 Jan 2024 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qZZv/VnU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB2EA35;
	Fri,  5 Jan 2024 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704413418;
	bh=gq6qCo8Z9i5nzsJTvOM5IqitMFtRngmF8UYkyG6IgLI=;
	h=Date:From:To:Cc:Subject:From;
	b=qZZv/VnUGgF27DKkt8zKc47S1xoU+VSaEhy10ezAbEBXIiqcrme/M6fEvefqcqvnB
	 CU8xT9wlEADFaDV2M1wy8c1DWsvk7WcWi+B8cX7U1zOyoBz+wDoQ8naPKxLFZ6JRqA
	 iofjlSONBn3/bcdbaNxOaDhzx8L2zB/hXdflAQHO9B2rWuPi0IyIgiONp0GFFel1tA
	 T5T/jZ119zprh6eI61G+/l9btLhjsqndjHk1oPm98YNqSf3QE0Cbyj3YezjM3D0V/9
	 Yc0mbxUHyZu1kCATIPSPCFhftBwWJ/m33o693LEdSrm/Y8MzM6o2OsuMrnCIpPTDla
	 uS1nQVNAUlBIg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5kP540tgz4x1x;
	Fri,  5 Jan 2024 11:10:16 +1100 (AEDT)
Date: Fri, 5 Jan 2024 11:10:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>
Subject: linux-next: manual merge of the vfs tree with Linus' tree
Message-ID: <20240105111016.5a3c36d0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hLOUkIKURAkrPlh9NLFO6P3";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/hLOUkIKURAkrPlh9NLFO6P3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/tracefs/inode.c

between commits:

  7e8358edf503 ("eventfs: Fix file and directory uid and gid ownership")
  ad579864637a ("tracefs: Check for dentry->d_inode exists in set_gid()")

from Linus' tree and commit:

  da549bdd15c2 ("dentry: switch the lists of children to hlist")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/tracefs/inode.c
index bc86ffdb103b,61ca5fcf10f9..000000000000
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@@ -207,28 -206,14 +206,25 @@@ static void set_gid(struct dentry *pare
 =20
  	change_gid(this_parent, gid);
  repeat:
- 	next =3D this_parent->d_subdirs.next;
+ 	dentry =3D d_first_child(this_parent);
  resume:
- 	while (next !=3D &this_parent->d_subdirs) {
+ 	hlist_for_each_entry_from(dentry, d_sib) {
 +		struct tracefs_inode *ti;
- 		struct list_head *tmp =3D next;
- 		struct dentry *dentry =3D list_entry(tmp, struct dentry, d_child);
- 		next =3D tmp->next;
 +
 +		/* Note, getdents() can add a cursor dentry with no inode */
 +		if (!dentry->d_inode)
 +			continue;
 +
  		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
 =20
  		change_gid(dentry, gid);
 =20
 +		/* If this is the events directory, update that too */
 +		ti =3D get_tracefs(dentry->d_inode);
 +		if (ti && (ti->flags & TRACEFS_EVENT_INODE))
 +			eventfs_update_gid(dentry, gid);
 +
- 		if (!list_empty(&dentry->d_subdirs)) {
+ 		if (!hlist_empty(&dentry->d_children)) {
  			spin_unlock(&this_parent->d_lock);
  			spin_release(&dentry->d_lock.dep_map, _RET_IP_);
  			this_parent =3D dentry;

--Sig_/hLOUkIKURAkrPlh9NLFO6P3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXSOgACgkQAVBC80lX
0GxAvQgAjIHA5kp6W+popfdm1cZs9mOmIEWQsDuvlY/d3y7egnTLP5ORVMZHq+9s
Ebb9O5vwCTxZnAj9qSZShR+VlikK/DYQqJ3S/LXxwrnIRv7w9Gb/kpMCl82jG7tZ
XUxQn+rOdKAZTeM1Gl7rKlBo4xFJdoS8qLZ9P8NP8Y/8fwIVoRQtbn0Wje5+UNPW
zktv4P9ydiwY3XZhwHgYnITR9hyQIOOpoAEMlArtqA4Fvb4k49eDPkGPkAHAfNMK
UKER1a4e/4UkPLqCDirfbFndmlxRk/nxEzM2J5RgC9a8kK6OA7ZfCRS17K0jaXKo
HoOb3HuQDvIyBlxAbCWgUDgLnkfhkQ==
=qIof
-----END PGP SIGNATURE-----

--Sig_/hLOUkIKURAkrPlh9NLFO6P3--

