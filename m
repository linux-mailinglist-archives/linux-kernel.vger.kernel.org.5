Return-Path: <linux-kernel+bounces-39765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C0383D5DA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A350D282CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C5E1BF2C;
	Fri, 26 Jan 2024 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CLpsDgqA"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32719D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257924; cv=none; b=okdP7v30hgJF6lLczMv9tkdoeNp6Ge+CdlQSLrqXO6WiStsmFjoKQDT1aZp3GGgS+vdbrRKsnbcuAKth7RPWYlLqAhoumx7lBEZTRyBSrxsItzoNOfzzcpT5YjlSoIEKld/iaCV9hI3lwoZBZMk6CVVDvLdx/89+OEUgXI8Y0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257924; c=relaxed/simple;
	bh=v5bJZkTs3BYM941I9It3NXIwfB5nm79uHDr7s+ctpzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=acvbQ8Ll3BQb9YKHEQYmOM11P7RLow3aAOg6nxB+MuRbU4LL8xYSWZ0WWR5zLUTcZTqfF2bVMsMDSCt2MykO5bWUHx6NM7oOp4t8ezIlgIMednG7uYgyUSb3UrdRIiK8LqMuliz228UrQLQYag0yRb44Wnpu+JkTDG9zTJnwmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CLpsDgqA; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706257919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RGl5GCV+/l8k8PkKYE4YjnNWtmux4RyfbXvzaTXTBw=;
	b=CLpsDgqApa2jWN3UyBSlFHJMAB6JLKUdRecLoWya7czH6asoNiydNa2hdfjXFJ3mhGU7bd
	sxi5fCGk4rSyYcc5yWXNRM0vKYyE0GwyUZFSztKB4ZxOLK9RE1TvftQiJma1PBMEg5J5qM
	jv04y+2koKHteg9CVHY3j3Wwzp5AsR4=
From: chengming.zhou@linux.dev
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 2/2] mm/zswap: fix race between lru writeback and swapoff
Date: Fri, 26 Jan 2024 08:30:15 +0000
Message-Id: <20240126083015.3557006-2-chengming.zhou@linux.dev>
In-Reply-To: <20240126083015.3557006-1-chengming.zhou@linux.dev>
References: <20240126083015.3557006-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

LRU writeback has race problem with swapoff, as spotted by Yosry[1]:

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
and return with folio locked, after which we can reference the tree.
Then check invalidate race with tree lock, the following things is
much the same like zswap_load().

Since we can't deref the entry after zswap_writeback_entry(), we
can't use zswap_lru_putback() anymore, instead we rotate the entry
in the LRU list so concurrent reclaimers have little chance to see it.
Or it will be deleted from LRU list if writeback success.

Another confusing part to me is the update of memcg nr_zswap_protected
in zswap_lru_putback(). I'm not sure why it's needed here since
if we raced with swapin, memcg nr_zswap_protected has already been
updated in zswap_folio_swapin(). So not include this part for now.

[1] https://lore.kernel.org/all/CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com/

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 93 ++++++++++++++++++------------------------------------
 1 file changed, 31 insertions(+), 62 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 81cb3790e0dd..fa2bdb7ec1d8 100644
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
@@ -860,40 +839,34 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 {
 	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
 	bool *encountered_page_in_swapcache = (bool *)arg;
-	struct zswap_tree *tree;
-	pgoff_t swpoffset;
+	swp_entry_t swpentry;
 	enum lru_status ret = LRU_REMOVED_RETRY;
 	int writeback_result;
 
+	/*
+	 * First rotate to the tail of lru list before unlocking lru lock,
+	 * so the concurrent reclaimers have little chance to see it.
+	 * It will be deleted from the lru list if writeback success.
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
@@ -903,27 +876,10 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
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
-
-	count_vm_event(ZSWPWB);
-	/*
-	 * Writeback started successfully, the page now belongs to the
-	 * swapcache. Drop the entry from zswap - unless invalidate already
-	 * took it out while we had the tree->lock released for IO.
-	 */
-	zswap_invalidate_entry(tree, entry);
 
-put_unlock:
-	/* Drop local reference */
-	zswap_entry_put(entry);
-unlock:
-	spin_unlock(&tree->lock);
 	spin_lock(lock);
 	return ret;
 }
@@ -1408,9 +1364,9 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
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
@@ -1442,18 +1398,31 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
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
2.40.1


