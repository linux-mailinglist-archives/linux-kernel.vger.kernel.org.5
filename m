Return-Path: <linux-kernel+bounces-91312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8C3870D4D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DE328E949
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F497D07C;
	Mon,  4 Mar 2024 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxtr/DmV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08137A736
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587955; cv=none; b=ttHR5aRUzw6Hramz43FyGTU7pDlOaZA5Pj8NIynXUg4sVTTnJKX4Raw9p1ckzvTQYPLP2rPqz7I03HsL0LL/oynaC5bx89qiJl6wH0d/6i0pl3P+mEwfp+/z0JE1yGU63+4jK/xfP3Udlo597+1QEgykeBimdyrDdzu0o3Tgmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587955; c=relaxed/simple;
	bh=Gd2r9kQYrs2drFnO4+W4q90+GEnwVaGGaYXsLzb2F20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lIzdZOYnd0ccVjk6lSTjm+xP9e1835dZRaIX/5l9UNYPyrRDFS5cz8VqxU+mLRSQXEbGsQge76a7POcGdWFbT36iGldsS+yHeItdHDYgDUci9IXAcsDsi7235tsckHexbyLQNBawcWUw1Garvj8DTrdz0VU2sezD+lae6MmXX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxtr/DmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25B3C433F1;
	Mon,  4 Mar 2024 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587955;
	bh=Gd2r9kQYrs2drFnO4+W4q90+GEnwVaGGaYXsLzb2F20=;
	h=From:Date:Subject:To:Cc:From;
	b=gxtr/DmVYj/MiCNcWz6P2uAgjd8vHuNoCqgJ6cKFB2QGmKDqpoy7mdn4nxq+c7v/B
	 rUbopdUzlAXnxjoH9RvtpnjFnuo6DTtmHpdzB2eMCNKO9Uh/hp9NB0hw/+fgllRyxQ
	 2OJ25g1E1RwP2NqM3mJG5n8CNuEMH0M9LtYeShL6KztMXIIH8sLPSVIYU3b5q5IPDI
	 pBG2E2Ne4N1s77p+QonWr0344NQkIBudecG6ZiTd5gOtnkwTbsOXhOk0AwlkmdGs23
	 pKZW3UqKxwGNtfL1P8qapptgUxY43ieLtLtMth1JCqXSSbLZNPY3P2ksFyJsdV9Ig1
	 BBMdTMRUwAJHQ==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 04 Mar 2024 13:32:20 -0800
Subject: [PATCH v4] zswap: replace RB tree with xarray
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-zswap-xarray-v4-1-c4b45670cc30@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOM95mUC/2XMQQ6CMBCF4auQrq2ZTksBV97DuKgwSKMB0hoEC
 Xe3EBMCLt9Mvn9knpwlz07RyBx11tumDkMdIpZXpr4Tt0XYDAEVCFD849+m5b1xzgw8ERo1UKw
 ESRZI66i0/ZK7XMOurH81bljqnZivv5BItqFOcOC6MCbVOaSlofODXE3PY+PubC51uGrEbKeRC
 04xYKqKMi9u4k/LVUvAnZZBxxkAxlhieG/0NE1fKY3TuiUBAAA=
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
followed by zswap_rb_erase. Use xa_erase directly. The entry
erase into zswap_xa_insert as well. That saves one tree
lookup as well.

Remove zswap_invalidate_entry due to no need to call
zswap_rb_erase any more. Use zswap_free_entry instead.

The "struct zswap_tree" has been replaced by "struct xarray".
The tree spin lock has transferred to the xarray lock.

Run the kernel build testing 10 times for each version, averages:
(memory.max=2GB, zswap shrinker and writeback enabled, one 50GB swapfile.)

mm-9a0181a3710eb                    xarray v4
user       3526.829                            3526.930
sys        532.754                             526.525
real       198.748                             198.850

---


