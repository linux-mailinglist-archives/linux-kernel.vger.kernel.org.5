Return-Path: <linux-kernel+bounces-7819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5AC81ADB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FF41C22B11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629CDB64A;
	Thu, 21 Dec 2023 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O9AapQ+5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620428BED;
	Thu, 21 Dec 2023 03:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL0kcYJ028673;
	Thu, 21 Dec 2023 03:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=frQT2CpboT4JFMVvIUEiP0bgwm9DmghW2eyfibPI+Dw
	=; b=O9AapQ+55736ztRF1flrJOjPeNO+skVkAVoc2mR5Gp2ZgYT8H0Xas2v/Wk/
	qTme8g9jzWDHhAwjJJmHswxdf8k5AGqSq685Ii2JEJnwNCrkADXEgGFq7dl00GkE
	y0XVwEokUV+dc0SHYwEMU5tbGqrNlLVuNTB8zFwICRnwO8jpi4i4opSQ3LBMhjD3
	66WxwNMeQG7WCTM7NBiZAWRHvQCbT+xnUAxy9HJ/btXbQKealScasdnp0QjMRqFq
	DDOAKiXaIk/irkawLrYQ+uVYY7VlSR9CJ5JCC5uYwS3iejVKt7OW9vY3dazIigoU
	G5WVyTz0ZrVWR91BNA+54Wh/TKg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4837gsb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 03:50:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL3ooN6003639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 03:50:50 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 19:50:50 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 20 Dec 2023 19:50:37 -0800
Subject: [PATCH 3/8] clk: qcom: gpucc-sc8280xp: Add external supply for GX
 gdsc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-sa8295p-gpu-v1-3-d8cdf2257f97@quicinc.com>
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703130649; l=842;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=W58jrEGR3HDSP9nsbmBVDzzSuXHMNvvdx7WjeV0kgd4=;
 b=NMs56R+sj8Rd40Y4Q8Zs3HVuUhqliL6UL/ShGfHLl1hid4rD+MdWG4y6CVAa1c07A9lmHjMIrEsM
 8CnmNXozBlvIj4oFGRO5R0FFMFPNjuffMajH38x81V+RqwzWRB/z
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s6XA8JUkH_9HSMLoQbXcyLxhlUsFYGLv
X-Proofpoint-ORIG-GUID: s6XA8JUkH_9HSMLoQbXcyLxhlUsFYGLv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=964
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312210026

On SA8295P and SA8540P the GFX rail is powered by a dedicated external
regulator, instead of the rpmh-controlled "gfx.lvl".

Define the "vdd-gfx" as the supply regulator for the GDSC, to cause the
gdsc logic to look for, and control, this external power supply.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/clk/qcom/gpucc-sc8280xp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index 8e147ee294ee..e2b3bc000c71 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -399,6 +399,7 @@ static struct gdsc gx_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = CLAMP_IO | RETAIN_FF_ENABLE,
+	.supply = "vdd-gfx",
 };
 
 static struct gdsc *gpu_cc_sc8280xp_gdscs[] = {

-- 
2.25.1


