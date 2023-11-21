Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA187F23EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjKUC0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjKUC03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:26:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D0AD5D;
        Mon, 20 Nov 2023 18:26:16 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL2Nses023161;
        Tue, 21 Nov 2023 02:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=orRMuZtJOOACHlraRkdGOQyMXZ01rdYdTiYOqJN2xb8=;
 b=fLhZhLwwVNoUC8dMbTjJZ/3WKYPkJ7T8bM9/hBerod84Kl0t4M3BhAEh2mXt9POwbDDp
 h8vBoDDLf/Fv2yQFA8nRKzcO0nBSuF3jrTISc+qNmwTTzX7fz/LP3xzIiORQLdi0jP/E
 cf2qdtyZjM3wxo3Rw+Rrer6REkGKdIeZun6I7JXSC3nOhO+n/pwCGouYOnv7AqK8sysN
 VRey1NmOphHGYGbYvKS6b+8L08qC6JaPq+HA97NpSoTZ4ih0p2gq0NcyP0t3TAuGs+bu
 5z24AkkhyaTpoxM9lWJkU/yXylV2sDoTz5hrK6GSl6ALiIFEEzkBSbKAjjo6G9LRjPyA xg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugcqs0u1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:26:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL2Q0T6012670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:26:00 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 18:25:55 -0800
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
Subject: [PATCH v3 8/8] coresight-tpdm: Add msr register support for CMB
Date:   Tue, 21 Nov 2023 10:24:54 +0800
Message-ID: <1700533494-19276-9-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Deb4HyrRbbUuJJYXs1kaMbzX2gx754Fa
X-Proofpoint-GUID: Deb4HyrRbbUuJJYXs1kaMbzX2gx754Fa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes for CMB subunit MSR(mux select register) support.
CMB MSRs(mux select registers) is to separate mux,arbitration,
,interleaving,data packing control from stream filtering control.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tpdm  |  8 ++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 86 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h  | 16 +++-
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index e0b77107be13..914f3fd81525 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -249,3 +249,11 @@ Description:
 		Accepts only one of the 2 values -  0 or 1.
 		0 : Disable the timestamp of all trace packets.
 		1 : Enable the timestamp of all trace packets.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_msr/msr[0:31]
+Date:		September 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the MSR(mux select register) for the CMB subunit
+		TPDM.
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index f6cda5616e84..7e331ea436cc 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -86,6 +86,11 @@ static ssize_t tpdm_simple_dataset_show(struct device *dev,
 			return -EINVAL;
 		return sysfs_emit(buf, "0x%x\n",
 			drvdata->cmb->patt_mask[tpdm_attr->idx]);
+	case CMB_MSR:
+		if (tpdm_attr->idx >= drvdata->cmb_msr_num)
+			return -EINVAL;
+		return sysfs_emit(buf, "0x%x\n",
+				drvdata->cmb->msr[tpdm_attr->idx]);
 	}
 	return -EINVAL;
 }
