Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9007D0879
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376331AbjJTG3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346989AbjJTG3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:29:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E6CD61
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnpwQAidu+BeoP5zv3Re3xuC1SwKqi67i5aEF7qmvF63Z/vkMrrGQDXfVV3d1ghy7IcVu74geS0rexVVMHvM3kYvFBX4MTnXhNPIVKWq/ZaYKdXoY3lWuYFl7l3wWA0DaV8NQktUTiowAhqGWUF5uQv43ob3S2I+LiR0993krntTj538mIZkcWNCD+1XkKRWNjymw71DQWNa21GD8yY6GYSBEOoNzyZTSpJQaeB4x19ViHomrnsDdEalHqlhHCdVjD3+zxWewPWEPjUzLGwhVKdlD9I9TGbdLMnIRcDux0ehffUUS7xHt060lmNVkZhoxY+XaVpjAfktRlCLUwbzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhvlEbtYPqsqSwqLx7qvx9U5elUq/N1zyRAd5QzxH80=;
 b=gYszyTr0MbEaQKA06xXticQ2WAHxKFS4iZc+Ao5PZ9ByblxUIr0BBKApF06/NbeCzroLLyScicUJPa+LDhI5lA74Expv2KxiR9SZ8qgrUjQA07H1h44cM2k1wn2CnaGmrWiEGSr+hfsJKn9SQ7E4O6MOVEvcHgEbIn2C7I7f0MRessjfUYnrnfGdF47aHSLmg7HHMXCxwiSvbhDJiJ4OweOkwrxazP+2NmLfN6dkd0Izne4FiUHNyC74wrgfLP0+uB82/iwVZVPFtXITrIr76+sSkojtI2V+jdkQXAK/ohbISfJWvrUB0NSNMrGwlIuXSsvPVKF7jPApF+ILRdLv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhvlEbtYPqsqSwqLx7qvx9U5elUq/N1zyRAd5QzxH80=;
 b=a+LUbgs//0/El/NCUxS/MvWyQKQkxyH6rJhV9KDTlvBiPAB/NBwSG/mfEOcMp5v0iqiYfX4oVQ1JwNmVElw8tg0sdolMY7FSJIVViGyhbVJTsEoWAoUYk1f5VM20IJKYEfKthFY69hZfjN5iQV/NIMirmWvzfWjCxAguXaRdWdk=
Received: from SN7PR04CA0217.namprd04.prod.outlook.com (2603:10b6:806:127::12)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 06:29:35 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::83) by SN7PR04CA0217.outlook.office365.com
 (2603:10b6:806:127::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 06:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 06:29:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 01:29:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 01:29:33 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Fri, 20 Oct 2023 01:29:28 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chao Song <chao.song@intel.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] ASoC: SOF: amd: add option to use sram for data bin loading
