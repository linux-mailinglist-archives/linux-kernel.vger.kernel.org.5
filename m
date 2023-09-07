Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486A3796FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbjIGFWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjIGFWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:22:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770891BC5;
        Wed,  6 Sep 2023 22:22:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38738qUS012005;
        Thu, 7 Sep 2023 05:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=DBvi+znXVTyvRW1anBO+yVoE96wgVq5YWLAax696RCs=;
 b=UUh4AMomW2EChFuI+votbPDAdJEPY2YBJ59WQBnGYUCnkYZglnZdrGVGjIr/AbUT0l0p
 w8wnQXWU/1VPBIQV1MMWs5vgSe4cz8Qt/2fu3Jff+3/rg93Ejsg43uLiIZeFYH37j7Z0
 ev1GDqqkaUwS0C0f8XUI97LexQwysuIt0ZUa4QnSZKAGPG+pWU0Jqdx4QIjTr8woy3r2
 3e0rU74hjk65GUVj04RE5jCkzSkU6lJhm0mVNGHdf4x3RTNaK2XSVDrbZ46dL8HvU7Jc
 DgEIvKFhCy+2bDMLZ3chmQ7hqnNJfOnd7OQVYEeA+LGHFmuqWV97JQkJjJeLIQB+ChNC iA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxhjfbgfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 05:22:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3875M5na015952
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 05:22:06 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 6 Sep 2023 22:22:00 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <ilia.lin@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_kathirav@quicinc.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v1 01/10] clk: qcom: clk-alpha-pll: introduce stromer plus ops
Date:   Thu, 7 Sep 2023 10:51:36 +0530
Message-ID: <18a3bc0c5b371deec5c4bbe6ceacf8afcf0bc640.1693996662.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1693996662.git.quic_varada@quicinc.com>
References: <cover.1693996662.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bdHQs9uihQXalMNezh8J19laSPu-3N69
X-Proofpoint-GUID: bdHQs9uihQXalMNezh8J19laSPu-3N69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070045
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/clk/qcom/clk-alpha-pll.c | 68 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 2 files changed, 69 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index e4ef645..2ef81f7 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2479,3 +2479,71 @@ const struct clk_ops clk_alpha_pll_stromer_ops = {
 	.set_rate = clk_alpha_pll_stromer_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_ops);
+
+static int clk_alpha_pll_stromer_plus_determine_rate(struct clk_hw *hw,
+						     struct clk_rate_request *req)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l, alpha_width = pll_alpha_width(pll);
+	u64 a;
+
+	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate, &l,
+					 &a, alpha_width);
+	return 0;
+}
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
+	udelay(50);
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret) {
+		pr_err("alpha pll running in 800 MHz with source GPLL0\n");
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
+	.determine_rate = clk_alpha_pll_stromer_plus_determine_rate,
+	.set_rate = clk_alpha_pll_stromer_plus_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_plus_ops);
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index e4bd863..903fbab 100644
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

