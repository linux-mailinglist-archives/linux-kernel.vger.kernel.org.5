Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8552378FB2D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345337AbjIAJmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348956AbjIAJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9010E7;
        Fri,  1 Sep 2023 02:42:02 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RcXyk0fP1zNmXX;
        Fri,  1 Sep 2023 17:38:22 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:41:59 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [RFC PATCH v2 13/19] scsi: scsi_debug: Add param to control target based error handle
Date:   Fri, 1 Sep 2023 17:41:21 +0800
Message-ID: <20230901094127.2010873-14-haowenchao2@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new module param target_eh to control if enable target based error
handler, and param target_eh_fallback to control if fallback to further
recover when target recovery can not recover all error commands.
This is used to test the target based error handle.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_debug.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index af3d43c9db6f..9a8aa48fb8a4 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -843,6 +843,8 @@ static bool sdebug_statistics = DEF_STATISTICS;
 static bool sdebug_wp;
 static bool sdebug_lun_eh;
 static bool sdebug_lun_eh_fallback;
+static bool sdebug_target_eh;
+static bool sdebug_target_eh_fallback;
 /* Following enum: 0: no zbc, def; 1: host aware; 2: host managed */
 static enum blk_zoned_model sdeb_zbc_model = BLK_ZONED_NONE;
 static char *sdeb_zbc_model_s;
@@ -1137,6 +1139,9 @@ static int sdebug_target_alloc(struct scsi_target *starget)
 
 	starget->hostdata = targetip;
 
+	if (sdebug_target_eh)
+		return scsi_target_setup_eh(starget, sdebug_target_eh_fallback);
+
 	return 0;
 }
 
@@ -1152,6 +1157,9 @@ static void sdebug_target_destroy(struct scsi_target *starget)
 {
 	struct sdebug_target_info *targetip;
 
+	if (sdebug_target_eh)
+		scsi_target_clear_eh(starget);
+
 	targetip = (struct sdebug_target_info *)starget->hostdata;
 	if (targetip) {
 		starget->hostdata = NULL;
@@ -6177,6 +6185,8 @@ module_param_named(zone_nr_conv, sdeb_zbc_nr_conv, int, S_IRUGO);
 module_param_named(zone_size_mb, sdeb_zbc_zone_size_mb, int, S_IRUGO);
 module_param_named(lun_eh, sdebug_lun_eh, bool, S_IRUGO);
 module_param_named(lun_eh_fallback, sdebug_lun_eh_fallback, bool, S_IRUGO);
+module_param_named(target_eh, sdebug_target_eh, bool, S_IRUGO);
+module_param_named(target_eh_fallback, sdebug_target_eh_fallback, bool, S_IRUGO);
 
 MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
 MODULE_DESCRIPTION("SCSI debug adapter driver");
@@ -6251,6 +6261,8 @@ MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones (def=1)");
 MODULE_PARM_DESC(zone_size_mb, "Zone size in MiB (def=auto)");
 MODULE_PARM_DESC(lun_eh, "LUN based error handle (def=0)");
 MODULE_PARM_DESC(lun_eh_fallback, "Fallback to further recovery if LUN recovery failed (def=0)");
+MODULE_PARM_DESC(target_eh, "target based error handle (def=0)");
+MODULE_PARM_DESC(target_eh_fallback, "Fallback to further recovery if target recovery failed (def=0)");
 
 #define SDEBUG_INFO_LEN 256
 static char sdebug_info[SDEBUG_INFO_LEN];
-- 
2.35.3

