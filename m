Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D257AD5F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjIYK3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjIYK3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:29:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E591A3;
        Mon, 25 Sep 2023 03:29:34 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P9OE59017244;
        Mon, 25 Sep 2023 10:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=f4ljE8N7jSMtZnLN7PP7A823ubbMKrgRc/IDalqJ9jQ=;
 b=hk/sRIbzOmckL6lDQYsqhq74IPXxmdJkeRlDJenwf980mdjdVFrlEdUYD9UM0yV5RTxr
 7eGK2SYDThlaQfy0GWSek38SkkAb9BHQ85SKMOMcTootvZ3JtuWo+ZQBGmPoBKU6sAXf
 MDgepmmWEj853B5dke44uL5NR31yUsQmP+4Xk0yzwfLdETVD1JUEWma/3xcIIm4D4+Iv
 62m/3IvdlD28h3rB9MqKQdFug2cRDxYjFe9Q1Kl1ZdUKWU0VNyTPQE1ur6MflAmIrAm5
 KvlmPV1UUoYomE3pTdpa0VJQpW+kBANAVIOYutkKK72afRiHLh+YchBpLzQIKx/As46g uw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9safbss4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:29:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PASsTU019526
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:28:54 GMT
Received: from hu-gokulsri-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 25 Sep 2023 03:28:49 -0700
From:   Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
To:     <dmitry.baryshkov@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <jassisinghbrar@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>
Subject: [PATCH V3 2/3] clk: qcom: apss-ipq-pll: add support for IPQ5018
Date:   Mon, 25 Sep 2023 15:58:25 +0530
Message-ID: <20230925102826.405446-3-quic_gokulsri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925102826.405446-1-quic_gokulsri@quicinc.com>
References: <20230925102826.405446-1-quic_gokulsri@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rYXGC1lglQ0xsi0n6gIjhc2cRvI1i6TD
X-Proofpoint-GUID: rYXGC1lglQ0xsi0n6gIjhc2cRvI1i6TD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 APSS PLL is of type Stromer. Reuse Stromer Plus PLL offsets,
add configuration values and the compatible.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/apss-ipq-pll.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index e170331858cc..bebbc8c5ab68 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -73,6 +73,20 @@ static struct clk_alpha_pll ipq_pll_stromer_plus = {
 	},
 };
 
+static const struct alpha_pll_config ipq5018_pll_config = {
+	.l = 0x32,
+	.config_ctl_val = 0x4001075b,
+	.config_ctl_hi_val = 0x304,
+	.main_output_mask = BIT(0),
+	.aux_output_mask = BIT(1),
+	.early_output_mask = BIT(3),
+	.alpha_en_mask = BIT(24),
+	.status_val = 0x3,
+	.status_mask = GENMASK(10, 8),
+	.lock_det = BIT(2),
+	.test_ctl_hi_val = 0x00400003,
+};
+
 static const struct alpha_pll_config ipq5332_pll_config = {
 	.l = 0x3e,
 	.config_ctl_val = 0x4001075b,
@@ -129,6 +143,12 @@ struct apss_pll_data {
 	const struct alpha_pll_config *pll_config;
 };
 
+static const struct apss_pll_data ipq5018_pll_data = {
+	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
+	.pll = &ipq_pll_stromer_plus,
+	.pll_config = &ipq5018_pll_config,
+};
+
 static struct apss_pll_data ipq5332_pll_data = {
 	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
 	.pll = &ipq_pll_stromer_plus,
@@ -195,6 +215,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id apss_ipq_pll_match_table[] = {
+	{ .compatible = "qcom,ipq5018-a53pll", .data = &ipq5018_pll_data },
 	{ .compatible = "qcom,ipq5332-a53pll", .data = &ipq5332_pll_data },
 	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_data },
 	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_data },
-- 
2.34.1

