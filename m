Return-Path: <linux-kernel+bounces-107933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4488803BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DEB61F22B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268E33B1AC;
	Tue, 19 Mar 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KCaZkzX0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1739FCE;
	Tue, 19 Mar 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870034; cv=none; b=kl36FIjIvHuPOXTv99oDJf38YZYjeEQUnyEyMpCeDv5+TSizYt6iLsfE3nSkItGaMXeJU+SbJye+aCvo2dO2NR8RAssX/kQPxxjFh/8Caa0dyMX8+lZujLHg1/VZentVO7QZIMoMrQxVi6BR36ZFSYuQy96e5mpR3bGL0Aa67OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870034; c=relaxed/simple;
	bh=JpoUtWpTmCwC3J5QP1df3LEOnYqrNcxZXF7Avd7cXtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozsxkR8viBrwFX/6mbSuQ4Wo/+n3sG47Jbncug5Rj842XaxmsR3FRiJPlozHEwlsONFGGD4JA2zamczb+HyTIGBk6oyx8pPfSY/oGWsSU9pOZiVIOsbjQwtpyEl6aeZslP3iOy8ZqMAyX5pnTMsnlGNyZHTAsdL+ufmoC+FfrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KCaZkzX0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JHGkQC030239;
	Tue, 19 Mar 2024 17:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=SJKmt5/kmTOQewCd8C45LJ8eD6XnIL/WY3b0sYExaM4=; b=KC
	aZkzX0QIzUNyNXjnig1W7CvxAo0sTy0pjyRxLB/FoUM1lmq7aQ/sKWyEqqQjDUoD
	DTq3sNXHUS2a3Hf2+piOASaeuT2JagdD9PCZs4wuKnFkurZPhepxNrUpcbQ83Doa
	wUH6Uz6MhuxPGFaZTmolOaV5ugF4cu6ikNfM6NHOZlNy+KYpylSbMf/MxMFG86qy
	Vb2447Y675gL45h3Wk93BAJJs0YEPc9aVChTQbz11x1iBSda0vwwErzKMNv0tlzP
	7t376Y4Bn1dR7jbZcTCQZbWEAi79a8pupvlamDSWc/88BTpsFbnjccVc3iiDv7mR
	6INJeCG087w65T6kkseA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy94ts18j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 17:40:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JHeOCB001071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 17:40:24 GMT
Received: from grosikop.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 10:40:21 -0700
From: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
Subject: [PATCH v2 7/8] media: qcom: camss: Decompose register and link operations
Date: Tue, 19 Mar 2024 19:39:34 +0200
Message-ID: <20240319173935.481-8-quic_grosikop@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319173935.481-1-quic_grosikop@quicinc.com>
References: <20240319173935.481-1-quic_grosikop@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aF3lT1R3ZFJhNtmMTu-PupYtGuJVcXbs
X-Proofpoint-ORIG-GUID: aF3lT1R3ZFJhNtmMTu-PupYtGuJVcXbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_07,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190131

From: Atanas Filipov <quic_afilipov@quicinc.com>

Split link and register operations.
Add dedicated link callback according to SoC identifier.

Signed-off-by: Atanas Filipov <quic_afilipov@quicinc.com>
Signed-off-by: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
---
 drivers/media/platform/qcom/camss/camss.c | 141 ++++++++++++----------
 drivers/media/platform/qcom/camss/camss.h |   1 +
 2 files changed, 81 insertions(+), 61 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index c2d21bfc52f5..fd5a42355d80 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1795,72 +1795,30 @@ static int camss_init_subdevices(struct camss *camss)
 }
 
 /*
- * camss_register_entities - Register subdev nodes and create links
+ * camss_link_entities - Register subdev nodes and create links
  * @camss: CAMSS device
  *
  * Return 0 on success or a negative error code on failure
  */
