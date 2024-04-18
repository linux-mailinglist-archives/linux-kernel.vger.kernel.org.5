Return-Path: <linux-kernel+bounces-150468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B768A9FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23BA71C211D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B2916F902;
	Thu, 18 Apr 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x0Fm0rIi"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E0B16F8F9;
	Thu, 18 Apr 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456913; cv=fail; b=t+qoMkTcAS92flii5Vt5+PpmRiBTZCDpmYQcjh0t7XQk1YCqmGwdvu4TKRn7ecY2U1khVoaPs+v4uO+qjcd8fNWyQ31f1Y2Vykqs3QCSMnaHtIO31vCy2yLdsp0/V7+Dngo236V369t5mHK8bN9I7BYOIwUaNUz9Tnppa71886c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456913; c=relaxed/simple;
	bh=TkadaQQPV9NjLYYA6i4SEGMj5U/CMJQQR/vb2cajDCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1R0785lJIPGZukpmd1mLUf8lmZFnACX4PGDXu0rnbRHXRGiWq7HOsZVgGv5Gle47YYxKdPxMqNMr5TuJ6yfKKdV8i0Nq4yz4nda0+8LQH/TZx2Vgohgfi2SsNw0DokCWDKuMqbPM9SuZduZGiyqq/wumXD3X7spCPqf/1carM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x0Fm0rIi; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/ezx8Kr87WSAu7le3XUQ60B+fWkvnP5+gLA4etWdO9rXKs+KGQXPRx4KWkBi9pmqh0ZyHc2ZGGDxdcyhCHn15hvhm0Z6TwdSLqeSL6z8PsL8UoSdRBkD3sbkhT9dZmMea17WsJAM9DykEd+ni/1X6wl1o8lpic6Cb3HLTSiJn73u8CUxb/oblSeeQ0eWQZ93zIVqrKvUGx7B994xRB634ZNBkUMdML6Yt/U6NyOoYP7QwM/hBM3Eb6DvzoPZ/PvuRyDHWIkWBEGVKMnTptHXxIsB8rX+H2g1t/w+9ziAtaAB1vpQNDZaogoFP3VhXvLLEwfOpiAOGfcKR/cy3u+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/1eAi1aIffewFNrj7oAu9AW7wbJDQ+w6/vUyunSWSs=;
 b=at9PPbq+NhUHC40BLIavNMnSsch4P3Bh1YD6IEKdaoJJabkM9qm3k28AdKliGGXwy0RqQzRG/1pY41/vU26qLUwmpEjgrn5A1OTaNGVNEERliT4XnBTWpIhYm49yriX3zfll2ODZsZPkhzm5HfbvltgBEkGBUUWhNMWl0o+PUnPnJ4Ud72l/WpokthtEOqAPGrDKy5n59Id8KdI8Wi7i88jqB02J58S91+1p/909hOvMOfTRUD8eyOrv6eu8YV5YMMDMNAD6vNshWkkU54cYE1QcDP7HQcVxhM5QI/i6JQVkgSmxx04sufjmqb5lE5/aASkZIsxPM5P+2r/N1HBfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/1eAi1aIffewFNrj7oAu9AW7wbJDQ+w6/vUyunSWSs=;
 b=x0Fm0rIiHQ1sFlo6XMDGsFme0kvxQ/JjKdCjv463ziO6MbCA7/2eHcHHoflFLv3/e2uAdN28oPnjyV6K3UK/SI6rxOeqEo0LSe0ftucY/XC54jtrWbTNGlRvC9KgGSQyEnvfKNVAfgICj0nmMU/1WHu9gkQu/+8FCMPKmqjjyLA=
Received: from MN2PR12CA0015.namprd12.prod.outlook.com (2603:10b6:208:a8::28)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 16:15:04 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::c8) by MN2PR12CA0015.outlook.office365.com
 (2603:10b6:208:a8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.24 via Frontend
 Transport; Thu, 18 Apr 2024 16:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 16:15:02 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 11:15:01 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v3 3/4] RAS/AMD/ATL: Validate address map when information is gathered
