Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE937D0876
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376319AbjJTG3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjJTG3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:29:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D27A3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkoJCCAXAP0g8RYt1HllZ9Btp0ntMALJHaeGv7rlMEBPSo+ppF3E6E79cBn7AcU5p4rBUdRoFZeLOpW0Hc5nzbY5E3kBcDyaBa2/oV3+6+wCFUs2wjAgh0cnvyF5i87ravPV/kSqS2O1R8SyEIDX4GcBvX8RsZIwp33lbnzoZ2tvi8QL9Aj1c0ErIDNoDnd/OkZkk9yHZ0sx5vUsGadcGGu/6CnL7IS/rifx57icv7n1c/78K9Ad2qFo6WcTXuaCk7CERQXKEdkk4s4MTFMuTziUoQ+HQK5I3pHrAatQ5DyPBf/tGIcjv/krd37CinU7bZOQoXJxpt8ZU8ruD7+qhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDCXCiZoqnjUxCvpDcsRrOWumgzb76V6UiN2QRKdBaY=;
 b=TDDEyujFTPhX6O8nLwEbDsoDlVJhMMg58tYoshGauFWmZgCqM2gMHee4yhAwOk0ATx80rhvT/cNWG9ZYu/CJkSDD90W3u0lx7lZhWOz0LraVBVsHYhtwgqr5qoYDEyjdP+OvhvgBUF0mvVmkBRAaPcfrlIuOHITg0LMj+u4lQC/mypEp5Y6rhaelYCU+s73IE4sHUTHiZ6CM714zhgIJ351PWfNTiKkFtopf4KAbJs95N+3j2Mv3vRzO5/R3WqrC/Yn0+7ChmkTIAfxLU/pDg+GfRJshesClMBpgrVFKd/lGqkBwKZJvfLY5TPhCZpOaAxV8m+1fDBfNsqD+x5+BwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDCXCiZoqnjUxCvpDcsRrOWumgzb76V6UiN2QRKdBaY=;
 b=tI7bn0u30ZAKak3U3hAKqYeeKAZMQOJm7LlXyovaCVCxWlgOkCwaPqQyl/MdvuMxGCgUUAAjIcmTxLNMplRrHlqlqMhuvuoXqnKGmBicBrg1IVokc7Jc28dbUj4OKO+3Ka0maAnEFOE8aDZJ5JsxEcvbGQSBSoX0m9TgL/DSFcs=