-static int camss_register_entities(struct camss *camss)
+static int camss_link_entities(struct camss *camss)
 {
 	int i, j, k;
 	int ret;
 
-	for (i = 0; i < camss->res->csiphy_num; i++) {
-		ret = msm_csiphy_register_entity(&camss->csiphy[i],
-						 &camss->v4l2_dev);
-		if (ret < 0) {
-			dev_err(camss->dev,
-				"Failed to register csiphy%d entity: %d\n",
-				i, ret);
-			goto err_reg_csiphy;
-		}
-	}
-
-	for (i = 0; i < camss->res->csid_num; i++) {
-		ret = msm_csid_register_entity(&camss->csid[i],
-					       &camss->v4l2_dev);
-		if (ret < 0) {
-			dev_err(camss->dev,
-				"Failed to register csid%d entity: %d\n",
-				i, ret);
-			goto err_reg_csid;
-		}
-	}
-
-	ret = msm_ispif_register_entities(camss->ispif,
-					  &camss->v4l2_dev);
-	if (ret < 0) {
-		dev_err(camss->dev, "Failed to register ispif entities: %d\n",
-		ret);
-		goto err_reg_ispif;
-	}
-
-	for (i = 0; i < camss->res->vfe_num; i++) {
-		ret = msm_vfe_register_entities(&camss->vfe[i],
-						&camss->v4l2_dev);
-		if (ret < 0) {
-			dev_err(camss->dev,
-				"Failed to register vfe%d entities: %d\n",
-				i, ret);
-			goto err_reg_vfe;
-		}
-	}
-
 	for (i = 0; i < camss->res->csiphy_num; i++) {
 		for (j = 0; j < camss->res->csid_num; j++) {
-			ret = media_create_pad_link(
-				&camss->csiphy[i].subdev.entity,
-				MSM_CSIPHY_PAD_SRC,
-				&camss->csid[j].subdev.entity,
-				MSM_CSID_PAD_SINK,
-				0);
+			ret = media_create_pad_link(&camss->csiphy[i].subdev.entity,
+						    MSM_CSIPHY_PAD_SRC,
+						    &camss->csid[j].subdev.entity,
+						    MSM_CSID_PAD_SINK,
+						    0);
 			if (ret < 0) {
 				dev_err(camss->dev,
 					"Failed to link %s->%s entities: %d\n",
 					camss->csiphy[i].subdev.entity.name,
 					camss->csid[j].subdev.entity.name,
 					ret);
-				goto err_link;
+				return ret;
 			}
 		}
 	}
@@ -1868,19 +1826,18 @@ static int camss_register_entities(struct camss *camss)
 	if (camss->ispif) {
 		for (i = 0; i < camss->res->csid_num; i++) {
 			for (j = 0; j < camss->ispif->line_num; j++) {
-				ret = media_create_pad_link(
-					&camss->csid[i].subdev.entity,
-					MSM_CSID_PAD_SRC,
-					&camss->ispif->line[j].subdev.entity,
-					MSM_ISPIF_PAD_SINK,
-					0);
+				ret = media_create_pad_link(&camss->csid[i].subdev.entity,
+							    MSM_CSID_PAD_SRC,
+							    &camss->ispif->line[j].subdev.entity,
+							    MSM_ISPIF_PAD_SINK,
+							    0);
 				if (ret < 0) {
 					dev_err(camss->dev,
 						"Failed to link %s->%s entities: %d\n",
 						camss->csid[i].subdev.entity.name,
 						camss->ispif->line[j].subdev.entity.name,
 						ret);
-					goto err_link;
+					return ret;
 				}
 			}
 		}
@@ -1902,7 +1859,7 @@ static int camss_register_entities(struct camss *camss)
 							ispif->entity.name,
 							vfe->entity.name,
 							ret);
-						goto err_link;
+						return ret;
 					}
 				}
 	} else {
@@ -1923,15 +1880,67 @@ static int camss_register_entities(struct camss *camss)
 							csid->entity.name,
 							vfe->entity.name,
 							ret);
-						goto err_link;
+						return ret;
 					}
 				}
 	}
 
