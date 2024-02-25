Return-Path: <linux-kernel+bounces-80348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A21866708
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690221F212AE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691BF1BC56;
	Sun, 25 Feb 2024 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DILHocHD"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C8663CF;
	Sun, 25 Feb 2024 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708905353; cv=none; b=PEE3FazbGDyE+cJYI79i33L7nec1nYONnMmxtpHjZ/V9YMIpFnVKEmTokiySGs38wXWuKZf7M04YsFwAceQpEoWWYmPdoXW0B3AwjwHlz8p5pZbuYF65BWPcE1/5T+dWDKV8iZp5VhKowhKhsLdIDCGzflMui7CAHk7U5ou1BJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708905353; c=relaxed/simple;
	bh=+ljHicFpx+gyo+qYhC/fcOr83KNDy5gQPApmdeXUvLw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=X6ocepP4qRa7w7svlP6T8heS9Rr4TkkawWlmETYSxQgxO8suziD5bPbn3RDsJ1sBJwO4jE+YCckMBxV1PzTSkJU5IAeSzPj8Ju81YXqkRWNWCHr2e2tXKzupoF9SNqrqtteXsuwJ3I5dZULvmDdfSL4ywZnY0BR9YkNUomCkxtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DILHocHD; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708905342;
	bh=0VdcT850UcoWWgcZajJ8/+4AfrFw2v/5C9GyePsHD9Y=;
	h=Date:From:To:Cc:Subject:From;
	b=DILHocHDeyY4POhfOZ6IreqqBcRq43xJZEsULM4MW0LX7qm2/WgPU76tINa5rKEjY
	 hBePYVIjMDyrig7w2xDirGWx9U4HTBYdppAoBApEYfcnagcPkPqGT+jhFh1CffNDV5
	 f/wtKZBEGZq4cYCQWLPd3wvnwUsEVWraM/YOcQqbUz6WYUQ1zxodsdWpJFeSLb6Y6N
	 +P38BdTChwEQiw/OuN0fNGSOdBsJabepKEYlHXqS8TXM12hsjMpgP5SSnW9cv/ekGV
	 wMOJWlDDy2s5yQRRdvzhZjnYLy2erhOikcoNgsh7a27+L3gBGCVH84FSJLDPxAJKiY
	 rbniKRsLfPGag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TjgcF2P6cz4wcY;
	Mon, 26 Feb 2024 10:55:39 +1100 (AEDT)
Date: Mon, 26 Feb 2024 10:55:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Alessio Balsini
 <balsini@android.com>, Amir Goldstein <amir73il@gmail.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Subject: linux-next: manual merge of the fuse tree with Linus' tree
Message-ID: <20240226105535.2939b066@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dm3soD_u3d7PCfElIj.b91q";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dm3soD_u3d7PCfElIj.b91q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fuse tree got a conflict in:

  fs/fuse/inode.c

between commit:

  053fc4f755ad ("fuse: fix UAF in rcu pathwalks")

from Linus' tree and commit:

  9fc953f59383 ("fuse: implement ioctls to manage backing files")

from the fuse tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/fuse/inode.c
index 516ea2979a90,c26a84439934..000000000000
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@@ -1373,7 -1395,9 +1402,9 @@@ EXPORT_SYMBOL_GPL(fuse_send_init)
  void fuse_free_conn(struct fuse_conn *fc)
  {
  	WARN_ON(!list_empty(&fc->devices));
+ 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+ 		fuse_backing_files_free(fc);
 -	kfree_rcu(fc, rcu);
 +	kfree(fc);
  }
  EXPORT_SYMBOL_GPL(fuse_free_conn);
 =20

--Sig_/dm3soD_u3d7PCfElIj.b91q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXb03cACgkQAVBC80lX
0GwwaAf/X0VXxaqiq1IKHsEhuuEWBBgEqOyFGKbKCWEgHjI4oESuHhEiPwEHADcN
TsCbvPoCZ79ZAik6pPp0MZChVE25MwLXpEtxw2Hp7MYAwBud9mT5/uiHIcezoVen
YcIb3eCIfjEvR2EOay7hqoIOFlBLnynl94NTKU4PWuzQ27YiZn5X/bqJpi1WKYZM
hBRlCdSnl3c1Sz89Mo6FmL6YCbR7ckkcwXI4BeMr+xNZaHAjnhNTDMu6d5Hr8iYV
zdJiJaTaQYjiz4LZOklY03sHgaucobfRAku1eeNkNhYWU+AfGweg6U06Ugvrwor9
7uZBLhuvjkeUSIM75qXSJixCQNEDtg==
=Iti7
-----END PGP SIGNATURE-----

--Sig_/dm3soD_u3d7PCfElIj.b91q--

