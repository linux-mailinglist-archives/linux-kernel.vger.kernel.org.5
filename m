Return-Path: <linux-kernel+bounces-35650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CDE8394C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00CBEB22497
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF11D7FBBF;
	Tue, 23 Jan 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VpIGMe9g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A27FBB2;
	Tue, 23 Jan 2024 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027673; cv=none; b=jFQrU+y0Qjv9RodvuHt3ZG8anKtmqZkRcnm5sqoyF/x5NBMf9egQ3Xvy2VpxZMQKQwmsrtfoeV61/X1FjZ1DAaWUIekFB8hytdLXODdfQI6nXas9vYKOg0LLl4A7QfuAXB14AkjrtBMVHwe2VdiM5K/HtUSwuuoRG4r4/wGPiP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027673; c=relaxed/simple;
	bh=SVd9nc7aLxCe8vSZUpkEU3kGca1nprnW6wmKmwxafpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZwqepE3jj44CTtcHDcCu9O1KKordmsqBAHjkyBe43Dul40MUDgmBz1DmASJQ5BMe2PNdQ9HDS1DtZOkf1+bhSa8pxEp7CD2zsG6Lxkrv1c2kWETl1k4uttKIGId7Gw1zOIJwk81nddidpfZUcqsykz05MWqpeJXSh+3DoRqAiN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VpIGMe9g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NBOjat009514;
	Tue, 23 Jan 2024 16:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=lUEbNMFM/zB5Pkpa3oaipzSV2zThPkjqo/WNshFlnoU
	=; b=VpIGMe9gm+iedENPgoSYvzAmZFvRAw4T9TY2ECz+/uVvku5qdOy9SdGKkBw
	2vcLr41/iPEWnmdA6hxjaCF4kGHBsQi1yqU73J0ke8km93jIjXKJ47OgBVH5Boh0
	kSe/WEIfAKIVhwrT+l+apGeLm+b7re3CADQlepcjGknkEJtMZngav+wlfTnfJzy6
	h/Yn3Ptbj7M6A2dUaDdi3KyS4RflZrOUkmWHCz4+kZnX3aQnDlxgwHO5Y/SMcuqo
	tg5Aa8I0OFl5QyyaB3u9wd42YP6zAbWKDBwqWPoN7A67TsOcSmpuDza/MAYnW1m8
	md5iRhzFk3o2j++/BfvDEoYnl/w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt73m1k61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 16:34:28 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NGYRFC008616
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 16:34:27 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 08:34:22 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Tue, 23 Jan 2024 22:04:08 +0530
Subject: [PATCH 2/3] clk: qcom: gcc-sm8150: Add gcc_parents_0_ao support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240123-gcc-ao-support-v1-2-6c18d5310874@quicinc.com>
References: <20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com>
In-Reply-To: <20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E28FmpfCPIAnpn4T5zdfwsBs93bVeFRk
X-Proofpoint-ORIG-GUID: E28FmpfCPIAnpn4T5zdfwsBs93bVeFRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=596 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1015 mlxscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230122

Add active_only support for gcc_parents_0, this is needed because
some of the clocks under it are critical which would vote on xo
blocking the suspend.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 drivers/clk/qcom/gcc-sm8150.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 05d115c52dfe..2a0608c5a104 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -123,6 +123,12 @@ static const struct clk_parent_data gcc_parents_0[] = {
 	{ .hw = &gpll0_out_even.clkr.hw },
 };
 
+static const struct clk_parent_data gcc_parents_0_ao[] = {
+	{ .fw_name = "bi_tcxo_ao", .name = "bi_tcxo_ao" },
+	{ .hw = &gpll0.clkr.hw },
+	{ .hw = &gpll0_out_even.clkr.hw },
+};
+
 static const struct parent_map gcc_parent_map_1[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
@@ -222,8 +228,8 @@ static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
 	.freq_tbl = ftbl_gcc_cpuss_ahb_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_cpuss_ahb_clk_src",
-		.parent_data = gcc_parents_0,
-		.num_parents = ARRAY_SIZE(gcc_parents_0),
+		.parent_data = gcc_parents_0_ao,
+		.num_parents = ARRAY_SIZE(gcc_parents_0_ao),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},

-- 
2.25.1


