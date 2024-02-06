Return-Path: <linux-kernel+bounces-54834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B3D84B43B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0119C1C23348
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACA81350C2;
	Tue,  6 Feb 2024 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XqIBGUMX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2B1350D5;
	Tue,  6 Feb 2024 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220095; cv=none; b=nMdLvTVjWESxf8uC8Xu5dNgPJxL0AJhiTsTvTzLi8qqiieLUauF80ZOb0ELyiZrODs6jbKSndPNF1i2GIBER85b+h+hw8Z2p7HYhzkGBjPk59SdXKQENx1BjJZHIm+lRPpdN6JMpxg2o5j0dQDaHxeERsTSSBVUSlnl/fmWlvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220095; c=relaxed/simple;
	bh=ddel/XIxqBvx0M3F8boknndMEkOJvPvc+PT/9tfwYYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4ec1O4Tim4WBHL0Nny4+xS/dj7JWDUTQbb4VQMOB95qMVlyoNxonbeOf1Jm+V7Z403HnulXywexLkDh9IcRgvfBkWTiyAl4Tc+fbRmgKj1MM/aL68+3JMNvX+4zTIMUMHGofp7zXWg8wwiV/EFsEx+f226YRdjQj6SbyZuXoOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XqIBGUMX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41650BT2001304;
	Tue, 6 Feb 2024 11:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=CY3N/nDEDwhXEdlnDpgUtfMLvdJp4cINjI0iGKTecUc=; b=Xq
	IBGUMXEO4MTmX5u258kmDppEdKClAj68BySx5SHsVU1041hEG4rWBs02jqHdK8MT
	erGJk6utShEcRliGde3kNlm6uU6dp38A2JQ9Sgp0NYR2j60GogpNC0V9BzYz8qG4
	BMSw57/waS6bmR0ojoHSxj+jjPcfx8kl+ZvSgyScZ7NytcpZiW/QsZYQLueZ6Pso
	eIHQ0PzEkJRrdy0+czFmrfpGNrNPTZ8EifMOfDWbammdRx7g5dEtDkQjImXj496r
	JZM8OqQmk2SLHxj+j4w1srJ0hYiy7S5SfDTI3Lsc48Tj/EcJaly8bmpoqgwvE09F
	g70+yku7+kdTwBRE1Blw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3e7g0sap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 11:48:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416BmAwe025013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 11:48:10 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 03:48:06 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH 2/3] arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB ports
Date: Tue, 6 Feb 2024 17:17:44 +0530
Message-ID: <20240206114745.1388491-3-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jgSbkpc9G5Cn6sITfWVBYSsxjNGavLio
X-Proofpoint-ORIG-GUID: jgSbkpc9G5Cn6sITfWVBYSsxjNGavLio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=590 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060083

Enable tertiary controller for SA8295P (based on SC8280XP).
Add pinctrl support for usb ports to provide VBUS to connected peripherals.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index fd253942e5e5..6da444042f82 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 #include "sa8540p.dtsi"
 #include "sa8540p-pmics.dtsi"
@@ -584,6 +585,16 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&usb_2 {
+	pinctrl-0 = <&usb2_en>,
+		    <&usb3_en>,
+		    <&usb4_en>,
+		    <&usb5_en>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &usb_2_hsphy0 {
 	vdda-pll-supply = <&vreg_l5a>;
 	vdda18-supply = <&vreg_l7g>;
@@ -636,6 +647,44 @@ &xo_board_clk {
 
 /* PINCTRL */
 
+&pmm8540c_gpios {
+	usb2_en: usb2-en-state {
+		pins = "gpio9";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+		output-high;
+		power-source = <0>;
+	};
+};
+
+&pmm8540e_gpios {
+	usb3_en: usb3-en-state {
+		pins = "gpio5";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+		output-high;
+		power-source = <0>;
+	};
+};
+
+&pmm8540g_gpios {
+	usb4_en: usb4-en-state {
+		pins = "gpio5";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+		output-high;
+		power-source = <0>;
+	};
+
+	usb5_en: usb5-en-state {
+		pins = "gpio9";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+		output-high;
+		power-source = <0>;
+	};
+};
+
 &tlmm {
 	pcie2a_default: pcie2a-default-state {
 		clkreq-n-pins {
-- 
2.34.1


