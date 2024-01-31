Return-Path: <linux-kernel+bounces-45994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348F8438FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D461F2205C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E689359149;
	Wed, 31 Jan 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ltvS7C+9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE238651B6;
	Wed, 31 Jan 2024 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689639; cv=none; b=ZpjXs29qDUttvD4wPmDEie7GM9v1ADadfIMoP3fvSRsuvxu/LNbrkwaEfLq1vdHzFP4X1RoNod4i3Pjnwzl4H6uucNfhOHd+5FWVW1wumLYS2QlOdgZE/PHkF3lbY+Pf6wSetvLqDNVVcdgonEhGrvz86L5019ArESRt7VgPdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689639; c=relaxed/simple;
	bh=1HrdCslaD+PWCYZtj/EJK3t8GMmTTa97jiReyQ5Vl6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqfaicIKu6K6rBvtxxhrEFymNMXQRZToc/thdRTqv6s5Z7wv9SCFRl76zmpXi2973adsXO/cNNM91jXIPe43u6RhV/FkZ2JUBLjoez7OeqyT19ma7MUfY/gAnh7i6E+C9WtEAbBdWboXOQ1bdyCohmFpM2xkfBugAQeE28VYxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ltvS7C+9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V76lOP002498;
	Wed, 31 Jan 2024 08:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=zXr0mBdB665cttRh0NuHcRK0xyTWE5xCgRUbWjlPAU8=; b=lt
	vS7C+9O5jvuRIZWVtmlMrLZzonwQZc95lD4uNJyBpWmFAwW+0sBhZ8YxfSDxXLic
	bLCF1+7o3DIjQoy4msa0UIJjc4HRUAjlQEZzm86DLPRM+n7719pWLmgU695KOwuc
	3Er78RVEMDrSaNDL5+T0YoqhqJnPmIev2N8diWdRKvHuVvP4hhiHG4ViOqOqmKh6
	lkLP/WjNBQED4EwoOVEhEbo/GImssTKGRsL+wApM4ka/GHn6L14UU7Odh/+b+xzH
	8x+OsJebZRjRmTtMHbS+ZJUX3M6LB+A3/980JfV7wl2XZi9HvR8nmZZ4ttebBm4K
	pmqeEkT92z0CLNa+BQNw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vy9nk9974-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 08:26:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V8QeIv010539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 08:26:41 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 00:26:40 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Leo Yan
	<leo.yan@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Mathieu
 Poirier" <mathieu.poirier@linaro.org>
CC: Mao Jinlong <quic_jinlmao@quicinc.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>
Subject: [PATCH v3 2/2] dt-bindings: arm: Add device-name in the coresight components
Date: Wed, 31 Jan 2024 00:26:26 -0800
Message-ID: <20240131082628.6288-3-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240131082628.6288-1-quic_jinlmao@quicinc.com>
References: <20240131082628.6288-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ykl1PGZ6S8dPye5cl1QM1JFjtE83zfvx
X-Proofpoint-ORIG-GUID: Ykl1PGZ6S8dPye5cl1QM1JFjtE83zfvx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310063

Current name of coresight component's folder consists of prefix of
the device and the id in the device list. When run 'ls' command,
we can get the register address of the device. Take CTI for example,
if we want to set the config for modem CTI, but we can't know which
CTI is modem CTI from all current information.

cti_sys0 -> ../../../devices/platform/soc@0/138f0000.cti/cti_sys0
cti_sys1 -> ../../../devices/platform/soc@0/13900000.cti/cti_sys1

