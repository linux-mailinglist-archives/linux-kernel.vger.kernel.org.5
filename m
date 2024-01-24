Return-Path: <linux-kernel+bounces-36650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BD983A462
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC681C21764
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAC317BDD;
	Wed, 24 Jan 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RPkqBPCK"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A4017BC2;
	Wed, 24 Jan 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085664; cv=fail; b=I7E3bj8W/4GoAv017TySaTxBtsht+basSYd6j4/es0LWTxx7HJBp5FMNdY1o8H2GSZ/Zxdw8CMEafWRe3EFKGNaqNhuiEcV7FTkKyM7ABeADJEDBpPR22N9VLPt6AR5sdu2Hh1+adhOXqTujvlM1Jn6OjsxhP/pKr6UvSIsI+5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085664; c=relaxed/simple;
	bh=JSavUQwauQ5NugGLC8OHoM1toSWzyiW15+qS8DK9VTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMNwyZGiWVgle1abBzPS2tfDOl7kylaTYWq3bLUBL+bH2bWikiZZxewdSCFeP1In8/TY8Mv2oNbLzUGF8g7u3asXUoRGUG0tB86ASN1VoqkixmEFFJLXFOWy+JsvJtbq7JCW8ZVZdLT0aMMI8ErWkawqMAdyqNJe+kPLsuE5sbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RPkqBPCK; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhQRKWi6H1f5FNsjWA0rvWthheeFGINkDQ3DaqM5utrOSH2NqAWr9kQjF3iouWTIlILGickXcipf1nfUCuu932G16Gjo7LirS3wbygqFr/c3N3cLSj8v7IeX89yyBivuWD2+sM/3pN5t+vd3QjeWKpFXvX5SG+SBpUHdY5rhmKX6IFVKWCXrZ4BnbpKg6fPuE3JdBjFzMmRjjkpSWlhnl84HEBSRALFc4Uj0iCTrryITNnJ2cf11pnNTMizg4hVPa+rh8mR/4HnhmN1ODx5cVi+1IKt9pP3PQipLfAqUh4m0g/QC4/SDGWL0RtTCkewpCOyS8epDr7d4IFxKunpd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtakwJF2Bp/VGmlWNt/aPHSW8I2UW+8++6zg+6yNoeU=;
 b=MekRGeiZzp15rZeHPqUIbfxv72CY68k6Jk3Dy3hIgQJMYajgxGgqkNALU4I/gCg0I7EycWTBHHEYhT5VGW35PTMXFMBDhnvINmE/CO5WV+IQ3SaqQ/5L4ZOOzB2/U0L+b8bUtUTI03z04EeKkCPVfLkQnfG9K86sbUW8fO5V8PuuF2dUmSRGWkoJBZw3ZZOiNGKNiJNn1Nr8ZcvBL8PGN6m0Xje84ubzDlHtqXqcABB0BuyKKo58H+6spLTUJXv+Vdg+3Iame8sXLLKLNxs1trXXNzEVKhJvtrzXBD79iZtXQm7mcrLHXwrjF7OC47OC2QonAYp09lzqG1G0JUIYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtakwJF2Bp/VGmlWNt/aPHSW8I2UW+8++6zg+6yNoeU=;
 b=RPkqBPCK+FPzTNrmOKyd9fBs/qk95S9Dq/3wdgby9U4q+8+/8HqajpDc3ghNWXjaLcTExw9xIOqJ78yPWKLjR/EIKLl9Ek3erZR2+mLPYudo/K/3Ti27fQXtmRsZqbPDa9ndk3VUweICsjRyxxxWvNGdvwLW2pNIjI+p7NZ8uxGS4ZeT6wZowHtl0JZntmdJvEUGv/G9VSLF/wky5FdTdZ4HgYqHlTkAfMr0UtVYaIxRjcvBI6NJuFwLl75gdC6r5taIR72jovDw3i9zeWyPRtOXEmRmXt9c/8Ryyw9w6pSDy2kDbHIcznNuG0sb+/POp/oJtpmkTXSXxWMl46CyZw==
