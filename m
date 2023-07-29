Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B28767DB5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjG2Jno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjG2Jnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:43:40 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B162727
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 02:43:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RCfhP6JR6z4f3p0y
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 17:43:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDHMy5D38RkAQcpOQ--.25635S3;
        Sat, 29 Jul 2023 17:43:34 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        willy@infradead.org, david@redhat.com, shikemeng@huaweicloud.com
Subject: [PATCH 1/5] mm/compaction: allow blockpfn outside of pageblock for high order buddy page
Date:   Sun, 30 Jul 2023 01:43:50 +0800
Message-Id: <20230729174354.2239980-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
References: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHMy5D38RkAQcpOQ--.25635S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW8Ar1kWryDXFyfWryxAFb_yoW8KryDpa
        47K3W29F1DuayYvFy7JrWkuF1jkwsYyF4jyrW5Kr18ZF9Yg3Z2k3sFyr1jvryjqr1fAFZ0
        vr4DKFZ7CrsrZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRxhLUUUUUU
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

Commit 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in
free scanner") skiped compound pages to save iterations and limit blockpfn
to reach outside of page block in case of bogus compound_order. While this
also limit pfnblock outside page block in case a buddy page with order
higher than page block is found. After this, isolate_freepages_range will
fail unexpectedly as it will fail to isolate the page block which was
isolated successfully by high order buddy page in previous page block
and abort the free page isolation.

Fix this by allow blockpfn outside of pageblock in case of high order
buddy page.

Fixes: 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in free scanner")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 6841c0496223..d1d28d57e5bd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -681,8 +681,10 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	/*
 	 * There is a tiny chance that we have read bogus compound_order(),
 	 * so be careful to not go outside of the pageblock.
+	 * Allow blockpfn outside pageblock in normal case that we isolate
+	 * buddy page with order more than pageblock order.
 	 */
-	if (unlikely(blockpfn > end_pfn))
+	if (unlikely(blockpfn > end_pfn) && total_isolated <= pageblock_nr_pages)
 		blockpfn = end_pfn;
 
 	trace_mm_compaction_isolate_freepages(*start_pfn, blockpfn,
@@ -1418,7 +1420,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
 	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
 
 	/* Skip this pageblock in the future as it's full or nearly full */
-	if (start_pfn == end_pfn && !cc->no_set_skip_hint)
+	if (start_pfn >= end_pfn && !cc->no_set_skip_hint)
 		set_pageblock_skip(page);
 }
 
@@ -1687,7 +1689,7 @@ static void isolate_freepages(struct compact_control *cc)
 					block_end_pfn, freelist, stride, false);
 
 		/* Update the skip hint if the full pageblock was scanned */
-		if (isolate_start_pfn == block_end_pfn)
+		if (isolate_start_pfn >= block_end_pfn)
 			update_pageblock_skip(cc, page, block_start_pfn);
 
 		/* Are enough freepages isolated? */
-- 
2.30.0

