Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4337D63D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjJYHqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjJYHpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:45:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F81985;
        Wed, 25 Oct 2023 00:35:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKScIcaXdIPkJ7+xCWXdYGsE81ZswcWHQ6v25SH+YZ1qyUqH/0VF4YCm0Kp2pmOHCHPw4o/IlSM9Kbs6v2og1FhbK72vMySVENUE42OnfYL/8ychfU6p1ew21Jd4niB2cLx3Csym0s8aVMl6b3fJFI4YtUBDjP7TmBKBuHbkXAtLUZKTSHr5uqztAuL0LYrRb8wb3gqjf1eSFUYxPMZtIVFgUr7207ziLefGLNiBdcBWnI+1SH8habWfQ4ZuDN8TybypIiRAFJjybj4eYE3lEWqaSylPzLl1AeFdqYoEj1g9Pvau0mR0qjyGSpvB3ve0960kuAagcvU65T2o1azkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+pq2U2vQF2d5lPXaNKhDXXeYI5ztpHBeU+pA8vLqYg=;
 b=UFzpYmm4hQOwsWB8IoRzYQzKvNwbeGiilaHn2hixN7eU8/0e6lNwWTr9ZXsb+PQEcq1ou06HDKQehR91jYq5ULBnC7wHs2EcgbBNZPkJ+vOgs9Tkgr/wVpV1oY5hdff42VZkBWVOaHpMf6cwGjQTONEn/ZfWaqW/ThcNnieWALla0rT2l7uhPmEC8OyMizG6qOBiTBGI9HpjC6w+x7VAmIhxsjydyMz/teUgjvvfYBpy69Vrf4w7TLuKJyNXe5NrIfwEOWuhnTQgLYMoN+15+9zqwmu6O/rjRIOfMOetTCRSJuJGilyerrRGZQSzVrZiSqKYyfqKfyqKZCo2yy6RYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+pq2U2vQF2d5lPXaNKhDXXeYI5ztpHBeU+pA8vLqYg=;
 b=Nk4bE+az8vq9eGgeyiD8CLuStAlVRtGCK/1LgibuTwpVACVlKcDuOq+OwLS4BYMIGYT9rUpAa07DEXzvF0uY5CWJ2bd8pQK0NimewaGEsGxSeI0rpm0ZFIxABMjYnAe5STcvhEfdwDKIxNf99MOVbuMlZRsuVhsuB/W2UpD8GnU=
Received: from DM6PR10CA0032.namprd10.prod.outlook.com (2603:10b6:5:60::45) by
 PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 07:35:15 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::8b) by DM6PR10CA0032.outlook.office365.com
 (2603:10b6:5:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 07:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 07:35:15 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 02:35:12 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 2/7] RAS: Add Address Translation support for MI300
