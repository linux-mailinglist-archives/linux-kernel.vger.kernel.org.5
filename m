Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513FB78F8D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348442AbjIAHBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjIAHBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:01:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A5810D2;
        Fri,  1 Sep 2023 00:01:08 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3816jjNM025707;
        Fri, 1 Sep 2023 07:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=0s1KoKJXAdqEKQ2U/kIybBGFtL0ncrGc0fZEPUE9J5Y=;
 b=VvbjbWkAP0sWP+6xjHbtLnZHcNWZOCdYSekqd9rGq0oCEG9Mh+SyOZtB7Cvb5ZQrG4el
 AM/I5JkaCcicoBGVS5BwZncFqfNP3ehjH9HjtL9EQMzsQL6B4GkGtI68OXupK0Ne+IyK
 b89BN3e8lHAY8XYn64Wvk6ek945qOqfQ8pQS/x84SSw1L9laO91+1aKwFvColpzcgTtP
 OGOXLhHgZhmSihx5l0bpNIgWR8sUXJIdAIAcSKR+oloFEQ5Gv3j7meBUOctNAWUz1DLG
 JF5xgbzGgotpxmbtViLKknw5nEy3vrBVxgy9u6PTjuPMhG8N2iJQtrCtGNegse7ABxar AQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stub8affy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 07:00:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38170w9a004213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 07:00:58 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 1 Sep 2023 00:00:54 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_devipriy@quicinc.com>, <quic_saahtoma@quicinc.com>
Subject: [PATCH V2] clk: qcom: clk-alpha-pll: Use determine_rate instead of round_rate
Date:   Fri, 1 Sep 2023 12:30:41 +0530
Message-ID: <20230901070041.13463-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 34r5av10KtpiWSnWc5rlyYle0whaXiev
X-Proofpoint-ORIG-GUID: 34r5av10KtpiWSnWc5rlyYle0whaXiev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_04,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The round_rate() API returns a long value as the errors are reported using
negative error codes. This leads to long overflow when the clock rate
exceeds 2GHz.As the clock controller treats the clock rate above signed
long max as an error, use determine_rate in place of round_rate as the
determine_rate API does not possess such limitations.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V2:
	- Updated divider_round_rate to divider_determine_rate as 
	  suggested by Stephen Boyd.

 drivers/clk/qcom/clk-alpha-pll.c | 125 +++++++++++++++++--------------
 1 file changed, 68 insertions(+), 57 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 1c2a72840cd2..de2b7e2784ec 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -756,22 +756,24 @@ static int clk_alpha_pll_hwfsm_set_rate(struct clk_hw *hw, unsigned long rate,
 					clk_alpha_pll_hwfsm_is_enabled);
 }
 
-static long clk_alpha_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *prate)
+static int clk_alpha_pll_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l, alpha_width = pll_alpha_width(pll);
 	u64 a;
 	unsigned long min_freq, max_freq;
 
-	rate = alpha_pll_round_rate(rate, *prate, &l, &a, alpha_width);
-	if (!pll->vco_table || alpha_pll_find_vco(pll, rate))
-		return rate;
+	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate,
+					 &l, &a, alpha_width);
+	if (!pll->vco_table || alpha_pll_find_vco(pll, req->rate))
+		return 0;
 
 	min_freq = pll->vco_table[0].min_freq;
 	max_freq = pll->vco_table[pll->num_vco - 1].max_freq;
 
-	return clamp(rate, min_freq, max_freq);
+	req->rate = clamp(req->rate, min_freq, max_freq);
+	return 0;
 }
 
 static unsigned long
@@ -918,12 +920,15 @@ static int alpha_pll_huayra_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static long alpha_pll_huayra_round_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long *prate)
+static int alpha_pll_huayra_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	u32 l, a;
 
