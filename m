Return-Path: <linux-kernel+bounces-135922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B089CD1D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E591F22F61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CE714901C;
	Mon,  8 Apr 2024 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IEp/h9EI"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97D14831F;
	Mon,  8 Apr 2024 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609647; cv=fail; b=nTIQzXlq5pqdaa5Q/zse3CaurdIu9hguCwlPaIh27kFBVvNS1cG/h5UFOklM75MPVJ/aFyjzIfemvgYAC2PBAW4/3xhI5CJeI1Y1BYEl/Ql0HHIQWRb+pThzwO02xGWZHOsc76qdAIwXAIEqK/98i9bc/D080EibXikQYZj//oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609647; c=relaxed/simple;
	bh=8ZZrpmBFiVs0ZWMuORm4Wup8HAUd6f7eKyEUueN5so8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4HomPK3KbssmASJPVOz16Tnv/YGbsiNePVSPL+Gd3DAiFtFEmjdEM8dncFPc7gvUUWzVUAiAQFLRarqNhaJRT8pVdnC0q6gO/pYvtn9elNP6D/u64D4trMFQ38ePsGL6UljK/dEdd6ZJo1NaAwqMqD82Ih7z5NVQvpPr4LZPdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IEp/h9EI; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvpmckjuBwhDO0MBDwKIevpqBE81USRARnndQhUdkmDVvv2w6/Db7n2J49a380zS2iMcqI22cwsQ75aySCcNsDXTIUH2r5Uzo2l80zWHCJqr4p26sPLGZXsQKxRmG6641mDa6JDk90S8es9kdgu0DN/VqlCXOEpRVQ+w4m7FFncpJDUpepWyxF4/Arw4d1yhRxEIRfeoMzAb3NarbOiwCkbpstQOwd49mNuLSLWC/w/JHtYg9qAzcC7pgAozDXarWcmEJqCrmoPm9PojmEa8blUHqqflJPeyfw89WTRJINjHogPCVqv/GmboZ84a029mz7Sd/9gRjsgkEZFZfDMqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur25LDUKgB1KdOPmUn07iALbHBVEjUwuULOcEPO0zc0=;
 b=DUDdWa+JFwUYgwr44TsZAGHUnJGkCanu50UZynLQaQW+56+OD/gDHfXV5ZVAFXMrGG5U5Tg2mzWIljfzJjBc3XeCIMq4MfoJ/8dljpNWlhcgbV4IJECOeqRaF5uRHWaMvlAs2aicQdN71G7Wu1jLVkbx0w/TxHPC1ERhoKZoqN3LCaoURj/Aboh+8YHE6LSC6xI40/2mYOrk/+eQ7aEG2PkdhZau/EZS7rBFVrIpnGEm25Y/JqkTsnKYbLKzpKgY8SrLMSvZHz8+cz8AfrhuC5xF3M3BlRqXCn3fzh3bROeCGy40/KaF/BoL73qTmnuLMH+QpQQaRvGlU/SvXWOvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur25LDUKgB1KdOPmUn07iALbHBVEjUwuULOcEPO0zc0=;
 b=IEp/h9EIxKaZCD7eRGCPCkGc8dXAGZwUvutDDu6snZhGBv7zGoUGqFU+PURzmTV0ao7pWkC6X2WHa67bpyzA9JtxWBix0bEPrp0VXvHykfbuxDHcMAtKthGLiD21Yq82CUYbNAYuSYblBlH4rbk9buwbhXky9+PpMzzS2abdPaA=
Received: from BN9PR03CA0354.namprd03.prod.outlook.com (2603:10b6:408:f6::29)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.47; Mon, 8 Apr
 2024 20:54:01 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::77) by BN9PR03CA0354.outlook.office365.com
 (2603:10b6:408:f6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 8 Apr 2024 20:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 20:54:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 15:54:00 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 8 Apr 2024 15:53:59 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v14 2/4] dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
