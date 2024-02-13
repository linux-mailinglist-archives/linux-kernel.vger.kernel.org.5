Return-Path: <linux-kernel+bounces-64035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FF7853934
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81191F229F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9299961678;
	Tue, 13 Feb 2024 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SsqNK2uu"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86806087F;
	Tue, 13 Feb 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846932; cv=fail; b=N7+sU6tpgjeYTsMeV0E8+WDaIYfEKWSQ6OkUficIcqmwgo68iPvhTBwyA0WmDzQLvlRHL8c6R3C8U9O0hXm8WdZ0hnZHIV1LmCqwJNY2XMQKewSXmCXOZS9jn54HtPV5gW/VOH9t54pVxNr0D+zWCc0qIwZAcFCKw/wAfs4lMwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846932; c=relaxed/simple;
	bh=+tnpjwq05Z2K6cjecAXZoEj9OCAHkBSdqg2TgaxczZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dICOi4qSYtNfbMsy1KzI04Xmqqen3rbrBFR64i2CJiMnBNwGfhgvlEylhmTnyDC7osAA6BaTfLIUcCwcTsEu+Ynfb2+Q8nDgTb2z4tecVmZ+5sWtZLdVS2SI5xOYPsMbks4y1w4DWuVmV3GvVUHD6iSu5cDy/bVTSGWkWW8D6O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SsqNK2uu; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsnkjkn7PzeyAzpcxufxRkN8ZJ4XqeznPieRxnn98I91wLJ3ym288H/Eum3QKm33tpLgaYkzr9E+HKbTFBHFxvXbXbu7Oq7mmgBP9TsDygMn9Kc6XNsKwTpfksRc2wv8Q2ol7064xJweEKp7aP9DCWp/E2iZecyD36irLVqPoaX/py6sz0hTwVmI+2nl8FWGP4YNYNDWmBoe0FkyhuLS/5QXCU3OtQAlNl2YCagRUoVAr7qdfhK3Q+ahisribZvmhc4kVsM1+5Qc3+gzmfs+jaC8g5g78rsf4WhK/D4CsWtjodZuZ86g0tlawJdGEQqbCvy+qlnJPk9FqZz13agByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QA/OwtE6xWO68xgFUN3U7BEEtUwHBVoPpTFE0kZ0kyo=;
 b=dPUCkcixkPmnD1OPMa/Rs15CgmbvWkO5WlDn4KX1zDTsGacIXQ56UID/pkClMiSgbG8pbtpgjxGaEXMAJvT5qw622hKvgFkRCz8uvGb00GD7skFm5WqPRvzFgWBERe799XIXQu5qkmEByFnDEm7c8b6GKzKHCFiwBUJL2TOwcc9zcejaoDAbhtPIC0LZgbyFutYkpxesTOMRJrh9U/3v/MZWSOZ24kpAFT6PnpQxWcXXDJIKLlpI2Ec7IGOaJ1tMHt5w3htqB9ShzcihSi/Iua8GJVtcVvXsTJ1MH5kUYHzJjrc9wMtic955l+iEOKaxWGMbyCVbx6nfjhm0phf1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA/OwtE6xWO68xgFUN3U7BEEtUwHBVoPpTFE0kZ0kyo=;
 b=SsqNK2uu28r8cge9qX/HfhEg8Ayz6AdFPPYBhm4dgTqBpjxToclO6gUzEGPkdfbkJJZ+DhVN5sMXEkTdhLIHQIN622Rk2XjERYUui66k1ZDM1dyQ1Wtm4o4tST/j3gfx1TkWqqk8J0oSWvmnywq0pA5R+4Uf9ramebWUuNgZWig=
Received: from BN9PR03CA0102.namprd03.prod.outlook.com (2603:10b6:408:fd::17)
 by DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Tue, 13 Feb
 2024 17:55:26 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::22) by BN9PR03CA0102.outlook.office365.com
 (2603:10b6:408:fd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 17:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 17:55:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 11:55:25 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Feb 2024 11:55:24 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 3/4] dts: zynqmp: add properties for TCM in remoteproc
Date: Tue, 13 Feb 2024 09:54:49 -0800
Message-ID: <20240213175450.3097308-4-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DM4PR12MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: fc25ac16-3ea1-4250-9076-08dc2cbcf569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ohn6KPdXEwbX2IHWVMytZZuM/yC7HmaUMp24GlXL7qUmyKcQ8Y6WCyf6OEvBvI3TxXthvFFgd8oINT6Gky5T7nonQ/pZ9+Ub+89JZ3QWEgs3De8bwRCE2VG75oeQvBBHY4VE+PP2ypVGQgvUynUZam/R8fEquYlZJeW0h5rLBecwQNgmGFnazKn+i4w+QIxnfvInBPgx6Q09139XSb3WpQTa3dDF41uTBWNwkbjHI7VFq2okKLXRkkLePByyo/KnFzfsxqyrYqugtoLhFUJnUEGcWRm/JHzGHr19L7Y5WKatoPD4VGPDqoOJFa6XbPFP4xois/bcnpilXqiORxq6kMzHRmRDd5kn/7lhKxXXpFmN2V0aRyvX2TeeXXFbUngIOmNiXSbmC74phk+BnR0Zzyif7ODX5iamdtoDBAI0VoMUzsFupCuAx8t/cotTzvH7dFoOSxQEPDcAM2qTlE6IXBHC5HeCl8zbEQQf10Z9y5cQo5hZG8bWYgvvmjAG3TpPW47Zf9rAwMuTHx6k5l6v/OwcM4QT2QZoQoMkycsnmROA7I2DZhOaaUPQwMVYW5fY1ZFBtESJ9fNCVrU5RAVUAGmRQZ//iLVJZTcBm23KhVQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(7049001)(44832011)(2906002)(1076003)(26005)(2616005)(336012)(41300700001)(86362001)(36756003)(426003)(478600001)(83380400001)(82740400003)(70206006)(70586007)(5660300002)(8676002)(8936002)(110136005)(316002)(54906003)(6666004)(81166007)(4326008)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:55:26.2109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc25ac16-3ea1-4250-9076-08dc2cbcf569
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071

