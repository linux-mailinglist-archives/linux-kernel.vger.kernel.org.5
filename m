Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968F17CF2EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjJSIlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjJSIlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:41:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F810134;
        Thu, 19 Oct 2023 01:41:43 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J7skbK008047;
        Thu, 19 Oct 2023 08:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6A8Rw+sbRT4V2/G0ENUVH19WTb2WHsVjktF1KZ9Gls0=;
 b=eyvnfGJFqSP0jbiHaHm5yGavGTb0Ft+q5piRQ++Q96ya5nwGrUWUkV9Vm3Uj1fmBglIk
 wj7pkcNVaef2wyCNmucXQpjI42f9vXBev37Ao6rDEKTcML2Ic/8I+cIvC2coKw7xzvgj
 ++5G64wDjBXF9aRY3C+/j+kHYbMbFfi0lkvJWvrqv/sCeAkagerPOqqJuMLUs9lVpnxQ
 KIFsAJN2NmAXaUUHDSHNQektBWVgtIYL4ZYcTJIzp6Glj5T6Wu9Vm1laGZjOlYTC9FKa
 E0Xp2C6meDWvXYz4Hi+CnyXh893lCOWG+1BzbE/sLiFHKqbn61AGgx5p3KHRCgCnujfV sA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt8xsb9g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:41:09 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J8f87G002666
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:41:08 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 01:41:02 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <sivaprak@codeaurora.org>, <quic_kathirav@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v4 2/9] clk: qcom: clk-alpha-pll: introduce stromer plus ops
Date:   Thu, 19 Oct 2023 14:10:36 +0530
Message-ID: <5e1c2ff9522dd29e69f286dbbe1c867433763629.1697694811.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1697694811.git.quic_varada@quicinc.com>
References: <cover.1697694811.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SDiaI6DgQmsOvR0_atcnfAxEgddElr9o
X-Proofpoint-ORIG-GUID: SDiaI6DgQmsOvR0_atcnfAxEgddElr9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_06,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310190072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
v4:	Ensure PLL is enabled before re-enabling
v3:	Use prepare/unprepare instead of disable/enable in clk_alpha_pll_stromer_plus_ops
v2:	Use clk_alpha_pll_stromer_determine_rate, instead of adding new
	clk_alpha_pll_stromer_plus_determine_rate as the alpha pll width
	is same for both

	Fix review comments
		udelay(50) -> usleep_range(50, 60)
		Remove SoC-specific from print message
---
 drivers/clk/qcom/clk-alpha-pll.c | 63 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 2 files changed, 64 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 4edbf77..05898d2 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2508,3 +2508,66 @@ const struct clk_ops clk_alpha_pll_stromer_ops = {
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
+	int ret, pll_mode;
+	u64 a;
+
+	rate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
+
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &pll_mode);
+	if (ret)
+		return ret;
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
+
+	if (pll_mode & PLL_OUTCTRL)
+		regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_OUTCTRL,
+				   PLL_OUTCTRL);
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

