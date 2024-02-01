Return-Path: <linux-kernel+bounces-48447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643B3845C25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C76829B6DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287B115F313;
	Thu,  1 Feb 2024 15:50:45 +0000 (UTC)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4C15F30C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802644; cv=none; b=A3XssTVtrnUOtaCq8VZDNnq0UtTe6Y2xFftR6AL893JIAGNPLXhcSX6XSQeRhXCoL4I84hLOv7UlHnb6AVFPA4YStv9lYS8xJFKYfIrBMZU7cFBkSdVgfBen2govlBk/2VDXifNe5r2TBVCRjfDd6qEvuki12+f8cWrQsthppVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802644; c=relaxed/simple;
	bh=zBvxp3bCJ9K1CLS/F5jZOmWaBn4ykFxftOcDi63IcHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7a02oeAIDasIIQ4b7OsaYUnXQgWhciPTqs8rflsFjDPDfnz4tM33s4/TrwjR0pE9Hz/RU/qTujbnapQAfRo8RY9NZYiv3sqr/XeR1KapTFEegF2MeP0ti7KfTh2uWLUQcXGylO5wVFHFDasHH93OAPYFoYwycmjJzc6TRjXkSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 01 Feb 2024 15:49:06 +0000
Subject: [PATCH 6/6] mm/zswap: zswap entry doesn't need refcount anymore
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240201-b4-zswap-invalidate-entry-v1-6-56ed496b6e55@bytedance.com>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
To: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosryahmed@google.com>
Cc: linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
X-Migadu-Flow: FLOW_OUT

Since we don't need to leave zswap entry on the zswap tree anymore,
we should remove it from tree once we find it from the tree.

Then after using it, we can directly free it, no concurrent path
can find it from tree. Only the shrinker can see it from lru list,
which will also double check under tree lock, so no race problem.

So we don't need refcount in zswap entry anymore and don't need to
take the spinlock for the second time to invalidate it.

The side effect is that zswap_entry_free() maybe not happen in tree
spinlock, but it's ok since nothing need to be protected by the lock.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 63 +++++++++++---------------------------------------------------
 1 file changed, 11 insertions(+), 52 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index cbf379abb6c7..cd67f7f6b302 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -193,12 +193,6 @@ struct zswap_pool {
  *
  * rbnode - links the entry into red-black tree for the appropriate swap type
  * swpentry - associated swap entry, the offset indexes into the red-black tree
- * refcount - the number of outstanding reference to the entry. This is needed
- *            to protect against premature freeing of the entry by code
- *            concurrent calls to load, invalidate, and writeback.  The lock
- *            for the zswap_tree structure that contains the entry must
- *            be held while changing the refcount.  Since the lock must
- *            be held, there is no reason to also make refcount atomic.
  * length - the length in bytes of the compressed page data.  Needed during
  *          decompression. For a same value filled page length is 0, and both
  *          pool and lru are invalid and must be ignored.
@@ -211,7 +205,6 @@ struct zswap_pool {
 struct zswap_entry {
 	struct rb_node rbnode;
 	swp_entry_t swpentry;
-	int refcount;
 	unsigned int length;
 	struct zswap_pool *pool;
 	union {
@@ -222,11 +215,6 @@ struct zswap_entry {
 	struct list_head lru;
 };
 
-/*
- * The tree lock in the zswap_tree struct protects a few things:
- * - the rbtree
- * - the refcount field of each entry in the tree
- */
 struct zswap_tree {
 	struct rb_root rbroot;
 	spinlock_t lock;
@@ -890,14 +878,10 @@ static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *entry,
 	return 0;
 }
 
-static bool zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
+static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
 {
-	if (!RB_EMPTY_NODE(&entry->rbnode)) {
-		rb_erase(&entry->rbnode, root);
-		RB_CLEAR_NODE(&entry->rbnode);
-		return true;
-	}
-	return false;
+	rb_erase(&entry->rbnode, root);
+	RB_CLEAR_NODE(&entry->rbnode);
 }
 
 /*********************************
@@ -911,7 +895,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
 	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
 	if (!entry)
 		return NULL;
-	entry->refcount = 1;
 	RB_CLEAR_NODE(&entry->rbnode);
 	return entry;
 }
@@ -954,33 +937,15 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	zswap_update_total_size();
 }
 
-/* caller must hold the tree lock */
-static void zswap_entry_get(struct zswap_entry *entry)
-{
-	WARN_ON_ONCE(!entry->refcount);
-	entry->refcount++;
-}
-
-/* caller must hold the tree lock */
-static void zswap_entry_put(struct zswap_entry *entry)
-{
-	WARN_ON_ONCE(!entry->refcount);
-	if (--entry->refcount == 0) {
-		WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
-		zswap_entry_free(entry);
-	}
-}
-
 /*
- * If the entry is still valid in the tree, drop the initial ref and remove it
- * from the tree. This function must be called with an additional ref held,
- * otherwise it may race with another invalidation freeing the entry.
+ * The caller hold the tree lock and search the entry from the tree,
+ * so it must be on the tree, remove it from the tree and free it.
  */
 static void zswap_invalidate_entry(struct zswap_tree *tree,
 				   struct zswap_entry *entry)
 {
-	if (zswap_rb_erase(&tree->rbroot, entry))
-		zswap_entry_put(entry);
+	zswap_rb_erase(&tree->rbroot, entry);
+	zswap_entry_free(entry);
 }
 
 /*********************************
@@ -1219,7 +1184,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	}
 
 	/* Safe to deref entry after the entry is verified above. */
-	zswap_entry_get(entry);
+	zswap_rb_erase(&tree->rbroot, entry);
 	spin_unlock(&tree->lock);
 
 	zswap_decompress(entry, &folio->page);
@@ -1228,10 +1193,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (entry->objcg)
 		count_objcg_event(entry->objcg, ZSWPWB);
 
-	spin_lock(&tree->lock);
-	zswap_invalidate_entry(tree, entry);
-	zswap_entry_put(entry);
-	spin_unlock(&tree->lock);
+	zswap_entry_free(entry);
 
 	/* folio is up to date */
 	folio_mark_uptodate(folio);
@@ -1702,7 +1664,7 @@ bool zswap_load(struct folio *folio)
 		spin_unlock(&tree->lock);
 		return false;
 	}
-	zswap_entry_get(entry);
+	zswap_rb_erase(&tree->rbroot, entry);
 	spin_unlock(&tree->lock);
 
 	if (entry->length)
@@ -1717,10 +1679,7 @@ bool zswap_load(struct folio *folio)
 	if (entry->objcg)
 		count_objcg_event(entry->objcg, ZSWPIN);
 
-	spin_lock(&tree->lock);
-	zswap_invalidate_entry(tree, entry);
-	zswap_entry_put(entry);
-	spin_unlock(&tree->lock);
+	zswap_entry_free(entry);
 
 	folio_mark_dirty(folio);
 

-- 
b4 0.10.1

