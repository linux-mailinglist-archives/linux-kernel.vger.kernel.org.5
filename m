Return-Path: <linux-kernel+bounces-148049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9238A7D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA913283017
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203847173B;
	Wed, 17 Apr 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="slKsXDks"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BCB6F060;
	Wed, 17 Apr 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339054; cv=fail; b=S72H+pSES/aA0T5nYOIO13u1iukDT+EhRBkVSx3g1oUS1TEQxHep9O6Zi4lD14ou+s6y0If2IUgEiH6M+MFDgWgKW0pEVuM1Yle72kxSAjpAO2NGkUoi+oFkTE6NbdScLZuRFZdersOyeZfuAuXtOEpEySZemkebOpT0B4dq8vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339054; c=relaxed/simple;
	bh=tu+l9oOPO1ViZIzn530t9nkb4u6RJMZaMufBUT+0eg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+uH+rZQabvVjelTrlqUUpiMdieoktAKueT+HwqQrG39ZbzrSVVEPBw9aeH4mgsQGuwZkjPz2ZcHHFlrYtVDeZXAKrBY9tBxrENg5OWPzXq6VX4V5jOp2u3BtcxoSLxw1asYNokLKEKku1l6Q3GI08nxS0dJzt1X1Wd/XPyUU/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=slKsXDks; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZ0RmCyqLPPl0alBIxttZHNTUsNTYlsDo4RRGstFut5ceyOH+vlG93hAwGGVdUI0517+AxIndYGeBsyli7UFLsAEOiMVgQQmLVAbH6drd+4EI+Lm+T1WgFREZasGC9wFOeG0mfF5SLFWATWLweAqUIfsUPYShEfj/6BUXOs7qpbxbfRKt3uR5rLnWf/ViwXduPVC7jsuJtgNvV0bphNBj3Bn95AGCGbdmgze5u4prITzVOKDiKP8P1Nfm7RZkH93HEa1Us6guwiAP6m1iiOwRv0/JwUH3EFTmKg3zxWSW+z9QHI1g+x2AhU4QbQr+qCDdAcJxf8m1h0mrZ4qNJiQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3G9hGj4HQSEaeMOnQ/xjz2Mzid1MG0kFCIbFwKAaOo=;
 b=b5/8QvHRUmeQKlIoQ0zCi9CE8Ri+Zx8PFHdeXKuz6HG3du29T1QCiByd3LyaLxBYzJlE7fIqnyIyUTHFP4+P6FzBEatPl5b/39kBUxW88k5hlwAW3UP/VH+kgaIGKOODaVwnfXEo/gmCQWe94qcd1M6j1zY7rxgqlVZyg9G38B+qGR86Frq4GVm+jOkqnjGlkcsep+n//m8twFVTbpaj3ADyP8p8o+E5QDpbe2w6+l7qPHtlbiBjXsQb2RSdiHHqYki1V68PCFxRxtlXrI3/n5ld3qmiswcZleHDcyoFDcg5Vge6fTblToxYWXu4TI6o0XzVPdGep5UlCkCyqRdH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3G9hGj4HQSEaeMOnQ/xjz2Mzid1MG0kFCIbFwKAaOo=;
 b=slKsXDks5XFXeH3NJ8cliL/Df828RqpvxaDCUcyQ2qOW+OM6jmfW1dZVbwzePichOCwAzNz/jGUn3yfxHSuAOipeTUQU0N3fVwLLe5NaQc6E7C7S+HX87uXzLz6QNB8b0mpVPk0J4QrLgCVkpyw0cSBPwlhWPDs6vx0+svXTkUlzC469hAsHx7pKYkloOQDtMAc8UI4QKDVNTS7JvmjroHEGOlHIpEkYUwo/ybqNv5C66GKE0gsZwbAinmY7RHQoDXz5Wi0bNremJ4AsEwxGi9U+0Fmt+7B0z+gv+RC+YqqkdH5h0yfsxVbIEnyZ18KoENAE7d+8FTYPg3Ijukq7jQ==
