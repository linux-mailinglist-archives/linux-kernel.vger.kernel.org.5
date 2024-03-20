Return-Path: <linux-kernel+bounces-108557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864FB880C29
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D4D1C227E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488973C493;
	Wed, 20 Mar 2024 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7kGTdOt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A573C46B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920283; cv=none; b=LBP5AkoMxc7XCs2SfY7R2PVbZwfHCFl13LgBkDQJpM7Jeoo2nF5eM+TUjmoz9aCIh2dgnHfX0KxvDkHd8tGVfhmKnylk0YXCAh3CUgbV5o3XGIRSNKSu/xrXuX96+g0HXqKtNOMHl4QZk6RfaSFEJNtcfPUCJAG7mcdeHNMHQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920283; c=relaxed/simple;
	bh=rdqHFbrLbUfNMTwK9NhbP/z7rMDrfdCWv7WBbuSbpoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRx7rbeuXqT9Pmib+YkWU0MroWz/VM5wYZZB/5PjFcf3JrkphE6UH9AVBtiqFaEJU0Iu+Qlm64oLC5yT18hf4MWjqLs2WUCaxbAmTcwlCEQ7WAD0h+QvuXvjWgo/hXtDaK2vLOKHo9JkiJIFkchujWpXsfwb5NDiO3L1UwhKoOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7kGTdOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B16C433F1;
	Wed, 20 Mar 2024 07:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710920282;
	bh=rdqHFbrLbUfNMTwK9NhbP/z7rMDrfdCWv7WBbuSbpoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7kGTdOtJXwS+CqqQBmTtS71n3PQ18LbacGDQuh/lRh42lDg2iTEayH6tSB1h2bxN
	 MrFoF+KbHSF2yqHtMdOX1qs+tosrFeLbpmemFHjLSVQmFpHa7XVRdgfCq44+BC2GQn
	 hNlKEFkjh8KST5YownPLSNmyqo1XOoJhOYDcFNAsw+aE3GVFYVKTJ+/uLPlccUufPs
	 X3wpNM1X8oqEebZhud/wtB3c2YdkoP9UUxDdszXnW+UBNIEJa9OhaeYN0j6V1EE/Nu
	 zB9352SkNM7OKNTbg5EXBn8mtVsfJzr+hH2RNih4eLmYGeKuW/hUwDb+DbtupYZfg7
	 x9DhUNWe+gMfg==
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
Subject: [PATCH 08/11] mm/ksm: Convert stable_tree_insert to use folio
Date: Wed, 20 Mar 2024 15:40:44 +0800
Message-ID: <20240320074049.4130552-9-alexs@kernel.org>
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

KSM stable tree only store single page, so convert the func users to use
folio and save few compound_head calls.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 648fa695424b..71d1a52f344d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2062,7 +2062,7 @@ static struct page *stable_tree_search(struct page *page)
  * This function returns the stable tree node just allocated on success,
  * NULL otherwise.
  */
-static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
+static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 {
 	int nid;
 	unsigned long kpfn;
@@ -2072,7 +2072,7 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
 	bool need_chain = false;
 
-	kpfn = page_to_pfn(kpage);
+	kpfn = folio_pfn(kfolio);
 	nid = get_kpfn_nid(kpfn);
 	root = root_stable_tree + nid;
 again:
@@ -2080,13 +2080,13 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
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
@@ -2108,11 +2108,11 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 			 * write protected at all times. Any will work
 			 * fine to continue the walk.
 			 */
-			tree_page = get_ksm_page(stable_node_any,
+			tree_folio = get_ksm_page(stable_node_any,
 						 GET_KSM_PAGE_NOLOCK);
 		}
 		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
-		if (!tree_page) {
+		if (!tree_folio) {
 			/*
 			 * If we walked over a stale stable_node,
 			 * get_ksm_page() will call rb_erase() and it
@@ -2125,8 +2125,8 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 			goto again;
 		}
 
-		ret = memcmp_pages(kpage, tree_page);
-		put_page(tree_page);
+		ret = memcmp_pages(&kfolio->page, &tree_folio->page);
+		folio_put(tree_folio);
 
 		parent = *new;
 		if (ret < 0)
@@ -2145,7 +2145,7 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 
 	INIT_HLIST_HEAD(&stable_node_dup->hlist);
 	stable_node_dup->kpfn = kpfn;
-	set_page_stable_node(kpage, stable_node_dup);
+	set_page_stable_node(&kfolio->page, stable_node_dup);
 	stable_node_dup->rmap_hlist_len = 0;
 	DO_NUMA(stable_node_dup->nid = nid);
 	if (!need_chain) {
@@ -2423,7 +2423,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 			 * node in the stable tree and add both rmap_items.
 			 */
 			lock_page(kpage);
-			stable_node = stable_tree_insert(kpage);
+			stable_node = stable_tree_insert(page_folio(kpage));
 			if (stable_node) {
 				stable_tree_append(tree_rmap_item, stable_node,
 						   false);
-- 
2.43.0


