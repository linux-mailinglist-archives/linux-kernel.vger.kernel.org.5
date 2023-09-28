Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087C27B1308
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjI1GcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjI1Gbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:31:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD196CC0;
        Wed, 27 Sep 2023 23:31:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S5Mi4B000751;
        Thu, 28 Sep 2023 06:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/soAqs+bUIQ4bXXuUDAlthrAV4VQsfwXXwo29x8oPdo=;
 b=SqKLtHkAS0HOk1ZS5xwHa5AYEKhIP/mpB/FZR3ml0XEG0wGc1OvQQ34F2kbRKjz3AtdH
 nHBX2XsQ5CUQI3jL2puO453uRZ9YhooT5QFgBox/7KhUWf/JfJxfsgS7gk1ZI0X1ytNL
 cpcTF8qB+eGUU8FskhyDcjgZgOk8RGrbXn1vvrmbmdTVSbXTT4z/URukNna8CyNe4R35
 Oebgg5rGje2Jou3+gaQ1EWz0vvoFRvW/4xueLfxDT1l0lxQDNIpfWTzch8g3dV7pUrY5
 axhdWeQfrOW9BDu0SKzoD43DZvhaG0QwUHO+iyS/PNvwLeNEQYgZniexxu4wbDQh9EYf Bw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tct5gs6jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 06:30:59 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38S6UwBj024594
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 06:30:58 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 27 Sep 2023 23:30:53 -0700
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
Subject: [PATCH v10 09/13] coresight-tpdm: Add nodes for dsb edge control
Date:   Thu, 28 Sep 2023 14:29:42 +0800
Message-ID: <1695882586-10306-10-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695882586-10306-1-git-send-email-quic_taozha@quicinc.com>
References: <1695882586-10306-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wL6n42NgqR5GmJCpYxuax2JcMck4LR_f
X-Proofpoint-GUID: wL6n42NgqR5GmJCpYxuax2JcMck4LR_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_03,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes to set value for DSB edge control and DSB edge
control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
resgisters to configure edge control. DSB edge detection control
00: Rising edge detection
01: Falling edge detection
10: Rising and falling edge detection (toggle detection)
And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
configure mask. Eight 32 bit registers providing DSB interface
edge detection mask control.

Add the nodes to configure DSB edge control and DSB edge control
mask. Each DSB subunit TPDM maximum of 256 edge detections can be
configured. The index and value sysfs files need to be paired and
written to order. The index sysfs file is to set the index number
of the edge detection which needs to be configured. And the value
sysfs file is to set the control or mask for the edge detection.
DSB edge detection control should be set as the following values.
00: Rising edge detection
01: Falling edge detection
10: Rising and falling edge detection (toggle detection)
And DSB edge mask should be set as 0 or 1.
Each DSB subunit TPDM has maximum of n(n<16) EDCR resgisters to
configure edge control. And each DSB subunit TPDM has maximum of
m(m<8) ECDMR registers to configure mask.

Add the nodes to read a set of the edge control value and mask
of the DSB in TPDM.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tpdm  |  51 +++++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 174 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h  |  60 ++++++
 3 files changed, 284 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 8ec7548070b7..6853bb1295e3 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -57,3 +57,54 @@ Description:
 		Bit[3] : Set to 0 for low performance mode.
 				 Set to 1 for high performance mode.
 		Bit[4:8] : Select byte lane for high performance mode.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge/ctrl_idx
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the index number of the edge detection for the DSB
+		subunit TPDM. Since there are at most 256 edge detections, this
+		value ranges from 0 to 255.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge/ctrl_val
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		Write a data to control the edge detection corresponding to
+		the index number. Before writing data to this sysfs file,
+		"ctrl_idx" should be written first to configure the index
+		number of the edge detection which needs to be controlled.
+
+		Accepts only one of the following values.
+		0 - Rising edge detection
+		1 - Falling edge detection
+		2 - Rising and falling edge detection (toggle detection)
+
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge/ctrl_mask
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		Write a data to mask the edge detection corresponding to the index
+		number. Before writing data to this sysfs file, "ctrl_idx" should
+		be written first to configure the index number of the edge detection
+		which needs to be masked.
+
+		Accepts only one of the 2 values -  0 or 1.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge/edcr[0:15]
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		Read a set of the edge control value of the DSB in TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge/edcmr[0:7]
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		Read a set of the edge control mask of the DSB in TPDM.
\ No newline at end of file
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 6201f12718ca..7175e70c2c4e 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -21,6 +21,30 @@
 
 DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
 
