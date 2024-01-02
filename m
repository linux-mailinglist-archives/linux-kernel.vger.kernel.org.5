Return-Path: <linux-kernel+bounces-14385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D14821C5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696011C21E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7912E4D;
	Tue,  2 Jan 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qcQ/Nui/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66C125B5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704201212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vziwaehcp4Mlf2+5m5PWlp5vkO7nD1McNxi9fSvMFU=;
	b=qcQ/Nui/5Ddo4hq2TnILxFLnHXPOYrnuSz5qK6UAQm45+GQS+0RyxWTYvckmzZSTJRgHK6
	y8iYkcup7wCN7qn8SKZwnf6eds3fWGGP/aglezu4KP6rMrK/MznoUTelkMah5ZTP2EvQrM
	uC8anNSTIvbFRJYUaxaebIz6ZnbBmiE=
From: Gang Li <gang.li@linux.dev>
To: David Hildenbrand <david@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Gang Li <gang.li@linux.dev>
Subject: [PATCH v3 4/7] hugetlb: pass *next_nid_to_alloc directly to for_each_node_mask_to_alloc
Date: Tue,  2 Jan 2024 21:12:46 +0800
Message-Id: <20240102131249.76622-5-gang.li@linux.dev>
In-Reply-To: <20240102131249.76622-1-gang.li@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The parallelization of hugetlb allocation leads to errors when sharing
h->next_nid_to_alloc across different threads. To address this, it's
necessary to assign a separate next_nid_to_alloc for each thread.

Consequently, the hstate_next_node_to_alloc and for_each_node_mask_to_alloc
have been modified to directly accept a *next_nid_to_alloc parameter,
ensuring thread-specific allocation and avoiding concurrent access issues.

Signed-off-by: Gang Li <gang.li@linux.dev>
---
This patch seems not elegant, but I can't come up with anything better.
Any suggestions will be highly appreciated!
---
 mm/hugetlb.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 92448e747991d..a71bc1622b53b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1464,15 +1464,15 @@ static int get_valid_node_allowed(int nid, nodemask_t *nodes_allowed)
  * next node from which to allocate, handling wrap at end of node
  * mask.
  */
-static int hstate_next_node_to_alloc(struct hstate *h,
+static int hstate_next_node_to_alloc(int *next_nid_to_alloc,
 					nodemask_t *nodes_allowed)
 {
 	int nid;
 
 	VM_BUG_ON(!nodes_allowed);
 
-	nid = get_valid_node_allowed(h->next_nid_to_alloc, nodes_allowed);
-	h->next_nid_to_alloc = next_node_allowed(nid, nodes_allowed);
+	nid = get_valid_node_allowed(*next_nid_to_alloc, nodes_allowed);
+	*next_nid_to_alloc = next_node_allowed(nid, nodes_allowed);
 
 	return nid;
 }
@@ -1495,10 +1495,10 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 	return nid;
 }
 
-#define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)		\
+#define for_each_node_mask_to_alloc(next_nid_to_alloc, nr_nodes, node, mask)		\
 	for (nr_nodes = nodes_weight(*mask);				\
 		nr_nodes > 0 &&						\
-		((node = hstate_next_node_to_alloc(hs, mask)) || 1);	\
+		((node = hstate_next_node_to_alloc(next_nid_to_alloc, mask)) || 1);	\
 		nr_nodes--)
 
 #define for_each_node_mask_to_free(hs, nr_nodes, node, mask)		\
@@ -2350,12 +2350,13 @@ static void prep_and_add_allocated_folios(struct hstate *h,
  */
 static struct folio *alloc_pool_huge_folio(struct hstate *h,
 					nodemask_t *nodes_allowed,
-					nodemask_t *node_alloc_noretry)
+					nodemask_t *node_alloc_noretry,
+					int *next_nid_to_alloc)
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 	int nr_nodes, node;
 
-	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
+	for_each_node_mask_to_alloc(next_nid_to_alloc, nr_nodes, node, nodes_allowed) {
 		struct folio *folio;
 
 		folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
@@ -3310,7 +3311,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 		goto found;
 	}
 	/* allocate from next node when distributing huge pages */
-	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
+	for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, &node_states[N_MEMORY]) {
 		m = memblock_alloc_try_nid_raw(
 				huge_page_size(h), huge_page_size(h),
 				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
@@ -3684,7 +3685,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 	VM_BUG_ON(delta != -1 && delta != 1);
 
 	if (delta < 0) {
-		for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
+		for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, nodes_allowed) {
 			if (h->surplus_huge_pages_node[node])
 				goto found;
 		}
@@ -3799,7 +3800,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		cond_resched();
 
 		folio = alloc_pool_huge_folio(h, nodes_allowed,
-						node_alloc_noretry);
+						node_alloc_noretry,
+						&h->next_nid_to_alloc);
 		if (!folio) {
 			prep_and_add_allocated_folios(h, &page_list);
 			spin_lock_irq(&hugetlb_lock);
-- 
2.20.1


