Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E978FB2F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349026AbjIAJms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348922AbjIAJmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583561732;
        Fri,  1 Sep 2023 02:42:01 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RcY013mYyzVkSC;
        Fri,  1 Sep 2023 17:39:29 +0800 (CST)
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
Subject: [RFC PATCH v2 11/19] scsi: scsi_error: Add a general target based error handler
Date:   Fri, 1 Sep 2023 17:41:19 +0800
Message-ID: <20230901094127.2010873-12-haowenchao2@huawei.com>
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

Add a general target based error handler which can be used by drivers
directly. This error handler implements an scsi_target_eh, when handling
error commands, it would call helper function scsi_starget_eh() added
before to try recover error commands.

The behavior if scsi_starget_eh() can not recover all error commands
depends on fallback flag, which is initialized when scsi_target is
allocated. If fallback is set, it would fallback to further error
recover strategy like old host based error handle; else it would
mark this scsi devices of this target  offline and flush all error
commands.

To using this error handler, drivers should call scsi_target_setup_eh()
in its target_alloc() to setup it's target based error handler;
call scsi_device_clear_eh() in its target_destroy() to clear this
target based error handler.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c | 161 ++++++++++++++++++++++++++++++++++++++
 include/scsi/scsi_eh.h    |   2 +
 2 files changed, 163 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 50cd8104175d..1338742e55b9 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -101,6 +101,19 @@ static inline void shost_clear_eh_done(struct Scsi_Host *shost)
 	}
 }
 
+static inline void starget_clear_eh_done(struct scsi_target *starget)
+{
+	struct scsi_device *sdev;
+
+	list_for_each_entry(sdev, &starget->devices, same_target_siblings) {
+		if (!sdev->eh)
+			continue;
+		sdev->eh->get_sense_done = 0;
+		sdev->eh->stu_done   = 0;
+		sdev->eh->reset_done = 0;
+	}
+}
+
 void scsi_eh_wakeup(struct Scsi_Host *shost)
 {
 	lockdep_assert_held(shost->host_lock);
@@ -3058,3 +3071,151 @@ void scsi_device_clear_eh(struct scsi_device *sdev)
 	sdev->eh = NULL;
 }
 EXPORT_SYMBOL_GPL(scsi_device_clear_eh);
