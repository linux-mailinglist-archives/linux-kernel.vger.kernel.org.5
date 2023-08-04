Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED5A76F83B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjHDDHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjHDDEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:04:55 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6990044A1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 20:04:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RH9YN14nfz4f3mW5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:04:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgAXODLGasxkWSvZOg--.12542S4;
        Fri, 04 Aug 2023 11:04:40 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v3 2/8] mm/compaction: correct last_migrated_pfn update in compact_zone
Date:   Fri,  4 Aug 2023 19:04:48 +0800
Message-Id: <20230804110454.2935878-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230804110454.2935878-1-shikemeng@huaweicloud.com>
References: <20230804110454.2935878-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAXODLGasxkWSvZOg--.12542S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyfAw1fGrWDCFWrZry7Wrg_yoW8Zr17p3
        4rC3Z7Kr4DGayUZF1Yq34kZw1YkwnxKF43JrZ8Jw18AFs5J3WjkwnFk3Wjvry5XrnIy39Y
        vF4qga9rAanrZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
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
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
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
after scan to correctly set start pfn of last isolated page range. To
avoid that:
1. Miss a rescan with finish_pageblock set as last_migrate_pfn does not
point to right pageblock and the migrate will not be in pageblock of
last_migrate_pfn as it should be.
2. Wrongly issue flush by test cc->order block boundary with wrong
last_migrate_pfn.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a21b834c5898..bdb03f38b7f7 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2509,7 +2509,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
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

