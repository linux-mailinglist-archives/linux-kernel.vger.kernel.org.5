Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1E378534E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjHWI6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjHWIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:53:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13531BF7;
        Wed, 23 Aug 2023 01:51:18 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N7A4O6027369;
        Wed, 23 Aug 2023 08:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UWMjJfFb0MwxCtcQ+6jje7+746jxi/1Ab6noIzkVK/M=;
 b=lgLCAb/qU2YZxt/hYp5qJ3A9ZGqhzGTytfo6Lnfpeb6Z2McmMfqPr8RagZTwKkhv2eai
 EeaDsRZpuIfi3tm7F/oIUrX3mM6Q28ezTQlz7OVyxDmGoV6MF+Rur2MoI8SK+B9pG1x3
 FWx7csJHXn44PUvuaK4R3EpigInrQl0yQGhpOfQwDXaPm0qluy7Rwb+CesaZlCH7z7D2
 KgZrnzEjNjWN47irM3Z/1oyMZeBNtGcQHlzhT7bOT1QxNe2Pws0RUpuaB/oukktCMICH
 +T22fstNZRpe/F26c8ZV6TNjdOpZu+NWj0a6ipMFaXKOaaEIS0BTDYvvjKFQjqiOQIC8 pw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn3tqh8e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 08:51:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37N8p4M7013866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 08:51:04 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 23 Aug 2023 01:51:00 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH v5 3/4] clk: qcom: common: commonize qcom_cc_really_probe
Date:   Wed, 23 Aug 2023 16:50:30 +0800
Message-ID: <20230823085031.27252-4-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823085031.27252-1-quic_luoj@quicinc.com>
References: <20230823085031.27252-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mQzImlm8rhJnHz236bjUj3ySh86-LGjG
X-Proofpoint-ORIG-GUID: mQzImlm8rhJnHz236bjUj3ySh86-LGjG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous wrapper qcom_cc_really_probe takes the platform
device as parameter, which is limited to platform driver.

As for qca8k clock controller driver, which is registered as
the MDIO device, which also follows the qcom clock framework.

To commonize qcom_cc_really_probe, updating it to take the
struct device as parameter, so that the qcom_cc_really_probe
can be utilized by the previous platform device and the new
added MDIO device.

Also update the current clock controller drivers to take
&pdev->dev as parameter when calling qcom_cc_really_probe.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/clk/qcom/apss-ipq6018.c        | 2 +-
 drivers/clk/qcom/camcc-sc7180.c        | 2 +-
 drivers/clk/qcom/camcc-sc7280.c        | 2 +-
 drivers/clk/qcom/camcc-sdm845.c        | 2 +-
 drivers/clk/qcom/camcc-sm6350.c        | 2 +-
 drivers/clk/qcom/camcc-sm8250.c        | 2 +-
 drivers/clk/qcom/camcc-sm8450.c        | 2 +-
 drivers/clk/qcom/common.c              | 7 +++----
 drivers/clk/qcom/common.h              | 2 +-
 drivers/clk/qcom/dispcc-qcm2290.c      | 2 +-
 drivers/clk/qcom/dispcc-sc7180.c       | 2 +-
 drivers/clk/qcom/dispcc-sc7280.c       | 2 +-
 drivers/clk/qcom/dispcc-sc8280xp.c     | 2 +-
 drivers/clk/qcom/dispcc-sdm845.c       | 2 +-
 drivers/clk/qcom/dispcc-sm6115.c       | 2 +-
 drivers/clk/qcom/dispcc-sm6125.c       | 2 +-
 drivers/clk/qcom/dispcc-sm6350.c       | 2 +-
 drivers/clk/qcom/dispcc-sm6375.c       | 2 +-
 drivers/clk/qcom/dispcc-sm8250.c       | 2 +-
 drivers/clk/qcom/dispcc-sm8450.c       | 2 +-
 drivers/clk/qcom/dispcc-sm8550.c       | 2 +-
 drivers/clk/qcom/gcc-ipq6018.c         | 2 +-
 drivers/clk/qcom/gcc-ipq8074.c         | 2 +-
 drivers/clk/qcom/gcc-mdm9607.c         | 2 +-
 drivers/clk/qcom/gcc-mdm9615.c         | 2 +-
 drivers/clk/qcom/gcc-msm8917.c         | 2 +-
 drivers/clk/qcom/gcc-msm8939.c         | 2 +-
 drivers/clk/qcom/gcc-msm8953.c         | 2 +-
 drivers/clk/qcom/gcc-msm8976.c         | 2 +-
 drivers/clk/qcom/gcc-msm8996.c         | 2 +-
 drivers/clk/qcom/gcc-msm8998.c         | 2 +-
 drivers/clk/qcom/gcc-qcm2290.c         | 2 +-
 drivers/clk/qcom/gcc-qcs404.c          | 2 +-
 drivers/clk/qcom/gcc-qdu1000.c         | 2 +-
 drivers/clk/qcom/gcc-sa8775p.c         | 2 +-
 drivers/clk/qcom/gcc-sc7180.c          | 2 +-
 drivers/clk/qcom/gcc-sc7280.c          | 2 +-
 drivers/clk/qcom/gcc-sc8180x.c         | 2 +-
 drivers/clk/qcom/gcc-sc8280xp.c        | 2 +-
 drivers/clk/qcom/gcc-sdm660.c          | 2 +-
 drivers/clk/qcom/gcc-sdm845.c          | 2 +-
 drivers/clk/qcom/gcc-sdx55.c           | 2 +-
 drivers/clk/qcom/gcc-sdx65.c           | 2 +-
 drivers/clk/qcom/gcc-sdx75.c           | 2 +-
 drivers/clk/qcom/gcc-sm6115.c          | 2 +-
 drivers/clk/qcom/gcc-sm6125.c          | 2 +-
 drivers/clk/qcom/gcc-sm6350.c          | 2 +-
 drivers/clk/qcom/gcc-sm6375.c          | 2 +-
 drivers/clk/qcom/gcc-sm7150.c          | 2 +-
 drivers/clk/qcom/gcc-sm8150.c          | 2 +-
 drivers/clk/qcom/gcc-sm8250.c          | 2 +-
 drivers/clk/qcom/gcc-sm8350.c          | 2 +-
 drivers/clk/qcom/gcc-sm8450.c          | 2 +-
 drivers/clk/qcom/gcc-sm8550.c          | 2 +-
 drivers/clk/qcom/gpucc-msm8998.c       | 2 +-
 drivers/clk/qcom/gpucc-sa8775p.c       | 2 +-
 drivers/clk/qcom/gpucc-sc7180.c        | 2 +-
 drivers/clk/qcom/gpucc-sc7280.c        | 2 +-
 drivers/clk/qcom/gpucc-sc8280xp.c      | 2 +-
 drivers/clk/qcom/gpucc-sdm660.c        | 2 +-
 drivers/clk/qcom/gpucc-sdm845.c        | 2 +-
 drivers/clk/qcom/gpucc-sm6115.c        | 2 +-
 drivers/clk/qcom/gpucc-sm6125.c        | 2 +-
 drivers/clk/qcom/gpucc-sm6350.c        | 2 +-
 drivers/clk/qcom/gpucc-sm6375.c        | 2 +-
 drivers/clk/qcom/gpucc-sm8150.c        | 2 +-
 drivers/clk/qcom/gpucc-sm8250.c        | 2 +-
 drivers/clk/qcom/gpucc-sm8350.c        | 2 +-
 drivers/clk/qcom/gpucc-sm8450.c        | 2 +-
 drivers/clk/qcom/gpucc-sm8550.c        | 2 +-
 drivers/clk/qcom/lcc-ipq806x.c         | 2 +-
 drivers/clk/qcom/lcc-mdm9615.c         | 2 +-
 drivers/clk/qcom/lcc-msm8960.c         | 2 +-
 drivers/clk/qcom/lpassaudiocc-sc7280.c | 4 ++--
 drivers/clk/qcom/lpasscorecc-sc7180.c  | 2 +-
 drivers/clk/qcom/lpasscorecc-sc7280.c  | 2 +-
 drivers/clk/qcom/mmcc-msm8960.c        | 2 +-
 drivers/clk/qcom/mmcc-msm8974.c        | 2 +-
 drivers/clk/qcom/mmcc-msm8994.c        | 2 +-
 drivers/clk/qcom/mmcc-msm8996.c        | 2 +-
 drivers/clk/qcom/mmcc-msm8998.c        | 2 +-
 drivers/clk/qcom/mmcc-sdm660.c         | 2 +-
 drivers/clk/qcom/tcsrcc-sm8550.c       | 2 +-
 drivers/clk/qcom/videocc-sc7180.c      | 2 +-
 drivers/clk/qcom/videocc-sc7280.c      | 2 +-
 drivers/clk/qcom/videocc-sdm845.c      | 2 +-
 drivers/clk/qcom/videocc-sm8150.c      | 2 +-
 drivers/clk/qcom/videocc-sm8250.c      | 2 +-
 drivers/clk/qcom/videocc-sm8350.c      | 2 +-
 drivers/clk/qcom/videocc-sm8450.c      | 2 +-
 drivers/clk/qcom/videocc-sm8550.c      | 2 +-
 91 files changed, 94 insertions(+), 95 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index f2f502e2d5a4..facb26d88322 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -89,7 +89,7 @@ static int apss_ipq6018_probe(struct platform_device *pdev)
 	if (!regmap)
 		return -ENODEV;
 
