Return-Path: <linux-kernel+bounces-30107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D083831944
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FF21F228B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2D4286B6;
	Thu, 18 Jan 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HorjKMfK"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBE25763
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581574; cv=none; b=AScuTLeFStKvqawkvOVMMhJjeBWKH7baaFuqgC0Z5vGqeRDkJEv9VeOK1OJ0SQGcriymcTULVh3DjJmMWPLBAZ64BzfI1XNLPjjxA1q2H8DWSYt5SmcgyivRcqGQy42e6Cm6NJZIRlrpcKXk3ouEtL9iHsd5VeMC1vuGF08uyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581574; c=relaxed/simple;
	bh=SPhcMQcybMslY+bt+TdzrJ28BtVXVk3UeMNOvesC3D4=;
	h=X-Report-Abuse:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Migadu-Flow; b=RPoKjCx8HMjkDhPZLOEuUswcCXvHLM4pmBz1om50i1I0/BtfMhSFMEYY1YTW6cWdyDWVln+n7KkVjkOwpPh2o+C06J340S2ZyA7EkQsuruZBfoTA1RQFfTm60ExS/R6I5DL2vtyT9sugseYgPA+pXW8shSzQyQ89P6OAjFU7Fro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HorjKMfK; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705581571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8BLudBFy7F7d9VGcgZ6uTbCxD4rT9ItFTD1EH+b2yk=;
	b=HorjKMfKZszOTJ83qRS01vcjPG50ZRqhtcnxtHTRYvfWUGzWq0C9r0LqFiHnDKR66Rz5Nc
	5u4qZ5PIJjK6E36euVVTPgblm7/zBw2ihXLuozf4chhpgLLJBNuj0/YOUr14eHNPUezFaQ
	sJDNTCbFkX134dX9DokOr/m7nu/AS3c=
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
Subject: [PATCH v4 4/7] hugetlb: pass *next_nid_to_alloc directly to for_each_node_mask_to_alloc
Date: Thu, 18 Jan 2024 20:39:08 +0800
Message-Id: <20240118123911.88833-5-gang.li@linux.dev>
In-Reply-To: <20240118123911.88833-1-gang.li@linux.dev>
References: <20240118123911.88833-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

With parallelization of hugetlb allocation across different threads, each
thread works on a differnet node to allocate pages from, instead of all
allocating from a common node h->next_nid_to_alloc.  To address this, it's
necessary to assign a separate next_nid_to_alloc for each thread.

Consequently, the hstate_next_node_to_alloc and for_each_node_mask_to_alloc
have been modified to directly accept a *next_nid_to_alloc parameter,
ensuring thread-specific allocation and avoiding concurrent access issues.

Signed-off-by: Gang Li <gang.li@linux.dev>
Tested-by: David Rientjes <rientjes@google.com>
---
 mm/hugetlb.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 98ae108e1fac..effe5539e545 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1464,15 +1464,15 @@ static int get_valid_node_allowed(int nid, nodemask_t *nodes_allowed)
  * next node from which to allocate, handling wrap at end of node
  * mask.
  */
-static int hstate_next_node_to_alloc(struct hstate *h,
+static int hstate_next_node_to_alloc(int *next_node,
 					nodemask_t *nodes_allowed)
 {
 	int nid;
 
 	VM_BUG_ON(!nodes_allowed);
 
-	nid = get_valid_node_allowed(h->next_nid_to_alloc, nodes_allowed);
-	h->next_nid_to_alloc = next_node_allowed(nid, nodes_allowed);
+	nid = get_valid_node_allowed(*next_node, nodes_allowed);
+	*next_node = next_node_allowed(nid, nodes_allowed);
 
 	return nid;
 }
@@ -1495,10 +1495,10 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 	return nid;
 }
 
-#define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)		\
+#define for_each_node_mask_to_alloc(next_node, nr_nodes, node, mask)		\
 	for (nr_nodes = nodes_weight(*mask);				\
 		nr_nodes > 0 &&						\
-		((node = hstate_next_node_to_alloc(hs, mask)) || 1);	\
+		((node = hstate_next_node_to_alloc(next_node, mask)) || 1);	\
 		nr_nodes--)
 
 #define for_each_node_mask_to_free(hs, nr_nodes, node, mask)		\
@@ -2350,12 +2350,13 @@ static void prep_and_add_allocated_folios(struct hstate *h,
  */
 static struct folio *alloc_pool_huge_folio(struct hstate *h,
 					nodemask_t *nodes_allowed,
-					nodemask_t *node_alloc_noretry)
+					nodemask_t *node_alloc_noretry,
+					int *next_node)
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 	int nr_nodes, node;
 
-	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
+	for_each_node_mask_to_alloc(next_node, nr_nodes, node, nodes_allowed) {
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
@@ -3679,7 +3680,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 	VM_BUG_ON(delta != -1 && delta != 1);
 
 	if (delta < 0) {
-		for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
+		for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, nodes_allowed) {
 			if (h->surplus_huge_pages_node[node])
 				goto found;
 		}
@@ -3794,7 +3795,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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


