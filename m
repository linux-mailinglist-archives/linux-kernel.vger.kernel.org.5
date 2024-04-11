Return-Path: <linux-kernel+bounces-139831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30628A0838
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3BFB27A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1511213C66C;
	Thu, 11 Apr 2024 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZbDdNNv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC23713CAAB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816076; cv=none; b=Jcv1kUueS4xeuUXnguLGJ01w91Mw96FJKN25qILsNYLM/ffI7PcEOQGPgP3W+W4cn4BaN9osnTNy3Y6K35ak+KY7VR4xWbn90YMpysYsWRHeX5FtSMb9QQUOy5NkMreQZSADVn2NVlbIFg0qoVVRnlTHgFf/HD0H8V3lgK34s8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816076; c=relaxed/simple;
	bh=2GVVNpZMi5SoTTNTvQBXF2hh1UdkIACaQFTD3ARx8EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNDcQGV1JaSkZ1sQnYKNj7zbnj/nvtPh6YPcE2QdOEV0g7wxBoIFvZow6KDxRfZWSMc1cRS3y4/9G7LKDH2htgiXR2nqzAp/LV5l9HyPM7HZn6mCXb4HHuGeFTjFgomJAp3q7tTINgdhVJD+T7T+rAlTRmJbEFPVauc+l2LP+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZbDdNNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7467CC433A6;
	Thu, 11 Apr 2024 06:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712816076;
	bh=2GVVNpZMi5SoTTNTvQBXF2hh1UdkIACaQFTD3ARx8EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZbDdNNv+PdK5e/4usAYNkLbBkxlnYZtRLhqtuKjdrjfruV8UtzX0jKTK/9QF9C7T
	 2izxyzQb3XkkUTQfYGWSJltVH7hJNqdRbI5ufVdeGrZ4eE8iRVg92gfk37kcgSam8R
	 sNdH5DbwlRmSHHz70fyi4kA3ZzSGdp7Qer9Neo6/q1mEippdSBAO/6Nc4AnMd59Y1z
	 /K31XoL8y/oSn3Urp0w8+MzRhKYkAkyREehCPKr6uavwQpqcYJB5SCkFK2Aw6tjZCo
	 lxhClL9gOgqu39nQ+tQo+6z847FWXusNLdZ+I0PKDyyd8j9g485Cdoyg7ukJtuVfZ0
	 nGMvqhqYmaXdg==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	hughd@google.com,
	chrisw@sous-sol.org,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Izik Eidus <izik.eidus@ravellosystems.com>
Subject: [PATCH v5 08/10] mm/ksm: Convert chain series funcs and replace get_ksm_page
Date: Thu, 11 Apr 2024 14:17:09 +0800
Message-ID: <20240411061713.1847574-9-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411061713.1847574-1-alexs@kernel.org>
References: <20240411061713.1847574-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

In ksm stable tree all page are single, let's convert them to use and
folios as well as stable_tree_insert/stable_tree_search funcs.
And replace get_ksm_page() by ksm_get_folio() since there is no more
needs.

It could save a few compound_head calls.

Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c     | 136 ++++++++++++++++++++++++---------------------------
 mm/migrate.c |   2 +-
 2 files changed, 66 insertions(+), 72 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2fdd6586a3a7..61a7b5b037a6 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -990,14 +990,6 @@ static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
 	return NULL;
 }
 
-static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
-				 enum get_ksm_page_flags flags)
-{
-	struct folio *folio = ksm_get_folio(stable_node, flags);
-
-	return &folio->page;
-}
-
 /*
  * Removing rmap_item from stable or unstable tree.
  * This function will clean the information from the stable/unstable tree.
@@ -1632,10 +1624,10 @@ bool is_page_sharing_candidate(struct ksm_stable_node *stable_node)
 	return __is_page_sharing_candidate(stable_node, 0);
 }
 
-static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
-				    struct ksm_stable_node **_stable_node,
-				    struct rb_root *root,
-				    bool prune_stale_stable_nodes)
+static struct folio *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
+				     struct ksm_stable_node **_stable_node,
+				     struct rb_root *root,
+				     bool prune_stale_stable_nodes)
 {
 	struct ksm_stable_node *dup, *found = NULL, *stable_node = *_stable_node;
 	struct hlist_node *hlist_safe;
@@ -1748,7 +1740,7 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 	}
 
 	*_stable_node_dup = found;
-	return &tree_folio->page;
+	return tree_folio;
 }
 
 static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stable_node,
@@ -1765,7 +1757,7 @@ static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stabl
 }
 
 /*
- * Like for get_ksm_page, this function can free the *_stable_node and
+ * Like for ksm_get_folio, this function can free the *_stable_node and
  * *_stable_node_dup if the returned tree_page is NULL.
  *
  * It can also free and overwrite *_stable_node with the found
@@ -1778,16 +1770,16 @@ static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stabl
  * function and will be overwritten in all cases, the caller doesn't
  * need to initialize it.
  */