-	return qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &apss_ipq6018_desc, regmap);
 }
 
 static struct platform_driver apss_ipq6018_driver = {
diff --git a/drivers/clk/qcom/camcc-sc7180.c b/drivers/clk/qcom/camcc-sc7180.c
index 8a4ba7a19ed1..8e3634036369 100644
--- a/drivers/clk/qcom/camcc-sc7180.c
+++ b/drivers/clk/qcom/camcc-sc7180.c
@@ -1680,7 +1680,7 @@ static int cam_cc_sc7180_probe(struct platform_device *pdev)
 	clk_agera_pll_configure(&cam_cc_pll2, regmap, &cam_cc_pll2_config);
 	clk_fabia_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll3_config);
 
-	ret = qcom_cc_really_probe(pdev, &cam_cc_sc7180_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &cam_cc_sc7180_desc, regmap);
 	pm_runtime_put(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register CAM CC clocks\n");
diff --git a/drivers/clk/qcom/camcc-sc7280.c b/drivers/clk/qcom/camcc-sc7280.c
index 4396fddba7a6..7641c3b7751e 100644
--- a/drivers/clk/qcom/camcc-sc7280.c
+++ b/drivers/clk/qcom/camcc-sc7280.c
@@ -2457,7 +2457,7 @@ static int cam_cc_sc7280_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&cam_cc_pll5, regmap, &cam_cc_pll5_config);
 	clk_lucid_pll_configure(&cam_cc_pll6, regmap, &cam_cc_pll6_config);
 
-	return qcom_cc_really_probe(pdev, &cam_cc_sc7280_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &cam_cc_sc7280_desc, regmap);
 }
 
 static struct platform_driver cam_cc_sc7280_driver = {
diff --git a/drivers/clk/qcom/camcc-sdm845.c b/drivers/clk/qcom/camcc-sdm845.c
index 27d44188a7ab..8ba095587ce8 100644
--- a/drivers/clk/qcom/camcc-sdm845.c
+++ b/drivers/clk/qcom/camcc-sdm845.c
@@ -1735,7 +1735,7 @@ static int cam_cc_sdm845_probe(struct platform_device *pdev)
 	cam_cc_pll_config.l = 0x14;
 	clk_fabia_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll_config);
 
-	return qcom_cc_really_probe(pdev, &cam_cc_sdm845_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &cam_cc_sdm845_desc, regmap);
 }
 
 static struct platform_driver cam_cc_sdm845_driver = {
diff --git a/drivers/clk/qcom/camcc-sm6350.c b/drivers/clk/qcom/camcc-sm6350.c
index acba9f99d960..d52073a6e204 100644
--- a/drivers/clk/qcom/camcc-sm6350.c
+++ b/drivers/clk/qcom/camcc-sm6350.c
@@ -1879,7 +1879,7 @@ static int camcc_sm6350_probe(struct platform_device *pdev)
 	clk_agera_pll_configure(&camcc_pll2, regmap, &camcc_pll2_config);
 	clk_fabia_pll_configure(&camcc_pll3, regmap, &camcc_pll3_config);
 
-	return qcom_cc_really_probe(pdev, &camcc_sm6350_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &camcc_sm6350_desc, regmap);
 }
 
 static struct platform_driver camcc_sm6350_driver = {
diff --git a/drivers/clk/qcom/camcc-sm8250.c b/drivers/clk/qcom/camcc-sm8250.c
index 9b32c56a5bc5..6ac85b96a1ea 100644
--- a/drivers/clk/qcom/camcc-sm8250.c
+++ b/drivers/clk/qcom/camcc-sm8250.c
@@ -2433,7 +2433,7 @@ static int cam_cc_sm8250_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll3_config);
 	clk_lucid_pll_configure(&cam_cc_pll4, regmap, &cam_cc_pll4_config);
 
-	return qcom_cc_really_probe(pdev, &cam_cc_sm8250_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &cam_cc_sm8250_desc, regmap);
 }
 
 static struct platform_driver cam_cc_sm8250_driver = {
diff --git a/drivers/clk/qcom/camcc-sm8450.c b/drivers/clk/qcom/camcc-sm8450.c
index 51338a2884d2..26b78eed15ef 100644
--- a/drivers/clk/qcom/camcc-sm8450.c
+++ b/drivers/clk/qcom/camcc-sm8450.c
@@ -2839,7 +2839,7 @@ static int cam_cc_sm8450_probe(struct platform_device *pdev)
 	clk_lucid_evo_pll_configure(&cam_cc_pll7, regmap, &cam_cc_pll7_config);
 	clk_lucid_evo_pll_configure(&cam_cc_pll8, regmap, &cam_cc_pll8_config);
 
-	return qcom_cc_really_probe(pdev, &cam_cc_sm8450_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &cam_cc_sm8450_desc, regmap);
 }
 
 static struct platform_driver cam_cc_sm8450_driver = {
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..e21fd7992237 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -234,11 +234,10 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
 	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
 }
 
-int qcom_cc_really_probe(struct platform_device *pdev,
+int qcom_cc_really_probe(struct device *dev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
 	int i, ret;
-	struct device *dev = &pdev->dev;
 	struct qcom_reset_controller *reset;
 	struct qcom_cc *cc;
 	struct gdsc_desc *scd;
@@ -315,7 +314,7 @@ int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return qcom_cc_really_probe(pdev, desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, desc, regmap);
 }
 EXPORT_SYMBOL_GPL(qcom_cc_probe);
 
@@ -333,7 +332,7 @@ int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return qcom_cc_really_probe(pdev, desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, desc, regmap);
 }
 EXPORT_SYMBOL_GPL(qcom_cc_probe_by_index);
 
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..e168a81a40e3 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -58,7 +58,7 @@ extern int qcom_cc_register_sleep_clk(struct device *dev);
 
 extern struct regmap *qcom_cc_map(struct platform_device *pdev,
 				  const struct qcom_cc_desc *desc);
