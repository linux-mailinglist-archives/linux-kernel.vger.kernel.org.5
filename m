Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024177D610F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjJYFPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjJYFPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:15:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AECA12A;
        Tue, 24 Oct 2023 22:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PN4b6eGGUzRUnf+JZKIahwU/IN1z1yeQ1QSns0BmhQ1s2jpzqzxNDZlemgV4K2RgkREHrC5FY6SiXhL1H7EK2fmcVyMnKZaPQfdfzG/BDK8Se1jjK2RIqg3LlMgSRM0NSpZa9fLH68KopGp9d+91AbF6y6fdcovWKGuwGE/Ec+nFAdw6+AErTTquVzHIiHS6tPcSa/6Ll0CiAT/P7KWpw7z41QXUSVmLtSqc5pu9qHcRz4lNfnADyN5Xty2PJ1m3SQ4pVy7HgZXyRLDboM4RiHAhtbN0WdqgOF5xteynfcQOFNXyqrPgdaRzY9Jpn8oSgPUe+flVLHIRUWUByb4TIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsGMwijuwk/m/tkWiZ1u114H1bX2Q1cyD5fIqMj7FsA=;
 b=R9SuaES9amLBWGiCcmdGJdxrz2IENcL99VWV9SW+uEoM3901/0HJH0KCuauLzbwPLzIaCS23Ie6Xr/GbBH+Wpwhmipe2HpJ8YiPWnyG9NKcE5tT2f1aeFnzmwG3yXEv93sWKr1G0zahDz48v1HII+9vs8BqbQrCB/bmBL8irja465RG4bOLIFHMpQN/p/V41bMK53fFitxKd7C6xhbmuFnApbQvQM5mXKyWreoYpE6FFyLNHNPVkMUS48t73tVh3NZHUBkz/pW48O6/nF6gLC75gIViRutqT7fG0hL3LdqQJh5H3KH5oLuvaRkNjMKjIcuy+6/NdNN62mpNb5+/9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsGMwijuwk/m/tkWiZ1u114H1bX2Q1cyD5fIqMj7FsA=;
 b=Y0fTjJwvPvAvAfdow5a/ZQybYAYghQNDQiNZizlZ/+LDCh4B9csxdjbJEXxneLe2JWKcr8/AVUMiT2GnYxbV5frSXj4jUMHSdZhJhRwNE1id6NcfxXU4jaiMem35p5WgdPOi0Bww0nwRNQchsu2WO3c8wq6flU8TS/v9F6A3tzY=
Received: from CY5P221CA0056.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::27) by
 SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.19; Wed, 25 Oct 2023 05:15:34 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::ed) by CY5P221CA0056.outlook.office365.com
 (2603:10b6:930:4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 05:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 05:15:34 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 00:15:31 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v2 4/4] EDAC/amd64: Add Family 19h Models 90h ~ 9fh enumeration support
