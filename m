Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1827C7E4144
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbjKGNyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjKGNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:53:30 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61045D43
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:52:55 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SPqRG169nzVlsm;
        Tue,  7 Nov 2023 21:52:42 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 7 Nov 2023 21:52:52 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 4/6] mm: memory: use a folio in do_cow_page()
Date:   Tue, 7 Nov 2023 21:52:14 +0800
Message-ID: <20231107135216.415926-5-wangkefeng.wang@huawei.com>
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

Use folio_prealloc() helper and convert to use a folio in
do_cow_page(), which save five compound_head() calls.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 062136d25da3..5ecee3eac29d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4648,6 +4648,7 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct folio *folio;
 	vm_fault_t ret;
 
 	ret = vmf_can_call_fault(vmf);
@@ -4656,16 +4657,11 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
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
@@ -4674,7 +4670,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 		return ret;
 
 	copy_user_highpage(vmf->cow_page, vmf->page, vmf->address, vma);
-	__SetPageUptodate(vmf->cow_page);
+	__folio_mark_uptodate(folio);
 
 	ret |= finish_fault(vmf);
 	unlock_page(vmf->page);
@@ -4683,7 +4679,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 		goto uncharge_out;
 	return ret;
 uncharge_out:
-	put_page(vmf->cow_page);
+	folio_put(folio);
 	return ret;
 }
 
-- 
2.27.0

