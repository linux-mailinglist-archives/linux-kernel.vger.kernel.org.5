Return-Path: <linux-kernel+bounces-150467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479AC8A9FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF87B1F23426
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AAB171646;
	Thu, 18 Apr 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MncmvrDG"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E823D7;
	Thu, 18 Apr 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456901; cv=fail; b=NI6jdFORFIcDXYI/T5/H6p9AFBOjxxHiHnCBGszLCeiLgC9shG8pgCVFrtEXoMkiIMNEg+LDmFE8Fx1JhaHD6Ku5XyJVACS81c9dsgdA6o8z0fDdabsUwp08Fgj26fIz6dJ90YiPVw6ooU6fF9XkRICeXgJYN8mbE4/F9FYdZmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456901; c=relaxed/simple;
	bh=rSjiSaoO5348k2iMi2zJuCiy//Z7KyohmFE1R4X+iBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKeZrgptVYr9bea7Dt1QQzQNPOj9Bc+ntPftat7h5PsdL5ZyQYNZUG3nl08w8X1vux7RmJWAW15Fuz/T8u9qVUIxkJByjmtdQZid54sJtK5Mya1fShu+y/n3h6qbF85gDjalS/wgn0AfUNbu+uyVgg/u2GJSWflPAeixRX4iN1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MncmvrDG; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg8cP1YvgPGtaxNkM5CI6/66UDao83XKQUNpPNmokPGCS/Px0fGd9Nk2JmzTOvesKlIwama9qImnIM6WXPY2CGWVRgbjSYoczCdaoEU9LR1Mj2LPc6fmOF06IU+nc6ewEx55Pq8CquTZzIG0Gm40AC6Rj4FMA9YW5Ts7jpPi9pi1OKJmRnjWL1ZlkIM64R7XRxjudSAAS4q9Pqp7SL7mpe976sdDp3mNK+fAYH4JQ2I2gtVAwLxMooSIr9F1jyOqRALoRRgOsFrfoDeDJYcEtHqTX2RRsdFQHc9wgspCEXfRZZebzKabRTITMDEKlbBYyu4UvJUEGkYoWUs3UhiOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSio4+7u7PvTuVNDKj7DOhF7tNY62EXlUR+GgraEFXU=;
 b=O4DM8/T4wi7XvbrNKIHsIb+e9csniDcXDlcU0DJhV7MLCgP8L0xieOU+dj98766VkRFcpXN0Cr1fHw/ghf0b9LC93QBlcg0Y3U1es5ALE5l3ztayKvVgIp7a6WFGibge5xOg/lArLy4bbH3jmbAe55DjJTA09CXEALD0mx905enWCoa1jdi3N4x7e19u6rV1tRcRRzXH5AhwksgJyPX+/ktW7Tu+sMj0f0GuSa2faUEcyy/bibWnynhfqTAi1xA58z5MHSTBwFjt+bJZZnXmTYTjKvIX83lrQ5hnQe2KMmP+mGw94TrMynU0gJ82bF9Lp+Kx5xXS99/fC1O3DfiDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSio4+7u7PvTuVNDKj7DOhF7tNY62EXlUR+GgraEFXU=;
 b=MncmvrDG2yyfLedDTvIo1ayqXbpVrSlnKAjW4TIQ8VVo3VRFa8GdcslEl4D4HJid28e7YTree6qQU62aL1io323yT4El2mpeLlsGkHWIz6lH0W0GtktD4vea8KG6vlokxJKbL6z0jIYx53awY7XRnQ9ykiP2tFJcnwBss6GXSqE=
Received: from BLAP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::17)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 16:14:57 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::c7) by BLAP220CA0012.outlook.office365.com
 (2603:10b6:208:32c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Thu, 18 Apr 2024 16:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 16:14:57 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 11:14:55 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v3 2/4] RAS/AMD/ATL: Expand helpers for adding and removing base and hole
Date: Thu, 18 Apr 2024 16:14:15 +0000
Message-ID: <20240418161417.6091-3-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418161417.6091-1-john.allen@amd.com>
References: <20240418161417.6091-1-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee37621-935f-45ef-39e3-08dc5fc2b0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VUeFvYdhyLbQecqY21bx85ANROdRaKNjzYA759WJPiKnvnMrG7MkQyqS6Rg2K0SzYDeOFaGTRPAFzMKMqkwEvtM1NrIVTpPQq4z51RmPs7kfiHvvAn0rNjeriZKfeDhb4XZRLrKCaqtILd9zjmg/MCnl6h5kUctTylbDT46DSYUiVPGbFQkSRxBfStNEhCOA4Lk7SPi6mK6JicrdFsWj0ZFUYqt37KpKsMQl+SSl/ppIB+mbkYkDVEgiDb7J6D32KMG0zP2mpi0FEAQ6IKRD3Kd0Pha8z9aKHTcss/0br0L5SSAyQY2hMp5iOb9t/aNov94yYwW3Dk51sKk7S8Xce8UU0FCauMP7t5VRQ2SD03T8gz8viiHQBYVRlLtayqxPS2qls2+2G+ILsA6aGXHpSE4MgmnKRILYr3fuQ+dmp3DEWVZURyCvSGzO59rWL9YvLYzA+zB6yhmvrvT0kOIlljnaW0r0AqEn7oeOxOh0om4C2mP9cGdR4q0Pbr8BgZzNkglMcg771MqM+NrpiMxvd9lXBzkHAcCHlMX1jvDVIsv7SdncUudInjEUw0aK1gU8eaRpk/gVvGRSncvKjBFIsUHu5KY5B6Gq4yXWunwG+TH+pLV0Lc380GqTwNOJJv+lg31+g95qqFAbKi8LZDq3SCLVInxvvQ2BYrK3w4nSJaGBkstm7xshgeBr4EeGKwS9emmJKlDGftdBd7oVnEVA7mEiL/lDLRIZiPRcAJPCyba0IF33Fk9Jh27r4EBuulYu
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:14:57.2547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee37621-935f-45ef-39e3-08dc5fc2b0b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469

The ret_addr field in struct addr_ctx contains the intermediate value of
the returned address as it passes through multiple steps in the
translation process. Currently, adding the DRAM base and legacy hole
is only done once, so it operates directly on the intermediate value.

However, for DF 4.5 non-power-of-2 denormalization, adding and removing
the DRAM base and legacy hole needs to be done for multiple temporary
address values. During this process, the intermediate value should not be
lost so the ret_addr value can't be reused.

Update the existing 'add' helper to operate on an arbitrary address
and introduce a new 'remove' helper to do the inverse operations.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - Make remove_base_and_hole the inverse of add_base_and_hole, removing
    the hole first and then removing the base.
  - Improve commit description.
v3:
  - Rewrite commit description.
  - Fix bug in remove_base_and_hole.
---
 drivers/ras/amd/atl/core.c     | 43 ++++++++++++++++++++++------------
 drivers/ras/amd/atl/internal.h |  3 +++
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 63513d972c07..c3a97ffd1a37 100644
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
 
-	if (ctx->ret_addr >= df_cfg.dram_hole_base)
-		ctx->ret_addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
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
+	addr = remove_legacy_hole(ctx, addr);
+	return addr - get_base_addr(ctx);
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


