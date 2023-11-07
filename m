Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D547B7E4142
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjKGNyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjKGNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:53:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026F510DA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:52:53 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SPqMp08QGzrTyk;
        Tue,  7 Nov 2023 21:49:42 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 7 Nov 2023 21:52:51 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/6] mm: ksm: use more folio api in ksm_might_need_to_copy()
Date:   Tue, 7 Nov 2023 21:52:11 +0800
Message-ID: <20231107135216.415926-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231107135216.415926-1-wangkefeng.wang@huawei.com>
References: <20231107135216.415926-1-wangkefeng.wang@huawei.com>
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

Convert ksm_might_need_to_copy() to use more folio api to save nine
compound_head() calls, short 'address' to reduce max-line-length.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/ksm.h |  4 ++--
 mm/ksm.c            | 36 ++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

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
index 7efcc68ccc6e..e5b8b677e2de 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2876,48 +2876,48 @@ void __ksm_exit(struct mm_struct *mm)
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
+	if (folio_test_ksm(folio)) {
+		if (folio_stable_node(folio) &&
 		    !(ksm_run & KSM_RUN_UNMERGE))
 			return page;	/* no need to copy it */
 	} else if (!anon_vma) {
 		return page;		/* no need to copy it */
-	} else if (page->index == linear_page_index(vma, address) &&
+	} else if (page->index == linear_page_index(vma, addr) &&
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

