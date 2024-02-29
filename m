Return-Path: <linux-kernel+bounces-86142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5284386C056
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813391C213AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B140BE5;
	Thu, 29 Feb 2024 05:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lsg1oRjx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07FF3C6BF;
	Thu, 29 Feb 2024 05:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709185201; cv=none; b=PON3jYX5MepcbqR7xgwpT78n0YQXUrlch2GgB6XvvfShjyKZHGoQGXKANr3rT9paNuqgePHG6OMLjXLlZ+e5X0mmAaALROrFbphEp8ZwIfjPREwd2SsGXDtWvK1R5jkrECUUW10OI7REK5psJpGlvFWEA+eUyFKcmkmuaH7pZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709185201; c=relaxed/simple;
	bh=BxBXdk9njGmAYe8X503FCTU4BkImA+Y2kMwY5j4gQNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y5eyJlZktZMnrYpnz3KE+7Jxl1oUTjHkCMK1sqNF5A5FKXYCP0URZRKFvDqIKkA7wy3Xmz2dSEo0ZlI6BGMFca/RnBQqh1ECLH5WUaYufZu6v3E5kFUjkNjDJWTtWEoL1hxHaLyDxsjaSzkTVBefkT8BnMbIVUKnznSMYWbnvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lsg1oRjx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T3Ge2Q002530;
	Thu, 29 Feb 2024 05:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=reJCW1U+TSxMoQu5eHByHVWlfAqnHOJk3G2lwDttdGg
	=; b=Lsg1oRjx9jsnDfxjUVsU40Km6jBewkFwKMFoA5KL9LvN6gVi2mjpNRcol4t
	FRrxS5zObidKDnz2/jHv/+/GLlKX+z2bqcqQFLnfRV2VCG8ct7F4GZhFkUoneiX5
	sQuuQbZrPHff3DlTGR6ndMS1varfCnclpItR6AHxdAso7BX0CFE6J+zKLPwC4Unz
	iTMrpDZUbTGamRTo1I8lCLE/iHNVJTVk9h5HlBiBnPaHNh+tvtmJntfkCilDPr4Z
	EmQ+o5d0+Qa+qmIQU60IkyvwhqLs3sU13dXNVgUtpNSozFRKqrjvqB6hsoykA4AP
	dRp3jdAconvCVA0s2qOGbcTnlRQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjb18137y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 05:39:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41T5dXRT005716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 05:39:33 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 21:39:28 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Thu, 29 Feb 2024 11:08:58 +0530
Subject: [PATCH 5/5] arm64: dts: qcom: Add camera clock controller for
 sm8150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-camcc-support-sm8150-v1-5-8c28c6c87990@quicinc.com>
References: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
In-Reply-To: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Stephen Boyd <sboyd@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1oYUBk43-IurOMVm3wb8JXZFNDp_gTDo
X-Proofpoint-ORIG-GUID: 1oYUBk43-IurOMVm3wb8JXZFNDp_gTDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402290042

Add device node for camera clock controller on Qualcomm
SM8150 platform.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8155p.dtsi |  4 ++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
index ffb7ab695213..52f6019885c1 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
@@ -9,6 +9,10 @@
 
 #include "sm8150.dtsi"
 
+&camcc {
+	power-domains = <&rpmhpd SA8155P_CX>;
+};
+
 &dispcc {
 	power-domains = <&rpmhpd SA8155P_CX>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a35c0852b5a1..8489304b845e 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/clock/qcom,gpucc-sm8150.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sm8150.h>
+#include <dt-bindings/clock/qcom,sm8150-camcc.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -3722,6 +3723,17 @@ camnoc_virt: interconnect@ac00000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		camcc: clock-controller@ad00000 {
+			compatible = "qcom,sm8150-camcc";
+			reg = <0 0x0ad00000 0 0x10000>;
+			clocks = <&gcc GCC_CAMERA_AHB_CLK>, <&rpmhcc RPMH_CXO_CLK>;
+			power-domains = <&rpmhpd SM8150_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		mdss: display-subsystem@ae00000 {
 			compatible = "qcom,sm8150-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;

-- 
2.25.1


