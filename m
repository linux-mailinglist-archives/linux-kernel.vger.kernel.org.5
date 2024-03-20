Return-Path: <linux-kernel+bounces-109350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D4A8817EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C9E1C22C45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB338592D;
	Wed, 20 Mar 2024 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn/OTm8l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90A86259
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963101; cv=none; b=b6A8/Z+aEuj0dw42ZeuOIQQsekhnDjWVaNa0HjTZIQMt4c8Ce2gCiEY1uGfPNKV80yKEmOHfMGPWtuedKH9oLSD+RZRq3avcFrgWwkTv4WfUPvJRznmI5aD8HLfnlFoDXAJDKvbauvab10UW1X15ZeHnP3BPj29tb1oDy8wUxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963101; c=relaxed/simple;
	bh=hRshkS56jI7yL3gp7KQHMCIDAGVyJd00QSwNf5mJJF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tAP6F8u9xIV16ipYcdJctIwSUMehc/SoYWWlGfyr+TwGD0x54F09HRcs8By+xqLVSYycaQljL+L5BDEmbTCDVPu2Yxfi8aq6qgNbRFNMaRPDJpLIpNHehSBbnneegqMTVYql0BWjrzkDXb2ibUWbL9bPHUu+G0P9acOmrOEcuMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn/OTm8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57465C433F1;
	Wed, 20 Mar 2024 19:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710963100;
	bh=hRshkS56jI7yL3gp7KQHMCIDAGVyJd00QSwNf5mJJF0=;
	h=From:Date:Subject:To:Cc:From;
	b=Wn/OTm8lapt7P8CFQuC+38IcmWqJIuDbopiNHpdtOeKcX1VcAIw+WQ6cvi8qIuSy0
	 e9oiVfVAWtvpoZHjce5WXwW5xW1awcvBrLEaQcjOzPvhpkqHoVWwLYxrGh+8Wecpm/
	 jIjeUkv+w19Tjr95p6ApGTRFofMsGCRW4uS6RhX0VJACknMTMLwTHuXXiVOuvai00o
	 UyK2B9B72JS8HIAq2lBqoB1OIWiZJFVVp2pJmul76MuqIYA0g9pB8P7PlQO3KyiefN
	 qwkSu2nSZIJksTRtNEJCt3jWTVW/yLHIUE2TzXR4ikTyTZ7dpxPzucaDXf9/ehNKNf
	 4MSncuDIr/IzQ==
From: Chris Li <chrisl@kernel.org>
Date: Wed, 20 Mar 2024 12:31:38 -0700
Subject: [PATCH v8] zswap: replace RB tree with xarray
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-zswap-xarray-v8-1-dc08ee9f8744@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJk5+2UC/2XQ3WrDMAwF4Fcpvp6HJP+mV3uPsQvHUVqz0RRnZ
 O1K3n1OGTR1Lo/EdxC6iZFz4lHsdzeReUpjGk4l+JediMdwOrBMXcmCgDQgaPk7/oSzvIScw1U
 6tGSBjUZWopBz5j5d7nXvHyUf0/g95Ou9fcJl+l+E7rloQgnSdiF4G8H3gd8+OZ/463XIB7E0T
 fTQRE2lSaJkA+R118euxY1WD62AKq2KNg0AGeqprDdar3X1gkkXHXWrjXUQo4KNNiuNWGlTdFB
 l0XPbRG822q51fbktGltftq5z4LeXu7Wuv+aWrzUBVADdsLdPep7nP11fRwgdAgAA
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

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chris Li <chrisl@kernel.org>
---
Changes in v8:
- Fix some white space damage discovered by Yosry. No actual code change.
- Collect review tags.
- Link to v7: https://lore.kernel.org/r/20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org

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
 mm/zswap.c | 178 ++++++++++++++++++-------------------------------------------
 1 file changed, 53 insertions(+), 125 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index b31c977f53e9..a97de9e547df 100644
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
@@ -1556,28 +1474,44 @@ bool zswap_store(struct folio *folio)
 insert_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
+
+	old = xa_store(tree, offset, entry, GFP_KERNEL);
+	if (xa_is_err(old)) {
+		int err = xa_err(old);
+
+		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
+		zswap_reject_alloc_fail++;
+		goto store_failed;
+	}
+
+	/*
+	 * We may have had an existing entry that became stale when
+	 * the folio was redirtied and now the new version is being
+	 * swapped out. Get rid of the old.
+	 */
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
@@ -1585,8 +1519,14 @@ bool zswap_store(struct folio *folio)
 
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
@@ -1597,11 +1537,9 @@ bool zswap_store(struct folio *folio)
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
@@ -1614,20 +1552,15 @@ bool zswap_load(struct folio *folio)
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
@@ -1651,19 +1584,17 @@ bool zswap_load(struct folio *folio)
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
@@ -1673,11 +1604,8 @@ int zswap_swapon(int type, unsigned long nr_pages)
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
@@ -1686,7 +1614,7 @@ int zswap_swapon(int type, unsigned long nr_pages)
 
 void zswap_swapoff(int type)
 {
-	struct zswap_tree *trees = zswap_trees[type];
+	struct xarray *trees = zswap_trees[type];
 	unsigned int i;
 
 	if (!trees)
@@ -1694,7 +1622,7 @@ void zswap_swapoff(int type)
 
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


