Return-Path: <linux-kernel+bounces-158107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8508B1BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456C528371C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA806BFD2;
	Thu, 25 Apr 2024 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NkFkTG2A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD4F3CF5E;
	Thu, 25 Apr 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029254; cv=none; b=dAx52MDaa94sqdngmsr4p/5DnEPnH1fdWswlk8sJCeS7ACx1Gxjp/1jYp3P0iGAsk8Auctth0sucfi01YMrBctAEhNYvWc0r5Gk1oECy+DRSIJYVz58t6W5IFshxJMqevOFokJx14Ntm0CSYmdmAuvNz7y23qhfiIj3AUQeQu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029254; c=relaxed/simple;
	bh=Uw5k8snV45DhizBJ9JPEOBZducDLygG+f5i+Ls5pmA0=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YtvB6+aTUEVk8COFrm6DG4OfKsX2ZAf2keugh72V6sw4JEZy+cPpHTj4bj3mD0tM/QI4WX1JxqlJzxicreUjkFWu+Qjt0OuHpsXMXIyZsV5751TFhcDhTXyXkGEYvW9BfXrE8DuO4+jHwPl6VCZPfw0eJtAMUw8XbkSxODHks5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NkFkTG2A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P2jExE001827;
	Thu, 25 Apr 2024 07:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:mime-version:content-type; s=
	qcppdkim1; bh=OPIXK7D3p+DrH1TF2OY64X+UHr1QtuBR8aKkWrFHsYA=; b=Nk
	FkTG2Aedng8VcjMQArU8om7cPPYPXKikWSYwljzfjA68F++N8PdAcxRqusvVsVJp
	D8g2RTf/WaimUkzMniGrtW1/G4/QBAmG64yhLbtjqbtXf7TshkiU9kuBVksNN6LD
	m8DEc3NrzO3uhKT1e75g2Ggy9jaY5TMXGSd0HooyKFUi06ZiYe8EJ93Mc5cnoXBD
	3veRZGcijGiigQ1+KuCOMCdAESaNd0KFuTZqezv4QRImqDmpaNGIwuWgnWZIWdyb
	5efG+6+fvjDq0qLxfPlbMxY7sUulhEQepDPSwr+AJE7aRiNcl9RHjIrVVIQ0NCu/
	f6XJY9UihSsI0UW5SO7w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenhrsuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 07:14:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P7E1x4021022
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 07:14:02 GMT
Received: from hu-vvalluru-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 00:13:58 -0700
Date: Thu, 25 Apr 2024 12:43:54 +0530
From: Venkata Prahlad Valluru <quic_vvalluru@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_abhinavk@quicinc.com>,
        <quic_nankam@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: enable hdmi bridge
Message-ID: <20240425071354.GA12900@hu-vvalluru-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Yl6rC1WRpP1-43TSVpgpoTTrp5ghBaXr
X-Proofpoint-GUID: Yl6rC1WRpP1-43TSVpgpoTTrp5ghBaXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_06,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=1 clxscore=1011
 priorityscore=1501 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250050

Enable lt9611uxc bridge for qcs6490 rb3 gen2 platform.

Signed-off-by: Prahlad Valluru <quic_vvalluru@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 86 ++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index a085ff5b5fb2..ff963f94c0e3 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -51,6 +51,18 @@
 			};
 		};
 	};
+	
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "HDMI";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&lt9611_out>;
+			};
+		};
+	};
 
 	reserved-memory {
 		xbl_mem: xbl@80700000 {
@@ -530,6 +542,45 @@
 			   <GCC_WPSS_RSCP_CLK>;
 };
 
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	lt9611_codec: hdmi-bridge@2b {
+		compatible = "lontium,lt9611uxc";
+		reg = <0x2b>;
+
+		interrupts-extended = <&tlmm 24 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&pm7250b_gpios 2 GPIO_ACTIVE_HIGH>;
+
+		vcc-supply = <&vreg_l11c_2p8>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lt9611_irq_pin &lt9611_rst_pin>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lt9611_a: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				lt9611_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
 &i2c1 {
 	status = "okay";
 
@@ -602,6 +653,21 @@
 	status = "okay";
 };
 
+&mdss_dsi {
+        vdda-supply = <&vreg_l6b_1p2>;
+        status = "okay";
+};
+
+&mdss_dsi0_out {
+        remote-endpoint = <&lt9611_a>;
+        data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi_phy {
+        vdds-supply = <&vreg_l10c_0p88>;
+        status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -711,3 +777,23 @@
 	function = "gpio";
 	bias-disable;
 };
+
+&pm7250b_gpios {
+        lt9611_rst_pin: lt9611-rst-state {
+                pins = "gpio2";
+                function = "normal";
+
+                output-high;
+                input-disable;
+                power-source = <0>;
+        };
+};
+
+&tlmm {
+        lt9611_irq_pin: lt9611-irq {
+                pins = "gpio24";
+                function = "gpio";
+                drive-strength = <8>;
+                bias-disable;
+        };
+};
-- 
2.17.1


