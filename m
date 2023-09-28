Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC987B130C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjI1GcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjI1Gbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:31:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6FA1718;
        Wed, 27 Sep 2023 23:31:23 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S5bjB7005507;
        Thu, 28 Sep 2023 06:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=pf9cl9ZX82zSKfbPyByPHOIoB0x4SqiPluvuj19aQC0=;
 b=HPfrOStQE4ZAKQXln3E9hxi7/YFlle6NAAwJW9dA13rfYCoO49BZdQ2lmHAPRpgIiC1w
 xw+03ZqfjNFxnzsPtc1QKRoxNXK31Tcg5oCvTyvRkFxpfa5CHmEHLAkokLAA2CoDRUUP
 E2WZXRp+G/6qzHXglmcB6qXD5HEEn97YhV/Vn3hhLf64h7IbDZLfmqqLWnc7zdqcyXcw
 NKG6GG6esB2bjsZh0SOaoXLeTqey97VafuV8E0spsNB6wWgMVdvCpi7GeXgM6aape/br
 T27/BiT6cN6sCHiKNlTb7ehdenELZagsNsD+qPm9xeY4uAjFA+udmSD6fya+9PymSWMu Rw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td3gg82ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 06:31:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38S6V3kW013076
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 06:31:03 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 27 Sep 2023 23:30:58 -0700
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
Subject: [PATCH v10 10/13] coresight-tpdm: Add nodes to configure pattern match output
Date:   Thu, 28 Sep 2023 14:29:43 +0800
Message-ID: <1695882586-10306-11-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-GUID: v-IhV0uqRgeKeGq6rW5aPGOySMEDthKI
X-Proofpoint-ORIG-GUID: v-IhV0uqRgeKeGq6rW5aPGOySMEDthKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_03,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309280053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../testing/sysfs-bus-coresight-devices-tpdm  | 18 +++-
 drivers/hwtracing/coresight/coresight-tpdm.c  | 82 ++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h  | 28 +++++++
 3 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 6853bb1295e3..2252e4706a90 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -107,4 +107,20 @@ Date:		March 2023
 KernelVersion	6.7
 Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
 Description:
-		Read a set of the edge control mask of the DSB in TPDM.
\ No newline at end of file
+		Read a set of the edge control mask of the DSB in TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt/xpr[0:7]
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the value of the trigger pattern for the DSB
+		subunit TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt/xpmr[0:7]
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the mask of the trigger pattern for the DSB
+		subunit TPDM.
\ No newline at end of file
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 7175e70c2c4e..e04c41f83265 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -41,10 +41,58 @@ static ssize_t tpdm_simple_dataset_show(struct device *dev,
 			return -EINVAL;
 		return sysfs_emit(buf, "0x%x\n",
 			drvdata->dsb->edge_ctrl_mask[tpdm_attr->idx]);
+	case DSB_TRIG_PATT:
+		if (tpdm_attr->idx >= TPDM_DSB_MAX_PATT)
+			return -EINVAL;
+		return sysfs_emit(buf, "0x%x\n",
+			drvdata->dsb->trig_patt[tpdm_attr->idx]);
+	case DSB_TRIG_PATT_MASK:
+		if (tpdm_attr->idx >= TPDM_DSB_MAX_PATT)
+			return -EINVAL;
+		return sysfs_emit(buf, "0x%x\n",
+			drvdata->dsb->trig_patt_mask[tpdm_attr->idx]);
 	}
 	return -EINVAL;
 }
 
+/* Write dataset array member with the index number */
+static ssize_t tpdm_simple_dataset_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t size)
+{
+	unsigned long val;
+	ssize_t ret = size;
+
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct tpdm_dataset_attribute *tpdm_attr =
+		container_of(attr, struct tpdm_dataset_attribute, attr);
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	switch (tpdm_attr->mem) {
+	case DSB_TRIG_PATT:
+		if (tpdm_attr->idx < TPDM_DSB_MAX_PATT)
+			drvdata->dsb->trig_patt[tpdm_attr->idx] = val;
+		else
+			ret = -EINVAL;
+		break;
+	case DSB_TRIG_PATT_MASK:
+		if (tpdm_attr->idx < TPDM_DSB_MAX_PATT)
+			drvdata->dsb->trig_patt_mask[tpdm_attr->idx] = val;
+		else
+			ret = -EINVAL;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	spin_unlock(&drvdata->spinlock);
+
+	return ret;
+}
+
 static bool tpdm_has_dsb_dataset(struct tpdm_drvdata *drvdata)
 {
 	return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
@@ -103,7 +151,12 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 	for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
 		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
 			   drvdata->base + TPDM_DSB_EDCMR(i));
-
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		writel_relaxed(drvdata->dsb->trig_patt[i],
+			   drvdata->base + TPDM_DSB_XPR(i));
+		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
+			   drvdata->base + TPDM_DSB_XPMR(i));
+	}
 	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
 	/* Set trigger timestamp */
 	if (drvdata->dsb->trig_ts)
