Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAED758C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGSDfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjGSDed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:34:33 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F748172E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:34:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R5Lz70zN8z4f3jM7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:34:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAXC+mVWLdkI7bmOA--.28977S3;
        Wed, 19 Jul 2023 11:29:27 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 1/4] mm/compaction: use "spinlock_t *" to record held lock in compact [un]lock functions
Date:   Wed, 19 Jul 2023 19:29:58 +0800
Message-Id: <20230719113001.2023703-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230719113001.2023703-1-shikemeng@huaweicloud.com>
References: <20230719113001.2023703-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXC+mVWLdkI7bmOA--.28977S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4fKFWUtr1rKFy7CFWktFb_yoW5AF4rpF
        1xG3Wayr18Zay5uF4ftFW8WF43Xw1fWa4UAwsIqw1rJF45tF13Gw10ya4UurWUXasavFZa
        qFW3tFyUAay7ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRiDGYDUUUUU=
        =
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

Make compact_lock_irqsave and compact_unlock_should_abort use
"spinlock_t *" to record held lock.
This is a preparation to use compact_unlock_should_abort in
isolate_migratepages_block to remove repeat code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 9641e2131901..dfef14d3ef78 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -523,22 +523,22 @@ static bool test_and_set_skip(struct compact_control *cc, struct page *page)
  * abort when the current block is finished regardless of success rate.
  * Sync compaction acquires the lock.
  *
- * Always returns true which makes it easier to track lock state in callers.
+ * Always returns lock which makes it easier to track lock state in callers.
  */
-static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
+static spinlock_t *compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 						struct compact_control *cc)
 	__acquires(lock)
 {
 	/* Track if the lock is contended in async mode */
 	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
 		if (spin_trylock_irqsave(lock, *flags))
-			return true;
+			return lock;
 
 		cc->contended = true;
 	}
 
 	spin_lock_irqsave(lock, *flags);
-	return true;
+	return lock;
 }
 
 /*
@@ -553,12 +553,12 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
  * Returns true if compaction should abort due to fatal signal pending.
  * Returns false when compaction can continue.
  */
-static bool compact_unlock_should_abort(spinlock_t *lock,
-		unsigned long flags, bool *locked, struct compact_control *cc)
+static bool compact_unlock_should_abort(spinlock_t **locked,
+		unsigned long flags, struct compact_control *cc)
 {
 	if (*locked) {
-		spin_unlock_irqrestore(lock, flags);
-		*locked = false;
+		spin_unlock_irqrestore(*locked, flags);
+		*locked = NULL;
 	}
 
 	if (fatal_signal_pending(current)) {
@@ -586,7 +586,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	int nr_scanned = 0, total_isolated = 0;
 	struct page *cursor;
 	unsigned long flags = 0;
-	bool locked = false;
+	spinlock_t *locked = NULL;
 	unsigned long blockpfn = *start_pfn;
 	unsigned int order;
 
@@ -607,8 +607,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 		 * pending.
 		 */
 		if (!(blockpfn % COMPACT_CLUSTER_MAX)
-		    && compact_unlock_should_abort(&cc->zone->lock, flags,
-								&locked, cc))
+		    && compact_unlock_should_abort(&locked, flags, cc))
 			break;
 
 		nr_scanned++;
@@ -673,7 +672,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	}
 
 	if (locked)
-		spin_unlock_irqrestore(&cc->zone->lock, flags);
+		spin_unlock_irqrestore(locked, flags);
 
 	/*
 	 * There is a tiny chance that we have read bogus compound_order(),
-- 
2.30.0

