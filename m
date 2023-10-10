Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FC67BF730
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjJJJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjJJJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:21:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64B6B6;
        Tue, 10 Oct 2023 02:21:25 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S4Vdr27gdztTMc;
        Tue, 10 Oct 2023 17:16:48 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 17:21:23 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v6 10/10] scsi: scsi_debug: Add param to control sdev's allow_restart
Date:   Tue, 10 Oct 2023 17:20:51 +0800
Message-ID: <20231010092051.608007-11-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231010092051.608007-1-haowenchao2@huawei.com>
References: <20231010092051.608007-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new module param "allow_restart" to control if setup scsi_device's
allow_restart flag, this flag determines if trigger EH after command
finished with sense_key 0x6, asc 0x4 and ascq 0x2, EH would be triggered
if allow_restart=1 in this condition.

The new param can be used with error inject added in patch6 to test how
commands finished with sense_key 0x6, asc 0x4 and ascq 0x2 are handled.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 2743eb36c58e..67922e2c4c19 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -843,6 +843,7 @@ static bool have_dif_prot;
 static bool write_since_sync;
 static bool sdebug_statistics = DEF_STATISTICS;
 static bool sdebug_wp;
+static bool sdebug_allow_restart;
 /* Following enum: 0: no zbc, def; 1: host aware; 2: host managed */
 static enum blk_zoned_model sdeb_zbc_model = BLK_ZONED_NONE;
 static char *sdeb_zbc_model_s;
@@ -5478,6 +5479,9 @@ static int scsi_debug_slave_configure(struct scsi_device *sdp)
 		sdp->no_uld_attach = 1;
 	config_cdb_len(sdp);
 
+	if (sdebug_allow_restart)
+		sdp->allow_restart = 1;
+
 	devip->debugfs_entry = debugfs_create_dir(dev_name(&sdp->sdev_dev),
 				sdebug_debugfs_root);
 	if (IS_ERR_OR_NULL(devip->debugfs_entry))
@@ -6202,6 +6206,7 @@ module_param_named(zone_cap_mb, sdeb_zbc_zone_cap_mb, int, S_IRUGO);
 module_param_named(zone_max_open, sdeb_zbc_max_open, int, S_IRUGO);
 module_param_named(zone_nr_conv, sdeb_zbc_nr_conv, int, S_IRUGO);
 module_param_named(zone_size_mb, sdeb_zbc_zone_size_mb, int, S_IRUGO);
+module_param_named(allow_restart, sdebug_allow_restart, bool, S_IRUGO | S_IWUSR);
 
 MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
 MODULE_DESCRIPTION("SCSI debug adapter driver");
@@ -6274,6 +6279,7 @@ MODULE_PARM_DESC(zone_cap_mb, "Zone capacity in MiB (def=zone size)");
 MODULE_PARM_DESC(zone_max_open, "Maximum number of open zones; [0] for no limit (def=auto)");
 MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones (def=1)");
 MODULE_PARM_DESC(zone_size_mb, "Zone size in MiB (def=auto)");
+MODULE_PARM_DESC(allow_restart, "Set scsi_device's allow_restart flag(def=0)");
 
 #define SDEBUG_INFO_LEN 256
 static char sdebug_info[SDEBUG_INFO_LEN];
-- 
2.32.0

