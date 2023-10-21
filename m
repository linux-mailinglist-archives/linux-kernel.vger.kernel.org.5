Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63897D1DAA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjJUOxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjJUOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:53:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C631704
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxPVIYtGXeZsatPVwwghKhcvrMMRDEd0O1NAGOrqa5I6Puwm3K80G+RUOzfK4775P3GlO0ipxMjS6mQSzQZUlZ5fBue9An8tYBc4DjMFhW8YGujac/QTj8sIf5QUos1Xb8UjQOSyXqDooqc/z7TKr057cwh0Kn/xve1Ckt83s7psi2kFEqZ8+9SbJ1rBe0DBQUwoDisfpwsSM8XqM6RTtoFNEqvch1fDeqrg+duQQsYac6hbe328zanKYHvPO0loYScrGf7DxacncMexMknql9PUZZ0YlI8p5FEVN7vWhOGSS1doROHM9Jj8zE7PUYS9I1pE9tWrE1Zu9lMgKBCvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUl+/jOmshxtwB90xbdpSKuf+wov1WY/I+TPhIdwLyg=;
 b=k4rig5IUk50FtojXjd+EludzYeXQGM3kKFl262+eeTDKwoWvY32Gvc5tcAUGz1+jFuVpvbfm2/vwkBcfMLriyZZ9F6RXdUQG1/PsofbTRsQeeETW6hDsDOUDDLKMbXcukdW4z1yx6jYUrVEx5LLb1Tnw4E9JMAA7O1lRWXYF5GCimVt0A3ClH05YCMPofKFKfThStBw3FbmqoacGOptHqYknfVGUjgU1P8TRA1maVd3aD1oeM2qcNv7RnUK9XPcndICZFEGCpXrtQuLSZMceRnAXWIIQ6fMiBvkvZIWJreOgB0GAMXcWNIEFC89QWZvw/U1Raf/W/3cH70EGaH4gRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUl+/jOmshxtwB90xbdpSKuf+wov1WY/I+TPhIdwLyg=;
 b=5BF0lC9Uggrj+m8FztaGB7ZIppv9pPvbhpKFUTcia0DVrxUqPUZ6/WiACHi8D0s9cf8qEMjfWxELj1lngWCPtl1Fn34S8Mzv6TMAIiomWShGunxDSGfL3sVzhDUiSEmeqXzqqjeK1MMuyyJx8Bix5eKjzJHjvvmOPqAHOEeIXd8=
Received: from PH0PR07CA0048.namprd07.prod.outlook.com (2603:10b6:510:e::23)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sat, 21 Oct
 2023 14:53:18 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::fb) by PH0PR07CA0048.outlook.office365.com
 (2603:10b6:510:e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Sat, 21 Oct 2023 14:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Sat, 21 Oct 2023 14:53:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:53:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:53:16 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sat, 21 Oct 2023 09:53:10 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <venkataprasad.potturu@amd.com>, <arungopal.kondaveeti@amd.com>,
        <mastan.katragadda@amd.com>, <juan.martinez@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        Marian Postevca <posteuca@mutex.one>,
        "Jarkko Nikula" <jarkko.nikula@bitmer.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/13] ASoC: amd: acp: Add pci legacy driver support for acp7.0 platform
