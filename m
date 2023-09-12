Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C4579DCBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjILXgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjILXgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:36:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9708710FE;
        Tue, 12 Sep 2023 16:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694561754;
        bh=KkBsaVN+fDNMy80brOyqyKoFlUZSHaDWIBvGFbtv2Xs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iFOOhfV3OMQ3FY/MfhY51GVq88OPVS/XHHZXabLfI2dqrjouJXCCT3QBroA37AHeT
         ShwU4tu439XcXPnPFC4bLGeoQ0BImuCWfPm0W1uGPan/e2R0kYUdgXbiknxQ5rAOUi
         +hVLBbHPwiPjbcRYl3+mlXleIPlbcc9wdU5Uo406oJDFfdjxKVk2PCt2pYesxKGz9x
         dimRL0szfQoUTJbo9nBwbOUTBiDvfr0geaK92jSPORbi2uOBU7DcLN0PA+OBs3F/Qk
         G73BZJ+y1SwuyoTUc4InJvLDjuqIBTgxenHrbghBjfu9c4FDNvbdUFLGf3cwofCvQv
         LyBgcH3EGcwfw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rlg220RWjz4xQS;
        Wed, 13 Sep 2023 09:35:53 +1000 (AEST)
Date:   Wed, 13 Sep 2023 09:35:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20230913093553.4290421e@canb.auug.org.au>
In-Reply-To: <e639a428-0fb7-7329-ce52-e51f7951a146@bytedance.com>
References: <20230912120429.7852428f@canb.auug.org.au>
        <e639a428-0fb7-7329-ce52-e51f7951a146@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fLuG7pKUkf67P==WhOEW3n6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fLuG7pKUkf67P==WhOEW3n6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Qi,

Thanks for the corrections.  See below.

