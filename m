Return-Path: <linux-kernel+bounces-104929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0887D601
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BF41F21CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826F5646F;
	Fri, 15 Mar 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="myjc74FK"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B354906;
	Fri, 15 Mar 2024 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537382; cv=fail; b=BmAkTYNq4bAWjhfL4NQqp9WhPwvqKotQ1PIJuH7BsxNFgVNd4lkkff+v22Imw3eFhHPIHzBu6OZxox45falx/Z2j7VhiaU1n9tcYAkmMNv7ByySSE7tcBg95aCiNpt1QKluxId0V+gcnzdHSZszbK4KPoPm6gzTDrA2JbLDkeqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537382; c=relaxed/simple;
	bh=z3KqpNkKRaztntoLJSnJWgvVl0iUrnETM8bNoVIpjnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cm0BjZ4cIXr8mXyrCIzaEKlF2FsYmDad0Q5pRRnkz9QWIUOltwF77JFHPpu8KL9uplovTp9ekPNx9rjx2m0Ibrg1zj7m6I/uTB1i5TQcJCWnFhdDfamXcGGuV5XhlajJVMAg5CC48F09zxp6hPVnuy7RnSv364zutjSkaDi8Mp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=myjc74FK; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISDK8Repq7GdLlMrylXUNJ7b2VGa3INNGmAJ16mDVLo4qrmAeYBX6funOOBU/luqFSTFPIw3HJnZkhXokxnBLgWsp8c1R3KFwC4C/6BuYpbOh7yNylm0QQyeT/o8VY9XhkFOu8AvxKxScNvmKELdV4S5FWU/AiGhw70Z8syxbj22d23yh12eAKi8DP2PXJaKfzhg9MWOvvviOODClJLG7k73ZVkDhRJaBcDQVmJ7i8pOYOdmuPF54YL+ia5JdMM9gaaq09KeqwA3sCkw9BzB87VV5pH+ir9zZFbZZdHWN56YyOxCm5wASlAQD01DY0EfK0M/klCUk4+0HTPV+bIdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJssCQe9TrDXhZLntMGqjTNPwluFb5zaZRNw0LirUHU=;
 b=BTVrh2XgAuh+X63WLmnnWA86iU9s4MrAI5N+zYLP5G1f3aZHnJVSpt6YYUF0xWCIzdZAPp7+o7fQOAV8kIFqw/5vDQLCOGMYsdK4NrotqOLceuVXb6WVWusVWWhNtsIUWu/1hZ+esZjy7bgTpIre8dWwBdrzGfoaXb3MAIpBsyRrhWALZQBsl2yhHaJxX9KvNaflmkN7lzZgeoU2mgCV8qooDyTYFubifMmPp8LZZTMXlZlptqmpUsQoNNwMuXX6k5c5pfeQNY0lJ+x4ea6tJu8WmyZTcQM7neKzfEta90bBwp6gR48s3oIfgszl1mp9qwDrmdAeVz3sC19PXvKBRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJssCQe9TrDXhZLntMGqjTNPwluFb5zaZRNw0LirUHU=;
 b=myjc74FKpqh1JLmRhoAh9r/JOGkGXvI6UaTsLiubALkwcZedOKQXIzjyeTw6Urpd1k6uzTZOcBjCtAkrDKNW3M1R6/3OcseJg/H2F4OPachM7Mw5nTqWTiLnhAiHI6xN9C+Yx9x4ZtM8dAd351KQHPvrfUYyzRw983SvCoOeGN0=
