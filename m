Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AB97DE7BD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343861AbjKAV5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjKAV47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:56:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153B6119;
        Wed,  1 Nov 2023 14:56:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88281C433C7;
        Wed,  1 Nov 2023 21:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698875813;
        bh=gno+Qq/S9t9Xx5vxCvbTys4gMgigrQ0DXVdnE3+iPpM=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=bnATcLlHnN/ATGsZYeuY1BQo/UULv5rGPJqin6da2KuPN1eZf/fcyMERYs8hh4hNv
         j09w+KxpI7ufcxWwezOQHRobfvkvcaotLlJuxFgx6neniBvAwKlVD96CGvykoZbP2P
         gJ3lR+JBYvKB0YmtJz9aLa46axH3ZqmVmwNFVKo8=
Date:   Wed, 1 Nov 2023 14:56:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] MM updates for 6.7-rc1
Message-Id: <20231101145652.8ff234ca6c327c5e49e2b21f@linux-foundation.org>
In-Reply-To: <20231101145447.60320c9044e7db4dba2d93e3@linux-foundation.org>
References: <20231101145447.60320c9044e7db4dba2d93e3@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 14:54:47 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> vs bcachefs tree
> 	https://lkml.kernel.org/r/20230913093553.4290421e@canb.auug.org.au
> 	I shall send Stephen's conversion patch in reply to this email.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: bcachefs: convert to dynamically allocated shrinkers
Date: Tue, 12 Sep 2023 11:27:22 +1000

Link: https://lkml.kernel.org/r/20230913093553.4290421e@canb.auug.org.au
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/bcachefs/btree_cache.c     |   22 ++++++++++++----------
 fs/bcachefs/btree_key_cache.c |   21 ++++++++++++---------
 fs/bcachefs/btree_types.h     |    4 ++--
 fs/bcachefs/fs.c              |    2 +-
 fs/bcachefs/sysfs.c           |    2 +-
 5 files changed, 28 insertions(+), 23 deletions(-)

