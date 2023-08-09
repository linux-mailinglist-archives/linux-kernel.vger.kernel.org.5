Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2874775F33
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjHIMgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjHIMgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:36:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D874A1FCC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP/GD96Rv/pNaoIihnN59rRzry0dt9+Og06xWI/YfqeLm1lNH0Q6nFey/Yi8raAPEFztPVaibyquxkYpZBOXHqalq084hh9n5QNhejp1qNRZL8C0El9A4SvBqlBVqFDXmplR95t1jrM6qupNatJeDBQx2JqzBqmE0K8O3Aa/xjesL5AYw/w2cE3iYYLZPa1j5HSV7PRGw/wWNNnbMUip3kLVGTnfWLzDGlmTe22qDuiJf2d4ZuMPUYCK27LdxTieLw9nOHkjroPQLjPALLxggx4oYAuCde2JIdU63UwwGJZT/aRa081g+JtGvvXf5+I1A/QzvvrrsCkJboZuKjUOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DYmUiF/sRfV6N9Mq1JCEcRZhggpEpez/B6klkbmXsc=;
 b=cy2isNz1tb/fNzBFpXuoAXGr33FrnHORKZtWjxSDTOvN2gcsBXatu+nmM7NamT/95blAoVz0i/19NTWdvw3AHDOPJVb5MfIy7YVE1rS80Yu7yMS9HL323fFZw5VdXn9lj9vhqboLoS+LBylK6UErxTPhZpE7NBRcA02RWhZv/5VH2dGVBTRUNS1LJ6Qga4AxBU2epSQC+GumHPpFdO6dPH5h1pcJcuKoL/S4mn9/Aof9E3wM+LuxizprJTDOIaejawdpBWV0pH6B2QlKTx+WApEXrDmqGOtxW+ZeH2S6Qs+fvKv1Trnnxl8/i4+voQ+PYhk26JGG1pOZjLNnd0OPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DYmUiF/sRfV6N9Mq1JCEcRZhggpEpez/B6klkbmXsc=;
 b=B7gVOOokf5ONOnUTlfxJZwSA+GLqMdBVii2ES+JSuXI2LZICpm/2vRdkRV1nf5kODSYw1boPIb72flB/jLaTNy2AaMqM6qp39BBdDpZ7Cu21RUQco9HFGd+s2KyMS9RTiIZje7xJTMgKYEDtXJmdp76HArdWifbWPki05czcNZE=
