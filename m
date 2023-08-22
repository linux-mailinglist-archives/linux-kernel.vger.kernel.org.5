Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572C178395F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjHVF3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjHVF33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:29:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABB7E77;
        Mon, 21 Aug 2023 22:28:55 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M54tQh013824;
        Tue, 22 Aug 2023 05:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yfflCSUAybDs4T/3HRF5sFtww81qMEhyRFilKneFei8=;
 b=Oo8onYMuTcISyur0m77180DF4AlEfr1K/ZODYoyJQmcIKxqJw8J/WRltPUR+XieK7/21
 Pj34XPXHSwKdlE7l8ekUFIwfMNJa5KuBS7uIdOMV6VHLG9+dGyCZdTIaUhKysGomkZQF
 e0n5HvhFg2znU0LINPYKActXankuHrRQM3Ok5sl6G1xc+qz6YNI3x0C9oR1hpi9q5cBI
 O9hv/pownPVWmtK5lNKDM7wfPbCg6GLCctJmIMehZiaoYAUSbWxXYkqWc1AcYDK4zutv
 tXyyv5YuRyoolGVOOgHnPEqHdV72/Qc9Tdb9nJIZcQnAT8h9WxkVWTsLGTX9qOTZhj9z yw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm6uuj1ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 05:27:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37M5Rf34028625
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 05:27:41 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 21 Aug 2023 22:27:36 -0700
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
Subject: [PATCH v8 13/13] coresight-tpdm: Add nodes for dsb msr support
Date:   Tue, 22 Aug 2023 13:26:13 +0800
Message-ID: <1692681973-20764-14-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1692681973-20764-1-git-send-email-quic_taozha@quicinc.com>
References: <1692681973-20764-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W8JJdweJwWWsX7pFh_aQTWtQ0D4lgKbz
X-Proofpoint-GUID: W8JJdweJwWWsX7pFh_aQTWtQ0D4lgKbz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_03,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes for DSB subunit MSR(mux select register) support.
The TPDM MSR (mux select register) interface is an optional
interface and associated bank of registers per TPDM subunit.
The intent of mux select registers is to control muxing structures
driving the TPDM’s’ various subunit interfaces.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  8 +++
 drivers/hwtracing/coresight/coresight-tpdm.c       | 79 ++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h       | 12 ++++
 3 files changed, 99 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 46a5535..9b7e172 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -162,3 +162,11 @@ Description:
 		Accepts only one of the 2 values -  0 or 1.
 		0 : Set the DSB pattern type to value.
 		1 : Set the DSB pattern type to toggle.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_msr/msr[0:31]
+Date:		March 2023
+KernelVersion	6.5
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the MSR(mux select register) for the DSB subunit
+		TPDM.
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 9b0e060..367c5e2 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -51,6 +51,9 @@ static ssize_t tpdm_simple_dataset_show(struct device *dev,
 	case DSB_PATT_MASK:
 		return sysfs_emit(buf, "0x%x\n",
 				drvdata->dsb->patt_mask[tpdm_attr->idx]);
+	case DSB_MSR:
+		return sysfs_emit(buf, "0x%x\n",
+				drvdata->dsb->msr[tpdm_attr->idx]);
 	default:
 		return -EINVAL;
 	}
@@ -84,6 +87,9 @@ static ssize_t tpdm_simple_dataset_store(struct device *dev,
 	case DSB_PATT_MASK:
 		drvdata->dsb->patt_mask[tpdm_attr->idx] = val;
 		break;
+	case DSB_MSR:
+		drvdata->dsb->msr[tpdm_attr->idx] = val;
+		break;
 	default:
 		spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
@@ -110,6 +116,22 @@ static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
 	return 0;
 }
 
