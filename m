Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB53575E15D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGWKYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGWKX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:23:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055351722;
        Sun, 23 Jul 2023 03:23:04 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R7zn26jx6ztRFL;
        Sun, 23 Jul 2023 18:19:50 +0800 (CST)
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
Subject: [PATCH 11/13] scsi:scsi_error: Add target based error handler based previous helper
Date:   Mon, 24 Jul 2023 07:44:20 +0800
Message-ID: <20230723234422.1629194-12-haowenchao2@huawei.com>
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

Add target based error handler, drivers can call scsi_target_setup_eh() in
its target_alloc() to setup it's target based error handler; call
scsi_device_clear_eh() in its target_destroy() to clear target based error
handler.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c | 154 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/scsi_priv.h  |   2 +
 2 files changed, 156 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 6ebf62f9817a..b64828c5c9ee 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -100,6 +100,19 @@ static inline void shost_clear_eh_done(struct Scsi_Host *shost)
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
@@ -3024,3 +3037,144 @@ void scsi_device_clear_eh(struct scsi_device *sdev)
 	kfree(sdev->eh);
 }
 EXPORT_SYMBOL_GPL(scsi_device_clear_eh);
+
+struct starget_eh {
+	spinlock_t		eh_lock;
+	unsigned int		eh_num;
+	struct list_head	eh_cmd_q;
+	struct scsi_target	*starget;
+	struct work_struct	eh_handle_work;
+	unsigned		try_reset_done:1;
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
+int scsi_target_setup_eh(struct scsi_target *starget)
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
+}
+EXPORT_SYMBOL_GPL(scsi_target_clear_eh);
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 7d7d95a6f526..12b8d7cedd1e 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -103,6 +103,8 @@ bool scsi_noretry_cmd(struct scsi_cmnd *scmd);
 void scsi_eh_done(struct scsi_cmnd *scmd);
 int scsi_device_setup_eh(struct scsi_device *sdev);
 void scsi_device_clear_eh(struct scsi_device *sdev);
+int scsi_target_setup_eh(struct scsi_target *starget);
+void scsi_target_clear_eh(struct scsi_target *starget);
 
 /* scsi_lib.c */
 extern int scsi_maybe_unblock_host(struct scsi_device *sdev);
-- 
2.35.3

