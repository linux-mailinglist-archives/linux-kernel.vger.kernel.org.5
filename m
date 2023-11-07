Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3037E4140
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjKGNy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjKGNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:53:30 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAA3D77
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:52:54 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SPqLK3Ts3zMmMX;
        Tue,  7 Nov 2023 21:48:25 +0800 (CST)
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
Subject: [PATCH 3/6] mm: memory: rename page_copy_prealloc() to folio_prealloc()
Date:   Tue, 7 Nov 2023 21:52:13 +0800
Message-ID: <20231107135216.415926-4-wangkefeng.wang@huawei.com>
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

Let's rename page_copy_prealloc() to folio_prealloc(), which could
be reused in more functons, as it maybe zero the new page, pass a
new should_zero to it, and call the vma_alloc_zeroed_movable_folio()
if need_zero is true.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b1bff4d245da..062136d25da3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -988,12 +988,17 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	return 0;
 }
 
-static inline struct folio *page_copy_prealloc(struct mm_struct *src_mm,
-		struct vm_area_struct *vma, unsigned long addr)
+static inline struct folio *folio_prealloc(struct mm_struct *src_mm,
+		struct vm_area_struct *vma, unsigned long addr, bool need_zero)
 {
 	struct folio *new_folio;
 
-	new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, addr, false);
+	if (need_zero)
+		new_folio = vma_alloc_zeroed_movable_folio(vma, addr);
+	else
+		new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
+					    addr, false);
+
 	if (!new_folio)
 		return NULL;
 
@@ -1125,7 +1130,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	} else if (ret == -EBUSY) {
 		goto out;
 	} else if (ret ==  -EAGAIN) {
-		prealloc = page_copy_prealloc(src_mm, src_vma, addr);
+		prealloc = folio_prealloc(src_mm, src_vma, addr, false);
 		if (!prealloc)
 			return -ENOMEM;
 	} else if (ret) {
-- 
2.27.0

