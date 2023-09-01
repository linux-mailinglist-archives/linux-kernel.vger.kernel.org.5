Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4888F78FB39
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349015AbjIAJnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348950AbjIAJmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3611708;
        Fri,  1 Sep 2023 02:42:23 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RcY184S2czrSMV;
        Fri,  1 Sep 2023 17:40:28 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:42:09 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [RFC PATCH v2 18/19] scsi: virtio_scsi: Add param to control LUN based error handle
Date:   Fri, 1 Sep 2023 17:41:26 +0800
Message-ID: <20230901094127.2010873-19-haowenchao2@huawei.com>
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

Add new param lun_eh to control if enable LUN based error handler, since
virtio_scsi did not define other further reset callbacks, it is not
necessary to fallback to further recover any more, so set the LUN
error handler with fallback set to 0.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/virtio_scsi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index bd5633667d01..7bf4a34cdd20 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -28,6 +28,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_devinfo.h>
+#include <scsi/scsi_eh.h>
 #include <linux/seqlock.h>
 #include <linux/blk-mq-virtio.h>
 
@@ -37,6 +38,10 @@
 #define VIRTIO_SCSI_EVENT_LEN 8
 #define VIRTIO_SCSI_VQ_BASE 2
 
+static bool lun_eh;
+module_param(lun_eh, bool, 0444);
+MODULE_PARM_DESC(lun_eh, "LUN based error handle (def=0)");
+
 /* Command queue element */
 struct virtio_scsi_cmd {
 	struct scsi_cmnd *sc;
@@ -679,9 +684,18 @@ static int virtscsi_device_alloc(struct scsi_device *sdevice)
 	 */
 	sdevice->sdev_bflags = BLIST_TRY_VPD_PAGES;
 
+	if (lun_eh)
+		return scsi_device_setup_eh(sdevice, 0);
+
 	return 0;
 }
 
+static void virtscsi_device_destroy(struct scsi_device *sdevice)
+{
+	if (lun_eh)
+		return scsi_device_clear_eh(sdevice);
+}
+
 
 /**
  * virtscsi_change_queue_depth() - Change a virtscsi target's queue depth
@@ -757,7 +771,7 @@ static const struct scsi_host_template virtscsi_host_template = {
 	.eh_device_reset_handler = virtscsi_device_reset,
 	.eh_timed_out = virtscsi_eh_timed_out,
 	.slave_alloc = virtscsi_device_alloc,
-
+	.slave_destroy = virtscsi_device_destroy,
 	.dma_boundary = UINT_MAX,
 	.map_queues = virtscsi_map_queues,
 	.track_queue_depth = 1,
-- 
2.35.3

