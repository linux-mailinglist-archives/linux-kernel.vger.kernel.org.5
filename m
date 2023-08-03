Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FAE76DD83
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjHCBts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjHCBs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:48:58 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC5430EF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 18:48:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGWwF2rYCz4f3n6P
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:48:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP3 (Coremail) with SMTP id _Ch0CgCXQiB7B8tkVa5vOQ--.12634S5;
        Thu, 03 Aug 2023 09:48:46 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 3/4] mm/compaction: remove unnecessary cursor page in isolate_freepages_block
Date:   Thu,  3 Aug 2023 17:49:00 +0800
Message-Id: <20230803094901.2915942-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230803094901.2915942-1-shikemeng@huaweicloud.com>
References: <20230803094901.2915942-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCXQiB7B8tkVa5vOQ--.12634S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWxAFW3WrW3tr4kZr4fXwb_yoW8AF18pF
        yjkw1xAF409345WFy7t3ykCr17GrsxtanFkrs3JrWrZFyftFyI9r9Fyr1UCrW8Xr9rurZa
        v3yqkF97Kan5JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b7a05b9843ed..cb1dd5c5bf3f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -584,7 +584,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 				bool strict)
 {
 	int nr_scanned = 0, total_isolated = 0;
-	struct page *cursor;
+	struct page *page;
 	unsigned long flags = 0;
 	bool locked = false;
 	unsigned long blockpfn = *start_pfn;
@@ -594,12 +594,11 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
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
@@ -624,7 +623,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 			if (likely(order <= MAX_ORDER)) {
 				blockpfn += (1UL << order) - 1;
-				cursor += (1UL << order) - 1;
+				page += (1UL << order) - 1;
 				nr_scanned += (1UL << order) - 1;
 			}
 			goto isolate_fail;
@@ -661,7 +660,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 		}
 		/* Advance to the end of split page */
 		blockpfn += isolated - 1;
-		cursor += isolated - 1;
+		page += isolated - 1;
 		continue;
 
 isolate_fail:
-- 
2.30.0

