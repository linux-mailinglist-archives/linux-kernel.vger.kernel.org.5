Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E06C78BEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjH2HG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjH2HGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:06:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E13519B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:06:28 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RZdhw71jgz1L9Lt;
        Tue, 29 Aug 2023 15:04:48 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 15:06:25 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Barry Song <baohua@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jinjiang Tu <tujinjiang@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] mm: vmscan: use per-zone watermark when determine file_is_tiny
Date:   Tue, 29 Aug 2023 16:00:38 +0800
Message-ID: <20230829080038.1532308-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting swapiness to 0, the anon pages should be reclaimed if and
only if the value of file_is_tiny is true.

__zone_watermark_ok uses per-zone watermark and lowmem_reserve to determine
whether allocating page from the zone. In the mean time, file_is_tiny is
calculated by per-node watermark. There are inconsistencies between the two
scenarios.

If total free pages on node is enough, then file_is_tiny can not be true,
so the anon pages can not be reclaimed. If the free pages in each zone is
less than watermark + lowmem_reserve, then the allocation will failed too.
Due to lowmem_reserve, these two cases can occur at the same time:

 zone_page_state(zone, NR_FREE_PAGES) < watermark + lowmem_reserve
 node_page_state(pgdat, NR_FREE_PAGES) > total_high_wmark

When both are met, there will be many anon pages that can not be reclaimed
because file_is_tiny is false, and in the same time, the allocation failed
because per-zone watermark is not suitable.

Split the condition (file + free <= high_wmark) to per-zone to fix it.

Reported-and-tested-by: Jinjiang Tu <tujinjiang@huawei.com>
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/vmscan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e73e2df8828d..f1dc0dbf1cdb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3009,21 +3009,23 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 	 * anon pages.  Try to detect this based on file LRU size.
 	 */
 	if (!cgroup_reclaim(sc)) {
-		unsigned long total_high_wmark = 0;
 		unsigned long free, anon;
 		int z;
 
-		free = sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
-		file = node_page_state(pgdat, NR_ACTIVE_FILE) +
-			   node_page_state(pgdat, NR_INACTIVE_FILE);
-
 		for (z = 0; z < MAX_NR_ZONES; z++) {
 			struct zone *zone = &pgdat->node_zones[z];
 
 			if (!managed_zone(zone))
 				continue;
 
-			total_high_wmark += high_wmark_pages(zone);
+			free = zone_page_state(zone, NR_FREE_PAGES);
+			file = zone_page_state(zone, NR_ZONE_ACTIVE_FILE) +
+				zone_page_state(zone, NR_ZONE_INACTIVE_FILE);
+
+			if (file + free <= high_wmark_pages(zone)) {
+				sc->file_is_tiny = true;
+				break;
+			}
 		}
 
 		/*
@@ -3033,8 +3035,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 		 */
 		anon = node_page_state(pgdat, NR_INACTIVE_ANON);
 
-		sc->file_is_tiny =
-			file + free <= total_high_wmark &&
+		sc->file_is_tiny = sc->file_is_tiny &&
 			!(sc->may_deactivate & DEACTIVATE_ANON) &&
 			anon >> sc->priority;
 	}
-- 
2.25.1

