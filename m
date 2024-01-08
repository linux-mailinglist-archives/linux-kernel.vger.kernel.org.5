Return-Path: <linux-kernel+bounces-19794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A329182741E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F174DB22D40
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D31753E2F;
	Mon,  8 Jan 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dNo7Grmj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF253E1E;
	Mon,  8 Jan 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H74KBlR/86gwwVz9puoT/NMVLAYc1W3iF4CXByekRt08k4fnSQrPsll5qbZdU12OKMm058Zu+qvtyb6xKvveBjBLhFCS5VSzOtVMZefTD/t3E/DtuJB6b67ExY7e+v2zw/zTN/IPScye/75ZD6+B4lgj5uuXWzn+leXuuIZyNGMyV0hUSiNHjBUTLREKgpeIU7Wuwljo8sFJliHM+mKL53VjrD4QuX7Kx437csS3uJEkL76FjMBqgVr6fNWS1tnBwfNN2NjkEu4pCtPAoj5bvWVA3xOhF9Sn6O4yKt0xW/hve2/lKbsTQ66IME3AThpSFDe4ehcFpkaaDWERQWUbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akhVudABiMCB5LjYEVjVgQ0lVhWK7fmtR/r1FxIueoI=;
 b=Poa/dEPz/AntOQuAyi+fMHal5ZkGEZLWffPKLT1A+Y9ha4HohI0FPizNp+8RJMiYj4PgtK584CpEtZh6RCu7RHiawq6dVZf40tyRrGwmmsNeNwj1h9kMGdl5M7XsoKf8dJsC4e/6tdKwSIspwNLXYyX8SvM/R4MmXwZ9bFe42T9JBZLVj27L9kto0cvixdg63EVUcyjuhuPdfbm9pc0cBNU/Hy78PJRaA0t/OqCWXScZlddK3PxESRdqmUy4CAHdivfP2QXYV0M5Df1sl8lVtkRufiPzRSmCI7d/Ej2S+w1NZKCNpdbQ50yt3i1M7WonbEqMv3HYln4Aa77Gr5mogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akhVudABiMCB5LjYEVjVgQ0lVhWK7fmtR/r1FxIueoI=;
 b=dNo7GrmjjSPXPQoRcyhPdiaDpZN1CAfwdUNyq2xXlUW6S2/YcZ+bnJXxvLsdxN5lJesDxQHp/quhzusKkiSSI3rHSkZBbvBYFbXKmwa/GrRj/eP3DYXzyp1adbSlLJWFRzX19N7wOZUfmC7+l7i/VuVkgA3uioR9/B+mn6t4IRM=
Received: from MN2PR13CA0013.namprd13.prod.outlook.com (2603:10b6:208:160::26)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 15:41:52 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::f4) by MN2PR13CA0013.outlook.office365.com
 (2603:10b6:208:160::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Mon, 8 Jan 2024 15:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:41:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:41:48 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 12/14] arm64: zynqmp: Rename i2c?-gpio to i2c?-gpio-grp
