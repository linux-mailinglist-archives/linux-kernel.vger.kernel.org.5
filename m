Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328EC7AADFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjIVJaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjIVJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:29:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B50CC6;
        Fri, 22 Sep 2023 02:29:34 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RsRgw3H3lztSwS;
        Fri, 22 Sep 2023 17:25:16 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 22 Sep 2023 17:29:32 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v5 01/10] scsi: scsi_debug: create scsi_debug directory in the debugfs filesystem
Date:   Fri, 22 Sep 2023 17:28:57 +0800
Message-ID: <20230922092906.2645265-2-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230922092906.2645265-1-haowenchao2@huawei.com>
References: <20230922092906.2645265-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create directory scsi_debug in the root of the debugfs filesystem.
Prepare to add interface for manage error injection.

Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
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
2.32.0

