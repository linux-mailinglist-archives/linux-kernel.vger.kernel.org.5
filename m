Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65747BF34C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442351AbjJJGrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442303AbjJJGrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:47:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C28A7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:47:09 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S4RGD0GDHz1M92R;
        Tue, 10 Oct 2023 14:44:36 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 14:47:07 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 6/7] mm: make wp_page_reuse() and finish_mkwrite_fault() to take a folio
Date:   Tue, 10 Oct 2023 14:45:43 +0800
Message-ID: <20231010064544.4162286-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
References: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make finish_mkwrite_fault() to a static function, and convert
wp_page_reuse() and finish_mkwrite_fault() to take a folio in
preparation for page_cpupid_xchg_last() to folio conversion.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h |  1 -
 mm/memory.c        | 37 ++++++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e0bd8abae6c6..3d59455626fa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1335,7 +1335,6 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		struct page *page, unsigned int nr, unsigned long addr);
 
 vm_fault_t finish_fault(struct vm_fault *vmf);
-vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
 #endif
 
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 7566955d88e3..1a1a6a6ccd58 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3018,23 +3018,24 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
  * case, all we need to do here is to mark the page as writable and update
  * any related book-keeping.
  */
-static inline void wp_page_reuse(struct vm_fault *vmf)
+static inline void wp_page_reuse(struct vm_fault *vmf, struct folio *folio)
 	__releases(vmf->ptl)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct page *page = vmf->page;
 	pte_t entry;
 
 	VM_BUG_ON(!(vmf->flags & FAULT_FLAG_WRITE));
-	VM_BUG_ON(page && PageAnon(page) && !PageAnonExclusive(page));
+	if (folio) {
+		VM_BUG_ON(folio_test_anon(folio) &&
+			  !PageAnonExclusive(vmf->page));
 
-	/*
-	 * Clear the pages cpupid information as the existing
-	 * information potentially belongs to a now completely
-	 * unrelated process.
-	 */
-	if (page)
-		page_cpupid_xchg_last(page, (1 << LAST_CPUPID_SHIFT) - 1);
+		/*
+		 * Clear the pages cpupid information as the existing
+		 * information potentially belongs to a now completely
+		 * unrelated process.
+		 */
+		page_cpupid_xchg_last(vmf->page, (1 << LAST_CPUPID_SHIFT) - 1);
+	}
 
 	flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 	entry = pte_mkyoung(vmf->orig_pte);
@@ -3261,6 +3262,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
  *			  writeable once the page is prepared
  *
  * @vmf: structure describing the fault
+ * @folio: the folio of vmf->page
  *
  * This function handles all that is needed to finish a write page fault in a
  * shared mapping due to PTE being read-only once the mapped page is prepared.
@@ -3272,7 +3274,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
  * Return: %0 on success, %VM_FAULT_NOPAGE when PTE got changed before
  * we acquired PTE lock.
  */
-vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)
+static vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf,
+				       struct folio *folio)
 {
 	WARN_ON_ONCE(!(vmf->vma->vm_flags & VM_SHARED));
 	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address,
@@ -3288,7 +3291,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return VM_FAULT_NOPAGE;
 	}
-	wp_page_reuse(vmf);
+	wp_page_reuse(vmf, folio);
 	return 0;
 }
 
@@ -3312,9 +3315,9 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 		ret = vma->vm_ops->pfn_mkwrite(vmf);
 		if (ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE))
 			return ret;
-		return finish_mkwrite_fault(vmf);
+		return finish_mkwrite_fault(vmf, NULL);
 	}
-	wp_page_reuse(vmf);
+	wp_page_reuse(vmf, NULL);
 	return 0;
 }
 
@@ -3342,14 +3345,14 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 			folio_put(folio);
 			return tmp;
 		}
-		tmp = finish_mkwrite_fault(vmf);
+		tmp = finish_mkwrite_fault(vmf, folio);
 		if (unlikely(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE))) {
 			folio_unlock(folio);
 			folio_put(folio);
 			return tmp;
 		}
 	} else {
-		wp_page_reuse(vmf);
+		wp_page_reuse(vmf, folio);
 		folio_lock(folio);
 	}
 	ret |= fault_dirty_shared_page(vmf);
@@ -3494,7 +3497,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			return 0;
 		}
-		wp_page_reuse(vmf);
+		wp_page_reuse(vmf, folio);
 		return 0;
 	}
 	/*
-- 
2.27.0

