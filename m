Return-Path: <linux-kernel+bounces-107289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD2E87FA74
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5201C21971
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0BB7CF30;
	Tue, 19 Mar 2024 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X596egTr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76F7CF1F;
	Tue, 19 Mar 2024 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839457; cv=none; b=tfQ6IjONE2Uj5ubd8kgZz76XiirDke80SP1DoZIqVlVNLrK3HFeqQ0dPbxgb0aEMGcKPcqk1a2F8CDYup2RumJyCihogIUs3dRdD4BnUPIeMii+AHx4mO9tFUujTA/+nVeHA5tMedUcTq790/iqOLJI26v2z78jMgj2f8yYSZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839457; c=relaxed/simple;
	bh=1GjPaXR/AcWqSYjy6NW+yKhk8z6ZayMbRuyJVgXZRyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfkFa1tEMLy07XQSYfEfL0etIxzkIM9k5UkigvDbNyFa+uIt7OER1UTp7OMetZ0joqFH14xiY7OToKnbl9CKiyYn2/gQcIX/5V6mDbJ0gfOlVoO4UicQuS2uzxuUPm9KzO9EeFL6YeD3ExZovxfuosqAtgU6cfSRbSV5TsekvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X596egTr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J2HbAx005288;
	Tue, 19 Mar 2024 09:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=JJ17S7PQVSKlwvPFjjPcR/mmQhwVo68YrxSRgZU+5Bc=; b=X5
	96egTrEJdcpkHjIduWKLQOmwPxx7UZTXZyD623cg/KDfm1fafTuEKLaKoSW514pT
	s4Ihazq32hdvNOU2RF0nvGFaYfr+crQsf4zoFE/liEGL42RbtPsUcly3T89t3jT0
	gdv/WNyhnfwidfr/DUx7IaWhuoNjX7OAlTb3YTd856H6ee7ySQhiqq7W40QgFK2K
	BTnLFDXhBvCKe36SVPZH9l1s8pnHSG6gQqJukDkAp5gUkEpWkg1svCR2USZtLMy9
	zwLvj8TOgEJZBZU64hkHwQgZg3QsUy0v9aps3YxgpvU/USpE7FS3LeTpebEg0bPr
	9+H0hpGPh6C9wwwUKKgQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy1j2gsh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:10:53 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J9AqDP022155
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:10:52 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 02:10:49 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>,
        "Amrit
 Anand" <quic_amrianan@quicinc.com>
Subject: [PATCH 3/3] arm64: dts: qcom: qru1000-idp: enable USB nodes
Date: Tue, 19 Mar 2024 14:40:20 +0530
Message-ID: <20240319091020.15137-4-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240319091020.15137-1-quic_kbajaj@quicinc.com>
References: <20240319091020.15137-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: REutQsOCmiJkepPzx_RpDNZFKVqVHY6B
X-Proofpoint-ORIG-GUID: REutQsOCmiJkepPzx_RpDNZFKVqVHY6B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 mlxlogscore=767 spamscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190070

Enable both USB controllers and associated hsphy and qmp phy
nodes on QRU1000 IDP. Add the usb type B port linked with the
DWC3 USB controller switched to OTG mode and tagged with
usb-role-switch.

Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qru1000-idp.dts | 65 ++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
index 258483af065b..5c479c1e4773 100644
--- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
@@ -46,6 +46,33 @@ ppvar_sys: ppvar-sys-regulator {
 		regulator-boot-on;
 	};

+	usb_conn_gpio: usb-conn-gpio {
+		compatible = "gpio-usb-b-connector";
+		vbus-gpio =  <&pm8150_gpios 7 GPIO_ACTIVE_HIGH>;
+		id-gpio = <&tlmm 42 GPIO_ACTIVE_HIGH>;
+		vbus-supply = <&vbus_supply_regulator>;
+
+		pinctrl-0 = <&usb_vbus_det_default
+			     &usb_id_det_default>;
+		pinctrl-names = "default";
+
+		port {
+			usb_port0_connector: endpoint {
+				remote-endpoint = <&usb_1_dwc3_hs>;
+			};
+		};
+	};
+
+	vbus_supply_regulator: vbus-supply-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_supply";
+
+		gpio = <&tlmm 43 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb_vbus_boost_default>;
+		pinctrl-names = "default";
+		enable-active-high;
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -239,6 +266,16 @@ vreg_l18a_1p2: ldo18 {
 	};
 };

+&pm8150_gpios {
+	usb_vbus_det_default: usb-vbus-det-default {
+		pins = "gpio7";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		power-source = <0>;
+	};
+};
+
 &qup_i2c1_data_clk {
 	drive-strength = <2>;
 	bias-pull-up;
@@ -467,3 +504,31 @@ &tlmm {
 &uart7 {
 	status = "okay";
 };
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "otg";
+	usb-role-switch;
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&usb_port0_connector>;
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l8a_0p91>;
+	vdda18-supply = <&vreg_l14a_1p8>;
+	vdda33-supply = <&vreg_l2a_2p3>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l8a_0p91>;
+	vdda-pll-supply = <&vreg_l3a_1p2>;
+
+	status = "okay";
+};
--
2.42.0