Date: Mon, 8 Jan 2024 16:39:23 +0100
Message-ID: <94f633e26b7b16cabddb8c7210c2e79208c364da.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7090; i=michal.simek@amd.com; h=from:subject:message-id; bh=fpglwb94TL6ZJTEFt8izxzzpDii9uQoouIkOQV+actY=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54pqtdlqiWq8F65/OPHe1V0p3zsM/VudjVjJ90ZHa2 2FdFyXeEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZyn4lhftyV5btjjrP3pP3l cYzP7by6h0ftN8N8Hy4lXcXnC45fE1rQ6sIQ2fF2/ebFAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 881c272a-acd9-48b2-91ec-08dc1060558e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5RUS4mjX+H7nU/iJtx8sPswJlSVQvWk3uXprNXxfRNmHcsEHwHC2I8PPQ33MpL7XpBD6eic13b4JuB5mJcZFzl9MRs6rVUGopxT+wQGCFLKUxeFdLHvBQ2uXdlpdjnuUIyC9Nr3E/9sKjXTlQtN0osRFw3UNi31gEPJqwUA9kqq99q52ypZwMHuKGjfkLtMQ/3tHO5MiJN7ybs095GObWZng7hY0wh1nLn1SHvwU/r+wgXTXixHJnKYgy5r96IbzAi2a6Pigedl5z7yX2amz2iqyWJFlfB6+avab/ybgGzhVZddZNU60EMBrjcMNCnliZIjN3rPyZ4A/rLc5OUklsFbpFn9v/OcZzl0SmWiFaqoXVx+nrMkBnbsaaBYJ6Bmyb4C799CYBruDAUOLbyo2G4dto51eHBbMxPVNVvxqlX+jbaE1fanEXf2nBMpAZcXStGahDhcH8LO53BYWpN8QZeqAGMMgvHBvY7w9++Sn10jKZyCtGTX5wKNIDRKVKxeQCl7lAZWK8ugAnET4OFP/YotHVmb7TSUpXfFC5eOQjamBFVmk6nJ15IQpskB1Oou0Jy3d42MsawEz9aTCkTKt6ObaZyHoGkD/8wgWc/6ZkCgKoab7LzkVm2bcBVEtjDFZg7YK19hZAkhGSrXtj9ldcVgT0+T5e9h8Bqc1BBdn8qkTUXohloAafp9m2g7qMnEmyhyVdGk7l0Kjcb3jkispS0Cwa4LyfpYLs6Hhmo/wblcuaXo8PP/exmJqK/a94l6KZB/cJ2s+k4VqSyPoWPPFRVVCi3PosHR+wRtWQPxbqh0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(316002)(36860700001)(426003)(54906003)(110136005)(336012)(16526019)(8936002)(47076005)(8676002)(36756003)(6666004)(83380400001)(44832011)(4326008)(40460700003)(40480700001)(70206006)(70586007)(2616005)(478600001)(26005)(2906002)(82740400003)(5660300002)(41300700001)(81166007)(86362001)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:41:51.7610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881c272a-acd9-48b2-91ec-08dc1060558e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323

Anything ending with gpio/gpios is taken as gpio phande/description which
is reported as the issue coming from gpio-consumer.yaml schema.
That's why rename the gpio suffix to gpio-grp to avoid name collision.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso   | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso   | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 4 ++--
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index 585b5845a1f4..d7535a77b45e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -227,7 +227,7 @@ mux {
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		conf {
 			groups = "gpio0_24_grp", "gpio0_25_grp";
 			slew-rate = <SLEW_RATE_SLOW>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index 037f0941ba0b..9e5853206eeb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -210,7 +210,7 @@ mux {
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		conf {
 			groups = "gpio0_24_grp", "gpio0_25_grp";
 			slew-rate = <SLEW_RATE_SLOW>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index 986efae8847a..2a671816015d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -150,7 +150,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_36_grp", "gpio0_37_grp";
 			function = "gpio0";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index 7599a12b64a5..54a32a705390 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -223,7 +223,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_6_grp", "gpio0_7_grp";
 			function = "gpio0";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
index b1857e17ab7e..53aa3dca1dca 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
@@ -125,7 +125,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_74_grp", "gpio0_75_grp";
 			function = "gpio0";
@@ -152,7 +152,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_76_grp", "gpio0_77_grp";
 			function = "gpio0";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index b4456e5b5058..528b5beb4dee 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -277,7 +277,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_4_grp", "gpio0_5_grp";
 			function = "gpio0";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 3b929c0eedcd..2ec0e2d1c869 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -693,7 +693,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_14_grp", "gpio0_15_grp";
 			function = "gpio0";
@@ -720,7 +720,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 59a919368094..a3d9f1b2713c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -274,7 +274,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index 4fe60f22c852..ba8708b88e67 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -286,7 +286,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 03955aa708d4..700f5b5f171e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -704,7 +704,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_14_grp", "gpio0_15_grp";
 			function = "gpio0";
@@ -731,7 +731,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index e3e0377d543e..920eb16cebf2 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -593,7 +593,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_14_grp", "gpio0_15_grp";
 			function = "gpio0";
@@ -620,7 +620,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio {
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
 		mux {
 			groups = "gpio0_16_grp", "gpio0_17_grp";
 			function = "gpio0";
-- 
2.36.1


