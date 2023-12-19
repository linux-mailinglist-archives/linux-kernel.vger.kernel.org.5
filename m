Return-Path: <linux-kernel+bounces-6106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4768194B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050FF282A77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18B83FE30;
	Tue, 19 Dec 2023 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lyKmhNFA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C43FB0B;
	Tue, 19 Dec 2023 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703029272;
	bh=Dcfd4RhAnXHoe7RYkF8n8Xk/9I2NneoLq8kj1SwTKMY=;
	h=Date:From:To:Cc:Subject:From;
	b=lyKmhNFA1/A1sH9hS0wM1eWuKU0ZQMVFUgPS2DlAXeKjsIKuMFI9ZmI+a23XMl5Gw
	 B8cdNWJCvhPE1qDip2CwzxgVmikC+Goetpdt5sJRxSPNR1r0AZAI6kPcM089VHfUTO
	 ZRj31MPXd2LB3u3wU7QO/RYqZdpqmsbKH6eoOgdfOmMAJimZoBC7mK3CZvq1xRIc6/
	 XxPIY+HqiywFUhPmYeHLK9tVW8/A7EEhvp9ndvX8qR4zUVxJGnjvkQoShRRh1kKnNh
	 9ipqa5pw8tLxRKQhqa8aGrhofRYrsFmwEgFVmzJqUkH9CngTUvMFIpL1WpIzr/MORG
	 GeOeWiB3LK9Ww==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvtVw2W0Wz4wdF;
	Wed, 20 Dec 2023 10:41:12 +1100 (AEDT)
Date: Wed, 20 Dec 2023 10:41:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the vfs-brauner tree
Message-ID: <20231220104110.56ae9b36@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b4PHeWdP57aqouLzyNAjazv";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/b4PHeWdP57aqouLzyNAjazv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  Documentation/filesystems/porting.rst

between commit:

  01bc8e9ae23a ("porting: document block device freeze and thaw changes")

from the vfs-brauner tree and commits:

  22e111ed6c83 ("rename(): fix the locking of subdirectories")
  a8b0026847b8 ("rename(): avoid a deadlock in the case of parents having n=
o common ancestor")
  da549bdd15c2 ("dentry: switch the lists of children to hlist")
  2f42f1eb9093 ("Call retain_dentry() with refcount 0")
  1c18edd1b7a0 ("__dentry_kill(): new locking scheme")

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

diff --cc Documentation/filesystems/porting.rst
index ced3a6761329,270cef3d84d4..000000000000
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@@ -1064,12 -1064,61 +1064,73 @@@ generic_encode_ino32_fh() explicitly
 =20
  ---
 =20
 +**recommended**
 +
 +Block device freezing and thawing have been moved to holder operations.
 +
 +Before this change, get_active_super() would only be able to find the
 +superblock of the main block device, i.e., the one stored in sb->s_bdev. =
Block
 +device freezing now works for any block device owned by a given superbloc=
k, not
 +just the main block device. The get_active_super() helper and bd_fsfreeze=
_sb
 +pointer are gone.
++
++---
++
+ **mandatory**
+=20
+ If ->rename() update of .. on cross-directory move needs an exclusion with
+ directory modifications, do *not* lock the subdirectory in question in yo=
ur
+ ->rename() - it's done by the caller now [that item should've been added =
in
+ 28eceeda130f "fs: Lock moved directories"].
+=20
+ ---
+=20
+ **mandatory**
+=20
+ On same-directory ->rename() the (tautological) update of .. is not prote=
cted
+ by any locks; just don't do it if the old parent is the same as the new o=
ne.
+ We really can't lock two subdirectories in same-directory rename - not wi=
thout
+ deadlocks.
+=20
+ ---
+=20
+ **mandatory**
+=20
+ lock_rename() and lock_rename_child() may fail in cross-directory case, if
+ their arguments do not have a common ancestor.  In that case ERR_PTR(-EXD=
EV)
+ is returned, with no locks taken.  In-tree users updated; out-of-tree ones
+ would need to do so.
+=20
+ ---
+=20
+ **mandatory**
+=20
+ The list of children anchored in parent dentry got turned into hlist now.
+ Field names got changed (->d_children/->d_sib instead of ->d_subdirs/->d_=
child
+ for anchor/entries resp.), so any affected places will be immediately cau=
ght
+ by compiler.
+=20
+ ---
+=20
+ **mandatory**
+=20
+ ->d_delete() instances are now called for dentries with ->d_lock held
+ and refcount equal to 0.  They are not permitted to drop/regain ->d_lock.
+ None of in-tree instances did anything of that sort.  Make sure yours do =
not...
+=20
+ --
+=20
+ **mandatory**
+=20
+ ->d_prune() instances are now called without ->d_lock held on the parent.
+ ->d_lock on dentry itself is still held; if you need per-parent exclusion=
s (none
+ of the in-tree instances did), use your own spinlock.
+=20
+ ->d_iput() and ->d_release() are called with victim dentry still in the
+ list of parent's children.  It is still unhashed, marked killed, etc., ju=
st not
+ removed from parent's ->d_children yet.
+=20
+ Anyone iterating through the list of children needs to be aware of the
+ half-killed dentries that might be seen there; taking ->d_lock on those w=
ill
+ see them negative, unhashed and with negative refcount, which means that =
most
+ of the in-kernel users would've done the right thing anyway without any a=
djustment.

--Sig_/b4PHeWdP57aqouLzyNAjazv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWCKhYACgkQAVBC80lX
0GxRTAf/dF1XvjDZ9/eCz1XJYd4veLq/9HB6hS8eGGlc1Lb6/74NvOMf/vri/7q7
Y2SCtC+6HbOdXY+xCSTZvdTc2K/wF5ZA7OoLwIk5fsmx2irWBsnkuwCXivIxaHZu
r6/F/m90jG3OiYfAgD7ohYHxQv0nClosdz6gHI7/JJ4hAhTZjk2nRIh1UpQGyTlP
F+Bnbqf1WYeZD0gE76mYLAVF53U9fo7IAcBX7WBlHs6JMC9Si1ryhGufbWpVG5UF
5H1p8eoSJ6wbpOO+OeSkRka2eROb2hoB7vHutY1r8fQdpiuQUBue/khW1XnemESg
t8YGwmJhkei8eQLywC7haL6HvpZ6Aw==
=esc+
-----END PGP SIGNATURE-----

--Sig_/b4PHeWdP57aqouLzyNAjazv--