-extern int qcom_cc_really_probe(struct platform_device *pdev,
+extern int qcom_cc_really_probe(struct device *dev,
 				const struct qcom_cc_desc *desc,
 				struct regmap *regmap);
 extern int qcom_cc_probe(struct platform_device *pdev,
diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
index 44dd5cfcc150..5d1903e83fcc 100644
--- a/drivers/clk/qcom/dispcc-qcm2290.c
+++ b/drivers/clk/qcom/dispcc-qcm2290.c
@@ -522,7 +522,7 @@ static int disp_cc_qcm2290_probe(struct platform_device *pdev)
 	/* Keep DISP_CC_XO_CLK always-ON */
 	regmap_update_bits(regmap, 0x604c, BIT(0), BIT(0));
 
-	ret = qcom_cc_really_probe(pdev, &disp_cc_qcm2290_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &disp_cc_qcm2290_desc, regmap);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register DISP CC clocks\n");
 		return ret;
diff --git a/drivers/clk/qcom/dispcc-sc7180.c b/drivers/clk/qcom/dispcc-sc7180.c
index 9536bfc72a43..644dd6241c9b 100644
--- a/drivers/clk/qcom/dispcc-sc7180.c
+++ b/drivers/clk/qcom/dispcc-sc7180.c
@@ -713,7 +713,7 @@ static int disp_cc_sc7180_probe(struct platform_device *pdev)
 
 	clk_fabia_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll_config);
 
-	return qcom_cc_really_probe(pdev, &disp_cc_sc7180_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &disp_cc_sc7180_desc, regmap);
 }
 
 static struct platform_driver disp_cc_sc7180_driver = {
diff --git a/drivers/clk/qcom/dispcc-sc7280.c b/drivers/clk/qcom/dispcc-sc7280.c
index ad596d567f6a..decb231cd135 100644
--- a/drivers/clk/qcom/dispcc-sc7280.c
+++ b/drivers/clk/qcom/dispcc-sc7280.c
@@ -884,7 +884,7 @@ static int disp_cc_sc7280_probe(struct platform_device *pdev)
 	 */
 	regmap_update_bits(regmap, 0x5008, BIT(0), BIT(0));
 
-	return qcom_cc_really_probe(pdev, &disp_cc_sc7280_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &disp_cc_sc7280_desc, regmap);
 }
 
 static struct platform_driver disp_cc_sc7280_driver = {
diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
index 167470beb369..afb3b7a0d679 100644
--- a/drivers/clk/qcom/dispcc-sc8280xp.c
+++ b/drivers/clk/qcom/dispcc-sc8280xp.c
@@ -3172,7 +3172,7 @@ static int disp_cc_sc8280xp_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(clkr_to_alpha_clk_pll(desc->clks[DISP_CC_PLL1]), regmap, &disp_cc_pll1_config);
 	clk_lucid_pll_configure(clkr_to_alpha_clk_pll(desc->clks[DISP_CC_PLL2]), regmap, &disp_cc_pll2_config);
 
-	ret = qcom_cc_really_probe(pdev, desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, desc, regmap);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register display clock controller\n");
 		goto out_pm_runtime_put;
diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 735adfefc379..633119a5c51d 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -861,7 +861,7 @@ static int disp_cc_sdm845_probe(struct platform_device *pdev)
 	/* Enable hardware clock gating for DSI and MDP clocks */
 	regmap_update_bits(regmap, 0x8000, 0x7f0, 0x7f0);
 
-	return qcom_cc_really_probe(pdev, &disp_cc_sdm845_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &disp_cc_sdm845_desc, regmap);
 }
 
 static struct platform_driver disp_cc_sdm845_driver = {
diff --git a/drivers/clk/qcom/dispcc-sm6115.c b/drivers/clk/qcom/dispcc-sm6115.c
index 1937edf23f21..9ebdd82942ba 100644
--- a/drivers/clk/qcom/dispcc-sm6115.c
+++ b/drivers/clk/qcom/dispcc-sm6115.c
@@ -586,7 +586,7 @@ static int disp_cc_sm6115_probe(struct platform_device *pdev)
 	/* Keep DISP_CC_XO_CLK always-ON */
 	regmap_update_bits(regmap, 0x604c, BIT(0), BIT(0));
 
-	ret = qcom_cc_really_probe(pdev, &disp_cc_sm6115_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &disp_cc_sm6115_desc, regmap);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register DISP CC clocks\n");
 		return ret;
diff --git a/drivers/clk/qcom/dispcc-sm6125.c b/drivers/clk/qcom/dispcc-sm6125.c
index 87b27053ddb6..f9ef300146a7 100644
--- a/drivers/clk/qcom/dispcc-sm6125.c
+++ b/drivers/clk/qcom/dispcc-sm6125.c
@@ -682,7 +682,7 @@ static int disp_cc_sm6125_probe(struct platform_device *pdev)
 
 	clk_alpha_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
-	return qcom_cc_really_probe(pdev, &disp_cc_sm6125_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &disp_cc_sm6125_desc, regmap);
 }
 
 static struct platform_driver disp_cc_sm6125_driver = {
diff --git a/drivers/clk/qcom/dispcc-sm6350.c b/drivers/clk/qcom/dispcc-sm6350.c
index ea6f54ed846e..ff6e320a9c26 100644
--- a/drivers/clk/qcom/dispcc-sm6350.c
+++ b/drivers/clk/qcom/dispcc-sm6350.c
@@ -770,7 +770,7 @@ static int disp_cc_sm6350_probe(struct platform_device *pdev)
 
 	clk_fabia_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
-	return qcom_cc_really_probe(pdev, &disp_cc_sm6350_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &disp_cc_sm6350_desc, regmap);
 }
 
 static struct platform_driver disp_cc_sm6350_driver = {
diff --git a/drivers/clk/qcom/dispcc-sm6375.c b/drivers/clk/qcom/dispcc-sm6375.c
index caa1b90a5ff2..1ab189fe9d42 100644
--- a/drivers/clk/qcom/dispcc-sm6375.c
+++ b/drivers/clk/qcom/dispcc-sm6375.c
@@ -583,7 +583,7 @@ static int disp_cc_sm6375_probe(struct platform_device *pdev)
 
 	clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
-	return qcom_cc_really_probe(pdev, &disp_cc_sm6375_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &disp_cc_sm6375_desc, regmap);
 }
 
 static struct platform_driver disp_cc_sm6375_driver = {
diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index e17bb8b543b5..fc46cb3ffa62 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -1368,7 +1368,7 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 	/* DISP_CC_XO_CLK always-on */
 	regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
 
-	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8250_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &disp_cc_sm8250_desc, regmap);
 
 	pm_runtime_put(&pdev->dev);
 
diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
index adbfd30bfc96..9e3eec3f41d3 100644
--- a/drivers/clk/qcom/dispcc-sm8450.c
+++ b/drivers/clk/qcom/dispcc-sm8450.c
@@ -1791,7 +1791,7 @@ static int disp_cc_sm8450_probe(struct platform_device *pdev)
 	 */
 	regmap_update_bits(regmap, 0xe05c, BIT(0), BIT(0));
 
-	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8450_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &disp_cc_sm8450_desc, regmap);
 
 	pm_runtime_put(&pdev->dev);
 
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 1e5a11081860..8a460f2f119e 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -1776,7 +1776,7 @@ static int disp_cc_sm8550_probe(struct platform_device *pdev)
 	 */
 	regmap_update_bits(regmap, 0xe054, BIT(0), BIT(0));
 
-	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8550_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &disp_cc_sm8550_desc, regmap);
 
 	pm_runtime_put(&pdev->dev);
 
diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 86b43175b042..6ecd09999892 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -4609,7 +4609,7 @@ static int gcc_ipq6018_probe(struct platform_device *pdev)
 	clk_alpha_pll_configure(&nss_crypto_pll_main, regmap,
 				&nss_crypto_pll_config);
 
