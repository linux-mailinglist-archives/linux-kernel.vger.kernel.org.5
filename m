Return-Path: <linux-kernel+bounces-121856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A388EE94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8082D1C331D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2681514F7;
	Wed, 27 Mar 2024 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hn6jrdy6"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938351514D8;
	Wed, 27 Mar 2024 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565569; cv=fail; b=HIIWrILM8RAp652yAijkHAP14wqm/RB8dWN97UDAMNaS9Pn8gYRT6/5rRSNsfu0P7S00NND5isT5SKwxaU7rWEyNJOn1+KwXtxxUbqWjFhSAj6/1/DdGZdry3nGxSDpG+taRylS7SGBUOA+2VlLua74hWLfeCrALrp9VoG76NN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565569; c=relaxed/simple;
	bh=fqs/zNo5C90782DSJjpFctqGwS1Fc8OT8Elly6zQr3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsSirkE5AvO8ptvNDzDKsZfhiAJ5jQ8J80SziA7W/IXUj+uw6uh7VEN1Pupl8O+1rrXWTfXKYmSa5gXviO2x2TqgDQn4WMHG9hQii5VOa0+YdHH7JHqbntqTk4CIRI6OBhfi2bUOfeDr1sbCtpscP6Dn/KpMusPNwwMj4favvl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hn6jrdy6; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wew3gbqXoQg0+YtpLkrrFW5Rbf7kEkcqAT5B6dtQN5ays3iKYCnbVCqKlnCMRGR+EvffFniIFJxybQ6jdHcEz+6IGHpk0fuItRXR8caO4xhjGxVHeYD0HoXjAYZ0gQsPWjNf6mJzDbtYgh1mnrdno6Cdq1RjVvDrE+NELkBgIbjE6eSnPz+/eQjLVVpDh3vUaC3F5+Fw6LyCx2DzxrkM8SlbnQuWsEEahM3NVKR+XJBE9XHD+dJuZYekC7r+n4IYNdw5e+kRo1CfBFEdRcEbTd0Z2zrcU7ODlA/D7Kt+EF2zjCATQo7VmYvachJGKMngQWfsePfOLOcNGkpeO0KXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgz+QaW0cxbyrtUpNxih6onHghXQEQs1z040cyIunvw=;
 b=VQ57hM9z/GHYk0xLG1ac0f5zoU9Eo0y56Fq21FuwHjbpKFDfdXIMnCnoNEfG1FkHI/HTnNtEFtuy9Kkqtyeo2Y4498ILOtBQXMNp9x/4wzJAWgWDHquCUmeDILul+sBOxV1ygF3GQOCAT/mtXftWKUi8Yh9mu5Vavzbl0SSgLKclrSvKhir69iTciDXcEXEMvaA4+Q41HJeP2mahceUy1cfMhPoswF4lW0qWSN+QzfBqLZ6kF5eqDOJYdaSmgGTwvt4lWF3XowD4jRky+8PgD2XWvMW6h/Kaldj0xI6QyJuJtd7Y+g1lzAPsj82pHodjI5x9hqNyWYd+3FrLt8Ejeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgz+QaW0cxbyrtUpNxih6onHghXQEQs1z040cyIunvw=;
 b=Hn6jrdy60SFPqPZ1x6yiY4vkk9XB2DwRYVC8e7iFN9Lbehm78nOL78Bl1ULuUREKBgbzq4MoEKjqQdOfUJWxiWTzLx5lfC9BWqPfRqP5N2GWpQDW3yO7RMyNOGSEOd0+WFbFT2SsArf09cToInEu9D1rpGhDTXi9SiZnDZpN3dM=
Received: from SA1PR05CA0021.namprd05.prod.outlook.com (2603:10b6:806:2d2::21)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 18:52:45 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:2d2:cafe::9f) by SA1PR05CA0021.outlook.office365.com
 (2603:10b6:806:2d2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 27 Mar 2024 18:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 18:52:44 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 13:52:44 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v2 2/4] RAS/AMD/ATL: Expand helpers for adding and removing base and hole
Date: Wed, 27 Mar 2024 18:52:20 +0000
Message-ID: <20240327185222.98998-3-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327185222.98998-1-john.allen@amd.com>
References: <20240327185222.98998-1-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: acc80b91-7c9c-4b6d-d467-08dc4e8f16c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3t9J0iJ7Jrc1KJRd5gNtr3hEboagRIKRSnc41BOXg/q8T4nRq0abZfd9L7FZ69nhVXsX1MCXrO7dLf05V4x86ppQnr7LAbfrOP9IgcruRmcMxYN/tYMnO+4GmmlwkQgtQmmMaS0mFG60RtJG1daUK3UUFNnvpiMBxROj7DqMTeQEacLxnPjJFXhjcZxqKqj3UsslKijVu2ka0IQaWh8OtKFs5y4DisYGgEyv0sX4u02J3+gBLf7p9ZI9uq9y1J3qLjigI/zedkeK6m8A3dN1S7izEyQHBcqndCuz+0dFLtqitbCcX85R1tu2V2EgGiqNlerQMN6wwsbf6jAuumymjisxGxdlIfNfc37VDyZ8s7okTbG5TsX/vK4aZs1lEe4qGu3t1SFdDFrHsXL0yRqgmlSkEls7lpDjuDgpmkxynpPryWbgqeVgPuvXCnjMIJ65OX5wGUAHtesjP+stGbJN8BM4ndnAjtE5E7Rdy0rV5ggEgtzTO8tBFBSKp4AzSoqmk0b3MIhh1f8emSCU0QrgVqE3ju3nvBC5R1t+QgENo/0c2WL2uGVSjk8FjPntJz6MpSk19eEtOv6eSEsMZzHn99Q8R6awngZ2+avRWDR6GQTg37URP9YTR/UFhQlK0XQN63v1ZrPrxNwwICcN8fvNZrXSr7iSbV0gruhZhJFq35Y7+pwMJJmoVDvlNyeR5RdC1sF2qe0+XwX2hkfzt2JH4JFE7g56S7/nqr49R49qZaKo4qbrtbTqv+DuoearvtWe
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 18:52:44.8078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc80b91-7c9c-4b6d-d467-08dc4e8f16c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419

The existing helpers for adding and removing the base and legacy MMIO
hole operate on the ret_addr stored in the addr_ctx struct. This works
for the existing use case as adding and removing the base and hole is
only done once for an address that is already stored in ret_addr as part
of translation.

However, in the Data Fabric 4.5 non-power-of-2 cases, we will add and
remove the base and hole temporarily to check for correctness on
addresses other than ret_addr multiple times throughout translation.

Modify the helpers to take any address as a parameter and return the
resulting address after adding or removing the hole. This will allow for
more simply adding and removing the base and hole from any address
without having to store them in the ret_addr field of the addr_ctx
struct.

Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - Make remove_base_and_hole the inverse of add_base_and_hole, removing
    the hole first and then removing the base.
  - Improve commit description.
---
 drivers/ras/amd/atl/core.c     | 43 ++++++++++++++++++++++------------
 drivers/ras/amd/atl/internal.h |  3 +++
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 63513d972c07..d45f9948c0ab 100644
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
+	remove_legacy_hole(ctx, addr);
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


