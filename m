Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A87758C24
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjGSDb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGSDbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:31:21 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE862723
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:29:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R5LsL0y1wz4f3n02
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:29:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAXC+mVWLdkI7bmOA--.28977S6;
        Wed, 19 Jul 2023 11:29:28 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 4/4] mm/compaction: add compact_unlock_irqrestore to remove repeat code
Date:   Wed, 19 Jul 2023 19:30:01 +0800
Message-Id: <20230719113001.2023703-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230719113001.2023703-1-shikemeng@huaweicloud.com>
References: <20230719113001.2023703-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXC+mVWLdkI7bmOA--.28977S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15Aw45WrWrCr1DWr1DAwb_yoWrXryxpF
        4kGasIyr4kZFy3WF4ftr4ruFs0g34fXF47Ar4Sk3WfJa1FvF93Gw1SyFyUuFWrXryavFZ5
        WFs8Jr18AF47Z3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjI
        I2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
        3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
        WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
        cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
        Xa7sRNv31UUUUUU==
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

