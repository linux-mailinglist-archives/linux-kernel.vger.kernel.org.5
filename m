Return-Path: <linux-kernel+bounces-46849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47F1844562
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6282957AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C5312BF22;
	Wed, 31 Jan 2024 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XWnoPgGV"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928463A7;
	Wed, 31 Jan 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720275; cv=fail; b=UYv1m7dB2sMV8haTLYXnuLPuJgn1dg6pwNS10yvHmDFYOUX3jeR9sx1wQTR3kn1RQbVdldA7Ly2bpMR50t9Ob36riRPmfp0yfyC1TT6U4z1aNznzI7EMKxU7iB6g34UuasGrIRrVjjv9d3aF4QO34u9YACb3u1YKYs5DLvBUChM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720275; c=relaxed/simple;
	bh=NzA+UkQFT3mVBZ8dhiOrHeC99dRbtxj42NZZgUAGtNQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7u5nsObTqXGxKuwf7zmFCdA3nnjzqLEqs0KeIu9mrYbb/eD0bJJskT4kNRFEYfIRk8kPgoW8FA8k68SLx9N4X1MNkbFsDJvCM366/WTSNThHsJ6u4jY5fYEFZYYB+6anKRIEMVSOTSCDALuINPedrCAbXZyF7TDU7EUZ3LhJis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XWnoPgGV; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7rfRQ5Vz8Wv8V3wjzcQzusVE/1vSGcRj3ZtbS531nnjmdcJWf1CDU9Wxel4QsgL1kB0hxqy2krOUeIIpFAkTKdGOsaYrZo9rEg/DITAW+vr1ZGcVfqfPbTWeop99DjmhSBYyQvDGNFwYXx3jkMXEJaNq/urtbolILrWznpB1iffUWbT+jK+F6/hw7UghbAL6MEPk3v4Cwaah4o5hTXWEatJgPdbNSSE+KHlzyNlgJqqDUbppUDpG/ymRVHchk5mLRUuWLdg6vIWmCjlKZ3pyHK99AlBwHMNzep7O4wyxe0FTvPgGrzKSAwGAl85DC1qA+utNlfrLm+op7SAa6vSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9InFWhwftL/kHqU+dPl0tcd6+d75mMxtawHb5NEgtg=;
 b=g7jU+BXPp7Hmfl2G3coWo0p2fEKTaQGkeU0UnER8NQ/aimLduJHfgnxjNIpOUF50fvh0lIzGfwt6tvRrAjzPvmeB3FbWEIdjt4lzyNeXNQbpDOUsAGtf9Xr4tMvDAzOsRpAsN8FZ6uN8fHLBBzk275F7KhIcGhL9MjfpQgVyne8jnswNA/COXvcttLIanEaPqvQBP790Y26akNfVEIBiYfC3m6USX3be38mJa+g/9Hn7F/3FdR4Nex1dkyG3/Yedi56aUjh+mG6s6NS3M2JjLz2cWdfbFNzgA12BpdQwp6tOsWrnVEzk3t/oWRWpF4v5OpiHkIS6oibA5RV5SsglaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9InFWhwftL/kHqU+dPl0tcd6+d75mMxtawHb5NEgtg=;
 b=XWnoPgGV8sJ9ciZ+tTw7qjm96ppcZZK6TOyCz3SeU2Mf29ge0t7Je9qZIAjQmAfXJMX5hJnqva8KKfEzcBhrWcKfuSuWk2xxFXjbbt73QxV9D26A3079EPT4oJGuDX51Vl9O08J7g+hIG2LRIEfCr3baun68JH3pDamANAzmKO4=
Received: from BN9PR03CA0760.namprd03.prod.outlook.com (2603:10b6:408:13a::15)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.36; Wed, 31 Jan
 2024 16:57:49 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::24) by BN9PR03CA0760.outlook.office365.com
 (2603:10b6:408:13a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Wed, 31 Jan 2024 16:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 16:57:48 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 10:57:42 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH] RAS/AMD/ATL: Add MI300 DRAM to Normalized address translation support
