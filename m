Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19E278F95C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjIAHwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344686AbjIAHwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:52:09 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2A010DA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:52:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RcVc03pW2z4f3kK5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:52:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnw6YfmPFk1Z5cCA--.13825S3;
        Fri, 01 Sep 2023 15:52:00 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] mm/compaction: use correct list in move_freelist_{head}/{tail}
Date:   Fri,  1 Sep 2023 23:51:36 +0800
Message-Id: <20230901155141.249860-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230901155141.249860-1-shikemeng@huaweicloud.com>
References: <20230901155141.249860-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnw6YfmPFk1Z5cCA--.13825S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4kCr15CFyDXry5JF1kXwb_yoW8GF18pr
        y5CF4UXr4UArW0yFnrXa1q9a48KFsrZrWjkrZ8uFWDAFn8trW2qF9ayF4UZ3s3XrWjkrWY
        vrsrKF43GrW3Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsgyZUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The freepage is chained with buddy_list in freelist head. Use buddy_list
instead of lru to correct the list operation.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 38c8d216c6a3..e3ee1bc1c0ad 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1395,8 +1395,8 @@ move_freelist_head(struct list_head *freelist, struct page *freepage)
 {
 	LIST_HEAD(sublist);
 
-	if (!list_is_last(freelist, &freepage->lru)) {
-		list_cut_before(&sublist, freelist, &freepage->lru);
+	if (!list_is_last(freelist, &freepage->buddy_list)) {
+		list_cut_before(&sublist, freelist, &freepage->buddy_list);
 		list_splice_tail(&sublist, freelist);
 	}
 }
@@ -1412,8 +1412,8 @@ move_freelist_tail(struct list_head *freelist, struct page *freepage)
 {
 	LIST_HEAD(sublist);
 
-	if (!list_is_first(freelist, &freepage->lru)) {
-		list_cut_position(&sublist, freelist, &freepage->lru);
+	if (!list_is_first(freelist, &freepage->buddy_list)) {
+		list_cut_position(&sublist, freelist, &freepage->buddy_list);
 		list_splice_tail(&sublist, freelist);
 	}
 }
-- 
2.30.0