Add properties as per new bindings in zynqmp remoteproc node
to represent TCM address and size.

This patch also adds alternative remoteproc node to represent
remoteproc cluster in split mode. By default lockstep mode is
enabled and users should disable it before using split mode
dts. Both device-tree nodes can't be used simultaneously one
of them must be disabled. For zcu102-1.0 and zcu102-1.1 board
remoteproc split mode dts node is enabled and lockstep mode
dts is disabled.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v10:
  - Add individual tcm regions via "reg" and "reg-names" for lockstep mode
  - Add each tcm's power-domains in lockstep mode
  - Drop previous Ack as new change in this patchset

Changes in v9:
  - fix rproc lockstep dts


 .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |  8 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 65 +++++++++++++++++--
 2 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
index c8f71a1aec89..495ca94b45db 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
@@ -14,6 +14,14 @@ / {
 	compatible = "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
 };
 
+&rproc_split {
+	status = "okay";
+};
+
+&rproc_lockstep {
+	status = "disabled";
+};
+
 &eeprom {
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index eaba466804bc..c8a7fd0f3a1e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -248,19 +248,74 @@ fpga_full: fpga-full {
 		ranges;
 	};
 
-	remoteproc {
+	rproc_lockstep: remoteproc@ffe00000 {
 		compatible = "xlnx,zynqmp-r5fss";
 		xlnx,cluster-mode = <1>;
 
-		r5f-0 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
+			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
+			 <0x0 0x10000 0x0 0xffe10000 0x0 0x10000>,
+			 <0x0 0x30000 0x0 0xffe30000 0x0 0x10000>;
+
+		r5f@0 {
+			compatible = "xlnx,zynqmp-r5f";
+			reg = <0x0 0x0 0x0 0x10000>,
+			      <0x0 0x20000 0x0 0x10000>,
+			      <0x0 0x10000 0x0 0x10000>,
+			      <0x0 0x30000 0x0 0x10000>;
+			reg-names = "atcm0", "btcm0", "atcm1", "btcm1";
+			power-domains = <&zynqmp_firmware PD_RPU_0>,
+					<&zynqmp_firmware PD_R5_0_ATCM>,
+					<&zynqmp_firmware PD_R5_0_BTCM>,
+					<&zynqmp_firmware PD_R5_1_ATCM>,
+					<&zynqmp_firmware PD_R5_1_BTCM>;
+			memory-region = <&rproc_0_fw_image>;
+		};
+
+		r5f@1 {
+			compatible = "xlnx,zynqmp-r5f";
+			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+			reg-names = "atcm0", "btcm0";
+			power-domains = <&zynqmp_firmware PD_RPU_1>,
+					<&zynqmp_firmware PD_R5_1_ATCM>,
+					<&zynqmp_firmware PD_R5_1_BTCM>;
+			memory-region = <&rproc_1_fw_image>;
+		};
+	};
+
+	rproc_split: remoteproc-split@ffe00000 {
+		status = "disabled";
+		compatible = "xlnx,zynqmp-r5fss";
+		xlnx,cluster-mode = <0>;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
+			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
+			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
+			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
+
+		r5f@0 {
 			compatible = "xlnx,zynqmp-r5f";
-			power-domains = <&zynqmp_firmware PD_RPU_0>;
+			reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
+			reg-names = "atcm0", "btcm0";
+			power-domains = <&zynqmp_firmware PD_RPU_0>,
+					<&zynqmp_firmware PD_R5_0_ATCM>,
+					<&zynqmp_firmware PD_R5_0_BTCM>;
 			memory-region = <&rproc_0_fw_image>;
 		};
 
-		r5f-1 {
+		r5f@1 {
 			compatible = "xlnx,zynqmp-r5f";
-			power-domains = <&zynqmp_firmware PD_RPU_1>;
+			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+			reg-names = "atcm0", "btcm0";
+			power-domains = <&zynqmp_firmware PD_RPU_1>,
+					<&zynqmp_firmware PD_R5_1_ATCM>,
+					<&zynqmp_firmware PD_R5_1_BTCM>;
 			memory-region = <&rproc_1_fw_image>;
 		};
 	};
-- 
2.25.1


