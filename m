Return-Path: <linux-kernel+bounces-125811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D7C892C78
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2482628285D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF84F41C89;
	Sat, 30 Mar 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cwCfs920"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D684369A;
	Sat, 30 Mar 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823370; cv=none; b=BlCYH4miFiChT5Qk1YsgyL9nKkarO4JD0w6t6WJF4iUgV5NrONwvb/m7FQyhN3U7T8W4lNVl1tkaWk2NlUc2CLTmzBn7K9TQYSwe+txGlRpWwiK+7FUVW5K5l2jOmAZcdaGx0AKMnPRbj2shOw+dXJkIBWTMkbd33ZqQi+m7GnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823370; c=relaxed/simple;
	bh=Cbhf7LOtDxm8kXQrY3cn33odrNMLb2snExadHbiAGxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ool/MiYOmXvR3EpEtrOUYX1mx1Vn8/xsMjBNUu+czlm35Sgivy2HiVWSzlqjxnmwKKsZCUzwP89kqlFSzgwZ6fANyg5VA1k7QnsycKY65jJ7aco3UbxVyvcDWhYTzhbbN6wbWGTmO2TQWyU4qNii4dVPfxb3UylOenzE8rU/4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cwCfs920; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42UHp8Yu003789;
	Sat, 30 Mar 2024 18:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=xqvzsZnF1LlgMc+oL0HG34IbDapDYKlJEYS6dCsjsSs=; b=cw
	Cfs9208oocEe1Fqm8VJf5VNF8aXUb9T12xGFVTGjxHcz1nEmyx2SImMleH/P/Xbh
	79O818fyaBY2+3PsRXE5jHNzG4Zz+KzgR1Mmj2zZ+s/4K+W6FIJWwordk2IROA1q
	ze4JVVKa/u1R2LqTCmcQKLd5zBn0DZMs1JHDWE6J6N2mh3HeIwr8P2bvmMcV38ii
	hfakXtnygHSSUm8vhZXaPDfoGJlqcOzD13C8dbOIpvnuIbbmaRILg1S79R0jP4MI
	DaBJH08OOeNRovMkLqFY06k0DirVz62/ukx1QHJQgV00iXn05W/CX6vZtb3Pkoln
	7BqAO1//BJkp55JGDIwA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x6c1dh5h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 18:29:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42UIT6sd027336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 18:29:06 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 30 Mar 2024 11:29:01 -0700
From: Ajit Pandey <quic_ajipan@quicinc.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        "Satya Priya Kakitapalli"
	<quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH 1/7] clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override for LUCID EVO PLL
Date: Sat, 30 Mar 2024 23:58:11 +0530
Message-ID: <20240330182817.3272224-2-quic_ajipan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lQ7NSYlB1sYhIgOvF87s8qaNmsMIxU9V
X-Proofpoint-ORIG-GUID: lQ7NSYlB1sYhIgOvF87s8qaNmsMIxU9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403300151

In LUCID EVO PLL CAL_L_VAL and L_VAL bitfields are part of single
PLL_L_VAL register. Update for L_VAL bitfield values in PLL_L_VAL
register using regmap_write() API in __alpha_pll_trion_set_rate
callback will override LUCID EVO PLL initial configuration related
to PLL_CAL_L_VAL bit fields in PLL_L_VAL register.

Observed random PLL lock failures during PLL enable due to such
override in PLL calibration value. Use regmap_update_bits() with
L_VAL bitfield mask instead of regmap_write() API to update only
PLL_L_VAL bitfields in __alpha_pll_trion_set_rate callback.

Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")

Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 8a412ef47e16..81cabd28eabe 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1656,7 +1656,7 @@ static int __alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (ret < 0)
 		return ret;
 
-	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_update_bits(pll->clkr.regmap, PLL_L_VAL(pll), LUCID_EVO_PLL_L_VAL_MASK,  l);
 	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
 
 	/* Latch the PLL input */
-- 
2.25.1


