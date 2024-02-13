Return-Path: <linux-kernel+bounces-64036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBFF853938
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A4CB2126C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204476169B;
	Tue, 13 Feb 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rp200eoX"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD62612F2;
	Tue, 13 Feb 2024 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846933; cv=fail; b=F+jE+Qp0PdoMKQqe49GjsP1kE4C5wMzWWuUYK60CMkjv/4KlFh2tovf5QlQfUcPkb9kXqDOusKm94acxXtU6qd08Is8d7yFdnJomuAw3DVLWXQBLMHke+RDMH/gRvxe6UEHzdL1JYCseou7XX3pM03h+tbH6pkKXmqHgvaOXU0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846933; c=relaxed/simple;
	bh=b85YXZq1codVFfqcS7LNQFV6mXuo6oXtOXUzADcdGIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVoQ76/6W2cHCzZ/FEaACFBtdxMTrC7P+4UB3MobtajxDRYATXIbgUT6VRg7/r3PNeFG8KcD7dZ3TMWW+BTnK3Dj3EqiYksMSNF0pmDXsmmWUxEHo/FQ8gEF/DI9gPoaUPyrBcTW2rzrFExZeQJWqr8OLSoWIUZD9uQAWY6+vTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rp200eoX; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OERDMXdD63t/oj1BnlihDfiBOLg+SDLrGp8ohDJPd2t6VCAVQzGTQJWXPluD440IT0TQY5xUNOeEefbQuN9A278t1DrBH0UsQ/GxGXOWtUP806MNTBlMrDHnM1NsKZKXSidm3KvuKvd5ZwiO9k1Wl1dmVUXNzzn9hrmoz32oLQS0p+USluMs8bVQMFQOLOi+KGRs7wghcR7fFps6XfgHYjHACAas2kwPiWLGCxBP3Zk9IeWWxcIPnwt59reot7yHQ1zhP0VuLQfblpXAlmT1Sn0V3PC+DPCx8LugVQ+bIEXjAG7N7fsoTmMo+d45wgFQRjfGEkrOaW7yx3ElXIvGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90OWFDXPgBTuhf4JBW6qxi8E0SCvgQSpWpiidMI3G+k=;
 b=CtrKqa7jzElcXjHpMh2ptLX66jSVirRagpI/XQMapUGkaqKCPRkBVO8jhAOsHszBK8eVEzuk3XduD/hi3Y396UanjjUtoITuVGNP2C3xR8+/y1FN4Wb1GJKDQn3xMycYLIQJDLBK//qRDA83S+KkG0gp7SjJli4cyO0c7Pyy1PLikOeYqRtpm9X7O1NP2HFgR7ujFo8M3CZRKjifNpWzIVCAWhWd8Bp3RyjqGVnf/Ywmu1OzEmsaH0G6nT/zjV06XlXvmfMrEOu1qUWD+FU5ruEva5IQOUGUZYMJSHwda2Qwz5hbLNiGaOpU5eu5xmLg9kwiBpOh1GuVaT7bremGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90OWFDXPgBTuhf4JBW6qxi8E0SCvgQSpWpiidMI3G+k=;
 b=rp200eoXU7RXgT8U7O/7/K+KJugUzPjvq02HKZeKcuSD24BbFxj+qGYRvgZ9g5yhvS9CcPWYZwDxC9oPqEg9AnDAM2PZOIenWLsYm4CpkAM/c5YEyvOUyNFoS52Ne7lQlN65RGw9UO2TMI/kLSV71oB4MCoD+nBv9gSNpnlfjGk=
Received: from BN9PR03CA0113.namprd03.prod.outlook.com (2603:10b6:408:fd::28)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 17:55:25 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::1a) by BN9PR03CA0113.outlook.office365.com
 (2603:10b6:408:fd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Tue, 13 Feb 2024 17:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 17:55:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 11:55:24 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Feb 2024 11:55:23 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v10 2/4] dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
Date: Tue, 13 Feb 2024 09:54:48 -0800
Message-ID: <20240213175450.3097308-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240213175450.3097308-1-tanmay.shah@amd.com>
References: <20240213175450.3097308-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b772e77-f820-4c78-22dd-08dc2cbcf4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AINfk9ashhmT88cM5xGGY/HEDdHajwy8ZlvE9h50k05p8ImtUwVZy1orPm4CN3dIQJMS5Mrn6vLC1sGaZonqcEYe0YheS+Qu9QgCvAGbzCf2ww2+VUvUJxVdEcSHTAoPN0rdQ58RoCtb38nBHRV8UuiEnXbc2RxG4bCvkDx5d7IbMRmVbsGH2r4EDVzOo7dBngOpjv+sHSnmHw9vyc8+Cz70vJn8N0szwbbSO/Z5rqathVm9ilTgCsHZPTW+4u16IJwkFW4gVs8kCBbcVR6S+3LlKhN/S/YSePmUG7ivRQGfGAMyVN/oqdZ+tNnz9L1j3Ssm9FU1qBwlJXyYpKbQWDRKpISA9LAiPPEKnnUQQRzsZkyV8v8I1m1YKSX5LzMwl+EiwDPHhsojcAuTAxBXV0TbEeXJT/djb10sXxENmYUeEOeKudFbFUm6H3dYfavhCpaBJTYbBHcpjrq7g/GxdgXazMxqQ5W0aaes+yM1yfPCnZNb6tRXopokZ1uv0Q6+ZM4WHVZOFlx41OE80U+LdaWQ+FpmkwQczJIXlM3DcC+f0xyFcEMKvv3WxI8Bv7Wnm3oI6OZi0WTJsoKwifRscw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(2906002)(70206006)(6666004)(26005)(36756003)(966005)(478600001)(356005)(8936002)(82740400003)(81166007)(336012)(2616005)(426003)(1076003)(70586007)(8676002)(4326008)(86362001)(83380400001)(44832011)(5660300002)(110136005)(54906003)(316002)(7049001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:55:25.0390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b772e77-f820-4c78-22dd-08dc2cbcf4b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692

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

Changes in v10:
  - modify number of "reg", "reg-names" and "power-domains" entries
    based on cluster mode
  - Add extra optional atcm and btcm in "reg" property for lockstep mode
  - Add "reg-names" for extra optional atcm and btcm for lockstep mode
  - Drop previous Ack as bindings has new change

Changes in v9:
  - None
Changes in v8:
  - None
Changes in v7:
  - None
Changes in v6:
  - None
Changes in v5:
  - None

Changes in v4:
  - Use address-cells and size-cells value 2
  - Modify ranges property as per new value of address-cells
    and size-cells
  - Modify child node "reg" property accordingly 
  - Remove previous ack for further review

v4 link: https://lore.kernel.org/all/20230829181900.2561194-2-tanmay.shah@amd.com/

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 192 ++++++++++++++++--
 1 file changed, 170 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
index 78aac69f1060..2de74307821e 100644
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
+            enum:
+              - 1
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


