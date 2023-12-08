Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A489E809988
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573009AbjLHCxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjLHCxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:02 -0500
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591D4171E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:08 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702003986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nScQm/fmNOjGhlLnCGYZOl5/YmPviWpS9XmgJR18QP0=;
        b=lfAm3Ag0u+nVvzsnpysTBQspAGEV7RQMWtcMnK+sgx5xG663oyDL2ImjlVJztS/qUUC2Bu
        ASnstCjN2e7RvnSs5QQnB61n9SzrCi2SL7VTkiqKPo9WPDD641CyExewkH4Cks64v1NnaA
        Y94xV0mU8qY+cPzuNp+xPfcAHW1VUQI=
From:   Gang Li <gang.li@linux.dev>
To:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ligang.bdlg@bytedance.com, Gang Li <gang.li@linux.dev>
Subject: [RFC PATCH v2 1/5] hugetlb: code clean for hugetlb_hstate_alloc_pages
Date:   Fri,  8 Dec 2023 10:52:36 +0800
Message-Id: <20231208025240.4744-2-gang.li@linux.dev>
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

The readability of `hugetlb_hstate_alloc_pages` is poor. By cleaning the
code, its readability can be improved, facilitating future modifications.

This patch extracts two functions to reduce the complexity of
`hugetlb_hstate_alloc_pages` and has no functional changes.

- hugetlb_hstate_alloc_pages_node_specific() to handle iterates through
  each online node and performs allocation if necessary.
- hugetlb_hstate_alloc_pages_report() report error during allocation.
  And the value of h->max_huge_pages is updated accordingly.

Signed-off-by: Gang Li <gang.li@linux.dev>
---
 mm/hugetlb.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 51f50bb3dc092..252d6866a0af8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3475,6 +3475,33 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 	h->max_huge_pages_node[nid] = i;
 }
 
+static bool __init hugetlb_hstate_alloc_pages_node_specific(struct hstate *h)
+{
+	int i;
+	bool node_specific_alloc = false;
+
+	for_each_online_node(i) {
+		if (h->max_huge_pages_node[i] > 0) {
+			hugetlb_hstate_alloc_pages_onenode(h, i);
+			node_specific_alloc = true;
+		}
+	}
+
+	return node_specific_alloc;
+}
+
+static void __init hugetlb_hstate_alloc_pages_report(unsigned long allocated, struct hstate *h)
+{
+	if (allocated < h->max_huge_pages) {
+		char buf[32];
+
+		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
+		pr_warn("HugeTLB: allocating %lu of page size %s failed.  Only allocated %lu hugepages.\n",
+			h->max_huge_pages, buf, allocated);
+		h->max_huge_pages = allocated;
+	}
+}
+
 /*
  * NOTE: this routine is called in different contexts for gigantic and
  * non-gigantic pages.
@@ -3492,7 +3519,6 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	struct folio *folio;
 	LIST_HEAD(folio_list);
 	nodemask_t *node_alloc_noretry;
-	bool node_specific_alloc = false;
 
 	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
 	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
@@ -3501,14 +3527,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	}
 
 	/* do node specific alloc */
-	for_each_online_node(i) {
-		if (h->max_huge_pages_node[i] > 0) {
-			hugetlb_hstate_alloc_pages_onenode(h, i);
-			node_specific_alloc = true;
-		}
-	}
-
-	if (node_specific_alloc)
+	if (hugetlb_hstate_alloc_pages_node_specific(h))
 		return;
 
 	/* below will do all node balanced alloc */
@@ -3551,14 +3570,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	/* list will be empty if hstate_is_gigantic */
 	prep_and_add_allocated_folios(h, &folio_list);
 
-	if (i < h->max_huge_pages) {
-		char buf[32];
-
-		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
-		pr_warn("HugeTLB: allocating %lu of page size %s failed.  Only allocated %lu hugepages.\n",
-			h->max_huge_pages, buf, i);
-		h->max_huge_pages = i;
-	}
+	hugetlb_hstate_alloc_pages_report(i, h);
 	kfree(node_alloc_noretry);
 }
 
-- 
2.30.2

