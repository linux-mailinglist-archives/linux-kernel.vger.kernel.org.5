Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA7760B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjGYHT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjGYHSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:18:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC2F19AD;
        Tue, 25 Jul 2023 00:17:17 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P5SrZH030185;
        Tue, 25 Jul 2023 07:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=JuxNSZ4L/4+OvCuzDVnh6dKJ5jle+4HKWf7saWivwJE=;
 b=DqgF63v1ZpZvk0BJXt4Q8k+Jf3BSiI1ZsU30fjoIUZRqeJP4KggifkZZ6k4g7MO/UMiu
 l+F9vGJjej4DQPtMUpf5tWIl7Ys4/N0nsIWvZxuiWBbI8Jl8lNqtYglr3XG4Nesii+7P
 AyAAGsehpWvQOhHP0lX9Yv997sSg8ykDukBR0MkmMsd9bgOwIAQwdAw2RMser2F1tyLx
 kfTXvcCTFYPuW14IZNoutKLQ8SG0A/4AP44uac54jC5Isei+olb+RQVku3zlltt5D1I6
 9744nbBXikd4+LtYKLqgWqxJcSfyFPuWS3CzKPMLEbIM3bUNqL53VxevYUYQ+hijtFpA ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1pfhad4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 07:17:05 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P7H4Jv032718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 07:17:05 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 00:17:00 -0700
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
Subject: [PATCH v7 10/13] coresight-tpdm: Add nodes to configure pattern match output
Date:   Tue, 25 Jul 2023 15:15:50 +0800
Message-ID: <1690269353-10829-11-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
References: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7RtPWihLlCjUUg9dFMlSfHvH3n8_IKC9
X-Proofpoint-GUID: 7RtPWihLlCjUUg9dFMlSfHvH3n8_IKC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_02,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250064
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes to configure trigger pattern and trigger pattern mask.
Each DSB subunit TPDM has maximum of n(n<7) XPR registers to
configure trigger pattern match output. Eight 32 bit registers
providing DSB interface trigger output pattern match comparison.
And each DSB subunit TPDM has maximum of m(m<7) XPMR registers to
configure trigger pattern mask match output. Eight 32 bit
registers providing DSB interface trigger output pattern match
mask.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  34 +++++-
 drivers/hwtracing/coresight/coresight-tpdm.c       | 118 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h       |  10 ++
 3 files changed, 161 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index a4550c5..66f9582 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -98,4 +98,36 @@ Description:
 		should be written first to configure the index number of the edge
 		detection which needs to be masked.
 
-		Accepts only one of the 2 values -  0 or 1.
\ No newline at end of file
+		Accepts only one of the 2 values -  0 or 1.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt_idx
+Date:		March 2023
+KernelVersion	6.5
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		Read/Write the index number of the trigger pattern value of DSB
+		tpdm. Since there are at most 8 XPR and XPMR registers for the
+		trigger parttern, this value ranges from 0 to 7.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt_val
+Date:		March 2023
+KernelVersion	6.5
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		Read a set of the trigger pattern values of the DSB TPDM.
+		Write a data to configure the trigger pattern corresponding to
+		the index number. Before writing data to this sysfs file,
+		"dsb_trig_patt_idx" should be written first to configure the
+		index number of the trigger pattern which needs to be configured.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt_mask
+Date:		March 2023
+KernelVersion	6.5
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		Read a set of the trigger pattern mask of the DSB TPDM.
+		Write a data to configure the trigger pattern mask corresponding
+		to the index number. Before writing data to this sysfs file,
+		"dsb_trig_patt_idx" should be written first to configure the
+		index number of the trigger pattern mask which needs to be
+		configured.
\ No newline at end of file
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 98fd6ab..1c32d27 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -80,6 +80,13 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
 			   drvdata->base + TPDM_DSB_EDCMR(i));
 
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		writel_relaxed(drvdata->dsb->trig_patt[i],
+			    drvdata->base + TPDM_DSB_XPR(i));
+		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
+			    drvdata->base + TPDM_DSB_XPMR(i));
+	}
+
 	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
 	/* Set trigger timestamp */
 	if (drvdata->dsb->trig_ts)
