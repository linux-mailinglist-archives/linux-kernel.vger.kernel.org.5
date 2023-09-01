Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7A478F904
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348494AbjIAHUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348489AbjIAHUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:20:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D05E7F;
        Fri,  1 Sep 2023 00:20:04 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RcTpb6h5vzhZHN;
        Fri,  1 Sep 2023 15:16:07 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 15:20:00 +0800
From:   Ze Zuo <zuoze1@huawei.com>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>, <axboe@kernel.dk>
CC:     <akpm@linux-foundation.org>, <ying.huang@intel.com>,
        <aneesh.kumar@linux.ibm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH 2/2] zram: take the benefit of kvzalloc_node
Date:   Fri, 1 Sep 2023 15:19:42 +0800
Message-ID: <20230901071942.207010-3-zuoze1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230901071942.207010-1-zuoze1@huawei.com>
References: <20230901071942.207010-1-zuoze1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500002.china.huawei.com (7.221.188.171)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using kvzalloc and zram can benefit from huge page table mapping, so lets
use kvzalloc_node/kvfree instead of vzalloc_node/vfree.

Signed-off-by: Ze Zuo <zuoze1@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/block/zram/zram_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 692993e48e93..97241f166324 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1249,7 +1249,7 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 		zram_free_page(zram, index);
 
 	zs_destroy_pool(zram->mem_pool);
-	vfree(zram->table);
+	kvfree(zram->table);
 }
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
@@ -1257,13 +1257,14 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	size_t num_pages;
 
 	num_pages = disksize >> PAGE_SHIFT;
-	zram->table = vzalloc_node(array_size(num_pages, sizeof(*zram->table)), node_id);
+	zram->table = kvzalloc_node(array_size(num_pages, sizeof(*zram->table)),
+				    GFP_KERNEL, node_id);
 	if (!zram->table)
 		return false;
 
 	zram->mem_pool = zs_create_pool(zram->disk->disk_name);
 	if (!zram->mem_pool) {
-		vfree(zram->table);
+		kvfree(zram->table);
 		return false;
 	}
 
-- 
2.25.1

