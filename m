Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC07B33CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjI2Ni6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjI2Niu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:38:50 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1C42680;
        Fri, 29 Sep 2023 06:38:43 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T27U4q020589;
        Fri, 29 Sep 2023 06:38:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=XzpzDtU+sci3BTK22fAHpWMzoVVdxlEQC1SPdSLBjJo=;
 b=ae0umQiTybXLRhofjtM1Ve0ixJe7CI/0Fbyz/UxYw/D/h2MeCzK6j/7Jdk0p6U6M/aVy
 q3q6hv8lN0M/k0qNlQAJRknK71uQ6GWIJy1WJoJkCaYE7DqSnx1OPqBPtsQQ1JRPmnV0
 mIx0HKjDM4fMoRwXz6H/MrZkawyRSMU6Ic3yue98vIkjpb3Ck8VzDZL6dEErTMUEzw4e
 NQoKlg2fQbu7SscriubB7SZsWpfevqGdVq6iS9XNABUnczzYbUXne4AjfPsYTamFin9n
 NZbq95VdHcxIzzh8GCIo5J8PXWN2+DX8kdLemCpT+x0xeJpBBaoKGzR9RSiHyfn2KrB1 iA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tcrrs986c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 06:38:32 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Sep
 2023 06:38:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 29 Sep 2023 06:38:30 -0700
Received: from virtx40.. (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id DB6925B6943;
        Fri, 29 Sep 2023 06:38:25 -0700 (PDT)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Anil Kumar Reddy <areddy3@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH 5/7] coresight: tmc: Add support for reading tracedata from previous boot
Date:   Fri, 29 Sep 2023 19:07:52 +0530
Message-ID: <20230929133754.857678-6-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929133754.857678-1-lcherian@marvell.com>
References: <20230929133754.857678-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1ypJnMLqtZslDzpviGKNK5rdObTAoE0s
X-Proofpoint-GUID: 1ypJnMLqtZslDzpviGKNK5rdObTAoE0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Introduce a new mode CS_MODE_READ_PREVBOOT for reading tracedata
  captured in previous boot.

* Add special handlers for preparing ETR/ETF for this special mode

