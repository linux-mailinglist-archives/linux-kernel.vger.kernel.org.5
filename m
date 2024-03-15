Return-Path: <linux-kernel+bounces-104307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1896987CC00
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869821F218EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA151C691;
	Fri, 15 Mar 2024 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CJ0VPzG1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9CE1B593;
	Fri, 15 Mar 2024 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501111; cv=none; b=PKW3SssCzC3+gFtt4aX+dpQhGUD7SbBhv620hHTnmifJ8m5eMoQ36Ld4fv4rotptfYjR1HUks64IdZ26wMfqJN/pbxdxK5pSTxI04zsoCbQHqCAaYu3NbOMzgfDd5dGhVEtIhOea700FrlfK0DUs/WABChjB5Q4n7ROKL1UCEjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501111; c=relaxed/simple;
	bh=L6QBOEmbjLNDR+6iEWPhrA19yzupcoLILRLXUmIQ3Z0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOypFZdxeTj4hlStfB9uAo9O1ipwE1ESaDqTWr9DxUQnK5TkJDc0db6xHI7NTTQKjUWTcIIY0JKAeHAHPvJeArf/lyaPWY83T5TYWe6TvlKSWK/3scT6V+/V43MWPKRQ4O+Aiw4wy5wUSHQaPCRC2zQXzTVckHmFrPrlSUKJg3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CJ0VPzG1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42FApkYg032414;
	Fri, 15 Mar 2024 11:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=47F97nRJ7yTuVM2FeJ7FtAVve6WE+PitYBORY6KFVIM=; b=CJ
	0VPzG1Old80Neow2ucgTiQ/JYg6Etel67lPkjCSpd1RG/qoYWPd7/ayGkjTAF7pA
	935MJGo6TpEM5tVmVFrPiY5rIOzm+UKe0F8h7YF9Z4jt8/OpUioBul7qiTdKLgvf
	TofaW3yvc5l7BMadmmBEn7KCR4Vd2JbJkbjE1BmELDn7mM7GwJaEaE2c/RHKJ9tr
	brVL9XAlXNsgWzMui3nTfZEbuW2UVVD7FhOcnBxLq2+wWRTjY77w05I11fW0+5lX
	n7kvhz98yYfl0BciYRY+EbjL7zcdHC0f4xXkiWvcFvJeuNFlkpRiaPPrMiSMhF+4
	ZU8uO14ZB5720GZUCF9g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wva0612pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 11:11:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42FBBfbY000303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 11:11:41 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 04:11:33 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman
	<khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>, Stephen Boyd
	<sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        "Vikash Garodia" <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa
	<abel.vesa@linaro.org>, Taniya Das <quic_tdas@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V5 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
Date: Fri, 15 Mar 2024 16:40:45 +0530
Message-ID: <20240315111046.22136-5-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315111046.22136-1-quic_jkona@quicinc.com>
References: <20240315111046.22136-1-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9x7XnCZxYYLzq3DvVfqE1kWeGxIXr3cU
X-Proofpoint-ORIG-GUID: 9x7XnCZxYYLzq3DvVfqE1kWeGxIXr3cU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403150091

The HW_CTRL_TRIGGER flag provides flexibility to switch the GDSC
mode as per the consumers requirement compared to HW_CTRL flag which
directly switches the GDSC mode as part of gdsc enable/disable.
Hence use HW_CTRL_TRIGGER flag for vcodec GDSC's to allow venus driver
to switch the vcodec GDSC to HW/SW control modes at runtime using
dev_pm_genpd_set_hwmode() API.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/videocc-sc7280.c | 2 +-
 drivers/clk/qcom/videocc-sm8250.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
index cdd59c6f60df..d55613a47ff7 100644
--- a/drivers/clk/qcom/videocc-sc7280.c
+++ b/drivers/clk/qcom/videocc-sc7280.c
@@ -236,7 +236,7 @@ static struct gdsc mvs0_gdsc = {
 		.name = "mvs0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = HW_CTRL_TRIGGER | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc mvsc_gdsc = {
diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index 016b596e03b3..cac10ccd362e 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -293,7 +293,7 @@ static struct gdsc mvs0_gdsc = {
 	.pd = {
 		.name = "mvs0_gdsc",
 	},
-	.flags = HW_CTRL,
+	.flags = HW_CTRL_TRIGGER,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
@@ -302,7 +302,7 @@ static struct gdsc mvs1_gdsc = {
 	.pd = {
 		.name = "mvs1_gdsc",
 	},
-	.flags = HW_CTRL,
+	.flags = HW_CTRL_TRIGGER,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
-- 
2.43.0


