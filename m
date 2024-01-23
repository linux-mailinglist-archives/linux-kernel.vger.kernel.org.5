Return-Path: <linux-kernel+bounces-34700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C126B83864B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246DDB220D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBF91FC4;
	Tue, 23 Jan 2024 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UTHllAL8"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B11848;
	Tue, 23 Jan 2024 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705983347; cv=fail; b=ZomqhYggoZwK1s18mf9Y2CsNb8/FeLpibQLEj7jViczVR+0F33WGyfZXPby15b6XFqQSRNqZP76xm6BMQl9tqIq3lHNVj9MGbC1CpFilVY6iXdN9JaxGyC5ZMfcale98hrq80Rssv+C9cs7xM0sN0zij3hORcrOpD8nd31PfXG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705983347; c=relaxed/simple;
	bh=lD4XgroUd1JFPtBapfrMQuICaPW3XJquUWqQAOQk4qA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcWTeDkIS+5vvdBfSSaF7Ko5OzKOuBLniarY+UVxol7lvRLj9vWy4C9vuFME+BiKAg67t5ut6Wp6Hglh77lLpFrwogt+8UWUkUwhN9sGKqR4DKYfldfpuqSxp//hvvxhBwYi0kjEj3nMWA9WV8aw1DZwqxxpfZC6JsxViFZNSYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UTHllAL8; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb34bSlCexxvtITx9hJrRTNQ78pAR3gmadrjA09smdZV1yJPd9XTFwODYQX92l37rE78cfhp7EG6rjjepoBbFIIlkkE/A0i4Sd7NcZiJQRBqf2wcg0tzpQIyTiOguN2xLF5CR03YUsbVPBWBm6/GmPlqbN4G3uvU2Kw/ZusHWdvdXiMvfr1Oth+4KLxTJQY6AK/sGSW38ly4KzKCfx6OhLMM80YX7hl75Iqf3AQyyIA7XCSgrWTaST2iPr9b9hGI9kTWxhK0L2g7HmJZejCY9EgEpH2dOq/UVMgpuGPwkwkKnAquAy+WFjf0N+hjJF3rjLqlVDmF4UV6u5DrbCIYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/+E47XhWu/2Ilvt5AM/SLlNGs0+IYFcs9UCM66vnQE=;
 b=bg/yuUUHqDelPc4RvIvGPOiO4kKxB2hoNdiWa80TzJ2Lvnn8mPG62x6vfqbvASH94nyX39WxKbN8cV+ULpm2ga44N2Rvnb9HXuhnVeIoj7VXwlIZSYOsFb8zFoYhn5ceG6xrmWb0Ca3LjXfc4dn7sQN1Fu2ag4hUKkjW2nYZJBHz0qfNL99RUb3YJotifkEYijR9DlSY+Dd4RzoePkOfC/vx06fG8G6Ted3fXli6hhajWPnziW0WH+aT16+QdB0uF9mGdtusC7kDaWPyR/Vm2jHGNY/vWCKjpVS0mVov8eWZ6OXo0ryPgvCzWNg2Rg/wE3Ta2khjwHZMJVUS6vvlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/+E47XhWu/2Ilvt5AM/SLlNGs0+IYFcs9UCM66vnQE=;
 b=UTHllAL8p2hBHhOrB4n9rL5z3PAilB0e7vis4gIpnQb6JrvTzSXrrxfpkbAF4FLTXfZxCUgsYeE9fta4Etv6LWAQw3vqDD6X3qkDzvnybdxvvYl1c5hcruETE93FiBe5e6B28EBCgtkFiisYB7mpAXvwVaFgL7ra4UQSgkl11MQ=
Received: from BYAPR02CA0060.namprd02.prod.outlook.com (2603:10b6:a03:54::37)
 by SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Tue, 23 Jan
 2024 04:15:42 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::65) by BYAPR02CA0060.outlook.office365.com
 (2603:10b6:a03:54::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Tue, 23 Jan 2024 04:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 04:15:41 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 22:15:39 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, <william.roche@oracle.com>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<christophe.jaillet@wanadoo.fr>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v5 2/3] EDAC/amd64: Use new AMD Address Translation Library
