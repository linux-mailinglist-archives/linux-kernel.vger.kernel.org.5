Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57359757520
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjGRHP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjGRHP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:15:56 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFCF10B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:15:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R4qWz3yNqz4f3n0K
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:57:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgB3a+nfN7Zk36ikOA--.34217S5;
        Tue, 18 Jul 2023 14:57:37 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 3/3] mm/page_ext: use page_ext_data helper in page_owner
Date:   Tue, 18 Jul 2023 22:58:12 +0800
Message-Id: <20230718145812.1991717-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
References: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3a+nfN7Zk36ikOA--.34217S5
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4kWw18Jr18Zr45Cw4fuFg_yoWxuFgE9w
        sFvr18ArnIyFWavw4rCan3Jry2y34kCr1kJF1vgrWYkr15ta4kXF9YvwnxGr1kXr43W34D
        GFy7Zasrtw17WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbqAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r1rM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
        AqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
        1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTR
        QSdDUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use page_ext_data helper in page_owner to avoid access offset directly.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page_owner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index c93baef0148f..4e2723e1b300 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -104,7 +104,7 @@ struct page_ext_operations page_owner_ops = {
 
 static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
 {
-	return (void *)page_ext + page_owner_ops.offset;
+	return page_ext_data(page_ext, &page_owner_ops);
 }
 
 static noinline depot_stack_handle_t save_stack(gfp_t flags)
-- 
2.30.0

