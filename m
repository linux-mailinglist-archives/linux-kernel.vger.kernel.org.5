Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937E378FB26
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348944AbjIAJm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348927AbjIAJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185B210D5;
        Fri,  1 Sep 2023 02:41:59 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RcXyf1dbTzNmJ3;
        Fri,  1 Sep 2023 17:38:18 +0800 (CST)
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
Subject: [RFC PATCH v2 08/19] scsi: scsi_error: Add a general LUN based error handler
Date:   Fri, 1 Sep 2023 17:41:16 +0800
Message-ID: <20230901094127.2010873-9-haowenchao2@huawei.com>
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

Add a general LUN based error handler which can be used by drivers
directly. This error handler implements an scsi_device_eh, when handling
error commands, it would call helper function scsi_sdev_eh() added before
to try recover error commands.

The behavior if scsi_sdev_eh() can not recover all error commands
depends on fallback flag, which is initialized when scsi_device is
allocated. If fallback is set, it would fallback to further error
recover strategy like old host based error handle; else it would
mark this scsi device offline and flush all error commands.

To using this error handler, drivers should call scsi_device_setup_eh()
in its slave_alloc() to setup it's LUN based error handler;
call scsi_device_clear_eh() in its slave_destroy() to clear LUN based
error handler.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c | 170 ++++++++++++++++++++++++++++++++++++++
 include/scsi/scsi_eh.h    |   2 +
 2 files changed, 172 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index f24f081fc637..b17bf1dea799 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2759,3 +2759,173 @@ bool scsi_get_sense_info_fld(const u8 *sense_buffer, int sb_len,
 	}
 }
 EXPORT_SYMBOL(scsi_get_sense_info_fld);
