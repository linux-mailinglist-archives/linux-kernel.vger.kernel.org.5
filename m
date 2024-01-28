Return-Path: <linux-kernel+bounces-41675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C64983F63B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCC6282CEE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99AA25778;
	Sun, 28 Jan 2024 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oQXp3O61"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23232D60A;
	Sun, 28 Jan 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706457607; cv=fail; b=UlblyZcNrCrnZqbJvlS8725Aoua0X9BRbY2USf7kzRxBaZ2RGJiKzCFna2MGwQQGcCAAMQjZ7amBS81SJ3czk33TIhUYavnbLGku3BFk+W9VSozBq8C4qNqrAh/ZWtwCf780D1OwEw5cfoOjIF6MjT/WMCii0kSQebnkpkoJ7IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706457607; c=relaxed/simple;
	bh=BaxYGyIMhYH8CSlJqydVpO3w5xQ/q8FQrmTGfdcrMpY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nXlnJkYrhStBH68J4xUFLjSxtn+5zRou0JGkYhIi+j6M8DbkLUiNhKB3h47Q6AtlaveYERzCdl6w2EfC23h5o2zQ0ih+zw+PxV2GKiC8l1OrVkRnsnJbYA2Wwknc7cz+BLoAOUHiaRnZiOSNjbpu9dzL5OuTEOlVL0dRLYNCgxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oQXp3O61; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2uM9+GpVmpZTnl6pI9m0hwoy5nGHtSC0RHhbs0K8BSdeXGId0PO39Ggv4emGSx4b/eiIA3s9jSx8I5iD4aqT0QxH5iaE1BDdrAsuX3Zfxb3BjjelJc7V8rNskftFUniRYZtE4QSTBubxIci/70RbXN8bqXFLPqtA/72mkXzpZ/u2Ij6OuR4siZ2VZTnbcUaOV3JNSsdq6zEWx5qdYClosGxEmKLyJfAk5iVA9Ay05YKuwhVk9mqmMsz6RCwA2B3EQFQlkBMHluj5Fe95vaZH3y1qmOPzP1fgLzGCMCx/QSDluyXu6GqILwGV397YHPjHMrsxSTA2j7tFMuN+vePvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UbBSddj/QdDyazKttjtSFuJ84jzuda6tGt//UPqZC0=;
 b=WLYn6Ae8P7kqpGNEKsb4Y7mFyjarrtHFIVQMWFaw8f+W2DKkQjRe6URfDsP3G/iL/x6BiFJsJnp/kqKx9cS4wX+ffq+kZSUVEWDSdjK3cIlSz6z8feEX46/2Vlx32ixmBHDERf4fcLdo7+5QSiIuWCn71h7FFlNMsq7mm7eiCbaOJ5AE0BumkdHuHi2wLyDJpnIMgl7zP057Ni2h09V6kTCGwOA6mxkB2ZzfDas8QAhR6y4LdlkQ/x0yVIr31zKOJDgUeUfY8sOXm2QSzwKNzvIbwjJjUa8/z6MSDvZgdelpPE12mDYmHJoeKQ55HlMBSed7/JyAbK+FN2ing2tilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UbBSddj/QdDyazKttjtSFuJ84jzuda6tGt//UPqZC0=;
 b=oQXp3O61av110hPmTbkObDPBtnhTZbd4xf5SwiDn1SjgE2HwnV7vszX1EmYzE3E9u+lQ5FJrhwT5jsM/syysQq7QtEvfAujfuUjkvWCqvxNFD2Mid7icmMvcXkaqTSNq53icE9E1/mJ/r+SmsB8wieKzC03w3gviZ6FWLg+QPpY=
Received: from MN2PR12CA0030.namprd12.prod.outlook.com (2603:10b6:208:a8::43)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Sun, 28 Jan
 2024 16:00:01 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::4) by MN2PR12CA0030.outlook.office365.com
 (2603:10b6:208:a8::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32 via Frontend
 Transport; Sun, 28 Jan 2024 16:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 28 Jan 2024 16:00:01 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 28 Jan
 2024 10:00:00 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, Muralidhara M K <muralidhara.mk@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH] RAS/AMD/ATL: Add MI300 support