+/* Read dataset array member with the index number */
+static ssize_t tpdm_simple_dataset_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct tpdm_dataset_attribute *tpdm_attr =
+		container_of(attr, struct tpdm_dataset_attribute, attr);
+
+	switch (tpdm_attr->mem) {
+	case DSB_EDGE_CTRL:
+		if (tpdm_attr->idx >= TPDM_DSB_MAX_EDCR)
+			return -EINVAL;
+		return sysfs_emit(buf, "0x%x\n",
+			drvdata->dsb->edge_ctrl[tpdm_attr->idx]);
+	case DSB_EDGE_CTRL_MASK:
+		if (tpdm_attr->idx >= TPDM_DSB_MAX_EDCMR)
+			return -EINVAL;
+		return sysfs_emit(buf, "0x%x\n",
+			drvdata->dsb->edge_ctrl_mask[tpdm_attr->idx]);
+	}
+	return -EINVAL;
+}
+
 static bool tpdm_has_dsb_dataset(struct tpdm_drvdata *drvdata)
 {
 	return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
@@ -71,7 +95,14 @@ static void set_dsb_mode(struct tpdm_drvdata *drvdata, u32 *val)
 
 static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
-	u32 val;
+	u32 val, i;
+
+	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
+		writel_relaxed(drvdata->dsb->edge_ctrl[i],
+			   drvdata->base + TPDM_DSB_EDCR(i));
+	for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
+		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
+			   drvdata->base + TPDM_DSB_EDCMR(i));
 
 	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
 	/* Set trigger timestamp */
@@ -296,6 +327,109 @@ static ssize_t dsb_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_mode);
 
+static ssize_t ctrl_idx_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			(unsigned int)drvdata->dsb->edge_ctrl_idx);
+}
+
+/*
+ * The EDCR registers can include up to 16 32-bit registers, and each
+ * one can be configured to control up to 16 edge detections(2 bits
+ * control one edge detection). So a total 256 edge detections can be
+ * configured. This function provides a way to set the index number of
+ * the edge detection which needs to be configured.
+ */
+static ssize_t ctrl_idx_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf,
+			      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || (val >= TPDM_DSB_MAX_LINES))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->dsb->edge_ctrl_idx = val;
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+static DEVICE_ATTR_RW(ctrl_idx);
+
+/*
+ * This function is used to control the edge detection according
+ * to the index number that has been set.
+ * "edge_ctrl" should be one of the following values.
+ * 0 - Rising edge detection
+ * 1 - Falling edge detection
+ * 2 - Rising and falling edge detection (toggle detection)
+ */
+static ssize_t ctrl_val_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf,
+			      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val, edge_ctrl;
+	int reg;
+
+	if ((kstrtoul(buf, 0, &edge_ctrl)) || (edge_ctrl > 0x2))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	/*
+	 * There are 2 bit per DSB Edge Control line.
+	 * Thus we have 16 lines in a 32bit word.
+	 */
+	reg = EDCR_TO_WORD_IDX(drvdata->dsb->edge_ctrl_idx);
+	val = drvdata->dsb->edge_ctrl[reg];
+	val &= ~EDCR_TO_WORD_MASK(drvdata->dsb->edge_ctrl_idx);
+	val |= EDCR_TO_WORD_VAL(edge_ctrl, drvdata->dsb->edge_ctrl_idx);
+	drvdata->dsb->edge_ctrl[reg] = val;
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+static DEVICE_ATTR_WO(ctrl_val);
+
+static ssize_t ctrl_mask_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+	u32 set;
+	int reg;
+
+	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	/*
+	 * There is 1 bit per DSB Edge Control Mark line.
+	 * Thus we have 32 lines in a 32bit word.
+	 */
+	reg = EDCMR_TO_WORD_IDX(drvdata->dsb->edge_ctrl_idx);
+	set = drvdata->dsb->edge_ctrl_mask[reg];
+	if (val)
+		set |= BIT(EDCMR_TO_WORD_SHIFT(drvdata->dsb->edge_ctrl_idx));
+	else
+		set &= ~BIT(EDCMR_TO_WORD_SHIFT(drvdata->dsb->edge_ctrl_idx));
+	drvdata->dsb->edge_ctrl_mask[reg] = set;
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+static DEVICE_ATTR_WO(ctrl_mask);
+
 static ssize_t dsb_trig_type_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -367,6 +501,37 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_trig_ts);
 
+static struct attribute *tpdm_dsb_edge_attrs[] = {
+	&dev_attr_ctrl_idx.attr,
+	&dev_attr_ctrl_val.attr,
+	&dev_attr_ctrl_mask.attr,
+	DSB_EDGE_CTRL_ATTR(0),
+	DSB_EDGE_CTRL_ATTR(1),
+	DSB_EDGE_CTRL_ATTR(2),
+	DSB_EDGE_CTRL_ATTR(3),
+	DSB_EDGE_CTRL_ATTR(4),
+	DSB_EDGE_CTRL_ATTR(5),
+	DSB_EDGE_CTRL_ATTR(6),
+	DSB_EDGE_CTRL_ATTR(7),
+	DSB_EDGE_CTRL_ATTR(8),
+	DSB_EDGE_CTRL_ATTR(9),
+	DSB_EDGE_CTRL_ATTR(10),
+	DSB_EDGE_CTRL_ATTR(11),
+	DSB_EDGE_CTRL_ATTR(12),
+	DSB_EDGE_CTRL_ATTR(13),
+	DSB_EDGE_CTRL_ATTR(14),
+	DSB_EDGE_CTRL_ATTR(15),
+	DSB_EDGE_CTRL_MASK_ATTR(0),
+	DSB_EDGE_CTRL_MASK_ATTR(1),
+	DSB_EDGE_CTRL_MASK_ATTR(2),
+	DSB_EDGE_CTRL_MASK_ATTR(3),
+	DSB_EDGE_CTRL_MASK_ATTR(4),
+	DSB_EDGE_CTRL_MASK_ATTR(5),
+	DSB_EDGE_CTRL_MASK_ATTR(6),
+	DSB_EDGE_CTRL_MASK_ATTR(7),
+	NULL,
+};
+
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_trig_ts.attr,
@@ -379,9 +544,16 @@ static struct attribute_group tpdm_dsb_attr_grp = {
 	.is_visible = tpdm_dsb_is_visible,
 };
 
