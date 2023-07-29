Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084ED767DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjG2Jnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG2Jnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:43:39 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676922701
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 02:43:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RCfhR0xxwz4f403y
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 17:43:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDHMy5D38RkAQcpOQ--.25635S5;
        Sat, 29 Jul 2023 17:43:35 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        willy@infradead.org, david@redhat.com, shikemeng@huaweicloud.com
Subject: [PATCH 3/5] mm/compaction: merge end_pfn boundary check in isolate_freepages_range
Date:   Sun, 30 Jul 2023 01:43:52 +0800
Message-Id: <20230729174354.2239980-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
References: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHMy5D38RkAQcpOQ--.25635S5
X-Coremail-Antispam: 1UD129KBjvJXoW7JF4kWr1rWF4kWryDJF4ruFg_yoW8Jrykp3
        47GF1xWr1kuayYvFy7X3s8Zr15Cw4kKF4UArWUGF1rAFyFkF97K3sayryDZFyjqw1xZrZ0
        vrsFkFyxt3WUZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
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

From: Kemeng Shi <shikemeng@huawei.com>

Merge the end_pfn boundary check for single page block forward and multiple
page blocks forward to avoid do twice boundary check for multiple page
blocks forward.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 4a784872565a..65791a74c5e8 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -740,8 +740,6 @@ isolate_freepages_range(struct compact_control *cc,
 		/* Protect pfn from changing by isolate_freepages_block */
 		unsigned long isolate_start_pfn = pfn;
 
-		block_end_pfn = min(block_end_pfn, end_pfn);
-
 		/*
 		 * pfn could pass the block_end_pfn if isolated freepage
 		 * is more than pageblock order. In this case, we adjust
@@ -750,9 +748,10 @@ isolate_freepages_range(struct compact_control *cc,
 		if (pfn >= block_end_pfn) {
 			block_start_pfn = pageblock_start_pfn(pfn);
 			block_end_pfn = pageblock_end_pfn(pfn);
-			block_end_pfn = min(block_end_pfn, end_pfn);
 		}
 
+		block_end_pfn = min(block_end_pfn, end_pfn);
+
 		if (!pageblock_pfn_to_page(block_start_pfn,
 					block_end_pfn, cc->zone))
 			break;
-- 
2.30.0

