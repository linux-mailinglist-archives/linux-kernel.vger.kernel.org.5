Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122617CDE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbjJROJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbjJROJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:09:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C823E11A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:09:12 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9XhL4X7YzrTQF;
        Wed, 18 Oct 2023 22:06:26 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 22:09:09 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 18/19] mm: use folio_xchg_last_cpupid() in wp_page_reuse()
Date:   Wed, 18 Oct 2023 22:08:05 +0800
Message-ID: <20231018140806.2783514-19-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231018140806.2783514-1-wangkefeng.wang@huawei.com>
References: <20231018140806.2783514-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Convert to use folio_xchg_last_cpupid() in wp_page_reuse(), and remove
page variable. Since now only normal and PMD-mapped page is handled by
numa balancing, it's enough to only update the entire folio's last cpupid.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 037da118f1d1..4f0dfbd5e4bf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3022,19 +3022,20 @@ static inline void wp_page_reuse(struct vm_fault *vmf, struct folio *folio)
 	__releases(vmf->ptl)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct page *page = vmf->page;
 	pte_t entry;
 
 	VM_BUG_ON(!(vmf->flags & FAULT_FLAG_WRITE));
-	VM_BUG_ON(folio && folio_test_anon(folio) && !PageAnonExclusive(page));
 
-	/*
-	 * Clear the pages cpupid information as the existing
-	 * information potentially belongs to a now completely
-	 * unrelated process.
-	 */
-	if (page)
-		page_cpupid_xchg_last(page, (1 << LAST_CPUPID_SHIFT) - 1);
+	if (folio) {
+		VM_BUG_ON(folio_test_anon(folio) &&
+			  !PageAnonExclusive(vmf->page));
+		/*
+		 * Clear the folio's cpupid information as the existing
+		 * information potentially belongs to a now completely
+		 * unrelated process.
+		 */
+		folio_xchg_last_cpupid(folio, (1 << LAST_CPUPID_SHIFT) - 1);
+	}
 
 	flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 	entry = pte_mkyoung(vmf->orig_pte);
-- 
2.27.0

