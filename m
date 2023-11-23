Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F047F6063
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345518AbjKWNga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345493AbjKWNg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:36:26 -0500
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA12BA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:36:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700746269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nGnKScZww5hZXWYTDAjHhsju7kmgmcYLYNYxHMYgc28=;
        b=d5CHLX57cCOGxJdVkM1Rcs5gK8JkZKtdzrPAWDsIIXnn4bLS2WT8PJZozgQuz0CNFwb0nc
        0T867ikyskX4+1d3xr9U6o5B04QY6IGfw21Vn6rpkQHu8CmkuXfiaUXsViDqqNzM3Lwggu
        BarejmtOHYkPWa7BTb5kD5s+K+Zxa3w=
From:   Gang Li <gang.li@linux.dev>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [RFC PATCH v1 2/4] hugetlb: split hugetlb_hstate_alloc_pages
Date:   Thu, 23 Nov 2023 21:30:34 +0800
Message-Id: <20231123133036.68540-3-gang.li@linux.dev>
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

Split hugetlb_hstate_alloc_pages into gigantic and non-gigantic.

These patch has no functional changes.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 mm/hugetlb.c | 86 +++++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 41 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7af2ee08ad1b..7f9ff0855dd0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3509,6 +3509,47 @@ static void __init hugetlb_hstate_alloc_pages_report(unsigned long allocated, st
 	}
 }
 
+static unsigned long __init hugetlb_hstate_alloc_pages_gigantic(struct hstate *h)
+{
+	unsigned long i;
+
+	for (i = 0; i < h->max_huge_pages; ++i) {
+		/*
+		 * gigantic pages not added to list as they are not
+		 * added to pools now.
+		 */
+		if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
+			break;
+		cond_resched();
+	}
+
+	return i;
+}
+
+static unsigned long __init hugetlb_hstate_alloc_pages_non_gigantic(struct hstate *h)
+{
+	unsigned long i;
+	struct folio *folio;
+	LIST_HEAD(folio_list);
+	nodemask_t node_alloc_noretry;
+
+	/* Bit mask controlling how hard we retry per-node allocations.*/
+	nodes_clear(node_alloc_noretry);
+
+	for (i = 0; i < h->max_huge_pages; ++i) {
+		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+						&node_alloc_noretry);
+		if (!folio)
+			break;
+		list_add(&folio->lru, &folio_list);
+		cond_resched();
+	}
+
+	prep_and_add_allocated_folios(h, &folio_list);
+
+	return i;
+}
+
 /*
  * NOTE: this routine is called in different contexts for gigantic and
  * non-gigantic pages.
@@ -3522,10 +3563,7 @@ static void __init hugetlb_hstate_alloc_pages_report(unsigned long allocated, st
  */
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
-	unsigned long i;
-	struct folio *folio;
-	LIST_HEAD(folio_list);
-	nodemask_t *node_alloc_noretry;
+	unsigned long allocated;
 
 	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
 	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
@@ -3539,46 +3577,12 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	/* below will do all node balanced alloc */
 	if (!hstate_is_gigantic(h)) {
-		/*
-		 * Bit mask controlling how hard we retry per-node allocations.
-		 * Ignore errors as lower level routines can deal with
-		 * node_alloc_noretry == NULL.  If this kmalloc fails at boot
-		 * time, we are likely in bigger trouble.
-		 */
-		node_alloc_noretry = kmalloc(sizeof(*node_alloc_noretry),
-						GFP_KERNEL);
+		allocated = hugetlb_hstate_alloc_pages_non_gigantic(h);
 	} else {
-		/* allocations done at boot time */
-		node_alloc_noretry = NULL;
-	}
-
-	/* bit mask controlling how hard we retry per-node allocations */
-	if (node_alloc_noretry)
-		nodes_clear(*node_alloc_noretry);
-
-	for (i = 0; i < h->max_huge_pages; ++i) {
-		if (hstate_is_gigantic(h)) {
-			/*
-			 * gigantic pages not added to list as they are not
-			 * added to pools now.
-			 */
-			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
-				break;
-		} else {
-			folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
-							node_alloc_noretry);
-			if (!folio)
-				break;
-			list_add(&folio->lru, &folio_list);
-		}
-		cond_resched();
+		allocated = hugetlb_hstate_alloc_pages_gigantic(h);
 	}
 
-	/* list will be empty if hstate_is_gigantic */
-	prep_and_add_allocated_folios(h, &folio_list);
-
-	hugetlb_hstate_alloc_pages_report(i, h);
-	kfree(node_alloc_noretry);
+	hugetlb_hstate_alloc_pages_report(allocated, h);
 }
 
 static void __init hugetlb_init_hstates(void)
-- 
2.20.1

