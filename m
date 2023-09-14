Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C07679FB15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjINFpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjINFpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:45:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8B1C6;
        Wed, 13 Sep 2023 22:45:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E5X3Gt008207;
        Thu, 14 Sep 2023 05:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=VWrFHOCKy+SR/MkNeEzB1mw4K6fj5P2t5bZJxHgSxtw=;
 b=Nr6SDQnN7heTrnIxktWKJlm3Zr70f5H1Bvr5Bx01ZCRPCn3DWVvZOURoENHvQHf1xQGs
 nASLani5ZFWOjeORSiICrFBE43AKFR/v3YBBAprIRmQmFb/+G80s/mRAeIoPWy1v0l7x
 OXCz7FQU7TH5A+L0u5SvslsIVqUu+06a1XzEEZGS4tr+Qubb4iSKy/fTm1LoZLJjCXPi
 x+XsGzjiMafE97nXw0NEFL5M3fJAOGtaS8bCye4hmfK6OW3kB4bEnaFe+ddfZnoPRUww
 HL5A8AUxl/1Xe8zcwd/KS2iD3Tre7GOfV5EHogV+BVmnBPmB1ha/zJncWSZML3tV9jh4 0w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3v4g80vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 05:44:48 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E5ilnw014027
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 05:44:47 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 13 Sep 2023 22:44:42 -0700
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
Subject: [PATCH v9 11/13] coresight-tpdm: Add nodes for timestamp request
Date:   Thu, 14 Sep 2023 13:43:22 +0800
Message-ID: <1694670204-11515-12-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694670204-11515-1-git-send-email-quic_taozha@quicinc.com>
References: <1694670204-11515-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -laCCO_mY1rWs_4luhF6E35-u7XSXQmZ
X-Proofpoint-GUID: -laCCO_mY1rWs_4luhF6E35-u7XSXQmZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_03,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes to configure the timestamp request based on input
pattern match. Each TPDM that support DSB subunit has maximum of
n(n<7) TPR registers to configure value for timestamp request
based on input pattern match. Eight 32 bit registers providing
DSB interface timestamp request  pattern match comparison. And
each TPDM that support DSB subunit has maximum of m(m<7) TPMR
registers to configure pattern mask for timestamp request. Eight
32 bit registers providing DSB interface timestamp request
pattern match mask generation. Add nodes to enable/disable
pattern timestamp and set pattern timestamp type.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  40 +++++-
 drivers/hwtracing/coresight/coresight-tpdm.c       | 155 ++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h       |  24 ++++
 3 files changed, 211 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 2252e47..1f20a3f 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -123,4 +123,42 @@ KernelVersion	6.7
 Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
 Description:
 		(RW) Set/Get the mask of the trigger pattern for the DSB
-		subunit TPDM.
\ No newline at end of file
+		subunit TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt/tpr[0:7]
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the value of the pattern for the DSB subunit TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt/tpmr[0:7]
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the mask of the pattern for the DSB subunit TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt/enable_ts
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Set the pattern timestamp of DSB tpdm. Read
+		the pattern timestamp of DSB tpdm.
+
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Disable DSB pattern timestamp.
+		1 : Enable DSB pattern timestamp.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt/set_type
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Set the pattern type of DSB tpdm. Read
+		the pattern type of DSB tpdm.
+
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Set the DSB pattern type to value.
+		1 : Set the DSB pattern type to toggle.
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 5ce3446..7acc220 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -51,6 +51,16 @@ static ssize_t tpdm_simple_dataset_show(struct device *dev,
 			return -EINVAL;
 		return sysfs_emit(buf, "0x%x\n",
 			drvdata->dsb->trig_patt_mask[tpdm_attr->idx]);
+	case DSB_PATT:
+		if (tpdm_attr->idx >= TPDM_DSB_MAX_PATT)
+			return -EINVAL;
+		return sysfs_emit(buf, "0x%x\n",
+			drvdata->dsb->patt_val[tpdm_attr->idx]);
+	case DSB_PATT_MASK:
+		if (tpdm_attr->idx >= TPDM_DSB_MAX_PATT)
+			return -EINVAL;
+		return sysfs_emit(buf, "0x%x\n",
+			drvdata->dsb->patt_mask[tpdm_attr->idx]);
 	}
 	return -EINVAL;
 }
