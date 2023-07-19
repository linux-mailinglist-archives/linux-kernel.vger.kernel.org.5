Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4867D758C20
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjGSDbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGSDbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:31:20 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCA33C1F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:29:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R5LsK3YDrz4f3jXN
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:29:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAXC+mVWLdkI7bmOA--.28977S4;
        Wed, 19 Jul 2023 11:29:27 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 2/4] mm/compaction: use "spinlock_t *" to record held lock in isolate_migratepages_block
Date:   Wed, 19 Jul 2023 19:29:59 +0800
Message-Id: <20230719113001.2023703-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230719113001.2023703-1-shikemeng@huaweicloud.com>
References: <20230719113001.2023703-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXC+mVWLdkI7bmOA--.28977S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGryUGFWDKw13JFyDuF4rKrg_yoW5ury8pF
        ykCasIkr4kua4agF1aqrs5uFsIg34fJF47Ar43K3WfXF4ftF9rGw1IyFyUurWrZr13AFZ5
        CFs8Ka4kAa12v3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRsXo7UUUUU
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

Use "spinlock_t *" instead of "struct lruvec *" to record held lock in
isolate_migratepages_block.
This is a preparation to use compact_unlock_should_abort in
isolate_migratepages_block to remove repeat code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index dfef14d3ef78..638146a49e89 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -840,7 +840,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	unsigned long nr_scanned = 0, nr_isolated = 0;
 	struct lruvec *lruvec;
 	unsigned long flags = 0;
-	struct lruvec *locked = NULL;
+	spinlock_t *locked = NULL;
 	struct folio *folio = NULL;
 	struct page *page = NULL, *valid_page = NULL;
 	struct address_space *mapping;
@@ -911,7 +911,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 */
 		if (!(low_pfn % COMPACT_CLUSTER_MAX)) {
 			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
+				spin_unlock_irqrestore(locked, flags);
 				locked = NULL;
 			}
 
@@ -946,7 +946,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 		if (PageHuge(page) && cc->alloc_contig) {
 			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
+				spin_unlock_irqrestore(locked, flags);
 				locked = NULL;
 			}
 
@@ -1035,7 +1035,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			if (unlikely(__PageMovable(page)) &&
 					!PageIsolated(page)) {
 				if (locked) {
-					unlock_page_lruvec_irqrestore(locked, flags);
+					spin_unlock_irqrestore(locked, flags);
 					locked = NULL;
 				}
 
@@ -1120,12 +1120,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		lruvec = folio_lruvec(folio);
 
 		/* If we already hold the lock, we can skip some rechecking */
-		if (lruvec != locked) {
+		if (&lruvec->lru_lock != locked) {
 			if (locked)
-				unlock_page_lruvec_irqrestore(locked, flags);
+				spin_unlock_irqrestore(locked, flags);
 
-			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
-			locked = lruvec;
+			locked = compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
 
 			lruvec_memcg_debug(lruvec, folio);
 
@@ -1188,7 +1187,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 isolate_fail_put:
 		/* Avoid potential deadlock in freeing page under lru_lock */
 		if (locked) {
-			unlock_page_lruvec_irqrestore(locked, flags);
+			spin_unlock_irqrestore(locked, flags);
 			locked = NULL;
 		}
 		folio_put(folio);
@@ -1204,7 +1203,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 */
 		if (nr_isolated) {
 			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
+				spin_unlock_irqrestore(locked, flags);
 				locked = NULL;
 			}
 			putback_movable_pages(&cc->migratepages);
@@ -1236,7 +1235,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 isolate_abort:
 	if (locked)
-		unlock_page_lruvec_irqrestore(locked, flags);
+		spin_unlock_irqrestore(locked, flags);
 	if (folio) {
 		folio_set_lru(folio);
 		folio_put(folio);
-- 
2.30.0

