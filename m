Return-Path: <linux-kernel+bounces-88893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3E686E816
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D8E1C21AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40739AE7;
	Fri,  1 Mar 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v7NUJBcW"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664BFC2C7;
	Fri,  1 Mar 2024 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317035; cv=fail; b=tGQtKU8+96ESbWIqKL2yHamhszFxtCcavETiYK19LWHvuG1jrobRlT+KflLNChMERKm7BAIZLgDDrA+R9cY9Gyz4cE+fp7NKLUpwWfPb7l3efN57NVAm77GpjF+ru5vQyPDAKTx+IaET2L4/VWi+uehy6yvQqcuUBWf9CtQcA7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317035; c=relaxed/simple;
	bh=khKv74DYQmIxxkHDNBn/tD9EKqIjHRpGz9WIhVVYj9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6OjII6j6IXK49Vj9qEpK/03QjXrv6gw0xMaMHfdl7gXOW+i4EH4FJvKJHZfwZBLdugIf8ub4IfKnErm/IS5xN8xg67mEYag5bpzQpM5MYNuPqQRg8fXa5knmyoYjgJY4f2x9zG+yTddJsKsy3f6e9aXfPRQx0HgV/8Q8AzpvRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v7NUJBcW; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShvH/ksv9e+l/FGd7/tOtoKetF/wubgMEPFQmtwp13KuAASLi5A49cMRjqmDE+xkiZl2d9eAGBj2j1SR0fsZei379sXlS0I/clBmKp8tJybikTeeMq2lBLTLcgOuJAJGCqpXzxvLIBurQ4eJ4lK6lkDFUQsIxk2TLf/Zmi72Tn0syJoBu5wxouq+Ba9QAFMkUJGl83AbHnNJoE57LjbulrJYfPNdGPYhqR51vzRK9tfHVQuM2KVzLP4MgRaEkJZkrK353/FBu40xjQUbYgu7oOo+8qmlsdsEApYytHfElgOwn9Ts1k8lXQR9UIDO+OBmhzVwHGsEPtu6rhoBq8xfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QvdQz2M2/fLMvKSQ570m2pRkl/Vtg8xNlpHK6pkgLY=;
 b=GAJ9833o2pQavqbVeXaN2qj0hXg3TwrNqSti3csDtqgln1bVzfxT/kGSk0d3HtNREU6tPv15Okq0pZdNm8G77lCS7KV8PVIDdfFKRptp4TSPLQ8IFWZsLTt/304uH8RP5Q9Q+LlDNvlmmdRx0OLJKq3XgyounCxT5lp5k1rV9NDQ/ZSE+VPulXu3LiLT1gAAE9icQeQ+nNm62t8y2SP05l/rF3hEKQ5oJMPZdeqQl6YX/RopdwfxCtIYhS8IFrTw9CJ2a/qMvXeUeew7J4q6hW+hucxiGjfUobCnEpRLlXMEOEZMwwK11wLkIZZ4f9GC/ZpPTuhwoiO36t3toeKzdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QvdQz2M2/fLMvKSQ570m2pRkl/Vtg8xNlpHK6pkgLY=;
 b=v7NUJBcWvxjEeNnbMSnsLskD8OMPGufRNWzb2G+NMMFFHqsg1TnkkmPU2rit+J8nXJYhjHXKjE8rX2IpAMu+AlI6bo0gstZYSyEguvqN+14DK2VfaVdFebO5SFNKJy5SDaYTOSr1GKKVixT7lHA7iR+6zCaFSH47YpyX/Pt4bEc=
Received: from BN9PR03CA0666.namprd03.prod.outlook.com (2603:10b6:408:10e::11)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 18:17:09 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::27) by BN9PR03CA0666.outlook.office365.com
 (2603:10b6:408:10e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Fri, 1 Mar 2024 18:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.0 via Frontend Transport; Fri, 1 Mar 2024 18:17:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 12:17:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 12:17:08 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Mar 2024 12:17:07 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v12 2/4] dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
Date: Fri, 1 Mar 2024 10:16:36 -0800
Message-ID: <20240301181638.814215-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301181638.814215-1-tanmay.shah@amd.com>
References: <20240301181638.814215-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e33428-863f-46b1-2b19-08dc3a1bcf28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f0Zil+mV5KbWj7HO230ErDD7Ww+3c+Ij6H+CMZ/VebL3rqNnI0nU0gUoxH/jptn5wdzsHQI731tohrXY83LvyPb/tIA6bGCpRJH+EKNADE1DptSpRFiJU0u8bE2HE6ntwkWUIO2KVlZ36fKgJXf4sutaRmu+NrQrYA2zwBHRQKpijz4+478V0fWvap5Rll3TKmwKB7GND1Lt3JWQgoedqDUSEUgBA2iSGGLFmYOvpD7/40sps5nFjzbKI3Aw1ens7bShjxqnF5ONsco4vMHnWX0fv61Zgl4FRWDNFCvglf/pUsZjYOwyzg+BxTX/qSfei7LZZF4T8As6fqgeFUrinJb5Z/ZolV5Jmg1joqh5L+KJ32FV7DkRkStBwpfMKfL9IO8sDqGgPEkTuWjaGpBBGCJ+4Wp4cU3qPrCsFzLxnA8lEmkqpQ0F9ZqCekFc/7F3jMhdDdIrKwjKgOCBg/QlEqShSKmKalBf7qzKP9B9CkZ3KM3mr0kaRRCcW3T6BwoBK2qZ1KLvL6X9xEqJygpLMt4rjqsC1z4OKivAAiBJCXl17Klk32rPWlc3VZmT2TLSTn0XH0OIJeGh8hPBScDDpZF2s5ZHKr8dfwXflBjLWnRjkPBF37T+BBDkdXfhqlKWG6ins8TgHtlZcVYJ/G4cUMlD/+E/6dD/U52pPkzfJj+bxrJzaCGIqzlZHFygWnWSacxu6amCQUPMa6Pr14h/gdKd6Wcv8h45UJ+GmhZQ6uf2344J5q+9UP+rNARBOgsr
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 18:17:09.2562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e33428-863f-46b1-2b19-08dc3a1bcf28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603

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

Changes in v12:
  - add "reg", "reg-names" and "power-domains" in pattern properties
  - add "reg" and "reg-names" in required list
  - keep "power-domains" in required list as it was before the change

Changes in v11:
  - Fix yamllint warning and reduce indentation as needed

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 188 ++++++++++++++++--
 1 file changed, 168 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
index 78aac69f1060..dc6ce308688f 100644
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
@@ -54,8 +66,17 @@ patternProperties:
       compatible:
         const: xlnx,zynqmp-r5f
 
+      reg:
+        minItems: 1
+        maxItems: 4
+
+      reg-names:
+        minItems: 1
+        maxItems: 4
+
       power-domains:
-        maxItems: 1
+        minItems: 2
+        maxItems: 5
 
       mboxes:
         minItems: 1
@@ -101,35 +122,162 @@ patternProperties:
 
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
+              maxItems: 3
 
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