Received: from SN6PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:805:106::31) by CY5PR12MB6370.namprd12.prod.outlook.com
 (2603:10b6:930:20::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 12:36:12 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::79) by SN6PR2101CA0021.outlook.office365.com
 (2603:10b6:805:106::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.3 via Frontend
 Transport; Wed, 9 Aug 2023 12:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Wed, 9 Aug 2023 12:36:12 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 07:36:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 05:36:11 -0700
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 9 Aug 2023 07:35:55 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <syed.sabakareem@amd.com>, <mastan.katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] ASOC: SOF: amd : Add support for signed fw image loading
Date:   Wed, 9 Aug 2023 18:05:21 +0530
Message-ID: <20230809123534.287707-2-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809123534.287707-1-venkataprasad.potturu@amd.com>
References: <20230809123534.287707-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f55502d-0a53-47cd-f0bf-08db98d53731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ew+5QIlPSwSCiut/7Q0R+OPdAqTNtPvTtl9taVVF2ccsQ2YW1xs3bm28q1A3CI9o30eu3/yGF6wg+xvulbwZIeu5EkmXO9uW/AqoDck8ExEhIudapvn5LUuT6YEFMDQQnE8XV4oKRLzQX5grQysLnDcmLwfiymLvIcaxtLpC002b5LRnbB/L4YFTP+sncChZc01EZpFxgB5aiMKSIpnGvgWpaj5f7OOsVqhq8ddlwJEPVoVXgEmMo8M9zn5Sliw00uuCZogyCJhOJvH4gyQTL7Ad2Xa2prrSUhBxTLE3SwXsY1kDo72B1O70dfbisgwGr7eWL8RLh6bU0mfynW9VJOrPaTgSiUiEDUjUmuwn9fJE7wPgLiEMaHB48CzczPDnGFQkN7py6qv7KWbY2DMTwOpR+gSN8djUAvdO5XBBtZ6a15vPJi1cD3/vYx8eQlY0BkOyHX6L83GMQ+Dnu+jDuvTafmt9vXdj1kKFQLwLZLjyPbdvAHgebCLQy8AIvKcnkBuIXhOf5kNBelAZqNZkvDk3BzHAvJVUbM3DgGS2BD9bIETvxJWcp/q0koOqypYpjvxTjtW0I2LP9ld3ORozlTSFG3xS3SEHKwU52cBkGRn0JsTmGUAWlRoJ2Bo8oaVKL3lOc9hbCPJ9nI6W7GHl0BTuFJt+sGurpvbuEB1h3krzcIR3aChIzOh3+k0byQyxbB6gPzZNoJzZS6ti4r9klZwDcGmkft2e1r0F8PDWURtCrcdSs1TlIQGnKH5e2Qvw97jPeLtikEc9y000R40rog==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(82310400008)(451199021)(1800799006)(186006)(40470700004)(46966006)(36840700001)(47076005)(36860700001)(316002)(426003)(4326008)(83380400001)(41300700001)(110136005)(54906003)(7696005)(478600001)(6666004)(2616005)(70206006)(70586007)(1076003)(336012)(26005)(2906002)(36756003)(86362001)(40480700001)(40460700003)(82740400003)(356005)(81166007)(5660300002)(8936002)(8676002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 12:36:12.3907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f55502d-0a53-47cd-f0bf-08db98d53731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for signed firmware code bin and data bin
loading for amd platforms.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/sof/amd/acp-dsp-offset.h |  1 +
 sound/soc/sof/amd/acp-loader.c     | 39 ++++++++++++++++++++++++++++--
 sound/soc/sof/amd/acp.c            |  6 ++++-
 sound/soc/sof/amd/acp.h            |  8 ++++++
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index 19ef2b4c46d6..a913f1cc4c80 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -87,6 +87,7 @@
 #define ACP_SHA_DMA_CMD_STS			0x1CC0
 #define ACP_SHA_DMA_ERR_STATUS			0x1CC4
 #define ACP_SHA_TRANSFER_BYTE_CNT		0x1CC8
+#define ACP_SHA_DMA_INCLUDE_HDR         0x1CCC
 #define ACP_SHA_PSP_ACK                         0x1C74
 
 #define ACP_SCRATCH_REG_0			0x10000
diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index a4bce5a3ae48..a63c00b53a5e 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -3,7 +3,7 @@
 // This file is provided under a dual BSD/GPLv2 license. When using or
 // redistributing this file, you may do so under either license.
 //
-// Copyright(c) 2021 Advanced Micro Devices, Inc.
+// Copyright(c) 2021, 2023 Advanced Micro Devices, Inc.
 //
 // Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
 
@@ -158,7 +158,11 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 	int ret;
 
 	adata = sdev->pdata->hw_pdata;
-	size_fw = adata->fw_bin_size;
+
+	if (adata->signed_fw_image)
+		size_fw = adata->fw_bin_size - ACP_FIRMWARE_SIGNATURE;
+	else
+		size_fw = adata->fw_bin_size;
 
 	page_count = PAGE_ALIGN(size_fw) >> PAGE_SHIFT;
 	adata->fw_bin_page_count = page_count;
@@ -219,3 +223,34 @@ int acp_sof_dsp_run(struct snd_sof_dev *sdev)
 	return 0;
 }
 EXPORT_SYMBOL_NS(acp_sof_dsp_run, SND_SOC_SOF_AMD_COMMON);
