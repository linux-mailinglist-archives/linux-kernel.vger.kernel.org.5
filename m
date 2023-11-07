Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E57E4146
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbjKGNyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjKGNxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:53:32 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B61119AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:52:56 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SPqLL4w68zMmNZ;
        Tue,  7 Nov 2023 21:48:26 +0800 (CST)
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
Subject: [PATCH 6/6] mm: memory: use folio_prealloc() in do_anonymous_page()
Date:   Tue, 7 Nov 2023 21:52:16 +0800
Message-ID: <20231107135216.415926-7-wangkefeng.wang@huawei.com>
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

Use folio_prealloc() to simplify code a bit.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1a7dc19bd35d..e4deab750a51 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4167,14 +4167,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	/* Allocate our own private page. */
 	if (unlikely(anon_vma_prepare(vma)))
-		goto oom;
-	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
+		return VM_FAULT_OOM;
+	folio = folio_prealloc(vma->vm_mm, vma, vmf->address, true);
 	if (!folio)
-		goto oom;
-
-	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
-		goto oom_free_page;
-	folio_throttle_swaprate(folio, GFP_KERNEL);
+		return VM_FAULT_OOM;
 
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
@@ -4225,10 +4221,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 release:
 	folio_put(folio);
 	goto unlock;
-oom_free_page:
-	folio_put(folio);
-oom:
-	return VM_FAULT_OOM;
 }
 
 /*
-- 
2.27.0

