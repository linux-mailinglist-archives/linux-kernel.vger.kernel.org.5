Return-Path: <linux-kernel+bounces-44652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758BC842584
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050751F2DA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A74C6D1DB;
	Tue, 30 Jan 2024 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QawNaijG"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A446D1BD;
	Tue, 30 Jan 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619211; cv=fail; b=T+ySSUzqOuq+19LKt7bLwwMtySP1o/YjR3QXp8vRYyMJeeUiEmrxVfaz3WlifB8gHy7sjWWJkZ2yMCf88DPP66bK2YSZPkGOxkUfBM48qRkSPt5/BqkkqGzrlaHdaqEz+hRqHydFmYkabDFTRka5rirb8RwP0ztaromIKSuyhSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619211; c=relaxed/simple;
	bh=kvwg62xz+gMXGKq2EznuDa4EsO8HLyC4JoYWKz+RjAk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y+WEeKxWkXidhXtD008MXNU6nEI9sdFC4J5w6hM2trhobgvsJMwG3Q94CpaXAv7+V0+aCjVQaPIH5vcnZuwJvzPftooEPKdyVH5+Hcx3A7aMTs4TrjScxhs9mMkHrb3X8ZD6ObilzBt57TgzatoTBl3YUHJW1Aqvk8xppnOsAL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QawNaijG; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKY5Ui/f2YatdXFWw19U+PyP/nguoQ9U/wRuQ9hNBRwruVLjENRaEl8a2UmNXatT+QtTA36FtziCajbPHonen6v2yUZ1XbXvyqQssZkbJyZA98I9ds3BVbm6PZ4QFH1tiYd+NWtgp9Ypqx2FSIoOIs8Qe+XTEy3gIofW6gOqaPeNK9BtU+A5jdyLkTFOjTJsX2pVYQQzy/r18nyxjbJSVefcUfgmH81MbbUCDY0703CqRkERcCpXBqkFnPctsuo8sHK2N9XQqoB62V7KYbfX0S6jGvAlOb8QGVJ3qEny9Col8/wOumkMTxZG/0bNe6EsddVBZ5UDMBlG99Ew+nWrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97kLD7u5ocC2pNhIaouJMQN5QlNV6phXE1tfwjBHJzU=;
 b=oSy8jFkJODn/tckVkCueE28GPYraETatVvwtRwrUwLOZr3q13SBWIYkg0DL59EYg47RLjk8zvSkd++kZjj/RKdfARq2z/KI9jTvwASVwORdCXWmqy4YoeOaZgUHPdeMFuQc4MkdzcLpbBWryxYHx+d5+uVF0Efi0eCp8g4eQkacoFrIdMfYHkGf7jZ4MWGiKaMaSPsYmWp9sRvbdXQeyfvCquos7EEyQLGwpEM5qs1Ak6j1MQwzCebC8Ch0bwsVdz7h5p5td8vgI6YmXseRMOleW7s+4MQtPpZK6S733qNLVZVS1O8zxA7Jg9hlcMdA212l7V59YsdBIH85+S59UKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97kLD7u5ocC2pNhIaouJMQN5QlNV6phXE1tfwjBHJzU=;
 b=QawNaijG8QFzZXE8xTxpqj0NZViVJXy1cJjUAhrbzbMR0HjE5+zgHgFExyZ7RyTpoCTXtZBRk5fCSnJ17by76kRAA4C/stGSxJUOm4P6ybayOwTSqdhbJ2NZ7BxPqYHho5h0MaBRS19dTTBxx8neS2A6g496alDqeZ7ojT3FyiY=
Received: from BN0PR08CA0028.namprd08.prod.outlook.com (2603:10b6:408:142::27)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 12:53:25 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::7b) by BN0PR08CA0028.outlook.office365.com
 (2603:10b6:408:142::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 12:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 12:53:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 06:53:23 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 06:53:10 -0600
Received: from xirmroche40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 30 Jan 2024 06:53:09 -0600
From: Dragan Cvetic <dragan.cvetic@amd.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
	Michal Simek <michal.simek@amd.com>, "Erim, Salih" <salih.erim@amd.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3] dt-bindings: misc: xlnx,sd-fec: convert bindings to yaml
