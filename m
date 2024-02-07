Return-Path: <linux-kernel+bounces-56459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840EA84CA6B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA101F2C18F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9C45B1F3;
	Wed,  7 Feb 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A3SX75PX"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D55A7A6;
	Wed,  7 Feb 2024 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307565; cv=fail; b=bIrxU7b8tEUTDvLoYUsSZhRTjhk4ZNRYsA14wgNc2u33pb30L2WU58pNQWnKv0qMGjI6z7VEgZ0l2tqSjYtWp2MphPI7qPO/L6GabPeMTSagWW6YL+Iu5JLCMPYWfNcpMNXDOZW2Gt/ixR1VShe4eHW8+jks5Se0qdYh6V5EMfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307565; c=relaxed/simple;
	bh=GLaNXQKI5c6NgZTvm4h+u214lanwQnSaUd0kav5+bBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wq0VkoKT3j45ZEhCKqdrJJKufOPHW488Z9P8Ubw+1x2u5c6iEw5VgrgT01GM882BwitDD0fDLITWs2SLOWJptIYxM5K31hbG8J93dbx3JPZy5XcLj+zECdDZ1Ylo4xsJYKtL00IoBo6prS5ivc3JHijHik03GvSMAfywmAwzb/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A3SX75PX; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi6pAwV1QSR2POSQbGyaiUhg/W7ZaMKQFmxy9D6DyumH3KFpZBYJVTnKtZzvueRCAMDuZSd+RzTKJki2cfevHkugRAb0iiZmeNDPHG2txkSOSdZxLVft1CzSVPqOYhyL0V3NwK0Um/7PFdLr5+AryFqwyflxVZ9kmvxLl1bOtoqN79/XPjjry/JCguV6Ua1ldsPhxaIS+cR5R157qGJKDYOgeKuPkf7DrOjMEX8PNVuzViWQ4PkXt2VQqUnCdNbY/aShcgZCtnkWcUowGWj2tEzUveG5LpaGnba9MKbuo/3PlgLKcsqt5yjLdnA17vJt0ZqvAvyhgzEbTCqLTpce/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSFhjCZJWT8x7i10BY80YiQW7GTaNBKVSUz/5zLrNIE=;
 b=fK832brE+OTVu0J4IzcCesKvVh9fnWisRZozmVXlbpL7kyxKRpsuHHbPBcfEqXz9lNQ6Gs32qixnLvYPJc8YFjpn0AL3Dd1E87gXMv76ba039BitE3bsBQK/CNDH6+Eoukk/mh3M4FM5kY+5Yzj2NXmbgeShq/HootCe4OSWMDc/BUr8LL70kC6VFovYsuAUWGarxMVZc8xqA4Hxc5spexAmtUIzYLsRsYy/o3pjr7Fw1f9ndZxYmeMUpSSZXIN/r9WA9KNHX2Mjx7KXZ3WKLc3dCqvNUBB4l+XnTP+f3fpOokcBVwj/W1LiMwPB3kM8Q5B3ToqHn1+LwGgcm6UuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSFhjCZJWT8x7i10BY80YiQW7GTaNBKVSUz/5zLrNIE=;
 b=A3SX75PXSVuwQY5LCEFjXF1oTQ3YwD+X+W6WvSoIzC35cC988eyizYiczx3ZAuWOQ1cg5/srJ2z7n3fMw807WH++puwTwqZBDH2q+itGvlLSXczabKiLQ/V9lGUdMIc/pnbNvDiafW/d1mLNdKwfmvMiLRrlCCMiPUF0sfwhWBKFT6r0CNNNNhEdsukSKu8mYlqLOVFkqNBwiMs0/ObEYNiC++ao5Hk5zTV5fGFaV6zNtEIXXQR+kOoDz/COb+buESYrcOfHxTpYJp3x9Fcw2fWoodsHx8C+XA4NtFE0xLO6P10bcpi2jZiTdh5noFPl1OQfNyAuMC0FQ5FXMS9ARw==
