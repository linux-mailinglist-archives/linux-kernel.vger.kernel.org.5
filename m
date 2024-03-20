Return-Path: <linux-kernel+bounces-108558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F518880C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1141F23B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC3F3D3BB;
	Wed, 20 Mar 2024 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnyMHcy7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6803D0AD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920286; cv=none; b=lc8SSXU7Dtysu5Jh+d21NADqCKz6BZSOAlYOxKhgBsLC7Pwi3Gu1ZORlowPiqzEgCZbWWLBTIrgKM3FfCggqjxF04doS0ATRMp3uSh0K9R/9cZf7+8f6tnKS85NBUleesYcL6wMNYF8Pnb7LhHUPe464u/DaKxcIWb6UCe+b5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920286; c=relaxed/simple;
	bh=tjVPu2LfV6/oJL+/cGFCPeE7wstp4Ud62/5nB+tu7Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujnrxEeS0vTA/UMIe7QyHa6/vZGnN6NoCYHft7B26AtBiIOakwfKFTQRsec1eVOQRUaXU581diac2FK2xk+GnytJC4NekC0aKO91Yk1Pw2z9YPJ1y0x9PEcn2JPG3jGYBUpkcdNLD2TdvC1V5SFDheMolRhJ7epILyz10QIZN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnyMHcy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12D5C43390;
	Wed, 20 Mar 2024 07:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710920285;
	bh=tjVPu2LfV6/oJL+/cGFCPeE7wstp4Ud62/5nB+tu7Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnyMHcy70fzp8mjnSBi4o1+7TO69JWuiRoHjNyhFVoYTtNUcOygYYs1aYzSwHZ4tP
	 B1BEQoxvGpCI5WgyIKpDPphqywUn0C0GwKZ9osVoCfI7FwSszybl7JM+X7kspzNj1U
	 ZaUyDOXUqJMrYPlAP3tjgfC0glaUofbiUSDuv3ZHGJJXB3urIxTdY8dqSOJpLF7Q4J
	 +0xpRLKV7XWf7OvDi6wMx13J5ewLV5vUggPB+1o1apGUrBvZIVUI7PM1LA3+YdCGy4
	 16PM0s7aJeQoqB4eV7jgHGwGxedDMFcl/prNrGkefrYvjHT9OTNC9gi84ELn/jrimA
	 l05LCkNlt1caA==
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
Subject: [PATCH 09/11] mm/ksm: Convert stable_tree_search to use folio
Date: Wed, 20 Mar 2024 15:40:45 +0800
Message-ID: <20240320074049.4130552-10-alexs@kernel.org>
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

Although, the func may pass a tail page to check its contents, but only
single page exist in KSM stable tree, so we still can use folio in
stable_tree_search() to save a few compound_head calls.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 60 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 71d1a52f344d..75401b3bae5c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1812,7 +1812,7 @@ static __always_inline void *chain(struct ksm_stable_node **s_n_d,
  * This function returns the stable tree node of identical content if found,
  * NULL otherwise.
  */
-static struct page *stable_tree_search(struct page *page)
+static void *stable_tree_search(struct page *page)
 {
 	int nid;
 	struct rb_root *root;
@@ -1820,28 +1820,30 @@ static struct page *stable_tree_search(struct page *page)
 	struct rb_node *parent;
 	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
 	struct ksm_stable_node *page_node;
+	struct folio *folio;
 
-	page_node = page_stable_node(page);
+	folio = (struct folio *)page;
+	page_node = folio_stable_node(folio);
 	if (page_node && page_node->head != &migrate_nodes) {
 		/* ksm page forked */
-		get_page(page);
-		return page;
+		folio_get(folio);
+		return folio;
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
@@ -1875,11 +1877,11 @@ static struct page *stable_tree_search(struct page *page)
 			 * write protected at all times. Any will work
 			 * fine to continue the walk.
 			 */
-			tree_page = get_ksm_page(stable_node_any,
-						 GET_KSM_PAGE_NOLOCK);
+			tree_folio = get_ksm_page(stable_node_any,
+						  GET_KSM_PAGE_NOLOCK);
 		}
 		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
-		if (!tree_page) {
+		if (!tree_folio) {
 			/*
 			 * If we walked over a stale stable_node,
 			 * get_ksm_page() will call rb_erase() and it
@@ -1892,8 +1894,8 @@ static struct page *stable_tree_search(struct page *page)
 			goto again;
 		}
 
-		ret = memcmp_pages(page, tree_page);
-		put_page(tree_page);
+		ret = memcmp_pages(&folio->page, &tree_folio->page);
+		folio_put(tree_folio);
 
 		parent = *new;
 		if (ret < 0)
@@ -1936,26 +1938,26 @@ static struct page *stable_tree_search(struct page *page)
 			 * It would be more elegant to return stable_node
 			 * than kpage, but that involves more changes.
 			 */
-			tree_page = get_ksm_page(stable_node_dup,
-						 GET_KSM_PAGE_TRYLOCK);
+			tree_folio = get_ksm_page(stable_node_dup,
+						  GET_KSM_PAGE_TRYLOCK);
 
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
+			return tree_folio;
 		}
 	}
 
@@ -1968,8 +1970,8 @@ static struct page *stable_tree_search(struct page *page)
 	rb_insert_color(&page_node->node, root);
 out:
 	if (is_page_sharing_candidate(page_node)) {
-		get_page(page);
-		return page;
+		folio_get(folio);
+		return folio;
 	} else
 		return NULL;
 
@@ -1994,12 +1996,12 @@ static struct page *stable_tree_search(struct page *page)
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
@@ -2010,16 +2012,16 @@ static struct page *stable_tree_search(struct page *page)
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
+	return folio;
 
 chain_append:
 	/* stable_node_dup could be null if it reached the limit */
@@ -2109,7 +2111,7 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 			 * fine to continue the walk.
 			 */
 			tree_folio = get_ksm_page(stable_node_any,
-						 GET_KSM_PAGE_NOLOCK);
+						  GET_KSM_PAGE_NOLOCK);
 		}
 		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
 		if (!tree_folio) {
-- 
2.43.0


