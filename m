Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43C180BCC8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjLJTtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjLJTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:49:44 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E608F1;
        Sun, 10 Dec 2023 11:49:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMUoUjKuh721fq/+zDHxV/pVDgCJ8fVpovopzAGyYAIgZrwqgUAC4Ag08C46X+j9Ki9q5fgtsjs81DJpNcVdF6tJNSXhLy6gQVoatIbW38B7fkKa/DJQPdNEpVICciSSDHgvPgN3Z5aQt8dpaLwoWt3o0zP/4aAwK79yXh25PprcxBZzY1w/9LQOkmo29VhoexrHLJo+MXK9vT2o9bFkE9gPvLgver1ClYXFD0/S+ePkKworLaBEerze+mRz4uYqjcw11gad1eFzqxcA57Ubv6Z2EnTvlPUMAQHowpFaB8CZcWxyKBJqKUMwE/uVHO1uoYxdojlxoM9dMURpSZPlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW0WoQL14DPni+CqwsMMmq53gJub6kZ7wUew4te4Hyw=;
 b=QgNzXYAUdNcUXfgd6MbayX17wdq3hasbGbGJdKHr2J1Ch3Yf1GNMqmQ8y8lE3RSC39sBNXLzi+X4WeDiVEfeigtvo6U1Xkb94/KhfvRxEEyXA0K9oY81B5rVqayxyMOGFIxMCORn9IRINjwEXj2TPo4+V7lCoITiFW6awvfl2JTnYmOlp6qwfhnqJycR6LrImXMv0wBoL7Oxwwc2mpaHY/TJDv6aAIlxqKAbj7mOLXYC0tj/6MXnQ2FRDzHvDAOqxRWZKg79PtwVkiWpFc5YNe2tIbx8UCLT+PKNvWFrRKsOkE4sU9UlZ7ey4U6mCsqyFaMd5lSCVUQsTuXe6WRWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW0WoQL14DPni+CqwsMMmq53gJub6kZ7wUew4te4Hyw=;
 b=ByYskZeszrSix+AyGub7yLP/DWVcLR54jIjc3pu6f9JFd7suSFjZfgFEHdx7fOFMKmnqK+VlnoNYOSjH0zRVO/I4fTtNvMJbMeJHqnX+ZtBf5IOEL9Zh1WLYzCr2epxG3/KYc3zeG36UJMogAd5fkZehkrOenKK2Euc6Ft6IOUo=
Received: from CY5PR15CA0240.namprd15.prod.outlook.com (2603:10b6:930:66::12)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.31; Sun, 10 Dec
 2023 19:49:46 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::61) by CY5PR15CA0240.outlook.office365.com
 (2603:10b6:930:66::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Sun, 10 Dec 2023 19:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Sun, 10 Dec 2023 19:49:46 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 10 Dec
 2023 13:49:45 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <avadhut.naik@amd.com>, <john.allen@amd.com>,
        <william.roche@oracle.com>, <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 2/3] EDAC/amd64: Use new AMD Address Translation Library