+
+int acp_sof_load_signed_firmware(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_pdata *plat_data = sdev->pdata;
+	struct acp_dev_data *adata = plat_data->hw_pdata;
+	int ret;
+
+	ret = request_firmware(&sdev->basefw.fw, adata->fw_code_bin, sdev->dev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "sof signed firmware code bin is missing\n");
+		return ret;
+	} else {
+		dev_dbg(sdev->dev, "request_firmware %s successful\n", adata->fw_code_bin);
+	}
+	ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_IRAM, 0,
+				      (void *)sdev->basefw.fw->data, sdev->basefw.fw->size);
+
+	ret = request_firmware(&adata->fw_dbin, adata->fw_data_bin, sdev->dev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "sof signed firmware data bin is missing\n");
+		return ret;
+
+	} else {
+		dev_dbg(sdev->dev, "request_firmware %s successful\n", adata->fw_data_bin);
+	}
+
+	ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_DRAM, 0,
+				      (void *)adata->fw_dbin->data, adata->fw_dbin->size);
+	return ret;
+}
+EXPORT_SYMBOL_NS(acp_sof_load_signed_firmware, SND_SOC_SOF_AMD_COMMON);
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index c450931ae77e..0072a62aa4ef 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -3,7 +3,7 @@
 // This file is provided under a dual BSD/GPLv2 license. When using or
 // redistributing this file, you may do so under either license.
 //
-// Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.
+// Copyright(c) 2021, 2023 Advanced Micro Devices, Inc. All rights reserved.
 //
 // Authors: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
 //	    Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
@@ -235,6 +235,9 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 		}
 	}
 
+	if (adata->signed_fw_image)
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_INCLUDE_HDR, ACP_SHA_HEADER);
+
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_STRT_ADDR, start_addr);
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_DESTINATION_ADDR, dest_addr);
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_MSG_LENGTH, image_length);
@@ -527,6 +530,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	sdev->debug_box.offset = sdev->host_box.offset + sdev->host_box.size;
 	sdev->debug_box.size = BOX_SIZE_1024;
 
+	adata->signed_fw_image = false;
 	acp_memory_init(sdev);
 
 	acp_dsp_stream_init(sdev);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 73c3e1373d42..842105330369 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -41,6 +41,7 @@
 #define DSP_FW_RUN_ENABLE			0x01
 #define ACP_SHA_RUN				0x01
 #define ACP_SHA_RESET				0x02
+#define ACP_SHA_HEADER				0x01
 #define ACP_DMA_CH_RST				0x01
 #define ACP_DMA_CH_GRACEFUL_RST_EN		0x10
 #define ACP_ATU_CACHE_INVALID			0x01
@@ -82,6 +83,8 @@
 #define SRAM1_SIZE				0x13A000
 #define PROBE_STATUS_BIT			BIT(31)
 
+#define ACP_FIRMWARE_SIGNATURE			0x100
+
 enum clock_source {
 	ACP_CLOCK_96M = 0,
 	ACP_CLOCK_48M,
@@ -181,15 +184,19 @@ struct sof_amd_acp_desc {
 /* Common device data struct for ACP devices */
 struct acp_dev_data {
 	struct snd_sof_dev  *dev;
+	const struct firmware *fw_dbin;
 	/* DMIC device */
 	struct platform_device *dmic_dev;
 	unsigned int fw_bin_size;
 	unsigned int fw_data_bin_size;
+	const char *fw_code_bin;
+	const char *fw_data_bin;
 	u32 fw_bin_page_count;
 	dma_addr_t sha_dma_addr;
 	u8 *bin_buf;
 	dma_addr_t dma_addr;
 	u8 *data_buf;
+	bool signed_fw_image;
 	struct dma_descriptor dscr_info[ACP_MAX_DESC];
 	struct acp_dsp_stream stream_buf[ACP_MAX_STREAM];
 	struct acp_dsp_stream *dtrace_stream;
@@ -214,6 +221,7 @@ int amd_sof_acp_remove(struct snd_sof_dev *sdev);
 /* DSP Loader callbacks */
 int acp_sof_dsp_run(struct snd_sof_dev *sdev);
 int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev);
+int acp_sof_load_signed_firmware(struct snd_sof_dev *sdev);
 int acp_get_bar_index(struct snd_sof_dev *sdev, u32 type);
 
 /* Block IO callbacks */
-- 
2.25.1

