Return-Path: <linux-kernel+bounces-18040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3A78257A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E751B25412
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC4231A9D;
	Fri,  5 Jan 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DKcZ2fdz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A442E84F;
	Fri,  5 Jan 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKQfMhuiqbxfjrFVhz+PUAkrIKd2xiFC4F5ojEbQ0bMXcX0DpkHi/VwSZQOH+Y1/wabmddY5xp/652oPFt5/xP9+TVCskCXW5iuhVciDDrz7B8Rt6JtAytBUdFQWeWEQAZ8JCEbhDiNbnrntuQMUCq2t8sagngZ0g0uGye8e8sjemFuOcFdkY19tMYBsc3FZdg8AaTRZpxx0MQs75lIq2voDSlrDBuCl4DPLc9mfMTfzuMo9r5l1Gmc3Gsj0TbsNvDs4kxvQdL4K3+6fZdIKNMDdN+fEaUvx0QM7D1BY36r/qj4CT7OHBF+Zc04eQ9JtOJuHjOWO9CUzFTeIcD6Pcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N///WPO3WSoDZgeDZ9uNHiL4/LlU3GiL/RtQaedZFsw=;
 b=of0jqVedFF0zYUHYzrzqqTL1lLy0PJ6+1pPnqoBdlYzFViy6/AV99Zk8XBS/Jjd6+6ekebr2V42CzBaQFVwi3YnVpEAeiTpnD4QoUltI7YEBmvUlSTR6mUlY6V0htCuvRqYSs6BlSqG1FAJbkRXvNGzdabVimqARoy80tWdbdQfnLC3pa5TisY1yZlP/Y/mdnE5fxekMveQp52tiUf37MWb+74uYkWz6GtvJRucFOEHpi1io4+NEX8y246YupAIn2hWaSmSgF8pzPfoEAMqpd/Bv3KcpL0u7evstsgFqJRi4XeSA9R8Cn4KPni5RbEf4+C1HGccsK/RUuMGMOKZwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N///WPO3WSoDZgeDZ9uNHiL4/LlU3GiL/RtQaedZFsw=;
 b=DKcZ2fdz+MpzufdbhtN2LuabXNPL4ZkofbFRVNCb/pfCqmYwguQ2fmX7lm+0KvLb0vml7r3MZXDKJlSgmKF/qBbn2/93Z/H6qXWPoj39/eGH1inQIFszK+j852A+98gDCXqAZxmN+rFrRp4ftKiOz9s96HF/pJFQK8W1LfB9K2o=
