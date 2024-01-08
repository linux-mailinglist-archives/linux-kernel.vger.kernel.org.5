Return-Path: <linux-kernel+bounces-19786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1CE8273E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE13B22A7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429DE53E27;
	Mon,  8 Jan 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p4Jka70r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602451C2E;
	Mon,  8 Jan 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG1rQq2m87Z+b47C0yhCbgno5xAg3uPQNfZX9BHNxOmAq8t2fS02cAJ1U2vSkQ05my6yEyJLwGR5vNOD3zpHDTuEAFSYO0h8+0kkk7Zr2h4Lrka9ENvNYEPpIJ6sSpBMU2LJDIfQaovwT1j/kDFkVreZppDSsGcpDAajANchry9xWFKYrfk5e61Xoo/bRhlNbbETZ9zAzeMke1JN9lKTxn9R1cn3WQoYr8INbGLrEDANr/QQwaIAW0zYaDcvEg+OcR++tVWhCw/dISiRO82llj7vao8BhLX52sT1O+aUAy9qEOeoR7EKEBnHWUCaSQAOKHgDbDMN+245OC/frEjzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc9O8p3cMv5pqVdHECTESI1vEu/LJc58ptJghjFAQ8Q=;
 b=E2GorLhKIsloORvGR07mdbyALNKOp/Wto6S3vMgPNIV/rFBU3llIr+sdX8NVrq7a7rezg7Pnp+DE+L2kiqRxE6kueewEL/FwYN8+m63PrII4wHIW6xkTovy3qjYYhvhAN/Uh91Nj2x38EANQh851zNYdn0/c7u4VI27iF4RhbqOwr8Fp3wgCRZf1cUF8XkDGrGLOIk/uwsUblaKyxhS2nkNXOB2tCGyL/gGlWy2ElygYFOZSLDsLhMxEEjEXULTXY+IqClKBEQkm5Q2/BpwOMzVXED9mhhee9H8MgPoF6N/gvbagfyXD846v+hRKCiQGoVkNfaWHKdm2aaH4GGE1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc9O8p3cMv5pqVdHECTESI1vEu/LJc58ptJghjFAQ8Q=;
 b=p4Jka70rD2CQQcefJy+O1oWaMvxYmXjYaOgFpmCnLtiarWJM5VrfuCGY4uzJa3xMbey0+bvptPAYr5Klxye8zEnJDY8VtsswP1OHJJMqiYjg0CfHPLb+4JEgDhkELYNt+G8Za3+rF166ka8t8YglZnTElTEcxd7eh0kajsDITOg=
Received: from BL1PR13CA0293.namprd13.prod.outlook.com (2603:10b6:208:2bc::28)
 by SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 15:40:18 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::93) by BL1PR13CA0293.outlook.office365.com
 (2603:10b6:208:2bc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.13 via Frontend
 Transport; Mon, 8 Jan 2024 15:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:40:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:40:12 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 05/14] arm64: zynqmp: Setup default si570 frequency to 156.25MHz
Date: Mon, 8 Jan 2024 16:39:16 +0100
Message-ID: <65a53776cbc5e4586f58da57a4b99e4d5c6c26a7.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784; i=michal.simek@amd.com; h=from:subject:message-id; bh=lmMa2YMYHaVedg3PyHU2y16J4g30BLTDhNIOobPXwf0=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54urZH5dfM3v48UCO/8WMN0VdTXv4MudsL7EU5qz+s I9T7C9PRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhI2h+GBdMfnGQJTM/e+vRf 4cUCybiUfwqzzBnmqQad/39liymTtPaVyKsXn3BdqZZuBwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SA3PR12MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 617335ef-123b-4793-008b-08dc10601d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UvQVY/E7+ZcUCVmRWYEDeyg/Cx6siYR5W0/vnBrn1/GrNfS21ANSZi9QAOo7yRWqx5O8bUz4C6Rc8xVdsmnbHfQwk7DBQBQLXNRNUkq2TSLWTvSfGMeD0/LwfP5tv3uayiPIL6F77G2uIDryV7rIQtTAWcfPnO/SiVx1Aa2X67ICpKbV1HZUTR0E5ti2O2JIUAwQNhER3EEjlJgvM7u8Gw4WXoRayYkQBa04AEG2P8GpuWo35FOLDYEuCH4gCH3J3MJkthOEamdE6OHMHHIZ8PADw09xp47MwIjnDihLnQEJ1bEaX+2on6640U+mMlsHMAsBbqJ5RVJWFE2HNZYHJbYryJAICUqtWCtwRNGKqGneKH6z2gVPmKhDkjdgmdfcKYhbeTJ9TTkkoLswXmb6hA/RvzH/wIvGWchT6DqPs6G+RoSalm8Rm8IejMbkvg51FAmS8++VYp9QJRWCjDhEQLDHVbLSOwadM93bdDUhe6XpXVyrVVi9TQTHGBeoYmDNrPYUD2p6IVQqXTeB34UWUrrsdup3rfKihP2LYQ+5zaO0p0Ftg0bB/NV77nhNGc60zN+GKgcJfyyD10fAMc3vEahjFRDahZmtCeufoYH8GOoy9dtjZ2NGLAY1odVxdQPh3YdEnh8sPkOrHQeywCQiVTmBP+F8N6peM3hUDE+Ns6mIWbrh5zyMmm6grCqX7x5dGhM0iRsq+iT4QcUo1aim9VTbm0mO4j8/6dbgTLqhttpCGRsAToqpFNuTCt1nPMo49LDawQ17DIdokME9sRnBgq3XZqrO1enESF8H8fEipE8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(40470700004)(46966006)(36840700001)(5660300002)(2906002)(41300700001)(82740400003)(26005)(36756003)(81166007)(356005)(86362001)(16526019)(2616005)(336012)(83380400001)(426003)(478600001)(36860700001)(47076005)(44832011)(70586007)(110136005)(54906003)(70206006)(316002)(8676002)(8936002)(4326008)(40460700003)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:40:17.6935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617335ef-123b-4793-008b-08dc10601d7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951

All si570 mgt chips have factory default 156.25MHz but DT changed it to
148.5MHz. After tracking it is pretty much c&p fault taken from Zynq
zc702/zc706 boards where 148.5MHz was setup as default because it was
requirement for AD7511 chip available on these boards.
ZynqMP board don't contain this chip that's why factory default frequency
can be used.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 55a8d3e9d44f..3b929c0eedcd 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -607,7 +607,7 @@ si570_2: clock-generator@5d { /* USER MGT SI570 - u56 */
 				reg = <0x5d>;
 				temperature-stability = <50>; /* copy from zc702 */
 				factory-fout = <156250000>;
-				clock-frequency = <148500000>;
+				clock-frequency = <156250000>;
 				clock-output-names = "si570_mgt";
 			};
 		};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index afc5571bf72b..03955aa708d4 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -609,7 +609,7 @@ si570_2: clock-generator@5d { /* USER MGT SI570 - u56 */
 				reg = <0x5d>;
 				temperature-stability = <50>; /* copy from zc702 */
 				factory-fout = <156250000>;
-				clock-frequency = <148500000>;
+				clock-frequency = <156250000>;
 				clock-output-names = "si570_mgt";
 			};
 		};
-- 
2.36.1


