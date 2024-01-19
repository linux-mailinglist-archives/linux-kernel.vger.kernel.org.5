Return-Path: <linux-kernel+bounces-31087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43238328B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056FE1C22F83
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEB54CE12;
	Fri, 19 Jan 2024 11:22:38 +0000 (UTC)
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833734CB40
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663358; cv=none; b=tYQqusq6cUvSDBOyqAWOSMzCjgTex0IeDfXu4aW/eUkPutHpYN0gNQoPau6BHljjQ08pNUjW4XrkHEqQKG9LDItw3Lb/VRSqMPQHnRovsVfXg0Nlbi/bnIgeOVhixbe0KUC7SQui0N32kG3VT9Ilj/1YeMviDJbyG+w3kgJtS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663358; c=relaxed/simple;
	bh=STTBS161JIPRA1SjEhSl0dRb0yjkdHTr74XohKywC4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOgSrStsReVKy6tBrG7MncYa36YMip4MpSxroh9RTEdG6/ESEdp/KCqsUpyXGZ/a69EgleJ4/hWA5IU+aS3554PMEb4ChFeYZZAc8eOOmX+Y8Bki4v+m37z7ws3apXGPy+bDq0pB4HCVLAkTySieYM+SXDONZaTPpnj1IxFxipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Fri, 19 Jan 2024 11:22:23 +0000
Subject: [PATCH v2 2/2] mm/zswap: split zswap rb-tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-b4-zswap-lock-optimize-v2-2-b5cc55479090@bytedance.com>
References: <20240117-b4-zswap-lock-optimize-v2-0-b5cc55479090@bytedance.com>
In-Reply-To: <20240117-b4-zswap-lock-optimize-v2-0-b5cc55479090@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Chris Li <chriscli@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
 Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705663348; l=7114;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=STTBS161JIPRA1SjEhSl0dRb0yjkdHTr74XohKywC4w=;
 b=bFo0QeQtyjGFtSnh6n45b8T++jbrYv6goBtMlmOhBp57yOKq5hpghI9HgNN1SmSD5s74vuMrs
 IZviwVVhWvnB0bY8nwHQvC2IyjnrT1wztQQGlfihj14bSKT5rd31aq+
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Each swapfile has one rb-tree to search the mapping of swp_entry_t to
zswap_entry, that use a spinlock to protect, which can cause heavy lock
contention if multiple tasks zswap_store/load concurrently.

Optimize the scalability problem by splitting the zswap rb-tree into
multiple rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M),
just like we did in the swap cache address_space splitting.

Although this method can't solve the spinlock contention completely, it
can mitigate much of that contention. Below is the results of kernel build
in tmpfs with zswap shrinker enabled:

     linux-next  zswap-lock-optimize
real 1m9.181s    1m3.820s
user 17m44.036s  17m40.100s
sys  7m37.297s   4m54.622s

So there are clearly improvements.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/zswap.h |  4 +--
 mm/swapfile.c         |  2 +-
 mm/zswap.c            | 71 +++++++++++++++++++++++++++++++++------------------
 3 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index eca388229d9a..91895ce1fdbc 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -30,7 +30,7 @@ struct zswap_lruvec_state {
 bool zswap_store(struct folio *folio);
 bool zswap_load(struct folio *folio);
 void zswap_invalidate(int type, pgoff_t offset);
-int zswap_swapon(int type);
+int zswap_swapon(int type, unsigned long nr_pages);
 void zswap_swapoff(int type);
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
 void zswap_lruvec_state_init(struct lruvec *lruvec);
@@ -51,7 +51,7 @@ static inline bool zswap_load(struct folio *folio)
 }
 
 static inline void zswap_invalidate(int type, pgoff_t offset) {}
-static inline int zswap_swapon(int type)
+static inline int zswap_swapon(int type, unsigned long nr_pages)
 {
 	return 0;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6c53ea06626b..35aa17b2a2fa 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3164,7 +3164,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (error)
 		goto bad_swap_unlock_inode;
 
-	error = zswap_swapon(p->type);
+	error = zswap_swapon(p->type, maxpages);
 	if (error)
 		goto free_swap_address_space;
 
diff --git a/mm/zswap.c b/mm/zswap.c
index d88faea85978..2885f4fb6dcb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -239,6 +239,7 @@ struct zswap_tree {
 };
 
 static struct zswap_tree *zswap_trees[MAX_SWAPFILES];
+static unsigned int nr_zswap_trees[MAX_SWAPFILES];
 
 /* RCU-protected iteration */
 static LIST_HEAD(zswap_pools);
@@ -265,6 +266,12 @@ static bool zswap_has_pool;
 * helpers and fwd declarations
 **********************************/
 
+static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
+{
+	return &zswap_trees[swp_type(swp)][swp_offset(swp)
+		>> SWAP_ADDRESS_SPACE_SHIFT];
+}
+
 #define zswap_pool_debug(msg, p)				\
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpools[0]))
@@ -865,7 +872,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	 * until the entry is verified to still be alive in the tree.
 	 */
 	swpoffset = swp_offset(entry->swpentry);
