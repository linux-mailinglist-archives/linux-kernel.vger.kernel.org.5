Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F4778945B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 09:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjHZHgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 03:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjHZHgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 03:36:36 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3B22139
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 00:36:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RXpXs6pWMz4f3lDj
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:36:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDHQi98q+lk6GgZBg--.2153S6;
        Sat, 26 Aug 2023 15:36:31 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 4/7] mm/compaction: simplify pfn iteration in isolate_freepages_range
Date:   Sat, 26 Aug 2023 23:36:14 +0800
Message-Id: <20230826153617.4019189-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHQi98q+lk6GgZBg--.2153S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUKw1xAr1xKrW8Zr4fXwb_yoW8Kr43pa
        y3G3Wxur1UGay5WFyUAw1Duw15GwsxCF47Wr4UJr1rZasYvF92yF9ayryqyFy0vryxArWq
        vrsFgFWDta1DZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiVbyDUU
        UUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

The pfn + isolated always points to start of next pageblock as:
In case isolated buddy page has order higher than pageblock:
1. page in buddy page is aligned with it's order
2. order of page is higher than pageblock order
Then page is aligned with pageblock order. So pfn of page and isolated
pages count are both aligned pageblock order. So pfn + isolated is
pageblock order aligned.

In case isolated buddy page has order lower than pageblock:
Buddy page with order N contains two order N - 1 pages as following:
|        order N        |
|order N - 1|order N - 1|
So buddy pages with order N - 1 will never cross boudary of order N.
Similar, buddy pages with order N - 2 will never cross boudary of order
N - 1 and so on. Then any pages with order less than pageblock order
will never crosa boudary of pageblock.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b4d03c9ffe7c..2937e754cfb7 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -739,21 +739,11 @@ isolate_freepages_range(struct compact_control *cc,
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

