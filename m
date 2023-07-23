Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4548575E130
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGWKT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjGWKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:19:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C9E6;
        Sun, 23 Jul 2023 03:19:54 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R7zm704KZz18Lbg;
        Sun, 23 Jul 2023 18:19:02 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 18:19:51 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <error27@gmail.com>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v3 1/9] scsi:scsi_debug: create scsi_debug directory in the debugfs filesystem
Date:   Mon, 24 Jul 2023 07:40:57 +0800
Message-ID: <20230723234105.1628982-2-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230723234105.1628982-1-haowenchao2@huawei.com>
References: <20230723234105.1628982-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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

