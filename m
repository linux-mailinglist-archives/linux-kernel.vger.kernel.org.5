Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175777FCFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjK2Hfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjK2Hfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:35:43 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C42CE1;
        Tue, 28 Nov 2023 23:35:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekMUrcI4/wdmtPDR8GbBGZDqoFkk0F3WNtfWhLJKl+WVg69OWGVGCdfEijed/tAPJPokBPvZwWGM3Xh0jYG5nmKcGWmRQA635iZBmwvNFH8Kp3D5kAY7SdawmaT0okbQzyi8YM8/kNKJDZiu8cTlYMgvcVzJUQp1H3cT2n4TTKrmaHupy9TG2WZksH88GXKlUIFMeNT0i8ROMGlK8d3jnNxGoifXBzxdZRdc6v+kKREoZW0Y72sonTcQYhmckGlvsnbFVqi+ayPdxxxuezBLM6ED3qWydz2+N434/ZIab4HvslCcA5UpK4QvGqYvouSt7wtmAggiGpyqDUiEYvu9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/00w9bCVf8aBKXKhGZqtYBiCRWr3vQWGy1Ian2PAoE=;
 b=eGjrzC93rDKSi3oxGFzVKVq5TMikdSas+s0iQ3Lv4KHDWdGohCZhgHZaxSYOoHWidJlImnG6lW1jTlgcrhj/+tIcly5TMzheRb0j1ZZhNVcdNJpYSS/RhaPnYWa67TLOupZhQTcBWA0CzlQ5Ws3azkxJSKJfuOErkYh9JSrQXomOkI27VJ4Q3hcK0nCd48Ktm17oET1CV/tKVbILp/FO1qndwBvgfak2atAYO2kEGSqLQ55TuVKujLcrSXoU45Rs2FNrOKHT92DSzHhFxjhRMuyeNfPdtVKJ/KGhkOClAvvjqaSjqowHK9LDE2LgejbKFNd8tbRrWlAHHawSYlEFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/00w9bCVf8aBKXKhGZqtYBiCRWr3vQWGy1Ian2PAoE=;
 b=UB3pCY5z3TJiHMyUYu3k+e0gN4r0ey/kD87FljhF6zgBnQGg5RLpN7QioR1awvC9lEteFPCNTxecYbZAMGRcUfrW1NojxEAKQSIUFiYj2xYikNk5GbYEI9PWVq4EONBaYBjMj0KHweIXcEOAmqMcfMdWywfussscJPyj3zr7mTU=
