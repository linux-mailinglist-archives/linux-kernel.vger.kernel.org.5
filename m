Return-Path: <linux-kernel+bounces-108461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C994E880ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31741283A09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36AE154B1;
	Wed, 20 Mar 2024 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dlkfk8F5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1C11C83
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710913950; cv=none; b=M/8QchPEkmw2JpnsTCLO1sBi6ColoPkYLTs4aecfGMFKQuucAqt5AuI39IaK7eyGI9SRi/gt0wquTL8CrRcSssYSExqhMhmxiFMIiFVfWkWjrNmpJeHmtArq+nkk7Hvn6OS7VYfLaD5uuTbrYiws8Z85+06ONeCvi73Sk9Zdl/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710913950; c=relaxed/simple;
	bh=P8roxe0rd6xI7PJj9yn4nxIQvSuFcBAbBeV18CveLr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pbLi3B9nTrnr6aMKstPhrFiVVmnjtaM1/TkMdzIis0VNE26T9IsvFQg6DpWUoIovTRSmixMW0fRP5AdUaDQhtpJVyEgTQYqji9zg6DEtmbHa0uHT+w7lTVbsjM7E0CtMuLWzxzzTGpGbN9CO2LloJC5YWwd39fris43TLVycPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dlkfk8F5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1577C433C7;
	Wed, 20 Mar 2024 05:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710913950;
	bh=P8roxe0rd6xI7PJj9yn4nxIQvSuFcBAbBeV18CveLr4=;
	h=From:Date:Subject:To:Cc:From;
	b=Dlkfk8F55DGS7UvqqdKV2gkpaBjP3bgqIfx89mZ0jObMvLzlZYNOWy79E8ayEyEbX
	 qbDDyiPuigvrnBWlgeRwzv25LAhuFAHn5gamwCTIOUWweMrnrreh3gpUOD0BEx0B7u
	 tk4I2+e+zRitH2AHXGQ4DaKa2NQN7pedPD17/SzCuTofKajHZ8pDEKAloTD1+XzVCA
	 WMdi0kpbWhpjDfDNhues67LB0TxXi3RmGYMGAqWxgp/xzc6YVS3xvsvPGHVadwsmEk
	 84D258IRwD+EaXrmv/7p3wxM68tivy9iyoRHjhAT8Da0atx4lXMzwoVxu629y3wYUr
	 5+jEahLHUTKbQ==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Mar 2024 22:52:26 -0700
Subject: [PATCH v7] zswap: replace RB tree with xarray
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJl5+mUC/2XQTWrDMBAF4KsErasyM/p1Vr1H6UKWx4losYNU3
 KTBd68SCnHs5dPjewy6isI5cRH73VVknlJJ41CDe9mJeAzDgWXqahYEpAFBy9/yE07yHHIOF+n
 QkgU2GlmJSk6Z+3S+z71/1HxM5XvMl/v6hLfX/yF0z0MTSpC2C8HbCL4P/PbJeeCv1zEfxG1po
 ocmalaaJEo2QF53fexa3Gj10ApopVXVpgEgQz3VeqP1Uq++YNJVR91qYx3EqGCjzUIjrrSpOqh
 a9Nw20ZuNtku9vtxWja2vresc+OfL53n+A/TbW/rfAQAA
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Chengming Zhou <zhouchengming@bytedance.com>, 
 Barry Song <v-songbaohua@oppo.com>, Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.12.4

Very deep RB tree requires rebalance at times. That
contributes to the zswap fault latencies. Xarray does not
need to perform tree rebalance. Replacing RB tree to xarray
can have some small performance gain.

One small difference is that xarray insert might fail with
ENOMEM, while RB tree insert does not allocate additional
memory.

The zswap_entry size will reduce a bit due to removing the
RB node, which has two pointers and a color field. Xarray
store the pointer in the xarray tree rather than the
zswap_entry. Every entry has one pointer from the xarray
tree. Overall, switching to xarray should save some memory,
if the swap entries are densely packed.

Notice the zswap_rb_search and zswap_rb_insert always
followed by zswap_rb_erase. Use xa_erase and xa_store
directly. That saves one tree lookup as well.

Remove zswap_invalidate_entry due to no need to call
zswap_rb_erase any more. Use zswap_free_entry instead.

The "struct zswap_tree" has been replaced by "struct xarray".
The tree spin lock has transferred to the xarray lock.

Run the kernel build testing 10 times for each version, averages:
(memory.max=2GB, zswap shrinker and writeback enabled,
one 50GB swapfile, 24 HT core, 32 jobs)

