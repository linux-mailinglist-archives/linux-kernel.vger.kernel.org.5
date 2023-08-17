Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB6B77F2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349237AbjHQJCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243382AbjHQJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:02:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232D82684
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:02:33 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRJrh2t6MzrRrF;
        Thu, 17 Aug 2023 17:01:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 17:02:30 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <james.clark@arm.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH 2/2] coresight: core: fix memory leak in dict->fwnode_list
Date:   Thu, 17 Aug 2023 16:59:37 +0800
Message-ID: <20230817085937.55590-3-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230817085937.55590-1-hejunhao3@huawei.com>
References: <20230817085937.55590-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are memory leaks reported by kmemleak:
...
unreferenced object 0xffff2020103c3200 (size 256):
  comm "insmod", pid 4476, jiffies 4294978252 (age 50072.536s)
  hex dump (first 32 bytes):
    10 60 40 06 28 20 ff ff 10 c0 59 06 20 20 ff ff  .`@.( ....Y.  ..
    10 e0 47 06 28 20 ff ff 10 00 49 06 28 20 ff ff  ..G.( ....I.( ..
  backtrace:
    [<0000000034ec4724>] __kmem_cache_alloc_node+0x2f8/0x348
    [<0000000057fbc15d>] __kmalloc_node_track_caller+0x5c/0x110
    [<00000055d5e34b>] krealloc+0x8c/0x178
    [<00000000a4635beb>] coresight_alloc_device_name+0x128/0x188 [coresight]
    [<00000000a92ddfee>] funnel_cs_ops+0x10/0xfffffffffffedaa0 [coresight_funnel]
    [<00000000449e20f8>] dynamic_funnel_ids+0x80/0xfffffffffffed840 [coresight_funnel]
...

when remove driver, the golab variables defined by the macro
DEFINE_CORESIGHT_DEVLIST will be released, dict->nr_idx and
dict->fwnode_list are cleared to 0. The lifetime of the golab
variable has ended. So the buffer pointer is lost.

Use the callback of devm_add_action_or_reset() to free memory.

Fixes: 0f5f9b6ba9e1 ("coresight: Use platform agnostic names")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 9fabe00a40d6..6849faad697d 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1756,6 +1756,20 @@ bool coresight_loses_context_with_cpu(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(coresight_loses_context_with_cpu);
 
+void coresight_release_dev_list(void *data)
+{
+	struct coresight_dev_list *dict = data;
+
+	mutex_lock(&coresight_mutex);
+
+	if (dict->nr_idx) {
+		kfree(dict->fwnode_list);
+		dict->nr_idx = 0;
+	}
+
+	mutex_unlock(&coresight_mutex);
+}
+
 /*
  * coresight_alloc_device_name - Get an index for a given device in the
  * device index list specific to a driver. An index is allocated for a
@@ -1766,12 +1780,16 @@ EXPORT_SYMBOL_GPL(coresight_loses_context_with_cpu);
 char *coresight_alloc_device_name(struct coresight_dev_list *dict,
 				  struct device *dev)
 {
-	int idx;
+	int idx, ret;
 	char *name = NULL;
 	struct fwnode_handle **list;
 
 	mutex_lock(&coresight_mutex);
 
+	ret = devm_add_action_or_reset(dev, coresight_release_dev_list, dict);
+	if (ret)
+		goto done;
+
 	idx = coresight_search_device_idx(dict, dev_fwnode(dev));
 	if (idx < 0) {
 		/* Make space for the new entry */
-- 
2.33.0

