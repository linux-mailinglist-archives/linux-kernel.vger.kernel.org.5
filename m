Return-Path: <linux-kernel+bounces-111140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D931588684D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7D81F2283D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B85F3EA94;
	Fri, 22 Mar 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FE8y6dUc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E03EA68
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096503; cv=none; b=IosSTU3YPD2vzeQhYGBare880tSzMYZa6KT5dfSTUcWqF3HvYNHlUVdan4KDRlrWohSxke+hmX9dAIFOIL8X5kQ0tHmrgVfLBc/Sp5Oki+sUTbubs0ulBuxqTpAdLWFIgelSZTs6IVCtJAoQ4sBbgc2ts4d5QT0pYHbmUvNfXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096503; c=relaxed/simple;
	bh=OQPoYyqG65JjgdV3GI4xIDPu6WE8F7QAfq111enlmHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rza3LGhM1nC5yzqyEIabzFCxIFgglkVwMwoxQD0lcCPBdxS9vDUlLW+TraH6bBLUjbDmIVPaFfZQLZ9+uSdhEXTv5/MMzRiNLFxzZnbXHW8LL5SmKayKHRCq7Y2g7MsrIKRJdmOiee8APx2KnrlpoqXlOx+vjY9ttkiesCD/vfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FE8y6dUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FC4C43394;
	Fri, 22 Mar 2024 08:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096503;
	bh=OQPoYyqG65JjgdV3GI4xIDPu6WE8F7QAfq111enlmHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FE8y6dUcnrwOvrjSqoZfUtGIkZA9NFddagJQg6rqBl50cP0LbOnPqZl8yV67gnyTr
	 CFOsvYS3sekAjUnGaaf0UU8qaCwx5LZ6HR6A6vvSP8n7woojxWf/BiKg1RE14V0Dce
	 k4NXLyenhP5ztZR71GJT6r+C2lQHpcVhLTmFJJY/fJ0KPu/LppQFfMKVvbxn45dkrr
	 x21PByGcOiNgNiAjSexMAi2rleYLB9pwrCeyHivrhu35RHCgTV8k1DfTHAXX9ZptS5
	 YoChjPk4azvx5NCK/oZ9D1PR8YvKzDxNO4zgknce8OgmStaqwRit+uUyhOHMaubTG6
	 Myo3Bak3dkwwg==
From: alexs@kernel.org
To: Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH v2 11/14] mm/ksm: remove get_ksm_page and related info
Date: Fri, 22 Mar 2024 16:36:58 +0800
Message-ID: <20240322083703.232364-12-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322083703.232364-1-alexs@kernel.org>
References: <20240322083703.232364-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Now since all caller are changed to ksm_get_folio, let's sync up the
related usages with ksm_get_folio, and remove get_ksm_page.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c     | 34 +++++++++++++---------------------
 mm/migrate.c |  2 +-
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 0692bede5ca6..afcf26510669 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -890,14 +890,14 @@ static void remove_node_from_stable_tree(struct ksm_stable_node *stable_node)
 	free_stable_node(stable_node);
 }
 