Received: from SJ0PR03CA0290.namprd03.prod.outlook.com (2603:10b6:a03:39e::25)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 07:35:47 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::2d) by SJ0PR03CA0290.outlook.office365.com
 (2603:10b6:a03:39e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Wed, 29 Nov 2023 07:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 07:35:46 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 01:35:43 -0600
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 1/6] RAS: Add Address Translation support for MI200
Date:   Wed, 29 Nov 2023 07:35:16 +0000
Message-ID: <20231129073521.2127403-2-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129073521.2127403-1-muralimk@amd.com>
References: <20231129073521.2127403-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b34f347-b0a5-4da3-d0e3-08dbf0adcd55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uG6V6tBe5JBTixiobVf5X/KG0HmxG4vkRe+GEUQqQybTPqZAmHc21AdNVq8eutbr8CsqSnuwpOVXZ9B6rRpcFvW7BFO6x+I4FV9b+LX8VBKCIcUiJsNbdEyTAj9uMGcuNpK083mt65L/ZNMOEmDoqMGcU2Lgk1quINZZT6agtC8TM9E9WS7u0zNhWt2ETZrxz8nOlcKSUZOCY2RyEW/veT8yLNbL31lOVYrTme/5qA5Do1R0678iUZnlHqfuckXIBaOWy1Y58LnLXcKt+ffus2aSSf9TDZYKAKnVu4zCv+XiifcWmbzXb5fyJbkUWFzI/Fba8nMO9AnecHgYZKIfAn3LOmf1pfqADR4VsOhMscSYF1v1kn8FGGiYVDQO77acnP6CKptHJOJ11kyBMzrvD6EQdvMnqDBRfuoY5krSpb9m/S5T2xEg1uDavXT/nqdYQTVTskL3eZnI7DEO09rT+ASQFAr+rYMb1I0HQWLMwgDqGwPjN13VJ3flMrAdCuN/5Bq4cRxjrv5qforQotlURUv+z89m9H9mPjRErb0Vhyo7CtXPJP0ZqVyYIOXQj5G+rjvq+du4Te6+7omMUqRZVoaN4IEtdLKvVwMcEfnYevzxnddAkSTRnNruR7WewPDeUkWRZV72pd1bz74iDWISbcvgCAQRIzWyBQpbuI3RXmMsduaBRrq55ujChXN26+xDqtqz/YeftLFW57jrGNakvL5MziX7EcF1bDB7y3sPh2xTYKy8+wYIQ1HksfGccaPm6J5sjTL3W+/5TE8FEVPPUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(2906002)(40480700001)(30864003)(5660300002)(40460700003)(81166007)(36860700001)(6666004)(8676002)(478600001)(54906003)(36756003)(7696005)(336012)(4326008)(8936002)(356005)(41300700001)(82740400003)(426003)(47076005)(16526019)(2616005)(83380400001)(70206006)(316002)(6916009)(70586007)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 07:35:46.6612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b34f347-b0a5-4da3-d0e3-08dbf0adcd55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add support for address translation on Data Fabric version 3.5
Add new interleaving modes for heterogeneous model support and
adjust how the DRAM address maps are found early in the
translation for certain cases.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Changes:
v1 -> v2 : None

 drivers/ras/amd/atl/dehash.c      |  60 +++++++++++++++++
 drivers/ras/amd/atl/denormalize.c |  11 +++-
 drivers/ras/amd/atl/internal.h    |  15 ++++-
 drivers/ras/amd/atl/map.c         | 105 +++++++++++++++++++++++++++++-
 drivers/ras/amd/atl/reg_fields.h  |  29 +++++++++
 drivers/ras/amd/atl/system.c      |   1 +
 6 files changed, 217 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
index e501f2e918d7..5760e6bca194 100644
--- a/drivers/ras/amd/atl/dehash.c
+++ b/drivers/ras/amd/atl/dehash.c
@@ -395,6 +395,61 @@ static int df4p5_dehash_addr(struct addr_ctx *ctx)
 	return 0;
 }
 
