Return-Path: <linux-kernel+bounces-103580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931A987C160
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E491C20EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0E9745C4;
	Thu, 14 Mar 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EbQNrW/v"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0A74431;
	Thu, 14 Mar 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434179; cv=fail; b=Wxq+pQg10t15n9VR0RjOGlogly8hu5XbvefzB8SOo99EyT2PAmlLBZe8IFcVwg04Ya6GxqDcYxvhHXQh5Y8blE+xzoAk9a0NRtI59hHSMrPEUYp4vjeDTLYHn7297gEumfbkmI3tv1cxZKn9rDR0PkLSNG7it+gx+rrhipH4p90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434179; c=relaxed/simple;
	bh=kFVZLTkjeaKGZ4/AJqyDyJ5CY6i5qhZETETG80yL1pM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bo9+Xv+TmGDeWIl6jVrwV4aj5qQ+NXYoZAVva894mmTpBKnYEbExn3BhApzD3oY+sPSwrGXgEbfONmFMQPjKVbShRBqf/aubMRwgb5l3DvLghs5vNyWouo0TJMOIWXNdiecAiYN8/rGzsoMasaLCtDdQ3EFXgSlUXJzBSHtUJCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EbQNrW/v; arc=fail smtp.client-ip=40.107.100.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3juoocdkM4gr2pkj+Jd7atFoZ6IH+G9CukHmB71bqZzxqnVfodKAVVuqO0xdv5x8rFbNeQFcU43AsvbUXm5X2mb+mazwlbyCMEVFXR5dvbM+rnYV1dNGE5+9Sg7QyMAGhcwxRnL3UC8SYHzr0YZCGCMOMdssLTp1pkIyLRVdv75BXIsS6ybd3bQ2IImPmUplFwoeN++SI3dqvMQOfZgZeFMUSDdH2uYgOTFOo4/C8+2TtgoDZZgfb702Krp5ZWoQ1WR0C/455vAzAMMhdUsLP1aLEAAKBXULb3PSbDREjOiVs+LfD7gLGs1mksXHxtDPxaUPyt0aXYZGyxy04RUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9tos26d//B80CeKPRcDsnnu705GDSi9a6KVhmLZG6A=;
 b=a56Ix3CfeNrMWiB4mDj8EfDx+cEwy4PjF7wq4wL8gcYlk+RZw8DHE4YcNDcxSVo0UWshVASDNCFYLth/aQa7InJ48MEE2IASMQUYjbOtyRuhJsCMfdHQYMuk6OmxMR2P832EnxUgTr4AM1d297nXGaeFiXOtALDazpyrck+3TUfXWWAJSGI0ikxD6Fui+B90Cb+5V2/jKsr3Qkr68d2ailbGYM+dMXbLPEaYoCOOI5ivsNL3e8ODotqw6RuLRTEdkpu2CXJEcX7KOnjbTFZ4y3MTazcfviHw8PkaUuqwJ2rTnjrDeFit2k23c7+XJJp2nMPRMuipo2F94zJni5zxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9tos26d//B80CeKPRcDsnnu705GDSi9a6KVhmLZG6A=;
 b=EbQNrW/vArhKSZNiNhlTELx7HgFfT+d8VA4PmpnbgglZE/pSqM/J2QzcY8EU4vzhE/OzhuKdA2FZOxxjpdGoSGIY3d5DeOHOq9/YfPrmzUc+98AKJrt2uejgmq8Vd0DmREDwncNzpwQrDs/a7rqWkOZMuI595YFJExmy1KFHDkc=
