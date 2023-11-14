Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851767EB0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjKNNdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjKNNdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:33:42 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C11A1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:33:37 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SV6Zh2MTGzMmls;
        Tue, 14 Nov 2023 21:29:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 21:33:35 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <suzuki.poulose@arm.com>, <james.clark@arm.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>,
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 1/4] coresight: ultrasoc-smb: Fix sleep while close preempt in enable_smb
Date:   Tue, 14 Nov 2023 21:33:43 +0800
Message-ID: <20231114133346.30489-2-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231114133346.30489-1-hejunhao3@huawei.com>
References: <20231114133346.30489-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we to enable the SMB by perf, the perf sched will call perf_ctx_lock()
to close system preempt in event_function_call(). But SMB::enable_smb() use
mutex to lock the critical section, which may sleep.

 BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
 in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 153023, name: perf
 preempt_count: 2, expected: 0
 RCU nest depth: 0, expected: 0
 INFO: lockdep is turned off.
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 hardirqs last disabled at (0): [<ffffa2983f5c5f40>] copy_process+0xae8/0x2b48
 softirqs last  enabled at (0): [<ffffa2983f5c5f40>] copy_process+0xae8/0x2b48
 softirqs last disabled at (0): [<0000000000000000>] 0x0
 CPU: 2 PID: 153023 Comm: perf Kdump: loaded Tainted: G   W  O   6.5.0-rc4+ #1

 Call trace:
 ...
  __mutex_lock+0xbc/0xa70
  mutex_lock_nested+0x34/0x48
  smb_update_buffer+0x58/0x360 [ultrasoc_smb]
  etm_event_stop+0x204/0x2d8 [coresight]
  etm_event_del+0x1c/0x30 [coresight]
  event_sched_out+0x17c/0x3b8
  group_sched_out.part.0+0x5c/0x208
  __perf_event_disable+0x15c/0x210
  event_function+0xe0/0x230
  remote_function+0xb4/0xe8
  generic_exec_single+0x160/0x268
  smp_call_function_single+0x20c/0x2a0
  event_function_call+0x20c/0x220
  _perf_event_disable+0x5c/0x90
  perf_event_for_each_child+0x58/0xc0
  _perf_ioctl+0x34c/0x1250
  perf_ioctl+0x64/0x98
 ...

Use spinlock to replace mutex to control driver data access to one at a
time. The function copy_to_user() may sleep, it cannot be in a spinlock
context, so we can't simply replace it in smb_read(). But we can ensure
that only one user gets the SMB device fd by smb_open(), so remove the
locks from smb_read() and buffer synchronization is guaranteed by the user.

Fixes: 06f5c2926aaa ("drivers/coresight: Add UltraSoc System Memory Buffer driver")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/hwtracing/coresight/ultrasoc-smb.c | 35 +++++++++-------------
 drivers/hwtracing/coresight/ultrasoc-smb.h |  6 ++--
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index e9a32a97fbee..0a0fe9fcc57f 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -99,7 +99,7 @@ static int smb_open(struct inode *inode, struct file *file)
 					struct smb_drv_data, miscdev);
 	int ret = 0;
 
-	mutex_lock(&drvdata->mutex);
+	spin_lock(&drvdata->spinlock);
 
 	if (drvdata->reading) {
 		ret = -EBUSY;
@@ -115,7 +115,7 @@ static int smb_open(struct inode *inode, struct file *file)
 
 	drvdata->reading = true;
 out:
-	mutex_unlock(&drvdata->mutex);
+	spin_unlock(&drvdata->spinlock);
 
 	return ret;
 }
