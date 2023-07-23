Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360A675E147
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGWKXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjGWKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:23:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F6120;
        Sun, 23 Jul 2023 03:22:57 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R7zmw4NxnztRFL;
        Sun, 23 Jul 2023 18:19:44 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 18:22:54 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <error27@gmail.com>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 01/13] scsi: Define basic framework for driver LUN/target based error handle
Date:   Mon, 24 Jul 2023 07:44:10 +0800
Message-ID: <20230723234422.1629194-2-haowenchao2@huawei.com>
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

SCSI mid-level is response to handle error scsi command, the traditional
handle logic based on host, once a scsi command in one LUN of this host
failed, SCSI mid-level would set the whole host to recovery state, and
no IO can be submitted to LUNs of this host any more before recovery
finished, while the recovery process might take a long time to finish.
It's unreasonable when there are a lot of LUNs in one host.

So this change introduce a way for driver to implement its own
error handle logic which can base on a single scsi LUN oe scsi target
as minimum unit.

scsi_device_eh is defined for error handle based on scsi LUN, and pointer
struct scsi_device_eh "eh" is added in scsi_device, which is NULL by
default.

LLDs can initialize the sdev->eh in hostt->slave_alloc to implement a
scsi LUN based error handle. If this member is not NULL, SCSI mid-level
would branch to drivers' error handler rather than the traditional one.

scsi_target_eh is defined for error handle based on scsi target, and
pointer struct scsi_target_eh "eh" is added in scsi_target, which is NULL
by default.
LLDs can initialize the sdev->eh in hostt->target_alloc to implement a
scsi target based error handle. If this member is not NULL, SCSI
mid-level would branch to drivers' error handler rather than the
traditional one.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c  | 57 +++++++++++++++++++++++++++++++-
 drivers/scsi/scsi_lib.c    | 12 +++++++
 drivers/scsi/scsi_priv.h   | 16 +++++++++
 include/scsi/scsi_device.h | 67 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index c67cdcdc3ba8..1d1d97b94613 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -290,11 +290,48 @@ static void scsi_eh_inc_host_failed(struct rcu_head *head)
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
 
+#define SCSI_EH_NO_HANDLER 1
+
+static int __scsi_eh_scmd_add_sdev(struct scsi_cmnd *scmd)
+{
+	struct scsi_device *sdev = scmd->device;
+	struct scsi_device_eh *eh = sdev->eh;
+
+	if (!eh || !eh->add_cmnd)
+		return SCSI_EH_NO_HANDLER;
+
+	scsi_eh_reset(scmd);
+	eh->add_cmnd(scmd);
+
+	if (eh->wakeup)
+		eh->wakeup(sdev);
+
+	return 0;
+}
+
+static int __scsi_eh_scmd_add_starget(struct scsi_cmnd *scmd)
+{
+	struct scsi_device *sdev = scmd->device;
+	struct scsi_target *starget = scsi_target(sdev);
+	struct scsi_target_eh *eh = starget->eh;
+
+	if (!eh || !eh->add_cmnd)
+		return SCSI_EH_NO_HANDLER;
+
+	scsi_eh_reset(scmd);
+	eh->add_cmnd(scmd);
+
+	if (eh->wakeup)
+		eh->wakeup(starget);
+
+	return 0;
+}
+
 /**
  * scsi_eh_scmd_add - add scsi cmd to error handling.
  * @scmd:	scmd to run eh on.
  */
-void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
+static void __scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 {
 	struct Scsi_Host *shost = scmd->device->host;
 	unsigned long flags;
@@ -320,6 +357,24 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 	call_rcu_hurry(&scmd->rcu, scsi_eh_inc_host_failed);
 }
 
