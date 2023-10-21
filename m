Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887807D1D99
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjJUOve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjJUOvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:51:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C834DA
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp/7gLWZp0IGZhf7xnHyh+To7RAqOt/P+jSn54cyC7LKaRWQ4iTnM50Sat5J0yIoEbv9qv8d3RLva+jGO1927MdRfvwnGRTCmZbxJ8KWah4vxIDrt+4qs6NCGcuNFuMPBmSWq+kU21pftfIygom2b86SsSoJ7iUgChRitBN7sHwepT2VwY0hgtFcdga2xtdIClo+2c7qYSjeXAodjmsX69pqGfgCMeStrN00agXgN7nE9bvqH/N9TLBH4vITHbCFZ55HqciUYW6TCmRkCIDtMvYbbHjt4WgWzn4xHBh+oy793h+OKOMieXIIdc515xby7FXDR3UKgpX0/iHzJXojxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AThVajZwDBtQIvZMoGwwZk4auW5IkTuQUHDWO3OdQgs=;
 b=ko1afCyvjCN/kgX/ZPts5wP1X0jxpuhAn4eKNU/TEvVxLi/PXoo+qN9OyjLtKR416jD5seFsi52iDJ9JVMXWxzwlsx2d9GxXGnKnsiciOXkq0GdMAg3xjsWKLc53hY/rYhYkHrVXPQOxcRJ6Sw0ocoNvGXeGWziqCzPPVmcXLQCAVMfOyp0y+hWh5JLifRk6Tm8ZBiPzxXidNK2QtvU0xkvpKyCBaFTbypyTGE6mvZrdy/OXujMEk8PObMqwjJr1DQICi+j7+4csjPV+EPYnqhAzxt46uV5YjfkbHOfM5WQLbS4wC70ysA3aG8xmd4RpbK6yGbWB2LDMCqV2eP+Whg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AThVajZwDBtQIvZMoGwwZk4auW5IkTuQUHDWO3OdQgs=;
 b=M41KXH2+UAuhaPxPBNsgf+aG00O689kp/O/5GJZ6yA1/nJrZXipAuL7muFP8+yBdv4DusGB7jLcK07dyaEBd3iwd1fSlCmRXRzRLdV2yaXe24ZqlEmfECKO47XFVJeM4THkUVsVaASdZql3ln3HnytlZwqb5KIt2T7nzZcT43w4=
