Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3927805D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357999AbjHRGGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358009AbjHRGGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:06:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC3D3A9C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4326463E81
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6090DC433CC;
        Fri, 18 Aug 2023 06:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692338759;
        bh=PTFvK66aSpc/wWYXL1tG3ENdFiVUZlkQu/DReJnqKDo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bbOTWJ6hSKJFcss5lL+TZpqq6+IGVcsiAeVbsSyFwYW+JEYg7RhWRlkI7cxWfBWZf
         76/MXNfx+Co4g9cC8KsCqjeTj1uY1hjSffEqPmKzAaZ5HYLN7P8dYTYPk96SyMaT6p
         3mDVpiYFix5Vwe3HjrP2w6PxKfW7tCrrw2a9HZalQ8399I/IMvWZ5vndleGZb8Lu4w
         jVMnbDZaGygfjf7W++mxpohOYkARhyjCsOUIcfwXM2rRQcTouyZUrWIt0dJNFHh0Md
         Nx8cfMGpk0/gIXyEjho2O2qu9ljHiGQWxobEmRC40zT6fPvPn6x4Jcq25ZwqVdmr2r
         x9InBHdTcsCKA==
From:   Chris Li <chrisl@kernel.org>
Date:   Thu, 17 Aug 2023 23:05:24 -0700
Subject: [PATCH RFC 2/2] mm/page_alloc: free_pcppages_bulk clean up
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230817-free_pcppages_bulk-v1-2-c14574a9f80c@kernel.org>
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
In-Reply-To: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, Michal Hocko <mhocko@suse.com>,
        david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
        Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not have functional change. Just pure clean up.

It removes the pindex_max and pindex_min and replaces it with a simpler
loop.

It uses for_each_entry_safe_reverse() to replace the loop over
list_last_entry(). It produces slightly better machine code.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 mm/page_alloc.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 347cb93081a02..d64d0f5ec70b4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1209,11 +1209,9 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 					int pindex)
 {
 	unsigned long flags;
-	int min_pindex = 0;
-	int max_pindex = NR_PCP_LISTS - 1;
 	unsigned int order;
 	bool isolated_pageblocks;
-	struct page *page;
+	int i;
 
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
@@ -1221,31 +1219,18 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	spin_lock_irqsave(&zone->lock, flags);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
-	while (count > 0) {
+	for (i = 0; i < NR_PCP_LISTS; i++, pindex++) {
 		struct list_head *list;
 		int nr_pages;
+		struct page *page, *next;
 
-		/* Remove pages from lists in a round-robin fashion. */
-		do {
-			if (++pindex > max_pindex)
-				pindex = min_pindex;
-			list = &pcp->lists[pindex];
-			if (!list_empty(list))
-				break;
-
-			if (pindex == max_pindex)
-				max_pindex--;
-			if (pindex == min_pindex)
-				min_pindex++;
-		} while (1);
-
+		if (pindex == NR_PCP_LISTS)
+			pindex = 0;
+		list = pcp->lists + pindex;
 		order = pindex_to_order(pindex);
 		nr_pages = 1 << order;
-		do {
-			int mt;
-
-			page = list_last_entry(list, struct page, pcp_list);
-			mt = get_pcppage_migratetype(page);
+		list_for_each_entry_safe_reverse(page, next, list, lru) {
+			int mt = get_pcppage_migratetype(page);
 
 			/* must delete to avoid corrupting pcp list */
 			list_del(&page->pcp_list);
@@ -1260,9 +1245,12 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 
 			__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
 			trace_mm_page_pcpu_drain(page, order, mt);
-		} while (count > 0 && pcp->count > 0 && !list_empty(list));
-	}
 
+			if (count <= 0 || pcp->count <= 0)
+				goto out;
+		}
+	}
+out:
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 

-- 
2.42.0.rc1.204.g551eb34607-goog

