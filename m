Return-Path: <linux-kernel+bounces-108559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C93880C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC031C225EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AE73EA8D;
	Wed, 20 Mar 2024 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAz1Jtn5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199CA3DB8C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920289; cv=none; b=LvuSVChR1SIGkvWRGy43sbSffm4TQhlnF8i5Bc8yt6YybCkn5uCfmwNUCCiQht0dJAp4PTiSA5cRW7QyYm0WLrav5nLufOG7WHXlz8OnonLZfGhun+vyX/grAQdEa7h0nkRLJ+s0VSrr6/zUeB7qzZsPXPyOEBf+7XYoGUCNxGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920289; c=relaxed/simple;
	bh=4/ipLVxA+I+/npLz6EvsQqobqTxElBqybjRD2uQTgUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUvSPtBi0f5eF6cUiIaHqO1z71vWylbBuhs/EjH5lJgOx82hozAxMe/F23uFZE6er0WQQZhT6CnjOCfvHWbaiGU9Bo01ick/P8uT1GkVqfdAqnnr5hXizZRv0QBVDaOyhr3Kwznmqao5E3Wt7fnbxDtD6/DfIKHyMIIG5k+ec40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAz1Jtn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3178CC433F1;
	Wed, 20 Mar 2024 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710920288;
	bh=4/ipLVxA+I+/npLz6EvsQqobqTxElBqybjRD2uQTgUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAz1Jtn5Tv7xWex39egXoEsKh+6Jyz4na6sqHGHE5Gn7vpfr/BD5NGADxf131MnF8
	 nS679xCkTyyQY1M8WtgJdNq8mqaUixp8HZrftKU44Ld/m7tOJd5wILQYaeRALdGZav
	 wS5kjN/WFPEojTEskJziqJTsLeXlW+eoz/PRYZVDNqgGvpd/i/xAsOTqtjaZ9HN5Wl
	 e9MSXRQFkU1funeUToZImXIzxFfPPfX05lRAjuCpOe/pKbeh3Vldew9uu+mJRTZuYg
	 XcIxbGSEnfSyVXgguUKGdo2qx73PFtZy6OF36ZSemWtHs+H/mFl9yoO47rNR5HxZDP
	 teWlc/3bOCa/g==
From: alexs@kernel.org
To: Izik Eidus <izik.eidus@ravellosystems.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>,
	kasong@tencent.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-kernel@vger.kernel.org,
	"Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH 10/11] mm/ksm: rename get_ksm_page to get_ksm_folio and return type
Date: Wed, 20 Mar 2024 15:40:46 +0800
Message-ID: <20240320074049.4130552-11-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240320074049.4130552-1-alexs@kernel.org>
References: <20240320074049.4130552-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Now since all caller are changed to folio, return to folio and rename it
as get_ksm_folio.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 75401b3bae5c..806ad4d2693b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -890,14 +890,14 @@ static void remove_node_from_stable_tree(struct ksm_stable_node *stable_node)
 	free_stable_node(stable_node);
 }
 
