Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC0C7AA2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjIUVeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjIUV3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:29:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F523C30
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:11:53 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RrnSL6bjnzVl9m;
        Thu, 21 Sep 2023 15:42:58 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 21 Sep 2023 15:45:57 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 4/6] mm: memory: make numa_migrate_prep() to take a folio
Date:   Thu, 21 Sep 2023 15:44:15 +0800
Message-ID: <20230921074417.24004-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230921074417.24004-1-wangkefeng.wang@huawei.com>
References: <20230921074417.24004-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for large folio numa balancing, make numa_migrate_prep()
to take a folio, no functional change intended.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/huge_memory.c | 2 +-
 mm/internal.h    | 2 +-
 mm/memory.c      | 9 ++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 53472e34a761..0f93a73115f7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1556,7 +1556,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 */
 	if (node_is_toptier(nid))
 		last_cpupid = page_cpupid_last(&folio->page);
-	target_nid = numa_migrate_prep(&folio->page, vma, haddr, nid, &flags);
+	target_nid = numa_migrate_prep(folio, vma, haddr, nid, &flags);
 	if (target_nid == NUMA_NO_NODE) {
 		folio_put(folio);
 		goto out_map;
diff --git a/mm/internal.h b/mm/internal.h
index 7a961d12b088..d7916f1e9e98 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -984,7 +984,7 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 
 void __vunmap_range_noflush(unsigned long start, unsigned long end);
 
-int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
+int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
 void free_zone_device_page(struct page *page);
diff --git a/mm/memory.c b/mm/memory.c
index a05cfb6be36d..93ce8bcbe9d7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4727,10 +4727,10 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
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
@@ -4741,7 +4741,7 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		*flags |= TNF_FAULT_LOCAL;
 	}
 
-	return mpol_misplaced(page, vma, addr);
+	return mpol_misplaced(&folio->page, vma, addr);
 }
 
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
@@ -4815,8 +4815,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		last_cpupid = page_cpupid_last(&folio->page);
-	target_nid = numa_migrate_prep(&folio->page, vma, vmf->address, nid,
-				       &flags);
+	target_nid = numa_migrate_prep(folio, vma, vmf->address, nid, &flags);
 	if (target_nid == NUMA_NO_NODE) {
 		folio_put(folio);
 		goto out_map;
-- 
2.27.0

