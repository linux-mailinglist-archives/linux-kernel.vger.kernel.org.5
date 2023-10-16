Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575787CA034
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJPHNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjJPHNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:13:48 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B155ED
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:13:44 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 39G7Cote053037;
        Mon, 16 Oct 2023 15:12:50 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4S87WF1gbWz2KmQJM;
        Mon, 16 Oct 2023 15:08:41 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 16 Oct 2023 15:12:48 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <steve.kang@unisoc.com>
Subject: [PATCHv6 1/1] mm: optimization on page allocation when CMA enabled
Date:   Mon, 16 Oct 2023 15:12:45 +0800
Message-ID: <20231016071245.2865233-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.40]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 39G7Cote053037
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

According to current CMA utilization policy, an alloc_pages(GFP_USER)
could 'steal' UNMOVABLE & RECLAIMABLE page blocks via the help of
CMA(pass zone_watermark_ok by counting CMA in but use U&R in rmqueue),
which could lead to following alloc_pages(GFP_KERNEL) fail.
Solving this by introducing second watermark checking for GFP_MOVABLE,
which could have the allocation use CMA when proper.

-- Free_pages(30MB)
|
|
-- WMARK_LOW(25MB)
|
-- Free_CMA(12MB)
|
|
--

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v6: update comments
---
---
 mm/page_alloc.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 452459836b71..5a146aa7c0aa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2078,6 +2078,43 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 
 }
 
+#ifdef CONFIG_CMA
+/*
+ * GFP_MOVABLE allocation could drain UNMOVABLE & RECLAIMABLE page blocks via
+ * the help of CMA which makes GFP_KERNEL failed. Checking if zone_watermark_ok
+ * again without ALLOC_CMA to see if to use CMA first.
+ */
+static bool use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
+{
+	unsigned long watermark;
+	bool cma_first = false;
+
+	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
+	/* check if GFP_MOVABLE pass previous zone_watermark_ok via the help of CMA */
+	if (zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~ALLOC_CMA))) {
+		/*
+		 * Balance movable allocations between regular and CMA areas by
+		 * allocating from CMA when over half of the zone's free memory
+		 * is in the CMA area.
+		 */
+		cma_first = (zone_page_state(zone, NR_FREE_CMA_PAGES) >
+				zone_page_state(zone, NR_FREE_PAGES) / 2);
+	} else {
+		/*
+		 * watermark failed means UNMOVABLE & RECLAIMBLE is not enough
+		 * now, we should use cma first to keep them stay around the
+		 * corresponding watermark
+		 */
+		cma_first = true;
+	}
+	return cma_first;
+}
+#else
+static bool use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
+{
+	return false;
+}
+#endif
 /*
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
@@ -2091,12 +2128,11 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 	if (IS_ENABLED(CONFIG_CMA)) {
 		/*
 		 * Balance movable allocations between regular and CMA areas by
-		 * allocating from CMA when over half of the zone's free memory
-		 * is in the CMA area.
+		 * allocating from CMA base on judging zone_watermark_ok again
+		 * to see if the latest check got pass via the help of CMA
 		 */
 		if (alloc_flags & ALLOC_CMA &&
-		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
-		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
+			use_cma_first(zone, order, alloc_flags)) {
 			page = __rmqueue_cma_fallback(zone, order);
 			if (page)
 				return page;
-- 
2.25.1

