Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6797F547D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjKVXZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjKVXZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:25:40 -0500
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CFF1B3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:25:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700695531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NMfXBsonhz+ezAg3sKaNXQeyap2g8yZZq48bhQ7Wec=;
        b=L/6Ssih/O7QhT9069T31VThCTNukc3MMvLU+/VMAZ3jnXRJbm6rGc+TMETY0offdQtngVp
        6jDxcKMISPFQdNLC7MDtwdDuraODTV+7GC8ozeT/P6g2dMkS3qcUJPEzMFbmowqy23RWPc
        TvwAmvR6OWymxacMWlUCPuncKjfbn0Y=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Daniel Hill <daniel@gluo.nz>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 7/7] bcachefs: add counters for failed shrinker reclaim
Date:   Wed, 22 Nov 2023 18:25:12 -0500
Message-ID: <20231122232515.177833-8-kent.overstreet@linux.dev>
In-Reply-To: <20231122232515.177833-1-kent.overstreet@linux.dev>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Hill <daniel@gluo.nz>

This adds distinct counters for every reason the btree node shrinker can
fail to free an object - if our shrinker isn't making progress, this
will tell us why.

Signed-off-by: Daniel Hill <daniel@gluo.nz>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/btree_cache.c | 91 +++++++++++++++++++++++++++++----------
 fs/bcachefs/btree_cache.h |  2 +-
 fs/bcachefs/btree_types.h | 10 +++++
 fs/bcachefs/sysfs.c       |  2 +-
 4 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
index aab279dff944..72dea90e12fa 100644
--- a/fs/bcachefs/btree_cache.c
+++ b/fs/bcachefs/btree_cache.c
@@ -15,6 +15,12 @@
 #include <linux/sched/mm.h>
 #include <linux/seq_buf.h>
 
