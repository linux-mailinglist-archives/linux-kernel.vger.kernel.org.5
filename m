Return-Path: <linux-kernel+bounces-43194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0337E8410A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290B01C23AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293F15A49D;
	Mon, 29 Jan 2024 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WfpLEdZK"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A8157050;
	Mon, 29 Jan 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548742; cv=fail; b=Xie/okkSaXlriBVLj/rIlmQWknfzWYXk0VFjEAVpMKCPVf//bt/5wcWSbxiKpBrJmwJnFgJ5qYJVyCzl4gZ7pIRr/o+i0GpbSdbgjSe6P+KnLHJOQCBCLR2d9tzp8RJ3brw1zyfP/jeOWHRxJ89gP4mHxtQkggQZsBfd/AC0tHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548742; c=relaxed/simple;
	bh=kg5KIPR37sBWHaIg4GelxQwcbbdi8RLH1sScgF51IJY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qk82xnhION0IN0n3In1P2Dn/2/OyGHXRgHIH2VIXeYmFVzPVNmzG8/x92ZN/6rHMjnf2DjkuVw/aRsACBSvIwDHLsLgPG9TacrIVnYH3AdJn05k/b3KaR2KalvCO8EWIkUebNFqCHT4a8Qbqqpfgtd8r9rtfl/l4sjYMcaYUEGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WfpLEdZK; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipBSWDwSr6ZwvI6pERioMMQCZZvVqR7yY2QzesFan+wPp64arVzhr451XmM2nO9e5uXQ1dPjjvLOGP5aLQ8sCjmqjLJ08kQ/VnVVCpeltsqnplt9OY/9GhV2j6fZK78AfLeSj5U/rsCouzBfJbaCO57DOreDoi+QkcvILfMGxpnw/r/KkVoC//AHKjJyup4pjjA1WTi/vSFlLPdg2/TN0C/LVABQbRQ27wys7BxmHf3DMtgAB3mmcJHT94Oc7Lj6w10juhrzvfLCLS0kMVB7ApBoUQNI4mxpQr0/BcFvTVKbNspxUo88jIUALsInfZT6uXgr+4WwO8YA2f0jXvfRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB0sImxyjoi7kcf0IcSUJhW+ONmBpYtOFM66PR9LX8E=;
 b=ERX5fB631T9fwhofQPt664l/gg8TuMDloBo1ymCPfrV7MqulZKymFKhcp1if76zdafXWan9D7cagPpPpr2BSuBI0Z+I/sS9dfW5E4vMM673PcqEXcKg9UUfEHeJQBfnUYHj37UyE3bCP+eqNqKlB8PPMtidcmvjMxniptOPuk3mRfH+yXWSr2/p/aRFY3yHl1cqGLs4Unrm1QgZRIdMdpum2iIgnzCav62w0Ht39p3YjecsKuOxHItBAhuBrxpHNEakB7/K1E9Q2hCn6SFcqKUSFOlV+BDurxd66Pq5J4cPoStqdzW7Ke0gcNgsRG4upaPp+35QSWeU0+zRTsJfBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hB0sImxyjoi7kcf0IcSUJhW+ONmBpYtOFM66PR9LX8E=;
 b=WfpLEdZK9a7KB7ZolwqUgaav41WX8M1nQTbd9Pfx1yh8WiyfF+Sfy2hn+CWaia7Lr7PvgDBM4GclN/sVOjLIQZP0IkvuvUO7d74ipZlQ6z6nC/JfDIbkRNZ8t72O21yInWXGh4MdcP0gdBUOa51WoigkPerOY5rY0uEiSFvPoFs=
Received: from BN8PR12CA0005.namprd12.prod.outlook.com (2603:10b6:408:60::18)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 17:18:57 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:60:cafe::b1) by BN8PR12CA0005.outlook.office365.com
 (2603:10b6:408:60::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 17:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 17:18:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 11:18:56 -0600
Received: from xirmroche40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 29 Jan 2024 11:18:55 -0600
From: Dragan Cvetic <dragan.cvetic@amd.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
	Michal Simek <michal.simek@amd.com>, "Erim, Salih" <salih.erim@amd.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] dt-bindings: misc: xlnx,sd-fec: convert bindings to yaml
Date: Mon, 29 Jan 2024 17:18:51 +0000
Message-ID: <20240129171854.3570055-1-dragan.cvetic@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 8519c73f-4eb4-42f1-49fe-08dc20ee604a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M0MPjQYXaCpSjhMdVMr1ru1j3EIe3F8O7dqREOqOrDk7lGGtS4EiY8zYPvitF91O9GJE8cMwgyg0aObHWpvLpM1WuHeEz2wPnfmE5Xyvdv4xIS/E0DR7IbDUdoHEGhjduwyneKjlao6oRkOjQNvHPc/LVTYcfbIQibh4kdJRGk23zZtlHOg9+ueCmGE3ABB0vcPo1op5UhIMcq7QHr0CMmfGA6ZBuC+htIsr2FBLfcEuiUCH4CJirZtfsBGA5ps29jFLwTdAukkV/t+lvx/+EJDEQNEyke92Qi0exoAcpSukdfcdjMkiOC/tZBDqrMemI3Sz1cBABuNf9J3u0i09wQJ8jnEiNiqD1qyrdhZS6f5LSd8PKSSVIyDcBg8R0wjG8f/jfjDPe7TR7iaHMuQvdt9z8+jc8jMtYzBuBAKuzJ7WYUSKzurQoJHR2uohGdFLyuqG1ZVYxITK8FHAmT0xpK6XHbW6DH0HVBOcF4eYT3VnpfxtfKR7LGB827ZfNo+FXe6/r2RD8CBFADOIOPiONQdALAP673pZEp9WAz8432RqNgT5I9shAUvy9/jpATg/nQNS3jzd8JDGk24i2HLWmOP3hzjFdlECsy6v1FX3J2KtT9WLIvIBXNXU++Nr+8qgwDmoD6HOuxRkWDb0P0kkYPJI+AxCgnmU2W8FmfHPD7aDHWK9FD76KPur+gjsRdekL9ODhA1kmf0HXwNuYvpKUduJIBHKSuG9q1rOsZhtdmmbr5oDV2KyJFskm5RzXYXfkbLwvn5sgMvPn8DZwoZQiw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(47076005)(83380400001)(6666004)(40480700001)(40460700003)(44832011)(36860700001)(966005)(356005)(5660300002)(336012)(426003)(2616005)(478600001)(1076003)(26005)(66899024)(82740400003)(8936002)(8676002)(81166007)(30864003)(36756003)(41300700001)(2906002)(70206006)(86362001)(921011)(316002)(70586007)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 17:18:56.9085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8519c73f-4eb4-42f1-49fe-08dc20ee604a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127

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
index 000000000000..8534beac042d
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