-	return qcom_cc_really_probe(pdev, &gcc_ipq6018_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_ipq6018_desc, regmap);
 }
 
 static struct platform_driver gcc_ipq6018_driver = {
diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 6541d98c0348..b54d6ca2d00e 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -4733,7 +4733,7 @@ static int gcc_ipq8074_probe(struct platform_device *pdev)
 	clk_alpha_pll_configure(&nss_crypto_pll_main, regmap,
 				&nss_crypto_pll_config);
 
-	return qcom_cc_really_probe(pdev, &gcc_ipq8074_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_ipq8074_desc, regmap);
 }
 
 static struct platform_driver gcc_ipq8074_driver = {
diff --git a/drivers/clk/qcom/gcc-mdm9607.c b/drivers/clk/qcom/gcc-mdm9607.c
index 4c9078e99bb3..fbef88518efd 100644
--- a/drivers/clk/qcom/gcc-mdm9607.c
+++ b/drivers/clk/qcom/gcc-mdm9607.c
@@ -1605,7 +1605,7 @@ static int gcc_mdm9607_probe(struct platform_device *pdev)
 	/* Vote for GPLL0 to turn on. Needed by acpuclock. */
 	regmap_update_bits(regmap, 0x45000, BIT(0), BIT(0));
 
-	return qcom_cc_really_probe(pdev, &gcc_mdm9607_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_mdm9607_desc, regmap);
 }
 
 static struct platform_driver gcc_mdm9607_driver = {
diff --git a/drivers/clk/qcom/gcc-mdm9615.c b/drivers/clk/qcom/gcc-mdm9615.c
index 8bed02a748ab..f63af7b6ae03 100644
--- a/drivers/clk/qcom/gcc-mdm9615.c
+++ b/drivers/clk/qcom/gcc-mdm9615.c
@@ -1712,7 +1712,7 @@ static int gcc_mdm9615_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return qcom_cc_really_probe(pdev, &gcc_mdm9615_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_mdm9615_desc, regmap);
 }
 
 static struct platform_driver gcc_mdm9615_driver = {
diff --git a/drivers/clk/qcom/gcc-msm8917.c b/drivers/clk/qcom/gcc-msm8917.c
index a4c33a2ce61c..6c292d387552 100644
--- a/drivers/clk/qcom/gcc-msm8917.c
+++ b/drivers/clk/qcom/gcc-msm8917.c
@@ -3270,7 +3270,7 @@ static int gcc_msm8917_probe(struct platform_device *pdev)
 
 	clk_alpha_pll_configure(&gpll3_early, regmap, &gpll3_early_config);
 
-	return qcom_cc_really_probe(pdev, gcc_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, gcc_desc, regmap);
 }
 
 static const struct of_device_id gcc_msm8917_match_table[] = {
diff --git a/drivers/clk/qcom/gcc-msm8939.c b/drivers/clk/qcom/gcc-msm8939.c
index 7f8969a77974..ec1227d4e714 100644
--- a/drivers/clk/qcom/gcc-msm8939.c
+++ b/drivers/clk/qcom/gcc-msm8939.c
@@ -4005,7 +4005,7 @@ static int gcc_msm8939_probe(struct platform_device *pdev)
 	clk_pll_configure_sr_hpm_lp(&gpll3, regmap, &gpll3_config, true);
 	clk_pll_configure_sr_hpm_lp(&gpll4, regmap, &gpll4_config, true);
 
-	return qcom_cc_really_probe(pdev, &gcc_msm8939_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_msm8939_desc, regmap);
 }
 
 static struct platform_driver gcc_msm8939_driver = {
diff --git a/drivers/clk/qcom/gcc-msm8953.c b/drivers/clk/qcom/gcc-msm8953.c
index 8aafa6591e84..158dee785e5b 100644
--- a/drivers/clk/qcom/gcc-msm8953.c
+++ b/drivers/clk/qcom/gcc-msm8953.c
@@ -4217,7 +4217,7 @@ static int gcc_msm8953_probe(struct platform_device *pdev)
 
 	clk_alpha_pll_configure(&gpll3_early, regmap, &gpll3_early_config);
 
-	return qcom_cc_really_probe(pdev, &gcc_msm8953_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_msm8953_desc, regmap);
 }
 
 static const struct of_device_id gcc_msm8953_match_table[] = {
diff --git a/drivers/clk/qcom/gcc-msm8976.c b/drivers/clk/qcom/gcc-msm8976.c
index 8beb923c0e19..dd8b68bf0300 100644
--- a/drivers/clk/qcom/gcc-msm8976.c
+++ b/drivers/clk/qcom/gcc-msm8976.c
@@ -4129,7 +4129,7 @@ static int gcc_msm8976_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_msm8976_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_msm8976_desc, regmap);
 }
 
 static struct platform_driver gcc_msm8976_driver = {
diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index 5e44d1bcca9e..673d3d9f376a 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -3848,7 +3848,7 @@ static int gcc_msm8996_probe(struct platform_device *pdev)
 	 */
 	regmap_update_bits(regmap, 0x52008, BIT(21), BIT(21));
 
-	return qcom_cc_really_probe(pdev, &gcc_msm8996_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_msm8996_desc, regmap);
 }
 
 static struct platform_driver gcc_msm8996_driver = {
diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index be024f8093c5..cd3a2e6338b6 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -3235,7 +3235,7 @@ static int gcc_msm8998_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_msm8998_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_msm8998_desc, regmap);
 }
 
 static const struct of_device_id gcc_msm8998_match_table[] = {
diff --git a/drivers/clk/qcom/gcc-qcm2290.c b/drivers/clk/qcom/gcc-qcm2290.c
index 48995e50c6bd..9a6703365e61 100644
--- a/drivers/clk/qcom/gcc-qcm2290.c
+++ b/drivers/clk/qcom/gcc-qcm2290.c
@@ -2994,7 +2994,7 @@ static int gcc_qcm2290_probe(struct platform_device *pdev)
 	clk_alpha_pll_configure(&gpll8, regmap, &gpll8_config);
 	clk_alpha_pll_configure(&gpll9, regmap, &gpll9_config);
 
-	return qcom_cc_really_probe(pdev, &gcc_qcm2290_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_qcm2290_desc, regmap);
 }
 
 static struct platform_driver gcc_qcm2290_driver = {
diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index a39c4990b29d..c3cfd572e7c1 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -2824,7 +2824,7 @@ static int gcc_qcs404_probe(struct platform_device *pdev)
 
 	clk_alpha_pll_configure(&gpll3_out_main, regmap, &gpll3_config);
 
-	return qcom_cc_really_probe(pdev, &gcc_qcs404_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_qcs404_desc, regmap);
 }
 
 static struct platform_driver gcc_qcs404_driver = {
diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
index 5051769ad90c..6e6a2f02712e 100644
--- a/drivers/clk/qcom/gcc-qdu1000.c
+++ b/drivers/clk/qcom/gcc-qdu1000.c
@@ -2622,7 +2622,7 @@ static int gcc_qdu1000_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qcom_cc_really_probe(pdev, &gcc_qdu1000_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &gcc_qdu1000_desc, regmap);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register GCC clocks\n");
 
diff --git a/drivers/clk/qcom/gcc-sa8775p.c b/drivers/clk/qcom/gcc-sa8775p.c
index bb94ff367abd..b4dc497c1255 100644
--- a/drivers/clk/qcom/gcc-sa8775p.c
+++ b/drivers/clk/qcom/gcc-sa8775p.c
@@ -4758,7 +4758,7 @@ static int gcc_sa8775p_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x34004, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x34024, BIT(0), BIT(0));
 