Received: from CY5PR04CA0026.namprd04.prod.outlook.com (2603:10b6:930:1e::21)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 12:06:00 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::37) by CY5PR04CA0026.outlook.office365.com
 (2603:10b6:930:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 12:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 12:06:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 04:05:47 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 7 Feb
 2024 04:05:46 -0800
Received: from sheetal.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 7 Feb 2024 04:05:44 -0800
From: "Sheetal ." <sheetal@nvidia.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
	<spujar@nvidia.com>, <jonathanh@nvidia.com>, <mkumard@nvidia.com>, sheetal
	<sheetal@nvidia.com>
Subject: [PATCH 2/4] arm64: tegra: Define missing IO ports
Date: Wed, 7 Feb 2024 17:35:16 +0530
Message-ID: <20240207120518.697926-3-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CO6PR12MB5427:EE_
X-MS-Office365-Filtering-Correlation-Id: 727821d5-f4b9-4684-3881-08dc27d5264d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lPPoS5CBVhIQ9UTctb8rSL0ALZhQkIew5Y+ZJEBKrl0quQvSIIDDQDLglvAJLE7M6tg6kSdqKtuQ27/oF+2RzvCcch9MBmdgO+2LIg94XAzjpyFq8K7f+rGE4F7oP3ouCx8EYw3g9AbY48Gr12pct54L7KOkNEAij5r73Ik/K4IBo+x2joGoZmOXj3X4DVbG2XyQvHTSlq3CtCU0KLVirjrjhZCKzxRp9LcD2xmPekbjY69YmDGdexq0IXxEbD3BCndRtkD5OKn/z5mpgWTLxkje4VWsnCtbV5TvmFGaQkxABep9wnAD++YqDJbrp1YencCgjCJb9QqBT8aXL8koHduC8F2xMuLakOcRFon2tCTo4T1r4dE42ZfJu4bZEzrYm8lBfFvEPzvaPLh4CPk5KAoV25L1Od5nwWojePuESzIgo62560aNo+NCEh/941MmQJQ63K9t0BhRBjgA8Lxtm7dRT+dF53WdmBDwycobwp2efOyhy+dnTg91UZcHK1RCjjRDnjWAdYP1IjQ7QWiW1qLGudEl3yO15vmKc87vnwIvNkGPPbGJ5PtAKf1A1P+djvWEq/W8mQNMWGuMyo/srntnamm/HKhy9NzwHr8t4rPyMOgckCrmmWN0wMjpWfPSUGH0Apq8u60K3LIHeREtOpaLJeZQlwBPG6z5D4bn+40zIpgU1WFwmbjXOoOOtBGCuMQXlnPj8ndDK7ncC5x7ZdZEhW9xQR5YrLpLumq5nxk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(230273577357003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(46966006)(36840700001)(40470700004)(6666004)(86362001)(478600001)(36860700001)(47076005)(40480700001)(40460700003)(2616005)(336012)(426003)(1076003)(7696005)(82740400003)(83380400001)(107886003)(26005)(7636003)(356005)(41300700001)(8936002)(54906003)(8676002)(5660300002)(2906002)(4326008)(316002)(36756003)(70586007)(70206006)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 12:06:00.2474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727821d5-f4b9-4684-3881-08dc27d5264d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427

From: sheetal <sheetal@nvidia.com>

I2S3, I2S5, DMIC1, DMIC2, DMIC4, DSPK1 and DSPK2 IO ports are not
defined. Those are not defined earlier because it was inside platform
DT and defined only for supported IOs by the platform.
Now these are part of SoC DTSI, all IOs ports are defined
so that all the ports are available to be used by platforms.

Signed-off-by: sheetal <sheetal@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 205 +++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index a01ff6174f74..561d01dfef56 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -272,6 +272,28 @@ tegra_i2s3: i2s@2901200 {
 					assigned-clock-rates = <1536000>;
 					sound-name-prefix = "I2S3";
 					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s3_cif: endpoint {
+								remote-endpoint = <&xbar_i2s3>;
+							};
+						};
+
+						i2s3_port: port@1 {
+							reg = <1>;
+
+							i2s3_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
 				};
 
 				tegra_i2s4: i2s@2901300 {
@@ -322,6 +344,28 @@ tegra_i2s5: i2s@2901400 {
 					assigned-clock-rates = <1536000>;
 					sound-name-prefix = "I2S5";
 					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s5_cif: endpoint {
+								remote-endpoint = <&xbar_i2s5>;
+							};
+						};
+
+						i2s5_port: port@1 {
+							reg = <1>;
+
+							i2s5_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
 				};
 
 				tegra_i2s6: i2s@2901500 {
@@ -900,6 +944,27 @@ tegra_dmic1: dmic@2904000 {
 					assigned-clock-rates = <3072000>;
 					sound-name-prefix = "DMIC1";
 					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							dmic1_cif: endpoint {
+								remote-endpoint = <&xbar_dmic1>;
+							};
+						};
+
+						dmic1_port: port@1 {
+							reg = <1>;
+
+							dmic1_dap: endpoint {
+								/* placeholder for external codec */
+							};
+						};
+					};
 				};
 
 				tegra_dmic2: dmic@2904100 {
@@ -913,6 +978,27 @@ tegra_dmic2: dmic@2904100 {
 					assigned-clock-rates = <3072000>;
 					sound-name-prefix = "DMIC2";
 					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							dmic2_cif: endpoint {
+								remote-endpoint = <&xbar_dmic2>;
+							};
+						};
+
+						dmic2_port: port@1 {
+							reg = <1>;
+
+							dmic2_dap: endpoint {
+								/* placeholder for external codec */
+							};
+						};
+					};
 				};
 
 				tegra_dmic3: dmic@2904200 {
@@ -960,6 +1046,27 @@ tegra_dmic4: dmic@2904300 {
 					assigned-clock-rates = <3072000>;
 					sound-name-prefix = "DMIC4";
 					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							dmic4_cif: endpoint {
+								remote-endpoint = <&xbar_dmic4>;
+							};
+						};
+
+						dmic4_port: port@1 {
+							reg = <1>;
+
+							dmic4_dap: endpoint {
+								/* placeholder for external codec */
+							};
+						};
+					};
 				};
 
 				tegra_dspk1: dspk@2905000 {
@@ -973,6 +1080,27 @@ tegra_dspk1: dspk@2905000 {
 					assigned-clock-rates = <12288000>;
 					sound-name-prefix = "DSPK1";
 					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							dspk1_cif: endpoint {
+								remote-endpoint = <&xbar_dspk1>;
+							};
+						};
+
+						dspk1_port: port@1 {
+							reg = <1>;
+
+							dspk1_dap: endpoint {
+								/* placeholder for external codec */
+							};
+						};
+					};
 				};
 
 				tegra_dspk2: dspk@2905100 {
@@ -986,6 +1114,27 @@ tegra_dspk2: dspk@2905100 {
 					assigned-clock-rates = <12288000>;
 					sound-name-prefix = "DSPK2";
 					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							dspk2_cif: endpoint {
+								remote-endpoint = <&xbar_dspk2>;
+							};
+						};
+
+						dspk2_port: port@1 {
+							reg = <1>;
+
+							dspk2_dap: endpoint {
+								/* placeholder for external codec */
+							};
+						};
+					};
 				};
 
 				tegra_ope1: processing-engine@2908000 {
@@ -1746,6 +1895,14 @@ xbar_i2s2: endpoint {
 						};
 					};
 
