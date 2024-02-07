Return-Path: <linux-kernel+bounces-56460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4538E84CA6F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E7C290F47
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4834F5B5AD;
	Wed,  7 Feb 2024 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d6WIB1Lh"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35F5B1F9;
	Wed,  7 Feb 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307569; cv=fail; b=Z+Jm6tOKz6siooVP+Vf7nGyv5MgmODPwGpFZuhrfnyRtkDUMU5Q3IwLMsLFTEvGODEVkXxQb8NF/D/5zX2CKnwNIVZYqw9HJ8tUe3IyfoGLdem/+2KuTuHcmoAhA0w/eGSfGjhMOvCwuJH+UkwtHJTiiLO+YRsPLfN//i1qfQfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307569; c=relaxed/simple;
	bh=Fw6hzNUfiu56SsPuRbyoTa76DQS/6OAS09usTHzIGNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8Bljnijixd1DFfUKq3aH/Dw0pVmiV5Jzi7F9X6QqIutCQirZvZvE+EG5bVAaRhnUqshv+JiOt/w8U6uyF6qMtp8Xl4pYuTQEe6OJmKW0bfabdBGbUMieoLuy/ODsxhVLlxttzay/WRsB3jbWXgi7T8rVwJOm+vKKYeawFxcAdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d6WIB1Lh; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hN/lShrSN+IW0HEFSj8NIisNcaTggl1gYTe+qdpa7w6IYY9hsidlLjlpuvIzvRBZ0sZC8k1nv+QV4tIc8tVwUBSBJGcIms4w63tNJJwtc6zMqXG8chN350ubIHnmbU9Vn7ed1liaxWRbHQFhK+b/FIX5Dlj2Y0b4LesyVDWXpRR6CqZO8V8x16BhBwOqm9r3pqlXsx96+FDXiwCDqrSiyvwDNgP437KkDc7cv1Ke8hZOSmULIraDy9PEsocZ8GyHC2ye3UEi72GeWWS99FC8mF3StmIG/8v2wICF1JTmj/YolYmA8oVcRieuXFReF3I3u0wxcCtRcYSn3BmFAmIoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Pz/kOuKKZZ59Qn/ZT9FUsOjfwSoaX5HAQIw/A9zQR8=;
 b=R5l2SVdWEA4fupsgELdnLeP3+803XJFmrDcIFACOlc67/k/DPLF4tPyA77ggBf7jYW/I+BHeI2U0OmxKAeJMnGWzeVU8FxvZlzCBumOEkDh0Nlie3jvAormb4sexMrWIX5uiOB0A5GHgFamNbWg74iDYFwyozRwq9k9Jghx36a4Z37u/hSxMowbkwQYnceO932JuqQDImwGvn01P5pmKeFPE+OMukCh35pwXXyWRdw2h2D6fkgIdfU1K7bEbYWCFtZCld8adJHwxA8r8o42a5u+t/ebcbZk6WVvOL4gh9/67+wv4rx0Hk923spToVyVVx1IxhmoGV8c4TPy4lHKK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Pz/kOuKKZZ59Qn/ZT9FUsOjfwSoaX5HAQIw/A9zQR8=;
 b=d6WIB1LhsswOxenkEj5f5Z/Fm2LWW3hCxHZftGCuqNH6uNFZYYkAyzVBcWf5AB6MURvVK/33a2SLQhLQGZkPN+gvAHPkZibqpeuZr1wrVSW9QY2K75AhV4nKnQZ3jJ+WJOuG1U5KedCGiGitL7MDG54YWwPcKibxkZOxNi7QP5/xGS5MLjRJJWy8K5BUc54vvSUyPr1B3XRafNroP+YUMsu6sP78WFL/ZwQr9bEpF0LkM75EFBnE6JFh1W5/tX1rl9Q2KXrdDNGp3vpAERZ+SPm258a6kNXhVvwGwruKTWkSL4dsDRBzmShoiZivCXMYSD4Hf4IzEueNvydPI9VT2w==
