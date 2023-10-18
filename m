Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6880C7CD80D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjJRJbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjJRJah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:30:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E456113;
        Wed, 18 Oct 2023 02:30:33 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I3wbOe022734;
        Wed, 18 Oct 2023 09:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8dcB08kcJO6iB0NBMIQzk7pAa1CVxalHivEWlL+5XLo=;
 b=NskZ4cuMCkpds/pBU0zb6OCEX3dzw1/J/i72aPzzwVH8eJQFQW4r1umPOKth8MKCkoyk
 NvORDFMlGJ/At43gMwcQ/3dmePdEIuHY1bm08N0/9sa71IGT/FcTnjbH028+GcG42hPB
 zqZjG6FZpEXzSGjxcbNr8v1EWku6l1NnZ4ZhR3TEZyiaV8dEe45hlqD/TsJ+roCRpHWE
 xp28g4EVzx2YNTzNN89UMceM5SwC3itqiGgvdI6SpHB5xMCM/1c54VZu9P643cjTe4By
 BMrgXTvLBjTeN8NpXIw+CLDLSKj18OXxKc6sRt5U9DOoZ85V7gP75uycY1rk+quanJHq IA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsv0v2ah6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 09:30:29 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39I9USkd025830
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 09:30:28 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 18 Oct 2023 02:30:22 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 1/8] clk: qcom: clk-alpha-pll: introduce stromer plus ops
Date:   Wed, 18 Oct 2023 14:59:14 +0530
Message-ID: <248c5ad76abad07b2c710c5c561d4e37a099bd36.1697600121.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1697600121.git.quic_varada@quicinc.com>
References: <cover.1697600121.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eR-2lTsYPfFkvuEeTmlIylXnyidkP_lB
X-Proofpoint-GUID: eR-2lTsYPfFkvuEeTmlIylXnyidkP_lB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_07,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stromer plus APSS PLL does not support dynamic frequency scaling.
To switch between frequencies, we have to shut down the PLL,
configure the L and ALPHA values and turn on again. So introduce the
separate set of ops for Stromer Plus PLL.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3:	Use prepare/unprepare instead of disable/enable in clk_alpha_pll_stromer_plus_ops
v2:	Use clk_alpha_pll_stromer_determine_rate, instead of adding new
	clk_alpha_pll_stromer_plus_determine_rate as the alpha pll width
	is same for both

	Fix review comments
		udelay(50) -> usleep_range(50, 60)
		Remove SoC-specific from print message
---
 drivers/clk/qcom/clk-alpha-pll.c | 57 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 2 files changed, 58 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 4edbf77..f839a31 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2508,3 +2508,60 @@ const struct clk_ops clk_alpha_pll_stromer_ops = {
 	.set_rate = clk_alpha_pll_stromer_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_ops);
+
+static int clk_alpha_pll_stromer_plus_set_rate(struct clk_hw *hw,
+					       unsigned long rate,
+					       unsigned long prate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l, alpha_width = pll_alpha_width(pll);
+	int ret;
+	u64 a;
+
+	rate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
+
+	regmap_write(pll->clkr.regmap, PLL_MODE(pll), 0);
+
+	/* Delay of 2 output clock ticks required until output is disabled */
+	udelay(1);
+
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+
+	if (alpha_width > ALPHA_BITWIDTH)
+		a <<= alpha_width - ALPHA_BITWIDTH;
+
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
+					a >> ALPHA_BITWIDTH);
+
+	regmap_write(pll->clkr.regmap, PLL_MODE(pll), PLL_BYPASSNL);
+
+	/* Wait five micro seconds or more */
+	udelay(5);
+	regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_RESET_N,
+			   PLL_RESET_N);
+
+	/* The lock time should be less than 50 micro seconds worst case */
+	usleep_range(50, 60);
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret) {
+		pr_err("Wait for PLL enable lock failed [%s] %d\n",
+		       clk_hw_get_name(hw), ret);
+		return ret;
+	}
+	regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_OUTCTRL,
+			   PLL_OUTCTRL);
+
+	return 0;
+}
+
+const struct clk_ops clk_alpha_pll_stromer_plus_ops = {
+	.prepare = clk_alpha_pll_enable,
+	.unprepare = clk_alpha_pll_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = clk_alpha_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_stromer_determine_rate,
+	.set_rate = clk_alpha_pll_stromer_plus_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_plus_ops);
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 3b24a66..a1a75bb 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -152,6 +152,7 @@ extern const struct clk_ops clk_alpha_pll_postdiv_ops;
 extern const struct clk_ops clk_alpha_pll_huayra_ops;
 extern const struct clk_ops clk_alpha_pll_postdiv_ro_ops;
 extern const struct clk_ops clk_alpha_pll_stromer_ops;
+extern const struct clk_ops clk_alpha_pll_stromer_plus_ops;
 
 extern const struct clk_ops clk_alpha_pll_fabia_ops;
 extern const struct clk_ops clk_alpha_pll_fixed_fabia_ops;
-- 
2.7.4

