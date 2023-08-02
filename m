Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F53376C24F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjHBBhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjHBBhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:37:31 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4A9270E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:37:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFvjc6W33z4f3lXF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:37:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAXzrFTs8lkvrtvPQ--.56352S5;
        Wed, 02 Aug 2023 09:37:27 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 3/8] mm/compaction: skip page block marked skip in isolate_migratepages_block
Date:   Wed,  2 Aug 2023 17:37:36 +0800
Message-Id: <20230802093741.2333325-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230802093741.2333325-1-shikemeng@huaweicloud.com>
References: <20230802093741.2333325-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXzrFTs8lkvrtvPQ--.56352S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1xCFWfKFyUtr1rKFyDJrb_yoW8Xr1UpF
        18G3ZFqFWDW3W3ZFnrtwn7uF15Cwn7JF43trZ8t348JFZ8ta4xt3srt3Z5ZrWYqrnxtrZ0
        vF4DKFWxCa17ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
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

Move migrate_pfn to page block end when block is marked skip to avoid
unnecessary scan retry of that block from upper caller.
For example, compact_zone may wrongly rescan skip page block with
finish_pageblock set as following:
1. cc->migrate point to the start of page block
2. compact_zone record last_migrated_pfn to cc->migrate
3. compact_zone->isolate_migratepages->isolate_migratepages_block tries to
scan the block. The low_pfn maybe moved forward to middle of block because
of free pages at beginning of block.
4. we find first lru page could be isolated but block was exclusive marked
skip.
5. abort isolate_migratepages_block and make cc->migrate_pfn point to
found lru page at middle of block.
6. compact_zone find cc->migrate_pfn and last_migrated_pfn are in the same
block and wrongly rescan the block with finish_pageblock set.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index ec3a96b7afce..984c17a5c8fd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1126,6 +1126,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 				skip_updated = true;
 				if (test_and_set_skip(cc, valid_page) &&
 				    !cc->finish_pageblock) {
+					low_pfn = end_pfn;
 					goto isolate_abort;
 				}
 			}
-- 
2.30.0

