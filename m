Return-Path: <linux-kernel+bounces-103579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900AC87C15D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454AC282F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622AE74427;
	Thu, 14 Mar 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oyp28NC+"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511A70CCB;
	Thu, 14 Mar 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434171; cv=fail; b=oxs4913jv4ZfYSWeZnzj1fKfmvCOLQCi9C4GIFH44dp8lajNBZ8tmX3syxSoz40YdTndHAZz0Y4u4/sTi3c2lG8e1FZdv82hJZWs3lfcJAUXnzvwGUabvktQ80ftUapjExN5Jdn/9RLcSXm68u0ap66o/HFjAdTNyRot4CTwKqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434171; c=relaxed/simple;
	bh=JGw+B+B+a+NQDc95++I+5KlrS3srAzM+aVMCrVq8FbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOKXxQ5RHTexS6a7O6UkObVRexN/mBowXE6omZp6QmWAoP0Bl0Gy/R8Z+VtLAxod0Jt8UNsHWrC++Rx008cAuqB0FxilbIj9adG1LwLCeeoHsR8X9mWSsibZj+ao4v4heML96bQaJpepoh21vhojO7u/fD/1eJWfVq80Xco2bdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oyp28NC+; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl31H7xhz8rhfM2GJhIM4whc4V9OZW8ACXK3UjW74A5IP76zB1paXtkUtHRhoi+FftdBagLh7IvUb4MLvD0rp83EElyR8Y0hxeS/DDbsaj2RbPn22BdZPv0tPaYq3I2KaW5YVJt6ekTje01KhGqYNTjHuYnXE9/bNj4pyXRm9ZZ8nYXRgpgdBs0ARu82rxBJ5Z1WK+I4gRkxOf1q6WWJfXQOGuBHC+2TpOipeXH9rVkmpEF/coRxLEqYPBramdNtWYWN4EYgKJ5ROP+FIozVoRXjYoGvEcjrDccnSNC1RDypsFZ1L6mAELfvqQmE+ePw8rz9MF6ybrNF2/2myctQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzWK9uW1Y/rIgtjRO5hT5FlfBEUx27JSe/1LrRnpi5A=;
 b=XEKiNRyyZiKSHMlm+QrN+pOgSWjUJw9x30RNRHm8TMLCc58Wwu3Z3vvHRevX4bsQ0ZoVEu3eDyWc6CbgnFuByWFpJSkmbzIUSp+78KHfXRb6BhyBsKK4Eux6n0jVNYVe3Ib8PoDwJYaJT4j7+p6j5pvHSIbuZcp3RaTpe+mM1XGsn+kHDTfJ8KRQk5Q1EoTbb62jFbButR6o/2m6/ED9sJLCDPGWZTaXGr17Vi99K9h/oGVRfahOlykMSpBSjN+hfkujc6MujYtQX5lDmobTK3DmkEEWmq4cNIZPSfuBEGof+9ftsFDvUzVYmcDUvhrf+23rJ1U19Pmb0x9uZSOzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzWK9uW1Y/rIgtjRO5hT5FlfBEUx27JSe/1LrRnpi5A=;
 b=Oyp28NC+y/GYfkFHY3g1WlxtdoBhge+Lj+LbAy59uVA6gMWQu73TM9zCs5B1qd9HobMhxhnaR7BzQHtik26wTh8YfMEWF+0qVDNZVxA12QHiLQ0h7llos8JR9Hv7qusOgS9TbzoraUM8wtJwrDN4I51DUNkmie5tso7CqNXbXNQ=