+void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
+{
+	struct scsi_device *sdev = scmd->device;
+	struct scsi_target *starget = scsi_target(sdev);
+	struct Scsi_Host *shost = sdev->host;
+
+	if (unlikely(scsi_host_in_recovery(shost)))
+		__scsi_eh_scmd_add(scmd);
+
+	if (unlikely(scsi_target_in_recovery(starget)))
+		if (__scsi_eh_scmd_add_starget(scmd))
+			__scsi_eh_scmd_add(scmd);
+
+	if (__scsi_eh_scmd_add_sdev(scmd))
+		if (__scsi_eh_scmd_add_starget(scmd))
+			__scsi_eh_scmd_add(scmd);
+}
+
 /**
  * scsi_timeout - Timeout function for normal scsi commands.
  * @req:	request that is timing out.
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ad9afae49544..db0a42fe49c0 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -298,6 +298,12 @@ void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd)
 
 	sbitmap_put(&sdev->budget_map, cmd->budget_token);
 	cmd->budget_token = -1;
+
+	if (sdev->eh && sdev->eh->wakeup)
+		sdev->eh->wakeup(sdev);
+
+	if (starget->eh && starget->eh->wakeup)
+		starget->eh->wakeup(starget);
 }
 
 static void scsi_kick_queue(struct request_queue *q)
@@ -1253,6 +1259,9 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
 {
 	int token;
 
+	if (scsi_device_in_recovery(sdev))
+		return -1;
+
 	token = sbitmap_get(&sdev->budget_map);
 	if (atomic_read(&sdev->device_blocked)) {
 		if (token < 0)
@@ -1288,6 +1297,9 @@ static inline int scsi_target_queue_ready(struct Scsi_Host *shost,
 	struct scsi_target *starget = scsi_target(sdev);
 	unsigned int busy;
 
+	if (scsi_target_in_recovery(starget))
+		return 0;
+
 	if (starget->single_lun) {
 		spin_lock_irq(shost->host_lock);
 		if (starget->starget_sdev_user &&
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index f42388ecb024..484c2f61ffe7 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -196,6 +196,22 @@ static inline void scsi_dh_add_device(struct scsi_device *sdev) { }
 static inline void scsi_dh_release_device(struct scsi_device *sdev) { }
 #endif
 
+static inline int scsi_device_in_recovery(struct scsi_device *sdev)
+{
+	struct scsi_device_eh *eh = sdev->eh;
+	if (eh && eh->is_busy)
+		return eh->is_busy(sdev);
+	return 0;
+}
+
+static inline int scsi_target_in_recovery(struct scsi_target *starget)
+{
+	struct scsi_target_eh *eh = starget->eh;
+	if (eh && eh->is_busy)
+		return eh->is_busy(starget);
+	return 0;
+}
+
 struct bsg_device *scsi_bsg_register_queue(struct scsi_device *sdev);
 
 extern int scsi_device_max_queue_depth(struct scsi_device *sdev);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 75b2235b99e2..08ed9a03015d 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -104,6 +104,71 @@ enum scsi_vpd_parameters {
 	SCSI_VPD_HEADER_SIZE = 4,
 };
 
+struct scsi_device;
+struct scsi_target;
+
+struct scsi_device_eh {
+	/*
+	 * add scsi command to error handler so it would be handuled by
+	 * driver's error handle strategy
+	 */
+	void (*add_cmnd)(struct scsi_cmnd *scmd);
+
+	/*
+	 * to judge if the device is busy handling errors, called before
+	 * dispatch scsi cmnd
+	 *
+	 * return 0 if it's ready to accepy scsi cmnd
+	 * return 0 if it's in error handle, command's would not be dispatched
+	 */
+	int (*is_busy)(struct scsi_device *sdev);
+
+	/*
+	 * wakeup device's error handle
+	 *
+	 * usually the error handler strategy would not run at once when
+	 * error command is added. This function would be called when any
+	 * scsi cmnd is finished or when scsi cmnd is added.
+	 */
+	int (*wakeup)(struct scsi_device *sdev);
+
+	/*
+	 * data entity for device specific error handler
+	 */
+	unsigned long driver_data[];
+};
+
+struct scsi_target_eh {
+	/*
+	 * add scsi command to error handler so it would be handuled by
+	 * driver's error handle strategy
+	 */
+	void (*add_cmnd)(struct scsi_cmnd *scmd);
+
+	/*
+	 * to judge if the device is busy handling errors, called before
+	 * dispatch scsi cmnd
+	 *
+	 * return 0 if it's ready to accepy scsi cmnd
+	 * return 0 if it's in error handle, command's would not be dispatched
+	 */
+	int (*is_busy)(struct scsi_target *starget);
+
+	/*
+	 * wakeup device's error handle
+	 *
+	 * usually the error handler strategy would not run at once when
+	 * error command is added. This function would be called when any
+	 * scsi cmnd is finished or when scsi cmnd is added.
+	 */
+	int (*wakeup)(struct scsi_target *starget);
+
+	/*
+	 * data entity for device specific error handler
+	 */
+	unsigned long driver_data[];
+};
+
 struct scsi_device {
 	struct Scsi_Host *host;
 	struct request_queue *request_queue;
@@ -258,6 +323,7 @@ struct scsi_device {
 	struct mutex		state_mutex;
 	enum scsi_device_state sdev_state;
 	struct task_struct	*quiesced_by;
+	struct scsi_device_eh	*eh;
 	unsigned long		sdev_data[];
 } __attribute__((aligned(sizeof(unsigned long))));
 
@@ -344,6 +410,7 @@ struct scsi_target {
 	char			scsi_level;
 	enum scsi_target_state	state;
 	void 			*hostdata; /* available to low-level driver */
+	struct scsi_target_eh	*eh;
 	unsigned long		starget_data[]; /* for the transport */
 	/* starget_data must be the last element!!!! */
 } __attribute__((aligned(sizeof(unsigned long))));
-- 
2.35.3

