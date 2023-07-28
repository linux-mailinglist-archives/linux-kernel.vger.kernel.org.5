Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B826766883
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjG1JNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjG1JMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:12:39 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979044B1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:10:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RC20P6k66z4f3nyk
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:10:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgA3n7L1hcNkCrD+Ow--.32454S4;
        Fri, 28 Jul 2023 17:10:16 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 2/8] mm/compaction: correct last_migrated_pfn update in compact_zone
Date:   Sat, 29 Jul 2023 01:10:31 +0800
Message-Id: <20230728171037.2219226-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3n7L1hcNkCrD+Ow--.32454S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyfAw1fGrWDCFWrZry7Wrg_yoW8WryUp3
        4rCwn7Kr4kWayUZFyYy34kZ3WYkwsxKF43ArZ8Jw18AFs5Ka4jk347KF1jvrWUXrnIy3sY
        vF4qga97AanrZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sR_veHUUUUUU=
        =
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

We record start pfn of last isolated page block with last_migrated_pfn. And
then:
1. We check if we mark the page block skip for exclusive access in
isolate_migratepages_block by test if next migrate pfn is still in last
isolated page block. If so, we will set finish_pageblock to do the rescan.
2. We check if a full cc->order block is scanned by test if last scan range
passes the cc->order block boundary. If so, we flush the pages were freed.

We treat cc->migrate_pfn before isolate_migratepages as the start pfn of
last isolated page range. However, we always align migrate_pfn to page block
or move to another page block in fast_find_migrateblock or in linearly scan
forward in isolate_migratepages before do page isolation in
isolate_migratepages_block.

Update last_migrated_pfn with pageblock_start_pfn(cc->migrate_pfn - 1)
after scan to correctly set start pfn of last isolated page range.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index ce7841363b12..fb250c6b2b6e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2482,7 +2482,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 			goto check_drain;
 		case ISOLATE_SUCCESS:
 			update_cached = false;
-			last_migrated_pfn = iteration_start_pfn;
+			last_migrated_pfn = max(cc->zone->zone_start_pfn,
+				pageblock_start_pfn(cc->migrate_pfn - 1));
 		}
 
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
-- 
2.30.0