Received: from DS7PR06CA0004.namprd06.prod.outlook.com (2603:10b6:8:2a::19) by
 SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 21:16:16 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::2f) by DS7PR06CA0004.outlook.office365.com
 (2603:10b6:8:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22 via Frontend
 Transport; Fri, 15 Mar 2024 21:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 21:16:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 16:16:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 16:16:14 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 15 Mar 2024 16:16:13 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: remoteproc: add Versal-NET platform
Date: Fri, 15 Mar 2024 14:15:32 -0700
Message-ID: <20240315211533.1996543-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240315211533.1996543-1-tanmay.shah@amd.com>
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b645f3-1737-4d3f-cc3e-08dc4535263c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9xnvtW8KX3uqsBECLrWN46284P2dAvu7u0GZ3HkrgpyJfZ+C6l63iFN/yLaFj91Nb9R2qE3h5qB95c7b4lkSlShWim74BiDPM9cAxVO3bTOCPx0W0U9NTeuqTbmevUlycVwd7/z58dZvWIHqhMvDwcd6srVFvKrwm4AJVVfdr08ZYM+A3E96DT1K5lBAKWAOhGWSgI8AYBRXX3Av9neHghq0/3K351EJldWNThynihGsTcsSX3S/QjemaTgDaC6+u3xTXHrcDsICiNCtPbvwK8NWJtZPye46QiMRd1uI5X/EXDkZLXbb+r88jzA9kyqy2QHXuBwhCjjLXFqvPrPhrEPM1dXDb2kjaYDI4sgIeF9PRyYZfSzjjVmqqTk0PsSC1ewsL7ll1fLOQ1eAmITGi5dZVAlQdJmrkmCP8ITqS5KRiKHNUVPl2nrvpZ52NNHCJkwtCg7Km3DOV1xm+5F0yS36/y9lXIgeEy3qQLlA+SRfuQh1wOjJOnBKYrgLv2281r9MelPlf+qt9/rNVr0zqjkDaKLvUaL5RD/yk/IUA5NJ8lnVz482P2kTezS8yUI1DAYHsbzwq9vX1wUMrQR6gqYMmPXCpZOLDXBeps5RgzdL/JtXxDbwXMyMLAJwz7vZ8dj8N/E8dDr0w6H/FoB9FACN/c0gr507k3CamGeANTIuogH72FQBjyj1WCxThm5hh+JfP1IqR8e6oLK+kY8Vro6xnjgvkWH5L8/0vl18a+uxR+lSRVJhdglmiSormZCL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 21:16:15.5775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b645f3-1737-4d3f-cc3e-08dc4535263c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

AMD-Xilinx Versal-NET platform is successor of Versal platform. It
contains multiple clusters of cortex-R52 real-time processing units.
Each cluster contains two cores of cortex-R52 processors. Each cluster
can be configured in lockstep mode or split mode.

Each R52 core is assigned 128KB of TCM memory. ATCM memory is 64KB, BTCM
and CTCM memoreis are 32KB each. Each TCM memory has its own dedicated
power-domain that needs to be requested before using it.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 220 +++++++++++++++---
 1 file changed, 184 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
index 711da0272250..55654ee02eef 100644
--- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
@@ -18,7 +18,9 @@ description: |
 
 properties:
   compatible:
-    const: xlnx,zynqmp-r5fss
+    enum:
+      - xlnx,zynqmp-r5fss
+      - xlnx,versal-net-r52fss
 
   "#address-cells":
     const: 2
@@ -64,7 +66,9 @@ patternProperties:
 
     properties:
       compatible:
-        const: xlnx,zynqmp-r5f
+        enum:
+          - xlnx,zynqmp-r5f
+          - xlnx,versal-net-r52f
 
       reg:
         minItems: 1
@@ -135,9 +139,11 @@ required:
 allOf:
   - if:
       properties:
-        xlnx,cluster-mode:
-          enum:
-            - 1
+        compatible:
+          contains:
+            enum:
+              - xlnx,versal-net-r52fss
+
     then:
       patternProperties:
         "^r5f@[0-9a-f]+$":
@@ -149,16 +155,14 @@ allOf:
               items:
                 - description: ATCM internal memory
                 - description: BTCM internal memory
-                - description: extra ATCM memory in lockstep mode
-                - description: extra BTCM memory in lockstep mode
+                - description: CTCM internal memory
 
             reg-names:
               minItems: 1
               items:
-                - const: atcm0
-                - const: btcm0
-                - const: atcm1
-                - const: btcm1
+                - const: atcm
+                - const: btcm
+                - const: ctcm
 
             power-domains:
               minItems: 2
@@ -166,33 +170,70 @@ allOf:
                 - description: RPU core power domain
                 - description: ATCM power domain
                 - description: BTCM power domain
-                - description: second ATCM power domain
-                - description: second BTCM power domain
+                - description: CTCM power domain
 
     else:
-      patternProperties:
-        "^r5f@[0-9a-f]+$":
-          type: object
-
-          properties:
-            reg:
-              minItems: 1
-              items:
-                - description: ATCM internal memory
-                - description: BTCM internal memory
-
-            reg-names:
-              minItems: 1
-              items:
-                - const: atcm0
-                - const: btcm0
-
-            power-domains:
-              minItems: 2
-              items:
-                - description: RPU core power domain
-                - description: ATCM power domain
-                - description: BTCM power domain
+      allOf:
+        - if:
+            properties:
+              xlnx,cluster-mode:
+                enum:
+                  - 1
+          then:
+            patternProperties:
+              "^r5f@[0-9a-f]+$":
+                type: object
+
+                properties:
+                  reg:
+                    minItems: 1
+                    items:
+                      - description: ATCM internal memory
+                      - description: BTCM internal memory
+                      - description: extra ATCM memory in lockstep mode
+                      - description: extra BTCM memory in lockstep mode
+
+                  reg-names:
+                    minItems: 1
+                    items:
+                      - const: atcm0
+                      - const: btcm0
+                      - const: atcm1
+                      - const: btcm1
+
+                  power-domains:
+                    minItems: 2
+                    items:
+                      - description: RPU core power domain
+                      - description: ATCM power domain
+                      - description: BTCM power domain
+                      - description: second ATCM power domain
+                      - description: second BTCM power domain
+
+          else:
+            patternProperties:
+              "^r5f@[0-9a-f]+$":
+                type: object
+
+                properties:
+                  reg:
+                    minItems: 1
+                    items:
+                      - description: ATCM internal memory
+                      - description: BTCM internal memory
+
+                  reg-names:
+                    minItems: 1
+                    items:
+                      - const: atcm0
+                      - const: btcm0
+
+                  power-domains:
+                    minItems: 2
+                    items:
+                      - description: RPU core power domain
+                      - description: ATCM power domain
+                      - description: BTCM power domain
 
 additionalProperties: false
 
@@ -386,4 +427,111 @@ examples:
             };
         };
     };
