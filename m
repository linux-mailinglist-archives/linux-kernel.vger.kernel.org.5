Return-Path: <linux-kernel+bounces-19788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AD68273EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798BC1F22D2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BBB54671;
	Mon,  8 Jan 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vX3Jwset"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913452F6B;
	Mon,  8 Jan 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkuf1M3AYacMtxLTeLhNc7vwot0BAdeNY3F4kP0HMh91+TXUWbAer1PVTsB1ikYr6WC45Xlhe74XweamtT/gs9lKBvDDotaYX48mKfjLJGEMGqIqV1Mti7yjvnLlTQoVfJuXC3FGQ42R2xw1adwTwCuJhzxnRLyLt6C/1JhP41NhhNPgdBZoUR4q753xA6zPE/uV14i8b1VrkO0FdlbremDaGDPEP9JvmAVqPYsf+o/nPHueu15zu7axK+ayrz+SnSJothyoGK6Zgd2tP7YdhGdd0HfgIVP9GmcMG8/mS/5zATFZSGevU79StsexPB1AfxEmtssLvOiWICMN6qhAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXuDDzcfqhO9fgQNp974TyiZJ+L1Yt7BETQ4vL2+mJI=;
 b=evpkLrKf9aJPcyKDxJenqaC+PBib4lotNVI0YBDMxactSPrRST6xi5KkeATaXfWS4/PoQ787mn7gYFtnieZ2+21oABvNCYAQl6GAZv+n25lSb0LY/gvl5wlko3Aqhiels0Z6opVVAoVxiNRre1UWQbniQlkgLinjLVPuhtFFGogEY/PWgZ7NWlxfED4/HYw+hRBdZxceiw7ALQ/MWu1PgeYB54lAYNuYWzTbWmeh3zl9UdBVnynW/SJCDcCzPiC7GPFOzyoFm0aMiJDRsfWyW8oQXSxBBXVGUDggOFycAC3UvjIr3/yQWxdglNPuhe5Ksg7rn0Be6E04CRbOQ0pxaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXuDDzcfqhO9fgQNp974TyiZJ+L1Yt7BETQ4vL2+mJI=;
 b=vX3JwsetYjy4tiQs67HkFXj9DLue2CD4xpI24u9Q/AAIqfK7ojAhElYCRZm2jlXObfuDWZHXIINaXHJ7sK6riM6JykBRNBb6XcpeCtp8D9PfnIeCtV1x4+q81mTjNXcee9ULtz3dGNO0D0O44zCoqorW7I8mRFzZ8gCL/h9YQOg=
Received: from MN2PR02CA0024.namprd02.prod.outlook.com (2603:10b6:208:fc::37)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 15:40:22 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::b8) by MN2PR02CA0024.outlook.office365.com
 (2603:10b6:208:fc::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 15:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 15:40:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:40:20 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Thippeswamy Havalige <thippeswamy.havalige@amd.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 07/14] arm64: zynqmp: Update ECAM size to discover up to 256 buses
Date: Mon, 8 Jan 2024 16:39:18 +0100
Message-ID: <4f7621a790f4aa35b3e7f74683d3ae4ffe820667.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=michal.simek@amd.com; h=from:subject:message-id; bh=kO6lW1upOOBH7LOITIBi6Aijv/ZvT+sNMH9PkpJmFkg=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54uqV5o7yoic+XcqY7skftpcvf8fc2BXuOTvvBsn8n V9vZpzZEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACbC3MqwoD936uYjlsH2u2p3 qx35dSvx9q4eRob5LhMmeJhEJ37vyM5TlFjuM2eC8vSPAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3a0053-13ff-49ec-4a26-08dc10602024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NJYI6otPhoXz5VjGpauFsJnLRUxdWGi3xEcDif3XVmM7LDu3sM4sTKII/s2CSOXACK8bglqgScPITcicRGKHwCJMrDB9hWuLJUheSH7IP7QqgJtd4TR8u07M8eoAJRS6YkfRUrduu9doIz3NOPH3O3yobcVbNTAeR8/arKct4ezgumpHboRlqPWje+3k1s61zlEyXMqi02BZHzA6R0Sg6LFbVHCLUUE1Cudx20IlynMfDgSb1yid3aBSZy4YhHjxMy5yGvuzrtntaFGsrp5PcPn9RuQFPhUAbxv5ldgfiz+8CGdqM9bfCIViw9VTm/gSFp5nfRonrtlFG5GRsr2Aiz39oeHV2zDClPhbZ4Cdc+rDZhfL1CGIPEd6czdxh2bH5HlpDHS7pK8gxfgv/RQRPo5XG/LWtBsPVKX7vno6nZb3P2pnEV3G3anUa1gYcTL2MAPZ4+lKkvNtJn2q1PUe20scXyOr89ba1HC9ov434KyRK9v7EF9DBpeSMrjJ3vsyh3Rc9In5T9HorgCmtpk8/rCM4mvWjquz0xzqoLn9048E40bQy4hhZsdoucvCqeZgk/m5cE8ag3VYBIrOKRLa3osoVNdD8d1uBUx3Zn5vLXxMWlHPiYehdNDIXWzgF+soQFRIfFM1oVyACs9SwIcjp4KEEc/NQICgQ7IeCLaYeE/ndJZIwCcQzJa9r6xFpRfoBc4u0oeX+znFUmG/3KLB2QrhNmkSzp4TyM9V88JlB1j5Ix2XTppY0Zm5rU1pYRs0kJ6DoWOWWgLb1dCUPsxoKB1qfHH5LfZJ9seVHkv+5I8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(40470700004)(46966006)(36840700001)(36860700001)(2906002)(47076005)(2616005)(70206006)(26005)(70586007)(41300700001)(40480700001)(86362001)(40460700003)(356005)(81166007)(36756003)(82740400003)(54906003)(5660300002)(4326008)(15650500001)(316002)(110136005)(16526019)(336012)(426003)(44832011)(83380400001)(478600001)(8936002)(8676002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:40:22.1453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3a0053-13ff-49ec-4a26-08dc10602024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895

From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>

Update ECAM size to discover up to 256 buses.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index c41c935f92b1..f1b0d4a15e76 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -690,7 +690,7 @@ pcie: pcie@fd0e0000 {
 			msi-parent = <&pcie>;
 			reg = <0x0 0xfd0e0000 0x0 0x1000>,
 			      <0x0 0xfd480000 0x0 0x1000>,
-			      <0x80 0x00000000 0x0 0x1000000>;
+			      <0x80 0x00000000 0x0 0x10000000>;
 			reg-names = "breg", "pcireg", "cfg";
 			ranges = <0x02000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0x00000000 0x10000000>,/* non-prefetchable memory */
 				 <0x43000000 0x00000006 0x00000000 0x00000006 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
-- 
2.36.1