Date:   Wed, 25 Oct 2023 05:14:55 +0000
Message-ID: <20231025051455.101424-5-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025051455.101424-1-muralimk@amd.com>
References: <20231025051455.101424-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e17aae-54e5-42f9-f722-08dbd5196a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ABmkrNYfudQXJu5ituSycKMVZHdPwU06t0ujZ495uYiuPdZeLiY1eiCdo5cBJkQsB+11A878ISR4I+aD1KIroTQUK2b4iToRiHMdK1eLCzOtxS4vmqkR3JIlVcRYUA3VRntgDtbqm4YykkuurF+t4j+7JPS07dnR/WhknPPqeyXWaKXqV452ZvyjL/7J6ux5NkaMnhkeBi0wiSQwvinPs+ucdBOUwZubfg4Fh/2cOrbGrTBq0cDbKVqZDSHrPfRPL2Nn9XQzyz9uiH7/0edazKA7wSdQ3XkKCsPNDy9VCR+dN+PrF6Xsp+MHpKvsvtfTdr54rbcb7OCz9NhxoKdouocSVrNamGM4ZWQEg90W9JOYe8uT1Y8PwiGBg01DSe2ZEsjsTUj9vkOy4Gl42Ht4g+pSAAM1BqmV7bt7kUJG94VFz94gUTO4q/yeitClEryQDXrOZMMBQinX8GJdrAtknFc1tDRW1VMebB3EOK6we0y5EXErfAJ19DPJF2SSXipm1NnATalAWqO/vQdZVz475pwfGSgNYTPV2K9wH2Rcx7PUeos7BRpvfKjMR0msmIgKFIoz/9GxyUHsTtZUmE5yHy2o98ipiNi4SbKgCxL1sdDmKS+ACKSz7Ntb+izqsOpiGiF21xCSxcY9IfISfzyCxQMPEri1i7Pketr1lh2i8lOEDFgZMKBk/cA5UoEwHN+w5HJEGiQuoCINFV5XVIh+0HNTDWgkXP2/a0s2bp3Fh3h/nfQ9FypQvvkuKQ3OwXprmUuLoMdLEa9+iw8o9URTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(26005)(478600001)(426003)(336012)(1076003)(40480700001)(6666004)(316002)(6916009)(7696005)(54906003)(70206006)(40460700003)(70586007)(36756003)(36860700001)(47076005)(16526019)(2616005)(356005)(81166007)(2906002)(8676002)(83380400001)(4326008)(8936002)(82740400003)(5660300002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 05:15:34.1181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e17aae-54e5-42f9-f722-08dbd5196a99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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

AMD Models 90h-9fh are APUs, They have built-in HBM3 memory.
ECC support is enabled by default.

APU models have a single Data Fabric (DF) per Package. Each DF is
visible to the OS in the same way as chiplet-based systems like
Rome and later. However, the Unified Memory Controllers (UMCs) are
arranged in the same way as GPU-based MI200 devices rather than
CPU-based systems.
So, use the gpu_ops for enumeration and adds a few fixups to
support enumeration of nodes and memory topology.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/edac/amd64_edac.c | 69 ++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9b6642d00871..82302393894c 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -996,12 +996,19 @@ static struct local_node_map {
 #define LNTM_NODE_COUNT				GENMASK(27, 16)
 #define LNTM_BASE_NODE_ID			GENMASK(11, 0)
 
-static int gpu_get_node_map(void)
+static int gpu_get_node_map(struct amd64_pvt *pvt)
 {
 	struct pci_dev *pdev;
 	int ret;
 	u32 tmp;
 
+	/* Mapping of nodes from hardware-provided AMD Node ID to a Linux logical
+	 * one is applicable for MI200 models.
+	 * Therefore return early for other heterogeneous systems.
+	 */
+	if (pvt->F3->device != PCI_DEVICE_ID_AMD_MI200_DF_F3)
+		return 0;
+
 	/*
 	 * Node ID 0 is reserved for CPUs.
 	 * Therefore, a non-zero Node ID means we've already cached the values.
@@ -3851,7 +3858,7 @@ static void gpu_init_csrows(struct mem_ctl_info *mci)
 
 			dimm->nr_pages = gpu_get_csrow_nr_pages(pvt, umc, cs);
 			dimm->edac_mode = EDAC_SECDED;
-			dimm->mtype = MEM_HBM2;
+			dimm->mtype = pvt->dram_type;
 			dimm->dtype = DEV_X16;
 			dimm->grain = 64;
 		}
@@ -3880,6 +3887,9 @@ static bool gpu_ecc_enabled(struct amd64_pvt *pvt)
 	return true;
 }
 
+/* Base address used for channels selection on MI200 GPUs */
+static u32 gpu_umc_base = 0x50000;
+
 static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
 {
 	/*
@@ -3893,13 +3903,33 @@ static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
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
+	return gpu_umc_base + (umc << 20) + ((channel % 4) << 12);
+}
+
+static void gpu_determine_memory_type(struct amd64_pvt *pvt)
+{
+	if (pvt->fam == 0x19) {
+		switch (pvt->model) {
+		case 0x30 ... 0x3F:
+			pvt->dram_type = MEM_HBM2;
+			break;
+		case 0x90 ... 0x9F:
+			pvt->dram_type = MEM_HBM3;
+			break;
+		default:
+			break;
+		}
+	}
+	edac_dbg(1, "  MEM type: %s\n", edac_mem_types[pvt->dram_type]);
 }
 
 static void gpu_read_mc_regs(struct amd64_pvt *pvt)
@@ -3960,7 +3990,7 @@ static int gpu_hw_info_get(struct amd64_pvt *pvt)
 {
 	int ret;
 
-	ret = gpu_get_node_map();
+	ret = gpu_get_node_map(pvt);
 	if (ret)
 		return ret;
 
@@ -3971,6 +4001,7 @@ static int gpu_hw_info_get(struct amd64_pvt *pvt)
 	gpu_prep_chip_selects(pvt);
 	gpu_read_base_mask(pvt);
 	gpu_read_mc_regs(pvt);
+	gpu_determine_memory_type(pvt);
 
 	return 0;
 }
@@ -4142,6 +4173,12 @@ static int per_family_init(struct amd64_pvt *pvt)
 			pvt->ctl_name			= "F19h_M70h";
 			pvt->flags.zn_regs_v2		= 1;
 			break;
+		case 0x90 ... 0x9f:
+			pvt->ctl_name			= "F19h_M90h";
+			pvt->max_mcs			= 4;
+			gpu_umc_base			= 0x90000;
+			pvt->ops			= &gpu_ops;
+			break;
 		case 0xa0 ... 0xaf:
 			pvt->ctl_name			= "F19h_MA0h";
 			pvt->max_mcs			= 12;
@@ -4180,23 +4217,31 @@ static const struct attribute_group *amd64_edac_attr_groups[] = {
 	NULL
 };
 
+/*
+ * For Heterogeneous and APU models EDAC CHIP_SELECT and CHANNEL layers
+ * should be swapped to fit into the layers.
+ */
+static unsigned int get_layer_size(struct amd64_pvt *pvt, u8 layer)
+{
+	bool is_gpu = (pvt->ops == &gpu_ops);
+
+	if (!layer)
+		return is_gpu ? pvt->max_mcs : pvt->csels[0].b_cnt;
+
+	return is_gpu ? pvt->csels[0].b_cnt : pvt->max_mcs;
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
-- 
2.25.1

