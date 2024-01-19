Return-Path: <linux-kernel+bounces-30997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCAD832746
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0FA1C22BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3173CF4E;
	Fri, 19 Jan 2024 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XC2zJDO1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260C3CF48;
	Fri, 19 Jan 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658831; cv=none; b=otwPJCrhR2vOwfM76V1dXu013waFojuM6i+I/ilOtFCLa9AHnh3+ZpfxixyYJwOZQ5vqjMFMNDeT4CsQfGs/XdWl5LOJXAMe6afbUGJ9xxCxDCgl8PsgKm+qLxdqglIJCN6LX9r7KT31VtKYOjke7LXjSTlEgF0wI32e/qlGvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658831; c=relaxed/simple;
	bh=10Dd8D0ej6wO+dukLmP09V5+oihbqymK6k0R3hvx8v0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNdC+sujSzMQipvMOaqzYWPuhUG5ADeWjXoHOc5zHUxmNmZc/0PdIYCiNMJZfo7ZGFBS+/35e1qEDz2d7Bi8pGf4M1bHoFguxKos0Oz5Da6POgCZUQFJdT9A8Vc9PLd9jMcQoOA7Xq/5ZAl2Y+MWNxjUO4MHwxms2+GUgsZNkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XC2zJDO1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J9axHo022006;
	Fri, 19 Jan 2024 10:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=HCgvHUisprq5+tCPj7gi
	0SpzXY1/jiO5lRnarDV+9rk=; b=XC2zJDO1iw9RlPUy0qRWl0FTGmMlLRmaR7SA
	35Qmikm3h8J/KhISump6ZcFzXS1N66dcGiKLi85BD2pN0f/8qzHbgYyXurN+a9T2
	BwYu/j3Zt4gm8nkIH4dmgTXZjvch6oDO7xnIdmYNxHeIjQdk6IvoRnixkm2rKJsn
	FnN2Ss3pgJTThPWPFex6rx1fSRMP7scrHB1wFKzhHpwOnLq/IrQo9Zk9rMv1vI1u
	lF1yd8c8FK7mD6Mhg6WIozWZkneEeLZaGtk8vaH+okZtsUaek+E/n/oLtVDIEM6K
	FRJJLzG4lymVQItD3irkTb0AxfxJ00UwzdW4Mrgn9y2+QbwF6w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqpkvg1su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:07:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JA72bx006449
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:07:02 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 02:06:56 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>
Subject: [PATCH v4 1/6] dt-bindings: arm: qcom: Document QCM8550, QCS8550 SoC and board
Date: Fri, 19 Jan 2024 18:06:16 +0800
Message-ID: <20240119100621.11788-2-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240119100621.11788-1-quic_tengfan@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AyZTR0XjHTrzLVNYqc4p6-Og5L3Oot52
X-Proofpoint-ORIG-GUID: AyZTR0XjHTrzLVNYqc4p6-Og5L3Oot52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=909 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401190044

Document QCM8550, QCS8550 SoC and the AIM300 AIoT board bindings.
QCS8550 and QCM8550 processor combines powerful computing, extreme edge
AI processing, Wi-Fi 7, and robust video and graphics for a wide range
of use cases for the Internet of Things (IoT). QCS8550 is a QCS version
for QCM8550. Modem RF only in QCM8550 but not in QCS8550.
AIM300 Series is a highly optimized family of modules designed to
support AIoT applications. The module is mounted onto Qualcomm AIoT
carrier board to support verification, evaluation and development. It
integrates QCS8550 SoC, UFS and PMIC chip etc.
AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..9cee874a8eae 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -49,8 +49,10 @@ description: |
         msm8996
         msm8998
         qcs404
+        qcs8550
         qcm2290
         qcm6490
+        qcm8550
         qdu1000
         qrb2210
         qrb4210
@@ -93,6 +95,7 @@ description: |
   The 'board' element must be one of the following strings:
 
         adp
+        aim300-aiot
         cdp
         dragonboard
         idp
@@ -904,6 +907,14 @@ properties:
           - const: qcom,qcs404-evb
           - const: qcom,qcs404
 
+      - items:
+          - enum:
+              - qcom,qcs8550-aim300-aiot
+          - const: qcom,qcs8550-aim300
+          - const: qcom,qcs8550
+          - const: qcom,qcm8550
+          - const: qcom,sm8550
+
       - items:
           - enum:
               - qcom,sa8155p-adp
-- 
2.17.1