@@ -132,10 +132,8 @@ static ssize_t smb_read(struct file *file, char __user *data, size_t len,
 	if (!len)
 		return 0;
 
-	mutex_lock(&drvdata->mutex);
-
 	if (!sdb->data_size)
-		goto out;
+		return 0;
 
 	to_copy = min(sdb->data_size, len);
 
@@ -145,20 +143,15 @@ static ssize_t smb_read(struct file *file, char __user *data, size_t len,
 
 	if (copy_to_user(data, sdb->buf_base + sdb->buf_rdptr, to_copy)) {
 		dev_dbg(dev, "Failed to copy data to user\n");
-		to_copy = -EFAULT;
-		goto out;
+		return -EFAULT;
 	}
 
 	*ppos += to_copy;
-
 	smb_update_read_ptr(drvdata, to_copy);
-
-	dev_dbg(dev, "%zu bytes copied\n", to_copy);
-out:
 	if (!sdb->data_size)
 		smb_reset_buffer(drvdata);
-	mutex_unlock(&drvdata->mutex);
 
+	dev_dbg(dev, "%zu bytes copied\n", to_copy);
 	return to_copy;
 }
 
@@ -167,9 +160,9 @@ static int smb_release(struct inode *inode, struct file *file)
 	struct smb_drv_data *drvdata = container_of(file->private_data,
 					struct smb_drv_data, miscdev);
 
-	mutex_lock(&drvdata->mutex);
+	spin_lock(&drvdata->spinlock);
 	drvdata->reading = false;
-	mutex_unlock(&drvdata->mutex);
+	spin_unlock(&drvdata->spinlock);
 
 	return 0;
 }
@@ -262,7 +255,7 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
 	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret = 0;
 
-	mutex_lock(&drvdata->mutex);
+	spin_lock(&drvdata->spinlock);
 
 	/* Do nothing, the trace data is reading by other interface now */
 	if (drvdata->reading) {
@@ -294,7 +287,7 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
 
 	dev_dbg(&csdev->dev, "Ultrasoc SMB enabled\n");
 out:
-	mutex_unlock(&drvdata->mutex);
+	spin_unlock(&drvdata->spinlock);
 
 	return ret;
 }
@@ -304,7 +297,7 @@ static int smb_disable(struct coresight_device *csdev)
 	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret = 0;
 
-	mutex_lock(&drvdata->mutex);
+	spin_lock(&drvdata->spinlock);
 
 	if (drvdata->reading) {
 		ret = -EBUSY;
@@ -327,7 +320,7 @@ static int smb_disable(struct coresight_device *csdev)
 
 	dev_dbg(&csdev->dev, "Ultrasoc SMB disabled\n");
 out:
-	mutex_unlock(&drvdata->mutex);
+	spin_unlock(&drvdata->spinlock);
 
 	return ret;
 }
@@ -408,7 +401,7 @@ static unsigned long smb_update_buffer(struct coresight_device *csdev,
 	if (!buf)
 		return 0;
 
-	mutex_lock(&drvdata->mutex);
+	spin_lock(&drvdata->spinlock);
 
 	/* Don't do anything if another tracer is using this sink. */
 	if (atomic_read(&csdev->refcnt) != 1)
@@ -432,7 +425,7 @@ static unsigned long smb_update_buffer(struct coresight_device *csdev,
 	if (!buf->snapshot && lost)
 		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 out:
-	mutex_unlock(&drvdata->mutex);
+	spin_unlock(&drvdata->spinlock);
 
 	return data_size;
 }
@@ -590,7 +583,7 @@ static int smb_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	mutex_init(&drvdata->mutex);
+	spin_lock_init(&drvdata->spinlock);
 	drvdata->pid = -1;
 
 	ret = smb_register_sink(pdev, drvdata);
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.h b/drivers/hwtracing/coresight/ultrasoc-smb.h
index d2e14e8d2c8a..82a44c14a882 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.h
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
@@ -8,7 +8,7 @@
 #define _ULTRASOC_SMB_H
 
 #include <linux/miscdevice.h>
-#include <linux/mutex.h>
+#include <linux/spinlock.h>
 
 /* Offset of SMB global registers */
 #define SMB_GLB_CFG_REG		0x00
@@ -105,7 +105,7 @@ struct smb_data_buffer {
  * @csdev:	Component vitals needed by the framework.
  * @sdb:	Data buffer for SMB.
  * @miscdev:	Specifics to handle "/dev/xyz.smb" entry.
- * @mutex:	Control data access to one at a time.
+ * @spinlock:	Control data access to one at a time.
  * @reading:	Synchronise user space access to SMB buffer.
  * @pid:	Process ID of the process being monitored by the
  *		session that is using this component.
@@ -116,7 +116,7 @@ struct smb_drv_data {
 	struct coresight_device	*csdev;
 	struct smb_data_buffer sdb;
 	struct miscdevice miscdev;
-	struct mutex mutex;
+	spinlock_t spinlock;
 	bool reading;
 	pid_t pid;
 	enum cs_mode mode;
-- 
2.33.0