-	return qcom_cc_really_probe(pdev, &gcc_sa8775p_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sa8775p_desc, regmap);
 }
 
 static struct platform_driver gcc_sa8775p_driver = {
diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index cef3c77564cf..78379651588a 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -2461,7 +2461,7 @@ static int gcc_sc7180_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sc7180_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sc7180_desc, regmap);
 }
 
 static struct platform_driver gcc_sc7180_driver = {
diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 1dc804154031..cd5431c8b1e4 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -3472,7 +3472,7 @@ static int gcc_sc7280_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sc7280_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sc7280_desc, regmap);
 }
 
 static struct platform_driver gcc_sc7280_driver = {
diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
index c41b9f010585..76258103e5be 100644
--- a/drivers/clk/qcom/gcc-sc8180x.c
+++ b/drivers/clk/qcom/gcc-sc8180x.c
@@ -4602,7 +4602,7 @@ static int gcc_sc8180x_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
 	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
 
-	return qcom_cc_really_probe(pdev, &gcc_sc8180x_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sc8180x_desc, regmap);
 }
 
 static struct platform_driver gcc_sc8180x_driver = {
diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index b90c71637814..e728b7a55a2a 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -7456,7 +7456,7 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qcom_cc_really_probe(pdev, &gcc_sc8280xp_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &gcc_sc8280xp_desc, regmap);
 	pm_runtime_put(&pdev->dev);
 
 	return ret;
diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
index 6afce8e42ede..7ee0a58fe0b7 100644
--- a/drivers/clk/qcom/gcc-sdm660.c
+++ b/drivers/clk/qcom/gcc-sdm660.c
@@ -2475,7 +2475,7 @@ static int gcc_sdm660_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sdm660_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sdm660_desc, regmap);
 }
 
 static struct platform_driver gcc_sdm660_driver = {
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 6af08e0ca847..bbfd2bbb73b9 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -4012,7 +4012,7 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
 		return ret;
 
 	gcc_desc = of_device_get_match_data(&pdev->dev);
-	return qcom_cc_really_probe(pdev, gcc_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, gcc_desc, regmap);
 }
 
 static struct platform_driver gcc_sdm845_driver = {
diff --git a/drivers/clk/qcom/gcc-sdx55.c b/drivers/clk/qcom/gcc-sdx55.c
index d5e17122698c..2b7a24b07119 100644
--- a/drivers/clk/qcom/gcc-sdx55.c
+++ b/drivers/clk/qcom/gcc-sdx55.c
@@ -1620,7 +1620,7 @@ static int gcc_sdx55_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21));
 	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22));
 
-	return qcom_cc_really_probe(pdev, &gcc_sdx55_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sdx55_desc, regmap);
 }
 
 static struct platform_driver gcc_sdx55_driver = {
diff --git a/drivers/clk/qcom/gcc-sdx65.c b/drivers/clk/qcom/gcc-sdx65.c
index b0c17043551d..c27dc4bca6d3 100644
--- a/drivers/clk/qcom/gcc-sdx65.c
+++ b/drivers/clk/qcom/gcc-sdx65.c
@@ -1583,7 +1583,7 @@ static int gcc_sdx65_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21));
 	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22));
 
-	return qcom_cc_really_probe(pdev, &gcc_sdx65_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sdx65_desc, regmap);
 }
 
 static struct platform_driver gcc_sdx65_driver = {
diff --git a/drivers/clk/qcom/gcc-sdx75.c b/drivers/clk/qcom/gcc-sdx75.c
index b6772abdcec5..65a1d77a01f5 100644
--- a/drivers/clk/qcom/gcc-sdx75.c
+++ b/drivers/clk/qcom/gcc-sdx75.c
@@ -2943,7 +2943,7 @@ static int gcc_sdx75_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x3e004, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x3e008, BIT(0), BIT(0));
 
-	return qcom_cc_really_probe(pdev, &gcc_sdx75_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sdx75_desc, regmap);
 }
 
 static struct platform_driver gcc_sdx75_driver = {
diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index 033e308ff865..211b3693d6dc 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -3512,7 +3512,7 @@ static int gcc_sm6115_probe(struct platform_device *pdev)
 	clk_alpha_pll_configure(&gpll10, regmap, &gpll10_config);
 	clk_alpha_pll_configure(&gpll11, regmap, &gpll11_config);
 
-	return qcom_cc_really_probe(pdev, &gcc_sm6115_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sm6115_desc, regmap);
 }
 
 static struct platform_driver gcc_sm6115_driver = {
diff --git a/drivers/clk/qcom/gcc-sm6125.c b/drivers/clk/qcom/gcc-sm6125.c
index 40ad062d1bf7..a5e26c909ecc 100644
--- a/drivers/clk/qcom/gcc-sm6125.c
+++ b/drivers/clk/qcom/gcc-sm6125.c
@@ -4162,7 +4162,7 @@ static int gcc_sm6125_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sm6125_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sm6125_desc, regmap);
 }
 
 static struct platform_driver gcc_sm6125_driver = {
diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
index 9b4e4bb05963..44f2eb827f17 100644
--- a/drivers/clk/qcom/gcc-sm6350.c
+++ b/drivers/clk/qcom/gcc-sm6350.c
@@ -2558,7 +2558,7 @@ static int gcc_sm6350_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sm6350_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sm6350_desc, regmap);
 }
 
 static struct platform_driver gcc_sm6350_driver = {
diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
index 417a0fd242ec..2e8eb1305e65 100644
--- a/drivers/clk/qcom/gcc-sm6375.c
+++ b/drivers/clk/qcom/gcc-sm6375.c
@@ -3894,7 +3894,7 @@ static int gcc_sm6375_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&gpll8, regmap, &gpll8_config);
 	clk_zonda_pll_configure(&gpll9, regmap, &gpll9_config);
 
-	return qcom_cc_really_probe(pdev, &gcc_sm6375_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sm6375_desc, regmap);
 }
 
 static struct platform_driver gcc_sm6375_driver = {
diff --git a/drivers/clk/qcom/gcc-sm7150.c b/drivers/clk/qcom/gcc-sm7150.c
index 6b628178f62c..a531c0b5598f 100644
--- a/drivers/clk/qcom/gcc-sm7150.c
+++ b/drivers/clk/qcom/gcc-sm7150.c
@@ -3021,7 +3021,7 @@ static int gcc_sm7150_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sm7150_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sm7150_desc, regmap);
 }
 
 static struct platform_driver gcc_sm7150_driver = {
diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 70b067f3618c..16e9e58bffdb 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -3787,7 +3787,7 @@ static int gcc_sm8150_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
 	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
 
-	return qcom_cc_really_probe(pdev, &gcc_sm8150_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sm8150_desc, regmap);
 }
 
 static struct platform_driver gcc_sm8150_driver = {
diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index b6cf4bc88d4d..f3b58b6ff56c 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -3660,7 +3660,7 @@ static int gcc_sm8250_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sm8250_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sm8250_desc, regmap);
 }
 
 static struct platform_driver gcc_sm8250_driver = {
diff --git a/drivers/clk/qcom/gcc-sm8350.c b/drivers/clk/qcom/gcc-sm8350.c
index 1385a98eb3bb..84de2db61cc3 100644
--- a/drivers/clk/qcom/gcc-sm8350.c
+++ b/drivers/clk/qcom/gcc-sm8350.c
@@ -3826,7 +3826,7 @@ static int gcc_sm8350_probe(struct platform_device *pdev)
 	/* FORCE_MEM_CORE_ON for ufs phy ice core clocks */
 	regmap_update_bits(regmap, gcc_ufs_phy_ice_core_clk.halt_reg, BIT(14), BIT(14));
 
-	return qcom_cc_really_probe(pdev, &gcc_sm8350_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sm8350_desc, regmap);
 }
 
 static struct platform_driver gcc_sm8350_driver = {
diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 75635d40a12d..97001faf3dc1 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -3293,7 +3293,7 @@ static int gcc_sm8450_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x42004, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x42028, BIT(0), BIT(0));
 
