Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F03758C22
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjGSDbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGSDbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:31:20 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1628B271B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:29:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R5LsK5xpvz4f3lX3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:29:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAXC+mVWLdkI7bmOA--.28977S5;
        Wed, 19 Jul 2023 11:29:28 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 3/4] mm/compaction: use compact_unlock_should_abort in isolate_migratepages_block
Date:   Wed, 19 Jul 2023 19:30:00 +0800
Message-Id: <20230719113001.2023703-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230719113001.2023703-1-shikemeng@huaweicloud.com>
References: <20230719113001.2023703-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXC+mVWLdkI7bmOA--.28977S5
X-Coremail-Antispam: 1UD129KBjvdXoWrtr48tFWktFy7urW8tF4xWFg_yoWDWFg_Za
        40q3Zaqr43ZryrJFZxCr4xAFn5KrZ5ur1xW3srtFZ0kr9IyF48tFsrZr43Wr13XasruFZx
        Ca4kZr12kF12yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbqAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r1rM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use compact_unlock_should_abort in isolate_migratepages_block to remove
repeat code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 638146a49e89..c1dc821ac6e1 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -909,20 +909,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * contention, to give chance to IRQs. Abort completely if
 		 * a fatal signal is pending.
 		 */
-		if (!(low_pfn % COMPACT_CLUSTER_MAX)) {
-			if (locked) {
-				spin_unlock_irqrestore(locked, flags);
-				locked = NULL;
-			}
-
-			if (fatal_signal_pending(current)) {
-				cc->contended = true;
-				ret = -EINTR;
-
-				goto fatal_pending;
-			}
-
-			cond_resched();
+		if (!(low_pfn % COMPACT_CLUSTER_MAX) &&
+		    compact_unlock_should_abort(&locked, flags, cc)) {
+			ret = -EINTR;
+			goto fatal_pending;
 		}
 
 		nr_scanned++;
-- 
2.30.0

