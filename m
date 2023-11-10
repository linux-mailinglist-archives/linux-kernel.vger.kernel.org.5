Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F057E8336
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346528AbjKJTqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346605AbjKJTpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:45:44 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B9A2F37E;
        Fri, 10 Nov 2023 03:26:31 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AABA1RZ015582;
        Fri, 10 Nov 2023 03:26:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=+KYDJfWs31T0XXXXYK/EPizwatTg/jf3EBfNUxChAwM=;
 b=adxzYVVec6AL47OpDBipASyHX/OYnCbBwuZbDPPLgWlMXgsxkypIZ6Y50yoVXl7Uar3b
 Kc3KNAa8Hk4JhVxVaInMIsb+CofKxNt8xGjT28zofn5EOXgc8a7ChV/RzfE1isfGmFCS
 FfgiTgmoY9j1eCrigzWZQuLnlGbDKnDxn8tGVU7AkO/T6ZsomUBHvOFS3JqhPMWrqu9u
 sbSnsOnAmj6PKoyCd7Rl944eykSVCVB5awLETgOm7Du2kYbYCFHbakzHEi6GMMx8pmEI
 BJaz3LwR2o22NbxCtbE5yVKzWv7DDFuB4NzqejgKV/yzurrcKAu9dmgpJkKXKZdtqyQB pg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3u95qatpgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 03:26:19 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 10 Nov
 2023 03:26:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 10 Nov 2023 03:26:16 -0800
Received: from virtx40.. (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id 48C3F5B6935;
        Fri, 10 Nov 2023 03:26:12 -0800 (PST)
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
Subject: [PATCH v5 5/7] coresight: tmc: Add support for reading tracedata from previous boot
Date:   Fri, 10 Nov 2023 16:55:31 +0530
Message-ID: <20231110112533.2499437-6-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110112533.2499437-1-lcherian@marvell.com>
References: <20231110112533.2499437-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FnGAOABYl1yp3lCpW3f6FbJ6bvdognI7
X-Proofpoint-GUID: FnGAOABYl1yp3lCpW3f6FbJ6bvdognI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_07,2023-11-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

     #dd if=/dev/tmc_etfXX of=~/cstrace.bin

  4. Reset back to normal mode

     #echo 0 > read_prevboot

Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v4:
* Fixed a typo in commit description 
* Added crc32 validation checks for metadata and tracedata
* Added/modified dev_dbg messages for validation checks
* Size field in "struct tmc_crash_metadata" refers to RSZ register and hence
  indicates the size in 32 bit words. ETR metadata follows this convention, the same
  has been extended to ETF metadata as well. 

 .../coresight/coresight-etm4x-core.c          |   1 +
 .../hwtracing/coresight/coresight-tmc-core.c  |  96 +++++++++++-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  64 ++++++++
 .../hwtracing/coresight/coresight-tmc-etr.c   | 148 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h   |   6 +
 include/linux/coresight.h                     |  13 ++
 6 files changed, 326 insertions(+), 2 deletions(-)

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
index 4d7530d6ac91..e6525c3dcf66 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -103,6 +103,60 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
 	return mask;
 }
 
