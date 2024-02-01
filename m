Return-Path: <linux-kernel+bounces-47760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4C4845271
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DAB1C26663
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA171159590;
	Thu,  1 Feb 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WoqFiyUJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D35159568;
	Thu,  1 Feb 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774948; cv=none; b=kpUZDtKkhLFXjJQ7acGIuZqzenhut5q/oLdSfUtjCDXgRvUZ80JIG7ldUw7zGsr1wmv7uXMjKAzvbuzb2+Dn0BMpJPefjuyLX8HOrXwdNwf5ffo4/McDF1ZXuD1gN1vIaWd3eTZxaeO0PHV4+LDmgz7VaIqRrFFAjzhPPy1Paas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774948; c=relaxed/simple;
	bh=bNaaw6weDoxuJGgs/D2zS/Yz2LMh5KhRX2yGIaDHjq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=kYhScEUxQrfRMP4kgqaPibCXd3RfIBEyskiqkOApajgnF/0Sgaa0GV4OdRyjvUluu0xeF/e74QoxRd1O9Wv55FXRiNfMVkJdsOz30sJohtMYWkIuZKB7wEY9dpPNphihTfL4XxPglzDkOWOCc+o7NCloeofvFcuGj/iWxiwzH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WoqFiyUJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4117xYOE015997;
	Thu, 1 Feb 2024 08:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=VDe
	tp2VtMJxskVkbo0GgvFsL//uLNezv1pGOaHuilrc=; b=WoqFiyUJQDOlTDvrDIJ
	1vh2dnO6RvgCpPCjMtbqDgZ23xcHmBbLKXT8bj3ITNS0I0P+LUDhRHORhiopRREj
	zZ2t/IvGry9T4JgQyRH7xkJSOVNycr20UGmdhd3PT71pZQwot6DwWSRCLE8F2H/S
	0Ix/hLU0Qf67SSdGun+UenqO+4rVIIrHAGR+2XsIP6OAbzRWIfgY8bCV8o+zP04v
	Z3meYon9yiqxk85N9QdGZx+JSI+9Ja4qQ3tC9+kJtRn7441jrBJvxNmbXmN97Tww
	qTJ5rr6+sS4igUyWc13pygThY+1wb7Z0VJ4ITVC/B2zWdnn3LCgCN9/BREsJvnut
	RKg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vypaq2gmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 08:08:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41188l7N019935
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 08:08:47 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 00:08:44 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Thu, 1 Feb 2024 13:38:28 +0530
Subject: [PATCH] clk: qcom: dispcc-sm8250: Make clk_init_data and pll_vco
 const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240201-dispcc-sm8150-v1-1-cbeb89015e5d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHtRu2UC/x3MQQqAIBBA0avIrBNUNKSrRItwpppFJg5EIN09a
 fkW/zcQqkwCk2pQ6WbhK3fYQUE61ryTZuwGZ5w3zliNLCUlLWe0wegQCXFMnmxA6E2ptPHz/+b
 lfT/JPLBWXwAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rWxEnv4ImJKAS8z2fsm8MqfBO3ix9j_P
X-Proofpoint-GUID: rWxEnv4ImJKAS8z2fsm8MqfBO3ix9j_P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=628 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010065

The clk_init_data and pll_vco structures are never modified, make
them const.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 drivers/clk/qcom/dispcc-sm8250.c | 118 +++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index e17bb8b543b5..7a042beb4bfa 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -39,11 +39,11 @@ enum {
 	P_DSI1_PHY_PLL_OUT_DSICLK,
 };
 
