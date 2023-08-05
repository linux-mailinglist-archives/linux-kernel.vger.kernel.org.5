Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5071D770D5E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjHEDHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHEDHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:07:07 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DAC4EE4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:07:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RHnYX4D99z4f3lKg
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 11:06:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrHQvM1k6A5ePg--.23962S5;
        Sat, 05 Aug 2023 11:06:59 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 3/9] mm/compaction: correctly return failure with bogus compound_order in strict mode
Date:   Sat,  5 Aug 2023 19:07:05 +0800
Message-Id: <20230805110711.2975149-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrHQvM1k6A5ePg--.23962S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWF18CFWfXr13ArWrXF47Arb_yoW5Ar4DpF
        9rK3WxAF1Dua4YqF9rXr4kZ3W29ws5Ka17J3y3KF18ZF9Yya4xG3sFyr1jvFy0qr9xArZ0
        vr4DtFWxC3WDXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRPEf5UUUUU
        =
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

In strict mode, we should return 0 if there is any hole in pageblock. If
we successfully isolated pages at beginning at pageblock and then have a
bogus compound_order outside pageblock in next page. We will abort search
loop with blockpfn > end_pfn. Although we will limit blockpfn to end_pfn,
we will treat it as a successful isolation in strict mode as blockpfn is
not < end_pfn and return partial isolated pages. Then
isolate_freepages_range may success unexpectly with hole in isolated
range.
This patch also removes unnecessary limit for blockpfn to go outside
by buddy page introduced in fixed commit or by stride introduced after
fixed commit. Caller could use returned blockpfn to check if full
pageblock is scanned by test if blockpfn >= end and to get next pfn to
scan inside isolate_freepages_block on demand.

Fixes: 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in free scanner")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index fa1b100b0d10..684f6e6cd8bc 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -631,6 +631,14 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 				page += (1UL << order) - 1;
 				nr_scanned += (1UL << order) - 1;
 			}
+			/*
+			 * There is a tiny chance that we have read bogus
+			 * compound_order(), so be careful to not go outside
+			 * of the pageblock.
+			 */
+			if (unlikely(blockpfn >= end_pfn))
+				blockpfn = end_pfn - 1;
+
 			goto isolate_fail;
 		}
 
@@ -677,17 +685,10 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	if (locked)
 		spin_unlock_irqrestore(&cc->zone->lock, flags);
 
-	/*
-	 * There is a tiny chance that we have read bogus compound_order(),
-	 * so be careful to not go outside of the pageblock.
-	 */
-	if (unlikely(blockpfn > end_pfn))
-		blockpfn = end_pfn;
-
 	trace_mm_compaction_isolate_freepages(*start_pfn, blockpfn,
 					nr_scanned, total_isolated);
 
-	/* Record how far we have got within the block */
+	/* Record how far we have got */
 	*start_pfn = blockpfn;
 
 	/*
@@ -1443,7 +1444,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
 	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
 
 	/* Skip this pageblock in the future as it's full or nearly full */
-	if (start_pfn == end_pfn && !cc->no_set_skip_hint)
+	if (start_pfn >= end_pfn && !cc->no_set_skip_hint)
 		set_pageblock_skip(page);
 }
 
@@ -1712,7 +1713,7 @@ static void isolate_freepages(struct compact_control *cc)
 					block_end_pfn, freelist, stride, false);
 
 		/* Update the skip hint if the full pageblock was scanned */
-		if (isolate_start_pfn == block_end_pfn)
+		if (isolate_start_pfn >= block_end_pfn)
 			update_pageblock_skip(cc, page, block_start_pfn -
 					      pageblock_nr_pages);
 
-- 
2.30.0

