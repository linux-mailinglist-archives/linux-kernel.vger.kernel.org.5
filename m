Return-Path: <linux-kernel+bounces-71774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A2785AA47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC2B1F21DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DA44BAAA;
	Mon, 19 Feb 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E5SdMSmJ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FBB482F0;
	Mon, 19 Feb 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364791; cv=fail; b=Btn2vL+zCxO07pywmiTp1eLwYaoRq73ACrcuqskfXpQsMXn8wEZQo7xi0HNASyMNYjl6qNEK6XMcXEP7T3uPiHVnAoIIrhS9yArf8ReZnu4E1x8YdEJFxjIZiI1Jza+XGQ3Dn2kQ4mj6u4d/m8RnRlYH2C6UdNNCMBdGqF1w9zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364791; c=relaxed/simple;
	bh=bOhAtr5M26xutt0BDGVBP+XlV3qYDlkKPdaS/4IDKVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqQksvdsWtR7eWmnH1+VXdoE70fzMe/8qlhHlTh8HDnk6R8mXkxVUs+FCcpPDQMayXzB9rnmVBXg+ixjWamBJ3L2KdZ6xGpG2HYy/fojPw/hJ5mLes1YvFYVGCAZf3XattIQ1AiqzYIUnpnviM+2VCJ3zxhlLoGPaIwbvXazIaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E5SdMSmJ; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYiS3zCtXxYAmSLByNAwv84jfDG+P7/psWhBktTm+UQYGE+QfVyOMcbiZrVuQWILtuh54iWo+BK3Brvc2P7bBSkD7/pNxVDT7wNyHHCNz14PGaHJvGpn9JfPkweqq9XtPmm8uQP9df7Z4heG6YeUd/BxKY3C7uCsfLqVBa1zxBaSqQ+wY4XJA7RMasY2AHhYDTpiNKjs0WVvhNpH/Gy96/qc8892thL5eqHagiSLlXMRzU5Xu+yzMuQwQ+ahg5pFROdLdhL3ffOpVRRVolWigmWyh23c9lFPOOjFgJwtBw4d/isrmjRem+oWuFPbJP+qDQ1pM9cwh4PDkHq0Oa6FKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoMOKHiJjaCCXC1pt9DQr0A73HAx/1OHmX6mZ/EQI2s=;
 b=CSzholyqhYRSKjO58l27/nKc5GYnZh+ZCdvbsu2rdwjI3/ZJ/tLCTNnHnwZe2za6eXhin9vs6rQ5bV2OwrSzJrrM9WIOchrw39l4Bmh6ox401JYFNlJWxgRZDX7bcMc266+mqMR6CaOB52+C9xUQpLYCw9ZEFmDJWK8OhmpJqHu9e38jjL/BDXlcfoXZsEn1uJURXVAuuOCJxJpLO5cxz7xcN9u9K2LWEte+odRzqoT0NoogzQeqGGThYhYWco+MeT3keCc6gk7WZlMLYoBvNGPLiC+hYZ6ZSBSMYANz0KSFmQkpYfXxyXnyqNUThtquC+PGulTETfyY16Xol+QT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoMOKHiJjaCCXC1pt9DQr0A73HAx/1OHmX6mZ/EQI2s=;
 b=E5SdMSmJyZuh7wnKw5vI/F/dgxLT6PVYTe000VHznKfLoz3Mai3pFywy5CcSfYuZnpAEniCmidRBEigbEkySoUJJHTwWTyVHXabq6yrASzB4QTD6E2QpViPj81d50C/RB8Jp3D6A3m9hD7yHeSzSNXHeMJad8LCMV8NVltcanRU=
Received: from MW4PR03CA0189.namprd03.prod.outlook.com (2603:10b6:303:b8::14)
 by DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 17:46:27 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::34) by MW4PR03CA0189.outlook.office365.com
 (2603:10b6:303:b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 17:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Mon, 19 Feb 2024 17:46:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 11:46:26 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 11:46:26 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 19 Feb 2024 11:46:25 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v11 2/4] dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
