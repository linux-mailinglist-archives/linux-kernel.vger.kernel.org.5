Return-Path: <linux-kernel+bounces-135923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7642B89CD1C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCD6282C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F19149007;
	Mon,  8 Apr 2024 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DMBfN2JC"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9461487D2;
	Mon,  8 Apr 2024 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609648; cv=fail; b=n981XYmSh7Nvi8qgCSe++zw075WK0s2A5+np3t3kVVSjJMGfmrO+KRru3rjj9d0Vy88++dAvqqWhAcOt1AdmZAw39CAMHPM08jtCdVLkqVxKYNnLibPV+OxROV1mRptXLcU4du0zDxfTAR+tKZ+UxfoNl8k7F+y6qi0WpbjaPKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609648; c=relaxed/simple;
	bh=5y2Qw/XJs03FWV9WmbMxC1+n8QNLXf1HXrUsHLixrQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KH4kXkRakvtb9C+7rDGFjvTQrz0Q0z4AEGduE4L3fxCwG5T2sqiSH9VcwnMpOwQv1BRcd5tXWI+UGqkxQvDBETn5YFhe7OCt7XoFspjo8YJRNL2znQtyw9dSSktaUN37WrWaxW2nNjDWM22ZER4l2kM/oW1cuKQC90aDMPkGKYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DMBfN2JC; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0zuQShPWCc2UYMNLwH+FBQ7WSRQmpGnvkx483s8A3YRhcrCcdql2hh1E8cm9padTnUws6ZV14e9gxPWtPmLyxrvpIWui2cvRLf7UHgcbKWkJ661uuDme+SIDAw25HJEYlg4uzedVnUJWonmERtN8DyPU4WBnkZ/L++Wuu0KPC8IkKIf6FSN5xKMHKTb0wNaHz6IgjucC48UQhJVTKqsNkQWXVSY89MreNF+CI+O3Ti6XE8wszWjy83YuDLnAe5oeGET1SlAsUYf+3DFbYaQe3xo6E6ev5dPX0YnleQeTkTzP2jelGLwOl6HkGgOPnjJvQso2GHnjH8now4j5lzDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAjoUvoP0VdhqCDNT37xAvZJDEojLRB9/OAPIdx+6fM=;
 b=c4m2glWIWyMHZLQ4Doq/8ILcBQvtzXW/ry6Ct1D5jsjjaTBmSy7kWlECy4WPl99Yz11siMZQ1IAEFS3YWM96+8D9BW0hh/0v3XWFKkKJQN7DPXVpQ9/t/mtF9rwWfI9Y8nTPeJR6/URRA1emEq2GINaNYCeh/1k3D+mehifKo5X2Ju6TykI9ZIKPUKnHUqLA3F3U5eKpJF62LipJQUZPFianjHRlRipwUHf+LX0SmBZ3dS5EjsaOUYr+9S3qM/RUi4Npcg8kSpOn/uj7fTn59nXuCMQvchYa+iQostvwqGYlVd0KjyhXDyBlQHinQaognKyr86ugYh10vd4bjvvXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAjoUvoP0VdhqCDNT37xAvZJDEojLRB9/OAPIdx+6fM=;
 b=DMBfN2JCRJCvZ3aRzfhmAgq6QLUtMbpK4tSSJ9rUDzEVaMmwbylPpN98RN+lnxK0kLjW/ecCzcWxIxG3Njvc5qK2iYw4PA1zf78HllwHkrMVqUQB67ou6ZNaq9e2jwLNJV4CccAUh6XbaqsKpCWixbXZIOKK80hHh6+1ckOvU0c=
Received: from MN2PR02CA0032.namprd02.prod.outlook.com (2603:10b6:208:fc::45)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 20:54:03 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::88) by MN2PR02CA0032.outlook.office365.com
 (2603:10b6:208:fc::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 8 Apr 2024 20:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 20:54:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 15:54:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 15:54:01 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 8 Apr 2024 15:54:01 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 3/4] dts: zynqmp: add properties for TCM in remoteproc
Date: Mon, 8 Apr 2024 13:53:13 -0700
Message-ID: <20240408205313.3552165-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408205313.3552165-1-tanmay.shah@amd.com>
References: <20240408205313.3552165-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 8299a45d-b62e-46e7-0e2c-08dc580e05f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6yvaKP0siBXGoBxdWqbyhgAHhQtYJO6dMes4hwi/UKcZMhtawfCT3uMmIFlRVElUD9kaO5pomCaBnmUmNq4l9HTnluWhGNLfCi9LYeXHWmDhRdbiijsAiePJu7Ayki7IffLdeC/GyQulmAPUIy+GxmDb7ZWQ1oM2WwiZmaIUFdR8sChBPzrxswBXEvssO6MO+WEKDsKwAvBBE+upXk9sfZFp8waXow9uTUrVrNO5OJS+aiqrt0AlCU5ys+2CMcbaEhkY6xg72Hgxx+/C9jG6ZgJlkY3vR9/e2eM80ao1see8P7/oxb5lJQMjD9Nj2MfCDHlsC/Okh+FaPxW/dAf30OlGRVHBuGMMpyPOGM1HUCz1+8ddynGXNxucX25kEbB4OafLH3KMCTZomG3dgwTp+wUB9o12i90ZPB7c5ho5m/9v2xlBM+ydj0zBbvVCebsQDB6PsdKafmvjm96Slz8ZZgiemzIwhDAvsMbDZaGIVLmTfbwBseK1Rbyiv7lQ82tP3Km3JXw6ItIAYAn+2fxeO30z9KhENFA152EGQDgX7R9HhqQ4tHK57LI0oDmn03J25oUAkife7uIAk9JgyTHwdEfP/N+UbXxZBESXy1gKGupc5MLF1KbggVhb+MRsSFN0sPsjmzTm8Fpk2G8gIGSDw8vQ0gkJ6lErBfWoKAHWM1c5hfLJ+dBXcKSzn6us6YGyqCQJ9WsrsD1nyfe6pjypfD8paXTKqPLttha/n4I7wVn4SHpQFUlLl33kTMLFIJEa
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 20:54:03.1603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8299a45d-b62e-46e7-0e2c-08dc580e05f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794

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

Changes in v14:
  - Add xlnx,tcm-mode property in remoteproc node

 .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |  8 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 67 +++++++++++++++++--
 2 files changed, 70 insertions(+), 5 deletions(-)

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
index 25d20d803230..ef31b0fc73d1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -260,19 +260,76 @@ fpga_full: fpga-full {
 		ranges;
 	};
 
-	remoteproc {
+	rproc_lockstep: remoteproc@ffe00000 {
 		compatible = "xlnx,zynqmp-r5fss";
 		xlnx,cluster-mode = <1>;
+		xlnx,tcm-mode = <1>;
 
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
+		xlnx,tcm-mode = <0>;
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


