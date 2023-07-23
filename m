Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030A575E14D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGWKXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGWKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:23:26 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370B41708;
        Sun, 23 Jul 2023 03:23:00 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R7znj4tQZzHqZd;
        Sun, 23 Jul 2023 18:20:25 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 18:22:56 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <error27@gmail.com>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 04/13] scsi:scsi_error: Add helper scsi_eh_sdev_stu to do START_UNIT
Date:   Mon, 24 Jul 2023 07:44:13 +0800
Message-ID: <20230723234422.1629194-5-haowenchao2@huawei.com>
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
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function scsi_eh_sdev_stu() to perform START_UNIT and check
if to finish some error commands.

This is preparation for a genernal LUN/target based error handle
strategy and did not change original logic.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c | 50 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index d80492366527..b7842d927af3 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1549,6 +1549,31 @@ static int scsi_eh_try_stu(struct scsi_cmnd *scmd)
 	return 1;
 }
 
+static int scsi_eh_sdev_stu(struct scsi_cmnd *scmd,
+			      struct list_head *work_q,
+			      struct list_head *done_q)
+{
+	struct scsi_device *sdev = scmd->device;
+	struct scsi_cmnd *next;
+
+	SCSI_LOG_ERROR_RECOVERY(3, sdev_printk(KERN_INFO, sdev,
+				"%s: Sending START_UNIT\n", current->comm));
+
+	if (scsi_eh_try_stu(scmd)) {
+		SCSI_LOG_ERROR_RECOVERY(3, sdev_printk(KERN_INFO, sdev,
+				    "%s: START_UNIT failed\n", current->comm));
+		return 0;
+	}
+
+	if (!scsi_device_online(sdev) || !scsi_eh_tur(scmd))
+		list_for_each_entry_safe(scmd, next, work_q, eh_entry)
+			if (scmd->device == sdev &&
+			    scsi_eh_action(scmd, SUCCESS) == SUCCESS)
+				scsi_eh_finish_cmd(scmd, done_q);
+
+	return list_empty(work_q);
+}
+
  /**
  * scsi_eh_stu - send START_UNIT if needed
  * @shost:	&scsi host being recovered.
@@ -1563,7 +1588,7 @@ static int scsi_eh_stu(struct Scsi_Host *shost,
 			      struct list_head *work_q,
 			      struct list_head *done_q)
 {
-	struct scsi_cmnd *scmd, *stu_scmd, *next;
+	struct scsi_cmnd *scmd, *stu_scmd;
 	struct scsi_device *sdev;
 
 	shost_for_each_device(sdev, shost) {
@@ -1586,26 +1611,9 @@ static int scsi_eh_stu(struct Scsi_Host *shost,
 		if (!stu_scmd)
 			continue;
 
-		SCSI_LOG_ERROR_RECOVERY(3,
-			sdev_printk(KERN_INFO, sdev,
-				     "%s: Sending START_UNIT\n",
-				    current->comm));
-
-		if (!scsi_eh_try_stu(stu_scmd)) {
-			if (!scsi_device_online(sdev) ||
-			    !scsi_eh_tur(stu_scmd)) {
-				list_for_each_entry_safe(scmd, next,
-							  work_q, eh_entry) {
-					if (scmd->device == sdev &&
-					    scsi_eh_action(scmd, SUCCESS) == SUCCESS)
-						scsi_eh_finish_cmd(scmd, done_q);
-				}
-			}
-		} else {
-			SCSI_LOG_ERROR_RECOVERY(3,
-				sdev_printk(KERN_INFO, sdev,
-					    "%s: START_UNIT failed\n",
-					    current->comm));
+		if (scsi_eh_sdev_stu(stu_scmd, work_q, done_q)) {
+			scsi_device_put(sdev);
+			break;
 		}
 	}
 
-- 
2.35.3

