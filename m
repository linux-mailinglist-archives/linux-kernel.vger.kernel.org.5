Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5490F78F95B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348559AbjIAHwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345020AbjIAHwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:52:10 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20C710E5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:52:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RcVc12kBSz4f3m7d
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:52:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnw6YfmPFk1Z5cCA--.13825S8;
        Fri, 01 Sep 2023 15:52:02 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] mm/compaction: factor out code to test if we should run compaction for target order
Date:   Fri,  1 Sep 2023 23:51:41 +0800
Message-Id: <20230901155141.249860-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230901155141.249860-1-shikemeng@huaweicloud.com>
References: <20230901155141.249860-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnw6YfmPFk1Z5cCA--.13825S8
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1xGry3Jr4xKF17ZrW5Wrg_yoWrAryUpF
        y8Wry3t395XF17GFWxtF48XF15Xw4xJF1UtwsFq3s7Aw1aya1vv3Wkta4UZFWUX343JF4j
        qF4FgF1DKanrAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We always do zone_watermark_ok check and compaction_suitable check
together to test if compaction for target order should be ran.
Factor these code out to remove repeat code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 66 +++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index ff3426a0d9c5..1940e8693638 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2378,6 +2378,30 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	return false;
 }
 
+/*
+ * Should we do compaction for target allocation order.
+ * Return COMPACT_SUCCESS if allocation for target order can be already
+ * satisfied
+ * Return COMPACT_SKIPPED if compaction for target order is likely to fail
+ * Return COMPACT_CONTINUE if compaction for target order should be ran
+ */
+static enum compact_result
+compaction_suit_allocation_order(struct zone *zone, unsigned int order,
+				 int highest_zoneidx, unsigned int alloc_flags)
+{
+	unsigned long watermark;
+
+	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
+	if (zone_watermark_ok(zone, order, watermark, highest_zoneidx,
+			      alloc_flags))
+		return COMPACT_SUCCESS;
+
+	if (!compaction_suitable(zone, order, highest_zoneidx))
+		return COMPACT_SKIPPED;
+
+	return COMPACT_CONTINUE;
+}
+
 static enum compact_result
 compact_zone(struct compact_control *cc, struct capture_control *capc)
 {
@@ -2403,19 +2427,11 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	cc->migratetype = gfp_migratetype(cc->gfp_mask);
 
 	if (!is_via_compact_memory(cc->order)) {
-		unsigned long watermark;
-
-		/* Allocation can already succeed, nothing to do */
-		watermark = wmark_pages(cc->zone,
-					cc->alloc_flags & ALLOC_WMARK_MASK);
-		if (zone_watermark_ok(cc->zone, cc->order, watermark,
-				      cc->highest_zoneidx, cc->alloc_flags))
-			return COMPACT_SUCCESS;
-
-		/* Compaction is likely to fail */
-		if (!compaction_suitable(cc->zone, cc->order,
-					 cc->highest_zoneidx))
-			return COMPACT_SKIPPED;
+		ret = compaction_suit_allocation_order(cc->zone, cc->order,
+						       cc->highest_zoneidx,
+						       cc->alloc_flags);
+		if (ret != COMPACT_CONTINUE)
+			return ret;
 	}
 
 	/*
@@ -2914,6 +2930,7 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 	int zoneid;
 	struct zone *zone;
 	enum zone_type highest_zoneidx = pgdat->kcompactd_highest_zoneidx;
+	enum compact_result ret;
 
 	for (zoneid = 0; zoneid <= highest_zoneidx; zoneid++) {
 		zone = &pgdat->node_zones[zoneid];
@@ -2921,14 +2938,10 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 		if (!populated_zone(zone))
 			continue;
 
-		/* Allocation can already succeed, check other zones */
-		if (zone_watermark_ok(zone, pgdat->kcompactd_max_order,
-				      min_wmark_pages(zone),
-				      highest_zoneidx, 0))
-			continue;
-
-		if (compaction_suitable(zone, pgdat->kcompactd_max_order,
-					highest_zoneidx))
+		ret = compaction_suit_allocation_order(zone,
+				pgdat->kcompactd_max_order,
+				highest_zoneidx, ALLOC_WMARK_MIN);
+		if (ret == COMPACT_CONTINUE)
 			return true;
 	}
 
@@ -2951,6 +2964,8 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		.ignore_skip_hint = false,
 		.gfp_mask = GFP_KERNEL,
 	};
+	enum compact_result ret;
+
 	trace_mm_compaction_kcompactd_wake(pgdat->node_id, cc.order,
 							cc.highest_zoneidx);
 	count_compact_event(KCOMPACTD_WAKE);
@@ -2965,12 +2980,9 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (compaction_deferred(zone, cc.order))
 			continue;
 
-		/* Allocation can already succeed, nothing to do */
-		if (zone_watermark_ok(zone, cc.order,
-				      min_wmark_pages(zone), zoneid, 0))
-			continue;
-
-		if (!compaction_suitable(zone, cc.order, zoneid))
+		ret = compaction_suit_allocation_order(zone,
+				cc.order, zoneid, ALLOC_WMARK_MIN);
+		if (ret != COMPACT_CONTINUE)
 			continue;
 
 		if (kthread_should_stop())
-- 
2.30.0

