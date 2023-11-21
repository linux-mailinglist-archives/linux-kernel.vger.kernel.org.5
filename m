Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259A77F23DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjKUCZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKUCZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:25:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390A59C;
        Mon, 20 Nov 2023 18:25:47 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL20lPN026928;
        Tue, 21 Nov 2023 02:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=HsQb9zpIaM7YpyH9MrnW2C1i5Czy1jzfJhu9Tq8xYwg=;
 b=fUkZprko6SdxcR6JZ14KmbxFB/fritKO4/qarg/UpWaUjMTF7vNC64XU4c7wGy8klBGp
 IH9tgqqrCwa8l6jYGc+MmYy81yR2GcSVIEmNj0LWSEE3TxSpiBv+g8j6snV1A+PF0Okv
 2x9JDadBfZ0VtvV6juPg4lP3RQD0HKiAAymssKl1Eu14aB2kJ1lMj3C/jm5GzORTjePk
 oHd/SoMBz5DBwai7hEPjxfQJ5h/4XbS7W+AlupEgPtb6RHKEoxVYb8F1BUR2TG7f3VML
 JzUaImEhbtByCFVmRYcea9mvFILG+cJexjvQmXxFNTVAQ9kDElnh0pjc2MTac/NBfTTf +w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugk6x0248-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:25:30 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL2PTd7010969
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:25:29 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 18:25:24 -0800
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
Subject: [PATCH v3 2/8] coresight-tpda: Add support to configure CMB element
Date:   Tue, 21 Nov 2023 10:24:48 +0800
Message-ID: <1700533494-19276-3-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-GUID: htpAcxqzBzmcKcPbh9qxnJOY90qZfgnh
X-Proofpoint-ORIG-GUID: htpAcxqzBzmcKcPbh9qxnJOY90qZfgnh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=837
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

Read the CMB element size from the device tree. Set the register
bit that controls the CMB element size of the corresponding port.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 117 +++++++++++--------
 drivers/hwtracing/coresight/coresight-tpda.h |   6 +
 2 files changed, 74 insertions(+), 49 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 5f82737c37bb..e3762f38abb3 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -28,24 +28,54 @@ static bool coresight_device_is_tpdm(struct coresight_device *csdev)
 			CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
 }
 
+static void tpdm_clear_element_size(struct coresight_device *csdev)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (drvdata->dsb_esize)
+		drvdata->dsb_esize = 0;
+	if (drvdata->cmb_esize)
+		drvdata->cmb_esize = 0;
+}
+
+static void tpda_set_element_size(struct tpda_drvdata *drvdata, u32 *val)
+{
+
+	if (drvdata->dsb_esize == 64)
+		*val |= TPDA_Pn_CR_DSBSIZE;
+	else if (drvdata->dsb_esize == 32)
+		*val &= ~TPDA_Pn_CR_DSBSIZE;
+
+	if (drvdata->cmb_esize == 64)
+		*val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
+	else if (drvdata->cmb_esize == 32)
+		*val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);
+	else if (drvdata->cmb_esize == 8)
+		*val &= ~TPDA_Pn_CR_CMBSIZE;
+}
+
 /*
- * Read the DSB element size from the TPDM device
+ * Read the element size from the TPDM device
  * Returns
- *    The dsb element size read from the devicetree if available.
+ *    The element size read from the devicetree if available.
  *    0 - Otherwise, with a warning once.
  */
-static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
+static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
+				  struct coresight_device *csdev)
 {
-	int rc = 0;
-	u8 size = 0;
-
-	rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
-			"qcom,dsb-element-size", &size);
+	int rc = -EINVAL;
+
+	if (!fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
+			"qcom,dsb-element-size", &drvdata->dsb_esize))
+		rc = 0;
+	if (!fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
+			"qcom,cmb-element-size", &drvdata->cmb_esize))
+		rc = 0;
 	if (rc)
 		dev_warn_once(&csdev->dev,
-			"Failed to read TPDM DSB Element size: %d\n", rc);
+			"Failed to read TPDM Element size: %d\n", rc);
 
-	return size;
+	return rc;
 }
 
 /*
@@ -56,11 +86,12 @@ static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
  * Parameter "inport" is used to pass in the input port number
  * of TPDA, and it is set to -1 in the recursize call.
  */