Received: from CH0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:610:e7::21)
 by LV8PR12MB9272.namprd12.prod.outlook.com (2603:10b6:408:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 16:36:05 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::eb) by CH0PR03CA0226.outlook.office365.com
 (2603:10b6:610:e7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Thu, 14 Mar 2024 16:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 16:36:05 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 11:36:04 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<yazen.ghannam@amd.com>, <muralidhara.mk@amd.com>, John Allen
	<john.allen@amd.com>
Subject: [PATCH 1/4] RAS: ATL: Read DRAM hole base early
Date: Thu, 14 Mar 2024 16:35:24 +0000
Message-ID: <20240314163527.63321-2-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314163527.63321-1-john.allen@amd.com>
References: <20240314163527.63321-1-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|LV8PR12MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: f7124e76-9bd5-4d37-f828-08dc4444d830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xvWqTioXNISHlFNEk05PJWe0OOo81BgIyI/vOZuKKvO9am7GW+dHmrEmLUovVtG5d3B+1S/E7HPexi2sZGweZd9gREQr7oa6gtTiERHl2PkchJbzxXqSzX6nsWMqiFVG8KiozNnCguKZYdOLumWZcvcO0qXvAkDi+DJrJVNAjkVxqUKuX8TGKLlWbA2FSgFBvWcIthWgxdkc91wBrHAEaw2XhOZeJRMnOcuwl1x9cBX8E8tedOpkMr0KYGTQE0fIwtsWEteF6WsXp3SeH2GF2/PwXC7EtB8hNy2EKjWThfs5OCvLEx27PCy94m2URp7ewSPXcLehCBZOdQ00dMEN0U3rbXIyxIUbAPzOSHi2h5/92JrhJ6/sxPUCbitmDyKJOFwGUZhEUZ33a5ZBhe6oAZ/BxnJh/U1rVrTrP9jF9kFZonUsq/tEe0gPDUscObPU+LGAqVcu8GOE4VwN+NcWfhJcvd6yLn2g5QEUnnLijClqW01iVTgUzgsR/Lv5GZKLF/z1DojTrajrWM6JTyjXdwJ9Eegz/E6ddDrmLboj2kpClBrt1/F5bbdiN7OZcvw+aY/23dmlJpgvi8/d1krl9z4qmm3qStxUClcrAFxQfICNcrCqNRkkKnxQQFF+89kunXtlY9sq/pU0n+kj7tCkik3k2d9o140GVCJ81f0pQaPc82mkDGujQkpOC7RUIMgPveNj8lvzICBsM6+9nLNHwMwkIbmqCRyRne5x/QAei71nzo2+vwOU4vWnD2u6IECy
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 16:36:05.4695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7124e76-9bd5-4d37-f828-08dc4444d830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9272

Read DRAM hole base when constructing the address map as the value will
not change during translation.

Signed-off-by: John Allen <john.allen@amd.com>
---
 drivers/ras/amd/atl/core.c     | 15 ++-------------
 drivers/ras/amd/atl/internal.h |  2 ++
 drivers/ras/amd/atl/system.c   | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 6dc4e06305f7..c1710d233adb 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -51,22 +51,11 @@ static bool legacy_hole_en(struct addr_ctx *ctx)
 
 static int add_legacy_hole(struct addr_ctx *ctx)
 {
-	u32 dram_hole_base;
-	u8 func = 0;
-
 	if (!legacy_hole_en(ctx))
 		return 0;
 
-	if (df_cfg.rev >= DF4)
-		func = 7;
-
-	if (df_indirect_read_broadcast(ctx->node_id, func, 0x104, &dram_hole_base))
-		return -EINVAL;
-
-	dram_hole_base &= DF_DRAM_HOLE_BASE_MASK;
-
-	if (ctx->ret_addr >= dram_hole_base)
-		ctx->ret_addr += (BIT_ULL(32) - dram_hole_base);
+	if (ctx->addr >= df_cfg.dram_hole_base)
+		ctx->addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
 
 	return 0;
 }
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 5de69e0bb0f9..1413c8ddc6c5 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -132,6 +132,8 @@ struct df_config {
 	/* Number of DRAM Address maps visible in a Coherent Station. */
 	u8 num_coh_st_maps;
 
+	u32 dram_hole_base;
+
 	/* Global flags to handle special cases. */
 	struct df_flags flags;
 };
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 701349e84942..6f6fe24dec81 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -223,6 +223,21 @@ static int determine_df_rev(void)
 	return -EINVAL;
 }
 
+static int get_dram_hole_base(void)
+{
+	u8 func = 0;
+
+	if (df_cfg.rev >= DF4)
+		func = 7;
+
+	if (df_indirect_read_broadcast(0, func, 0x104, &df_cfg.dram_hole_base))
+		return -EINVAL;
+
+	df_cfg.dram_hole_base &= DF_DRAM_HOLE_BASE_MASK;
+
+	return 0;
+}
+
 static void get_num_maps(void)
 {
 	switch (df_cfg.rev) {
@@ -266,6 +281,7 @@ static void dump_df_cfg(void)
 
 	pr_debug("num_coh_st_maps=%u",			df_cfg.num_coh_st_maps);
 
+	pr_debug("dram_hole_base=%x",			df_cfg.dram_hole_base);
 	pr_debug("flags.legacy_ficaa=%u",		df_cfg.flags.legacy_ficaa);
 	pr_debug("flags.socket_id_shift_quirk=%u",	df_cfg.flags.socket_id_shift_quirk);
 }
@@ -282,6 +298,11 @@ int get_df_system_info(void)
 
 	get_num_maps();
 
+	if (get_dram_hole_base()) {
+		pr_warn("amd_atl: Failed to read DRAM hole base");
+		return -EINVAL;
+	}
+
 	dump_df_cfg();
 
 	return 0;
-- 
2.34.1