Date: Mon, 8 Apr 2024 13:53:12 -0700
Message-ID: <20240408205313.3552165-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408205313.3552165-1-tanmay.shah@amd.com>
References: <20240408205313.3552165-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9ce956-d87b-4afa-f629-08dc580e04ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yzvj77d4DGdWpl8IdjlCC00YNMOa7KcgIbDDjTUUV0hmq6CMaRxTET/YHF5J12CAxgvHsr8lgbAHb1MzHxs2Qz+QaBiNjQ8w+B3dWFrIU3qN0AoYz8DgDaF4+wIdHvRkcle2t4NEklUCKHYS4lM7PKdxn9rzhwe9K/PJ/bmyo+CZWNwFQk3D15sjX76gpPGNTw9jQqk1kdygLNFfApWEKoskGxyk3PjF8ZXPCbLEE/Fn57uXs7Am28QbSfcJbuW0TMUTP4ZI9fvS8MFJ5qo3Eh4kbambnQoQ99psrsWLnfmgwwWkuS5jnEnv0p/FcnEom7e8o6loiUl7IqgKV1sEYwPapej9Be+4vJ9BhEtjXnJkkpMbH1Hv2e0h6o/SIugUjXrdAFFbjyzh2ERkH7g0Ec97bi6EA0Qlnan0eMhGimI9sVVbUBJ6O0OBIjYSQTRPBXdQA6tWHESEler2rhcjh84ccF8Y8fTPZAvQgRvBtDBv4PWZ+JHfNE1Bta3Wl6G2IF2Up3eo68oW6WqR6Zgj+8gwvFXUll2UYrd4pWu+2mVm2E7ms3wfYc9nKSyjDJ97n9ddyhA9myZkkVFqkGc01g4z2a9M8xUstj6nyx9sTvoEzrZmWi1Jj0MQe093o++6r+NANgkoDzUlAYlgkSa0cNwR3xgNPEgAfyGy3jnQmsewW+fyEVwVFpOMd0MBc9R5kSx7Ovlc6X1KMy8nMGlb6kGFQh1UaBA3fwbMK/WBzc7MGSCuh6NfcWvWYrEVHoK4
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 20:54:01.4386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9ce956-d87b-4afa-f629-08dc580e04ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Introduce bindings for TCM memory address space on AMD-xilinx Zynq
UltraScale+ platform. It will help in defining TCM in device-tree
and make it's access platform agnostic and data-driven.

Tightly-coupled memories(TCMs) are low-latency memory that provides
predictable instruction execution and predictable data load/store
timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
banks on the ATCM and BTCM ports, for a total of 128 KB of memory.

The TCM resources(reg, reg-names and power-domain) are documented for
each TCM in the R5 node. The reg and reg-names are made as required
properties as we don't want to hardcode TCM addresses for future
platforms and for zu+ legacy implementation will ensure that the
old dts w/o reg/reg-names works and stable ABI is maintained.

It also extends the examples for TCM split and lockstep modes.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>

---

Changes in v14:
  - Remove previous RB tag
  - Add xlnx,tcm-mode property
  - Add Versal platform support
  - Add Versal-NET platform support

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 279 ++++++++++++++++--
 1 file changed, 257 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
index 78aac69f1060..6f13da11f593 100644
--- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
@@ -18,11 +18,26 @@ description: |
 
 properties:
   compatible:
-    const: xlnx,zynqmp-r5fss
+    enum:
+      - xlnx,zynqmp-r5fss
+      - xlnx,versal-r5fss
+      - xlnx,versal-net-r52fss
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges:
+    description: |
+      Standard ranges definition providing address translations for
+      local R5F TCM address spaces to bus addresses.
 
   xlnx,cluster-mode:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2]