Add device-name in device tree which can provide a better description
of the coresight device. It can provide the info like the system or
HW it belongs to.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../devicetree/bindings/arm/arm,coresight-catu.yaml         | 6 ++++++
 .../devicetree/bindings/arm/arm,coresight-cpu-debug.yaml    | 6 ++++++
 .../devicetree/bindings/arm/arm,coresight-cti.yaml          | 6 ++++++
 .../devicetree/bindings/arm/arm,coresight-dummy-sink.yaml   | 6 ++++++
 .../devicetree/bindings/arm/arm,coresight-dummy-source.yaml | 6 ++++++
 .../bindings/arm/arm,coresight-dynamic-funnel.yaml          | 6 ++++++
 .../bindings/arm/arm,coresight-dynamic-replicator.yaml      | 6 ++++++
 .../devicetree/bindings/arm/arm,coresight-etb10.yaml        | 6 ++++++
 .../devicetree/bindings/arm/arm,coresight-etm.yaml          | 6 ++++++
 .../bindings/arm/arm,coresight-static-funnel.yaml           | 6 ++++++
 .../bindings/arm/arm,coresight-static-replicator.yaml       | 6 ++++++
 .../devicetree/bindings/arm/arm,coresight-stm.yaml          | 6 ++++++
 .../devicetree/bindings/arm/arm,coresight-tmc.yaml          | 6 ++++++
 .../devicetree/bindings/arm/arm,coresight-tpiu.yaml         | 6 ++++++
 .../devicetree/bindings/arm/qcom,coresight-tpda.yaml        | 6 ++++++
 .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml        | 6 ++++++
 16 files changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
index 2bae06eed693..a4d20aad0c70 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
@@ -44,6 +44,12 @@ properties:
       - const: arm,coresight-catu
       - const: arm,primecell
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
index 0a6bc03ebe00..6094cc9cb834 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
@@ -39,6 +39,12 @@ properties:
       - const: arm,coresight-cpu-debug
       - const: arm,primecell
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
index 2d5545a2b49c..21c3c4fb71a6 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
@@ -88,6 +88,12 @@ properties:
           - const: arm,coresight-cti
           - const: arm,primecell
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
index c960c8e0a9a5..c2c3f4a743f2 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
@@ -39,6 +39,12 @@ properties:
     enum:
       - arm,coresight-dummy-sink
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   in-ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
index 6745b4cc8f1c..6b3ba3c0cedb 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
@@ -38,6 +38,12 @@ properties:
     enum:
       - arm,coresight-dummy-source
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   out-ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
index 44a1041cb0fc..a47c30e6da97 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
@@ -41,6 +41,12 @@ properties:
       - const: arm,coresight-dynamic-funnel
       - const: arm,primecell
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
index 03792e9bd97a..feb800a95ee5 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
@@ -41,6 +41,12 @@ properties:
       - const: arm,coresight-dynamic-replicator
       - const: arm,primecell
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
index 90679788e0bf..5bf173982019 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
@@ -41,6 +41,12 @@ properties:
       - const: arm,coresight-etb10
       - const: arm,primecell
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
index 01200f67504a..20c0e5394ea0 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
@@ -60,6 +60,12 @@ properties:
           Embedded Trace Macrocell (version 4.x), with system register access only
         const: arm,coresight-etm4x-sysreg
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
index cc8c3baa79b4..ddecf2a9cbc6 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
@@ -27,6 +27,12 @@ properties:
   compatible:
     const: arm,coresight-static-funnel
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   power-domains:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
index 1892a091ac35..d10f2fbcab68 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
@@ -27,6 +27,12 @@ properties:
   compatible:
     const: arm,coresight-static-replicator
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   power-domains:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
index 378380c3f5aa..c964a01c5bd6 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
@@ -43,6 +43,12 @@ properties:
       - const: arm,coresight-stm
       - const: arm,primecell
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 2
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
index cb8dceaca70e..825d24c1c263 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
@@ -42,6 +42,12 @@ properties:
       - const: arm,coresight-tmc
       - const: arm,primecell
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
index 61a0cdc27745..3959c3ae6244 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
@@ -41,6 +41,12 @@ properties:
       - const: arm,coresight-tpiu
       - const: arm,primecell
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
index ea3c5db6b52d..6c94c47a05d4 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -54,6 +54,12 @@ properties:
       - const: qcom,coresight-tpda
       - const: arm,primecell
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     minItems: 1
     maxItems: 2
diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 61ddc3b5b247..f9c73c26daa8 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -40,6 +40,12 @@ properties:
       - const: qcom,coresight-tpdm
       - const: arm,primecell
 
+  device-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     minItems: 1
     maxItems: 2
-- 
2.41.0


