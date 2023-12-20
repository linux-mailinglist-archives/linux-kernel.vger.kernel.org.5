Return-Path: <linux-kernel+bounces-6403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87AB819872
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363FF1F27768
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067618AF6;
	Wed, 20 Dec 2023 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cFZW3QBZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5D13AC4;
	Wed, 20 Dec 2023 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK452vR020735;
	Wed, 20 Dec 2023 06:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=cF2AFQd/o4DUV3N3/91P
	lROqR7ALzxo9WQC1QyEvWAI=; b=cFZW3QBZ7AVrpWeJCEP66jNBdwrsib2onVdF
	iMtZwqhhYhSMefUA088AIdjJW+dq3rPYZ1hWlKvgaBwWLbRpfHPVd/VmeMnzY9ps
	4QcmxKxHb3oTa70O6DBzxuI8psngsmWO1Gl8+o8kyY/+KHsL5QW2n+VRvEvCT8T6
	uygrPOa4qIIO95o7dpXpE7pgUNBO7tzztCACTj2uh41flh/nJWGKc7OSkzMrrxSx
	Di7WJD+/3TiW4+6hETSzQDd18Sz1tuGyZMGhHevz8XvGsz+aDinPIRAamCM/cvpM
	ZovcNnHxHPPTWK51gqhw7jDzks4N+Ct3PTgkUgAJhiEjO+E4aA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3fed9b24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 06:02:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK62kFJ027879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 06:02:46 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 22:02:45 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>
CC: <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v3 1/9] dt-bindings: iommu: Add Translation Buffer Unit bindings
Date: Tue, 19 Dec 2023 22:02:28 -0800
Message-ID: <20231220060236.18600-2-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231220060236.18600-1-quic_c_gdjako@quicinc.com>
References: <20231220060236.18600-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X3WyVrKETlAt236d3zOk-UEpn75QNLfH
X-Proofpoint-ORIG-GUID: X3WyVrKETlAt236d3zOk-UEpn75QNLfH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200038

The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
of the SMMU-500, that consists of a single TCU (Translation Control
Unit) and multiple TBUs (Translation Buffer Units). The TCU is already
being described in the generic SMMU DT schema. Add bindings for the
TBUs to describe their properties and resources that needs to be
managed in order to operate them.

In this DT schema, the TBUs are modelled as child devices of the TCU
and each of them is described with it's register space, clocks, power
domains, interconnects etc.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 31 ++++++++
 .../bindings/iommu/qcom,qsmmuv500-tbu.yaml    | 77 +++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a4042ae24770..a610af2c7e5e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -235,6 +235,27 @@ properties:
       enabled for any given device.
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  '#address-cells':
+    enum: [ 1, 2 ]
+
+  '#size-cells':
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+patternProperties:
+  "^tbu@[0-9a-f]+":
+    description: The TBU child node(s)
+    type: object
+
+    properties:
+      stream-id-range:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: Stream ID range (address and size) that is assigned by the TBU
+        items:
+          minItems: 2
+          maxItems: 2
+
 required:
   - compatible
   - reg
@@ -312,6 +333,16 @@ allOf:
                     through the TCU's programming interface.
                 - description: bus clock required for the smmu ptw
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sdm845-smmu-500
+    then:
+      patternProperties:
+        "^tbu@[0-9a-f]+":
+          $ref: qcom,qsmmuv500-tbu.yaml
+
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
new file mode 100644
index 000000000000..c4f148ae5f38
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/qcom,qsmmuv500-tbu.yaml#
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
+  instances distributes with each client core.
+
+properties:
+
+  compatible:
+    const: qcom,qsmmuv500-tbu
+
+  reg:
+    items:
+      - description: Address and size of the TBU's register space.
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
+  stream-id-range:
+    $ref: "arm,smmu.yaml#/patternProperties/^tbu@[0-9a-f]+/properties/stream-id-range"
+
+required:
+  - compatible
+  - reg
+  - stream-id-range
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,sdm845.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    apps_smmu: iommu@15000000 {
+        compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
+        reg = <0x15000000 0x80000>;
+        ranges = <0 0 0 0 0xffffffff>;
+        #iommu-cells = <2>;
+        #global-interrupts = <1>;
+        interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        anoc_1_pcie_tbu: tbu@150e1000 {
+            compatible = "qcom,qsmmuv500-tbu";
+            reg = <0x0 0x150e1000 0x0 0x1000>;
+            clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+            interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+                             &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+            power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
+            stream-id-range = <0x1c00 0x400>;
+        };
+    };
+
+...

