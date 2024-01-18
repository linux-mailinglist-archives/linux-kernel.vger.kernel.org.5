Return-Path: <linux-kernel+bounces-29679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C94138311A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DC11F24D03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB508F40;
	Thu, 18 Jan 2024 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcZdgahe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88306FBC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705547162; cv=none; b=lCQlIhBcvcaKy/+HlLdRJwlluUPL/p55WilhUTJJYb4UHQKGNelKcpPoYy1QYydKkwMltWQVvEbQw6mvrQMGVWkuE8+NOPSwwHS9szCpVZwrlP8+XQydBV8kbu99cPe9F5hmKaVyWT6Owhn9hYrjaWbOVAWRcJy+vL3t1/k4m5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705547162; c=relaxed/simple;
	bh=3DwC3VSiZT27oLdnDyvSWHDXtxL2ymfHgLFoSU1pH4U=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer; b=VplEcRhnJodpNWxULKXMNj2DQDOIxxvE1CSGXJRAz5XjKjndcAqGJSZtBX4vYK3aGZM8/QJhpgbmom86MHIvjHwFBoX9YwUWkGoOneAXVAE1PbMBBkIOyULijxDBcTHRlj3Zu9EyHRCJSA7Mm+VBsagayvn6o4uLQBsCLIdaCRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcZdgahe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE59BC433F1;
	Thu, 18 Jan 2024 03:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705547161;
	bh=3DwC3VSiZT27oLdnDyvSWHDXtxL2ymfHgLFoSU1pH4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UcZdgahelcMT357ClgpltNiCRfjxsyoHwta5sDcXBwfjRTuVsvctiRl2f8upxk2xA
	 FDiwiSUN3lsR6RWtiq2VDQhLVDMpp0yL8V8xYF1yb4mKGNIwnB/KRuvnXYdJfpFv/u
	 di38kb1QAXM+u0PSjzT3jHeTUB3MWI3tB4hed9UjBZ28cb5FW2V5sz9XrNJ30WQi4a
	 ggZUMMXmawcXpWbaq4oMsvR81FtYGkgWFCf1mUuA3li8WfSGkncv27Y+vAlTw587+6
	 qS7JFORCfCQeOjAmZlvt2v6e2Wlj9/yFhd0uXGgf2cNLKgRh6EO5TcuDplwtcF/3v5
	 6hZz7U7jcGp+Q==
From: Chris Li <chrisl@kernel.org>
Date: Wed, 17 Jan 2024 19:05:41 -0800
Subject: [PATCH 1/2] mm: zswap.c: add xarray tree to zswap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org>
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
In-Reply-To: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 =?utf-8?q?Wei_Xu=EF=BF=BC?= <weixugc@google.com>, 
 Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
 Chun-Tse Shao <ctshao@google.com>, 
 =?utf-8?q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
 Yosry Ahmed <yosryahmed@google.com>, Brain Geffon <bgeffon@google.com>, 
 Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Kairui Song <kasong@tencent.com>, 
 Zhongkun He <hezhongkun.hzk@bytedance.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Barry Song <v-songbaohua@oppo.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.12.3

The xarray tree is added alongside the zswap RB tree.
Checks for the xarray get the same result as the RB tree operations.

Rename the zswap RB tree function to a more generic function
name without the RB part.
---
 mm/zswap.c | 60 ++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f8bc9e089268..a40b0076722b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -235,6 +235,7 @@ struct zswap_entry {
  */
 struct zswap_tree {
 	struct rb_root rbroot;
+	struct xarray xarray;
 	spinlock_t lock;
 };
 
@@ -462,9 +463,9 @@ static void zswap_lru_putback(struct list_lru *list_lru,
 /*********************************
 * rbtree functions
 **********************************/
-static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t offset)
+static struct zswap_entry *zswap_search(struct zswap_tree *tree, pgoff_t offset)
 {
-	struct rb_node *node = root->rb_node;
+	struct rb_node *node = tree->rbroot.rb_node;
 	struct zswap_entry *entry;
 	pgoff_t entry_offset;
 
@@ -475,8 +476,12 @@ static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t offset)
 			node = node->rb_left;
 		else if (entry_offset < offset)
 			node = node->rb_right;
-		else
+		else {
+			struct zswap_entry *e = xa_load(&tree->xarray, offset);
+
+			BUG_ON(entry != e);
 			return entry;
+		}
 	}
 	return NULL;
 }
@@ -485,13 +490,15 @@ static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t offset)
  * In the case that a entry with the same offset is found, a pointer to
  * the existing entry is stored in dupentry and the function returns -EEXIST
  */
-static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *entry,
+static int zswap_insert(struct zswap_tree *tree, struct zswap_entry *entry,
 			struct zswap_entry **dupentry)
 {
+	struct rb_root *root = &tree->rbroot;
 	struct rb_node **link = &root->rb_node, *parent = NULL;
-	struct zswap_entry *myentry;
+	struct zswap_entry *myentry, *old;
 	pgoff_t myentry_offset, entry_offset = swp_offset(entry->swpentry);
 
+
 	while (*link) {
 		parent = *link;
 		myentry = rb_entry(parent, struct zswap_entry, rbnode);
@@ -501,19 +508,26 @@ static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *entry,
 		else if (myentry_offset < entry_offset)
 			link = &(*link)->rb_right;
 		else {
+			old = xa_load(&tree->xarray, entry_offset);
+			BUG_ON(old != myentry);
 			*dupentry = myentry;
 			return -EEXIST;
 		}
 	}
 	rb_link_node(&entry->rbnode, parent, link);
 	rb_insert_color(&entry->rbnode, root);
+	old = xa_store(&tree->xarray, entry_offset, entry, GFP_KERNEL);
 	return 0;
 }
 
