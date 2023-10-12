Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706C57C697C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjJLJ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjJLJ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:27:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE82A9D;
        Thu, 12 Oct 2023 02:27:08 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C6PFCE001983;
        Thu, 12 Oct 2023 09:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=lVxSiWUvHrC7msJ4yZC1IngY35ovVoWwT2jCdn3l9WY=;
 b=ofMt6Zrl5BfDy+rLPsOXDgY03EjRz0rXNE2hdQmgXviyz9xKTW77tx4/Ag5dNTElA3OM
 co8IJ1SJMR+DGGslZ+ilSA2ie8EXsBc28VBDPcbX71Xd/oykCTsLzx2P21z5FOjismma
 QdxG5zsGlCx/guGLwxzthHgNllTZSlctOCrg3CgGxa2AGyu3I0bDx7GrRfAxMehW5b1G
 wvrS5MfAUPMeF9DwuwLgufnMP8yaJHl9Afx5Tyki7siOm0P+sjbHSByPvGaQ40HqvE+4
 nKFftHsPmMdr0zeZQtR2heKHh/OtpHcIOtOgIi6mNOuQZw29oTCt5nOpMiLTTphtDEqx FQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tp0vw9q1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 09:27:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39C9R3dj000737
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 09:27:03 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 12 Oct 2023 02:26:57 -0700
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
Subject: [PATCH v2 1/8] clk: qcom: clk-alpha-pll: introduce stromer plus ops
Date:   Thu, 12 Oct 2023 14:56:17 +0530
Message-ID: <8f578277cc015cfe9cdca06586b2c82f1a728bad.1697101543.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1697101543.git.quic_varada@quicinc.com>
References: <cover.1697101543.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cd-XnR9iELjyN1gX0PKF5KVkkLo9ictp
X-Proofpoint-ORIG-GUID: cd-XnR9iELjyN1gX0PKF5KVkkLo9ictp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxlogscore=999
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 4edbf77..5221b6c 100644
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
+	.enable = clk_alpha_pll_enable,
+	.disable = clk_alpha_pll_disable,
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

