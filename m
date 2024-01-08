Return-Path: <linux-kernel+bounces-19796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 825B3827423
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1651C22E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D886754FB9;
	Mon,  8 Jan 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GWSROCh8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD16E54FA2;
	Mon,  8 Jan 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiPIO8Klk8XXsl/Q5JgXKh8TYKx6sAGcYEsV/g3u2CwHQqERvLQwj4ASsKqmEnHEyOJ9nJAmujBLBiEGXXl/ZzLFncS4dmjkP2a8goBdwKCyjO1YWVwFsAyqU58WlgdiwboNVpBhx32ioRaBDx06fuS5cUBOqD5rMpcMdGccU/gkGU7LOqn+MtN1Xur0SXK0ejRbUitGv4kpJaq8dgP69NR6puTh/1nPEN5KbCtW5HRChFXapFqtKkTmvQ9aeQASHbAnme47KKMYkN9QvvbxZE5qlzx16Ub4NTYPx04+d8HvCdI6wj0c7L464QJ7Gq4qfC5k9NfgDROM1/XyCnmSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFKhffKYIB+jzCN1TLMcaQ1ZvGPHbvedyMz6xHJXIvQ=;
 b=ZsubeguDwRhMsxss9gXKVZAgm1g+P3/qhydvmG8XLa0/dVuQSi8LgDwdQNN35x7x2D3L8Vj7kGDKm2Nc3Huvkivt82PgFVKJEWrR33aQtgt9rrW6CUIqLC87rGnkR4Xk2SDF3RZlLnbS5ayyIsltfrgGLmMRhAk2m9Qh82crOMiG28ThAXkeOjZntmTPzLHa1y4vO/yZDMUCKQtp3zFyRy5zJqqK2C3/CEhemrlzMExR7qwzkuAZRys8Xp5pa5q7Qydppxm6BdkUlzN9oCd7NaRqOx+Mo9JUKYkkRlJEFxjy2+6qwn0hRcWNaQiUmESuypI9udUQ8/MfJVFci+9EsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFKhffKYIB+jzCN1TLMcaQ1ZvGPHbvedyMz6xHJXIvQ=;
 b=GWSROCh8GJSE8clMUdkKMSwPWglEGzSD4gTAAw4lUJxJ5/a9va15rMVodyX+nAAMY52n/YkpbruUtjZC5IqJUjFzTdtLbZu3Q+SsxvGFoEAwTxbYFg1xVwVsI2Jded0+DZRNsj8l+JjBit4xMkCISYeeaTeYLjjFf5Ib9FIGXp0=
Received: from MN2PR13CA0001.namprd13.prod.outlook.com (2603:10b6:208:160::14)
 by DM8PR12MB5463.namprd12.prod.outlook.com (2603:10b6:8:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 15:41:59 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::4a) by MN2PR13CA0001.outlook.office365.com
 (2603:10b6:208:160::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Mon, 8 Jan 2024 15:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:41:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:41:56 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 14/14] arm64: zynqmp: Align usb clock nodes with binding
