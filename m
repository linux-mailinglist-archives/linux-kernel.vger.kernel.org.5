Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E797A1E59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjIOMQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjIOMQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:16:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBA72D62;
        Fri, 15 Sep 2023 05:16:02 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FAwQoG020152;
        Fri, 15 Sep 2023 12:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=z7EdD7gnN29RfjnjGry9rnKgrLgOu5D5ie3Dn+GEn3s=;
 b=N8jwnP6CYz78lPCbI8RPELo4XIrshCTB+Hl2b8QB6k3mDrz6pMTQqVAc0XFTSr6drqZR
 w4n1bzZlhbzfyJ++RN4nk21nC0wzngJbpAM4HBlI7WUw8M7YjZu/6nsVYLY1nGEcxNFn
 y2SOnIK3gTWRJtx8NpzvRJxr/J6vMbvz3KbVwuIVs1r3vkTIyqV93Jl4mKPtH3ZxS/qc
 K1wMSpDntTBy7LMabBgOxN03ZzaPQb0YfR0s1vQ0gyY/NYXIvN0RHbcPQF7kFq7H7VtS
 KLfXcm6xV5LWBMDuthBI5XbXZDhr7PhnzJwonAyhVjy5EL7ruwdrlr5E54iE32m6qP7m nQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g07111u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 12:15:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FCFpZI010358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 12:15:51 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 05:15:46 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH V2 3/4] thermal/drivers/tsens: Add support for IPQ5018 tsens
Date:   Fri, 15 Sep 2023 17:45:03 +0530
Message-ID: <20230915121504.806672-4-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915121504.806672-1-quic_srichara@quicinc.com>
References: <20230915121504.806672-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z7-F87IANLbT9oA9AICOUmPotA8PnUMO
X-Proofpoint-ORIG-GUID: z7-F87IANLbT9oA9AICOUmPotA8PnUMO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_08,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 has tsens IP V1.0, 4 sensors and 1 interrupt.
The soc does not have a RPM, hence tsens has to be reset and
enabled in the driver init. Adding the driver support for same.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v2] Used tsens_calibrate_common instead of legacy
      and addressed comments from Dmitry.

 drivers/thermal/qcom/tsens-v1.c | 58 +++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 ++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index dc1c4ae2d8b0..ed5c017905ab 100644
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
@@ -150,6 +162,39 @@ static int __init init_8956(struct tsens_priv *priv) {
 	return init_common(priv);
 }
 
+static int init_ipq5018(struct tsens_priv *priv)
+{
+	int ret;
+	u32 mask;
+
+	init_common(priv);
+	if (!priv->tm_map)
+		return -ENODEV;
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
@@ -187,3 +232,16 @@ struct tsens_plat_data data_8976 = {
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

