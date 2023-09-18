Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2393C7A4727
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbjIRKdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241340AbjIRKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:33:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B970E12F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:32:51 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rq1KL21nhz15NQY;
        Mon, 18 Sep 2023 18:30:46 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 18:32:49 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 6/6] mm: huge_memory: use a folio in do_huge_pmd_numa_page()
Date:   Mon, 18 Sep 2023 18:32:13 +0800
Message-ID: <20230918103213.4166210-7-wangkefeng.wang@huawei.com>
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

Use a folio in do_huge_pmd_numa_page(), reduce three page_folio()
calls to one, no functional change intended.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/huge_memory.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3e34a48fbdd8..5c015ca40fea 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1517,9 +1517,9 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	pmd_t oldpmd = vmf->orig_pmd;
 	pmd_t pmd;
-	struct page *page;
+	struct folio *folio;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
-	int page_nid = NUMA_NO_NODE;
+	int nid = NUMA_NO_NODE;
 	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
 	bool migrated = false, writable = false;
 	int flags = 0;
@@ -1541,36 +1541,35 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	    can_change_pmd_writable(vma, vmf->address, pmd))
 		writable = true;
 
-	page = vm_normal_page_pmd(vma, haddr, pmd);
-	if (!page)
+	folio = vm_normal_pmd_folio(vma, haddr, pmd);
+	if (!folio)
 		goto out_map;
 
 	/* See similar comment in do_numa_page for explanation */
 	if (!writable)
 		flags |= TNF_NO_GROUP;
 
-	page_nid = page_to_nid(page);
+	nid = folio_nid(folio);
 	/*
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if (node_is_toptier(page_nid))
-		last_cpupid = page_cpupid_last(page);
-	target_nid = numa_migrate_prep(page_folio(page), vma, haddr, page_nid,
-				       &flags);
+	if (node_is_toptier(nid))
+		last_cpupid = page_cpupid_last(&folio->page);
 
+	target_nid = numa_migrate_prep(folio, vma, haddr, nid, &flags);
 	if (target_nid == NUMA_NO_NODE) {
-		put_page(page);
+		folio_put(folio);
 		goto out_map;
 	}
 
 	spin_unlock(vmf->ptl);
 	writable = false;
 
-	migrated = migrate_misplaced_folio(page_folio(page), vma, target_nid);
+	migrated = migrate_misplaced_folio(folio, vma, target_nid);
 	if (migrated) {
 		flags |= TNF_MIGRATED;
-		page_nid = target_nid;
+		nid = target_nid;
 	} else {
 		flags |= TNF_MIGRATE_FAIL;
 		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
@@ -1582,9 +1581,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	}
 
 out:
-	if (page_nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR,
-				flags);
+	if (nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
 
 	return 0;
 
-- 
2.27.0