Received: from SJ0PR13CA0103.namprd13.prod.outlook.com (2603:10b6:a03:2c5::18)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.28; Fri, 5 Jan
 2024 16:04:40 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::6a) by SJ0PR13CA0103.outlook.office365.com
 (2603:10b6:a03:2c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17 via Frontend
 Transport; Fri, 5 Jan 2024 16:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 16:04:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 5 Jan
 2024 10:04:38 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Moritz Fischer <mdf@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Tom Rix <trix@redhat.com>, Wu Hao
	<hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open
 list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: fpga: altera: Convert bridge bindings to yaml
Date: Fri, 5 Jan 2024 17:04:31 +0100
Message-ID: <e738a64f742982bba6c7a8ea3cbc660f81316d2b.1704470663.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
References: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8377; i=michal.simek@amd.com; h=from:subject:message-id; bh=7vhxYQFw4IJWU8EcdMXRv+SHeJLQ4PPfBiOBorhhuXg=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQZGr3Tp2RNzL0pMPO4gNfWQ+u8D6UrPdmsrbWjP4qbf 81DpYdJHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiYd8Z5sd5Hr3qm175/WW/ 3Z0H1RuE62ZO/MAw38vKaf6ncPU5hZxnVzNPf97x5X48DwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: e27ccfdc-5722-46ef-47c8-08dc0e0805cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sbsuibm1hbs2L+D8b2YObp8xWoPtexhwHv7YwEhWEUFprsK9m8GI4Fp3OT3cqqUyuqPmwWsZIgnMce7FH0eCGYQgRBJV9uR7ZK6+guH+DqiKHgI4wOu9im4FJyuIpRoMF3q/iuvKF0fKBp5pSf4hvRHUeoukTwJT9za9cXtO4egt7zGgPbkCmw8OdTTFRGecdAmpIIY/eruluDV6Jag/Nf5LIiJWnFidWjBdHZB3OVUqJfbaitVUfj5IJ8vCo4/C+p1GZSYVnlw58Y+NgDp+YG0kizeAdkdQXs/CThtMKwJcF2bRZZ4cYYyZ0xxergjtLe09ARhC18c+pDce/T+a84ot6e59fXmNbP/NQwze7LGvObUuBzFEO59BjzhXiH6H0CWhY2t5DJZw4P2zPuKZHACrzQFIiLEPaSac0fEhBhh28am8JLURz20Nt9Ru79SpbAUOh4/uU2Wsy2t3DgVorh7WV4eFo426RB/b7RXvjTmMaRjTZx63m9QjohvLXBuGEd6Qtds5rMtdveprJRwv5dImICviHEj91gZrszJMT/9BqSrtorM0OlHZqXiur2Li+Wo7PQYSgeopdwEmyzSkWEPiE8ZUtPPzwFwx9+ktElzz83UrK+3Kl4zL+VWfOK35z/LAbkJ51JX0bB8K/BevXlPOCAD3CKUtKxs11Gm2mZ2ylcD2GhhsXJovTGqvfukLzBh7HCj5qCxjnhowQdZldf3hE+OMO1xMfxYT9MJ/caa49VTuW2MZ0fydeyAXxZNPg5GxRqUClXpIy2rek8W28n/xNhoIgusb6BnXBbGug8c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(36840700001)(40470700004)(46966006)(6666004)(2616005)(83380400001)(426003)(336012)(16526019)(26005)(36756003)(86362001)(7416002)(44832011)(5660300002)(41300700001)(8936002)(54906003)(70586007)(70206006)(4326008)(110136005)(8676002)(2906002)(316002)(478600001)(40460700003)(47076005)(966005)(81166007)(82740400003)(356005)(40480700001)(36860700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 16:04:39.8162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e27ccfdc-5722-46ef-47c8-08dc0e0805cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324

Convert Altera's bridges to yaml with using fpga-bridge.yaml.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../fpga/altera-fpga2sdram-bridge.txt         | 13 ----
 .../fpga/altera-fpga2sdram-bridge.yaml        | 34 ++++++++++
 .../bindings/fpga/altera-freeze-bridge.txt    | 20 ------
 .../bindings/fpga/altera-freeze-bridge.yaml   | 41 ++++++++++++
 .../bindings/fpga/altera-hps2fpga-bridge.txt  | 36 -----------
 .../bindings/fpga/altera-hps2fpga-bridge.yaml | 63 +++++++++++++++++++
 6 files changed, 138 insertions(+), 69 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml

diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
deleted file mode 100644
index 5dd0ff0f7b4e..000000000000
--- a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-Altera FPGA To SDRAM Bridge Driver
-
-Required properties:
-- compatible		: Should contain "altr,socfpga-fpga2sdram-bridge"
-
-See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
-
-Example:
-	fpga_bridge3: fpga-bridge@ffc25080 {
-		compatible = "altr,socfpga-fpga2sdram-bridge";
-		reg = <0xffc25080 0x4>;
-		bridge-enable = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
new file mode 100644
index 000000000000..a3f3fe2729f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/altera-fpga2sdram-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera FPGA To SDRAM Bridge
+
+maintainers:
+  - Xu Yilun <yilun.xu@intel.com>
+
+allOf:
+  - $ref: fpga-bridge.yaml#
+
+properties:
+  compatible:
+    const: altr,socfpga-fpga2sdram-bridge
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    fpga-bridge@ffc25080 {
+        compatible = "altr,socfpga-fpga2sdram-bridge";
+        reg = <0xffc25080 0x4>;
+        bridge-enable = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
deleted file mode 100644
index 8b26fbcff3c6..000000000000
--- a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Altera Freeze Bridge Controller Driver
-
-The Altera Freeze Bridge Controller manages one or more freeze bridges.
-The controller can freeze/disable the bridges which prevents signal
-changes from passing through the bridge.  The controller can also
-unfreeze/enable the bridges which allows traffic to pass through the
-bridge normally.
-
-Required properties:
-- compatible		: Should contain "altr,freeze-bridge-controller"
-- regs			: base address and size for freeze bridge module
-
-See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
-
-Example:
-	freeze-controller@100000450 {
-		compatible = "altr,freeze-bridge-controller";
-		regs = <0x1000 0x10>;
-		bridge-enable = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml
new file mode 100644
index 000000000000..4a89e3980669
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/altera-freeze-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera Freeze Bridge Controller
+
+description: |
+  The Altera Freeze Bridge Controller manages one or more freeze bridges.
+  The controller can freeze/disable the bridges which prevents signal
+  changes from passing through the bridge. The controller can also
+  unfreeze/enable the bridges which allows traffic to pass through the bridge
+  normally.
+
+maintainers:
+  - Xu Yilun <yilun.xu@intel.com>
+
+allOf:
+  - $ref: fpga-bridge.yaml#
+
+properties:
+  compatible:
+    const: altr,freeze-bridge-controller
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    fpga-bridge@100000450 {
+        compatible = "altr,freeze-bridge-controller";
+        reg = <0x1000 0x10>;
+        bridge-enable = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
deleted file mode 100644
index 68cce3945b10..000000000000
--- a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Altera FPGA/HPS Bridge Driver
-
-Required properties:
-- regs		: base address and size for AXI bridge module
-- compatible	: Should contain one of:
-		  "altr,socfpga-lwhps2fpga-bridge",
-		  "altr,socfpga-hps2fpga-bridge", or
-		  "altr,socfpga-fpga2hps-bridge"
-- resets	: Phandle and reset specifier for this bridge's reset
-- clocks	: Clocks used by this module.
-
-See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
-
-Example:
-	fpga_bridge0: fpga-bridge@ff400000 {
-		compatible = "altr,socfpga-lwhps2fpga-bridge";
-		reg = <0xff400000 0x100000>;
-		resets = <&rst LWHPS2FPGA_RESET>;
-		clocks = <&l4_main_clk>;
-		bridge-enable = <0>;
-	};
-
-	fpga_bridge1: fpga-bridge@ff500000 {
-		compatible = "altr,socfpga-hps2fpga-bridge";
-		reg = <0xff500000 0x10000>;
-		resets = <&rst HPS2FPGA_RESET>;
-		clocks = <&l4_main_clk>;
-		bridge-enable = <1>;
-	};
-
-	fpga_bridge2: fpga-bridge@ff600000 {
-		compatible = "altr,socfpga-fpga2hps-bridge";
-		reg = <0xff600000 0x100000>;
-		resets = <&rst FPGA2HPS_RESET>;
-		clocks = <&l4_main_clk>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml
new file mode 100644
index 000000000000..f8210449dfed
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml
@@ -0,0 +1,63 @@
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/altera-hps2fpga-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera FPGA/HPS Bridge
+
+maintainers:
+  - Xu Yilun <yilun.xu@intel.com>
+
+allOf:
+  - $ref: fpga-bridge.yaml#
+
+properties:
+  compatible:
+    enum:
+      - altr,socfpga-lwhps2fpga-bridge
+      - altr,socfpga-hps2fpga-bridge
+      - altr,socfpga-fpga2hps-bridge
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/altr,rst-mgr.h>
+
+    fpga-bridge@ff400000 {
+      compatible = "altr,socfpga-lwhps2fpga-bridge";
+      reg = <0xff400000 0x100000>;
+      bridge-enable = <0>;
+      clocks = <&l4_main_clk>;
+      resets = <&rst LWHPS2FPGA_RESET>;
+    };
+
+    fpga_bridge1: fpga-bridge@ff500000 {
+      compatible = "altr,socfpga-hps2fpga-bridge";
+      reg = <0xff500000 0x10000>;
+      bridge-enable = <1>;
+      clocks = <&l4_main_clk>;
+      resets = <&rst HPS2FPGA_RESET>;
+    };
+
+    fpga_bridge2: fpga-bridge@ff600000 {
+      compatible = "altr,socfpga-fpga2hps-bridge";
+      reg = <0xff600000 0x100000>;
+      clocks = <&l4_main_clk>;
+      resets = <&rst FPGA2HPS_RESET>;
+    };
-- 
2.36.1