Received: from CH0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:610:e6::20)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 16:36:11 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::38) by CH0PR03CA0285.outlook.office365.com
 (2603:10b6:610:e6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.35 via Frontend
 Transport; Thu, 14 Mar 2024 16:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 16:36:11 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 11:36:10 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<yazen.ghannam@amd.com>, <muralidhara.mk@amd.com>, John Allen
	<john.allen@amd.com>
Subject: [PATCH 2/4] RAS: ATL: Expand helpers for adding and removing base and hole
Date: Thu, 14 Mar 2024 16:35:25 +0000
Message-ID: <20240314163527.63321-3-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc20536-5fed-4cd0-f792-08dc4444db87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vbCMIxvmj7Prd7fxEMKheFuhwq+dYgH3Ojk9BlD0Nc2D1l6llJAxYJsm9QzAZxe19levW0SoElCTi5UZebFWNfQVpCtRz2FW4jaEOvOyKnfXY6+U2yXRKlsE7F9FbMWGGSbC1GsUG4l6WAiLQDaRdqS6xLdLdGN+kclyvhrjEkEsYQxiM2CnDIleeYSQOmJfJw8+XpKR0usUH5cvrP1VImo3T1WO/s3Pgw9Lrtxalz3aD0GowTnGwt6N2fu5Ox42rftaK7B+33QhpSJlf+NT/JHuNm6LeVFIx0DMbSDwcYjvXkLVyGS/iRAJWvz8g6TrPxEQ6/dyDzKZcNHxtg/Gm6a7SPtnDfoIZHzovw0cEoA/ftY1FC7Ipook9X5BYkU+3xXtLs3+r44MNiAynwUaAeezgPOqvZldKLBctd64Hoy6mlrVcVoVqmSAv5uCF98Ui923K5i7O0Hcfajo3DO0a+pkC0EEO5XvkcaX3hwZghhCGzqsuZ9hEX/33IIYYpuJnWm/fgke1lr87eJl+GAhOJeMu9O72OmlEmExJqu/1ERUJ8ItY0LGxl3+zGiP0qHlgcFgD+lIqdlTTTNotykuKgIFbvkJpTBYsg5O2hvM4OHu1Tg+WQMMxy61C3Gn78mKnpYEJaE2WYCFJkDec+XuA2t1/RoCGhkqXs5ZoRaxAPG45+39UeOlkBrCJN2B2A02R0QDWoqfWcelz2bMuMFPGvpXisOcMSawCV+CZEbJFbzKdNqEPjBEJR1Qo9VSNgsE
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 16:36:11.0572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc20536-5fed-4cd0-f792-08dc4444db87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599

Data fabric 4.5 denormalization will need to frequently add and remove
the base and the legacy MMIO hole. Modify existing helpers to improve DF
4.5 denormalization flow and add helper to remove the base and hole.

Signed-off-by: John Allen <john.allen@amd.com>
---
 drivers/ras/amd/atl/core.c     | 43 ++++++++++++++++++++++------------
 drivers/ras/amd/atl/internal.h |  3 +++
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index c1710d233adb..cafdfc57d929 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -49,15 +49,26 @@ static bool legacy_hole_en(struct addr_ctx *ctx)
 	return FIELD_GET(DF_LEGACY_MMIO_HOLE_EN, reg);
 }
 
-static int add_legacy_hole(struct addr_ctx *ctx)
+static u64 add_legacy_hole(struct addr_ctx *ctx, u64 addr)
 {
 	if (!legacy_hole_en(ctx))
-		return 0;
+		return addr;
 
-	if (ctx->addr >= df_cfg.dram_hole_base)
-		ctx->addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
+	if (addr >= df_cfg.dram_hole_base)
+		addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
 
-	return 0;
+	return addr;
+}
+
+static u64 remove_legacy_hole(struct addr_ctx *ctx, u64 addr)
+{
+	if (!legacy_hole_en(ctx))
+		return addr;
+
+	if (addr >= df_cfg.dram_hole_base)
+		addr -= (BIT_ULL(32) - df_cfg.dram_hole_base);
+
+	return addr;
 }
 
 static u64 get_base_addr(struct addr_ctx *ctx)
@@ -72,14 +83,16 @@ static u64 get_base_addr(struct addr_ctx *ctx)
 	return base_addr << DF_DRAM_BASE_LIMIT_LSB;
 }
 
-static int add_base_and_hole(struct addr_ctx *ctx)
+u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr)
 {
-	ctx->ret_addr += get_base_addr(ctx);
-
-	if (add_legacy_hole(ctx))
-		return -EINVAL;
+	addr += get_base_addr(ctx);
+	return add_legacy_hole(ctx, addr);
+}
 
-	return 0;
+u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr)
+{
+	addr -= get_base_addr(ctx);
+	return remove_legacy_hole(ctx, addr);
 }
 
 static bool late_hole_remove(struct addr_ctx *ctx)
@@ -123,14 +136,14 @@ unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsig
 	if (denormalize_address(&ctx))
 		return -EINVAL;
 
-	if (!late_hole_remove(&ctx) && add_base_and_hole(&ctx))
-		return -EINVAL;
+	if (!late_hole_remove(&ctx))
+		ctx.ret_addr = add_base_and_hole(&ctx, ctx.ret_addr);
 
 	if (dehash_address(&ctx))
 		return -EINVAL;
 
-	if (late_hole_remove(&ctx) && add_base_and_hole(&ctx))
-		return -EINVAL;
+	if (late_hole_remove(&ctx))
+		ctx.ret_addr = add_base_and_hole(&ctx, ctx.ret_addr);
 
 	if (addr_over_limit(&ctx))
 		return -EINVAL;
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 1413c8ddc6c5..05b870fcb24e 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -236,6 +236,9 @@ int dehash_address(struct addr_ctx *ctx);
 unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
 unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
 
+u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
+u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
+
 /*
  * Make a gap in @data that is @num_bits long starting at @bit_num.
  * e.g. data		= 11111111'b
-- 
2.34.1


