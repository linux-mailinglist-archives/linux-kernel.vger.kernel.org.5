Return-Path: <linux-kernel+bounces-99607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE9E878AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E669C281E44
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660875787D;
	Mon, 11 Mar 2024 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atAGu7Rz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD0857861
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195971; cv=none; b=ooGlKL4wjLSVpWnKM8D7Rk/fIljxokuw8xLIfAQTUenMZsx8IP+V6NXdZ2RhCFw7bAdA+iQs/MIJmSl3yxk0GHfT5j1KcnU2lJYP1qpm0kutmlDymZkLvkJ7lzM/SPWV6GDgvWAOTIWrh+aL0UebIjnT9LNRTv4Ofa7U2Zlu6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195971; c=relaxed/simple;
	bh=8qEHP8w+/NNRQXfiAq53yZAb2gXCzb5JNyISxEXeDgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jpfSOGKMMwkaEN/q63AetvwDarYX2ITIDRggJpvH9zl/6qGysBafvp9TBmm/CIUSvQmKlogIUBcuD9OwGvH9hhMxNzKpbfIJ+/AvX1bBHoDm5ZJL+kxeTOBWfJJUpfLNE/wakuzi7/kYbbuA4tthCtInS/NKtZQaPbQJOHCz0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atAGu7Rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570D1C433F1;
	Mon, 11 Mar 2024 22:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710195970;
	bh=8qEHP8w+/NNRQXfiAq53yZAb2gXCzb5JNyISxEXeDgI=;
	h=From:Date:Subject:To:Cc:From;
	b=atAGu7RzGViuchpmt4pTcmWefbP1XU28j4UDDaWHh/YWk85P/n5zxIlm/sndVa4QX
	 92aeyIcEQ9IljITr0XGGWHVbUo6Rr0G3IpQuWM1kWnsutyBJC0xsv/ECpQXn0u7RT0
	 KCiGfQ1WiDtOd6U6YzGt5hO5mIrVXzy21CDArotinawlZWbBHtPl83PIDq4GZ6DMqc
	 t16uxRt+UhIHx2/HsJlHCjAVsEJFJJVYMaZQ7CRGlNWAtgpokfj5jBIQedCiGnrRSl
	 Bs/yGWy+k5xUdDF2DIQr71fGwkb+SRKwwZd24OThQwKYefs+Ey9AlzGH4v+PKuf6YG
	 buIpwu0C+npVg==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 11 Mar 2024 15:26:05 -0700
Subject: [PATCH v5] zswap: replace RB tree with xarray
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-zswap-xarray-v5-1-a3031feb9c85@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPyE72UC/2XQyw7CIBCF4VdpWIsZhkurK9/DuKB0aommNWDwl
 r671JiodXmGfP+CB4sUPEW2Lh4sUPLRD30eelEw19l+T9w3eTMEVCBA8Xu82BO/2hDsjZfCoAH
 SSpBkmZwCtf76ym13eXc+nodwe9WTmK7vkCh/Q0lw4KaxtjIOqtbS5kChp+NyCHs2lRJ+NOJqp
 pELThqwUk3rmlr8afnREnCmZdZ6BYAaW8zPf1p969kXJJW1U7XSpgTnJPzocRyfNIyQ0mMBAAA
 =
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

mm-9a0181a3710eb             xarray v5
user       3532.385			3535.658
sys        536.231                      530.083
real       200.431                      200.176

---


