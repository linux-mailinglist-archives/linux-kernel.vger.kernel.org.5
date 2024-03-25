Return-Path: <linux-kernel+bounces-117044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3970388B144
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA05EBA1D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F4571747;
	Mon, 25 Mar 2024 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at0VDuHS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143406BFC2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370777; cv=none; b=IorhWswvnjR2PJT99cn0TFDQf/0H6ZWx0OAVjLblXem5GrmQ5Lh1CVMs37I/0RSMOnLUMTci/rmJrj7ifgAKr9Qb4l9GlSvPsYkLEgLL4N0u/M92iqHUTW6C+j7DR7XqjIA7lmkqd0/TLY1DnSkz23fZOTKerlT9TnMEoQP+EDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370777; c=relaxed/simple;
	bh=wVJDweO+3+nZNvpdxD1sOnabgczsKGATc/r/G9PfpiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9atOzcCu/g0edo5Ic6BUThJ489b6t0e/8MS0M2RIM6W2NWu/6v0xVZ+CoCS4BqiuiPzZllhM7JbZZh3kKEaeVlF8LpjBTFVk2UkoJzIkrjmlwV8sl55+Yk1z+J9N+k0sZr582miOQu+mH8pPYXDGzOfq/Hn6twLgwtzZQzDP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at0VDuHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457B1C433F1;
	Mon, 25 Mar 2024 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370776;
	bh=wVJDweO+3+nZNvpdxD1sOnabgczsKGATc/r/G9PfpiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=at0VDuHS1UFGvZa2neZdLri042ZbLa6A9MUgGRBNE5qGfCI2bODuBIA+VXldGpWmz
	 AzJe9wHMcmIBUbmnO5/pHRIsv/Q/o4PcTWzYXvcIpEEIuGuXBKeuXRMIutXAYCR1I3
	 /0LHpeFZ6sCQ+Qk8HwfLlumd0YNfJHFmIrE72awqDsW8FNVinqkiaFLuaQswCaZFxq
	 ewFRlvWp135MbtvT4KguhzgPncItoNY2Twe1cufEpby7VJdZTZNedABe6Vo7sqMiCF
	 swfeW+jnM6fzay7hnPM43ksTBiWNp3G9ZwFMuxYPKn2m99dxG82erlMJDDYcuPo63N
	 dtMH7Lhm7e9Nw==
From: alexs@kernel.org
To: Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ryncsn@gmail.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH v3 11/14] mm/ksm: remove get_ksm_page and related info
Date: Mon, 25 Mar 2024 20:48:58 +0800
Message-ID: <20240325124904.398913-12-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325124904.398913-1-alexs@kernel.org>
References: <20240325124904.398913-1-alexs@kernel.org>
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
index e92445f29685..0ad02524e363 100644
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
@@ -1657,7 +1649,7 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
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


