Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24DB7E4143
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjKGNyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjKGNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:53:31 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23B319AB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:52:55 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SPqRG3sZ3zVlwY;
        Tue,  7 Nov 2023 21:52:42 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 7 Nov 2023 21:52:53 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 5/6] mm: memory: use folio_prealloc() in wp_page_copy()
Date:   Tue, 7 Nov 2023 21:52:15 +0800
Message-ID: <20231107135216.415926-6-wangkefeng.wang@huawei.com>
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

Use folio_prealloc() helper to simplify code a bit.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5ecee3eac29d..1a7dc19bd35d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3109,6 +3109,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	int page_copied = 0;
 	struct mmu_notifier_range range;
 	vm_fault_t ret;
+	bool pfn_is_zero;
 
 	delayacct_wpcopy_start();
 
@@ -3118,16 +3119,13 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	if (unlikely(ret))
 		goto out;
 
-	if (is_zero_pfn(pte_pfn(vmf->orig_pte))) {
-		new_folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
-		if (!new_folio)
-			goto oom;
-	} else {
+	pfn_is_zero = is_zero_pfn(pte_pfn(vmf->orig_pte));
+	new_folio = folio_prealloc(mm, vma, vmf->address, pfn_is_zero);
+	if (!new_folio)
+		goto oom;
+
+	if (!pfn_is_zero) {
 		int err;
-		new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
-				vmf->address, false);
-		if (!new_folio)
-			goto oom;
 
 		err = __wp_page_copy_user(&new_folio->page, vmf->page, vmf);
 		if (err) {
@@ -3148,10 +3146,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		kmsan_copy_page_meta(&new_folio->page, vmf->page);
 	}
 
-	if (mem_cgroup_charge(new_folio, mm, GFP_KERNEL))
-		goto oom_free_new;
-	folio_throttle_swaprate(new_folio, GFP_KERNEL);
-
 	__folio_mark_uptodate(new_folio);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
@@ -3250,8 +3244,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 
 	delayacct_wpcopy_end();
 	return 0;
-oom_free_new:
-	folio_put(new_folio);
 oom:
 	ret = VM_FAULT_OOM;
 out:
-- 
2.27.0