+
+struct scsi_lun_eh {
+	spinlock_t		eh_lock;
+	unsigned int		eh_num;
+	struct list_head	eh_cmd_q;
+	struct scsi_device	*sdev;
+	struct work_struct	eh_handle_work;
+	unsigned int		fallback:1;	/* If fallback to further */
+						/* recovery on failure  */
+};
+
+/*
+ * error handle strategy based on LUN, following steps
+ * is applied to recovery error commands in list:
+ *    check sense data
+ *    send start unit
+ *    reset lun
+ * if there are still error commands, it would fallback to
+ * target based or host based error handle for further recovery.
+ */
+static void sdev_eh_work(struct work_struct *work)
+{
+	unsigned long flags;
+	struct scsi_lun_eh *luneh =
+			container_of(work, struct scsi_lun_eh, eh_handle_work);
+	struct scsi_device *sdev = luneh->sdev;
+	struct scsi_device_eh *eh = sdev->eh;
+	struct Scsi_Host *shost = sdev->host;
+	struct scsi_cmnd *scmd, *next;
+	LIST_HEAD(eh_work_q);
+	LIST_HEAD(eh_done_q);
+
+	spin_lock_irqsave(&luneh->eh_lock, flags);
+	list_splice_init(&luneh->eh_cmd_q, &eh_work_q);
+	spin_unlock_irqrestore(&luneh->eh_lock, flags);
+
+	if (scsi_sdev_eh(sdev, &eh_work_q, &eh_done_q))
+		goto out_flush_done;
+
+	if (!luneh->fallback) {
+		list_for_each_entry_safe(scmd, next, &eh_work_q, eh_entry)
+			scsi_eh_finish_cmd(scmd, &eh_done_q);
+
+		sdev_printk(KERN_INFO, sdev, "%s:luneh: Device offlined - "
+			    "not ready after error recovery\n", current->comm);
+
+		mutex_lock(&sdev->state_mutex);
+		scsi_device_set_state(sdev, SDEV_OFFLINE);
+		mutex_unlock(&sdev->state_mutex);
+
+		goto out_flush_done;
+	}
+
+	/*
+	 * fallback to target or host based error handle
+	 */
+	SCSI_LOG_ERROR_RECOVERY(2, sdev_printk(KERN_INFO, sdev,
+		"%s:luneh fallback to further recovery\n", current->comm));
+	list_for_each_entry_safe(scmd, next, &eh_work_q, eh_entry) {
+		list_del_init(&scmd->eh_entry);
+
+		if (scsi_host_in_recovery(shost) ||
+		    __scsi_eh_scmd_add_starget(scmd))
+			__scsi_eh_scmd_add(scmd);
+	}
+
+	eh->get_sense_done = 1;
+	eh->stu_done = 1;
+	eh->reset_done = 1;
+
+out_flush_done:
+	scsi_eh_flush_done_q(&eh_done_q);
+	spin_lock_irqsave(&luneh->eh_lock, flags);
+	luneh->eh_num = 0;
+	spin_unlock_irqrestore(&luneh->eh_lock, flags);
+}
+static void sdev_eh_add_cmnd(struct scsi_cmnd *scmd)
+{
+	unsigned long flags;
+	struct scsi_lun_eh *luneh;
+	struct scsi_device *sdev = scmd->device;
+
+	luneh = (struct scsi_lun_eh *)sdev->eh->driver_data;
+
+	spin_lock_irqsave(&luneh->eh_lock, flags);
+	list_add_tail(&scmd->eh_entry, &luneh->eh_cmd_q);
+	luneh->eh_num++;
+	spin_unlock_irqrestore(&luneh->eh_lock, flags);
+}
+static int sdev_eh_is_busy(struct scsi_device *sdev)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct scsi_lun_eh *luneh;
+
+	if (!sdev->eh)
+		return 0;
+
+	luneh = (struct scsi_lun_eh *)sdev->eh->driver_data;
+
+	spin_lock_irqsave(&luneh->eh_lock, flags);
+	ret = luneh->eh_num;
+	spin_unlock_irqrestore(&luneh->eh_lock, flags);
+
+	return ret;
+}
+static int sdev_eh_wakeup(struct scsi_device *sdev)
+{
+	unsigned long flags;
+	unsigned int nr_error;
+	unsigned int nr_busy;
+	struct scsi_lun_eh *luneh;
+
+	luneh = (struct scsi_lun_eh *)sdev->eh->driver_data;
+
+	spin_lock_irqsave(&luneh->eh_lock, flags);
+	nr_error = luneh->eh_num;
+	spin_unlock_irqrestore(&luneh->eh_lock, flags);
+
+	nr_busy = scsi_device_busy(sdev);
+
+	if (!nr_error || nr_busy != nr_error) {
+		SCSI_LOG_ERROR_RECOVERY(5, sdev_printk(KERN_INFO, sdev,
+			"%s:luneh: do not wake up, busy/error: %d/%d\n",
+			current->comm, nr_busy, nr_error));
+		return 0;
+	}
+
+	SCSI_LOG_ERROR_RECOVERY(2, sdev_printk(KERN_INFO, sdev,
+		"%s:luneh: waking up, busy/error: %d/%d\n",
+		current->comm, nr_busy, nr_error));
+
+	return schedule_work(&luneh->eh_handle_work);
+}
+
+int scsi_device_setup_eh(struct scsi_device *sdev, int fallback)
+{
+	struct scsi_device_eh *eh;
+	struct scsi_lun_eh *luneh;
+
+	eh = kzalloc(sizeof(struct scsi_device_eh) + sizeof(struct scsi_lun_eh),
+		GFP_KERNEL);
+	if (!eh) {
+		sdev_printk(KERN_ERR, sdev, "failed to setup error handle\n");
+		return -ENOMEM;
+	}
+	luneh = (struct scsi_lun_eh *)eh->driver_data;
+
+	eh->add_cmnd = sdev_eh_add_cmnd;
+	eh->is_busy  = sdev_eh_is_busy;
+	eh->wakeup   = sdev_eh_wakeup;
+
+	luneh->fallback = fallback;
+	luneh->sdev  = sdev;
+	spin_lock_init(&luneh->eh_lock);
+	INIT_LIST_HEAD(&luneh->eh_cmd_q);
+	INIT_WORK(&luneh->eh_handle_work, sdev_eh_work);
+
+	sdev->eh = eh;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(scsi_device_setup_eh);
+
+void scsi_device_clear_eh(struct scsi_device *sdev)
+{
+	kfree(sdev->eh);
+	sdev->eh = NULL;
+}
+EXPORT_SYMBOL_GPL(scsi_device_clear_eh);
diff --git a/include/scsi/scsi_eh.h b/include/scsi/scsi_eh.h
index 5ce791063baf..89b471aa484f 100644
--- a/include/scsi/scsi_eh.h
+++ b/include/scsi/scsi_eh.h
@@ -20,6 +20,8 @@ extern bool scsi_command_normalize_sense(const struct scsi_cmnd *cmd,
 extern enum scsi_disposition scsi_check_sense(struct scsi_cmnd *);
 extern int scsi_sdev_eh(struct scsi_device *sdev, struct list_head *workq,
 			struct list_head *doneq);
+extern int scsi_device_setup_eh(struct scsi_device *sdev, int fallback);
+extern void scsi_device_clear_eh(struct scsi_device *sdev);
 
 static inline bool scsi_sense_is_deferred(const struct scsi_sense_hdr *sshdr)
 {
-- 
2.35.3

