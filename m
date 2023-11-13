Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E2C7E9FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjKMPWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjKMPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:22:35 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3725ED67
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:22:32 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4STY7k1Wz4zWh55;
        Mon, 13 Nov 2023 23:22:10 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 23:22:30 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 4/6] mm: memory: use a folio in do_cow_page()
Date:   Mon, 13 Nov 2023 23:22:20 +0800
Message-ID: <20231113152222.3495908-5-wangkefeng.wang@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use folio_prealloc() helper and convert to use a folio in
do_cow_page(), which save five compound_head() calls.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d85df1c59f52..f350ab2a324f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4653,6 +4653,7 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct folio *folio;
 	vm_fault_t ret;
 
 	ret = vmf_can_call_fault(vmf);
@@ -4661,16 +4662,11 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	if (ret)
 		return ret;
 
-	vmf->cow_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vmf->address);
-	if (!vmf->cow_page)
+	folio = folio_prealloc(vma->vm_mm, vma, vmf->address, false);
+	if (!folio)
 		return VM_FAULT_OOM;
 
-	if (mem_cgroup_charge(page_folio(vmf->cow_page), vma->vm_mm,
-				GFP_KERNEL)) {
-		put_page(vmf->cow_page);
-		return VM_FAULT_OOM;
-	}
-	folio_throttle_swaprate(page_folio(vmf->cow_page), GFP_KERNEL);
+	vmf->cow_page = &folio->page;
 
 	ret = __do_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
@@ -4679,7 +4675,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 		return ret;
 
 	copy_user_highpage(vmf->cow_page, vmf->page, vmf->address, vma);
-	__SetPageUptodate(vmf->cow_page);
+	__folio_mark_uptodate(folio);
 
 	ret |= finish_fault(vmf);
 	unlock_page(vmf->page);
@@ -4688,7 +4684,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 		goto uncharge_out;
 	return ret;
 uncharge_out:
-	put_page(vmf->cow_page);
+	folio_put(folio);
 	return ret;
 }
 
-- 
2.27.0

