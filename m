Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914AF78348C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjHUUwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjHUUwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:52:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AA1171E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=R60f4MZlgl3FiJgLjXWtZXeM99QHm1vtfudYO1B8YHk=; b=rzJR+ALEuWNqK9HrcFfa8MzDG/
        /cTXZSUZqPrUIkirOzoygnEazjDTrCAdZl+jsxjLjiS8BjfWrpHcucFTaJlBhX/QbsHZ8dRnzUqP/
        oLtAzcQQGv58zaD8LnjUXJZTBJ+vM9y82DUozXRCXVK6QbJ6ue+HqKSk/mZpOQSzdVQ88X2K25n9b
        awISxEAZ+9IUkRF3s1UKwSIzwilgwGFpmnBBRe6f5X9NHnmqlnpbd2iLaP4dcLZ5Dw4olzWomrOWe
        dbu3siwyIqVwOHqWvvxUBtF0cvvifgE+ZFikoNkWEC09VzXHCtEjK07Htq5t8bS9FInuFGrmpSYLm
        9o43L/Vg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBlE-00CL06-9Z; Mon, 21 Aug 2023 20:44:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/7] mm: Convert free_unref_page_list() to use folios
Date:   Mon, 21 Aug 2023 21:44:20 +0100
Message-Id: <20230821204425.2940496-2-willy@infradead.org>
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

Most of its callees are not yet ready to accept a folio, but we know
all of the pages passed in are actually folios because they're linked
through ->lru.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page_alloc.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 81b1c7e3a28b..2f2185929fcb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2498,17 +2498,17 @@ void free_unref_page(struct page *page, unsigned int order)
 void free_unref_page_list(struct list_head *list)
 {
 	unsigned long __maybe_unused UP_flags;
-	struct page *page, *next;
+	struct folio *folio, *next;
 	struct per_cpu_pages *pcp = NULL;
 	struct zone *locked_zone = NULL;
 	int batch_count = 0;
 	int migratetype;
 
 	/* Prepare pages for freeing */
-	list_for_each_entry_safe(page, next, list, lru) {
-		unsigned long pfn = page_to_pfn(page);
-		if (!free_unref_page_prepare(page, pfn, 0)) {
-			list_del(&page->lru);
+	list_for_each_entry_safe(folio, next, list, lru) {
+		unsigned long pfn = folio_pfn(folio);
+		if (!free_unref_page_prepare(&folio->page, pfn, 0)) {
+			list_del(&folio->lru);
 			continue;
 		}
 
@@ -2516,24 +2516,25 @@ void free_unref_page_list(struct list_head *list)
 		 * Free isolated pages directly to the allocator, see
 		 * comment in free_unref_page.
 		 */
-		migratetype = get_pcppage_migratetype(page);
+		migratetype = get_pcppage_migratetype(&folio->page);
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			list_del(&page->lru);
-			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
+			list_del(&folio->lru);
+			free_one_page(folio_zone(folio), &folio->page, pfn,
+					0, migratetype, FPI_NONE);
 			continue;
 		}
 	}
 
-	list_for_each_entry_safe(page, next, list, lru) {
-		struct zone *zone = page_zone(page);
+	list_for_each_entry_safe(folio, next, list, lru) {
+		struct zone *zone = folio_zone(folio);
 
-		list_del(&page->lru);
-		migratetype = get_pcppage_migratetype(page);
+		list_del(&folio->lru);
+		migratetype = get_pcppage_migratetype(&folio->page);
 
 		/*
 		 * Either different zone requiring a different pcp lock or
 		 * excessive lock hold times when freeing a large list of
-		 * pages.
+		 * folios.
 		 */
 		if (zone != locked_zone || batch_count == SWAP_CLUSTER_MAX) {
 			if (pcp) {
@@ -2544,15 +2545,16 @@ void free_unref_page_list(struct list_head *list)
 			batch_count = 0;
 
 			/*
-			 * trylock is necessary as pages may be getting freed
+			 * trylock is necessary as folios may be getting freed
 			 * from IRQ or SoftIRQ context after an IO completion.
 			 */
 			pcp_trylock_prepare(UP_flags);
 			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
-				free_one_page(zone, page, page_to_pfn(page),
-					      0, migratetype, FPI_NONE);
+				free_one_page(zone, &folio->page,
+						folio_pfn(folio), 0,
+						migratetype, FPI_NONE);
 				locked_zone = NULL;
 				continue;
 			}
@@ -2566,8 +2568,8 @@ void free_unref_page_list(struct list_head *list)
 		if (unlikely(migratetype >= MIGRATE_PCPTYPES))
 			migratetype = MIGRATE_MOVABLE;
 
-		trace_mm_page_free_batched(page);
-		free_unref_page_commit(zone, pcp, page, migratetype, 0);
+		trace_mm_page_free_batched(&folio->page);
+		free_unref_page_commit(zone, pcp, &folio->page, migratetype, 0);
 		batch_count++;
 	}
 
-- 
2.40.1