-	return qcom_cc_really_probe(pdev, &gcc_sm8450_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sm8450_desc, regmap);
 }
 
 static struct platform_driver gcc_sm8450_driver = {
diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
index 277cd4f020ff..6e7bfee5ae9c 100644
--- a/drivers/clk/qcom/gcc-sm8550.c
+++ b/drivers/clk/qcom/gcc-sm8550.c
@@ -3360,7 +3360,7 @@ static int gcc_sm8550_probe(struct platform_device *pdev)
 	/* Clear GDSC_SLEEP_ENA_VOTE to stop votes being auto-removed in sleep. */
 	regmap_write(regmap, 0x52024, 0x0);
 
-	return qcom_cc_really_probe(pdev, &gcc_sm8550_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sm8550_desc, regmap);
 }
 
 static struct platform_driver gcc_sm8550_driver = {
diff --git a/drivers/clk/qcom/gpucc-msm8998.c b/drivers/clk/qcom/gpucc-msm8998.c
index f929e0f2333f..2a35e38f80a2 100644
--- a/drivers/clk/qcom/gpucc-msm8998.c
+++ b/drivers/clk/qcom/gpucc-msm8998.c
@@ -335,7 +335,7 @@ static int gpucc_msm8998_probe(struct platform_device *pdev)
 	/* tweak droop detector (GPUCC_GPU_DD_WRAP_CTRL) to reduce leakage */
 	regmap_write_bits(regmap, gfx3d_clk.clkr.enable_reg, BIT(0), BIT(0));
 
-	return qcom_cc_really_probe(pdev, &gpucc_msm8998_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpucc_msm8998_desc, regmap);
 }
 
 static struct platform_driver gpucc_msm8998_driver = {
diff --git a/drivers/clk/qcom/gpucc-sa8775p.c b/drivers/clk/qcom/gpucc-sa8775p.c
index 18d23be8d435..b76223c79a2a 100644
--- a/drivers/clk/qcom/gpucc-sa8775p.c
+++ b/drivers/clk/qcom/gpucc-sa8775p.c
@@ -598,7 +598,7 @@ static int gpu_cc_sa8775p_probe(struct platform_device *pdev)
 	clk_lucid_evo_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
 	clk_lucid_evo_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sa8775p_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sa8775p_desc, regmap);
 }
 
 static struct platform_driver gpu_cc_sa8775p_driver = {
diff --git a/drivers/clk/qcom/gpucc-sc7180.c b/drivers/clk/qcom/gpucc-sc7180.c
index 3f92f0b43be6..03b48767cf4d 100644
--- a/drivers/clk/qcom/gpucc-sc7180.c
+++ b/drivers/clk/qcom/gpucc-sc7180.c
@@ -241,7 +241,7 @@ static int gpu_cc_sc7180_probe(struct platform_device *pdev)
 	value = 0xF << CX_GMU_CBCR_WAKE_SHIFT | 0xF << CX_GMU_CBCR_SLEEP_SHIFT;
 	regmap_update_bits(regmap, 0x1098, mask, value);
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sc7180_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sc7180_desc, regmap);
 }
 
 static struct platform_driver gpu_cc_sc7180_driver = {
diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
index 1490cd45a654..71ea731223c8 100644
--- a/drivers/clk/qcom/gpucc-sc7280.c
+++ b/drivers/clk/qcom/gpucc-sc7280.c
@@ -465,7 +465,7 @@ static int gpu_cc_sc7280_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x1098, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x1098, BIT(13), BIT(13));
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sc7280_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sc7280_desc, regmap);
 }
 
 static struct platform_driver gpu_cc_sc7280_driver = {
diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index 8e147ee294ee..3ec2437e8586 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -451,7 +451,7 @@ static int gpu_cc_sc8280xp_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x1170, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x109c, BIT(0), BIT(0));
 
-	ret = qcom_cc_really_probe(pdev, &gpu_cc_sc8280xp_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &gpu_cc_sc8280xp_desc, regmap);
 	pm_runtime_put(&pdev->dev);
 
 	return ret;
diff --git a/drivers/clk/qcom/gpucc-sdm660.c b/drivers/clk/qcom/gpucc-sdm660.c
index d6b38a0b063d..653cd218d012 100644
--- a/drivers/clk/qcom/gpucc-sdm660.c
+++ b/drivers/clk/qcom/gpucc-sdm660.c
@@ -331,7 +331,7 @@ static int gpucc_sdm660_probe(struct platform_device *pdev)
 	gpu_pll_config.alpha_hi = 0x8a;
 	clk_alpha_pll_configure(&gpu_pll1_pll_out_main, regmap, &gpu_pll_config);
 
-	return qcom_cc_really_probe(pdev, &gpucc_sdm660_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpucc_sdm660_desc, regmap);
 }
 
 static struct platform_driver gpucc_sdm660_driver = {
diff --git a/drivers/clk/qcom/gpucc-sdm845.c b/drivers/clk/qcom/gpucc-sdm845.c
index 970d7414bdf0..8658f692fcea 100644
--- a/drivers/clk/qcom/gpucc-sdm845.c
+++ b/drivers/clk/qcom/gpucc-sdm845.c
@@ -192,7 +192,7 @@ static int gpu_cc_sdm845_probe(struct platform_device *pdev)
 	value = 0xf << CX_GMU_CBCR_WAKE_SHIFT | 0xf << CX_GMU_CBCR_SLEEP_SHIFT;
 	regmap_update_bits(regmap, 0x1098, mask, value);
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sdm845_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sdm845_desc, regmap);
 }
 
 static struct platform_driver gpu_cc_sdm845_driver = {
diff --git a/drivers/clk/qcom/gpucc-sm6115.c b/drivers/clk/qcom/gpucc-sm6115.c
index c84727e8352d..d9b0c72d1de1 100644
--- a/drivers/clk/qcom/gpucc-sm6115.c
+++ b/drivers/clk/qcom/gpucc-sm6115.c
@@ -487,7 +487,7 @@ static int gpu_cc_sm6115_probe(struct platform_device *pdev)
 	qcom_branch_set_force_mem_core(regmap, gpu_cc_gx_gfx3d_clk, true);
 	qcom_branch_set_force_periph_on(regmap, gpu_cc_gx_gfx3d_clk, true);
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sm6115_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sm6115_desc, regmap);
 }
 
 static struct platform_driver gpu_cc_sm6115_driver = {
diff --git a/drivers/clk/qcom/gpucc-sm6125.c b/drivers/clk/qcom/gpucc-sm6125.c
index d4f1296a48ef..88da5df38a41 100644
--- a/drivers/clk/qcom/gpucc-sm6125.c
+++ b/drivers/clk/qcom/gpucc-sm6125.c
@@ -408,7 +408,7 @@ static int gpu_cc_sm6125_probe(struct platform_device *pdev)
 	qcom_branch_set_force_mem_core(regmap, gpu_cc_gx_gfx3d_clk, true);
 	qcom_branch_set_force_periph_on(regmap, gpu_cc_gx_gfx3d_clk, true);
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sm6125_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sm6125_desc, regmap);
 }
 
 static struct platform_driver gpu_cc_sm6125_driver = {
diff --git a/drivers/clk/qcom/gpucc-sm6350.c b/drivers/clk/qcom/gpucc-sm6350.c
index ef15185a99c3..21f9ef9227e5 100644
--- a/drivers/clk/qcom/gpucc-sm6350.c
+++ b/drivers/clk/qcom/gpucc-sm6350.c
@@ -494,7 +494,7 @@ static int gpu_cc_sm6350_probe(struct platform_device *pdev)
 	value = 0xF << CX_GMU_CBCR_WAKE_SHIFT | 0xF << CX_GMU_CBCR_SLEEP_SHIFT;
 	regmap_update_bits(regmap, 0x1098, mask, value);
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sm6350_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sm6350_desc, regmap);
 }
 
 static struct platform_driver gpu_cc_sm6350_driver = {
diff --git a/drivers/clk/qcom/gpucc-sm6375.c b/drivers/clk/qcom/gpucc-sm6375.c
index 2d863dc3d83b..5bfeb4c857a9 100644
--- a/drivers/clk/qcom/gpucc-sm6375.c
+++ b/drivers/clk/qcom/gpucc-sm6375.c
@@ -454,7 +454,7 @@ static int gpucc_sm6375_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&gpucc_pll0, regmap, &gpucc_pll0_config);
 	clk_lucid_pll_configure(&gpucc_pll1, regmap, &gpucc_pll1_config);
 
-	ret = qcom_cc_really_probe(pdev, &gpucc_sm6375_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &gpucc_sm6375_desc, regmap);
 	pm_runtime_put(&pdev->dev);
 
 	return ret;