Received: from DS7PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:3bb::18)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 12:06:04 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::bf) by DS7PR03CA0073.outlook.office365.com
 (2603:10b6:5:3bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 12:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 12:06:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 04:05:51 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 7 Feb
 2024 04:05:51 -0800
Received: from sheetal.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 7 Feb 2024 04:05:48 -0800
From: "Sheetal ." <sheetal@nvidia.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
	<spujar@nvidia.com>, <jonathanh@nvidia.com>, <mkumard@nvidia.com>, sheetal
	<sheetal@nvidia.com>
Subject: [PATCH 3/4] arm64: tegra: Add audio support for Jetson Orin NX and Jetson Orin Nano
Date: Wed, 7 Feb 2024 17:35:17 +0530
Message-ID: <20240207120518.697926-4-sheetal@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207120518.697926-1-sheetal@nvidia.com>
References: <20240207120518.697926-1-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 3548f33f-a658-40eb-e453-08dc27d528de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bEAhxD/MXmdFxwjqi85+4YfrhhsvknZiCccqAiUGu+gcwxWbMnWTciHva/H0opJJ8T0WJyiz8XVIBibIeGY0OIKM4ENFQQRF91zQvbSPISdwLV0dUwUqzin3/FzM/kLf3FxZJqOR8Zs31j2B1JNiM8FsGD58OHjlaLlp7C+UBufk6TAEGOkuCjmCtorPQvMY4YnKShsLkKzrFe2uxowPnnTv8OSB3sBDayQ7lS4vYYXHbfhoe1MVAxMZ2cPiUhEI5XwFG5WXr6xsOZrKXOgJBhVbdWd6JHWBZQswkrQOh33GLFshg18oJgcrQZagNXQy2GUbYUuMs1V5vZauYcemsF06Rzgo9QqlDbuCDr4dgV+byHpEgZko+vO34YJnr05hLJY0KEe/n2YPZEa5CkteiGv9vfOVRENUIWdQi07Z2gflRVrlj1JhQeQe+XOzDD+Yg0fCXgt6mKhaU7g69t6GeFVZRBjw7G8+NZXk2MkDYabF1ZhKPLk9hXeiLFT0bCAGLvnxkzNMcvNPSLgXeT1dyKpy1qU70wex7bDenW2k2K1kN4BioptitV/kIR0+LDWdNvS4QQPYXbCBjpo8q4v4wj1fJaJhC8WPKy/dUQQY7yQa2ZHvEY8SNj9396C48j+xofYJLMNMRQ/04ShuwL95DBUUKRUIYDuIrZTXaGzz0kZVneRMl9VuOYBMMTw3eFkihzoKFajMdMyAkrpL8k22sKDO/oN31RzGYPRNIe8qmu554ClUivoZh4HJ2IlWqm6k
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(36840700001)(46966006)(40470700004)(1076003)(2906002)(70586007)(316002)(4326008)(8676002)(70206006)(5660300002)(110136005)(54906003)(8936002)(86362001)(478600001)(41300700001)(82740400003)(426003)(36860700001)(356005)(7696005)(7636003)(83380400001)(26005)(6666004)(336012)(47076005)(36756003)(107886003)(2616005)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 12:06:04.5418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3548f33f-a658-40eb-e453-08dc27d528de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280

From: sheetal <sheetal@nvidia.com>

Add audio support for the NVIDIA Jetson Orin NX (p3767, SKU0) module and
Jetson Orin Nano (p3767, SKU5) module Developer Kit with P3768 carrier
board.

APE and HDA sound cards are enabled.

Supported IO interfaces: I2S2 and I2S4.

Signed-off-by: sheetal <sheetal@nvidia.com>
---
 .../arm64/boot/dts/nvidia/tegra234-p3767.dtsi | 82 +++++++++++++++++++
 .../nvidia/tegra234-p3768-0000+p3767-0000.dts |  5 +-
 .../nvidia/tegra234-p3768-0000+p3767-0005.dts | 10 +++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3767.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3767.dtsi
index 59c14ded5e9f..1b23d37e4463 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3767.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3767.dtsi
@@ -6,6 +6,30 @@ / {
 	compatible = "nvidia,p3767", "nvidia,tegra234";
 
 	bus@0 {
+		aconnect@2900000 {
+			status = "okay";
+
+			ahub@2900800 {
+				status = "okay";
+
+				i2s@2901100 {
+					status = "okay";
+				};
+
+				i2s@2901300 {
+					status = "okay";
+				};
+			};
+
+			dma-controller@2930000 {
+				status = "okay";
+			};
+
+			interrupt-controller@2a40000 {
+				status = "okay";
+			};
+		};
+
 		i2c@3160000 {
 			status = "okay";
 
@@ -127,6 +151,64 @@ vdd_3v3_ao: regulator-vdd-3v3-ao {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
+	sound {
+		compatible = "nvidia,tegra186-audio-graph-card";
+		status = "okay";
+
+		dais = /* ADMAIF (FE) Ports */
+		       <&admaif0_port>, <&admaif1_port>, <&admaif2_port>, <&admaif3_port>,
+		       <&admaif4_port>, <&admaif5_port>, <&admaif6_port>, <&admaif7_port>,
+		       <&admaif8_port>, <&admaif9_port>, <&admaif10_port>, <&admaif11_port>,
+		       <&admaif12_port>, <&admaif13_port>, <&admaif14_port>, <&admaif15_port>,
+		       <&admaif16_port>, <&admaif17_port>, <&admaif18_port>, <&admaif19_port>,
+		       /* XBAR Ports */
+		       <&xbar_i2s2_port>, <&xbar_i2s4_port>,
+		       <&xbar_sfc1_in_port>, <&xbar_sfc2_in_port>,
+		       <&xbar_sfc3_in_port>, <&xbar_sfc4_in_port>,
+		       <&xbar_mvc1_in_port>, <&xbar_mvc2_in_port>,
+		       <&xbar_amx1_in1_port>, <&xbar_amx1_in2_port>,
+		       <&xbar_amx1_in3_port>, <&xbar_amx1_in4_port>,
+		       <&xbar_amx2_in1_port>, <&xbar_amx2_in2_port>,
+		       <&xbar_amx2_in3_port>, <&xbar_amx2_in4_port>,
+		       <&xbar_amx3_in1_port>, <&xbar_amx3_in2_port>,
+		       <&xbar_amx3_in3_port>, <&xbar_amx3_in4_port>,
+		       <&xbar_amx4_in1_port>, <&xbar_amx4_in2_port>,
+		       <&xbar_amx4_in3_port>, <&xbar_amx4_in4_port>,
+		       <&xbar_adx1_in_port>, <&xbar_adx2_in_port>,
+		       <&xbar_adx3_in_port>, <&xbar_adx4_in_port>,
+		       <&xbar_mix_in1_port>, <&xbar_mix_in2_port>,
+		       <&xbar_mix_in3_port>, <&xbar_mix_in4_port>,
+		       <&xbar_mix_in5_port>, <&xbar_mix_in6_port>,
+		       <&xbar_mix_in7_port>, <&xbar_mix_in8_port>,
+		       <&xbar_mix_in9_port>, <&xbar_mix_in10_port>,
+		       <&xbar_asrc_in1_port>, <&xbar_asrc_in2_port>,
+		       <&xbar_asrc_in3_port>, <&xbar_asrc_in4_port>,
+		       <&xbar_asrc_in5_port>, <&xbar_asrc_in6_port>,
+		       <&xbar_asrc_in7_port>,
+		       <&xbar_ope1_in_port>,
+		       /* HW accelerators */
+		       <&sfc1_out_port>, <&sfc2_out_port>,
+		       <&sfc3_out_port>, <&sfc4_out_port>,
+		       <&mvc1_out_port>, <&mvc2_out_port>,
+		       <&amx1_out_port>, <&amx2_out_port>,
+		       <&amx3_out_port>, <&amx4_out_port>,
+		       <&adx1_out1_port>, <&adx1_out2_port>,
+		       <&adx1_out3_port>, <&adx1_out4_port>,
+		       <&adx2_out1_port>, <&adx2_out2_port>,
+		       <&adx2_out3_port>, <&adx2_out4_port>,
+		       <&adx3_out1_port>, <&adx3_out2_port>,
+		       <&adx3_out3_port>, <&adx3_out4_port>,
+		       <&adx4_out1_port>, <&adx4_out2_port>,
+		       <&adx4_out3_port>, <&adx4_out4_port>,
+		       <&mix_out1_port>, <&mix_out2_port>, <&mix_out3_port>,
+		       <&mix_out4_port>, <&mix_out5_port>,
+		       <&asrc_out1_port>, <&asrc_out2_port>, <&asrc_out3_port>,
+		       <&asrc_out4_port>, <&asrc_out5_port>, <&asrc_out6_port>,
+		       <&ope1_out_port>,
+		       /* BE I/O Ports */
+		       <&i2s2_port>, <&i2s4_port>;
+	};
+
 	thermal-zones {
 		tj-thermal {
 			polling-delay = <1000>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dts
index 61b0e69d3d20..4c75dc940e99 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dts
@@ -37,7 +37,6 @@ pwm@32a0000 {
 
 		hda@3510000 {
 			nvidia,model = "NVIDIA Jetson Orin NX HDA";
-			status = "okay";
 		};
 
 		padctl@3520000 {
@@ -85,6 +84,10 @@ vdd_3v3_pcie: regulator-vdd-3v3-pcie {
 		enable-active-high;
 	};
 
+	sound {
+		label = "NVIDIA Jetson Orin NX APE";
+	};
+
 	thermal-zones {
 		tj-thermal {
 			cooling-maps {
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dts
index 9e9bb9ca8be4..ba949203eba0 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dts
@@ -11,10 +11,20 @@ / {
 	compatible = "nvidia,p3768-0000+p3767-0005", "nvidia,p3767-0005", "nvidia,tegra234";
 	model = "NVIDIA Jetson Orin Nano Developer Kit";
 
+	bus@0 {
+		hda@3510000 {
+			nvidia,model = "NVIDIA Jetson Orin Nano HDA";
+		};
+	};
+
 	pwm-fan {
 		cooling-levels = <0 88 187 255>;
 	};
 
+	sound {
+		label = "NVIDIA Jetson Orin Nano APE";
+	};
+
 	thermal-zones {
 		tj-thermal {
 			cooling-maps {
-- 
2.34.1


