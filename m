Return-Path: <linux-kernel+bounces-44908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8778428E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4584828703F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F4486AE5;
	Tue, 30 Jan 2024 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rQM5ynL9"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5B86151;
	Tue, 30 Jan 2024 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631187; cv=fail; b=aWRKPhP7YIjE0jaRD5xJNx7vQxhsC9lNQdwoccybBb9f/lnEOfZph+869Fpy0bMZXUZQaPI/4gJDKVWV2rliOlwGI3F4bRmGA0yi3LaOrk9LFyeYE5bxztdXj8PFYQrqXUddQgDFuJNihx2AifOsl3Vyg7xlOwBINtvuBYRr7+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631187; c=relaxed/simple;
	bh=LiPDWiX3AjAjcSImXTLW7du7wpIVfgc3fjQgvoko0oM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lwXEhQCOkc0p/xXZpCXxtZi/zZB5RwpHk39rpOPUuPsZcPsOb+uUYIPn+3coegQOryqNZAQs52+YnzVVTYqDDyFzIgyhRnfEWIDMHS+dfg1yhJlZzf2gGvlgX3syt0xx8uQfY1fhUBV689aw6L0f3XuCgJw8LuworfQWsQhpick=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rQM5ynL9; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juRKxr3qcg1aacpgNFno1bBGVjEvLp3d2LL27COV0U92PlUKJrniNXXQUZEdvLcoUX32jolW1Ja7ra3nciMps0AKfwJ/rD4h1b2ftOYJ544B6P5iY2T/z2s1ANWRLtS8S97PkhuQlQg86enfslHcMzkug7HD6Rew9rvq3MRxPtwN/XeCt1rv+XAaIc0ef16qKo0OY/Mbd5iIvCMqTgFsnzLRqlNKlPRYSg9k3M0z5RWBdj/APpBiikrrO8T3rp+TMLxqctxg9EfRyakwWdGkb0wejoDIMW+aQqeBy6saSozkq65zU6CQRa72qXfcTvMYkfJSBXArm6UzSNWMKLFp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbqeTdVZdB2ugO7r/4Gy081ukQFw05hoy9AqXGWGaWw=;
 b=dbPA8PXxy4q1fRkjp5f1ImhVFcvRC2V3O2DG9gxqo/SbT9MZjUGfowM9aqrEBEyfH5qldmZnL8V+E8m+frJGPgP6FdqLU0wn751ZgEMXyJUKdhjDLwjSHEuz/RJ/wXCemmZkAkSn/WL/A+hBHHI5R6LJlSKHYwwa/l83oRtxN3M9QOwYa6vTzYVgVRt6fUdlbNeMgo6WxZkqHQ/5cbTIyBOijfG8OxraDCDU6Jn5GxN9I6Ugvbz0pv6uLJQLxZzikwf1IDxxJ8wTYMLe1KXIHv/gcjd3HonzlUd+JP7J5n4PlYlzGs0r/FxftjV5e+XHGES7TZlnii6YEDxdCTVi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbqeTdVZdB2ugO7r/4Gy081ukQFw05hoy9AqXGWGaWw=;
 b=rQM5ynL9hnTI+wbdcwTN4TuK0STFNsy7qoPmBmpDXNPn7bGSNRTUUDO0QjtjvleKT0SSjcTW7A6niE1FFDVEHArrYjz/359EsnaRX0VWwl+IrEp5Da4sqIUBkLWeJPIwQJjsdHdC+U4VL+UoCkYYg4Y2MhpnFdVjYS3nMLZPKl0=
Received: from CH5PR02CA0002.namprd02.prod.outlook.com (2603:10b6:610:1ed::14)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Tue, 30 Jan
 2024 16:13:02 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::24) by CH5PR02CA0002.outlook.office365.com
 (2603:10b6:610:1ed::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 16:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 16:13:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 10:13:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 30 Jan
 2024 08:13:01 -0800
Received: from xirmroche40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 30 Jan 2024 10:12:59 -0600
From: Dragan Cvetic <dragan.cvetic@amd.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
	Michal Simek <michal.simek@amd.com>, "Erim, Salih" <salih.erim@amd.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4] dt-bindings: misc: xlnx,sd-fec: convert bindings to yaml