+static struct attribute_group tpdm_dsb_edge_grp = {
+	.attrs = tpdm_dsb_edge_attrs,
+	.is_visible = tpdm_dsb_is_visible,
+	.name = "dsb_edge",
+};
+
 static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
 	&tpdm_dsb_attr_grp,
+	&tpdm_dsb_edge_grp,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index b55d6f5ce852..a9c65d96316a 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -12,6 +12,8 @@
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
+#define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
+#define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
 
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
@@ -37,6 +39,16 @@
 /* High performance mode */
 #define TPDM_DSB_MODE_HPBYTESEL(val)	(val & GENMASK(8, 4))
 
+#define EDCRS_PER_WORD			16
+#define EDCR_TO_WORD_IDX(r)		((r) / EDCRS_PER_WORD)
+#define EDCR_TO_WORD_SHIFT(r)		((r % EDCRS_PER_WORD) * 2)
+#define EDCR_TO_WORD_VAL(val, r)	(val << EDCR_TO_WORD_SHIFT(r))
+#define EDCR_TO_WORD_MASK(r)		EDCR_TO_WORD_VAL(0x3, r)
+
+#define EDCMRS_PER_WORD				32
+#define EDCMR_TO_WORD_IDX(r)		((r) / EDCMRS_PER_WORD)
+#define EDCMR_TO_WORD_SHIFT(r)		((r) % EDCMRS_PER_WORD)
+
 /* TPDM integration test registers */
 #define TPDM_ITATBCNTRL		(0xEF0)
 #define TPDM_ITCNTRL		(0xF00)
@@ -63,14 +75,43 @@
 #define TPDM_PIDR0_DS_IMPDEF	BIT(0)
 #define TPDM_PIDR0_DS_DSB	BIT(1)
 
+#define TPDM_DSB_MAX_LINES	256
+/* MAX number of EDCR registers */
+#define TPDM_DSB_MAX_EDCR	16
+/* MAX number of EDCMR registers */
+#define TPDM_DSB_MAX_EDCMR	8
+
+#define tpdm_simple_dataset_ro(name, mem, idx)			\
+	(&((struct tpdm_dataset_attribute[]) {			\
+	   {								\
+		__ATTR(name, 0444, tpdm_simple_dataset_show, NULL),	\
+		mem,							\
+		idx,							\
+	   }								\
+	})[0].attr.attr)
+
+#define DSB_EDGE_CTRL_ATTR(nr)					\
+		tpdm_simple_dataset_ro(edcr##nr,		\
+		DSB_EDGE_CTRL, nr)
+
+#define DSB_EDGE_CTRL_MASK_ATTR(nr)				\
+		tpdm_simple_dataset_ro(edcmr##nr,		\
+		DSB_EDGE_CTRL_MASK, nr)
+
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
  * @mode:             DSB programming mode
+ * @edge_ctrl_idx     Index number of the edge control
+ * @edge_ctrl:        Save value for edge control
+ * @edge_ctrl_mask:   Save value for edge control mask
  * @trig_ts:          Enable/Disable trigger timestamp.
  * @trig_type:        Enable/Disable trigger type.
  */
 struct dsb_dataset {
 	u32			mode;
+	u32			edge_ctrl_idx;
+	u32			edge_ctrl[TPDM_DSB_MAX_EDCR];
+	u32			edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
 	bool			trig_ts;
 	bool			trig_type;
 };
@@ -96,4 +137,23 @@ struct tpdm_drvdata {
 	struct dsb_dataset	*dsb;
 };
 
+/* Enumerate members of various datasets */
+enum dataset_mem {
+	DSB_EDGE_CTRL,
+	DSB_EDGE_CTRL_MASK,
+};
+
+/**
+ * struct tpdm_dataset_attribute - Record the member variables and
+ * index number of datasets that need to be operated by sysfs file
+ * @attr:       The device attribute
+ * @mem:        The member in the dataset data structure
+ * @idx:        The index number of the array data
+ */
+struct tpdm_dataset_attribute {
+	struct device_attribute attr;
+	enum dataset_mem mem;
+	u32 idx;
+};
+
 #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
-- 
2.17.1