-	tree = zswap_trees[swp_type(entry->swpentry)];
+	tree = swap_zswap_tree(entry->swpentry);
 	list_lru_isolate(l, item);
 	/*
 	 * It's safe to drop the lock here because we return either
@@ -1494,10 +1501,9 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 bool zswap_store(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
-	int type = swp_type(swp);
 	pgoff_t offset = swp_offset(swp);
 	struct page *page = &folio->page;
-	struct zswap_tree *tree = zswap_trees[type];
+	struct zswap_tree *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry, *dupentry;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
@@ -1569,7 +1575,7 @@ bool zswap_store(struct folio *folio)
 		src = kmap_local_page(page);
 		if (zswap_is_page_same_filled(src, &value)) {
 			kunmap_local(src);
-			entry->swpentry = swp_entry(type, offset);
+			entry->swpentry = swp;
 			entry->length = 0;
 			entry->value = value;
 			atomic_inc(&zswap_same_filled_pages);
@@ -1651,7 +1657,7 @@ bool zswap_store(struct folio *folio)
 	mutex_unlock(&acomp_ctx->mutex);
 
 	/* populate entry */
-	entry->swpentry = swp_entry(type, offset);
+	entry->swpentry = swp;
 	entry->handle = handle;
 	entry->length = dlen;
 
@@ -1711,10 +1717,9 @@ bool zswap_store(struct folio *folio)
 bool zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
-	int type = swp_type(swp);
 	pgoff_t offset = swp_offset(swp);
 	struct page *page = &folio->page;
-	struct zswap_tree *tree = zswap_trees[type];
+	struct zswap_tree *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 	u8 *dst;
 
@@ -1757,7 +1762,7 @@ bool zswap_load(struct folio *folio)
 
 void zswap_invalidate(int type, pgoff_t offset)
 {
-	struct zswap_tree *tree = zswap_trees[type];
+	struct zswap_tree *tree = swap_zswap_tree(swp_entry(type, offset));
 	struct zswap_entry *entry;
 
 	/* find */
@@ -1772,37 +1777,53 @@ void zswap_invalidate(int type, pgoff_t offset)
 	spin_unlock(&tree->lock);
 }
 
-int zswap_swapon(int type)
+int zswap_swapon(int type, unsigned long nr_pages)
 {
-	struct zswap_tree *tree;
+	struct zswap_tree *trees, *tree;
+	unsigned int nr, i;
 
-	tree = kzalloc(sizeof(*tree), GFP_KERNEL);
-	if (!tree) {
+	nr = DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
+	trees = kvcalloc(nr, sizeof(*tree), GFP_KERNEL);
+	if (!trees) {
 		pr_err("alloc failed, zswap disabled for swap type %d\n", type);
 		return -ENOMEM;
 	}
 
-	tree->rbroot = RB_ROOT;
-	spin_lock_init(&tree->lock);
-	zswap_trees[type] = tree;
+	for (i = 0; i < nr; i++) {
+		tree = trees + i;
+		tree->rbroot = RB_ROOT;
+		spin_lock_init(&tree->lock);
+	}
+
+	nr_zswap_trees[type] = nr;
+	zswap_trees[type] = trees;
 	return 0;
 }
 
 void zswap_swapoff(int type)
 {
-	struct zswap_tree *tree = zswap_trees[type];
-	struct zswap_entry *entry, *n;
+	struct zswap_tree *trees = zswap_trees[type];
+	unsigned int i;
 
-	if (!tree)
+	if (!trees)
 		return;
 
-	/* walk the tree and free everything */
-	spin_lock(&tree->lock);
-	rbtree_postorder_for_each_entry_safe(entry, n, &tree->rbroot, rbnode)
-		zswap_free_entry(entry);
-	tree->rbroot = RB_ROOT;
-	spin_unlock(&tree->lock);
-	kfree(tree);
+	for (i = 0; i < nr_zswap_trees[type]; i++) {
+		struct zswap_tree *tree = trees + i;
+		struct zswap_entry *entry, *n;
+
+		/* walk the tree and free everything */
+		spin_lock(&tree->lock);
+		rbtree_postorder_for_each_entry_safe(entry, n,
+						     &tree->rbroot,
+						     rbnode)
+			zswap_free_entry(entry);
+		tree->rbroot = RB_ROOT;
+		spin_unlock(&tree->lock);
+	}
+
+	kvfree(trees);
+	nr_zswap_trees[type] = 0;
 	zswap_trees[type] = NULL;
 }
 

-- 
b4 0.10.1

