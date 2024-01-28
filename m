Return-Path: <linux-kernel+bounces-41631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EEE83F59A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59271282BC1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1CC2E3EB;
	Sun, 28 Jan 2024 13:29:07 +0000 (UTC)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51EE28DD3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706448547; cv=none; b=gmWjPoF7U1bXlouubnm3qqwIIwDc1EjXg1SJgUoenwAfzeb73fZnOk2mkbOwGFE54I0Xpfb93vUl71XBditT3x0pim6gcQVW8seuKX3e3eAiU2JCNDcxPvMIMX9Ktcf3dpAOzTCa1Uf4DNIUnrPF+OzieZqy7TemI1bCVmWxryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706448547; c=relaxed/simple;
	bh=EyPiXHq7EpkESBtsy6suPJOsAFZgCHipFHLhyyRGbno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EctASmg+QStrNpyrBzbLBY9a67bQWQ7ZvCVBBGb3NC16u7Aepx+00kom3ddB6bts1dT3UkFHyH1iwhcEnzD5gXe4WEOKJSchaT9/GsOKz8RNDeAIKruouvzOD33IEnbqD26+ckgjvXCIFPVNji+QgYrS/T8MxS+lzJabt4QL8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Sun, 28 Jan 2024 13:28:50 +0000
Subject: [PATCH v2 2/3] mm/zswap: fix race between lru writeback and swapoff
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240126-zswap-writeback-race-v2-2-b10479847099@bytedance.com>
References: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com>
In-Reply-To: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chriscli@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Migadu-Flow: FLOW_OUT

LRU writeback has race problem with swapoff, as spotted by Yosry [1]:

CPU1			CPU2
shrink_memcg_cb		swap_off
  list_lru_isolate	  zswap_invalidate
			  zswap_swapoff
			    kfree(tree)
  // UAF
  spin_lock(&tree->lock)

The problem is that the entry in lru list can't protect the tree from
being swapoff and freed, and the entry also can be invalidated and freed
concurrently after we unlock the lru lock.

We can fix it by moving the swap cache allocation ahead before
referencing the tree, then check invalidate race with tree lock,
only after that we can safely deref the entry. Note we couldn't
deref entry or tree anymore after we unlock the folio, since we
depend on this to hold on swapoff.

So this patch moves all tree and entry usage to zswap_writeback_entry(),
we only use the copied swpentry on the stack to allocate swap cache
and if returned with folio locked we can reference the tree safely.
Then we can check invalidate race with tree lock, the following things
is much the same like zswap_load().

Since we can't deref the entry after zswap_writeback_entry(), we
can't use zswap_lru_putback() anymore, instead we rotate the entry
in the beginning. And it will be unlinked and freed when invalidated
if writeback success.

Another change is we don't update the memcg nr_zswap_protected in
the -ENOMEM and -EEXIST cases anymore. -EEXIST case means we raced
with swapin or concurrent shrinker action, since swapin already
have memcg nr_zswap_protected updated, don't need double counts here.
For concurrent shrinker, the folio will be writeback and freed anyway.
-ENOMEM case is extremely rare and doesn't happen spuriously either,
so don't bother distinguishing this case.

[1] https://lore.kernel.org/all/CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com/

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 114 ++++++++++++++++++++++++++-----------------------------------
 1 file changed, 49 insertions(+), 65 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 81cb3790e0dd..f5cb5a46e4d7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -277,7 +277,7 @@ static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
 		 zpool_get_type((p)->zpools[0]))
 
 static int zswap_writeback_entry(struct zswap_entry *entry,
-				 struct zswap_tree *tree);
+				 swp_entry_t swpentry);
 static int zswap_pool_get(struct zswap_pool *pool);
 static void zswap_pool_put(struct zswap_pool *pool);
 
@@ -445,27 +445,6 @@ static void zswap_lru_del(struct list_lru *list_lru, struct zswap_entry *entry)
 	rcu_read_unlock();
 }
 
-static void zswap_lru_putback(struct list_lru *list_lru,
-		struct zswap_entry *entry)
-{
-	int nid = entry_to_nid(entry);
-	spinlock_t *lock = &list_lru->node[nid].lock;
-	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
-
-	rcu_read_lock();
-	memcg = mem_cgroup_from_entry(entry);
-	spin_lock(lock);
-	/* we cannot use list_lru_add here, because it increments node's lru count */
-	list_lru_putback(list_lru, &entry->lru, nid, memcg);
-	spin_unlock(lock);
-
-	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(entry_to_nid(entry)));
-	/* increment the protection area to account for the LRU rotation. */
-	atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
-	rcu_read_unlock();
-}
-
 /*********************************
 * rbtree functions
 **********************************/