+    default: 1
     description: |
       The RPU MPCore can operate in split mode (Dual-processor performance), Safety
       lock-step mode(Both RPU cores execute the same code in lock-step,
@@ -36,8 +51,16 @@ properties:
       1: lockstep mode (default)
       2: single cpu mode
 
+  xlnx,tcm-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description: |
+      Configure RPU TCM
+      0: split mode
+      1: lockstep mode
+
 patternProperties:
-  "^r5f-[a-f0-9]+$":
+  "^r(.*)@[0-9a-f]+$":
     type: object
     description: |
       The RPU is located in the Low Power Domain of the Processor Subsystem.
@@ -52,10 +75,22 @@ patternProperties:
 
     properties:
       compatible:
-        const: xlnx,zynqmp-r5f
+        enum:
+          - xlnx,zynqmp-r5f
+          - xlnx,versal-r5f
+          - xlnx,versal-net-r52f
+
+      reg:
+        minItems: 1
+        maxItems: 4
+
+      reg-names:
+        minItems: 1
+        maxItems: 4
 
       power-domains:
-        maxItems: 1
+        minItems: 2
+        maxItems: 5
 
       mboxes:
         minItems: 1
@@ -101,35 +136,235 @@ patternProperties:
 
     required:
       - compatible
+      - reg
+      - reg-names
       - power-domains
 
-    unevaluatedProperties: false
-
 required:
   - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,versal-net-r52fss
+    then:
+      properties:
+        xlnx,tcm-mode: false
+
+      patternProperties:
+        "^r52f@[0-9a-f]+$":
+          type: object
+
+          properties:
+            reg:
+              minItems: 1
+              items:
+                - description: ATCM internal memory
+                - description: BTCM internal memory
+                - description: CTCM internal memory
+
+            reg-names:
+              minItems: 1
+              items:
+                - const: atcm0
+                - const: btcm0
+                - const: ctcm0
+
+            power-domains:
+              minItems: 2
+              items:
+                - description: RPU core power domain
+                - description: ATCM power domain
+                - description: BTCM power domain
+                - description: CTCM power domain
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,zynqmp-r5fss
+              - xlnx,versal-r5fss
+    then:
+      if:
+        properties:
+          xlnx,cluster-mode:
+            enum: [1, 2]
+      then:
+        properties:
+          xlnx,tcm-mode:
+            enum: [1]
+
+        patternProperties:
+          "^r5f@[0-9a-f]+$":
+            type: object
+
+            properties:
+              reg:
+                minItems: 1
+                items:
+                  - description: ATCM internal memory
+                  - description: BTCM internal memory
+                  - description: extra ATCM memory in lockstep mode
+                  - description: extra BTCM memory in lockstep mode
+
+              reg-names:
+                minItems: 1
+                items:
+                  - const: atcm0
+                  - const: btcm0
+                  - const: atcm1
+                  - const: btcm1
+
+              power-domains:
+                minItems: 2
+                items:
+                  - description: RPU core power domain
+                  - description: ATCM power domain
+                  - description: BTCM power domain
+                  - description: second ATCM power domain
+                  - description: second BTCM power domain
+
+        required:
+          - xlnx,tcm-mode
+
+      else:
+        properties:
+          xlnx,tcm-mode:
+            enum: [0]
+
+        patternProperties:
+          "^r5f@[0-9a-f]+$":
+            type: object
+
+            properties:
+              reg:
+                minItems: 1
+                items:
+                  - description: ATCM internal memory
+                  - description: BTCM internal memory
+
+              reg-names:
+                minItems: 1
+                items:
+                  - const: atcm0
+                  - const: btcm0
+
+              power-domains:
+                minItems: 2
+                items:
+                  - description: RPU core power domain
+                  - description: ATCM power domain
+                  - description: BTCM power domain
+
+        required:
+          - xlnx,tcm-mode
 
 additionalProperties: false
 
 examples:
   - |
-    remoteproc {
-        compatible = "xlnx,zynqmp-r5fss";
-        xlnx,cluster-mode = <1>;
-
-        r5f-0 {
-            compatible = "xlnx,zynqmp-r5f";
-            power-domains = <&zynqmp_firmware 0x7>;
-            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
-            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
-            mbox-names = "tx", "rx";
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+
+    // Split mode configuration
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        remoteproc@ffe00000 {
+            compatible = "xlnx,zynqmp-r5fss";
+            xlnx,cluster-mode = <0>;
+            xlnx,tcm-mode = <0>;
+
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
+                     <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
+                     <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
+                     <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
+
+            r5f@0 {
+                compatible = "xlnx,zynqmp-r5f";
+                reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
+                reg-names = "atcm0", "btcm0";
+                power-domains = <&zynqmp_firmware PD_RPU_0>,
+                                <&zynqmp_firmware PD_R5_0_ATCM>,
+                                <&zynqmp_firmware PD_R5_0_BTCM>;
+                memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
+                                <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+                mbox-names = "tx", "rx";
+            };
+
+            r5f@1 {
+                compatible = "xlnx,zynqmp-r5f";
+                reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+                reg-names = "atcm0", "btcm0";
+                power-domains = <&zynqmp_firmware PD_RPU_1>,
+                                <&zynqmp_firmware PD_R5_1_ATCM>,
+                                <&zynqmp_firmware PD_R5_1_BTCM>;
+                memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
+                                <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+                mbox-names = "tx", "rx";
+            };
         };
+    };
+
+  - |
+    //Lockstep configuration
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        remoteproc@ffe00000 {
+            compatible = "xlnx,zynqmp-r5fss";
+            xlnx,cluster-mode = <1>;
+            xlnx,tcm-mode = <1>;
+
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
+                     <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
+                     <0x0 0x10000 0x0 0xffe10000 0x0 0x10000>,
+                     <0x0 0x30000 0x0 0xffe30000 0x0 0x10000>;
+
+            r5f@0 {
+                compatible = "xlnx,zynqmp-r5f";
+                reg = <0x0 0x0 0x0 0x10000>,
+                      <0x0 0x20000 0x0 0x10000>,
+                      <0x0 0x10000 0x0 0x10000>,
+                      <0x0 0x30000 0x0 0x10000>;
+                reg-names = "atcm0", "btcm0", "atcm1", "btcm1";
+                power-domains = <&zynqmp_firmware PD_RPU_0>,
+                                <&zynqmp_firmware PD_R5_0_ATCM>,
+                                <&zynqmp_firmware PD_R5_0_BTCM>,
+                                <&zynqmp_firmware PD_R5_1_ATCM>,
+                                <&zynqmp_firmware PD_R5_1_BTCM>;
+                memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
+                                <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+                mbox-names = "tx", "rx";
+            };
 
-        r5f-1 {
-            compatible = "xlnx,zynqmp-r5f";
-            power-domains = <&zynqmp_firmware 0x8>;
-            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
-            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
-            mbox-names = "tx", "rx";
+            r5f@1 {
+                compatible = "xlnx,zynqmp-r5f";
+                reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+                reg-names = "atcm0", "btcm0";
+                power-domains = <&zynqmp_firmware PD_RPU_1>,
+                                <&zynqmp_firmware PD_R5_1_ATCM>,
+                                <&zynqmp_firmware PD_R5_1_BTCM>;
+                memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
+                                <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+                mbox-names = "tx", "rx";
+            };
         };
     };
 ...
-- 
2.25.1