@@ -455,6 +462,114 @@ static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
 
+static ssize_t dsb_trig_patt_idx_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			 (unsigned int)drvdata->dsb->trig_patt_idx);
+}
+
+static ssize_t dsb_trig_patt_idx_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index;
+
+	if (kstrtoul(buf, 0, &index))
+		return -EINVAL;
+	if (index >= TPDM_DSB_MAX_PATT)
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->dsb->trig_patt_idx = index;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_patt_idx);
+
+static ssize_t dsb_trig_patt_val_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	unsigned long bytes;
+	int i = 0;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		bytes = sysfs_emit_at(buf, size,
+				  "Value: 0x%x\n", drvdata->dsb->trig_patt[i]);
+		if (bytes <= 0)
+			break;
+		size += bytes;
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+
+static ssize_t dsb_trig_patt_val_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->dsb->trig_patt[drvdata->dsb->trig_patt_idx] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_patt_val);
+
+static ssize_t dsb_trig_patt_mask_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	unsigned long bytes;
+	int i = 0;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		bytes = sysfs_emit_at(buf, size,
+			  "Value: 0x%x\n", drvdata->dsb->trig_patt_mask[i]);
+		if (bytes <= 0)
+			break;
+		size += bytes;
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+
+static ssize_t dsb_trig_patt_mask_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf,
+					     size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->dsb->trig_patt_mask[drvdata->dsb->trig_patt_idx] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_patt_mask);
+
 static ssize_t dsb_trig_type_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
@@ -530,6 +645,9 @@ static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_edge_ctrl_idx.attr,
 	&dev_attr_dsb_edge_ctrl_val.attr,
 	&dev_attr_dsb_edge_ctrl_mask.attr,
+	&dev_attr_dsb_trig_patt_idx.attr,
+	&dev_attr_dsb_trig_patt_val.attr,
+	&dev_attr_dsb_trig_patt_mask.attr,
 	&dev_attr_dsb_trig_ts.attr,
 	&dev_attr_dsb_trig_type.attr,
 	NULL,
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 4afdb29..7f688b2 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -12,6 +12,8 @@
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
+#define TPDM_DSB_XPR(n)		(0x7C8 + (n * 4))
+#define TPDM_DSB_XPMR(n)	(0x7E8 + (n * 4))
 #define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
 #define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
 
@@ -77,21 +79,29 @@
 #define TPDM_DSB_MAX_EDCR	16
 /* MAX number of EDCMR registers */
 #define TPDM_DSB_MAX_EDCMR	8
+/* MAX number of DSB pattern */
+#define TPDM_DSB_MAX_PATT	8
 
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
  * @mode:               DSB programming mode
  * @edge_ctrl_idx       Index number of the edge control
+ * @trig_patt_idx       Index number of the trigger pattern
  * @edge_ctrl:          Save value for edge control
  * @edge_ctrl_mask:     Save value for edge control mask
+ * @trig_patt:          Save value for trigger pattern
+ * @trig_patt_mask:     Save value for trigger pattern mask
  * @trig_ts:            Enable/Disable trigger timestamp.
  * @trig_type:          Enable/Disable trigger type.
  */
 struct dsb_dataset {
 	u32				mode;
 	u32				edge_ctrl_idx;
+	u32				trig_patt_idx;
 	u32				edge_ctrl[TPDM_DSB_MAX_EDCR];
 	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
+	u32				trig_patt[TPDM_DSB_MAX_PATT];
+	u32				trig_patt_mask[TPDM_DSB_MAX_PATT];
 	bool			trig_ts;
 	bool			trig_type;
 };
-- 
2.7.4

