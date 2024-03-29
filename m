Return-Path: <linux-kernel+bounces-125434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBA88925E4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A2D1C21A73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90ED13A888;
	Fri, 29 Mar 2024 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RlEAZ4XF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597BB13DDDF;
	Fri, 29 Mar 2024 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746448; cv=none; b=BHQXNAauOL7kN3xySj04THkEZFp6cs8JgUxVC87axIKVVoJBLmxX31Ckxa408FH9FK5+9JbOVRtWN5yXGdGEePqxf6okECp30ZiwamUYAp5h9az2oFvrn2T+R29xlCpCS1gRfe1w3VjdUfggRExItdY8EsMEX2xYqKK3UHZp0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746448; c=relaxed/simple;
	bh=JPhRmvU6/OOV83yBCS7YQHfqQmoF9oYIfLw2gmy/0gU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrZIutyxF4kCMepjiKDEGVoiZPiL9cNss/+ExJaAsKfG8QDnPEBI58pB5dDh/6igOnsk9PKJNaFqhIF9L8n7wNUqmQX+iZXB2WM6x3rTRYezUngB0aLRO2NjJ0sj2HJHRnw+TxNV73JuQYIjhhXe3CjqAobrdnDrQ9Q0pQ+fSoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RlEAZ4XF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TIH1jW031716;
	Fri, 29 Mar 2024 21:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=L1akAeQst6w1VvIjfgQbc+ioil6Ud5+W2NJNV7WAuEw=; b=Rl
	EAZ4XFFh+feYeKlHi9GRYDeWASRv52zRUGRjMzhqMhBms1gZRJlGoNJcjl5MrxTn
	3jPpB3Yi0Cjxkb7KgZGNiNgug5mI7td+/LNH6dkLy8DRVkasSkJQiY2bn8UnnF40
	bVz/kvAoKKFAXmKY04g+1G2gNVtiDHnJvtKYRBvmSpDH+SjUia+ZGH4kMbpc0V8j
	xYyaLip7McaJ75DV+86Eqq/uO29PaKWrIocDOWX0s4QWgBm7eEEgUqF4qJBwil/u
	7h57lmXRj5JbtIYSQH3LLhY+mivDmt62/mGkFvczqWnW5b+846kSouvGVy51tAM5
	0X9JIDe5cvYKcS1UEO5Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5uccsk2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:07:08 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TL76Kp023827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:07:07 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 14:07:06 -0700
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <iommu@lists.linux.dev>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robdclark@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_cgoldswo@quicinc.com>, <quic_sukadev@quicinc.com>,
        <quic_pdaly@quicinc.com>, <quic_sudaraja@quicinc.com>,
        <djakov@kernel.org>
Subject: [PATCH v7 1/7] dt-bindings: iommu: Add Qualcomm TBU
Date: Fri, 29 Mar 2024 14:06:32 -0700
Message-ID: <20240329210638.3647523-2-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329210638.3647523-1-quic_c_gdjako@quicinc.com>
References: <20240329210638.3647523-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fyrjka7IF6L1ayo_RIsydfW9zr3qpjcn
X-Proofpoint-ORIG-GUID: fyrjka7IF6L1ayo_RIsydfW9zr3qpjcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290188

The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
of the SMMU-500, that consists of a single TCU (Translation Control
Unit) and multiple TBUs (Translation Buffer Units). These TBUs have
hardware debugging features that are specific and only present on
Qualcomm hardware. Represent them as independent DT nodes. List all
the resources that are needed to operate them (such as registers,
clocks, power domains and interconnects).

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 .../devicetree/bindings/iommu/qcom,tbu.yaml   | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,tbu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/qcom,tbu.yaml b/Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
new file mode 100644
index 000000000000..82dfe935573e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/qcom,tbu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm TBU (Translation Buffer Unit)
+
+maintainers:
+  - Georgi Djakov <quic_c_gdjako@quicinc.com>
+
+description:
+  The Qualcomm SMMU500 implementation consists of TCU and TBU. The TBU contains
+  a Translation Lookaside Buffer (TLB) that caches page tables. TBUs provides
+  debug features to trace and trigger debug transactions. There are multiple TBU
+  instances with each client core.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc7280-tbu
+      - qcom,sdm845-tbu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  qcom,stream-id-range:
+    description: |
+      Phandle of a SMMU device and Stream ID range (address and size) that
+      is assigned by the TBU
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle of a smmu node
+          - description: stream id base address
+          - description: stream id size
+
+required:
+  - compatible
+  - reg
+  - qcom,stream-id-range
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,sdm845.h>
+
+    tbu@150e1000 {
+        compatible = "qcom,sdm845-tbu";
+        reg = <0x150e1000 0x1000>;
+        clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+        interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+                         &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+        power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
+        qcom,stream-id-range = <&apps_smmu 0x1c00 0x400>;
+    };
+...

