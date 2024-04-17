Return-Path: <linux-kernel+bounces-148357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101E88A8162
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410751C22E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC47313CF8A;
	Wed, 17 Apr 2024 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a1EQkasS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7CE13BC0A;
	Wed, 17 Apr 2024 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351415; cv=none; b=tZ13g2Cwcn8kVDfjyOYHRPxrKCB42XqLI/ORSEl7vmY4OAd+bGUjBLtRG5ekUSjl3U43Ozlq1D7QctGk3FH3O8dX+FTtlqxLteEbtCBq6EBmU4qgIuLZ36EdUrONhWUim+V/LVglWF79XrBihwPHKf3h6i/SODAp5emfP+i1O+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351415; c=relaxed/simple;
	bh=RMJaR8uGIBUG56BD89FQeBOWR0Wahk+6itjRi5Pq4kY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARhwHF+5wSt/AwQ5s1yb+vktq8beFm9qwe3m8ouISQNrZfjM2mtDqaO5xukLnAP4gfemqw4PGYrN6wapPOapa7LRwk61qc9CpG51XYY4eLgciTJjZVyiMA0ZdTuWfkyfykdLrlPEt8eFbLYtgUD6uVQehuPapi3UM4J6ApVubJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a1EQkasS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H77Sc2006593;
	Wed, 17 Apr 2024 10:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=S+TPjOcBFWBCDv1XUN5SSUPjLhuLUWbbNH0zXglMkSA=; b=a1
	EQkasSc/g83/IVU+W+oOCuG1UBbn5fw7e3V4d/KkjRpM4v+q9yoYFowDw7bRT9T6
	WN8aD90ebPFMrL8n95nq8e/3cGDnleoB4+JCO7fcZ44QbaGoSWr+qq+lYtsohYkT
	juJWwF9aQ/MWhlTagyMu+qxHW7AFAYyZ0xmDEIyYWrA28/6IkS7bCnd9AL9+4IUh
	6dfBekkydoy6j+I2UsC1rrj4yNvztLTkxpDiEhVUkgWHOaHO793b9DOUlAPq2R8o
	qWTFIOL3j3ftG0ChLhi8Iyh6DYUsb7eBC1OZzxbBlmsLId+6yxoV3+XcHTGfZK42
	ybyaUide6g/hKbOmYEGw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj9rm8g4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:56:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HAujOb015402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:56:45 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 03:56:40 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v8 2/7] clk: qcom: cbf-msm8996: Specify master and slave id
Date: Wed, 17 Apr 2024 16:26:00 +0530
Message-ID: <20240417105605.836705-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417105605.836705-1-quic_varada@quicinc.com>
References: <20240417105605.836705-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mPoUrt2C_BI-7hY7RqsLvhO97abdSCVs
X-Proofpoint-GUID: mPoUrt2C_BI-7hY7RqsLvhO97abdSCVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170075

The icc-clk driver has been changed to take master and slave id
from the caller instead of auto-generating them. Update
clk-cbf-8996 accordingly.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/clk-cbf-8996.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
index fe24b4abeab4..a077d4403967 100644
--- a/drivers/clk/qcom/clk-cbf-8996.c
+++ b/drivers/clk/qcom/clk-cbf-8996.c
@@ -237,7 +237,12 @@ static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev, struct cl
 	struct device *dev = &pdev->dev;
 	struct clk *clk = devm_clk_hw_get_clk(dev, cbf_hw, "cbf");
 	const struct icc_clk_data data[] = {
-		{ .clk = clk, .name = "cbf", },
+		{
+			.clk = clk,
+			.name = "cbf",
+			.master_id = MASTER_CBF_M4M,
+			.slave_id = SLAVE_CBF_M4M,
+		},
 	};
 	struct icc_provider *provider;
 
-- 
2.34.1


