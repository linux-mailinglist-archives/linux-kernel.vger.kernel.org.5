Return-Path: <linux-kernel+bounces-71756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC4B85A9FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C381F22714
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E811E44C98;
	Mon, 19 Feb 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r7JoTCoO"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75847F5F;
	Mon, 19 Feb 2024 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363612; cv=fail; b=cbntYenKRZS3SEBa+Lo67LpB1w8if4P49de7kySr8A2G6m+Zo6+kbiwB5MXmQLfwxHILeYr6Ija9NPwHrpki4F0OmZEGYMrQrdpkZbQ43nARZwxLI/AqmW00ZXzZkmY6SLiqW1pFIZKMXuhp4liybJoku3IY3v3UId4T6yXn7ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363612; c=relaxed/simple;
	bh=ir/ka7ufzwISVyYGS8BXiCBiS+UjuZY0MzJuhI5bhAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7LjP5ZJSPuY9l62mkrqcQH0yudwP5K/S6Gug3CbIxS8YMfw87r5Yk/WKjxU21QR4a6aeUsUT7fgwPxbGOAwUhQ2ZgQdLRS8/uVZ2s0B6zEBFT1wzYswHi0mhmvwgayA24ONuICBSq4gMCIgHemErJP16HvT49U+mMquu65PSWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r7JoTCoO; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZxbqjv+LxMMFcJoJdHODSYSGE9a3Ib8qQUGvQrZSws1c1RzcdKk25fuzez1/nx5opDvVoNsagVOoqhNs/8aSc2aIsEanfmGAP6fcUFRT63wYkcbqgNkINdT+ToaETocxB7iS2+OghWCjUXKFa+qiFAreqnLBJk2dEnCywCpxffo2Sm9SGbBxDMd93iNAZeTePWhmPqOEh2FakyOKiPPnN7oU3jA7/BIL8pN2ZBfPSnA+rgIEvMHHACbxkQMCXusX7PqnEB7SIHlmcKqFHAwXNhwXokp6lgJyu8SEyDF1/VPg5N1GZbQlxvIqO0Eg0xzfzEiPb531jkjMfY24CYHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A96YmSEaULokCB7+8Jx9VadjPtHpWrWMquVvxIxD/84=;
 b=DkVCfaP0sq3SjhpU5kuVzsqxI54V6Tf1N8ey3P4y7SEpBeAhswCJZdnugEtprfkLpPf/nkdt2Y/Qjk17kiPLIg3HEVUCx1oe+M9yODV6vREVpKRYbT53+K4LFIrWpiuLY5m8VIYa59a0ASiBhH1Uv/VR36mR2spW732ievSqK8RK170X3MzK8nAqbRrH7JY1+sf+V+vkQad0k/yJD1ZQBbEMA0Z/iX/mQAkm+cv7+RmrFYtSOuZxUvMP6E3MwY4VBHP15472WSHZ67r5inn1UrNr/Ixjkc5Frirs66vi7zi8jUjt4dPHrndHHWSkKLbL8/Xc0YndJe36cTciHD9j9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A96YmSEaULokCB7+8Jx9VadjPtHpWrWMquVvxIxD/84=;
 b=r7JoTCoOwvkVdD/HW2gnB0PVc7rrilfUBYbOTajHu8jUCNBMdzv3CQEhCA3up7uwxkJzkE3vNiiySLv9i3ODkeB7t51zG6u2+iNPn9BGXHfY7r9uA5Gnux/y6+La1KUUe6B+0G1AzQ1yJoQqwyDyKx35z62DfMFJMjb9JLZ3RBMnPSSFvyVcnBOzDFb3MWJW4PaCj1ixLH3Ipu4pQrzM6JITSLYaG5fuKtH2sWvI5WVF6jNFUMJLOCtTQir2mAzavs3yiSk3aLwpQ/S3OBkqJa1+lx9QM3+2lK+3uVxOZ4qFEsyl9Yz3Po57JhGOwPq+V8hT/NBa0qWm7TsRUexcPQ==
Received: from CYXPR02CA0065.namprd02.prod.outlook.com (2603:10b6:930:cd::9)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 17:26:43 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:cd:cafe::34) by CYXPR02CA0065.outlook.office365.com
 (2603:10b6:930:cd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 17:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 17:26:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 19 Feb
 2024 09:26:23 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 19 Feb
 2024 09:26:22 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 19 Feb 2024 09:26:17 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v5 2/5] gpu: host1x: Add Tegra SE to SID table
Date: Mon, 19 Feb 2024 22:55:27 +0530
Message-ID: <20240219172530.20517-3-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|BN9PR12MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe83933-33e2-455b-5e94-08dc316fef8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z7Vlu88GcYVMUY1ZikOPbt3fw43sKnhhgG/ZL2C4AcTJDSNNKaPiy5y2deZA1E/ftQD4WU/0htl66ren9+pQDTwefGe1ZzfvcLavLNdkPZbJdmLze87j97eeQiG9QFj3DKu4fCY0lr1c7j0+7p5TV4do/kYiDZiO6x8uuuxXLzP+ZtmbhwKkECBVyVn9Ojcc0I+iYyRlrpRjimZTZdy3bJZgEWCp9KGSuHvGneJ3iFhmT8mGRqylqIj9EqqIbaLmLv/uaNV5qrc+pI2WZ6wJF/4M1/ajv1+x9mADrtcDu4X8JuMlerPLF+AEPiJU3Pob4baZlHDldf83Nsx+GCGlHZv/Bk0k8mhT9G/W1AWZmMzhz2PfTxVEn/77ekSxbS4u+9JWQ1C9W1awQTHhrZI2AMtOk+cXo/azn5rJLz3IsrslUS388UiwDxHQoWqvsmvERqDH899IHP8PZek+58kdvPb1b41aReGhOFGoDO0H0dGZM+9c2fGMgeFXxB4vyqSR3U6UvFeQihS01TL6WoaDfgKfZ/b4hBcpD5zLzhJjNbs5kp3MBinTGeF1poinnx9AcUSQfrq4BMFd0a7KIyGGyyqaxWRf8cZuqxedZpEnUSTFAHew7+tL5UHatxDm4UHY6QTgpLJ3boiVINohgszuQcvxf05E5+jq+P5gXKkb8kk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:26:40.7130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe83933-33e2-455b-5e94-08dc316fef8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179

Add Tegra Security Engine details to the SID table in host1x driver.
These entries are required to be in place to configure the stream ID
for SE. Register writes to stream ID registers fail otherwise.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 42fd504abbcd..b564c7042235 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -214,6 +214,30 @@ static const struct host1x_info host1x07_info = {
  * and firmware stream ID in the MMIO path table.
  */
 static const struct host1x_sid_entry tegra234_sid_table[] = {
+	{
+		/* SE2 MMIO */
+		.base = 0x1658,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE4 MMIO */
+		.base = 0x1660,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE2 channel */
+		.base = 0x1738,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE4 channel */
+		.base = 0x1740,
+		.offset = 0x90,
+		.limit = 0x90
+	},
 	{
 		/* VIC channel */
 		.base = 0x17b8,
-- 
2.17.1