@@ -162,6 +167,12 @@ static ssize_t tpdm_simple_dataset_store(struct device *dev,
 		else
 			ret = -EINVAL;
 		break;
+	case CMB_MSR:
+		if (tpdm_attr->idx < drvdata->cmb_msr_num)
+			drvdata->cmb->msr[tpdm_attr->idx] = val;
+		else
+			ret = -EINVAL;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -220,6 +231,23 @@ static umode_t tpdm_dsb_msr_is_visible(struct kobject *kobj,
 	return 0;
 }
 
+static umode_t tpdm_cmb_msr_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	struct device_attribute *dev_attr =
+		container_of(attr, struct device_attribute, attr);
+	struct tpdm_dataset_attribute *tpdm_attr =
+		container_of(dev_attr, struct tpdm_dataset_attribute, attr);
+
+	if (tpdm_attr->idx < drvdata->cmb_msr_num)
+		return attr->mode;
+
+	return 0;
+}
+
 static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
 {
 	if (tpdm_has_dsb_dataset(drvdata)) {
@@ -361,6 +389,15 @@ static void set_cmb_tier(struct tpdm_drvdata *drvdata)
 	writel_relaxed(val, drvdata->base + TPDM_CMB_TIER);
 }
 
+static void set_cmb_msr(struct tpdm_drvdata *drvdata)
+{
+	int i;
+
+	for (i = 0; i < drvdata->cmb_msr_num; i++)
+		writel_relaxed(drvdata->cmb->msr[i],
+			   drvdata->base + TPDM_CMB_MSR(i));
+}
+
 static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
 {
 	u32 val, i;
@@ -379,6 +416,8 @@ static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
 
 	set_cmb_tier(drvdata);
 
+	set_cmb_msr(drvdata);
+
 	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
 	/*
 	 * Set to 0 for continuous CMB collection mode,
@@ -1084,6 +1123,42 @@ static struct attribute *tpdm_cmb_patt_attrs[] = {
 	NULL,
 };
 
+static struct attribute *tpdm_cmb_msr_attrs[] = {
+	CMB_MSR_ATTR(0),
+	CMB_MSR_ATTR(1),
+	CMB_MSR_ATTR(2),
+	CMB_MSR_ATTR(3),
+	CMB_MSR_ATTR(4),
+	CMB_MSR_ATTR(5),
+	CMB_MSR_ATTR(6),
+	CMB_MSR_ATTR(7),
+	CMB_MSR_ATTR(8),
+	CMB_MSR_ATTR(9),
+	CMB_MSR_ATTR(10),
+	CMB_MSR_ATTR(11),
+	CMB_MSR_ATTR(12),
+	CMB_MSR_ATTR(13),
+	CMB_MSR_ATTR(14),
+	CMB_MSR_ATTR(15),
+	CMB_MSR_ATTR(16),
+	CMB_MSR_ATTR(17),
+	CMB_MSR_ATTR(18),
+	CMB_MSR_ATTR(19),
+	CMB_MSR_ATTR(20),
+	CMB_MSR_ATTR(21),
+	CMB_MSR_ATTR(22),
+	CMB_MSR_ATTR(23),
+	CMB_MSR_ATTR(24),
+	CMB_MSR_ATTR(25),
+	CMB_MSR_ATTR(26),
+	CMB_MSR_ATTR(27),
+	CMB_MSR_ATTR(28),
+	CMB_MSR_ATTR(29),
+	CMB_MSR_ATTR(30),
+	CMB_MSR_ATTR(31),
+	NULL,
+};
+
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_trig_ts.attr,
@@ -1144,6 +1219,12 @@ static struct attribute_group tpdm_cmb_patt_grp = {
 	.name = "cmb_patt",
 };
 
+static struct attribute_group tpdm_cmb_msr_grp = {
+	.attrs = tpdm_cmb_msr_attrs,
+	.is_visible = tpdm_cmb_msr_is_visible,
+	.name = "cmb_msr",
+};
+
 static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
 	&tpdm_dsb_attr_grp,
@@ -1154,6 +1235,7 @@ static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_cmb_attr_grp,
 	&tpdm_cmb_trig_patt_grp,
 	&tpdm_cmb_patt_grp,
+	&tpdm_cmb_msr_grp,
 	NULL,
 };
 
@@ -1192,6 +1274,10 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 		of_property_read_u32(drvdata->dev->of_node,
 			   "qcom,dsb-msrs-num", &drvdata->dsb_msr_num);
 
+	if (drvdata && tpdm_has_cmb_dataset(drvdata))
+		of_property_read_u32(drvdata->dev->of_node,
+			   "qcom,cmb-msrs-num", &drvdata->cmb_msr_num);
+
 	/* Set up coresight component description */
 	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
 	if (!desc.name)
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 65b7ca6c4077..255104d024ab 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -21,6 +21,8 @@
 #define TPDM_CMB_XPR(n)		(0xA18 + (n * 4))
 /*CMB subunit trigger pattern mask registers*/
 #define TPDM_CMB_XPMR(n)	(0xA20 + (n * 4))
+/* CMB MSR register */
+#define TPDM_CMB_MSR(n)		(0xA80 + (n * 4))
 
 /* Enable bit for CMB subunit */
 #define TPDM_CMB_CR_ENA		BIT(0)
@@ -36,6 +38,9 @@
 /*Patten register number*/
 #define TPDM_CMB_MAX_PATT		2
 
+/* MAX number of DSB MSR */
+#define TPDM_CMB_MAX_MSR 32
+
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
@@ -186,6 +191,10 @@
 		tpdm_simple_dataset_rw(tpmr##nr,		\
 		CMB_PATT_MASK, nr)
 
+#define CMB_MSR_ATTR(nr)					\
+		tpdm_simple_dataset_rw(msr##nr,			\
+		CMB_MSR, nr)
+
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
  * @mode:             DSB programming mode
@@ -225,6 +234,7 @@ struct dsb_dataset {
  * @patt_mask:        Save value for pattern mask
  * @trig_patt:        Save value for trigger pattern
  * @trig_patt_mask:   Save value for trigger pattern mask
+ * @msr               Save value for MSR
  * @patt_ts:          Indicates if pattern match for timestamp is enabled.
  * @trig_ts:          Indicates if CTI trigger for timestamp is enabled.
  * @ts_all:           Indicates if timestamp is enabled for all packets.
@@ -235,6 +245,7 @@ struct cmb_dataset {
 	u32			patt_mask[TPDM_CMB_MAX_PATT];
 	u32			trig_patt[TPDM_CMB_MAX_PATT];
 	u32			trig_patt_mask[TPDM_CMB_MAX_PATT];
+	u32			msr[TPDM_CMB_MAX_MSR];
 	bool			patt_ts;
 	bool			trig_ts;
 	bool			ts_all;
@@ -251,6 +262,7 @@ struct cmb_dataset {
  * @dsb         Specifics associated to TPDM DSB.
  * @cmb         Specifics associated to TPDM CMB.
  * @dsb_msr_num Number of MSR supported by DSB TPDM
+ * @cmb_msr_num Number of MSR supported by CMB TPDM
  */
 
 struct tpdm_drvdata {
@@ -263,6 +275,7 @@ struct tpdm_drvdata {
 	struct dsb_dataset	*dsb;
 	struct cmb_dataset	*cmb;
 	u32			dsb_msr_num;
+	u32			cmb_msr_num;
 };
 
 /* Enumerate members of various datasets */
@@ -277,7 +290,8 @@ enum dataset_mem {
 	CMB_TRIG_PATT,
 	CMB_TRIG_PATT_MASK,
 	CMB_PATT,
-	CMB_PATT_MASK
+	CMB_PATT_MASK,
+	CMB_MSR
 };
 
 /**
-- 
2.17.1