diff --git a/drivers/clk/qcom/gpucc-sm8150.c b/drivers/clk/qcom/gpucc-sm8150.c
index 8422fd047493..1aefe5c224b8 100644
--- a/drivers/clk/qcom/gpucc-sm8150.c
+++ b/drivers/clk/qcom/gpucc-sm8150.c
@@ -304,7 +304,7 @@ static int gpu_cc_sm8150_probe(struct platform_device *pdev)
 
 	clk_trion_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sm8150_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sm8150_desc, regmap);
 }
 
 static struct platform_driver gpu_cc_sm8150_driver = {
diff --git a/drivers/clk/qcom/gpucc-sm8250.c b/drivers/clk/qcom/gpucc-sm8250.c
index 9c1f8ce32da4..1bdd1a8ac53f 100644
--- a/drivers/clk/qcom/gpucc-sm8250.c
+++ b/drivers/clk/qcom/gpucc-sm8250.c
@@ -320,7 +320,7 @@ static int gpu_cc_sm8250_probe(struct platform_device *pdev)
 	value = 0xf << CX_GMU_CBCR_WAKE_SHIFT | 0xf << CX_GMU_CBCR_SLEEP_SHIFT;
 	regmap_update_bits(regmap, 0x1098, mask, value);
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sm8250_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sm8250_desc, regmap);
 }
 
 static struct platform_driver gpu_cc_sm8250_driver = {
diff --git a/drivers/clk/qcom/gpucc-sm8350.c b/drivers/clk/qcom/gpucc-sm8350.c
index 5367ce654ac9..53b69a12942f 100644
--- a/drivers/clk/qcom/gpucc-sm8350.c
+++ b/drivers/clk/qcom/gpucc-sm8350.c
@@ -604,7 +604,7 @@ static int gpu_cc_sm8350_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
 	clk_lucid_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sm8350_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sm8350_desc, regmap);
 }
 
 static const struct of_device_id gpu_cc_sm8350_match_table[] = {
diff --git a/drivers/clk/qcom/gpucc-sm8450.c b/drivers/clk/qcom/gpucc-sm8450.c
index 16c0381b3087..bf48ea630dd5 100644
--- a/drivers/clk/qcom/gpucc-sm8450.c
+++ b/drivers/clk/qcom/gpucc-sm8450.c
@@ -750,7 +750,7 @@ static int gpu_cc_sm8450_probe(struct platform_device *pdev)
 	clk_lucid_evo_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
 	clk_lucid_evo_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sm8450_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sm8450_desc, regmap);
 }
 
 static struct platform_driver gpu_cc_sm8450_driver = {
diff --git a/drivers/clk/qcom/gpucc-sm8550.c b/drivers/clk/qcom/gpucc-sm8550.c
index 8a2e3522af51..13474af4d6e4 100644
--- a/drivers/clk/qcom/gpucc-sm8550.c
+++ b/drivers/clk/qcom/gpucc-sm8550.c
@@ -584,7 +584,7 @@ static int gpu_cc_sm8550_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x9004, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x900c, BIT(0), BIT(0));
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sm8550_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sm8550_desc, regmap);
 }
 
 static struct platform_driver gpu_cc_sm8550_driver = {
diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index 81a44a9a9abc..beb4d3881e60 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -455,7 +455,7 @@ static int lcc_ipq806x_probe(struct platform_device *pdev)
 	/* Enable PLL4 source on the LPASS Primary PLL Mux */
 	regmap_write(regmap, 0xc4, 0x1);
 
-	return qcom_cc_really_probe(pdev, &lcc_ipq806x_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &lcc_ipq806x_desc, regmap);
 }
 
 static struct platform_driver lcc_ipq806x_driver = {
diff --git a/drivers/clk/qcom/lcc-mdm9615.c b/drivers/clk/qcom/lcc-mdm9615.c
index 8d243e880d95..e0035b67f16a 100644
--- a/drivers/clk/qcom/lcc-mdm9615.c
+++ b/drivers/clk/qcom/lcc-mdm9615.c
@@ -555,7 +555,7 @@ static int lcc_mdm9615_probe(struct platform_device *pdev)
 	/* Enable PLL4 source on the LPASS Primary PLL Mux */
 	regmap_write(regmap, 0xc4, 0x1);
 
-	return qcom_cc_really_probe(pdev, &lcc_mdm9615_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &lcc_mdm9615_desc, regmap);
 }
 
 static struct platform_driver lcc_mdm9615_driver = {
diff --git a/drivers/clk/qcom/lcc-msm8960.c b/drivers/clk/qcom/lcc-msm8960.c
index 3926184cc91b..b8d8346f5bab 100644
--- a/drivers/clk/qcom/lcc-msm8960.c
+++ b/drivers/clk/qcom/lcc-msm8960.c
@@ -471,7 +471,7 @@ static int lcc_msm8960_probe(struct platform_device *pdev)
 	/* Enable PLL4 source on the LPASS Primary PLL Mux */
 	regmap_write(regmap, 0xc4, 0x1);
 
-	return qcom_cc_really_probe(pdev, &lcc_msm8960_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &lcc_msm8960_desc, regmap);
 }
 
 static struct platform_driver lcc_msm8960_driver = {
diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 134eb1529ede..4934409b90b5 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -771,7 +771,7 @@ static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
 	regmap_write(regmap, 0x4, 0x3b);
 	regmap_write(regmap, 0x8, 0xff05);
 
-	ret = qcom_cc_really_probe(pdev, &lpass_audio_cc_sc7280_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &lpass_audio_cc_sc7280_desc, regmap);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register LPASS AUDIO CC clocks\n");
 		goto exit;
@@ -846,7 +846,7 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
 
 	clk_lucid_pll_configure(&lpass_aon_cc_pll, regmap, &lpass_aon_cc_pll_config);
 
-	ret = qcom_cc_really_probe(pdev, &lpass_aon_cc_sc7280_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &lpass_aon_cc_sc7280_desc, regmap);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register LPASS AON CC clocks\n");
 		goto exit;
diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 010867dcc2ef..c5b51e471020 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -414,7 +414,7 @@ static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 	clk_fabia_pll_configure(&lpass_lpaaudio_dig_pll, regmap,
 				&lpass_lpaaudio_dig_pll_config);
 
-	ret = qcom_cc_really_probe(pdev, &lpass_core_cc_sc7180_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &lpass_core_cc_sc7180_desc, regmap);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 exit:
diff --git a/drivers/clk/qcom/lpasscorecc-sc7280.c b/drivers/clk/qcom/lpasscorecc-sc7280.c
index 6ad19b06b1ce..8a9a9d7dab0d 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7280.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7280.c
@@ -405,7 +405,7 @@ static int lpass_core_cc_sc7280_probe(struct platform_device *pdev)
 
 	clk_lucid_pll_configure(&lpass_core_cc_dig_pll, regmap, &lpass_core_cc_dig_pll_config);
 
-	return qcom_cc_really_probe(pdev, &lpass_core_cc_sc7280_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &lpass_core_cc_sc7280_desc, regmap);
 }
 
 static struct platform_driver lpass_core_cc_sc7280_driver = {
diff --git a/drivers/clk/qcom/mmcc-msm8960.c b/drivers/clk/qcom/mmcc-msm8960.c
index 6bf908a51f53..bd532f371cdf 100644
--- a/drivers/clk/qcom/mmcc-msm8960.c
+++ b/drivers/clk/qcom/mmcc-msm8960.c
@@ -3128,7 +3128,7 @@ static int mmcc_msm8960_probe(struct platform_device *pdev)
 
 	clk_pll_configure_sr(&pll15, regmap, &pll15_config, false);
 
-	return qcom_cc_really_probe(pdev, match->data, regmap);
+	return qcom_cc_really_probe(&pdev->dev, match->data, regmap);
 }
 
 static struct platform_driver mmcc_msm8960_driver = {
diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index 82f6bad144a9..524d94d89aa3 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -2774,7 +2774,7 @@ static int mmcc_msm8974_probe(struct platform_device *pdev)
 		msm8226_clock_override();
 	}
 
