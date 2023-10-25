Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32D47D6386
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjJYHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjJYHhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:37:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8142B386F;
        Wed, 25 Oct 2023 00:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsTepsn5cDVqYP6yKNteSVPcxO96ydRMOXv3rNaYNEgjOptyL8Okjkf7tl6Pu6qIK9iLRPcu5fE6uOoPENmy2YKSkVkWLVEBGtDk+/MQV9hSFaBd1B1Qj1h4buc4eyC/UolNJGwE1bwWA0XU1D00M+PFyF/R9C3+aId02Bw9kdc6ThMWj9waT85kwdm+D6FaRyeRoFhhna+vGqUOy5PvLYSUBpBfMxJwNSs8waa0I61ou5iiSXlYSNFbutv9JD/j/HBwiKnBAJdUS45tloVkr3rclUJRep+Je/DISpI17IPAJOKrU5Ja/LQBgvZ33BQsiQfA1tp+erX0ACQRSQ5aOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iwyQePTgrftNMp5vZxzXiDDXXc3x4zVu7UroQvPFKM=;
 b=HlQQgJSgSmPXpCi5cIHOsortNOTYqcGCE48eS2c/LZIx+Fx+1suV18uTR7hYrh6JbXGqFtl+z4BQuCFfb+BJ+I4aC4lFYp6cVE8gaks4y6xY4i6R/dysSzpwv61ZCtPny/EvQ6LaUDw6L4BMZz69KUEB56EuhTP6AkfWb60C2+AZKMTNbWmgEACTxNVgkcAUnEFqP3WI3RcfRrMlxmzLsCIWpq5a+qVQ++8XId5m1uxHJSW7D2DLX8bieai6ipBEPNtSFrL0hh6nj0gXD+gYbyfPS7x/2aOH1tiegEmNNPxUE4S56uew96QHmEMtfwquwpjxi85DV4QDIXKYt0bzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iwyQePTgrftNMp5vZxzXiDDXXc3x4zVu7UroQvPFKM=;
 b=ShpopXXLnxTP/P5ahV8yTaPGj4dMoHEhXSBEy83dEPD/gJ674er6p1uvjn6jyzPCOX2eeDZW3z5bQfBf3exCxdEbGLoC1TqJ4eCeHr7tTWDGU1RWp1JZ890vNAXPPwAgdM/WQLX9IGYNDS3gvQ5sLmcVanAzXS4Bnk2b14mtWSk=
Received: from DM6PR02CA0152.namprd02.prod.outlook.com (2603:10b6:5:332::19)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 07:35:12 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::ad) by DM6PR02CA0152.outlook.office365.com
 (2603:10b6:5:332::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 07:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 07:35:12 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 02:35:09 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 1/7] RAS: Add Address Translation support for MI200
Date:   Wed, 25 Oct 2023 07:33:33 +0000
Message-ID: <20231025073339.630093-2-muralimk@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 789d43c3-2bdd-427d-4948-08dbd52cec4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehvY4sfGrwf/Lg4JODayc7bxDKzqccha2dtW8aGkPuG+g/lTTEAqtupPwhA+IZ1AQntw52fCiRVTn/kNp9AX5l6RCrxOuDnjasroBhSYbFqt/QPC2Bh2wQ+xA+CM9Kfmr3G3Ow1iwY3uVD4+2XFHnx5XlKJiDTkPNQmxzE0+DAgzFZR0DkgUTtgDkkJcmafPKvQrwHvZAKaYlFP+Dh6kZOA5H2SEW7MmsVNbOquT/EW4eLjFEc/Y7s7ZHc9+PoyoE3yJT3Wtik+IabYkTTtwtfaMzjLJU+73kcMAHFHnbEpPC0HasPsi8faP47svu/cO1++qsi5zXrx36met9ceTPn6b1JMkcPB750rtvyBDNajuS7U52dTepbakUzf4Uc8Fa7MShgIp8nJKiYn75IMhLIQIgft4rPgRROyGLGbRcTMeb+JWvAqbA1MfKXTf9WbxVMG+yGan1aS2VM9kLUayFE3QBNZyD+quMflgHr9eNeuDLEIyyAWSaeoFOZgSWduIN63XVT0DvnMNxxJWpFXfPmhOSd5UvcXlJg3b6W2ZOTLHyOi97eS4pkYB/1aD/cqlKMVGy7jtDmsh+7hfY9cAlgaAXCqgiHGvCdCELFB+ZLHMlIrCB7WtWu71BvKmQYcvlifRSFEDcSrkwJgyWq6nwTdNJIcqiBOhBZSoDSfGmfft3bdcyuhkSdA+4DlGAybO9hjSfpFn1+u/lDNVhCx/+laHsuT7vFL2bfwMMlXyTi+rYLYjkoOgWsZuH/gSqhajw9sN3odTLSCh3bGW31HPiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(83380400001)(30864003)(36860700001)(2906002)(26005)(4326008)(8936002)(8676002)(336012)(36756003)(82740400003)(47076005)(2616005)(16526019)(81166007)(426003)(356005)(1076003)(6666004)(7696005)(316002)(478600001)(5660300002)(110136005)(70586007)(54906003)(70206006)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:35:12.1844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 789d43c3-2bdd-427d-4948-08dbd52cec4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964
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

Add support for address translation on Data Fabric version 3.5
Add new interleaving modes for heterogeneous model support and
adjust how the DRAM address maps are found early in the
translation for certain cases.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
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
index f3888c8fd02d..33905933e31e 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -30,6 +30,12 @@
 /* Shift needed for adjusting register values to true values. */
 #define DF_DRAM_BASE_LIMIT_LSB		28
 
+/* Cache Coherent Moderator Instnce Type value on register */
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
index 05141da27028..9326f6a6b6c3 100644
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
+int get_umc_to_cs_mapping(struct addr_ctx *ctx)
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

