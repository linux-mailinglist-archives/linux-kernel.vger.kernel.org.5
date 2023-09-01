Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B120B78FB38
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349021AbjIAJnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349020AbjIAJmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E831BD6;
        Fri,  1 Sep 2023 02:42:19 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RcXyb5wpNzhZJb;
        Fri,  1 Sep 2023 17:38:15 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:42:08 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [RFC PATCH v2 17/19] scsi: megaraid_sas: Add param to control target based error handle
Date:   Fri, 1 Sep 2023 17:41:25 +0800
Message-ID: <20230901094127.2010873-18-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230901094127.2010873-1-haowenchao2@huawei.com>
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
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

Add new param target_eh to control if enable target based error
handler, since megaraid_sas did not define callback eh_device_reset,
so only target based error handler is enabled; and megaraid_sas
defined eh_host_reset, so make it fallback to further recover
when target based recovery can not recover all error commands.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 050eed8e2684..cc00cd5b213d 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -45,6 +45,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_dbg.h>
+#include <scsi/scsi_eh.h>
 #include "megaraid_sas_fusion.h"
 #include "megaraid_sas.h"
 
@@ -127,6 +128,10 @@ int host_tagset_enable = 1;
 module_param(host_tagset_enable, int, 0444);
 MODULE_PARM_DESC(host_tagset_enable, "Shared host tagset enable/disable Default: enable(1)");
 
+static bool target_eh;
+module_param(target_eh, bool, 0444);
+MODULE_PARM_DESC(target_eh, "target based error handle (def=0)");
+
 MODULE_LICENSE("GPL");
 MODULE_VERSION(MEGASAS_VERSION);
 MODULE_AUTHOR("megaraidlinux.pdl@broadcom.com");
@@ -2174,6 +2179,19 @@ static void megasas_slave_destroy(struct scsi_device *sdev)
 	sdev->hostdata = NULL;
 }
 
+static int megasas_target_alloc(struct scsi_target *starget)
+{
+	if (target_eh)
+		return scsi_target_setup_eh(starget, 1);
+	return 0;
+}
+
+static void megasas_target_destroy(struct scsi_target *starget)
+{
+	if (target_eh)
+		scsi_target_clear_eh(starget);
+}
+
 /*
 * megasas_complete_outstanding_ioctls - Complete outstanding ioctls after a
 *                                       kill adapter
@@ -3525,6 +3543,8 @@ static const struct scsi_host_template megasas_template = {
 	.change_queue_depth = scsi_change_queue_depth,
 	.max_segment_size = 0xffffffff,
 	.cmd_size = sizeof(struct megasas_cmd_priv),
+	.target_alloc = megasas_target_alloc,
+	.target_destroy = megasas_target_destroy,
 };
 
 /**
-- 
2.35.3

