Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D8B80998F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573038AbjLHCxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573041AbjLHCxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:14 -0500
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [IPv6:2001:41d0:1004:224b::aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521EE1732
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:20 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702003997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kGZs/UomIOv18ew/FrkoM04DuS4bMFxPVmfT4OFKf7o=;
        b=chBueub5MeUxcphaWjUQxqFROsevyxpVPZfmiPXveRFoaHIrVUEHPmnvrGUbaR4eTRBiWA
        f94Dvmb/dAYuSx8K1f3+h/VIZx1F4a/NHLYb+wLTgBl21NY0lhI2iPxvxgQs9MN7KjUjor
        XiwWvmtR111DRnYq7EyqfBimXVLu1UU=
From:   Gang Li <gang.li@linux.dev>
To:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ligang.bdlg@bytedance.com, Gang Li <gang.li@linux.dev>
Subject: [RFC PATCH v2 4/5] hugetlb: parallelize 2M hugetlb allocation and initialization
Date:   Fri,  8 Dec 2023 10:52:39 +0800
Message-Id: <20231208025240.4744-5-gang.li@linux.dev>
In-Reply-To: <20231208025240.4744-1-gang.li@linux.dev>
References: <20231208025240.4744-1-gang.li@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By distributing both the allocation and the initialization tasks across
multiple threads, the initialization of 2M hugetlb will be faster,
thereby improving the boot speed.

This patch can achieve 60% improvement in performance.

        test          no patch(ms)   patched(ms)   saved
 ------------------- -------------- ------------- --------
  256c2t(4 node) 2M           2624           956   63.57%
  128c1t(2 node) 2M           1788           684   61.74%

Signed-off-by: Gang Li <gang.li@linux.dev>
---
 mm/hugetlb.c | 71 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8de1653fc4c4f..033e359fdb86b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -35,6 +35,7 @@
 #include <linux/delayacct.h>
 #include <linux/memory.h>
 #include <linux/mm_inline.h>
+#include <linux/padata.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -3502,6 +3503,37 @@ static void __init hugetlb_hstate_alloc_pages_report(unsigned long allocated, st
 	}
 }
 
+static void __init hugetlb_alloc_node(unsigned long start, unsigned long end, void *arg)
+{
+	struct hstate *h = (struct hstate *)arg;
+	int i, num = end - start;
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
+}
+
+static void __init hugetlb_vmemmap_optimize_node(unsigned long start, unsigned long end, void *arg)
+{
+	struct hstate *h = (struct hstate *)arg;
+	int nid = start;
+
+	hugetlb_vmemmap_optimize_folios(h, &h->hugepage_freelists[nid]);
+}
+
 static unsigned long __init hugetlb_hstate_alloc_pages_gigantic(struct hstate *h)
 {
 	unsigned long i;
@@ -3521,26 +3553,27 @@ static unsigned long __init hugetlb_hstate_alloc_pages_gigantic(struct hstate *h
 
 static unsigned long __init hugetlb_hstate_alloc_pages_non_gigantic(struct hstate *h)
 {
-	unsigned long i;
-	struct folio *folio;
-	LIST_HEAD(folio_list);
-	nodemask_t node_alloc_noretry;
-
-	/* Bit mask controlling how hard we retry per-node allocations.*/
-	nodes_clear(node_alloc_noretry);
-
-	for (i = 0; i < h->max_huge_pages; ++i) {
-		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
-						&node_alloc_noretry);
-		if (!folio)
-			break;
-		list_add(&folio->lru, &folio_list);
-		cond_resched();
-	}
-
-	prep_and_add_allocated_folios(h, &folio_list);
+	struct padata_mt_job job = {
+		.fn_arg		= h,
+		.align		= 1,
+		.numa_aware	= true,
+	};
 
-	return i;
+	job.thread_fn	= hugetlb_alloc_node,
+	job.start	= 0,
+	job.size	= h->max_huge_pages,
+	job.min_chunk	= h->max_huge_pages / num_node_state(N_MEMORY) / 2,
+	job.max_threads	= num_node_state(N_MEMORY) * 2,
+	padata_do_multithreaded(&job);
+
+	job.thread_fn	= hugetlb_vmemmap_optimize_node,
+	job.start	= 0,
+	job.size	= num_node_state(N_MEMORY),
+	job.min_chunk	= 1,
+	job.max_threads	= num_node_state(N_MEMORY),
+	padata_do_multithreaded(&job);
+
+	return h->nr_huge_pages;
 }
 
 /*
-- 
2.30.2

