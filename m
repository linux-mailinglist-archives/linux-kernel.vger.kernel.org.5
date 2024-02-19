Return-Path: <linux-kernel+bounces-71759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE685AA06
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4BA3B26CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3D44B5BF;
	Mon, 19 Feb 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e0u8lj7l"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3245BF8;
	Mon, 19 Feb 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363654; cv=fail; b=bE9hm29xlJbsadXCiUhv/vbiU+IPsOUCbvC3A5QxNyFqQSUDpZ1+Qj8fKucByMZq3BT180pRWmUnh8jKq/7OJjvPQCXnAsGh6E1eMpiquDH6e0QWuCIHQ6UkDgyisa/RhASrdWvFp2id4lbC2Jo3dM3gX92fIwTWqukmoduiFb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363654; c=relaxed/simple;
	bh=z9zfd3hCvkBPuIqLElSnOQmtQS967qMceaEVpdvQ9g4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQ+77kSWJfzGykjhsou5l/Qi7yVtg/HGtVceJF4DLAyCt2m0EqojL3dcyem/PNplN7HhtqV/sXNOs+uxARzaCEdM3r/AgsYk13mwh84b2CTLGwoFLe5IcKlvf7bRTJtrIgmSyq0uN1ndbJFpkoitrPtJejFnnNWTAHKsWjcDMkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e0u8lj7l; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ackOkx/Xmm9OYAnBUB6E0MBxyZQaqxoJjvelty7tiMhUtXW82Wjqr/TMOIKjN+GZofVA8qcl7T6tmeq9r/qsfMiSQkDhv/YJH2IIrXhzHDuXjpRUdRQo7HvWfEHiPeqVsWyEb00xh/1TEFGFmjH7Xtb0dF2fsd5mmwHugp7HC0j55yeWK1GquEd20i4YyijoiWjYWBUPMw/xA8sEVK3DnN5xCvCMnnRiLrEEGxE4KYZXVJvZUyTrmBiIlU9PPy4H07iJ5FyNu0CkLF3svjyk4rAtFp6YMD617CHV07xq1+tBWaGWUfrVORdgLbjCxu10ql2+to/6Q3C9SzErr/UXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiS+3cxGGsyqrzkAiW11fANnNIB8Z0ZRBY8GWobuG4Q=;
 b=TsiRxjiCMTI6fx/u854jlkCKaMRbplUhdIx3br/E7q+5/3rJIvb5LGm5I8BV8pHFTgoDM1opWb6C2ocNocAn9V9nPwhBNOUBeskXpMWs8KHJWPFOSLjGiP8kJm+zqknboiUR2WG5ZGJFmvlHnNbcM+c/2cYjKy1qGnItAyVnHgkLzX3IEy2xTo1igWXWE0izSkZjEniANS4wCcRXpXLfgUWy4POqiMMCTxh4Y6SliRg1ihUxRKNUmR5aNDoDJDx+6NTGogqJ6qPDtLpKRqwr5Nly3ExdzjvTyvLxAUriHLINFispeWwnNDuPpsLsNYzLNFb2uQB6PHYgJTM4NbTNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiS+3cxGGsyqrzkAiW11fANnNIB8Z0ZRBY8GWobuG4Q=;
 b=e0u8lj7lytfCuijKtjAippqTbM6+BmaxWzmMUsnkdwrvC8d8Hq3Zy221psJd4A5TG/VXlu2LERaXuMtH0ur1VVMy9rTBNZcKEG3zftrJrTEDQfKdTmN/AdkDsyWHEDljwhz7MPkb+yy6UvDvpGqdkMSXO0/rDfU/iJB5kK/z8kGY0eOJAcb/PMPCPZVgC8rV576nZvruSrxm5O6enJLE8jECRnnI6gBfi7AMTpRefCKsRoXXV5rxm+lhbOv97KsrhWsiVWZqrUplc0ibl8Asq99P7OKWRG7C9MatI7ZEqnEzBZ2Ehc507E/hMCED4NsNWtEoDIvVAJOJqAxLUCnm3g==
Received: from CYZPR20CA0023.namprd20.prod.outlook.com (2603:10b6:930:a2::27)
 by PH7PR12MB9254.namprd12.prod.outlook.com (2603:10b6:510:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 17:27:29 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::91) by CYZPR20CA0023.outlook.office365.com
 (2603:10b6:930:a2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 17:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 17:27:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 19 Feb
 2024 09:27:11 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 19 Feb
 2024 09:27:10 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 19 Feb 2024 09:27:06 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v5 5/5] arm64: tegra: Add Tegra Security Engine DT nodes
Date: Mon, 19 Feb 2024 22:55:30 +0530
Message-ID: <20240219172530.20517-6-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240219172530.20517-1-akhilrajeev@nvidia.com>
References: <20240219172530.20517-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH7PR12MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e538012-003c-429c-3eb4-08dc31700bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JYiSfhZjYIZKyCaMqS417qCTCF6KMNgWJJnRZUkr5BoFQFEtqd77pLikiwWgk4rVaRQeNQ+14gMi8WNm8BgA3SCWwuW1Sg6qqZePHnwnHc1l3EFBACE3KElbJTkAZghAoGkfRaUB60u4NH+9jT3HrYWoYNEhtWYuyFQEC2O9YMA7qcNZtlNKcrSatdUgoyzAaYrNrzBJy80nsX4IGnp96pXO/VI+8XsMDr93cRzqoyJuAb9qMT2S1Ms/lCrw3nnc3dZMwURKUCnxSiavdUwzUPAhPnZ9zHVSDkIJ9T1wOsiih2/Jvc101NAqX0TaUO+wOBwdmQSXlo2A1LutW+fdCnKoAiBQBMlu2mhX6ddxKcAUTIjD8eWuU01GuaBuiW/9SPX3SpT0zQpS4hUDvO7UprdObTSHzuXD9OZhkKE6hggi/N1A5I9++9VW9JpDRTwJFz1OYqRW8OparoCz4QXMOKdFcaNUCHp4TVVRabYUkoyZf7oczZh73+8YO87DARSKPXg5L28N0v9kY/u1psPe/XgRuQ4LYsN1QkcEtNo52xnNwHJDTeyFdK1FOTLRaD9hyakudlP6Z5APnKodljoehZxJU1xna5hPxSLq3ZAb2S1qQHdQugyU2D59TQzqRqlpdDKzK647Mav7JCobPBTCRFd76DzFFTb8IE7U10wyjfg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:27:28.0368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e538012-003c-429c-3eb4-08dc31700bb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254

Add device tree nodes for Tegra AES and HASH engines.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 3f16595d099c..0941a2c95ece 100644
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
+				iommus = <&smmu_niso1 TEGRA234_SID_SES_SE2>;
+				dma-coherent;
+			};
 		};
 
 		pcie@140a0000 {
-- 
2.17.1


