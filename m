Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AFA7D1BC6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 10:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjJUIiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 04:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUIh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 04:37:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BE4D41
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 01:37:56 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SCF9Y3D4HzVlZj;
        Sat, 21 Oct 2023 16:34:09 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 21 Oct 2023 16:37:54 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <suzuki.poulose@arm.com>, <james.clark@arm.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH v2 4/4] coresight: ultrasoc-smb: Use guards to cleanup
Date:   Sat, 21 Oct 2023 16:38:22 +0800
Message-ID: <20231021083822.18239-5-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231021083822.18239-1-hejunhao3@huawei.com>
References: <20231021083822.18239-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/hwtracing/coresight/ultrasoc-smb.c | 70 +++++++---------------
 1 file changed, 22 insertions(+), 48 deletions(-)

diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index 2ee6bf5b725e..5140782b1b5d 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -97,27 +97,19 @@ static int smb_open(struct inode *inode, struct file *file)
 {
 	struct smb_drv_data *drvdata = container_of(file->private_data,
 					struct smb_drv_data, miscdev);
-	int ret = 0;
 
-	spin_lock(&drvdata->spinlock);
+	guard(spinlock)(&drvdata->spinlock);
 
-	if (drvdata->reading) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (drvdata->reading)
+		return -EBUSY;
 
-	if (atomic_read(&drvdata->csdev->refcnt)) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (atomic_read(&drvdata->csdev->refcnt))
+		return -EBUSY;
 
 	smb_update_data_size(drvdata);
-
 	drvdata->reading = true;
-out:
-	spin_unlock(&drvdata->spinlock);
 
-	return ret;
+	return 0;
 }
 
 static ssize_t smb_read(struct file *file, char __user *data, size_t len,
@@ -160,9 +152,8 @@ static int smb_release(struct inode *inode, struct file *file)
 	struct smb_drv_data *drvdata = container_of(file->private_data,
 					struct smb_drv_data, miscdev);
 
-	spin_lock(&drvdata->spinlock);
+	guard(spinlock)(&drvdata->spinlock);
 	drvdata->reading = false;
-	spin_unlock(&drvdata->spinlock);
 
 	return 0;
 }
@@ -255,19 +246,15 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
 	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret = 0;
 
-	spin_lock(&drvdata->spinlock);
+	guard(spinlock)(&drvdata->spinlock);
 
 	/* Do nothing, the trace data is reading by other interface now */
-	if (drvdata->reading) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (drvdata->reading)
+		return -EBUSY;
 
 	/* Do nothing, the SMB is already enabled as other mode */
-	if (drvdata->mode != CS_MODE_DISABLED && drvdata->mode != mode) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (drvdata->mode != CS_MODE_DISABLED && drvdata->mode != mode)
+		return -EBUSY;
 
 	switch (mode) {
 	case CS_MODE_SYSFS:
@@ -281,13 +268,10 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
 	}
 
 	if (ret)
-		goto out;
+		return ret;
 
 	atomic_inc(&csdev->refcnt);
-
 	dev_dbg(&csdev->dev, "Ultrasoc SMB enabled\n");
-out:
-	spin_unlock(&drvdata->spinlock);
 
 	return ret;
 }
@@ -295,19 +279,14 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
 static int smb_disable(struct coresight_device *csdev)
 {
 	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
-	int ret = 0;
 
-	spin_lock(&drvdata->spinlock);
+	guard(spinlock)(&drvdata->spinlock);
 
-	if (drvdata->reading) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (drvdata->reading)
+		return -EBUSY;
 
-	if (atomic_dec_return(&csdev->refcnt)) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (atomic_dec_return(&csdev->refcnt))
+		return -EBUSY;
 
 	/* Complain if we (somehow) got out of sync */
 	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
@@ -317,12 +296,9 @@ static int smb_disable(struct coresight_device *csdev)
 	/* Dissociate from the target process. */
 	drvdata->pid = -1;
 	drvdata->mode = CS_MODE_DISABLED;
-
 	dev_dbg(&csdev->dev, "Ultrasoc SMB disabled\n");
-out:
-	spin_unlock(&drvdata->spinlock);
 
-	return ret;
+	return 0;
 }
 
 static void *smb_alloc_buffer(struct coresight_device *csdev,
@@ -395,17 +371,17 @@ static unsigned long smb_update_buffer(struct coresight_device *csdev,
 	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct smb_data_buffer *sdb = &drvdata->sdb;
 	struct cs_buffers *buf = sink_config;
-	unsigned long data_size = 0;
+	unsigned long data_size;
 	bool lost = false;
 
 	if (!buf)
 		return 0;
 
-	spin_lock(&drvdata->spinlock);
+	guard(spinlock)(&drvdata->spinlock);
 
 	/* Don't do anything if another tracer is using this sink. */
 	if (atomic_read(&csdev->refcnt) != 1)
-		goto out;
+		return 0;
 
 	smb_disable_hw(drvdata);
 	smb_update_data_size(drvdata);
@@ -424,8 +400,6 @@ static unsigned long smb_update_buffer(struct coresight_device *csdev,
 	smb_sync_perf_buffer(drvdata, buf, handle->head);
 	if (!buf->snapshot && lost)
 		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
-out:
-	spin_unlock(&drvdata->spinlock);
 
 	return data_size;
 }
-- 
2.33.0

