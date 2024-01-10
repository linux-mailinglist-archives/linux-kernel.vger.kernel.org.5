Return-Path: <linux-kernel+bounces-22822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E552A82A35E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776452895AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CA44F88B;
	Wed, 10 Jan 2024 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PT1W18J7"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B463BB53;
	Wed, 10 Jan 2024 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUs7VQhXhcB5Y1Jmmo1mA92oV5NErAw24tbPVjQkt1QeefoiByNnUBd1HPMz0b6q7JDLfMffm+8WYhgWwl/ozX6LLi2NBy/Fnk/1MD5+i0ORA9/a4UyK/BE53lvuwRQ+9Q9mv/3RJONelXHWjzyFXns4ubnRZby2m1aP0o9pMRkPg/0qTADaFJ4iOC3x6Ye7zg7vS9104v8zgLu4XH/CXlvKyXhVFLnQZybahgpcqpwXNYGMz9MRi1C+TugveIe2WOQZCpPKBPmVkUrAauwQlyn1GGg+RQFduZ/Gp2KzetU+POBobMTmkJdn8oNkKk6Ap4ldIhakJtXF7f4rI3wrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrY+QZb5Ca8Ow9rg7UNssdhiW6V06EIOjAd+S0ikrVM=;
 b=ZthjIqeY+NUVrRrBjxndTwd/KzfJb7d5j8j+jbu40EFS5YqLTr9j3gR+u5LA7FpbFI/ok8/2SCSabxDuFjB7liP5leYEpyyixCixMYM9WZ/cVmX4wj9UnI4Tx7XNnbcCeFY9jL/DVYLYJeEv0rdqgx4zzV8i40N3F3ekq8e/cZSrm6KXgMleMGjG/iFlgKSSNsvoM+iOgUS5tSLR6UJwUHoYyX0wVJZBNho1+18vV96x4vyE2Up4DxUZD3EgqdPvniFVOB4xyxfNI1wMP6BWmdpjRuZ1vNzWJnpIZP/rmIzO473bp22wlrwSmUW4Qyx+xrO8fRH06YGnSq3oADKzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrY+QZb5Ca8Ow9rg7UNssdhiW6V06EIOjAd+S0ikrVM=;
 b=PT1W18J7n3hgOuUmmuY9YgRyclrAsS3D4awCh9creseB5KEK5dT0Gz0GiOLTGFmwXJswkl1kRa7Ki48ZMNgsoazrVRt5/tpNPxtLg8jU1ORkRNcUpVGgiKINOx5KJXy+gB0yuR2L6EwPqE8jzgyKx37q60l2e97SNSrlXs6BeX4=
Received: from MW2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:907::38) by
 DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.17; Wed, 10 Jan 2024 21:35:59 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::d3) by MW2PR16CA0025.outlook.office365.com
 (2603:10b6:907::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 21:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:35:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:35:58 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 10 Jan 2024 15:35:57 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 2/3] dts: zynqmp: add properties for TCM in remoteproc
Date: Wed, 10 Jan 2024 13:35:04 -0800
Message-ID: <20240110213504.3626468-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110213504.3626468-1-tanmay.shah@amd.com>
References: <20240110213504.3626468-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 657a2b81-4409-420f-b95e-08dc122422bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	obMPdar1N/lJK3Cv3mk7QQgQy/RO86V7C6uslwUxRbecOrMfx7XnS3zr4GiM4ThRYBCsNsbxoyv2Iqfnt12ZwT611lo+0urAD+7yc2Cmox3FcjpstdpwoZ3w6l0vyao2WUyy6nAlr8quPTBA+AUpGLpHFNlOZlFo578gZHaR5BnZgN35vgDJjsI/YTUhd/ZGUgzGcipzmDvI7giY3DHx8ueogqZ/Bb+N4rG+74OEFreaFe3Z026Xla2A5jKMrg7ufzQr9ayQGdi9jwfwpivbxKJmcFrdQfZvQOAwzFM/6KyYH6/ECtrIL3DmkhhYdGxZkcOb2yBlJGsPJ33f9YlFQCAIA0EnsX06JL2zeQBh14n4gmKnFowV52ozX74V/aFolxfV1XUJ5+onxrqvZiADpRWyOHJYxjqYXoK74NffwBa9T9Q91gIhpWQGXxu7/jPZfx1Wh8Qkp4ANCmS+OF+Z5fzbFp2gkYczb9PDdc245JTQKsOSc1lvFTpE1yvoqLcg5FxG877+MLkEuGigVE85aqR5MhkJTgcx935xv9nJ+d8bD+0ipr27BCc7vkS9+kX1wXkRXOnclGry2WQLIS/dvQY9lSKPewz8V+NDjGfYcWiTPmo2R8ystxUXs6uE+Zik+h8Nrfyb4bj/rhz37ZPVFBWieSR/67l9I5FTfoyytCWk40JdgdR1NGyImryTd/yz+xmrKFGfM//uTZrbykL3xpe4gFe88nYWUJ0Wsgyg4zrDQryxSftZorSj2yl5NbhgaOpc4jyWzAEUJGB4DQzgwA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(82740400003)(356005)(81166007)(36756003)(40480700001)(40460700003)(7049001)(86362001)(426003)(336012)(83380400001)(1076003)(2616005)(26005)(70206006)(70586007)(110136005)(54906003)(478600001)(6666004)(316002)(8676002)(8936002)(47076005)(36860700001)(2906002)(41300700001)(44832011)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:35:58.9277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 657a2b81-4409-420f-b95e-08dc122422bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470

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

Changes in v9:
  - fix rproc lockstep dts


 .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |  8 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 58 +++++++++++++++++--
 2 files changed, 61 insertions(+), 5 deletions(-)

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
index b61fc99cd911..cfdd1f68501f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -247,19 +247,67 @@ fpga_full: fpga-full {
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
+		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x20000>,
+			 <0x0 0x20000 0x0 0xffe20000 0x0 0x20000>;
+
+		r5f@0 {
+			compatible = "xlnx,zynqmp-r5f";
+			reg = <0x0 0x0 0x0 0x20000>, <0x0 0x20000 0x0 0x20000>;
+			reg-names = "atcm", "btcm";
+			power-domains = <&zynqmp_firmware PD_RPU_0>,
+					<&zynqmp_firmware PD_R5_0_ATCM>,
+					<&zynqmp_firmware PD_R5_0_BTCM>;
+			memory-region = <&rproc_0_fw_image>;
+		};
+
+		r5f@1 {
+			compatible = "xlnx,zynqmp-r5f";
+			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+			reg-names = "atcm", "btcm";
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
+			reg-names = "atcm", "btcm";
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
+			reg-names = "atcm", "btcm";
+			power-domains = <&zynqmp_firmware PD_RPU_1>,
+					<&zynqmp_firmware PD_R5_1_ATCM>,
+					<&zynqmp_firmware PD_R5_1_BTCM>;
 			memory-region = <&rproc_1_fw_image>;
 		};
 	};
-- 
2.25.1