-	return alpha_huayra_pll_round_rate(rate, *prate, &l, &a);
+	req->rate = alpha_huayra_pll_round_rate(req->rate,
+						req->best_parent_rate,
+						&l, &a);
+	return 0;
 }
 
 static int trion_pll_is_enabled(struct clk_alpha_pll *pll,
@@ -1042,7 +1047,7 @@ const struct clk_ops clk_alpha_pll_ops = {
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = clk_alpha_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_alpha_pll_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_ops);
@@ -1052,7 +1057,7 @@ const struct clk_ops clk_alpha_pll_huayra_ops = {
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = alpha_pll_huayra_recalc_rate,
-	.round_rate = alpha_pll_huayra_round_rate,
+	.determine_rate = alpha_pll_huayra_determine_rate,
 	.set_rate = alpha_pll_huayra_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_huayra_ops);
@@ -1062,7 +1067,7 @@ const struct clk_ops clk_alpha_pll_hwfsm_ops = {
 	.disable = clk_alpha_pll_hwfsm_disable,
 	.is_enabled = clk_alpha_pll_hwfsm_is_enabled,
 	.recalc_rate = clk_alpha_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_alpha_pll_hwfsm_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_hwfsm_ops);
@@ -1072,7 +1077,7 @@ const struct clk_ops clk_alpha_pll_fixed_trion_ops = {
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_trion_ops);
 
@@ -1106,9 +1111,8 @@ static const struct clk_div_table clk_alpha_2bit_div_table[] = {
 	{ }
 };
 
-static long
-clk_alpha_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *prate)
+static int clk_alpha_pll_postdiv_determine_rate(struct clk_hw *hw,
+						struct clk_rate_request *req)
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 	const struct clk_div_table *table;
@@ -1118,13 +1122,13 @@ clk_alpha_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
 	else
 		table = clk_alpha_div_table;
 
-	return divider_round_rate(hw, rate, prate, table,
-				  pll->width, CLK_DIVIDER_POWER_OF_TWO);
+	req->rate = divider_determine_rate(hw, req, table,
+					   pll->width, CLK_DIVIDER_POWER_OF_TWO);
+	return 0;
 }
 
-static long
-clk_alpha_pll_postdiv_round_ro_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *prate)
+static int clk_alpha_pll_postdiv_determine_ro_rate(struct clk_hw *hw,
+						   struct clk_rate_request *req)
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 	u32 ctl, div;
@@ -1136,9 +1140,11 @@ clk_alpha_pll_postdiv_round_ro_rate(struct clk_hw *hw, unsigned long rate,
 	div = 1 << fls(ctl);
 
 	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)
-		*prate = clk_hw_round_rate(clk_hw_get_parent(hw), div * rate);
+		req->best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
+							  div * req->rate);
+	req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
 
-	return DIV_ROUND_UP_ULL((u64)*prate, div);
+	return 0;
 }
 
 static int clk_alpha_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1157,13 +1163,13 @@ static int clk_alpha_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 
 const struct clk_ops clk_alpha_pll_postdiv_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_determine_rate,
 	.set_rate = clk_alpha_pll_postdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_ro_ops = {
-	.round_rate = clk_alpha_pll_postdiv_round_ro_rate,
+	.determine_rate = clk_alpha_pll_postdiv_determine_ro_rate,
 	.recalc_rate = clk_alpha_pll_postdiv_recalc_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_ro_ops);
@@ -1405,7 +1411,7 @@ const struct clk_ops clk_alpha_pll_fabia_ops = {
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.set_rate = alpha_pll_fabia_set_rate,
 	.recalc_rate = alpha_pll_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fabia_ops);
 
@@ -1414,7 +1420,7 @@ const struct clk_ops clk_alpha_pll_fixed_fabia_ops = {
 	.disable = alpha_pll_fabia_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = alpha_pll_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_fabia_ops);
 
@@ -1464,14 +1470,15 @@ clk_trion_pll_postdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return (parent_rate / div);
 }
 
-static long
-clk_trion_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *prate)
+static int
+clk_trion_pll_postdiv_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 
-	return divider_round_rate(hw, rate, prate, pll->post_div_table,
-				  pll->width, CLK_DIVIDER_ROUND_CLOSEST);
+	req->rate = divider_determine_rate(hw, req, pll->post_div_table, pll->width,
+					   CLK_DIVIDER_ROUND_CLOSEST);
+	return 0;
 };
 
 static int
@@ -1497,18 +1504,20 @@ clk_trion_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 
 const struct clk_ops clk_alpha_pll_postdiv_trion_ops = {
 	.recalc_rate = clk_trion_pll_postdiv_recalc_rate,
-	.round_rate = clk_trion_pll_postdiv_round_rate,
+	.determine_rate = clk_trion_pll_postdiv_determine_rate,
 	.set_rate = clk_trion_pll_postdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_trion_ops);
 