+					xbar_i2s3_port: port@16 {
+						reg = <0x16>;
+
+						xbar_i2s3: endpoint {
+							remote-endpoint = <&i2s3_cif>;
+						};
+					};
+
 					xbar_i2s4_port: port@17 {
 						reg = <0x17>;
 
@@ -1754,6 +1911,14 @@ xbar_i2s4: endpoint {
 						};
 					};
 
+					xbar_i2s5_port: port@18 {
+						reg = <0x18>;
+
+						xbar_i2s5: endpoint {
+							remote-endpoint = <&i2s5_cif>;
+						};
+					};
+
 					xbar_i2s6_port: port@19 {
 						reg = <0x19>;
 
@@ -1762,6 +1927,22 @@ xbar_i2s6: endpoint {
 						};
 					};
 
+					xbar_dmic1_port: port@1a {
+						reg = <0x1a>;
+
+						xbar_dmic1: endpoint {
+							remote-endpoint = <&dmic1_cif>;
+						};
+					};
+
+					xbar_dmic2_port: port@1b {
+						reg = <0x1b>;
+
+						xbar_dmic2: endpoint {
+							remote-endpoint = <&dmic2_cif>;
+						};
+					};
+
 					xbar_dmic3_port: port@1c {
 						reg = <0x1c>;
 
@@ -1770,6 +1951,30 @@ xbar_dmic3: endpoint {
 						};
 					};
 
+					xbar_dmic4_port: port@1d {
+						reg = <0x1d>;
+
+						xbar_dmic4: endpoint {
+							remote-endpoint = <&dmic4_cif>;
+						};
+					};
+
+					xbar_dspk1_port: port@1e {
+						reg = <0x1e>;
+
+						xbar_dspk1: endpoint {
+							remote-endpoint = <&dspk1_cif>;
+						};
+					};
+
+					xbar_dspk2_port: port@1f {
+						reg = <0x1f>;
+
+						xbar_dspk2: endpoint {
+							remote-endpoint = <&dspk2_cif>;
+						};
+					};
+
 					xbar_sfc1_in_port: port@20 {
 						reg = <0x20>;
 
-- 
2.34.1