@@ -532,6 +585,26 @@ static struct attribute *tpdm_dsb_edge_attrs[] = {
 	NULL,
 };
 
+static struct attribute *tpdm_dsb_trig_patt_attrs[] = {
+	DSB_TRIG_PATT_ATTR(0),
+	DSB_TRIG_PATT_ATTR(1),
+	DSB_TRIG_PATT_ATTR(2),
+	DSB_TRIG_PATT_ATTR(3),
+	DSB_TRIG_PATT_ATTR(4),
+	DSB_TRIG_PATT_ATTR(5),
+	DSB_TRIG_PATT_ATTR(6),
+	DSB_TRIG_PATT_ATTR(7),
+	DSB_TRIG_PATT_MASK_ATTR(0),
+	DSB_TRIG_PATT_MASK_ATTR(1),
+	DSB_TRIG_PATT_MASK_ATTR(2),
+	DSB_TRIG_PATT_MASK_ATTR(3),
+	DSB_TRIG_PATT_MASK_ATTR(4),
+	DSB_TRIG_PATT_MASK_ATTR(5),
+	DSB_TRIG_PATT_MASK_ATTR(6),
+	DSB_TRIG_PATT_MASK_ATTR(7),
+	NULL,
+};
+
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_trig_ts.attr,
@@ -550,10 +623,17 @@ static struct attribute_group tpdm_dsb_edge_grp = {
 	.name = "dsb_edge",
 };
 
+static struct attribute_group tpdm_dsb_trig_patt_grp = {
+	.attrs = tpdm_dsb_trig_patt_attrs,
+	.is_visible = tpdm_dsb_is_visible,
+	.name = "dsb_trig_patt",
+};
+
 static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
 	&tpdm_dsb_attr_grp,
 	&tpdm_dsb_edge_grp,
+	&tpdm_dsb_trig_patt_grp,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index a9c65d96316a..2cf7bdbdbb15 100644
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
 
@@ -80,6 +82,8 @@
 #define TPDM_DSB_MAX_EDCR	16
 /* MAX number of EDCMR registers */
 #define TPDM_DSB_MAX_EDCMR	8
+/* MAX number of DSB pattern */
+#define TPDM_DSB_MAX_PATT	8
 
 #define tpdm_simple_dataset_ro(name, mem, idx)			\
 	(&((struct tpdm_dataset_attribute[]) {			\
@@ -90,6 +94,16 @@
 	   }								\
 	})[0].attr.attr)
 
+#define tpdm_simple_dataset_rw(name, mem, idx)			\
+	(&((struct tpdm_dataset_attribute[]) {			\
+	   {								\
+		__ATTR(name, 0644, tpdm_simple_dataset_show,		\
+		tpdm_simple_dataset_store),		\
+		mem,							\
+		idx,							\
+	   }								\
+	})[0].attr.attr)
+
 #define DSB_EDGE_CTRL_ATTR(nr)					\
 		tpdm_simple_dataset_ro(edcr##nr,		\
 		DSB_EDGE_CTRL, nr)
@@ -98,12 +112,22 @@
 		tpdm_simple_dataset_ro(edcmr##nr,		\
 		DSB_EDGE_CTRL_MASK, nr)
 
+#define DSB_TRIG_PATT_ATTR(nr)					\
+		tpdm_simple_dataset_rw(xpr##nr,			\
+		DSB_TRIG_PATT, nr)
+
+#define DSB_TRIG_PATT_MASK_ATTR(nr)				\
+		tpdm_simple_dataset_rw(xpmr##nr,		\
+		DSB_TRIG_PATT_MASK, nr)
+
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
  * @mode:             DSB programming mode
  * @edge_ctrl_idx     Index number of the edge control
  * @edge_ctrl:        Save value for edge control
  * @edge_ctrl_mask:   Save value for edge control mask
+ * @trig_patt:        Save value for trigger pattern
+ * @trig_patt_mask:   Save value for trigger pattern mask
  * @trig_ts:          Enable/Disable trigger timestamp.
  * @trig_type:        Enable/Disable trigger type.
  */
@@ -112,6 +136,8 @@ struct dsb_dataset {
 	u32			edge_ctrl_idx;
 	u32			edge_ctrl[TPDM_DSB_MAX_EDCR];
 	u32			edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
+	u32			trig_patt[TPDM_DSB_MAX_PATT];
+	u32			trig_patt_mask[TPDM_DSB_MAX_PATT];
 	bool			trig_ts;
 	bool			trig_type;
 };
@@ -141,6 +167,8 @@ struct tpdm_drvdata {
 enum dataset_mem {
 	DSB_EDGE_CTRL,
 	DSB_EDGE_CTRL_MASK,
+	DSB_TRIG_PATT,
+	DSB_TRIG_PATT_MASK,
 };
 
 /**
-- 
2.17.1

