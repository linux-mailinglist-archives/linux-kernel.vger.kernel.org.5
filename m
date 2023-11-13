Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58E57E9FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjKMPWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjKMPWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:22:34 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D43D71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:22:31 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4STY2q1FgKzMmqw;
        Mon, 13 Nov 2023 23:17:55 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 23:22:28 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 1/6] mm: ksm: use more folio api in ksm_might_need_to_copy()
Date:   Mon, 13 Nov 2023 23:22:17 +0800
Message-ID: <20231113152222.3495908-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231113152222.3495908-1-wangkefeng.wang@huawei.com>
References: <20231113152222.3495908-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Since ksm only support normal page, no swapout/in for ksm large
folio too, add large folio check in ksm_might_need_to_copy(),
also convert page->index to folio->index as page->index is going away.

Then convert ksm_might_need_to_copy() to use more folio api to save
nine compound_head() calls, short 'address' to reduce max-line-length.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/ksm.h |  4 ++--
 mm/ksm.c            | 39 +++++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index c2dd786a30e1..4643d5244e77 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -77,7 +77,7 @@ static inline void ksm_exit(struct mm_struct *mm)
  * but what if the vma was unmerged while the page was swapped out?
  */
 struct page *ksm_might_need_to_copy(struct page *page,
-			struct vm_area_struct *vma, unsigned long address);
+			struct vm_area_struct *vma, unsigned long addr);
 
 void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc);
 void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
@@ -130,7 +130,7 @@ static inline int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 }
 
 static inline struct page *ksm_might_need_to_copy(struct page *page,
-			struct vm_area_struct *vma, unsigned long address)
+			struct vm_area_struct *vma, unsigned long addr)
 {
 	return page;
 }
diff --git a/mm/ksm.c b/mm/ksm.c
index 7efcc68ccc6e..e9d72254e66c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2876,48 +2876,51 @@ void __ksm_exit(struct mm_struct *mm)
 }
 
 struct page *ksm_might_need_to_copy(struct page *page,
-			struct vm_area_struct *vma, unsigned long address)
+			struct vm_area_struct *vma, unsigned long addr)
 {
 	struct folio *folio = page_folio(page);
 	struct anon_vma *anon_vma = folio_anon_vma(folio);
-	struct page *new_page;
+	struct folio *new_folio;
 
-	if (PageKsm(page)) {
-		if (page_stable_node(page) &&
+	if (folio_test_large(folio))
+		return page;
+
+	if (folio_test_ksm(folio)) {
+		if (folio_stable_node(folio) &&
 		    !(ksm_run & KSM_RUN_UNMERGE))
 			return page;	/* no need to copy it */
 	} else if (!anon_vma) {
 		return page;		/* no need to copy it */
-	} else if (page->index == linear_page_index(vma, address) &&
+	} else if (folio->index == linear_page_index(vma, addr) &&
 			anon_vma->root == vma->anon_vma->root) {
 		return page;		/* still no need to copy it */
 	}
 	if (PageHWPoison(page))
 		return ERR_PTR(-EHWPOISON);
-	if (!PageUptodate(page))
+	if (!folio_test_uptodate(folio))
 		return page;		/* let do_swap_page report the error */
 
-	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
-	if (new_page &&
-	    mem_cgroup_charge(page_folio(new_page), vma->vm_mm, GFP_KERNEL)) {
-		put_page(new_page);
-		new_page = NULL;
+	new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, addr, false);
+	if (new_folio &&
+	    mem_cgroup_charge(new_folio, vma->vm_mm, GFP_KERNEL)) {
+		folio_put(new_folio);
+		new_folio = NULL;
 	}
-	if (new_page) {
-		if (copy_mc_user_highpage(new_page, page, address, vma)) {
-			put_page(new_page);
+	if (new_folio) {
+		if (copy_mc_user_highpage(&new_folio->page, page, addr, vma)) {
+			folio_put(new_folio);
 			memory_failure_queue(page_to_pfn(page), 0);
 			return ERR_PTR(-EHWPOISON);
 		}
-		SetPageDirty(new_page);
-		__SetPageUptodate(new_page);
-		__SetPageLocked(new_page);
+		folio_set_dirty(new_folio);
+		__folio_mark_uptodate(new_folio);
+		__folio_set_locked(new_folio);
 #ifdef CONFIG_SWAP
 		count_vm_event(KSM_SWPIN_COPY);
 #endif
 	}
 
-	return new_page;
+	return new_folio ? &new_folio->page : NULL;
 }
 
 void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
-- 
2.27.0

