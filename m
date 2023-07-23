Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2247F75E154
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjGWKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGWKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:23:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B91138;
        Sun, 23 Jul 2023 03:22:58 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R7zpt5BCnzVj2S;
        Sun, 23 Jul 2023 18:21:26 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 18:22:55 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <error27@gmail.com>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 02/13] scsi:scsi_error: Move complete variable eh_action from shost to sdevice
Date:   Mon, 24 Jul 2023 07:44:11 +0800
Message-ID: <20230723234422.1629194-3-haowenchao2@huawei.com>
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

eh_action is used to wait for error handle command's completion if
scsi command is send in error handle. Now the error handler might
based on scsi_device, so move it to scsi_device.

This is preparation for a genernal LUN/target based error handle
strategy.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c  | 6 +++---
 include/scsi/scsi_device.h | 2 ++
 include/scsi/scsi_host.h   | 2 --
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 1d1d97b94613..879fdd7c165b 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -914,7 +914,7 @@ void scsi_eh_done(struct scsi_cmnd *scmd)
 	SCSI_LOG_ERROR_RECOVERY(3, scmd_printk(KERN_INFO, scmd,
 			"%s result: %x\n", __func__, scmd->result));
 
-	eh_action = scmd->device->host->eh_action;
+	eh_action = scmd->device->eh_action;
 	if (eh_action)
 		complete(eh_action);
 }
@@ -1203,7 +1203,7 @@ static enum scsi_disposition scsi_send_eh_cmnd(struct scsi_cmnd *scmd,
 
 retry:
 	scsi_eh_prep_cmnd(scmd, &ses, cmnd, cmnd_size, sense_bytes);
-	shost->eh_action = &done;
+	sdev->eh_action = &done;
 
 	scsi_log_send(scmd);
 	scmd->submitter = SUBMITTED_BY_SCSI_ERROR_HANDLER;
@@ -1246,7 +1246,7 @@ static enum scsi_disposition scsi_send_eh_cmnd(struct scsi_cmnd *scmd,
 		rtn = SUCCESS;
 	}
 
-	shost->eh_action = NULL;
+	sdev->eh_action = NULL;
 
 	scsi_log_completion(scmd, rtn);
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 08ed9a03015d..1894ba1c82cd 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -324,6 +324,8 @@ struct scsi_device {
 	enum scsi_device_state sdev_state;
 	struct task_struct	*quiesced_by;
 	struct scsi_device_eh	*eh;
+	struct completion	*eh_action; /* Wait for specific actions on the
+					       device. */
 	unsigned long		sdev_data[];
 } __attribute__((aligned(sizeof(unsigned long))));
 
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 70b7475dcf56..def0d99e9b36 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -554,8 +554,6 @@ struct Scsi_Host {
 	struct list_head	eh_abort_list;
 	struct list_head	eh_cmd_q;
 	struct task_struct    * ehandler;  /* Error recovery thread. */
-	struct completion     * eh_action; /* Wait for specific actions on the
-					      host. */
 	wait_queue_head_t       host_wait;
 	const struct scsi_host_template *hostt;
 	struct scsi_transport_template *transportt;
-- 
2.35.3

