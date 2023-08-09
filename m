Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46317750AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjHICHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjHICHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:07:48 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E6D1BCD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 19:07:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RLD3N5qqKz4f3pHf
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:07:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBXem7v9NJkFAkTAQ--.60414S3;
        Wed, 09 Aug 2023 10:07:45 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 1/2] mm/page_alloc: remove track of active PCP lists range in bulk free
Date:   Wed,  9 Aug 2023 18:07:53 +0800
Message-Id: <20230809100754.3094517-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230809100754.3094517-1-shikemeng@huaweicloud.com>
References: <20230809100754.3094517-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBXem7v9NJkFAkTAQ--.60414S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyrKFWkGw4kKFyrKr18AFb_yoW8GFy7pF
        Wftw1SyrWkJryrCr4DAa1Dury7Kw1qkFWDurWrG348ZwnxWFyIk3WIqr9ayFyrJFWkZFy7
        AF4UJryFya4UZ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRE2NtUUUUUU=
        =
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

After commit fd56eef258a17 ("mm/page_alloc: simplify how many pages are
selected per pcp list during bulk free"), we will drain all pages in
selected pcp list. And we ensured passed count is < pcp->count. Then,
the search will finish before wrap-around and track of active PCP lists
range intended for wrap-around case is no longer needed.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page_alloc.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 96b7c1a7d1f2..1ddcb2707d05 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1207,8 +1207,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 					int pindex)
 {
 	unsigned long flags;
-	int min_pindex = 0;
-	int max_pindex = NR_PCP_LISTS - 1;
 	unsigned int order;
 	bool isolated_pageblocks;
 	struct page *page;
@@ -1231,17 +1229,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 
 		/* Remove pages from lists in a round-robin fashion. */
 		do {
-			if (++pindex > max_pindex)
-				pindex = min_pindex;
+			if (++pindex > NR_PCP_LISTS - 1)
+				pindex = 0;
 			list = &pcp->lists[pindex];
-			if (!list_empty(list))
-				break;
-
-			if (pindex == max_pindex)
-				max_pindex--;
-			if (pindex == min_pindex)
-				min_pindex++;
-		} while (1);
+		} while (list_empty(list));
 
 		order = pindex_to_order(pindex);
 		nr_pages = 1 << order;
-- 
2.30.0

