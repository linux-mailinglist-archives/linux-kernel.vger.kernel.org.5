Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C2E76C252
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjHBBhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjHBBhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:37:31 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101102708
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:37:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFvjc4D2fz4f3lX5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:37:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAXzrFTs8lkvrtvPQ--.56352S4;
        Wed, 02 Aug 2023 09:37:27 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 2/8] mm/compaction: correct last_migrated_pfn update in compact_zone
Date:   Wed,  2 Aug 2023 17:37:35 +0800
Message-Id: <20230802093741.2333325-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230802093741.2333325-1-shikemeng@huaweicloud.com>
References: <20230802093741.2333325-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXzrFTs8lkvrtvPQ--.56352S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyfAw1fGrWDCFWrZry7Wrg_yoW8CF48pa
        4rC3Z7Kr4DWayUZF1Yq34kZw1Ykws3KF43JrZ8Jw18Ars5Ka4Iyw17K3WjvrW5XrnIy3sY
        vF4qgay7AanrZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
        CS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
        WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7s
        RNVbyUUUUUU==
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
after scan to correctly set start pfn of last isolated page range. To
avoid that:
1. Miss a rescan with finish_pageblock set as last_migrate_pfn does not
point to right pageblock and the migrate will not be in pageblock of
last_migrate_pfn as it should be.
2. Wrongly issue flush by test cc->order block boundary with wrong
last_migrate_pfn.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a8cea916df9d..ec3a96b7afce 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2487,7 +2487,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
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