-static long clk_alpha_pll_postdiv_fabia_round_rate(struct clk_hw *hw,
-				unsigned long rate, unsigned long *prate)
+static int
+clk_alpha_pll_postdiv_fabia_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 
-	return divider_round_rate(hw, rate, prate, pll->post_div_table,
-				pll->width, CLK_DIVIDER_ROUND_CLOSEST);
+	req->rate = divider_determine_rate(hw, req, pll->post_div_table, pll->width,
+					   CLK_DIVIDER_ROUND_CLOSEST);
+	return 0;
 }
 
 static int clk_alpha_pll_postdiv_fabia_set_rate(struct clk_hw *hw,
@@ -1543,7 +1552,7 @@ static int clk_alpha_pll_postdiv_fabia_set_rate(struct clk_hw *hw,
 
 const struct clk_ops clk_alpha_pll_postdiv_fabia_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_alpha_pll_postdiv_fabia_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_fabia_ops);
@@ -1695,7 +1704,7 @@ const struct clk_ops clk_alpha_pll_trion_ops = {
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_trion_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_trion_ops);
@@ -1706,14 +1715,14 @@ const struct clk_ops clk_alpha_pll_lucid_ops = {
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_trion_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_alpha_pll_postdiv_fabia_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_ops);
@@ -1765,7 +1774,7 @@ const struct clk_ops clk_alpha_pll_agera_ops = {
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = alpha_pll_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_alpha_pll_agera_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_agera_ops);
@@ -1930,7 +1939,7 @@ const struct clk_ops clk_alpha_pll_lucid_5lpe_ops = {
 	.disable = alpha_pll_lucid_5lpe_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_lucid_5lpe_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_5lpe_ops);
@@ -1940,13 +1949,13 @@ const struct clk_ops clk_alpha_pll_fixed_lucid_5lpe_ops = {
 	.disable = alpha_pll_lucid_5lpe_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_5lpe_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_5lpe_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_lucid_5lpe_pll_postdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_5lpe_ops);
@@ -2099,7 +2108,7 @@ const struct clk_ops clk_alpha_pll_zonda_ops = {
 	.disable = clk_zonda_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_zonda_pll_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_zonda_ops);
@@ -2289,13 +2298,13 @@ const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops = {
 	.disable = alpha_pll_lucid_evo_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_evo_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_lucid_evo_pll_postdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_evo_ops);
@@ -2306,7 +2315,7 @@ const struct clk_ops clk_alpha_pll_lucid_evo_ops = {
 	.disable = alpha_pll_lucid_evo_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_lucid_5lpe_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_evo_ops);
@@ -2317,7 +2326,7 @@ const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops = {
 	.disable = alpha_pll_reset_lucid_evo_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_lucid_5lpe_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_reset_lucid_evo_ops);
@@ -2353,22 +2362,24 @@ static unsigned long clk_rivian_evo_pll_recalc_rate(struct clk_hw *hw,
 	return parent_rate * l;
 }
 
-static long clk_rivian_evo_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-					  unsigned long *prate)
+static int clk_rivian_evo_pll_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	unsigned long min_freq, max_freq;
 	u32 l;
 	u64 a;
 
-	rate = alpha_pll_round_rate(rate, *prate, &l, &a, 0);
-	if (!pll->vco_table || alpha_pll_find_vco(pll, rate))
-		return rate;
+	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate,
+					 &l, &a, 0);
+	if (!pll->vco_table || alpha_pll_find_vco(pll, req->rate))
+		return 0;
 
 	min_freq = pll->vco_table[0].min_freq;
 	max_freq = pll->vco_table[pll->num_vco - 1].max_freq;
 
-	return clamp(rate, min_freq, max_freq);
+	req->rate = clamp(req->rate, min_freq, max_freq);
+	return 0;
 }
 
 const struct clk_ops clk_alpha_pll_rivian_evo_ops = {
@@ -2376,7 +2387,7 @@ const struct clk_ops clk_alpha_pll_rivian_evo_ops = {
 	.disable = alpha_pll_lucid_5lpe_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_rivian_evo_pll_recalc_rate,
-	.round_rate = clk_rivian_evo_pll_round_rate,
+	.determine_rate = clk_rivian_evo_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_rivian_evo_ops);
 
-- 
2.34.1

