Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870F678FB29
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348947AbjIAJmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348939AbjIAJmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0F1726;
        Fri,  1 Sep 2023 02:42:00 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RcY003ytWzVkR3;
        Fri,  1 Sep 2023 17:39:28 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:41:57 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [RFC PATCH v2 10/19] scsi: scsi_error: Add helper to handle scsi target's error command list
Date:   Fri, 1 Sep 2023 17:41:18 +0800
Message-ID: <20230901094127.2010873-11-haowenchao2@huawei.com>
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

Add helper scsi_starget_eh() to handle scsi target's error command list,
it would perform some steps which can be done with target's IO blocked,
including check sense, start unit, reset lun and reset target.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c | 129 ++++++++++++++++++++++++++++++++++++++
 include/scsi/scsi_eh.h    |   2 +
 2 files changed, 131 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index b17bf1dea799..50cd8104175d 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2547,6 +2547,135 @@ int scsi_sdev_eh(struct scsi_device *sdev,
 }
 EXPORT_SYMBOL_GPL(scsi_sdev_eh);
 
+static int starget_eh_stu(struct scsi_target *starget,
+			  struct list_head *work_q,
+			  struct list_head *done_q)
+{
+	struct scsi_device *sdev;
+	struct scsi_cmnd *scmd, *stu_scmd;
+
+	list_for_each_entry(sdev, &starget->devices, same_target_siblings) {
+		if (sdev_stu_done(sdev))
+			continue;
+
+		stu_scmd = NULL;
+		list_for_each_entry(scmd, work_q, eh_entry)
+			if (scmd->device == sdev && SCSI_SENSE_VALID(scmd) &&
+			    scsi_check_sense(scmd) == FAILED) {
+				stu_scmd = scmd;
+				break;
+			}
+		if (!stu_scmd)
+			continue;
+
+		if (scsi_eh_sdev_stu(stu_scmd, work_q, done_q))
+			return 1;
+	}
+
+	return 0;
+}
+
+static int starget_eh_reset_lun(struct scsi_target *starget,
+				struct list_head *work_q,
+				struct list_head *done_q)
+{
+	struct scsi_device *sdev;
+	struct scsi_cmnd *scmd, *bdr_scmd;
+
+	list_for_each_entry(sdev, &starget->devices, same_target_siblings) {
+		if (sdev_reset_done(sdev))
+			continue;
+
+		bdr_scmd = NULL;
+		list_for_each_entry(scmd, work_q, eh_entry)
+			if (scmd->device) {
+				bdr_scmd = scmd;
+				break;
+			}
+		if (!bdr_scmd)
+			continue;
+
+		if (scsi_eh_sdev_reset(bdr_scmd, work_q, done_q))
+			return 1;
+	}
+
+	return 0;
+}
+
+static int starget_eh_reset_target(struct scsi_target *starget,
+				    struct list_head *work_q,
+				    struct list_head *done_q)
+{
+	enum scsi_disposition rtn;
+	struct scsi_cmnd *scmd, *next;
+	LIST_HEAD(check_list);
+
+	scmd = list_first_entry(work_q, struct scsi_cmnd, eh_entry);
+
+	SCSI_LOG_ERROR_RECOVERY(3, starget_printk(KERN_INFO, starget,
+			     "%s: Sending target reset\n", current->comm));
+
+	rtn = scsi_try_target_reset(scmd);
+	if (rtn != SUCCESS && rtn != FAST_IO_FAIL) {
+		SCSI_LOG_ERROR_RECOVERY(3, starget_printk(KERN_INFO, starget,
+				     "%s: Target reset failed\n",
+				     current->comm));
+		return 0;
+	}
+
+	SCSI_LOG_ERROR_RECOVERY(3, starget_printk(KERN_INFO, starget,
+			     "%s: Target reset success\n", current->comm));
+
+	list_for_each_entry_safe(scmd, next, work_q, eh_entry) {
+		if (rtn == SUCCESS)
+			list_move_tail(&scmd->eh_entry, &check_list);
+		else if (rtn == FAST_IO_FAIL)
+			scsi_eh_finish_cmd(scmd, done_q);
+	}
+
+	return scsi_eh_test_devices(&check_list, work_q, done_q, 0);
+}
+
+/*
+ * Target based error handle
+ *
+ * @work_q: list of scsi commands need to recovery
+ * @done_q: list of scsi commands handled
+ *
+ * return: return 1 if all commands in work_q is recoveryed, else 0 is returned
+ */
+int scsi_starget_eh(struct scsi_target *starget,
+		    struct list_head *work_q,
+		    struct list_head *done_q)
+{
+	int ret = 0;
+
+	SCSI_LOG_ERROR_RECOVERY(2, starget_printk(KERN_INFO, starget,
+		"%s:targeteh: checking sense\n", current->comm));
+	ret = scsi_eh_get_sense(work_q, done_q);
+	if (ret)
+		return ret;
+
+	SCSI_LOG_ERROR_RECOVERY(2, starget_printk(KERN_INFO, starget,
+		"%s:targeteh: start unit\n", current->comm));
+	ret = starget_eh_stu(starget, work_q, done_q);
+	if (ret)
+		return ret;
+
+	SCSI_LOG_ERROR_RECOVERY(2, starget_printk(KERN_INFO, starget,
+		"%s:targeteh reset LUN\n", current->comm));
+	ret = starget_eh_reset_lun(starget, work_q, done_q);
+	if (ret)
+		return ret;
+
+	SCSI_LOG_ERROR_RECOVERY(2, starget_printk(KERN_INFO, starget,
+		"%s:targeteh reset target\n", current->comm));
+	ret = starget_eh_reset_target(starget, work_q, done_q);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(scsi_starget_eh);
+
 /*
  * Function:    scsi_report_bus_reset()
  *
diff --git a/include/scsi/scsi_eh.h b/include/scsi/scsi_eh.h
index 89b471aa484f..80e2f130e884 100644
--- a/include/scsi/scsi_eh.h
+++ b/include/scsi/scsi_eh.h
@@ -20,6 +20,8 @@ extern bool scsi_command_normalize_sense(const struct scsi_cmnd *cmd,
 extern enum scsi_disposition scsi_check_sense(struct scsi_cmnd *);
 extern int scsi_sdev_eh(struct scsi_device *sdev, struct list_head *workq,
 			struct list_head *doneq);
+extern int scsi_starget_eh(struct scsi_target *starget,
+			struct list_head *workq, struct list_head *doneq);
 extern int scsi_device_setup_eh(struct scsi_device *sdev, int fallback);
 extern void scsi_device_clear_eh(struct scsi_device *sdev);
 
-- 
2.35.3

