Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4303D766882
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjG1JNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjG1JMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:12:39 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6C044B2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:10:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RC20Q5DXlz4f3nyv
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:10:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgA3n7L1hcNkCrD+Ow--.32454S6;
        Fri, 28 Jul 2023 17:10:17 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 4/8] mm/compaction: remove stale fast_find_block flag in isolate_migratepages
Date:   Sat, 29 Jul 2023 01:10:33 +0800
Message-Id: <20230728171037.2219226-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3n7L1hcNkCrD+Ow--.32454S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW3uFWUWF1fuFykCryUZFb_yoW8tFWxpw
        1fJwn7GF4DGa43W3ZIqFyDZ3W5Cw1fKF17JrW7Kw18AFnxtFnF93Z7tFnYvFyFqr9avF90
        vr4Dta4Iya1jva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRKFAPU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In old code, we set skip to found page block in fast_find_migrateblock. So
we use fast_find_block to avoid skip found page block from
fast_find_migrateblock.
In 90ed667c03fe5 ("Revert "Revert "mm/compaction: fix set skip in
fast_find_migrateblock"""), we remove skip set in fast_find_migrateblock,
then fast_find_block is useless.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index ad535f880c70..09c36251c613 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1949,7 +1949,6 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 	const isolate_mode_t isolate_mode =
 		(sysctl_compact_unevictable_allowed ? ISOLATE_UNEVICTABLE : 0) |
 		(cc->mode != MIGRATE_SYNC ? ISOLATE_ASYNC_MIGRATE : 0);
-	bool fast_find_block;
 
 	/*
 	 * Start at where we last stopped, or beginning of the zone as
@@ -1961,13 +1960,6 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 	if (block_start_pfn < cc->zone->zone_start_pfn)
 		block_start_pfn = cc->zone->zone_start_pfn;
 
-	/*
-	 * fast_find_migrateblock marks a pageblock skipped so to avoid
-	 * the isolation_suitable check below, check whether the fast
-	 * search was successful.
-	 */
-	fast_find_block = low_pfn != cc->migrate_pfn && !cc->fast_search_fail;
-
 	/* Only scan within a pageblock boundary */
 	block_end_pfn = pageblock_end_pfn(low_pfn);
 
@@ -1976,7 +1968,6 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 	 * Do not cross the free scanner.
 	 */
 	for (; block_end_pfn <= cc->free_pfn;
-			fast_find_block = false,
 			cc->migrate_pfn = low_pfn = block_end_pfn,
 			block_start_pfn = block_end_pfn,
 			block_end_pfn += pageblock_nr_pages) {
@@ -2007,8 +1998,7 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 		 * before making it "skip" so other compaction instances do
 		 * not scan the same block.
 		 */
-		if (pageblock_aligned(low_pfn) &&
-		    !fast_find_block && !isolation_suitable(cc, page))
+		if (pageblock_aligned(low_pfn) && !isolation_suitable(cc, page))
 			continue;
 
 		/*
-- 
2.30.0

