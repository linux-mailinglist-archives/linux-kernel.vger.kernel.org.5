Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCDE7CD7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjJRJai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjJRJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:30:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E3FF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:30:22 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S9QT12vG6zLp2r;
        Wed, 18 Oct 2023 17:26:13 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 17:30:18 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v3 2/7] bootmem: use kmemleak_free_part_phys in free_bootmem_page
Date:   Wed, 18 Oct 2023 18:29:47 +0800
Message-ID: <20231018102952.3339837-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018102952.3339837-1-liushixin2@huawei.com>
References: <20231018102952.3339837-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