Date:   Wed, 25 Oct 2023 07:33:34 +0000
Message-ID: <20231025073339.630093-3-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025073339.630093-1-muralimk@amd.com>
References: <20231025073339.630093-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: f0661b44-a619-4bf1-0d1a-08dbd52cee12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAf6DdHdkg1r31d3a/93axZsY+/CiAD26wqPuAqLHcskvtJTmjKMCJtOYp6Ya1Gc3UtT4WIVha+vMPHxC75X9re9WnEFFeHmsVtoxWO2jCzN87X5+MrUNCa0zKhea0QAeHPvsKQfq5Zv17jiP5+OLckC56XZgKnj3GNCCJyajpAxiJ6TOKIs/FgLAa6edRR0AD5K3443h06W8wHmDI5ZI8yPs43hTE3vUwXkQJOfWT/h+1QkPRyYTf2Eh2bfNTsW7fqpGhiyf/ojUt83GmY85/8u5Sfhkl8aUyB+RBzOkkuIDnRUjhGHkI6/WjMJIfvFAJCSJKhRF4xctzcS9r469uwlOKvoMlZ+miQb6JV51XMjUjdUJ9rxNAZXhTzBuZwKGAtrwsEI0EmirA3tdKmMORH/4r3uB76VToaLv7FGX0CC+Weaw8w8TAcdt2YbdJWlvBR+XFy9NyF19yiRJXyi3MlrC9vOr73x73HDMZqv41BAsP7uwBBcJkZIN4lDF38TssIjYDv1ThN983RhjIM1FN4O+L0U5NamEw2uVMoFBMkQcYq+rkc0iES8ecK/5oBrCjC6yi0dXm95WyPjqWaxAQjhCJ/k6I9xe2b6vNXdLfOsr/+75Ix3j8D9Wt4wDowDMdEbURkC+daO8EroQIblr31ZMhzjLhINYvoeEirG/7RbRnGfO1XWSwpuXxXrv2Ek+Dr+0X6+KDlxpavFOa5gYnbg2uTP8zddiWDH3yqlRJMX/UO1lY7W1MmWO4yJxExUoqm5PHfufMsmXvLFk0p5tQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(40480700001)(7696005)(6666004)(478600001)(1076003)(2616005)(70586007)(70206006)(110136005)(54906003)(36756003)(316002)(36860700001)(47076005)(426003)(336012)(16526019)(26005)(82740400003)(356005)(81166007)(83380400001)(8676002)(8936002)(4326008)(5660300002)(2906002)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:35:15.1557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0661b44-a619-4bf1-0d1a-08dbd52cee12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add support for address translation on Data Fabric version 4.5
for MI300 systems.
Add new interleaving modes for APU model support  and adjust how
the DRAM address maps are found early in the translation for
certain cases.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/atl/core.c        |  5 +-
 drivers/ras/amd/atl/dehash.c      | 89 +++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/denormalize.c | 79 +++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    | 12 ++++-
 drivers/ras/amd/atl/map.c         | 53 +++++++++++-------
 drivers/ras/amd/atl/reg_fields.h  |  5 ++
 drivers/ras/amd/atl/system.c      |  3 ++
 drivers/ras/amd/atl/umc.c         | 28 +++++++++-
 8 files changed, 250 insertions(+), 24 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 8c997c7ae8a6..cbbaf82f1ee1 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -56,7 +56,7 @@ static int add_legacy_hole(struct addr_ctx *ctx)
 	if (df_cfg.rev >= DF4)
 		func = 7;
 
-	if (df_indirect_read_broadcast(ctx->node_id, func, 0x104, &dram_hole_base))
+	if (df_indirect_read_broadcast(ctx->df_acc_id, func, 0x104, &dram_hole_base))
 		return -EINVAL;
 
 	dram_hole_base &= DF_DRAM_HOLE_BASE_MASK;
@@ -103,7 +103,7 @@ static bool late_hole_remove(struct addr_ctx *ctx)
 	return false;
 }
 
