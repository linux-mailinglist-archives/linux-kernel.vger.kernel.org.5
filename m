Return-Path: <linux-kernel+bounces-25216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F482CA94
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565C81C2235C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 08:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9697F1;
	Sat, 13 Jan 2024 08:48:21 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96238384
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TBsV64Wj5z1Q7CJ;
	Sat, 13 Jan 2024 16:47:26 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id C49BF1402E2;
	Sat, 13 Jan 2024 16:48:14 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 13 Jan
 2024 16:48:13 +0800
From: Nanyong Sun <sunnanyong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mike.kravetz@oracle.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>,
	<anshuman.khandual@arm.com>
CC: <willy@infradead.org>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v3 1/3] mm: HVO: introduce helper function to update and flush pgtable
Date: Sat, 13 Jan 2024 17:44:34 +0800
Message-ID: <20240113094436.2506396-2-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240113094436.2506396-1-sunnanyong@huawei.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)

Add pmd/pte update and tlb flush helper function to update page
table. This refactoring patch is designed to facilitate each
architecture to implement its own special logic in preparation
for the arm64 architecture to follow the necessary break-before-make
sequence when updating page tables.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 55 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index da177e49d956..f1f5702bce4f 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -46,6 +46,37 @@ struct vmemmap_remap_walk {
 	unsigned long		flags;
 };
 
+#ifndef vmemmap_update_pmd
+static inline void vmemmap_update_pmd(unsigned long addr,
+				      pmd_t *pmdp, pte_t *ptep)
+{
+	pmd_populate_kernel(&init_mm, pmdp, ptep);
+}
+#endif
+
+#ifndef vmemmap_update_pte
+static inline void vmemmap_update_pte(unsigned long addr,
+				      pte_t *ptep, pte_t pte)
+{
+	set_pte_at(&init_mm, addr, ptep, pte);
+}
+#endif
+
+#ifndef vmemmap_flush_tlb_all
+static inline void vmemmap_flush_tlb_all(void)
+{
+	flush_tlb_all();
+}
+#endif
+
+#ifndef vmemmap_flush_tlb_range
+static inline void vmemmap_flush_tlb_range(unsigned long start,
+					   unsigned long end)
+{
+	flush_tlb_kernel_range(start, end);
+}
+#endif
+
 static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 			     struct vmemmap_remap_walk *walk)
 {
@@ -81,9 +112,9 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
-		pmd_populate_kernel(&init_mm, pmd, pgtable);
+		vmemmap_update_pmd(start, pmd, pgtable);
 		if (!(walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH))
-			flush_tlb_kernel_range(start, start + PMD_SIZE);
+			vmemmap_flush_tlb_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
 	}
@@ -171,7 +202,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 		return ret;
 
 	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
-		flush_tlb_kernel_range(start, end);
+		vmemmap_flush_tlb_range(start, end);
 
 	return 0;
 }
@@ -217,15 +248,15 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 
 		/*
 		 * Makes sure that preceding stores to the page contents from
-		 * vmemmap_remap_free() become visible before the set_pte_at()
-		 * write.
+		 * vmemmap_remap_free() become visible before the
+		 * vmemmap_update_pte() write.
 		 */
 		smp_wmb();
 	}
 
 	entry = mk_pte(walk->reuse_page, pgprot);
 	list_add(&page->lru, walk->vmemmap_pages);
-	set_pte_at(&init_mm, addr, pte, entry);
+	vmemmap_update_pte(addr, pte, entry);
 }
 
 /*
@@ -264,10 +295,10 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 
 	/*
 	 * Makes sure that preceding stores to the page contents become visible
-	 * before the set_pte_at() write.
+	 * before the vmemmap_update_pte() write.
 	 */
 	smp_wmb();
-	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
+	vmemmap_update_pte(addr, pte, mk_pte(page, pgprot));
 }
 
 /**
@@ -519,7 +550,7 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	}
 
 	if (restored)
-		flush_tlb_all();
+		vmemmap_flush_tlb_all();
 	if (!ret)
 		ret = restored;
 	return ret;
@@ -642,7 +673,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			break;
 	}
 
-	flush_tlb_all();
+	vmemmap_flush_tlb_all();
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
@@ -659,7 +690,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 		 * allowing more vmemmap remaps to occur.
 		 */
 		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
-			flush_tlb_all();
+			vmemmap_flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
 			__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages,
@@ -667,7 +698,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 		}
 	}
 
-	flush_tlb_all();
+	vmemmap_flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-- 
2.25.1


