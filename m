Return-Path: <linux-kernel+bounces-111138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A28588684B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF4B1F255AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915683D0BE;
	Fri, 22 Mar 2024 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4/d94dF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38EC3A1CB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096497; cv=none; b=O3Pn1FRFJKDRnAwrdjr9Br35WTdKpoWSGZFB2NK2WznxPiO/bM1w6nG4yWxiBqYu1UX4f+zoloeMuVxjzmlDay3E0p82H1yYFPb2xno3AfnIfrM6rS5wf1Mq++j8pD+dSS7z1HJ9wejSHcc10lDHk46BQ4li/x3sSUHhVPm6MHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096497; c=relaxed/simple;
	bh=WVA5iQMpP6XRPAUdm6BGPXwO6vUlPgINWjhmK5fNggI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdTH04anO6i6Jfw2LPXgEw8KKgQ538fwfg2mei1yMenBp6dRl8b4ES1xtKQ2NJJWmWwOu+KlaPoq1mr+kdxl7l9QAo3IN8vaDHXxxdoQkgUrdFH1QNv3xSlfVK7eSL+XTvzZQR1GxFXnuhRH7QIxsNkMdpY8Z4N6gpiWWiJC68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4/d94dF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26435C43394;
	Fri, 22 Mar 2024 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096497;
	bh=WVA5iQMpP6XRPAUdm6BGPXwO6vUlPgINWjhmK5fNggI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4/d94dFJHh92jVFstIb123+K+uECJMzjhO5h6qNXziYhpASueY+JlCKsaASBC+B6
	 /kJdoOCiCE9/rxMx3VTLNNK1Dpd34UZDHm+FWEqaJftEAHTC+UneL2xXg2HGZFNUHH
	 SVcA+FYM77wBYYMu6uTlKeYWFjsJhs8wJfd6mbR6slOLLb2dGCEg0O7Rbfjw5kEDmw
	 VIA8AsLhzenXMSa8OzzAKuSoTa2rW3/BOkmCBllehPo+yTPgSWRNyM07qug6chSimL
	 WEgTi0VvMwYWegCZkEERh5MdlBztXBBTNm7XvJcjUUfg/eP/bZe+UzB5S/hrpwq/ND
	 namI+bYeJFPvw==
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
Subject: [PATCH v2 09/14] mm/ksm: Convert stable_tree_insert to use folio
Date: Fri, 22 Mar 2024 16:36:56 +0800
Message-ID: <20240322083703.232364-10-alexs@kernel.org>
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

KSM stable tree only store single page, so convert the func users to use
folio and save few compound_head calls.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 30570e1f68ec..e6837e615ef0 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2078,7 +2078,7 @@ static struct page *stable_tree_search(struct page *page)
  * This function returns the stable tree node just allocated on success,
  * NULL otherwise.
  */
-static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
+static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 {
 	int nid;
 	unsigned long kpfn;
@@ -2088,7 +2088,7 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
 	bool need_chain = false;
 
-	kpfn = page_to_pfn(kpage);
+	kpfn = folio_pfn(kfolio);
 	nid = get_kpfn_nid(kpfn);
 	root = root_stable_tree + nid;
 again:
@@ -2096,13 +2096,13 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
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
@@ -2124,11 +2124,11 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
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
@@ -2141,8 +2141,8 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 			goto again;
 		}
 
-		ret = memcmp_pages(kpage, tree_page);
-		put_page(tree_page);
+		ret = memcmp_pages(&kfolio->page, &tree_folio->page);
+		folio_put(tree_folio);
 
 		parent = *new;
 		if (ret < 0)
@@ -2161,7 +2161,7 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 
 	INIT_HLIST_HEAD(&stable_node_dup->hlist);
 	stable_node_dup->kpfn = kpfn;
-	set_page_stable_node(kpage, stable_node_dup);
+	folio_set_stable_node(kfolio, stable_node_dup);
 	stable_node_dup->rmap_hlist_len = 0;
 	DO_NUMA(stable_node_dup->nid = nid);
 	if (!need_chain) {
@@ -2439,7 +2439,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
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