Date: Wed, 31 Jan 2024 10:57:32 -0600
Message-ID: <20240131165732.88297-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: b60f1456-075b-4295-ac2a-08dc227dc106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CMrWUrSw4bAlBark8d5rSXAahIby2kAmXFqzgYaUkwhJvNCRiGEUTxMcSOIOywfED6g40CYDVf9kda/S/dTG0ZOg77KQWh4VmMTtgs7dJ8kOlIR4UsVKGViOAMdbYgeO56dx7m54AL2eQFHD+S4k/1Jo6QFnFhZ5ZuYRGzjG7LMfjOGFCuPpb8mVR3EQPD5fIs85hzb6rR/qe628qev3FGqsyxy0Sq213aGajCsJXfGFASgusQ7nAuTA4yE4L8mJFw3bePRWv5AqB7jlkaHP+/fU5Gn9HaRx/NZ+KK/nRPlMEl/TO5UApbzJEKafS2EJmZUF55R+/PISBJwljwR1+cfUvvqlFd2+AK2u8Fg656l/1+/0KzOPbHTjsp7683RkVbhJTjTViqv8wwuABoTNqpaknLv3ZbtMGdAFdsYmVYdh9abZBPnooFEVglv/cpEHZI3aKNicdHugjuSQEd59Fmu9JEZUtMDsRR2CHWIWnhKcCVeIWSauaNOfbGwg6TQ04z0Dkjm6EqEYbo9aSM5wntx9D6Z6MLSIfeOicscHelpfuMdGXD3HCejYd1li0Ohgaz5Jxn7XX6A50hlZ1pel7mB3s+rTeSeImNN5wd6ts1G9lrBu8lbU3i3gK8EIeL4BW5rLZ7Mzl9wLZeZGNt2OhLjA1w6s3aqwvQNEES9BlSnthIuAUjZHYx5GF5N/to+2j+IhZHR2I+Ncl/d9Svrt0vfjlerdVhJvDQ0PHqb40n9DaSxRwy3L53Fbe/6e+VeHXvMbw095I3N7jBNQ7WYykw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(54906003)(5660300002)(44832011)(2906002)(4326008)(8936002)(8676002)(86362001)(110136005)(70586007)(70206006)(36756003)(36860700001)(316002)(81166007)(47076005)(82740400003)(7696005)(478600001)(966005)(356005)(6666004)(83380400001)(26005)(2616005)(336012)(16526019)(426003)(1076003)(41300700001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 16:57:48.3995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b60f1456-075b-4295-ac2a-08dc227dc106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855

Modern AMD systems report DRAM ECC errors through Unified Memory
Controller (UMC) MCA banks. The value provided in MCA_ADDR is a
"Normalized" address which represents the UMC's view of its managed
memory. The Normalized address must be translated to a System Physical
address for software to take action.

MI300 systems, uniquely, do not provide a Normalized address in MCA_ADDR
for DRAM ECC errors. Rather, the "DRAM" address is reported. This value
includes identifiers for the Bank, Row, Column, Pseudochannel, and Stack
of the memory location.

The DRAM address must be converted to a Normalized address in order to
be further translated to a System Physical address.

Add helper functions to do the DRAM to Normalized translation for MI300
systems. The method is based on the fixed hardware layout of the on-chip
memory.

Also, cache the required hardware register values during module init.
These should not change during run time. And all UMCs should be
programmed identically.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Notes:

This is an almost complete rewrite of the following patch:
https://lore.kernel.org/r/20231129073521.2127403-4-muralimk@amd.com

I'd like to include Murali as co-developer, if that's okay with him,
since this is based on his earlier work. 

With this patch, MI300 address translation support should be complete.
The remaining work includes handling expanded page retirement cases.

 drivers/ras/amd/atl/internal.h |   1 +
 drivers/ras/amd/atl/system.c   |   6 +-
 drivers/ras/amd/atl/umc.c      | 199 ++++++++++++++++++++++++++++++++-
 3 files changed, 204 insertions(+), 2 deletions(-)

diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 21d45755e5f2..5de69e0bb0f9 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -224,6 +224,7 @@ int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo);
 
 int get_df_system_info(void);
 int determine_node_id(struct addr_ctx *ctx, u8 socket_num, u8 die_num);
+int get_addr_hash_mi300(void);
 
 int get_address_map(struct addr_ctx *ctx);
 
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 46493ed405d6..701349e84942 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -124,9 +124,13 @@ static int df4_determine_df_rev(u32 reg)
 	if (reg == DF_FUNC0_ID_ZEN4_SERVER)
 		df_cfg.flags.socket_id_shift_quirk = 1;
 
-	if (reg == DF_FUNC0_ID_MI300)
+	if (reg == DF_FUNC0_ID_MI300) {
 		df_cfg.flags.heterogeneous = 1;
 
+		if (get_addr_hash_mi300())
+			return -EINVAL;
+	}
+
 	return df4_get_fabric_id_mask_registers();
 }
 
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 7bfa21a582f0..816c2c5c683f 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -49,6 +49,203 @@ static u8 get_coh_st_inst_id_mi300(struct atl_err *err)
 	return i;
 }
 