Received: from CY5PR15CA0103.namprd15.prod.outlook.com (2603:10b6:930:7::26)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 06:29:03 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::5e) by CY5PR15CA0103.outlook.office365.com
 (2603:10b6:930:7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 06:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 06:29:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 01:28:58 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Fri, 20 Oct 2023 01:28:53 -0500
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
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
Subject: [PATCH 2/5] ASoC: SOF: amd: add support for acp6.3 based platform
Date:   Fri, 20 Oct 2023 11:58:12 +0530
Message-ID: <20231020062822.3913760-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020062822.3913760-1-Vijendar.Mukunda@amd.com>
References: <20231020062822.3913760-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db75bb5-20eb-4dea-798a-08dbd135da4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Msmx9nsmEhUrp2i9IZIPKkJ6cmWvynEB4Wh8k8Q0E5Y0uugBaqHnyLfCwEHzNNl04uyBi4VoJhnog20HXvBvOo3Mk+Fb1iOFcOU6kl7f8yCVkmIrAZDNUSlor8LDDA7gvzCbLq7TItbKMXh32u5XbFHXIyhyS/I+ZKVyyIXpxarWVNCH+Lgkx5UJXo0vsNlj2Unfc94+ItvP71bnavwRzT4B4zFfjtTFTIsfWl7Hq+VfGdBfpoOZFizSOQ16eo0EuCtkgwLAb8D3acrFcXwEEWNzi+bDylMSNtcbFXo6YxTyXYkjqpVxdxTDu+a2lvv9a3j21CblO5VeO8P1X1HYtN9u0P1P9DphT9ioF3fFSGiM+UQoLWQJ8N4O09bpVBG5S/+NAKLIOTy05fwkc7pQM3ayyQnimCRhB5qiNnVBBDItd0D+1QRuNegYLmQg1TK9vxiUAhDr+4eIKBUyWbqOtuO8YacLddF8ZJRbJximgely3t5K9aPIVWRrBpA2dwNmnyJwCmnqLB0TEcl88kNLKO6MA2NGDHA5EDNSmSYp9FeeKvRm8Rt0ZQWewD5p51+yiViEc9HXGCpdmT4Tqap97PpmIcslVvSot7blBIP8tM3epgId80saZzeI4CFFPge4F2LOsa0szTH/hTy6Y3WQs8qyTJAVGmHAd81tknfjjF0XfM/PyfwjqpkSK6ZMzzrWuGD/xcSaR0pgGpHfRIid3KXkKKuznBOGDlRcYQh9m202O7ZRU5zTuar36MUuasT3IVpglO34PL7fLFs1qfZa8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(86362001)(40480700001)(6666004)(54906003)(70586007)(6916009)(316002)(478600001)(8936002)(70206006)(2906002)(5660300002)(8676002)(4326008)(36756003)(47076005)(36860700001)(2616005)(7416002)(336012)(41300700001)(426003)(26005)(81166007)(356005)(7696005)(1076003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 06:29:02.8167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db75bb5-20eb-4dea-798a-08dbd135da4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SOF support for ACP6.3 version based platform

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/Kconfig     |   9 +++
 sound/soc/sof/amd/Makefile    |   2 +
 sound/soc/sof/amd/acp.h       |   4 +
 sound/soc/sof/amd/acp63.c     | 146 ++++++++++++++++++++++++++++++++++
 sound/soc/sof/amd/pci-acp63.c | 106 ++++++++++++++++++++++++
 5 files changed, 267 insertions(+)
 create mode 100644 sound/soc/sof/amd/acp63.c
 create mode 100644 sound/soc/sof/amd/pci-acp63.c

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index f2faa08f0c0e..19c5e27a193f 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -60,4 +60,13 @@ config SND_SOC_SOF_ACP_PROBES
 	  This option is not user-selectable but automatically handled by
 	  'select' statements at a higher level
 
+config SND_SOC_SOF_AMD_ACP63
+	tristate "SOF support for ACP6.3 platform"
+	depends on SND_SOC_SOF_PCI
+	select SND_SOC_SOF_AMD_COMMON
+	help
+	  Select this option for SOF support on
+	  AMD ACP6.3 version based platforms.
+	  Say Y if you want to enable SOF on ACP6.3 based platform.
+	  If unsure select "N".
 endif
diff --git a/sound/soc/sof/amd/Makefile b/sound/soc/sof/amd/Makefile
index f3b375e67a6f..ad25f4206177 100644
--- a/sound/soc/sof/amd/Makefile
+++ b/sound/soc/sof/amd/Makefile
@@ -9,8 +9,10 @@ snd-sof-amd-acp-$(CONFIG_SND_SOC_SOF_ACP_PROBES) = acp-probes.o
 snd-sof-amd-renoir-objs := pci-rn.o renoir.o
 snd-sof-amd-rembrandt-objs := pci-rmb.o rembrandt.o
 snd-sof-amd-vangogh-objs := pci-vangogh.o vangogh.o
+snd-sof-amd-acp63-objs := pci-acp63.o acp63.o
 
 obj-$(CONFIG_SND_SOC_SOF_AMD_COMMON) += snd-sof-amd-acp.o
 obj-$(CONFIG_SND_SOC_SOF_AMD_RENOIR) +=snd-sof-amd-renoir.o
 obj-$(CONFIG_SND_SOC_SOF_AMD_REMBRANDT) +=snd-sof-amd-rembrandt.o
 obj-$(CONFIG_SND_SOC_SOF_AMD_VANGOGH) +=snd-sof-amd-vangogh.o
+obj-$(CONFIG_SND_SOC_SOF_AMD_ACP63) +=snd-sof-amd-acp63.o
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 6814f2051104..3d2c5f07ed44 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -62,10 +62,12 @@
 #define ACP_RN_PCI_ID				0x01
 #define ACP_VANGOGH_PCI_ID			0x50
 #define ACP_RMB_PCI_ID				0x6F
+#define ACP63_PCI_ID				0x63
 
 #define HOST_BRIDGE_CZN				0x1630
 #define HOST_BRIDGE_VGH				0x1645
 #define HOST_BRIDGE_RMB				0x14B5
+#define HOST_BRIDGE_ACP63			0x14E8
 #define ACP_SHA_STAT				0x8000
 #define ACP_PSP_TIMEOUT_US			1000000
 #define ACP_EXT_INTR_ERROR_STAT			0x20000000
@@ -273,6 +275,8 @@ extern struct snd_sof_dsp_ops sof_vangogh_ops;
 int sof_vangogh_ops_init(struct snd_sof_dev *sdev);
 extern struct snd_sof_dsp_ops sof_rembrandt_ops;
 int sof_rembrandt_ops_init(struct snd_sof_dev *sdev);
+extern struct snd_sof_dsp_ops sof_acp63_ops;
+int sof_acp63_ops_init(struct snd_sof_dev *sdev);
 
 struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev);
 /* Machine configuration */
diff --git a/sound/soc/sof/amd/acp63.c b/sound/soc/sof/amd/acp63.c
new file mode 100644
index 000000000000..9fb645079c3a
--- /dev/null
+++ b/sound/soc/sof/amd/acp63.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2023 Advanced Micro Devices, Inc.
+//
+// Authors: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
+
+/*
+ * Hardware interface for Audio DSP on ACP6.3 version based platform
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+
+#include "../ops.h"
+#include "../sof-audio.h"
+#include "acp.h"
+#include "acp-dsp-offset.h"
+
+#define I2S_HS_INSTANCE		0
+#define I2S_BT_INSTANCE		1
+#define I2S_SP_INSTANCE		2
+#define PDM_DMIC_INSTANCE	3
+#define I2S_HS_VIRTUAL_INSTANCE 4
+
+static struct snd_soc_dai_driver acp63_sof_dai[] = {
+	[I2S_HS_INSTANCE] = {
+		.id = I2S_HS_INSTANCE,
+		.name = "acp-sof-hs",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S HS controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+
+	[I2S_BT_INSTANCE] = {
+		.id = I2S_BT_INSTANCE,
+		.name = "acp-sof-bt",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S BT controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+
+	[I2S_SP_INSTANCE] = {
+		.id = I2S_SP_INSTANCE,
+		.name = "acp-sof-sp",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S SP controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+
+	[PDM_DMIC_INSTANCE] = {
+		.id = PDM_DMIC_INSTANCE,
+		.name = "acp-sof-dmic",
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 4,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+
+	[I2S_HS_VIRTUAL_INSTANCE] = {
+		.id = I2S_HS_VIRTUAL_INSTANCE,
+		.name = "acp-sof-hs-virtual",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+	},
+};
+
+/* Phoenix ops */
+struct snd_sof_dsp_ops sof_acp63_ops;
+EXPORT_SYMBOL_NS(sof_acp63_ops, SND_SOC_SOF_AMD_COMMON);
+
+int sof_acp63_ops_init(struct snd_sof_dev *sdev)
+{
+	/* common defaults */
+	memcpy(&sof_acp63_ops, &sof_acp_common_ops, sizeof(struct snd_sof_dsp_ops));
+
+	sof_acp63_ops.drv = acp63_sof_dai;
+	sof_acp63_ops.num_drv = ARRAY_SIZE(acp63_sof_dai);
+
+	return 0;
+}
+
+MODULE_IMPORT_NS(SND_SOC_SOF_AMD_COMMON);
+MODULE_DESCRIPTION("ACP63 SOF Driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/amd/pci-acp63.c b/sound/soc/sof/amd/pci-acp63.c
new file mode 100644
index 000000000000..bceb94ac80a9
--- /dev/null
+++ b/sound/soc/sof/amd/pci-acp63.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2023 Advanced Micro Devices, Inc. All rights reserved.
+//
+// Authors: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
+
+/*.
+ * PCI interface for ACP6.3 device
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <sound/sof.h>
+#include <sound/soc-acpi.h>
+
+#include "../ops.h"
+#include "../sof-pci-dev.h"
+#include "../../amd/mach-config.h"
+#include "acp.h"
+#include "acp-dsp-offset.h"
+
+#define ACP6X_FUTURE_REG_ACLK_0		0x1854
+#define ACP6x_REG_START			0x1240000
+#define ACP6x_REG_END			0x125C000
+
+static const struct sof_amd_acp_desc acp63_chip_info = {
+	.rev		= 6,
+	.host_bridge_id = HOST_BRIDGE_ACP63,
+	.pgfsm_base	= ACP6X_PGFSM_BASE,
+	.ext_intr_stat	= ACP6X_EXT_INTR_STAT,
+	.dsp_intr_base	= ACP6X_DSP_SW_INTR_BASE,
+	.sram_pte_offset = ACP6X_SRAM_PTE_OFFSET,
+	.hw_semaphore_offset = ACP6X_AXI2DAGB_SEM_0,
+	.fusion_dsp_offset = ACP6X_DSP_FUSION_RUNSTALL,
+	.probe_reg_offset = ACP6X_FUTURE_REG_ACLK_0,
+};
+
+static const struct sof_dev_desc acp63_desc = {
+	.machines		= snd_soc_acpi_amd_acp63_sof_machines,
+	.resindex_lpe_base	= 0,
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= -1,
+	.irqindex_host_ipc	= -1,
+	.chip_info		= &acp63_chip_info,
+	.ipc_supported_mask     = BIT(SOF_IPC_TYPE_3),
+	.ipc_default            = SOF_IPC_TYPE_3,
+	.default_fw_path	= {
+		[SOF_IPC_TYPE_3] = "amd/sof",
+	},
+	.default_tplg_path	= {
+		[SOF_IPC_TYPE_3] = "amd/sof-tplg",
+	},
+	.default_fw_filename	= {
+		[SOF_IPC_TYPE_3] = "sof-acp_6_3.ri",
+	},
+	.nocodec_tplg_filename	= "sof-acp.tplg",
+	.ops			= &sof_acp63_ops,
+	.ops_init		= sof_acp63_ops_init,
+};
+
+static int acp63_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+{
+	unsigned int flag;
+
+	if (pci->revision != ACP63_PCI_ID)
+		return -ENODEV;
+
+	flag = snd_amd_acp_find_config(pci);
+	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
+		return -ENODEV;
+
+	return sof_pci_probe(pci, pci_id);
+};
+
+static void acp63_pci_remove(struct pci_dev *pci)
+{
+	sof_pci_remove(pci);
+}
+
+/* PCI IDs */
+static const struct pci_device_id acp63_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_PCI_DEV_ID),
+	.driver_data = (unsigned long)&acp63_desc},
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, acp63_pci_ids);
+
+/* pci_driver definition */
+static struct pci_driver snd_sof_pci_amd_acp63_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = acp63_pci_ids,
+	.probe = acp63_pci_probe,
+	.remove = acp63_pci_remove,
+	.driver = {
+		.pm = &sof_pci_pm,
+	},
+};
+module_pci_driver(snd_sof_pci_amd_acp63_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(SND_SOC_SOF_AMD_COMMON);
+MODULE_IMPORT_NS(SND_SOC_SOF_PCI_DEV);
-- 
2.34.1

