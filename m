Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487867BCB97
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 03:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344301AbjJHBdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 21:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjJHBdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 21:33:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2299695
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 18:33:19 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S34P42l2WzrTFk;
        Sun,  8 Oct 2023 09:30:48 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sun, 8 Oct
 2023 09:33:17 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v2 2/4] bootmem: use kmemleak_free_part_phys in free_bootmem_page
Date:   Sun, 8 Oct 2023 10:33:15 +0800
Message-ID: <20231008023317.3015699-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231008023317.3015699-1-liushixin2@huawei.com>
References: <20231008023317.3015699-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kmemleak_alloc_phys() rather than kmemleak_alloc() was called from
memblock_alloc_range_nid(), kmemleak_free_part_phys() should be used to
delete kmemleak object in free_bootmem_page(). In debug mode, there are
following warning:

 kmemleak: Partially freeing unknown object at 0xffff97345aff7000 (size 4096)

Fixes: 028725e73375 ("bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/linux/bootmem_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index e1a3c9c9754c..cffa38a73618 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -60,7 +60,7 @@ static inline void get_page_bootmem(unsigned long info, struct page *page,
 
 static inline void free_bootmem_page(struct page *page)
 {
-	kmemleak_free_part(page_to_virt(page), PAGE_SIZE);
+	kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
 	free_reserved_page(page);
 }
 #endif
-- 
2.25.1

