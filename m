Return-Path: <linux-kernel+bounces-165036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3768B86EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EAC1C223F8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B3D50A63;
	Wed,  1 May 2024 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mwl0Fo47"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E81E4A1;
	Wed,  1 May 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552370; cv=none; b=uF/mSPiXVj/6zvJW7NUVU2taWT1v53SSJrQweLiFP2eKKsnoCdngiA3fqRthtq7sfsH3znW4OyRTKojXMVbo/sfVV79I38YVaKLzx3RbMTAYJikOo7WPxDPm1EzJc1QOHZeSmezXDd0BSO7YoqT5isFzePd7Q/Oz5omVKDDocHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552370; c=relaxed/simple;
	bh=BekQdQptTQpvGpRyGlUbj2l5mkL6Bnv5K9rBAJ8HL1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lfQGjNKPSoOWZh3JuiOPOaby62sSUk2YHqd4vCJO7VEUSet4mYUtaEmzNXaYr/bdL70ewRdP0/dnFKDo6xJTuXEKrUL4irJgDZm0SZB7StfMysTP229uKfKdP3Gi9p8vaWJt+XpdD1xP/u/CmyIbKX654kvFnIGGEfPy5ryVGJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mwl0Fo47; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4417feQL004388;
	Wed, 1 May 2024 08:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=5aovpYcRm3B2nPdzz98yDMi5tfJer7t+Yw3vCW5iLVU
	=; b=Mwl0Fo4767jT0wfP0GlVsZTWROYnF5V+cbPW/N84vkR7GK2DMt51T79zvc/
	tSiPNf0fmKRQ5YdOxFnf47R9FNDKLyvPkXC6eCUv7oFcE0bHTkIdps4KXmy8Cbx1
	0bmXbeDv9ToZPlnIJtaZ/bJ2+/DBa+kRCs8goZhbgVGw8/C08poMHANXFRl23T9f
	gYt5Yb899MREy3GbPvP4sG2W2XHKTVpac6yF0eI8RVp25T59LWu/AhaIRAQVlZbQ
	l1LnjvMATU6nqle14ENUt8z+v1pCo2oG9u6cUL/Z4DqFm+aNrBaZd3Z+ID2N8veI
	XjcWFkqIf5mM1f/3aRcJvtQ83/A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xudkkrg7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 08:32:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4418WbWq005888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 08:32:37 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 1 May 2024 01:32:33 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Wed, 1 May 2024 14:02:19 +0530
Subject: [PATCH v3 2/2] arm64: dts: qcom: sm8150: Add video clock
 controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240501-videocc-sm8150-dt-node-v3-2-2c4bd9ef48bd@quicinc.com>
References: <20240501-videocc-sm8150-dt-node-v3-0-2c4bd9ef48bd@quicinc.com>
In-Reply-To: <20240501-videocc-sm8150-dt-node-v3-0-2c4bd9ef48bd@quicinc.com>
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
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Taniya
 Das" <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AJqPRkw9mEaCrmfIZTI2fHNEVg-Mkv0z
X-Proofpoint-GUID: AJqPRkw9mEaCrmfIZTI2fHNEVg-Mkv0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=938
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405010059

Add device node for video clock controller on Qualcomm
SM8150 platform.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8155p.dtsi |  4 ++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
index ffb7ab695213..9e70effc72e1 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
@@ -38,3 +38,7 @@ &rpmhpd {
 	 */
 	compatible = "qcom,sa8155p-rpmhpd";
 };
+
+&videocc {
+	power-domains = <&rpmhpd SA8155P_CX>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a35c0852b5a1..55c9046f4fb9 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/qcom,dispcc-sm8150.h>
 #include <dt-bindings/clock/qcom,gcc-sm8150.h>
 #include <dt-bindings/clock/qcom,gpucc-sm8150.h>
+#include <dt-bindings/clock/qcom,videocc-sm8150.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sm8150.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -3715,6 +3716,19 @@ usb_2_dwc3: usb@a800000 {
 			};
 		};
 
+		videocc: clock-controller@ab00000 {
+			compatible = "qcom,sm8150-videocc";
+			reg = <0 0x0ab00000 0 0x10000>;
+			clocks = <&gcc GCC_VIDEO_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "bi_tcxo";
+			power-domains = <&rpmhpd SM8150_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		camnoc_virt: interconnect@ac00000 {
 			compatible = "qcom,sm8150-camnoc-virt";
 			reg = <0 0x0ac00000 0 0x1000>;

-- 
2.25.1