+/*
+ * MI200 hash bits
+ *				64K  2M  1G
+ * CSSelect[0] = XOR of addr{8,  16, 21, 30};
+ * CSSelect[1] = XOR of addr{9,  17, 22, 31};
+ * CSSelect[2] = XOR of addr{10, 18, 23, 32};
+ * CSSelect[3] = XOR of addr{11, 19, 24, 33}; - 16 and 32 channel only
+ * CSSelect[4] = XOR of addr{12, 20, 25, 34}; - 32 channel only
+ */
+static int mi200_dehash_addr(struct addr_ctx *ctx)
+{
+	u8 num_intlv_bits = ctx->map.total_intlv_bits;
+	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
+	u8 hashed_bit, intlv_bit, i;
+
+	/* Assert that interleave bit is 8. */
+	if (ctx->map.intlv_bit_pos != 8) {
+		pr_warn("%s: Invalid interleave bit: %u",
+			__func__, ctx->map.intlv_bit_pos);
+		return -EINVAL;
+	}
+
+	/* Assert that die interleaving is disabled. */
+	if (ctx->map.num_intlv_dies > 1) {
+		pr_warn("%s: Invalid number of interleave dies: %u",
+			__func__, ctx->map.num_intlv_dies);
+		return -EINVAL;
+	}
+
+	/* Assert that socket interleaving is disabled. */
+	if (ctx->map.num_intlv_sockets > 1) {
+		pr_warn("%s: Invalid number of interleave sockets: %u",
+			__func__, ctx->map.num_intlv_sockets);
+		return -EINVAL;
+	}
+
+	hash_ctl_64k	= FIELD_GET(DF3_HASH_CTL_64K, ctx->map.ctl);
+	hash_ctl_2M	= FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
+	hash_ctl_1G	= FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);
+
+	for (i = 0; i < num_intlv_bits; i++) {
+		intlv_bit = atl_get_bit(8 + i, ctx->ret_addr);
+
+		hashed_bit = intlv_bit;
+		hashed_bit ^= atl_get_bit(8 + i, ctx->ret_addr);
+		hashed_bit ^= atl_get_bit(16 + i, ctx->ret_addr) & hash_ctl_64k;
+		hashed_bit ^= atl_get_bit(21 + i, ctx->ret_addr) & hash_ctl_2M;
+		hashed_bit ^= atl_get_bit(30 + i, ctx->ret_addr) & hash_ctl_1G;
+
+		if (hashed_bit != intlv_bit)
+			ctx->ret_addr ^= BIT_ULL(8 + i);
+	}
+	return 0;
+}
+
 int dehash_address(struct addr_ctx *ctx)
 {
 	switch (ctx->map.intlv_mode) {
@@ -452,6 +507,11 @@ int dehash_address(struct addr_ctx *ctx)
 	case DF4p5_NPS1_16CHAN_2K_HASH:
 		return df4p5_dehash_addr(ctx);
 
+	case MI2_HASH_8CHAN:
+	case MI2_HASH_16CHAN:
+	case MI2_HASH_32CHAN:
+		return mi200_dehash_addr(ctx);
+
 	default:
 		ATL_BAD_INTLV_MODE(ctx->map.intlv_mode);
 		return -EINVAL;
diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index fe1480c8e0d8..03eb1eea68f9 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -16,7 +16,7 @@
  * Returns the Destination Fabric ID. This is the first (lowest)
  * CS Fabric ID used within a DRAM Address map.
  */
-static u16 get_dst_fabric_id(struct addr_ctx *ctx)
+u16 get_dst_fabric_id(struct addr_ctx *ctx)
 {
 	switch (df_cfg.rev) {
 	case DF2:
@@ -97,6 +97,9 @@ static u64 make_space_for_cs_id(struct addr_ctx *ctx)
 	case NOHASH_8CHAN:
 	case NOHASH_16CHAN:
 	case NOHASH_32CHAN:
+	case MI2_HASH_8CHAN:
+	case MI2_HASH_16CHAN:
+	case MI2_HASH_32CHAN:
 	case DF2_2CHAN_HASH:
 		return make_space_for_cs_id_at_intlv_bit(ctx);
 
@@ -233,6 +236,9 @@ static u16 calculate_cs_id(struct addr_ctx *ctx)
 	case DF3_COD4_2CHAN_HASH:
 	case DF3_COD2_4CHAN_HASH:
 	case DF3_COD1_8CHAN_HASH:
+	case MI2_HASH_8CHAN:
+	case MI2_HASH_16CHAN:
+	case MI2_HASH_32CHAN:
 	case DF2_2CHAN_HASH:
 		return get_cs_id_df2(ctx);
 
@@ -296,6 +302,9 @@ static u64 insert_cs_id(struct addr_ctx *ctx, u64 denorm_addr, u16 cs_id)
 	case NOHASH_8CHAN:
 	case NOHASH_16CHAN:
 	case NOHASH_32CHAN:
+	case MI2_HASH_8CHAN:
+	case MI2_HASH_16CHAN:
+	case MI2_HASH_32CHAN:
 	case DF2_2CHAN_HASH:
 		return insert_cs_id_at_intlv_bit(ctx, denorm_addr, cs_id);
 
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index f3888c8fd02d..0ce3fd9ef4d4 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -30,6 +30,12 @@
 /* Shift needed for adjusting register values to true values. */
 #define DF_DRAM_BASE_LIMIT_LSB		28
 
+/* Cache Coherent Moderator Instance Type value on register */
+#define DF_INST_TYPE_CCM		0
+
+/* Maximum possible number of DRAM maps within a Data Fabric. */
+#define DF_NUM_DRAM_MAPS_AVAILABLE	16
+
 /*
  * Glossary of acronyms used in address translation for Zen-based systems
  *
@@ -68,6 +74,9 @@ enum intlv_modes {
 	DF4_NPS1_12CHAN_HASH		= 0x15,
 	DF4_NPS2_5CHAN_HASH		= 0x16,
 	DF4_NPS1_10CHAN_HASH		= 0x17,
+	MI2_HASH_8CHAN			= 0x1C,
+	MI2_HASH_16CHAN			= 0x1D,
+	MI2_HASH_32CHAN			= 0x1E,
 	DF2_2CHAN_HASH			= 0x21,
 	/* DF4.5 modes are all IntLvNumChan + 0x20 */
 	DF4p5_NPS1_16CHAN_1K_HASH	= 0x2C,
@@ -94,8 +103,9 @@ enum intlv_modes {
 
 struct df_flags {
 	__u8	legacy_ficaa		: 1,
+		heterogeneous		: 1,
 		genoa_quirk		: 1,
-		__reserved_0		: 6;
+		__reserved_0		: 5;
 };
 
 struct df_config {
@@ -220,6 +230,9 @@ int determine_node_id(struct addr_ctx *ctx, u8 socket_num, u8 die_num);
 int get_address_map(struct addr_ctx *ctx);
 
 int denormalize_address(struct addr_ctx *ctx);
+
+u16 get_dst_fabric_id(struct addr_ctx *ctx);
+
 int dehash_address(struct addr_ctx *ctx);
 
 int norm_to_sys_addr(u8 socket_id, u8 die_id, u8 cs_inst_id, u64 *addr);
diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
index 05141da27028..cf6127b1387b 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -355,6 +355,101 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
 	}
 }
 
+static int find_moderator_instance_id(struct addr_ctx *ctx)
+{
+	u16 num_df_instances;
+	u32 reg;
+
+	/* Read D18F0x40 (FabricBlockInstanceCount). */
+	if (df_indirect_read_broadcast(0, 0, 0x40, &reg))
+		return -EINVAL;
+
+	num_df_instances = FIELD_GET(DF_BLOCK_INSTANCE_COUNT, reg);
+
+	for (ctx->inst_id = 0; ctx->inst_id < num_df_instances; ctx->inst_id++) {
+		/* Read D18F0x44 (FabricBlockInstanceInformation0). */
+		if (df_indirect_read_instance(0, 0, 0x44, ctx->inst_id, &reg))
+			return -EINVAL;
+
+		if (!reg)
+			continue;
+
+		/* Match on the first CCM instance. */
+		if (FIELD_GET(DF_INSTANCE_TYPE, reg) == DF_INST_TYPE_CCM)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int find_map_by_dst_fabric_id(struct addr_ctx *ctx)
+{
+	u64 mask = df_cfg.node_id_mask;
+
+	for (ctx->map.num = 0; ctx->map.num < DF_NUM_DRAM_MAPS_AVAILABLE ; ctx->map.num++) {
+		if (get_dram_addr_map(ctx))
+			return -EINVAL;
+
+		/*
+		 * Match if the Destination Fabric ID in this map is the same as
+		 * the Fabric ID for the target memory device.
+		 */
+		if ((get_dst_fabric_id(ctx) & mask) == (ctx->cs_fabric_id & mask))
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+/* UMC to CS mapping for MI200 die[0]s */
+u8 umc_to_cs_mapping_mi200_die0[] = { 28, 20, 24, 16, 12, 4, 8, 0,
+					6, 30, 2, 26, 22, 14, 18, 10,
+					19, 11, 15, 7, 3, 27, 31, 23,
+					9, 1, 5, 29, 25, 17, 21, 13};
+
+/* UMC to CS mapping for MI200 die[1]s */
+u8 umc_to_cs_mapping_mi200_die1[] = { 19, 11, 15, 7, 3, 27, 31, 23,
+					9, 1, 5, 29, 25, 17, 21, 13,
+					28, 20, 24, 16, 12, 4, 8, 0,
+					6, 30, 2, 26, 22, 14, 18, 10};
+
+static int get_umc_to_cs_mapping(struct addr_ctx *ctx)
+{
+	if (ctx->inst_id >= sizeof(umc_to_cs_mapping_mi200_die0))
+		return -EINVAL;
+
+	/*
+	 * MI200 has 2 dies and are enumerated alternatively
+	 * die0's are enumerated as node 2, 4, 6 and 8
+	 * die1's are enumerated as node 1, 3, 5 and 7
+	 */
+	if (ctx->node_id % 2)
+		ctx->inst_id = umc_to_cs_mapping_mi200_die1[ctx->inst_id];
+	else
+		ctx->inst_id = umc_to_cs_mapping_mi200_die0[ctx->inst_id];
+
+	return 0;
+}
+
+static int get_address_map_heterogeneous(struct addr_ctx *ctx)
+{
+	if (ctx->node_id >= amd_nb_num()) {
+		if (get_umc_to_cs_mapping(ctx))
+			return -EINVAL;
+	}
+
+	ctx->cs_fabric_id = ctx->inst_id;
+	ctx->cs_fabric_id |= ctx->node_id << df_cfg.node_id_shift;
+
+	if (find_moderator_instance_id(ctx))
+		return -EINVAL;
+
+	if (find_map_by_dst_fabric_id(ctx))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int lookup_cs_fabric_id(struct addr_ctx *ctx)
 {
 	u32 reg;
@@ -482,6 +577,7 @@ static u8 get_num_intlv_chan(enum intlv_modes intlv_mode)
 	case NOHASH_8CHAN:
 	case DF3_COD1_8CHAN_HASH:
 	case DF4_NPS1_8CHAN_HASH:
+	case MI2_HASH_8CHAN:
 	case DF4p5_NPS1_8CHAN_1K_HASH:
 	case DF4p5_NPS1_8CHAN_2K_HASH:
 		return 8;
@@ -494,6 +590,7 @@ static u8 get_num_intlv_chan(enum intlv_modes intlv_mode)
 	case DF4p5_NPS1_12CHAN_2K_HASH:
 		return 12;
 	case NOHASH_16CHAN:
+	case MI2_HASH_16CHAN:
 	case DF4p5_NPS1_16CHAN_1K_HASH:
 	case DF4p5_NPS1_16CHAN_2K_HASH:
 		return 16;
@@ -501,6 +598,7 @@ static u8 get_num_intlv_chan(enum intlv_modes intlv_mode)
 	case DF4p5_NPS0_24CHAN_2K_HASH:
 		return 24;
 	case NOHASH_32CHAN:
+	case MI2_HASH_32CHAN:
 		return 32;
 	default:
 		ATL_BAD_INTLV_MODE(intlv_mode);
@@ -645,8 +743,11 @@ int get_address_map(struct addr_ctx *ctx)
 {
 	int ret = 0;
 
-	/* TODO: Add special path for DF3.5 heterogeneous systems. */
-	ret = get_address_map_common(ctx);
+	/* Add special path for DF3.5 heterogeneous systems. */
+	if (df_cfg.flags.heterogeneous && df_cfg.rev == DF3p5)
+		ret = get_address_map_heterogeneous(ctx);
+	else
+		ret = get_address_map_common(ctx);
 	if (ret)
 		return ret;
 
diff --git a/drivers/ras/amd/atl/reg_fields.h b/drivers/ras/amd/atl/reg_fields.h
index d48470e12498..b85ab157773e 100644
--- a/drivers/ras/amd/atl/reg_fields.h
+++ b/drivers/ras/amd/atl/reg_fields.h
@@ -601,3 +601,32 @@
 #define DF2_SOCKET_ID_SHIFT	GENMASK(31, 28)
 #define DF3_SOCKET_ID_SHIFT	GENMASK(9, 8)
 #define DF4_SOCKET_ID_SHIFT	GENMASK(11, 8)
+
+/*
+ * Total number of instances of all the blocks in DF
+ *
+ * Access type: Broadcast
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x040 [Fabric Block Instance Count]
+ *	DF3	BlkInstCount	[7:0]
+ *	DF3p5	BlkInstCount	[7:0]
+ *	DF4	BlkInstCount	[7:0]
+ *	DF4p5	BlkInstCount	[9:0]
+ */
+#define DF_BLOCK_INSTANCE_COUNT	GENMASK(9, 0)
+
+/*
+ * Information on the block capabilities
+ *
+ * Access type: Broadcast
+ *
+ * Register
+ *	Rev	Fieldname	Bits
+ *
+ *	D18F0x044 [Fabric Block Instance Information 0]
+ *	DF3p5	BlkInstCount	[3:0]
+ */
+#define DF_INSTANCE_TYPE	GENMASK(3, 0)
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 86488138e120..656aac3f6c59 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -144,6 +144,7 @@ static int determine_df_rev_legacy(void)
 
 	if (FIELD_GET(DF4_COMPONENT_ID_MASK, fabric_id_mask0)) {
 		df_cfg.rev = DF3p5;
+		df_cfg.flags.heterogeneous = 1;
 
 		/* Read D18F1x154 (SystemFabricIdMask1) */
 		if (df_indirect_read_broadcast(0, 1, 0x154, &fabric_id_mask1))
-- 
2.25.1