Date: Mon, 22 Jan 2024 22:14:00 -0600
Message-ID: <20240123041401.79812-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123041401.79812-1-yazen.ghannam@amd.com>
References: <20240123041401.79812-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SA3PR12MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 321d0397-029b-4160-895f-08dc1bc9f680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cZoO/GBK+JWIivBoshrcyBKDAcNYRXPE8Tf9DjT3vl7xfcfcVIZoPjdzEguzauE8xXH4fu4HQ4nSSXGI0aeweXelr7YpxD6IGNzCr9VMVIBk+Q1cc9nwAS8N0ubPLS55U1248CtpgeQ+gB7VQp4+dRmDkcTu7oSYthupdUXiK6bcLtICc4JEEUnQ6CWy8U7rajZD2iz1kW9RkkmzoIMogTxlsfaAbA5ZlnLWabWkDuZiJf0oCrZYsehhiq7kwxEwC9foXK7ul8l2feNQV9R8Y71nkOC1EOzE8Y2kqoe/sC3tsiLJL24Da0v9fbFeyo+2SguoektqZWio0Pxli/NHxhq23M1NUymQyY6sNV1xY8RjpTSVUKQog04lGPCCdCtN6ozbEBBASHiPgEvS9cUzTK8l3W7n9z+zANbCplaUKql+j1nGgTKJJzA3lFc2/4tFwBNklHs/ToWRNdqeNDqW7aNwA6mHrE3M2YCH3w1BGHOHvpfQ5aKGiJSZRyEqd8Q6amUXEHcN31tLIOx0c34SL32+/UTfzlzrE1alfM88DXk6XKsC9O83MH9niMwfilCqAmTaOwY8hhRMOOLbL3dUHM40VRsGbprsndJIdJJ74RzzMaxlVb4u8RXGhUy8H/Vb0GZQZAbqZ0q/+VsW3gO9O7RieJF8jtWfJFyJpn5gG8NGHz+WTBl5TX2YMuBQveNvDKuqUIpFq0LagQrVWLjk4Z5XdM/poHzmFzFLRTLUm03D6VlpMgnMVRba9/kX+yfrkrCbXOpcSC7uhUHDPlwu5g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(7696005)(36860700001)(1076003)(6666004)(26005)(16526019)(336012)(426003)(2616005)(47076005)(70206006)(8936002)(5660300002)(8676002)(2906002)(966005)(110136005)(70586007)(316002)(54906003)(41300700001)(478600001)(44832011)(4326008)(36756003)(86362001)(356005)(81166007)(83380400001)(82740400003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 04:15:41.6356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 321d0397-029b-4160-895f-08dc1bc9f680
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921

Remove old address translation code and use the new AMD Address
Translation Library.

Use "imply" in Kconfig so that the "AMD_ATL" config option takes the
value of "EDAC_AMD64" as its default.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20231218190406.27479-3-yazen.ghannam@amd.com

v4->v5:
* Use "struct atl_err".

v3->v4:
* Adjust header include and library function name.
* Use IS_ERR_VALUE() to check for translation success.

v2->v3:
* Adjust header include and library function name.

v1->v2:
* Drop the "config reachable" check.

 drivers/edac/Kconfig      |   1 +
 drivers/edac/amd64_edac.c | 287 ++------------------------------------
 2 files changed, 11 insertions(+), 277 deletions(-)

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
index 537b9987a431..c22eeb633958 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/ras.h>
 #include "amd64_edac.h"
 #include <asm/amd_nb.h>
 
@@ -1051,281 +1052,6 @@ static int fixup_node_id(int node_id, struct mce *m)
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
@@ -3073,9 +2799,10 @@ static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
 	struct mem_ctl_info *mci;
+	unsigned long sys_addr;
 	struct amd64_pvt *pvt;
+	struct atl_err a_err;
 	struct err_info err;
-	u64 sys_addr;
 
 	node_id = fixup_node_id(node_id, m);
 
@@ -3106,7 +2833,13 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	pvt->ops->get_err_info(m, &err);
 
-	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
+	a_err.addr = m->addr;
+	a_err.ipid = m->ipid;
+	a_err.cpu  = m->extcpu;
+
+	sys_addr = amd_convert_umc_mca_addr_to_sys_addr(&a_err);
+
+	if (IS_ERR_VALUE(sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}
-- 
2.34.1


