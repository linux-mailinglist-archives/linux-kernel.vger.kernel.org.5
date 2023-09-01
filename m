Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8343078FB3C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348987AbjIAJn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349043AbjIAJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8141BE3;
        Fri,  1 Sep 2023 02:42:30 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RcXyd20CjzhZJn;
        Fri,  1 Sep 2023 17:38:17 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:42:10 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [RFC PATCH v2 19/19] scsi: iscsi_tcp: Add param to control LUN based error handle
Date:   Fri, 1 Sep 2023 17:41:27 +0800
Message-ID: <20230901094127.2010873-20-haowenchao2@huawei.com>
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

Add new param lun_eh to control if enable LUN based error handler,
since iscsi_tcp defined callback eh_target_reset, so make it
fallback to further recover when LUN based recovery can not recover
all error commands.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/iscsi_tcp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 9ab8555180a3..83474dc0ecd5 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -35,6 +35,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_transport_iscsi.h>
+#include <scsi/scsi_eh.h>
 #include <trace/events/iscsi.h>
 #include <trace/events/sock.h>
 
@@ -63,6 +64,10 @@ module_param_named(debug_iscsi_tcp, iscsi_sw_tcp_dbg, int,
 MODULE_PARM_DESC(debug_iscsi_tcp, "Turn on debugging for iscsi_tcp module "
 		 "Set to 1 to turn on, and zero to turn off. Default is off.");
 
+static bool iscsi_sw_tcp_lun_eh;
+module_param_named(lun_eh, iscsi_sw_tcp_lun_eh, bool, 0444);
+MODULE_PARM_DESC(lun_eh, "LUN based error handle (def=0)");
+
 #define ISCSI_SW_TCP_DBG(_conn, dbg_fmt, arg...)		\
 	do {							\
 		if (iscsi_sw_tcp_dbg)				\
@@ -1065,6 +1070,19 @@ static int iscsi_sw_tcp_slave_configure(struct scsi_device *sdev)
 	return 0;
 }
 
+static int iscsi_sw_tcp_slave_alloc(struct scsi_device *sdev)
+{
+	if (iscsi_sw_tcp_lun_eh)
+		return scsi_device_setup_eh(sdev, 1);
+	return 0;
+}
+
+static void iscsi_sw_tcp_slave_destroy(struct scsi_device *sdev)
+{
+	if (iscsi_sw_tcp_lun_eh)
+		return scsi_device_clear_eh(sdev);
+}
+
 static const struct scsi_host_template iscsi_sw_tcp_sht = {
 	.module			= THIS_MODULE,
 	.name			= "iSCSI Initiator over TCP/IP",
@@ -1080,6 +1098,8 @@ static const struct scsi_host_template iscsi_sw_tcp_sht = {
 	.eh_target_reset_handler = iscsi_eh_recover_target,
 	.dma_boundary		= PAGE_SIZE - 1,
 	.slave_configure        = iscsi_sw_tcp_slave_configure,
+	.slave_alloc		= iscsi_sw_tcp_slave_alloc,
+	.slave_destroy		= iscsi_sw_tcp_slave_destroy,
 	.proc_name		= "iscsi_tcp",
 	.this_id		= -1,
 	.track_queue_depth	= 1,
-- 
2.35.3