Signed-off-by: Chris Li <chrisl@kernel.org>
---
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
 mm/zswap.c | 186 ++++++++++++++++++++++++-------------------------------------
 1 file changed, 72 insertions(+), 114 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 011e068eb355..4f4a3f452b76 100644
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
@@ -71,6 +70,8 @@ static u64 zswap_reject_compress_poor;
 static u64 zswap_reject_alloc_fail;
 /* Store failed because the entry metadata could not be allocated (rare) */
 static u64 zswap_reject_kmemcache_fail;
+/* Store failed because xarray can't insert the entry*/
+static u64 zswap_reject_xarray_fail;
 
 /* Shrinker work queue */
 static struct workqueue_struct *shrink_wq;
@@ -196,7 +197,6 @@ static struct {
  * This structure contains the metadata for tracking a single compressed
  * page within zswap.
  *
- * rbnode - links the entry into red-black tree for the appropriate swap type
  * swpentry - associated swap entry, the offset indexes into the red-black tree
  * length - the length in bytes of the compressed page data.  Needed during
  *          decompression. For a same value filled page length is 0, and both
@@ -208,7 +208,6 @@ static struct {
  * lru - handle to the pool's lru used to evict pages.
  */
 struct zswap_entry {
-	struct rb_node rbnode;
 	swp_entry_t swpentry;
 	unsigned int length;
 	struct zswap_pool *pool;
@@ -220,12 +219,7 @@ struct zswap_entry {
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
@@ -253,7 +247,7 @@ static bool zswap_has_pool;
 * helpers and fwd declarations
 **********************************/
 
-static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
+static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
 {
 	return &zswap_trees[swp_type(swp)][swp_offset(swp)
 		>> SWAP_ADDRESS_SPACE_SHIFT];
@@ -805,60 +799,33 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
 }
 
 /*********************************
-* rbtree functions
+* xarray functions
 **********************************/
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
 
 /*
  * In the case that a entry with the same offset is found, a pointer to
- * the existing entry is stored in dupentry and the function returns -EEXIST
+ * the existing entry is stored in old and erased from the tree.
+ * Function return error on insert.
  */
-static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *entry,
-			struct zswap_entry **dupentry)
+static int zswap_xa_insert(struct xarray *tree, struct zswap_entry *entry,
+			   struct zswap_entry **old)
 {
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
+	int err;
+	struct zswap_entry *e;
+	pgoff_t offset = swp_offset(entry->swpentry);
 
-static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
-{
-	rb_erase(&entry->rbnode, root);
-	RB_CLEAR_NODE(&entry->rbnode);
+	e = xa_store(tree, offset, entry, GFP_KERNEL);
+	err = xa_err(e);
+
+	if (err) {
+		e = xa_erase(tree, offset);
+		if (err == -ENOMEM)
+			zswap_reject_alloc_fail++;
+		else
+			zswap_reject_xarray_fail++;
+	}
+	*old = e;
+	return err;
 }
 
 /*********************************
@@ -872,7 +839,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
 	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
 	if (!entry)
 		return NULL;
-	RB_CLEAR_NODE(&entry->rbnode);
 	return entry;
 }
 
@@ -914,17 +880,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	zswap_update_total_size();
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
@@ -1113,7 +1068,9 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 static int zswap_writeback_entry(struct zswap_entry *entry,
 				 swp_entry_t swpentry)
 {
-	struct zswap_tree *tree;
+	struct xarray *tree;
+	pgoff_t offset = swp_offset(swpentry);
+	struct zswap_entry *e;
 	struct folio *folio;
 	struct mempolicy *mpol;
 	bool folio_was_allocated;
@@ -1150,19 +1107,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * be dereferenced.
 	 */
 	tree = swap_zswap_tree(swpentry);
-	spin_lock(&tree->lock);
-	if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) != entry) {
-		spin_unlock(&tree->lock);
+	e = xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL);
+	if (e != entry) {
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
@@ -1471,10 +1423,12 @@ bool zswap_store(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
-	struct zswap_tree *tree = swap_zswap_tree(swp);
-	struct zswap_entry *entry, *dupentry;
+	struct xarray *tree = swap_zswap_tree(swp);
+	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
+	int err;
+	bool old_erased = false;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1526,6 +1480,7 @@ bool zswap_store(struct folio *folio)
 			kunmap_local(src);
 			entry->length = 0;
 			entry->value = value;
+			entry->pool = NULL;
 			atomic_inc(&zswap_same_filled_pages);
 			goto insert_entry;
 		}
@@ -1555,28 +1510,31 @@ bool zswap_store(struct folio *folio)
 insert_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
-	if (objcg) {
-		obj_cgroup_charge_zswap(objcg, entry->length);
-		/* Account before objcg ref is moved to tree */
-		count_objcg_event(objcg, ZSWPOUT);
-	}
 
 	/* map */
-	spin_lock(&tree->lock);
 	/*
 	 * The folio may have been dirtied again, invalidate the
 	 * possibly stale entry before inserting the new entry.
 	 */
-	if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
-		zswap_invalidate_entry(tree, dupentry);
-		WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
+	err = zswap_xa_insert(tree, entry, &old);
+	if (old)
+		zswap_entry_free(old);
+	if (err) {
+		old_erased = true;
+		goto insert_failed;
 	}
+
+	if (objcg) {
+		obj_cgroup_charge_zswap(objcg, entry->length);
+		/* Account before objcg ref is moved to tree */
+		count_objcg_event(objcg, ZSWPOUT);
+	}
+
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&zswap.list_lru, entry);
 		atomic_inc(&zswap.nr_stored);
 	}
-	spin_unlock(&tree->lock);
 
 	/* update stats */
 	atomic_inc(&zswap_stored_pages);
@@ -1585,6 +1543,12 @@ bool zswap_store(struct folio *folio)
 
 	return true;
 
+insert_failed:
+	if (!entry->length) {
+		atomic_dec(&zswap_same_filled_pages);
+		goto freepage;
+	}
+	zpool_free(zswap_find_zpool(entry), entry->handle);
 put_pool:
 	zswap_pool_put(entry->pool);
 freepage:
@@ -1592,17 +1556,19 @@ bool zswap_store(struct folio *folio)
 reject:
 	if (objcg)
 		obj_cgroup_put(objcg);
+
+	if (old_erased)
+		goto failed;
 check_old:
 	/*
 	 * If the zswap store fails or zswap is disabled, we must invalidate the
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
+failed:
 	return false;
 
 shrink:
@@ -1615,20 +1581,15 @@ bool zswap_load(struct folio *folio)
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
@@ -1652,19 +1613,17 @@ bool zswap_load(struct folio *folio)
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
@@ -1674,11 +1633,8 @@ int zswap_swapon(int type, unsigned long nr_pages)
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
@@ -1687,7 +1643,7 @@ int zswap_swapon(int type, unsigned long nr_pages)
 
 void zswap_swapoff(int type)
 {
-	struct zswap_tree *trees = zswap_trees[type];
+	struct xarray *trees = zswap_trees[type];
 	unsigned int i;
 
 	if (!trees)
@@ -1695,7 +1651,7 @@ void zswap_swapoff(int type)
 
 	/* try_to_unuse() invalidated all the entries already */
 	for (i = 0; i < nr_zswap_trees[type]; i++)
-		WARN_ON_ONCE(!RB_EMPTY_ROOT(&trees[i].rbroot));
+		WARN_ON_ONCE(!xa_empty(trees + i));
 
 	kvfree(trees);
 	nr_zswap_trees[type] = 0;
@@ -1727,6 +1683,8 @@ static int zswap_debugfs_init(void)
 			   zswap_debugfs_root, &zswap_reject_kmemcache_fail);
 	debugfs_create_u64("reject_compress_fail", 0444,
 			   zswap_debugfs_root, &zswap_reject_compress_fail);
+	debugfs_create_u64("reject_xarray_fail", 0444,
+			   zswap_debugfs_root, &zswap_reject_xarray_fail);
 	debugfs_create_u64("reject_compress_poor", 0444,
 			   zswap_debugfs_root, &zswap_reject_compress_poor);
 	debugfs_create_u64("written_back_pages", 0444,

---
base-commit: 9a0181a3710eba1f5c6d19eadcca888be3d54e4f
change-id: 20240104-zswap-xarray-716260e541e3

Best regards,
-- 
Chris Li <chrisl@kernel.org>