Received: from PH0PR07CA0072.namprd07.prod.outlook.com (2603:10b6:510:f::17)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Sat, 21 Oct
 2023 14:51:23 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::e4) by PH0PR07CA0072.outlook.office365.com
 (2603:10b6:510:f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29 via Frontend
 Transport; Sat, 21 Oct 2023 14:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Sat, 21 Oct 2023 14:51:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:51:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:51:22 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sat, 21 Oct 2023 09:51:16 -0500
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
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/13] ASoC: amd: acp: Add acp6.3 pci legacy driver support
Date:   Sat, 21 Oct 2023 20:20:42 +0530
Message-ID: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 65264f71-fd19-4443-2bf2-08dbd24531b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOAkuACfBmvDOQzjUcmABJjtN/PWBsp0fXFzHZS3h2v5HGNYTqdIg3iEIDTZAvAleC+MmybviA2THpAva1vzTj6X0lAOvW2o0nDgXdsBMjEriPSLj/McwvXTkshC17NGXXRJZ7SYWmBnVjuWmtIt2MgCaC+BsxxY4vUwoIg6/xtOuxTwdPJwAiZoG1L9Jv6ZN+79uUCeY3pshH5JZFjaRdv4tM9OOL2n57ziWmwT/qBJPscAvr1Ztfdk+GMEpi8kf/0gSdYOE775S53FlaEnZqqpASOJDGwTOHFMSTz2vnhmyCMeL/XL+ASgjoMgHIQrOtdh3J21UHZAkxxxKO0f6gGJVm1qc2oyqnZaquLNPQMab1tOrLw7b70unnCpIa842/lelQFSpvn4Z0+9NT5FuWZXZlUC8k7bpQk5hiC0ZW222LvqrKC0J0W8gTQ68yTxudRX6prrVqwhzPThG5rdeYvHl9n+1hb3UwggFMTyWtXTJxB/U9J99Mq5/8b3ysPStJoeWDtwBRnotYAimrkEwknVTNF298YYGd9jPq3NGiL4FLwoto2t8k273P6gu2ShdiOqWYrwf/CYLj16TPqjZIdvufQQHVw30eatyR4yawJQrX+p8g9Urc0pQ1fRo9EB8qL8vFZeWdZQjdPPTpz3nmHbIPgAF3jQHOQFzIAIWSXCVCukwpVUdJ9c1PdE6cKI24MMfwzkxAKU8Gj1ZrtwqUHJZMlkP97ZK73rLdPRexGq2Gie5AQUqCB8T4L7R0PBM2XHcWMe33QqVMwT1JRTbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(356005)(36756003)(336012)(81166007)(86362001)(40460700003)(7696005)(478600001)(1076003)(30864003)(40480700001)(82740400003)(8676002)(2906002)(41300700001)(6666004)(4326008)(8936002)(5660300002)(426003)(316002)(26005)(110136005)(2616005)(70586007)(36860700001)(83380400001)(7416002)(54906003)(47076005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 14:51:23.1056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65264f71-fd19-4443-2bf2-08dbd24531b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
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
acp6.3 based platforms.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-legacy-common.c |   4 +
 sound/soc/amd/acp/acp-pci.c           |   4 +
 sound/soc/amd/acp/acp63.c             | 314 ++++++++++++++++++++++++++
 sound/soc/amd/acp/amd.h               |   4 +
 4 files changed, 326 insertions(+)
 create mode 100644 sound/soc/amd/acp/acp63.c

diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index 217b4c89b975..e16ef94e6336 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -260,6 +260,10 @@ static int acp_power_on(struct acp_chip_info *chip)
 		acp_pgfsm_stat_reg = ACP6X_PGFSM_STATUS;
 		acp_pgfsm_ctrl_reg = ACP6X_PGFSM_CONTROL;
 		break;
+	case ACP63_DEV:
+		acp_pgfsm_stat_reg = ACP63_PGFSM_STATUS;
+		acp_pgfsm_ctrl_reg = ACP63_PGFSM_CONTROL;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index a32c14a109b7..d7fc4a0e9245 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -87,6 +87,10 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		chip->name = "acp_asoc_rembrandt";
 		chip->acp_rev = ACP6X_DEV;
 		break;
+	case 0x63:
+		chip->name = "acp_asoc_acp63";
+		chip->acp_rev = ACP63_DEV;
+		break;
 	default:
 		dev_err(dev, "Unsupported device revision:0x%x\n", pci->revision);
 		ret = -EINVAL;
diff --git a/sound/soc/amd/acp/acp63.c b/sound/soc/amd/acp/acp63.c
new file mode 100644
index 000000000000..f94348ad863d
--- /dev/null
+++ b/sound/soc/amd/acp/acp63.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2023 Advanced Micro Devices, Inc.
+//
+// Authors: Syed Saba kareem <syed.sabakareem@amd.com>
+/*
+ * Hardware interface for ACP6.3 block
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
+
+#define DRV_NAME "acp_asoc_acp63"
+
+#define CLK_PLL_PWR_REQ_N0		0X0006C2C0
+#define CLK_SPLL_FIELD_2_N0		0X0006C114
+#define CLK_PLL_REQ_N0			0X0006C0DC
+#define CLK_DFSBYPASS_CONTR		0X0006C2C8
+#define CLK_DFS_CNTL_N0			0X0006C1A4
+
+#define PLL_AUTO_STOP_REQ		BIT(4)
+#define PLL_AUTO_START_REQ		BIT(0)
+#define PLL_FRANCE_EN			BIT(4)
+#define EXIT_DPF_BYPASS_0		BIT(16)
+#define EXIT_DPF_BYPASS_1		BIT(17)
+#define CLK0_DIVIDER			0X30
+
+union clk_pll_req_no {
+	struct {
+		u32 fb_mult_int : 9;
+		u32 reserved : 3;
+		u32 pll_spine_div : 4;
+		u32 gb_mult_frac : 16;
+	} bitfields, bits;
+	u32 clk_pll_req_no_reg;
+};
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
+static struct snd_soc_acpi_mach snd_soc_acpi_amd_acp63_acp_machines[] = {
+	{
+		.id = "AMDI0052",
+		.drv_name = "acp63-acp",
+	},
+	{},
+};
+
+static struct snd_soc_dai_driver acp63_dai[] = {
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
+static int acp63_i2s_master_clock_generate(struct acp_dev_data *adata)
+{
+	u32 data;
+	union clk_pll_req_no clk_pll;
+	struct pci_dev *smn_dev;
+
+	smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, 0x14E8, NULL);
+	if (!smn_dev)
+		return -ENODEV;
+
+	/* Clk5 pll register values to get mclk as 196.6MHz*/
+	clk_pll.bits.fb_mult_int = 0x31;
+	clk_pll.bits.pll_spine_div = 0;
+	clk_pll.bits.gb_mult_frac = 0x26E9;
+
+	data = smn_read(smn_dev, CLK_PLL_PWR_REQ_N0);
+	smn_write(smn_dev, CLK_PLL_PWR_REQ_N0, data | PLL_AUTO_STOP_REQ);
+
+	data = smn_read(smn_dev, CLK_SPLL_FIELD_2_N0);
+	if (data & PLL_FRANCE_EN)
+		smn_write(smn_dev, CLK_SPLL_FIELD_2_N0, data | PLL_FRANCE_EN);
+
+	smn_write(smn_dev, CLK_PLL_REQ_N0, clk_pll.clk_pll_req_no_reg);
+
+	data = smn_read(smn_dev, CLK_PLL_PWR_REQ_N0);
+	smn_write(smn_dev, CLK_PLL_PWR_REQ_N0, data | PLL_AUTO_START_REQ);
+
+	data = smn_read(smn_dev, CLK_DFSBYPASS_CONTR);
+	smn_write(smn_dev, CLK_DFSBYPASS_CONTR, data | EXIT_DPF_BYPASS_0);
+	smn_write(smn_dev, CLK_DFSBYPASS_CONTR, data | EXIT_DPF_BYPASS_1);
+
+	smn_write(smn_dev, CLK_DFS_CNTL_N0, CLK0_DIVIDER);
+	return 0;
+}
+
+static int acp63_audio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acp_chip_info *chip;
+	struct acp_dev_data *adata;
+	struct resource *res;
+	int ret;
+
+	chip = dev_get_platdata(&pdev->dev);
+	if (!chip || !chip->base) {
+		dev_err(&pdev->dev, "ACP chip data is NULL\n");
+		return -ENODEV;
+	}
+
+	if (chip->acp_rev != ACP63_DEV) {
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
+	adata->dai_driver = acp63_dai;
+	adata->num_dai = ARRAY_SIZE(acp63_dai);
+	adata->rsrc = &rsrc;
+	adata->machines = snd_soc_acpi_amd_acp63_acp_machines;
+	acp_machine_select(adata);
+	dev_set_drvdata(dev, adata);
+	ret = acp63_i2s_master_clock_generate(adata);
+	if (ret)
+		return ret;
+
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
+static void acp63_audio_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+
+	acp_disable_interrupts(adata);
+	acp_platform_unregister(dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
+static int __maybe_unused acp63_pcm_resume(struct device *dev)
+{
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	struct acp_stream *stream;
+	struct snd_pcm_substream *substream;
+	snd_pcm_uframes_t buf_in_frames;
+	u64 buf_size;
+
+	acp63_i2s_master_clock_generate(adata);
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
+	spin_unlock(&adata->acp_lock);
+	return 0;
+}
+
+static const struct dev_pm_ops acp63_dma_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, acp63_pcm_resume)
+};
+
+static struct platform_driver acp63_driver = {
+	.probe = acp63_audio_probe,
+	.remove_new = acp63_audio_remove,
+	.driver = {
+		.name = "acp_asoc_acp63",
+		.pm = &acp63_dma_pm_ops,
+	},
+};
+
+module_platform_driver(acp63_driver);
+
+MODULE_DESCRIPTION("AMD ACP acp63 Driver");
+MODULE_IMPORT_NS(SND_SOC_ACP_COMMON);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index d6cfae6ec5f7..487eefa5985f 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -20,6 +20,7 @@
 
 #define ACP3X_DEV			3
 #define ACP6X_DEV			6
+#define ACP63_DEV			0x63
 
 #define DMIC_INSTANCE			0x00
 #define I2S_SP_INSTANCE			0x01
@@ -95,6 +96,9 @@
 #define ACP6X_PGFSM_CONTROL                     0x1024
 #define ACP6X_PGFSM_STATUS                      0x1028
 
+#define ACP63_PGFSM_CONTROL			ACP6X_PGFSM_CONTROL
+#define ACP63_PGFSM_STATUS			ACP6X_PGFSM_STATUS
+
 #define ACP_SOFT_RST_DONE_MASK	0x00010001
 
 #define ACP_PGFSM_CNTL_POWER_ON_MASK            0x01
-- 
2.25.1

