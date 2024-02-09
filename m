Return-Path: <linux-kernel+bounces-59121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC5284F184
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F29A1C221E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8578967735;
	Fri,  9 Feb 2024 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ys4FPkRf"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB06F664AF;
	Fri,  9 Feb 2024 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468043; cv=fail; b=sMFo+FffWy7UJ2qTxChNz4TiBQMEQ6YYNzp7P4w+mL0i+SlXe3hE6ivhtpo1qxy2PK6VMVQkmpz+YuQGTOSD7YEEXeYsJd0JjKW8bQlnzd+8FAP8fnv7jUJv0stcbMSOKZOluRfDWDwlWAVAoPiGYgf8AXT2+h/jMIN/xMU5qzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468043; c=relaxed/simple;
	bh=AJ62I58qI5mfqqgdroIvrS3CHWUodvRfFiWOQuQOAvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cx5R5CTw6hN43dhHNc8cxsXNU2vmFwpSlhjvyucS/G7392wsVEmfoVQI+pCXvMbtQ5X2dftZxsuyqZKqSM1jkLltUX6ZdhurBM3ST+meE+42IjDrdbfSkNSIEO6QrWYmc6uU9D7MW9I1yybuj62gcngTEkGcfd8bg3IywyVvWcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ys4FPkRf; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFhUp0CrxfkRFjMz3wNJ1wSknXryK6HmhmqtSWNHZX9KWHJsklVkv4/PFf65iPbHDoCVmc/Uhgz5Vepl+8FfhSFZKSYIlmoSM2dctl8sy2IrsM39gDk7LabD/2aU44bB0+AsVA3M4H3dZwNEjr7BtsVLA7exYhjDLsVkOabfdZb6xHZmkdP6lJo0ApDP8rSKlRc0KrUNqR2PcG7jOESMrvUBVHBT7eNa5SP6auNsuX1bJgd9zhktZW6p6CcnQyVUvaoBL5Y2fU1yAFax1qD5HLfOIWePGX/i26nQ41ghTm7S2ha+sBAKOOxQ9N+CHiOW9HEXWRGW7NY2ZToOzPnS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJJEpo6/ZROJHbJTLawterEZ5OhsQAaRnNa93pxuNC4=;
 b=XKdw49OS+P1EJCgEwewLfQgGW08aioYjkLvPHB3DP4MgcUtpPM8+h3UJ/HSvZe4iDPddydEJ2Sg6NdCsAQqnzv3iiBhqValRHxq3yq68XY/GqFJYlxXhFfa/oJ2k2XzpnyStcR6JwiOn7AH0/97qEvkL1FJU0PSfAjImhcmOL93hlLTn5muTonHtthQKna+tBj3gUtvQyDnwPieGMPuwgn8IKrhBBH2lg3ugXGek8B8hkRbAE+ZsseSqpFQ76uT9EFJwTu0aUroUqUSB+SwXY0zPFdli9Tp1Yf0sELtdsrSX91sSHJ/nsaMGJeqrfPT9i84K0oji7os4fIfRywwrdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJJEpo6/ZROJHbJTLawterEZ5OhsQAaRnNa93pxuNC4=;
 b=Ys4FPkRfWsRVrDrEgWio04MxdMGM5/kU8TiTOCRCplnC/uo9IwWKIM3ZWL9PexVKx9Z55IWKkRU4krMO9dr7H68wy3oBAE3h47Qb+nXyG02MOvsLNpisqfTzr4LSeSi3GekVGulULtIjVSLl2f+FqJQGC0iKQfWTXqMztEhNSjgcHtmC87czfGye93R9tJBnxvhaOBXhf/LHqKbOfoz/4HQRE6QALnfRgFjnJ1jBDoYUXSEBe11q+xHEvGNUgjC43akoE98DCMaIhjFm2qd+kEpLx3ZFvEghSj2HPeztkcgjqsHP9Tdd6RSzmFUkr/NDDhpSt266ph1idOt+MX2Viw==
Received: from SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.14; Fri, 9 Feb 2024 08:40:39 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:f2:cafe::d5) by SN7PR04CA0014.outlook.office365.com
 (2603:10b6:806:f2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44 via Frontend
 Transport; Fri, 9 Feb 2024 08:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 08:40:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 9 Feb 2024
 00:40:19 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 9 Feb 2024 00:40:18 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 9 Feb 2024 00:40:17 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] platform/mellanox: mlxbf-pmc: Add support for clock_measure performance block
Date: Fri, 9 Feb 2024 03:39:57 -0500
Message-ID: <891f85f39028753c8282436dc4d1efb2cb55eead.1707466888.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1707466888.git.shravankr@nvidia.com>
References: <cover.1707466888.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d28f74b-6625-49e1-2ff2-08dc294acaee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0P87XwFYfHFBNbnNhynYuAdPBk1wK4kbL7DjXVeqXbTV9IkMvhTwS6jAAjudu11PhzU1Kdk7nlmeCSl9l25l6RcF07YWc/dFZtejrh0gR/Bh+VIsiN3EAyWOMx2bgY+qmzgSgsFAAGwWmEcuKB8xnYsH4DQnLcs4NjZ+Yo65Z3qvY/Y7EgDqFRlNK+oBE4uCyR06meD8XqdGs1wOAa5cbsFec6aBSSPLwhdP+DhjwjgunT/ST0EcUVgjC4EsfLiGrA5oHi9PbBsRfWnVnCrHiX3Vwr9bH1F5ZLQBYe+4nHY0W0XUSx4Od+iJoiHrqvbuCkGK4qIqXXCdPwDogWF3FztG3EjIjDFABYHByTXRX65ocrS5uft8oNLTwg+4ZtZa7a9CZ9908xHr4q/XtuJpDiirjXqUcln8GfKWoKkzH6YJ8orE23Zu5PKNcG1AhYPyrC+9Vo3oYsJXs7OrV5ADL+gfMYjYg86y9f66l0d/ukc9Jy+LecH9oMDl7TUnNIZt92dI0PIydC/JpfyVSo7DgIZjBs0p6PqnXpWaL61wI5ZNUlxpcnLUDpYHHGCPJVkbBXpASRRsEX+yYelj+tkWfHMo9W/+dFMwRpkLXKaoJGs=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(82740400003)(7636003)(2616005)(83380400001)(2906002)(316002)(8936002)(6666004)(5660300002)(110136005)(7696005)(426003)(8676002)(336012)(4326008)(70586007)(70206006)(54906003)(6636002)(356005)(478600001)(26005)(36756003)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 08:40:38.7287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d28f74b-6625-49e1-2ff2-08dc294acaee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485

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
index 1b9356a3ffab..565951c69a0f 100644
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
@@ -1041,6 +1072,9 @@ static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk,
 	} else if (strstr(blk, "llt")) {
 		events = mlxbf_pmc_llt_events;
 		*size = ARRAY_SIZE(mlxbf_pmc_llt_events);
+	} else if (strstr(blk, "clock_measure")) {
+		events = mlxbf_pmc_clock_events;
+		*size = ARRAY_SIZE(mlxbf_pmc_clock_events);
 	} else {
 		events = NULL;
 		*size = 0;
@@ -1474,14 +1508,15 @@ static int mlxbf_pmc_read_event(unsigned int blk_num, u32 cnt_num, bool is_l3,
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
 
@@ -1495,6 +1530,9 @@ static int mlxbf_pmc_read_reg(unsigned int blk_num, u32 offset, u64 *result)
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