Date: Tue, 30 Jan 2024 12:53:07 +0000
Message-ID: <20240130125309.4019261-1-dragan.cvetic@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|BL0PR12MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8e68e2-891c-4c22-e63e-08dc219272e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OH8qM5D8qjSj57Qlzv5bbt0uwin3YxhT5QLZEM5KzZkJOoJABGYUWYkEG43U6PNfEumn4w23e3bC6xbUsykBnwkMo5rhCQxVZbWYLxYYDH2mhu03EaUJ5zhp5eBFd1dLDl5TufjpnV+jpvKvxt5U1dgJod16Nq+CEoTS04vSHnSY9Bgymnk+44604gFY1XJs3kv8Ylw7xnz0WSy+riXY1sym2JJkeNo6H9nWVBhkI6OUPQOnrY5s2bQrhJy2KS5bXz7agoOIpnrAtzkSTJpc4It1qUvvfrkv8IHhwTnuFykvbcv4GORq/y04AW9cQyKDJQT6HhMdOzcHPT9g9VB7qWaMDm2O3tgb96e+cAV6E+SVe0Uowdcv7jfTcmhoS51AZTeKGsZKy+NrgPrjE3rCkoAW8/s3bTGzvbyXAhW0PemngteEVj41WC+7VnuaQbIpHZdEuSCp0O3o1Ui1YobPBV9Mlb6TDauFp9xh0StvG6oKapCr3hpEieiI0pYDVwMTo8SxxivTgNqWw4nPFvI9zEOpilHogsDX5iMQ2Kbpu1cvdUXh4vDTCLrgaPmOi8f8XasTsKlqJjnDDcCy9zvXERyrB2FRVls1QLgFj7eOYVcccgkplmt/xDGFK90IlN3tNaV3vdzKHKmlRf69N92yUnMR4J1QiqXVM2R2gH4T6u0RAt+U5NolwMAMFnzJ8aEGFRbGTGlwbeZxMBdopRbZ8UeDeO/9vgKHgU+Yfb3jmie7b9bl6utmXj5PUD+EFXuUM4aGkS3yaoKEqqErlUJiwqIIbe8T50ci7/EXnPBxqgFuePaxNPGc3oU+ccZ44ysy
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(426003)(66899024)(1076003)(110136005)(36860700001)(47076005)(966005)(36756003)(82740400003)(41300700001)(83380400001)(81166007)(478600001)(356005)(86362001)(316002)(44832011)(8676002)(336012)(8936002)(26005)(2616005)(70586007)(70206006)(30864003)(2906002)(5660300002)(921011)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:53:25.5779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8e68e2-891c-4c22-e63e-08dc219272e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898

Convert AMD (Xilinx) sd-fec bindings to yaml format, so it can validate
dt-entries as well as any future additions to yaml.
Change in clocks is due to IP is itself configurable and
only the first two clocks are in all combinations. The last
6 clocks can be present in some of them. It means order is
not really fixed and any combination is possible.
Interrupt may or may not be present.
The documentation for sd-fec bindings is now YAML, so update the
MAINTAINERS file.
Update the link to the new yaml file in xilinx_sdfec.rst.

Signed-off-by: Dragan Cvetic <dragan.cvetic@amd.com>
---
Changes in v2:
---
Drop clocks description.
Use "contains:" with enum for optional clock-names and update
comment explaining diference from the original DT binding file.
Remove trailing full stops.
Add more details in sdfec-code description.
Set sdfec-code to "string" not "string-array"
---
Changes in v3:
Fix a mistake in example, set interrupt type to 0.
---
 .../devicetree/bindings/misc/xlnx,sd-fec.txt  |  58 --------
 .../devicetree/bindings/misc/xlnx,sd-fec.yaml | 136 ++++++++++++++++++
 Documentation/misc-devices/xilinx_sdfec.rst   |   2 +-
 MAINTAINERS                                   |   2 +-
 4 files changed, 138 insertions(+), 60 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