Date:   Sun, 10 Dec 2023 13:49:31 -0600
Message-ID: <20231210194932.43992-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210194932.43992-1-yazen.ghannam@amd.com>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: cb492728-dd54-49cb-5cb4-08dbf9b9299c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29PgLf+RWTMnhPl6Sish539EkvSeRtPbCenh6VdU1xZwddbP1CyA1tsP6x0VBV7k0Vd7ECidYpk3gR25I7etE9SZk47Ap55oj2Q26z7KyiALigiloDrD+VmI4ldMO/M8xVn9K3IIcG8hZYT/WPtClKWKVKVcrlFAI2dhHfsJQuR5fn1A2SaoaHH0My8mRpY3aDrOhZhX+fee0nh9vVy96LNa+c/iP8yV1HXhs6sAMfq2enGuUv9VSadEzhEcm1r2hQslE7xuXXc2cHodpQD3Rd9477j3DHR7MQiKinwjFIP33eJFk3w2d5B8CkNAJ5ol5qALqvW7Y8O99hWqnLC10QX1fRAXQV2yLPVjf5ud4mQivSyfRLpspTEwZ2zwI8+0sNOj6Pih9pjSq/PAArqDroby4VRXbYHpshu7Hl/J8bS98O0nX2gb6M126PVmZ0zH+m3vRWoRBl1kieMdMM4Z6oUlpv1PgtrlNgYV8mnnzCbRaKxzFj7gUDtIYq118CtYjnySAmYg4KaKP8C5wfNlI7ucftn5d8iBCJzg5WUb0K5Ty7WSzqcKxUVnvSBjy/sPl6QKFLnYRrMoDuZ6+tqCbF37tQsRbO6gWcEZKZuipBtqcaU63U0KqUpHHf56ZzjwBSspMNpVoCpujLPI+RAN7xEZZHDxCanJg8YyixWbOQM/f34pSPL0XFVIvat+8761zwVoWO2ayb1BbzFG90uU6AkUBxSH1Aqb3SuJbgi7zecG8REa+2dRYkynecvo+YrFQcash9o41y2vvWzaAd53lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(36840700001)(46966006)(40470700004)(40480700001)(41300700001)(40460700003)(2906002)(5660300002)(44832011)(316002)(4326008)(8676002)(8936002)(70586007)(6916009)(54906003)(70206006)(81166007)(356005)(82740400003)(2616005)(86362001)(36756003)(36860700001)(47076005)(966005)(83380400001)(26005)(478600001)(6666004)(1076003)(16526019)(426003)(336012)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 19:49:46.4498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb492728-dd54-49cb-5cb4-08dbf9b9299c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove old address translation code and use the new AMD Address
Translation Library.

Use "imply" in Kconfig so that the "AMD_ATL" config option takes the
value of "EDAC_AMD64" as its default.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20231005173526.42831-3-yazen.ghannam@amd.com

v2->v3:
* Adjust header include and library function name.

v1->v2:
* Drop the "config reachable" check.

 drivers/edac/Kconfig      |   1 +
 drivers/edac/amd64_edac.c | 278 +-------------------------------------
 2 files changed, 3 insertions(+), 276 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 5a7f3fabee22..16c8de5050e5 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -78,6 +78,7 @@ config EDAC_GHES
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
+	imply AMD_ATL
 	help
 	  Support for error detection and correction of DRAM ECC errors on
 	  the AMD64 families (>= K8) of memory controllers.
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9b6642d00871..70bdaca78545 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include "amd64_edac.h"
 #include <asm/amd_nb.h>
+#include <asm/amd_atl.h>
 
 static struct edac_pci_ctl_info *pci_ctl;
 
@@ -1043,281 +1044,6 @@ static int fixup_node_id(int node_id, struct mce *m)
 	return nid - gpu_node_map.base_node_id + 1;
 }
 