mm-unstable-a824831a082f     xarray v7
user       3547.264			3541.509
sys        531.176                      526.111
real       200.752                      201.334

---
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Signed-off-by: Chris Li <chrisl@kernel.org>
---
Changes in v7:
- update comment suggested by Johannes and Yosry
- Simplify some error handling code, suggested by Johannes.
- Link to v6: https://lore.kernel.org/r/20240312-zswap-xarray-v6-1-1b82027d7082@kernel.org

Changes in v6:
- Add WARN_ONCE() for xa_store failed other than -ENOMEM.
- Collect review tags.
- Link to v5: https://lore.kernel.org/r/20240311-zswap-xarray-v5-1-a3031feb9c85@kernel.org

Changes in v5:
- Remove zswap_xa_insert(), call xa_store and xa_erase directly.
- Remove zswap_reject_xarray_fail. 
- Link to v4: https://lore.kernel.org/r/20240304-zswap-xarray-v4-1-c4b45670cc30@kernel.org

Changes in v4:
- Remove zswap_xa_search_and_earse, use xa_erase directly.
- Move charge of objcg after zswap_xa_insert.
- Avoid erase old entry on insert fail error path.
- Remove not needed swap_zswap_tree change
- Link to v3: https://lore.kernel.org/r/20240302-zswap-xarray-v3-1-5900252f2302@kernel.org

Changes in v3:
- Use xa_cmpxchg instead of zswap_xa_search_and_delete in zswap_writeback_entry.
- Use xa_store in zswap_xa_insert directly. Reduce the scope of spinlock.
- Fix xa_store error handling for same page fill case.
- Link to v2: https://lore.kernel.org/r/20240229-zswap-xarray-v2-1-e50284dfcdb1@kernel.org

Changes in v2:
- Replace struct zswap_tree with struct xarray.
- Remove zswap_tree spinlock, use xarray lock instead.
- Fold zswap_rb_erase() into zswap_xa_search_and_delete() and zswap_xa_insert().
- Delete zswap_invalidate_entry(), use zswap_free_entry() instead.
- Link to v1: https://lore.kernel.org/r/20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org
---
 mm/zswap.c | 177 ++++++++++++++++++-------------------------------------------
 1 file changed, 52 insertions(+), 125 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index b31c977f53e9..d8a14b27adcd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -20,7 +20,6 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/atomic.h>
-#include <linux/rbtree.h>
 #include <linux/swap.h>
 #include <linux/crypto.h>
 #include <linux/scatterlist.h>
@@ -196,7 +195,6 @@ static struct shrinker *zswap_shrinker;
  * This structure contains the metadata for tracking a single compressed
  * page within zswap.
  *
- * rbnode - links the entry into red-black tree for the appropriate swap type
  * swpentry - associated swap entry, the offset indexes into the red-black tree
  * length - the length in bytes of the compressed page data.  Needed during
  *          decompression. For a same value filled page length is 0, and both
@@ -208,7 +206,6 @@ static struct shrinker *zswap_shrinker;
  * lru - handle to the pool's lru used to evict pages.
  */
 struct zswap_entry {
-	struct rb_node rbnode;
 	swp_entry_t swpentry;
 	unsigned int length;
 	struct zswap_pool *pool;
@@ -220,12 +217,7 @@ struct zswap_entry {
 	struct list_head lru;
 };
 
-struct zswap_tree {
-	struct rb_root rbroot;
-	spinlock_t lock;
-};
-
-static struct zswap_tree *zswap_trees[MAX_SWAPFILES];
+static struct xarray *zswap_trees[MAX_SWAPFILES];
 static unsigned int nr_zswap_trees[MAX_SWAPFILES];
 
 /* RCU-protected iteration */
@@ -253,7 +245,7 @@ static bool zswap_has_pool;
 * helpers and fwd declarations
 **********************************/
 
-static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
+static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
 {
 	return &zswap_trees[swp_type(swp)][swp_offset(swp)
 		>> SWAP_ADDRESS_SPACE_SHIFT];
@@ -792,63 +784,6 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
 	spin_unlock(&zswap_shrink_lock);
 }
 
-/*********************************
-* rbtree functions
-**********************************/
-static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t offset)
-{
-	struct rb_node *node = root->rb_node;
-	struct zswap_entry *entry;
-	pgoff_t entry_offset;
-
-	while (node) {
-		entry = rb_entry(node, struct zswap_entry, rbnode);
-		entry_offset = swp_offset(entry->swpentry);
-		if (entry_offset > offset)
-			node = node->rb_left;
-		else if (entry_offset < offset)
-			node = node->rb_right;
-		else
-			return entry;
-	}
-	return NULL;
-}
-
-/*
- * In the case that a entry with the same offset is found, a pointer to
- * the existing entry is stored in dupentry and the function returns -EEXIST
- */
-static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *entry,
-			struct zswap_entry **dupentry)
-{
-	struct rb_node **link = &root->rb_node, *parent = NULL;
-	struct zswap_entry *myentry;
-	pgoff_t myentry_offset, entry_offset = swp_offset(entry->swpentry);
-
-	while (*link) {
-		parent = *link;
-		myentry = rb_entry(parent, struct zswap_entry, rbnode);
-		myentry_offset = swp_offset(myentry->swpentry);
-		if (myentry_offset > entry_offset)
-			link = &(*link)->rb_left;
-		else if (myentry_offset < entry_offset)
-			link = &(*link)->rb_right;
-		else {
-			*dupentry = myentry;
-			return -EEXIST;
-		}
-	}
-	rb_link_node(&entry->rbnode, parent, link);
-	rb_insert_color(&entry->rbnode, root);
-	return 0;
-}
-
-static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
-{
-	rb_erase(&entry->rbnode, root);
-	RB_CLEAR_NODE(&entry->rbnode);
-}
-
 /*********************************
 * zswap entry functions
 **********************************/
