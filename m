Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94F3789460
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 09:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjHZHhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 03:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjHZHgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 03:36:36 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF42683
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 00:36:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RXpXs4MH0z4f3lD6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:36:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDHQi98q+lk6GgZBg--.2153S5;
        Sat, 26 Aug 2023 15:36:30 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 3/7] mm/compaction: correctly return failure with bogus compound_order in strict mode
Date:   Sat, 26 Aug 2023 23:36:13 +0800
Message-Id: <20230826153617.4019189-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHQi98q+lk6GgZBg--.2153S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4xury8JFykCFy7Jry8uFg_yoW8WFyDpF
        9xKF1IkF18uayYgF97Zr4kZ3WfCrZakFW7A39xKF18AasYya47Zry2yr1UZFy0qrnxAr90
        vrsrtFW8Ca1DXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiyCJDUUUUU=
        =
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

In strict mode, we should return 0 if there is any hole in pageblock. If
we successfully isolated pages at beginning at pageblock and then have a
bogus compound_order outside pageblock in next page. We will abort search
loop with blockpfn > end_pfn. Although we will limit blockpfn to end_pfn,
we will treat it as a successful isolation in strict mode as blockpfn is
not < end_pfn and return partial isolated pages. Then
isolate_freepages_range may success unexpectly with hole in isolated
range.

Fixes: 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in free scanner")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a40550a33aee..b4d03c9ffe7c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -631,6 +631,14 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 				page += (1UL << order) - 1;
 				nr_scanned += (1UL << order) - 1;
 			}
+			/*
+			 * There is a tiny chance that we have read bogus
+			 * compound_order(), so be careful to not go outside
+			 * of the pageblock.
+			 */
+			if (unlikely(blockpfn >= end_pfn))
+				blockpfn = end_pfn - 1;
+
 			goto isolate_fail;
 		}
 
@@ -678,8 +686,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 		spin_unlock_irqrestore(&cc->zone->lock, flags);
 
 	/*
-	 * There is a tiny chance that we have read bogus compound_order(),
-	 * so be careful to not go outside of the pageblock.
+	 * Be careful to not go outside of the pageblock.
 	 */
 	if (unlikely(blockpfn > end_pfn))
 		blockpfn = end_pfn;
-- 
2.30.0

