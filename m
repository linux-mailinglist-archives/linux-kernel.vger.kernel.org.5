Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264B68128AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443286AbjLNHB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjLNHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:01:20 -0500
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF64E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:01:26 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SrN5g0gYQz29fy0;
        Thu, 14 Dec 2023 14:40:39 +0800 (CST)
Received: from kwepemm000003.china.huawei.com (unknown [7.193.23.66])
        by mail.maildlp.com (Postfix) with ESMTPS id 5007C1A0190;
        Thu, 14 Dec 2023 14:41:47 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm000003.china.huawei.com
 (7.193.23.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 14:41:46 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mike.kravetz@oracle.com>, <muchun.song@linux.dev>,
        <akpm@linux-foundation.org>, <anshuman.khandual@arm.com>
CC:     <willy@infradead.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 1/3] mm: HVO: introduce helper function to update and flush pgtable
Date:   Thu, 14 Dec 2023 15:39:10 +0800
Message-ID: <20231214073912.1938330-2-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214073912.1938330-1-sunnanyong@huawei.com>
References: <20231214073912.1938330-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pmd/pte update and tlb flush helper function to update page
table. This refactoring patch is designed to facilitate each
architecture to implement its own special logic in preparation
for the arm64 architecture to follow the necessary break-before-make
sequence when updating page tables.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 mm/hugetlb_vmemmap.c | 55 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 87818ee7f01d..49e8b351def3 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -45,6 +45,37 @@ struct vmemmap_remap_walk {
 	unsigned long		flags;
 };
 
+#ifndef vmemmap_update_pmd
+static inline void vmemmap_update_pmd(unsigned long start,
+				      pmd_t *pmd, pte_t *pgtable)
+{
+	pmd_populate_kernel(&init_mm, pmd, pgtable);
+}
+#endif
+
+#ifndef vmemmap_update_pte
+static inline void vmemmap_update_pte(unsigned long addr,
+				      pte_t *pte, pte_t entry)
+{
+	set_pte_at(&init_mm, addr, pte, entry);
+}
+#endif
+
+#ifndef flush_tlb_vmemmap_all
+static inline void flush_tlb_vmemmap_all(void)
+{
+	flush_tlb_all();
+}
+#endif
+
+#ifndef flush_tlb_vmemmap_range
+static inline void flush_tlb_vmemmap_range(unsigned long start,
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
+			flush_tlb_vmemmap_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
 	}
@@ -217,7 +248,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 	} while (pgd++, addr = next, addr != end);
 
 	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
-		flush_tlb_kernel_range(start, end);
+		flush_tlb_vmemmap_range(start, end);
 
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
+		flush_tlb_vmemmap_all();
 	if (!ret)
 		ret = restored;
 	return ret;
@@ -744,7 +775,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			break;
 	}
 
-	flush_tlb_all();
+	flush_tlb_vmemmap_all();
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize_folio(h, folio,
@@ -760,7 +791,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 		 * allowing more vmemmap remaps to occur.
 		 */
 		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
-			flush_tlb_all();
+			flush_tlb_vmemmap_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
 			__hugetlb_vmemmap_optimize_folio(h, folio,
@@ -769,7 +800,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 		}
 	}
 
-	flush_tlb_all();
+	flush_tlb_vmemmap_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-- 
2.25.1

