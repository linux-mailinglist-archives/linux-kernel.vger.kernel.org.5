Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F34A78FB25
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348878AbjIAJmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345337AbjIAJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F111170C;
        Fri,  1 Sep 2023 02:41:58 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RcXyK6zF9zhZHX;
        Fri,  1 Sep 2023 17:38:01 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:41:55 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [RFC PATCH v2 07/19] scsi: scsi_error: Add helper to handle scsi device's error command list
Date:   Fri, 1 Sep 2023 17:41:15 +0800
Message-ID: <20230901094127.2010873-8-haowenchao2@huawei.com>
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

Add helper scsi_sdev_eh() to handle scsi device's error command list,
it would perform some steps which can be done with LUN's IO blocked,
including check sense, start unit and reset lun.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c | 37 +++++++++++++++++++++++++++++++++++++
 include/scsi/scsi_eh.h    |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 055c04470f5c..f24f081fc637 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2510,6 +2510,43 @@ int scsi_error_handler(void *data)
 	return 0;
 }
 
+/*
+ * Single LUN error handle
+ *
+ * @work_q: list of scsi commands need to recovery
+ * @done_q: list of scsi commands handled
+ *
+ * return: return 1 if all commands in work_q is recoveryed, else 0 is returned
+ */
+int scsi_sdev_eh(struct scsi_device *sdev,
+		 struct list_head *work_q,
+		 struct list_head *done_q)
+{
+	int ret = 0;
+	struct scsi_cmnd *scmd;
+
+	SCSI_LOG_ERROR_RECOVERY(2, sdev_printk(KERN_INFO, sdev,
+		"%s:luneh: checking sense\n", current->comm));
+	ret = scsi_eh_get_sense(work_q, done_q);
+	if (ret)
+		return ret;
+
+	SCSI_LOG_ERROR_RECOVERY(2, sdev_printk(KERN_INFO, sdev,
+		"%s:luneh: start unit\n", current->comm));
+	scmd = list_first_entry(work_q, struct scsi_cmnd, eh_entry);
+	ret = scsi_eh_sdev_stu(scmd, work_q, done_q);
+	if (ret)
+		return ret;
+
+	SCSI_LOG_ERROR_RECOVERY(2, sdev_printk(KERN_INFO, sdev,
+		"%s:luneh reset LUN\n", current->comm));
+	scmd = list_first_entry(work_q, struct scsi_cmnd, eh_entry);
+	ret = scsi_eh_sdev_reset(scmd, work_q, done_q);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(scsi_sdev_eh);
+
 /*
  * Function:    scsi_report_bus_reset()
  *
diff --git a/include/scsi/scsi_eh.h b/include/scsi/scsi_eh.h
index 1ae08e81339f..5ce791063baf 100644
--- a/include/scsi/scsi_eh.h
+++ b/include/scsi/scsi_eh.h
@@ -18,6 +18,8 @@ extern int scsi_block_when_processing_errors(struct scsi_device *);
 extern bool scsi_command_normalize_sense(const struct scsi_cmnd *cmd,
 					 struct scsi_sense_hdr *sshdr);
 extern enum scsi_disposition scsi_check_sense(struct scsi_cmnd *);
+extern int scsi_sdev_eh(struct scsi_device *sdev, struct list_head *workq,
+			struct list_head *doneq);
 
 static inline bool scsi_sense_is_deferred(const struct scsi_sense_hdr *sshdr)
 {
-- 
2.35.3

