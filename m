Return-Path: <linux-kernel+bounces-46872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D027844631
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F229B32B97
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B4B12DD90;
	Wed, 31 Jan 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dMmclgbY"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F512BF0E;
	Wed, 31 Jan 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720819; cv=fail; b=J6dWSmaAVafg/X63zx+yXNGq83fzgZRtdl5Iam4fY6wvEBzGFwvwrJdyvhCGufPklOa0V9PQJEhWwaARXodhMsU+gbYVkwwIrzezSdirn29Fb+MD2LKXl50/AtNAFk+TIZ0KVtbntT1AyKFLIrM+DL41A2lQkhF2YgE5daOt/g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720819; c=relaxed/simple;
	bh=tpE/n8lRpVquouXsDC3VYtQHKqWi4+oFa55DJkVY6Ow=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gKLPihMALDAgdHyIqJuwgmfbksNM1RJu6j5yEuOrAkqS+XFQ15JQDVlBjEwEmhBiowNJOviiYwi1A9IWPAHztWDDUJblhDFvbT2c6fmH+ushDIBhVs9V21PG7mBD/EwdgQaL6R+qCXDzMQrNs3GCWYhJwU5iqttBG3ieBnfY53c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dMmclgbY; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKEkR1qWu9hyyyMGgktUFGurYPLQBhwH2FmVu4tnwXkOn/fhp7cCAM0OXjYuAHLTNI/OUoSeVAFMsng66dT2/CQBODGtuufmLQpsZhO8opWkLDmFd8lT6lV7Ht8o36M1XxRUtL5jZsVyAz8JuAbbqULoXa0Notj/84w+RknkO22/2b8lkx75SAkg77MB7qqVOBDuNwhL3K0VG+S2Jmvum6wn+V8v6bMN3lNz0h1hAzLqBIy/DHB6AUwkGf9ib7YAIxXl16J9S+goLegw++sLBKQUjjhGjTsRaw7jOaVhJzRQXfldbL+ZF4oF7SvFqf5ET0u7SaxaXFoLCG5dH4d/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBJ7a9SaUySKyI+Yiy/bmychQhgcxknH8ZSDOBd3SeM=;
 b=D/wQO6rgUJD08GmCKHoumoOApMTXa7Y5GJi2QqF9qKP3sAnBz4t/ft3N+KscZoThPTHyzC33HOqWyJi0wg+i5SzgJXuq8DiPg91+ifqREbW+o1RAItt5hDRI12/TCHp4VcRavps4h6ozMUmcI4HJt4pY+bHHj8QZC4j+fJYxEVK4nw1jxmmRlpwlSDvBBoC/E8x5lHvyas6fGq53+0qKmOYWtHnq2vpCdbH8DzwCeeuu8rdFoWod5nAe/uMCuu+okBN6sv5KvTQRC2TIEom//QXkMQmfzPnVdnYuG1ujAg4rtqlg/14zEFPWtzb69Y6gjHQK7o4Ha92wyvy75p5X6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBJ7a9SaUySKyI+Yiy/bmychQhgcxknH8ZSDOBd3SeM=;
 b=dMmclgbYuwWekdRBL4EVJccnyornBgbrOVFl81WF34iGhMIiO+CPuBI/OkpcmWU/TIDtYpAu3MXYlrjj8I2X8m3ejoWTBlHlIXiL8XJtNcvQqg9lLMlavjuwYjlgD/KT22Wn8STUkjFqRjShSYMnQ8MEEyrQF518NuDXgw/3fTQ=
Received: from SN7PR18CA0001.namprd18.prod.outlook.com (2603:10b6:806:f3::15)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 17:06:55 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::27) by SN7PR18CA0001.outlook.office365.com
 (2603:10b6:806:f3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 17:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 17:06:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 11:06:52 -0600
Received: from xirmroche40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 31 Jan 2024 11:06:51 -0600
From: Dragan Cvetic <dragan.cvetic@amd.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
	Michal Simek <michal.simek@amd.com>, "Erim, Salih" <salih.erim@amd.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5] dt-bindings: misc: xlnx,sd-fec: convert bindings to yaml
