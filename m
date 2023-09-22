Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FFD7AB155
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjIVLvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjIVLvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:51:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFDB139;
        Fri, 22 Sep 2023 04:51:31 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M7oXP9023916;
        Fri, 22 Sep 2023 11:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=0v4XD9bwoxz/L+l6yVODIdLZIbBqhrKVg63Bxb3XVB8=;
 b=krjwr21GeDNYm8xJpPp6NHEoYo5m8tx7+QDF0pipRo7+fi823scZjlMIULz6RGwNmYfk
 PwooFgWc+eCnVL24NJ43k9Qd9+R/uBSPOCAlV+ifKPd9g9zemv/yjOwDapBN7sHVUmCf
 k19TVCUQOGSMxI4aEIki1twEG9du+BxUepOWl3mjOxxNOO3wb/XXLLY4cfdsm033me7i
 ubJGjV6/oJlTLYupfRdxr3dvManvfsIF6X42i7v5KYTFuHmWGZUfeR5oh9JD84X4olAP
 ezvIkReWZuIY01YgEvCcf58nZrxc/KHNhFykf2uScxJ88YAENuLSxgj2fUob/LHL83II 6g== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u0s1tan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:51:21 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38MBpIl6027887;
        Fri, 22 Sep 2023 11:51:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3t55emanc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:51:18 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MBntHo026858;
        Fri, 22 Sep 2023 11:51:17 GMT
Received: from win-platform-upstream01.qualcomm.com (win-platform-upstream01.qualcomm.com [10.242.182.84])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 38MBpHJd027856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:51:17 +0000
Received: by win-platform-upstream01.qualcomm.com (Postfix, from userid 330701)
        id 8FC1199B; Fri, 22 Sep 2023 17:21:16 +0530 (IST)
From:   Sricharan R <srichara@win-platform-upstream01.qualcomm.com>
To:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        quic_srichara@quicinc.com
Subject: [PATCH V3 3/4] thermal/drivers/tsens: Add support for IPQ5018 tsens
Date:   Fri, 22 Sep 2023 17:21:15 +0530
Message-Id: <20230922115116.2748804-4-srichara@win-platform-upstream01.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QNHmlromq1ES1PshjRmX8UUtgPImrveq
X-Proofpoint-ORIG-GUID: QNHmlromq1ES1PshjRmX8UUtgPImrveq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_10,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 clxscore=1034
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220100
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens IP V1.0, 4 sensors and 1 interrupt.
The soc does not have a RPM, hence tsens has to be reset and
enabled in the driver init. Adding the driver support for same.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v3] Fixed Dmitry's comments for error checks in init_ipq5018

 drivers/thermal/qcom/tsens-v1.c | 60 +++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 ++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index dc1c4ae2d8b0..acee2064f83e 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -79,6 +79,18 @@ static struct tsens_features tsens_v1_feat = {
 	.trip_max_temp	= 120000,
 };
 
+static struct tsens_features tsens_v1_ipq5018_feat = {
+	.ver_major	= VER_1_X,
+	.crit_int	= 0,
+	.combo_int	= 0,
+	.adc		= 1,
+	.srot_split	= 1,
+	.max_sensors	= 11,
+	.trip_min_temp	= -40000,
+	.trip_max_temp	= 120000,
+	.ignore_enable	= 1,
+};
+
 static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* VERSION */
@@ -150,6 +162,41 @@ static int __init init_8956(struct tsens_priv *priv) {
 	return init_common(priv);
 }
 
+static int init_ipq5018(struct tsens_priv *priv)
+{
+	int ret;
+	u32 mask;
+
+	ret = init_common(priv);
+	if (ret < 0) {
+		dev_err(priv->dev, "Init common failed %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 1);
+	if (ret) {
+		dev_err(priv->dev, "Reset failed\n");
+		return ret;
+	}
+
+	mask = GENMASK(priv->num_sensors, 0);
+	ret = regmap_field_update_bits(priv->rf[SENSOR_EN], mask, mask);
+	if (ret) {
+		dev_err(priv->dev, "Sensor Enable failed\n");
+		return ret;
+	}
+
+	ret = regmap_field_write(priv->rf[TSENS_EN], 1);
+	if (ret) {
+		dev_err(priv->dev, "Enable failed\n");
+		return ret;
+	}
+
+	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 0);
+
+	return ret;
+}
+
 static const struct tsens_ops ops_generic_v1 = {
 	.init		= init_common,
 	.calibrate	= calibrate_v1,
@@ -187,3 +234,16 @@ struct tsens_plat_data data_8976 = {
 	.feat		= &tsens_v1_feat,
 	.fields		= tsens_v1_regfields,
 };
+
+const struct tsens_ops ops_ipq5018 = {
+	.init		= init_ipq5018,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_tsens_valid,
+};
+
+struct tsens_plat_data data_ipq5018 = {
+	.num_sensors	= 5,
+	.ops		= &ops_ipq5018,
+	.feat		= &tsens_v1_ipq5018_feat,
+	.fields		= tsens_v1_regfields,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 0a43ccf02ec4..c792b9dc6676 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1101,6 +1101,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq5018-tsens",
+		.data = &data_ipq5018,
+	}, {
 		.compatible = "qcom,ipq8064-tsens",
 		.data = &data_8960,
 	}, {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index e254cd2df904..b6594b546d11 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -645,7 +645,7 @@ extern struct tsens_plat_data data_8960;
 extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
-extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
+extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956, data_ipq5018;
 
 /* TSENS v2 targets */
 extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
-- 
2.34.1

