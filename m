Return-Path: <linux-kernel+bounces-6364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD0D8197B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728CD1F25FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2581643E;
	Wed, 20 Dec 2023 04:21:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558B156DD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sw0kF2gX3zsSDx;
	Wed, 20 Dec 2023 12:21:25 +0800 (CST)
Received: from kwepemm000003.china.huawei.com (unknown [7.193.23.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F7BB18007A;
	Wed, 20 Dec 2023 12:21:42 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm000003.china.huawei.com
 (7.193.23.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Dec
 2023 12:21:41 +0800
From: Nanyong Sun <sunnanyong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mike.kravetz@oracle.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>,
	<anshuman.khandual@arm.com>
CC: <willy@infradead.org>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v2 1/3] mm: HVO: introduce helper function to update and flush pgtable
Date: Wed, 20 Dec 2023 13:18:53 +0800
Message-ID: <20231220051855.47547-2-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220051855.47547-1-sunnanyong@huawei.com>
References: <20231220051855.47547-1-sunnanyong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000003.china.huawei.com (7.193.23.66)

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
index 87818ee7f01d..2187e5410a94 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -45,6 +45,37 @@ struct vmemmap_remap_walk {
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
 static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
 {
 	pmd_t __pmd;
@@ -87,9 +118,9 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
 
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
-		pmd_populate_kernel(&init_mm, pmd, pgtable);
+		vmemmap_update_pmd(start, pmd, pgtable);
 		if (flush)
-			flush_tlb_kernel_range(start, start + PMD_SIZE);
+			vmemmap_flush_tlb_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
 	}
@@ -217,7 +248,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 	} while (pgd++, addr = next, addr != end);
 
 	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
-		flush_tlb_kernel_range(start, end);
+		vmemmap_flush_tlb_range(start, end);
 
 	return 0;
 }
@@ -263,15 +294,15 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 
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
@@ -310,10 +341,10 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 
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
@@ -576,7 +607,7 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	}
 
 	if (restored)
-		flush_tlb_all();
+		vmemmap_flush_tlb_all();
 	if (!ret)
 		ret = restored;
 	return ret;
@@ -744,7 +775,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			break;
 	}
 
-	flush_tlb_all();
+	vmemmap_flush_tlb_all();
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize_folio(h, folio,
@@ -760,7 +791,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 		 * allowing more vmemmap remaps to occur.
 		 */
 		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
-			flush_tlb_all();
+			vmemmap_flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
 			__hugetlb_vmemmap_optimize_folio(h, folio,
@@ -769,7 +800,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 		}
 	}
 
-	flush_tlb_all();
+	vmemmap_flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-- 
2.25.1