Date: Tue, 30 Jan 2024 16:12:58 +0000
Message-ID: <20240130161259.4118510-1-dragan.cvetic@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3d4954-2d38-4c0f-6aa0-08dc21ae5563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SB0EIEM1a1RV1AWXGbVj6W9uCW7JhFGTJA7QqaSH1p9yYKy7wjhIShjzc6h9eudctLg/JUfmt8DF8C1Wx1Hz44DII5OsXG7JXVX0Lg2XaS8PnumV13w1jA6me0RLtS0yZrLHB8Rppngcv8qdCtNZf+ulJa8weagI3a/77zbTMrAJOtNYV3QrEIXD0qIYC5gGKU3ZAAqJ56NTw82llTGV3vMJ8RDZ/9jGt9FyIuFCYnLU7kP+lNveydFSrZm0i2bSxzLGCQcIX5UorSRpQCiHEdGmL5rQ4bYXeRpP+zbhTLGEbbd46kxGqVMNbXDbTXwi0FU/8fQBOS0f0rMjhCQnIs8irqGvgLzZBDtiNlBBjIKOuR+MIYRrXxjE45UiejUKJnO2wBk3+pd0rBOCc8uVwFlxmcngbvncQDAh1OABii1fpU1tT7ek+1r2ovDEVudz/k8JFtu82E32hTtBVI52KNebu4U7qv2og6N9yLfqEi0SX/qe2cMsXHkkiB76HSDWQB/Sm4ZUZRxxfJp5tm80ccx50ogrKtmowTzJPhKbhD4NS9rYQjaQF8Zv9P9NsVJAG10MyUVP9nWHMhqpgpcxS8BRvNCUQT2bD/Scw/deq2Fwo6PeykK2CEIzLu9R3EF+Hln02HDg3djhE+A7qXbkAa9xHXQCAOAm8smAJ7ffCmZ4MadMJa3BrsUuEfUQ/PohDqlM49Kuw2oTU05ybeEyxFJ3lZVwHHruNzc+OTyVOOv70mjDYSPBtIkQttjrQu5vp06Edzm0vj4fW7d1MOxpytGkzjJyVqXaXtMq0+TS46C/Sc0/60LJCZ5uPl57v/B4
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(70586007)(316002)(8936002)(8676002)(110136005)(1076003)(83380400001)(36860700001)(70206006)(478600001)(86362001)(5660300002)(966005)(30864003)(2906002)(44832011)(2616005)(36756003)(81166007)(921011)(336012)(82740400003)(40460700003)(40480700001)(426003)(47076005)(356005)(26005)(41300700001)(66899024)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 16:13:01.9591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3d4954-2d38-4c0f-6aa0-08dc21ae5563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311

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
Changes in v4:
Set interrupt type to high level sensitive.
Remove '|' from descriptions, no need to preserve format.
Remove not needed empty line.
---
 .../devicetree/bindings/misc/xlnx,sd-fec.txt  |  58 --------
 .../devicetree/bindings/misc/xlnx,sd-fec.yaml | 137 ++++++++++++++++++
 Documentation/misc-devices/xilinx_sdfec.rst   |   2 +-
 MAINTAINERS                                   |   2 +-
 4 files changed, 139 insertions(+), 60 deletions(-)
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
index 000000000000..7be8439861a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
@@ -0,0 +1,137 @@
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
+description:
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
+    description:
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
+    description:
+      Configures the DIN AXI stream where a value of 1
+      configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
+      of "4x128b".
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 4 ]
+
+  xlnx,sdfec-din-words:
+    description:
+      A value 0 indicates that the DIN_WORDS interface is
+      driven with a fixed value and is not present on the device, a value of 1
+      configures the DIN_WORDS to be block based, while a value of 2 configures the
+      DIN_WORDS input to be supplied for each AXI transaction.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2 ]
+
+  xlnx,sdfec-dout-width:
+    description:
+      Configures the DOUT AXI stream where a value of 1 configures a width of "1x128b",
+      2 a width of "2x128b" and 4 configures a width of "4x128b".
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 4 ]
+
+  xlnx,sdfec-dout-words:
+    description:
+      A value 0 indicates that the DOUT_WORDS interface is
+      driven with a fixed value and is not present on the device, a value of 1
+      configures the DOUT_WORDS to be block based, while a value of 2 configures the
+      DOUT_WORDS input to be supplied for each AXI transaction.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2 ]
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    sd-fec@a0040000 {
+        compatible = "xlnx,sd-fec-1.1";
+        reg = <0xa0040000 0x40000>;
+        clocks = <&misc_clk_2>, <&misc_clk_0>, <&misc_clk_1>, <&misc_clk_1>,
+                 <&misc_clk_1>, <&misc_clk_1>;
+        clock-names = "core_clk", "s_axi_aclk", "s_axis_ctrl_aclk",
+                      "s_axis_din_aclk", "m_axis_status_aclk",
+                      "m_axis_dout_aclk";
+        interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
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


