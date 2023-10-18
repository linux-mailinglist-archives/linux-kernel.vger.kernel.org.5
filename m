Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4488B7CDE75
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345013AbjJROKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344892AbjJROJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:09:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64011112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:09:12 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S9XhL5QYkz15NX8;
        Wed, 18 Oct 2023 22:06:26 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 22:09:09 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 17/19] mm: convert wp_page_reuse() and finish_mkwrite_fault() to take a folio
Date:   Wed, 18 Oct 2023 22:08:04 +0800
Message-ID: <20231018140806.2783514-18-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231018140806.2783514-1-wangkefeng.wang@huawei.com>
References: <20231018140806.2783514-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Saves one compound_head() call, also in preparation for
page_cpupid_xchg_last() conversion.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b6cc24257683..037da118f1d1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3018,7 +3018,7 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
  * case, all we need to do here is to mark the page as writable and update
  * any related book-keeping.
  */
-static inline void wp_page_reuse(struct vm_fault *vmf)
+static inline void wp_page_reuse(struct vm_fault *vmf, struct folio *folio)
 	__releases(vmf->ptl)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -3026,7 +3026,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 	pte_t entry;
 
 	VM_BUG_ON(!(vmf->flags & FAULT_FLAG_WRITE));
-	VM_BUG_ON(page && PageAnon(page) && !PageAnonExclusive(page));
+	VM_BUG_ON(folio && folio_test_anon(folio) && !PageAnonExclusive(page));
 
 	/*
 	 * Clear the pages cpupid information as the existing
@@ -3261,6 +3261,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
  *			  writeable once the page is prepared
  *
  * @vmf: structure describing the fault
+ * @folio: the folio of vmf->page
  *
  * This function handles all that is needed to finish a write page fault in a
  * shared mapping due to PTE being read-only once the mapped page is prepared.
@@ -3272,7 +3273,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
  * Return: %0 on success, %VM_FAULT_NOPAGE when PTE got changed before
  * we acquired PTE lock.
  */
-static vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)
+static vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf, struct folio *folio)
 {
 	WARN_ON_ONCE(!(vmf->vma->vm_flags & VM_SHARED));
 	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address,
@@ -3288,7 +3289,7 @@ static vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return VM_FAULT_NOPAGE;
 	}
-	wp_page_reuse(vmf);
+	wp_page_reuse(vmf, folio);
 	return 0;
 }
 
@@ -3312,9 +3313,9 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
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
 
@@ -3342,14 +3343,14 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
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
@@ -3494,7 +3495,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
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