Date: Thu, 18 Apr 2024 16:14:16 +0000
Message-ID: <20240418161417.6091-4-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 3716f901-d24e-434b-85a6-08dc5fc2b3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wwt+JFg1UWgOGh5eixQbKG5hpgj9pXYuZUnysk8vF0njeKiheerAU5O5f2zm6t9la8o2ta8aL25bvUlJ3X9DpIwerGYf+4bGoHQttvc6qz91/dnTWK45KQQMsnQAzLRdgUPOPtw9JakN5CM3tiR37Ti+Jz9mCmeqsY2DzPKRq0G4ifx+h0pcOSVVPDhmBTvmeRNqR9HpZKEiIi1IdDNGrehME0I+raeYcNVS45hfmReNT+SCE6MN3Zp18bIDH2gyGoWBk3d9ojxup3e8CGEIoVsgBDBo3qSKxrCEjZ/48oVsxbigzxZsI9n8rbE62NnsQwtqTWuuAKt1ACo5Bg9qAH0qzyUmuVZHrVELFP3jocGZTe2YBa0db/BfzD5wQB3rhLqnBWE8pqakBvex8VFM5SjUlTOYxHy8P06cAvTbrNHZE4VVSfGTsl7V86X2zFj0OhUO0NSP4feKxyh6g5ucq8RHZ4RTnCUfF3hIx978edJcjmuyIZnCBpBE40fomiJWA44xzGy0SJ+yYVTJDkQKdl/2gbwvEgND8hO+/7vg8QArueN4YNrTkFSesSmT1ZSLbcwsgvHocxlg0RxMu3IxA67SdckbRXkUWFGAYsQCrfTAWY1VmtmyFUmeFqbU2Z7HQnZd1RmLiFE4jonCKokJzcPdtcTTPHUrWoIUfPyZ3H5GL2kY0U9Gtpldhr3+52z7hx7lXyi54k6Vr71ej9Mw4UxM3bIpHuxabp3th/Es8cjuHl9WdHEh2SGgzGZvavMk
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:15:02.7017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3716f901-d24e-434b-85a6-08dc5fc2b3fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

Validate address maps at the time the information is gathered as the
address map will not change during translation.

Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - New in v2.
v3:
  - Move DF 4.5 np2 validation to patch 4.
  - Update commit description.
---
 drivers/ras/amd/atl/dehash.c | 43 ------------------
 drivers/ras/amd/atl/map.c    | 85 ++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 43 deletions(-)

diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
index 4ea46262c4f5..d4ee7ecabaee 100644
--- a/drivers/ras/amd/atl/dehash.c
+++ b/drivers/ras/amd/atl/dehash.c
@@ -12,41 +12,10 @@
 
 #include "internal.h"
 
-/*
- * Verify the interleave bits are correct in the different interleaving
- * settings.
- *
- * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
- * respective interleaving is disabled.
- */
-static inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
-				  u8 num_intlv_dies, u8 num_intlv_sockets)
-{
-	if (!(ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)) {
-		pr_debug("Invalid interleave bit: %u", ctx->map.intlv_bit_pos);
-		return false;
-	}
-
-	if (ctx->map.num_intlv_dies > num_intlv_dies) {
-		pr_debug("Invalid number of interleave dies: %u", ctx->map.num_intlv_dies);
-		return false;
-	}
-
-	if (ctx->map.num_intlv_sockets > num_intlv_sockets) {
-		pr_debug("Invalid number of interleave sockets: %u", ctx->map.num_intlv_sockets);
-		return false;
-	}
-
-	return true;
-}
-
 static int df2_dehash_addr(struct addr_ctx *ctx)
 {
 	u8 hashed_bit, intlv_bit, intlv_bit_pos;
 
-	if (!map_bits_valid(ctx, 8, 9, 1, 1))
-		return -EINVAL;
-
 	intlv_bit_pos = ctx->map.intlv_bit_pos;
 	intlv_bit = !!(BIT_ULL(intlv_bit_pos) & ctx->ret_addr);
 
@@ -67,9 +36,6 @@ static int df3_dehash_addr(struct addr_ctx *ctx)
 	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
 	u8 hashed_bit, intlv_bit, intlv_bit_pos;
 
-	if (!map_bits_valid(ctx, 8, 9, 1, 1))
-		return -EINVAL;
-
 	hash_ctl_64k = FIELD_GET(DF3_HASH_CTL_64K, ctx->map.ctl);
 	hash_ctl_2M  = FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
 	hash_ctl_1G  = FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);
@@ -171,9 +137,6 @@ static int df4_dehash_addr(struct addr_ctx *ctx)
 	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
 	u8 hashed_bit, intlv_bit;
 