+
+struct starget_eh {
+	spinlock_t		eh_lock;
+	unsigned int		eh_num;
+	struct list_head	eh_cmd_q;
+	struct scsi_target	*starget;
+	struct work_struct	eh_handle_work;
+	unsigned int		fallback:1;
+};
+
+static void starget_eh_work(struct work_struct *work)
+{
+	struct scsi_cmnd *scmd, *next;
+	unsigned long flags;
+	LIST_HEAD(eh_work_q);
+	LIST_HEAD(eh_done_q);
+	struct starget_eh *stargeteh =
+			container_of(work, struct starget_eh, eh_handle_work);
+	struct scsi_target *starget = stargeteh->starget;
+	struct scsi_target_eh *eh = starget->eh;
+
+	spin_lock_irqsave(&stargeteh->eh_lock, flags);
+	list_splice_init(&stargeteh->eh_cmd_q, &eh_work_q);
+	spin_unlock_irqrestore(&stargeteh->eh_lock, flags);
+
+	if (scsi_starget_eh(starget, &eh_work_q, &eh_done_q))
+		goto out_clear_flag;
+
+	if (!stargeteh->fallback) {
+		scsi_eh_offline_sdevs(&eh_work_q, &eh_done_q);
+		goto out_clear_flag;
+	}
+
+	/*
+	 * fallback to host based error handle
+	 */
+	SCSI_LOG_ERROR_RECOVERY(2, starget_printk(KERN_INFO, starget,
+		"%s:targeteh fallback to further recovery\n", current->comm));
+	eh->reset_done = 1;
+	list_for_each_entry_safe(scmd, next, &eh_work_q, eh_entry) {
+		list_del_init(&scmd->eh_entry);
+		__scsi_eh_scmd_add(scmd);
+	}
+	goto out_flush_done;
+
+out_clear_flag:
+	starget_clear_eh_done(starget);
+
+out_flush_done:
+	scsi_eh_flush_done_q(&eh_done_q);
+	spin_lock_irqsave(&stargeteh->eh_lock, flags);
+	stargeteh->eh_num = 0;
+	spin_unlock_irqrestore(&stargeteh->eh_lock, flags);
+}
+
+static void starget_eh_add_cmnd(struct scsi_cmnd *scmd)
+{
+	unsigned long flags;
+	struct scsi_target *starget = scmd->device->sdev_target;
+	struct starget_eh *eh;
+
+	eh = (struct starget_eh *)starget->eh->driver_data;
+
+	spin_lock_irqsave(&eh->eh_lock, flags);
+	list_add_tail(&scmd->eh_entry, &eh->eh_cmd_q);
+	eh->eh_num++;
+	spin_unlock_irqrestore(&eh->eh_lock, flags);
+}
+
+static int starget_eh_is_busy(struct scsi_target *starget)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct starget_eh *eh;
+
+	eh = (struct starget_eh *)starget->eh->driver_data;
+
+	spin_lock_irqsave(&eh->eh_lock, flags);
+	ret = eh->eh_num;
+	spin_unlock_irqrestore(&eh->eh_lock, flags);
+
+	return ret;
+}
+
+static int starget_eh_wakeup(struct scsi_target *starget)
+{
+	unsigned long flags;
+	unsigned int nr_error;
+	unsigned int nr_busy;
+	struct starget_eh *eh;
+
+	eh = (struct starget_eh *)starget->eh->driver_data;
+
+	spin_lock_irqsave(&eh->eh_lock, flags);
+	nr_error = eh->eh_num;
+	spin_unlock_irqrestore(&eh->eh_lock, flags);
+
+	nr_busy = atomic_read(&starget->target_busy);
+
+	if (!nr_error || nr_busy != nr_error) {
+		SCSI_LOG_ERROR_RECOVERY(5, starget_printk(KERN_INFO, starget,
+			"%s:targeteh: do not wake up, busy/error is %d/%d\n",
+			current->comm, nr_busy, nr_error));
+		return 0;
+	}
+
+	SCSI_LOG_ERROR_RECOVERY(2, starget_printk(KERN_INFO, starget,
+		"%s:targeteh: waking up, busy/error is %d/%d\n",
+		current->comm, nr_busy, nr_error));
+
+	return schedule_work(&eh->eh_handle_work);
+}
+
+int scsi_target_setup_eh(struct scsi_target *starget, int fallback)
+{
+	struct scsi_target_eh *eh;
+	struct starget_eh *stargeteh;
+
+	eh = kzalloc(sizeof(struct scsi_device_eh) + sizeof(struct starget_eh),
+		GFP_KERNEL);
+	if (!eh) {
+		starget_printk(KERN_ERR, starget, "failed to setup eh\n");
+		return -ENOMEM;
+	}
+	stargeteh = (struct starget_eh *)eh->driver_data;
+
+	eh->add_cmnd = starget_eh_add_cmnd;
+	eh->is_busy  = starget_eh_is_busy;
+	eh->wakeup   = starget_eh_wakeup;
+	stargeteh->starget = starget;
+	stargeteh->fallback = fallback;
+
+	spin_lock_init(&stargeteh->eh_lock);
+	INIT_LIST_HEAD(&stargeteh->eh_cmd_q);
+	INIT_WORK(&stargeteh->eh_handle_work, starget_eh_work);
+
+	starget->eh = eh;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(scsi_target_setup_eh);
+
+void scsi_target_clear_eh(struct scsi_target *starget)
+{
+	kfree(starget->eh);
+	starget->eh = NULL;
+}
+EXPORT_SYMBOL_GPL(scsi_target_clear_eh);
diff --git a/include/scsi/scsi_eh.h b/include/scsi/scsi_eh.h
index 80e2f130e884..011f63030589 100644
--- a/include/scsi/scsi_eh.h
+++ b/include/scsi/scsi_eh.h
@@ -24,6 +24,8 @@ extern int scsi_starget_eh(struct scsi_target *starget,
 			struct list_head *workq, struct list_head *doneq);
 extern int scsi_device_setup_eh(struct scsi_device *sdev, int fallback);
 extern void scsi_device_clear_eh(struct scsi_device *sdev);
+extern int scsi_target_setup_eh(struct scsi_target *starget, int fallback);
+extern void scsi_target_clear_eh(struct scsi_target *starget);
 
 static inline bool scsi_sense_is_deferred(const struct scsi_sense_hdr *sshdr)
 {
-- 
2.35.3