Received: from SA9PR13CA0051.namprd13.prod.outlook.com (2603:10b6:806:22::26)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 08:40:59 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::e2) by SA9PR13CA0051.outlook.office365.com
 (2603:10b6:806:22::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 08:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 08:40:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 00:40:39 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 00:40:39 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 24 Jan 2024 00:40:35 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v4 5/5] arm64: tegra: Add Tegra Security Engine DT nodes
Date: Wed, 24 Jan 2024 14:08:46 +0530
Message-ID: <20240124083846.46487-6-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124083846.46487-1-akhilrajeev@nvidia.com>
References: <20240124083846.46487-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: aa60866d-43d8-410c-c29b-08dc1cb8300f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SheipnI6bs4rUDiEOS3ksZPuiw1LTJ8mP8Pbjgm3Now9KSazPEqdLUicGdcYwbcWQw9LRV7Kmukx9kIpGQRnYNUDUWWpn0R2xpt0xP5o0WWf286xIGXJfpGIMXHIirdP3oKMKCbl5EQlo5IZrqb4Jg9+U1ntqV74qEeB+sDyPLSn9PfMMH2wLUEnRdMZkiRT8MbnyFZU857V/3WgtY/ip4IEr2pLhwgqXV08e6ovScvjAbxwhvoQHQVF3PUD9oRxVYsv+JZXV0MyQ3hoWeBsqh6BtBvCmo+DeW7nfQd3myjPYV0BgL7ZSsMQMhK2Gy65smwnytGwSo8fJFSI51gKmCpa33/Olnyko7U07/Zj48z2eWYPudWWkmPyr6E4O1wNFX1AbBYOFWhfrs8r5ugS5aI26d3PYa70ag6wUhIDoCoeffMHgQMp+a0v2gsTh+sLj7ETBCELM5D/wSP8zCulKCkHfN1hYwBcTmwwNJbotHVcTmcGXfYO43lxcTT2h2Ts50LuoxlsS/ErsboSP7MKrQLNOW1k9mYOz4RdN8Q//KIOjp+KZtbyDuVO06GV1KTPgtTNX6P+v5HnY7ucZkP/cGNS0VF9iYq0mf3DQl0lya4ztCV2O34xmbtGlVeC5KGFHdjGvVShQyAQdWa9pC4Dmu+PJgbjIQjvgjZpwxJjueXU6L4cK0p8RdwtIWYguiQZ9/X1zoRPmZdK1f2OSW6v1G6XDB8q1raARR/EglRzdqd0aVOItpjPYjMz5n0Zj/Sg
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(36860700001)(83380400001)(47076005)(2616005)(107886003)(1076003)(26005)(336012)(426003)(7636003)(82740400003)(8936002)(5660300002)(2906002)(41300700001)(7696005)(6666004)(70586007)(8676002)(110136005)(7416002)(70206006)(316002)(4326008)(356005)(478600001)(86362001)(36756003)(921011)(4744005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 08:40:58.4417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa60866d-43d8-410c-c29b-08dc1cb8300f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951

Add device tree nodes for Tegra AES and HASH engines.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 3f16595d099c..8a6eae4b4365 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -2304,6 +2304,22 @@
 				 */
 				status = "disabled";
 			};
+
+			crypto@15820000 {
+				compatible = "nvidia,tegra234-se-aes";
+				reg = <0x00 0x15820000 0x00 0x10000>;
+				clocks = <&bpmp TEGRA234_CLK_SE>;
+				iommus = <&smmu_niso1 TEGRA234_SID_SES_SE1>;
+				dma-coherent;
+			};
+
+			crypto@15840000 {
+				compatible = "nvidia,tegra234-se-hash";
+				reg = <0x00 0x15840000 0x00 0x10000>;
+				clocks = <&bpmp TEGRA234_CLK_SE>;
+				iommus = <&smmu_niso1 TEGRA234_SID_SES_SE1>;
+				dma-coherent;
+			};
 		};
 
 		pcie@140a0000 {
-- 
2.17.1


