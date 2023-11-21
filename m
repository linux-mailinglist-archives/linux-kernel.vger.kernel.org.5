Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2BA7F23E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjKUC00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjKUC0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:26:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F73D7F;
        Mon, 20 Nov 2023 18:26:03 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL20jv2029444;
        Tue, 21 Nov 2023 02:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=dYWFFwh0ZwFNmXwGIe1k4Lj9OS8BMb+5PuIO3Cmi71A=;
 b=PuiP2EP7cC/ESTrHApUt4Ani4qUE5cKUxvuhxK9yZQy6Qbgnf8iuKhl5QTHJT/Sr3lJ/
 OLCEp27XpieJUWUUbaT3yGwdYstdgC7gUPGV92P7I+r0vs2ylnmdVRkUEff82e7WMLYZ
 btutOY7mjNO0j2hlam4Vm7Hwt8JtjbxU0EIiyDGX8+93VkItJtsQ9a9sepwU5At16EXS
 Fyxnzpia2+Kc1kPJT6Y7dv4ItL2uhHwVdjlcPtToxGjvnVJ3Upm4q+DSHz1LoLGzm1H8
 EScJnacrLZFXX2tmnq7YccC4d/ZnwlLfC2Qgcss2fgwXpdgy0AeGKRJIyka1kzPjmVyp 6Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug7ea9r07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:25:51 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL2PoZf009668
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:25:50 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 18:25:44 -0800
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
        Song Chai <quic_songchai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
Subject: [PATCH v3 6/8] coresight-tpdm: Add timestamp control register support for the CMB
Date:   Tue, 21 Nov 2023 10:24:52 +0800
Message-ID: <1700533494-19276-7-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rjO4lMaO-PcBGUKSmbzoKMpiWKkYjsT2
X-Proofpoint-ORIG-GUID: rjO4lMaO-PcBGUKSmbzoKMpiWKkYjsT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMB_TIER register is CMB subunit timestamp insertion enable register.
Bit 0 is PATT_TSENAB bit. Set this bit to 1 to request a timestamp
following a CMB interface pattern match. Bit 1 is XTRIG_TSENAB bit.
Set this bit to 1 to request a timestamp following a CMB CTI timestamp
request. Bit 2 is TS_ALL bit. Set this bit to 1 to request timestamp
for all packets.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tpdm  |  35 ++++++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 116 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h  |  14 +++
 3 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 53662ce7c2d0..e0b77107be13 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -214,3 +214,38 @@ KernelVersion	6.7
 Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
 Description:
 		(RW) Set/Get the mask of the pattern for the CMB subunit TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_patt/enable_ts
+Date:		September 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Set the pattern timestamp of CMB tpdm. Read
+		the pattern timestamp of CMB tpdm.
+
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Disable CMB pattern timestamp.
+		1 : Enable CMB pattern timestamp.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_ts
+Date:		September 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the trigger timestamp of the CMB for tpdm.
+
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Set the CMB trigger type to false
+		1 : Set the CMB trigger type to true
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_ts_all
+Date:		September 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Read or write the status of timestamp upon all interface.
+		Only value 0 and 1  can be written to this node. Set this node to 1 to requeset
+		timestamp to all trace packet.
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Disable the timestamp of all trace packets.
+		1 : Enable the timestamp of all trace packets.
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 894d4309f1c7..f6cda5616e84 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -331,6 +331,36 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
 }
 
+static void set_cmb_tier(struct tpdm_drvdata *drvdata)
+{
+	u32 val;
+
+	val = readl_relaxed(drvdata->base + TPDM_CMB_TIER);
+
+	/* Clear all relevant fields */
+	val &= ~(TPDM_CMB_TIER_PATT_TSENAB | TPDM_CMB_TIER_TS_ALL |
+		 TPDM_CMB_TIER_XTRIG_TSENAB);
+
+	/* Set pattern timestamp type and enablement */
+	if (drvdata->cmb->patt_ts)
+		val |= TPDM_CMB_TIER_PATT_TSENAB;
+	else
+		val &= ~TPDM_CMB_TIER_PATT_TSENAB;
+
+	/* Set trigger timestamp */
+	if (drvdata->cmb->trig_ts)
+		val |= TPDM_CMB_TIER_XTRIG_TSENAB;
+	else
+		val &= ~TPDM_CMB_TIER_XTRIG_TSENAB;
+
+	/* Set all timestamp enablement*/
+	if (drvdata->cmb->ts_all)
+		val |= TPDM_CMB_TIER_TS_ALL;
+	else
+		val &= ~TPDM_CMB_TIER_TS_ALL;
+	writel_relaxed(val, drvdata->base + TPDM_CMB_TIER);
+}
+
 static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
 {
 	u32 val, i;
@@ -347,6 +377,8 @@ static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
 			    drvdata->base + TPDM_CMB_XPMR(i));
 	}
 