+int tmc_read_prepare_prevboot(struct tmc_drvdata *drvdata)
+{
+	int ret = 0;
+	struct tmc_crash_metadata *mdata;
+	struct coresight_device *csdev = drvdata->csdev;
+
+	if (!drvdata->crash_mdata.vaddr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	mdata = drvdata->crash_mdata.vaddr;
+	/* Check data integrity of metadata */
+	if (mdata->crc32_mdata != find_crash_metadata_crc(mdata)) {
+		dev_dbg(&drvdata->csdev->dev,
+			"CRC mismatch in tmc crash metadata\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	/* Check data integrity of tracedata */
+	if (mdata->crc32_tdata != find_crash_tracedata_crc(drvdata, mdata)) {
+		dev_dbg(&drvdata->csdev->dev,
+			"CRC mismatch in tmc crash tracedata\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	/* Check for valid metadata */
+	if (!mdata->valid) {
+		dev_dbg(&drvdata->csdev->dev,
+			"Data invalid in tmc crash metadata\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Sink specific prevboot mode preparation */
+	ret = prevboot_ops(csdev)->prepare(csdev);
+	if (ret)
+		goto out;
+
+	if (mdata->sts & 0x1)
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
@@ -153,6 +207,10 @@ static int tmc_open(struct inode *inode, struct file *file)
 	struct tmc_drvdata *drvdata = container_of(file->private_data,
 						   struct tmc_drvdata, miscdev);
 
+	/* Advertise if we are opening with a special mode */
+	if (drvdata->mode == CS_MODE_READ_PREVBOOT)
+		dev_dbg(&drvdata->csdev->dev, "TMC read mode for previous boot\n");
+
 	ret = tmc_read_prepare(drvdata);
 	if (ret)
 		return ret;
@@ -331,9 +389,44 @@ static ssize_t buffer_size_store(struct device *dev,
 
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
 
@@ -635,7 +728,8 @@ static void tmc_shutdown(struct amba_device *adev)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	if (drvdata->mode == CS_MODE_DISABLED)
+	if (drvdata->mode == CS_MODE_DISABLED ||
+	    drvdata->mode == CS_MODE_READ_PREVBOOT)
 		goto out;
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index a0c5437b9e9c..a6b6f2f9eaa5 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -648,6 +648,47 @@ static int tmc_panic_sync_etf(struct coresight_device *csdev)
 	return 0;
 }
 
+static int tmc_etb_setup_prevboot_buf(struct tmc_drvdata *drvdata)
+{
+	unsigned long size;
+	struct tmc_crash_metadata *mdata;
+
+	mdata = drvdata->crash_mdata.vaddr;
+	size = mdata->size << 2;
+
+	drvdata->buf = memremap(mdata->trc_paddr, size,
+				MEMREMAP_WB);
+	if (IS_ERR(drvdata->buf))
+		return -ENOMEM;
+	drvdata->len = size;
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
@@ -665,6 +706,11 @@ static const struct coresight_ops_panic tmc_etf_sync_ops = {
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
@@ -673,6 +719,7 @@ const struct coresight_ops tmc_etf_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 	.link_ops	= &tmc_etf_link_ops,
 	.panic_ops	= &tmc_etf_sync_ops,
+	.prevboot_ops	= &tmc_etf_prevboot_ops,
 };
 
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
@@ -693,6 +740,14 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
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
@@ -716,6 +771,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 		__tmc_etb_disable_hw(drvdata);
 	}
 
+mode_valid:
 	drvdata->reading = true;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -735,8 +791,16 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
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
index 38cd4a692b61..62a2ab667c57 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1166,7 +1166,12 @@ ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
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
@@ -1873,6 +1878,124 @@ static int tmc_panic_sync_etr(struct coresight_device *csdev)
 	return 0;
 }
 
+static int tmc_etr_setup_prevboot_buf(struct tmc_drvdata *drvdata)
+{
+	int rc = 0;
+	u64 trace_addr;
+	struct etr_buf *etr_buf;
+	struct etr_flat_buf *resrv_buf;
+	struct tmc_crash_metadata *mdata;
+
+	etr_buf = kzalloc(sizeof(*etr_buf), GFP_KERNEL);
+	if (!etr_buf) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	etr_buf->size = drvdata->crash_tbuf.size;
+
+	resrv_buf = kzalloc(sizeof(*resrv_buf), GFP_KERNEL);
+	if (!resrv_buf) {
+		rc = -ENOMEM;
+		goto rmem_err;
+	}
+
+	mdata = drvdata->crash_mdata.vaddr;
+	trace_addr = mdata->trc_paddr;
+
+	resrv_buf->vaddr = memremap(trace_addr, mdata->size * 4,
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
+	struct tmc_crash_metadata *mdata;
+	struct etr_buf *etr_buf = drvdata->prevboot_buf;
+
+	mdata = drvdata->crash_mdata.vaddr;
+
+	rrp = mdata->rrp;
+	rwp = mdata->rwp;
+	dba = mdata->dba;
+	status = mdata->sts;
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
+	/* Additional sanity checks for validating metadata */
+	if ((etr_buf->offset > etr_buf->size) ||
+	    (etr_buf->len > etr_buf->size)) {
+		dev_dbg(&drvdata->csdev->dev,
+			"Offset and length invalid in tmc crash metadata\n");
+		return -EINVAL;
+	}
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
@@ -1885,9 +2008,15 @@ static const struct coresight_ops_panic tmc_etr_sync_ops = {
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
@@ -1899,12 +2028,21 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
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
@@ -1919,6 +2057,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	if (drvdata->mode == CS_MODE_SYSFS)
 		__tmc_etr_disable_hw(drvdata);
 
+mode_valid:
 	drvdata->reading = true;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -1937,6 +2076,13 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 
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
index 6f13caae6495..6e1e910d5ea4 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -216,6 +216,9 @@ struct tmc_resrv_buf {
  * @idr_mutex:	Access serialisation for idr.
  * @sysfs_buf:	SYSFS buffer for ETR.
  * @perf_buf:	PERF buffer for ETR.
+ * @prevboot_buf: Previous boot buffer for ETR. This is a special purpose
+ *		buffer that is used only for mapping the trace buffer from
+ *		previous boot and not for capturing trace.
  * @crash_tbuf: Used by ETR as hardware trace buffer and for trace data
  *		retention (after crash) only when ETR_MODE_RESRV buffer
  *		mode is enabled. Used by ETF for trace data retention
@@ -247,6 +250,7 @@ struct tmc_drvdata {
 	struct mutex		idr_mutex;
 	struct etr_buf		*sysfs_buf;
 	struct etr_buf		*perf_buf;
+	struct etr_buf		*prevboot_buf;
 	struct tmc_resrv_buf	crash_tbuf;
 	struct tmc_resrv_buf	crash_mdata;
 };
@@ -298,6 +302,8 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
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