--- a/fs/bcachefs/btree_cache.c~bcachefs-convert-to-dynamically-allocated-shrinkers
+++ a/fs/bcachefs/btree_cache.c
@@ -285,8 +285,7 @@ static int btree_node_write_and_reclaim(
 static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
 					   struct shrink_control *sc)
 {
-	struct bch_fs *c = container_of(shrink, struct bch_fs,
-					btree_cache.shrink);
+	struct bch_fs *c = shrink->private_data;
 	struct btree_cache *bc = &c->btree_cache;
 	struct btree *b, *t;
 	unsigned long nr = sc->nr_to_scan;
@@ -384,8 +383,7 @@ out_nounlock:
 static unsigned long bch2_btree_cache_count(struct shrinker *shrink,
 					    struct shrink_control *sc)
 {
-	struct bch_fs *c = container_of(shrink, struct bch_fs,
-					btree_cache.shrink);
+	struct bch_fs *c = shrink->private_data;
 	struct btree_cache *bc = &c->btree_cache;
 
 	if (bch2_btree_shrinker_disabled)
@@ -400,7 +398,7 @@ void bch2_fs_btree_cache_exit(struct bch
 	struct btree *b;
 	unsigned i, flags;
 
-	unregister_shrinker(&bc->shrink);
+	shrinker_free(bc->shrink);
 
 	/* vfree() can allocate memory: */
 	flags = memalloc_nofs_save();
@@ -454,6 +452,7 @@ void bch2_fs_btree_cache_exit(struct bch
 int bch2_fs_btree_cache_init(struct bch_fs *c)
 {
 	struct btree_cache *bc = &c->btree_cache;
+	struct shrinker *shrink;
 	unsigned i;
 	int ret = 0;
 
@@ -473,12 +472,15 @@ int bch2_fs_btree_cache_init(struct bch_
 
 	mutex_init(&c->verify_lock);
 
-	bc->shrink.count_objects	= bch2_btree_cache_count;
-	bc->shrink.scan_objects		= bch2_btree_cache_scan;
-	bc->shrink.seeks		= 4;
-	ret = register_shrinker(&bc->shrink, "%s/btree_cache", c->name);
-	if (ret)
+	shrink = shrinker_alloc(0, "%s/btree_cache", c->name);
+	if (!shrink)
 		goto err;
+	bc->shrink = shrink;
+	shrink->count_objects	= bch2_btree_cache_count;
+	shrink->scan_objects	= bch2_btree_cache_scan;
+	shrink->seeks		= 4;
+	shrink->private_data	= c;
+	shrinker_register(shrink);
 
 	return 0;
 err:
--- a/fs/bcachefs/btree_key_cache.c~bcachefs-convert-to-dynamically-allocated-shrinkers
+++ a/fs/bcachefs/btree_key_cache.c
@@ -834,8 +834,7 @@ void bch2_btree_key_cache_drop(struct bt
 static unsigned long bch2_btree_key_cache_scan(struct shrinker *shrink,
 					   struct shrink_control *sc)
 {
-	struct bch_fs *c = container_of(shrink, struct bch_fs,
-					btree_key_cache.shrink);
+	struct bch_fs *c = shrink->private_data;
 	struct btree_key_cache *bc = &c->btree_key_cache;
 	struct bucket_table *tbl;
 	struct bkey_cached *ck, *t;
@@ -932,8 +931,7 @@ out:
 static unsigned long bch2_btree_key_cache_count(struct shrinker *shrink,
 					    struct shrink_control *sc)
 {
-	struct bch_fs *c = container_of(shrink, struct bch_fs,
-					btree_key_cache.shrink);
+	struct bch_fs *c = shrink->private_data;
 	struct btree_key_cache *bc = &c->btree_key_cache;
 	long nr = atomic_long_read(&bc->nr_keys) -
 		atomic_long_read(&bc->nr_dirty);
@@ -953,7 +951,7 @@ void bch2_fs_btree_key_cache_exit(struct
 	int cpu;
 #endif
 
-	unregister_shrinker(&bc->shrink);
+	shrinker_free(bc->shrink);
 
 	mutex_lock(&bc->lock);
 
@@ -1027,6 +1025,7 @@ void bch2_fs_btree_key_cache_init_early(
 int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
 {
 	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
+	struct shrinker *shrink;
 
 #ifdef __KERNEL__
 	bc->pcpu_freed = alloc_percpu(struct btree_key_cache_freelist);
@@ -1039,11 +1038,15 @@ int bch2_fs_btree_key_cache_init(struct
 
 	bc->table_init_done = true;
 
-	bc->shrink.seeks		= 0;
-	bc->shrink.count_objects	= bch2_btree_key_cache_count;
-	bc->shrink.scan_objects		= bch2_btree_key_cache_scan;
-	if (register_shrinker(&bc->shrink, "%s/btree_key_cache", c->name))
+	shrink = shrinker_alloc(0, "%s/btree_key_cache", c->name);
+	if (!shrink)
 		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
+	bc->shrink = shrink;
+	shrink->seeks		= 0;
+	shrink->count_objects	= bch2_btree_key_cache_count;
+	shrink->scan_objects	= bch2_btree_key_cache_scan;
+	shrink->private_data	= c;
+	shrinker_register(shrink);
 	return 0;
 }
 
--- a/fs/bcachefs/btree_types.h~bcachefs-convert-to-dynamically-allocated-shrinkers
+++ a/fs/bcachefs/btree_types.h
@@ -163,7 +163,7 @@ struct btree_cache {
 	unsigned		used;
 	unsigned		reserve;
 	atomic_t		dirty;
-	struct shrinker		shrink;
+	struct shrinker		*shrink;
 
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
 
--- a/fs/bcachefs/fs.c~bcachefs-convert-to-dynamically-allocated-shrinkers
+++ a/fs/bcachefs/fs.c
@@ -1904,7 +1904,7 @@ got_sb:
 		sb->s_flags	|= SB_POSIXACL;
 #endif
 
-	sb->s_shrink.seeks = 0;
+	sb->s_shrink->seeks = 0;
 
 	vinode = bch2_vfs_inode_get(c, BCACHEFS_ROOT_SUBVOL_INUM);
 	ret = PTR_ERR_OR_ZERO(vinode);
--- a/fs/bcachefs/sysfs.c~bcachefs-convert-to-dynamically-allocated-shrinkers
+++ a/fs/bcachefs/sysfs.c
@@ -494,7 +494,7 @@ STORE(bch2_fs)
 
 		sc.gfp_mask = GFP_KERNEL;
 		sc.nr_to_scan = strtoul_or_return(buf);
-		c->btree_cache.shrink.scan_objects(&c->btree_cache.shrink, &sc);
+		c->btree_cache.shrink->scan_objects(c->btree_cache.shrink, &sc);
 	}
 
 	if (attr == &sysfs_btree_wakeup)
_

