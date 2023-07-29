Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61E0767DB0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjG2Jnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjG2Jnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:43:40 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCB535A3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 02:43:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RCfhP2P7cz4f3nwX
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 17:43:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDHMy5D38RkAQcpOQ--.25635S6;
        Sat, 29 Jul 2023 17:43:35 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        willy@infradead.org, david@redhat.com, shikemeng@huaweicloud.com
Subject: [PATCH 4/5] mm/compaction: remove unnecessary cursor page in isolate_freepages_block
Date:   Sun, 30 Jul 2023 01:43:53 +0800
Message-Id: <20230729174354.2239980-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
References: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHMy5D38RkAQcpOQ--.25635S6
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWxAFW3WF17CFWkXF1UKFg_yoW8Ww47pF
        yjkw1IyF40g345uFy7t3ykCr17Grs8KanrCr4fJrWrZFyftFyxZry2yr1UCrW8XrZrurZa
        93yDKF97Kan5JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cursor is only used for page forward currently. We can simply move page
forward directly to remove unnecessary cursor.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 65791a74c5e8..cfb661f4ce23 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -589,7 +589,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 				bool strict)
 {
 	int nr_scanned = 0, total_isolated = 0;
-	struct page *cursor;
+	struct page *page;
 	unsigned long flags = 0;
 	spinlock_t *locked = NULL;
 	unsigned long blockpfn = *start_pfn;
@@ -599,12 +599,11 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	if (strict)
 		stride = 1;
 
-	cursor = pfn_to_page(blockpfn);
+	page = pfn_to_page(blockpfn);
 
 	/* Isolate free pages. */
-	for (; blockpfn < end_pfn; blockpfn += stride, cursor += stride) {
+	for (; blockpfn < end_pfn; blockpfn += stride, page += stride) {
 		int isolated;
-		struct page *page = cursor;
 
 		/*
 		 * Periodically drop the lock (if held) regardless of its
@@ -628,7 +627,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 			if (likely(order <= MAX_ORDER)) {
 				blockpfn += (1UL << order) - 1;
-				cursor += (1UL << order) - 1;
+				page += (1UL << order) - 1;
 				nr_scanned += (1UL << order) - 1;
 			}
 			goto isolate_fail;
@@ -665,7 +664,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 		}
 		/* Advance to the end of split page */
 		blockpfn += isolated - 1;
-		cursor += isolated - 1;
+		page += isolated - 1;
 		continue;
 
 isolate_fail:
-- 
2.30.0

