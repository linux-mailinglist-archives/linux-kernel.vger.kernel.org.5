Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A653E770D62
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjHEDH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHEDHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:07:07 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26014EE6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:07:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHnYb2KYsz4f3jZ6
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 11:06:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrHQvM1k6A5ePg--.23962S6;
        Sat, 05 Aug 2023 11:06:59 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 4/9] mm/compaction: simplify pfn iteration in isolate_freepages_range
Date:   Sat,  5 Aug 2023 19:07:06 +0800
Message-Id: <20230805110711.2975149-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrHQvM1k6A5ePg--.23962S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUKw17Zw15Jr4rZw4rAFb_yoW8Xr43pa
        47C3WIgr1UCayYgF17Z3yDZw15Gws8GF4UGr4UJF1rZF9YkF97Kas2yrykXFy0v34xArZ0
        vrZrKFWxKw4UZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
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

We call isolate_freepages_block in strict mode, continuous pages in
pageblock will be isolated if isolate_freepages_block successed.
Then pfn + isolated will point to start of next pageblock to scan
no matter how many pageblocks are isolated in isolate_freepages_block.
Use pfn + isolated as start of next pageblock to scan to simplify the
iteration.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 684f6e6cd8bc..8d7d38073d30 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -733,21 +733,11 @@ isolate_freepages_range(struct compact_control *cc,
 	block_end_pfn = pageblock_end_pfn(pfn);
 
 	for (; pfn < end_pfn; pfn += isolated,
-				block_start_pfn = block_end_pfn,
-				block_end_pfn += pageblock_nr_pages) {
+				block_start_pfn = pfn,
+				block_end_pfn = pfn + pageblock_nr_pages) {
 		/* Protect pfn from changing by isolate_freepages_block */
 		unsigned long isolate_start_pfn = pfn;
 
-		/*
-		 * pfn could pass the block_end_pfn if isolated freepage
-		 * is more than pageblock order. In this case, we adjust
-		 * scanning range to right one.
-		 */
-		if (pfn >= block_end_pfn) {
-			block_start_pfn = pageblock_start_pfn(pfn);
-			block_end_pfn = pageblock_end_pfn(pfn);
-		}
-
 		block_end_pfn = min(block_end_pfn, end_pfn);
 
 		if (!pageblock_pfn_to_page(block_start_pfn,
-- 
2.30.0