-static bool zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
+static bool zswap_erase(struct zswap_tree *tree, struct zswap_entry *entry)
 {
+	pgoff_t offset = swp_offset(entry->swpentry);
 	if (!RB_EMPTY_NODE(&entry->rbnode)) {
-		rb_erase(&entry->rbnode, root);
+		struct zswap_entry *old;
+		old = xa_erase(&tree->xarray, offset);
+		BUG_ON(old != entry);
+		rb_erase(&entry->rbnode, &tree->rbroot);
 		RB_CLEAR_NODE(&entry->rbnode);
 		return true;
 	}
@@ -575,12 +589,12 @@ static void zswap_entry_put(struct zswap_tree *tree,
 }
 
 /* caller must hold the tree lock */
-static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
+static struct zswap_entry *zswap_entry_find_get(struct zswap_tree *tree,
 				pgoff_t offset)
 {
 	struct zswap_entry *entry;
 
-	entry = zswap_rb_search(root, offset);
+	entry = zswap_search(tree, offset);
 	if (entry)
 		zswap_entry_get(entry);
 
@@ -845,7 +859,7 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 static void zswap_invalidate_entry(struct zswap_tree *tree,
 				   struct zswap_entry *entry)
 {
-	if (zswap_rb_erase(&tree->rbroot, entry))
+	if (zswap_erase(tree, entry))
 		zswap_entry_put(tree, entry);
 }
 
@@ -875,7 +889,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 
 	/* Check for invalidate() race */
 	spin_lock(&tree->lock);
-	if (entry != zswap_rb_search(&tree->rbroot, swpoffset))
+	if (entry != zswap_search(tree, swpoffset))
 		goto unlock;
 
 	/* Hold a reference to prevent a free during writeback */
@@ -1407,6 +1421,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 				 struct zswap_tree *tree)
 {
 	swp_entry_t swpentry = entry->swpentry;
+	pgoff_t offset = swp_offset(swpentry);
+	struct zswap_entry *e;
 	struct folio *folio;
 	struct mempolicy *mpol;
 	bool folio_was_allocated;
@@ -1439,7 +1455,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * avoid overwriting a new swap folio with old compressed data.
 	 */
 	spin_lock(&tree->lock);
-	if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
+	e = zswap_search(tree, offset);
+	if (e != entry) {
 		spin_unlock(&tree->lock);
 		delete_from_swap_cache(folio);
 		return -ENOMEM;
@@ -1528,7 +1545,7 @@ bool zswap_store(struct folio *folio)
 	 * the tree, and it might be written back overriding the new data.
 	 */
 	spin_lock(&tree->lock);
-	dupentry = zswap_rb_search(&tree->rbroot, offset);
+	dupentry = zswap_search(tree, offset);
 	if (dupentry) {
 		zswap_duplicate_entry++;
 		zswap_invalidate_entry(tree, dupentry);
@@ -1671,7 +1688,7 @@ bool zswap_store(struct folio *folio)
 	 * found again here it means that something went wrong in the swap
 	 * cache.
 	 */
-	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
+	while (zswap_insert(tree, entry, &dupentry) == -EEXIST) {
 		WARN_ON(1);
 		zswap_duplicate_entry++;
 		zswap_invalidate_entry(tree, dupentry);
@@ -1722,7 +1739,7 @@ bool zswap_load(struct folio *folio)
 
 	/* find */
 	spin_lock(&tree->lock);
-	entry = zswap_entry_find_get(&tree->rbroot, offset);
+	entry = zswap_entry_find_get(tree, offset);
 	if (!entry) {
 		spin_unlock(&tree->lock);
 		return false;
@@ -1762,7 +1779,7 @@ void zswap_invalidate(int type, pgoff_t offset)
 
 	/* find */
 	spin_lock(&tree->lock);
-	entry = zswap_rb_search(&tree->rbroot, offset);
+	entry = zswap_search(tree, offset);
 	if (!entry) {
 		/* entry was written back */
 		spin_unlock(&tree->lock);
@@ -1783,6 +1800,7 @@ void zswap_swapon(int type)
 	}
 
 	tree->rbroot = RB_ROOT;
+	xa_init(&tree->xarray);
 	spin_lock_init(&tree->lock);
 	zswap_trees[type] = tree;
 }
@@ -1790,15 +1808,21 @@ void zswap_swapon(int type)
 void zswap_swapoff(int type)
 {
 	struct zswap_tree *tree = zswap_trees[type];
-	struct zswap_entry *entry, *n;
+	struct zswap_entry *entry, *e, *n;
+	XA_STATE(xas, tree ? &tree->xarray : NULL, 0);
 
 	if (!tree)
 		return;
 
 	/* walk the tree and free everything */
 	spin_lock(&tree->lock);
+
+	xas_for_each(&xas, e, ULONG_MAX)
+		zswap_invalidate_entry(tree, e);
+
 	rbtree_postorder_for_each_entry_safe(entry, n, &tree->rbroot, rbnode)
-		zswap_free_entry(entry);
+		BUG_ON(entry);
+
 	tree->rbroot = RB_ROOT;
 	spin_unlock(&tree->lock);
 	kfree(tree);

-- 
2.43.0.429.g432eaa2c6b-goog


