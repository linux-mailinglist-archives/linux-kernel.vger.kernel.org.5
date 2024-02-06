Return-Path: <linux-kernel+bounces-54410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF784AEDE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A40528B7C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA43128818;
	Tue,  6 Feb 2024 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cuVw3hOv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA812880C;
	Tue,  6 Feb 2024 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203839; cv=none; b=jnY5Tus4DvhVKMWFvJtbkO6fOHfMqsek4vu1ot5b1DX+rncg5hr5sa4KdHKB5KeANJWpd8jPp2At0ORxPjvYB1OETNkcV7cqJhFM+idi1SowLD9qNkMD9pRuMozHSGPxgZK/OA648TMxhRjJh6ubDoyp+3OUA5OVNBvM1WlrrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203839; c=relaxed/simple;
	bh=5aeCt1+o9MXMelDw/lj+vKT+15nhQGe3WCu0riYfOdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usTQBiKmZ0AYzH9ItoILhpLV9kJ6ZR4uoNmWxIYB1fC/whlOXIRgsqEMW7wX+OTiCqyiWZAxWde7G5PyJ8pvf8UaXsJN25gnx0paMtHVihMmXOCwPAryjElPVtKwGkoN9nA2mtHWndMiWy28pG6RI1VzvYGLKnGgyAixbmjX4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cuVw3hOv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4162n2B1022378;
	Tue, 6 Feb 2024 07:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+9mlMHKrVAoer+pu7PXqAPtmSzppYg7g1BinlOpnG9s=; b=cu
	Vw3hOvMMRjGPrPJHKRhey7tJRJvFmMpW1LM0vzWLvnnEjibbFzDp9SCH77XwV6Ft
	N/ZRVwzFyw0CAulz4QXU5T1RJvErA+wzWGk2I/Kv++h6mKj+GASsASPik6S1NnUH
	ZjYJwpem1U11dpvYpfK+++CQzLwKeA4xb8tbllnMPotNwrwpRwNSN2BFd39zP05b
	p6HrUvC4bC9Hpu04gjQ9kE3Ss8GOgQ2JuTYveqsXUcJHLBFuf4q8DhHuO0bMwd79
	OzpO+vITz9F7gZNpb/PxXr7MK7Cu60YdOgXoMvDiMhTsnI3/y9SF29SLf7PQlx4U
	c5YJ0ExJEJKjZ7BWcXfw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3cafre1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 07:16:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4167G9xn009524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 07:16:09 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 23:16:06 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/5] dt-bindings: arm: msm: Add llcc Broadcast_AND register region
Date: Mon, 5 Feb 2024 23:15:52 -0800
Message-ID: <53ba029fb1e3f66505b9f6487030e5d981e1621f.1707202761.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1707202761.git.quic_uchalich@quicinc.com>
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JktFPk2LbXJMACOpKgr4KQTPPmbJtLR5
X-Proofpoint-GUID: JktFPk2LbXJMACOpKgr4KQTPPmbJtLR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=804 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060049

The LLCC driver in SM8450, SM8550 and SM8650 have a new register
space for Broadcast_AND region. This is used to check that all
channels have bit set to "1", mainly in SCID activation/deactivation.

Previously we were mapping only the Broadcast_OR region assuming
there was only one broadcast register region. Now we also map
Broadcast_AND region.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/cache/qcom,llcc.yaml  | 41 +++++++++++++++----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 07ccbda4a0ab..b12ac4308284 100644
--- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -141,8 +141,31 @@ allOf:
               - qcom,sm8150-llcc
               - qcom,sm8250-llcc
               - qcom,sm8350-llcc
+    then:
+      properties:
+        reg:
+          items:
+            - description: LLCC0 base register region
+            - description: LLCC1 base register region
+            - description: LLCC2 base register region
+            - description: LLCC3 base register region
+            - description: LLCC broadcast base register region
+        reg-names:
+          items:
+            - const: llcc0_base
+            - const: llcc1_base
+            - const: llcc2_base
+            - const: llcc3_base
+            - const: llcc_broadcast_base
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,sm8450-llcc
               - qcom,sm8550-llcc
+              - qcom,sm8650-llcc
     then:
       properties:
         reg:
@@ -151,7 +174,8 @@ allOf:
             - description: LLCC1 base register region
             - description: LLCC2 base register region
             - description: LLCC3 base register region
-            - description: LLCC broadcast base register region
+            - description: LLCC broadcast OR register region
+            - description: LLCC broadcast AND register region
         reg-names:
           items:
             - const: llcc0_base
@@ -159,6 +183,7 @@ allOf:
             - const: llcc2_base
             - const: llcc3_base
             - const: llcc_broadcast_base
+            - const: llcc_broadcast_and_base
 
 additionalProperties: false
 
@@ -170,13 +195,13 @@ examples:
         #address-cells = <2>;
         #size-cells = <2>;
 
-        system-cache-controller@1100000 {
-            compatible = "qcom,sdm845-llcc";
-            reg = <0 0x01100000 0 0x50000>, <0 0x01180000 0 0x50000>,
-                <0 0x01200000 0 0x50000>, <0 0x01280000 0 0x50000>,
-                <0 0x01300000 0 0x50000>;
+        system-cache-controller@25000000 {
+            compatible = "qcom,sm8550-llcc";
+            reg = <0 0x25200000 0 0x200000>, <0 0x25400000 0 0x200000>,
+                <0 0x25600000 0 0x200000>, <0 0x25800000 0 0x200000>,
+                <0 0x25a00000 0 0x200000>;
             reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
-                "llcc3_base", "llcc_broadcast_base";
-            interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
+                "llcc3_base", "llcc_broadcast_base", "llcc_broadcast_and_base";
+            interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
         };
     };
-- 
2.25.1