Date:   Fri, 20 Oct 2023 11:58:15 +0530
Message-ID: <20231020062822.3913760-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020062822.3913760-1-Vijendar.Mukunda@amd.com>
References: <20231020062822.3913760-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8e0cf2-bd17-4976-9b4b-08dbd135eda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FX8pOiNwNG8QlUJjsJLFvF2EA3ku2qa6fH5S9xeBqYoe9zFps+wBwAKiMqHdgszl8REycTez/hc8N+DLtwsY4bQnqsINqtLKrKPQU5Y/6jyBzGh/lc9GYroWd1v7LiOf420l6KdL9KYDs7a+P9n3ml+35Rj5f8gTQdhtWiaDlrs0y8LRO+JjuUiiPGqhp8z/nLNGej+3oSkSqIasR3D+ci+NW1n+tJBqSlq/zsmX4JQRUVTcAwy36RCdyM+LFKQnroaVIppyvTYqFYDIWRbhuRDbO3XoXtyub/4GsC6g/KcLAGXYZR4CzJQsu0EWtNKdhI1qj+05d7PTgJURjAp/ylwA+og5e4yQdFuSOmNJ9dcBRfbp218i/BL+YLG45J8B7caIDcC33dgqcyNFqVpyvDchePg0UbhSuonSD3pgjR0UAopXd5EE79SD4af+E6cIff2v+a9s/+oTpWzmkMES3ZTKgBtXAPnnExtSRe/tjdMZXDo8wGJG6XTpaQek3jeLZGaOoSA5AN8jgiVVI1dN5x2iiUxddjS2BECWF8MoZyu5yia4IGHPiKovNnR8hmTvCMNoe/SsRwN55mekiZ/5NVLTwtTFacFs91gXBmv41bAi96Ea4N51dkFTJLLrouEDCeABz14tFJG27yXALeHFao3tVdBgOQhjEOCf0gjETzPHeR/R5nhSe3MkqF2ThHHVQy65cBI86kaF+sWE2Tgj56pSAOefGDm88mDInVshNiFPeqr42U1CZutlVbQl/39Mrvwvtml1GxnOgVVImE5j5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(6916009)(6666004)(336012)(426003)(7696005)(478600001)(47076005)(36860700001)(70586007)(70206006)(316002)(26005)(36756003)(83380400001)(1076003)(2616005)(54906003)(41300700001)(81166007)(5660300002)(82740400003)(356005)(7416002)(40460700003)(8676002)(8936002)(4326008)(2906002)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 06:29:35.3088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8e0cf2-bd17-4976-9b4b-08dbd135eda7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an option to load DSP data bin to ACP SRAM.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-loader.c | 46 +++++++++++++++++++++++++++++-----
 sound/soc/sof/amd/acp.h        | 10 +++++++-
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index d35d47d7e311..e05eb7a86dd4 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -19,8 +19,9 @@
 #include "acp-dsp-offset.h"
 #include "acp.h"
 
-#define FW_BIN		0
-#define FW_DATA_BIN	1
+#define FW_BIN			0
+#define FW_DATA_BIN		1
+#define FW_SRAM_DATA_BIN	2
 
 #define FW_BIN_PTE_OFFSET	0x00
 #define FW_DATA_BIN_PTE_OFFSET	0x08
