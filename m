Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD377A750
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHMPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjHMPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:13:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D798E6A;
        Sun, 13 Aug 2023 08:13:49 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37DF7DB6032045;
        Sun, 13 Aug 2023 15:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=QT2BpjsQJBSxU8yICeONrrSMbH94MtRJ8WU/bltVeVY=;
 b=HHZCnEcQI0hNtlvnA/lDYuwXAopuHF2PbJ+kF5vTez+pVN6QEU5rLDI7nHgRy75nMSkm
 RoQvK52IJTbbgkVEn6W1c3Xj33aPS52/A5gTKXkhfmELfHRiVWIELqLSi5JAnYgUH+Cb
 TOH+O2tuNotLY6wmnYPtnH2A1lsqBcAafgxCtiBfFZJFPo925T6Q3fxZAbT8xIJCYnf0
 cwvuI6zeWubJNOV+RZSMPu5vL8sS3NPAbC6o234d9NTXx2XiM9+qjru5iBhVR7qigj4/
 SwTUmu3pShfWFVHAfP7d2X75QVGtVqKlx3yLd4JuJjHHz8xKwN6EupghtQifA5bFRviy Bw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3srssrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 15:13:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37DFDT9r029293
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 15:13:29 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 13 Aug 2023 08:13:23 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v2 3/3] coresight-csr: Add support for streaming interface for ETR
Date:   Sun, 13 Aug 2023 23:12:53 +0800
Message-ID: <20230813151253.38128-4-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230813151253.38128-1-quic_jinlmao@quicinc.com>
References: <20230813151253.38128-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PG7gDRvRkIZ0E_Yvqq_6WC8bo08TutDA
X-Proofpoint-ORIG-GUID: PG7gDRvRkIZ0E_Yvqq_6WC8bo08TutDA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308130143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a streaming interface for TMC ETR to allow for continuous
log collection to secondary storage. An interrupt based mechanism is used
to stream out the data from the device.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-csr   |   6 +
 drivers/hwtracing/coresight/Makefile          |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |  31 +-
 .../coresight/coresight-csr-bytecntr.c        | 275 ++++++++++++++++
 .../hwtracing/coresight/coresight-csr-core.c  | 293 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-csr.h   |  80 +++++
 drivers/hwtracing/coresight/coresight-priv.h  |   8 +
 .../hwtracing/coresight/coresight-tmc-etr.c   |   3 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
 include/linux/coresight.h                     |   3 +-
 10 files changed, 694 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-csr
 create mode 100644 drivers/hwtracing/coresight/coresight-csr-bytecntr.c

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-csr b/Documentation/ABI/testing/sysfs-bus-coresight-devices-csr
new file mode 100644
index 000000000000..2694ed527a50
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-csr
@@ -0,0 +1,6 @@
+What:		/sys/bus/coresight/devices/<memory_map>.csr/etr_byte_cntr_val
+Date:		August 2023
+KernelVersion:	6.5
+Contact:	Mao Jinlong <quic_jinlmao@quicinc.com>
+Description:	(RW) Size of the ETR irq byte counter value.
+
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 6f8d17003ff7..3e20030b6242 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -32,4 +32,4 @@ coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
 obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
 obj-$(CONFIG_CORESIGHT_CSR) += coresight-csr.o
-coresight-csr-y := coresight-csr-core.o
+coresight-csr-y := coresight-csr-core.o coresight-csr-bytecntr.o
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 9fabe00a40d6..72d54092d839 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -60,6 +60,7 @@ const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fff
 EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
 
 static const struct cti_assoc_op *cti_assoc_ops;
+static const struct csr_assoc_op *csr_assoc_ops;
 
 ssize_t coresight_simple_show_pair(struct device *_dev,
 			      struct device_attribute *attr, char *buf)
@@ -89,6 +90,18 @@ ssize_t coresight_simple_show32(struct device *_dev,
 }
 EXPORT_SYMBOL_GPL(coresight_simple_show32);
 