* User can read the trace data as below

  For example, for reading trace data from tmc_etf sink

  1. cd /sys/bus/coresight/devices/tmc_etfXX/

  2. Change mode to READ_PREVBOOT

     #echo 1 > read_prevboot

  3. Dump trace buffer data to a file,

     #dd if=/dev/tmc_etrXX of=~/cstrace.bin

  4. Reset back to normal mode

     #echo 0 > read_prevboot

Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
 .../coresight/coresight-etm4x-core.c          |   1 +
 .../hwtracing/coresight/coresight-tmc-core.c  |  81 +++++++++-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  62 ++++++++
 .../hwtracing/coresight/coresight-tmc-etr.c   | 145 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h   |   6 +
 include/linux/coresight.h                     |  13 ++
 6 files changed, 306 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 77b0271ce6eb..513baf681280 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1010,6 +1010,7 @@ static void etm4_disable(struct coresight_device *csdev,
 
 	switch (mode) {
 	case CS_MODE_DISABLED:
+	case CS_MODE_READ_PREVBOOT:
 		break;
 	case CS_MODE_SYSFS:
 		etm4_disable_sysfs(csdev);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 6658ce76777b..65c15c9f821b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -103,6 +103,45 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
 	return mask;
 }
 
+int tmc_read_prepare_prevboot(struct tmc_drvdata *drvdata)
+{
+	int ret = 0;
+	struct tmc_register_snapshot *reg_ptr;
+	struct coresight_device *csdev = drvdata->csdev;
+
+	if (!drvdata->metadata.vaddr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	reg_ptr = drvdata->metadata.vaddr;
+	if (!reg_ptr->valid) {
+		dev_err(&drvdata->csdev->dev,
+			"Invalid metadata captured from previous boot\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Sink specific prevboot mode preparation */
+	ret = prevboot_ops(csdev)->prepare(csdev);
+	if (ret)
+		goto out;
+
+	if (reg_ptr->sts & 0x1)
+		coresight_insert_barrier_packet(drvdata->buf);
+
+out:
+	return ret;
+}
+
+int tmc_read_unprepare_prevboot(struct tmc_drvdata *drvdata)
+{
+	struct coresight_device *csdev = drvdata->csdev;
+
+	/* Sink specific prevboot mode preparation */
+	return prevboot_ops(csdev)->unprepare(csdev);
+}
+
 static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
@@ -153,6 +192,10 @@ static int tmc_open(struct inode *inode, struct file *file)
 	struct tmc_drvdata *drvdata = container_of(file->private_data,
 						   struct tmc_drvdata, miscdev);
 
+	/* Advertise if we are opening with a special mode */
+	if (drvdata->mode == CS_MODE_READ_PREVBOOT)
+		dev_dbg(&drvdata->csdev->dev, "TMC read mode for previous boot\n");
+
 	ret = tmc_read_prepare(drvdata);
 	if (ret)
 		return ret;
@@ -331,9 +374,44 @@ static ssize_t buffer_size_store(struct device *dev,
 
 static DEVICE_ATTR_RW(buffer_size);
 
+static ssize_t read_prevboot_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sprintf(buf, "%#x\n", (drvdata->mode == CS_MODE_READ_PREVBOOT));
+}
+
+static ssize_t read_prevboot_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	int ret;
+	unsigned long val, flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	if (val && (drvdata->mode == CS_MODE_DISABLED))
+		drvdata->mode = CS_MODE_READ_PREVBOOT;
+	else if (!val && (drvdata->mode == CS_MODE_READ_PREVBOOT))
+		drvdata->mode = CS_MODE_DISABLED;
+
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(read_prevboot);
+
 static struct attribute *coresight_tmc_attrs[] = {
 	&dev_attr_trigger_cntr.attr,
 	&dev_attr_buffer_size.attr,
+	&dev_attr_read_prevboot.attr,
 	NULL,
 };
 
@@ -635,7 +713,8 @@ static void tmc_shutdown(struct amba_device *adev)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	if (drvdata->mode == CS_MODE_DISABLED)
+	if (drvdata->mode == CS_MODE_DISABLED ||
+	    drvdata->mode == CS_MODE_READ_PREVBOOT)
 		goto out;
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 40204d5f200f..496b44aad56d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -639,6 +639,45 @@ static int tmc_panic_sync_etf(struct coresight_device *csdev)
 	return 0;
 }
 
+static int tmc_etb_setup_prevboot_buf(struct tmc_drvdata *drvdata)
+{
+	struct tmc_register_snapshot *reg_ptr;
+
+	reg_ptr = drvdata->metadata.vaddr;
+
+	drvdata->buf = memremap(reg_ptr->trc_paddr, reg_ptr->size,
+				MEMREMAP_WB);
+	if (IS_ERR(drvdata->buf))
+		return -ENOMEM;
+	drvdata->len = reg_ptr->size;
+	return 0;
+}
+
+static void tmc_etb_free_prevboot_buf(struct tmc_drvdata *drvdata)
+{
+	void *buf = drvdata->buf;
+
+	if (!buf)
+		return;
+	memunmap(buf);
+	drvdata->buf = NULL;
+}
+
+static int tmc_etb_prepare_prevboot(struct coresight_device *csdev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	return  tmc_etb_setup_prevboot_buf(drvdata);
+}
+
+static int tmc_etb_unprepare_prevboot(struct coresight_device *csdev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	tmc_etb_free_prevboot_buf(drvdata);
+	return 0;
+}
+
 static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.enable		= tmc_enable_etf_sink,
 	.disable	= tmc_disable_etf_sink,
@@ -656,6 +695,11 @@ static const struct coresight_ops_panic tmc_etf_sync_ops = {
 	.sync		= tmc_panic_sync_etf,
 };
 
+static const struct coresight_ops_prevboot tmc_etf_prevboot_ops = {
+	.prepare	= tmc_etb_prepare_prevboot,
+	.unprepare	= tmc_etb_unprepare_prevboot,
+};
+
 const struct coresight_ops tmc_etb_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 };
@@ -664,6 +708,7 @@ const struct coresight_ops tmc_etf_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 	.link_ops	= &tmc_etf_link_ops,
 	.panic_ops	= &tmc_etf_sync_ops,
+	.prevboot_ops	= &tmc_etf_prevboot_ops,
 };
 
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
@@ -684,6 +729,14 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 		goto out;
 	}
 
+	if (drvdata->mode == CS_MODE_READ_PREVBOOT) {
+		ret = tmc_read_prepare_prevboot(drvdata);
+		if (ret)
+			goto out;
+		else
+			goto mode_valid;
+	}
+
 	/* Don't interfere if operated from Perf */
 	if (drvdata->mode == CS_MODE_PERF) {
 		ret = -EINVAL;
@@ -707,6 +760,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 		__tmc_etb_disable_hw(drvdata);
 	}
 
+mode_valid:
 	drvdata->reading = true;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -726,8 +780,16 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
 		return -EINVAL;
 
