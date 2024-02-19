Return-Path: <linux-kernel+bounces-71775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5EB85AA4A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27EF1C21375
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1B47A4D;
	Mon, 19 Feb 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jazBZu5n"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0040C4B5CA;
	Mon, 19 Feb 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364794; cv=fail; b=p0rZZhRjG5xKfK7snXo4rJiEraZLxKQA9SdZveH0aFoMQvhSPXH9jR4VtbLlAWh+3eZkvuBD0z2WJMkSAxp2WTsaJB09seA+hUBoc71u8YTeA8+4WTbZKAAbasuxtGRqJmDVZEjVlpjxoIRKPeJTDnMCYykumUHggQgaK/ParvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364794; c=relaxed/simple;
	bh=PNG2yGTVDqAX54+DzLfreLsxA5XONm73RBqez1IitUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgQoUyiXfSdyqrdc5MIl+IxSw6p7L91k+erjN4YgV8LI4OfLOAiGB8LCDxkmtGoH6xNY0WlNzHR9KENGIInmFEHsla+U5xTKPV0AyOhkayBCpgZXLC9xYURnRKcX8BML1KO0vmWq4W21nYJ9IzvGuexrJl+4TUpuf3G94gI6HTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jazBZu5n; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvLRlehUjpszNM6iOU793fltV9jExaxNfM2DuYlQYXgjqbk0nJeFrg3z2fw+WIuTH68euSNimyF3V/UWVYsQl7YnhX3GXSxb29oB85mCr1kBRVcvBwKu96mHKn9rws+Dky1zeaevELTyHc8Z4L1Zdy7ryAntL7NaezO5bBUFC6JcrGo2ApP5D3+b0bQOBTcBGswCGCBdpXZUgdKhapsVK0Jt6tKO5wmRXwI7EDPpCH3Cow3gGZlUqp4x/qyy5RjoPyV4HaUT1THyRQTfVWkBtgvDMsgowPX2hZYODD4KahKM6coUznioJE0PM23NyMLPn4EycnAf9DqnWvAoa/56bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MreDkp+FxtXut9dSZ/EM5Nwd8OWHoGBIM13dERcOSmM=;
 b=FFroZvpAy5hIAUoXmlgEeArWp2i/zanZ7aL9bE8AqbE1Y99sIFkm2b3j+zyDrFrcBkKfnh8IJQHTK6TY2fp+w+qFkice6//GPFk/jKnToXiJLToYLAbcZdKK2Eav/BxBa7XFij4d/V2xoq6ASKEi6gezucT69QtVqd+KmzU219x4S7TfC1c35BCqYV6fPhZOxlL1neoux9Fxo5eD8+ui/G5+P46lFe/4HuMUA1HAAoDJmWMwVo678RSj2xuJ4mFnZlMhPo3zBK5b42g7BD85BHskbsqTONd9rTVXN8NsLLOi/qwfKRqMKmtME/PBEr1UOJD/fSNDM3ZFvc4hLaj/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MreDkp+FxtXut9dSZ/EM5Nwd8OWHoGBIM13dERcOSmM=;
 b=jazBZu5nBq1A1PydbGBB1iaoYeQzkfJ30ddmwjtjVBq80mI6oYbnHrEHsfibVHjF64tKjul0W5dLZW6EOviT72d3J1SoP6Va0yNxzNa3DjhEwXqShE9U/yXV6i1bodwIWleotAe8M+vRxgE3llKCZgOX9FFcTiK+Mt7cD1eQY18=
Received: from DS7PR03CA0289.namprd03.prod.outlook.com (2603:10b6:5:3ad::24)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Mon, 19 Feb
 2024 17:46:29 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::80) by DS7PR03CA0289.outlook.office365.com
 (2603:10b6:5:3ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 17:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 17:46:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 11:46:27 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 11:46:27 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 19 Feb 2024 11:46:26 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 3/4] dts: zynqmp: add properties for TCM in remoteproc
Date: Mon, 19 Feb 2024 09:44:36 -0800
Message-ID: <20240219174437.3722620-9-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219174437.3722620-1-tanmay.shah@amd.com>
References: <20240219174437.3722620-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 01eb2723-38f1-449d-b5c4-08dc3172b34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fwn0lobFcCon4XG0XgVAmrJEfRRR+ZMQ7JKXZb6+hBIu0HV4tZPH6npjYj9BQ42oZtk8imtHsbsNjMAqcmGsbfNf9i6MDseV6Bllvvf4yMFsuqsY4JeBFKdMGd7d1DDIytPV33ayZthv7AFsVsfSmwcXRRpCsAUSoeNtfZd2tKT6sORvXT1gH6tWXi5WVuob+vI+qtDEqtxCuGkaCWgr7uida4Avxt1goeOK/GUAvm+XNqiLgidAq02aI5FCJmwrrL+/QPdjtA/QnvWBHPXAUof97Ckq4KcQU1W89rW00IRd0oNoKj+P9kK/x+5h3+WkPCeBjHEhSvy3DftaAD2R5oOIdOkze4G2AvTcIizA4fsmfcXKnTdaOBb7Trra6DMgHWBiF5mK5YTjHuiMHNV2AHYdh76wh607K/MeESW2M/kI55AZSJNllvkY47nKnG4tqFlWCvC7OLAjbUh2V33q4Oo3RBF/NwWmwSAFEHC3IZIYh4uaRhe4lhEIgNHcLyNs9MR0XmtZYZDAmGjAuAoCHitOd/c+tDVt3Bo2/yH4K7hQVs4mZqYDDL2EA4GTJrDth1jdxKGAXnIxGb7LiDUdKusNcchJBB1cnhuFzBHkDXQxLVslgX2gRaGr9EjcXOpJGU/4OKUxLEvLCThkIdXMcg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:46:28.2986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01eb2723-38f1-449d-b5c4-08dc3172b34e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437

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