-	if (!map_bits_valid(ctx, 8, 8, 1, 2))
-		return -EINVAL;
-
 	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
 	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M, ctx->map.ctl);
 	hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G, ctx->map.ctl);
@@ -247,9 +210,6 @@ static int df4p5_dehash_addr(struct addr_ctx *ctx)
 	u8 hashed_bit, intlv_bit;
 	u64 rehash_vector;
 
-	if (!map_bits_valid(ctx, 8, 8, 1, 2))
-		return -EINVAL;
-
 	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
 	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M, ctx->map.ctl);
 	hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G, ctx->map.ctl);
@@ -360,9 +320,6 @@ static int mi300_dehash_addr(struct addr_ctx *ctx)
 	bool hashed_bit, intlv_bit, test_bit;
 	u8 num_intlv_bits, base_bit, i;
 
-	if (!map_bits_valid(ctx, 8, 8, 4, 1))
-		return -EINVAL;
-
 	hash_ctl_4k  = FIELD_GET(DF4p5_HASH_CTL_4K, ctx->map.ctl);
 	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
 	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
index 8b908e8d7495..94c5f665d5bc 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -642,6 +642,87 @@ static int get_global_map_data(struct addr_ctx *ctx)
 	return 0;
 }
 
+/*
+ * Verify the interleave bits are correct in the different interleaving
+ * settings.
+ *
+ * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
+ * respective interleaving is disabled.
+ */
+static inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
+				  u8 num_intlv_dies, u8 num_intlv_sockets)
+{
+	if (!(ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)) {
+		pr_debug("Invalid interleave bit: %u", ctx->map.intlv_bit_pos);
+		return false;
+	}
+
+	if (ctx->map.num_intlv_dies > num_intlv_dies) {
+		pr_debug("Invalid number of interleave dies: %u", ctx->map.num_intlv_dies);
+		return false;
+	}
+
+	if (ctx->map.num_intlv_sockets > num_intlv_sockets) {
+		pr_debug("Invalid number of interleave sockets: %u", ctx->map.num_intlv_sockets);
+		return false;
+	}
+
+	return true;
+}
+
+static int validate_address_map(struct addr_ctx *ctx)
+{
+	switch (ctx->map.intlv_mode) {
+	case DF2_2CHAN_HASH:
+		if (!map_bits_valid(ctx, 8, 9, 1, 1))
+			goto out;
+		break;
+
+	case DF3_COD4_2CHAN_HASH:
+	case DF3_COD2_4CHAN_HASH:
+	case DF3_COD1_8CHAN_HASH:
+		if (!map_bits_valid(ctx, 8, 9, 1, 1))
+			goto out;
+		break;
+
+	case DF4_NPS4_2CHAN_HASH:
+	case DF4_NPS2_4CHAN_HASH:
+	case DF4_NPS1_8CHAN_HASH:
+		if (!map_bits_valid(ctx, 8, 8, 1, 2))
+			goto out;
+		break;
+
+	case DF4p5_NPS4_2CHAN_1K_HASH:
+	case DF4p5_NPS4_2CHAN_2K_HASH:
+	case DF4p5_NPS2_4CHAN_1K_HASH:
+	case DF4p5_NPS2_4CHAN_2K_HASH:
+	case DF4p5_NPS1_8CHAN_1K_HASH:
+	case DF4p5_NPS1_8CHAN_2K_HASH:
+	case DF4p5_NPS1_16CHAN_1K_HASH:
+	case DF4p5_NPS1_16CHAN_2K_HASH:
+		if (!map_bits_valid(ctx, 8, 8, 1, 2))
+			goto out;
+		break;
+
+	case MI3_HASH_8CHAN:
+	case MI3_HASH_16CHAN:
+	case MI3_HASH_32CHAN:
+		if (!map_bits_valid(ctx, 8, 8, 4, 1))
+			goto out;
+		break;
+
+	default:
+		atl_debug_on_bad_intlv_mode(ctx);
+		return -EINVAL;
+	}
+
+	return 0;
+
+out:
+	atl_debug(ctx, "Inconsistent address map");
+	return -EINVAL;
+}
+
 static void dump_address_map(struct dram_addr_map *map)
 {
 	u8 i;
@@ -678,5 +759,9 @@ int get_address_map(struct addr_ctx *ctx)
 
 	dump_address_map(&ctx->map);
 
+	ret = validate_address_map(ctx);
+	if (ret)
+		return ret;
+
 	return ret;
 }
-- 
2.34.1


