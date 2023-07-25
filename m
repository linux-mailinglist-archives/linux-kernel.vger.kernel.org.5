Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A77761035
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjGYKFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjGYKFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:05:03 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F531FCA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:04:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R9CLP4Bgdz4f3l8s
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:04:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAXC+ksnr9kFkPOOg--.2821S6;
        Tue, 25 Jul 2023 18:04:30 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, baolin.wang@linux.alibaba.com,
        david@redhat.com, shikemeng@huaweicloud.com
Subject: [PATCH 4/4] mm/compaction: add compact_unlock_irqrestore to remove repeat code
Date:   Wed, 26 Jul 2023 02:04:56 +0800
Message-Id: <20230725180456.2146626-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230725180456.2146626-1-shikemeng@huaweicloud.com>
References: <20230725180456.2146626-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXC+ksnr9kFkPOOg--.2821S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15Aw45WrWrCr1DWr1DAwb_yoWrXryxpF
        4kGasIyr4kZFy3WF4ftr4ruFs0g34fXF47Ar4Sk3WfJa1FvF93Gw1SyFyUuFWrXryavFZ5
        WFs8Jr18AF47Z3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRHa0PU
        UUUU=
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

Add compact_unlock_irqrestore to remove repeat code. This also make
compact lock functions sereis complete as we can call
compact_lock_irqsave/compact_unlock_irqrestore in pair.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index c1dc821ac6e1..eb1d3d9a422c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -541,6 +541,14 @@ static spinlock_t *compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 	return lock;
 }
 
+static inline void compact_unlock_irqrestore(spinlock_t **locked, unsigned long flags)
+{
+	if (*locked) {
+		spin_unlock_irqrestore(*locked, flags);
+		*locked = NULL;
+	}
+}
+
 /*
  * Compaction requires the taking of some coarse locks that are potentially
  * very heavily contended. The lock should be periodically unlocked to avoid
@@ -556,10 +564,7 @@ static spinlock_t *compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 static bool compact_unlock_should_abort(spinlock_t **locked,
 		unsigned long flags, struct compact_control *cc)
 {
-	if (*locked) {
-		spin_unlock_irqrestore(*locked, flags);
-		*locked = NULL;
-	}
+	compact_unlock_irqrestore(locked, flags);
 
 	if (fatal_signal_pending(current)) {
 		cc->contended = true;
@@ -671,8 +676,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 	}
 
-	if (locked)
-		spin_unlock_irqrestore(locked, flags);
+	compact_unlock_irqrestore(&locked, flags);
 
 	/*
 	 * There is a tiny chance that we have read bogus compound_order(),
@@ -935,10 +939,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		}
 
 		if (PageHuge(page) && cc->alloc_contig) {
-			if (locked) {
-				spin_unlock_irqrestore(locked, flags);
-				locked = NULL;
-			}
+			compact_unlock_irqrestore(&locked, flags);
 
 			ret = isolate_or_dissolve_huge_page(page, &cc->migratepages);
 
@@ -1024,10 +1025,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			 */
 			if (unlikely(__PageMovable(page)) &&
 					!PageIsolated(page)) {
-				if (locked) {
-					spin_unlock_irqrestore(locked, flags);
-					locked = NULL;
-				}
+				compact_unlock_irqrestore(&locked, flags);
 
 				if (isolate_movable_page(page, mode)) {
 					folio = page_folio(page);
@@ -1111,9 +1109,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 		/* If we already hold the lock, we can skip some rechecking */
 		if (&lruvec->lru_lock != locked) {
-			if (locked)
-				spin_unlock_irqrestore(locked, flags);
-
+			compact_unlock_irqrestore(&locked, flags);
 			locked = compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
 
 			lruvec_memcg_debug(lruvec, folio);
@@ -1176,10 +1172,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 isolate_fail_put:
 		/* Avoid potential deadlock in freeing page under lru_lock */
-		if (locked) {
-			spin_unlock_irqrestore(locked, flags);
-			locked = NULL;
-		}
+		compact_unlock_irqrestore(&locked, flags);
 		folio_put(folio);
 
 isolate_fail:
@@ -1192,10 +1185,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * page anyway.
 		 */
 		if (nr_isolated) {
-			if (locked) {
-				spin_unlock_irqrestore(locked, flags);
-				locked = NULL;
-			}
+			compact_unlock_irqrestore(&locked, flags);
 			putback_movable_pages(&cc->migratepages);
 			cc->nr_migratepages = 0;
 			nr_isolated = 0;
@@ -1224,8 +1214,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	folio = NULL;
 
 isolate_abort:
-	if (locked)
-		spin_unlock_irqrestore(locked, flags);
+	compact_unlock_irqrestore(&locked, flags);
 	if (folio) {
 		folio_set_lru(folio);
 		folio_put(folio);
-- 
2.30.0