Date: Mon, 19 Feb 2024 09:44:35 -0800
Message-ID: <20240219174437.3722620-8-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219174437.3722620-1-tanmay.shah@amd.com>
References: <20240219174437.3722620-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DM4PR12MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 6237078a-5e97-4eb0-4b43-08dc3172b2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FNIBzTdqwjSvtsIVar3NHBnlJVVqMPAbRHHrulMVeattc32O04q8B6URnbB0TwCCG0TuFl2Lq0dMOqLH04VdYQA5lx0zZWwox16nJIwOOSzHjixh9sdm39KrwSgHcNfpwXkGvfwGd5YIDR9GZwOhL5dkx7WMAdSc9zKdZaMgTjitdAZWPUYQAQjSfQ5SO4lSbTLhIHtRKLwJXmrIClHVMOlIjiaS2f6bIrNMozgkVWpiOMm3rehI5Xjr6Eqb1QbQpPZeRD4sXG/hQvz0wJIggzVhaOJcv2K2IDNNj5J6YIvqszY9vndj01W9QPeVSJ24Wi59Bj3M8EZXOxdVBd4b+LfW+jNKheVNAOre8sC2ESrHZPPyjTZATspTAtVYINr9oyzufNjR+wALgrCO4Wmifp5+ucQUozTg0cpOorOLkU66mONafXxsUplhp3xLNODJrHb9TXEdvJ0JWyoq44ZiSkCIQ1FRVa/q2Dzh1xUIqGqUMjTHyznP3tZwc7KVzvoFcDaMrcvlyVdIGG5oY6m7q5CX+nq9kpLibztY1kdsicHYkXuUTV7GnHioL/UHxUYx7krUhc7ambV67ycSZGgftAJx98A615hBLoJuFwLRo7EcN5pQ/hcWF4UIHTq7EKf5lDS0RsquDL7G9kfP7Qby8JAY5FWlbkI5u2KF5k6ZVUA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:46:27.4666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6237078a-5e97-4eb0-4b43-08dc3172b2d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229

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

Changes in v11:
  - Fix yamllint warning and reduce indentation as needed

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 192 ++++++++++++++++--
 1 file changed, 170 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
index 78aac69f1060..77030edf41fa 100644
--- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
@@ -20,9 +20,21 @@ properties:
   compatible:
     const: xlnx,zynqmp-r5fss
 
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
+
   xlnx,cluster-mode:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2]
+    default: 1
     description: |
       The RPU MPCore can operate in split mode (Dual-processor performance), Safety
       lock-step mode(Both RPU cores execute the same code in lock-step,
@@ -37,7 +49,7 @@ properties:
       2: single cpu mode
 
 patternProperties:
-  "^r5f-[a-f0-9]+$":
+  "^r5f@[0-9a-f]+$":
     type: object
     description: |
       The RPU is located in the Low Power Domain of the Processor Subsystem.
@@ -54,9 +66,6 @@ patternProperties:
       compatible:
         const: xlnx,zynqmp-r5f
 
-      power-domains:
-        maxItems: 1
-
       mboxes:
         minItems: 1
         items:
@@ -101,35 +110,174 @@ patternProperties:
 
     required:
       - compatible
-      - power-domains
 
-    unevaluatedProperties: false
+allOf:
+  - if:
+      properties:
+        xlnx,cluster-mode:
+          enum:
+            - 1
+    then:
+      patternProperties:
+        "^r5f@[0-9a-f]+$":
+          type: object
+
+          properties:
+            reg:
+              minItems: 1
+              items:
+                - description: ATCM internal memory
+                - description: BTCM internal memory
+                - description: extra ATCM memory in lockstep mode
+                - description: extra BTCM memory in lockstep mode
+
+            reg-names:
+              minItems: 1
+              items:
+                - const: atcm0
+                - const: btcm0
+                - const: atcm1
+                - const: btcm1
+
+            power-domains:
+              minItems: 2
+              maxItems: 5
+
+          required:
+            - reg
+            - reg-names
+            - power-domains
+
+    else:
+      patternProperties:
+        "^r5f@[0-9a-f]+$":
+          type: object
+
+          properties:
+            reg:
+              minItems: 1
+              items:
+                - description: ATCM internal memory
+                - description: BTCM internal memory
+
+            reg-names:
+              minItems: 1
+              items:
+                - const: atcm0
+                - const: btcm0
+
+            power-domains:
+              minItems: 2
+              maxItems: 3
+
+          required:
+            - reg
+            - reg-names
+            - power-domains
 
 required:
   - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
 
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