-static struct page *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
-					struct ksm_stable_node **_stable_node,
-					struct rb_root *root,
-					bool prune_stale_stable_nodes)
+static struct folio *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
+					 struct ksm_stable_node **_stable_node,
+					 struct rb_root *root,
+					 bool prune_stale_stable_nodes)
 {
 	struct ksm_stable_node *stable_node = *_stable_node;
 	if (!is_stable_node_chain(stable_node)) {
 		if (is_page_sharing_candidate(stable_node)) {
 			*_stable_node_dup = stable_node;
-			return get_ksm_page(stable_node, GET_KSM_PAGE_NOLOCK);
+			return ksm_get_folio(stable_node, GET_KSM_PAGE_NOLOCK);
 		}
 		/*
 		 * _stable_node_dup set to NULL means the stable_node
@@ -1800,24 +1792,24 @@ static struct page *__stable_node_chain(struct ksm_stable_node **_stable_node_du
 			       prune_stale_stable_nodes);
 }
 
-static __always_inline struct page *chain_prune(struct ksm_stable_node **s_n_d,
-						struct ksm_stable_node **s_n,
-						struct rb_root *root)
+static __always_inline struct folio *chain_prune(struct ksm_stable_node **s_n_d,
+						 struct ksm_stable_node **s_n,
+						 struct rb_root *root)
 {
 	return __stable_node_chain(s_n_d, s_n, root, true);
 }
 
-static __always_inline struct page *chain(struct ksm_stable_node **s_n_d,
-					  struct ksm_stable_node *s_n,
-					  struct rb_root *root)
+static __always_inline struct folio *chain(struct ksm_stable_node **s_n_d,
+					   struct ksm_stable_node *s_n,
+					   struct rb_root *root)
 {
 	struct ksm_stable_node *old_stable_node = s_n;
-	struct page *tree_page;
+	struct folio *tree_folio;
 
-	tree_page = __stable_node_chain(s_n_d, &s_n, root, false);
+	tree_folio = __stable_node_chain(s_n_d, &s_n, root, false);
 	/* not pruning dups so s_n cannot have changed */
 	VM_BUG_ON(s_n != old_stable_node);
-	return tree_page;
+	return tree_folio;
 }
 
 /*
@@ -1837,28 +1829,30 @@ static struct page *stable_tree_search(struct page *page)
 	struct rb_node *parent;
 	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
 	struct ksm_stable_node *page_node;
+	struct folio *folio;
 
-	page_node = page_stable_node(page);
+	folio = page_folio(page);
+	page_node = folio_stable_node(folio);
 	if (page_node && page_node->head != &migrate_nodes) {
 		/* ksm page forked */
-		get_page(page);
-		return page;
+		folio_get(folio);
+		return &folio->page;
 	}
 
-	nid = get_kpfn_nid(page_to_pfn(page));
+	nid = get_kpfn_nid(folio_pfn(folio));
 	root = root_stable_tree + nid;
 again:
 	new = &root->rb_node;
 	parent = NULL;
 
 	while (*new) {
-		struct page *tree_page;
+		struct folio *tree_folio;
 		int ret;
 
 		cond_resched();
 		stable_node = rb_entry(*new, struct ksm_stable_node, node);
 		stable_node_any = NULL;
-		tree_page = chain_prune(&stable_node_dup, &stable_node,	root);
+		tree_folio = chain_prune(&stable_node_dup, &stable_node, root);
 		/*
 		 * NOTE: stable_node may have been freed by
 		 * chain_prune() if the returned stable_node_dup is
@@ -1892,14 +1886,14 @@ static struct page *stable_tree_search(struct page *page)
 			 * write protected at all times. Any will work
 			 * fine to continue the walk.
 			 */
-			tree_page = get_ksm_page(stable_node_any,
-						 GET_KSM_PAGE_NOLOCK);
+			tree_folio = ksm_get_folio(stable_node_any,
+						   GET_KSM_PAGE_NOLOCK);
 		}
 		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
