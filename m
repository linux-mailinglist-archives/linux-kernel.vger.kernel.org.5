Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D057DB1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 02:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjJ3BMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 21:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjJ3BMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 21:12:05 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B587DBD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 18:12:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vv4ZEFb_1698628318;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vv4ZEFb_1698628318)
          by smtp.aliyun-inc.com;
          Mon, 30 Oct 2023 09:11:59 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     shy828301@gmail.com, ying.huang@intel.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: huge_memory: batch tlb flush when splitting a pte-mapped THP
Date:   Mon, 30 Oct 2023 09:11:47 +0800
Message-Id: <431d9fb6823036369dcb1d3b2f63732f01df21a7.1698488264.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can observe an obvious tlb flush hotpot when splitting a pte-mapped THP on
my ARM64 server, and the distribution of this hotspot is as follows:

   - 16.85% split_huge_page_to_list
      + 7.80% down_write
      - 7.49% try_to_migrate
         - 7.48% rmap_walk_anon
              7.23% ptep_clear_flush
      + 1.52% __split_huge_page

The reason is that the split_huge_page_to_list() will build migration entries
for each subpage of a pte-mapped Anon THP by try_to_migrate(), or unmap for
file THP, and it will clear and tlb flush for each subpage's pte. Moreover,
the split_huge_page_to_list() will set TTU_SPLIT_HUGE_PMD flag to ensure
the THP is already a pte-mapped THP before splitting it to some normal pages.

Actually, there is no need to flush tlb for each subpage immediately, instead
we can batch tlb flush for the pte-mapped THP to improve the performance.

After this patch, we can see the batch tlb flush can improve the latency
obviously when running thpscale.
                             k6.5-base                   patched
Amean     fault-both-1      1071.17 (   0.00%)      901.83 *  15.81%*
Amean     fault-both-3      2386.08 (   0.00%)     1865.32 *  21.82%*
Amean     fault-both-5      2851.10 (   0.00%)     2273.84 *  20.25%*
Amean     fault-both-7      3679.91 (   0.00%)     2881.66 *  21.69%*
Amean     fault-both-12     5916.66 (   0.00%)     4369.55 *  26.15%*
Amean     fault-both-18     7981.36 (   0.00%)     6303.57 *  21.02%*
Amean     fault-both-24    10950.79 (   0.00%)     8752.56 *  20.07%*
Amean     fault-both-30    14077.35 (   0.00%)    10170.01 *  27.76%*
Amean     fault-both-32    13061.57 (   0.00%)    11630.08 *  10.96%*

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/huge_memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f31f02472396..0e4c14bf6872 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2379,7 +2379,7 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 static void unmap_folio(struct folio *folio)
 {
 	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
-		TTU_SYNC;
+		TTU_SYNC | TTU_BATCH_FLUSH;
 
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 
@@ -2392,6 +2392,8 @@ static void unmap_folio(struct folio *folio)
 		try_to_migrate(folio, ttu_flags);
 	else
 		try_to_unmap(folio, ttu_flags | TTU_IGNORE_MLOCK);
+
+	try_to_unmap_flush();
 }
 
 static void remap_page(struct folio *folio, unsigned long nr)
-- 
2.39.3

