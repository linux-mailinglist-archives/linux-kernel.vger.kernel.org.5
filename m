Return-Path: <linux-kernel+bounces-120199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCE388D455
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199292E45C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149D8249FA;
	Wed, 27 Mar 2024 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dh/QFBNo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C621350;
	Wed, 27 Mar 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505089; cv=none; b=XXC0Kd7S9aCpliwu2YRBExPEKcz5qgmvaJJ47WB5Rzo5/rxvU9Pj7qJ7aHbJvlnR1XaLHySifUYI0G4C/fASswbMbC4TJOCQ9zmrLys6HcyyrSrWkIEy2uEMSbCGRPzvLf9ZiMuHAQCFvMpD2tB6evlv6TFS3GQv6o7rG4vC+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505089; c=relaxed/simple;
	bh=hKwYk3D5QSMV7OSF+Ca8/FmkQUmQItnqoBqRsQD44MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WOQE8Ev4Nn8Q+IYPoK7B3nsR4yxdUmKPnU5wGOzhVb43YtzBL5RMxYkpRnnDFD6bwGjGS9ovpOKYDXh/bYvCeBDdsyXtPsDjOoR0IG0Ew7rv6pFq9vQFVezz6pwFKj5aFu0OVFNRMxj4PJDKv4PMEB2Lwj9G4vaIHXFxjKH7/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dh/QFBNo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R1wBEX024348;
	Wed, 27 Mar 2024 02:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=XyNMUkrl4UKoqNN+iVNqP4IAueZnf1vHjoggBL7N3iM
	=; b=Dh/QFBNo+1PRzLZjmR0fdaiomQjVe/jBBsIvfWbhO+9D1Zx2gWoft9/fujg
	Jb10CnEzRPE6IvGAFUKyH9BlSxufKD5hhEgkCDxcvOJFMwP3Ih8F3YO3GMOXpS/1
	UxS9zN1UnCfOA79l8G7XWOS/D4O9Io+1BIPRcS09I8toJuBfJN7kAp+PQTBwqW0W
	1IOfVxa+RDuRPGEKm+VpfF8TAeC4LepAx8atK+JZQIWmm4BOUzIrFpiFuOXBCaIj
	Wo+EoEyBkvmNBUD+IeUurHIpK8qz4z3QWT+2Bn/6eS8CYXo8O133ROwKA6wZEUrA
	6HegMlL2NPA4Y8ekcweX1sW8VJw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x47800c3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42R24Uhu012399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:30 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 19:04:29 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 26 Mar 2024 19:04:19 -0700
Subject: [PATCH v2 2/6] arm64: dts: qcom: qcs6490-rb3gen2: Add DP output
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240326-rb3gen2-dp-connector-v2-2-a9f1bc32ecaf@quicinc.com>
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
In-Reply-To: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
To: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711505069; l=1624;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=hKwYk3D5QSMV7OSF+Ca8/FmkQUmQItnqoBqRsQD44MQ=;
 b=uyyoX2JyVCf3Z+6XMWRRwxQJ8gO8t8fYVIYbHPEdWu9EVLJuv4ouDCYCW6BDxRM4ZlbYQX6iY
 1sKdq8u8EB5DDtjqwXVQ1GyDXr0p7H5C/nedZ0gXSd7mvEvHkwuVFab
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yuXJxLpOoN0TFYQWdnmaDDu0ErL9_yJ4
X-Proofpoint-GUID: yuXJxLpOoN0TFYQWdnmaDDu0ErL9_yJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=949 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270012

The RB3Gen2 board comes with a mini DP connector, describe this, enable
MDSS, DP controller and the PHY that drives this.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 63ebe0774f1d..f90bf3518e98 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -39,6 +39,20 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	dp-connector {
+		compatible = "dp-connector";
+		label = "DP";
+		type = "mini";
+
+		hpd-gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
+
+		port {
+			dp_connector_in: endpoint {
+				remote-endpoint = <&mdss_edp_out>;
+			};
+		};
+	};
+
 	reserved-memory {
 		xbl_mem: xbl@80700000 {
 			reg = <0x0 0x80700000 0x0 0x100000>;
@@ -471,6 +485,25 @@ &gcc {
 			   <GCC_WPSS_RSCP_CLK>;
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_edp {
+	status = "okay";
+};
+
+&mdss_edp_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+
+	remote-endpoint = <&dp_connector_in>;
+};
+
+&mdss_edp_phy {
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -511,3 +544,10 @@ &usb_1_qmpphy {
 &wifi {
 	memory-region = <&wlan_fw_mem>;
 };
+
+/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
+
+&edp_hot_plug_det {
+	function = "gpio";
+	bias-disable;
+};

-- 
2.25.1