+	set_cmb_tier(drvdata);
+
 	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
 	/*
 	 * Set to 0 for continuous CMB collection mode,
@@ -695,9 +727,17 @@ static ssize_t enable_ts_show(struct device *dev,
 			      char *buf)
 {
 	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
 
-	return sysfs_emit(buf, "%u\n",
-			 (unsigned int)drvdata->dsb->patt_ts);
+	if (tpdm_has_dsb_dataset(drvdata))
+		size = sysfs_emit(buf, "%u\n",
+				 (unsigned int)drvdata->dsb->patt_ts);
+
+	if (tpdm_has_cmb_dataset(drvdata))
+		size = sysfs_emit(buf, "%u\n",
+				 (unsigned int)drvdata->cmb->patt_ts);
+
+	return size;
 }
 
 /*
@@ -715,8 +755,13 @@ static ssize_t enable_ts_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	drvdata->dsb->patt_ts = !!val;
+	if (tpdm_has_dsb_dataset(drvdata))
+		drvdata->dsb->patt_ts = !!val;
+
+	if (tpdm_has_cmb_dataset(drvdata))
+		drvdata->cmb->patt_ts = !!val;
 	spin_unlock(&drvdata->spinlock);
+
 	return size;
 }
 static DEVICE_ATTR_RW(enable_ts);
@@ -851,6 +896,68 @@ static ssize_t cmb_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(cmb_mode);
 
+static ssize_t cmb_ts_all_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			  (unsigned int)drvdata->cmb->ts_all);
+}
+
+static ssize_t cmb_ts_all_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->cmb->ts_all = true;
+	else
+		drvdata->cmb->ts_all = false;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_ts_all);
+
+static ssize_t cmb_trig_ts_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			  (unsigned int)drvdata->cmb->trig_ts);
+}
+
+static ssize_t cmb_trig_ts_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->cmb->trig_ts = true;
+	else
+		drvdata->cmb->trig_ts = false;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_trig_ts);
+
 static struct attribute *tpdm_dsb_edge_attrs[] = {
 	&dev_attr_ctrl_idx.attr,
 	&dev_attr_ctrl_val.attr,
@@ -973,6 +1080,7 @@ static struct attribute *tpdm_cmb_patt_attrs[] = {
 	CMB_PATT_ATTR(1),
 	CMB_PATT_MASK_ATTR(0),
 	CMB_PATT_MASK_ATTR(1),
+	&dev_attr_enable_ts.attr,
 	NULL,
 };
 
@@ -985,6 +1093,8 @@ static struct attribute *tpdm_dsb_attrs[] = {
 
 static struct attribute *tpdm_cmb_attrs[] = {
 	&dev_attr_cmb_mode.attr,
+	&dev_attr_cmb_ts_all.attr,
+	&dev_attr_cmb_trig_ts.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index e90d008c1cb2..65b7ca6c4077 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -11,6 +11,8 @@
 
 /* CMB Subunit Registers */
 #define TPDM_CMB_CR		(0xA00)
+/*CMB subunit timestamp insertion enable register*/
+#define TPDM_CMB_TIER		(0xA04)
 /*CMB subunit timestamp pattern registers*/
 #define TPDM_CMB_TPR(n)		(0xA08 + (n * 4))
 /*CMB subunit timestamp pattern mask registers*/
@@ -24,6 +26,12 @@
 #define TPDM_CMB_CR_ENA		BIT(0)
 /* Trace collection mode for CMB subunit */
 #define TPDM_CMB_CR_MODE	BIT(1)
+/* Timestamp control for pattern match */
+#define TPDM_CMB_TIER_PATT_TSENAB	BIT(0)
+/* CMB CTI timestamp request */
+#define TPDM_CMB_TIER_XTRIG_TSENAB	BIT(1)
+/* For timestamp fo all trace */
+#define TPDM_CMB_TIER_TS_ALL		BIT(2)
 
 /*Patten register number*/
 #define TPDM_CMB_MAX_PATT		2
@@ -217,6 +225,9 @@ struct dsb_dataset {
  * @patt_mask:        Save value for pattern mask
  * @trig_patt:        Save value for trigger pattern
  * @trig_patt_mask:   Save value for trigger pattern mask
+ * @patt_ts:          Indicates if pattern match for timestamp is enabled.
+ * @trig_ts:          Indicates if CTI trigger for timestamp is enabled.
+ * @ts_all:           Indicates if timestamp is enabled for all packets.
  */
 struct cmb_dataset {
 	u32			trace_mode;
@@ -224,6 +235,9 @@ struct cmb_dataset {
 	u32			patt_mask[TPDM_CMB_MAX_PATT];
 	u32			trig_patt[TPDM_CMB_MAX_PATT];
 	u32			trig_patt_mask[TPDM_CMB_MAX_PATT];
+	bool			patt_ts;
+	bool			trig_ts;
+	bool			ts_all;
 };
 
 /**
-- 
2.17.1

