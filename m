Return-Path: <linux-kernel+bounces-107288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469F587FA71
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD191F2158E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC677CF07;
	Tue, 19 Mar 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QefBuxLc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4237C6CA;
	Tue, 19 Mar 2024 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839453; cv=none; b=aounZR0KTGKl38qNU06LfQxeHCZkX2G1J2puko2EkEWLGetAnmxzABnHsvxPJbe30pVNth+DFY/kl+VuN9JVqmYNxgO8wHRIjpCDdi/7dU9r/auNJMkT1/SzD8DCH26pxeqqQGQIGMJ7rB8952aQjGbjne3dCF0rsq9AJyuFvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839453; c=relaxed/simple;
	bh=c9JYfFslNqVdGrOJyx8u+k6cMcptcL1A7XS1g9CPGcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xgt7tjyfV/Za/lEDGx3GVFiJe2ZTVfxOIm2FKoCKp/mE4qjv14GZL6vdYTLunZelJjpIMW63DyF7eOFYjBct8cZayG5McVwkt50LltagucFdMsTa+Q8k1nXzbnEg7YlgED5Y9yN3o8gpX+jqvSOmt8aF/dUfz8HhEdcPssbBENI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QefBuxLc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J8TLGe018076;
	Tue, 19 Mar 2024 09:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=IJnOURZsUkoeLkEZ8Vk2F5OfStKLOCD+XDvw5oA/rNs=; b=Qe
	fBuxLc1WOgsrKHBVO1oqECcXzvM2GSI9nLVgoiyjNshqf25a6P5OqydFmZ5A56mz
	JOmJcdqT3m3b2VfMq1jgZP1BIzhv51FsoZma/UqoPzwrHbxVmscRh7c4nha4Hmrp
	mJYWpY7c3asHQFA/lFWt2+dSfkF5Hpsi67j4A3KkLQhmGkVc9M88xi54W4jbYgt8
	SopXsuHkj2G68DMquUELQBA2wVkdhNp8XWOvM0xh+15m91PDJADpuZFyij3K37h6
	n6XKcMSzrLWNcB6v8StMwaeRrioogTt3iKkFR77b5NWlgNf8oulmuw+MreOloDfA
	9GhX7pbDmPE7gIlInqxw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy1jhrryc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:10:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J9Am2S003864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:10:48 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 02:10:44 -0700
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
Subject: [PATCH 2/3] arm64: dts: qcom: qdu1000-idp: enable USB nodes
Date: Tue, 19 Mar 2024 14:40:19 +0530
Message-ID: <20240319091020.15137-3-quic_kbajaj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: e6YexffVuCmj8GV8Ft5bRhq_P3rISTNT
X-Proofpoint-GUID: e6YexffVuCmj8GV8Ft5bRhq_P3rISTNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxlogscore=767
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403190070

Enable both USB controllers and associated hsphy and qmp phy
nodes on QDU1000 IDP. Add the usb type B port linked with the
DWC3 USB controller switched to OTG mode and tagged with
usb-role-switch.

Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 65 ++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
index 89b84fb0f70a..26442e707b5e 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
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
@@ -500,3 +537,31 @@ &tlmm {
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


