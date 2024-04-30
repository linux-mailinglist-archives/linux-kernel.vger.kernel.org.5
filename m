Return-Path: <linux-kernel+bounces-164153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCE18B79F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCC61C22CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7AA181D17;
	Tue, 30 Apr 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IEAylLQw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D621779A4;
	Tue, 30 Apr 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487457; cv=none; b=kKJEVvxjHAA79+ShF+kdnCaJoDdn2s++BvbMJfaODcKms9dj0a5T/JxhnZ5SZ69+GNjgweqz3fvpKkSHbeTmaw1grlEIU2LtmY6x3542HphV9dEK/sy26RZsDKqw8/jzdtBWjx2t0fKFb3YsqRvlwqOJ15UIhbXho5PL5SQga5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487457; c=relaxed/simple;
	bh=yg8dq+sy/qGAh/xvwFTjBDe2Uf3uD3iLaM1zD8Hb8ME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QncSXaah7qDWvDXHX4R/NWslt07IWc4Bp4r3Z95vXhIUeCAMuHT0ujZSa2UummN2OlZol1m1ZKyBblnCp+a4Jq6PzrpPUFxSFFsOd4UiOF1iMQBlPfZKaKlcR+zVFiUxl06xW1PijJYGhrPEbBsoA/qHNlDkSiUvLhuepZ23ZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IEAylLQw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U4vd1V007979;
	Tue, 30 Apr 2024 14:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Oj14B2hQSOl1GaQtoCBjPP6cb5TXxChp6ymHSspELcc=; b=IE
	AylLQwgQcRN7+YwYBAmhYJDvkwlIaUAYZw/xEoMXA0IPUWgjgqohrehIRnIiWIs4
	n/1YTcKjDtF6Y3sGX3VHzkAUwmvsM2ii5+OhPvM5JA1lqG1zun5+GKKxGkzVsI6S
	orEqj8diNFBbYeyd8PZ4Cmek1GYCv41qUNgFhSK5s1X8HntPbaDdpSG2gqXuF8zl
	J5HUhRlpfEojJSaUsiRn3LsR3DVxrRkD6XJenI8+LMJTdNgsT/BDnhFD/VA/w+22
	5qzxPdqN21Ged7aU3IOIX+WF6sv9M+SGbhUS2JL2Tm3sWZhY1akJcyC7HPUH+CXN
	WQvpfnwK8z+Pa0hDEOqg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xthgvu5sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UEUol9021825
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:50 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 07:30:45 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 6/8] dt-bindings: clock: qcom: Add SM8650 camera clock controller
Date: Tue, 30 Apr 2024 19:57:55 +0530
Message-ID: <20240430142757.16872-7-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430142757.16872-1-quic_jkona@quicinc.com>
References: <20240430142757.16872-1-quic_jkona@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1pIgdcP_2cYs-OVD94wiVl5koW4PW5aP
X-Proofpoint-GUID: 1pIgdcP_2cYs-OVD94wiVl5koW4PW5aP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300102

Add device tree bindings for the camera clock controller on
Qualcomm SM8650 platform.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 .../bindings/clock/qcom,sm8450-camcc.yaml     |   3 +
 include/dt-bindings/clock/qcom,sm8650-camcc.h | 195 ++++++++++++++++++
 2 files changed, 198 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-camcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index bf23e25d71f5..abd414328495 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -8,6 +8,7 @@ title: Qualcomm Camera Clock & Reset Controller on SM8450
 
 maintainers:
   - Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
+  - Jagadeesh Kona <quic_jkona@quicinc.com>
 
 description: |
   Qualcomm camera clock control module provides the clocks, resets and power
@@ -17,6 +18,7 @@ description: |
     include/dt-bindings/clock/qcom,sc8280xp-camcc.h
     include/dt-bindings/clock/qcom,sm8450-camcc.h
     include/dt-bindings/clock/qcom,sm8550-camcc.h
+    include/dt-bindings/clock/qcom,sm8650-camcc.h
     include/dt-bindings/clock/qcom,x1e80100-camcc.h
 
 allOf:
@@ -28,6 +30,7 @@ properties:
       - qcom,sc8280xp-camcc
       - qcom,sm8450-camcc
       - qcom,sm8550-camcc
+      - qcom,sm8650-camcc
       - qcom,x1e80100-camcc
 
   clocks:
diff --git a/include/dt-bindings/clock/qcom,sm8650-camcc.h b/include/dt-bindings/clock/qcom,sm8650-camcc.h
new file mode 100644
index 000000000000..df73bf35f4bf
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8650-camcc.h
@@ -0,0 +1,195 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAM_CC_SM8650_H
+#define _DT_BINDINGS_CLK_QCOM_CAM_CC_SM8650_H
+
+/* CAM_CC clocks */
+#define CAM_CC_BPS_AHB_CLK					0
+#define CAM_CC_BPS_CLK						1
+#define CAM_CC_BPS_CLK_SRC					2
+#define CAM_CC_BPS_FAST_AHB_CLK					3
+#define CAM_CC_BPS_SHIFT_CLK					4
+#define CAM_CC_CAMNOC_AXI_NRT_CLK				5
+#define CAM_CC_CAMNOC_AXI_RT_CLK				6
+#define CAM_CC_CAMNOC_AXI_RT_CLK_SRC				7
+#define CAM_CC_CAMNOC_DCD_XO_CLK				8
+#define CAM_CC_CAMNOC_XO_CLK					9
+#define CAM_CC_CCI_0_CLK					10
+#define CAM_CC_CCI_0_CLK_SRC					11
+#define CAM_CC_CCI_1_CLK					12
+#define CAM_CC_CCI_1_CLK_SRC					13
+#define CAM_CC_CCI_2_CLK					14
+#define CAM_CC_CCI_2_CLK_SRC					15
+#define CAM_CC_CORE_AHB_CLK					16
+#define CAM_CC_CPAS_AHB_CLK					17
+#define CAM_CC_CPAS_BPS_CLK					18
+#define CAM_CC_CPAS_CRE_CLK					19
+#define CAM_CC_CPAS_FAST_AHB_CLK				20
+#define CAM_CC_CPAS_IFE_0_CLK					21
+#define CAM_CC_CPAS_IFE_1_CLK					22
+#define CAM_CC_CPAS_IFE_2_CLK					23
+#define CAM_CC_CPAS_IFE_LITE_CLK				24
+#define CAM_CC_CPAS_IPE_NPS_CLK					25
+#define CAM_CC_CPAS_SBI_CLK					26
+#define CAM_CC_CPAS_SFE_0_CLK					27
+#define CAM_CC_CPAS_SFE_1_CLK					28
+#define CAM_CC_CPAS_SFE_2_CLK					29
+#define CAM_CC_CPHY_RX_CLK_SRC					30
+#define CAM_CC_CRE_AHB_CLK					31
+#define CAM_CC_CRE_CLK						32
+#define CAM_CC_CRE_CLK_SRC					33
+#define CAM_CC_CSI0PHYTIMER_CLK					34
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC				35
+#define CAM_CC_CSI1PHYTIMER_CLK					36
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC				37
+#define CAM_CC_CSI2PHYTIMER_CLK					38
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC				39
+#define CAM_CC_CSI3PHYTIMER_CLK					40
+#define CAM_CC_CSI3PHYTIMER_CLK_SRC				41
+#define CAM_CC_CSI4PHYTIMER_CLK					42
+#define CAM_CC_CSI4PHYTIMER_CLK_SRC				43
+#define CAM_CC_CSI5PHYTIMER_CLK					44
+#define CAM_CC_CSI5PHYTIMER_CLK_SRC				45
+#define CAM_CC_CSI6PHYTIMER_CLK					46
+#define CAM_CC_CSI6PHYTIMER_CLK_SRC				47
+#define CAM_CC_CSI7PHYTIMER_CLK					48
+#define CAM_CC_CSI7PHYTIMER_CLK_SRC				49
+#define CAM_CC_CSID_CLK						50
+#define CAM_CC_CSID_CLK_SRC					51
+#define CAM_CC_CSID_CSIPHY_RX_CLK				52
+#define CAM_CC_CSIPHY0_CLK					53
+#define CAM_CC_CSIPHY1_CLK					54
+#define CAM_CC_CSIPHY2_CLK					55
+#define CAM_CC_CSIPHY3_CLK					56
+#define CAM_CC_CSIPHY4_CLK					57
+#define CAM_CC_CSIPHY5_CLK					58
+#define CAM_CC_CSIPHY6_CLK					59
+#define CAM_CC_CSIPHY7_CLK					60
+#define CAM_CC_DRV_AHB_CLK					61
+#define CAM_CC_DRV_XO_CLK					62
+#define CAM_CC_FAST_AHB_CLK_SRC					63
+#define CAM_CC_GDSC_CLK						64
+#define CAM_CC_ICP_AHB_CLK					65
+#define CAM_CC_ICP_CLK						66
+#define CAM_CC_ICP_CLK_SRC					67
+#define CAM_CC_IFE_0_CLK					68
+#define CAM_CC_IFE_0_CLK_SRC					69
+#define CAM_CC_IFE_0_FAST_AHB_CLK				70
+#define CAM_CC_IFE_0_SHIFT_CLK					71
+#define CAM_CC_IFE_1_CLK					72
+#define CAM_CC_IFE_1_CLK_SRC					73
+#define CAM_CC_IFE_1_FAST_AHB_CLK				74
+#define CAM_CC_IFE_1_SHIFT_CLK					75
+#define CAM_CC_IFE_2_CLK					76
+#define CAM_CC_IFE_2_CLK_SRC					77
+#define CAM_CC_IFE_2_FAST_AHB_CLK				78
+#define CAM_CC_IFE_2_SHIFT_CLK					79
+#define CAM_CC_IFE_LITE_AHB_CLK					80
+#define CAM_CC_IFE_LITE_CLK					81
+#define CAM_CC_IFE_LITE_CLK_SRC					82
+#define CAM_CC_IFE_LITE_CPHY_RX_CLK				83
+#define CAM_CC_IFE_LITE_CSID_CLK				84
+#define CAM_CC_IFE_LITE_CSID_CLK_SRC				85
+#define CAM_CC_IPE_NPS_AHB_CLK					86
+#define CAM_CC_IPE_NPS_CLK					87
+#define CAM_CC_IPE_NPS_CLK_SRC					88
+#define CAM_CC_IPE_NPS_FAST_AHB_CLK				89
+#define CAM_CC_IPE_PPS_CLK					90
+#define CAM_CC_IPE_PPS_FAST_AHB_CLK				91
+#define CAM_CC_IPE_SHIFT_CLK					92
+#define CAM_CC_JPEG_1_CLK					93
+#define CAM_CC_JPEG_CLK						94
+#define CAM_CC_JPEG_CLK_SRC					95
+#define CAM_CC_MCLK0_CLK					96
+#define CAM_CC_MCLK0_CLK_SRC					97
+#define CAM_CC_MCLK1_CLK					98
+#define CAM_CC_MCLK1_CLK_SRC					99
+#define CAM_CC_MCLK2_CLK					100
+#define CAM_CC_MCLK2_CLK_SRC					101
+#define CAM_CC_MCLK3_CLK					102
+#define CAM_CC_MCLK3_CLK_SRC					103
+#define CAM_CC_MCLK4_CLK					104
+#define CAM_CC_MCLK4_CLK_SRC					105
+#define CAM_CC_MCLK5_CLK					106
+#define CAM_CC_MCLK5_CLK_SRC					107
+#define CAM_CC_MCLK6_CLK					108
+#define CAM_CC_MCLK6_CLK_SRC					109
+#define CAM_CC_MCLK7_CLK					110
+#define CAM_CC_MCLK7_CLK_SRC					111
+#define CAM_CC_PLL0						112
+#define CAM_CC_PLL0_OUT_EVEN					113
+#define CAM_CC_PLL0_OUT_ODD					114
+#define CAM_CC_PLL1						115
+#define CAM_CC_PLL1_OUT_EVEN					116
+#define CAM_CC_PLL2						117
+#define CAM_CC_PLL3						118
+#define CAM_CC_PLL3_OUT_EVEN					119
+#define CAM_CC_PLL4						120
+#define CAM_CC_PLL4_OUT_EVEN					121
+#define CAM_CC_PLL5						122
+#define CAM_CC_PLL5_OUT_EVEN					123
+#define CAM_CC_PLL6						124
+#define CAM_CC_PLL6_OUT_EVEN					125
+#define CAM_CC_PLL7						126
+#define CAM_CC_PLL7_OUT_EVEN					127
+#define CAM_CC_PLL8						128
+#define CAM_CC_PLL8_OUT_EVEN					129
+#define CAM_CC_PLL9						130
+#define CAM_CC_PLL9_OUT_EVEN					131
+#define CAM_CC_PLL9_OUT_ODD					132
+#define CAM_CC_PLL10						133
+#define CAM_CC_PLL10_OUT_EVEN					134
+#define CAM_CC_QDSS_DEBUG_CLK					135
+#define CAM_CC_QDSS_DEBUG_CLK_SRC				136
+#define CAM_CC_QDSS_DEBUG_XO_CLK				137
+#define CAM_CC_SBI_CLK						138
+#define CAM_CC_SBI_FAST_AHB_CLK					139
+#define CAM_CC_SBI_SHIFT_CLK					140
+#define CAM_CC_SFE_0_CLK					141
+#define CAM_CC_SFE_0_CLK_SRC					142
+#define CAM_CC_SFE_0_FAST_AHB_CLK				143
+#define CAM_CC_SFE_0_SHIFT_CLK					144
+#define CAM_CC_SFE_1_CLK					145
+#define CAM_CC_SFE_1_CLK_SRC					146
+#define CAM_CC_SFE_1_FAST_AHB_CLK				147
+#define CAM_CC_SFE_1_SHIFT_CLK					148
+#define CAM_CC_SFE_2_CLK					149
+#define CAM_CC_SFE_2_CLK_SRC					150
+#define CAM_CC_SFE_2_FAST_AHB_CLK				151
+#define CAM_CC_SFE_2_SHIFT_CLK					152
+#define CAM_CC_SLEEP_CLK					153
+#define CAM_CC_SLEEP_CLK_SRC					154
+#define CAM_CC_SLOW_AHB_CLK_SRC					155
+#define CAM_CC_TITAN_TOP_SHIFT_CLK				156
+#define CAM_CC_XO_CLK_SRC					157
+
+/* CAM_CC power domains */
+#define CAM_CC_TITAN_TOP_GDSC					0
+#define CAM_CC_BPS_GDSC						1
+#define CAM_CC_IFE_0_GDSC					2
+#define CAM_CC_IFE_1_GDSC					3
+#define CAM_CC_IFE_2_GDSC					4
+#define CAM_CC_IPE_0_GDSC					5
+#define CAM_CC_SBI_GDSC						6
+#define CAM_CC_SFE_0_GDSC					7
+#define CAM_CC_SFE_1_GDSC					8
+#define CAM_CC_SFE_2_GDSC					9
+
+/* CAM_CC resets */
+#define CAM_CC_BPS_BCR						0
+#define CAM_CC_DRV_BCR						1
+#define CAM_CC_ICP_BCR						2
+#define CAM_CC_IFE_0_BCR					3
+#define CAM_CC_IFE_1_BCR					4
+#define CAM_CC_IFE_2_BCR					5
+#define CAM_CC_IPE_0_BCR					6
+#define CAM_CC_QDSS_DEBUG_BCR					7
+#define CAM_CC_SBI_BCR						8
+#define CAM_CC_SFE_0_BCR					9
+#define CAM_CC_SFE_1_BCR					10
+#define CAM_CC_SFE_2_BCR					11
+
+#endif
-- 
2.43.0


