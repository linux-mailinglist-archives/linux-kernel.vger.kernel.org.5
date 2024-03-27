Return-Path: <linux-kernel+bounces-121855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C996C88EE92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0AE29E58A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63831514DF;
	Wed, 27 Mar 2024 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O2zCiXZK"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA412EBEF;
	Wed, 27 Mar 2024 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565567; cv=fail; b=QGuctmVb/l0miJFJ9jQ23pWuGxTNys78eNbbZoSJM4MTJRY8Lq+ieJfKadLcII33EiKD2AjI8blTWWUxzRYUWL2ReWKm9b0s2GcOSYuutLfaxn3Q5nhKrg4847I/RJN9CSoqjvMZZYUkOFzwSM6KJKxZVRd8lUyvydZm0YlIbPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565567; c=relaxed/simple;
	bh=Gn83KWZ7tFQ+6YLu51o0zAjScRFJtC1UnZ0IIM896uk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wr8TDzsBMP+6GwpkvZOt9F/5/wrPxbZr1+K9fjB/WbyiqFbW3IEFttNo+ljXqTbEKREZRY8WLeNbnogXQm+GANzqCroLPZeHTzw7LdJD+KWdzAg4E3Sp1Aa0YRqFurpTrqpxlqNyeOVGDf9KRsDslVt3MwsM5g2wLRkSm53agww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O2zCiXZK; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU30bPNK+91v2od+gjgKthKA5sCR7NjkB2oEpBadCTzjHGPCGq4BzyoZzvrQwabpXS59NiJz5SbcoHqxz5TVflO0nrgqGeMFjhq/YBGqfj5OHx4ZyVxbFEGVwqxelBhm+Q26WLaVb2GL5QNOOt1BzNBQNPYhZxkQTMVV4jP89tgVNk0HTqMkBcN1LEc0P3F7m5WIdwsPAZ+KIrvp8iBxq4RVMNdZTw/BpIiM6l/AgFRrD/VLH9l0byUuCj8SlzhAexKg6JCGWtI2aRBV7DR2pZTa6PKx6h5qEvVPO5BQq157q33AyPXFZaVhLDIQfQLp18W17dXB9yPmrQ6dAUs5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCHtUXgSRyA+li8cDpa0bMPl0zvUlkeVO01vYHTo6jY=;
 b=Rhgy8Awc7Pxn5tZ9LebWUg5hwm/Yjv8fDKJzMM8QmtdMBdqCe81HUxEB8pWY/umQXTT2SDfgdPHt4gN87wSZVVka9z7GDeGQ00RwIkDwJr5kW2gISqZXjVbsLt9X6tOuxwWQEQ71Xc3kSqrl6UeQnkT5RhdTAIpAt7gHO+PFEbhYGHaO589WEKlxOh7UtsqZsKqE7+9PFYyw6HwDdhhWn+S8YR7dabNrsgxzd/SrM216HpPm3jP+kNLc+bcv/irxejDGuJ4R6yBTT7tqgfQXjZd095SY5PpyHDlMIkk7lTOst0HBaiJUIFaRkpZcs/6M4nRIOtPrDEtsi2Am22MRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCHtUXgSRyA+li8cDpa0bMPl0zvUlkeVO01vYHTo6jY=;
 b=O2zCiXZKAZQerUqwZiV0g+mum0febgIst58bARWSxMntB4GivP/BYhJt6QU4g0YDt1jPUUysMPxkmU27kzBJpEcRTYhAk7htZjyMGVKTnyL2Qkgv1kqJbZclF9ivZWW7zwKfHvb+mFNxDhPB6jrp773T7NcCYVMEkWUc9ZV/u7Y=
Received: from SA1P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::7)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 18:52:41 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:22c:cafe::4c) by SA1P222CA0006.outlook.office365.com
 (2603:10b6:806:22c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 18:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 18:52:40 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 13:52:40 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v2 1/4] RAS/AMD/ATL: Read DRAM hole base early
Date: Wed, 27 Mar 2024 18:52:19 +0000
Message-ID: <20240327185222.98998-2-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MW4PR12MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0d7a0c-a639-4903-039a-08dc4e8f147a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Hxn0hQWN3TvNO+AOrPAgepE+DJYnupXiIUZX20S1SBHOXW6NIS+3ra8iL6HeBu/9nfU+VaSF8B11X23oa27+wvl7XFQyhFZulR/TGGUBsHYxW2FJtdU0xobAXa24fmV/5Zh7FlsHKD9T8D+vDC0ZOkLxN8bBtYhxjtpci09O5thvcu6eqSJG70xAS4VA6T1lEr5IJcLWzauGDTSpq9nYhuq/hVwciajRiXccuHPUp5Jhm67lC9mgJ24wR0sAHLhvGX1hCC1FEdmIm/0CKQFis1dDG8UIn4grPOYPnKj32tLxTHCj+8NYeMqBCwRhmXipwzFvoPmAJdmCskATzkCoEFvO43iuBsN+t6IxA8jfQyX3EGEZChPpriCTgEvAikTNGpocDDrUM/NQF0aUx9EMwQlu/ZVCTuyekKApByHefouLjXb7KYfM6exnFT7dUQITklyGt3qBBghKKTYSF6zcGTM9Jj7pwb5dImPuwLGPDVgQmM+QWYPH6ALnNxYSEBvnmbqULr260Kx0zKPc7qyHCHmOyzRWIsCFp5Lpm1karsakpwZHTC+TyqT1Hr5poBtrZm37P8Oen0fxdSEk1t3gnpSZ1uKO7euLi9J8pWn5BPEviglU8bN+TKfDpJCUoCKW3TkZQ60D9BiBmuC0UxHPMLIM2p/asZVE1kQox4auMSDYpW5kTlc2NMlQGNtAdFPV8lfAMdLjxnK3QFia/r1hdOaofgQ0THib0T75OWd9rqAdpEigW3mk9ml48xzK5bJ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 18:52:40.9973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0d7a0c-a639-4903-039a-08dc4e8f147a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997

Read DRAM hole base when constructing the address map as the value will
not change during run time.

Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - Fix compilation error. ctx->addr should read ctx->ret_addr.
  - Improve commit description.
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


