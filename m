Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949317A4729
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbjIRKdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbjIRKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:33:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC18129
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:32:50 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rq1KJ5QCjz15NQJ;
        Mon, 18 Sep 2023 18:30:44 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 18:32:47 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 3/6] mm: memory: make numa_migrate_prep() to take a folio
Date:   Mon, 18 Sep 2023 18:32:10 +0800
Message-ID: <20230918103213.4166210-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230918103213.4166210-1-wangkefeng.wang@huawei.com>
References: <20230918103213.4166210-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

In preparation for large folio numa balancing, make numa_migrate_prep()
to take a folio, no functional change intended.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/huge_memory.c |  2 +-
 mm/internal.h    |  2 +-
 mm/memory.c      | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0da653080d8c..3e34a48fbdd8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1556,7 +1556,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 */
 	if (node_is_toptier(page_nid))
 		last_cpupid = page_cpupid_last(page);
-	target_nid = numa_migrate_prep(page, vma, haddr, page_nid,
+	target_nid = numa_migrate_prep(page_folio(page), vma, haddr, page_nid,
 				       &flags);
 
 	if (target_nid == NUMA_NO_NODE) {
diff --git a/mm/internal.h b/mm/internal.h
index 8c90e966e9f8..f30b81f365c1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -926,7 +926,7 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 
 void __vunmap_range_noflush(unsigned long start, unsigned long end);
 
-int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
+int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
 void free_zone_device_page(struct page *page);
diff --git a/mm/memory.c b/mm/memory.c
index a04c90604c73..ce7d9d9eddc4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4717,10 +4717,10 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
+int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags)
 {
-	get_page(page);
+	folio_get(folio);
 
 	/* Record the current PID acceesing VMA */
 	vma_set_access_pid_bit(vma);
@@ -4731,7 +4731,7 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		*flags |= TNF_FAULT_LOCAL;
 	}
 
-	return mpol_misplaced(page_folio(page), vma, addr);
+	return mpol_misplaced(folio, vma, addr);
 }
 
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
@@ -4805,8 +4805,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		last_cpupid = page_cpupid_last(page);
-	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
-			&flags);
+	target_nid = numa_migrate_prep(page_folio(page), vma, vmf->address,
+				       page_nid, &flags);
 	if (target_nid == NUMA_NO_NODE) {
 		put_page(page);
 		goto out_map;
-- 
2.27.0