+static u16 internal_bitwise_xor(u16 val)
+{
+	u16 tmp = 0;
+	u8 i;
+
+	for (i = 0; i < 16; i++)
+		tmp ^= (val >> i) & 0x1;
+
+	return tmp;
+}
+
+struct xor_bits {
+	bool	xor_enable;
+	u16	col_xor;
+	u32	row_xor;
+};
+
+#define NUM_BANK_BITS	4
+
+static struct {
+	/* Values from UMC::CH::AddrHashBank registers */
+	struct xor_bits	bank[NUM_BANK_BITS];
+
+	/* Values from UMC::CH::AddrHashPC register */
+	struct xor_bits	pc;
+
+	/* Value from UMC::CH::AddrHashPC2 register */
+	u8		bank_xor;
+} addr_hash;
+
+#define MI300_UMC_CH_BASE	0x90000
+#define MI300_ADDR_HASH_BANK0	(MI300_UMC_CH_BASE + 0xC8)
+#define MI300_ADDR_HASH_PC	(MI300_UMC_CH_BASE + 0xE0)
+#define MI300_ADDR_HASH_PC2	(MI300_UMC_CH_BASE + 0xE4)
+
+#define ADDR_HASH_XOR_EN	BIT(0)
+#define ADDR_HASH_COL_XOR	GENMASK(13, 1)
+#define ADDR_HASH_ROW_XOR	GENMASK(31, 14)
+#define ADDR_HASH_BANK_XOR	GENMASK(5, 0)
+
+/*
+ * Read UMC::CH::AddrHash{Bank,PC,PC2} registers to get XOR bits used
+ * for hashing. Do this during module init, since the values will not
+ * change during run time.
+ *
+ * These registers are instantiated for each UMC across each AMD Node.
+ * However, they should be identically programmed due to the fixed hardware
+ * design of MI300 systems. So read the values from Node 0 UMC 0 and keep a
+ * single global structure for simplicity.
+ */
+int get_addr_hash_mi300(void)
+{
+	u32 temp;
+	int ret;
+	u8 i;
+
+	for (i = 0; i < NUM_BANK_BITS; i++) {
+		ret = amd_smn_read(0, MI300_ADDR_HASH_BANK0 + (i * 4), &temp);
+		if (ret)
+			return ret;
+
+		addr_hash.bank[i].xor_enable = FIELD_GET(ADDR_HASH_XOR_EN,  temp);
+		addr_hash.bank[i].col_xor    = FIELD_GET(ADDR_HASH_COL_XOR, temp);
+		addr_hash.bank[i].row_xor    = FIELD_GET(ADDR_HASH_ROW_XOR, temp);
+	}
+
+	ret = amd_smn_read(0, MI300_ADDR_HASH_PC, &temp);
+	if (ret)
+		return ret;
+
+	addr_hash.pc.xor_enable = FIELD_GET(ADDR_HASH_XOR_EN,  temp);
+	addr_hash.pc.col_xor    = FIELD_GET(ADDR_HASH_COL_XOR, temp);
+	addr_hash.pc.row_xor    = FIELD_GET(ADDR_HASH_ROW_XOR, temp);
+
+	ret = amd_smn_read(0, MI300_ADDR_HASH_PC2, &temp);
+	if (ret)
+		return ret;
+
+	addr_hash.bank_xor = FIELD_GET(ADDR_HASH_BANK_XOR, temp);
+
+	return 0;
+}
+
+/*
+ * MI300 systems report a DRAM address in MCA_ADDR for DRAM ECC errors. This must
+ * be converted to the intermediate Normalized address (NA) before translating to a
+ * System Physical address.
+ *
+ * The DRAM address includes bank, row, and column. Also included are bits for
+ * Pseudochannel (PC) and Stack ID (SID).
+ *
+ * Abbreviations: (S)tack ID, (P)seudochannel, (R)ow, (B)ank, (C)olumn, (Z)ero
+ *
+ * The MCA address format is as follows:
+ *	MCA_ADDR[27:0] = {S[1:0], P[0], R[14:0], B[3:0], C[4:0], Z[0]}
+ *
+ * The Normalized address format is fixed in hardware and is as follows:
+ *	NA[30:0] = {S[1:0], R[13:0], C4, B[1:0], B[3:2], C[3:2], P, C[1:0], Z[4:0]}
+ *
+ * Additionally, the PC and Bank bits may be hashed. This must be accounted for before
+ * reconstructing the Normalized address.
+ */
+#define MI300_UMC_MCA_COL	GENMASK(5, 1)
+#define MI300_UMC_MCA_BANK	GENMASK(9, 6)
+#define MI300_UMC_MCA_ROW	GENMASK(24, 10)
+#define MI300_UMC_MCA_PC	BIT(25)
+#define MI300_UMC_MCA_SID	GENMASK(27, 26)
+
+#define MI300_NA_COL_1_0	GENMASK(6, 5)
+#define MI300_NA_PC		BIT(7)
+#define MI300_NA_COL_3_2	GENMASK(9, 8)
+#define MI300_NA_BANK_3_2	GENMASK(11, 10)
+#define MI300_NA_BANK_1_0	GENMASK(13, 12)
+#define MI300_NA_COL_4		BIT(14)
+#define MI300_NA_ROW		GENMASK(28, 15)
+#define MI300_NA_SID		GENMASK(30, 29)
+
+static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
+{
+	u16 i, col, row, bank, pc, sid, temp;
+
+	col  = FIELD_GET(MI300_UMC_MCA_COL,  addr);
+	bank = FIELD_GET(MI300_UMC_MCA_BANK, addr);
+	row  = FIELD_GET(MI300_UMC_MCA_ROW,  addr);
+	pc   = FIELD_GET(MI300_UMC_MCA_PC,   addr);
+	sid  = FIELD_GET(MI300_UMC_MCA_SID,  addr);
+
+	/* Calculate hash for each Bank bit. */
+	for (i = 0; i < NUM_BANK_BITS; i++) {
+		if (!addr_hash.bank[i].xor_enable)
+			continue;
+
+		temp  = internal_bitwise_xor(col & addr_hash.bank[i].col_xor);
+		temp ^= internal_bitwise_xor(row & addr_hash.bank[i].row_xor);
+		bank ^= temp << i;
+	}
+
+	/* Calculate hash for PC bit. */
+	if (addr_hash.pc.xor_enable) {
+		/* Bits SID[1:0] act as Bank[6:5] for PC hash, so apply them here. */
+		bank |= sid << 5;
+
+		temp  = internal_bitwise_xor(col  & addr_hash.pc.col_xor);
+		temp ^= internal_bitwise_xor(row  & addr_hash.pc.row_xor);
+		temp ^= internal_bitwise_xor(bank & addr_hash.bank_xor);
+		pc   ^= temp;
+
+		/* Drop SID bits for the sake of debug printing later. */
+		bank &= 0x1F;
+	}
+
+	/* Reconstruct the Normalized address starting with NA[4:0] = 0 */
+	addr  = 0;
+
+	/* NA[6:5] = Column[1:0] */
+	temp  = col & 0x3;
+	addr |= FIELD_PREP(MI300_NA_COL_1_0, temp);
+
+	/* NA[7] = PC */
+	addr |= FIELD_PREP(MI300_NA_PC, pc);
+
+	/* NA[9:8] = Column[3:2] */
+	temp  = (col >> 2) & 0x3;
+	addr |= FIELD_PREP(MI300_NA_COL_3_2, temp);
+
+	/* NA[11:10] = Bank[3:2] */
+	temp  = (bank >> 2) & 0x3;
+	addr |= FIELD_PREP(MI300_NA_BANK_3_2, temp);
+
+	/* NA[13:12] = Bank[1:0] */
+	temp  = bank & 0x3;
+	addr |= FIELD_PREP(MI300_NA_BANK_1_0, temp);
+
+	/* NA[14] = Column[4] */
+	temp  = (col >> 4) & 0x1;
+	addr |= FIELD_PREP(MI300_NA_COL_4, temp);
+
+	/* NA[28:15] = Row[13:0] */
+	addr |= FIELD_PREP(MI300_NA_ROW, row);
+
+	/* NA[30:29] = SID[1:0] */
+	addr |= FIELD_PREP(MI300_NA_SID, sid);
+
+	pr_debug("Addr=0x%016lx", addr);
+	pr_debug("Bank=%u Row=%u Column=%u PC=%u SID=%u", bank, row, col, pc, sid);
+
+	return addr;
+}
+
+static unsigned long get_addr(unsigned long addr)
+{
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		return convert_dram_to_norm_addr_mi300(addr);
+
+	return addr;
+}
+
 #define MCA_IPID_INST_ID_HI	GENMASK_ULL(47, 44)
 static u8 get_die_id(struct atl_err *err)
 {
@@ -82,7 +279,7 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
 {
 	u8 socket_id = topology_physical_package_id(err->cpu);
 	u8 coh_st_inst_id = get_coh_st_inst_id(err);
-	unsigned long addr = err->addr;
+	unsigned long addr = get_addr(err->addr);
 	u8 die_id = get_die_id(err);
 
 	pr_debug("socket_id=0x%x die_id=0x%x coh_st_inst_id=0x%x addr=0x%016lx",

base-commit: a7b57372e1c5c848cbe9169574f07a9ee2177a1b
-- 
2.34.1


