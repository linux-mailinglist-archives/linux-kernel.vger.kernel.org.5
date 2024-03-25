Return-Path: <linux-kernel+bounces-117043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D80A88A665
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48A2300A28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F63B15FCE6;
	Mon, 25 Mar 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz0MergX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FCE15F415
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370773; cv=none; b=l/GbINHMTjmqMOI5K/6jNeca7y96O+Chj2NC2NtJckvuVu4whntPythlzM8/uFcgyL9gHO3171R0eLgD8udXUBgMJK94gzwjsR2oQEHXxCSIwtb46b8v6MWDZY7+vgaWk87Kw3j7zOQz+DI/PHE1mLaiijSWvwmEg8w+M0+2qlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370773; c=relaxed/simple;
	bh=2lgvFI0wNn9RTCMEzEWib7Gn+j7luBL+Jg2E4ycFUf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWgE9qdurynx6NPs/pfwFQ5ZIdQCf9NUIMjv4tT2vtOd65vnepJ2PSHxyA05XLET7JzMJ0hyVnr7R6IRD3aSYfgyrahnNJbDQLczeY6L3Q1Cyq/fGiH1VadpKEiYS5IMPCMiE0bw2ZmlblRutMmzDKY0eRV65qiC3hhm2rh1uI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz0MergX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40281C43390;
	Mon, 25 Mar 2024 12:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370773;
	bh=2lgvFI0wNn9RTCMEzEWib7Gn+j7luBL+Jg2E4ycFUf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dz0MergXwbNpE5qypVG9l++oEAh9GgKrjYVi2WZATBEUMf/h2vvKvfWuuN2rYay9Q
	 mvBr0LRQln4jeWSRsqlLU8WM7vzf95ttjzjXBJIPtHyIR8fB+mcbA6L6yjQILNW13E
	 EGLVB0l5Zlthhdi3jucQwfl7boWT3sAKrIJNV9XNKm1YRkYBe9NGv019lOFQyoxQuA
	 1IBBuXPnLgXvLTeau3NR1///K8RNQnj6GrTVhWQbmN6pYAV+qwXdZ2HD5AKz62NVjT
	 KcjwNL2irL8wTYaKKGnUMzndCBL9R0lq+wEpVRtUACFl77GcxTnbkuJk6hE9dx6Hwk
	 JDbfAotIewksw==
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
Subject: [PATCH v3 10/14] mm/ksm: Convert stable_tree_search to use folio
Date: Mon, 25 Mar 2024 20:48:57 +0800
Message-ID: <20240325124904.398913-11-alexs@kernel.org>
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
 mm/ksm.c | 58 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c2afe2f926db..e92445f29685 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1828,7 +1828,7 @@ static __always_inline void *chain(struct ksm_stable_node **s_n_d,
  * This function returns the stable tree node of identical content if found,
  * NULL otherwise.
  */
-static struct page *stable_tree_search(struct page *page)
+static void *stable_tree_search(struct page *page)
 {
 	int nid;
 	struct rb_root *root;
@@ -1836,28 +1836,30 @@ static struct page *stable_tree_search(struct page *page)
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
@@ -1891,11 +1893,11 @@ static struct page *stable_tree_search(struct page *page)
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
 			 * get_ksm_page() will call rb_erase() and it
@@ -1908,8 +1910,8 @@ static struct page *stable_tree_search(struct page *page)
 			goto again;
 		}
 
-		ret = memcmp_pages(page, tree_page);
-		put_page(tree_page);
+		ret = memcmp_pages(page, &tree_folio->page);
+		folio_put(tree_folio);
 
 		parent = *new;
 		if (ret < 0)
@@ -1952,26 +1954,26 @@ static struct page *stable_tree_search(struct page *page)
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
+			return tree_folio;
 		}
 	}
 
@@ -1984,8 +1986,8 @@ static struct page *stable_tree_search(struct page *page)
 	rb_insert_color(&page_node->node, root);
 out:
 	if (is_page_sharing_candidate(page_node)) {
-		get_page(page);
-		return page;
+		folio_get(folio);
+		return folio;
 	} else
 		return NULL;
 
@@ -2010,12 +2012,12 @@ static struct page *stable_tree_search(struct page *page)
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
@@ -2026,16 +2028,16 @@ static struct page *stable_tree_search(struct page *page)
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
-- 
2.43.0


