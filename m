Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE3A77CC79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbjHOMXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjHOMXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:23:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1327DE52;
        Tue, 15 Aug 2023 05:23:14 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQ9Lc263YztSDG;
        Tue, 15 Aug 2023 20:19:36 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 20:23:11 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v4 1/9] scsi:scsi_debug: create scsi_debug directory in the debugfs filesystem
Date:   Tue, 15 Aug 2023 20:23:08 +0800
Message-ID: <20230815122316.4129333-2-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230815122316.4129333-1-haowenchao2@huawei.com>
References: <20230815122316.4129333-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create directory scsi_debug in the root of the debugfs filesystem.
Prepare to add interface for manage error injection.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 9c0af50501f9..35c336271b13 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -41,6 +41,7 @@
 #include <linux/random.h>
 #include <linux/xarray.h>
 #include <linux/prefetch.h>
+#include <linux/debugfs.h>
 
 #include <net/checksum.h>
 
@@ -862,6 +863,8 @@ static const int device_qfull_result =
 
 static const int condition_met_result = SAM_STAT_CONDITION_MET;
 
+static struct dentry *sdebug_debugfs_root;
+
 
 /* Only do the extra work involved in logical block provisioning if one or
  * more of the lbpu, lbpws or lbpws10 parameters are given and we are doing
@@ -7011,6 +7014,8 @@ static int __init scsi_debug_init(void)
 		goto driver_unreg;
 	}
 
+	sdebug_debugfs_root = debugfs_create_dir("scsi_debug", NULL);
+
 	for (k = 0; k < hosts_to_add; k++) {
 		if (want_store && k == 0) {
 			ret = sdebug_add_host_helper(idx);
@@ -7057,6 +7062,7 @@ static void __exit scsi_debug_exit(void)
 
 	sdebug_erase_all_stores(false);
 	xa_destroy(per_store_ap);
+	debugfs_remove(sdebug_debugfs_root);
 }
 
 device_initcall(scsi_debug_init);
-- 
2.35.3

