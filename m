Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA377EFFAB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 13:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjKRMk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 07:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjKRMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 07:40:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD710CF;
        Sat, 18 Nov 2023 04:40:46 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIC99Zu016888;
        Sat, 18 Nov 2023 12:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=SBpOQrbp7XlDO8T1tC3fI7fAzNuLm6Fu1U8IgPaTQ4w=;
 b=QnWM9V1JPb5YWCq2JxdpVbeoSYUjcnQ+n7fjzCP6rK5SVWNBY1V4fHyUp+1ymJipTdlE
 iGZvU6Pxga1+7j1btSYZ2+f0yM3Vd1e1viV28S+oT+lxEPf6aGMacuv60kkbw0Mu7Utz
 p3hcAzMx4YmzFYzO5r5U+eHa904tgYc1w6l+kFkX5+LYwxJIWB6AktAeDP5rWpRUKdrx
 LEMp805Hqo12VgelzNf0hPPRmHCzGBnvmDZ2DK8u5+YUwd36Ay+cCVqCENhDuvADGkfb
 zs0mkydMQc5UBjwKnb/cY3DaTKKnwI5fFGNCfE2tMGeKP6odTZVwEDDwKbcziJbieR/7 uQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uem9e8jy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 12:40:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AICeeH1005596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 12:40:41 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 18 Nov 2023 04:40:36 -0800
From:   Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>
Subject: [PATCH V2 4/4] clk: qcom: videocc-sm8150: Add runtime PM support
Date:   Sat, 18 Nov 2023 18:09:44 +0530
Message-ID: <20231118123944.2202630-5-quic_skakitap@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231118123944.2202630-1-quic_skakitap@quicinc.com>
References: <20231118123944.2202630-1-quic_skakitap@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qs6mAs21Uh2vJWaz5MJOdMNxICpF2ME8
X-Proofpoint-GUID: qs6mAs21Uh2vJWaz5MJOdMNxICpF2ME8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_11,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311180094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime PM support to ensure the supply rails are enabled
when necessary.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
Changes since v1:
 - None.

 drivers/clk/qcom/videocc-sm8150.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sm8150.c b/drivers/clk/qcom/videocc-sm8150.c
index 52a9a453a143..b57df5ff96c4 100644
--- a/drivers/clk/qcom/videocc-sm8150.c
+++ b/drivers/clk/qcom/videocc-sm8150.c
@@ -6,6 +6,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,videocc-sm8150.h>
@@ -240,17 +241,32 @@ MODULE_DEVICE_TABLE(of, video_cc_sm8150_match_table);
 static int video_cc_sm8150_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
+	int ret;
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
 
 	regmap = qcom_cc_map(pdev, &video_cc_sm8150_desc);
-	if (IS_ERR(regmap))
+	if (IS_ERR(regmap)) {
+		pm_runtime_put(&pdev->dev);
 		return PTR_ERR(regmap);
+	}
 
 	clk_trion_pll_configure(&video_pll0, regmap, &video_pll0_config);
 
 	/* Keep VIDEO_CC_XO_CLK ALWAYS-ON */
 	regmap_update_bits(regmap, 0x984, 0x1, 0x1);
 
-	return qcom_cc_really_probe(pdev, &video_cc_sm8150_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &video_cc_sm8150_desc, regmap);
+
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
 }
 
 static struct platform_driver video_cc_sm8150_driver = {
-- 
2.25.1

