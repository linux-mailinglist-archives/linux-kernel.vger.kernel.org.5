Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5F17F6064
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345545AbjKWNge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345495AbjKWNg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:36:26 -0500
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [IPv6:2001:41d0:1004:224b::af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D59A1B6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:36:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700746266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZ0xmMUhKXlLEkuqOXd+S2Kz2QguNe+dVlDKaJye92A=;
        b=PvITNhCauLhoxZoDafpy0vQRZZqHvieig+ygz0sJ0KwQBDvhV9RPQ7WPfQpMHtWDAup4Yw
        MSno402iwprJTutoIIV7sPIPvxuHCpkEExhh6mVM441U9SnVOxB2WXeqSKZJ89qeRTXCh6
        7CujJmPaqH11kwtg96cXGzPn5Hr9Caw=
From:   Gang Li <gang.li@linux.dev>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [RFC PATCH v1 1/4] hugetlb: code clean for hugetlb_hstate_alloc_pages
Date:   Thu, 23 Nov 2023 21:30:33 +0800
Message-Id: <20231123133036.68540-2-gang.li@linux.dev>
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

This patch focus on cleaning up the code related to per node allocation
and error reporting in the hugetlb alloc:

- hugetlb_hstate_alloc_pages_node_specific() to handle iterates through
  each online node and performs allocation if necessary.
- hugetlb_hstate_alloc_pages_report() report error during allocation.
  And the value of h->max_huge_pages is updated accordingly.

This patch has no functional changes.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 mm/hugetlb.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c466551e2fd9..7af2ee08ad1b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3482,6 +3482,33 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
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
@@ -3499,7 +3526,6 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	struct folio *folio;
 	LIST_HEAD(folio_list);
 	nodemask_t *node_alloc_noretry;
-	bool node_specific_alloc = false;
 
 	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
 	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
@@ -3508,14 +3534,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
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
@@ -3558,14 +3577,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
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
2.20.1