@@ -85,6 +95,18 @@ static ssize_t tpdm_simple_dataset_store(struct device *dev,
 		else
 			ret = -EINVAL;
 		break;
+	case DSB_PATT:
+		if (tpdm_attr->idx < TPDM_DSB_MAX_PATT)
+			drvdata->dsb->patt_val[tpdm_attr->idx] = val;
+		else
+			ret = -EINVAL;
+		break;
+	case DSB_PATT_MASK:
+		if (tpdm_attr->idx < TPDM_DSB_MAX_PATT)
+			drvdata->dsb->patt_mask[tpdm_attr->idx] = val;
+		else
+			ret = -EINVAL;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -141,6 +163,36 @@ static void set_dsb_mode(struct tpdm_drvdata *drvdata, u32 *val)
 		*val &= ~TPDM_DSB_CR_MODE;
 }
 
+static void set_dsb_tier(struct tpdm_drvdata *drvdata)
+{
+	u32 val;
+
+	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
+
+	/* Clear all relevant fields */
+	val &= ~(TPDM_DSB_TIER_PATT_TSENAB | TPDM_DSB_TIER_PATT_TYPE |
+		 TPDM_DSB_TIER_XTRIG_TSENAB);
+
+	/* Set pattern timestamp type and enablement */
+	if (drvdata->dsb->patt_ts) {
+		val |= TPDM_DSB_TIER_PATT_TSENAB;
+		if (drvdata->dsb->patt_type)
+			val |= TPDM_DSB_TIER_PATT_TYPE;
+		else
+			val &= ~TPDM_DSB_TIER_PATT_TYPE;
+	} else {
+		val &= ~TPDM_DSB_TIER_PATT_TSENAB;
+	}
+
+	/* Set trigger timestamp */
+	if (drvdata->dsb->trig_ts)
+		val |= TPDM_DSB_TIER_XTRIG_TSENAB;
+	else
+		val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
+
+	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
+}
+
 static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
 	u32 val, i;
@@ -152,18 +204,17 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
 			   drvdata->base + TPDM_DSB_EDCMR(i));
 	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		writel_relaxed(drvdata->dsb->patt_val[i],
+			   drvdata->base + TPDM_DSB_TPR(i));
+		writel_relaxed(drvdata->dsb->patt_mask[i],
+			   drvdata->base + TPDM_DSB_TPMR(i));
 		writel_relaxed(drvdata->dsb->trig_patt[i],
 			   drvdata->base + TPDM_DSB_XPR(i));
 		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
 			   drvdata->base + TPDM_DSB_XPMR(i));
 	}
-	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
-	/* Set trigger timestamp */
-	if (drvdata->dsb->trig_ts)
-		val |= TPDM_DSB_TIER_XTRIG_TSENAB;
-	else
-		val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
-	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
+
+	set_dsb_tier(drvdata);
 
 	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
 	/* Set the mode of DSB dataset */
@@ -483,6 +534,67 @@ static ssize_t ctrl_mask_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(ctrl_mask);
 
+static ssize_t enable_ts_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			 (unsigned int)drvdata->dsb->patt_ts);
+}
+
+/*
+ * value 1: Enable/Disable DSB pattern timestamp
+ */
+static ssize_t enable_ts_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->dsb->patt_ts = !!val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(enable_ts);
+
+static ssize_t set_type_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			 (unsigned int)drvdata->dsb->patt_type);
+}
+
+/*
+ * value 1: Set DSB pattern type
+ */
+static ssize_t set_type_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->dsb->patt_type = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(set_type);
+
 static ssize_t dsb_trig_type_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -605,6 +717,28 @@ static struct attribute *tpdm_dsb_trig_patt_attrs[] = {
 	NULL,
 };
 