On Tue, 12 Sep 2023 10:47:14 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wr=
ote:
>
> > diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
> > index 245ddd92b2d1..7f0eded6c296 100644
> > --- a/fs/bcachefs/btree_cache.c
> > +++ b/fs/bcachefs/btree_cache.c
> > @@ -285,7 +285,7 @@ static int btree_node_write_and_reclaim(struct bch_=
fs *c, struct btree *b)
> >   static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
> >   					   struct shrink_control *sc)
> >   {
> > -	struct bch_fs *c =3D container_of(shrink, struct bch_fs,
> > +	struct bch_fs *c =3D container_of(&shrink, struct bch_fs,
> >   					btree_cache.shrink); =20
>=20
> The shrink passed in here will be a local variable, so its address can
> not be used directly. So need to be modified as follows:
>=20
> 	struct bch_fs *c =3D shrink->private_data;

OK.

> > @@ -384,7 +384,7 @@ static unsigned long bch2_btree_cache_scan(struct s=
hrinker *shrink,
> >   static unsigned long bch2_btree_cache_count(struct shrinker *shrink,
> >   					    struct shrink_control *sc)
> >   {
> > -	struct bch_fs *c =3D container_of(shrink, struct bch_fs,
> > +	struct bch_fs *c =3D container_of(&shrink, struct bch_fs,
> >   					btree_cache.shrink); =20
>=20
> Ditto.

OK

> >   > @@ -473,12 +474,14 @@ int bch2_fs_btree_cache_init(struct bch_fs *c)
> >   >   	mutex_init(&c->verify_lock);
> >   > -	bc->shrink.count_objects	=3D bch2_btree_cache_count; =20
> > -	bc->shrink.scan_objects		=3D bch2_btree_cache_scan;
> > -	bc->shrink.seeks		=3D 4;
> > -	ret =3D register_shrinker(&bc->shrink, "%s/btree_cache", c->name);
> > -	if (ret)
> > +	shrink =3D shrinker_alloc(0, "%s/btree_cache", c->name);
> > +	if (!shrink)
> >   		goto err; =20
>=20
> Here the 'ret' needs to be set to -ENOMEM.
>=20
> 	if (!shrink) {
> 		ret =3D -ENOMEM;
> 		goto err;
> 	}

Except err: does this:

    return -BCH_ERR_ENOMEM_fs_btree_cache_init;

so ret does not need to be set.

> > +	bc->shrink =3D shrink;
> > +	shrink->count_objects	=3D bch2_btree_cache_count;
> > +	shrink->scan_objects	=3D bch2_btree_cache_scan;
> > +	shrink->seeks		=3D 4; =20
>=20
> 	shrink->private_data =3D c;

OK

> > diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cach=
e.c
> > index 505e7c365ab7..88d33690233b 100644
> > --- a/fs/bcachefs/btree_key_cache.c
> > +++ b/fs/bcachefs/btree_key_cache.c
> > @@ -838,7 +838,7 @@ void bch2_btree_key_cache_drop(struct btree_trans *=
trans,
> >   static unsigned long bch2_btree_key_cache_scan(struct shrinker *shrin=
k,
> >   					   struct shrink_control *sc)
> >   {
> > -	struct bch_fs *c =3D container_of(shrink, struct bch_fs,
> > +	struct bch_fs *c =3D container_of(&shrink, struct bch_fs,
> >   					btree_key_cache.shrink); =20
>=20
> 	struct bch_fs *c =3D shrink->private_data;
>=20

OK

> > @@ -936,7 +936,7 @@ static unsigned long bch2_btree_key_cache_scan(stru=
ct shrinker *shrink,
> >   static unsigned long bch2_btree_key_cache_count(struct shrinker *shri=
nk,
> >   					    struct shrink_control *sc)
> >   {
> > -	struct bch_fs *c =3D container_of(shrink, struct bch_fs,
> > +	struct bch_fs *c =3D container_of(&shrink, struct bch_fs,
> >   					btree_key_cache.shrink); =20
>=20
> Ditto.

OK

> > @@ -957,7 +957,7 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_=
cache *bc)
> >   	int cpu;
> >   #endif =20
> >   > -	unregister_shrinker(&bc->shrink); =20
> > +	shrinker_free(bc->shrink); =20
> >   >   	mutex_lock(&bc->lock);
> >   > @@ -1031,6 +1031,7 @@ void bch2_fs_btree_key_cache_init_early(struc=
t btree_key_cache *c) =20
> >   int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
> >   {
> >   	struct bch_fs *c =3D container_of(bc, struct bch_fs, btree_key_cache=
);
> > +	struct shrinker *shrink; =20
> >   >   #ifdef __KERNEL__ =20
> >   	bc->pcpu_freed =3D alloc_percpu(struct btree_key_cache_freelist);
> > @@ -1043,11 +1044,14 @@ int bch2_fs_btree_key_cache_init(struct btree_k=
ey_cache *bc) =20
>=20
> 	struct bch_fs *c =3D container_of(bc, struct bch_fs, btree_key_cache);

Already done n this function.

> >   >   	bc->table_init_done =3D true;
> >   > -	bc->shrink.seeks		=3D 0; =20
> > -	bc->shrink.count_objects	=3D bch2_btree_key_cache_count;
> > -	bc->shrink.scan_objects		=3D bch2_btree_key_cache_scan;
> > -	if (register_shrinker(&bc->shrink, "%s/btree_key_cache", c->name))
> > +	shrink =3D shrinker_alloc(0, "%s/btree_key_cache", c->name);
> > +	if (!shrink)
> >   		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
> > +	bc->shrink =3D shrink;
> > +	shrink->seeks		=3D 0;
> > +	shrink->count_objects	=3D bch2_btree_key_cache_count;
> > +	shrink->scan_objects	=3D bch2_btree_key_cache_scan; =20
>=20
> 	shrink->private_data =3D c;

OK

So the merge resolution patch now looks like this:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 12 Sep 2023 11:27:22 +1000
Subject: [PATCH] bcachefs: convert to dynamically allocated shrinkers

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/bcachefs/btree_cache.c     | 22 ++++++++++++----------
 fs/bcachefs/btree_key_cache.c | 21 ++++++++++++---------
 fs/bcachefs/btree_types.h     |  4 ++--
 fs/bcachefs/fs.c              |  2 +-
 fs/bcachefs/sysfs.c           |  2 +-
 5 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
index 245ddd92b2d1..d8cd0bbc33cc 100644
--- a/fs/bcachefs/btree_cache.c
+++ b/fs/bcachefs/btree_cache.c
@@ -285,8 +285,7 @@ static int btree_node_write_and_reclaim(struct bch_fs *=
c, struct btree *b)
 static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
 					   struct shrink_control *sc)
 {
-	struct bch_fs *c =3D container_of(shrink, struct bch_fs,
-					btree_cache.shrink);
+	struct bch_fs *c =3D shrink->private_data;
 	struct btree_cache *bc =3D &c->btree_cache;
 	struct btree *b, *t;
 	unsigned long nr =3D sc->nr_to_scan;
@@ -384,8 +383,7 @@ static unsigned long bch2_btree_cache_scan(struct shrin=
ker *shrink,
 static unsigned long bch2_btree_cache_count(struct shrinker *shrink,
 					    struct shrink_control *sc)
 {
-	struct bch_fs *c =3D container_of(shrink, struct bch_fs,
-					btree_cache.shrink);
+	struct bch_fs *c =3D shrink->private_data;
 	struct btree_cache *bc =3D &c->btree_cache;
=20
 	if (bch2_btree_shrinker_disabled)
@@ -400,7 +398,7 @@ void bch2_fs_btree_cache_exit(struct bch_fs *c)
 	struct btree *b;
 	unsigned i, flags;
=20
-	unregister_shrinker(&bc->shrink);
+	shrinker_free(bc->shrink);
=20
 	/* vfree() can allocate memory: */
 	flags =3D memalloc_nofs_save();
@@ -454,6 +452,7 @@ void bch2_fs_btree_cache_exit(struct bch_fs *c)
 int bch2_fs_btree_cache_init(struct bch_fs *c)
 {
 	struct btree_cache *bc =3D &c->btree_cache;
+	struct shrinker *shrink;
 	unsigned i;
 	int ret =3D 0;
=20
@@ -473,12 +472,15 @@ int bch2_fs_btree_cache_init(struct bch_fs *c)
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
+	shrink->private_data	=3D c;
+	shrinker_register(shrink);
=20
 	return 0;
 err:
diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
index 505e7c365ab7..ed387eb915c3 100644
--- a/fs/bcachefs/btree_key_cache.c
+++ b/fs/bcachefs/btree_key_cache.c
@@ -838,8 +838,7 @@ void bch2_btree_key_cache_drop(struct btree_trans *tran=
s,
 static unsigned long bch2_btree_key_cache_scan(struct shrinker *shrink,
 					   struct shrink_control *sc)
 {
-	struct bch_fs *c =3D container_of(shrink, struct bch_fs,
-					btree_key_cache.shrink);
+	struct bch_fs *c =3D shrink->private_data;
 	struct btree_key_cache *bc =3D &c->btree_key_cache;
 	struct bucket_table *tbl;
 	struct bkey_cached *ck, *t;
@@ -936,8 +935,7 @@ static unsigned long bch2_btree_key_cache_scan(struct s=
hrinker *shrink,
 static unsigned long bch2_btree_key_cache_count(struct shrinker *shrink,
 					    struct shrink_control *sc)
 {
-	struct bch_fs *c =3D container_of(shrink, struct bch_fs,
-					btree_key_cache.shrink);
+	struct bch_fs *c =3D shrink->private_data;
 	struct btree_key_cache *bc =3D &c->btree_key_cache;
 	long nr =3D atomic_long_read(&bc->nr_keys) -
 		atomic_long_read(&bc->nr_dirty);
@@ -957,7 +955,7 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_cach=
e *bc)
 	int cpu;
 #endif
=20
-	unregister_shrinker(&bc->shrink);
+	shrinker_free(bc->shrink);
=20
 	mutex_lock(&bc->lock);
=20
@@ -1031,6 +1029,7 @@ void bch2_fs_btree_key_cache_init_early(struct btree_=
key_cache *c)
 int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
 {
 	struct bch_fs *c =3D container_of(bc, struct bch_fs, btree_key_cache);
+	struct shrinker *shrink;
=20
 #ifdef __KERNEL__
 	bc->pcpu_freed =3D alloc_percpu(struct btree_key_cache_freelist);
@@ -1043,11 +1042,15 @@ int bch2_fs_btree_key_cache_init(struct btree_key_c=
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
+	shrink->private_data	=3D c;
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

--Sig_/fLuG7pKUkf67P==WhOEW3n6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUA9dkACgkQAVBC80lX
0Gw/9wf/QBwJjMHh0bCVq9dstwCCkDvL/Vi/bHIfaU2/AusHSSA5a77sQdjCipJo
Exj+w96SyTpP6baNOKmJ0WMAHxtOgvrnzMxyz9YH2FRLzm5avb3E/sNMVzDGNJRy
r7PX1mEBDVHh2GEYjkz4C+ssrTZFc2tPfIoPXC5EJPmfulKS9amuyq+k9JUybGjz
bJQRnUrzeM4h3y2w1ALw/UiIZ0cnkHmxbjieUdbb7qq0bP3qnx7izHjHqz6H+pgN
O5TC2iKjUOaSpRUfHA27bfmngGkzOYskdtUmZYJDJApH69RvLE0UUmWIgIG6rvFn
yN2Hvqkl0dyH2wxvx42IHgxiKvcvQg==
=g9xX
-----END PGP SIGNATURE-----

--Sig_/fLuG7pKUkf67P==WhOEW3n6--