Date:   Sat, 21 Oct 2023 20:20:53 +0530
Message-ID: <20231021145110.478744-12-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: ee501119-f36a-48fc-3a37-08dbd24575fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aaafx4uqYdIfL5ES2Z0KZPEo07dbNL+r8VUfpVARsNo4m535NCzaHp8Fj1cWcdcMHoNraQZFPAVirLUeVY3/6B6AmlGbPREgBmV1f+Ysx2po0Q1N5l1r+FpHwTC7FXkTB9X1/eQXHOCjlGA6zDEalDS/RSqIS0giAQcWFFXA7CKldOgEMZRhKUz0/zDGVnVu2/+RSH7OyQH8v9kO6GDL7gmo7z/o5DO1AVxcC30L3zhWSSM9rKW5reSX9ckgDXxvMI2EpsXESEkf2Q1jC/FSQPFpUD5PsIFFcYb3MB83YLvh5u51CmBqYTHfgumrf5BxYjDctmTAZuYLozteZduynlhZJe4LYrRU/EyykU3Xp2BUHFv1doyF09nM+LJ9LO64WkkzeModmeqep3pppfsIuzU1YeTTnaVCY54SoWoCNLl6YjJXDc2kLNxn2AtuDKPNdcQd0YCyEqVAvMV67xKqnGZkZprFbw1lH13/gHe/60MxiT63oN2kJFgEkxysq2f6UJPCiPF3SKsKYlgO5IGS2+qBek+Hbsrs2pAtvpHMNM8Ihxkk8AW7GaTxa+19Eifc0foDMFW4927gelTIUYr9sHqBAB/Jx7Hu6ZPUx+juP1blguA+ax+ms+g0AHLn+uHAFurTDlcypYOhFgVzbQ+UazFB1wDQSUqRHP3sPpq/jX/qxCsjzvAwSRQNecyGMVozRVZ/Q/TadsKRtAAEWuBvaiUCHg86BEBmAjtvPBJKveoRVu03gfzzcuNEGUs6hpeLOLIj1jG8Pbi6TDvpu3PZwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(40460700003)(47076005)(41300700001)(4326008)(36756003)(7416002)(26005)(5660300002)(36860700001)(83380400001)(1076003)(82740400003)(81166007)(426003)(336012)(356005)(86362001)(7696005)(2616005)(40480700001)(478600001)(70206006)(8676002)(2906002)(70586007)(110136005)(54906003)(6666004)(316002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 14:53:17.6472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee501119-f36a-48fc-3a37-08dbd24575fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pci legacy driver support and create platform driver for
acp7.0 platform.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-legacy-common.c |  11 +-
 sound/soc/amd/acp/acp-mach.h          |   1 +
 sound/soc/amd/acp/acp-pci.c           |   4 +
 sound/soc/amd/acp/acp70.c             | 254 ++++++++++++++++++++++++++
 sound/soc/amd/acp/amd.h               |   4 +
 5 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/amd/acp/acp70.c

diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index cba0aabefb34..b5aff3f230be 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -19,6 +19,7 @@
 #define ACP_RENOIR_PDM_ADDR	0x02
 #define ACP_REMBRANDT_PDM_ADDR	0x03
 #define ACP63_PDM_ADDR		0x02
+#define ACP70_PDM_ADDR		0x02
 
 void acp_enable_interrupts(struct acp_dev_data *adata)
 {
@@ -268,6 +269,10 @@ static int acp_power_on(struct acp_chip_info *chip)
 		acp_pgfsm_stat_reg = ACP63_PGFSM_STATUS;
 		acp_pgfsm_ctrl_reg = ACP63_PGFSM_CONTROL;
 		break;
+	case ACP70_DEV:
+		acp_pgfsm_stat_reg = ACP70_PGFSM_STATUS;
+		acp_pgfsm_ctrl_reg = ACP70_PGFSM_CONTROL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -329,7 +334,8 @@ int acp_deinit(struct acp_chip_info *chip)
 	if (ret)
 		return ret;
 
-	writel(0, chip->base + ACP_CONTROL);
+	if (chip->acp_rev != ACP70_DEV)
+		writel(0, chip->base + ACP_CONTROL);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(acp_deinit, SND_SOC_ACP_COMMON);
@@ -385,6 +391,9 @@ int check_acp_pdm(struct pci_dev *pci, struct acp_chip_info *chip)
 	case ACP63_DEV:
 		pdm_addr = ACP63_PDM_ADDR;
 		break;
+	case ACP70_DEV:
+		pdm_addr = ACP70_PDM_ADDR;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index 69db61f12eca..cd681101bea7 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -54,6 +54,7 @@ enum platform_end_point {
 	RENOIR = 0,
 	REMBRANDT,
 	ACP63,
+	ACP70,
 };
 
 struct acp_mach_ops {
diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 696c9ee6786f..8c8b1dcac628 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -91,6 +91,10 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		chip->name = "acp_asoc_acp63";
 		chip->acp_rev = ACP63_DEV;
 		break;
+	case 0x70:
+		chip->name = "acp_asoc_acp70";
+		chip->acp_rev = ACP70_DEV;
+		break;
 	default:
 		dev_err(dev, "Unsupported device revision:0x%x\n", pci->revision);
 		ret = -EINVAL;
diff --git a/sound/soc/amd/acp/acp70.c b/sound/soc/amd/acp/acp70.c
new file mode 100644
index 000000000000..dd384c966ae9
--- /dev/null
+++ b/sound/soc/amd/acp/acp70.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2023 Advanced Micro Devices, Inc.
+//
+// Authors: Syed Saba kareem <syed.sabakareem@amd.com>
+/*
+ * Hardware interface for ACP7.0 block
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
+#include <linux/pci.h>
+#include "amd.h"
+#include "acp-mach.h"
+
+#define DRV_NAME "acp_asoc_acp70"
+
+static struct acp_resource rsrc = {
+	.offset = 0,
+	.no_of_ctrls = 2,
+	.irqp_used = 1,
+	.soc_mclk = true,
+	.irq_reg_offset = 0x1a00,
+	.i2s_pin_cfg_offset = 0x1440,
+	.i2s_mode = 0x0a,
+	.scratch_reg_offset = 0x12800,
+	.sram_pte_offset = 0x03802800,
+};
+
+static struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_acp_machines[] = {
+	{
+		.id = "AMDI0029",
+		.drv_name = "acp70-acp",
+	},
+	{},
+};
+
+static struct snd_soc_dai_driver acp70_dai[] = {
+{
+	.name = "acp-i2s-sp",
+	.id = I2S_SP_INSTANCE,
+	.playback = {
+		.stream_name = "I2S SP Playback",
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 8,
+		.rate_min = 8000,
+		.rate_max = 96000,
+	},
+	.capture = {
+		.stream_name = "I2S SP Capture",
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 2,
+		.rate_min = 8000,
+		.rate_max = 48000,
+	},
+	.ops = &asoc_acp_cpu_dai_ops,
+},
+{
+	.name = "acp-i2s-bt",
+	.id = I2S_BT_INSTANCE,
+	.playback = {
+		.stream_name = "I2S BT Playback",
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 8,
+		.rate_min = 8000,
+		.rate_max = 96000,
+	},
+	.capture = {
+		.stream_name = "I2S BT Capture",
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 2,
+		.rate_min = 8000,
+		.rate_max = 48000,
+	},
+	.ops = &asoc_acp_cpu_dai_ops,
+},
+{
+	.name = "acp-i2s-hs",
+	.id = I2S_HS_INSTANCE,
+	.playback = {
+		.stream_name = "I2S HS Playback",
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 8,
+		.rate_min = 8000,
+		.rate_max = 96000,
+	},
+	.capture = {
+		.stream_name = "I2S HS Capture",
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 8,
+		.rate_min = 8000,
+		.rate_max = 48000,
+	},
+	.ops = &asoc_acp_cpu_dai_ops,
+},
+{
+	.name = "acp-pdm-dmic",
+	.id = DMIC_INSTANCE,
+	.capture = {
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 2,
+		.rate_min = 8000,
+		.rate_max = 48000,
+	},
+	.ops = &acp_dmic_dai_ops,
+},
+};
+
+static int acp_acp70_audio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acp_chip_info *chip;
+	struct acp_dev_data *adata;
+	struct resource *res;
+
+	chip = dev_get_platdata(&pdev->dev);
+	if (!chip || !chip->base) {
+		dev_err(&pdev->dev, "ACP chip data is NULL\n");
+		return -ENODEV;
+	}
+
+	if (chip->acp_rev != ACP70_DEV) {
+		dev_err(&pdev->dev, "Un-supported ACP Revision %d\n", chip->acp_rev);
+		return -ENODEV;
+	}
+
+	adata = devm_kzalloc(dev, sizeof(struct acp_dev_data), GFP_KERNEL);
+	if (!adata)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "acp_mem");
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
+		return -ENODEV;
+	}
+
+	adata->acp_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!adata->acp_base)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "acp_dai_irq");
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
+		return -ENODEV;
+	}
+
+	adata->i2s_irq = res->start;
+	adata->dev = dev;
+	adata->dai_driver = acp70_dai;
+	adata->num_dai = ARRAY_SIZE(acp70_dai);
+	adata->rsrc = &rsrc;
+	adata->machines = snd_soc_acpi_amd_acp70_acp_machines;
+	adata->platform = ACP70;
+	adata->flag = chip->flag;
+	acp_machine_select(adata);
+
+	dev_set_drvdata(dev, adata);
+	acp_enable_interrupts(adata);
+	acp_platform_register(dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	return 0;
+}
+
+static void acp_acp70_audio_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+
+	acp_disable_interrupts(adata);
+	acp_platform_unregister(dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
+static int __maybe_unused acp70_pcm_resume(struct device *dev)
+{
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	struct acp_stream *stream;
+	struct snd_pcm_substream *substream;
+	snd_pcm_uframes_t buf_in_frames;
+	u64 buf_size;
+
+	spin_lock(&adata->acp_lock);
+	list_for_each_entry(stream, &adata->stream_list, list) {
+		if (stream) {
+			substream = stream->substream;
+			if (substream && substream->runtime) {
+				buf_in_frames = (substream->runtime->buffer_size);
+				buf_size = frames_to_bytes(substream->runtime, buf_in_frames);
+				config_pte_for_stream(adata, stream);
+				config_acp_dma(adata, stream, buf_size);
+				if (stream->dai_id)
+					restore_acp_i2s_params(substream, adata, stream);
+				else
+					restore_acp_pdm_params(substream, adata);
+			}
+		}
+	}
+		spin_unlock(&adata->acp_lock);
+		return 0;
+}
+
+static const struct dev_pm_ops acp70_dma_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, acp70_pcm_resume)
+};
+
+static struct platform_driver acp70_driver = {
+	.probe = acp_acp70_audio_probe,
+	.remove_new = acp_acp70_audio_remove,
+	.driver = {
+		.name = "acp_asoc_acp70",
+		.pm = &acp70_dma_pm_ops,
+	},
+};
+
+module_platform_driver(acp70_driver);
+
+MODULE_DESCRIPTION("AMD ACP ACP70 Driver");
+MODULE_IMPORT_NS(SND_SOC_ACP_COMMON);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 937ce13c7d40..5017e868f39b 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -21,6 +21,7 @@
 #define ACP3X_DEV			3
 #define ACP6X_DEV			6
 #define ACP63_DEV			0x63
+#define ACP70_DEV			0x70
 
 #define DMIC_INSTANCE			0x00
 #define I2S_SP_INSTANCE			0x01
@@ -99,6 +100,9 @@
 #define ACP63_PGFSM_CONTROL			ACP6X_PGFSM_CONTROL
 #define ACP63_PGFSM_STATUS			ACP6X_PGFSM_STATUS
 
+#define ACP70_PGFSM_CONTROL			ACP6X_PGFSM_CONTROL
+#define ACP70_PGFSM_STATUS			ACP6X_PGFSM_STATUS
+
 #define ACP_SOFT_RST_DONE_MASK	0x00010001
 
 #define ACP_PGFSM_CNTL_POWER_ON_MASK            0xffffffff
-- 
2.25.1

