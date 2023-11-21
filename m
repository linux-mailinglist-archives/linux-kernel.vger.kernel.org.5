Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6FF7F23E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjKUC0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjKUC0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:26:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF50D63;
        Mon, 20 Nov 2023 18:26:01 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL1rthU001968;
        Tue, 21 Nov 2023 02:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=84eClwrrjIk6zmgygAdMPY5ziRBmNKTl5xgBwbSP5q4=;
 b=eMfwLPUFyR5+mWUR3dryxageBgjFqqkCYXTXZsLanh4uHW/hJwLiXE8dYfbIIDae2HuA
 sLUThG7phxw1w5RVD0YfXB0vq3zYGWsNe2f0/zGHUy3HaiEx46bkjo52rY/pdYmTieMN
 azB8ZYVT7Za/efVv+GYH8CDWKh2LgHXp0jOUZW9+KZK6hVaTyioInHmxCrZagBNV+FlY
 AwJYjdN3/YRYBJCHSHxL+fzS6EcVs+011oK3+1EBmCT+5tD6T7aD1kWA4DLeA3hfW3TV
 KjgpWgBnkGahwgYVYluezD+eLeEGkBswfimrMJcj5YqIiBWNnOcxkb7UO8ewkZhZKemQ bQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugk9p81uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:25:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL2Piix009653
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:25:44 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 18:25:39 -0800
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
Subject: [PATCH v3 5/8] coresight-tpdm: Add pattern registers support for CMB
Date:   Tue, 21 Nov 2023 10:24:51 +0800
Message-ID: <1700533494-19276-6-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qW-JH_BoNCkqMROMByM_5gZFXnY92Hbs
X-Proofpoint-ORIG-GUID: qW-JH_BoNCkqMROMByM_5gZFXnY92Hbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timestamps are requested if the monitor’s CMB data set unit input
data matches the value in the Monitor CMB timestamp pattern and mask
registers (M_CMB_TPR and M_CMB_TPMR) when CMB timestamp enabled
via the timestamp insertion enable register bit(CMB_TIER.PATT_TSENAB).
The pattern match trigger output is achieved via setting values into
the CMB trigger pattern and mask registers (CMB_XPR and CMB_XPMR).
After configuring a pattern through these registers, the TPDM subunit
will assert an output trigger every time it receives new input data
that matches the configured pattern value. Values in a given bit
number of the mask register correspond to the same bit number in
the corresponding pattern register.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tpdm  | 30 +++++++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 88 ++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h  | 39 ++++++++
 3 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 246c77c109d7..53662ce7c2d0 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -184,3 +184,33 @@ Description:	(Write) Set the data collection mode of CMB tpdm. Continuous
 		Accepts only one of the 2 values -  0 or 1.
 		0 : Continuous CMB collection mode.
 		1 : Trace-on-change CMB collection mode.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_patt/xpr[0:1]
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the value of the trigger pattern for the CMB
+		subunit TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_patt/xpmr[0:1]
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the mask of the trigger pattern for the CMB
+		subunit TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt/tpr[0:1]
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the value of the pattern for the CMB subunit TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt/tpmr[0:1]
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the mask of the pattern for the CMB subunit TPDM.
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index efb376e069a1..894d4309f1c7 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -66,6 +66,26 @@ static ssize_t tpdm_simple_dataset_show(struct device *dev,
 			return -EINVAL;
 		return sysfs_emit(buf, "0x%x\n",
 				drvdata->dsb->msr[tpdm_attr->idx]);
+	case CMB_TRIG_PATT:
+		if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
+			return -EINVAL;
+		return sysfs_emit(buf, "0x%x\n",
+			drvdata->cmb->trig_patt[tpdm_attr->idx]);
+	case CMB_TRIG_PATT_MASK:
+		if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
+			return -EINVAL;
+		return sysfs_emit(buf, "0x%x\n",
+			drvdata->cmb->trig_patt_mask[tpdm_attr->idx]);
+	case CMB_PATT:
+		if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
+			return -EINVAL;
+		return sysfs_emit(buf, "0x%x\n",
+			drvdata->cmb->patt_val[tpdm_attr->idx]);
+	case CMB_PATT_MASK:
+		if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
+			return -EINVAL;
+		return sysfs_emit(buf, "0x%x\n",
+			drvdata->cmb->patt_mask[tpdm_attr->idx]);
 	}
 	return -EINVAL;
 }