deleted file mode 100644
index e3289634fa30..000000000000
--- a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Xilinx SDFEC(16nm) IP *
-
-The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
-which provides high-throughput LDPC and Turbo Code implementations.
-The LDPC decode & encode functionality is capable of covering a range of
-customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
-principally covers codes used by LTE. The FEC Engine offers significant
-power and area savings versus implementations done in the FPGA fabric.
-
-
-Required properties:
-- compatible: Must be "xlnx,sd-fec-1.1"
-- clock-names : List of input clock names from the following:
-    - "core_clk", Main processing clock for processing core (required)
-    - "s_axi_aclk", AXI4-Lite memory-mapped slave interface clock (required)
-    - "s_axis_din_aclk", DIN AXI4-Stream Slave interface clock (optional)
-    - "s_axis_din_words-aclk", DIN_WORDS AXI4-Stream Slave interface clock (optional)
-    - "s_axis_ctrl_aclk",  Control input AXI4-Stream Slave interface clock (optional)
-    - "m_axis_dout_aclk", DOUT AXI4-Stream Master interface clock (optional)
-    - "m_axis_dout_words_aclk", DOUT_WORDS AXI4-Stream Master interface clock (optional)
-    - "m_axis_status_aclk", Status output AXI4-Stream Master interface clock (optional)
-- clocks : Clock phandles (see clock_bindings.txt for details).
-- reg: Should contain Xilinx SDFEC 16nm Hardened IP block registers
-  location and length.
-- xlnx,sdfec-code : Should contain "ldpc" or "turbo" to describe the codes
-  being used.
-- xlnx,sdfec-din-words : A value 0 indicates that the DIN_WORDS interface is
-  driven with a fixed value and is not present on the device, a value of 1
-  configures the DIN_WORDS to be block based, while a value of 2 configures the
-  DIN_WORDS input to be supplied for each AXI transaction.
-- xlnx,sdfec-din-width : Configures the DIN AXI stream where a value of 1
-  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
-  of "4x128b".
-- xlnx,sdfec-dout-words : A value 0 indicates that the DOUT_WORDS interface is
-  driven with a fixed value and is not present on the device, a value of 1
-  configures the DOUT_WORDS to be block based, while a value of 2 configures the
-  DOUT_WORDS input to be supplied for each AXI transaction.
-- xlnx,sdfec-dout-width : Configures the DOUT AXI stream where a value of 1
-  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
-  of "4x128b".
-Optional properties:
-- interrupts: should contain SDFEC interrupt number
-
-Example
----------------------------------------
-	sd_fec_0: sd-fec@a0040000 {
-		compatible = "xlnx,sd-fec-1.1";
-		clock-names = "core_clk","s_axi_aclk","s_axis_ctrl_aclk","s_axis_din_aclk","m_axis_status_aclk","m_axis_dout_aclk";
-		clocks = <&misc_clk_2>,<&misc_clk_0>,<&misc_clk_1>,<&misc_clk_1>,<&misc_clk_1>, <&misc_clk_1>;
-		reg = <0x0 0xa0040000 0x0 0x40000>;
-		interrupt-parent = <&axi_intc>;
-		interrupts = <1 0>;
-		xlnx,sdfec-code = "ldpc";
-		xlnx,sdfec-din-words = <0>;
-		xlnx,sdfec-din-width = <2>;
-		xlnx,sdfec-dout-words = <0>;
-		xlnx,sdfec-dout-width = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
new file mode 100644
index 000000000000..ed87c48a9ee9
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,sd-fec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx SDFEC(16nm) IP
+
+maintainers:
+  - Cvetic, Dragan <dragan.cvetic@amd.com>
+  - Erim, Salih <salih.erim@amd.com>
+
+description: |
+  The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
+  which provides high-throughput LDPC and Turbo Code implementations.
+  The LDPC decode & encode functionality is capable of covering a range of
+  customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
+  principally covers codes used by LTE. The FEC Engine offers significant
+  power and area savings versus implementations done in the FPGA fabric.
+
+properties:
+  compatible:
+    const: xlnx,sd-fec-1.1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 8
+    additionalItems: true
+    items:
+      - description: Main processing clock for processing core
+      - description: AXI4-Lite memory-mapped slave interface clock
+      - description: Control input AXI4-Stream Slave interface clock
+      - description: DIN AXI4-Stream Slave interface clock
+      - description: Status output AXI4-Stream Master interface clock
+      - description: DOUT AXI4-Stream Master interface clock
+      - description: DIN_WORDS AXI4-Stream Slave interface clock
+      - description: DOUT_WORDS AXI4-Stream Master interface clock
+
+  clock-names:
+    minItems: 2
+    maxItems: 8
+    additionalItems: true
+    items:
+      - const: core_clk
+      - const: s_axi_aclk
+    contains:
+      enum:
+        - s_axis_ctrl_aclk
+        - s_axis_din_aclk
+        - m_axis_status_aclk
+        - m_axis_dout_aclk
+        - s_axis_din_words_aclk
+        - m_axis_dout_words_aclk
+
+  interrupts:
+    maxItems: 1
+
+  xlnx,sdfec-code:
+    description: |
+      The SD-FEC integrated block supports Low Density Parity Check (LDPC)
+      decoding and encoding and Turbo code decoding. The LDPC codes used are
+      highly configurable, and the specific code used can be specified on
+      a codeword-by-codeword basis. The Turbo code decoding is required by LTE
+      standard.
+    $ref: /schemas/types.yaml#/definitions/string
+    items:
+      enum: [ ldpc, turbo ]
+
+  xlnx,sdfec-din-width:
+    description: |
+      Configures the DIN AXI stream where a value of 1
+      configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
+      of "4x128b".
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 4 ]
+
+  xlnx,sdfec-din-words:
+    description: |
+      A value 0 indicates that the DIN_WORDS interface is
+      driven with a fixed value and is not present on the device, a value of 1
+      configures the DIN_WORDS to be block based, while a value of 2 configures the
+      DIN_WORDS input to be supplied for each AXI transaction.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2 ]
+
+  xlnx,sdfec-dout-width:
+    description: |
+      Configures the DOUT AXI stream where a value of 1 configures a width of "1x128b",
+      2 a width of "2x128b" and 4 configures a width of "4x128b".
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 4 ]
+
+  xlnx,sdfec-dout-words:
+    description: |
+      A value 0 indicates that the DOUT_WORDS interface is
+      driven with a fixed value and is not present on the device, a value of 1
+      configures the DOUT_WORDS to be block based, while a value of 2 configures the
+      DOUT_WORDS input to be supplied for each AXI transaction.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2 ]
+
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - xlnx,sdfec-code
+  - xlnx,sdfec-din-width
+  - xlnx,sdfec-din-words
+  - xlnx,sdfec-dout-width
+  - xlnx,sdfec-dout-words
+
+additionalProperties: false
+
+examples:
+  - |
+    sd-fec@a0040000 {
+        compatible = "xlnx,sd-fec-1.1";
+        reg = <0xa0040000 0x40000>;
+        clocks = <&misc_clk_2>, <&misc_clk_0>, <&misc_clk_1>, <&misc_clk_1>,
+                 <&misc_clk_1>, <&misc_clk_1>;
+        clock-names = "core_clk", "s_axi_aclk", "s_axis_ctrl_aclk",
+                      "s_axis_din_aclk", "m_axis_status_aclk",
+                      "m_axis_dout_aclk";
+        interrupts = <1 0>;
+        xlnx,sdfec-code = "ldpc";
+        xlnx,sdfec-din-width = <2>;
+        xlnx,sdfec-din-words = <0>;
+        xlnx,sdfec-dout-width = <1>;
+        xlnx,sdfec-dout-words = <0>;
+    };
+
diff --git a/Documentation/misc-devices/xilinx_sdfec.rst b/Documentation/misc-devices/xilinx_sdfec.rst
index 8c8a289d69a3..698e6630f3a7 100644
--- a/Documentation/misc-devices/xilinx_sdfec.rst
+++ b/Documentation/misc-devices/xilinx_sdfec.rst
@@ -29,7 +29,7 @@ follows:
   - Does not support shared LDPC code table wraparound
 
 The device tree entry is described in:
-`linux-xlnx/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt <https://github.com/Xilinx/linux-xlnx/blob/master/Documentation/devicetree/bindings/misc/xlnx%2Csd-fec.txt>`_
+`linux-xlnx/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml <https://github.com/Xilinx/linux-xlnx/blob/master/Documentation/devicetree/bindings/misc/xlnx%2Csd-fec.yaml>`_
 
 
 Modes of Operation
diff --git a/MAINTAINERS b/MAINTAINERS
index 8999497011a2..d62e04322e19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24157,7 +24157,7 @@ XILINX SD-FEC IP CORES
 M:	Derek Kiernan <derek.kiernan@amd.com>
 M:	Dragan Cvetic <dragan.cvetic@amd.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
+F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
 F:	Documentation/misc-devices/xilinx_sdfec.rst
 F:	drivers/misc/Kconfig
 F:	drivers/misc/Makefile
-- 
2.34.1


