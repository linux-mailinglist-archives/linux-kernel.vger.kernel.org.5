Return-Path: <linux-kernel+bounces-148582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601628A84BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8B61F23708
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50586142911;
	Wed, 17 Apr 2024 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q00dyHIf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1113F443;
	Wed, 17 Apr 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360600; cv=none; b=Slnnr12lctKR0wMwbagLvsL3qqbwsMWXDVowbz8Vu0D4a+sKMIySiXtyL6mJcb0fUAldPs6QfwZy+jOCMi3s4vFxDtzTsWF8mOtVFgnQkpXPO0xL8SI39FXCKLF5wEiMT5ygRFtVDbQsBZT2KiTu2gYJrYBxBJ3LgY6mCcnQefA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360600; c=relaxed/simple;
	bh=vxRFz7wfrZBNGmjw2CSdCD+fROMTFjSPtNmdQgbOcjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTZXNi1t4DZSUamXfl7kVmUbwXccAJ6R+olPgvrvvxmIcWiq4MfEsg3+9/PGLww7Z84OE1rlpAHK7hoCozTek9hnyw6cw5pZZg+upMdi1qGKIQBLw4zQ40zWm6ctsbfgweDjJGMj6xQuQJTagEiN0aHSzkNwP0cT9L184SSqsco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q00dyHIf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H8MS3V018641;
	Wed, 17 Apr 2024 13:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=NXSg0v0D8r4kCHR2hwTQDZZjqCujZtmCiDi/VwCG3gI=; b=Q0
	0dyHIfCgWPJ4vNxeHi1NA1iJLR+cjuBQXaS5c3BOhKAyR0eJPEyZbeBVQsl+kcXX
	pXyDcEfZFn4mc+r7+LWFvYPBYhGP0qPgXk/qQItQkpngmjHIxSVcqku9OQ9lQ0E2
	U/0FryVOY1IonaUZmHmFk43ML/cc+7FCiSY+tHCpTstUsGwf5zF0Mhbh4haliR2g
	RNDARLb8Y+uMkm8enO6EtEGE3Lad3SRTqZRAT4myCOBmJAnK4toSMA71+1D4xXzM
	Rr9wwxrZwnpFWbbbZDNDYDeFo2FHZrr57zhqlOIa43mNI+LtvS45O5eI+ULRPEJj
	obktqo60k7kdYX9fIt+Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjauprnu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:29:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HDToL6020059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:29:50 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 06:29:45 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
Subject: [PATCH V3 5/5] arm64: dts: qcom: x1e80100: Enable cpufreq
Date: Wed, 17 Apr 2024 18:58:56 +0530
Message-ID: <20240417132856.1106250-6-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417132856.1106250-1-quic_sibis@quicinc.com>
References: <20240417132856.1106250-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: LzxiClJtJvjj2sEzTLuKWkyHZQI9jsFa
X-Proofpoint-ORIG-GUID: LzxiClJtJvjj2sEzTLuKWkyHZQI9jsFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=948 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170093

Enable cpufreq on X1E80100 SoCs through the SCMI perf protocol node.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Use power-domain instead of clocks. [Sudeep/Ulf]


 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 63 ++++++++++++++++----------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index f40e95d49370..42bbe58dfbf9 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -69,8 +69,8 @@ CPU0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
-			power-domains = <&CPU_PD0>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD0>, <&scmi_dvfs 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 
 			L2_0: l2-cache {
@@ -86,8 +86,8 @@ CPU1: cpu@100 {
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
-			power-domains = <&CPU_PD1>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD1>, <&scmi_dvfs 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -97,8 +97,8 @@ CPU2: cpu@200 {
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
-			power-domains = <&CPU_PD2>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD2>, <&scmi_dvfs 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -108,8 +108,8 @@ CPU3: cpu@300 {
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
-			power-domains = <&CPU_PD3>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD3>, <&scmi_dvfs 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -119,8 +119,8 @@ CPU4: cpu@10000 {
 			reg = <0x0 0x10000>;
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
-			power-domains = <&CPU_PD4>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD4>, <&scmi_dvfs 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 
 			L2_1: l2-cache {
@@ -136,8 +136,8 @@ CPU5: cpu@10100 {
 			reg = <0x0 0x10100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
-			power-domains = <&CPU_PD5>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD5>, <&scmi_dvfs 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -147,8 +147,8 @@ CPU6: cpu@10200 {
 			reg = <0x0 0x10200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
-			power-domains = <&CPU_PD6>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD6>, <&scmi_dvfs 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -158,8 +158,8 @@ CPU7: cpu@10300 {
 			reg = <0x0 0x10300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
-			power-domains = <&CPU_PD7>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD7>, <&scmi_dvfs 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -169,8 +169,8 @@ CPU8: cpu@20000 {
 			reg = <0x0 0x20000>;
 			enable-method = "psci";
 			next-level-cache = <&L2_2>;
-			power-domains = <&CPU_PD8>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD8>, <&scmi_dvfs 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 
 			L2_2: l2-cache {
@@ -186,8 +186,8 @@ CPU9: cpu@20100 {
 			reg = <0x0 0x20100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_2>;
-			power-domains = <&CPU_PD9>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD9>, <&scmi_dvfs 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -197,8 +197,8 @@ CPU10: cpu@20200 {
 			reg = <0x0 0x20200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_2>;
-			power-domains = <&CPU_PD10>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD10>, <&scmi_dvfs 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -208,8 +208,8 @@ CPU11: cpu@20300 {
 			reg = <0x0 0x20300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_2>;
-			power-domains = <&CPU_PD11>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD11>, <&scmi_dvfs 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -309,6 +309,21 @@ scm: scm {
 			interconnects = <&aggre2_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
+
+		scmi {
+			compatible = "arm,scmi";
+			mboxes = <&cpucp_mbox 0>, <&cpucp_mbox 2>;
+			mbox-names = "tx", "rx";
+			shmem = <&cpu_scp_lpri0>, <&cpu_scp_lpri1>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_dvfs: protocol@13 {
+				reg = <0x13>;
+				#power-domain-cells = <1>;
+			};
+		};
 	};
 
 	clk_virt: interconnect-0 {
-- 
2.34.1


