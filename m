Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1184776DD7F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjHCBtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHCBs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:48:58 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E71230E9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 18:48:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGWwD4nbgz4f3mJ1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:48:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP3 (Coremail) with SMTP id _Ch0CgCXQiB7B8tkVa5vOQ--.12634S3;
        Thu, 03 Aug 2023 09:48:45 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 1/4] mm/compaction: set compact_cached_free_pfn correctly in update_pageblock_skip
Date:   Thu,  3 Aug 2023 17:48:58 +0800
Message-Id: <20230803094901.2915942-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230803094901.2915942-1-shikemeng@huaweicloud.com>
References: <20230803094901.2915942-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCXQiB7B8tkVa5vOQ--.12634S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1kCr17WFW3KFW7KF15urg_yoWfZrX_G3
        WIyFnxK34avrZ3Z3ZrAw4Skr1xKrWrCF1DWw1Yqry7Z3yqvF4kZa9rJwsxXrnIqFyDurnx
        Gw1kuF1vkF4agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb6AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREgyCDUUUUU=
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

We will set skip to page block of block_start_pfn, it's more reasonable
to set compact_cached_free_pfn to page block before the block_start_pfn.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index fbf50a9e4d23..61f56cee3715 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1714,7 +1714,8 @@ static void isolate_freepages(struct compact_control *cc)
 
 		/* Update the skip hint if the full pageblock was scanned */
 		if (isolate_start_pfn == block_end_pfn)
-			update_pageblock_skip(cc, page, block_start_pfn);
+			update_pageblock_skip(cc, page, block_start_pfn -
+					      pageblock_nr_pages);
 
 		/* Are enough freepages isolated? */
 		if (cc->nr_freepages >= cc->nr_migratepages) {
-- 
2.30.0

