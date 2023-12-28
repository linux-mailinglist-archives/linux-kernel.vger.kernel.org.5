Return-Path: <linux-kernel+bounces-12535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871A81F656
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBF31C217BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2592363D2;
	Thu, 28 Dec 2023 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eENMT9lE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD363B6;
	Thu, 28 Dec 2023 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BS9XYdX005402;
	Thu, 28 Dec 2023 09:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=3V3kSOA
	OwccGH7vwGx91DHobrSy3nxlzWo29d0Rsq1w=; b=eENMT9lET+jKLILcfCbrDZu
	KjAQHhKWuy+KTuGsDuIcUScMPfv6DE4vtabpGEJtF7qCgWsh6RJLRy/snkBhOHYY
	ANgYwTHOrabuV+LEcsqG/mPPzROLrZmXjLwso0V9iED7+FdbqfIQ+Kk1q5IT3k5U
	iErHUtT7MpSVZqVTfQQDTBKLEfBBHQONtQtiDdsvuowQ/3LkM36hnHi4S9wiRX0R
	vJfKfM2/TTQKxoFE1tGqEJ6n7anr2JNMhacsREh3CtZ+H/z5dd9L2nklLNf/BtB3
	iiE8peHWTAkB0fSZcpu7ya/QXfVEB5803Fl+hN6uVOFhVnDzPystF4As9QvPVQg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v8hbgaa5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Dec 2023 09:33:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BS9XX1Z007595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Dec 2023 09:33:33 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Dec 2023 01:33:33 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Leo Yan
	<leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Mao Jinlong <quic_jinlmao@quicinc.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>
Subject: [PATCH] coresight: Add coresight name support
Date: Thu, 28 Dec 2023 01:33:19 -0800
Message-ID: <20231228093321.5522-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1vrc7teFwwSHAcIFVZv_acjCvHve53-h
X-Proofpoint-GUID: 1vrc7teFwwSHAcIFVZv_acjCvHve53-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312280076

Add coresight name support for custom names which will be
easy to identify the device by the name.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../hwtracing/coresight/coresight-cti-core.c  | 20 ++++++++------
 drivers/hwtracing/coresight/coresight-dummy.c | 10 ++++---
 .../hwtracing/coresight/coresight-platform.c  | 27 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 10 ++++---
 include/linux/coresight.h                     |  1 +
 5 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index 3999d0a2cb60..60a1e76064a9 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -902,14 +902,18 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
 	/* default to powered - could change on PM notifications */
 	drvdata->config.hw_powered = true;
 
-	/* set up device name - will depend if cpu bound or otherwise */
-	if (drvdata->ctidev.cpu >= 0)
-		cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
-					       drvdata->ctidev.cpu);
-	else
-		cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);
-	if (!cti_desc.name)
-		return -ENOMEM;
+	cti_desc.name = coresight_get_device_name(dev);
+	if (!cti_desc.name) {
+		/* set up device name - will depend if cpu bound or otherwise */
+		if (drvdata->ctidev.cpu >= 0)
+			cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
+						       drvdata->ctidev.cpu);
+		else {
+			cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);
+			if (!cti_desc.name)
+				return -ENOMEM;
+		}
+	}
 
 	/* setup CPU power management handling for CPU bound CTI devices. */
 	ret = cti_pm_setup(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
index e4deafae7bc2..b19cd400df79 100644
--- a/drivers/hwtracing/coresight/coresight-dummy.c
+++ b/drivers/hwtracing/coresight/coresight-dummy.c
@@ -76,10 +76,12 @@ static int dummy_probe(struct platform_device *pdev)
 	struct coresight_desc desc = { 0 };
 
 	if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
-
-		desc.name = coresight_alloc_device_name(&source_devs, dev);
-		if (!desc.name)
-			return -ENOMEM;
+		desc.name = coresight_get_device_name(dev);
+		if (!desc.name) {
+			desc.name = coresight_alloc_device_name(&source_devs, dev);
+			if (!desc.name)
+				return -ENOMEM;
+		}
 
 		desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 		desc.subtype.source_subtype =
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 9d550f5697fa..284aa22a06b7 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -183,6 +183,18 @@ static int of_coresight_get_cpu(struct device *dev)
 	return cpu;
 }
 
+static const char *of_coresight_get_device_name(struct device *dev)
+{
+	const char *name = NULL;
+
+	if (!dev->of_node)
+		return NULL;
+
+	of_property_read_string(dev->of_node, "coresight-name", &name);
+
+	return name;
+}
+
 /*
  * of_coresight_parse_endpoint : Parse the given output endpoint @ep
  * and fill the connection information in @pdata->out_conns
@@ -315,6 +327,12 @@ static inline int of_coresight_get_cpu(struct device *dev)
 {
 	return -ENODEV;
 }
+
+static inline const char *of_coresight_get_device_name(struct device *dev)
+{
+	return NULL;
+}
+
 #endif
 
 #ifdef CONFIG_ACPI
@@ -794,6 +812,15 @@ int coresight_get_cpu(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(coresight_get_cpu);
 
+const char *coresight_get_device_name(struct device *dev)
+{
+	if (is_of_node(dev->fwnode))
+		return of_coresight_get_device_name(dev);
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(coresight_get_device_name);
+
 struct coresight_platform_data *
 coresight_get_platform_data(struct device *dev)
 {
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index f4854af0431e..7735ff18c48e 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -201,9 +201,13 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->base = base;
 
 	/* Set up coresight component description */
-	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
-	if (!desc.name)
-		return -ENOMEM;
+	desc.name = coresight_get_device_name(dev);
+	if (!desc.name) {
+		desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
+		if (!desc.name)
+			return -ENOMEM;
+	}
+
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
 	desc.ops = &tpdm_cs_ops;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a269fffaf991..caa17c8af865 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -675,6 +675,7 @@ static inline void coresight_write64(struct coresight_device *csdev, u64 val, u3
 #endif		/* IS_ENABLED(CONFIG_CORESIGHT) */
 
 extern int coresight_get_cpu(struct device *dev);
+extern const char *coresight_get_device_name(struct device *dev);
 
 struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
 struct coresight_connection *
-- 
2.41.0