Signed-off-by: Chris Li <chrisl@kernel.org>
---
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
 mm/zswap.c | 166 +++++++++++++++----------------------------------------------
 1 file changed, 41 insertions(+), 125 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 011e068eb355..4c3139583a6c 100644
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
@@ -196,7 +195,6 @@ static struct {
  * This structure contains the metadata for tracking a single compressed
  * page within zswap.
  *
- * rbnode - links the entry into red-black tree for the appropriate swap type
  * swpentry - associated swap entry, the offset indexes into the red-black tree
  * length - the length in bytes of the compressed page data.  Needed during
  *          decompression. For a same value filled page length is 0, and both
@@ -208,7 +206,6 @@ static struct {
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
@@ -804,63 +796,6 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
 	spin_unlock(&zswap.shrink_lock);
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
@@ -872,7 +807,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
 	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
 	if (!entry)
 		return NULL;
-	RB_CLEAR_NODE(&entry->rbnode);
 	return entry;
 }
 
@@ -914,17 +848,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
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
@@ -1113,7 +1036,8 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 static int zswap_writeback_entry(struct zswap_entry *entry,
 				 swp_entry_t swpentry)
 {
-	struct zswap_tree *tree;
+	struct xarray *tree;
+	pgoff_t offset = swp_offset(swpentry);
 	struct folio *folio;
 	struct mempolicy *mpol;
 	bool folio_was_allocated;
@@ -1150,19 +1074,13 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
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
@@ -1471,8 +1389,8 @@ bool zswap_store(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
-	struct zswap_tree *tree = swap_zswap_tree(swp);
-	struct zswap_entry *entry, *dupentry;
+	struct xarray *tree = swap_zswap_tree(swp);
+	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 
@@ -1555,28 +1473,32 @@ bool zswap_store(struct folio *folio)
 insert_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
-	if (objcg) {
-		obj_cgroup_charge_zswap(objcg, entry->length);
-		/* Account before objcg ref is moved to tree */
-		count_objcg_event(objcg, ZSWPOUT);
-	}
 
-	/* map */
-	spin_lock(&tree->lock);
 	/*
 	 * The folio may have been dirtied again, invalidate the
 	 * possibly stale entry before inserting the new entry.
 	 */
-	if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
-		zswap_invalidate_entry(tree, dupentry);
-		WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
+	old = xa_store(tree, offset, entry, GFP_KERNEL);
+
+	if (xa_is_err(old)) {
+		if (xa_err(old) == -ENOMEM)
+			zswap_reject_alloc_fail++;
+		goto store_failed;
+	}
+	if (old)
+		zswap_entry_free(old);
+
+	if (objcg) {
+		obj_cgroup_charge_zswap(objcg, entry->length);
+		/* Account before objcg ref is moved to tree */
+		count_objcg_event(objcg, ZSWPOUT);
 	}
+
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&zswap.list_lru, entry);
 		atomic_inc(&zswap.nr_stored);
 	}
-	spin_unlock(&tree->lock);
 
 	/* update stats */
 	atomic_inc(&zswap_stored_pages);
@@ -1585,6 +1507,12 @@ bool zswap_store(struct folio *folio)
 
 	return true;
 
+store_failed:
+	if (!entry->length) {
+		atomic_dec(&zswap_same_filled_pages);
+		goto freepage;
+	}
+	zpool_free(zswap_find_zpool(entry), entry->handle);
 put_pool:
 	zswap_pool_put(entry->pool);
 freepage:
@@ -1598,11 +1526,9 @@ bool zswap_store(struct folio *folio)
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
@@ -1615,20 +1541,15 @@ bool zswap_load(struct folio *folio)
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
@@ -1652,19 +1573,17 @@ bool zswap_load(struct folio *folio)
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
@@ -1674,11 +1593,8 @@ int zswap_swapon(int type, unsigned long nr_pages)
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
@@ -1687,7 +1603,7 @@ int zswap_swapon(int type, unsigned long nr_pages)
 
 void zswap_swapoff(int type)
 {
-	struct zswap_tree *trees = zswap_trees[type];
+	struct xarray *trees = zswap_trees[type];
 	unsigned int i;
 
 	if (!trees)
@@ -1695,7 +1611,7 @@ void zswap_swapoff(int type)
 
 	/* try_to_unuse() invalidated all the entries already */
 	for (i = 0; i < nr_zswap_trees[type]; i++)
-		WARN_ON_ONCE(!RB_EMPTY_ROOT(&trees[i].rbroot));
+		WARN_ON_ONCE(!xa_empty(trees + i));
 
 	kvfree(trees);
 	nr_zswap_trees[type] = 0;

---
base-commit: 9a0181a3710eba1f5c6d19eadcca888be3d54e4f
change-id: 20240104-zswap-xarray-716260e541e3

Best regards,
-- 
Chris Li <chrisl@kernel.org>


