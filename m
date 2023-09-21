Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0AF7A9B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjIUSyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjIUSxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:53:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9DCD5123
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:41:44 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RrnQt2BRGztSwP;
        Thu, 21 Sep 2023 15:41:42 +0800 (CST)
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
Subject: [PATCH v2 3/6] mm: memory: use a folio in do_numa_page()
Date:   Thu, 21 Sep 2023 15:44:14 +0800
Message-ID: <20230921074417.24004-4-wangkefeng.wang@huawei.com>
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Numa balancing only try to migrate non-compound page in do_numa_page(),
use a folio in it to save several compound_head calls, note we use
folio_estimated_sharers(), it is enough to check the folio sharers
since only normal page is handled, if large folio numa balancing is
supported, a precise folio sharers check would be used, no functional
change intended.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index dbc7b67eca68..a05cfb6be36d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4747,8 +4747,8 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct page *page = NULL;
-	int page_nid = NUMA_NO_NODE;
+	struct folio *folio = NULL;
+	int nid = NUMA_NO_NODE;
 	bool writable = false;
 	int last_cpupid;
 	int target_nid;
@@ -4779,12 +4779,12 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	    can_change_pte_writable(vma, vmf->address, pte))
 		writable = true;
 
-	page = vm_normal_page(vma, vmf->address, pte);
-	if (!page || is_zone_device_page(page))
+	folio = vm_normal_folio(vma, vmf->address, pte);
+	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 
 	/* TODO: handle PTE-mapped THP */
-	if (PageCompound(page))
+	if (folio_test_large(folio))
 		goto out_map;
 
 	/*
@@ -4799,34 +4799,34 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		flags |= TNF_NO_GROUP;
 
 	/*
-	 * Flag if the page is shared between multiple address spaces. This
+	 * Flag if the folio is shared between multiple address spaces. This
 	 * is later used when determining whether to group tasks together
 	 */
-	if (page_mapcount(page) > 1 && (vma->vm_flags & VM_SHARED))
+	if (folio_estimated_sharers(folio) > 1 && (vma->vm_flags & VM_SHARED))
 		flags |= TNF_SHARED;
 
-	page_nid = page_to_nid(page);
+	nid = folio_nid(folio);
 	/*
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
 	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
-	    !node_is_toptier(page_nid))
+	    !node_is_toptier(nid))
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
-		last_cpupid = page_cpupid_last(page);
-	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
-			&flags);
+		last_cpupid = page_cpupid_last(&folio->page);
+	target_nid = numa_migrate_prep(&folio->page, vma, vmf->address, nid,
+				       &flags);
 	if (target_nid == NUMA_NO_NODE) {
-		put_page(page);
+		folio_put(folio);
 		goto out_map;
 	}
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	writable = false;
 
 	/* Migrate to the requested node */
-	if (migrate_misplaced_folio(page_folio(page), vma, target_nid)) {
-		page_nid = target_nid;
+	if (migrate_misplaced_folio(folio, vma, target_nid)) {
+		nid = target_nid;
 		flags |= TNF_MIGRATED;
 	} else {
 		flags |= TNF_MIGRATE_FAIL;
@@ -4842,8 +4842,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	}
 
 out:
-	if (page_nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, page_nid, 1, flags);
+	if (nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, nid, 1, flags);
 	return 0;
 out_map:
 	/*
-- 
2.27.0

