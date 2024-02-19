Return-Path: <linux-kernel+bounces-71770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543EF85AA39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7910A1C21607
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96B3481DC;
	Mon, 19 Feb 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mU93E618"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46146B9F;
	Mon, 19 Feb 2024 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364787; cv=fail; b=DBdUv8Xz6uSBA/TUCL1Zn092gEW8xpLQ4mm0AUNu0RRZqFnw5kyIiufaJ7+z4l83nkozaZZ1Saew+DC+EqImC6ZThbK5nyjdOIIr5nVJmzIeuZNlo5wnk4R/gGvKK6Ad8WgxnSPhFOoDk57xi4xQXBNWhOBN1JvaXlBpxnTQsis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364787; c=relaxed/simple;
	bh=PNG2yGTVDqAX54+DzLfreLsxA5XONm73RBqez1IitUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVYo9zoaHOhRsdeYoOlR0Q42QG3J1t6b1AG1O6Kw3tv3HmEjfFUrI1tdZdHubM8QrMEn7mA6Nx6sUYpf8BhXnJwt+oDA0i6o4OOBuwI4cmONg+duYk16i4x2olCrHPzqxRAz4LxpLEbJ8xBfI4s6bCn8ZN83teNf2PtZ0YopCKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mU93E618; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpY9RgCiG9EZGOZalrE/fF3vRbRnrn/NZ6qwsv4snD3waWOE7FO0xmsAN58+tSSGJAhk/oB9m8ySyTg/oxdq/aF17gvSsVpDQv01wc6kqnuSchVHnKeNa6OUhFGQ9AuNj1t1AWUAUJF7MTk3VOpPNZ/XHMAG0Is+usQb52W3xHigLZE7uMDdIxX2mJHzN7QLdNDvmCARC0yuHlcFGmqadLhU4WwMaPn6lYHJixN/bPPDIma+8EbREkyCWh/4dWmQ6vcLsMtfs1mssX3w1v+FXFfI4lT0n7N1a+Qrix17qeyVxZ5M4uwIE1ewGWLLJ/BoY+TYY5x+el3Fw91qsLsFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MreDkp+FxtXut9dSZ/EM5Nwd8OWHoGBIM13dERcOSmM=;
 b=Zw4W2LRfb1DVMkgmrFxb+x+RlDTYuh/Q139oimwJaKPQxgpRU1Hy2ocLVtaN0pq6pTXFrjNp3ZOfvTxDshxzGdMHoYNsJBGm14Fo3VT2f+pH+Y8mRjlv6ZFtv9urNeyzuX7UZv0WNJ5EMMQxwiAzcYZ/qLp/7QH5n1RjZIKKZxAj73m978iINQ4tnMOKrkjFliE9HGC1RRKeaSvc+XxoIg30YqIJ7gsyT/FBlsJcOHZ4kIcnDrL9MPCTFTWdO53FCKv2Klm78qiCnSdEGnkPWJWRvAzT2iFaAJhR0WCtngx+aFP0BPDjUnWiSSMMxvhVL+fNiCrIFeA7nuEwMshuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MreDkp+FxtXut9dSZ/EM5Nwd8OWHoGBIM13dERcOSmM=;
 b=mU93E618qEoTl7kUpAmvtaL7WIe1K3zyWVUVPjaOIVEB/oP7Hoe1xIyMHYgMF3YdQVCZRNWhWY1FL+v8MO43eZPDw/A9cm6sV3PjCMGsN2+BGlEbYDv+82AlYVziRMsz2IOTg3sd1qSFPyOPCXSOblKCjbtZ3qQ4bdctqQyuUfo=
Received: from MW4PR04CA0274.namprd04.prod.outlook.com (2603:10b6:303:89::9)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 17:46:23 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::ef) by MW4PR04CA0274.outlook.office365.com
 (2603:10b6:303:89::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 17:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Mon, 19 Feb 2024 17:46:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 11:46:21 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 19 Feb 2024 11:46:21 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 3/4] dts: zynqmp: add properties for TCM in remoteproc
Date: Mon, 19 Feb 2024 09:44:31 -0800
Message-ID: <20240219174437.3722620-4-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d6c83d-97e7-46a6-2f8c-08dc3172b00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5/jVDuEdHLuyWC4pqwDT8MgrkPvsRdoIZP4iNWjzmg0O6tBIeqWdVaDtU2AfUOjnttxj9gf5mB8Nx+cPsoFsukydIM5QyxOsSYw12MOkPEOc7aUQqOioWAaRSvy4HGHep1BF/Yt+NUhzyl046XXYdsNcJip2Z7Ztk1Axtof87WQuTbSElAT0+D5FzPcUa4piCO67Z9WeXgIZai07gYmjVgsAtuFU49E+SUQDAJZOQK86bX+Q1WSvNagZU0POuoqrcPYc2QTvNZRtGOdRR5hxyFoIKgotsGthcXAqMzOd75OGgJNeG4UDd9iSWNZzlN/QhD+X2w1ZK4YDW+3koFhFKjj+j2r8XVQ6u0o97j+sXt0KACYrhIy7kVbJrPiBtm4l/gm3+c2ofVNtUtThntOU/VdYWiPAa8c8raSz/myIR5Jh/5uJFI/iD4sNiQXSM02PzRRmL9SU5mh6lbC6VFqj9e2tT/b7kf110TGrSvdrZ/xKN76d/sesSnbwNuJ/lOerWbash9e2GOyh1kNt81n4Aavl/m/mdDUzBiH8CZCv4uOpgfglYGV+lnHkr9Y6zTccQ4js+MWNA6plYKmXQ94ROMp8Bk9Ulimu3HXcyaW7K+eB5Ep77hcH0Sgj2gpNF6zIpi/MHbPN191dvIESbjBr4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:46:22.7736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d6c83d-97e7-46a6-2f8c-08dc3172b00d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256

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