@@ -860,7 +795,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
 	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
 	if (!entry)
 		return NULL;
-	RB_CLEAR_NODE(&entry->rbnode);
 	return entry;
 }
 
@@ -896,17 +830,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	atomic_dec(&zswap_stored_pages);
 }
 
-/*
- * The caller hold the tree lock and search the entry from the tree,
- * so it must be on the tree, remove it from the tree and free it.
- */
-static void zswap_invalidate_entry(struct zswap_tree *tree,
-				   struct zswap_entry *entry)
-{
-	zswap_rb_erase(&tree->rbroot, entry);
-	zswap_entry_free(entry);
-}
-
 /*********************************
 * compressed storage functions
 **********************************/
@@ -1106,7 +1029,8 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 static int zswap_writeback_entry(struct zswap_entry *entry,
 				 swp_entry_t swpentry)
 {
-	struct zswap_tree *tree;
+	struct xarray *tree;
+	pgoff_t offset = swp_offset(swpentry);
 	struct folio *folio;
 	struct mempolicy *mpol;
 	bool folio_was_allocated;
@@ -1143,19 +1067,13 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * be dereferenced.
 	 */
 	tree = swap_zswap_tree(swpentry);
-	spin_lock(&tree->lock);
-	if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) != entry) {
-		spin_unlock(&tree->lock);
+	if (entry != xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL)) {
 		delete_from_swap_cache(folio);
 		folio_unlock(folio);
 		folio_put(folio);
 		return -ENOMEM;
 	}
 
-	/* Safe to deref entry after the entry is verified above. */
-	zswap_rb_erase(&tree->rbroot, entry);
-	spin_unlock(&tree->lock);
-
 	zswap_decompress(entry, &folio->page);
 
 	count_vm_event(ZSWPWB);
@@ -1467,8 +1385,8 @@ bool zswap_store(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
-	struct zswap_tree *tree = swap_zswap_tree(swp);
-	struct zswap_entry *entry, *dupentry;
+	struct xarray *tree = swap_zswap_tree(swp);
+	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 	unsigned long max_pages, cur_pages;
@@ -1556,28 +1474,43 @@ bool zswap_store(struct folio *folio)
 insert_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
+
+	old = xa_store(tree, offset, entry, GFP_KERNEL);
+	if (xa_is_err(old)) {
+		int err = xa_err(old);
+		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
+		zswap_reject_alloc_fail++;
+		goto store_failed;
+	}
+
+        /*
+         * We may have had an existing entry that became stale when
+         * the folio was redirtied and now the new version is being
+         * swapped out. Get rid of the old.
+         */
+	if (old)
+		zswap_entry_free(old);
+
 	if (objcg) {
 		obj_cgroup_charge_zswap(objcg, entry->length);
-		/* Account before objcg ref is moved to tree */
 		count_objcg_event(objcg, ZSWPOUT);
 	}
 
-	/* map */
-	spin_lock(&tree->lock);
 	/*
-	 * The folio may have been dirtied again, invalidate the
-	 * possibly stale entry before inserting the new entry.
+	 * We finish initializing the entry while it's already in xarray.
+	 * This is safe because:
+	 *
+	 * 1. Concurrent stores and invalidations are excluded by folio lock.
+	 *
+	 * 2. Writeback is excluded by the entry not being on the LRU yet.
+	 *    The publishing order matters to prevent writeback from seeing
+	 *    an incoherent entry.
 	 */
-	if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
-		zswap_invalidate_entry(tree, dupentry);
-		WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
-	}
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&zswap_list_lru, entry);
 		atomic_inc(&zswap_nr_stored);
 	}
