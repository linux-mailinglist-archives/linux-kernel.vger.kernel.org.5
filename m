Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C346799678
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 07:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbjIIFfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 01:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjIIFfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 01:35:32 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A56DFE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 22:35:28 -0700 (PDT)
X-QQ-mid: bizesmtp70t1694237669txe6uyul
Received: from wangjiexun-virtual-machine.loca ( [120.225.34.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 09 Sep 2023 13:34:21 +0800 (CST)
X-QQ-SSF: 01200000000000101000000A0000000
X-QQ-FEAT: znfcQSa1hKZrI9jdG7jfNoZKIGbSER5jLxOcs5Ol1lhcYITTz7DwmwsVa1Jna
        BeOWm4eM1+bPQOUX2LqaqIClrDbrmvoXRtCKgy11lHSwNrSpsLTUZPS2mScc4o/LHxj7OxN
        W/op9BHWM2AnGxutzJlMMqi8F2G99LKDTdzGI9XxSu4+t3wlqLbEOEcC88TlkEL5XsjXTUq
        CTHK/Hkgv5m8urKUlxiu7TQnbgTQqxussDdgcyBEZjRxFjzXcNtuNvFjPWseeKGheqtZ3sN
        HOFO51SGY4L/rPjbZnxDEDqOze5KB41BMs2fhUbLShHsYrRfleA3rFkIacUvzHRMDPz97Mj
        eKTngEiTGgjn8QoW2pRgEs/85sIn7wyKIowOg5I5GruwgAb0EduqrpDBFyyig==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2953894577725368514
From:   Jiexun Wang <wangjiexun@tinylab.org>
To:     akpm@linux-foundation.org, brauner@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, Jiexun Wang <wangjiexun@tinylab.org>
Subject: [PATCH 1/1] mm/madvise: add cond_resched() in madvise_cold_or_pageout_pte_range()
Date:   Sat,  9 Sep 2023 13:33:08 +0800
Message-Id: <95d610623363009a71024c7a473d6895f39f3caf.1694219361.git.wangjiexun@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694219361.git.wangjiexun@tinylab.org>
References: <cover.1694219361.git.wangjiexun@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the madvise_cold_or_pageout_pte_range() function exhibits 
significant latency under memory pressure, which can be effectively 
reduced by adding cond_resched() within the loop.

When the batch_count reaches SWAP_CLUSTER_MAX, we reschedule 
the task to ensure fairness and avoid long lock holding times.

Signed-off-by: Jiexun Wang <wangjiexun@tinylab.org>
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4dded5d27e7e..df760096ea85 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -31,6 +31,7 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
+#include <linux/swap.h>
 
 #include <asm/tlb.h>
 
@@ -353,6 +354,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	struct folio *folio = NULL;
 	LIST_HEAD(folio_list);
 	bool pageout_anon_only_filter;
+	unsigned int batch_count = 0;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -441,6 +443,13 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	arch_enter_lazy_mmu_mode();
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
 		ptent = ptep_get(pte);
+		
+		if (++batch_count == SWAP_CLUSTER_MAX) {
+			pte_unmap_unlock(start_pte, ptl);
+		 	cond_resched();
+		 	start_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+		 	batch_count = 0;
+		}
 
 		if (pte_none(ptent))
 			continue;
-- 
2.34.1

