Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69177DF17B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbjKBLnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345074AbjKBLnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:43:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1D118C;
        Thu,  2 Nov 2023 04:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYyv7RzOx+UjaF4+4hmloUT5zshCL/HhxVjmEX1raFkaJ4MfhZ8eBpAa144qTmLhkll8t4SB2TCsKm8ji+4DQ/jAKlAtNjPK0dXHau1Y31EuXDt2iuBQ4x9HOW22m3tZVkDjESm4mN+W9JcTZKxHUEhe1SFZre44H0Ioir2faYc0wPKWDpRQEEjuviscALMUspLU61o4UXPSGwLqmCoeAvmpUMPU125f0w2qpkIcxPyiF9mRz6XAE5+K1ehlUx3U87SuS6nujEoaI9ofRKeqP9OnOMzOH0VTunmMJ9Q3QzmJiCL1HOx9boNa80P8KDUGIqfv14L7l/mT9E2iskS2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVxvq0R5bY67xOTk1bbxKRcO1F9ZU+2vJgMSY4t8iwA=;
 b=ctlDRrB2ajkt1ytfWw+NKwxoewGpKg2U+RRy4Mzya6LtRGkECl/EPOyNEAgpBLO0kzd1PGOlaow0hBiA3K0Nmj0a2nGRnvtA6ncxq+pRjdEI8dsi8OEpZ5ddGpO9mtjuc8PPq39Q6I4Kz2evpR9qlYNbjG5pfZZX8N8vSMxAE5WUEkyBsu6wfIxTB0vl1k8MznumMox3jKyKsh86D8617vGg347rM5gm/Jpy8B5+wSOBDLe5fbz4O400JCgjTAcgBJq8fphRAUAMxXb8UcYdmCwDVskHIEqXQtqpbDKwNXghx53iVOGiOGDhkWNxy/r8+o8M7oAD1M/hIT/Sxgdn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVxvq0R5bY67xOTk1bbxKRcO1F9ZU+2vJgMSY4t8iwA=;
 b=OHxKEzhnUJ6fTdVdkp1VpxlMpBJ20Lo7Gpq5y6HdUhocTnDwpBH10LX70Y6qe1ReZiZ35tWrPiPqyRveFNHzuDFtxG5H5NZEDG+ZYUk0JXrAP+S2MHu4VG4Kl4Jdbiw7YPHP3IpDks0i1a9bbhPmLsA8IWb0saNgRKfVKvrECn0=
Received: from CH0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:610:77::33)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 11:42:56 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::de) by CH0PR04CA0058.outlook.office365.com
 (2603:10b6:610:77::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 11:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 11:42:56 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 06:42:54 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v3 4/4] EDAC/amd64: Add support for family 0x19, models 0x90-9f devices