-/* Protect the PCI config register pairs used for DF indirect access. */
-static DEFINE_MUTEX(df_indirect_mutex);
-
-/*
- * Data Fabric Indirect Access uses FICAA/FICAD.
- *
- * Fabric Indirect Configuration Access Address (FICAA): Constructed based
- * on the device's Instance Id and the PCI function and register offset of
- * the desired register.
- *
- * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
- * and FICAD HI registers but so far we only need the LO register.
- *
- * Use Instance Id 0xFF to indicate a broadcast read.
- */
-#define DF_BROADCAST	0xFF
-static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
-{
-	struct pci_dev *F4;
-	u32 ficaa;
-	int err = -ENODEV;
-
-	if (node >= amd_nb_num())
-		goto out;
-
-	F4 = node_to_amd_nb(node)->link;
-	if (!F4)
-		goto out;
-
-	ficaa  = (instance_id == DF_BROADCAST) ? 0 : 1;
-	ficaa |= reg & 0x3FC;
-	ficaa |= (func & 0x7) << 11;
-	ficaa |= instance_id << 16;
-
-	mutex_lock(&df_indirect_mutex);
-
-	err = pci_write_config_dword(F4, 0x5C, ficaa);
-	if (err) {
-		pr_warn("Error writing DF Indirect FICAA, FICAA=0x%x\n", ficaa);
-		goto out_unlock;
-	}
-
-	err = pci_read_config_dword(F4, 0x98, lo);
-	if (err)
-		pr_warn("Error reading DF Indirect FICAD LO, FICAA=0x%x.\n", ficaa);
-
-out_unlock:
-	mutex_unlock(&df_indirect_mutex);
-
-out:
-	return err;
-}
-
-static int df_indirect_read_instance(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
-{
-	return __df_indirect_read(node, func, reg, instance_id, lo);
-}
-
-static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
-{
-	return __df_indirect_read(node, func, reg, DF_BROADCAST, lo);
-}
-
-struct addr_ctx {
-	u64 ret_addr;
-	u32 tmp;
-	u16 nid;
-	u8 inst_id;
-};
-
-static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
-{
-	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
-
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
-	u8 intlv_addr_sel, intlv_addr_bit;
-	u8 num_intlv_bits, hashed_bit;
-	u8 lgcy_mmio_hole_en, base = 0;
-	u8 cs_mask, cs_id = 0;
-	bool hash_enabled = false;
-
-	struct addr_ctx ctx;
-
-	memset(&ctx, 0, sizeof(ctx));
-
-	/* Start from the normalized address */
-	ctx.ret_addr = norm_addr;
-
-	ctx.nid = nid;
-	ctx.inst_id = umc;
-
-	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &ctx.tmp))
-		goto out_err;
-
-	/* Remove HiAddrOffset from normalized address, if enabled: */
-	if (ctx.tmp & BIT(0)) {
-		u64 hi_addr_offset = (ctx.tmp & GENMASK_ULL(31, 20)) << 8;
-
-		if (norm_addr >= hi_addr_offset) {
-			ctx.ret_addr -= hi_addr_offset;
-			base = 1;
-		}
-	}
-
-	/* Read D18F0x110 (DramBaseAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * base), umc, &ctx.tmp))
-		goto out_err;
-
-	/* Check if address range is valid. */
-	if (!(ctx.tmp & BIT(0))) {
-		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
-			__func__, ctx.tmp);
-		goto out_err;
-	}
-
-	lgcy_mmio_hole_en = ctx.tmp & BIT(1);
-	intlv_num_chan	  = (ctx.tmp >> 4) & 0xF;
-	intlv_addr_sel	  = (ctx.tmp >> 8) & 0x7;
-	dram_base_addr	  = (ctx.tmp & GENMASK_ULL(31, 12)) << 16;
-
-	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
-	if (intlv_addr_sel > 3) {
-		pr_err("%s: Invalid interleave address select %d.\n",
-			__func__, intlv_addr_sel);
-		goto out_err;
-	}
-
-	/* Read D18F0x114 (DramLimitAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * base), umc, &ctx.tmp))
-		goto out_err;
-
-	intlv_num_sockets = (ctx.tmp >> 8) & 0x1;
-	intlv_num_dies	  = (ctx.tmp >> 10) & 0x3;
-	dram_limit_addr	  = ((ctx.tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
-
-	intlv_addr_bit = intlv_addr_sel + 8;
-
-	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
-	switch (intlv_num_chan) {
-	case 0:	intlv_num_chan = 0; break;
-	case 1: intlv_num_chan = 1; break;
-	case 3: intlv_num_chan = 2; break;
-	case 5:	intlv_num_chan = 3; break;
-	case 7:	intlv_num_chan = 4; break;
-
-	case 8: intlv_num_chan = 1;
-		hash_enabled = true;
-		break;
-	default:
-		pr_err("%s: Invalid number of interleaved channels %d.\n",
-			__func__, intlv_num_chan);
-		goto out_err;
-	}
-
-	num_intlv_bits = intlv_num_chan;
-
-	if (intlv_num_dies > 2) {
-		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
-			__func__, intlv_num_dies);
-		goto out_err;
-	}
-
-	num_intlv_bits += intlv_num_dies;
-
-	/* Add a bit if sockets are interleaved. */
-	num_intlv_bits += intlv_num_sockets;
-
-	/* Assert num_intlv_bits <= 4 */
-	if (num_intlv_bits > 4) {
-		pr_err("%s: Invalid interleave bits %d.\n",
-			__func__, num_intlv_bits);
-		goto out_err;
-	}
-
-	if (num_intlv_bits > 0) {
-		u64 temp_addr_x, temp_addr_i, temp_addr_y;
-		u8 die_id_bit, sock_id_bit, cs_fabric_id;
-
-		/*
-		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
-		 * This is the fabric id for this coherent slave. Use
-		 * umc/channel# as instance id of the coherent slave
-		 * for FICAA.
-		 */
-		if (df_indirect_read_instance(nid, 0, 0x50, umc, &ctx.tmp))
-			goto out_err;
-
-		cs_fabric_id = (ctx.tmp >> 8) & 0xFF;
-		die_id_bit   = 0;
-
-		/* If interleaved over more than 1 channel: */
-		if (intlv_num_chan) {
-			die_id_bit = intlv_num_chan;
-			cs_mask	   = (1 << die_id_bit) - 1;
-			cs_id	   = cs_fabric_id & cs_mask;
-		}
-
-		sock_id_bit = die_id_bit;
-
-		/* Read D18F1x208 (SystemFabricIdMask). */
-		if (intlv_num_dies || intlv_num_sockets)
-			if (df_indirect_read_broadcast(nid, 1, 0x208, &ctx.tmp))
-				goto out_err;
-
-		/* If interleaved over more than 1 die. */
-		if (intlv_num_dies) {
-			sock_id_bit  = die_id_bit + intlv_num_dies;
-			die_id_shift = (ctx.tmp >> 24) & 0xF;
-			die_id_mask  = (ctx.tmp >> 8) & 0xFF;
-
-			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
-		}
-
-		/* If interleaved over more than 1 socket. */
-		if (intlv_num_sockets) {
-			socket_id_shift	= (ctx.tmp >> 28) & 0xF;
-			socket_id_mask	= (ctx.tmp >> 16) & 0xFF;
-
-			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
-		}
-
-		/*
-		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
-		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-		 * address bits from the post-interleaved address.
-		 * "num_intlv_bits" has been calculated to tell us how many "I"
-		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
-		 * there are (where "I" starts).
-		 */
-		temp_addr_y = ctx.ret_addr & GENMASK_ULL(intlv_addr_bit - 1, 0);
-		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ctx.ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ctx.ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
-	}
-
-	/* Add dram base address */
-	ctx.ret_addr += dram_base_addr;
-
-	/* If legacy MMIO hole enabled */
-	if (lgcy_mmio_hole_en) {
-		if (df_indirect_read_broadcast(nid, 0, 0x104, &ctx.tmp))
-			goto out_err;
-
-		dram_hole_base = ctx.tmp & GENMASK(31, 24);
-		if (ctx.ret_addr >= dram_hole_base)
-			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
-	}
-
-	if (hash_enabled) {
-		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ctx.ret_addr >> 12) ^
-				(ctx.ret_addr >> 18) ^
-				(ctx.ret_addr >> 21) ^
-				(ctx.ret_addr >> 30) ^
-				cs_id;
-
-		hashed_bit &= BIT(0);
-
-		if (hashed_bit != ((ctx.ret_addr >> intlv_addr_bit) & BIT(0)))
-			ctx.ret_addr ^= BIT(intlv_addr_bit);
-	}
-
-	/* Is calculated system address is above DRAM limit address? */
-	if (ctx.ret_addr > dram_limit_addr)
-		goto out_err;
-
-	*sys_addr = ctx.ret_addr;
-	return 0;
-
-out_err:
-	return -EINVAL;
-}
-
 static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
 
 /*
@@ -3098,7 +2824,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	pvt->ops->get_err_info(m, &err);
 
-	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
+	if (amd_convert_umc_mca_addr_to_sys_addr(m, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}
-- 
2.34.1

