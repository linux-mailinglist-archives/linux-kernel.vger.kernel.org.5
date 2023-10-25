Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642937D6D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbjJYNem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344596AbjJYNek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:34:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7F9133;
        Wed, 25 Oct 2023 06:34:37 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PAxxgl007363;
        Wed, 25 Oct 2023 13:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0KnYWo9G5QtM2c/t3ahqFKcaENZGchGejX4b3wSMMmk=;
 b=KTt0vJ7F4INenKdH4UPFYQ2NUucCOjTk6ouaFjPXC8wJAHByiY+64z5Prt0alsEF9M+T
 aWthJehsFI2buKkvR26tjPc9FVYEiI/GWNej5VmubtCHDuHZP11wp2qmJtkNhDVAF9Pe
 bKHyXaXgOkHPkoiP75c2VxigT2ONDatvRRN+exA+R3iJJTpRO7eiXIyDtHDTWXmyN3vF
 hxBNMgANBAaIJIVjlrp7MDnsrnhHSB5WK6nyYp7B47Ph8hm0blTIZKupt6a9W/4f/etO
 +ALEJthd2exfk6hQ3ZaBxlF1SjRApNEkmDmCDe8KOPQJdhba/VxTD/kWE6/tHHWsn02i nA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txk9k9yyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:34:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PDYW4X000539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:34:32 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 06:34:27 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_tdas@quicinc.com>, <quic_rjendra@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>,
        <quic_tsoni@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 4/4] clk: qcom: rpmh: Add support for SC8380XP rpmh clocks
Date:   Wed, 25 Oct 2023 19:03:20 +0530
Message-ID: <20231025133320.4720-5-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025133320.4720-1-quic_sibis@quicinc.com>
References: <20231025133320.4720-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _kUp0FXrgfUBfJ72P0Blkc_VcsjW6dRl
X-Proofpoint-ORIG-GUID: _kUp0FXrgfUBfJ72P0Blkc_VcsjW6dRl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <quic_rjendra@quicinc.com>

Adds the RPMH clocks present in SC8380XP SoC

Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/clk/qcom/clk-rpmh.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 5d853fd43294..7f6d5f98957b 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -372,6 +372,9 @@ DEFINE_CLK_RPMH_VRM(clk3, _a1, "clka3", 1);
 DEFINE_CLK_RPMH_VRM(clk4, _a1, "clka4", 1);
 DEFINE_CLK_RPMH_VRM(clk5, _a1, "clka5", 1);
 
+DEFINE_CLK_RPMH_VRM(clk3, _a2, "clka3", 2);
+DEFINE_CLK_RPMH_VRM(clk4, _a2, "clka4", 2);
+DEFINE_CLK_RPMH_VRM(clk5, _a2, "clka5", 2);
 DEFINE_CLK_RPMH_VRM(clk6, _a2, "clka6", 2);
 DEFINE_CLK_RPMH_VRM(clk7, _a2, "clka7", 2);
 DEFINE_CLK_RPMH_VRM(clk8, _a2, "clka8", 2);
@@ -737,6 +740,28 @@ static const struct clk_rpmh_desc clk_rpmh_sm4450 = {
 	.num_clks = ARRAY_SIZE(sm4450_rpmh_clocks),
 };
 
+static struct clk_hw *sc8380xp_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
+	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
+	[RPMH_LN_BB_CLK1]	= &clk_rpmh_clk6_a2.hw,
+	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_clk6_a2_ao.hw,
+	[RPMH_LN_BB_CLK2]	= &clk_rpmh_clk7_a2.hw,
+	[RPMH_LN_BB_CLK2_A]	= &clk_rpmh_clk7_a2_ao.hw,
+	[RPMH_LN_BB_CLK3]	= &clk_rpmh_clk8_a2.hw,
+	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_clk8_a2_ao.hw,
+	[RPMH_RF_CLK3]		= &clk_rpmh_clk3_a2.hw,
+	[RPMH_RF_CLK3_A]	= &clk_rpmh_clk3_a2_ao.hw,
+	[RPMH_RF_CLK4]		= &clk_rpmh_clk4_a2.hw,
+	[RPMH_RF_CLK4_A]	= &clk_rpmh_clk4_a2_ao.hw,
+	[RPMH_RF_CLK5]		= &clk_rpmh_clk5_a2.hw,
+	[RPMH_RF_CLK5_A]	= &clk_rpmh_clk5_a2_ao.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sc8380xp = {
+	.clks = sc8380xp_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sc8380xp_rpmh_clocks),
+};
+
 static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
 					 void *data)
 {
@@ -825,6 +850,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sc7180-rpmh-clk", .data = &clk_rpmh_sc7180},
 	{ .compatible = "qcom,sc8180x-rpmh-clk", .data = &clk_rpmh_sc8180x},
 	{ .compatible = "qcom,sc8280xp-rpmh-clk", .data = &clk_rpmh_sc8280xp},
+	{ .compatible = "qcom,sc8380xp-rpmh-clk", .data = &clk_rpmh_sc8380xp},
 	{ .compatible = "qcom,sdm845-rpmh-clk", .data = &clk_rpmh_sdm845},
 	{ .compatible = "qcom,sdm670-rpmh-clk", .data = &clk_rpmh_sdm670},
 	{ .compatible = "qcom,sdx55-rpmh-clk",  .data = &clk_rpmh_sdx55},
-- 
2.17.1