-	return qcom_cc_really_probe(pdev, desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, desc, regmap);
 }
 
 static struct platform_driver mmcc_msm8974_driver = {
diff --git a/drivers/clk/qcom/mmcc-msm8994.c b/drivers/clk/qcom/mmcc-msm8994.c
index 89c5f5fa7d9a..b46e133a3da1 100644
--- a/drivers/clk/qcom/mmcc-msm8994.c
+++ b/drivers/clk/qcom/mmcc-msm8994.c
@@ -2603,7 +2603,7 @@ static int mmcc_msm8994_probe(struct platform_device *pdev)
 	clk_alpha_pll_configure(&mmpll3_early, regmap, &mmpll_p_config);
 	clk_alpha_pll_configure(&mmpll5_early, regmap, &mmpll_p_config);
 
-	return qcom_cc_really_probe(pdev, &mmcc_msm8994_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &mmcc_msm8994_desc, regmap);
 }
 
 static struct platform_driver mmcc_msm8994_driver = {
diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm8996.c
index 80330dab4d81..8b898e6e53c3 100644
--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -3627,7 +3627,7 @@ static int mmcc_msm8996_probe(struct platform_device *pdev)
 	/* Disable the NoC FSM for mmss_mmagic_cfg_ahb_clk */
 	regmap_update_bits(regmap, 0x5054, BIT(15), 0);
 
-	return qcom_cc_really_probe(pdev, &mmcc_msm8996_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &mmcc_msm8996_desc, regmap);
 }
 
 static struct platform_driver mmcc_msm8996_driver = {
diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index 4490594bde69..2f74c539f394 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -2873,7 +2873,7 @@ static int mmcc_msm8998_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return qcom_cc_really_probe(pdev, &mmcc_msm8998_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &mmcc_msm8998_desc, regmap);
 }
 
 static struct platform_driver mmcc_msm8998_driver = {
diff --git a/drivers/clk/qcom/mmcc-sdm660.c b/drivers/clk/qcom/mmcc-sdm660.c
index bc19a23e13f8..db9c916a07b6 100644
--- a/drivers/clk/qcom/mmcc-sdm660.c
+++ b/drivers/clk/qcom/mmcc-sdm660.c
@@ -2851,7 +2851,7 @@ static int mmcc_660_probe(struct platform_device *pdev)
 	clk_alpha_pll_configure(&mmpll8, regmap, &mmpll8_config);
 	clk_alpha_pll_configure(&mmpll10, regmap, &mmpll10_config);
 
-	return qcom_cc_really_probe(pdev, &mmcc_660_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &mmcc_660_desc, regmap);
 }
 
 static struct platform_driver mmcc_660_driver = {
diff --git a/drivers/clk/qcom/tcsrcc-sm8550.c b/drivers/clk/qcom/tcsrcc-sm8550.c
index 2c67ee71c196..617dc1123267 100644
--- a/drivers/clk/qcom/tcsrcc-sm8550.c
+++ b/drivers/clk/qcom/tcsrcc-sm8550.c
@@ -165,7 +165,7 @@ static int tcsr_cc_sm8550_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return qcom_cc_really_probe(pdev, &tcsr_cc_sm8550_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &tcsr_cc_sm8550_desc, regmap);
 }
 
 static struct platform_driver tcsr_cc_sm8550_driver = {
diff --git a/drivers/clk/qcom/videocc-sc7180.c b/drivers/clk/qcom/videocc-sc7180.c
index 5b9b54f616b8..526165b2acb8 100644
--- a/drivers/clk/qcom/videocc-sc7180.c
+++ b/drivers/clk/qcom/videocc-sc7180.c
@@ -226,7 +226,7 @@ static int video_cc_sc7180_probe(struct platform_device *pdev)
 	/* Keep VIDEO_CC_XO_CLK ALWAYS-ON */
 	regmap_update_bits(regmap, 0x984, 0x1, 0x1);
 
-	return qcom_cc_really_probe(pdev, &video_cc_sc7180_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &video_cc_sc7180_desc, regmap);
 }
 
 static struct platform_driver video_cc_sc7180_driver = {
diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
index 615695d82319..fd6186d708b9 100644
--- a/drivers/clk/qcom/videocc-sc7280.c
+++ b/drivers/clk/qcom/videocc-sc7280.c
@@ -298,7 +298,7 @@ static int video_cc_sc7280_probe(struct platform_device *pdev)
 
 	clk_lucid_pll_configure(&video_pll0, regmap, &video_pll0_config);
 
-	return qcom_cc_really_probe(pdev, &video_cc_sc7280_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &video_cc_sc7280_desc, regmap);
 }
 
 static struct platform_driver video_cc_sc7280_driver = {
diff --git a/drivers/clk/qcom/videocc-sdm845.c b/drivers/clk/qcom/videocc-sdm845.c
index c77a4dd5d39c..557264abdbaa 100644
--- a/drivers/clk/qcom/videocc-sdm845.c
+++ b/drivers/clk/qcom/videocc-sdm845.c
@@ -329,7 +329,7 @@ static int video_cc_sdm845_probe(struct platform_device *pdev)
 
 	clk_fabia_pll_configure(&video_pll0, regmap, &video_pll0_config);
 
-	return qcom_cc_really_probe(pdev, &video_cc_sdm845_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &video_cc_sdm845_desc, regmap);
 }
 
 static struct platform_driver video_cc_sdm845_driver = {
diff --git a/drivers/clk/qcom/videocc-sm8150.c b/drivers/clk/qcom/videocc-sm8150.c
index 1afdbe4a249d..a5e7ba988372 100644
--- a/drivers/clk/qcom/videocc-sm8150.c
+++ b/drivers/clk/qcom/videocc-sm8150.c
@@ -245,7 +245,7 @@ static int video_cc_sm8150_probe(struct platform_device *pdev)
 	/* Keep VIDEO_CC_XO_CLK ALWAYS-ON */
 	regmap_update_bits(regmap, 0x984, 0x1, 0x1);
 
-	return qcom_cc_really_probe(pdev, &video_cc_sm8150_desc, regmap);
+	return qcom_cc_really_probe(&pdev->dev, &video_cc_sm8150_desc, regmap);
 }
 
 static struct platform_driver video_cc_sm8150_driver = {
diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index ad46c4014a40..6d119dcb7b1e 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -387,7 +387,7 @@ static int video_cc_sm8250_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
 
-	ret = qcom_cc_really_probe(pdev, &video_cc_sm8250_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &video_cc_sm8250_desc, regmap);
 
 	pm_runtime_put(&pdev->dev);
 
diff --git a/drivers/clk/qcom/videocc-sm8350.c b/drivers/clk/qcom/videocc-sm8350.c
index b148877fc73d..6a13b7da30e0 100644
--- a/drivers/clk/qcom/videocc-sm8350.c
+++ b/drivers/clk/qcom/videocc-sm8350.c
@@ -527,7 +527,7 @@ static int video_cc_sm8350_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
 
-	ret = qcom_cc_really_probe(pdev, &video_cc_sm8350_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &video_cc_sm8350_desc, regmap);
 	pm_runtime_put(&pdev->dev);
 
 	return ret;
diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
index 7d0029b8b799..1ae3beab1d37 100644
--- a/drivers/clk/qcom/videocc-sm8450.c
+++ b/drivers/clk/qcom/videocc-sm8450.c
@@ -432,7 +432,7 @@ static int video_cc_sm8450_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x8130, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x8114, BIT(0), BIT(0));
 
-	ret = qcom_cc_really_probe(pdev, &video_cc_sm8450_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &video_cc_sm8450_desc, regmap);
 
 	pm_runtime_put(&pdev->dev);
 
diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index e2400fe23e60..dcca9bc04756 100644
--- a/drivers/clk/qcom/videocc-sm8550.c
+++ b/drivers/clk/qcom/videocc-sm8550.c
@@ -439,7 +439,7 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x8140, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x8124, BIT(0), BIT(0));
 
-	ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &video_cc_sm8550_desc, regmap);
 
 	pm_runtime_put(&pdev->dev);
 
-- 
2.17.1

