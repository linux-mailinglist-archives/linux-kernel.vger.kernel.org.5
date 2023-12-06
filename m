Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7349806AFF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377255AbjLFJqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377267AbjLFJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:46:31 -0500
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA4EB9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:46:37 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <zhouchengming@bytedance.com>
Date:   Wed, 06 Dec 2023 09:46:25 +0000
Subject: [PATCH 2/7] mm/zswap: split zswap rb-tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231206-zswap-lock-optimize-v1-2-e25b059f9c3a@bytedance.com>
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
In-Reply-To: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701855988; l=6878;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=91S6pF6My/bUROdLpQALha8Vf8LlqYuhabIDQmuzuWI=;
 b=wPMG7SuyQz02Gmf6/zoPkNXypnlp9pzAs3LaGP2c2Co5uxHZeHfDwL1yFMzUvPUEcTV7ChSyQ
 ajsHFI83VQLCQGcg29JkEtY4nc6utk5FaXQG6gU7Y5SrzXyxOn7RFyY
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each swapfile has one rb-tree to search the mapping of swp_entry_t to
zswap_entry, that use a spinlock to protect, which can cause heavy lock
contention if multiple tasks zswap_store/load concurrently.

Optimize the scalability problem by splitting the zswap rb-tree into
multiple rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M),
just like we did in the swap cache address_space splitting.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/zswap.h |  4 +--
 mm/swapfile.c         |  2 +-
 mm/zswap.c            | 69 ++++++++++++++++++++++++++++++++-------------------
 3 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 7cccc02cb9e9..d3a8bc300b70 100644
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
@@ -50,7 +50,7 @@ static inline bool zswap_load(struct folio *folio)
 }
 
 static inline void zswap_invalidate(int type, pgoff_t offset) {}
-static inline int zswap_swapon(int type) {}
+static inline int zswap_swapon(int type, unsigned long nr_pages) {}
 static inline void zswap_swapoff(int type) {}
 static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
 static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 939e7590feda..da8367a3e076 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3163,7 +3163,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (error)
 		goto bad_swap_unlock_inode;
 
-	error = zswap_swapon(p->type);
+	error = zswap_swapon(p->type, maxpages);
 	if (error)
 		goto free_swap_address_space;
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 5e2b8d5ee33b..a6b4859a0164 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -234,6 +234,7 @@ struct zswap_tree {
 };
 
 static struct zswap_tree *zswap_trees[MAX_SWAPFILES];
+static unsigned int nr_zswap_trees[MAX_SWAPFILES];
 
 /* RCU-protected iteration */
 static LIST_HEAD(zswap_pools);
@@ -260,6 +261,10 @@ static bool zswap_has_pool;
 * helpers and fwd declarations
 **********************************/
 
+#define swap_zswap_tree(entry)					\
+	(&zswap_trees[swp_type(entry)][swp_offset(entry)	\
+		>> SWAP_ADDRESS_SPACE_SHIFT])
+
 #define zswap_pool_debug(msg, p)				\
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpools[0]))
@@ -885,7 +890,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	 * until the entry is verified to still be alive in the tree.
 	 */
 	swpoffset = swp_offset(entry->swpentry);
-	tree = zswap_trees[swp_type(entry->swpentry)];
+	tree = swap_zswap_tree(entry->swpentry);
 	list_lru_isolate(l, item);
 	/*
 	 * It's safe to drop the lock here because we return either
@@ -1535,10 +1540,9 @@ static void zswap_fill_page(void *ptr, unsigned long value)
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
@@ -1610,7 +1614,7 @@ bool zswap_store(struct folio *folio)
 		src = kmap_local_page(page);
 		if (zswap_is_page_same_filled(src, &value)) {
 			kunmap_local(src);
-			entry->swpentry = swp_entry(type, offset);
+			entry->swpentry = swp;
 			entry->length = 0;
 			entry->value = value;
 			atomic_inc(&zswap_same_filled_pages);
@@ -1688,7 +1692,7 @@ bool zswap_store(struct folio *folio)
 	mutex_unlock(acomp_ctx->mutex);
 
 	/* populate entry */
-	entry->swpentry = swp_entry(type, offset);
+	entry->swpentry = swp;
 	entry->handle = handle;
 	entry->length = dlen;
 
@@ -1748,10 +1752,9 @@ bool zswap_store(struct folio *folio)
 bool zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
-	int type = swp_type(swp);
 	pgoff_t offset = swp_offset(swp);
 	struct page *page = &folio->page;
-	struct zswap_tree *tree = zswap_trees[type];
+	struct zswap_tree *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
@@ -1835,7 +1838,7 @@ bool zswap_load(struct folio *folio)
 
 void zswap_invalidate(int type, pgoff_t offset)
 {
-	struct zswap_tree *tree = zswap_trees[type];
+	struct zswap_tree *tree = swap_zswap_tree(swp_entry(type, offset));
 	struct zswap_entry *entry;
 
 	/* find */
@@ -1850,37 +1853,53 @@ void zswap_invalidate(int type, pgoff_t offset)
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