-enum get_ksm_page_flags {
+enum get_ksm_folio_flags {
 	GET_KSM_PAGE_NOLOCK,
 	GET_KSM_PAGE_LOCK,
 	GET_KSM_PAGE_TRYLOCK
 };
 
 /*
- * get_ksm_page: checks if the page indicated by the stable node
+ * get_ksm_folio: checks if the page indicated by the stable node
  * is still its ksm page, despite having held no reference to it.
  * In which case we can trust the content of the page, and it
  * returns the gotten page; but if the page has now been zapped,
@@ -915,8 +915,8 @@ enum get_ksm_page_flags {
  * a page to put something that might look like our key in page->mapping.
  * is on its way to being freed; but it is an anomaly to bear in mind.
  */
-static void *get_ksm_page(struct ksm_stable_node *stable_node,
-				 enum get_ksm_page_flags flags)
+static struct folio *get_ksm_folio(struct ksm_stable_node *stable_node,
+				   enum get_ksm_folio_flags flags)
 {
 	struct folio *folio;
 	void *expected_mapping;
@@ -1001,7 +1001,7 @@ static void remove_rmap_item_from_tree(struct ksm_rmap_item *rmap_item)
 		struct folio *folio;
 
 		stable_node = rmap_item->head;
-		folio = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
+		folio = get_ksm_folio(stable_node, GET_KSM_PAGE_LOCK);
 		if (!folio)
 			goto out;
 
@@ -1110,10 +1110,10 @@ static int remove_stable_node(struct ksm_stable_node *stable_node)
 	struct folio *folio;
 	int err;
 
-	folio = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
+	folio = get_ksm_folio(stable_node, GET_KSM_PAGE_LOCK);
 	if (!folio) {
 		/*
-		 * get_ksm_page did remove_node_from_stable_tree itself.
+		 * get_ksm_folio did remove_node_from_stable_tree itself.
 		 */
 		return 0;
 	}
@@ -1126,7 +1126,7 @@ static int remove_stable_node(struct ksm_stable_node *stable_node)
 	err = -EBUSY;
 	if (!folio_mapped(folio)) {
 		/*
-		 * The stable node did not yet appear stale to get_ksm_page(),
+		 * The stable node did not yet appear stale to get_ksm_folio(),
 		 * since that allows for an unmapped ksm folio to be recognized
 		 * right up until it is freed; but the node is safe to remove.
 		 * This folio might be in an LRU cache waiting to be freed,
@@ -1641,13 +1641,13 @@ static void *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 		 * We must walk all stable_node_dup to prune the stale
 		 * stable nodes during lookup.
 		 *
-		 * get_ksm_page can drop the nodes from the
+		 * get_ksm_folio can drop the nodes from the
 		 * stable_node->hlist if they point to freed pages
 		 * (that's why we do a _safe walk). The "dup"
 		 * stable_node parameter itself will be freed from
 		 * under us if it returns NULL.
 		 */
-		folio = get_ksm_page(dup, GET_KSM_PAGE_NOLOCK);
+		folio = get_ksm_folio(dup, GET_KSM_PAGE_NOLOCK);
 		if (!folio)
 			continue;
 		nr += 1;
@@ -1748,7 +1748,7 @@ static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stabl
 }
 
 /*
- * Like for get_ksm_page, this function can free the *_stable_node and
+ * Like for get_ksm_folio, this function can free the *_stable_node and
  * *_stable_node_dup if the returned tree_page is NULL.
  *
  * It can also free and overwrite *_stable_node with the found
@@ -1770,7 +1770,7 @@ static void *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
 	if (!is_stable_node_chain(stable_node)) {
 		if (is_page_sharing_candidate(stable_node)) {
 			*_stable_node_dup = stable_node;
-			return get_ksm_page(stable_node, GET_KSM_PAGE_NOLOCK);
+			return get_ksm_folio(stable_node, GET_KSM_PAGE_NOLOCK);
 		}
 		/*
 		 * _stable_node_dup set to NULL means the stable_node
@@ -1877,14 +1877,14 @@ static void *stable_tree_search(struct page *page)
 			 * write protected at all times. Any will work
 			 * fine to continue the walk.
 			 */
-			tree_folio = get_ksm_page(stable_node_any,
-						  GET_KSM_PAGE_NOLOCK);
+			tree_folio = get_ksm_folio(stable_node_any,
+						   GET_KSM_PAGE_NOLOCK);
 		}
 		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
 		if (!tree_folio) {
 			/*
 			 * If we walked over a stale stable_node,
-			 * get_ksm_page() will call rb_erase() and it
+			 * get_ksm_folio() will call rb_erase() and it
 			 * may rebalance the tree from under us. So
 			 * restart the search from scratch. Returning
 			 * NULL would be safe too, but we'd generate
@@ -1938,8 +1938,8 @@ static void *stable_tree_search(struct page *page)
 			 * It would be more elegant to return stable_node
 			 * than kpage, but that involves more changes.
 			 */
-			tree_folio = get_ksm_page(stable_node_dup,
-						  GET_KSM_PAGE_TRYLOCK);
+			tree_folio = get_ksm_folio(stable_node_dup,
+						   GET_KSM_PAGE_TRYLOCK);
 
 			if (PTR_ERR(tree_folio) == -EBUSY)
 				return ERR_PTR(-EBUSY);
@@ -2110,14 +2110,14 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 			 * write protected at all times. Any will work
 			 * fine to continue the walk.
 			 */
-			tree_folio = get_ksm_page(stable_node_any,
-						  GET_KSM_PAGE_NOLOCK);
+			tree_folio = get_ksm_folio(stable_node_any,
+						   GET_KSM_PAGE_NOLOCK);
 		}
 		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
 		if (!tree_folio) {
 			/*
 			 * If we walked over a stale stable_node,
-			 * get_ksm_page() will call rb_erase() and it
+			 * get_ksm_folio() will call rb_erase() and it
 			 * may rebalance the tree from under us. So
 			 * restart the search from scratch. Returning
 			 * NULL would be safe too, but we'd generate
@@ -2601,8 +2601,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 
 			list_for_each_entry_safe(stable_node, next,
 						 &migrate_nodes, list) {
-				folio = get_ksm_page(stable_node,
-						    GET_KSM_PAGE_NOLOCK);
+				folio = get_ksm_folio(stable_node,
+						      GET_KSM_PAGE_NOLOCK);
 				if (folio)
 					folio_put(folio);
 				cond_resched();
@@ -3229,7 +3229,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
 		/*
 		 * newfolio->mapping was set in advance; now we need smp_wmb()
 		 * to make sure that the new stable_node->kpfn is visible
-		 * to get_ksm_page() before it can see that folio->mapping
+		 * to get_ksm_folio() before it can see that folio->mapping
 		 * has gone stale (or that folio_test_swapcache has been cleared).
 		 */
 		smp_wmb();
@@ -3256,7 +3256,7 @@ static bool stable_node_dup_remove_range(struct ksm_stable_node *stable_node,
 	if (stable_node->kpfn >= start_pfn &&
 	    stable_node->kpfn < end_pfn) {
 		/*
-		 * Don't get_ksm_page, page has already gone:
+		 * Don't get_ksm_folio, page has already gone:
 		 * which is why we keep kpfn instead of page*
 		 */
 		remove_node_from_stable_tree(stable_node);
@@ -3344,7 +3344,7 @@ static int ksm_memory_callback(struct notifier_block *self,
 		 * Most of the work is done by page migration; but there might
 		 * be a few stable_nodes left over, still pointing to struct
 		 * pages which have been offlined: prune those from the tree,
-		 * otherwise get_ksm_page() might later try to access a
+		 * otherwise get_ksm_folio() might later try to access a
 		 * non-existent struct page.
 		 */
 		ksm_check_stable_tree(mn->start_pfn,
-- 
2.43.0