-	spin_unlock(&tree->lock);
 
 	/* update stats */
 	atomic_inc(&zswap_stored_pages);
@@ -1585,8 +1518,14 @@ bool zswap_store(struct folio *folio)
 
 	return true;
 
+store_failed:
+	if (!entry->length)
+		atomic_dec(&zswap_same_filled_pages);
+	else {
+		zpool_free(zswap_find_zpool(entry), entry->handle);
 put_pool:
-	zswap_pool_put(entry->pool);
+		zswap_pool_put(entry->pool);
+	}
 freepage:
 	zswap_entry_cache_free(entry);
 reject:
@@ -1597,11 +1536,9 @@ bool zswap_store(struct folio *folio)
 	 * possibly stale entry which was previously stored at this offset.
 	 * Otherwise, writeback could overwrite the new data in the swapfile.
 	 */
-	spin_lock(&tree->lock);
-	entry = zswap_rb_search(&tree->rbroot, offset);
+	entry = xa_erase(tree, offset);
 	if (entry)
-		zswap_invalidate_entry(tree, entry);
-	spin_unlock(&tree->lock);
+		zswap_entry_free(entry);
 	return false;
 
 shrink:
@@ -1614,20 +1551,15 @@ bool zswap_load(struct folio *folio)
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
 	struct page *page = &folio->page;
-	struct zswap_tree *tree = swap_zswap_tree(swp);
+	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 	u8 *dst;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
-	spin_lock(&tree->lock);
-	entry = zswap_rb_search(&tree->rbroot, offset);
-	if (!entry) {
-		spin_unlock(&tree->lock);
+	entry = xa_erase(tree, offset);
+	if (!entry)
 		return false;
-	}
-	zswap_rb_erase(&tree->rbroot, entry);
-	spin_unlock(&tree->lock);
 
 	if (entry->length)
 		zswap_decompress(entry, page);
@@ -1651,19 +1583,17 @@ bool zswap_load(struct folio *folio)
 void zswap_invalidate(swp_entry_t swp)
 {
 	pgoff_t offset = swp_offset(swp);
-	struct zswap_tree *tree = swap_zswap_tree(swp);
+	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 
-	spin_lock(&tree->lock);
-	entry = zswap_rb_search(&tree->rbroot, offset);
+	entry = xa_erase(tree, offset);
 	if (entry)
-		zswap_invalidate_entry(tree, entry);
-	spin_unlock(&tree->lock);
+		zswap_entry_free(entry);
 }
 
 int zswap_swapon(int type, unsigned long nr_pages)
 {
-	struct zswap_tree *trees, *tree;
+	struct xarray *trees, *tree;
 	unsigned int nr, i;
 
 	nr = DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
@@ -1673,11 +1603,8 @@ int zswap_swapon(int type, unsigned long nr_pages)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < nr; i++) {
-		tree = trees + i;
-		tree->rbroot = RB_ROOT;
-		spin_lock_init(&tree->lock);
-	}
+	for (i = 0; i < nr; i++)
+		xa_init(trees + i);
 
 	nr_zswap_trees[type] = nr;
 	zswap_trees[type] = trees;
@@ -1686,7 +1613,7 @@ int zswap_swapon(int type, unsigned long nr_pages)
 
 void zswap_swapoff(int type)
 {
-	struct zswap_tree *trees = zswap_trees[type];
+	struct xarray *trees = zswap_trees[type];
 	unsigned int i;
 
 	if (!trees)
@@ -1694,7 +1621,7 @@ void zswap_swapoff(int type)
 
 	/* try_to_unuse() invalidated all the entries already */
 	for (i = 0; i < nr_zswap_trees[type]; i++)
-		WARN_ON_ONCE(!RB_EMPTY_ROOT(&trees[i].rbroot));
+		WARN_ON_ONCE(!xa_empty(trees + i));
 
 	kvfree(trees);
 	nr_zswap_trees[type] = 0;

---
base-commit: a824831a082f1d8f9b51a4c0598e633d38555fcf
change-id: 20240104-zswap-xarray-716260e541e3

Best regards,
-- 
Chris Li <chrisl@kernel.org>