+static umode_t tpdm_dsb_msr_is_visible(struct kobject *kobj,
+					   struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (drvdata && tpdm_has_dsb_dataset(drvdata)) {
+		of_property_read_u32(drvdata->dev->of_node,
+			   "qcom,dsb_msr_num", &drvdata->dsb->msr_num);
+		if (drvdata->dsb->msr_num != 0)
+			return attr->mode;
+	}
+
+	return 0;
+}
+
 static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
 {
 	if (tpdm_has_dsb_dataset(drvdata)) {
@@ -162,6 +184,18 @@ static void set_dsb_tier(struct tpdm_drvdata *drvdata, u32 *val)
 
 }
 
+static void set_dsb_msr(struct tpdm_drvdata *drvdata)
+{
+	int i;
+
+	if (drvdata->dsb->msr_num == 0)
+		return;
+
+	for (i = 0; i < drvdata->dsb->msr_num; i++)
+		writel_relaxed(drvdata->dsb->msr[i],
+			   drvdata->base + TPDM_DSB_MSR(i));
+}
+
 static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
 	u32 val, i;
@@ -186,6 +220,8 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 	set_dsb_tier(drvdata, &val);
 	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
 
+	set_dsb_msr(drvdata);
+
 	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
 	/* Set the mode of DSB dataset */
 	set_dsb_mode(drvdata, &val);
@@ -707,6 +743,42 @@ static struct attribute *tpdm_dsb_patt_attrs[] = {
 	NULL,
 };
 
+static struct attribute *tpdm_dsb_msr_attrs[] = {
+	DSB_MSR_ATTR(0),
+	DSB_MSR_ATTR(1),
+	DSB_MSR_ATTR(2),
+	DSB_MSR_ATTR(3),
+	DSB_MSR_ATTR(4),
+	DSB_MSR_ATTR(5),
+	DSB_MSR_ATTR(6),
+	DSB_MSR_ATTR(7),
+	DSB_MSR_ATTR(8),
+	DSB_MSR_ATTR(9),
+	DSB_MSR_ATTR(10),
+	DSB_MSR_ATTR(11),
+	DSB_MSR_ATTR(12),
+	DSB_MSR_ATTR(13),
+	DSB_MSR_ATTR(14),
+	DSB_MSR_ATTR(15),
+	DSB_MSR_ATTR(16),
+	DSB_MSR_ATTR(17),
+	DSB_MSR_ATTR(18),
+	DSB_MSR_ATTR(19),
+	DSB_MSR_ATTR(20),
+	DSB_MSR_ATTR(21),
+	DSB_MSR_ATTR(22),
+	DSB_MSR_ATTR(23),
+	DSB_MSR_ATTR(24),
+	DSB_MSR_ATTR(25),
+	DSB_MSR_ATTR(26),
+	DSB_MSR_ATTR(27),
+	DSB_MSR_ATTR(28),
+	DSB_MSR_ATTR(29),
+	DSB_MSR_ATTR(30),
+	DSB_MSR_ATTR(31),
+	NULL,
+};
+
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_patt_ts.attr,
@@ -739,12 +811,19 @@ static struct attribute_group tpdm_dsb_patt_grp = {
 	.name = "dsb_patt",
 };
 
+static struct attribute_group tpdm_dsb_msr_grp = {
+	.attrs = tpdm_dsb_msr_attrs,
+	.is_visible = tpdm_dsb_msr_is_visible,
+	.name = "dsb_msr",
+};
+
 static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
 	&tpdm_dsb_attrs_grp,
 	&tpdm_dsb_edge_grp,
 	&tpdm_dsb_trig_patt_grp,
 	&tpdm_dsb_patt_grp,
+	&tpdm_dsb_msr_grp,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 9173e80..270e946 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -18,6 +18,7 @@
 #define TPDM_DSB_XPMR(n)	(0x7E8 + (n * 4))
 #define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
 #define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
+#define TPDM_DSB_MSR(n)		(0x980 + (n * 4))
 
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
@@ -90,6 +91,8 @@
 #define TPDM_DSB_MAX_EDCMR	8
 /* MAX number of DSB pattern */
 #define TPDM_DSB_MAX_PATT	8
+/* MAX number of DSB MSR */
+#define TPDM_DSB_MAX_MSR 32
 
 #define tpdm_simple_dataset_ro(name, mem, idx, max)			\
 	(&((struct tpdm_dataset_attribute[]) {			\
@@ -136,16 +139,22 @@
 		tpdm_simple_dataset_rw(tpmr##nr,		\
 		DSB_PATT_MASK, nr, TPDM_DSB_MAX_PATT)
 
+#define DSB_MSR_ATTR(nr)						\
+		tpdm_simple_dataset_rw(msr##nr,			\
+		DSB_MSR, nr, TPDM_DSB_MAX_MSR)
+
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
  * @mode:             DSB programming mode
  * @edge_ctrl_idx     Index number of the edge control
+ * @msr_num           Number of MSR supported by DSB TPDM
  * @edge_ctrl:        Save value for edge control
  * @edge_ctrl_mask:   Save value for edge control mask
  * @patt_val:         Save value for pattern
  * @patt_mask:        Save value for pattern mask
  * @trig_patt:        Save value for trigger pattern
  * @trig_patt_mask:   Save value for trigger pattern mask
+ * @msr               Save value for MSR
  * @patt_ts:          Enable/Disable pattern timestamp
  * @patt_type:        Set pattern type
  * @trig_ts:          Enable/Disable trigger timestamp.
@@ -154,12 +163,14 @@
 struct dsb_dataset {
 	u32				mode;
 	u32				edge_ctrl_idx;
+	u32				msr_num;
 	u32				edge_ctrl[TPDM_DSB_MAX_EDCR];
 	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
 	u32				patt_val[TPDM_DSB_MAX_PATT];
 	u32				patt_mask[TPDM_DSB_MAX_PATT];
 	u32				trig_patt[TPDM_DSB_MAX_PATT];
 	u32				trig_patt_mask[TPDM_DSB_MAX_PATT];
+	u32				msr[TPDM_DSB_MAX_MSR];
 	bool			patt_ts;
 	bool			patt_type;
 	bool			trig_ts;
@@ -195,6 +206,7 @@ enum dataset_mem {
 	DSB_TRIG_PATT_MASK,
 	DSB_PATT,
 	DSB_PATT_MASK,
+	DSB_MSR,
 };
 
 /**
-- 
2.7.4

