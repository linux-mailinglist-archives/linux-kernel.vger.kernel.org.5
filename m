Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B87F486D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344274AbjKVOBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343965AbjKVOBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:01:06 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291B5A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:01:01 -0800 (PST)
Received: from kwepemm000020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Sb2pS07YNzMnLj;
        Wed, 22 Nov 2023 21:56:15 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm000020.china.huawei.com (7.193.23.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 22 Nov 2023 22:00:58 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <fengwei.yin@intel.com>, <ying.huang@intel.com>,
        <aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>,
        <hughd@google.com>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [RFC PATCH] mm: filemap: avoid unnecessary major faults in filemap_fault()
Date:   Wed, 22 Nov 2023 22:00:52 +0800
Message-ID: <20231122140052.4092083-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000020.china.huawei.com (7.193.23.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
in application, which leading to an unexpected performance issue[1].

This caused by temporarily cleared pte during a read/modify/write update
of the pte, eg, do_numa_page()/change_pte_range().

For the data segment of the user-mode program, the global variable area
is a private mapping. After the pagecache is loaded, the private anonymous
page is generated after the COW is triggered. Mlockall can lock COW pages
(anonymous pages), but the original file pages cannot be locked and may
be reclaimed. If the global variable (private anon page) is accessed when
vmf->pte is zeroed in numa fault, a file page fault will be triggered.

At this time, the original private file page may have been reclaimed.
If the page cache is not available at this time, a major fault will be
triggered and the file will be read, causing additional overhead.

Fix this by rechecking the pte by holding ptl in filemap_fault() before
triggering a major fault.

[1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/filemap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 71f00539ac00..bb5e6a2790dc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3226,6 +3226,20 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 			mapping_locked = true;
 		}
 	} else {
+		pte_t *ptep = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
+						  vmf->address, &vmf->ptl);
+		if (ptep) {
+			/*
+			 * Recheck pte with ptl locked as the pte can be cleared
+			 * temporarily during a read/modify/write update.
+			 */
+			if (unlikely(!pte_none(ptep_get(ptep))))
+				ret = VM_FAULT_NOPAGE;
+			pte_unmap_unlock(ptep, vmf->ptl);
+			if (unlikely(ret))
+				return ret;
+		}
+
 		/* No page in the page cache at all */
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
-- 
2.25.1

