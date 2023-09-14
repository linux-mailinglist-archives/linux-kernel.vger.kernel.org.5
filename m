Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4772579FAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjINFoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjINFo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:44:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DB4B9;
        Wed, 13 Sep 2023 22:44:22 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E4qHIi001878;
        Thu, 14 Sep 2023 05:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ikDtLp7lQLKIHaZc+T6UUz3EWyeMOVZR4ce1o84zuig=;
 b=JDiI9OgbOCrg8viVGirdm5zjRmg5CwSLbqm3uR+2hBwO/jnm5dJKXdCVcryB4DcqV1ot
 FGrsaj8fG/qf25jBDweUABTSMdFM2ddgPXK4Yd7qyYvxbVGpneEJxeggI+gBwd6qjtxV
 zyh68qCA7r1jV4Uv7/Xnk37veVSqRSYn0QgaexbOofjyAZvCoQG8zewIrNMgtrXpK0uq
 znuS6wTWZYtb74FRO54xRRbcV70NAnUJZgz5LonG7IY68yOiuLydWPosu6N6Y4m4NGmv
 flIcGsQkGdGkSysj91eLgSAWJzo017Aci+NJD5EPmtEOxyt+tqbYz9OrfFKKe5e4HeX+ lw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y8q3jst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 05:44:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E5iBxe009977
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 05:44:11 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 13 Sep 2023 22:44:06 -0700
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
Subject: [PATCH v9 04/13] coresight-tpda: Add DSB dataset support
Date:   Thu, 14 Sep 2023 13:43:15 +0800
Message-ID: <1694670204-11515-5-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: xhB_sZbFLvIQqwYPv5waJloSqxXYJjse
X-Proofpoint-GUID: xhB_sZbFLvIQqwYPv5waJloSqxXYJjse
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_03,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the DSB element size from the device tree. Set the register
bit that controls the DSB element size of the corresponding port.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 126 ++++++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tpda.h |   2 +
 2 files changed, 118 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 8d2b9d2..5f82737 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -21,6 +21,80 @@
 
 DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
 
+static bool coresight_device_is_tpdm(struct coresight_device *csdev)
+{
+	return (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
+	       (csdev->subtype.source_subtype ==
+			CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
+}
+
+/*
+ * Read the DSB element size from the TPDM device
+ * Returns
+ *    The dsb element size read from the devicetree if available.
+ *    0 - Otherwise, with a warning once.
+ */
+static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
+{
+	int rc = 0;
+	u8 size = 0;
+
+	rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
+			"qcom,dsb-element-size", &size);
+	if (rc)
+		dev_warn_once(&csdev->dev,
+			"Failed to read TPDM DSB Element size: %d\n", rc);
+
+	return size;
+}
+
+/*
+ * Search and read element data size from the TPDM node in
+ * the devicetree. Each input port of TPDA is connected to
+ * a TPDM. Different TPDM supports different types of dataset,
+ * and some may support more than one type of dataset.
+ * Parameter "inport" is used to pass in the input port number
+ * of TPDA, and it is set to -1 in the recursize call.
+ */
+static int tpda_get_element_size(struct coresight_device *csdev,
+				 int inport)
+{
+	int dsb_size = -ENOENT;
+	int i, size;
+	struct coresight_device *in;
+
+	for (i = 0; i < csdev->pdata->nr_inconns; i++) {
+		in = csdev->pdata->in_conns[i]->src_dev;
+		if (!in)
+			continue;
+
+		/* Ignore the paths that do not match port */
+		if (inport > 0 &&
+		    csdev->pdata->in_conns[i]->dest_port != inport)
+			continue;
+
+		if (coresight_device_is_tpdm(in)) {
+			size = tpdm_read_dsb_element_size(in);
+		} else {
+			/* Recurse down the path */
+			size = tpda_get_element_size(in, -1);
+		}
+
+		if (size < 0)
+			return size;
+
+		if (dsb_size < 0) {
+			/* Found a size, save it. */
+			dsb_size = size;
+		} else {
+			/* Found duplicate TPDMs */
+			return -EEXIST;
+		}
+	}
+
+	return dsb_size;
+}
+
 /* Settings pre enabling port control register */
 static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
 {
@@ -32,26 +106,55 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
 	writel_relaxed(val, drvdata->base + TPDA_CR);
 }
 
-static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
+static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
 {
 	u32 val;
+	int size;
 
 	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
+	/*
+	 * Configure aggregator port n DSB data set element size
+	 * Set the bit to 0 if the size is 32
+	 * Set the bit to 1 if the size is 64
+	 */
+	size = tpda_get_element_size(drvdata->csdev, port);
+	switch (size) {
+	case 32:
+		val &= ~TPDA_Pn_CR_DSBSIZE;
+		break;
+	case 64:
+		val |= TPDA_Pn_CR_DSBSIZE;
+		break;
+	case 0:
+		return -EEXIST;
+	case -EEXIST:
+		dev_warn_once(&drvdata->csdev->dev,
+			"Detected multiple TPDMs on port %d", -EEXIST);
+		return -EEXIST;
+	default:
+		return -EINVAL;
+	}
+
 	/* Enable the port */
 	val |= TPDA_Pn_CR_ENA;
 	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
+
+	return 0;
 }
 
-static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
+static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
 {
+	int ret;
+
 	CS_UNLOCK(drvdata->base);
 
 	if (!drvdata->csdev->enable)
 		tpda_enable_pre_port(drvdata);
 
-	tpda_enable_port(drvdata, port);
-
+	ret = tpda_enable_port(drvdata, port);
 	CS_LOCK(drvdata->base);
+
+	return ret;
 }
 
 static int tpda_enable(struct coresight_device *csdev,
@@ -59,16 +162,19 @@ static int tpda_enable(struct coresight_device *csdev,
 		       struct coresight_connection *out)
 {
 	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int ret = 0;
 
 	spin_lock(&drvdata->spinlock);
-	if (atomic_read(&in->dest_refcnt) == 0)
-		__tpda_enable(drvdata, in->dest_port);
+	if (atomic_read(&in->dest_refcnt) == 0) {
+		ret = __tpda_enable(drvdata, in->dest_port);
+		if (!ret) {
+			atomic_inc(&in->dest_refcnt);
+			dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
+		}
+	}
 
-	atomic_inc(&in->dest_refcnt);
 	spin_unlock(&drvdata->spinlock);
-
-	dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
-	return 0;
+	return ret;
 }
 
 static void __tpda_disable(struct tpda_drvdata *drvdata, int port)
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index 0399678..b3b38fd 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -10,6 +10,8 @@
 #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
 /* Aggregator port enable bit */
 #define TPDA_Pn_CR_ENA		BIT(0)
+/* Aggregator port DSB data set element size bit */
+#define TPDA_Pn_CR_DSBSIZE		BIT(8)
 
 #define TPDA_MAX_INPORTS	32
 
-- 
2.7.4

