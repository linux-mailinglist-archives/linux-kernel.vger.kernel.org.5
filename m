Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF178F901
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348482AbjIAHUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjIAHUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:20:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F74E7F;
        Fri,  1 Sep 2023 00:19:59 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RcTpq4lNJzNn2R;
        Fri,  1 Sep 2023 15:16:19 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 15:19:57 +0800
From:   Ze Zuo <zuoze1@huawei.com>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>, <axboe@kernel.dk>
CC:     <akpm@linux-foundation.org>, <ying.huang@intel.com>,
        <aneesh.kumar@linux.ibm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH 1/2] zram: add a parameter "node_id" for zram
Date:   Fri, 1 Sep 2023 15:19:41 +0800
Message-ID: <20230901071942.207010-2-zuoze1@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a parameter "node_id" to zram to support storing pages on specific
node_id node memory.

Now, zram memory allocation is random, however in some cases, specifying
specific nodes for memory allocation for zram may have good effects. In
addition, when memory tier is supported, demotion can be achieved not
only through page migration,  it is also possible to apply for memory by
specifying zram on low-speed device nodes, such as CXL memory devices,
and compressing pages to these devices through memory reclamation to
achieve similar effects to migration.

Signed-off-by: Ze Zuo <zuoze1@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/block/zram/zram_drv.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 06673c6ca255..692993e48e93 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -45,6 +45,8 @@ static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
 
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
+
+static int node_id = NUMA_NO_NODE;
 /*
  * Pages that compress to sizes equals or greater than this are stored
  * uncompressed in memory.
@@ -53,6 +55,28 @@ static size_t huge_class_size;
 
 static const struct block_device_operations zram_devops;
 
+static int zram_node_id_store(const char *val,
+		const struct kernel_param *kp)
+{
+	int ret, nid;
+
+	ret = kstrtoint(val, 10, &nid);
+	if (ret)
+		return ret;
+	if (nid != NUMA_NO_NODE && !node_online(nid))
+		return -EINVAL;
+	node_id = nid;
+	return 0;
+}
+
+static const struct kernel_param_ops node_id_param_ops = {
+	.set = zram_node_id_store,
+	.get = param_get_int,
+};
+
+module_param_cb(node_id, &node_id_param_ops, &node_id, 0600);
+MODULE_PARM_DESC(node_id, "The node of pre-created zram devices memory alloc");
+
 static void zram_free_page(struct zram *zram, size_t index);
 static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 			  struct bio *parent);
@@ -1233,7 +1257,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	size_t num_pages;
 
 	num_pages = disksize >> PAGE_SHIFT;
-	zram->table = vzalloc(array_size(num_pages, sizeof(*zram->table)));
+	zram->table = vzalloc_node(array_size(num_pages, sizeof(*zram->table)), node_id);
 	if (!zram->table)
 		return false;
 
-- 
2.25.1