Date:   Thu, 2 Nov 2023 11:42:25 +0000
Message-ID: <20231102114225.2006878-5-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102114225.2006878-1-muralimk@amd.com>
References: <20231102114225.2006878-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9bf748-3d17-445f-2982-08dbdb98db9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ubs6FjBwkgr3MDWnHG8tjpTbdbPniOciXyeh/5wCfs3e10NVyNB8sH70CDB0+glNg7rL0oMHy49j5Aaw47qjGJGcuKQodpfhBfnPBsYO26A0GO1tYK26qe+mnravOWP0QNBl2/bNLAUJzGEzk2TJtjYSh+CtJ3qwffgdYloYC3XwQBeJY4CmXc2tz+eiYFA1ARD4mZmji4J9im3lpV1cde90XEjtfII3apqFrH+T4u4a0+Qugzwed1pTLtkaFI/wPm/Jl5UD2lxW+Ibuv4KwUmEvvYeu62wW1UXhgpb+jBaLvMtHmD/LQYlVoAk5L6iVieYKTdNKJ2rEP789CZOFd2PwNbjXXf1osSb0sVBtewLtTGtLbM7owkPzIhdJOUbxaXRMT960tIV+N+HCke9fw3QWznXvy8FpkVJ3Kyql7hmrbAsOukcb8zQGDXo62vtvHsqttHbgqyfqwFfHoMROLeNo6NUg2iTomNhthlJBYVz7yi/N2FSKCvVrrCNSnLdEhZ9E2tZhG2LpVPN4lLM1ihg9y14AiTVf0y+gpk58sOjFffn0sqJGsFGy6Yz/Zjaz43qN6EtFe8bcRVHdrj2/87OufIRPENF+Sctzfwj41afkNLJJUn/YlSQMfE0ox3G16L4Nb9aLNwuhz/UHiutqztQbTkMocSDxPTWakhhEUg/6NTkm52LKQrGYi35MhyeRrhJ4SCWPh4PTTLvgFfrN+L1qHKvDlZxzy+a+p2JlMP7Fts+0UPw14IAGWsn6cMXefWv2O8tRnpS28dPmeWzeJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(6666004)(40480700001)(478600001)(7696005)(40460700003)(83380400001)(47076005)(5660300002)(4326008)(36860700001)(8676002)(8936002)(2906002)(6916009)(1076003)(70586007)(316002)(26005)(426003)(2616005)(16526019)(81166007)(36756003)(356005)(82740400003)(336012)(54906003)(41300700001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:42:56.8257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9bf748-3d17-445f-2982-08dbdb98db9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

AMD Models 90h-9fh are APUs. They have built-in HBM3 memory.
ECC support is enabled by default.

APU models have a single Data Fabric (DF) per Package. Each DF is
visible to the OS in the same way as chiplet-based systems like
Zen2 CPUs and later. However, the Unified Memory Controllers (UMCs)
are arranged in the same way as GPU-based MI200 devices rather than
CPU-based systems.
Use the existing gpu_ops for hetergeneous systems to support
enumeration of nodes and memory topology with few fixups.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
Changes:
v2->v3:
1. Remove determine_memory_type and added in per_family_init
2. gpu_umc_base moved to pvt struct and used directly in per_family_init

 drivers/edac/amd64_edac.c | 62 +++++++++++++++++++++++++++++----------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9b6642d00871..d080e7d70588 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -996,12 +996,20 @@ static struct local_node_map {
 #define LNTM_NODE_COUNT				GENMASK(27, 16)
 #define LNTM_BASE_NODE_ID			GENMASK(11, 0)
 
-static int gpu_get_node_map(void)
+static int gpu_get_node_map(struct amd64_pvt *pvt)
 {
 	struct pci_dev *pdev;
 	int ret;
 	u32 tmp;
 
+	/*
+	 * Mapping of nodes from hardware-provided AMD Node ID to a
+	 * Linux logical one is applicable for MI200 models.
+	 * Therefore return early for other heterogeneous systems.
+	 */
+	if (pvt->F3->device != PCI_DEVICE_ID_AMD_MI200_DF_F3)
+		return 0;
+
 	/*
 	 * Node ID 0 is reserved for CPUs.
 	 * Therefore, a non-zero Node ID means we've already cached the values.
@@ -3851,7 +3859,7 @@ static void gpu_init_csrows(struct mem_ctl_info *mci)
 
 			dimm->nr_pages = gpu_get_csrow_nr_pages(pvt, umc, cs);
 			dimm->edac_mode = EDAC_SECDED;
-			dimm->mtype = MEM_HBM2;
+			dimm->mtype = pvt->dram_type;
 			dimm->dtype = DEV_X16;
 			dimm->grain = 64;
 		}
@@ -3880,7 +3888,7 @@ static bool gpu_ecc_enabled(struct amd64_pvt *pvt)
 	return true;
 }
 
-static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
+static inline u32 gpu_get_umc_base(struct amd64_pvt *pvt, u8 umc, u8 channel)
 {
 	/*
 	 * On CPUs, there is one channel per UMC, so UMC numbering equals
@@ -3893,13 +3901,16 @@ static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
 	 * On GPU nodes channels are selected in 3rd nibble
 	 * HBM chX[3:0]= [Y  ]5X[3:0]000;
 	 * HBM chX[7:4]= [Y+1]5X[3:0]000
+	 *
+	 * On MI300 APU nodes, same as GPU nodes but channels are selected
+	 * in the base address of 0x90000
 	 */
 	umc *= 2;
 
 	if (channel >= 4)
 		umc++;
 
-	return 0x50000 + (umc << 20) + ((channel % 4) << 12);
+	return pvt->gpu_umc_base + (umc << 20) + ((channel % 4) << 12);
 }
 
 static void gpu_read_mc_regs(struct amd64_pvt *pvt)
@@ -3910,7 +3921,7 @@ static void gpu_read_mc_regs(struct amd64_pvt *pvt)
 
 	/* Read registers from each UMC */
 	for_each_umc(i) {
-		umc_base = gpu_get_umc_base(i, 0);
+		umc_base = gpu_get_umc_base(pvt, i, 0);
 		umc = &pvt->umc[i];
 
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
@@ -3927,7 +3938,7 @@ static void gpu_read_base_mask(struct amd64_pvt *pvt)
 
 	for_each_umc(umc) {
 		for_each_chip_select(cs, umc, pvt) {
-			base_reg = gpu_get_umc_base(umc, cs) + UMCCH_BASE_ADDR;
+			base_reg = gpu_get_umc_base(pvt, umc, cs) + UMCCH_BASE_ADDR;
 			base = &pvt->csels[umc].csbases[cs];
 
 			if (!amd_smn_read(pvt->mc_node_id, base_reg, base)) {
@@ -3935,7 +3946,7 @@ static void gpu_read_base_mask(struct amd64_pvt *pvt)
 					 umc, cs, *base, base_reg);
 			}
 
-			mask_reg = gpu_get_umc_base(umc, cs) + UMCCH_ADDR_MASK;
+			mask_reg = gpu_get_umc_base(pvt, umc, cs) + UMCCH_ADDR_MASK;
 			mask = &pvt->csels[umc].csmasks[cs];
 
 			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask)) {
@@ -3960,7 +3971,7 @@ static int gpu_hw_info_get(struct amd64_pvt *pvt)
 {
 	int ret;
 
-	ret = gpu_get_node_map();
+	ret = gpu_get_node_map(pvt);
 	if (ret)
 		return ret;
 
@@ -4125,6 +4136,8 @@ static int per_family_init(struct amd64_pvt *pvt)
 			if (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) {
 				pvt->ctl_name		= "MI200";
 				pvt->max_mcs		= 4;
+				pvt->dram_type		= MEM_HBM2;
+				pvt->gpu_umc_base	= 0x50000;
 				pvt->ops		= &gpu_ops;
 			} else {
 				pvt->ctl_name		= "F19h_M30h";
@@ -4142,6 +4155,13 @@ static int per_family_init(struct amd64_pvt *pvt)
 			pvt->ctl_name			= "F19h_M70h";
 			pvt->flags.zn_regs_v2		= 1;
 			break;
+		case 0x90 ... 0x9f:
+			pvt->ctl_name			= "F19h_M90h";
+			pvt->max_mcs			= 4;
+			pvt->dram_type			= MEM_HBM3;
+			pvt->gpu_umc_base		= 0x90000;
+			pvt->ops			= &gpu_ops;
+			break;
 		case 0xa0 ... 0xaf:
 			pvt->ctl_name			= "F19h_MA0h";
 			pvt->max_mcs			= 12;
@@ -4180,23 +4200,33 @@ static const struct attribute_group *amd64_edac_attr_groups[] = {
 	NULL
 };
 
+/*
+ * For heterogeneous and APU models EDAC CHIP_SELECT and CHANNEL layers
+ * should be swapped to fit into the layers.
+ */
+static unsigned int get_layer_size(struct amd64_pvt *pvt, u8 layer)
+{
+	bool is_gpu = (pvt->ops == &gpu_ops);
+
+	if (!layer)
+		return is_gpu ? pvt->max_mcs
+			      : pvt->csels[0].b_cnt;
+	else
+		return is_gpu ? pvt->csels[0].b_cnt
+			      : pvt->max_mcs;
+}
+
 static int init_one_instance(struct amd64_pvt *pvt)
 {
 	struct mem_ctl_info *mci = NULL;
 	struct edac_mc_layer layers[2];
 	int ret = -ENOMEM;
 
-	/*
-	 * For Heterogeneous family EDAC CHIP_SELECT and CHANNEL layers should
-	 * be swapped to fit into the layers.
-	 */
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) ?
-			 pvt->max_mcs : pvt->csels[0].b_cnt;
+	layers[0].size = get_layer_size(pvt, 0);
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) ?
-			 pvt->csels[0].b_cnt : pvt->max_mcs;
+	layers[1].size = get_layer_size(pvt, 1);
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 5a4e4a59682b..1665f7932bac 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -362,6 +362,7 @@ struct amd64_pvt {
 	u32 dct_sel_lo;		/* DRAM Controller Select Low */
 	u32 dct_sel_hi;		/* DRAM Controller Select High */
 	u32 online_spare;	/* On-Line spare Reg */
+	u32 gpu_umc_base;	/* Base address used for channel selection on GPUs */
 
 	/* x4, x8, or x16 syndromes in use */
 	u8 ecc_sym_sz;
-- 
2.25.1

