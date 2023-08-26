Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC3789462
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 09:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjHZHhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 03:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjHZHgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 03:36:37 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B43213C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 00:36:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RXpXv5sv0z4f3jqD
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:36:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDHQi98q+lk6GgZBg--.2153S9;
        Sat, 26 Aug 2023 15:36:32 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 7/7] mm/compaction: factor out code to test if we should run compaction for target order
Date:   Sat, 26 Aug 2023 23:36:17 +0800
Message-Id: <20230826153617.4019189-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHQi98q+lk6GgZBg--.2153S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW8Gr43KrWxCw1fKr47XFb_yoW5tF4fpF
        yxur13t395XF13GrWxta18JF45Xw4xGF1Utwsrt3s7Aw1ayayvv3Wkta4xAFWUXry3JF4j
        qFWFgF9rKanxAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We always do zone_watermark_ok check and compaction_suitable check
together to test if compaction for target order should be runned.
Factor these code out to remove repeat code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 63 ++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 00b7bba6c72e..6f2b87b026b8 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2374,6 +2374,30 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	return false;
 }
 
+/*
+ * Should we do compaction for target allocation order.
+ * Return COMPACT_SUCCESS if allocation for target order can be already
+ * satisfied
+ * Return COMPACT_SKIPPED if compaction for target order is likely to fail
+ * Return COMPACT_CONTINUE if compaction for target order should be runned
+ */
+static inline enum compact_result
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
@@ -2399,19 +2423,11 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
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
@@ -2917,14 +2933,10 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
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
+		if (compaction_suit_allocation_order(zone,
+				pgdat->kcompactd_max_order,
+				highest_zoneidx, ALLOC_WMARK_MIN) ==
+				COMPACT_CONTINUE)
 			return true;
 	}
 
@@ -2961,12 +2973,9 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (compaction_deferred(zone, cc.order))
 			continue;
 
-		/* Allocation can already succeed, nothing to do */
-		if (zone_watermark_ok(zone, cc.order,
-				      min_wmark_pages(zone), zoneid, 0))
-			continue;
-
-		if (!compaction_suitable(zone, cc.order, zoneid))
+		if (compaction_suit_allocation_order(zone,
+				cc.order, zoneid, ALLOC_WMARK_MIN) !=
+				COMPACT_CONTINUE)
 			continue;
 
 		if (kthread_should_stop())
-- 
2.30.0

