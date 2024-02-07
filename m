Return-Path: <linux-kernel+bounces-56458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5BB84CA6C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B071C248D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598181B803;
	Wed,  7 Feb 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D5UwBhgL"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7F5A102;
	Wed,  7 Feb 2024 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307562; cv=fail; b=uo95cry4SJydAI7dXyCqbs+gyKtAOpXAe5ij6Q3wNvSZ8mKwO4vYypIF/d6mssI7gTL15K783UMR3CTZ2iTcHvTbaR+WJoq0N1l69IZkG/Q7PXMzCVvp4maAHYxdEbGSe9zZEHZDmINnooW433iD70XoEJJiTODQU5taHLpcNpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307562; c=relaxed/simple;
	bh=p9HFPMxS5KpznQ2EcGY4UClPyDwLsdjv2Ks9uEOuajQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sitKFNBpA5bHfV2XSSTQrawi9SvAnaYMHtKYAAU9TIszcXtN4FkbFBq8liFVaBa/zMDfAB77Ewjy6/xJHM2L+HD8l7H56MEfHAXo2GsAuN8x2fCMGnwpNR5Nc6sYR7cQE04jL3KMklZOzuH3wcCPULX34IZXbW7NFD+2+ROsgyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D5UwBhgL; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg9UxBE0Fz8ve/kLDQlIvZciXCLaTirW6dpjKlPcFvf/vM0vOFMTR1sTyp4lZ0VridAFehpITZp0mB6uwbiDJGprjO+PxbieyJ8ylPGmNZEgCQlywFXUaahnXMCK/JeLYCNdj4XHo0mQdLz62ENVyHl8wfMJm8cDb3QTtKUTQqkfuk/eSPLqtSYAmvOJ9frNDb/YZNTD8lFmUBj7bk8KvO6Qrd3Z1xs6lHFlfZc33NlU76mi5Y+0nDAGN/L2Srm4IEDjoW/XLfUkgsZyM/4KPO/qklZwIqczHkp7hH9OFEltGMz31yf8b3MkwOuiLgbNGbjtAliAo+Yoi4AswitcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7LRF1OwsWnK0157wh4xF+65lUp2VL7JxntIGlR42O4=;
 b=MbKOagGLvb1K9RePns3I+/buB29TGONKP4nY/v6UKb2DfPuYED5Zsqzt118QqjozgTCQo3q04t0CmWEOaNRPGM53iFCX/w75Z9BuWINkDmFc/kfmp350J/TmsQUQq1mX0TLx3MVFhnys+EGmSiPiD/VWUMDC1rZQuarXxZr602DLoDnfZEN1OgiNGemf5NKq2b2YRykcn2RZr/LvLXtoIaJdVo8ofDDl2cHjJZmD2qRKnGrBUPueg2btfx87OJsfkGM4gLB7Q71E3BYpgCJkDJrz3RYjAYKPJDsqs9C2puERULkVeo/DhGg9VFB4oi+sxx3VhEQb/+8P/FFtFh41cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7LRF1OwsWnK0157wh4xF+65lUp2VL7JxntIGlR42O4=;
 b=D5UwBhgLB2jUR/PKb+8JFn7un6DxS2QBxE17WRsrXQifQFjdZh1HIJLUgaMudb9jtC9BpJKg/v6t8O1Yq240Q5PCZVYOO77Sv38zkx+jiTiST6EROAff/6Q85VtUEhW6FB2WoRSNrdmsn053aGyDieTgBFbciGgIuRt25QRyaQzMKSUFTMPxv66fdXPsCFHLXzvYHeTa2tAZHaBDwPSA/ZHxkypFr1dXym6b4i9S1PPDhKQ8smqwCaQvDDDvPXcquUAzlcWJvb/h3HYH9fs0k1QpaRm6B14FvY/9rX7gP4uzQgjhAqSNwvXX2c/wx7Lt8DZMvTSS5GklrEy5ZLVGVg==
