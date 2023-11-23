Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1DD7F6062
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbjKWNg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345468AbjKWNg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:36:26 -0500
X-Greylist: delayed 326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 05:36:31 PST
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B81A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:36:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700746275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVmsj9TN/aj38n19fqlW2b7zQkW3VvgWG56LLSCGces=;
        b=Y71JssEDzrYWYNV34cyzjaSirgHK0BrpKRWoKYtD+NlDt+B0BHOaS3CWA9Uyhz5yKbgj6g
        PimBt6l7h2P4kLFfkV0n8MPPjcmR9a/NNorQu2gY5FzktxNGVTBcPtxXi8OV6XSHGDx82i
        xNn/ddoatbelzCFAmHSUzrB3UJs23Jc=
From:   Gang Li <gang.li@linux.dev>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [RFC PATCH v1 4/4] hugetlb: parallelize hugetlb page allocation
Date:   Thu, 23 Nov 2023 21:30:36 +0800
Message-Id: <20231123133036.68540-5-gang.li@linux.dev>
In-Reply-To: <20231123133036.68540-1-gang.li@linux.dev>
References: <20231123133036.68540-1-gang.li@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gang Li <ligang.bdlg@bytedance.com>

By distributing the allocation across threads, large hugetlb
configurations can allocate pages faster, improving boot speed.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 mm/hugetlb.c | 89 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac8558724cc2..df3fbe95989e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3509,6 +3509,55 @@ static void __init hugetlb_hstate_alloc_pages_report(unsigned long allocated, st
 	}
 }
 
+struct hugetlb_work {
+	struct work_struct work;
+	struct hstate *h;
+	int num;
+	int nid;
+};
+
+static atomic_t hugetlb_hstate_alloc_n_undone __initdata;
+static __initdata DECLARE_COMPLETION(hugetlb_hstate_alloc_comp);
+
+static void __init hugetlb_alloc_node(struct work_struct *w)
+{
+	struct hugetlb_work *hw = container_of(w, struct hugetlb_work, work);
+	struct hstate *h = hw->h;
+	int i, num = hw->num;
+	nodemask_t node_alloc_noretry;
+	unsigned long flags;
+
+	/* Bit mask controlling how hard we retry per-node allocations.*/
+	nodes_clear(node_alloc_noretry);
+
+	for (i = 0; i < num; ++i) {
+		struct folio *folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+						&node_alloc_noretry);
+		if (!folio)
+			break;
+		spin_lock_irqsave(&hugetlb_lock, flags);
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
+		cond_resched();
+	}
+
+	if (atomic_dec_and_test(&hugetlb_hstate_alloc_n_undone))
+		complete(&hugetlb_hstate_alloc_comp);
+}
+
+static void __init hugetlb_vmemmap_optimize_node(struct work_struct *w)
+{
+	struct hugetlb_work *hw = container_of(w, struct hugetlb_work, work);
+	struct hstate *h = hw->h;
+	int nid = hw->nid;
+
+	hugetlb_vmemmap_optimize_folios(h, &h->hugepage_freelists[nid]);
+
+	if (atomic_dec_and_test(&hugetlb_hstate_alloc_n_undone))
+		complete(&hugetlb_hstate_alloc_comp);
+}
+
 static unsigned long __init hugetlb_hstate_alloc_pages_gigantic(struct hstate *h)
 {
 	unsigned long i;
@@ -3528,26 +3577,36 @@ static unsigned long __init hugetlb_hstate_alloc_pages_gigantic(struct hstate *h
 
 static unsigned long __init hugetlb_hstate_alloc_pages_non_gigantic(struct hstate *h)
 {
-	unsigned long i;
-	struct folio *folio;
-	LIST_HEAD(folio_list);
-	nodemask_t node_alloc_noretry;
+	int nid;
+	struct hugetlb_work *works;
 
-	/* Bit mask controlling how hard we retry per-node allocations.*/
-	nodes_clear(node_alloc_noretry);
+	works = kcalloc(num_node_state(N_MEMORY), sizeof(*works), GFP_KERNEL);
+	if (works == NULL) {
+		pr_warn("HugeTLB: allocating struct hugetlb_work failed.\n");
+		return 0;
+	}
 
-	for (i = 0; i < h->max_huge_pages; ++i) {
-		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
-						&node_alloc_noretry);
-		if (!folio)
-			break;
-		list_add(&folio->lru, &folio_list);
-		cond_resched();
+	atomic_set(&hugetlb_hstate_alloc_n_undone, num_node_state(N_MEMORY));
+	for_each_node_state(nid, N_MEMORY) {
+		works[nid].h = h;
+		works[nid].num = h->max_huge_pages/num_node_state(N_MEMORY);
+		if (nid == 0)
+			works[nid].num += h->max_huge_pages % num_node_state(N_MEMORY);
+		INIT_WORK(&works[nid].work, hugetlb_alloc_node);
+		queue_work_node(nid, system_unbound_wq, &works[nid].work);
 	}
+	wait_for_completion(&hugetlb_hstate_alloc_comp);
 
-	prep_and_add_allocated_folios(h, &folio_list);
+	atomic_set(&hugetlb_hstate_alloc_n_undone, num_node_state(N_MEMORY));
+	for_each_node_state(nid, N_MEMORY) {
+		works[nid].nid = nid;
+		INIT_WORK(&works[nid].work, hugetlb_vmemmap_optimize_node);
+		queue_work_node(nid, system_unbound_wq, &works[nid].work);
+	}
+	wait_for_completion(&hugetlb_hstate_alloc_comp);
 
-	return i;
+	kfree(works);
+	return h->nr_huge_pages;
 }
 
 /*
-- 
2.20.1

