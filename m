Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A17AE31B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjIZAxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjIZAxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:53:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1470CD6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:53:13 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rvh2B6SqZztT0Z;
        Tue, 26 Sep 2023 08:48:50 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 08:53:10 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 6/9] mm: make wp_page_reuse() and finish_mkwrite_fault() to take a folio
Date:   Tue, 26 Sep 2023 08:52:51 +0800
Message-ID: <20230926005254.2861577-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
References: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index aa7fdda1b56c..9933f6345e66 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1335,7 +1335,6 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		struct page *page, unsigned int nr, unsigned long addr);
 
 vm_fault_t finish_fault(struct vm_fault *vmf);
-vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
 #endif
 
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 5ab6e8d45a7d..119c40e4465e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3014,23 +3014,24 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
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
@@ -3223,6 +3224,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
  *			  writeable once the page is prepared
  *
  * @vmf: structure describing the fault
+ * @folio: the folio of vmf->page
  *
  * This function handles all that is needed to finish a write page fault in a
  * shared mapping due to PTE being read-only once the mapped page is prepared.
@@ -3234,7 +3236,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
  * Return: %0 on success, %VM_FAULT_NOPAGE when PTE got changed before
  * we acquired PTE lock.
  */
-vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)
+static vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf,
+				       struct folio *folio)
 {
 	WARN_ON_ONCE(!(vmf->vma->vm_flags & VM_SHARED));
 	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address,
@@ -3250,7 +3253,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return VM_FAULT_NOPAGE;
 	}
-	wp_page_reuse(vmf);
+	wp_page_reuse(vmf, folio);
 	return 0;
 }
 
@@ -3275,9 +3278,9 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
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
 
@@ -3305,14 +3308,14 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
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
@@ -3436,7 +3439,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			return 0;
 		}
-		wp_page_reuse(vmf);
+		wp_page_reuse(vmf, folio);
 		return 0;
 	}
 copy:
-- 
2.27.0

