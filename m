Return-Path: <linux-kernel+bounces-5225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751C7818830
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0D16B255CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48B61BDDB;
	Tue, 19 Dec 2023 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qYOoeH9K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBCB19471;
	Tue, 19 Dec 2023 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSiTn+RyHG6H+XEOR8mZZri/ix9orsR5wvE8+XIGehQNZ2B5JPtFczlYDNIKyT5+Yu5RBEHMoCLT0Z8aH1FgRkxD+z+dYU5QAGxl+HzoFTxE/fiLDs6yn3dLzeycKgkfdVEt//uCLSRXCYOGlHfEyOiIC1/Lc+C+i1dHxMA4hy1fZBH0OgoQR/cS9O9UyZYC+s/yuStMqo79WBTlZ4AvkWW4sWlNkulTq6PewxyLj986EQhmPqR72FZuxQBBfRh15shwUWsSdnRgZj+Kg0fR/TnGrpSoiYYoY98XE4pvC2oyADFsX4O6h8ZlY5hFEX10RHia0X+3XkuLP/WblkGn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eMMog2MnMnqsmecZf7t0U1qGTG82j1sYnMIXXptBr0=;
 b=jbhQC2X9tYwxDuobVf2wZT28sk5Y8v5JOTiEO4pNIG+Ty+0P/HSilE6zYoNWIERDoiZpBKO2SYpKP8RHvNcaMTe9A/J1Xx+yQ8Xyp/xEC+G4Q2thBw/p8OqXr4bz67vR/EijmDO9UQvtkKYgiKj6eg1flGTC8xJ/WQZTgSRw3VFnRwct38n2j5FsGJKIva+prSyL9VRt3Twj1860mJ8Ys+dhLyS0+sqGlwq9lYlyTl5/SW2y3J+43I/DQ8FJutbIjFZIjkOWUAZEXOxalACcFg2bFGnHqh8X+UR4taQOc5pIhlWI7P0VqVprikYZbMsaMK97M+Hmnx5xgr2kLw0KjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eMMog2MnMnqsmecZf7t0U1qGTG82j1sYnMIXXptBr0=;
 b=qYOoeH9KDVu1xlDquG2DJmQIEsasltvQxZtaFiAdnuFoSL/+OvBgTg55DNBUSHn/lcSac9OFCs4bR0Zn1sw5bryL8UwQ92/n3mv0XOeOUoRqwfBR0VUr+aA00S8X4HlNhvG+SC4PFfgb2q1S6x+6LXUt67RQWtbl/0eQq1OVp3Co/trYMFa6tTrHbQ2TmQ2UHK37jWl2mDM1yQBT0W/AZH/8Yb4lIiwfmqa1WjUnzFHJwrsrWIBonHruiQt8+36ULm4HlX7kb5skxFA04ePQGtwjR50pCXiC/YSwVtjQY3dt5ZfVeyiYzM4z2QBTQn4abUcN8Dywwd7D31vbj1IZFw==
Received: from DM6PR13CA0065.namprd13.prod.outlook.com (2603:10b6:5:134::42)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 12:57:29 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::ea) by DM6PR13CA0065.outlook.office365.com
 (2603:10b6:5:134::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.17 via Frontend
 Transport; Tue, 19 Dec 2023 12:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 12:57:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 04:57:26 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Dec 2023 04:57:25 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 04:57:21 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 5/5] arm64: tegra: Add Tegra Security Engine DT nodes
Date: Tue, 19 Dec 2023 18:26:14 +0530
Message-ID: <20231219125614.33062-6-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231219125614.33062-1-akhilrajeev@nvidia.com>
References: <20231219125614.33062-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: d64ae501-3c42-48bf-e6c3-08dc00920e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7dsZq70+ue2hhlBYqISThbkXayLrIRkRzi2hLOykT9rphIyiIPQLsbWkxoW3l+mPx68BeW7DDrX52jtjyr82l6yohFXESbKyWCXTUDbOKr+FDMXuTOWrTaRzzDBIiCbOYzH5A/KVeDSoIVNf5n0h7OP+qD/MeBSySkUGKB2+JHvFhk2iD3M1HPjJsMcCdhcTHRKTngOqO4Kw5G2eetAFVHtAqrXXDZl068lYUHIxDKa3bGiUhyPaKsLRY2MldRvbXw+Ufs0xs/W6SbCwCyRigqpF/86g2PV9OZVVUC2l8tEWgkeaUpsINvEM6hTR2VpL5n2TKpXaPcjeOI2sJoBZBYH1qaOCTVD4sW/GaSWHiYELGpEFr/SOsT9UnSqTLGgq6NgHL5/u/qHOdYYi1w8x4bdYFxIKSeU+vcva1Mj+RDZ8uFiYN9aIuWJ7VlM8AMQmLwneXWqdCgqmQVGuS9V0XdVexDdobExx1i4crGL4jJWU2vtRfRdgh3RbQ7pdaOiOXxYqNaocLYFL0pVurRX8dmtNyETt7bgK/v/DjMSgNqi3SyPrOn8vkrb+A9yNo/Ore4IAS1pzbgcMAd7PXRypi/WvmjyfS/dEj8WUDW/jZCdCJM6Jyn3zIg7ZYHzB5UjT/zHeH1gXptUYN1XqAonSOzxs9taqXV4hYlXUFw8W/aH34ge9mQsSAGoHL6BBC7gBeA3M0hP51s93r/ei2GSzG/YhxsadYEynvDzO50iGZcrOA0yBijadZod8cPxZQNl/
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(107886003)(1076003)(2616005)(426003)(336012)(26005)(40460700003)(82740400003)(86362001)(921008)(36756003)(7636003)(47076005)(83380400001)(5660300002)(7696005)(356005)(8936002)(36860700001)(2906002)(8676002)(70206006)(316002)(70586007)(4326008)(110136005)(6666004)(41300700001)(4744005)(7416002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:57:28.5065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d64ae501-3c42-48bf-e6c3-08dc00920e5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

Add device tree nodes for Tegra AES and HASH engines.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 3f16595d099c..05da74d1c2f4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -2304,6 +2304,22 @@
 				 */
 				status = "disabled";
 			};
+
+			crypto@15820000 {
+				compatible = "nvidia,tegra234-se2-aes";
+				reg = <0x00 0x15820000 0x00 0x10000>;
+				clocks = <&bpmp TEGRA234_CLK_SE>;
+				iommus = <&smmu_niso1 TEGRA234_SID_SES_SE1>;
+				dma-coherent;
+			};
+
+			crypto@15840000 {
+				compatible = "nvidia,tegra234-se4-hash";
+				reg = <0x00 0x15840000 0x00 0x10000>;
+				clocks = <&bpmp TEGRA234_CLK_SE>;
+				iommus = <&smmu_niso1 TEGRA234_SID_SES_SE1>;
+				dma-coherent;
+			};
 		};
 
 		pcie@140a0000 {
-- 
2.17.1