-int norm_to_sys_addr(u8 socket_id, u8 die_id, u8 cs_inst_id, u64 *addr)
+int norm_to_sys_addr(u16 df_acc_id, u8 socket_id, u8 die_id, u8 cs_inst_id, u64 *addr)
 {
 	struct addr_ctx ctx;
 
@@ -115,6 +115,7 @@ int norm_to_sys_addr(u8 socket_id, u8 die_id, u8 cs_inst_id, u64 *addr)
 	/* We start from the normalized address */
 	ctx.ret_addr = *addr;
 	ctx.inst_id = cs_inst_id;
+	ctx.df_acc_id = df_acc_id;
 
 	if (determine_node_id(&ctx, socket_id, die_id)) {
 		pr_warn("Failed to determine Node ID");
diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
index 5760e6bca194..ddfada2eb7b4 100644
--- a/drivers/ras/amd/atl/dehash.c
+++ b/drivers/ras/amd/atl/dehash.c
@@ -450,6 +450,90 @@ static int mi200_dehash_addr(struct addr_ctx *ctx)
 	return 0;
 }
 
+/*
+ * MI300 hash bits
+ *			         4K 64K  2M  1G  1T  1T
+ * CSSelect[0] = XOR of addr{8,  12, 15, 22, 29, 36, 43}
+ * CSSelect[1] = XOR of addr{9,  13, 16, 23, 30, 37, 44}
+ * CSSelect[2] = XOR of addr{10, 14, 17, 24, 31, 38, 45}
+ * CSSelect[3] = XOR of addr{11,     18, 25, 32, 39, 46}
+ * CSSelect[4] = XOR of addr{14,     19, 26, 33, 40, 47} aka Stack
+ * DieID[0]    = XOR of addr{12,     20, 27, 34, 41    }
+ * DieID[1]    = XOR of addr{13,     21, 28, 35, 42    }
+ */
+static int mi300_dehash_addr(struct addr_ctx *ctx)
+{
+	bool hash_ctl_4k, hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T;
+	u8 hashed_bit, intlv_bit, num_intlv_bits, base_bit, i;
+
+	if (ctx->map.intlv_bit_pos != 8) {
+		pr_warn("%s: Invalid interleave bit: %u",
+			__func__, ctx->map.intlv_bit_pos);
+		return -EINVAL;
+	}
+
+	if (ctx->map.num_intlv_sockets > 1) {
+		pr_warn("%s: Invalid number of interleave sockets: %u",
+			__func__, ctx->map.num_intlv_sockets);
+		return -EINVAL;
+	}
+
+	hash_ctl_4k	= FIELD_GET(DF4p5_HASH_CTL_4K, ctx->map.ctl);
+	hash_ctl_64k	= FIELD_GET(DF4p5_HASH_CTL_64K, ctx->map.ctl);
+	hash_ctl_2M	= FIELD_GET(DF4p5_HASH_CTL_2M, ctx->map.ctl);
+	hash_ctl_1G	= FIELD_GET(DF4p5_HASH_CTL_1G, ctx->map.ctl);
+	hash_ctl_1T	= FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
+
+	/* Channel bits */
+	num_intlv_bits = ilog2(ctx->map.num_intlv_chan);
+
+	for (i = 0; i < num_intlv_bits; i++) {
+		base_bit = 8 + i;
+
+		/* CSSelect[4] jumps to a base bit of 14. */
+		if (i == 4)
+			base_bit = 14;
+
+		intlv_bit = atl_get_bit(base_bit, ctx->ret_addr);
+
+		hashed_bit = intlv_bit;
+
+		/* 4k hash bit only applies to the first 3 bits. */
+		if (i <= 2)
+			hashed_bit ^= atl_get_bit(12 + i, ctx->ret_addr) & hash_ctl_4k;
+
+		hashed_bit ^= atl_get_bit(15 + i, ctx->ret_addr) & hash_ctl_64k;
+		hashed_bit ^= atl_get_bit(22 + i, ctx->ret_addr) & hash_ctl_2M;
+		hashed_bit ^= atl_get_bit(29 + i, ctx->ret_addr) & hash_ctl_1G;
+		hashed_bit ^= atl_get_bit(36 + i, ctx->ret_addr) & hash_ctl_1T;
+		hashed_bit ^= atl_get_bit(43 + i, ctx->ret_addr) & hash_ctl_1T;
+
+		if (hashed_bit != intlv_bit)
+			ctx->ret_addr ^= BIT_ULL(base_bit);
+	}
+
+	/* Die bits */
+	num_intlv_bits = ilog2(ctx->map.num_intlv_dies);
+
+	for (i = 0; i < num_intlv_bits; i++) {
+		base_bit = 12 + i;
+
+		intlv_bit = atl_get_bit(base_bit, ctx->ret_addr);
+
+		hashed_bit = intlv_bit;
+
+		hashed_bit ^= atl_get_bit(20 + i, ctx->ret_addr) & hash_ctl_64k;
+		hashed_bit ^= atl_get_bit(27 + i, ctx->ret_addr) & hash_ctl_2M;
+		hashed_bit ^= atl_get_bit(34 + i, ctx->ret_addr) & hash_ctl_1G;
+		hashed_bit ^= atl_get_bit(41 + i, ctx->ret_addr) & hash_ctl_1T;
+
+		if (hashed_bit != intlv_bit)
+			ctx->ret_addr ^= BIT_ULL(base_bit);
+	}
+
+	return 0;
+}
+
 int dehash_address(struct addr_ctx *ctx)
 {
 	switch (ctx->map.intlv_mode) {
@@ -512,6 +596,11 @@ int dehash_address(struct addr_ctx *ctx)
 	case MI2_HASH_32CHAN:
 		return mi200_dehash_addr(ctx);
 
+	case MI3_HASH_8CHAN:
+	case MI3_HASH_16CHAN:
+	case MI3_HASH_32CHAN:
+		return mi300_dehash_addr(ctx);
+
 	default:
 		ATL_BAD_INTLV_MODE(ctx->map.intlv_mode);
 		return -EINVAL;
diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index 03eb1eea68f9..b233a26f68fc 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -85,6 +85,46 @@ static u64 make_space_for_cs_id_split_2_1(struct addr_ctx *ctx)
 	return expand_bits(12, ctx->map.total_intlv_bits - 1, denorm_addr);
 }
 
+/*
+ * Make space for CS ID at bits [14:8] as follows:
+ *
+ * 8 channels	-> bits [10:8]
+ * 16 channels	-> bits [11:8]
+ * 32 channels	-> bits [14,11:8]
+ *
+ * 1 die	-> N/A
+ * 2 dies	-> bit  [12]
+ * 4 dies	-> bits [13:12]
+ */
+static u64 make_space_for_cs_id_mi300(struct addr_ctx *ctx)
+{
+	u8 num_intlv_bits = order_base_2(ctx->map.num_intlv_chan);
+	u64 denorm_addr;
+
+	if (ctx->map.intlv_bit_pos != 8) {
+		pr_warn("%s: Invalid interleave bit: %u", __func__, ctx->map.intlv_bit_pos);
+		return -1;
+	}
+
+	/* Channel bits. Covers up to 4 bits at [11:8]. */
+	if (num_intlv_bits > 4)
+		denorm_addr = expand_bits(8, 4, ctx->ret_addr);
+	else
+		denorm_addr = expand_bits(ctx->map.intlv_bit_pos, num_intlv_bits, ctx->ret_addr);
+
+	/* Die bits. Always starts at [12]. */
+	if (ctx->map.num_intlv_dies > 1)
+		denorm_addr = expand_bits(12,
+					  ctx->map.total_intlv_bits - num_intlv_bits,
+					  denorm_addr);
+
+	/* Additional channel bit at [14]. */
+	if (num_intlv_bits > 4)
+		denorm_addr = expand_bits(14, 1, denorm_addr);
+
+	return denorm_addr;
+}
+
 /*
  * Take the current calculated address and shift enough bits in the middle
  * to make a gap where the interleave bits will be inserted.
@@ -116,6 +156,11 @@ static u64 make_space_for_cs_id(struct addr_ctx *ctx)
 	case DF4p5_NPS1_16CHAN_2K_HASH:
 		return make_space_for_cs_id_split_2_1(ctx);
 
+	case MI3_HASH_8CHAN:
+	case MI3_HASH_16CHAN:
+	case MI3_HASH_32CHAN:
+		return make_space_for_cs_id_mi300(ctx);
+
 	case DF4p5_NPS2_4CHAN_1K_HASH:
 		//TODO
 	case DF4p5_NPS1_8CHAN_1K_HASH:
@@ -219,6 +264,32 @@ static u16 get_cs_id_df4(struct addr_ctx *ctx)
 	return cs_id;
 }
 
+/*
+ * MI300 hash has:
+ * (C)hannel[3:0]	= cs_id[3:0]
+ * (S)tack[0]		= cs_id[4]
+ * (D)ie[1:0]		= cs_id[6:5]
+ *
+ * Hashed cs_id is swizzled so that Stack bit is at the end.
+ * cs_id = SDDCCCC
+ */
+static u16 get_cs_id_mi300(struct addr_ctx *ctx)
+{
+	u8 channel_bits, die_bits, stack_bit;
+	u16 die_id;
+
+	/* Subtract the "base" Destination Fabric ID. */
+	ctx->cs_fabric_id -= get_dst_fabric_id(ctx);
+
+	die_id = (ctx->cs_fabric_id & df_cfg.die_id_mask) >> df_cfg.die_id_shift;
+
+	channel_bits	= FIELD_GET(GENMASK(3, 0), ctx->cs_fabric_id);
+	stack_bit	= FIELD_GET(BIT(4), ctx->cs_fabric_id) << 6;
+	die_bits	= die_id << 4;
+
+	return stack_bit | die_bits | channel_bits;
+}
+
 /*
  * Derive the correct CS ID that represents the interleave bits
  * used within the system physical address. This accounts for the
@@ -252,6 +323,11 @@ static u16 calculate_cs_id(struct addr_ctx *ctx)
 	case DF4p5_NPS1_16CHAN_2K_HASH:
 		return get_cs_id_df4(ctx);
 
+	case MI3_HASH_8CHAN:
+	case MI3_HASH_16CHAN:
+	case MI3_HASH_32CHAN:
+		return get_cs_id_mi300(ctx);
+
 	/* CS ID is simply the CS Fabric ID adjusted by the Destination Fabric ID. */
 	case DF4p5_NPS2_4CHAN_1K_HASH:
 	case DF4p5_NPS1_8CHAN_1K_HASH:
@@ -305,6 +381,9 @@ static u64 insert_cs_id(struct addr_ctx *ctx, u64 denorm_addr, u16 cs_id)
 	case MI2_HASH_8CHAN:
 	case MI2_HASH_16CHAN:
 	case MI2_HASH_32CHAN:
+	case MI3_HASH_8CHAN:
+	case MI3_HASH_16CHAN:
+	case MI3_HASH_32CHAN:
 	case DF2_2CHAN_HASH:
 		return insert_cs_id_at_intlv_bit(ctx, denorm_addr, cs_id);
 
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 33905933e31e..a5b13e611a72 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -27,8 +27,12 @@
 /* PCI IDs for Genoa DF Function 0. */
 #define DF_FUNC0_ID_GENOA		0x14AD1022
 
+/* PCI IDs for MI300 DF Function 0. */
+#define DF_FUNC0_ID_MI300		0x15281022
+
 /* Shift needed for adjusting register values to true values. */
 #define DF_DRAM_BASE_LIMIT_LSB		28
+#define MI300_DRAM_LIMIT_LSB		20
 
 /* Cache Coherent Moderator Instnce Type value on register */
 #define DF_INST_TYPE_CCM		0
@@ -74,6 +78,9 @@ enum intlv_modes {
 	DF4_NPS1_12CHAN_HASH		= 0x15,
 	DF4_NPS2_5CHAN_HASH		= 0x16,
 	DF4_NPS1_10CHAN_HASH		= 0x17,
+	MI3_HASH_8CHAN			= 0x18,
+	MI3_HASH_16CHAN			= 0x19,
+	MI3_HASH_32CHAN			= 0x1A,
 	MI2_HASH_8CHAN			= 0x1C,
 	MI2_HASH_16CHAN			= 0x1D,
 	MI2_HASH_32CHAN			= 0x1E,
@@ -219,6 +226,9 @@ struct addr_ctx {
 	 * System-wide ID that includes 'node' bits.
 	 */
 	u16 cs_fabric_id;
+
+	/* ID calculated from topology */
+	u16 df_acc_id;
 };
 
 int df_indirect_read_instance(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo);
@@ -235,7 +245,7 @@ u16 get_dst_fabric_id(struct addr_ctx *ctx);
 
 int dehash_address(struct addr_ctx *ctx);
 
-int norm_to_sys_addr(u8 socket_id, u8 die_id, u8 cs_inst_id, u64 *addr);
+int norm_to_sys_addr(u16 df_acc_id, u8 socket_id, u8 die_id, u8 cs_inst_id, u64 *addr);
 
 /*
  * Helper to use test_bit() without needing to do
diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
index 9326f6a6b6c3..9e9d97e87c69 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -63,6 +63,10 @@ static int df4p5_get_intlv_mode(struct addr_ctx *ctx)
 	if (ctx->map.intlv_mode <= NOHASH_32CHAN)
 		return 0;
 
+	if (ctx->map.intlv_mode >= MI3_HASH_8CHAN &&
+	    ctx->map.intlv_mode <= MI3_HASH_32CHAN)
+		return 0;
+
 	/*
 	 * Modes matching the ranges above are returned as-is.
 	 *
@@ -117,6 +121,9 @@ static u64 get_hi_addr_offset(u32 reg_dram_offset)
 		ATL_BAD_DF_REV;
 	}
 
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		shift = MI300_DRAM_LIMIT_LSB;
+
 	return hi_addr_offset << shift;
 }
 
@@ -138,13 +145,13 @@ static int get_dram_offset(struct addr_ctx *ctx, bool *enabled, u64 *norm_offset
 
 	if (df_cfg.rev >= DF4) {
 		/* Read D18F7x140 (DramOffset) */
-		if (df_indirect_read_instance(ctx->node_id, 7, 0x140 + (4 * map_num),
+		if (df_indirect_read_instance(ctx->df_acc_id, 7, 0x140 + (4 * map_num),
 					      ctx->inst_id, &reg_dram_offset))
 			return -EINVAL;
 
 	} else {
 		/* Read D18F0x1B4 (DramOffset) */
-		if (df_indirect_read_instance(ctx->node_id, 0, 0x1B4 + (4 * map_num),
+		if (df_indirect_read_instance(ctx->df_acc_id, 0, 0x1B4 + (4 * map_num),
 					      ctx->inst_id, &reg_dram_offset))
 			return -EINVAL;
 	}
@@ -170,7 +177,7 @@ static int df3_6ch_get_dram_addr_map(struct addr_ctx *ctx)
 		offset = 0x68;
 
 	/* Read D18F0x06{0,8} (DF::Skt0CsTargetRemap0)/(DF::Skt0CsTargetRemap1) */
-	if (df_indirect_read_broadcast(ctx->node_id, 0, offset, &reg))
+	if (df_indirect_read_broadcast(ctx->df_acc_id, 0, offset, &reg))
 		return -EINVAL;
 
 	/* Save 8 remap entries. */
@@ -191,12 +198,12 @@ static int df3_6ch_get_dram_addr_map(struct addr_ctx *ctx)
 static int df2_get_dram_addr_map(struct addr_ctx *ctx)
 {
 	/* Read D18F0x110 (DramBaseAddress). */
-	if (df_indirect_read_instance(ctx->node_id, 0, 0x110 + (8 * ctx->map.num),
+	if (df_indirect_read_instance(ctx->df_acc_id, 0, 0x110 + (8 * ctx->map.num),
 				      ctx->inst_id, &ctx->map.base))
 		return -EINVAL;
 
 	/* Read D18F0x114 (DramLimitAddress). */
-	if (df_indirect_read_instance(ctx->node_id, 0, 0x114 + (8 * ctx->map.num),
+	if (df_indirect_read_instance(ctx->df_acc_id, 0, 0x114 + (8 * ctx->map.num),
 				      ctx->inst_id, &ctx->map.limit))
 		return -EINVAL;
 
@@ -209,7 +216,7 @@ static int df3_get_dram_addr_map(struct addr_ctx *ctx)
 		return -EINVAL;
 
 	/* Read D18F0x3F8 (DfGlobalCtl). */
-	if (df_indirect_read_instance(ctx->node_id, 0, 0x3F8,
+	if (df_indirect_read_instance(ctx->df_acc_id, 0, 0x3F8,
 				      ctx->inst_id, &ctx->map.ctl))
 		return -EINVAL;
 
@@ -222,22 +229,22 @@ static int df4_get_dram_addr_map(struct addr_ctx *ctx)
 	u32 remap_reg;
 
 	/* Read D18F7xE00 (DramBaseAddress). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0xE00 + (16 * ctx->map.num),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0xE00 + (16 * ctx->map.num),
 				      ctx->inst_id, &ctx->map.base))
 		return -EINVAL;
 
 	/* Read D18F7xE04 (DramLimitAddress). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0xE04 + (16 * ctx->map.num),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0xE04 + (16 * ctx->map.num),
 				      ctx->inst_id, &ctx->map.limit))
 		return -EINVAL;
 
 	/* Read D18F7xE08 (DramAddressCtl). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0xE08 + (16 * ctx->map.num),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0xE08 + (16 * ctx->map.num),
 				      ctx->inst_id, &ctx->map.ctl))
 		return -EINVAL;
 
 	/* Read D18F7xE0C (DramAddressIntlv). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0xE0C + (16 * ctx->map.num),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0xE0C + (16 * ctx->map.num),
 				      ctx->inst_id, &ctx->map.intlv))
 		return -EINVAL;
 
@@ -252,7 +259,7 @@ static int df4_get_dram_addr_map(struct addr_ctx *ctx)
 	remap_sel = FIELD_GET(DF4_REMAP_SEL, ctx->map.ctl);
 
 	/* Read D18F7x180 (CsTargetRemap0A). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0x180 + (8 * remap_sel),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0x180 + (8 * remap_sel),
 				      ctx->inst_id, &remap_reg))
 		return -EINVAL;
 
@@ -261,7 +268,7 @@ static int df4_get_dram_addr_map(struct addr_ctx *ctx)
 		ctx->map.remap_array[i] = (remap_reg >> (j * shift)) & mask;
 
 	/* Read D18F7x184 (CsTargetRemap0B). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0x184 + (8 * remap_sel),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0x184 + (8 * remap_sel),
 				      ctx->inst_id, &remap_reg))
 		return -EINVAL;
 
@@ -278,22 +285,22 @@ static int df4p5_get_dram_addr_map(struct addr_ctx *ctx)
 	u32 remap_reg;
 
 	/* Read D18F7x200 (DramBaseAddress). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0x200 + (16 * ctx->map.num),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0x200 + (16 * ctx->map.num),
 				      ctx->inst_id, &ctx->map.base))
 		return -EINVAL;
 
 	/* Read D18F7x204 (DramLimitAddress). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0x204 + (16 * ctx->map.num),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0x204 + (16 * ctx->map.num),
 				      ctx->inst_id, &ctx->map.limit))
 		return -EINVAL;
 
 	/* Read D18F7x208 (DramAddressCtl). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0x208 + (16 * ctx->map.num),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0x208 + (16 * ctx->map.num),
 				      ctx->inst_id, &ctx->map.ctl))
 		return -EINVAL;
 
 	/* Read D18F7x20C (DramAddressIntlv). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0x20C + (16 * ctx->map.num),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0x20C + (16 * ctx->map.num),
 				      ctx->inst_id, &ctx->map.intlv))
 		return -EINVAL;
 
@@ -308,7 +315,7 @@ static int df4p5_get_dram_addr_map(struct addr_ctx *ctx)
 	remap_sel = FIELD_GET(DF4_REMAP_SEL, ctx->map.ctl);
 
 	/* Read D18F7x180 (CsTargetRemap0A). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0x180 + (24 * remap_sel),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0x180 + (24 * remap_sel),
 				      ctx->inst_id, &remap_reg))
 		return -EINVAL;
 
@@ -317,7 +324,7 @@ static int df4p5_get_dram_addr_map(struct addr_ctx *ctx)
 		ctx->map.remap_array[i] = (remap_reg >> (j * shift)) & mask;
 
 	/* Read D18F7x184 (CsTargetRemap0B). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0x184 + (24 * remap_sel),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0x184 + (24 * remap_sel),
 				      ctx->inst_id, &remap_reg))
 		return -EINVAL;
 
@@ -326,7 +333,7 @@ static int df4p5_get_dram_addr_map(struct addr_ctx *ctx)
 		ctx->map.remap_array[i] = (remap_reg >> (j * shift)) & mask;
 
 	/* Read D18F7x188 (CsTargetRemap0C). */
-	if (df_indirect_read_instance(ctx->node_id, 7, 0x188 + (24 * remap_sel),
+	if (df_indirect_read_instance(ctx->df_acc_id, 7, 0x188 + (24 * remap_sel),
 				      ctx->inst_id, &remap_reg))
 		return -EINVAL;
 
@@ -455,7 +462,7 @@ static int lookup_cs_fabric_id(struct addr_ctx *ctx)
 	u32 reg;
 
 	/* Read D18F0x50 (FabricBlockInstanceInformation3). */
-	if (df_indirect_read_instance(ctx->node_id, 0, 0x50, ctx->inst_id, &reg))
+	if (df_indirect_read_instance(ctx->df_acc_id, 0, 0x50, ctx->inst_id, &reg))
 		return -EINVAL;
 
 	if (df_cfg.rev < DF4p5)
@@ -463,6 +470,9 @@ static int lookup_cs_fabric_id(struct addr_ctx *ctx)
 	else
 		ctx->cs_fabric_id = FIELD_GET(DF4p5_CS_FABRIC_ID, reg);
 
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		ctx->cs_fabric_id |= ctx->node_id << df_cfg.node_id_shift;
+
 	return 0;
 }
 
@@ -578,6 +588,7 @@ static u8 get_num_intlv_chan(enum intlv_modes intlv_mode)
 	case DF3_COD1_8CHAN_HASH:
 	case DF4_NPS1_8CHAN_HASH:
 	case MI2_HASH_8CHAN:
+	case MI3_HASH_8CHAN:
 	case DF4p5_NPS1_8CHAN_1K_HASH:
 	case DF4p5_NPS1_8CHAN_2K_HASH:
 		return 8;
@@ -591,6 +602,7 @@ static u8 get_num_intlv_chan(enum intlv_modes intlv_mode)
 		return 12;
 	case NOHASH_16CHAN:
 	case MI2_HASH_16CHAN:
+	case MI3_HASH_16CHAN:
 	case DF4p5_NPS1_16CHAN_1K_HASH:
 	case DF4p5_NPS1_16CHAN_2K_HASH:
 		return 16;
@@ -599,6 +611,7 @@ static u8 get_num_intlv_chan(enum intlv_modes intlv_mode)
 		return 24;
 	case NOHASH_32CHAN:
 	case MI2_HASH_32CHAN:
+	case MI3_HASH_32CHAN:
 		return 32;
 	default:
 		ATL_BAD_INTLV_MODE(intlv_mode);
diff --git a/drivers/ras/amd/atl/reg_fields.h b/drivers/ras/amd/atl/reg_fields.h
index b85ab157773e..c3853a25217b 100644
--- a/drivers/ras/amd/atl/reg_fields.h
+++ b/drivers/ras/amd/atl/reg_fields.h
@@ -251,6 +251,11 @@
 #define DF4_HASH_CTL_2M			BIT(9)
 #define DF4_HASH_CTL_1G			BIT(10)
 #define DF4_HASH_CTL_1T			BIT(15)
+#define DF4p5_HASH_CTL_4K		BIT(7)
+#define DF4p5_HASH_CTL_64K		BIT(8)
+#define DF4p5_HASH_CTL_2M		BIT(9)
+#define DF4p5_HASH_CTL_1G		BIT(10)
+#define DF4p5_HASH_CTL_1T		BIT(15)
 
 /*
  * High Address Offset
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 656aac3f6c59..d80f24798a1e 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -124,6 +124,9 @@ static int df4_determine_df_rev(u32 reg)
 	if (reg == DF_FUNC0_ID_GENOA)
 		df_cfg.flags.genoa_quirk = 1;
 
+	if (reg == DF_FUNC0_ID_MI300)
+		df_cfg.flags.heterogeneous = 1;
+
 	return df4_get_fabric_id_mask_registers();
 }
 
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 80030db6b8a5..f334be0dc034 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -17,8 +17,16 @@ static u8 get_socket_id(struct mce *m)
 	return m->socketid;
 }
 
+#define MCA_IPID_INST_ID_HI	GENMASK_ULL(47, 44)
 static u8 get_die_id(struct mce *m)
 {
+	/* The "AMD Node ID" is provided in MCA_IPID[InstanceIdHi] */
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous) {
+		u8 node_id = FIELD_GET(MCA_IPID_INST_ID_HI, m->ipid);
+
+		return node_id / 4;
+	}
+
 	/*
 	 * For CPUs, this is the AMD Node ID modulo the number
 	 * of AMD Nodes per socket.
@@ -37,14 +45,32 @@ static u8 get_cs_inst_id(struct mce *m)
 	return FIELD_GET(UMC_CHANNEL_NUM, m->ipid);
 }
 
+/*
+ * Use CPU's AMD Node ID for all cases.
+ *
+ * This is needed to read DF registers which can only be
+ * done on CPU-attached DFs even in heterogeneous cases.
+ *
+ * Future systems may report MCA errors across AMD Nodes.
+ * For example, errors from CPU socket 1 are reported to a
+ * CPU on socket 0. When this happens, the assumption below
+ * will break. But the AMD Node ID will be reported in
+ * MCA_IPID[InstanceIdHi] at that time.
+ */
+static u16 get_df_acc_id(struct mce *m)
+{
+	return topology_die_id(m->extcpu);
+}
+
 int umc_mca_addr_to_sys_addr(struct mce *m, u64 *sys_addr)
 {
 	u8 cs_inst_id = get_cs_inst_id(m);
 	u8 socket_id = get_socket_id(m);
 	u64 addr = get_norm_addr(m);
 	u8 die_id = get_die_id(m);
+	u16 df_acc_id = get_df_acc_id(m);
 
-	if (norm_to_sys_addr(socket_id, die_id, cs_inst_id, &addr))
+	if (norm_to_sys_addr(df_acc_id, socket_id, die_id, cs_inst_id, &addr))
 		return -EINVAL;
 
 	*sys_addr = addr;
-- 
2.25.1

