Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5139B789461
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 09:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjHZHhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 03:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjHZHgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 03:36:36 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F49213D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 00:36:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RXpXr6PdZz4f3l1Z
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:36:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDHQi98q+lk6GgZBg--.2153S3;
        Sat, 26 Aug 2023 15:36:30 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 1/7] mm/compaction: use correct list in move_freelist_{head}/{tail}
Date:   Sat, 26 Aug 2023 23:36:11 +0800
Message-Id: <20230826153617.4019189-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHQi98q+lk6GgZBg--.2153S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4kCr1fGFWUXw1DXrWDJwb_yoW8Jw47pr
        y5Cr4UXr1UArW0yFnrXa1q9348KF42vrWjkrZ8uFWDAFn8trW2qF9ayF4UZ3sxXrWjkrWY
        vrsrKF43GrW7Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBC14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
        1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
        JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
        AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
        IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRCeHDUUUUU
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

The freepage is chained with buddy_list in freelist head. Use buddy_list
instead of lru to correct the list operation.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
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

