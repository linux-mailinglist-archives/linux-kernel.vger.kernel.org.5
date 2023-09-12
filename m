Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5979C31C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbjILCjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbjILCjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:39:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3DD3D71D;
        Mon, 11 Sep 2023 19:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694484272;
        bh=7MnTQAA6NXTt2KERJ1/UbZs3JZvQmiYmgAFEHSqSre4=;
        h=Date:From:To:Cc:Subject:From;
        b=cla3qUtbuTnx4S3xdRjH9jRl6xDdMgnSviigtKEx78SSdjkickLnQHv4xOzFiAOy0
         TB/UMCn/63NQ5cwxFJtCGBwQ6o03ro5d78F93WRBlYNbGW58lixIcu+ym5ElGogKHI
         TblIZ5mGLNkhig4BJn8nS0MnIktuVMus3FGi2nz3dLGT2Pj21Ro9uQgbLrbETnhR62
         zbJ8OW98CmypI786fwkoGYP+mVgQx+zdgkuMJEO6W8trtoILDomdU2QpXWU1PkDbNH
         O37LazzSVpWQu9IxaLZNZ8zSZ8UXYcZLPEioQ1d4h28u9hUS7VjlKrPFht0gInEEi3
         cLBZ3eEflXPZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rl6Mz6w2Dz4xQ1;
        Tue, 12 Sep 2023 12:04:31 +1000 (AEST)
Date:   Tue, 12 Sep 2023 12:04:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20230912120429.7852428f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HyO/wwY.250W_1EDD7kIjHg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HyO/wwY.250W_1EDD7kIjHg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bcachefs tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/bcachefs/btree_cache.c: In function 'bch2_fs_btree_cache_exit':
fs/bcachefs/btree_cache.c:403:9: error: implicit declaration of function 'u=
nregister_shrinker'; did you mean 'unregister_chrdev'? [-Werror=3Dimplicit-=
function-declaration]
  403 |         unregister_shrinker(&bc->shrink);
      |         ^~~~~~~~~~~~~~~~~~~
      |         unregister_chrdev
fs/bcachefs/btree_cache.c: In function 'bch2_fs_btree_cache_init':
fs/bcachefs/btree_cache.c:479:15: error: implicit declaration of function '=
register_shrinker'; did you mean 'register_chrdev'? [-Werror=3Dimplicit-fun=
ction-declaration]
  479 |         ret =3D register_shrinker(&bc->shrink, "%s/btree_cache", c-=
>name);
      |               ^~~~~~~~~~~~~~~~~
      |               register_chrdev
cc1: all warnings being treated as errors

Caused by commits

  5ec30115c066 ("bcachefs: Initial commit")

interacting with commit

  eba045d9350d ("mm: shrinker: remove old APIs")

from v6.6-rc1.

I have applied the following merge resolution patch for today.  More may
be needed.

=46rom 801ad185700d9a7abcf156233b9db6cf6d831581 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 12 Sep 2023 11:27:22 +1000
Subject: [PATCH] bcachefs: convert to dynamically allocated shrinkers

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/bcachefs/btree_cache.c     | 19 +++++++++++--------
 fs/bcachefs/btree_key_cache.c | 18 +++++++++++-------
 fs/bcachefs/btree_types.h     |  4 ++--
 fs/bcachefs/fs.c              |  2 +-
 fs/bcachefs/sysfs.c           |  2 +-
 5 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