+void coresight_set_csr_ops(const struct csr_assoc_op *csr_op)
+{
+	csr_assoc_ops = csr_op;
+}
+EXPORT_SYMBOL_GPL(coresight_set_csr_ops);
+
+void coresight_remove_csr_ops(void)
+{
+	csr_assoc_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(coresight_remove_csr_ops);
+
 void coresight_set_cti_ops(const struct cti_assoc_op *cti_op)
 {
 	cti_assoc_ops = cti_op;
@@ -416,14 +429,14 @@ static int coresight_enable_helper(struct coresight_device *csdev,
 	return 0;
 }
 
-static void coresight_disable_helper(struct coresight_device *csdev)
+static void coresight_disable_helper(struct coresight_device *csdev, void *data)
 {
 	int ret;
 
 	if (!helper_ops(csdev)->disable)
 		return;
 
-	ret = helper_ops(csdev)->disable(csdev, NULL);
+	ret = helper_ops(csdev)->disable(csdev, data);
 	if (ret)
 		return;
 	csdev->enable = false;
@@ -437,7 +450,7 @@ static void coresight_disable_helpers(struct coresight_device *csdev)
 	for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
 		helper = csdev->pdata->out_conns[i]->dest_dev;
 		if (helper && coresight_is_helper(helper))
-			coresight_disable_helper(helper);
+			coresight_disable_helper(helper, csdev);
 	}
 }
 
@@ -535,7 +548,11 @@ static int coresight_enable_helpers(struct coresight_device *csdev,
 		if (!helper || !coresight_is_helper(helper))
 			continue;
 
-		ret = coresight_enable_helper(helper, mode, data);
+		if (helper->subtype.helper_subtype == CORESIGHT_DEV_SUBTYPE_HELPER_CSR)
+			ret = coresight_enable_helper(helper, mode, csdev);
+		else
+			ret = coresight_enable_helper(helper, mode, data);
+
 		if (ret)
 			return ret;
 	}
@@ -1639,6 +1656,9 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	if (!ret) {
 		if (cti_assoc_ops && cti_assoc_ops->add)
 			cti_assoc_ops->add(csdev);
+
+		if (csr_assoc_ops && csr_assoc_ops->add)
+			csr_assoc_ops->add(csdev);
 		return csdev;
 	}
 
@@ -1661,6 +1681,9 @@ void coresight_unregister(struct coresight_device *csdev)
 	/* Remove references of that device in the topology */
 	if (cti_assoc_ops && cti_assoc_ops->remove)
 		cti_assoc_ops->remove(csdev);
+
+	if (csr_assoc_ops && csr_assoc_ops->remove)
+		csr_assoc_ops->remove(csdev);
 	coresight_remove_conns(csdev);
 	coresight_clear_default_sink(csdev);
 	coresight_release_platform_data(csdev, csdev->dev.parent, csdev->pdata);
diff --git a/drivers/hwtracing/coresight/coresight-csr-bytecntr.c b/drivers/hwtracing/coresight/coresight-csr-bytecntr.c
new file mode 100644
index 000000000000..1a94498897e0
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-csr-bytecntr.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "coresight-csr.h"
+
+/* Read the data from ETR's DDR buffer */
+static void tmc_etr_read_bytes(struct byte_cntr *byte_cntr_data, long offset,
+			       size_t bytes, size_t *len, char **bufp)
+{
+	struct csr_assoc_data *assoc_data =
+			container_of(byte_cntr_data, struct csr_assoc_data, byte_cntr_data);
+	struct tmc_drvdata *tmcdrvdata = dev_get_drvdata(assoc_data->assoc_csdev->dev.parent);
+	struct etr_buf *etr_buf = tmcdrvdata->sysfs_buf;
+	size_t actual;
+
+	if (*len >= bytes)
+		*len = bytes;
+	else if (((uint32_t)offset % bytes) + *len > bytes)
+		*len = bytes - ((uint32_t)offset % bytes);
+
+	actual = tmc_etr_buf_get_data(etr_buf, offset, *len, bufp);
+	*len = actual;
+	if (actual == bytes || (actual + (uint32_t)offset) % bytes == 0)
+		atomic_dec(&byte_cntr_data->irq_cnt);
+}
+
+static irqreturn_t etr_handler(int irq, void *data)
+{
+	struct byte_cntr *byte_cntr_data = data;
+
+	atomic_inc(&byte_cntr_data->irq_cnt);
+	wake_up(&byte_cntr_data->wq);
+
+	return IRQ_HANDLED;
+}
+
+/* Read function for /dev/byte-cntr */
+static ssize_t tmc_etr_byte_cntr_read(struct file *fp, char __user *data,
+			       size_t len, loff_t *ppos)
+{
+	struct byte_cntr *byte_cntr_data = fp->private_data;
+	struct csr_assoc_data *assoc_data =
+			container_of(byte_cntr_data, struct csr_assoc_data, byte_cntr_data);
+	struct tmc_drvdata *tmcdrvdata = dev_get_drvdata(assoc_data->assoc_csdev->dev.parent);
+	char *bufp = NULL;
+	int ret = 0;
+
+	if (!data)
+		return -EINVAL;
+
+	mutex_lock(&byte_cntr_data->byte_cntr_lock);
+
+	if (byte_cntr_data->enable) {
+		if (!atomic_read(&byte_cntr_data->irq_cnt)) {
+			mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+			if (wait_event_interruptible(byte_cntr_data->wq,
+				atomic_read(&byte_cntr_data->irq_cnt) > 0
+				|| !byte_cntr_data->enable))
+				return -ERESTARTSYS;
+			mutex_lock(&byte_cntr_data->byte_cntr_lock);
+		}
+
+		tmc_etr_read_bytes(byte_cntr_data, byte_cntr_data->offset,
+				   byte_cntr_data->block_size, &len, &bufp);
+	} else {
+		ret = -EINVAL;
+		goto err0;
+	}
+
+	if (copy_to_user(data, bufp, len)) {
+		mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+		return -EFAULT;
+	}
+
+	if (byte_cntr_data->offset + len >= tmcdrvdata->size)
+		byte_cntr_data->offset = 0;
+	else
+		byte_cntr_data->offset += len;
+
+	goto out;
+
+err0:
+	mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+	return ret;
+out:
+	mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+	return len;
+}
+
+/* Start byte-cntr function. */
+void csr_byte_cntr_start(struct byte_cntr *byte_cntr_data)
+{
+	if (!byte_cntr_data)
+		return;
+
+	mutex_lock(&byte_cntr_data->byte_cntr_lock);
+
+	/*
+	 * When block_size is not set or /dev/byte-cntr
+	 * is being read, don't start byte-cntr function.
+	 */
+	if (byte_cntr_data->block_size <= 0 || byte_cntr_data->read_active) {
+		mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+		return;
+	}
+
+	atomic_set(&byte_cntr_data->irq_cnt, 0);
+	byte_cntr_data->enable = true;
+	mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+}
+
+/* Stop byte-cntr function */
+void csr_byte_cntr_stop(struct byte_cntr *byte_cntr_data)
+{
+	mutex_lock(&byte_cntr_data->byte_cntr_lock);
+	byte_cntr_data->enable = false;
+	byte_cntr_data->read_active = false;
+	atomic_set(&byte_cntr_data->irq_cnt, 0);
+	wake_up(&byte_cntr_data->wq);
+	mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+}
+
+static int tmc_etr_byte_cntr_release(struct inode *in, struct file *fp)
+{
+	struct byte_cntr *byte_cntr_data = fp->private_data;
+
+	mutex_lock(&byte_cntr_data->byte_cntr_lock);
+	byte_cntr_data->read_active = false;
+	atomic_set(&byte_cntr_data->irq_cnt, 0);
+	disable_irq_wake(byte_cntr_data->byte_cntr_irq);
+	mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+
+	return 0;
+}
+
+static int tmc_etr_byte_cntr_open(struct inode *in, struct file *fp)
+{
+	struct byte_cntr *byte_cntr_data =
+			container_of(in->i_cdev, struct byte_cntr, dev);
+	struct csr_assoc_data *assoc_data =
+			container_of(byte_cntr_data, struct csr_assoc_data, byte_cntr_data);
+	struct tmc_drvdata *tmcdrvdata = dev_get_drvdata(assoc_data->assoc_csdev->dev.parent);
+
+	mutex_lock(&byte_cntr_data->byte_cntr_lock);
+
+	if (byte_cntr_data->read_active) {
+		mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+		return -EBUSY;
+	}
+
+	if (tmcdrvdata->mode != CS_MODE_SYSFS ||
+			!byte_cntr_data->block_size) {
+		mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+		return -EINVAL;
+	}
+
+	enable_irq_wake(byte_cntr_data->byte_cntr_irq);
+
+	fp->private_data = byte_cntr_data;
+	nonseekable_open(in, fp);
+	byte_cntr_data->enable = true;
+	byte_cntr_data->read_active = true;
+	mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+	return 0;
+}
+
+static const struct file_operations byte_cntr_fops = {
+	.owner		= THIS_MODULE,
+	.open		= tmc_etr_byte_cntr_open,
+	.read		= tmc_etr_byte_cntr_read,
+	.release	= tmc_etr_byte_cntr_release,
+	.llseek		= no_llseek,
+};
+
+static int byte_cntr_register_chardev(struct byte_cntr *byte_cntr_data)
+{
+	int ret;
+	unsigned int baseminor = 0;
+	unsigned int count = 1;
+	struct device *device;
+	dev_t dev;
+
+	ret = alloc_chrdev_region(&dev, baseminor, count, byte_cntr_data->name);
+	if (ret < 0) {
+		pr_err("alloc_chrdev_region failed %d\n", ret);
+		return ret;
+	}
+	cdev_init(&byte_cntr_data->dev, &byte_cntr_fops);
+
+	byte_cntr_data->dev.owner = THIS_MODULE;
+	byte_cntr_data->dev.ops = &byte_cntr_fops;
+
+	ret = cdev_add(&byte_cntr_data->dev, dev, 1);
+	if (ret)
+		goto exit_unreg_chrdev_region;
+
+	byte_cntr_data->driver_class = class_create(byte_cntr_data->class_name);
+	if (IS_ERR(byte_cntr_data->driver_class)) {
+		ret = -ENOMEM;
+		pr_err("class_create failed %d\n", ret);
+		goto exit_unreg_chrdev_region;
+	}
+
+	device = device_create(byte_cntr_data->driver_class, NULL,
+			       byte_cntr_data->dev.dev, byte_cntr_data,
+			       byte_cntr_data->name);
+
+	if (IS_ERR(device)) {
+		pr_err("class_device_create failed %d\n", ret);
+		ret = -ENOMEM;
+		goto exit_destroy_class;
+	}
+
+	return 0;
+
+exit_destroy_class:
+	class_destroy(byte_cntr_data->driver_class);
+exit_unreg_chrdev_region:
+	unregister_chrdev_region(byte_cntr_data->dev.dev, 1);
+	return ret;
+}
+
+int byte_cntr_init(struct csr_drvdata *drvdata, struct csr_assoc_data *assoc_data)
+{
+	int byte_cntr_irq;
+	int ret = 0;
+	struct device *dev = drvdata->dev;
+
+	byte_cntr_irq = fwnode_irq_get_byname(assoc_data->fnode, CSR_DT_BYTECNTR_IRQ);
+	if (byte_cntr_irq < 0)
+		return byte_cntr_irq;
+
+	ret = fwnode_property_read_string(assoc_data->fnode, CSR_DT_BYTECNTR_NAME,
+				&assoc_data->byte_cntr_data.name);
+	if (ret)
+		assoc_data->byte_cntr_data.name = "byte-cntr";
+
+	ret = fwnode_property_read_string(assoc_data->fnode, CSR_DT_BYTECNTR_CLASS_NAME,
+				&assoc_data->byte_cntr_data.class_name);
+	if (ret)
+		assoc_data->byte_cntr_data.class_name = "coresight-tmc-etr-stream";
+
+	ret = fwnode_property_read_u32(assoc_data->fnode, CSR_DT_BYTECNTVAL_OFFSET,
+				&assoc_data->byte_cntr_data.byte_cntr_offset);
+	if (ret)
+		assoc_data->byte_cntr_data.byte_cntr_offset = CSR_ETR_BYTECNTVAL;
+
+	ret = devm_request_irq(dev, byte_cntr_irq, etr_handler,
+			       IRQF_TRIGGER_RISING | IRQF_SHARED,
+			       assoc_data->assoc_dev_name, &assoc_data->byte_cntr_data);
+	if (ret)
+		return ret;
+
+	ret = byte_cntr_register_chardev(&assoc_data->byte_cntr_data);
+	if (ret)
+		return ret;
+
+	assoc_data->byte_cntr_data.byte_cntr_irq = byte_cntr_irq;
+	atomic_set(&assoc_data->byte_cntr_data.irq_cnt, 0);
+	init_waitqueue_head(&assoc_data->byte_cntr_data.wq);
+	mutex_init(&assoc_data->byte_cntr_data.byte_cntr_lock);
+
+	return ret;
+}
+
+void byte_cntr_remove(struct byte_cntr *byte_cntr_data)
+{
+	device_destroy(byte_cntr_data->driver_class,
+				byte_cntr_data->dev.dev);
+	class_destroy(byte_cntr_data->driver_class);
+	unregister_chrdev_region(byte_cntr_data->dev.dev, 1);
+}
+
diff --git a/drivers/hwtracing/coresight/coresight-csr-core.c b/drivers/hwtracing/coresight/coresight-csr-core.c
index e07070b650d3..6195c9c3b3e5 100644
--- a/drivers/hwtracing/coresight/coresight-csr-core.c
+++ b/drivers/hwtracing/coresight/coresight-csr-core.c
@@ -13,9 +13,274 @@
 
 #include "coresight-priv.h"
 #include "coresight-csr.h"
+#include <dt-bindings/arm/coresight-csr-dt.h>
+
+static LIST_HEAD(csr_list);
 
 DEFINE_CORESIGHT_DEVLIST(csr_devs, "csr");
 
+#define csdev_to_csr_drvdata(csdev)	\
+	dev_get_drvdata(csdev->dev.parent)
+
+static ssize_t etr_byte_cntr_val_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct csr_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return scnprintf(buf, PAGE_SIZE, "%#x\n", drvdata->etr_byte_cntr_value);
+}
+
+static ssize_t etr_byte_cntr_val_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t size)
+{
+	unsigned long val, flags;
+	int ret;
+	struct csr_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	ret = clk_prepare_enable(drvdata->clk);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&drvdata->spin_lock, flags);
+
+	if (kstrtoul(buf, 16, &val)) {
+		spin_unlock_irqrestore(&drvdata->spin_lock, flags);
+		return -EINVAL;
+	}
+
+	drvdata->etr_byte_cntr_value = val;
+	CS_UNLOCK(drvdata->base);
+	/*
+	 * A zero setting disables the interrupt. A one
+	 * setting means 8 bytes, two 16 bytes, etc. In
+	 * other words, the value in this register is the
+	 * interrupt threshold times 8 bytes.
+	 */
+	writel_relaxed(val / 8, drvdata->base + CSR_ETR_BYTECNTVAL);
+	CS_LOCK(drvdata->base);
+
+	spin_unlock_irqrestore(&drvdata->spin_lock, flags);
+
+	clk_disable_unprepare(drvdata->clk);
+	return size;
+}
+static DEVICE_ATTR_RW(etr_byte_cntr_val);
+
+static struct attribute *csr_attrs[] = {
+	&dev_attr_etr_byte_cntr_val.attr,
+	NULL,
+};
+
+static struct attribute_group csr_attr_grp = {
+	.attrs = csr_attrs,
+};
+
+static const struct attribute_group *csr_attr_grps[] = {
+	&csr_attr_grp,
+	NULL,
+};
+
+static int csr_read_bytecntr_value(struct csr_drvdata *drvdata, void __iomem *address)
+{
+	int ret;
+	int byte_cntr_value;
+
+	ret = clk_prepare_enable(drvdata->clk);
+	if (ret)
+		return ret;
+
+	byte_cntr_value = readl_relaxed(address);
+	clk_disable_unprepare(drvdata->clk);
+
+	return byte_cntr_value;
+}
+
+static int csr_enable(struct coresight_device *csdev, enum cs_mode mode,
+		       void *data)
+{
+	struct csr_drvdata *drvdata;
+	struct coresight_device *assoc_csdev = (struct coresight_device *)data;
+	struct csr_assoc_data *assoc_data = NULL;
+	u32 byte_cntr_value;
+	u32 offset;
+
+	drvdata = csdev_to_csr_drvdata(csdev);
+	list_for_each_entry(assoc_data, &drvdata->csr_assoc, node) {
+		/* Get the assocated data of the device by the device name */
+		if (!strcmp(dev_name(&assoc_csdev->dev),
+						dev_name(&assoc_data->assoc_csdev->dev))) {
+			/* If it is ETR device, start byte-cntr function. */
+			if (assoc_data->assoc_csdev->type == CORESIGHT_DEV_TYPE_SINK) {
+				offset = assoc_data->byte_cntr_data.byte_cntr_offset;
+				byte_cntr_value = csr_read_bytecntr_value(drvdata,
+							drvdata->base + offset);
+				if (byte_cntr_value > 0) {
+					assoc_data->byte_cntr_data.block_size = byte_cntr_value * 8;
+					csr_byte_cntr_start(&assoc_data->byte_cntr_data);
+				}
+			}
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int csr_disable(struct coresight_device *csdev, void *data)
+{
+	struct csr_drvdata *drvdata;
+	struct csr_assoc_data *assoc_data = NULL;
+	struct coresight_device *assoc_csdev = (struct coresight_device *)data;
+	u32 byte_cntr_value;
+	u32 offset;
+
+	drvdata = csdev_to_csr_drvdata(csdev);
+
+	list_for_each_entry(assoc_data, &drvdata->csr_assoc, node) {
+		if (!strcmp(dev_name(&assoc_csdev->dev),
+					dev_name(&assoc_data->assoc_csdev->dev))) {
+			if (assoc_data->assoc_csdev->type == CORESIGHT_DEV_TYPE_SINK) {
+				offset = assoc_data->byte_cntr_data.byte_cntr_offset;
+				byte_cntr_value = csr_read_bytecntr_value(drvdata,
+							drvdata->base + offset);
+				if (byte_cntr_value > 0) {
+					assoc_data->byte_cntr_data.block_size = 0;
+					csr_byte_cntr_stop(&assoc_data->byte_cntr_data);
+				}
+			}
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static const struct coresight_ops_helper csr_helper_ops = {
+	.enable = csr_enable,
+	.disable = csr_disable,
+};
+
+static const struct coresight_ops csr_ops = {
+	.helper_ops = &csr_helper_ops,
+};
+
+const char *csr_plat_get_node_name(struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		return of_node_full_name(to_of_node(fwnode));
+	return "unknown";
+}
+
+static bool csr_plat_node_name_eq(struct fwnode_handle *fwnode,
+				  const char *name)
+{
+	if (is_of_node(fwnode))
+		return of_node_name_eq(to_of_node(fwnode), name);
+	return false;
+}
+
+static void csr_add_assoc_to_csdev(struct coresight_device *csdev)
+{
+	struct csr_drvdata *drvdata;
+	struct csr_assoc_data *assoc_data = NULL;
+	const char *name = NULL;
+
+	name = csr_plat_get_node_name(dev_fwnode(csdev->dev.parent));
+	list_for_each_entry(drvdata, &csr_list, node) {
+		list_for_each_entry(assoc_data, &drvdata->csr_assoc, node) {
+			if (!strcmp(assoc_data->assoc_dev_name, name)) {
+				assoc_data->assoc_dev_name = dev_name(&csdev->dev);
+				assoc_data->assoc_csdev = csdev;
+				coresight_add_helper(csdev, drvdata->csdev);
+				break;
+			}
+		}
+	}
+}
+
+static void csr_remove_assoc_from_csdev(struct coresight_device *csdev)
+{
+	struct csr_drvdata *drvdata;
+	struct csr_assoc_data *assoc_data = NULL;
+	const char *name = NULL;
+
+	name = csr_plat_get_node_name(dev_fwnode(csdev->dev.parent));
+	list_for_each_entry(drvdata, &csr_list, node) {
+		list_for_each_entry(assoc_data, &drvdata->csr_assoc, node) {
+			if (!strcmp(assoc_data->assoc_dev_name, name)) {
+				assoc_data->assoc_csdev = NULL;
+				break;
+			}
+		}
+	}
+}
+
+static struct csr_assoc_op csr_assoc_ops = {
+	.add = csr_add_assoc_to_csdev,
+	.remove = csr_remove_assoc_from_csdev
+};
+
+/**
+ * Get the data of the assocated device to CSR.
+ * @dev:	Device of CSR.
+ * @drvdata:	Driver data of CSR.
+ */
+static int csr_get_assoc_data(struct device *dev, struct csr_drvdata *drvdata)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct fwnode_handle *child = NULL;
+	struct fwnode_handle *cs_fwnode = NULL;
+	struct csr_assoc_data *assoc_data = NULL;
+	struct coresight_device *csdev = NULL;
+	u32 dev_type;
+	int ret;
+
+	if (IS_ERR_OR_NULL(fwnode))
+		return -EINVAL;
+
+	/* Get the data from each child node of the CSR node. */
+	fwnode_for_each_child_node(fwnode, child) {
+		if (csr_plat_node_name_eq(child, CSR_DT_ASSOC_DEVICE)) {
+			assoc_data = devm_kzalloc(dev, sizeof(struct csr_assoc_data), GFP_KERNEL);
+			if (!assoc_data)
+				return -ENOMEM;
+
+			/* Assocated DT node */
+			cs_fwnode = fwnode_find_reference(child, CSR_DT_CSDEV_ASSOC, 0);
+			if (IS_ERR(cs_fwnode))
+				return -EINVAL;
+
+			/* Find the assocated csdev by fwnode. */
+			csdev = coresight_find_csdev_by_fwnode(cs_fwnode);
+			if (csdev) {
+				assoc_data->assoc_dev_name = dev_name(&csdev->dev);
+				assoc_data->assoc_csdev = csdev;
+			} else {
+				assoc_data->assoc_dev_name = csr_plat_get_node_name(cs_fwnode);
+				assoc_data->assoc_csdev = NULL;
+			}
+			assoc_data->fnode = child;
+			ret = fwnode_property_read_u32(child, CSR_DT_CSDEV_ASSOC_DEV_TYPE,
+					&dev_type);
+			if (ret)
+				return ret;
+			/* If assocated device is ETR device. Init all the byte counter data*/
+			if (dev_type == CSR_ASSOC_DEV_ETR) {
+				assoc_data->dev_type = CSR_ASSOC_DEV_ETR;
+				byte_cntr_init(drvdata, assoc_data);
+			}
+			/* Add assocate data to the list */
+			list_add_tail(&assoc_data->node, &drvdata->csr_assoc);
+		}
+	}
+
+	fwnode_handle_put(child);
+	return 0;
+}
+
 static int csr_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -23,6 +288,7 @@ static int csr_probe(struct platform_device *pdev)
 	struct csr_drvdata *drvdata;
 	struct resource *res;
 	struct coresight_desc desc = { 0 };
+	int ret = 0;
 
 	desc.name = coresight_alloc_device_name(&csr_devs, dev);
 	if (!desc.name)
@@ -51,23 +317,40 @@ static int csr_probe(struct platform_device *pdev)
 	if (!drvdata->base)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&drvdata->csr_assoc);
+	ret = csr_get_assoc_data(dev, drvdata);
+	if (ret)
+		return ret;
+
 	desc.type = CORESIGHT_DEV_TYPE_HELPER;
+	desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CSR;
 	desc.pdata = pdev->dev.platform_data;
 	desc.dev = &pdev->dev;
+	desc.groups = csr_attr_grps;
+	desc.ops = &csr_ops;
 
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
 
+	list_add(&drvdata->node, &csr_list);
 	spin_lock_init(&drvdata->spin_lock);
 
 	dev_dbg(dev, "CSR initialized: %s\n", dev_name(dev));
-	return 0;
+	return ret;
 }
 
 static int csr_remove(struct platform_device *pdev)
 {
 	struct csr_drvdata *drvdata = platform_get_drvdata(pdev);
+	struct csr_assoc_data *assoc_data = NULL;
+
+	list_for_each_entry(drvdata, &csr_list, node) {
+		list_for_each_entry(assoc_data, &drvdata->csr_assoc, node) {
+			if (assoc_data->assoc_csdev->type == CORESIGHT_DEV_TYPE_SINK)
+				byte_cntr_remove(&assoc_data->byte_cntr_data);
+		}
+	}
 
 	coresight_unregister(drvdata->csdev);
 	return 0;
@@ -90,12 +373,18 @@ static struct platform_driver csr_driver = {
 
 static int __init csr_init(void)
 {
-	return platform_driver_register(&csr_driver);
+	int ret;
+
+	ret = platform_driver_register(&csr_driver);
+	coresight_set_csr_ops(&csr_assoc_ops);
+
+	return ret;
 }
 module_init(csr_init);
 
 static void __exit csr_exit(void)
 {
+	coresight_remove_csr_ops();
 	platform_driver_unregister(&csr_driver);
 }
 module_exit(csr_exit);
diff --git a/drivers/hwtracing/coresight/coresight-csr.h b/drivers/hwtracing/coresight/coresight-csr.h
index b4fb947fe23b..d253d06a7f4e 100644
--- a/drivers/hwtracing/coresight/coresight-csr.h
+++ b/drivers/hwtracing/coresight/coresight-csr.h
@@ -5,10 +5,80 @@
 
 #ifndef _CORESIGHT_CSR_H
 #define _CORESIGHT_CSR_H
+
+#include <linux/cdev.h>
 #include <linux/clk.h>
 #include <linux/coresight.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/moduleparam.h>
 #include <linux/of.h>
+#include <linux/property.h>
+
+#include "coresight-tmc.h"
+
+#define CSR_DT_ASSOC_DEVICE		"assoc_device"
+#define CSR_DT_CSDEV_ASSOC		"qcom,cs-dev-assoc"
+#define CSR_DT_CSDEV_ASSOC_DEV_TYPE		"qcom,cs-dev-type"
+#define CSR_DT_BYTECNTVAL_OFFSET	"qcom,csr-bytecntr-offset"
+#define CSR_DT_BYTECNTR_NAME		"qcom,csr-bytecntr-name"
+#define CSR_DT_BYTECNTR_CLASS_NAME	"qcom,csr-bytecntr-class-name"
+#define CSR_DT_BYTECNTR_IRQ		"byte-cntr-irq"
+
+#define CSR_ETR_BYTECNTVAL		0x06C
+
+/**
+ * struct byte_cntr
+ * @dev:	cdev for byte_cntr.
+ * @driver_class:	device classes.
+ * @enable:	Indicates that byte_cntr function is enabled or not.
+ * @read_active:	Indicates that byte-cntr node is opened or not.
+ * @block_size:	Byte counter value of IRQ.
+ * @byte_cntr_irq: IRQ number.
+ * @irq_cnt: The irq counter number for the ETR data.
+ * @wq:	Workqueue of reading ETR data.
+ * @read_work:	Work of reading ETR data.
+ * @byte_cntr_lock:	lock of byte_cntr data.
+ * @offset: Offset of reading pointer.
+ * @byte_cntr_offset:	BYTECNTR IRQ Register offset to the CSR base.
+ * @name:	The name of byte cntr device node.
+ * @class_name:	Device class name configured in DT.
+ */
+struct byte_cntr {
+	struct cdev		dev;
+	struct class	*driver_class;
+	bool			enable;
+	bool			read_active;
+	u32			block_size;
+	int			byte_cntr_irq;
+	atomic_t		irq_cnt;
+	wait_queue_head_t	wq;
+	struct work_struct	read_work;
+	struct mutex		byte_cntr_lock;
+	unsigned long	offset;
+	u32 byte_cntr_offset;
+	const char		*name;
+	const char		*class_name;
+};
+
+/**
+ * struct csr_assoc_data - Data of assocated device to CSR device.
+ * @assoc_dev_name:	Assocated device's name.
+ * @assoc_csdev: Assocated csdev.
+ * @node:	List node for CSR assocated data list.
+ * @dev_type: Type of the assocated device.
+ * @fnode:	fwnode of the child node.
+ * @byte_cntr_data: byte_cntr_data of the assocated device.
+ */
+struct csr_assoc_data {
+	const char *assoc_dev_name;
+	struct coresight_device	*assoc_csdev;
+	struct list_head node;
+	u32 dev_type;
+	struct fwnode_handle *fnode;
+	struct byte_cntr byte_cntr_data;
+};
 
 /**
  * struct csr_drvdata - specifics for the CSR device.
@@ -16,17 +86,27 @@
  * @pbase:	Physical address base.
  * @dev:	The device entity associated to this component.
  * @csdev:	Data struct for coresight device.
+ * @node: List node of the CSR data list.
+ * @csr_assoc: Assocated device data list.
  * @clk:	Clock of this component.
  * @spin_lock:	Spin lock for the data.
+ * @etr_byte_cntr_value: Byte cntr value of the ETR.
  */
 struct csr_drvdata {
 	void __iomem		*base;
 	phys_addr_t		pbase;
 	struct device		*dev;
 	struct coresight_device	*csdev;
+	struct list_head node;
+	struct list_head csr_assoc;
 	struct clk		*clk;
 	spinlock_t		spin_lock;
+	u32		etr_byte_cntr_value;
 };
 
+void csr_byte_cntr_start(struct byte_cntr *byte_cntr_data);
+void csr_byte_cntr_stop(struct byte_cntr *byte_cntr_data);
+int byte_cntr_init(struct csr_drvdata *drvdata, struct csr_assoc_data *assoc_data);
+void byte_cntr_remove(struct byte_cntr *byte_cntr_data);
 #endif
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 767076e07970..b95478d52ed7 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -164,6 +164,14 @@ struct cti_assoc_op {
 extern void coresight_set_cti_ops(const struct cti_assoc_op *cti_op);
 extern void coresight_remove_cti_ops(void);
 
+struct csr_assoc_op {
+	void (*add)(struct coresight_device *csdev);
+	void (*remove)(struct coresight_device *csdev);
+};
+
+extern void coresight_set_csr_ops(const struct csr_assoc_op *csr_op);
+extern void coresight_remove_csr_ops(void);
+
 /*
  * Macros and inline functions to handle CoreSight UCI data and driver
  * private data in AMBA ID table entries, and extract data values.
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 66dc5f97a009..faa2928c239f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -905,7 +905,7 @@ static void tmc_free_etr_buf(struct etr_buf *etr_buf)
  * Returns: The size of the linear data available @pos, with *bufpp
  * updated to point to the buffer.
  */
-static ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
+ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
 				    u64 offset, size_t len, char **bufpp)
 {
 	/* Adjust the length to limit this transaction to end of buffer */
@@ -913,6 +913,7 @@ static ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
 
 	return etr_buf->ops->get_data(etr_buf, (u64)offset, len, bufpp);
 }
+EXPORT_SYMBOL_GPL(tmc_etr_buf_get_data);
 
 static inline s64
 tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 0ee48c5ba764..ea5aec00c2be 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -322,6 +322,8 @@ void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
 				  u64 offset, u64 size);
 ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
 			      u64 offset, size_t len, char **bufpp);
+ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
+				    u64 offset, size_t len, char **bufpp);
 static inline unsigned long
 tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a269fffaf991..15994f6b0873 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -69,7 +69,8 @@ enum coresight_dev_subtype_source {
 
 enum coresight_dev_subtype_helper {
 	CORESIGHT_DEV_SUBTYPE_HELPER_CATU,
-	CORESIGHT_DEV_SUBTYPE_HELPER_ECT_CTI
+	CORESIGHT_DEV_SUBTYPE_HELPER_ECT_CTI,
+	CORESIGHT_DEV_SUBTYPE_HELPER_CSR,
 };
 
 /**
-- 
2.17.1

