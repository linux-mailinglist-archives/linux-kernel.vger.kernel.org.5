Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3BF78C1D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjH2JzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbjH2JzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:55:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB44E9;
        Tue, 29 Aug 2023 02:55:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T5F23c026274;
        Tue, 29 Aug 2023 09:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=tz/64Cre2cszQKqlQL+wp86MwBS9O59TEJLGoZ+NmY8=;
 b=I/uJt6bfJ1ftAJgxAW+VEc9zZwGlCA9Rw7b+scr95Smiq4yLgesARIz1YV4H1Y1+nqlU
 7KwVDczIqdZtH1iItkV+F2jQLUwDn5AIzflt+hVPYpfsIwe3YgloK5OOrgSZwV5KZuAF
 SwH+AosVMB2u7Knqo9JonXG0upbix6QgYm0Wkr41L4fJ1GbQtcr1x9Eqd/RbL1nvOPk6
 YeUtFTYgVwjGO7Ju7a592mh/cll5dTEFa7Sn/77RfukKWFON8MnKuJPqdsqFPUtzrU/p
 EoU3/7iKDgUSCs9QSJk47KloMPHmiB8fAf7GrPsKKmSJXpbBkk2JXqDJ5BPiqLDpOMVH 2A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srt8s2nv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 09:54:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T9spwT027569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 09:54:51 GMT
Received: from hu-gokulsri-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 02:54:46 -0700
From:   Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>
Subject: [PATCH 2/3] clk: qcom: apss-ipq-pll: add support for IPQ5018
Date:   Tue, 29 Aug 2023 15:24:22 +0530
Message-ID: <20230829095423.760641-3-quic_gokulsri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
References: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5IrPlptDTNIcBLmgG2YCeyT_ekiCtVHp
X-Proofpoint-GUID: 5IrPlptDTNIcBLmgG2YCeyT_ekiCtVHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_06,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 APSS PLL is of type Stromer. Add support for Stromer PLL,
configuration values and the compatible.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
---
 drivers/clk/qcom/apss-ipq-pll.c | 52 ++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index e170331858cc..bbc25d5eb70d 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -24,6 +24,17 @@ static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_TEST_CTL] = 0x30,
 		[PLL_OFF_TEST_CTL_U] = 0x34,
 	},
+	[CLK_ALPHA_PLL_TYPE_STROMER] = {
+		[PLL_OFF_L_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL_U] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_STATUS] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x30,
+		[PLL_OFF_TEST_CTL_U] = 0x34,
+	},
 	[CLK_ALPHA_PLL_TYPE_STROMER_PLUS] = {
 		[PLL_OFF_L_VAL] = 0x08,
 		[PLL_OFF_ALPHA_VAL] = 0x10,
@@ -73,6 +84,38 @@ static struct clk_alpha_pll ipq_pll_stromer_plus = {
 	},
 };
 
+static struct clk_alpha_pll ipq_pll_stromer = {
+	.offset = 0x0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER],
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.clkr = {
+		.enable_reg = 0x0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "a53pll",
+			.parent_data = &(const struct clk_parent_data) {
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_stromer_ops,
+		},
+	},
+};
+
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
@@ -129,6 +172,12 @@ struct apss_pll_data {
 	const struct alpha_pll_config *pll_config;
 };
 
+static struct apss_pll_data ipq5018_pll_data = {
+	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER,
+	.pll = &ipq_pll_stromer,
+	.pll_config = &ipq5018_pll_config,
+};
+
 static struct apss_pll_data ipq5332_pll_data = {
 	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
 	.pll = &ipq_pll_stromer_plus,
@@ -183,7 +232,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 
 	if (data->pll_type == CLK_ALPHA_PLL_TYPE_HUAYRA)
 		clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
-	else if (data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER_PLUS)
+	else
 		clk_stromer_pll_configure(data->pll, regmap, data->pll_config);
 
 	ret = devm_clk_register_regmap(dev, &data->pll->clkr);
@@ -195,6 +244,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id apss_ipq_pll_match_table[] = {
+	{ .compatible = "qcom,ipq5018-a53pll", .data = &ipq5018_pll_data },
 	{ .compatible = "qcom,ipq5332-a53pll", .data = &ipq5332_pll_data },
 	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_data },
 	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_data },
-- 
2.34.1