-static struct pll_vco vco_table[] = {
+static const struct pll_vco vco_table[] = {
 	{ 249600000, 2000000000, 0 },
 };
 
-static struct pll_vco lucid_5lpe_vco[] = {
+static const struct pll_vco lucid_5lpe_vco[] = {
 	{ 249600000, 1750000000, 0 },
 };
 
@@ -214,7 +214,7 @@ static struct clk_rcg2 disp_cc_mdss_ahb_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
 	.freq_tbl = ftbl_disp_cc_mdss_ahb_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_ahb_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
@@ -233,7 +233,7 @@ static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_2,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_byte0_clk_src",
 		.parent_data = disp_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
@@ -247,7 +247,7 @@ static struct clk_rcg2 disp_cc_mdss_byte1_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_2,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_byte1_clk_src",
 		.parent_data = disp_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
@@ -262,7 +262,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_aux1_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_1,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dp_aux1_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
@@ -277,7 +277,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_1,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dp_aux_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
@@ -291,7 +291,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_link1_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dp_link1_clk_src",
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
@@ -304,7 +304,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dp_link_clk_src",
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
@@ -317,7 +317,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_pixel1_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dp_pixel1_clk_src",
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
@@ -330,7 +330,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_pixel2_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dp_pixel2_clk_src",
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
@@ -343,7 +343,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_pixel_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dp_pixel_clk_src",
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
@@ -357,7 +357,7 @@ static struct clk_rcg2 disp_cc_mdss_edp_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_1,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_edp_aux_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
@@ -372,7 +372,7 @@ static struct clk_rcg2 disp_cc_mdss_edp_gtc_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_7,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_edp_gtc_clk_src",
 		.parent_data = disp_cc_parent_data_7,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_7),
@@ -386,7 +386,7 @@ static struct clk_rcg2 disp_cc_mdss_edp_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_4,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_edp_link_clk_src",
 		.parent_data = disp_cc_parent_data_4,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
@@ -400,7 +400,7 @@ static struct clk_rcg2 disp_cc_mdss_edp_pixel_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_4,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_edp_pixel_clk_src",
 		.parent_data = disp_cc_parent_data_4,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
@@ -414,7 +414,7 @@ static struct clk_branch disp_cc_mdss_edp_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x2078,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_edp_aux_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_edp_aux_clk_src.clkr.hw,
@@ -432,7 +432,7 @@ static struct clk_branch disp_cc_mdss_edp_gtc_clk = {
 	.clkr = {
 		.enable_reg = 0x207c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_edp_gtc_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_edp_gtc_clk_src.clkr.hw,
@@ -450,7 +450,7 @@ static struct clk_branch disp_cc_mdss_edp_link_clk = {
 	.clkr = {
 		.enable_reg = 0x2070,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_edp_link_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_edp_link_clk_src.clkr.hw,
@@ -466,7 +466,7 @@ static struct clk_regmap_div disp_cc_mdss_edp_link_div_clk_src = {
 	.reg = 0x2288,
 	.shift = 0,
 	.width = 2,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_edp_link_div_clk_src",
 		.parent_hws = (const struct clk_hw*[]){
 			&disp_cc_mdss_edp_link_clk_src.clkr.hw,
@@ -482,7 +482,7 @@ static struct clk_branch disp_cc_mdss_edp_link_intf_clk = {
 	.clkr = {
 		.enable_reg = 0x2074,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_edp_link_intf_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_edp_link_div_clk_src.clkr.hw,
@@ -500,7 +500,7 @@ static struct clk_branch disp_cc_mdss_edp_pixel_clk = {
 	.clkr = {
 		.enable_reg = 0x206c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_edp_pixel_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_edp_pixel_clk_src.clkr.hw,
@@ -518,7 +518,7 @@ static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_2,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_esc0_clk_src",
 		.parent_data = disp_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
@@ -533,7 +533,7 @@ static struct clk_rcg2 disp_cc_mdss_esc1_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_2,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_esc1_clk_src",
 		.parent_data = disp_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
@@ -560,7 +560,7 @@ static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_5,
 	.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_mdp_clk_src",
 		.parent_data = disp_cc_parent_data_5,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
@@ -574,7 +574,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_6,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_pclk0_clk_src",
 		.parent_data = disp_cc_parent_data_6,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_6),
@@ -588,7 +588,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk1_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_6,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_pclk1_clk_src",
 		.parent_data = disp_cc_parent_data_6,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_6),
@@ -612,7 +612,7 @@ static struct clk_rcg2 disp_cc_mdss_rot_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_5,
 	.freq_tbl = ftbl_disp_cc_mdss_rot_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_rot_clk_src",
 		.parent_data = disp_cc_parent_data_5,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
@@ -627,7 +627,7 @@ static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_1,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_vsync_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
@@ -640,7 +640,7 @@ static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
 	.reg = 0x2128,
 	.shift = 0,
 	.width = 2,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_byte0_div_clk_src",
 		.parent_hws = (const struct clk_hw*[]){
 			&disp_cc_mdss_byte0_clk_src.clkr.hw,
@@ -655,7 +655,7 @@ static struct clk_regmap_div disp_cc_mdss_byte1_div_clk_src = {
 	.reg = 0x2144,
 	.shift = 0,
 	.width = 2,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_byte1_div_clk_src",
 		.parent_hws = (const struct clk_hw*[]){
 			&disp_cc_mdss_byte1_clk_src.clkr.hw,
@@ -665,12 +665,11 @@ static struct clk_regmap_div disp_cc_mdss_byte1_div_clk_src = {
 	},
 };
 
-
 static struct clk_regmap_div disp_cc_mdss_dp_link1_div_clk_src = {
 	.reg = 0x2224,
 	.shift = 0,
 	.width = 2,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dp_link1_div_clk_src",
 		.parent_hws = (const struct clk_hw*[]){
 			&disp_cc_mdss_dp_link1_clk_src.clkr.hw,
@@ -680,12 +679,11 @@ static struct clk_regmap_div disp_cc_mdss_dp_link1_div_clk_src = {
 	},
 };
 
-
 static struct clk_regmap_div disp_cc_mdss_dp_link_div_clk_src = {
 	.reg = 0x2190,
 	.shift = 0,
 	.width = 2,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dp_link_div_clk_src",
 		.parent_hws = (const struct clk_hw*[]){
 			&disp_cc_mdss_dp_link_clk_src.clkr.hw,
@@ -701,7 +699,7 @@ static struct clk_branch disp_cc_mdss_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x2080,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_ahb_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_ahb_clk_src.clkr.hw,
@@ -719,7 +717,7 @@ static struct clk_branch disp_cc_mdss_byte0_clk = {
 	.clkr = {
 		.enable_reg = 0x2028,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_byte0_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_byte0_clk_src.clkr.hw,
@@ -737,7 +735,7 @@ static struct clk_branch disp_cc_mdss_byte0_intf_clk = {
 	.clkr = {
 		.enable_reg = 0x202c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_byte0_intf_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_byte0_div_clk_src.clkr.hw,
@@ -755,7 +753,7 @@ static struct clk_branch disp_cc_mdss_byte1_clk = {
 	.clkr = {
 		.enable_reg = 0x2030,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_byte1_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_byte1_clk_src.clkr.hw,
@@ -773,7 +771,7 @@ static struct clk_branch disp_cc_mdss_byte1_intf_clk = {
 	.clkr = {
 		.enable_reg = 0x2034,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_byte1_intf_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_byte1_div_clk_src.clkr.hw,
@@ -791,7 +789,7 @@ static struct clk_branch disp_cc_mdss_dp_aux1_clk = {
 	.clkr = {
 		.enable_reg = 0x2068,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_dp_aux1_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_aux1_clk_src.clkr.hw,
@@ -809,7 +807,7 @@ static struct clk_branch disp_cc_mdss_dp_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x2054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_dp_aux_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_aux_clk_src.clkr.hw,
@@ -827,7 +825,7 @@ static struct clk_branch disp_cc_mdss_dp_link1_clk = {
 	.clkr = {
 		.enable_reg = 0x205c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_dp_link1_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_link1_clk_src.clkr.hw,
@@ -845,7 +843,7 @@ static struct clk_branch disp_cc_mdss_dp_link1_intf_clk = {
 	.clkr = {
 		.enable_reg = 0x2060,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_dp_link1_intf_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_link1_div_clk_src.clkr.hw,
@@ -862,7 +860,7 @@ static struct clk_branch disp_cc_mdss_dp_link_clk = {
 	.clkr = {
 		.enable_reg = 0x2040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_dp_link_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_link_clk_src.clkr.hw,
@@ -880,7 +878,7 @@ static struct clk_branch disp_cc_mdss_dp_link_intf_clk = {
 	.clkr = {
 		.enable_reg = 0x2044,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_dp_link_intf_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_link_div_clk_src.clkr.hw,
@@ -897,7 +895,7 @@ static struct clk_branch disp_cc_mdss_dp_pixel1_clk = {
 	.clkr = {
 		.enable_reg = 0x2050,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_dp_pixel1_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_pixel1_clk_src.clkr.hw,
@@ -915,7 +913,7 @@ static struct clk_branch disp_cc_mdss_dp_pixel2_clk = {
 	.clkr = {
 		.enable_reg = 0x2058,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_dp_pixel2_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_pixel2_clk_src.clkr.hw,
@@ -933,7 +931,7 @@ static struct clk_branch disp_cc_mdss_dp_pixel_clk = {
 	.clkr = {
 		.enable_reg = 0x204c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_dp_pixel_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_pixel_clk_src.clkr.hw,
@@ -951,7 +949,7 @@ static struct clk_branch disp_cc_mdss_esc0_clk = {
 	.clkr = {
 		.enable_reg = 0x2038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_esc0_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_esc0_clk_src.clkr.hw,
@@ -969,7 +967,7 @@ static struct clk_branch disp_cc_mdss_esc1_clk = {
 	.clkr = {
 		.enable_reg = 0x203c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_esc1_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_esc1_clk_src.clkr.hw,
@@ -987,7 +985,7 @@ static struct clk_branch disp_cc_mdss_mdp_clk = {
 	.clkr = {
 		.enable_reg = 0x200c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_mdp_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_mdp_clk_src.clkr.hw,
@@ -1005,7 +1003,7 @@ static struct clk_branch disp_cc_mdss_mdp_lut_clk = {
 	.clkr = {
 		.enable_reg = 0x201c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_mdp_lut_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_mdp_clk_src.clkr.hw,
@@ -1022,7 +1020,7 @@ static struct clk_branch disp_cc_mdss_non_gdsc_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x4004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_non_gdsc_ahb_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_ahb_clk_src.clkr.hw,
@@ -1040,7 +1038,7 @@ static struct clk_branch disp_cc_mdss_pclk0_clk = {
 	.clkr = {
 		.enable_reg = 0x2004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_pclk0_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_pclk0_clk_src.clkr.hw,
@@ -1058,7 +1056,7 @@ static struct clk_branch disp_cc_mdss_pclk1_clk = {
 	.clkr = {
 		.enable_reg = 0x2008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_pclk1_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_pclk1_clk_src.clkr.hw,
@@ -1076,7 +1074,7 @@ static struct clk_branch disp_cc_mdss_rot_clk = {
 	.clkr = {
 		.enable_reg = 0x2014,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_rot_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_rot_clk_src.clkr.hw,
@@ -1094,7 +1092,7 @@ static struct clk_branch disp_cc_mdss_rscc_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x400c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_rscc_ahb_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_ahb_clk_src.clkr.hw,
@@ -1112,7 +1110,7 @@ static struct clk_branch disp_cc_mdss_rscc_vsync_clk = {
 	.clkr = {
 		.enable_reg = 0x4008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_rscc_vsync_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_vsync_clk_src.clkr.hw,
@@ -1130,7 +1128,7 @@ static struct clk_branch disp_cc_mdss_vsync_clk = {
 	.clkr = {
 		.enable_reg = 0x2024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_mdss_vsync_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_vsync_clk_src.clkr.hw,

---
base-commit: 51b70ff55ed88edd19b080a524063446bcc34b62
change-id: 20240201-dispcc-sm8150-58edd6c4e15d

Best regards,
-- 
Satya Priya Kakitapalli <quic_skakitap@quicinc.com>