Received: from DS7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:8:54::23) by
 SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 12:05:54 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::71) by DS7PR06CA0042.outlook.office365.com
 (2603:10b6:8:54::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 12:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 12:05:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 04:05:43 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 7 Feb
 2024 04:05:42 -0800
Received: from sheetal.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 7 Feb 2024 04:05:39 -0800
From: "Sheetal ." <sheetal@nvidia.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
	<spujar@nvidia.com>, <jonathanh@nvidia.com>, <mkumard@nvidia.com>, sheetal
	<sheetal@nvidia.com>
Subject: [PATCH 1/4] arm64: tegra: Move AHUB ports to SoC DTSI
Date: Wed, 7 Feb 2024 17:35:15 +0530
Message-ID: <20240207120518.697926-2-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 1060ed9c-2d4d-4399-88f0-08dc27d5229c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aNbo+iNjvnzRuV/7I60bFsOwe/03QWJ40H9uDSrJinW1jfYFlfS7Z9llXWnDtf0eK71iaK0hE2J5CEXNcbl/ySoRvvvTjJdFtXZZrRpEMCI9iIVPeHHWxh7ASuAYV4XympYzo2rBkFatf3b1E2arBAqrS2J0xLMv9PtdtFl7srOAc0sgWjueIx85Bf6Eb6PxUwqg5hODPdmX/CTJrYkBwtY4HbZTYiuo5c0k5Ad6nKQ+P7KL85ILQ2gHyvKkp45VaRd5Z5wQQCxIjsS1iPP7wtzGAM7qPEK5Z4eB3bweCgKvUTHfgvlkq2K6ec37lW0KWaMnTVIAFukv+8uSaZqOda0KPhSVfbV2l7J2den+0kQcpfXt1DfkXcuINfood2d+E0o+msnXvn8sEAd9FELK+SDB8L4fGRpxWevvH63Q7FJ/OuAwusiFX0yPlJZvCu3t6IJhT6Rnk1QjgI/U+R/nrYpQax0ghqYuNZtyMM18R5Racr3WWvhaqAz0JQijiXBI1dQycfkhBR5eCfI3b7NtEI3dE4+rUm7x2Dv8aFW1nsiAxQP7GnPpvGHlgs1TwEHW6lAe6XLszZas5bjgW/Q9Gi0ttx/vDefTOlqk3FyVlgARlLeGHb4QrUCdkI+4KI5DU0xv267jGZPx7LklEJK4F4J3bbn8PL2oZ/b6MiotRWVMvZxlYZqur11CjI11fp9tnIJ5bKeW1q3nNs/FoW2UQcEh6cN/MWVVPCtCgSfNZJY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(230273577357003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(7696005)(26005)(41300700001)(7636003)(2616005)(70586007)(426003)(107886003)(1076003)(83380400001)(47076005)(2906002)(5660300002)(4326008)(8676002)(36860700001)(110136005)(54906003)(82740400003)(316002)(356005)(6666004)(8936002)(70206006)(336012)(478600001)(30864003)(86362001)(40460700003)(40480700001)(36756003)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 12:05:54.0562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1060ed9c-2d4d-4399-88f0-08dc27d5229c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

From: sheetal <sheetal@nvidia.com>

AHUB and its child nodes ports are part of platform DTS and with new
platform support these entries need to be defined again.
As they are common across the platforms, moving them to SoC
DTSI to avoid code duplicacy.

AHUB HW accelerators are used for audio processing and typically all of 
these are made available. Platforms can enable all of these just by 
enabling the AHUB parent device. However IO interfaces (which are also 
children of AHUB) are selectively enabled based on what the platform 
actually exposes for interaction with external world.

Signed-off-by: sheetal <sheetal@nvidia.com>
---
 .../arm64/boot/dts/nvidia/tegra234-p3701.dtsi | 1948 -----------------
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 1925 +++++++++++++++-
 2 files changed, 1899 insertions(+), 1974 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701.dtsi
index db6ef711674a..835288a44cdf 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3701.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701.dtsi
@@ -12,1970 +12,22 @@ ahub@2900800 {
 
 				i2s@2901000 {
 					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							i2s1_cif: endpoint {
-								remote-endpoint = <&xbar_i2s1>;
-							};
-						};
-
-						i2s1_port: port@1 {
-							reg = <1>;
-
-							i2s1_dap: endpoint {
-								dai-format = "i2s";
-								/* placeholder for external codec */
-							};
-						};
-					};
 				};
 
 				i2s@2901100 {
 					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							i2s2_cif: endpoint {
-								remote-endpoint = <&xbar_i2s2>;
-							};
-						};
-
-						i2s2_port: port@1 {
-							reg = <1>;
-
-							i2s2_dap: endpoint {
-								dai-format = "i2s";
-								/* placeholder for external codec */
-							};
-						};
-					};
 				};
 
 				i2s@2901300 {
 					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							i2s4_cif: endpoint {
-								remote-endpoint = <&xbar_i2s4>;
-							};
-						};
-
-						i2s4_port: port@1 {
-							reg = <1>;
-
-							i2s4_dap: endpoint {
-								dai-format = "i2s";
-								/* placeholder for external codec */
-							};
-						};
-					};
 				};
 
 				i2s@2901500 {
 					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							i2s6_cif: endpoint {
-								remote-endpoint = <&xbar_i2s6>;
-							};
-						};
-
-						i2s6_port: port@1 {
-							reg = <1>;
-
-							i2s6_dap: endpoint {
-								dai-format = "i2s";
-								/* placeholder for external codec */
-							};
-						};
-					};
-				};
-
-				sfc@2902000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							sfc1_cif_in: endpoint {
-								remote-endpoint = <&xbar_sfc1_in>;
-							};
-						};
-
-						sfc1_out_port: port@1 {
-							reg = <1>;
-
-							sfc1_cif_out: endpoint {
-								remote-endpoint = <&xbar_sfc1_out>;
-							};
-						};
-					};
-				};
-
-				sfc@2902200 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							sfc2_cif_in: endpoint {
-								remote-endpoint = <&xbar_sfc2_in>;
-							};
-						};
-
-						sfc2_out_port: port@1 {
-							reg = <1>;
-
-							sfc2_cif_out: endpoint {
-								remote-endpoint = <&xbar_sfc2_out>;
-							};
-						};
-					};
-				};
-
-				sfc@2902400 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							sfc3_cif_in: endpoint {
-								remote-endpoint = <&xbar_sfc3_in>;
-							};
-						};
-
-						sfc3_out_port: port@1 {
-							reg = <1>;
-
-							sfc3_cif_out: endpoint {
-								remote-endpoint = <&xbar_sfc3_out>;
-							};
-						};
-					};
-				};
-
-				sfc@2902600 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							sfc4_cif_in: endpoint {
-								remote-endpoint = <&xbar_sfc4_in>;
-							};
-						};
-
-						sfc4_out_port: port@1 {
-							reg = <1>;
-
-							sfc4_cif_out: endpoint {
-								remote-endpoint = <&xbar_sfc4_out>;
-							};
-						};
-					};
-				};
-
-				amx@2903000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							amx1_in1: endpoint {
-								remote-endpoint = <&xbar_amx1_in1>;
-							};
-						};
-
-						port@1 {
-							reg = <1>;
-
-							amx1_in2: endpoint {
-								remote-endpoint = <&xbar_amx1_in2>;
-							};
-						};
-
-						port@2 {
-							reg = <2>;
-
-							amx1_in3: endpoint {
-								remote-endpoint = <&xbar_amx1_in3>;
-							};
-						};
-
-						port@3 {
-							reg = <3>;
-
-							amx1_in4: endpoint {
-								remote-endpoint = <&xbar_amx1_in4>;
-							};
-						};
-
-						amx1_out_port: port@4 {
-							reg = <4>;
-
-							amx1_out: endpoint {
-								remote-endpoint = <&xbar_amx1_out>;
-							};
-						};
-					};
-				};
-
-				amx@2903100 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							amx2_in1: endpoint {
-								remote-endpoint = <&xbar_amx2_in1>;
-							};
-						};
-
-						port@1 {
-							reg = <1>;
-
-							amx2_in2: endpoint {
-								remote-endpoint = <&xbar_amx2_in2>;
-							};
-						};
-
-						port@2 {
-							reg = <2>;
-
-							amx2_in3: endpoint {
-								remote-endpoint = <&xbar_amx2_in3>;
-							};
-						};
-
-						port@3 {
-							reg = <3>;
-
-							amx2_in4: endpoint {
-								remote-endpoint = <&xbar_amx2_in4>;
-							};
-						};
-
-						amx2_out_port: port@4 {
-							reg = <4>;
-
-							amx2_out: endpoint {
-								remote-endpoint = <&xbar_amx2_out>;
-							};
-						};
-					};
-				};
-
-				amx@2903200 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							amx3_in1: endpoint {
-								remote-endpoint = <&xbar_amx3_in1>;
-							};
-						};
-
-						port@1 {
-							reg = <1>;
-
-							amx3_in2: endpoint {
-								remote-endpoint = <&xbar_amx3_in2>;
-							};
-						};
-
-						port@2 {
-							reg = <2>;
-
-							amx3_in3: endpoint {
-								remote-endpoint = <&xbar_amx3_in3>;
-							};
-						};
-
-						port@3 {
-							reg = <3>;
-
-							amx3_in4: endpoint {
-								remote-endpoint = <&xbar_amx3_in4>;
-							};
-						};
-
-						amx3_out_port: port@4 {
-							reg = <4>;
-
-							amx3_out: endpoint {
-								remote-endpoint = <&xbar_amx3_out>;
-							};
-						};
-					};
-				};
-
-				amx@2903300 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							amx4_in1: endpoint {
-								remote-endpoint = <&xbar_amx4_in1>;
-							};
-						};
-
-						port@1 {
-							reg = <1>;
-
-							amx4_in2: endpoint {
-								remote-endpoint = <&xbar_amx4_in2>;
-							};
-						};
-
-						port@2 {
-							reg = <2>;
-
-							amx4_in3: endpoint {
-								remote-endpoint = <&xbar_amx4_in3>;
-							};
-						};
-
-						port@3 {
-							reg = <3>;
-
-							amx4_in4: endpoint {
-								remote-endpoint = <&xbar_amx4_in4>;
-							};
-						};
-
-						amx4_out_port: port@4 {
-							reg = <4>;
-
-							amx4_out: endpoint {
-								remote-endpoint = <&xbar_amx4_out>;
-							};
-						};
-					};
-				};
-
-				adx@2903800 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							adx1_in: endpoint {
-								remote-endpoint = <&xbar_adx1_in>;
-							};
-						};
-
-						adx1_out1_port: port@1 {
-							reg = <1>;
-
-							adx1_out1: endpoint {
-								remote-endpoint = <&xbar_adx1_out1>;
-							};
-						};
-
-						adx1_out2_port: port@2 {
-							reg = <2>;
-
-							adx1_out2: endpoint {
-								remote-endpoint = <&xbar_adx1_out2>;
-							};
-						};
-
-						adx1_out3_port: port@3 {
-							reg = <3>;
-
-							adx1_out3: endpoint {
-								remote-endpoint = <&xbar_adx1_out3>;
-							};
-						};
-
-						adx1_out4_port: port@4 {
-							reg = <4>;
-
-							adx1_out4: endpoint {
-								remote-endpoint = <&xbar_adx1_out4>;
-							};
-						};
-					};
-				};
-
-				adx@2903900 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							adx2_in: endpoint {
-								remote-endpoint = <&xbar_adx2_in>;
-							};
-						};
-
-						adx2_out1_port: port@1 {
-							reg = <1>;
-
-							adx2_out1: endpoint {
-								remote-endpoint = <&xbar_adx2_out1>;
-							};
-						};
-
-						adx2_out2_port: port@2 {
-							reg = <2>;
-
-							adx2_out2: endpoint {
-								remote-endpoint = <&xbar_adx2_out2>;
-							};
-						};
-
-						adx2_out3_port: port@3 {
-							reg = <3>;
-
-							adx2_out3: endpoint {
-								remote-endpoint = <&xbar_adx2_out3>;
-							};
-						};
-
-						adx2_out4_port: port@4 {
-							reg = <4>;
-
-							adx2_out4: endpoint {
-								remote-endpoint = <&xbar_adx2_out4>;
-							};
-						};
-					};
-				};
-
-				adx@2903a00 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							adx3_in: endpoint {
-								remote-endpoint = <&xbar_adx3_in>;
-							};
-						};
-
-						adx3_out1_port: port@1 {
-							reg = <1>;
-
-							adx3_out1: endpoint {
-								remote-endpoint = <&xbar_adx3_out1>;
-							};
-						};
-
-						adx3_out2_port: port@2 {
-							reg = <2>;
-
-							adx3_out2: endpoint {
-								remote-endpoint = <&xbar_adx3_out2>;
-							};
-						};
-
-						adx3_out3_port: port@3 {
-							reg = <3>;
-
-							adx3_out3: endpoint {
-								remote-endpoint = <&xbar_adx3_out3>;
-							};
-						};
-
-						adx3_out4_port: port@4 {
-							reg = <4>;
-
-							adx3_out4: endpoint {
-								remote-endpoint = <&xbar_adx3_out4>;
-							};
-						};
-					};
-				};
-
-				adx@2903b00 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							adx4_in: endpoint {
-								remote-endpoint = <&xbar_adx4_in>;
-							};
-						};
-
-						adx4_out1_port: port@1 {
-							reg = <1>;
-
-							adx4_out1: endpoint {
-								remote-endpoint = <&xbar_adx4_out1>;
-							};
-						};
-
-						adx4_out2_port: port@2 {
-							reg = <2>;
-
-							adx4_out2: endpoint {
-								remote-endpoint = <&xbar_adx4_out2>;
-							};
-						};
-
-						adx4_out3_port: port@3 {
-							reg = <3>;
-
-							adx4_out3: endpoint {
-								remote-endpoint = <&xbar_adx4_out3>;
-							};
-						};
-
-						adx4_out4_port: port@4 {
-							reg = <4>;
-
-							adx4_out4: endpoint {
-								remote-endpoint = <&xbar_adx4_out4>;
-							};
-						};
-					};
 				};
 
 				dmic@2904200 {
 					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							dmic3_cif: endpoint {
-								remote-endpoint = <&xbar_dmic3>;
-							};
-						};
-
-						dmic3_port: port@1 {
-							reg = <1>;
-
-							dmic3_dap: endpoint {
-								/* placeholder for external codec */
-							};
-						};
-					};
-				};
-
-				processing-engine@2908000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0x0>;
-
-							ope1_cif_in_ep: endpoint {
-								remote-endpoint = <&xbar_ope1_in_ep>;
-							};
-						};
-
-						ope1_out_port: port@1 {
-							reg = <0x1>;
-
-							ope1_cif_out_ep: endpoint {
-								remote-endpoint = <&xbar_ope1_out_ep>;
-							};
-						};
-					};
-				};
-
-				mvc@290a000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							mvc1_cif_in: endpoint {
-								remote-endpoint = <&xbar_mvc1_in>;
-							};
-						};
-
-						mvc1_out_port: port@1 {
-							reg = <1>;
-
-							mvc1_cif_out: endpoint {
-								remote-endpoint = <&xbar_mvc1_out>;
-							};
-						};
-					};
-				};
-
-				mvc@290a200 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							mvc2_cif_in: endpoint {
-								remote-endpoint = <&xbar_mvc2_in>;
-							};
-						};
-
-						mvc2_out_port: port@1 {
-							reg = <1>;
-
-							mvc2_cif_out: endpoint {
-								remote-endpoint = <&xbar_mvc2_out>;
-							};
-						};
-					};
-				};
-
-				amixer@290bb00 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0x0>;
-
-							mix_in1: endpoint {
-								remote-endpoint = <&xbar_mix_in1>;
-							};
-						};
-
-						port@1 {
-							reg = <0x1>;
-
-							mix_in2: endpoint {
-								remote-endpoint = <&xbar_mix_in2>;
-							};
-						};
-
-						port@2 {
-							reg = <0x2>;
-
-							mix_in3: endpoint {
-								remote-endpoint = <&xbar_mix_in3>;
-							};
-						};
-
-						port@3 {
-							reg = <0x3>;
-
-							mix_in4: endpoint {
-								remote-endpoint = <&xbar_mix_in4>;
-							};
-						};
-
-						port@4 {
-							reg = <0x4>;
-
-							mix_in5: endpoint {
-								remote-endpoint = <&xbar_mix_in5>;
-							};
-						};
-
-						port@5 {
-							reg = <0x5>;
-
-							mix_in6: endpoint {
-								remote-endpoint = <&xbar_mix_in6>;
-							};
-						};
-
-						port@6 {
-							reg = <0x6>;
-
-							mix_in7: endpoint {
-								remote-endpoint = <&xbar_mix_in7>;
-							};
-						};
-
-						port@7 {
-							reg = <0x7>;
-
-							mix_in8: endpoint {
-								remote-endpoint = <&xbar_mix_in8>;
-							};
-						};
-
-						port@8 {
-							reg = <0x8>;
-
-							mix_in9: endpoint {
-								remote-endpoint = <&xbar_mix_in9>;
-							};
-						};
-
-						port@9 {
-							reg = <0x9>;
-
-							mix_in10: endpoint {
-								remote-endpoint = <&xbar_mix_in10>;
-							};
-						};
-
-						mix_out1_port: port@a {
-							reg = <0xa>;
-
-							mix_out1: endpoint {
-								remote-endpoint = <&xbar_mix_out1>;
-							};
-						};
-
-						mix_out2_port: port@b {
-							reg = <0xb>;
-
-							mix_out2: endpoint {
-								remote-endpoint = <&xbar_mix_out2>;
-							};
-						};
-
-						mix_out3_port: port@c {
-							reg = <0xc>;
-
-							mix_out3: endpoint {
-								remote-endpoint = <&xbar_mix_out3>;
-							};
-						};
-
-						mix_out4_port: port@d {
-							reg = <0xd>;
-
-							mix_out4: endpoint {
-								remote-endpoint = <&xbar_mix_out4>;
-							};
-						};
-
-						mix_out5_port: port@e {
-							reg = <0xe>;
-
-							mix_out5: endpoint {
-								remote-endpoint = <&xbar_mix_out5>;
-							};
-						};
-					};
-				};
-
-				admaif@290f000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						admaif0_port: port@0 {
-							reg = <0x0>;
-
-							admaif0: endpoint {
-								remote-endpoint = <&xbar_admaif0>;
-							};
-						};
-
-						admaif1_port: port@1 {
-							reg = <0x1>;
-
-							admaif1: endpoint {
-								remote-endpoint = <&xbar_admaif1>;
-							};
-						};
-
-						admaif2_port: port@2 {
-							reg = <0x2>;
-
-							admaif2: endpoint {
-								remote-endpoint = <&xbar_admaif2>;
-							};
-						};
-
-						admaif3_port: port@3 {
-							reg = <0x3>;
-
-							admaif3: endpoint {
-								remote-endpoint = <&xbar_admaif3>;
-							};
-						};
-
-						admaif4_port: port@4 {
-							reg = <0x4>;
-
-							admaif4: endpoint {
-								remote-endpoint = <&xbar_admaif4>;
-							};
-						};
-
-						admaif5_port: port@5 {
-							reg = <0x5>;
-
-							admaif5: endpoint {
-								remote-endpoint = <&xbar_admaif5>;
-							};
-						};
-
-						admaif6_port: port@6 {
-							reg = <0x6>;
-
-							admaif6: endpoint {
-								remote-endpoint = <&xbar_admaif6>;
-							};
-						};
-
-						admaif7_port: port@7 {
-							reg = <0x7>;
-
-							admaif7: endpoint {
-								remote-endpoint = <&xbar_admaif7>;
-							};
-						};
-
-						admaif8_port: port@8 {
-							reg = <0x8>;
-
-							admaif8: endpoint {
-								remote-endpoint = <&xbar_admaif8>;
-							};
-						};
-
-						admaif9_port: port@9 {
-							reg = <0x9>;
-
-							admaif9: endpoint {
-								remote-endpoint = <&xbar_admaif9>;
-							};
-						};
-
-						admaif10_port: port@a {
-							reg = <0xa>;
-
-							admaif10: endpoint {
-								remote-endpoint = <&xbar_admaif10>;
-							};
-						};
-
-						admaif11_port: port@b {
-							reg = <0xb>;
-
-							admaif11: endpoint {
-								remote-endpoint = <&xbar_admaif11>;
-							};
-						};
-
-						admaif12_port: port@c {
-							reg = <0xc>;
-
-							admaif12: endpoint {
-								remote-endpoint = <&xbar_admaif12>;
-							};
-						};
-
-						admaif13_port: port@d {
-							reg = <0xd>;
-
-							admaif13: endpoint {
-								remote-endpoint = <&xbar_admaif13>;
-							};
-						};
-
-						admaif14_port: port@e {
-							reg = <0xe>;
-
-							admaif14: endpoint {
-								remote-endpoint = <&xbar_admaif14>;
-							};
-						};
-
-						admaif15_port: port@f {
-							reg = <0xf>;
-
-							admaif15: endpoint {
-								remote-endpoint = <&xbar_admaif15>;
-							};
-						};
-
-						admaif16_port: port@10 {
-							reg = <0x10>;
-
-							admaif16: endpoint {
-								remote-endpoint = <&xbar_admaif16>;
-							};
-						};
-
-						admaif17_port: port@11 {
-							reg = <0x11>;
-
-							admaif17: endpoint {
-								remote-endpoint = <&xbar_admaif17>;
-							};
-						};
-
-						admaif18_port: port@12 {
-							reg = <0x12>;
-
-							admaif18: endpoint {
-								remote-endpoint = <&xbar_admaif18>;
-							};
-						};
-
-						admaif19_port: port@13 {
-							reg = <0x13>;
-
-							admaif19: endpoint {
-								remote-endpoint = <&xbar_admaif19>;
-							};
-						};
-					};
-				};
-
-				asrc@2910000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0x0>;
-
-							asrc_in1_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in1_ep>;
-							};
-						};
-
-						port@1 {
-							reg = <0x1>;
-
-							asrc_in2_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in2_ep>;
-							};
-						};
-
-						port@2 {
-							reg = <0x2>;
-
-							asrc_in3_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in3_ep>;
-							};
-						};
-
-						port@3 {
-							reg = <0x3>;
-
-							asrc_in4_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in4_ep>;
-							};
-						};
-
-						port@4 {
-							reg = <0x4>;
-
-							asrc_in5_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in5_ep>;
-							};
-						};
-
-						port@5 {
-							reg = <0x5>;
-
-							asrc_in6_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in6_ep>;
-							};
-						};
-
-						port@6 {
-							reg = <0x6>;
-
-							asrc_in7_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in7_ep>;
-							};
-						};
-
-						asrc_out1_port: port@7 {
-							reg = <0x7>;
-
-							asrc_out1_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_out1_ep>;
-							};
-						};
-
-						asrc_out2_port: port@8 {
-							reg = <0x8>;
-
-							asrc_out2_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_out2_ep>;
-							};
-						};
-
-						asrc_out3_port: port@9 {
-							reg = <0x9>;
-
-							asrc_out3_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_out3_ep>;
-							};
-						};
-
-						asrc_out4_port: port@a {
-							reg = <0xa>;
-
-							asrc_out4_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_out4_ep>;
-							};
-						};
-
-						asrc_out5_port: port@b {
-							reg = <0xb>;
-
-							asrc_out5_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_out5_ep>;
-							};
-						};
-
-						asrc_out6_port:	port@c {
-							reg = <0xc>;
-
-							asrc_out6_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_out6_ep>;
-							};
-						};
-					};
-				};
-
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0x0>;
-
-						xbar_admaif0: endpoint {
-							remote-endpoint = <&admaif0>;
-						};
-					};
-
-					port@1 {
-						reg = <0x1>;
-
-						xbar_admaif1: endpoint {
-							remote-endpoint = <&admaif1>;
-						};
-					};
-
-					port@2 {
-						reg = <0x2>;
-
-						xbar_admaif2: endpoint {
-							remote-endpoint = <&admaif2>;
-						};
-					};
-
-					port@3 {
-						reg = <0x3>;
-
-						xbar_admaif3: endpoint {
-							remote-endpoint = <&admaif3>;
-						};
-					};
-
-					port@4 {
-						reg = <0x4>;
-
-						xbar_admaif4: endpoint {
-							remote-endpoint = <&admaif4>;
-						};
-					};
-
-					port@5 {
-						reg = <0x5>;
-
-						xbar_admaif5: endpoint {
-							remote-endpoint = <&admaif5>;
-						};
-					};
-
-					port@6 {
-						reg = <0x6>;
-
-						xbar_admaif6: endpoint {
-							remote-endpoint = <&admaif6>;
-						};
-					};
-
-					port@7 {
-						reg = <0x7>;
-
-						xbar_admaif7: endpoint {
-							remote-endpoint = <&admaif7>;
-						};
-					};
-
-					port@8 {
-						reg = <0x8>;
-
-						xbar_admaif8: endpoint {
-							remote-endpoint = <&admaif8>;
-						};
-					};
-
-					port@9 {
-						reg = <0x9>;
-
-						xbar_admaif9: endpoint {
-							remote-endpoint = <&admaif9>;
-						};
-					};
-
-					port@a {
-						reg = <0xa>;
-
-						xbar_admaif10: endpoint {
-							remote-endpoint = <&admaif10>;
-						};
-					};
-
-					port@b {
-						reg = <0xb>;
-
-						xbar_admaif11: endpoint {
-							remote-endpoint = <&admaif11>;
-						};
-					};
-
-					port@c {
-						reg = <0xc>;
-
-						xbar_admaif12: endpoint {
-							remote-endpoint = <&admaif12>;
-						};
-					};
-
-					port@d {
-						reg = <0xd>;
-
-						xbar_admaif13: endpoint {
-							remote-endpoint = <&admaif13>;
-						};
-					};
-
-					port@e {
-						reg = <0xe>;
-
-						xbar_admaif14: endpoint {
-							remote-endpoint = <&admaif14>;
-						};
-					};
-
-					port@f {
-						reg = <0xf>;
-
-						xbar_admaif15: endpoint {
-							remote-endpoint = <&admaif15>;
-						};
-					};
-
-					port@10 {
-						reg = <0x10>;
-
-						xbar_admaif16: endpoint {
-							remote-endpoint = <&admaif16>;
-						};
-					};
-
-					port@11 {
-						reg = <0x11>;
-
-						xbar_admaif17: endpoint {
-							remote-endpoint = <&admaif17>;
-						};
-					};
-
-					port@12 {
-						reg = <0x12>;
-
-						xbar_admaif18: endpoint {
-							remote-endpoint = <&admaif18>;
-						};
-					};
-
-					port@13 {
-						reg = <0x13>;
-
-						xbar_admaif19: endpoint {
-							remote-endpoint = <&admaif19>;
-						};
-					};
-
-					xbar_i2s1_port: port@14 {
-						reg = <0x14>;
-
-						xbar_i2s1: endpoint {
-							remote-endpoint = <&i2s1_cif>;
-						};
-					};
-
-					xbar_i2s2_port: port@15 {
-						reg = <0x15>;
-
-						xbar_i2s2: endpoint {
-							remote-endpoint = <&i2s2_cif>;
-						};
-					};
-
-					xbar_i2s4_port: port@17 {
-						reg = <0x17>;
-
-						xbar_i2s4: endpoint {
-							remote-endpoint = <&i2s4_cif>;
-						};
-					};
-
-					xbar_i2s6_port: port@19 {
-						reg = <0x19>;
-
-						xbar_i2s6: endpoint {
-							remote-endpoint = <&i2s6_cif>;
-						};
-					};
-
-					xbar_dmic3_port: port@1c {
-						reg = <0x1c>;
-
-						xbar_dmic3: endpoint {
-							remote-endpoint = <&dmic3_cif>;
-						};
-					};
-
-					xbar_sfc1_in_port: port@20 {
-						reg = <0x20>;
-
-						xbar_sfc1_in: endpoint {
-							remote-endpoint = <&sfc1_cif_in>;
-						};
-					};
-
-					port@21 {
-						reg = <0x21>;
-
-						xbar_sfc1_out: endpoint {
-							remote-endpoint = <&sfc1_cif_out>;
-						};
-					};
-
-					xbar_sfc2_in_port: port@22 {
-						reg = <0x22>;
-
-						xbar_sfc2_in: endpoint {
-							remote-endpoint = <&sfc2_cif_in>;
-						};
-					};
-
-					port@23 {
-						reg = <0x23>;
-
-						xbar_sfc2_out: endpoint {
-							remote-endpoint = <&sfc2_cif_out>;
-						};
-					};
-
-					xbar_sfc3_in_port: port@24 {
-						reg = <0x24>;
-
-						xbar_sfc3_in: endpoint {
-							remote-endpoint = <&sfc3_cif_in>;
-						};
-					};
-
-					port@25 {
-						reg = <0x25>;
-
-						xbar_sfc3_out: endpoint {
-							remote-endpoint = <&sfc3_cif_out>;
-						};
-					};
-
-					xbar_sfc4_in_port: port@26 {
-						reg = <0x26>;
-
-						xbar_sfc4_in: endpoint {
-							remote-endpoint = <&sfc4_cif_in>;
-						};
-					};
-
-					port@27 {
-						reg = <0x27>;
-
-						xbar_sfc4_out: endpoint {
-							remote-endpoint = <&sfc4_cif_out>;
-						};
-					};
-
-					xbar_mvc1_in_port: port@28 {
-						reg = <0x28>;
-
-						xbar_mvc1_in: endpoint {
-							remote-endpoint = <&mvc1_cif_in>;
-						};
-					};
-
-					port@29 {
-						reg = <0x29>;
-
-						xbar_mvc1_out: endpoint {
-							remote-endpoint = <&mvc1_cif_out>;
-						};
-					};
-
-					xbar_mvc2_in_port: port@2a {
-						reg = <0x2a>;
-
-						xbar_mvc2_in: endpoint {
-							remote-endpoint = <&mvc2_cif_in>;
-						};
-					};
-
-					port@2b {
-						reg = <0x2b>;
-
-						xbar_mvc2_out: endpoint {
-							remote-endpoint = <&mvc2_cif_out>;
-						};
-					};
-
-					xbar_amx1_in1_port: port@2c {
-						reg = <0x2c>;
-
-						xbar_amx1_in1: endpoint {
-							remote-endpoint = <&amx1_in1>;
-						};
-					};
-
-					xbar_amx1_in2_port: port@2d {
-						reg = <0x2d>;
-
-						xbar_amx1_in2: endpoint {
-							remote-endpoint = <&amx1_in2>;
-						};
-					};
-
-					xbar_amx1_in3_port: port@2e {
-						reg = <0x2e>;
-
-						xbar_amx1_in3: endpoint {
-							remote-endpoint = <&amx1_in3>;
-						};
-					};
-
-					xbar_amx1_in4_port: port@2f {
-						reg = <0x2f>;
-
-						xbar_amx1_in4: endpoint {
-							remote-endpoint = <&amx1_in4>;
-						};
-					};
-
-					port@30 {
-						reg = <0x30>;
-
-						xbar_amx1_out: endpoint {
-							remote-endpoint = <&amx1_out>;
-						};
-					};
-
-					xbar_amx2_in1_port: port@31 {
-						reg = <0x31>;
-
-						xbar_amx2_in1: endpoint {
-							remote-endpoint = <&amx2_in1>;
-						};
-					};
-
-					xbar_amx2_in2_port: port@32 {
-						reg = <0x32>;
-
-						xbar_amx2_in2: endpoint {
-							remote-endpoint = <&amx2_in2>;
-						};
-					};
-
-					xbar_amx2_in3_port: port@33 {
-						reg = <0x33>;
-
-						xbar_amx2_in3: endpoint {
-							remote-endpoint = <&amx2_in3>;
-						};
-					};
-
-					xbar_amx2_in4_port: port@34 {
-						reg = <0x34>;
-
-						xbar_amx2_in4: endpoint {
-							remote-endpoint = <&amx2_in4>;
-						};
-					};
-
-					port@35 {
-						reg = <0x35>;
-
-						xbar_amx2_out: endpoint {
-							remote-endpoint = <&amx2_out>;
-						};
-					};
-
-					xbar_amx3_in1_port: port@36 {
-						reg = <0x36>;
-
-						xbar_amx3_in1: endpoint {
-							remote-endpoint = <&amx3_in1>;
-						};
-					};
-
-					xbar_amx3_in2_port: port@37 {
-						reg = <0x37>;
-
-						xbar_amx3_in2: endpoint {
-							remote-endpoint = <&amx3_in2>;
-						};
-					};
-
-					xbar_amx3_in3_port: port@38 {
-						reg = <0x38>;
-
-						xbar_amx3_in3: endpoint {
-							remote-endpoint = <&amx3_in3>;
-						};
-					};
-
-					xbar_amx3_in4_port: port@39 {
-						reg = <0x39>;
-
-						xbar_amx3_in4: endpoint {
-							remote-endpoint = <&amx3_in4>;
-						};
-					};
-
-					port@3a {
-						reg = <0x3a>;
-
-						xbar_amx3_out: endpoint {
-							remote-endpoint = <&amx3_out>;
-						};
-					};
-
-					xbar_amx4_in1_port: port@3b {
-						reg = <0x3b>;
-
-						xbar_amx4_in1: endpoint {
-							remote-endpoint = <&amx4_in1>;
-						};
-					};
-
-					xbar_amx4_in2_port: port@3c {
-						reg = <0x3c>;
-
-						xbar_amx4_in2: endpoint {
-							remote-endpoint = <&amx4_in2>;
-						};
-					};
-
-					xbar_amx4_in3_port: port@3d {
-						reg = <0x3d>;
-
-						xbar_amx4_in3: endpoint {
-							remote-endpoint = <&amx4_in3>;
-						};
-					};
-
-					xbar_amx4_in4_port: port@3e {
-						reg = <0x3e>;
-
-						xbar_amx4_in4: endpoint {
-							remote-endpoint = <&amx4_in4>;
-						};
-					};
-
-					port@3f {
-						reg = <0x3f>;
-
-						xbar_amx4_out: endpoint {
-							remote-endpoint = <&amx4_out>;
-						};
-					};
-
-					xbar_adx1_in_port: port@40 {
-						reg = <0x40>;
-
-						xbar_adx1_in: endpoint {
-							remote-endpoint = <&adx1_in>;
-						};
-					};
-
-					port@41 {
-						reg = <0x41>;
-
-						xbar_adx1_out1: endpoint {
-							remote-endpoint = <&adx1_out1>;
-						};
-					};
-
-					port@42 {
-						reg = <0x42>;
-
-						xbar_adx1_out2: endpoint {
-							remote-endpoint = <&adx1_out2>;
-						};
-					};
-
-					port@43 {
-						reg = <0x43>;
-
-						xbar_adx1_out3: endpoint {
-							remote-endpoint = <&adx1_out3>;
-						};
-					};
-
-					port@44 {
-						reg = <0x44>;
-
-						xbar_adx1_out4: endpoint {
-							remote-endpoint = <&adx1_out4>;
-						};
-					};
-
-					xbar_adx2_in_port: port@45 {
-						reg = <0x45>;
-
-						xbar_adx2_in: endpoint {
-							remote-endpoint = <&adx2_in>;
-						};
-					};
-
-					port@46 {
-						reg = <0x46>;
-
-						xbar_adx2_out1: endpoint {
-							remote-endpoint = <&adx2_out1>;
-						};
-					};
-
-					port@47 {
-						reg = <0x47>;
-
-						xbar_adx2_out2: endpoint {
-							remote-endpoint = <&adx2_out2>;
-						};
-					};
-
-					port@48 {
-						reg = <0x48>;
-
-						xbar_adx2_out3: endpoint {
-							remote-endpoint = <&adx2_out3>;
-						};
-					};
-
-					port@49 {
-						reg = <0x49>;
-
-						xbar_adx2_out4: endpoint {
-							remote-endpoint = <&adx2_out4>;
-						};
-					};
-
-					xbar_adx3_in_port: port@4a {
-						reg = <0x4a>;
-
-						xbar_adx3_in: endpoint {
-							remote-endpoint = <&adx3_in>;
-						};
-					};
-
-					port@4b {
-						reg = <0x4b>;
-
-						xbar_adx3_out1: endpoint {
-							remote-endpoint = <&adx3_out1>;
-						};
-					};
-
-					port@4c {
-						reg = <0x4c>;
-
-						xbar_adx3_out2: endpoint {
-							remote-endpoint = <&adx3_out2>;
-						};
-					};
-
-					port@4d {
-						reg = <0x4d>;
-
-						xbar_adx3_out3: endpoint {
-							remote-endpoint = <&adx3_out3>;
-						};
-					};
-
-					port@4e {
-						reg = <0x4e>;
-
-						xbar_adx3_out4: endpoint {
-							remote-endpoint = <&adx3_out4>;
-						};
-					};
-
-					xbar_adx4_in_port: port@4f {
-						reg = <0x4f>;
-
-						xbar_adx4_in: endpoint {
-							remote-endpoint = <&adx4_in>;
-						};
-					};
-
-					port@50 {
-						reg = <0x50>;
-
-						xbar_adx4_out1: endpoint {
-							remote-endpoint = <&adx4_out1>;
-						};
-					};
-
-					port@51 {
-						reg = <0x51>;
-
-						xbar_adx4_out2: endpoint {
-							remote-endpoint = <&adx4_out2>;
-						};
-					};
-
-					port@52 {
-						reg = <0x52>;
-
-						xbar_adx4_out3: endpoint {
-							remote-endpoint = <&adx4_out3>;
-						};
-					};
-
-					port@53 {
-						reg = <0x53>;
-
-						xbar_adx4_out4: endpoint {
-							remote-endpoint = <&adx4_out4>;
-						};
-					};
-
-					xbar_mix_in1_port: port@54 {
-						reg = <0x54>;
-
-						xbar_mix_in1: endpoint {
-							remote-endpoint = <&mix_in1>;
-						};
-					};
-
-					xbar_mix_in2_port: port@55 {
-						reg = <0x55>;
-
-						xbar_mix_in2: endpoint {
-							remote-endpoint = <&mix_in2>;
-						};
-					};
-
-					xbar_mix_in3_port: port@56 {
-						reg = <0x56>;
-
-						xbar_mix_in3: endpoint {
-							remote-endpoint = <&mix_in3>;
-						};
-					};
-
-					xbar_mix_in4_port: port@57 {
-						reg = <0x57>;
-
-						xbar_mix_in4: endpoint {
-							remote-endpoint = <&mix_in4>;
-						};
-					};
-
-					xbar_mix_in5_port: port@58 {
-						reg = <0x58>;
-
-						xbar_mix_in5: endpoint {
-							remote-endpoint = <&mix_in5>;
-						};
-					};
-
-					xbar_mix_in6_port: port@59 {
-						reg = <0x59>;
-
-						xbar_mix_in6: endpoint {
-							remote-endpoint = <&mix_in6>;
-						};
-					};
-
-					xbar_mix_in7_port: port@5a {
-						reg = <0x5a>;
-
-						xbar_mix_in7: endpoint {
-							remote-endpoint = <&mix_in7>;
-						};
-					};
-
-					xbar_mix_in8_port: port@5b {
-						reg = <0x5b>;
-
-						xbar_mix_in8: endpoint {
-							remote-endpoint = <&mix_in8>;
-						};
-					};
-
-					xbar_mix_in9_port: port@5c {
-						reg = <0x5c>;
-
-						xbar_mix_in9: endpoint {
-							remote-endpoint = <&mix_in9>;
-						};
-					};
-
-					xbar_mix_in10_port: port@5d {
-						reg = <0x5d>;
-
-						xbar_mix_in10: endpoint {
-							remote-endpoint = <&mix_in10>;
-						};
-					};
-
-					port@5e {
-						reg = <0x5e>;
-
-						xbar_mix_out1: endpoint {
-							remote-endpoint = <&mix_out1>;
-						};
-					};
-
-					port@5f {
-						reg = <0x5f>;
-
-						xbar_mix_out2: endpoint {
-							remote-endpoint = <&mix_out2>;
-						};
-					};
-
-					port@60 {
-						reg = <0x60>;
-
-						xbar_mix_out3: endpoint {
-							remote-endpoint = <&mix_out3>;
-						};
-					};
-
-					port@61 {
-						reg = <0x61>;
-
-						xbar_mix_out4: endpoint {
-							remote-endpoint = <&mix_out4>;
-						};
-					};
-
-					port@62 {
-						reg = <0x62>;
-
-						xbar_mix_out5: endpoint {
-							remote-endpoint = <&mix_out5>;
-						};
-					};
-
-					xbar_asrc_in1_port: port@63 {
-						reg = <0x63>;
-
-						xbar_asrc_in1_ep: endpoint {
-							remote-endpoint = <&asrc_in1_ep>;
-						};
-					};
-
-					port@64 {
-						reg = <0x64>;
-
-						xbar_asrc_out1_ep: endpoint {
-							remote-endpoint = <&asrc_out1_ep>;
-						};
-					};
-
-					xbar_asrc_in2_port: port@65 {
-						reg = <0x65>;
-
-						xbar_asrc_in2_ep: endpoint {
-							remote-endpoint = <&asrc_in2_ep>;
-						};
-					};
-
-					port@66 {
-						reg = <0x66>;
-
-						xbar_asrc_out2_ep: endpoint {
-							remote-endpoint = <&asrc_out2_ep>;
-						};
-					};
-
-					xbar_asrc_in3_port: port@67 {
-						reg = <0x67>;
-
-						xbar_asrc_in3_ep: endpoint {
-							remote-endpoint = <&asrc_in3_ep>;
-						};
-					};
-
-					port@68 {
-						reg = <0x68>;
-
-						xbar_asrc_out3_ep: endpoint {
-							remote-endpoint = <&asrc_out3_ep>;
-						};
-					};
-
-					xbar_asrc_in4_port: port@69 {
-						reg = <0x69>;
-
-						xbar_asrc_in4_ep: endpoint {
-							remote-endpoint = <&asrc_in4_ep>;
-						};
-					};
-
-					port@6a {
-						reg = <0x6a>;
-
-						xbar_asrc_out4_ep: endpoint {
-							remote-endpoint = <&asrc_out4_ep>;
-						};
-					};
-
-					xbar_asrc_in5_port: port@6b {
-						reg = <0x6b>;
-
-						xbar_asrc_in5_ep: endpoint {
-							remote-endpoint = <&asrc_in5_ep>;
-						};
-					};
-
-					port@6c {
-						reg = <0x6c>;
-
-						xbar_asrc_out5_ep: endpoint {
-							remote-endpoint = <&asrc_out5_ep>;
-						};
-					};
-
-					xbar_asrc_in6_port: port@6d {
-						reg = <0x6d>;
-
-						xbar_asrc_in6_ep: endpoint {
-							remote-endpoint = <&asrc_in6_ep>;
-						};
-					};
-
-					port@6e {
-						reg = <0x6e>;
-
-						xbar_asrc_out6_ep: endpoint {
-							remote-endpoint = <&asrc_out6_ep>;
-						};
-					};
-
-					xbar_asrc_in7_port: port@6f {
-						reg = <0x6f>;
-
-						xbar_asrc_in7_ep: endpoint {
-							remote-endpoint = <&asrc_in7_ep>;
-						};
-					};
-
-					xbar_ope1_in_port: port@70 {
-						reg = <0x70>;
-
-						xbar_ope1_in_ep: endpoint {
-							remote-endpoint = <&ope1_cif_in_ep>;
-						};
-					};
-
-					port@71 {
-						reg = <0x71>;
-
-						xbar_ope1_out_ep: endpoint {
-							remote-endpoint = <&ope1_cif_out_ep>;
-						};
-					};
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 3f16595d099c..a01ff6174f74 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -200,6 +200,28 @@ tegra_i2s1: i2s@2901000 {
 					assigned-clock-rates = <1536000>;
 					sound-name-prefix = "I2S1";
 					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s1_cif: endpoint {
+								remote-endpoint = <&xbar_i2s1>;
+							};
+						};
+
+						i2s1_port: port@1 {
+							reg = <1>;
+
+							i2s1_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
 				};
 
 				tegra_i2s2: i2s@2901100 {
@@ -214,6 +236,28 @@ tegra_i2s2: i2s@2901100 {
 					assigned-clock-rates = <1536000>;
 					sound-name-prefix = "I2S2";
 					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s2_cif: endpoint {
+								remote-endpoint = <&xbar_i2s2>;
+							};
+						};
+
+						i2s2_port: port@1 {
+							reg = <1>;
+
+							i2s2_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
 				};
 
 				tegra_i2s3: i2s@2901200 {
@@ -242,6 +286,28 @@ tegra_i2s4: i2s@2901300 {
 					assigned-clock-rates = <1536000>;
 					sound-name-prefix = "I2S4";
 					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s4_cif: endpoint {
+								remote-endpoint = <&xbar_i2s4>;
+							};
+						};
+
+						i2s4_port: port@1 {
+							reg = <1>;
+
+							i2s4_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
 				};
 
 				tegra_i2s5: i2s@2901400 {
@@ -270,6 +336,28 @@ tegra_i2s6: i2s@2901500 {
 					assigned-clock-rates = <1536000>;
 					sound-name-prefix = "I2S6";
 					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s6_cif: endpoint {
+								remote-endpoint = <&xbar_i2s6>;
+							};
+						};
+
+						i2s6_port: port@1 {
+							reg = <1>;
+
+							i2s6_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
 				};
 
 				tegra_sfc1: sfc@2902000 {
@@ -277,7 +365,27 @@ tegra_sfc1: sfc@2902000 {
 						     "nvidia,tegra210-sfc";
 					reg = <0x0 0x2902000 0x0 0x200>;
 					sound-name-prefix = "SFC1";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc1_cif_in: endpoint {
+								remote-endpoint = <&xbar_sfc1_in>;
+							};
+						};
+
+						sfc1_out_port: port@1 {
+							reg = <1>;
+
+							sfc1_cif_out: endpoint {
+								remote-endpoint = <&xbar_sfc1_out>;
+							};
+						};
+					};
 				};
 
 				tegra_sfc2: sfc@2902200 {
@@ -285,7 +393,27 @@ tegra_sfc2: sfc@2902200 {
 						     "nvidia,tegra210-sfc";
 					reg = <0x0 0x2902200 0x0 0x200>;
 					sound-name-prefix = "SFC2";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc2_cif_in: endpoint {
+								remote-endpoint = <&xbar_sfc2_in>;
+							};
+						};
+
+						sfc2_out_port: port@1 {
+							reg = <1>;
+
+							sfc2_cif_out: endpoint {
+								remote-endpoint = <&xbar_sfc2_out>;
+							};
+						};
+					};
 				};
 
 				tegra_sfc3: sfc@2902400 {
@@ -293,7 +421,27 @@ tegra_sfc3: sfc@2902400 {
 						     "nvidia,tegra210-sfc";
 					reg = <0x0 0x2902400 0x0 0x200>;
 					sound-name-prefix = "SFC3";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc3_cif_in: endpoint {
+								remote-endpoint = <&xbar_sfc3_in>;
+							};
+						};
+
+						sfc3_out_port: port@1 {
+							reg = <1>;
+
+							sfc3_cif_out: endpoint {
+								remote-endpoint = <&xbar_sfc3_out>;
+							};
+						};
+					};
 				};
 
 				tegra_sfc4: sfc@2902600 {
@@ -301,7 +449,27 @@ tegra_sfc4: sfc@2902600 {
 						     "nvidia,tegra210-sfc";
 					reg = <0x0 0x2902600 0x0 0x200>;
 					sound-name-prefix = "SFC4";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc4_cif_in: endpoint {
+								remote-endpoint = <&xbar_sfc4_in>;
+							};
+						};
+
+						sfc4_out_port: port@1 {
+							reg = <1>;
+
+							sfc4_cif_out: endpoint {
+								remote-endpoint = <&xbar_sfc4_out>;
+							};
+						};
+					};
 				};
 
 				tegra_amx1: amx@2903000 {
@@ -309,7 +477,51 @@ tegra_amx1: amx@2903000 {
 						     "nvidia,tegra194-amx";
 					reg = <0x0 0x2903000 0x0 0x100>;
 					sound-name-prefix = "AMX1";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx1_in1: endpoint {
+								remote-endpoint = <&xbar_amx1_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx1_in2: endpoint {
+								remote-endpoint = <&xbar_amx1_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx1_in3: endpoint {
+								remote-endpoint = <&xbar_amx1_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx1_in4: endpoint {
+								remote-endpoint = <&xbar_amx1_in4>;
+							};
+						};
+
+						amx1_out_port: port@4 {
+							reg = <4>;
+
+							amx1_out: endpoint {
+								remote-endpoint = <&xbar_amx1_out>;
+							};
+						};
+					};
 				};
 
 				tegra_amx2: amx@2903100 {
@@ -317,7 +529,51 @@ tegra_amx2: amx@2903100 {
 						     "nvidia,tegra194-amx";
 					reg = <0x0 0x2903100 0x0 0x100>;
 					sound-name-prefix = "AMX2";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx2_in1: endpoint {
+								remote-endpoint = <&xbar_amx2_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx2_in2: endpoint {
+								remote-endpoint = <&xbar_amx2_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx2_in3: endpoint {
+								remote-endpoint = <&xbar_amx2_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx2_in4: endpoint {
+								remote-endpoint = <&xbar_amx2_in4>;
+							};
+						};
+
+						amx2_out_port: port@4 {
+							reg = <4>;
+
+							amx2_out: endpoint {
+								remote-endpoint = <&xbar_amx2_out>;
+							};
+						};
+					};
 				};
 
 				tegra_amx3: amx@2903200 {
@@ -325,7 +581,51 @@ tegra_amx3: amx@2903200 {
 						     "nvidia,tegra194-amx";
 					reg = <0x0 0x2903200 0x0 0x100>;
 					sound-name-prefix = "AMX3";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx3_in1: endpoint {
+								remote-endpoint = <&xbar_amx3_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx3_in2: endpoint {
+								remote-endpoint = <&xbar_amx3_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx3_in3: endpoint {
+								remote-endpoint = <&xbar_amx3_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx3_in4: endpoint {
+								remote-endpoint = <&xbar_amx3_in4>;
+							};
+						};
+
+						amx3_out_port: port@4 {
+							reg = <4>;
+
+							amx3_out: endpoint {
+								remote-endpoint = <&xbar_amx3_out>;
+							};
+						};
+					};
 				};
 
 				tegra_amx4: amx@2903300 {
@@ -333,7 +633,51 @@ tegra_amx4: amx@2903300 {
 						     "nvidia,tegra194-amx";
 					reg = <0x0 0x2903300 0x0 0x100>;
 					sound-name-prefix = "AMX4";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx4_in1: endpoint {
+								remote-endpoint = <&xbar_amx4_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx4_in2: endpoint {
+								remote-endpoint = <&xbar_amx4_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx4_in3: endpoint {
+								remote-endpoint = <&xbar_amx4_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx4_in4: endpoint {
+								remote-endpoint = <&xbar_amx4_in4>;
+							};
+						};
+
+						amx4_out_port: port@4 {
+							reg = <4>;
+
+							amx4_out: endpoint {
+								remote-endpoint = <&xbar_amx4_out>;
+							};
+						};
+					};
 				};
 
 				tegra_adx1: adx@2903800 {
@@ -341,7 +685,51 @@ tegra_adx1: adx@2903800 {
 						     "nvidia,tegra210-adx";
 					reg = <0x0 0x2903800 0x0 0x100>;
 					sound-name-prefix = "ADX1";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx1_in: endpoint {
+								remote-endpoint = <&xbar_adx1_in>;
+							};
+						};
+
+						adx1_out1_port: port@1 {
+							reg = <1>;
+
+							adx1_out1: endpoint {
+								remote-endpoint = <&xbar_adx1_out1>;
+							};
+						};
+
+						adx1_out2_port: port@2 {
+							reg = <2>;
+
+							adx1_out2: endpoint {
+								remote-endpoint = <&xbar_adx1_out2>;
+							};
+						};
+
+						adx1_out3_port: port@3 {
+							reg = <3>;
+
+							adx1_out3: endpoint {
+								remote-endpoint = <&xbar_adx1_out3>;
+							};
+						};
+
+						adx1_out4_port: port@4 {
+							reg = <4>;
+
+							adx1_out4: endpoint {
+								remote-endpoint = <&xbar_adx1_out4>;
+							};
+						};
+					};
 				};
 
 				tegra_adx2: adx@2903900 {
@@ -349,7 +737,51 @@ tegra_adx2: adx@2903900 {
 						     "nvidia,tegra210-adx";
 					reg = <0x0 0x2903900 0x0 0x100>;
 					sound-name-prefix = "ADX2";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx2_in: endpoint {
+								remote-endpoint = <&xbar_adx2_in>;
+							};
+						};
+
+						adx2_out1_port: port@1 {
+							reg = <1>;
+
+							adx2_out1: endpoint {
+								remote-endpoint = <&xbar_adx2_out1>;
+							};
+						};
+
+						adx2_out2_port: port@2 {
+							reg = <2>;
+
+							adx2_out2: endpoint {
+								remote-endpoint = <&xbar_adx2_out2>;
+							};
+						};
+
+						adx2_out3_port: port@3 {
+							reg = <3>;
+
+							adx2_out3: endpoint {
+								remote-endpoint = <&xbar_adx2_out3>;
+							};
+						};
+
+						adx2_out4_port: port@4 {
+							reg = <4>;
+
+							adx2_out4: endpoint {
+								remote-endpoint = <&xbar_adx2_out4>;
+							};
+						};
+					};
 				};
 
 				tegra_adx3: adx@2903a00 {
@@ -357,7 +789,51 @@ tegra_adx3: adx@2903a00 {
 						     "nvidia,tegra210-adx";
 					reg = <0x0 0x2903a00 0x0 0x100>;
 					sound-name-prefix = "ADX3";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx3_in: endpoint {
+								remote-endpoint = <&xbar_adx3_in>;
+							};
+						};
+
+						adx3_out1_port: port@1 {
+							reg = <1>;
+
+							adx3_out1: endpoint {
+								remote-endpoint = <&xbar_adx3_out1>;
+							};
+						};
+
+						adx3_out2_port: port@2 {
+							reg = <2>;
+
+							adx3_out2: endpoint {
+								remote-endpoint = <&xbar_adx3_out2>;
+							};
+						};
+
+						adx3_out3_port: port@3 {
+							reg = <3>;
+
+							adx3_out3: endpoint {
+								remote-endpoint = <&xbar_adx3_out3>;
+							};
+						};
+
+						adx3_out4_port: port@4 {
+							reg = <4>;
+
+							adx3_out4: endpoint {
+								remote-endpoint = <&xbar_adx3_out4>;
+							};
+						};
+					};
 				};
 
 				tegra_adx4: adx@2903b00 {
@@ -365,7 +841,51 @@ tegra_adx4: adx@2903b00 {
 						     "nvidia,tegra210-adx";
 					reg = <0x0 0x2903b00 0x0 0x100>;
 					sound-name-prefix = "ADX4";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx4_in: endpoint {
+								remote-endpoint = <&xbar_adx4_in>;
+							};
+						};
+
+						adx4_out1_port: port@1 {
+							reg = <1>;
+
+							adx4_out1: endpoint {
+								remote-endpoint = <&xbar_adx4_out1>;
+							};
+						};
+
+						adx4_out2_port: port@2 {
+							reg = <2>;
+
+							adx4_out2: endpoint {
+								remote-endpoint = <&xbar_adx4_out2>;
+							};
+						};
+
+						adx4_out3_port: port@3 {
+							reg = <3>;
+
+							adx4_out3: endpoint {
+								remote-endpoint = <&xbar_adx4_out3>;
+							};
+						};
+
+						adx4_out4_port: port@4 {
+							reg = <4>;
+
+							adx4_out4: endpoint {
+								remote-endpoint = <&xbar_adx4_out4>;
+							};
+						};
+					};
 				};
 
 
@@ -406,6 +926,27 @@ tegra_dmic3: dmic@2904200 {
 					assigned-clock-rates = <3072000>;
 					sound-name-prefix = "DMIC3";
 					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							dmic3_cif: endpoint {
+								remote-endpoint = <&xbar_dmic3>;
+							};
+						};
+
+						dmic3_port: port@1 {
+							reg = <1>;
+
+							dmic3_dap: endpoint {
+								/* placeholder for external codec */
+							};
+						};
+					};
 				};
 
 				tegra_dmic4: dmic@2904300 {
@@ -452,7 +993,6 @@ tegra_ope1: processing-engine@2908000 {
 						     "nvidia,tegra210-ope";
 					reg = <0x0 0x2908000 0x0 0x100>;
 					sound-name-prefix = "OPE1";
-					status = "disabled";
 
 					#address-cells = <2>;
 					#size-cells = <2>;
@@ -469,6 +1009,29 @@ dynamic-range-compressor@2908200 {
 							     "nvidia,tegra210-mbdrc";
 						reg = <0x0 0x2908200 0x0 0x200>;
 					};
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							ope1_cif_in_ep: endpoint {
+								remote-endpoint =
+									<&xbar_ope1_in_ep>;
+							};
+						};
+
+						ope1_out_port: port@1 {
+							reg = <0x1>;
+
+							ope1_cif_out_ep: endpoint {
+								remote-endpoint =
+									<&xbar_ope1_out_ep>;
+							};
+						};
+					};
 				};
 
 				tegra_mvc1: mvc@290a000 {
@@ -476,7 +1039,27 @@ tegra_mvc1: mvc@290a000 {
 						     "nvidia,tegra210-mvc";
 					reg = <0x0 0x290a000 0x0 0x200>;
 					sound-name-prefix = "MVC1";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							mvc1_cif_in: endpoint {
+								remote-endpoint = <&xbar_mvc1_in>;
+							};
+						};
+
+						mvc1_out_port: port@1 {
+							reg = <1>;
+
+							mvc1_cif_out: endpoint {
+								remote-endpoint = <&xbar_mvc1_out>;
+							};
+						};
+					};
 				};
 
 				tegra_mvc2: mvc@290a200 {
@@ -484,7 +1067,27 @@ tegra_mvc2: mvc@290a200 {
 						     "nvidia,tegra210-mvc";
 					reg = <0x0 0x290a200 0x0 0x200>;
 					sound-name-prefix = "MVC2";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							mvc2_cif_in: endpoint {
+								remote-endpoint = <&xbar_mvc2_in>;
+							};
+						};
+
+						mvc2_out_port: port@1 {
+							reg = <1>;
+
+							mvc2_cif_out: endpoint {
+								remote-endpoint = <&xbar_mvc2_out>;
+							};
+						};
+					};
 				};
 
 				tegra_amixer: amixer@290bb00 {
@@ -492,16 +1095,140 @@ tegra_amixer: amixer@290bb00 {
 						     "nvidia,tegra210-amixer";
 					reg = <0x0 0x290bb00 0x0 0x800>;
 					sound-name-prefix = "MIXER1";
-					status = "disabled";
-				};
 
-				tegra_admaif: admaif@290f000 {
-					compatible = "nvidia,tegra234-admaif",
-						     "nvidia,tegra186-admaif";
-					reg = <0x0 0x0290f000 0x0 0x1000>;
-					dmas = <&adma 1>, <&adma 1>,
-					       <&adma 2>, <&adma 2>,
-					       <&adma 3>, <&adma 3>,
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							mix_in1: endpoint {
+								remote-endpoint = <&xbar_mix_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <0x1>;
+
+							mix_in2: endpoint {
+								remote-endpoint = <&xbar_mix_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <0x2>;
+
+							mix_in3: endpoint {
+								remote-endpoint = <&xbar_mix_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <0x3>;
+
+							mix_in4: endpoint {
+								remote-endpoint = <&xbar_mix_in4>;
+							};
+						};
+
+						port@4 {
+							reg = <0x4>;
+
+							mix_in5: endpoint {
+								remote-endpoint = <&xbar_mix_in5>;
+							};
+						};
+
+						port@5 {
+							reg = <0x5>;
+
+							mix_in6: endpoint {
+								remote-endpoint = <&xbar_mix_in6>;
+							};
+						};
+
+						port@6 {
+							reg = <0x6>;
+
+							mix_in7: endpoint {
+								remote-endpoint = <&xbar_mix_in7>;
+							};
+						};
+
+						port@7 {
+							reg = <0x7>;
+
+							mix_in8: endpoint {
+								remote-endpoint = <&xbar_mix_in8>;
+							};
+						};
+
+						port@8 {
+							reg = <0x8>;
+
+							mix_in9: endpoint {
+								remote-endpoint = <&xbar_mix_in9>;
+							};
+						};
+
+						port@9 {
+							reg = <0x9>;
+
+							mix_in10: endpoint {
+								remote-endpoint = <&xbar_mix_in10>;
+							};
+						};
+
+						mix_out1_port: port@a {
+							reg = <0xa>;
+
+							mix_out1: endpoint {
+								remote-endpoint = <&xbar_mix_out1>;
+							};
+						};
+
+						mix_out2_port: port@b {
+							reg = <0xb>;
+
+							mix_out2: endpoint {
+								remote-endpoint = <&xbar_mix_out2>;
+							};
+						};
+
+						mix_out3_port: port@c {
+							reg = <0xc>;
+
+							mix_out3: endpoint {
+								remote-endpoint = <&xbar_mix_out3>;
+							};
+						};
+
+						mix_out4_port: port@d {
+							reg = <0xd>;
+
+							mix_out4: endpoint {
+								remote-endpoint = <&xbar_mix_out4>;
+							};
+						};
+
+						mix_out5_port: port@e {
+							reg = <0xe>;
+
+							mix_out5: endpoint {
+								remote-endpoint = <&xbar_mix_out5>;
+							};
+						};
+					};
+				};
+
+				tegra_admaif: admaif@290f000 {
+					compatible = "nvidia,tegra234-admaif",
+						     "nvidia,tegra186-admaif";
+					reg = <0x0 0x0290f000 0x0 0x1000>;
+					dmas = <&adma 1>, <&adma 1>,
+					       <&adma 2>, <&adma 2>,
+					       <&adma 3>, <&adma 3>,
 					       <&adma 4>, <&adma 4>,
 					       <&adma 5>, <&adma 5>,
 					       <&adma 6>, <&adma 6>,
@@ -543,7 +1270,171 @@ tegra_admaif: admaif@290f000 {
 							<&mc TEGRA234_MEMORY_CLIENT_APEDMAW &emc>;
 					interconnect-names = "dma-mem", "write";
 					iommus = <&smmu_niso0 TEGRA234_SID_APE>;
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						admaif0_port: port@0 {
+							reg = <0x0>;
+
+							admaif0: endpoint {
+								remote-endpoint = <&xbar_admaif0>;
+							};
+						};
+
+						admaif1_port: port@1 {
+							reg = <0x1>;
+
+							admaif1: endpoint {
+								remote-endpoint = <&xbar_admaif1>;
+							};
+						};
+
+						admaif2_port: port@2 {
+							reg = <0x2>;
+
+							admaif2: endpoint {
+								remote-endpoint = <&xbar_admaif2>;
+							};
+						};
+
+						admaif3_port: port@3 {
+							reg = <0x3>;
+
+							admaif3: endpoint {
+								remote-endpoint = <&xbar_admaif3>;
+							};
+						};
+
+						admaif4_port: port@4 {
+							reg = <0x4>;
+
+							admaif4: endpoint {
+								remote-endpoint = <&xbar_admaif4>;
+							};
+						};
+
+						admaif5_port: port@5 {
+							reg = <0x5>;
+
+							admaif5: endpoint {
+								remote-endpoint = <&xbar_admaif5>;
+							};
+						};
+
+						admaif6_port: port@6 {
+							reg = <0x6>;
+
+							admaif6: endpoint {
+								remote-endpoint = <&xbar_admaif6>;
+							};
+						};
+
+						admaif7_port: port@7 {
+							reg = <0x7>;
+
+							admaif7: endpoint {
+								remote-endpoint = <&xbar_admaif7>;
+							};
+						};
+
+						admaif8_port: port@8 {
+							reg = <0x8>;
+
+							admaif8: endpoint {
+								remote-endpoint = <&xbar_admaif8>;
+							};
+						};
+
+						admaif9_port: port@9 {
+							reg = <0x9>;
+
+							admaif9: endpoint {
+								remote-endpoint = <&xbar_admaif9>;
+							};
+						};
+
+						admaif10_port: port@a {
+							reg = <0xa>;
+
+							admaif10: endpoint {
+								remote-endpoint = <&xbar_admaif10>;
+							};
+						};
+
+						admaif11_port: port@b {
+							reg = <0xb>;
+
+							admaif11: endpoint {
+								remote-endpoint = <&xbar_admaif11>;
+							};
+						};
+
+						admaif12_port: port@c {
+							reg = <0xc>;
+
+							admaif12: endpoint {
+								remote-endpoint = <&xbar_admaif12>;
+							};
+						};
+
+						admaif13_port: port@d {
+							reg = <0xd>;
+
+							admaif13: endpoint {
+								remote-endpoint = <&xbar_admaif13>;
+							};
+						};
+
+						admaif14_port: port@e {
+							reg = <0xe>;
+
+							admaif14: endpoint {
+								remote-endpoint = <&xbar_admaif14>;
+							};
+						};
+
+						admaif15_port: port@f {
+							reg = <0xf>;
+
+							admaif15: endpoint {
+								remote-endpoint = <&xbar_admaif15>;
+							};
+						};
+
+						admaif16_port: port@10 {
+							reg = <0x10>;
+
+							admaif16: endpoint {
+								remote-endpoint = <&xbar_admaif16>;
+							};
+						};
+
+						admaif17_port: port@11 {
+							reg = <0x11>;
+
+							admaif17: endpoint {
+								remote-endpoint = <&xbar_admaif17>;
+							};
+						};
+
+						admaif18_port: port@12 {
+							reg = <0x12>;
+
+							admaif18: endpoint {
+								remote-endpoint = <&xbar_admaif18>;
+							};
+						};
+
+						admaif19_port: port@13 {
+							reg = <0x13>;
+
+							admaif19: endpoint {
+								remote-endpoint = <&xbar_admaif19>;
+							};
+						};
+					};
 				};
 
 				tegra_asrc: asrc@2910000 {
@@ -551,7 +1442,989 @@ tegra_asrc: asrc@2910000 {
 						     "nvidia,tegra186-asrc";
 					reg = <0x0 0x2910000 0x0 0x2000>;
 					sound-name-prefix = "ASRC1";
-					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							asrc_in1_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in1_ep>;
+							};
+						};
+
+						port@1 {
+							reg = <0x1>;
+
+							asrc_in2_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in2_ep>;
+							};
+						};
+
+						port@2 {
+							reg = <0x2>;
+
+							asrc_in3_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in3_ep>;
+							};
+						};
+
+						port@3 {
+							reg = <0x3>;
+
+							asrc_in4_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in4_ep>;
+							};
+						};
+
+						port@4 {
+							reg = <0x4>;
+
+							asrc_in5_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in5_ep>;
+							};
+						};
+
+						port@5 {
+							reg = <0x5>;
+
+							asrc_in6_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in6_ep>;
+							};
+						};
+
+						port@6 {
+							reg = <0x6>;
+
+							asrc_in7_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in7_ep>;
+							};
+						};
+
+						asrc_out1_port: port@7 {
+							reg = <0x7>;
+
+							asrc_out1_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_out1_ep>;
+							};
+						};
+
+						asrc_out2_port: port@8 {
+							reg = <0x8>;
+
+							asrc_out2_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_out2_ep>;
+							};
+						};
+
+						asrc_out3_port: port@9 {
+							reg = <0x9>;
+
+							asrc_out3_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_out3_ep>;
+							};
+						};
+
+						asrc_out4_port: port@a {
+							reg = <0xa>;
+
+							asrc_out4_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_out4_ep>;
+							};
+						};
+
+						asrc_out5_port: port@b {
+							reg = <0xb>;
+
+							asrc_out5_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_out5_ep>;
+							};
+						};
+
+						asrc_out6_port:	port@c {
+							reg = <0xc>;
+
+							asrc_out6_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_out6_ep>;
+							};
+						};
+					};
+				};
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0x0>;
+
+						xbar_admaif0: endpoint {
+							remote-endpoint = <&admaif0>;
+						};
+					};
+
+					port@1 {
+						reg = <0x1>;
+
+						xbar_admaif1: endpoint {
+							remote-endpoint = <&admaif1>;
+						};
+					};
+
+					port@2 {
+						reg = <0x2>;
+
+						xbar_admaif2: endpoint {
+							remote-endpoint = <&admaif2>;
+						};
+					};
+
+					port@3 {
+						reg = <0x3>;
+
+						xbar_admaif3: endpoint {
+							remote-endpoint = <&admaif3>;
+						};
+					};
+
+					port@4 {
+						reg = <0x4>;
+
+						xbar_admaif4: endpoint {
+							remote-endpoint = <&admaif4>;
+						};
+					};
+
+					port@5 {
+						reg = <0x5>;
+
+						xbar_admaif5: endpoint {
+							remote-endpoint = <&admaif5>;
+						};
+					};
+
+					port@6 {
+						reg = <0x6>;
+
+						xbar_admaif6: endpoint {
+							remote-endpoint = <&admaif6>;
+						};
+					};
+
+					port@7 {
+						reg = <0x7>;
+
+						xbar_admaif7: endpoint {
+							remote-endpoint = <&admaif7>;
+						};
+					};
+
+					port@8 {
+						reg = <0x8>;
+
+						xbar_admaif8: endpoint {
+							remote-endpoint = <&admaif8>;
+						};
+					};
+
+					port@9 {
+						reg = <0x9>;
+
+						xbar_admaif9: endpoint {
+							remote-endpoint = <&admaif9>;
+						};
+					};
+
+					port@a {
+						reg = <0xa>;
+
+						xbar_admaif10: endpoint {
+							remote-endpoint = <&admaif10>;
+						};
+					};
+
+					port@b {
+						reg = <0xb>;
+
+						xbar_admaif11: endpoint {
+							remote-endpoint = <&admaif11>;
+						};
+					};
+
+					port@c {
+						reg = <0xc>;
+
+						xbar_admaif12: endpoint {
+							remote-endpoint = <&admaif12>;
+						};
+					};
+
+					port@d {
+						reg = <0xd>;
+
+						xbar_admaif13: endpoint {
+							remote-endpoint = <&admaif13>;
+						};
+					};
+
+					port@e {
+						reg = <0xe>;
+
+						xbar_admaif14: endpoint {
+							remote-endpoint = <&admaif14>;
+						};
+					};
+
+					port@f {
+						reg = <0xf>;
+
+						xbar_admaif15: endpoint {
+							remote-endpoint = <&admaif15>;
+						};
+					};
+
+					port@10 {
+						reg = <0x10>;
+
+						xbar_admaif16: endpoint {
+							remote-endpoint = <&admaif16>;
+						};
+					};
+
+					port@11 {
+						reg = <0x11>;
+
+						xbar_admaif17: endpoint {
+							remote-endpoint = <&admaif17>;
+						};
+					};
+
+					port@12 {
+						reg = <0x12>;
+
+						xbar_admaif18: endpoint {
+							remote-endpoint = <&admaif18>;
+						};
+					};
+
+					port@13 {
+						reg = <0x13>;
+
+						xbar_admaif19: endpoint {
+							remote-endpoint = <&admaif19>;
+						};
+					};
+
+					xbar_i2s1_port: port@14 {
+						reg = <0x14>;
+
+						xbar_i2s1: endpoint {
+							remote-endpoint = <&i2s1_cif>;
+						};
+					};
+
+					xbar_i2s2_port: port@15 {
+						reg = <0x15>;
+
+						xbar_i2s2: endpoint {
+							remote-endpoint = <&i2s2_cif>;
+						};
+					};
+
+					xbar_i2s4_port: port@17 {
+						reg = <0x17>;
+
+						xbar_i2s4: endpoint {
+							remote-endpoint = <&i2s4_cif>;
+						};
+					};
+
+					xbar_i2s6_port: port@19 {
+						reg = <0x19>;
+
+						xbar_i2s6: endpoint {
+							remote-endpoint = <&i2s6_cif>;
+						};
+					};
+
+					xbar_dmic3_port: port@1c {
+						reg = <0x1c>;
+
+						xbar_dmic3: endpoint {
+							remote-endpoint = <&dmic3_cif>;
+						};
+					};
+
+					xbar_sfc1_in_port: port@20 {
+						reg = <0x20>;
+
+						xbar_sfc1_in: endpoint {
+							remote-endpoint = <&sfc1_cif_in>;
+						};
+					};
+
+					port@21 {
+						reg = <0x21>;
+
+						xbar_sfc1_out: endpoint {
+							remote-endpoint = <&sfc1_cif_out>;
+						};
+					};
+
+					xbar_sfc2_in_port: port@22 {
+						reg = <0x22>;
+
+						xbar_sfc2_in: endpoint {
+							remote-endpoint = <&sfc2_cif_in>;
+						};
+					};
+
+					port@23 {
+						reg = <0x23>;
+
+						xbar_sfc2_out: endpoint {
+							remote-endpoint = <&sfc2_cif_out>;
+						};
+					};
+
+					xbar_sfc3_in_port: port@24 {
+						reg = <0x24>;
+
+						xbar_sfc3_in: endpoint {
+							remote-endpoint = <&sfc3_cif_in>;
+						};
+					};
+
+					port@25 {
+						reg = <0x25>;
+
+						xbar_sfc3_out: endpoint {
+							remote-endpoint = <&sfc3_cif_out>;
+						};
+					};
+
+					xbar_sfc4_in_port: port@26 {
+						reg = <0x26>;
+
+						xbar_sfc4_in: endpoint {
+							remote-endpoint = <&sfc4_cif_in>;
+						};
+					};
+
+					port@27 {
+						reg = <0x27>;
+
+						xbar_sfc4_out: endpoint {
+							remote-endpoint = <&sfc4_cif_out>;
+						};
+					};
+
+					xbar_mvc1_in_port: port@28 {
+						reg = <0x28>;
+
+						xbar_mvc1_in: endpoint {
+							remote-endpoint = <&mvc1_cif_in>;
+						};
+					};
+
+					port@29 {
+						reg = <0x29>;
+
+						xbar_mvc1_out: endpoint {
+							remote-endpoint = <&mvc1_cif_out>;
+						};
+					};
+
+					xbar_mvc2_in_port: port@2a {
+						reg = <0x2a>;
+
+						xbar_mvc2_in: endpoint {
+							remote-endpoint = <&mvc2_cif_in>;
+						};
+					};
+
+					port@2b {
+						reg = <0x2b>;
+
+						xbar_mvc2_out: endpoint {
+							remote-endpoint = <&mvc2_cif_out>;
+						};
+					};
+
+					xbar_amx1_in1_port: port@2c {
+						reg = <0x2c>;
+
+						xbar_amx1_in1: endpoint {
+							remote-endpoint = <&amx1_in1>;
+						};
+					};
+
+					xbar_amx1_in2_port: port@2d {
+						reg = <0x2d>;
+
+						xbar_amx1_in2: endpoint {
+							remote-endpoint = <&amx1_in2>;
+						};
+					};
+
+					xbar_amx1_in3_port: port@2e {
+						reg = <0x2e>;
+
+						xbar_amx1_in3: endpoint {
+							remote-endpoint = <&amx1_in3>;
+						};
+					};
+
+					xbar_amx1_in4_port: port@2f {
+						reg = <0x2f>;
+
+						xbar_amx1_in4: endpoint {
+							remote-endpoint = <&amx1_in4>;
+						};
+					};
+
+					port@30 {
+						reg = <0x30>;
+
+						xbar_amx1_out: endpoint {
+							remote-endpoint = <&amx1_out>;
+						};
+					};
+
+					xbar_amx2_in1_port: port@31 {
+						reg = <0x31>;
+
+						xbar_amx2_in1: endpoint {
+							remote-endpoint = <&amx2_in1>;
+						};
+					};
+
+					xbar_amx2_in2_port: port@32 {
+						reg = <0x32>;
+
+						xbar_amx2_in2: endpoint {
+							remote-endpoint = <&amx2_in2>;
+						};
+					};
+
+					xbar_amx2_in3_port: port@33 {
+						reg = <0x33>;
+
+						xbar_amx2_in3: endpoint {
+							remote-endpoint = <&amx2_in3>;
+						};
+					};
+
+					xbar_amx2_in4_port: port@34 {
+						reg = <0x34>;
+
+						xbar_amx2_in4: endpoint {
+							remote-endpoint = <&amx2_in4>;
+						};
+					};
+
+					port@35 {
+						reg = <0x35>;
+
+						xbar_amx2_out: endpoint {
+							remote-endpoint = <&amx2_out>;
+						};
+					};
+
+					xbar_amx3_in1_port: port@36 {
+						reg = <0x36>;
+
+						xbar_amx3_in1: endpoint {
+							remote-endpoint = <&amx3_in1>;
+						};
+					};
+
+					xbar_amx3_in2_port: port@37 {
+						reg = <0x37>;
+
+						xbar_amx3_in2: endpoint {
+							remote-endpoint = <&amx3_in2>;
+						};
+					};
+
+					xbar_amx3_in3_port: port@38 {
+						reg = <0x38>;
+
+						xbar_amx3_in3: endpoint {
+							remote-endpoint = <&amx3_in3>;
+						};
+					};
+
+					xbar_amx3_in4_port: port@39 {
+						reg = <0x39>;
+
+						xbar_amx3_in4: endpoint {
+							remote-endpoint = <&amx3_in4>;
+						};
+					};
+
+					port@3a {
+						reg = <0x3a>;
+
+						xbar_amx3_out: endpoint {
+							remote-endpoint = <&amx3_out>;
+						};
+					};
+
+					xbar_amx4_in1_port: port@3b {
+						reg = <0x3b>;
+
+						xbar_amx4_in1: endpoint {
+							remote-endpoint = <&amx4_in1>;
+						};
+					};
+
+					xbar_amx4_in2_port: port@3c {
+						reg = <0x3c>;
+
+						xbar_amx4_in2: endpoint {
+							remote-endpoint = <&amx4_in2>;
+						};
+					};
+
+					xbar_amx4_in3_port: port@3d {
+						reg = <0x3d>;
+
+						xbar_amx4_in3: endpoint {
+							remote-endpoint = <&amx4_in3>;
+						};
+					};
+
+					xbar_amx4_in4_port: port@3e {
+						reg = <0x3e>;
+
+						xbar_amx4_in4: endpoint {
+							remote-endpoint = <&amx4_in4>;
+						};
+					};
+
+					port@3f {
+						reg = <0x3f>;
+
+						xbar_amx4_out: endpoint {
+							remote-endpoint = <&amx4_out>;
+						};
+					};
+
+					xbar_adx1_in_port: port@40 {
+						reg = <0x40>;
+
+						xbar_adx1_in: endpoint {
+							remote-endpoint = <&adx1_in>;
+						};
+					};
+
+					port@41 {
+						reg = <0x41>;
+
+						xbar_adx1_out1: endpoint {
+							remote-endpoint = <&adx1_out1>;
+						};
+					};
+
+					port@42 {
+						reg = <0x42>;
+
+						xbar_adx1_out2: endpoint {
+							remote-endpoint = <&adx1_out2>;
+						};
+					};
+
+					port@43 {
+						reg = <0x43>;
+
+						xbar_adx1_out3: endpoint {
+							remote-endpoint = <&adx1_out3>;
+						};
+					};
+
+					port@44 {
+						reg = <0x44>;
+
+						xbar_adx1_out4: endpoint {
+							remote-endpoint = <&adx1_out4>;
+						};
+					};
+
+					xbar_adx2_in_port: port@45 {
+						reg = <0x45>;
+
+						xbar_adx2_in: endpoint {
+							remote-endpoint = <&adx2_in>;
+						};
+					};
+
+					port@46 {
+						reg = <0x46>;
+
+						xbar_adx2_out1: endpoint {
+							remote-endpoint = <&adx2_out1>;
+						};
+					};
+
+					port@47 {
+						reg = <0x47>;
+
+						xbar_adx2_out2: endpoint {
+							remote-endpoint = <&adx2_out2>;
+						};
+					};
+
+					port@48 {
+						reg = <0x48>;
+
+						xbar_adx2_out3: endpoint {
+							remote-endpoint = <&adx2_out3>;
+						};
+					};
+
+					port@49 {
+						reg = <0x49>;
+
+						xbar_adx2_out4: endpoint {
+							remote-endpoint = <&adx2_out4>;
+						};
+					};
+
+					xbar_adx3_in_port: port@4a {
+						reg = <0x4a>;
+
+						xbar_adx3_in: endpoint {
+							remote-endpoint = <&adx3_in>;
+						};
+					};
+
+					port@4b {
+						reg = <0x4b>;
+
+						xbar_adx3_out1: endpoint {
+							remote-endpoint = <&adx3_out1>;
+						};
+					};
+
+					port@4c {
+						reg = <0x4c>;
+
+						xbar_adx3_out2: endpoint {
+							remote-endpoint = <&adx3_out2>;
+						};
+					};
+
+					port@4d {
+						reg = <0x4d>;
+
+						xbar_adx3_out3: endpoint {
+							remote-endpoint = <&adx3_out3>;
+						};
+					};
+
+					port@4e {
+						reg = <0x4e>;
+
+						xbar_adx3_out4: endpoint {
+							remote-endpoint = <&adx3_out4>;
+						};
+					};
+
+					xbar_adx4_in_port: port@4f {
+						reg = <0x4f>;
+
+						xbar_adx4_in: endpoint {
+							remote-endpoint = <&adx4_in>;
+						};
+					};
+
+					port@50 {
+						reg = <0x50>;
+
+						xbar_adx4_out1: endpoint {
+							remote-endpoint = <&adx4_out1>;
+						};
+					};
+
+					port@51 {
+						reg = <0x51>;
+
+						xbar_adx4_out2: endpoint {
+							remote-endpoint = <&adx4_out2>;
+						};
+					};
+
+					port@52 {
+						reg = <0x52>;
+
+						xbar_adx4_out3: endpoint {
+							remote-endpoint = <&adx4_out3>;
+						};
+					};
+
+					port@53 {
+						reg = <0x53>;
+
+						xbar_adx4_out4: endpoint {
+							remote-endpoint = <&adx4_out4>;
+						};
+					};
+
+					xbar_mix_in1_port: port@54 {
+						reg = <0x54>;
+
+						xbar_mix_in1: endpoint {
+							remote-endpoint = <&mix_in1>;
+						};
+					};
+
+					xbar_mix_in2_port: port@55 {
+						reg = <0x55>;
+
+						xbar_mix_in2: endpoint {
+							remote-endpoint = <&mix_in2>;
+						};
+					};
+
+					xbar_mix_in3_port: port@56 {
+						reg = <0x56>;
+
+						xbar_mix_in3: endpoint {
+							remote-endpoint = <&mix_in3>;
+						};
+					};
+
+					xbar_mix_in4_port: port@57 {
+						reg = <0x57>;
+
+						xbar_mix_in4: endpoint {
+							remote-endpoint = <&mix_in4>;
+						};
+					};
+
+					xbar_mix_in5_port: port@58 {
+						reg = <0x58>;
+
+						xbar_mix_in5: endpoint {
+							remote-endpoint = <&mix_in5>;
+						};
+					};
+
+					xbar_mix_in6_port: port@59 {
+						reg = <0x59>;
+
+						xbar_mix_in6: endpoint {
+							remote-endpoint = <&mix_in6>;
+						};
+					};
+
+					xbar_mix_in7_port: port@5a {
+						reg = <0x5a>;
+
+						xbar_mix_in7: endpoint {
+							remote-endpoint = <&mix_in7>;
+						};
+					};
+
+					xbar_mix_in8_port: port@5b {
+						reg = <0x5b>;
+
+						xbar_mix_in8: endpoint {
+							remote-endpoint = <&mix_in8>;
+						};
+					};
+
+					xbar_mix_in9_port: port@5c {
+						reg = <0x5c>;
+
+						xbar_mix_in9: endpoint {
+							remote-endpoint = <&mix_in9>;
+						};
+					};
+
+					xbar_mix_in10_port: port@5d {
+						reg = <0x5d>;
+
+						xbar_mix_in10: endpoint {
+							remote-endpoint = <&mix_in10>;
+						};
+					};
+
+					port@5e {
+						reg = <0x5e>;
+
+						xbar_mix_out1: endpoint {
+							remote-endpoint = <&mix_out1>;
+						};
+					};
+
+					port@5f {
+						reg = <0x5f>;
+
+						xbar_mix_out2: endpoint {
+							remote-endpoint = <&mix_out2>;
+						};
+					};
+
+					port@60 {
+						reg = <0x60>;
+
+						xbar_mix_out3: endpoint {
+							remote-endpoint = <&mix_out3>;
+						};
+					};
+
+					port@61 {
+						reg = <0x61>;
+
+						xbar_mix_out4: endpoint {
+							remote-endpoint = <&mix_out4>;
+						};
+					};
+
+					port@62 {
+						reg = <0x62>;
+
+						xbar_mix_out5: endpoint {
+							remote-endpoint = <&mix_out5>;
+						};
+					};
+
+					xbar_asrc_in1_port: port@63 {
+						reg = <0x63>;
+
+						xbar_asrc_in1_ep: endpoint {
+							remote-endpoint = <&asrc_in1_ep>;
+						};
+					};
+
+					port@64 {
+						reg = <0x64>;
+
+						xbar_asrc_out1_ep: endpoint {
+							remote-endpoint = <&asrc_out1_ep>;
+						};
+					};
+
+					xbar_asrc_in2_port: port@65 {
+						reg = <0x65>;
+
+						xbar_asrc_in2_ep: endpoint {
+							remote-endpoint = <&asrc_in2_ep>;
+						};
+					};
+
+					port@66 {
+						reg = <0x66>;
+
+						xbar_asrc_out2_ep: endpoint {
+							remote-endpoint = <&asrc_out2_ep>;
+						};
+					};
+
+					xbar_asrc_in3_port: port@67 {
+						reg = <0x67>;
+
+						xbar_asrc_in3_ep: endpoint {
+							remote-endpoint = <&asrc_in3_ep>;
+						};
+					};
+
+					port@68 {
+						reg = <0x68>;
+
+						xbar_asrc_out3_ep: endpoint {
+							remote-endpoint = <&asrc_out3_ep>;
+						};
+					};
+
+					xbar_asrc_in4_port: port@69 {
+						reg = <0x69>;
+
+						xbar_asrc_in4_ep: endpoint {
+							remote-endpoint = <&asrc_in4_ep>;
+						};
+					};
+
+					port@6a {
+						reg = <0x6a>;
+
+						xbar_asrc_out4_ep: endpoint {
+							remote-endpoint = <&asrc_out4_ep>;
+						};
+					};
+
+					xbar_asrc_in5_port: port@6b {
+						reg = <0x6b>;
+
+						xbar_asrc_in5_ep: endpoint {
+							remote-endpoint = <&asrc_in5_ep>;
+						};
+					};
+
+					port@6c {
+						reg = <0x6c>;
+
+						xbar_asrc_out5_ep: endpoint {
+							remote-endpoint = <&asrc_out5_ep>;
+						};
+					};
+
+					xbar_asrc_in6_port: port@6d {
+						reg = <0x6d>;
+
+						xbar_asrc_in6_ep: endpoint {
+							remote-endpoint = <&asrc_in6_ep>;
+						};
+					};
+
+					port@6e {
+						reg = <0x6e>;
+
+						xbar_asrc_out6_ep: endpoint {
+							remote-endpoint = <&asrc_out6_ep>;
+						};
+					};
+
+					xbar_asrc_in7_port: port@6f {
+						reg = <0x6f>;
+
+						xbar_asrc_in7_ep: endpoint {
+							remote-endpoint = <&asrc_in7_ep>;
+						};
+					};
+
+					xbar_ope1_in_port: port@70 {
+						reg = <0x70>;
+
+						xbar_ope1_in_ep: endpoint {
+							remote-endpoint = <&ope1_cif_in_ep>;
+						};
+					};
+
+					port@71 {
+						reg = <0x71>;
+
+						xbar_ope1_out_ep: endpoint {
+							remote-endpoint = <&ope1_cif_out_ep>;
+						};
+					};
 				};
 			};
 
-- 
2.34.1