Date: Mon, 8 Jan 2024 16:39:25 +0100
Message-ID: <aa4c65a8997c7a65f23da3a3088bb5eb64281307.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4029; i=michal.simek@amd.com; h=from:subject:message-id; bh=axs4l9O6YJQEk5Iy903xSlO+KwBZsGUulUfNiut9MLk=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54lqcIrUdXZ07efSqRX7d/5K0eNbEc4/uuPbMf3WwR mb66zdCHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiFXkM8wvmvAy5auN5uuN7 QRtz4DXmoobLrQzzDJdsvjLDS4H39n1JJv77u1d+Ld8vDQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DM8PR12MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: a65a7c36-2296-4fe1-1110-08dc106059dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0Km38g7gLIuFZ7lwjpXDaEKH1wCZ6vB1/ddKAUjjEEfccD6oeklCZEjtFUZyXK0fWxYH1acSRsp2TnqgInmPEUjXIWgo3f4Y6JfxVFZT44OaLcQumT2iW4s4jCmiDxxjhWE9uCDZNITSO1KaKsJgB88jeF4V+p7EyBeanaFPbNuUaLArKn1wg6VBpz2ue6PGiPhhpMpzICifn/1XE7WUZ5risVNcw+ibKp3BgbS4GgpT1g38nCUHyJgUUdA/uQZ+kmifCLnFIvyaH95HlaWHpLjfM0V20y/wc+GD/PygWVTTNjhv8x4aOiPPCjkC0ZW4nvX8IOkicGXIzL4hxhzCU9I+2GbLOMsjKbhPRmVk0JkimEgkuMAsDmijJSx0hRt7fXUkZ963SitcxoixUfqI1C49oMHyd7EoJ2ZCNu0oH/8Y/0jrZ+kKnhlnIPT7X7sM9eJNXwyS1OZeeFY9NNyH8MwWz6kzBs6ijs/Rb0zOr1kWs0b8JZEFsj0I5VKR0wE28X85mJ2zPqC24HbVB4DqBVZCm8klMbZVcv5pJExtPae1Edf3LKkJ8x0PmnQCmJGS9nLpqaAsEze12S5niHFo8YovwCF+jKKaaRL0HLv646Xe1t3hPWDW1I0K8trMZVqk4Ns9VitRq9c2iUbuN+EwRXnJzwyXb+hiAjcWgg1lnb5BUT/seO5q248aHNVQbph/T5ny/e83BHx1BObif/nmu/BP4CLCno35s2//say9KvSDqyjJIg/kzOVi8+ryWWs0gmollyn/iJsmXmAfjxatMpDo631XoNxTxPxGFj1dnFI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(70206006)(70586007)(47076005)(316002)(8936002)(8676002)(26005)(478600001)(336012)(16526019)(426003)(2616005)(83380400001)(2906002)(5660300002)(82740400003)(41300700001)(81166007)(4326008)(356005)(40480700001)(86362001)(36860700001)(6666004)(110136005)(54906003)(36756003)(40460700003)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:41:58.9798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65a7c36-2296-4fe1-1110-08dc106059dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5463

dwc3-xilinx.yaml defines 2 clocks which are not defined that's why define
them (bus_early clock is moved to bus_clk in glue logic).
With also describing kv260 assigned clock rates with assigned clocks.
Also add missing status property to standard dwc3 core.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi     | 14 ++++++++++++--
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso      |  1 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  8 ++++++--
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index ca1248784f59..dd4569e7bd95 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -238,12 +238,22 @@ &uart1 {
 	assigned-clocks = <&zynqmp_clk UART1_REF>;
 };
 
-&dwc3_0 {
+&usb0 {
 	clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
+	assigned-clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
 };
 
-&dwc3_1 {
+&dwc3_0 {
+	clocks = <&zynqmp_clk USB3_DUAL_REF>;
+};
+
+&usb1 {
 	clocks = <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
+	assigned-clocks = <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
+};
+
+&dwc3_1 {
+	clocks = <&zynqmp_clk USB3_DUAL_REF>;
 };
 
 &watchdog0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index 9e5853206eeb..a7b8fffad499 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -94,6 +94,7 @@ &usb0 {
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 1>;
+	assigned-clock-rates = <250000000>, <20000000>;
 };
 
 &dwc3_0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 631484e17ab0..133b464baa9a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -913,6 +913,7 @@ usb0: usb@ff9d0000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dwc3";
 			reg = <0x0 0xff9d0000 0x0 0x100>;
+			clock-names = "bus_clk", "ref_clk";
 			power-domains = <&zynqmp_firmware PD_USB_0>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_USB0_CORERESET>,
 				 <&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRESET>,
@@ -923,13 +924,14 @@ usb0: usb@ff9d0000 {
 
 			dwc3_0: usb@fe200000 {
 				compatible = "snps,dwc3";
+				status = "disabled";
 				reg = <0x0 0xfe200000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
 				interrupt-names = "host", "peripheral", "otg";
 				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-				clock-names = "bus_early", "ref";
+				clock-names = "ref";
 				/* iommus = <&smmu 0x860>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,resume-hs-terminations;
@@ -943,6 +945,7 @@ usb1: usb@ff9e0000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dwc3";
 			reg = <0x0 0xff9e0000 0x0 0x100>;
+			clock-names = "bus_clk", "ref_clk";
 			power-domains = <&zynqmp_firmware PD_USB_1>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
 				 <&zynqmp_reset ZYNQMP_RESET_USB1_HIBERRESET>,
@@ -952,13 +955,14 @@ usb1: usb@ff9e0000 {
 
 			dwc3_1: usb@fe300000 {
 				compatible = "snps,dwc3";
+				status = "disabled";
 				reg = <0x0 0xfe300000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
 				interrupt-names = "host", "peripheral", "otg";
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-				clock-names = "bus_early", "ref";
+				clock-names = "ref";
 				/* iommus = <&smmu 0x861>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,resume-hs-terminations;
-- 
2.36.1