-		if (!tree_page) {
+		if (!tree_folio) {
 			/*
 			 * If we walked over a stale stable_node,
-			 * get_ksm_page() will call rb_erase() and it
+			 * ksm_get_folio() will call rb_erase() and it
 			 * may rebalance the tree from under us. So
 			 * restart the search from scratch. Returning
 			 * NULL would be safe too, but we'd generate
@@ -1909,8 +1903,8 @@ static struct page *stable_tree_search(struct page *page)
 			goto again;
 		}
 
-		ret = memcmp_pages(page, tree_page);
-		put_page(tree_page);
+		ret = memcmp_pages(page, &tree_folio->page);
+		folio_put(tree_folio);
 
 		parent = *new;
 		if (ret < 0)
@@ -1953,26 +1947,26 @@ static struct page *stable_tree_search(struct page *page)
 			 * It would be more elegant to return stable_node
 			 * than kpage, but that involves more changes.
 			 */
-			tree_page = get_ksm_page(stable_node_dup,
-						 GET_KSM_PAGE_TRYLOCK);
+			tree_folio = ksm_get_folio(stable_node_dup,
+						   GET_KSM_PAGE_TRYLOCK);
 
-			if (PTR_ERR(tree_page) == -EBUSY)
+			if (PTR_ERR(tree_folio) == -EBUSY)
 				return ERR_PTR(-EBUSY);
 
-			if (unlikely(!tree_page))
+			if (unlikely(!tree_folio))
 				/*
 				 * The tree may have been rebalanced,
 				 * so re-evaluate parent and new.
 				 */
 				goto again;
-			unlock_page(tree_page);
+			folio_unlock(tree_folio);
 
 			if (get_kpfn_nid(stable_node_dup->kpfn) !=
 			    NUMA(stable_node_dup->nid)) {
-				put_page(tree_page);
+				folio_put(tree_folio);
 				goto replace;
 			}
-			return tree_page;
+			return &tree_folio->page;
 		}
 	}
 
@@ -1985,8 +1979,8 @@ static struct page *stable_tree_search(struct page *page)
 	rb_insert_color(&page_node->node, root);
 out:
 	if (is_page_sharing_candidate(page_node)) {
-		get_page(page);
-		return page;
+		folio_get(folio);
+		return &folio->page;
 	} else
 		return NULL;
 
@@ -2011,12 +2005,12 @@ static struct page *stable_tree_search(struct page *page)
 					&page_node->node,
 					root);
 			if (is_page_sharing_candidate(page_node))
-				get_page(page);
+				folio_get(folio);
 			else
-				page = NULL;
+				folio = NULL;
 		} else {
 			rb_erase(&stable_node_dup->node, root);
-			page = NULL;
+			folio = NULL;
 		}
 	} else {
 		VM_BUG_ON(!is_stable_node_chain(stable_node));
@@ -2027,16 +2021,16 @@ static struct page *stable_tree_search(struct page *page)
 			DO_NUMA(page_node->nid = nid);
 			stable_node_chain_add_dup(page_node, stable_node);
 			if (is_page_sharing_candidate(page_node))
-				get_page(page);
+				folio_get(folio);
 			else
-				page = NULL;
+				folio = NULL;
 		} else {
-			page = NULL;
+			folio = NULL;
 		}
 	}
 	stable_node_dup->head = &migrate_nodes;
 	list_add(&stable_node_dup->list, stable_node_dup->head);
-	return page;
+	return &folio->page;
 
 chain_append:
 	/* stable_node_dup could be null if it reached the limit */
@@ -2079,7 +2073,7 @@ static struct page *stable_tree_search(struct page *page)
  * This function returns the stable tree node just allocated on success,
  * NULL otherwise.
  */