index 245ddd92b2d1..7f0eded6c296 100644
--- a/fs/bcachefs/btree_cache.c
+++ b/fs/bcachefs/btree_cache.c
@@ -285,7 +285,7 @@ static int btree_node_write_and_reclaim(struct bch_fs *=
c, struct btree *b)
 static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
 					   struct shrink_control *sc)
 {
-	struct bch_fs *c =3D container_of(shrink, struct bch_fs,
+	struct bch_fs *c =3D container_of(&shrink, struct bch_fs,
 					btree_cache.shrink);
 	struct btree_cache *bc =3D &c->btree_cache;
 	struct btree *b, *t;
@@ -384,7 +384,7 @@ static unsigned long bch2_btree_cache_scan(struct shrin=
ker *shrink,
 static unsigned long bch2_btree_cache_count(struct shrinker *shrink,
 					    struct shrink_control *sc)
 {
-	struct bch_fs *c =3D container_of(shrink, struct bch_fs,
+	struct bch_fs *c =3D container_of(&shrink, struct bch_fs,
 					btree_cache.shrink);
 	struct btree_cache *bc =3D &c->btree_cache;
=20
@@ -400,7 +400,7 @@ void bch2_fs_btree_cache_exit(struct bch_fs *c)
 	struct btree *b;
 	unsigned i, flags;
=20
-	unregister_shrinker(&bc->shrink);
+	shrinker_free(bc->shrink);
=20
 	/* vfree() can allocate memory: */
 	flags =3D memalloc_nofs_save();
@@ -454,6 +454,7 @@ void bch2_fs_btree_cache_exit(struct bch_fs *c)
 int bch2_fs_btree_cache_init(struct bch_fs *c)
 {
 	struct btree_cache *bc =3D &c->btree_cache;
+	struct shrinker *shrink;
 	unsigned i;
 	int ret =3D 0;
=20
@@ -473,12 +474,14 @@ int bch2_fs_btree_cache_init(struct bch_fs *c)
=20
 	mutex_init(&c->verify_lock);
=20
-	bc->shrink.count_objects	=3D bch2_btree_cache_count;
-	bc->shrink.scan_objects		=3D bch2_btree_cache_scan;
-	bc->shrink.seeks		=3D 4;
-	ret =3D register_shrinker(&bc->shrink, "%s/btree_cache", c->name);
-	if (ret)
+	shrink =3D shrinker_alloc(0, "%s/btree_cache", c->name);
+	if (!shrink)
 		goto err;
+	bc->shrink =3D shrink;
+	shrink->count_objects	=3D bch2_btree_cache_count;
+	shrink->scan_objects	=3D bch2_btree_cache_scan;
+	shrink->seeks		=3D 4;
+	shrinker_register(shrink);
=20
 	return 0;
 err:
diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
index 505e7c365ab7..88d33690233b 100644
--- a/fs/bcachefs/btree_key_cache.c
+++ b/fs/bcachefs/btree_key_cache.c
@@ -838,7 +838,7 @@ void bch2_btree_key_cache_drop(struct btree_trans *tran=
s,
 static unsigned long bch2_btree_key_cache_scan(struct shrinker *shrink,
 					   struct shrink_control *sc)
 {
-	struct bch_fs *c =3D container_of(shrink, struct bch_fs,
+	struct bch_fs *c =3D container_of(&shrink, struct bch_fs,
 					btree_key_cache.shrink);
 	struct btree_key_cache *bc =3D &c->btree_key_cache;
 	struct bucket_table *tbl;
@@ -936,7 +936,7 @@ static unsigned long bch2_btree_key_cache_scan(struct s=
hrinker *shrink,
 static unsigned long bch2_btree_key_cache_count(struct shrinker *shrink,
 					    struct shrink_control *sc)
 {
-	struct bch_fs *c =3D container_of(shrink, struct bch_fs,
+	struct bch_fs *c =3D container_of(&shrink, struct bch_fs,
 					btree_key_cache.shrink);
 	struct btree_key_cache *bc =3D &c->btree_key_cache;
 	long nr =3D atomic_long_read(&bc->nr_keys) -
@@ -957,7 +957,7 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_cach=
e *bc)
 	int cpu;
 #endif
=20
-	unregister_shrinker(&bc->shrink);
+	shrinker_free(bc->shrink);
=20
 	mutex_lock(&bc->lock);
=20
@@ -1031,6 +1031,7 @@ void bch2_fs_btree_key_cache_init_early(struct btree_=
key_cache *c)
 int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
 {
 	struct bch_fs *c =3D container_of(bc, struct bch_fs, btree_key_cache);
+	struct shrinker *shrink;
=20
 #ifdef __KERNEL__
 	bc->pcpu_freed =3D alloc_percpu(struct btree_key_cache_freelist);
@@ -1043,11 +1044,14 @@ int bch2_fs_btree_key_cache_init(struct btree_key_c=
ache *bc)
=20
 	bc->table_init_done =3D true;
=20
-	bc->shrink.seeks		=3D 0;
-	bc->shrink.count_objects	=3D bch2_btree_key_cache_count;
-	bc->shrink.scan_objects		=3D bch2_btree_key_cache_scan;
-	if (register_shrinker(&bc->shrink, "%s/btree_key_cache", c->name))
+	shrink =3D shrinker_alloc(0, "%s/btree_key_cache", c->name);
+	if (!shrink)
 		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
+	bc->shrink =3D shrink;
+	shrink->seeks		=3D 0;
+	shrink->count_objects	=3D bch2_btree_key_cache_count;
+	shrink->scan_objects	=3D bch2_btree_key_cache_scan;
+	shrinker_register(shrink);
 	return 0;
 }
=20
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index 70398aaa095e..fac0abdaf167 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -163,7 +163,7 @@ struct btree_cache {
 	unsigned		used;
 	unsigned		reserve;
 	atomic_t		dirty;
-	struct shrinker		shrink;
+	struct shrinker		*shrink;
=20
 	/*
 	 * If we need to allocate memory for a new btree node and that
@@ -321,7 +321,7 @@ struct btree_key_cache {
 	bool			table_init_done;
 	struct list_head	freed_pcpu;
 	struct list_head	freed_nonpcpu;
-	struct shrinker		shrink;
+	struct shrinker		*shrink;
 	unsigned		shrink_iter;
 	struct btree_key_cache_freelist __percpu *pcpu_freed;
=20
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 48431700b83e..bdc8573631bd 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1885,7 +1885,7 @@ static struct dentry *bch2_mount(struct file_system_t=
ype *fs_type,
 		sb->s_flags	|=3D SB_POSIXACL;
 #endif
=20
-	sb->s_shrink.seeks =3D 0;
+	sb->s_shrink->seeks =3D 0;
=20
 	vinode =3D bch2_vfs_inode_get(c, BCACHEFS_ROOT_SUBVOL_INUM);
 	ret =3D PTR_ERR_OR_ZERO(vinode);
diff --git a/fs/bcachefs/sysfs.c b/fs/bcachefs/sysfs.c
index 41c6900c34c1..a9f480c26bb4 100644
--- a/fs/bcachefs/sysfs.c
+++ b/fs/bcachefs/sysfs.c
@@ -522,7 +522,7 @@ STORE(bch2_fs)
=20
 		sc.gfp_mask =3D GFP_KERNEL;
 		sc.nr_to_scan =3D strtoul_or_return(buf);
-		c->btree_cache.shrink.scan_objects(&c->btree_cache.shrink, &sc);
+		c->btree_cache.shrink->scan_objects(c->btree_cache.shrink, &sc);
 	}
=20
 	if (attr =3D=3D &sysfs_btree_wakeup)
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/HyO/wwY.250W_1EDD7kIjHg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT/xy0ACgkQAVBC80lX
0GyS5QgAo/VyB0n0K9oHwrW66ClrcZlog5az4zDvUTBaHMU6su2FMwVXjuvE016r
XiOlZ9TMaS/UyEXHcXZZ0oMhEuaV2yeiaunOusNtqW4a3KshjabbGuSUrFBp3H0N
lgJvRmYdoreNWfqz+UcXYi1YvEFQTC3ZdErRgRGmUN3pFporI678+nvM/t5hJiRP
H9rE/guN69WwSWqArzFcVl2/t5ZNnWuECBJa9dfXgZBbh03c2UezOS2Go+KWyHeC
g/4ahCfOtfNCDoHNfe/b9MzI43p3RS3t1beRNRc5Kuwb8a0hvgihYpHlCb2vSB8G
X2UJboYKfi2p35W51HV4YpywS7mEoA==
=hMdR
-----END PGP SIGNATURE-----

--Sig_/HyO/wwY.250W_1EDD7kIjHg--