Date: Sun, 28 Jan 2024 09:59:50 -0600
Message-ID: <20240128155950.1434067-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 05025754-4156-4359-6afc-08dc201a2f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	01MduAuPulnFVf6qpIBqip5li7ShX67rcxNS/3hwRMisfdUDQ94X0sl5+eqp04WpoljBHeQrm0vcXwFmDhxfxmZlKcci0zW27Ycz8XO+TvxuZ1HnFvmWU3wqaV7FMvia8h1sjUrvRm1QNEP4Nt9an1Q/9G4FOEMBVdgeZT+yaMjl3+kYsZ7bDKsxFEynzc5IaacVlX1syecvl8SEr7HQhHNm89uSvGf2V0DqZhiXxaMC5FardFIDavRQwC8mDVS2nn0IsQZfimCYPilpfAzzfHDiZtBzcTFd2c8p5uJ7B4Eyf1/Fv+1+M2tdN0cGVeSXpxx19Iy2iW5eDFN/rD1jD/27JkhGOw0+EFg57rQuFH2z1QhrUlVlai+qoqotls/duQxtEkoej9RTxcr5ZkcCoXPvMIlTx1YBBS3wKCr3h0VuiGDc4gWnDfmWl0OkrvyOKEiluHhQlewhZRc2XmfCQ6AwJ3SK/hVaqk4u7sGOFB1Le7VUZnLKJuzcBy5b+W1VpV6OnfE310gBKKm7apARqaktxCL0AyWDJl9gQ/G1maNYDQ9FlVVf5iZhGwX25dwJC+ns7jI5QYT8+mEF9eso3H6aPYnT91z0dmc6nS+Qo20bR78EIv5TRpARuhtNCh+lvRqhyAAe4c3c3ESsVXMN1LrgNDpwaRasVhqgviNjU0bBoMNQWdqLLFBpIl5qfZPl4/mf/5AXu1jwRu9dxSbIDtsrDmWr47/eVEksyrK8UM/ZkzHQhsE6MSovnoGHv+j0n01eEIgNV5J9Xxdz0Xil1nXIXu/Ynyff/ZBiA65noIkHZ3mFtpXZJCaKTN8RIQjx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230273577357003)(230922051799003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(82740400003)(36756003)(6666004)(316002)(70206006)(81166007)(4326008)(110136005)(41300700001)(7696005)(2906002)(44832011)(86362001)(70586007)(5660300002)(8936002)(8676002)(30864003)(356005)(54906003)(966005)(478600001)(47076005)(336012)(36860700001)(40460700003)(40480700001)(426003)(1076003)(16526019)(26005)(83380400001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 16:00:01.0470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05025754-4156-4359-6afc-08dc201a2f15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996

From: Muralidhara M K <muralidhara.mk@amd.com>

AMD MI300 systems include on-die HBM3 memory and a unique topology. And
they fall under Data Fabric version 4.5 in overall design.

Generally, topology information (IDs, etc.) is gathered from Data Fabric
registers. However, the unique topology for MI300 means that some
topology information is fixed in hardware and follows arbitrary
mappings. Furthermore, not all hardware instances are software-visible,
so register accesses must be adjusted.

Recognize and add helper functions for the new MI300 interleave modes.
Add lookup tables for fixed values where appropriate. Adjust how Die and
Node IDs are found and used.

Also, fix some register bitmasks that were mislabeled.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Notes:
This patch is based on patches 2, 4, and 5 from the following set.
https://lore.kernel.org/r/20231129073521.2127403-1-muralimk@amd.com

Patch 3 from above set is still needed for complete MI300 address
translation support. This will be the first to follow.

Patch 6 from above set is needed for expanding page retirement on MI300
systems. This will be the second to follow.

Patch 1 from above set adds MI200 support to ATL. This will be deferred
until after priority MI300 updates.

Changes:
* Rebased on upstream ATL code. (Murali)
* Squash 3 patches into 1. (Murali)
* Update commit message. (Yazen)
* Code style, comments, and flow changes. (Yazen) 

 drivers/ras/amd/atl/access.c      |  26 ++++++++
 drivers/ras/amd/atl/dehash.c      |  95 +++++++++++++++++++++++++++-
 drivers/ras/amd/atl/denormalize.c | 102 ++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    |  10 ++-
 drivers/ras/amd/atl/map.c         |  17 +++++
 drivers/ras/amd/atl/reg_fields.h  |   9 ++-
 drivers/ras/amd/atl/system.c      |   3 +
 drivers/ras/amd/atl/umc.c         |  51 +++++++++++++++
 8 files changed, 308 insertions(+), 5 deletions(-)

diff --git a/drivers/ras/amd/atl/access.c b/drivers/ras/amd/atl/access.c
index f6dd87bb2c35..de3103b25296 100644
--- a/drivers/ras/amd/atl/access.c
+++ b/drivers/ras/amd/atl/access.c
@@ -36,6 +36,30 @@ static DEFINE_MUTEX(df_indirect_mutex);
 
 #define DF_FICAA_REG_NUM_LEGACY	GENMASK(10, 2)
 
+static u16 get_accessible_node(u16 node)
+{
+	/*
+	 * On heterogeneous systems, not all AMD Nodes are accessible through
+	 * software-visible registers. The Node ID needs to be adjusted for
+	 * register accesses. But its value should not be changed for the
+	 * translation methods.
+	 */
+	if (df_cfg.flags.heterogeneous) {
+		/* Only Node 0 is accessible on DF3.5 systems. */
+		if (df_cfg.rev == DF3p5)
+			node = 0;
+		/*
+		 * Only the first Node in each Socket is accessible on DF4.5 systems, and
+		 * this is visible to software as one Fabric per Socket.
+		 * The Socket ID can be derived from the Node ID and global shift values.
+		 */
+		if (df_cfg.rev == DF4p5)
+			node >>= df_cfg.socket_id_shift - df_cfg.node_id_shift;
+	}
+
+	return node;
+}
+
 static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
 {
 	u32 ficaa_addr = 0x8C, ficad_addr = 0xB8;
@@ -43,6 +67,8 @@ static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *l
 	int err = -ENODEV;
 	u32 ficaa = 0;
 
+	node = get_accessible_node(node);
+
 	if (node >= amd_nb_num())
 		goto out;
 
diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
index 6f414926e6fe..4ea46262c4f5 100644
--- a/drivers/ras/amd/atl/dehash.c
+++ b/drivers/ras/amd/atl/dehash.c
@@ -253,7 +253,7 @@ static int df4p5_dehash_addr(struct addr_ctx *ctx)
 	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
 	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M, ctx->map.ctl);
 	hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G, ctx->map.ctl);
-	hash_ctl_1T  = FIELD_GET(DF4_HASH_CTL_1T, ctx->map.ctl);
+	hash_ctl_1T  = FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
 
 	/*
 	 * Generate a unique address to determine which bits
@@ -343,6 +343,94 @@ static int df4p5_dehash_addr(struct addr_ctx *ctx)
 	return 0;
 }
 
+/*
+ * MI300 hash bits
+ *					  4K 64K  2M  1G  1T  1T
+ * COH_ST_Select[0]	= XOR of addr{8,  12, 15, 22, 29, 36, 43}
+ * COH_ST_Select[1]	= XOR of addr{9,  13, 16, 23, 30, 37, 44}
+ * COH_ST_Select[2]	= XOR of addr{10, 14, 17, 24, 31, 38, 45}
+ * COH_ST_Select[3]	= XOR of addr{11,     18, 25, 32, 39, 46}
+ * COH_ST_Select[4]	= XOR of addr{14,     19, 26, 33, 40, 47} aka Stack
+ * DieID[0]		= XOR of addr{12,     20, 27, 34, 41    }
+ * DieID[1]		= XOR of addr{13,     21, 28, 35, 42    }
+ */
+static int mi300_dehash_addr(struct addr_ctx *ctx)
+{
+	bool hash_ctl_4k, hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T;
+	bool hashed_bit, intlv_bit, test_bit;
+	u8 num_intlv_bits, base_bit, i;
+
+	if (!map_bits_valid(ctx, 8, 8, 4, 1))
+		return -EINVAL;
+
+	hash_ctl_4k  = FIELD_GET(DF4p5_HASH_CTL_4K, ctx->map.ctl);
+	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
+	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
+	hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G,   ctx->map.ctl);
+	hash_ctl_1T  = FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
+
+	/* Channel bits */
+	num_intlv_bits = ilog2(ctx->map.num_intlv_chan);
+
+	for (i = 0; i < num_intlv_bits; i++) {
+		base_bit = 8 + i;
+
+		/* COH_ST_Select[4] jumps to a base bit of 14. */
+		if (i == 4)
+			base_bit = 14;
+
+		intlv_bit = BIT_ULL(base_bit) & ctx->ret_addr;
+
+		hashed_bit = intlv_bit;
+
+		/* 4k hash bit only applies to the first 3 bits. */
+		if (i <= 2) {
+			test_bit    = BIT_ULL(12 + i) & ctx->ret_addr;
+			hashed_bit ^= test_bit & hash_ctl_4k;
+		}
+
+		/* Use temporary 'test_bit' value to avoid Sparse warnings. */
+		test_bit    = BIT_ULL(15 + i) & ctx->ret_addr;
+		hashed_bit ^= test_bit & hash_ctl_64k;
+		test_bit    = BIT_ULL(22 + i) & ctx->ret_addr;
+		hashed_bit ^= test_bit & hash_ctl_2M;
+		test_bit    = BIT_ULL(29 + i) & ctx->ret_addr;
+		hashed_bit ^= test_bit & hash_ctl_1G;
+		test_bit    = BIT_ULL(36 + i) & ctx->ret_addr;
+		hashed_bit ^= test_bit & hash_ctl_1T;
+		test_bit    = BIT_ULL(43 + i) & ctx->ret_addr;
+		hashed_bit ^= test_bit & hash_ctl_1T;
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
+		intlv_bit = BIT_ULL(base_bit) & ctx->ret_addr;
+
+		hashed_bit = intlv_bit;
+
+		test_bit    = BIT_ULL(20 + i) & ctx->ret_addr;
+		hashed_bit ^= test_bit & hash_ctl_64k;
+		test_bit    = BIT_ULL(27 + i) & ctx->ret_addr;
+		hashed_bit ^= test_bit & hash_ctl_2M;
+		test_bit    = BIT_ULL(34 + i) & ctx->ret_addr;
+		hashed_bit ^= test_bit & hash_ctl_1G;
+		test_bit    = BIT_ULL(41 + i) & ctx->ret_addr;
+		hashed_bit ^= test_bit & hash_ctl_1T;
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
@@ -400,6 +488,11 @@ int dehash_address(struct addr_ctx *ctx)
 	case DF4p5_NPS1_16CHAN_2K_HASH:
 		return df4p5_dehash_addr(ctx);
 
+	case MI3_HASH_8CHAN:
+	case MI3_HASH_16CHAN:
+	case MI3_HASH_32CHAN:
+		return mi300_dehash_addr(ctx);
+
 	default:
 		atl_debug_on_bad_intlv_mode(ctx);
 		return -EINVAL;
diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index 01f1d0fb6799..91c996d4927a 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -80,6 +80,40 @@ static u64 make_space_for_coh_st_id_split_2_1(struct addr_ctx *ctx)
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
+static u64 make_space_for_coh_st_id_mi300(struct addr_ctx *ctx)
+{
+	u8 num_intlv_bits = ilog2(ctx->map.num_intlv_chan);
+	u64 denorm_addr;
+
+	if (ctx->map.intlv_bit_pos != 8) {
+		pr_debug("Invalid interleave bit: %u", ctx->map.intlv_bit_pos);
+		return ~0ULL;
+	}
+
+	/* Channel bits. Covers up to 4 bits at [11:8]. */
+	denorm_addr = expand_bits(8, min(num_intlv_bits, 4), ctx->ret_addr);
+
+	/* Die bits. Always starts at [12]. */
+	denorm_addr = expand_bits(12, ilog2(ctx->map.num_intlv_dies), denorm_addr);
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
@@ -107,6 +141,12 @@ static u64 make_space_for_coh_st_id(struct addr_ctx *ctx)
 	case DF4p5_NPS1_8CHAN_2K_HASH:
 	case DF4p5_NPS1_16CHAN_2K_HASH:
 		return make_space_for_coh_st_id_split_2_1(ctx);
+
+	case MI3_HASH_8CHAN:
+	case MI3_HASH_16CHAN:
+	case MI3_HASH_32CHAN:
+		return make_space_for_coh_st_id_mi300(ctx);
+
 	default:
 		atl_debug_on_bad_intlv_mode(ctx);
 		return ~0ULL;
@@ -204,6 +244,32 @@ static u16 get_coh_st_id_df4(struct addr_ctx *ctx)
 	return coh_st_id;
 }
 
+/*
+ * MI300 hash has:
+ * (C)hannel[3:0]	= coh_st_id[3:0]
+ * (S)tack[0]		= coh_st_id[4]
+ * (D)ie[1:0]		= coh_st_id[6:5]
+ *
+ * Hashed coh_st_id is swizzled so that Stack bit is at the end.
+ * coh_st_id = SDDCCCC
+ */
+static u16 get_coh_st_id_mi300(struct addr_ctx *ctx)
+{
+	u8 channel_bits, die_bits, stack_bit;
+	u16 die_id;
+
+	/* Subtract the "base" Destination Fabric ID. */
+	ctx->coh_st_fabric_id -= get_dst_fabric_id(ctx);
+
+	die_id = (ctx->coh_st_fabric_id & df_cfg.die_id_mask) >> df_cfg.die_id_shift;
+
+	channel_bits	= FIELD_GET(GENMASK(3, 0), ctx->coh_st_fabric_id);
+	stack_bit	= FIELD_GET(BIT(4), ctx->coh_st_fabric_id) << 6;
+	die_bits	= die_id << 4;
+
+	return stack_bit | die_bits | channel_bits;
+}
+
 /*
  * Derive the correct Coherent Station ID that represents the interleave bits
  * used within the system physical address. This accounts for the
@@ -237,6 +303,11 @@ static u16 calculate_coh_st_id(struct addr_ctx *ctx)
 	case DF4p5_NPS1_16CHAN_2K_HASH:
 		return get_coh_st_id_df4(ctx);
 
+	case MI3_HASH_8CHAN:
+	case MI3_HASH_16CHAN:
+	case MI3_HASH_32CHAN:
+		return get_coh_st_id_mi300(ctx);
+
 	/* COH_ST ID is simply the COH_ST Fabric ID adjusted by the Destination Fabric ID. */
 	case DF4p5_NPS2_4CHAN_1K_HASH:
 	case DF4p5_NPS1_8CHAN_1K_HASH:
@@ -287,6 +358,9 @@ static u64 insert_coh_st_id(struct addr_ctx *ctx, u64 denorm_addr, u16 coh_st_id
 	case NOHASH_8CHAN:
 	case NOHASH_16CHAN:
 	case NOHASH_32CHAN:
+	case MI3_HASH_8CHAN:
+	case MI3_HASH_16CHAN:
+	case MI3_HASH_32CHAN:
 	case DF2_2CHAN_HASH:
 		return insert_coh_st_id_at_intlv_bit(ctx, denorm_addr, coh_st_id);
 
@@ -314,6 +388,31 @@ static u64 insert_coh_st_id(struct addr_ctx *ctx, u64 denorm_addr, u16 coh_st_id
 	}
 }
 
+/*
+ * MI300 systems have a fixed, hardware-defined physical to logical
+ * Coherent Station mapping. The Remap registers are not used.
+ */
+static const u16 phy_to_log_coh_st_map_mi300[] = {
+	12, 13, 14, 15,
+	 8,  9, 10, 11,
+	 4,  5,  6,  7,
+	 0,  1,  2,  3,
+	28, 29, 30, 31,
+	24, 25, 26, 27,
+	20, 21, 22, 23,
+	16, 17, 18, 19,
+};
+
+static u16 get_logical_coh_st_fabric_id_mi300(struct addr_ctx *ctx)
+{
+	if (ctx->inst_id >= sizeof(phy_to_log_coh_st_map_mi300)) {
+		atl_debug(ctx, "Instance ID out of range");
+		return ~0;
+	}
+
+	return phy_to_log_coh_st_map_mi300[ctx->inst_id] | (ctx->node_id << df_cfg.node_id_shift);
+}
+
 static u16 get_logical_coh_st_fabric_id(struct addr_ctx *ctx)
 {
 	u16 component_id, log_fabric_id;
@@ -321,6 +420,9 @@ static u16 get_logical_coh_st_fabric_id(struct addr_ctx *ctx)
 	/* Start with the physical COH_ST Fabric ID. */
 	u16 phys_fabric_id = ctx->coh_st_fabric_id;
 
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		return get_logical_coh_st_fabric_id_mi300(ctx);
+
 	/* Skip logical ID lookup if remapping is disabled. */
 	if (!FIELD_GET(DF4_REMAP_EN, ctx->map.ctl) &&
 	    ctx->map.intlv_mode != DF3_6CHAN)
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 13f1b6098c96..21d45755e5f2 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -27,8 +27,12 @@
 /* PCI ID for Zen4 Server DF Function 0. */
 #define DF_FUNC0_ID_ZEN4_SERVER		0x14AD1022
 
+/* PCI IDs for MI300 DF Function 0. */
+#define DF_FUNC0_ID_MI300		0x15281022
+
 /* Shift needed for adjusting register values to true values. */
 #define DF_DRAM_BASE_LIMIT_LSB		28
+#define MI300_DRAM_LIMIT_LSB		20
 
 enum df_revisions {
 	UNKNOWN,
@@ -59,6 +63,9 @@ enum intlv_modes {
 	DF4_NPS1_12CHAN_HASH		= 0x15,
 	DF4_NPS2_5CHAN_HASH		= 0x16,
 	DF4_NPS1_10CHAN_HASH		= 0x17,
+	MI3_HASH_8CHAN			= 0x18,
+	MI3_HASH_16CHAN			= 0x19,
+	MI3_HASH_32CHAN			= 0x1A,
 	DF2_2CHAN_HASH			= 0x21,
 	/* DF4.5 modes are all IntLvNumChan + 0x20 */
 	DF4p5_NPS1_16CHAN_1K_HASH	= 0x2C,
@@ -86,7 +93,8 @@ enum intlv_modes {
 struct df_flags {
 	__u8	legacy_ficaa		: 1,
 		socket_id_shift_quirk	: 1,
-		__reserved_0		: 6;
+		heterogeneous		: 1,
+		__reserved_0		: 5;
 };
 
 struct df_config {
diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
index 33f549b6255a..8b908e8d7495 100644
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
@@ -125,6 +129,9 @@ static u64 get_hi_addr_offset(u32 reg_dram_offset)
 		atl_debug_on_bad_df_rev();
 	}
 
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		shift = MI300_DRAM_LIMIT_LSB;
+
 	return hi_addr_offset << shift;
 }
 
@@ -369,6 +376,13 @@ static int get_coh_st_fabric_id(struct addr_ctx *ctx)
 {
 	u32 reg;
 
+	/*
+	 * On MI300 systems, the Coherent Station Fabric ID is derived
+	 * later. And it does not depend on the register value.
+	 */
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		return 0;
+
 	/* Read D18F0x50 (FabricBlockInstanceInformation3). */
 	if (df_indirect_read_instance(ctx->node_id, 0, 0x50, ctx->inst_id, &reg))
 		return -EINVAL;
@@ -490,6 +504,7 @@ static u8 get_num_intlv_chan(struct addr_ctx *ctx)
 	case NOHASH_8CHAN:
 	case DF3_COD1_8CHAN_HASH:
 	case DF4_NPS1_8CHAN_HASH:
+	case MI3_HASH_8CHAN:
 	case DF4p5_NPS1_8CHAN_1K_HASH:
 	case DF4p5_NPS1_8CHAN_2K_HASH:
 		return 8;
@@ -502,6 +517,7 @@ static u8 get_num_intlv_chan(struct addr_ctx *ctx)
 	case DF4p5_NPS1_12CHAN_2K_HASH:
 		return 12;
 	case NOHASH_16CHAN:
+	case MI3_HASH_16CHAN:
 	case DF4p5_NPS1_16CHAN_1K_HASH:
 	case DF4p5_NPS1_16CHAN_2K_HASH:
 		return 16;
@@ -509,6 +525,7 @@ static u8 get_num_intlv_chan(struct addr_ctx *ctx)
 	case DF4p5_NPS0_24CHAN_2K_HASH:
 		return 24;
 	case NOHASH_32CHAN:
+	case MI3_HASH_32CHAN:
 		return 32;
 	default:
 		atl_debug_on_bad_intlv_mode(ctx);
diff --git a/drivers/ras/amd/atl/reg_fields.h b/drivers/ras/amd/atl/reg_fields.h
index 6aaa5093f42c..9dcdf6e4a856 100644
--- a/drivers/ras/amd/atl/reg_fields.h
+++ b/drivers/ras/amd/atl/reg_fields.h
@@ -246,11 +246,11 @@
 #define DF3_HASH_CTL_64K		BIT(20)
 #define DF3_HASH_CTL_2M			BIT(21)
 #define DF3_HASH_CTL_1G			BIT(22)
-#define DF4_HASH_CTL_4K			BIT(7)
 #define DF4_HASH_CTL_64K		BIT(8)
 #define DF4_HASH_CTL_2M			BIT(9)
 #define DF4_HASH_CTL_1G			BIT(10)
-#define DF4_HASH_CTL_1T			BIT(15)
+#define DF4p5_HASH_CTL_4K		BIT(7)
+#define DF4p5_HASH_CTL_1T		BIT(15)
 
 /*
  * High Address Offset
@@ -268,10 +268,13 @@
  *	D18F7x140 [DRAM Offset]
  *	DF4	HiAddrOffset	[24:1]
  *	DF4p5	HiAddrOffset	[24:1]
+ *	MI300	HiAddrOffset	[31:1]
  */
 #define DF2_HI_ADDR_OFFSET	GENMASK(31, 20)
 #define DF3_HI_ADDR_OFFSET	GENMASK(31, 12)
-#define DF4_HI_ADDR_OFFSET	GENMASK(24, 1)
+
+/* Follow reference code by including reserved bits for simplicity. */
+#define DF4_HI_ADDR_OFFSET	GENMASK(31, 1)
 
 /*
  * High Address Offset Enable
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index af61f2f1d6de..46493ed405d6 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -124,6 +124,9 @@ static int df4_determine_df_rev(u32 reg)
 	if (reg == DF_FUNC0_ID_ZEN4_SERVER)
 		df_cfg.flags.socket_id_shift_quirk = 1;
 
+	if (reg == DF_FUNC0_ID_MI300)
+		df_cfg.flags.heterogeneous = 1;
+
 	return df4_get_fabric_id_mask_registers();
 }
 
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 9d51e4954687..7bfa21a582f0 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -12,8 +12,56 @@
 
 #include "internal.h"
 
+/*
+ * MI300 has a fixed, model-specific mapping between a UMC instance and
+ * its related Data Fabric Coherent Station instance.
+ *
+ * The MCA_IPID_UMC[InstanceId] field holds a unique identifier for the
+ * UMC instance within a Node. Use this to find the appropriate Coherent
+ * Station ID.
+ *
+ * Redundant bits were removed from the map below.
+ */
+static const u16 umc_coh_st_map[32] = {
+	0x393, 0x293, 0x193, 0x093,
+	0x392, 0x292, 0x192, 0x092,
+	0x391, 0x291, 0x191, 0x091,
+	0x390, 0x290, 0x190, 0x090,
+	0x793, 0x693, 0x593, 0x493,
+	0x792, 0x692, 0x592, 0x492,
+	0x791, 0x691, 0x591, 0x491,
+	0x790, 0x690, 0x590, 0x490,
+};
+
+#define UMC_ID_MI300 GENMASK(23, 12)
+static u8 get_coh_st_inst_id_mi300(struct atl_err *err)
+{
+	u16 umc_id = FIELD_GET(UMC_ID_MI300, err->ipid);
+	u8 i;
+
+	for (i = 0; i < ARRAY_SIZE(umc_coh_st_map); i++) {
+		if (umc_id == umc_coh_st_map[i])
+			break;
+	}
+
+	WARN_ON_ONCE(i >= ARRAY_SIZE(umc_coh_st_map));
+
+	return i;
+}
+
+#define MCA_IPID_INST_ID_HI	GENMASK_ULL(47, 44)
 static u8 get_die_id(struct atl_err *err)
 {
+	/*
+	 * AMD Node ID is provided in MCA_IPID[InstanceIdHi], and this
+	 * needs to be divided by 4 to get the internal Die ID.
+	 */
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous) {
+		u8 node_id = FIELD_GET(MCA_IPID_INST_ID_HI, err->ipid);
+
+		return node_id >> 2;
+	}
+
 	/*
 	 * For CPUs, this is the AMD Node ID modulo the number
 	 * of AMD Nodes per socket.
@@ -24,6 +72,9 @@ static u8 get_die_id(struct atl_err *err)
 #define UMC_CHANNEL_NUM	GENMASK(31, 20)
 static u8 get_coh_st_inst_id(struct atl_err *err)
 {
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		return get_coh_st_inst_id_mi300(err);
+
 	return FIELD_GET(UMC_CHANNEL_NUM, err->ipid);
 }
 

base-commit: 1289c431641f8beacc47db506210154dcea2492a
-- 
2.34.1


