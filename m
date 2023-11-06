Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1150E7E291E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjKFPuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjKFPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:50:07 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B85191;
        Mon,  6 Nov 2023 07:50:04 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SPG0K1YGGzPnbL;
        Mon,  6 Nov 2023 23:45:53 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 23:50:01 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 06/10] mm: memory: use a folio in zap_pte_range()
Date:   Mon, 6 Nov 2023 23:49:46 +0800
Message-ID: <20231106154950.3399469-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231106154950.3399469-1-wangkefeng.wang@huawei.com>
References: <20231106154950.3399469-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make should_zap_page() to take a folio and use a folio in
zap_pte_range(), which save several compound_head() calls.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 914353d1c7f1..669f167f45cd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1359,19 +1359,20 @@ static inline bool should_zap_cows(struct zap_details *details)
 	return details->even_cows;
 }
 
-/* Decides whether we should zap this page with the page pointer specified */
-static inline bool should_zap_page(struct zap_details *details, struct page *page)
+/* Decides whether we should zap this folio with the folio pointer specified */
+static inline bool should_zap_folio(struct zap_details *details,
+				    struct folio *folio)
 {
-	/* If we can make a decision without *page.. */
+	/* If we can make a decision without *folio.. */
 	if (should_zap_cows(details))
 		return true;
 
-	/* E.g. the caller passes NULL for the case of a zero page */
-	if (!page)
+	/* E.g. the caller passes NULL for the case of a zero folio */
+	if (!folio)
 		return true;
 
-	/* Otherwise we should only zap non-anon pages */
-	return !PageAnon(page);
+	/* Otherwise we should only zap non-anon folios */
+	return !folio_test_anon(folio);
 }
 
 static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
@@ -1424,7 +1425,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	arch_enter_lazy_mmu_mode();
 	do {
 		pte_t ptent = ptep_get(pte);
-		struct page *page;
+		struct folio *folio = NULL;
 
 		if (pte_none(ptent))
 			continue;
@@ -1434,9 +1435,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 
 		if (pte_present(ptent)) {
 			unsigned int delay_rmap;
+			struct page *page;
 
 			page = vm_normal_page(vma, addr, ptent);
-			if (unlikely(!should_zap_page(details, page)))
+			if (page)
+				folio = page_folio(page);
+
+			if (unlikely(!should_zap_folio(details, folio)))
 				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
@@ -1450,16 +1455,16 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			}
 
 			delay_rmap = 0;
-			if (!PageAnon(page)) {
+			if (!folio_test_anon(folio)) {
 				if (pte_dirty(ptent)) {
-					set_page_dirty(page);
+					folio_set_dirty(folio);
 					if (tlb_delay_rmap(tlb)) {
 						delay_rmap = 1;
 						force_flush = 1;
 					}
 				}
 				if (pte_young(ptent) && likely(vma_has_recency(vma)))
-					mark_page_accessed(page);
+					folio_mark_accessed(folio);
 			}
 			rss[mm_counter(page)]--;
 			if (!delay_rmap) {
@@ -1478,9 +1483,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		entry = pte_to_swp_entry(ptent);
 		if (is_device_private_entry(entry) ||
 		    is_device_exclusive_entry(entry)) {
-			page = pfn_swap_entry_to_page(entry);
-			if (unlikely(!should_zap_page(details, page)))
+			struct page *page = pfn_swap_entry_to_page(entry);
+
+			folio = page_folio(page);
+			if (unlikely(!should_zap_folio(details, folio)))
 				continue;
+
 			/*
 			 * Both device private/exclusive mappings should only
 			 * work with anonymous page so far, so we don't need to
@@ -1491,7 +1499,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			rss[mm_counter(page)]--;
 			if (is_device_private_entry(entry))
 				page_remove_rmap(page, vma, false);
-			put_page(page);
+			folio_put(folio);
 		} else if (!non_swap_entry(entry)) {
 			/* Genuine swap entry, hence a private anon page */
 			if (!should_zap_cows(details))
@@ -1500,10 +1508,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (unlikely(!free_swap_and_cache(entry)))
 				print_bad_pte(vma, addr, ptent, NULL);
 		} else if (is_migration_entry(entry)) {
-			page = pfn_swap_entry_to_page(entry);
-			if (!should_zap_page(details, page))
+			folio = pfn_swap_entry_to_folio(entry);
+			if (!should_zap_folio(details, folio))
 				continue;
-			rss[mm_counter(page)]--;
+			rss[mm_counter(&folio->page)]--;
 		} else if (pte_marker_entry_uffd_wp(entry)) {
 			/*
 			 * For anon: always drop the marker; for file: only
-- 
2.27.0