+#define BTREE_CACHE_NOT_FREED_INCREMENT(counter) \
+do {						 \
+	if (shrinker_counter)			 \
+		bc->not_freed_##counter++;	 \
+} while (0)
+
 const char * const bch2_btree_node_flags[] = {
 #define x(f)	#f,
 	BTREE_FLAGS()
@@ -202,7 +208,7 @@ static inline struct btree *btree_cache_find(struct btree_cache *bc,
  * this version is for btree nodes that have already been freed (we're not
  * reaping a real btree node)
  */
-static int __btree_node_reclaim(struct bch_fs *c, struct btree *b, bool flush)
+static int __btree_node_reclaim(struct bch_fs *c, struct btree *b, bool flush, bool shrinker_counter)
 {
 	struct btree_cache *bc = &c->btree_cache;
 	int ret = 0;
@@ -212,38 +218,64 @@ static int __btree_node_reclaim(struct bch_fs *c, struct btree *b, bool flush)
 	if (b->flags & ((1U << BTREE_NODE_dirty)|
 			(1U << BTREE_NODE_read_in_flight)|
 			(1U << BTREE_NODE_write_in_flight))) {
-		if (!flush)
+		if (!flush) {
+			if (btree_node_dirty(b))
+				BTREE_CACHE_NOT_FREED_INCREMENT(dirty);
+			else if (btree_node_read_in_flight(b))
+				BTREE_CACHE_NOT_FREED_INCREMENT(read_in_flight);
+			else if (btree_node_write_in_flight(b))
+				BTREE_CACHE_NOT_FREED_INCREMENT(write_in_flight);
 			return -BCH_ERR_ENOMEM_btree_node_reclaim;
+		}
 
 		/* XXX: waiting on IO with btree cache lock held */
 		bch2_btree_node_wait_on_read(b);
 		bch2_btree_node_wait_on_write(b);
 	}
 
-	if (!six_trylock_intent(&b->c.lock))
+	if (!six_trylock_intent(&b->c.lock)) {
+		BTREE_CACHE_NOT_FREED_INCREMENT(lock_intent);
 		return -BCH_ERR_ENOMEM_btree_node_reclaim;
+	}
 
-	if (!six_trylock_write(&b->c.lock))
+	if (!six_trylock_write(&b->c.lock)) {
+		BTREE_CACHE_NOT_FREED_INCREMENT(lock_write);
 		goto out_unlock_intent;
+	}
 
 	/* recheck under lock */
 	if (b->flags & ((1U << BTREE_NODE_read_in_flight)|
 			(1U << BTREE_NODE_write_in_flight))) {
-		if (!flush)
+		if (!flush) {
+			if (btree_node_read_in_flight(b))
+				BTREE_CACHE_NOT_FREED_INCREMENT(read_in_flight);
+			else if (btree_node_write_in_flight(b))
+				BTREE_CACHE_NOT_FREED_INCREMENT(write_in_flight);
 			goto out_unlock;
+		}
 		six_unlock_write(&b->c.lock);
 		six_unlock_intent(&b->c.lock);
 		goto wait_on_io;
 	}
 
-	if (btree_node_noevict(b) ||
-	    btree_node_write_blocked(b) ||
-	    btree_node_will_make_reachable(b))
+	if (btree_node_noevict(b)) {
+		BTREE_CACHE_NOT_FREED_INCREMENT(noevict);
+		goto out_unlock;
+	}
+	if (btree_node_write_blocked(b)) {
+		BTREE_CACHE_NOT_FREED_INCREMENT(write_blocked);
+		goto out_unlock;
+	}
+	if (btree_node_will_make_reachable(b)) {
+		BTREE_CACHE_NOT_FREED_INCREMENT(will_make_reachable);
 		goto out_unlock;
+	}
 
 	if (btree_node_dirty(b)) {
-		if (!flush)
+		if (!flush) {
+			BTREE_CACHE_NOT_FREED_INCREMENT(dirty);
 			goto out_unlock;
+		}
 		/*
 		 * Using the underscore version because we don't want to compact
 		 * bsets after the write, since this node is about to be evicted
@@ -273,14 +305,14 @@ static int __btree_node_reclaim(struct bch_fs *c, struct btree *b, bool flush)
 	goto out;
 }
 
-static int btree_node_reclaim(struct bch_fs *c, struct btree *b)
+static int btree_node_reclaim(struct bch_fs *c, struct btree *b, bool shrinker_counter)
 {
-	return __btree_node_reclaim(c, b, false);
+	return __btree_node_reclaim(c, b, false, shrinker_counter);
 }
 
 static int btree_node_write_and_reclaim(struct bch_fs *c, struct btree *b)
 {
-	return __btree_node_reclaim(c, b, true);
+	return __btree_node_reclaim(c, b, true, false);
 }
 
 static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
@@ -328,11 +360,12 @@ static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
 		if (touched >= nr)
 			goto out;
 
-		if (!btree_node_reclaim(c, b)) {
+		if (!btree_node_reclaim(c, b, true)) {
 			btree_node_data_free(c, b);
 			six_unlock_write(&b->c.lock);
 			six_unlock_intent(&b->c.lock);
 			freed++;
+			bc->freed++;
 		}
 	}
 restart:
@@ -341,9 +374,11 @@ static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
 
 		if (btree_node_accessed(b)) {
 			clear_btree_node_accessed(b);
-		} else if (!btree_node_reclaim(c, b)) {
+			bc->not_freed_access_bit++;
+		} else if (!btree_node_reclaim(c, b, true)) {
 			freed++;
 			btree_node_data_free(c, b);
+			bc->freed++;
 
 			bch2_btree_node_hash_remove(bc, b);
 			six_unlock_write(&b->c.lock);
@@ -400,7 +435,7 @@ static void bch2_btree_cache_shrinker_to_text(struct seq_buf *s, struct shrinker
 	size_t buflen = seq_buf_get_buf(s, &cbuf);
 	struct printbuf out = PRINTBUF_EXTERN(cbuf, buflen);
 
-	bch2_btree_cache_to_text(&out, c);
+	bch2_btree_cache_to_text(&out, &c->btree_cache);
 	seq_buf_commit(s, out.pos);
 }
 
@@ -564,7 +599,7 @@ static struct btree *btree_node_cannibalize(struct bch_fs *c)
 	struct btree *b;
 
 	list_for_each_entry_reverse(b, &bc->live, list)
-		if (!btree_node_reclaim(c, b))
+		if (!btree_node_reclaim(c, b, false))
 			return b;
 
 	while (1) {
@@ -600,7 +635,7 @@ struct btree *bch2_btree_node_mem_alloc(struct btree_trans *trans, bool pcpu_rea
 	 * disk node. Check the freed list before allocating a new one:
 	 */
 	list_for_each_entry(b, freed, list)
-		if (!btree_node_reclaim(c, b)) {
+		if (!btree_node_reclaim(c, b, false)) {
 			list_del_init(&b->list);
 			goto got_node;
 		}
@@ -626,7 +661,7 @@ struct btree *bch2_btree_node_mem_alloc(struct btree_trans *trans, bool pcpu_rea
 	 * the list. Check if there's any freed nodes there:
 	 */
 	list_for_each_entry(b2, &bc->freeable, list)
-		if (!btree_node_reclaim(c, b2)) {
+		if (!btree_node_reclaim(c, b2, false)) {
 			swap(b->data, b2->data);
 			swap(b->aux_data, b2->aux_data);
 			btree_node_to_freedlist(bc, b2);
@@ -1222,9 +1257,21 @@ void bch2_btree_node_to_text(struct printbuf *out, struct bch_fs *c, const struc
 	       stats.failed);
 }
 
-void bch2_btree_cache_to_text(struct printbuf *out, const struct bch_fs *c)
+void bch2_btree_cache_to_text(struct printbuf *out, const struct btree_cache *bc)
 {
-	prt_printf(out, "nr nodes:\t\t%u\n", c->btree_cache.used);
-	prt_printf(out, "nr dirty:\t\t%u\n", atomic_read(&c->btree_cache.dirty));
-	prt_printf(out, "cannibalize lock:\t%p\n", c->btree_cache.alloc_lock);
+	prt_printf(out, "nr nodes:\t\t%u\n", bc->used);
+	prt_printf(out, "nr dirty:\t\t%u\n", atomic_read(&bc->dirty));
+	prt_printf(out, "cannibalize lock:\t%p\n", bc->alloc_lock);
+
+	prt_printf(out, "freed:\t\t\t\t%u\n", bc->freed);
+	prt_printf(out, "not freed, dirty:\t\t%u\n", bc->not_freed_dirty);
+	prt_printf(out, "not freed, write in flight:\t%u\n", bc->not_freed_write_in_flight);
+	prt_printf(out, "not freed, read in flight:\t%u\n", bc->not_freed_read_in_flight);
+	prt_printf(out, "not freed, lock intent failed:\t%u\n", bc->not_freed_lock_intent);
+	prt_printf(out, "not freed, lock write failed:\t%u\n", bc->not_freed_lock_write);
+	prt_printf(out, "not freed, access bit:\t\t%u\n", bc->not_freed_access_bit);
+	prt_printf(out, "not freed, no evict failed:\t%u\n", bc->not_freed_noevict);
+	prt_printf(out, "not freed, write blocked:\t%u\n", bc->not_freed_write_blocked);
+	prt_printf(out, "not freed, will make reachable:\t%u\n", bc->not_freed_will_make_reachable);
+
 }
diff --git a/fs/bcachefs/btree_cache.h b/fs/bcachefs/btree_cache.h
index cfb80b201d61..bfe1d7482cbc 100644
--- a/fs/bcachefs/btree_cache.h
+++ b/fs/bcachefs/btree_cache.h
@@ -126,6 +126,6 @@ static inline struct btree *btree_node_root(struct bch_fs *c, struct btree *b)
 const char *bch2_btree_id_str(enum btree_id);
 void bch2_btree_pos_to_text(struct printbuf *, struct bch_fs *, const struct btree *);
 void bch2_btree_node_to_text(struct printbuf *, struct bch_fs *, const struct btree *);
-void bch2_btree_cache_to_text(struct printbuf *, const struct bch_fs *);
+void bch2_btree_cache_to_text(struct printbuf *, const struct btree_cache *);
 
 #endif /* _BCACHEFS_BTREE_CACHE_H */
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index 2326bceb34f8..14983e778756 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -162,6 +162,16 @@ struct btree_cache {
 	/* Number of elements in live + freeable lists */
 	unsigned		used;
 	unsigned		reserve;
+	unsigned		freed;
+	unsigned		not_freed_lock_intent;
+	unsigned		not_freed_lock_write;
+	unsigned		not_freed_dirty;
+	unsigned		not_freed_read_in_flight;
+	unsigned		not_freed_write_in_flight;
+	unsigned		not_freed_noevict;
+	unsigned		not_freed_write_blocked;
+	unsigned		not_freed_will_make_reachable;
+	unsigned		not_freed_access_bit;
 	atomic_t		dirty;
 	struct shrinker		*shrink;
 
diff --git a/fs/bcachefs/sysfs.c b/fs/bcachefs/sysfs.c
index ab743115f169..264c46b456c2 100644
--- a/fs/bcachefs/sysfs.c
+++ b/fs/bcachefs/sysfs.c
@@ -402,7 +402,7 @@ SHOW(bch2_fs)
 		bch2_btree_updates_to_text(out, c);
 
 	if (attr == &sysfs_btree_cache)
-		bch2_btree_cache_to_text(out, c);
+		bch2_btree_cache_to_text(out, &c->btree_cache);
 
 	if (attr == &sysfs_btree_key_cache)
 		bch2_btree_key_cache_to_text(out, &c->btree_key_cache);
-- 
2.42.0

