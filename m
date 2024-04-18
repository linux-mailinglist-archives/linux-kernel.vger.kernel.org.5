Return-Path: <linux-kernel+bounces-150466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE228A9FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C1B1F23339
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8745716FF3E;
	Thu, 18 Apr 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uor2owKp"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3469C4D9E8;
	Thu, 18 Apr 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456894; cv=fail; b=eor5hWOQuxI3PxNMojH4AkP0rO3zzYXe9e8WoSOhMXK2gAwjCFT0SOXZSmycztCzC1xjmvffQpAF+xtfiRJ7A0TkX7ITwjVJvbEDv/RHJ9e48o2TAXx49ycx2bjtVMRLf05lP4j6GcnuyMqktNRYJPsgmCnjBQ5aaoGVQzTdC90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456894; c=relaxed/simple;
	bh=nqOYKSB+ZoMZ7w7B7CVjMVQFtupimE29pbNDldp1F0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEEmwvH684InBm2M9soAPcK3cA7Egf4I0zdb6YAG/Bh/WQg1jGrDTvYodRXLpVPkzSJZh67yFZ9QRY2QwwWoSyTdloR0qhrXrZepYXpW3nTBV9Q+70lNTgp0yidIzGe637j1VGomDfmeEo2QqIPaRoc2EsVkChjGZecIh80TlII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uor2owKp; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyrkqfI587YodbibcVIU0E3Y8cJVDHM2hw8e764gt35v4N6PMI9MFtpVFf9VWszF+FBB9em+5MxDz7Fy2m6Zdab3kuNRBPECcyZOh6yKfZlYlRHtcPmNZppBcuNsfmgYfMeNZigiyV1wQSnirVeO0JnNQa9ZgPr8l7kyoHC5T1bj447Z8LsuB02yoUbhCG5lEXMFU0ZEb8GlI8aTTHnCkMPrTmq3I79YsMBh0AzyLN2LcJdMZR39WrUVXIohfGI/6hbwf/psMmDwFUWmIU0qHZEfYTfD+mOu5YpkwhyibdqfI5G5Dpy+0Y8HTOR6GXAio2bk02YaqDouTQraXC7jKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUYo/w0e7QHmMz8kLIdVA6AkR25hUEhMB+DWEKHiu7U=;
 b=mIrQHxZd099rfbfh5fIQ1pocbW9Fpy67ZjzCioVNRcGicH2iQUM1rJoFF9X97g6wR59aa8xYwbyQo+opr4Fx3I9HroKyWfu6YsH72Ru/O5eR3zM9CTqiZGINpaGzPuNK1/WK7FPRF6sIvdC6F04c8HXasXK1E+x6tbvnt1keHkMRm3kvEtxnXRjIxJgQHfGCE2LXHXGKX034nZKIISybLXvIVkQxJbQZBIqozj7B9o+Xq2CJvzKwdmey1zvak10cOoGFAKw1Y0AJE6PFlL+TXc+61oTCh/yq7hAXayx5wtLenQGDR8I+zvByxS9N1CExFofaxvzmEJubk72MdZ1c9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUYo/w0e7QHmMz8kLIdVA6AkR25hUEhMB+DWEKHiu7U=;
 b=Uor2owKpubJqpEHPYE3Jt9rPD+w46iFv/dvjboA3T4MNCE6vTOewmv3pMZAlg3az4aGG/p1CFdHS2z2FDjCnCM8uVeIg3CrlLIgqPNOGYsOIXixu70eeG6bum46gC1kuNVCYHymUrzYqq0B75NIV7GZcv9WcFWZBit6MBrIYjxw=
Received: from BL1PR13CA0265.namprd13.prod.outlook.com (2603:10b6:208:2ba::30)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 16:14:51 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::68) by BL1PR13CA0265.outlook.office365.com
 (2603:10b6:208:2ba::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11 via Frontend
 Transport; Thu, 18 Apr 2024 16:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 16:14:50 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 11:14:49 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v3 1/4] RAS/AMD/ATL: Read DRAM hole base early
Date: Thu, 18 Apr 2024 16:14:14 +0000
Message-ID: <20240418161417.6091-2-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: c1414ceb-9d80-4565-efe5-08dc5fc2ac66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BKXEonJEuBA8D9wecPVKThuMQwJbmbznBQ4nyxVhuH8oajeVPxP7BDu3iZEDuN6KKosn0K2IGHm3c2wBt2JuQLIQPQh8RJuAaq5ANzJwZQvVk7UHwYLc7Xujbl6o4EOdRSqYRbZR1uS4IW4TyGP8Xuj6U1BrmuCwVPcgatqEKz0GL1VNcdoTjTu8++EisIxWLkCZB4aBO4YgbUxHitHQ188lxxUu1A5poDca4ynNAxSFJs4lhV4h8HOS+ewWShDISwgix0ZXK1UG+fSPf54m3JIunTa4xTrS0wdULl48rYfFU5GEorRqKvVdKx17r8G9p/fed+vBeaTDnsSaJpRa+QLP1CTDJ3komSSqbFuH1ZH/e63/eknmw/A6S0cmplDqlSK5YI6DfqHMM5oEnm++Mrjb0HlTtcid7JGL92jHJCTjdmBZNuSzbKQDKf+Fz0Amoc6JLwb/GxKTDLoQF7VA4CF7VS4ITr9Xx7mzw54MRK++vOx/ZGkMVqu7Fr1SY8nE8jIP78GaWtD7zuZwwF557sJpDv6InPQGyZmcZ6oEI+mdX8yy7zgyIUt3x+r073elKTT5+fUKtd1OgMxr1E+tVOFSaoa5pENDzECM6rhYETQRO4B5NdKptiro6F3dq9NzlmP6IgH3u5v1p7Smdz0XW0psJPsshnZqEj01wFPUvc/srGBMBt5xbMPniC7dapMJcAqmY2CeDwaR7u7FnmWSMwe4/qILlUVKg1k+q3Kgp8YLAgmZtvcZSXyFOr2LA5MF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:14:50.0020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1414ceb-9d80-4565-efe5-08dc5fc2ac66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549

Read DRAM hole base when constructing the address map as the value will
not change during run time.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - Fix compilation error. ctx->addr should read ctx->ret_addr.
  - Improve commit description.
v3:
  - Include "0x" prefix for dram_hole_base print
---
 drivers/ras/amd/atl/core.c     | 15 ++-------------
 drivers/ras/amd/atl/internal.h |  2 ++
 drivers/ras/amd/atl/system.c   | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 6dc4e06305f7..63513d972c07 100644
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
+	if (ctx->ret_addr >= df_cfg.dram_hole_base)
+		ctx->ret_addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
 
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
index 701349e84942..a4314f5073ab 100644
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
 
+	pr_debug("dram_hole_base=0x%x",			df_cfg.dram_hole_base);
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


