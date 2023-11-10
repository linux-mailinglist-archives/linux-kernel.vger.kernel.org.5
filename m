Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D17E7808
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbjKJDeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345805AbjKJDdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:33:54 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D354682
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 19:33:52 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SRPYW5dvJzWhCv;
        Fri, 10 Nov 2023 11:33:35 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 11:33:50 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 6/7] mm: task_mmu: use a folio in clear_refs_pte_range()
Date:   Fri, 10 Nov 2023 11:33:23 +0800
Message-ID: <20231110033324.2455523-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a folio to save two compound_head() calls in clear_refs_pte_range().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/proc/task_mmu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fe15f99a4908..740d5c4fa33c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1161,7 +1161,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *pte, ptent;
 	spinlock_t *ptl;
-	struct page *page;
+	struct folio *folio;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -1173,12 +1173,12 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!pmd_present(*pmd))
 			goto out;
 
-		page = pmd_page(*pmd);
+		folio = page_folio(pmd_page(*pmd));
 
 		/* Clear accessed and referenced bits. */
 		pmdp_test_and_clear_young(vma, addr, pmd);
-		test_and_clear_page_young(page);
-		ClearPageReferenced(page);
+		folio_test_clear_young(folio);
+		folio_clear_referenced(folio);
 out:
 		spin_unlock(ptl);
 		return 0;
@@ -1200,14 +1200,14 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!pte_present(ptent))
 			continue;
 
-		page = vm_normal_page(vma, addr, ptent);
-		if (!page)
+		folio = vm_normal_folio(vma, addr, ptent);
+		if (!folio)
 			continue;
 
 		/* Clear accessed and referenced bits. */
 		ptep_test_and_clear_young(vma, addr, pte);
-		test_and_clear_page_young(page);
-		ClearPageReferenced(page);
+		folio_test_clear_young(folio);
+		folio_clear_referenced(folio);
 	}
 	pte_unmap_unlock(pte - 1, ptl);
 	cond_resched();
-- 
2.27.0