-static int tpda_get_element_size(struct coresight_device *csdev,
+static int tpda_get_element_size(struct tpda_drvdata *drvdata,
+				 struct coresight_device *csdev,
 				 int inport)
 {
-	int dsb_size = -ENOENT;
-	int i, size;
+	int rc = 0;
+	int i;
 	struct coresight_device *in;
 
 	for (i = 0; i < csdev->pdata->nr_inconns; i++) {
@@ -74,25 +105,21 @@ static int tpda_get_element_size(struct coresight_device *csdev,
 			continue;
 
 		if (coresight_device_is_tpdm(in)) {
-			size = tpdm_read_dsb_element_size(in);
+			if ((drvdata->dsb_esize) || (drvdata->cmb_esize))
+				return -EEXIST;
+			rc = tpdm_read_element_size(drvdata, in);
+			if (rc)
+				return rc;
 		} else {
 			/* Recurse down the path */
-			size = tpda_get_element_size(in, -1);
-		}
-
-		if (size < 0)
-			return size;
-
-		if (dsb_size < 0) {
-			/* Found a size, save it. */
-			dsb_size = size;
-		} else {
-			/* Found duplicate TPDMs */
-			return -EEXIST;
+			rc = tpda_get_element_size(drvdata, in, -1);
+			if (rc)
+				return rc;
 		}
 	}
 
-	return dsb_size;
+
+	return rc;
 }
 
 /* Settings pre enabling port control register */
@@ -109,7 +136,7 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
 static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
 {
 	u32 val;
-	int size;
+	int rc;
 
 	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
 	/*
@@ -117,29 +144,21 @@ static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
 	 * Set the bit to 0 if the size is 32
 	 * Set the bit to 1 if the size is 64
 	 */
-	size = tpda_get_element_size(drvdata->csdev, port);
-	switch (size) {
-	case 32:
-		val &= ~TPDA_Pn_CR_DSBSIZE;
-		break;
-	case 64:
-		val |= TPDA_Pn_CR_DSBSIZE;
-		break;
-	case 0:
-		return -EEXIST;
-	case -EEXIST:
+	tpdm_clear_element_size(drvdata->csdev);
+	rc = tpda_get_element_size(drvdata, drvdata->csdev, port);
+	if (!rc && ((drvdata->dsb_esize) || (drvdata->cmb_esize))) {
+		tpda_set_element_size(drvdata, &val);
+		/* Enable the port */
+		val |= TPDA_Pn_CR_ENA;
+		writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
+	} else if (rc == -EEXIST)
 		dev_warn_once(&drvdata->csdev->dev,
-			"Detected multiple TPDMs on port %d", -EEXIST);
-		return -EEXIST;
-	default:
-		return -EINVAL;
-	}
-
-	/* Enable the port */
-	val |= TPDA_Pn_CR_ENA;
-	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
+			      "Detected multiple TPDMs on port %d", -EEXIST);
+	else
+		dev_warn_once(&drvdata->csdev->dev,
+			      "Didn't find TPDM elem size");
 
-	return 0;
+	return rc;
 }
 
 static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index b3b38fd41b64..29164fd9711f 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -10,6 +10,8 @@
 #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
 /* Aggregator port enable bit */
 #define TPDA_Pn_CR_ENA		BIT(0)
+/* Aggregator port CMB data set element size bit */
+#define TPDA_Pn_CR_CMBSIZE		GENMASK(7, 6)
 /* Aggregator port DSB data set element size bit */
 #define TPDA_Pn_CR_DSBSIZE		BIT(8)
 
@@ -25,6 +27,8 @@
  * @csdev:      component vitals needed by the framework.
  * @spinlock:   lock for the drvdata value.
  * @enable:     enable status of the component.
+ * @dsb_esize   Record the DSB element size.
+ * @cmb_esize   Record the CMB element size.
  */
 struct tpda_drvdata {
 	void __iomem		*base;
@@ -32,6 +36,8 @@ struct tpda_drvdata {
 	struct coresight_device	*csdev;
 	spinlock_t		spinlock;
 	u8			atid;
+	u8			dsb_esize;
+	u8			cmb_esize;
 };
 
 #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
-- 
2.17.1

