Return-Path: <linux-kernel+bounces-13955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ED282158E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 23:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE56D1F217DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 22:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F71EACE;
	Mon,  1 Jan 2024 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FdBGdn3/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BDE55F;
	Mon,  1 Jan 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704148579;
	bh=2FQy+ORQlDr6BlS1/OXUjM6c+rLOzpW8GfhmKHifP4w=;
	h=Date:From:To:Cc:Subject:From;
	b=FdBGdn3/A8KDOjrGc+K2eVZYO/eN7kMUILSwcmiH2h2BWrObW9cDELRJGnHH2pIc2
	 Pe+q4JAKjXT249aegVfRpJU0/vje/SGG+oXz5zJnVHB4HJew0RgQb+kWgNu6C4SS2d
	 ecjDtEumAR/piFeU3erbdCmTb0AzQlg9jd2ntgy9bqbY/yb/QuyFzVWmdAlbyvBLdX
	 flK+m2ZtDN5YjZyYHb5L7rBz2D7laLgJQXBkVSDiY/tQGJvKKNKbu1ZsrDA012iOHr
	 2jYsAi3W/rBcAbNRe3SJvB9JcB88anNO7mxLIYsd+8bA0+ph5iq5LktLitQ4XNkfeS
	 jVTnbRFrmvQZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3rS315rCz4wcg;
	Tue,  2 Jan 2024 09:36:18 +1100 (AEDT)
Date: Tue, 2 Jan 2024 09:36:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>
Subject: linux-next: manual merge of the vfs tree with Linus' tree
Message-ID: <20240102093617.0b3a0907@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d+MIXcnLuloSv.dh+tZIWZ6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/d+MIXcnLuloSv.dh+tZIWZ6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/tracefs/inode.c

between commit:

  7e8358edf503 ("eventfs: Fix file and directory uid and gid ownership")

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
index 62524b20964e,61ca5fcf10f9..000000000000
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@@ -207,24 -206,14 +206,21 @@@ static void set_gid(struct dentry *pare
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

--Sig_/d+MIXcnLuloSv.dh+tZIWZ6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTPmEACgkQAVBC80lX
0Gz6egf8DAkzOrBYU+3hxpdmPeBJ8/ZNK3XUpXqfJfvTeGRepAXnwpqfc9QbKiJT
RHlwdYtu0CxBlALMxg408duhz2tp+d9cEteOIuc/9dxkm7SH2F0tiCDk/bJXOoRh
S0HKpxmMqgXA+Sk2Z2tWF+npLz0hBlO2qxXEgA6Zc6BPnB9608LggDwWl0Gk5EGk
nIpictcCV0M/D8ukC/4/FzeF0q4g8QauRiy0DDBOw5AcQoCQoFDM2JKE1k788fus
dJJG2WzWPEHxyfjeiDob7pu3PkeQP+cRS7tN0beza3RYlGfruiPZRuODRzT+QhFO
Lc4t7yBMeD0on8SkBB5YWJvUp7lJPQ==
=ht0o
-----END PGP SIGNATURE-----

--Sig_/d+MIXcnLuloSv.dh+tZIWZ6--