@@ -118,6 +138,30 @@ static ssize_t tpdm_simple_dataset_store(struct device *dev,
 		else
 			ret = -EINVAL;
 		break;
+	case CMB_TRIG_PATT:
+		if (tpdm_attr->idx < TPDM_CMB_MAX_PATT)
+			drvdata->cmb->trig_patt[tpdm_attr->idx] = val;
+		else
+			ret = -EINVAL;
+		break;
+	case CMB_TRIG_PATT_MASK:
+		if (tpdm_attr->idx < TPDM_CMB_MAX_PATT)
+			drvdata->cmb->trig_patt_mask[tpdm_attr->idx] = val;
+		else
+			ret = -EINVAL;
+		break;
+	case CMB_PATT:
+		if (tpdm_attr->idx < TPDM_CMB_MAX_PATT)
+			drvdata->cmb->patt_val[tpdm_attr->idx] = val;
+		else
+			ret = -EINVAL;
+		break;
+	case CMB_PATT_MASK:
+		if (tpdm_attr->idx < TPDM_CMB_MAX_PATT)
+			drvdata->cmb->patt_mask[tpdm_attr->idx] = val;
+		else
+			ret = -EINVAL;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -289,7 +333,19 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 
 static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
 {
-	u32 val;
+	u32 val, i;
+
+	/* Configure pattern registers */
+	for (i = 0; i < TPDM_CMB_MAX_PATT; i++) {
+		writel_relaxed(drvdata->cmb->patt_val[i],
+			    drvdata->base + TPDM_CMB_TPR(i));
+		writel_relaxed(drvdata->cmb->patt_mask[i],
+			    drvdata->base + TPDM_CMB_TPMR(i));
+		writel_relaxed(drvdata->cmb->trig_patt[i],
+			    drvdata->base + TPDM_CMB_XPR(i));
+		writel_relaxed(drvdata->cmb->trig_patt_mask[i],
+			    drvdata->base + TPDM_CMB_XPMR(i));
+	}
 
 	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
 	/*
@@ -904,6 +960,22 @@ static struct attribute *tpdm_dsb_msr_attrs[] = {
 	NULL,
 };
 
+static struct attribute *tpdm_cmb_trig_patt_attrs[] = {
+	CMB_TRIG_PATT_ATTR(0),
+	CMB_TRIG_PATT_ATTR(1),
+	CMB_TRIG_PATT_MASK_ATTR(0),
+	CMB_TRIG_PATT_MASK_ATTR(1),
+	NULL,
+};
+
+static struct attribute *tpdm_cmb_patt_attrs[] = {
+	CMB_PATT_ATTR(0),
+	CMB_PATT_ATTR(1),
+	CMB_PATT_MASK_ATTR(0),
+	CMB_PATT_MASK_ATTR(1),
+	NULL,
+};
+
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_trig_ts.attr,
@@ -950,6 +1022,18 @@ static struct attribute_group tpdm_cmb_attr_grp = {
 	.is_visible = tpdm_cmb_is_visible,
 };
 
+static struct attribute_group tpdm_cmb_trig_patt_grp = {
+	.attrs = tpdm_cmb_trig_patt_attrs,
+	.is_visible = tpdm_cmb_is_visible,
+	.name = "cmb_trig_patt",
+};
+
+static struct attribute_group tpdm_cmb_patt_grp = {
+	.attrs = tpdm_cmb_patt_attrs,
+	.is_visible = tpdm_cmb_is_visible,
+	.name = "cmb_patt",
+};
+
 static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
 	&tpdm_dsb_attr_grp,
@@ -958,6 +1042,8 @@ static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_dsb_patt_grp,
 	&tpdm_dsb_msr_grp,
 	&tpdm_cmb_attr_grp,
+	&tpdm_cmb_trig_patt_grp,
+	&tpdm_cmb_patt_grp,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index c6b36d2fe45a..e90d008c1cb2 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -11,12 +11,23 @@
 
 /* CMB Subunit Registers */
 #define TPDM_CMB_CR		(0xA00)
+/*CMB subunit timestamp pattern registers*/
+#define TPDM_CMB_TPR(n)		(0xA08 + (n * 4))
+/*CMB subunit timestamp pattern mask registers*/
+#define TPDM_CMB_TPMR(n)	(0xA10 + (n * 4))
+/*CMB subunit trigger pattern registers*/
+#define TPDM_CMB_XPR(n)		(0xA18 + (n * 4))
+/*CMB subunit trigger pattern mask registers*/
+#define TPDM_CMB_XPMR(n)	(0xA20 + (n * 4))
 
 /* Enable bit for CMB subunit */
 #define TPDM_CMB_CR_ENA		BIT(0)
 /* Trace collection mode for CMB subunit */
 #define TPDM_CMB_CR_MODE	BIT(1)
 
+/*Patten register number*/
+#define TPDM_CMB_MAX_PATT		2
+
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
@@ -151,6 +162,22 @@
 		tpdm_simple_dataset_rw(msr##nr,			\
 		DSB_MSR, nr)
 
+#define CMB_TRIG_PATT_ATTR(nr)					\
+		tpdm_simple_dataset_rw(xpr##nr,			\
+		CMB_TRIG_PATT, nr)
+
+#define CMB_TRIG_PATT_MASK_ATTR(nr)				\
+		tpdm_simple_dataset_rw(xpmr##nr,		\
+		CMB_TRIG_PATT_MASK, nr)
+
+#define CMB_PATT_ATTR(nr)					\
+		tpdm_simple_dataset_rw(tpr##nr,			\
+		CMB_PATT, nr)
+
+#define CMB_PATT_MASK_ATTR(nr)					\
+		tpdm_simple_dataset_rw(tpmr##nr,		\
+		CMB_PATT_MASK, nr)
+
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
  * @mode:             DSB programming mode
@@ -186,9 +213,17 @@ struct dsb_dataset {
 /**
  * struct cmb_dataset
  * @trace_mode:       Dataset collection mode
+ * @patt_val:         Save value for pattern
+ * @patt_mask:        Save value for pattern mask
+ * @trig_patt:        Save value for trigger pattern
+ * @trig_patt_mask:   Save value for trigger pattern mask
  */
 struct cmb_dataset {
 	u32			trace_mode;
+	u32			patt_val[TPDM_CMB_MAX_PATT];
+	u32			patt_mask[TPDM_CMB_MAX_PATT];
+	u32			trig_patt[TPDM_CMB_MAX_PATT];
+	u32			trig_patt_mask[TPDM_CMB_MAX_PATT];
 };
 
 /**
@@ -225,6 +260,10 @@ enum dataset_mem {
 	DSB_PATT,
 	DSB_PATT_MASK,
 	DSB_MSR,
+	CMB_TRIG_PATT,
+	CMB_TRIG_PATT_MASK,
+	CMB_PATT,
+	CMB_PATT_MASK
 };
 
 /**
-- 
2.17.1

