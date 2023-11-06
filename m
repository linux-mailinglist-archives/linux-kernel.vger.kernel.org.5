Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02357E291A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjKFPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjKFPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:50:05 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9CFD51;
        Mon,  6 Nov 2023 07:50:02 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SPG1S1t8Mz1P7vj;
        Mon,  6 Nov 2023 23:46:52 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 23:49:59 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 03/10] mm: huge_memory: use a folio in __split_huge_pmd_locked()
Date:   Mon, 6 Nov 2023 23:49:43 +0800
Message-ID: <20231106154950.3399469-4-wangkefeng.wang@huawei.com>
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a folio in __split_huge_pmd_locked() which replaces five
compound_head() call with two page_folio() calls.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/huge_memory.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f31f02472396..34dd01970927 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2117,6 +2117,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	count_vm_event(THP_SPLIT_PMD);
 
 	if (!vma_is_anonymous(vma)) {
+		struct folio *folio;
 		old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
 		/*
 		 * We are going to unmap this huge page. So
@@ -2130,17 +2131,17 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			swp_entry_t entry;
 
 			entry = pmd_to_swp_entry(old_pmd);
-			page = pfn_swap_entry_to_page(entry);
+			folio = pfn_swap_entry_to_folio(entry);
 		} else {
-			page = pmd_page(old_pmd);
-			if (!PageDirty(page) && pmd_dirty(old_pmd))
-				set_page_dirty(page);
-			if (!PageReferenced(page) && pmd_young(old_pmd))
-				SetPageReferenced(page);
-			page_remove_rmap(page, vma, true);
-			put_page(page);
+			folio = page_folio(pmd_page(old_pmd));
+			if (!folio_test_dirty(folio) && pmd_dirty(old_pmd))
+				folio_set_dirty(folio);
+			if (!folio_test_referenced(folio) && pmd_young(old_pmd))
+				folio_set_referenced(folio);
+			page_remove_rmap(&folio->page, vma, true);
+			folio_put(folio);
 		}
-		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
+		add_mm_counter(mm, mm_counter_file(&folio->page), -HPAGE_PMD_NR);
 		return;
 	}
 
-- 
2.27.0