-enum get_ksm_page_flags {
+enum ksm_get_folio_flags {
 	GET_KSM_PAGE_NOLOCK,
 	GET_KSM_PAGE_LOCK,
 	GET_KSM_PAGE_TRYLOCK
 };
 
 /*
- * get_ksm_page: checks if the page indicated by the stable node
+ * ksm_get_folio: checks if the page indicated by the stable node
  * is still its ksm page, despite having held no reference to it.
  * In which case we can trust the content of the page, and it
  * returns the gotten page; but if the page has now been zapped,
@@ -916,7 +916,7 @@ enum get_ksm_page_flags {
  * is on its way to being freed; but it is an anomaly to bear in mind.
  */
 static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
-				 enum get_ksm_page_flags flags)
+				 enum ksm_get_folio_flags flags)
 {
 	struct folio *folio;
 	void *expected_mapping;
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
@@ -1127,7 +1119,7 @@ static int remove_stable_node(struct ksm_stable_node *stable_node)
 	folio = ksm_get_folio(stable_node, GET_KSM_PAGE_LOCK);
 	if (!folio) {
 		/*
-		 * get_ksm_page did remove_node_from_stable_tree itself.
+		 * ksm_get_folio did remove_node_from_stable_tree itself.
 		 */
 		return 0;
 	}
@@ -1140,7 +1132,7 @@ static int remove_stable_node(struct ksm_stable_node *stable_node)
 	err = -EBUSY;
 	if (!folio_mapped(folio)) {
 		/*
-		 * The stable node did not yet appear stale to get_ksm_page(),
+		 * The stable node did not yet appear stale to ksm_get_folio(),
 		 * since that allows for an unmapped ksm folio to be recognized
 		 * right up until it is freed; but the node is safe to remove.
 		 * This folio might be in an LRU cache waiting to be freed,
@@ -1657,7 +1649,7 @@ static void *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 		 * We must walk all stable_node_dup to prune the stale
 		 * stable nodes during lookup.
 		 *
-		 * get_ksm_page can drop the nodes from the
+		 * ksm_get_folio can drop the nodes from the
 		 * stable_node->hlist if they point to freed pages
 		 * (that's why we do a _safe walk). The "dup"
 		 * stable_node parameter itself will be freed from
@@ -1764,7 +1756,7 @@ static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stabl
 }
 
 /*
- * Like for get_ksm_page, this function can free the *_stable_node and
+ * Like for ksm_get_folio, this function can free the *_stable_node and
  * *_stable_node_dup if the returned tree_page is NULL.
  *
  * It can also free and overwrite *_stable_node with the found
@@ -1786,7 +1778,7 @@ static void *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
 	if (!is_stable_node_chain(stable_node)) {
 		if (is_page_sharing_candidate(stable_node)) {
 			*_stable_node_dup = stable_node;
-			return get_ksm_page(stable_node, GET_KSM_PAGE_NOLOCK);
+			return ksm_get_folio(stable_node, GET_KSM_PAGE_NOLOCK);
 		}
 		/*
 		 * _stable_node_dup set to NULL means the stable_node
@@ -1900,7 +1892,7 @@ static void *stable_tree_search(struct page *page)
 		if (!tree_folio) {
 			/*
 			 * If we walked over a stale stable_node,
-			 * get_ksm_page() will call rb_erase() and it
+			 * ksm_get_folio() will call rb_erase() and it
 			 * may rebalance the tree from under us. So
 			 * restart the search from scratch. Returning
 			 * NULL would be safe too, but we'd generate
@@ -2133,7 +2125,7 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 		if (!tree_folio) {
 			/*
 			 * If we walked over a stale stable_node,
-			 * get_ksm_page() will call rb_erase() and it
+			 * ksm_get_folio() will call rb_erase() and it
 			 * may rebalance the tree from under us. So
 			 * restart the search from scratch. Returning
 			 * NULL would be safe too, but we'd generate
@@ -3245,7 +3237,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
 		/*
 		 * newfolio->mapping was set in advance; now we need smp_wmb()
 		 * to make sure that the new stable_node->kpfn is visible
-		 * to get_ksm_page() before it can see that folio->mapping
+		 * to ksm_get_folio() before it can see that folio->mapping
 		 * has gone stale (or that folio_test_swapcache has been cleared).
 		 */
 		smp_wmb();
@@ -3272,7 +3264,7 @@ static bool stable_node_dup_remove_range(struct ksm_stable_node *stable_node,
 	if (stable_node->kpfn >= start_pfn &&
 	    stable_node->kpfn < end_pfn) {
 		/*
-		 * Don't get_ksm_page, page has already gone:
+		 * Don't ksm_get_folio, page has already gone:
 		 * which is why we keep kpfn instead of page*
 		 */
 		remove_node_from_stable_tree(stable_node);
@@ -3360,7 +3352,7 @@ static int ksm_memory_callback(struct notifier_block *self,
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


