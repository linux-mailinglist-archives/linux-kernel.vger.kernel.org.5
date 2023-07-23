Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7DA75E15E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGWKY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjGWKX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:23:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE5B172A;
        Sun, 23 Jul 2023 03:23:05 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R7zq10mzfzVj2S;
        Sun, 23 Jul 2023 18:21:33 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 18:23:01 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <error27@gmail.com>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 12/13] scsi:scsi_debug: Add param to control if setup LUN based error handle
Date:   Mon, 24 Jul 2023 07:44:21 +0800
Message-ID: <20230723234422.1629194-13-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230723234422.1629194-1-haowenchao2@huawei.com>
References: <20230723234422.1629194-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new module param lun_eh to control if setup LUN based error handle,
this is used to test the LUN based error handle.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_debug.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 2c5ed618f228..7ab57fc30301 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -58,6 +58,7 @@
 
 #include "sd.h"
 #include "scsi_logging.h"
+#include "scsi_priv.h"
 
 /* make sure inq_product_rev string corresponds to this version */
 #define SDEBUG_VERSION "0191"	/* format to fit INQUIRY revision field */
@@ -840,6 +841,7 @@ static bool have_dif_prot;
 static bool write_since_sync;
 static bool sdebug_statistics = DEF_STATISTICS;
 static bool sdebug_wp;
+static bool sdebug_lun_eh;
 /* Following enum: 0: no zbc, def; 1: host aware; 2: host managed */
 static enum blk_zoned_model sdeb_zbc_model = BLK_ZONED_NONE;
 static char *sdeb_zbc_model_s;
@@ -5423,6 +5425,9 @@ static int scsi_debug_slave_alloc(struct scsi_device *sdp)
 		pr_info("slave_alloc <%u %u %u %llu>\n",
 		       sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
 
+	if (sdebug_lun_eh)
+		return scsi_device_setup_eh(sdp);
+
 	return 0;
 }
 
@@ -5477,6 +5482,9 @@ static void scsi_debug_slave_destroy(struct scsi_device *sdp)
 	/* make this slot available for re-use */
 	devip->used = false;
 	sdp->hostdata = NULL;
+
+	if (sdebug_lun_eh)
+		scsi_device_clear_eh(sdp);
 }
 
 /* Returns true if we require the queued memory to be freed by the caller. */
@@ -6153,6 +6161,7 @@ module_param_named(zone_cap_mb, sdeb_zbc_zone_cap_mb, int, S_IRUGO);
 module_param_named(zone_max_open, sdeb_zbc_max_open, int, S_IRUGO);
 module_param_named(zone_nr_conv, sdeb_zbc_nr_conv, int, S_IRUGO);
 module_param_named(zone_size_mb, sdeb_zbc_zone_size_mb, int, S_IRUGO);
+module_param_named(lun_eh, sdebug_lun_eh, bool, S_IRUGO);
 
 MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
 MODULE_DESCRIPTION("SCSI debug adapter driver");
@@ -6225,6 +6234,7 @@ MODULE_PARM_DESC(zone_cap_mb, "Zone capacity in MiB (def=zone size)");
 MODULE_PARM_DESC(zone_max_open, "Maximum number of open zones; [0] for no limit (def=auto)");
 MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones (def=1)");
 MODULE_PARM_DESC(zone_size_mb, "Zone size in MiB (def=auto)");
+MODULE_PARM_DESC(lun_eh, "LUN based error handle (def=0)");
 
 #define SDEBUG_INFO_LEN 256
 static char sdebug_info[SDEBUG_INFO_LEN];
-- 
2.35.3

