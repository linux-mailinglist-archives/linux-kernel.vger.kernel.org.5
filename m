Return-Path: <linux-kernel+bounces-32371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7176B835AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9FA1C24065
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4036EDDB8;
	Mon, 22 Jan 2024 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oP5m8e3x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4BB5257;
	Mon, 22 Jan 2024 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903094; cv=none; b=DmKHs4Gz430HyjRRaB2yBATZGSaxpZ37HeuFvXE2oik1NYYSRP7sGllcVTV3WorMcJ92ExBpqvXA339hfO9uQoyF1LkXmPpdcjyOvK9pUffRo19gaQ4mhX0Rvqbq9MwrANbTf2vywdGAiRTlulv2lE0ZYvJUGuczgqnlA7sEPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903094; c=relaxed/simple;
	bh=r0GgMzb0IwLYew1hPy8O6BwVhCfjMR033KqRmaNeDb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GZyi/U+wrkOxve0hexIINdjuONcu+2CCEfmnlfTWdPQfrE62UKtAMhy/m6Nfq0l4g9z1XyQ0VpNblIGtkxug//DHFOeP/KJnh/Cso54krE1aJjpKXlJU2dGf27Hp9SOwMT196PS+nBGGkrDYQqAUgxlBNaaj0pm78wUrltR1REM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oP5m8e3x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M5UFNH020326;
	Mon, 22 Jan 2024 05:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=UUKLt13C9tDbno9DR5Kvl/4aK/hJZvVVCUTzBufJzOE
	=; b=oP5m8e3xrsz8RYQmHkf0+poUVBU0KreG7oiVlHWW70h3EUGHdqNq+rj18T6
	OYrlCh4kI+zEJQBlj1HbGX8AiTIOvlBvVRjP02BKmUnVYEKVHvGxPIVSUSWEMsW7
	ek8JRSZRpycgQAl/jn23T4W+Y3Q47yB4Vra7KpqWZ5Z4EJdu3Kv3i9db7XIIa31/
	SrM10MfTDr7TZjgIarDjTtjNnM1ubmcCUac4Z9t/3PXhMtz+zml5AYBGbDZT512v
	/dqI30bDxOrH9RQ2Reb/FzOnPbpspdrFj5ajBtWsKo1W8ZPQQSrNbmLbV4XeztI2
	9OfwEMCS/b66L5Y45m+nMTn9lJQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr56d32y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:58:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M5vPi3023894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:25 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 21:57:19 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Mon, 22 Jan 2024 11:26:59 +0530
Subject: [PATCH v4 3/8] dt-bindings: clock: ipq5332: add definition for
 GPLL0_OUT_AUX clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240122-ipq5332-nsscc-v4-3-19fa30019770@quicinc.com>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
In-Reply-To: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan
 Thirumoorthy" <quic_kathirav@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705903023; l=785;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=r0GgMzb0IwLYew1hPy8O6BwVhCfjMR033KqRmaNeDb0=;
 b=V5g2LEzCVpHJo61bNH1ibJWzG60RK+8ybxK26rjChZbz1VdFpZdPsRXF3oE+cxXsqqJpp70Uc
 iExK6uG1TGNBRsMxxTlPtAU+J4Burx174tRUlBXk73K+wxn4JqzATrS
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _DfSCDjKnFFbQ8cAvQGVtKVNgLf4qcrY
X-Proofpoint-GUID: _DfSCDjKnFFbQ8cAvQGVtKVNgLf4qcrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 mlxlogscore=946 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220041

Add the definition for GPLL0_OUT_AUX clock.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 include/dt-bindings/clock/qcom,ipq5332-gcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,ipq5332-gcc.h b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
index 8a405a0a96d0..24486eb47ed8 100644
--- a/include/dt-bindings/clock/qcom,ipq5332-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
@@ -179,6 +179,7 @@
 #define GCC_PCIE3X1_0_PIPE_CLK_SRC			170
 #define GCC_PCIE3X1_1_PIPE_CLK_SRC			171
 #define GCC_USB0_PIPE_CLK_SRC				172
+#define GPLL0_OUT_AUX					173
 
 #define GCC_ADSS_BCR					0
 #define GCC_ADSS_PWM_CLK_ARES				1

-- 
2.34.1


