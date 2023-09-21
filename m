Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CD37A9AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjIUSva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjIUSvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:51:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10571D5109
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:41:44 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RrnQv46tyztSwc;
        Thu, 21 Sep 2023 15:41:43 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 21 Sep 2023 15:45:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 5/6] mm: mempolicy: make mpol_misplaced() to take a folio
Date:   Thu, 21 Sep 2023 15:44:16 +0800
Message-ID: <20230921074417.24004-6-wangkefeng.wang@huawei.com>
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

In preparation for large folio numa balancing, make mpol_misplaced()
to take a folio, no functional change intended.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mempolicy.h |  5 +++--
 mm/memory.c               |  2 +-
 mm/mempolicy.c            | 22 ++++++++++++----------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index d232de7cdc56..6c2754d7bfed 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -174,7 +174,7 @@ extern void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol);
 /* Check if a vma is migratable */
 extern bool vma_migratable(struct vm_area_struct *vma);
 
-extern int mpol_misplaced(struct page *, struct vm_area_struct *, unsigned long);
+int mpol_misplaced(struct folio *, struct vm_area_struct *, unsigned long);
 extern void mpol_put_task_policy(struct task_struct *);
 
 static inline bool mpol_is_preferred_many(struct mempolicy *pol)
@@ -278,7 +278,8 @@ static inline int mpol_parse_str(char *str, struct mempolicy **mpol)
 }
 #endif
 
-static inline int mpol_misplaced(struct page *page, struct vm_area_struct *vma,
+static inline int mpol_misplaced(struct folio *folio,
+				 struct vm_area_struct *vma,
 				 unsigned long address)
 {
 	return -1; /* no node preference */
diff --git a/mm/memory.c b/mm/memory.c
index 93ce8bcbe9d7..29c5618c91e5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4741,7 +4741,7 @@ int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
 		*flags |= TNF_FAULT_LOCAL;
 	}
 
-	return mpol_misplaced(&folio->page, vma, addr);
+	return mpol_misplaced(folio, vma, addr);
 }
 
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 98fae2bfc851..ecf06ce3a5dd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2572,24 +2572,25 @@ static void sp_free(struct sp_node *n)
 }
 
 /**
- * mpol_misplaced - check whether current page node is valid in policy
+ * mpol_misplaced - check whether current folio node is valid in policy
  *
- * @page: page to be checked
- * @vma: vm area where page mapped
- * @addr: virtual address where page mapped
+ * @folio: folio to be checked
+ * @vma: vm area where folio mapped
+ * @addr: virtual address in @vma for shared policy lookup and interleave policy
  *
- * Lookup current policy node id for vma,addr and "compare to" page's
+ * Lookup current policy node id for vma,addr and "compare to" folio's
  * node id.  Policy determination "mimics" alloc_page_vma().
  * Called from fault path where we know the vma and faulting address.
  *
  * Return: NUMA_NO_NODE if the page is in a node that is valid for this
- * policy, or a suitable node ID to allocate a replacement page from.
+ * policy, or a suitable node ID to allocate a replacement folio from.
  */
-int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long addr)
+int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
+		   unsigned long addr)
 {
 	struct mempolicy *pol;
 	struct zoneref *z;
-	int curnid = page_to_nid(page);
+	int curnid = folio_nid(folio);
 	unsigned long pgoff;
 	int thiscpu = raw_smp_processor_id();
 	int thisnid = cpu_to_node(thiscpu);
@@ -2645,11 +2646,12 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		BUG();
 	}
 
-	/* Migrate the page towards the node whose CPU is referencing it */
+	/* Migrate the folio towards the node whose CPU is referencing it */
 	if (pol->flags & MPOL_F_MORON) {
 		polnid = thisnid;
 
-		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
+		if (!should_numa_migrate_memory(current, &folio->page, curnid,
+						thiscpu))
 			goto out;
 	}
 
-- 
2.27.0