Received: from DS7PR03CA0058.namprd03.prod.outlook.com (2603:10b6:5:3b5::33)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 07:30:49 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::24) by DS7PR03CA0058.outlook.office365.com
 (2603:10b6:5:3b5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Wed, 17 Apr 2024 07:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 07:30:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Apr
 2024 00:30:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 17 Apr 2024 00:30:36 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 17 Apr 2024 00:30:35 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/3] platform/mellanox: mlxbf-pmc: Add support for clock_measure performance block
Date: Wed, 17 Apr 2024 03:30:18 -0400
Message-ID: <433fac1cffd9128a10eb2eff85b11ff671c9962f.1713334019.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1713334019.git.shravankr@nvidia.com>
References: <cover.1713334019.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: d10587c7-e00c-4726-a5b3-08dc5eb04ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IOIZZqPIvp62lWYZH+XfxPWiU7PXmAyxHt8hneLwG9TJG7ivqCWtbZul8ZiLwWhj6mLU2mxC0DrYg1/9hpyCwyv7kyjFjQWs5ATOr8VuQncgrDmiYxC90UKmdWo19x+4ZwbdYj4pQuP5CBuF7vWL/kFDEL26YFKb0Z03LxZDTWXri+A5I7ElxgEesDkifi4AZUaewcVmmQ/CkKwBa5Erjin/mDh3XUmESO9pFEoPXsvuwHZVsmaiC/aUZXAesTVGu40iK1fIL8m8uxRzMwg7Zlh7SPOVAWQHmkznsvFR3j2p0ExoN2QrqQ3cNPuwvy36rc7bTKIOPM1YrolQDj5Ahhgrk/MMMvYllfA2wFV1PwTF73Kng29GoRetqRkBNmpSThm4C0ZvQUBKj8KhBwTIcDpgC3xKhzQLAK9YNspgaDCvOHjnV2ez0xoSkfiPe5hdA1qxlcwt6bvjdY1qRCvDHrB2aVknkWuyAPK9DCi30jao97xX+YX3mXUfS3RCWVP8FN44FLKw2MyIlxKRzE4u9dkmLOqS4Zyj6y/BFW2sZv8mPFQ6H0/W8FUFQwFOUgrYC2lXIdorkHVJL/FK/jxhNqQJ3FMCDkmL6whpeQiqAT87wyUAUPdh4HYrA/hIZ15A8jFo6z4NGO2vpPc/g2eq+tVC1n9ErHHJ1Iii25tpYb4nYv8wr2DsFIZXAHuLhPy1mRy/+2U5/8rLn2CqWOCShwaJwaTIi21XUu1qRu8fpMP3wWpkHQF2PNXgsNcHlweU
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 07:30:49.3036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d10587c7-e00c-4726-a5b3-08dc5eb04ded
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190

The HW clock_measure counter info is passed to the driver from ACPI.
Create a new sub-directory for clock_measure events and provide
read access to the user. Writes are blocked since the fields are RO.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 46 ++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 635ecc3b3845..1212a96fb3eb 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -865,6 +865,37 @@ static const struct mlxbf_pmc_events mlxbf_pmc_llt_miss_events[] = {
 	{75, "HISTOGRAM_HISTOGRAM_BIN9"},
 };
 