@@ -860,40 +839,47 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 {
 	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
 	bool *encountered_page_in_swapcache = (bool *)arg;
-	struct zswap_tree *tree;
-	pgoff_t swpoffset;
+	swp_entry_t swpentry;
 	enum lru_status ret = LRU_REMOVED_RETRY;
 	int writeback_result;
 
+	/*
+	 * Rotate the entry to the tail before unlocking the LRU,
+	 * so that in case of an invalidation race concurrent
+	 * reclaimers don't waste their time on it.
+	 *
+	 * If writeback succeeds, or failure is due to the entry
+	 * being invalidated by the swap subsystem, the invalidation
+	 * will unlink and free it.
+	 *
+	 * Temporary failures, where the same entry should be tried
+	 * again immediately, almost never happen for this shrinker.
+	 * We don't do any trylocking; -ENOMEM comes closest,
+	 * but that's extremely rare and doesn't happen spuriously
+	 * either. Don't bother distinguishing this case.
+	 *
+	 * But since they do exist in theory, the entry cannot just
+	 * be unlinked, or we could leak it. Hence, rotate.
+	 */
+	list_move_tail(item, &l->list);
+
 	/*
 	 * Once the lru lock is dropped, the entry might get freed. The
-	 * swpoffset is copied to the stack, and entry isn't deref'd again
+	 * swpentry is copied to the stack, and entry isn't deref'd again
 	 * until the entry is verified to still be alive in the tree.
 	 */
-	swpoffset = swp_offset(entry->swpentry);
-	tree = swap_zswap_tree(entry->swpentry);
-	list_lru_isolate(l, item);
+	swpentry = entry->swpentry;
+
 	/*
 	 * It's safe to drop the lock here because we return either
 	 * LRU_REMOVED_RETRY or LRU_RETRY.
 	 */
 	spin_unlock(lock);
 
-	/* Check for invalidate() race */
-	spin_lock(&tree->lock);
-	if (entry != zswap_rb_search(&tree->rbroot, swpoffset))
-		goto unlock;
-
-	/* Hold a reference to prevent a free during writeback */
-	zswap_entry_get(entry);
-	spin_unlock(&tree->lock);
-
-	writeback_result = zswap_writeback_entry(entry, tree);
+	writeback_result = zswap_writeback_entry(entry, swpentry);
 
-	spin_lock(&tree->lock);
 	if (writeback_result) {
 		zswap_reject_reclaim_fail++;
-		zswap_lru_putback(&entry->pool->list_lru, entry);
 		ret = LRU_RETRY;
 
 		/*
@@ -903,27 +889,10 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 		 */
 		if (writeback_result == -EEXIST && encountered_page_in_swapcache)
 			*encountered_page_in_swapcache = true;
-
-		goto put_unlock;
+	} else {
+		zswap_written_back_pages++;
 	}
-	zswap_written_back_pages++;
-
-	if (entry->objcg)
-		count_objcg_event(entry->objcg, ZSWPWB);
 
-	count_vm_event(ZSWPWB);
-	/*
-	 * Writeback started successfully, the page now belongs to the
-	 * swapcache. Drop the entry from zswap - unless invalidate already
-	 * took it out while we had the tree->lock released for IO.
-	 */
-	zswap_invalidate_entry(tree, entry);
-
-put_unlock:
-	/* Drop local reference */
-	zswap_entry_put(entry);
-unlock:
-	spin_unlock(&tree->lock);
 	spin_lock(lock);
 	return ret;
 }
@@ -1408,9 +1377,9 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
  * freed.
  */
 static int zswap_writeback_entry(struct zswap_entry *entry,
-				 struct zswap_tree *tree)
+				 swp_entry_t swpentry)
 {
-	swp_entry_t swpentry = entry->swpentry;
+	struct zswap_tree *tree;
 	struct folio *folio;
 	struct mempolicy *mpol;
 	bool folio_was_allocated;
@@ -1426,9 +1395,11 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 		return -ENOMEM;
 
 	/*
-	 * Found an existing folio, we raced with load/swapin. We generally
-	 * writeback cold folios from zswap, and swapin means the folio just
-	 * became hot. Skip this folio and let the caller find another one.
+	 * Found an existing folio, we raced with swapin or concurrent
+	 * shrinker. We generally writeback cold folios from zswap, and
+	 * swapin means the folio just became hot, so skip this folio.
+	 * For unlikely concurrent shrinker case, it will be unlinked
+	 * and freed when invalidated by the concurrent shrinker anyway.
 	 */
 	if (!folio_was_allocated) {
 		folio_put(folio);
@@ -1442,18 +1413,31 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * backs (our zswap_entry reference doesn't prevent that), to
 	 * avoid overwriting a new swap folio with old compressed data.
 	 */
+	tree = swap_zswap_tree(swpentry);
 	spin_lock(&tree->lock);
-	if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
+	if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) != entry) {
 		spin_unlock(&tree->lock);
 		delete_from_swap_cache(folio);
 		folio_unlock(folio);
 		folio_put(folio);
 		return -ENOMEM;
 	}
+
+	/* Safe to deref entry after the entry is verified above. */
+	zswap_entry_get(entry);
 	spin_unlock(&tree->lock);
 
 	__zswap_load(entry, &folio->page);
 
+	count_vm_event(ZSWPWB);
+	if (entry->objcg)
+		count_objcg_event(entry->objcg, ZSWPWB);
+
+	spin_lock(&tree->lock);
+	zswap_invalidate_entry(tree, entry);
+	zswap_entry_put(entry);
+	spin_unlock(&tree->lock);
+
 	/* folio is up to date */
 	folio_mark_uptodate(folio);
 

-- 
b4 0.10.1

