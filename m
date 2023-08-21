Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C256783470
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjHUUwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjHUUwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:52:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F81721
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RORJVnZ1xjomMTeygi3JJ1E6/B1esghHOmLJuCDuVL8=; b=cX48794hHeiyAzu9fcQmsTqm/r
        aqdYpWMbkTSg7sdRenY7DY184Sjqx0L5TE1lRgR1Rv/aCmpiho/0J8NfdRRgDvgFHaQ9sh85P0saE
        Ey1GDns++lTylnBp8OVqiMfqhFMzLA0fpZGEodGibshcHZBSYp3j6aPLIDFwP1ocmxTHjfQXSr6px
        xr/QshlBPusGF0zTRlEZH8lHdsFiiY9YmUKnFUHdiJr3VPUBOpZfpiAhZnQ8FyqDrjkrlCHWc+dgm
        7+hR/W6e6bBmn7K8tUqHbHnagtZH6cUOlrhdg4Auy7hyJ8bNsFbqaLdZ3mv0bZKbpg7B9GN6tG/LJ
        C4P1H2Sg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBlE-00CL08-JJ; Mon, 21 Aug 2023 20:44:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 3/7] mm: Add free_unref_folios()
Date:   Mon, 21 Aug 2023 21:44:21 +0100
Message-Id: <20230821204425.2940496-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230821204425.2940496-1-willy@infradead.org>
References: <ZOPMNyZ3gKb/bdjO@casper.infradead.org>
 <20230821204425.2940496-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iterate over a folio_batch rather than a linked list.  This is
easier for the CPU to prefetch and has a batch count naturally
built in so we don't need to track it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h   |  5 +++--
 mm/page_alloc.c | 59 ++++++++++++++++++++++++++++++-------------------
 2 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 5c777b6779fa..3e6b448e7d63 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -440,8 +440,9 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern int user_min_free_kbytes;
 
-extern void free_unref_page(struct page *page, unsigned int order);
-extern void free_unref_page_list(struct list_head *list);
+void free_unref_page(struct page *page, unsigned int order);
+void free_unref_folios(struct folio_batch *fbatch);
+void free_unref_page_list(struct list_head *list);
 
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2f2185929fcb..4354938ca3b0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -32,6 +32,7 @@
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
+#include <linux/pagevec.h>
 #include <linux/memory_hotplug.h>
 #include <linux/nodemask.h>
 #include <linux/vmstat.h>
@@ -2493,24 +2494,21 @@ void free_unref_page(struct page *page, unsigned int order)
 }
 
 /*
- * Free a list of 0-order pages
+ * Free a batch of 0-order pages
  */
-void free_unref_page_list(struct list_head *list)
+void free_unref_folios(struct folio_batch *folios)
 {
 	unsigned long __maybe_unused UP_flags;
-	struct folio *folio, *next;
 	struct per_cpu_pages *pcp = NULL;
 	struct zone *locked_zone = NULL;
-	int batch_count = 0;
-	int migratetype;
+	int i, j, migratetype;
 
-	/* Prepare pages for freeing */
-	list_for_each_entry_safe(folio, next, list, lru) {
+	/* Prepare folios for freeing */
+	for (i = 0, j = 0; i < folios->nr; i++) {
+		struct folio *folio = folios->folios[i];
 		unsigned long pfn = folio_pfn(folio);
-		if (!free_unref_page_prepare(&folio->page, pfn, 0)) {
-			list_del(&folio->lru);
+		if (!free_unref_page_prepare(&folio->page, pfn, 0))
 			continue;
-		}
 
 		/*
 		 * Free isolated pages directly to the allocator, see
@@ -2518,34 +2516,31 @@ void free_unref_page_list(struct list_head *list)
 		 */
 		migratetype = get_pcppage_migratetype(&folio->page);
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			list_del(&folio->lru);
 			free_one_page(folio_zone(folio), &folio->page, pfn,
 					0, migratetype, FPI_NONE);
 			continue;
 		}
+		if (j != i)
+			folios->folios[j] = folio;
+		j++;
 	}
+	folios->nr = j;
 
-	list_for_each_entry_safe(folio, next, list, lru) {
+	for (i = 0; i < folios->nr; i++) {
+		struct folio *folio = folios->folios[i];
 		struct zone *zone = folio_zone(folio);
 
-		list_del(&folio->lru);
 		migratetype = get_pcppage_migratetype(&folio->page);
 
-		/*
-		 * Either different zone requiring a different pcp lock or
-		 * excessive lock hold times when freeing a large list of
-		 * folios.
-		 */
-		if (zone != locked_zone || batch_count == SWAP_CLUSTER_MAX) {
+		/* Different zone requires a different pcp lock */
+		if (zone != locked_zone) {
 			if (pcp) {
 				pcp_spin_unlock(pcp);
 				pcp_trylock_finish(UP_flags);
 			}
 
-			batch_count = 0;
-
 			/*
-			 * trylock is necessary as folios may be getting freed
+			 * trylock is necessary as pages may be getting freed
 			 * from IRQ or SoftIRQ context after an IO completion.
 			 */
 			pcp_trylock_prepare(UP_flags);
@@ -2570,7 +2565,6 @@ void free_unref_page_list(struct list_head *list)
 
 		trace_mm_page_free_batched(&folio->page);
 		free_unref_page_commit(zone, pcp, &folio->page, migratetype, 0);
-		batch_count++;
 	}
 
 	if (pcp) {
@@ -2579,6 +2573,25 @@ void free_unref_page_list(struct list_head *list)
 	}
 }
 
+void free_unref_page_list(struct list_head *list)
+{
+	struct folio_batch fbatch;
+
+	folio_batch_init(&fbatch);
+	while (!list_empty(list)) {
+		struct folio *folio = list_first_entry(list, struct folio, lru);
+
+		list_del(&folio->lru);
+		if (folio_batch_add(&fbatch, folio) > 0)
+			continue;
+		free_unref_folios(&fbatch);
+		fbatch.nr = 0;
+	}
+
+	if (fbatch.nr)
+		free_unref_folios(&fbatch);
+}
+
 /*
  * split_page takes a non-compound higher-order page, and splits it into
  * n (1<<order) sub-pages: page[0..n]
-- 
2.40.1