@@ -49,7 +50,6 @@ int acp_dsp_block_write(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_t
 			u32 offset, void *src, size_t size)
 {
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
-	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	struct acp_dev_data *adata;
 	void *dest;
 	u32 dma_size, page_count;
@@ -86,9 +86,18 @@ int acp_dsp_block_write(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_t
 		adata->is_dram_in_use = true;
 		break;
 	case SOF_FW_BLK_TYPE_SRAM:
-		offset = offset - desc->sram_pte_offset;
-		memcpy_to_scratch(sdev, offset, src, size);
-		return 0;
+		if (!adata->sram_data_buf) {
+			adata->sram_data_buf = dma_alloc_coherent(&pci->dev,
+								  ACP_DEFAULT_SRAM_LENGTH,
+								  &adata->sram_dma_addr,
+								  GFP_ATOMIC);
+			if (!adata->sram_data_buf)
+				return -ENOMEM;
+		}
+		adata->fw_sram_data_bin_size = size + offset;
+		dest = adata->sram_data_buf + offset;
+		adata->is_sram_in_use = true;
+		break;
 	default:
 		dev_err(sdev->dev, "bad blk type 0x%x\n", blk_type);
 		return -EINVAL;
@@ -123,6 +132,10 @@ static void configure_pte_for_fw_loading(int type, int num_pages, struct acp_dev
 		offset = adata->fw_bin_page_count * 8;
 		addr = adata->dma_addr;
 		break;
+	case FW_SRAM_DATA_BIN:
+		offset = (adata->fw_bin_page_count + ACP_DRAM_PAGE_COUNT) * 8;
+		addr = adata->sram_dma_addr;
+		break;
 	default:
 		dev_err(sdev->dev, "Invalid data type %x\n", type);
 		return;
@@ -189,6 +202,22 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 		if (ret < 0)
 			dev_err(sdev->dev, "acp dma transfer status: %d\n", ret);
 	}
+	if (adata->is_sram_in_use) {
+		configure_pte_for_fw_loading(FW_SRAM_DATA_BIN, ACP_SRAM_PAGE_COUNT, adata);
+		src_addr = ACP_SYSTEM_MEMORY_WINDOW + ACP_DEFAULT_SRAM_LENGTH +
+			   (page_count * ACP_PAGE_SIZE);
+		dest_addr = ACP_SRAM_BASE_ADDRESS;
+
+		ret = configure_and_run_dma(adata, src_addr, dest_addr,
+					    adata->fw_sram_data_bin_size);
+		if (ret < 0) {
+			dev_err(sdev->dev, "acp dma configuration failed: %d\n", ret);
+			return ret;
+		}
+		ret = acp_dma_status(adata, 0);
+		if (ret < 0)
+			dev_err(sdev->dev, "acp dma transfer status: %d\n", ret);
+	}
 
 	if (desc->rev > 3) {
 		/* Cache Window enable */
@@ -205,6 +234,11 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 				  adata->dma_addr);
 		adata->data_buf = NULL;
 	}
+	if (adata->is_sram_in_use) {
+		dma_free_coherent(&pci->dev, ACP_DEFAULT_SRAM_LENGTH, adata->sram_data_buf,
+				  adata->sram_dma_addr);
+		adata->sram_data_buf = NULL;
+	}
 	return ret;
 }
 EXPORT_SYMBOL_NS(acp_dsp_pre_fw_run, SND_SOC_SOF_AMD_COMMON);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 2d1f57e1365a..c536cfde0e44 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -56,7 +56,7 @@
 #define ACP_IRAM_BASE_ADDRESS			0x000000
 #define ACP_DRAM_BASE_ADDRESS			0x01000000
 #define ACP_DRAM_PAGE_COUNT			128
-
+#define ACP_SRAM_BASE_ADDRESS			0x3806000
 #define ACP_DSP_TO_HOST_IRQ			0x04
 
 #define ACP_RN_PCI_ID				0x01
@@ -88,6 +88,8 @@
 #define PROBE_STATUS_BIT			BIT(31)
 
 #define ACP_FIRMWARE_SIGNATURE			0x100
+#define ACP_DEFAULT_SRAM_LENGTH			0x00080000
+#define ACP_SRAM_PAGE_COUNT			128
 
 enum clock_source {
 	ACP_CLOCK_96M = 0,
@@ -194,13 +196,18 @@ struct acp_dev_data {
 	struct platform_device *dmic_dev;
 	unsigned int fw_bin_size;
 	unsigned int fw_data_bin_size;
+	unsigned int fw_sram_data_bin_size;
 	const char *fw_code_bin;
 	const char *fw_data_bin;
+	const char *fw_sram_data_bin;
 	u32 fw_bin_page_count;
+	u32 fw_data_bin_page_count;
 	dma_addr_t sha_dma_addr;
 	u8 *bin_buf;
 	dma_addr_t dma_addr;
 	u8 *data_buf;
+	dma_addr_t sram_dma_addr;
+	u8 *sram_data_buf;
 	bool signed_fw_image;
 	struct dma_descriptor dscr_info[ACP_MAX_DESC];
 	struct acp_dsp_stream stream_buf[ACP_MAX_STREAM];
@@ -209,6 +216,7 @@ struct acp_dev_data {
 	struct acp_dsp_stream *probe_stream;
 	bool enable_fw_debug;
 	bool is_dram_in_use;
+	bool is_sram_in_use;
 };
 
 void memcpy_to_scratch(struct snd_sof_dev *sdev, u32 offset, unsigned int *src, size_t bytes);
-- 
2.34.1

