Return-Path: <linux-kernel+bounces-101416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B39187A6D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE531C20CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED784AECA;
	Wed, 13 Mar 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OYk9x0EP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B485482C9;
	Wed, 13 Mar 2024 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328160; cv=none; b=ZgEX2BvYTySxgUwNCTY/79R61ct+yZrHRJ3pjzrP35paSGZXmT3VoWvw02qL4G2QDJGlLu1Gq6CVrWvT4+hft2XgNyFbvDpZUIfKKaeuDRXcTNyiDEcohJ0v4ssT5mz5Kgj8/DZO4441J+DU/JE64qGHec+rf/aro/PheQqHMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328160; c=relaxed/simple;
	bh=JCnLwcrTKgTY9i0OvXg+VN9D6vYgq+9YDeZyE7ywI8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nwBfZjwc9q9m9xpjNkNs2yKtbb9ooPrSZCnKky1bNBnaHx2ETTNQhws/CDhhLqWZY+tNWuDSDKmAhefbBt6R6SlSDO7EjCMu8TWzU4sU1E5e/8r6xpN3Qscos76wHIg0diZtRrVigyqlXZr6jf+i9of0rZYvVNqNL+oJMzDK0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OYk9x0EP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DAvTBC006554;
	Wed, 13 Mar 2024 11:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=tw0UkAYi81GfGQNJCgFCDn6r3Unprkn+tqqLNjnq9E8
	=; b=OYk9x0EPD0IXLJwaD79sg6t8msWtKsbQqyznMiBro0E1U0erLUDAyM5IBcB
	zvfpUbTfI/9ninECf4rQk5JQ8VPuyM9il5Im8/lizdZE/IhQKvC225I44qVibdkn
	0+d3Goqma2rvxXt6OoU6KdUCpAuT/nQOGS70r/081RD3b4jzEpCBk5+QC5Es7EmX
	0sIe+VYctfcCW4VtJY67VtT/Tk4+9p7lS3IbPkP2NOE51C2Myd3APZbrpWryoStY
	7xBQDh5GMvOx1cGEOhhndUv4Vvc+tP64z4Crp9B7Z/DZLePqvATGbXDrBa4T+ydw
	SCce5IDMbLB7XVYCQtN/j0JM31A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuam5g1me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 11:09:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DB9EKf010175
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 11:09:14 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Mar 2024 04:09:09 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Wed, 13 Mar 2024 16:38:28 +0530
Subject: [PATCH 2/3] clk: qcom: videocc-sm8150: Add index based clk lookup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240313-videocc-sm8150-dt-node-v1-2-ae8ec3c822c2@quicinc.com>
References: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com>
In-Reply-To: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G_l3NxeOJZ9ZGEPH2uqqwzK8FAzljgll
X-Proofpoint-ORIG-GUID: G_l3NxeOJZ9ZGEPH2uqqwzK8FAzljgll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130083

Add support to look up for clocks using index instead of fw_name.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 drivers/clk/qcom/videocc-sm8150.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sm8150.c b/drivers/clk/qcom/videocc-sm8150.c
index a0329260157a..2b788a03c5ed 100644
--- a/drivers/clk/qcom/videocc-sm8150.c
+++ b/drivers/clk/qcom/videocc-sm8150.c
@@ -19,6 +19,10 @@
 #include "reset.h"
 #include "gdsc.h"
 
+enum {
+	DT_BI_TCXO,
+};
+
 enum {
 	P_BI_TCXO,
 	P_VIDEO_PLL0_OUT_MAIN,
@@ -49,7 +53,7 @@ static struct clk_alpha_pll video_pll0 = {
 		.hw.init = &(struct clk_init_data){
 			.name = "video_pll0",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = DT_BI_TCXO,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_trion_ops,
@@ -63,7 +67,7 @@ static const struct parent_map video_cc_parent_map_0[] = {
 };
 
 static const struct clk_parent_data video_cc_parent_data_0[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = DT_BI_TCXO },
 	{ .hw = &video_pll0.clkr.hw },
 };
 

-- 
2.25.1