+static struct attribute *tpdm_dsb_patt_attrs[] = {
+	DSB_PATT_ATTR(0),
+	DSB_PATT_ATTR(1),
+	DSB_PATT_ATTR(2),
+	DSB_PATT_ATTR(3),
+	DSB_PATT_ATTR(4),
+	DSB_PATT_ATTR(5),
+	DSB_PATT_ATTR(6),
+	DSB_PATT_ATTR(7),
+	DSB_PATT_MASK_ATTR(0),
+	DSB_PATT_MASK_ATTR(1),
+	DSB_PATT_MASK_ATTR(2),
+	DSB_PATT_MASK_ATTR(3),
+	DSB_PATT_MASK_ATTR(4),
+	DSB_PATT_MASK_ATTR(5),
+	DSB_PATT_MASK_ATTR(6),
+	DSB_PATT_MASK_ATTR(7),
+	&dev_attr_enable_ts.attr,
+	&dev_attr_set_type.attr,
+	NULL,
+};
+
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_trig_ts.attr,
@@ -629,11 +763,18 @@ static struct attribute_group tpdm_dsb_trig_patt_grp = {
 	.name = "dsb_trig_patt",
 };
 
+static struct attribute_group tpdm_dsb_patt_grp = {
+	.attrs = tpdm_dsb_patt_attrs,
+	.is_visible = tpdm_dsb_is_visible,
+	.name = "dsb_patt",
+};
+
 static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
 	&tpdm_dsb_attrs_grp,
 	&tpdm_dsb_edge_grp,
 	&tpdm_dsb_trig_patt_grp,
+	&tpdm_dsb_patt_grp,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 2cf7bdb..891979d 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -12,6 +12,8 @@
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
+#define TPDM_DSB_TPR(n)		(0x788 + (n * 4))
+#define TPDM_DSB_TPMR(n)	(0x7A8 + (n * 4))
 #define TPDM_DSB_XPR(n)		(0x7C8 + (n * 4))
 #define TPDM_DSB_XPMR(n)	(0x7E8 + (n * 4))
 #define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
@@ -28,8 +30,12 @@
 /* Data bits for DSB test mode */
 #define TPDM_DSB_CR_TEST_MODE		GENMASK(10, 9)
 
+/* Enable bit for DSB subunit pattern timestamp */
+#define TPDM_DSB_TIER_PATT_TSENAB		BIT(0)
 /* Enable bit for DSB subunit trigger timestamp */
 #define TPDM_DSB_TIER_XTRIG_TSENAB		BIT(1)
+/* Bit for DSB subunit pattern type */
+#define TPDM_DSB_TIER_PATT_TYPE			BIT(2)
 
 /* DSB programming modes */
 /* DSB mode bits mask */
@@ -120,14 +126,26 @@
 		tpdm_simple_dataset_rw(xpmr##nr,		\
 		DSB_TRIG_PATT_MASK, nr)
 
+#define DSB_PATT_ATTR(nr)					\
+		tpdm_simple_dataset_rw(tpr##nr,			\
+		DSB_PATT, nr)
+
+#define DSB_PATT_MASK_ATTR(nr)					\
+		tpdm_simple_dataset_rw(tpmr##nr,		\
+		DSB_PATT_MASK, nr)
+
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
  * @mode:             DSB programming mode
  * @edge_ctrl_idx     Index number of the edge control
  * @edge_ctrl:        Save value for edge control
  * @edge_ctrl_mask:   Save value for edge control mask
+ * @patt_val:         Save value for pattern
+ * @patt_mask:        Save value for pattern mask
  * @trig_patt:        Save value for trigger pattern
  * @trig_patt_mask:   Save value for trigger pattern mask
+ * @patt_ts:          Enable/Disable pattern timestamp
+ * @patt_type:        Set pattern type
  * @trig_ts:          Enable/Disable trigger timestamp.
  * @trig_type:        Enable/Disable trigger type.
  */
@@ -136,8 +154,12 @@ struct dsb_dataset {
 	u32			edge_ctrl_idx;
 	u32			edge_ctrl[TPDM_DSB_MAX_EDCR];
 	u32			edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
+	u32			patt_val[TPDM_DSB_MAX_PATT];
+	u32			patt_mask[TPDM_DSB_MAX_PATT];
 	u32			trig_patt[TPDM_DSB_MAX_PATT];
 	u32			trig_patt_mask[TPDM_DSB_MAX_PATT];
+	bool			patt_ts;
+	bool			patt_type;
 	bool			trig_ts;
 	bool			trig_type;
 };
@@ -169,6 +191,8 @@ enum dataset_mem {
 	DSB_EDGE_CTRL_MASK,
 	DSB_TRIG_PATT,
 	DSB_TRIG_PATT_MASK,
+	DSB_PATT,
+	DSB_PATT_MASK,
 };
 
 /**
-- 
2.7.4

