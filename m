Return-Path: <linux-kernel+bounces-143216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7603B8A35D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE50DB21576
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D7F14F9FA;
	Fri, 12 Apr 2024 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5S8FQPdo"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD5514E2F5;
	Fri, 12 Apr 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947040; cv=fail; b=PizAolucfyNjEk6dGlFxFZtX/J9nUSERqttU8ZTME+Fi3XhmBq5lWFV7d7qIK69+JqA3ZzXpfEviyBjtE4Xi/1EbMH91h96l51l4upqqL0lbq1vWSMsqer3POraztQVIRMyPQVs/OROCXO6SgNAIkdyt6DAHFtZ7DPm6EpAqYvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947040; c=relaxed/simple;
	bh=i+SpKsQJ1joKY46DnmKtyHt/cyTkUnJiXwPWFoH0Oq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLqd/HbRcWgqIEmWoUbDpJHXlhP8ygr7oRd7aaF7W/pChUPghnF41Ug5sblxLZk4z/fevWE/8RGN8VgL+wlSIfIQ4oGfc5ZQlL6RS63pWTYkRGUa9tK4B1DO/ZAwrAsm6rdaWwfknAem4h7wVDnOngQ/44IoIyuPangFyWxhXnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5S8FQPdo; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kluA465/eQJvyGqmrugMRfSJin/PsitTxzHMZXmYzZWGpO3yV95kMf/QylUY/zagfageolhVzZcwpMgHRlPEfZSRbw1GUyQG7TfPMlZQjTn6WMQErTBK1rEWiCVExIr1he2qQbsBwbGybI/nVDGrA4s0fk/S8P8g77iaYIpD175q1kEQupQpYdIpRSysffk6D4KWHDeAzVNqirWUyDWPsyhnyMMtbZ/MC/fm03FNS82oaWwgC1fyL5z2dVRP9bomQ1VfYuFkPUCTufYoVxgavaIUnFK+DGmrq8l/h+4Eret1s+6/gZ1ewlkWo4AK6QMPrEdDFuU2HpNxvGMIb8ZVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiEACJJoZwpiy6W+LyN7teo8w1yj6MIl9bHqFwGJaIs=;
 b=nznjOuIuKiYfV6UiKvAqeOYa6gFm/2s7stX/RyRlLKX51cEyqs3AjpZ16JGmq2er76dNGvto9xkhB4Q2YdNLps/eeSJGbh2zFOt1HkfnuYISWTkAPcI6HR7oXJqj7vSK460LdLPLyd7PrTetzbO5EZgpWy9PM4Pl+/MLE/Xt4n1X7Di6dzLmJxvQ7gN5G7yI7/wvqzWDOAJBQ8ZNq48fB4EU9O24EsNyX67BnX2NRwn88JDdcCoF7YOXgdVpGMpfXKixtfwPlrHSoOCLwSIOKFHjvXlrtxE1WT5RBFhIJLNkLf8G+1GcoHo0iCx5YU+WN+nUcH1AFkKB7EWThepZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiEACJJoZwpiy6W+LyN7teo8w1yj6MIl9bHqFwGJaIs=;
 b=5S8FQPdomSyIDaLgFprfcZE1ZdwA33DqmbPuwbPJwaCVCk+nxFSjgpK69N3Nl5ExqBgOx9UfnJ982lGb8z40I2LEOkixu/tkGXYDM9PRKcu7DgsYHX491DvnU5SJOTQA4cVSiJ+32EeVnHnNsjoyxyZ47l3mcZuY8c5UvRaeT7w=
Received: from MN2PR13CA0034.namprd13.prod.outlook.com (2603:10b6:208:160::47)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 18:37:15 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::16) by MN2PR13CA0034.outlook.office365.com
 (2603:10b6:208:160::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.14 via Frontend
 Transport; Fri, 12 Apr 2024 18:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 18:37:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 13:37:13 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 13:37:12 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v15 2/4] dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
Date: Fri, 12 Apr 2024 11:37:06 -0700
Message-ID: <20240412183708.4036007-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412183708.4036007-1-tanmay.shah@amd.com>
References: <20240412183708.4036007-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a00328-29e5-4ad7-e10b-08dc5b1f9339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jI9NMY1BDjA2QD7opulg2/HJi0C2her0ySa8YpGgPmt7QCUqProaapdw9yb7i+NeJdZmX1MVKIvDXcdZIH46nNZtSHvzR21pOQEOjzzsaixBIBe/y9a99uh/jFoRmU1F2MUJ7QLn2NpjeK0RH8rk5pSyiqoY9v0GWlUr54774uK9pjE1PmrEyAQGSe14KxjmMb1nueaRUYaukAk8UlVw3xM2YXKcmGh0LoX/3hZRB4VrNlMdNFJMHvyKZxx8CiK4WRudGdp612VuszC1qCJGYGqRU3Ah1rN43vONyZ8yvgV6O2UDveOAv72oWY9IG89LkudfOvkjcNUdD1p9uLhcESY417mOGqB+EeaeEFmuiUKbhwFt70yXzLdPVzgyWwmIXWHU2VNTArYs63zMr7nSzkwi7xGQN6eioNNyQL8cBLGjErQkVnbOsA/xoWJ06h7dbjiZjvaFZDkcQZ13n+xF4MXt2k0MLPRvwIeHnko0Qw0Ios2Sr+JCItuT6dbOFw7mwY2ZraJixAKnbkZQy3of/sDLuE5bqGBxdHfYkegTuEudljsvWyAaJdVFaYDM8uTBFnJee3BEeobQI+KBKGZpqvRcTK/k4S1BcoEhm0jxzIkxy+UyThZTzML2N95gEq5brnGkSzWwAXkAKzDA2Qp1t+Ce6jGreNZ9uYe8KWioVRBSuQ7agjvu5SnI1mh0IkIwV9bI+IzQv5UlYyr5CQQJyTY1hJpLOPDh3WO0osUGjBq9S9pFRbEb2RApmPynZUlE
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 18:37:15.1456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a00328-29e5-4ad7-e10b-08dc5b1f9339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456

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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
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


