Return-Path: <linux-kernel+bounces-121857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9B388EE96
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20ABA280DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5A314F138;
	Wed, 27 Mar 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EN2aK/Wq"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE01509BF;
	Wed, 27 Mar 2024 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565579; cv=fail; b=BR4zvU28bz9qLJaN1qo8vR4vMD8DeC7BzghBk/ZOf5w7JxlCeN3E9B/dttFe8cX8yMkN9C13ds+5WZKqxaLgzb1+3MG4EN4f823wv5bRj0BEh0WW6WTYToayu+tX+jspTUTromrNV34bjMK9aOGT4tBe5ma7RaH+/vNK6vIhQRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565579; c=relaxed/simple;
	bh=Y/L4LdV1IYTqWpGXrZPjXBixMdD7q8yx7HcJ780fcK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnOXFmKf9fme85vdX9p3SFcNRu2kT2/8sMH7UtHtNQ4p1WHmzTBAhiJJgMI+46dxHFMMeSPBKpOCco67NsIU5JHIJgU/XVnVsxOkdy3O4Hm9kiykswyPUvJ7J7IxZMA5DIX6gyIpP1DuQ6H6j8/ME9FVDaPJ57Kd/PZPnZuiNkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EN2aK/Wq; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4/4zj57UorpYdvE1Bl4X9+jvW6bQUNibVXMcpznY5OU6XBLSQ7KLdYWQ6wsuB7X2d1k0/QBigJTJuTnABm9dvz4wq6S2qq0vDvVYibRzOTwZcnJZQeNqObBBF2fw1A2uB2Vqi1Zyx7dU6eGUnTvzhpEkiHDsgtiyNB5MUvF8E7NQWXLxxU9Tj53QRMIgKOA0WyIP3yAvkVBeYeDgoHtEYXR7Vh4I8IIg1n3faG9OpwqA5YocRkghmtIw38wHaGViiNSSDP/yr5Cr1fwJ1kvwYAnAe0tG940LwSP/fNtepuJ42qLDDNT8da70JMUydhNFOafV6BL5Sa+VjgmXHrYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMfKWEIwcOwJVvF72PKptQC6QFwrNWExeHYkxnOE5A=;
 b=l5AFlNyYYoZDe82vZnfkw5Y82n57IVdZFNodsARKC1wV2cCSD+Sc01KBItkLTDTpP+K9Q4TwSd0tEjH2NteO2Ws+S1SuDZU1L+vqcMNUdOVtT+TSob4Cdio8c5Diq3fZrhMgoZn6EYEJlvT4xrgCXUmEpzT8yYUHXcsvJZiNlmq+waQYK95JwHNw9ejlGlkCYpsRIzUjkdZSLT0mxyV7Y/JP/nLp7gaDDuVprjxCWPBTEYNNYJLMvQo9ONCfSTaw3dfK3fqSdOkvYRj8L+eHLds/emJok1oPL0ZEmUKSjs7HP6S8uS2ZC5XkiyBSjIesUarRqIC5qKni4/Cxmq1YnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMfKWEIwcOwJVvF72PKptQC6QFwrNWExeHYkxnOE5A=;
 b=EN2aK/Wq1UBx8fDmIZtSz4px9ghJr05ihNih2cwF0QbPAeka2RKezCsxfYDgM1y2mcMI1LHEESp+TIxnqR24A3tZBnwTLN0UA3jq3PVq6rDWd83JBwwVkt2BRzIkK+wi2S8mCCACpHhkmZkoWRlzBt/2146R99BJ1vb0faQ56k0=
Received: from SA9PR13CA0101.namprd13.prod.outlook.com (2603:10b6:806:24::16)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 18:52:54 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::d2) by SA9PR13CA0101.outlook.office365.com
 (2603:10b6:806:24::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Wed, 27 Mar 2024 18:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 18:52:54 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 13:52:53 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v2 3/4] RAS/AMD/ATL: Validate address map when information is gathered
Date: Wed, 27 Mar 2024 18:52:21 +0000
Message-ID: <20240327185222.98998-4-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 7570c347-534a-4615-5998-08dc4e8f1c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YQ5Tp+77wZXW7GI0UCuXgB83fRK3NQLBPTRadMZ8abE5rsDqfpvK+GpuxAE/wI74jFaN5zEdultuQ0e9+cOp/nowUIeY50+5bahMBoit4x7zdO+/azo1FaW24ruc+nURKLjUjSQgiatoYABQOXKPkXwNrvqfgFHg9Vjotc5BSUWI20DmOghaGufLlCLktY327azT9jOQObEcYdOImGGFpSucyc6xkBkWudggOEXOdia1D5el9oEsJEFP8THN9p+ojuYHw6RwUvWCXw5wQcYIW7GgK+9avdOXxqUOWF1c6y9Ir3MgbXy6NlUV9albxMgQjJtwitBWmSmrXgiTaLx/LP6VsT0doan0USNcHQ2Z0BkZgVyeFp4PoIHxkWOBlcqtv9bRWCKIgZMcdhZji8GhAqi62Bb835wMbybebSkIljrlK/OWoO8u2MCaL1fb6BEJmuIP1ES5DHu0mW4ALsfN9j4ya47KPnzKpVXjdA1Bc+//uzix7ge9e6fQutTXPCmlWFXhTmpin4AttjnW5BSavB459fUyXiUtqckK8XuLF3tWKTTl/wny5re/fOp2LwddNirrKYilE1zVkL+FS/B1gTYmm5zWKNH3i6i3rOGfA+YXGGT9YOwUyNLbswZvsK91yndgMgkOz1ofzerRsZ0U0pGlBFNdo3ZgbJqVT3Q6AE5iHYBv4ukFoj/A3F44+6w5DmxyjqQxamnsbza75cnQ/2HGpH5VrcOn06+wgz4TzDCjNG09IsTxbJr9CaK97ZrC
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 18:52:54.2287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7570c347-534a-4615-5998-08dc4e8f1c5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315

The address map will not change during translation so all checks to
validate the map can be moved to a single function that checks the map
at the time the information is gathered.

Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - New in v2.
---
 drivers/ras/amd/atl/dehash.c |  43 --------------
 drivers/ras/amd/atl/map.c    | 105 +++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 43 deletions(-)

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
index 8b908e8d7495..c7772733a363 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -642,6 +642,107 @@ static int get_global_map_data(struct addr_ctx *ctx)
 	return 0;
 }
 
+/*
+ * Verify the interleave bits are correct in the different interleaving
+ * settings.
+ *
+ * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
+ * respective interleaving is disabled.
+ */
+inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
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
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		if (ctx->map.num_intlv_sockets != 1 || !map_bits_valid(ctx, 8, 0, 1, 1))
+			goto out;
+		break;
+
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		if (ctx->map.num_intlv_sockets < 2 || !map_bits_valid(ctx, 8, 0, 1, 2))
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
@@ -678,5 +779,9 @@ int get_address_map(struct addr_ctx *ctx)
 
 	dump_address_map(&ctx->map);
 
+	ret = validate_address_map(ctx);
+	if (ret)
+		return ret;
+
 	return ret;
 }
-- 
2.34.1