+
+  - |
+    // Versal-NET split configuration
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        remoteproc@eba00000 {
+            compatible = "xlnx,versal-net-r52fss";
+            xlnx,cluster-mode = <0>;
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x0 0x0 0x0 0xeba00000 0x0 0x10000>,
+                     <0x0 0x10000 0x0 0xeba10000 0x0 0x8000>,
+                     <0x0 0x18000 0x0 0xeba20000 0x0 0x8000>,
+                     <0x1 0x0 0x0 0xeba40000 0x0 0x10000>,
+                     <0x1 0x10000 0x0 0xeba50000 0x0 0x8000>,
+                     <0x1 0x18000 0x0 0xeba60000 0x0 0x8000>;
+            r5f@0 {
+                compatible = "xlnx,versal-net-r52f";
+                reg = <0x0 0x0 0x0 0x10000>,
+                      <0x0 0x10000 0x0 0x8000>,
+                      <0x0 0x18000 0x0 0x8000>;
+                reg-names = "atcm", "btcm", "ctcm";
+                power-domains = <&versal_net_firmware 0x181100BF>,
+                                <&versal_net_firmware 0x183180CB>,
+                                <&versal_net_firmware 0x183180CC>,
+                                <&versal_net_firmware 0x183180CD>;
+                memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
+                                <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+                mbox-names = "tx", "rx";
+            };
+
+            r5f@1 {
+                compatible = "xlnx,versal-net-r52f";
+                reg = <0x1 0x0 0x0 0x10000>, <0x1 0x10000 0x0 0x8000>,
+                      <0x1 0x18000 0x0 0x8000>;
+                reg-names = "atcm", "btcm", "ctcm";
+                power-domains = <&versal_net_firmware 0x181100C0>,
+                                <&versal_net_firmware 0x183180CE>,
+                                <&versal_net_firmware 0x183180CF>,
+                                <&versal_net_firmware 0x183180D0>;
+                memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
+                                <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+                mbox-names = "tx", "rx";
+            };
+        };
+    };
+
+  - |
+    // Versal-NET lockstep configuration
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        remoteproc@eba00000 {
+            compatible = "xlnx,versal-net-r52fss";
+            xlnx,cluster-mode = <1>;
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x0 0x0 0x0 0xeba00000 0x0 0x10000>,
+                     <0x0 0x10000 0x0 0xeba10000 0x0 0x8000>,
+                     <0x0 0x18000 0x0 0xeba20000 0x0 0x8000>,
+                     <0x1 0x0 0x0 0xeba40000 0x0 0x10000>,
+                     <0x1 0x10000 0x0 0xeba50000 0x0 0x8000>,
+                     <0x1 0x18000 0x0 0xeba60000 0x0 0x8000>;
+
+            r5f@0 {
+                compatible = "xlnx,versal-net-r52f";
+                reg = <0x0 0x0 0x0 0x10000>,
+                      <0x0 0x10000 0x0 0x8000>,
+                      <0x0 0x18000 0x0 0x8000>;
+
+                reg-names = "atcm", "btcm", "ctcm";
+
+                power-domains = <&versal_net_firmware 0x181100BF>,
+                                <&versal_net_firmware 0x183180CB>,
+                                <&versal_net_firmware 0x183180CC>,
+                                <&versal_net_firmware 0x183180CD>;
+
+                memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
+                                <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+
+                mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+
+                mbox-names = "tx", "rx";
+            };
+
+            r5f@1 {
+                compatible = "xlnx,versal-net-r52f";
+                reg = <0x1 0x0 0x0 0x10000>,
+                      <0x1 0x10000 0x0 0x8000>,
+                      <0x1 0x18000 0x0 0x8000>;
+                reg-names = "atcm", "btcm", "ctcm";
+                power-domains = <&versal_net_firmware 0x181100C0>,
+                                <&versal_net_firmware 0x183180CE>,
+                                <&versal_net_firmware 0x183180CF>,
+                                <&versal_net_firmware 0x183180D0>;
+                memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
+                                <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+                mbox-names = "tx", "rx";
+            };
+        };
+    };
 ...
-- 
2.25.1


