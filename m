Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3969A770D66
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjHEDHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHEDHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:07:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBB44EEE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:07:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHnYc2cdZz4f3kK2
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 11:07:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrHQvM1k6A5ePg--.23962S9;
        Sat, 05 Aug 2023 11:07:00 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 7/9] mm/compaction: factor out code to test if we should run compaction for target order
Date:   Sat,  5 Aug 2023 19:07:09 +0800
Message-Id: <20230805110711.2975149-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrHQvM1k6A5ePg--.23962S9
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1rAw47ZryrKr15Zw4kCrg_yoW8Kw4xpF
        y8Z343K395XF13GFWIya18JF45Xw4xGF1DAwsFqwn2vw1ayay0v3WDta48ZFyUXry3Ar4j
        qFWYkFyDKFsxAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We always do zone_watermark_ok check and compaction_suitable check
together to test if compaction for target order should be runned.
Factor these code out for preparation to remove repeat code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b5a699ed526b..26787ebb0297 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2365,6 +2365,30 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
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
@@ -2390,19 +2414,11 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	cc->migratetype = gfp_migratetype(cc->gfp_mask);
 
 	if (compaction_with_allocation_order(cc->order)) {
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
-- 
2.30.0

