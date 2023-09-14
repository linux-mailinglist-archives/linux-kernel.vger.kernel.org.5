Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFA179FB02
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjINFol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjINFoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:44:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C50CE;
        Wed, 13 Sep 2023 22:44:28 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E5X0HW008160;
        Thu, 14 Sep 2023 05:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8I8dvjRKFxdYOty8DWONS1DQJCy1ikvW6teu8kFaMuY=;
 b=GA9wg/Q1yLC5c9cDxtWQ793idPMUmPqDabKgjcSVbz3Q+D+/ewyQ0UwchoDA9g5T5xTp
 hIJWjBlIVDaZCwPXwjOeymbICaNdSJJyzJB1h1M8Draw7Hi6Vhotbp4auW4c59EZ6iCj
 UxlLgBvMgTLY2a6rJd0o2NZse8P+Bq9Jo3mQM790B8UweKLOuW0Cq8R581HBp+l2zMyl
 kcJktD4ltJML3CHsSVm9vDT9Z7+3MS/m7G0i0MVEqtr2iJ6B9DWfg+DnGe2lsyey1CfQ
 M+uHBGKGGbz/ElmJOnUR0dtn2KJjOehNYRzkjota1JC90sSRTEjpKgN+8C2smgk1Tqko JA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3v4g80ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 05:44:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E5iGP0018092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 05:44:16 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 13 Sep 2023 22:44:11 -0700
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
Subject: [PATCH v9 05/13] coresight-tpdm: Initialize DSB subunit configuration
Date:   Thu, 14 Sep 2023 13:43:16 +0800
Message-ID: <1694670204-11515-6-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694670204-11515-1-git-send-email-quic_taozha@quicinc.com>
References: <1694670204-11515-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X-NqwTODRSZqp219yOCO7dW_1FVW8EQZ
X-Proofpoint-GUID: X-NqwTODRSZqp219yOCO7dW_1FVW8EQZ
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

DSB is used for monitoring “events”. Events are something that
occurs at some point in time. It could be a state decode, the
act of writing/reading a particular address, a FIFO being empty,
etc. This decoding of the event desired is done outside TPDM.
DSB subunit need to be configured in enablement and disablement.
A struct that specifics associated to dsb dataset is needed. It
saves the configuration and parameters of the dsb datasets. This
change is to add this struct and initialize the configuration of
DSB subunit.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 64 ++++++++++++++++++++++++----
 drivers/hwtracing/coresight/coresight-tpdm.h | 18 ++++++++
 2 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index abaff0b..951ad4d 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -20,23 +20,57 @@
 
 DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
 
+static bool tpdm_has_dsb_dataset(struct tpdm_drvdata *drvdata)
+{
+	return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
+}
+
+static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
+{
+	if (tpdm_has_dsb_dataset(drvdata)) {
+		memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
+
+		drvdata->dsb->trig_ts = true;
+		drvdata->dsb->trig_type = false;
+	}
+}
+
 static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
 	u32 val;
 
-	/* Set the enable bit of DSB control register to 1 */
+	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
+	/* Set trigger timestamp */
+	if (drvdata->dsb->trig_ts)
+		val |= TPDM_DSB_TIER_XTRIG_TSENAB;
+	else
+		val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
+	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
+
 	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+	/* Set trigger type */
+	if (drvdata->dsb->trig_type)
+		val |= TPDM_DSB_CR_TRIG_TYPE;
+	else
+		val &= ~TPDM_DSB_CR_TRIG_TYPE;
+	/* Set the enable bit of DSB control register to 1 */
 	val |= TPDM_DSB_CR_ENA;
 	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
 }
 
-/* TPDM enable operations */
+/*
+ * TPDM enable operations
+ * The TPDM or Monitor serves as data collection component for various
+ * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
+ * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete Single
+ * Bit(DSB). This function will initialize the configuration according
+ * to the dataset type supported by the TPDM.
+ */
 static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	/* Check if DSB datasets is present for TPDM. */
-	if (drvdata->datasets & TPDM_PIDR0_DS_DSB)
+	if (tpdm_has_dsb_dataset(drvdata))
 		tpdm_enable_dsb(drvdata);
 
 	CS_LOCK(drvdata->base);
@@ -76,8 +110,7 @@ static void __tpdm_disable(struct tpdm_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	/* Check if DSB datasets is present for TPDM. */
-	if (drvdata->datasets & TPDM_PIDR0_DS_DSB)
+	if (tpdm_has_dsb_dataset(drvdata))
 		tpdm_disable_dsb(drvdata);
 
 	CS_LOCK(drvdata->base);
@@ -110,13 +143,23 @@ static const struct coresight_ops tpdm_cs_ops = {
 	.source_ops	= &tpdm_source_ops,
 };
 
-static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
+static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
 {
 	u32 pidr;
 
 	/*  Get the datasets present on the TPDM. */
 	pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
 	drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
+
+	if (tpdm_has_dsb_dataset(drvdata) && (!drvdata->dsb)) {
+		drvdata->dsb = devm_kzalloc(drvdata->dev,
+						sizeof(*drvdata->dsb), GFP_KERNEL);
+		if (!drvdata->dsb)
+			return -ENOMEM;
+	}
+	tpdm_reset_datasets(drvdata);
+
+	return 0;
 }
 
 /*
@@ -179,6 +222,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct coresight_platform_data *pdata;
 	struct tpdm_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
+	int ret;
 
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
@@ -198,6 +242,10 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 
 	drvdata->base = base;
 
+	ret = tpdm_datasets_setup(drvdata);
+	if (ret)
+		return ret;
+
 	/* Set up coresight component description */
 	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
 	if (!desc.name)
@@ -214,7 +262,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(drvdata->csdev);
 
 	spin_lock_init(&drvdata->spinlock);
-	tpdm_init_default_data(drvdata);
+
 	/* Decrease pm refcount when probe is done.*/
 	pm_runtime_put(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 5438540..f59e751 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -11,8 +11,14 @@
 
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
+#define TPDM_DSB_TIER		(0x784)
+
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
+/* Enable bit for DSB subunit trigger type */
+#define TPDM_DSB_CR_TRIG_TYPE		BIT(12)
+/* Enable bit for DSB subunit trigger timestamp */
+#define TPDM_DSB_TIER_XTRIG_TSENAB		BIT(1)
 
 /* TPDM integration test registers */
 #define TPDM_ITATBCNTRL		(0xEF0)
@@ -41,6 +47,16 @@
 #define TPDM_PIDR0_DS_DSB	BIT(1)
 
 /**
+ * struct dsb_dataset - specifics associated to dsb dataset
+ * @trig_ts:          Enable/Disable trigger timestamp.
+ * @trig_type:        Enable/Disable trigger type.
+ */
+struct dsb_dataset {
+	bool			trig_ts;
+	bool			trig_type;
+};
+
+/**
  * struct tpdm_drvdata - specifics associated to an TPDM component
  * @base:       memory mapped base address for this component.
  * @dev:        The device entity associated to this component.
@@ -48,6 +64,7 @@
  * @spinlock:   lock for the drvdata value.
  * @enable:     enable status of the component.
  * @datasets:   The datasets types present of the TPDM.
+ * @dsb         Specifics associated to TPDM DSB.
  */
 
 struct tpdm_drvdata {
@@ -57,6 +74,7 @@ struct tpdm_drvdata {
 	spinlock_t		spinlock;
 	bool			enable;
 	unsigned long		datasets;
+	struct dsb_dataset	*dsb;
 };
 
 #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
-- 
2.7.4