+	return 0;
+}
+
+/*
+ * camss_register_entities - Register subdev nodes and create links
+ * @camss: CAMSS device
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static int camss_register_entities(struct camss *camss)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < camss->res->csiphy_num; i++) {
+		ret = msm_csiphy_register_entity(&camss->csiphy[i],
+						 &camss->v4l2_dev);
+		if (ret < 0) {
+			dev_err(camss->dev,
+				"Failed to register csiphy%d entity: %d\n",
+				i, ret);
+			goto err_reg_csiphy;
+		}
+	}
+
+	for (i = 0; i < camss->res->csid_num; i++) {
+		ret = msm_csid_register_entity(&camss->csid[i],
+					       &camss->v4l2_dev);
+		if (ret < 0) {
+			dev_err(camss->dev,
+				"Failed to register csid%d entity: %d\n",
+				i, ret);
+			goto err_reg_csid;
+		}
+	}
+
+	ret = msm_ispif_register_entities(camss->ispif,
+					  &camss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(camss->dev, "Failed to register ispif entities: %d\n", ret);
+		goto err_reg_ispif;
+	}
+
+	for (i = 0; i < camss->res->vfe_num; i++) {
+		ret = msm_vfe_register_entities(&camss->vfe[i],
+						&camss->v4l2_dev);
+		if (ret < 0) {
+			dev_err(camss->dev,
+				"Failed to register vfe%d entities: %d\n",
+				i, ret);
+			goto err_reg_vfe;
+		}
+	}
+
 	return 0;
 
-err_link:
-	i = camss->res->vfe_num;
 err_reg_vfe:
 	for (i--; i >= 0; i--)
 		msm_vfe_unregister_entities(&camss->vfe[i]);
@@ -2251,6 +2260,10 @@ static int camss_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_v4l2_device_unregister;
 
+	ret = camss->res->link_entities(camss);
+	if (ret < 0)
+		goto err_register_subdevs;
+
 	if (num_subdevs) {
 		camss->notifier.ops = &camss_subdev_notifier_ops;
 
@@ -2330,6 +2343,7 @@ static const struct camss_resources msm8916_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_8x16),
 	.csid_num = ARRAY_SIZE(csid_res_8x16),
 	.vfe_num = ARRAY_SIZE(vfe_res_8x16),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources msm8996_resources = {
@@ -2341,6 +2355,7 @@ static const struct camss_resources msm8996_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_8x96),
 	.csid_num = ARRAY_SIZE(csid_res_8x96),
 	.vfe_num = ARRAY_SIZE(vfe_res_8x96),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources sdm660_resources = {
@@ -2352,6 +2367,7 @@ static const struct camss_resources sdm660_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_660),
 	.csid_num = ARRAY_SIZE(csid_res_660),
 	.vfe_num = ARRAY_SIZE(vfe_res_660),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources sdm845_resources = {
@@ -2362,6 +2378,7 @@ static const struct camss_resources sdm845_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_845),
 	.csid_num = ARRAY_SIZE(csid_res_845),
 	.vfe_num = ARRAY_SIZE(vfe_res_845),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources sm8250_resources = {
@@ -2375,6 +2392,7 @@ static const struct camss_resources sm8250_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_8250),
 	.csid_num = ARRAY_SIZE(csid_res_8250),
 	.vfe_num = ARRAY_SIZE(vfe_res_8250),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources sc8280xp_resources = {
@@ -2389,6 +2407,7 @@ static const struct camss_resources sc8280xp_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_sc8280xp),
 	.csid_num = ARRAY_SIZE(csid_res_sc8280xp),
 	.vfe_num = ARRAY_SIZE(vfe_res_sc8280xp),
+	.link_entities = camss_link_entities
 };
 
 static const struct of_device_id camss_dt_match[] = {
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 4b13012940bf..a5be9e872992 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -106,6 +106,7 @@ struct camss_resources {
 	const unsigned int csiphy_num;
 	const unsigned int csid_num;
 	const unsigned int vfe_num;
+	int (*link_entities)(struct camss *camss);
 };
 
 struct camss {
-- 
2.17.1