Date: Wed, 31 Jan 2024 17:06:45 +0000
Message-ID: <20240131170650.530079-1-dragan.cvetic@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f803b6-a19c-4b06-ce43-08dc227f06a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ztrg/eN1j5ltf+RTS0r1mJFvrq1L0VX6hCd5m5HUKTGwHEoM9GfVb6VK7bjlZKFCwksOLBlBSa+9RDIvQgEFk28+hV3QmF1GnTb7dYpVLGYVawEIch6LsJ7rZlM5bfrUmTAh7sfX7/oiHtpaNZ/lJNcsxJAHwPQfIpC2aOvkLDKSVZXuFm0rJMICDqbttByjku0lSqGSRFImqE1xEAhF2UEjAR7EUE7Lv/tIk9QKxfeDhQyxYrBiC7BUF3JOzeYEqtB//MUh8XzO6nnhCT72ZyoVieCNiN6+vBnsNoXuPhjAhofd36+OGrjY1tj4DWWFltAPil+QX9FDCTx+batVKa9zN/6q7ILRIsMY5gGIbr98F1ZJO721Mb6HnGCybQco8I0kjmEshN7KYNRuylt0ZWcux9MgpxkIYDqF/v0JMgQFczVcil0x3PsdEGPTAdDm/uaVBFQ1AZele9trDfnZgTaL4OX8qaZ4fbYznYn+a27va19L5TNjKVCe0pZqWx2dBsaoMaPPtaVyahos4OiZIOcuRPujsP6pXqLlVg8DHohd1xXebJ4f+R6ARmfGVFX0JC+oDUFrAa/cno82BTPRMC+MRPVYwLSmnHGm8AiKq2YyyE5c5OuiRDuTfC4ROD1DfO4BEF+B9BypZg7jJtbZndLPG2KGlegcLAeLhI6pGM/gLGtkvbQoj9FTP2IUr28a4Taf0UXyawMF2OqnlI1UButzzoWSr0hi7Lae+dnspsn65FTEVIt8AKt86SgkMK8aYRrbI0x8Vb5otydhbAkhBKCviR2OvNEsNDPp57ky6TF2QrucFv/BglRS8qdkb9yA
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(66899024)(41300700001)(83380400001)(921011)(86362001)(36756003)(82740400003)(36860700001)(26005)(47076005)(336012)(1076003)(2616005)(426003)(70206006)(30864003)(478600001)(966005)(2906002)(110136005)(81166007)(316002)(356005)(70586007)(44832011)(6666004)(8676002)(5660300002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:06:54.6132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f803b6-a19c-4b06-ce43-08dc227f06a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073

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
Changes in v5:
Apply allOf to clock-names and put permanent clock items
inside enum.
---
 .../devicetree/bindings/misc/xlnx,sd-fec.txt  |  58 --------
 .../devicetree/bindings/misc/xlnx,sd-fec.yaml | 140 ++++++++++++++++++
 Documentation/misc-devices/xilinx_sdfec.rst   |   2 +-
 MAINTAINERS                                   |   2 +-
 4 files changed, 142 insertions(+), 60 deletions(-)
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
index 000000000000..9bd210337426
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
@@ -0,0 +1,140 @@
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
+    allOf:
+      - minItems: 2
+        maxItems: 8
+        additionalItems: true
+        items:
+          - const: core_clk
+          - const: s_axi_aclk
+      - items:
+          enum:
+            - core_clk
+            - s_axi_aclk
+            - s_axis_ctrl_aclk
+            - s_axis_din_aclk
+            - m_axis_status_aclk
+            - m_axis_dout_aclk
+            - s_axis_din_words_aclk
+            - m_axis_dout_words_aclk
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


