Return-Path: <linux-kernel+bounces-93113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA27872B2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07221F21D3C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D24C137926;
	Tue,  5 Mar 2024 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HiQQC/Bw"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383C13443C;
	Tue,  5 Mar 2024 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681694; cv=none; b=VXm1W/SjHVywqmuiGsS9TuQowDNa+m4WNouiOXhSklmHDJ0oXEa7Khss3VtE/Vk7M+m9NA+YoCxQFfxjfo1xY8bZDaCv3gETKeohdnI9DqXwtzaOxU6x0WUNoazND7xwsuuILNnrNaoYT1rhGkVoBtr+99rd5A2l7Ls010zhBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681694; c=relaxed/simple;
	bh=CgccsEajkJX3rGr/KEv9kEGO8zCtuDqpv508JqCMKs4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YnXGrHOL4GRVYEdaKxV/PsumhgxQ+o+HSPlkno28ZUVCbu0NxohEi0a1KP7gJl5DEl6H/2kXkGYN/aQrsq4iB5fNmxBqL9iMao+lBcErOIhcAB1EjJERAx9vJCpb0cLqu/37TKwR0wPr6BuI6hn4Kjyu38HQsPAOF8TfD1vO8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=HiQQC/Bw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709681682;
	bh=AOh366utPLpjWO/Ipym/f07WE+ie0PHRov9sGyieLuc=;
	h=Date:From:To:Cc:Subject:From;
	b=HiQQC/Bw2k+NByUfW7F8V8qm5NS7sTxD3st9VRY/xmTMAe+WiYvUMIRcYLpNUdn3A
	 vE9HnVtgVRbfGGEvWgLLSvxHHU4tNVTdpEpZkdBW3x7e+xgHcUxczoYeaz4Gmw7qJu
	 iof4JQr3cxG39e7UXBnMgJpCFnFYioXdPFzGJna6wSjMCFJTSDI0SxLALU2sIYHZH4
	 fTDjMVXBAyoVIjaocnzQ0ybHUBAmIDYyFeVeMyoJJZgfUbpkNG1DRhjgDV9f82D5Mn
	 DZu4okzfBjpBhcdkCbSFPcNy20tEJVRqhVKMK/+SBI6ZHLj3CKxhOSzX4k7arTLR4a
	 cC4b5kHqz2eZA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqBjs01kpz4wc7;
	Wed,  6 Mar 2024 10:34:40 +1100 (AEDT)
Date: Wed, 6 Mar 2024 10:34:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Alessio Balsini
 <balsini@android.com>, Amir Goldstein <amir73il@gmail.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Subject: linux-next: manual merge of the fuse tree with Linus' tree
Message-ID: <20240306103438.2c0a6f44@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LkBvSJcC./c/m5YCppuATU5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/LkBvSJcC./c/m5YCppuATU5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fuse tree got a conflict in:

  fs/fuse/inode.c

between commit:

  053fc4f755ad ("fuse: fix UAF in rcu pathwalks")

from Linus' tree and commit:

  44350256ab94 ("fuse: implement ioctls to manage backing files")

from the fuse tree.

I fixed it up (I think? see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/fuse/inode.c
index 516ea2979a90,02869edf72f3..000000000000
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@@ -930,14 -942,6 +942,16 @@@ void fuse_conn_init(struct fuse_conn *f
  }
  EXPORT_SYMBOL_GPL(fuse_conn_init);
 =20
 +static void delayed_release(struct rcu_head *p)
 +{
 +	struct fuse_conn *fc =3D container_of(p, struct fuse_conn, rcu);
 +
 +	put_user_ns(fc->user_ns);
++	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
++		fuse_backing_files_free(fc);
 +	fc->release(fc);
 +}
 +
  void fuse_conn_put(struct fuse_conn *fc)
  {
  	if (refcount_dec_and_test(&fc->count)) {

--Sig_/LkBvSJcC./c/m5YCppuATU5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXnrA4ACgkQAVBC80lX
0Gy2Nwf7BIw0m7aawt3swN1ahcp9amUY30AMU9AT44OzzPpdAZN/KVNfSor7Vbx4
/r4pSuPKPvINYPWtrDmLCu69aIDbHH1EAD5eziFGOVFjaam/z7fepkG2ZLpcg5cH
DJtIa48uojDQiFZk4LiFamFY23Up39Df8Xxjw1HCbAA5vHsC0DgMeRpZ6zxxPE5t
27o+jR/mwLijGVmfTGx7HuGdOta0VGpTgkZbo4jYaplEwkzDvxLMJd71ZwJBBYFB
HAfGGSpqkrG4A+EhsO7KrSB1VSUMrqgMTAgkM0E3HBx2Mh25BXnR0M4Ibz0+5Sna
xQPm7V57gGMyVGlQIynIVrgLgt/O/g==
=cECx
-----END PGP SIGNATURE-----

--Sig_/LkBvSJcC./c/m5YCppuATU5--

