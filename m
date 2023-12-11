Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5195180BFFA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjLKDiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 22:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjLKDiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 22:38:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0885F1;
        Sun, 10 Dec 2023 19:38:10 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB3KBfk011859;
        Mon, 11 Dec 2023 03:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:date:subject:mime-version:content-type
        :content-transfer-encoding:message-id:references:in-reply-to:to
        :cc; s=qcppdkim1; bh=OFIyZUELma5elx840cpyHkVfuPRcMvTtbu13rPmqMc8
        =; b=eeuoPikgbcqlReZp4ZrLevmhGG/geHsCwdXJ76V1azTSBHOPcDSAN5/mfQW
        VIvL4KONqkT0Ih7oQEGkaGEzQnNYmvYrq+VUmKkwdysPS7xuXy+lA6AOZjRjMtvV
        VjFtokQPMW7fhytR/XCkrB5GJem+bF5LC2x8GCibYD3ydmzl23zGHJpqZJgw7g2D
        4/Z8EbswV/gTocwnr15zd7LpkLvvCxyU4IqsOnZaffu5of2gvQ9IlRk3Lms4vtzO
        mevMHxc++vMr+No9iqUNSUzqLp5SA1eQsCXhZtPn9I0CKfsA8sqKtgoPXJImNd+A
        RPUWuZp7ZgJ+WX6DETUVnFfEPIg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnfja5s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 03:38:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB3c0VQ012577
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 03:38:00 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 10 Dec 2023 19:37:53 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Mon, 11 Dec 2023 09:07:26 +0530
Subject: [PATCH v3 4/8] clk: qcom: ipq5332: add gpll0_out_aux clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231211-ipq5332-nsscc-v3-4-ad13bef9b137@quicinc.com>
References: <20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com>
In-Reply-To: <20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702265852; l=1518;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=DyKCjY0eO5znBwgEYWVDto1DUhSsK4/xk7MoI73Ei5Q=;
 b=F5asOI9dSH9q43jBAOLaMl0LEE8xFu54hWTe5jXuVD8wu2/z5cKGRgCMWFJj0v6YWn7OTT4ws
 iqs1wlMOmaGDhdzxWK1kHqP28TaVQ0quCGY5tM1Xg91plBoHVZrnxyO
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vGmoBzK8AblYyzRmFNgni_Il2cEfoPH-
X-Proofpoint-GUID: vGmoBzK8AblYyzRmFNgni_Il2cEfoPH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for gpll0_out_aux clock which acts as the parent for
certain networking subsystem (NSS) clocks.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index 38a570b68813..9a5f0c98f734 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -87,6 +87,19 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 	},
 };
 
+static struct clk_alpha_pll_postdiv gpll0_out_aux = {
+	.offset = 0x20000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gpll0_out_aux",
+		.parent_hws = (const struct clk_hw *[]) {
+				&gpll0_main.clkr.hw },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_ro_ops,
+	},
+};
+
 static struct clk_alpha_pll gpll2_main = {
 	.offset = 0x21000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
@@ -3393,6 +3406,7 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_PCIE3X1_0_PIPE_CLK_SRC] = &gcc_pcie3x1_0_pipe_clk_src.clkr,
 	[GCC_PCIE3X1_1_PIPE_CLK_SRC] = &gcc_pcie3x1_1_pipe_clk_src.clkr,
 	[GCC_USB0_PIPE_CLK_SRC] = &gcc_usb0_pipe_clk_src.clkr,
+	[GPLL0_OUT_AUX] = &gpll0_out_aux.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq5332_resets[] = {

-- 
2.34.1

