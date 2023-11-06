Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DC37E2919
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjKFPuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjKFPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:50:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBBB191;
        Mon,  6 Nov 2023 07:50:02 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SPG4v34Z0zVlpd;
        Mon,  6 Nov 2023 23:49:51 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 23:50:00 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 05/10] mm: memory: use a folio in copy_nonpresent_pte()
Date:   Mon, 6 Nov 2023 23:49:45 +0800
Message-ID: <20231106154950.3399469-6-wangkefeng.wang@huawei.com>
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

Use a folio in copy_nonpresent_pte(), which is a preparetion for
converting mm counter functions to take a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1f18ed4a5497..914353d1c7f1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -779,7 +779,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	unsigned long vm_flags = dst_vma->vm_flags;
 	pte_t orig_pte = ptep_get(src_pte);
 	pte_t pte = orig_pte;
-	struct page *page;
+	struct folio *folio;
 	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 
 	if (likely(!non_swap_entry(entry))) {
@@ -801,9 +801,9 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		}
 		rss[MM_SWAPENTS]++;
 	} else if (is_migration_entry(entry)) {
-		page = pfn_swap_entry_to_page(entry);
+		folio = pfn_swap_entry_to_folio(entry);
 
-		rss[mm_counter(page)]++;
+		rss[mm_counter(&folio->page)]++;
 
 		if (!is_readable_migration_entry(entry) &&
 				is_cow_mapping(vm_flags)) {
@@ -822,8 +822,9 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
 	} else if (is_device_private_entry(entry)) {
-		page = pfn_swap_entry_to_page(entry);
+		struct page *page = pfn_swap_entry_to_page(entry);
 
+		folio = page_folio(page);
 		/*
 		 * Update rss count even for unaddressable pages, as
 		 * they should treated just like normal pages in this
@@ -833,7 +834,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * for unaddressable pages, at some point. But for now
 		 * keep things as they are.
 		 */
-		get_page(page);
+		folio_get(folio);
 		rss[mm_counter(page)]++;
 		/* Cannot fail as these pages cannot get pinned. */
 		BUG_ON(page_try_dup_anon_rmap(page, false, src_vma));
-- 
2.27.0