+
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
+	if (drvdata->mode == CS_MODE_READ_PREVBOOT) {
+		tmc_read_unprepare_prevboot(drvdata);
+		drvdata->reading = false;
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return 0;
+	}
+
 	/* Re-enable the TMC if need be */
 	if (drvdata->mode == CS_MODE_SYSFS) {
 		/* There is no point in reading a TMC in HW FIFO mode */
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 27fc9fdb84cc..c31c71e02833 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1165,7 +1165,12 @@ ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
 {
 	s64 offset;
 	ssize_t actual = len;
-	struct etr_buf *etr_buf = drvdata->sysfs_buf;
+	struct etr_buf *etr_buf;
+
+	if (drvdata->mode == CS_MODE_READ_PREVBOOT)
+		etr_buf = drvdata->prevboot_buf;
+	else
+		etr_buf = drvdata->sysfs_buf;
 
 	if (pos + actual > etr_buf->len)
 		actual = etr_buf->len - pos;
@@ -1864,6 +1869,121 @@ static int tmc_panic_sync_etr(struct coresight_device *csdev)
 	return 0;
 }
 
+static int tmc_etr_setup_prevboot_buf(struct tmc_drvdata *drvdata)
+{
+	int rc = 0;
+	u64 trace_addr;
+	struct etr_buf *etr_buf;
+	struct etr_flat_buf *resrv_buf;
+	struct tmc_register_snapshot *reg_ptr;
+
+	etr_buf = kzalloc(sizeof(*etr_buf), GFP_KERNEL);
+	if (!etr_buf) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	etr_buf->size = drvdata->resrv_buf.size;
+
+	resrv_buf = kzalloc(sizeof(*resrv_buf), GFP_KERNEL);
+	if (!resrv_buf) {
+		rc = -ENOMEM;
+		goto rmem_err;
+	}
+
+	reg_ptr = drvdata->metadata.vaddr;
+	trace_addr = reg_ptr->trc_paddr;
+
+	resrv_buf->vaddr = memremap(trace_addr, reg_ptr->size * 4,
+				    MEMREMAP_WB);
+	if (IS_ERR(drvdata->buf)) {
+		rc = -ENOMEM;
+		goto map_err;
+	}
+	resrv_buf->size = etr_buf->size;
+	resrv_buf->dev = &drvdata->csdev->dev;
+	etr_buf->hwaddr = trace_addr;
+	etr_buf->mode = ETR_MODE_RESRV;
+	etr_buf->private = resrv_buf;
+	etr_buf->ops = etr_buf_ops[ETR_MODE_RESRV];
+
+	drvdata->prevboot_buf = etr_buf;
+
+	return 0;
+
+map_err:
+	kfree(resrv_buf);
+
+rmem_err:
+	kfree(etr_buf);
+
+out:
+	return rc;
+}
+
+static int tmc_etr_sync_prevboot_buf(struct tmc_drvdata *drvdata)
+{
+	u32 status;
+	u64 rrp, rwp, dba;
+	struct tmc_register_snapshot *reg_ptr;
+	struct etr_buf *etr_buf = drvdata->prevboot_buf;
+
+	reg_ptr = drvdata->metadata.vaddr;
+
+	rrp = reg_ptr->rrp;
+	rwp = reg_ptr->rwp;
+	dba = reg_ptr->dba;
+	status = reg_ptr->sts;
+
+	etr_buf->full = !!(status & TMC_STS_FULL);
+
+	/* Sync the buffer pointers */
+	etr_buf->offset = rrp - dba;
+	if (etr_buf->full)
+		etr_buf->len = etr_buf->size;
+	else
+		etr_buf->len = rwp - rrp;
+
+	/* Sanity checks for validating metadata */
+	if ((etr_buf->offset > etr_buf->size) ||
+	    (etr_buf->len > etr_buf->size))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void tmc_etr_free_prevboot_buf(struct tmc_drvdata *drvdata)
+{
+	void *buf = drvdata->prevboot_buf;
+
+	if (!buf)
+		return;
+
+	memunmap(buf);
+	drvdata->prevboot_buf = NULL;
+}
+
+static int tmc_etr_prepare_prevboot(struct coresight_device *csdev)
+{
+	int ret = 0;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	ret = tmc_etr_setup_prevboot_buf(drvdata);
+	if (ret)
+		goto out;
+	ret = tmc_etr_sync_prevboot_buf(drvdata);
+
+out:
+	return ret;
+}
+
+static int tmc_etr_unprepare_prevboot(struct coresight_device *csdev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	tmc_etr_free_prevboot_buf(drvdata);
+	return 0;
+}
+
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
 	.enable		= tmc_enable_etr_sink,
 	.disable	= tmc_disable_etr_sink,
@@ -1876,9 +1996,15 @@ static const struct coresight_ops_panic tmc_etr_sync_ops = {
 	.sync		= tmc_panic_sync_etr,
 };
 
+static const struct coresight_ops_prevboot tmc_etr_prevboot_ops = {
+	.prepare	= tmc_etr_prepare_prevboot,
+	.unprepare	= tmc_etr_unprepare_prevboot,
+};
+
 const struct coresight_ops tmc_etr_cs_ops = {
 	.sink_ops	= &tmc_etr_sink_ops,
 	.panic_ops	= &tmc_etr_sync_ops,
+	.prevboot_ops	= &tmc_etr_prevboot_ops,
 };
 
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
@@ -1890,12 +2016,21 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
 		return -EINVAL;
 
+
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		ret = -EBUSY;
 		goto out;
 	}
 
+	if (drvdata->mode == CS_MODE_READ_PREVBOOT) {
+		ret = tmc_read_prepare_prevboot(drvdata);
+		if (ret)
+			goto out;
+		else
+			goto mode_valid;
+	}
+
 	/*
 	 * We can safely allow reads even if the ETR is operating in PERF mode,
 	 * since the sysfs session is captured in mode specific data.
@@ -1910,6 +2045,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	if (drvdata->mode == CS_MODE_SYSFS)
 		__tmc_etr_disable_hw(drvdata);
 
+mode_valid:
 	drvdata->reading = true;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -1928,6 +2064,13 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
+	if (drvdata->mode == CS_MODE_READ_PREVBOOT) {
+		tmc_read_unprepare_prevboot(drvdata);
+		drvdata->reading = false;
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return 0;
+	}
+
 	/* RE-enable the TMC if need be */
 	if (drvdata->mode == CS_MODE_SYSFS) {
 		/*
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 24ef7bbb0611..f8b79eaac0bd 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -213,6 +213,9 @@ struct tmc_resrv_buf {
  * @idr_mutex:	Access serialisation for idr.
  * @sysfs_buf:	SYSFS buffer for ETR.
  * @perf_buf:	PERF buffer for ETR.
+ * @prevboot_buf: Previous boot buffer for ETR. This is a special purpose
+ *		buffer that is used only for mapping the trace buffer from
+ *		previous boot and not for capturing trace.
  * @resrv_buf: Reserved Memory for trace data buffer. Used by ETR/ETF.
  * @metadata: Reserved memory for metadata. Used by ETR/ETF.
  */
@@ -240,6 +243,7 @@ struct tmc_drvdata {
 	struct mutex		idr_mutex;
 	struct etr_buf		*sysfs_buf;
 	struct etr_buf		*perf_buf;
+	struct etr_buf		*prevboot_buf;
 	struct tmc_resrv_buf	resrv_buf;
 	struct tmc_resrv_buf	metadata;
 };
@@ -291,6 +295,8 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
 void tmc_enable_hw(struct tmc_drvdata *drvdata);
 void tmc_disable_hw(struct tmc_drvdata *drvdata);
 u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
+int tmc_read_prepare_prevboot(struct tmc_drvdata *drvdata);
+int tmc_read_unprepare_prevboot(struct tmc_drvdata *drvdata);
 
 /* ETB/ETF functions */
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4fd518738958..9f84decf1d7a 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -294,6 +294,7 @@ enum cs_mode {
 	CS_MODE_DISABLED,
 	CS_MODE_SYSFS,
 	CS_MODE_PERF,
+	CS_MODE_READ_PREVBOOT, /* Trace data from previous boot */
 };
 
 #define source_ops(csdev)	csdev->ops->source_ops
@@ -302,6 +303,7 @@ enum cs_mode {
 #define helper_ops(csdev)	csdev->ops->helper_ops
 #define ect_ops(csdev)		csdev->ops->ect_ops
 #define panic_ops(csdev)	csdev->ops->panic_ops
+#define prevboot_ops(csdev)	csdev->ops->prevboot_ops
 
 /**
  * struct coresight_ops_sink - basic operations for a sink
@@ -381,12 +383,23 @@ struct coresight_ops_panic {
 	int (*sync)(struct coresight_device *csdev);
 };
 
+/**
+ * struct coresight_ops_prevboot - Generic device ops for prevboot mode
+ *
+ * @prepare	: Preparation for prevboot mode
+ */
+struct coresight_ops_prevboot {
+	int (*prepare)(struct coresight_device *csdev);
+	int (*unprepare)(struct coresight_device *csdev);
+};
+
 struct coresight_ops {
 	const struct coresight_ops_sink *sink_ops;
 	const struct coresight_ops_link *link_ops;
 	const struct coresight_ops_source *source_ops;
 	const struct coresight_ops_helper *helper_ops;
 	const struct coresight_ops_panic *panic_ops;
+	const struct coresight_ops_prevboot *prevboot_ops;
 };
 
 #if IS_ENABLED(CONFIG_CORESIGHT)
-- 
2.34.1