+static const struct mlxbf_pmc_events mlxbf_pmc_clock_events[] = {
+	{ 0x0, "FMON_CLK_LAST_COUNT_PLL_D1_INST0" },
+	{ 0x4, "REFERENCE_WINDOW_WIDTH_PLL_D1_INST0" },
+	{ 0x8, "FMON_CLK_LAST_COUNT_PLL_D1_INST1" },
+	{ 0xc, "REFERENCE_WINDOW_WIDTH_PLL_D1_INST1" },
+	{ 0x10, "FMON_CLK_LAST_COUNT_PLL_G1" },
+	{ 0x14, "REFERENCE_WINDOW_WIDTH_PLL_G1" },
+	{ 0x18, "FMON_CLK_LAST_COUNT_PLL_W1" },
+	{ 0x1c, "REFERENCE_WINDOW_WIDTH_PLL_W1" },
+	{ 0x20, "FMON_CLK_LAST_COUNT_PLL_T1" },
+	{ 0x24, "REFERENCE_WINDOW_WIDTH_PLL_T1" },
+	{ 0x28, "FMON_CLK_LAST_COUNT_PLL_A0" },
+	{ 0x2c, "REFERENCE_WINDOW_WIDTH_PLL_A0" },
+	{ 0x30, "FMON_CLK_LAST_COUNT_PLL_C0" },
+	{ 0x34, "REFERENCE_WINDOW_WIDTH_PLL_C0" },
+	{ 0x38, "FMON_CLK_LAST_COUNT_PLL_N1" },
+	{ 0x3c, "REFERENCE_WINDOW_WIDTH_PLL_N1" },
+	{ 0x40, "FMON_CLK_LAST_COUNT_PLL_I1" },
+	{ 0x44, "REFERENCE_WINDOW_WIDTH_PLL_I1" },
+	{ 0x48, "FMON_CLK_LAST_COUNT_PLL_R1" },
+	{ 0x4c, "REFERENCE_WINDOW_WIDTH_PLL_R1" },
+	{ 0x50, "FMON_CLK_LAST_COUNT_PLL_P1" },
+	{ 0x54, "REFERENCE_WINDOW_WIDTH_PLL_P1" },
+	{ 0x58, "FMON_CLK_LAST_COUNT_REF_100_INST0" },
+	{ 0x5c, "REFERENCE_WINDOW_WIDTH_REF_100_INST0" },
+	{ 0x60, "FMON_CLK_LAST_COUNT_REF_100_INST1" },
+	{ 0x64, "REFERENCE_WINDOW_WIDTH_REF_100_INST1" },
+	{ 0x68, "FMON_CLK_LAST_COUNT_REF_156" },
+	{ 0x6c, "REFERENCE_WINDOW_WIDTH_REF_156" },
+};
+
 static struct mlxbf_pmc_context *pmc;
 
 /* UUID used to probe ATF service. */
@@ -1038,6 +1069,9 @@ static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk, size
 	} else if (strstr(blk, "llt")) {
 		events = mlxbf_pmc_llt_events;
 		size = ARRAY_SIZE(mlxbf_pmc_llt_events);
+	} else if (strstr(blk, "clock_measure")) {
+		events = mlxbf_pmc_clock_events;
+		size = ARRAY_SIZE(mlxbf_pmc_clock_events);
 	} else {
 		events = NULL;
 		size = 0;
@@ -1472,14 +1506,15 @@ static int mlxbf_pmc_read_event(unsigned int blk_num, u32 cnt_num, bool is_l3, u
 /* Method to read a register */
 static int mlxbf_pmc_read_reg(unsigned int blk_num, u32 offset, u64 *result)
 {
-	u32 ecc_out;
+	u32 reg;
 
-	if (strstr(pmc->block_name[blk_num], "ecc")) {
+	if ((strstr(pmc->block_name[blk_num], "ecc")) ||
+	    (strstr(pmc->block_name[blk_num], "clock_measure"))) {
 		if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base + offset,
-				    &ecc_out))
+				    &reg))
 			return -EFAULT;
 
-		*result = ecc_out;
+		*result = reg;
 		return 0;
 	}
 
@@ -1493,6 +1528,9 @@ static int mlxbf_pmc_read_reg(unsigned int blk_num, u32 offset, u64 *result)
 /* Method to write to a register */
 static int mlxbf_pmc_write_reg(unsigned int blk_num, u32 offset, u64 data)
 {
+	if (strstr(pmc->block_name[blk_num], "clock_measure"))
+		return -EINVAL;
+
 	if (strstr(pmc->block_name[blk_num], "ecc")) {
 		return mlxbf_pmc_write(pmc->block[blk_num].mmio_base + offset,
 				       MLXBF_PMC_WRITE_REG_32, data);
-- 
2.30.1


