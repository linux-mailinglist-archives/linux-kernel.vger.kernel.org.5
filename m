Return-Path: <linux-kernel+bounces-23098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2E82A7A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5346E1C23554
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D64CA64;
	Thu, 11 Jan 2024 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cNcl8KoI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01178C8F5;
	Thu, 11 Jan 2024 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B5tDtM027873;
	Thu, 11 Jan 2024 06:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=Ed9FvcCxjPahHj5DCQnCG2rVK5w4YX+xEkPlELY2UP8
	=; b=cNcl8KoI+vlMO4H3MO9hB1Wnj2Q8Mlfcwda8XTAAnYneyn7JwaPbq1VB9sW
	mebhNbVl/64EjN+riEWpK0sWySNNa9YP5FOZgHbOMvx76qV03dojgCo0cZ+hGjAI
	tY5eOJYhvYtN8xMLZry0uwCqKCcPQkn0fPUIKmx78aI9BlU3RRJ7kLr38KfDYsud
	29dIlVYXT3NufG5EmTslgIxAxzhCAaAJaRPAHj0MkSMc7Kvypuko+8ah8GAUTz/Z
	/AHR7i8AL1o/MXmnfNw9lvbiNhFrDtSicLHddgQ998sKJKPT9hzlbksTgt8yH3Zs
	FFmXwMCU+uHqFrTHRubHwFQ5vgA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj0sk9750-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 06:32:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B6Wqqd028350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 06:32:52 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 22:32:47 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Thu, 11 Jan 2024 12:02:30 +0530
Subject: [PATCH v2 3/3] clk: qcom: gcc-sm8150: Add gcc video resets for
 sm8150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240111-sm8150-dfs-support-v2-3-6edb44c83d3b@quicinc.com>
References: <20240111-sm8150-dfs-support-v2-0-6edb44c83d3b@quicinc.com>
In-Reply-To: <20240111-sm8150-dfs-support-v2-0-6edb44c83d3b@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OUqV5KnjJJGwWt6rzh9oqop45faK5cN3
X-Proofpoint-ORIG-GUID: OUqV5KnjJJGwWt6rzh9oqop45faK5cN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=860
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401110051

Add gcc video axic, axi0 and axi1 resets for the global clock
controller on sm8150.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 drivers/clk/qcom/gcc-sm8150.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 80315307dbb4..a47ef9dfa808 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -3778,6 +3778,9 @@ static const struct qcom_reset_map gcc_sm8150_resets[] = {
 	[GCC_USB30_PRIM_BCR] = { 0xf000 },
 	[GCC_USB30_SEC_BCR] = { 0x10000 },
 	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+	[GCC_VIDEO_AXIC_CLK_BCR] = { 0xb02c, 2 },
+	[GCC_VIDEO_AXI0_CLK_BCR] = { 0xb024, 2 },
+	[GCC_VIDEO_AXI1_CLK_BCR] = { 0xb028, 2 },
 };
 
 static struct gdsc *gcc_sm8150_gdscs[] = {

-- 
2.25.1