-static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
+static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 {
 	int nid;
 	unsigned long kpfn;
@@ -2089,7 +2083,7 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
 	bool need_chain = false;
 
-	kpfn = page_to_pfn(kpage);
+	kpfn = folio_pfn(kfolio);
 	nid = get_kpfn_nid(kpfn);
 	root = root_stable_tree + nid;
 again:
@@ -2097,13 +2091,13 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 	new = &root->rb_node;
 
 	while (*new) {
-		struct page *tree_page;
+		struct folio *tree_folio;
 		int ret;
 
 		cond_resched();
 		stable_node = rb_entry(*new, struct ksm_stable_node, node);
 		stable_node_any = NULL;
-		tree_page = chain(&stable_node_dup, stable_node, root);
+		tree_folio = chain(&stable_node_dup, stable_node, root);
 		if (!stable_node_dup) {
 			/*
 			 * Either all stable_node dups were full in
@@ -2125,14 +2119,14 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 			 * write protected at all times. Any will work
 			 * fine to continue the walk.
 			 */
-			tree_page = get_ksm_page(stable_node_any,
-						 GET_KSM_PAGE_NOLOCK);
+			tree_folio = ksm_get_folio(stable_node_any,
+						   GET_KSM_PAGE_NOLOCK);
 		}
 		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
-		if (!tree_page) {
+		if (!tree_folio) {
 			/*
 			 * If we walked over a stale stable_node,
-			 * get_ksm_page() will call rb_erase() and it
+			 * ksm_get_folio() will call rb_erase() and it
 			 * may rebalance the tree from under us. So
 			 * restart the search from scratch. Returning
 			 * NULL would be safe too, but we'd generate
@@ -2142,8 +2136,8 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 			goto again;
 		}
 
-		ret = memcmp_pages(kpage, tree_page);
-		put_page(tree_page);
+		ret = memcmp_pages(&kfolio->page, &tree_folio->page);
+		folio_put(tree_folio);
 
 		parent = *new;
 		if (ret < 0)
@@ -2162,7 +2156,7 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 
 	INIT_HLIST_HEAD(&stable_node_dup->hlist);
 	stable_node_dup->kpfn = kpfn;
-	set_page_stable_node(kpage, stable_node_dup);
+	folio_set_stable_node(kfolio, stable_node_dup);
 	stable_node_dup->rmap_hlist_len = 0;
 	DO_NUMA(stable_node_dup->nid = nid);
 	if (!need_chain) {
@@ -2440,7 +2434,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 			 * node in the stable tree and add both rmap_items.
 			 */
 			lock_page(kpage);
-			stable_node = stable_tree_insert(kpage);
+			stable_node = stable_tree_insert(page_folio(kpage));
 			if (stable_node) {
 				stable_tree_append(tree_rmap_item, stable_node,
 						   false);
@@ -3244,7 +3238,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
 		/*
 		 * newfolio->mapping was set in advance; now we need smp_wmb()
 		 * to make sure that the new stable_node->kpfn is visible
-		 * to get_ksm_page() before it can see that folio->mapping
+		 * to ksm_get_folio() before it can see that folio->mapping
 		 * has gone stale (or that folio_test_swapcache has been cleared).
 		 */
 		smp_wmb();
@@ -3271,7 +3265,7 @@ static bool stable_node_dup_remove_range(struct ksm_stable_node *stable_node,
 	if (stable_node->kpfn >= start_pfn &&
 	    stable_node->kpfn < end_pfn) {
 		/*
-		 * Don't get_ksm_page, page has already gone:
+		 * Don't ksm_get_folio, page has already gone:
 		 * which is why we keep kpfn instead of page*
 		 */
 		remove_node_from_stable_tree(stable_node);
@@ -3359,7 +3353,7 @@ static int ksm_memory_callback(struct notifier_block *self,
 		 * Most of the work is done by page migration; but there might
 		 * be a few stable_nodes left over, still pointing to struct
 		 * pages which have been offlined: prune those from the tree,
-		 * otherwise get_ksm_page() might later try to access a
+		 * otherwise ksm_get_folio() might later try to access a
 		 * non-existent struct page.
 		 */
 		ksm_check_stable_tree(mn->start_pfn,
diff --git a/mm/migrate.c b/mm/migrate.c
index 73a052a382f1..9f0494fd902c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -616,7 +616,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 	folio_migrate_ksm(newfolio, folio);
 	/*
 	 * Please do not reorder this without considering how mm/ksm.c's
-	 * get_ksm_page() depends upon ksm_migrate_page() and PageSwapCache().
+	 * ksm_get_folio() depends upon ksm_migrate_page() and PageSwapCache().
 	 */
 	if (folio_test_swapcache(folio))
 		folio_clear_swapcache(folio);
-- 
2.43.0


