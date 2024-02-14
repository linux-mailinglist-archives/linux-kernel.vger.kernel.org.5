Return-Path: <linux-kernel+bounces-65063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8FD85475A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218C128AFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB7A18C28;
	Wed, 14 Feb 2024 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q68FfLxe"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9EC1865C;
	Wed, 14 Feb 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907252; cv=fail; b=e2Rk5KlHwXVu44O3zlxu5bl1lxY4AQjgOuT19xfQROUJBIf0txDGEM58NGyKGPVmlZR7bFyyGyYWARFW/mi5y+DHoOjzCRzQ/6OsIHTnf0FuAGmbO4KuFGhLN2Ayv2CltguQpXHyZCvoPYlSCrtTKzA2D8pDW6e10LuBpiijwz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907252; c=relaxed/simple;
	bh=Xxyi0Cbq8a1/kLAy0H3uOMyM+ziuEQ/cmLkrkuBUPHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjwl/DOXczloZ4jhplsF2SLf991usQXFxV+OgyQuE1HKfSlmBpv2vjo4A/HxHEiEKAq8NQNF6MIoDynH+JHKc6wCIb7jsh4Qr7RYBO7CdtpmsDMjBpMJ4KkNdBcg3Zh7jf+ANTb21eX5NclPPUpdcsrwUBZ5oM9qAgi7H6+qpeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q68FfLxe; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK4SQo7F/ZWEcYiwORSFKXuM19VLsSgIuinJBOebbs1cD1eNH7jgwL8toOc/SUOg5fJDuTw9B3ahbvI7n7IuBNkCf/NFJYZ2nevsdtumLd4OSXsoiRGK9IvgDlnhvdx3tlbbzPLkoqAQK+bocRhw1nBcNcziU9c5yhA6VQPB5kKD/QisRK+eK0IjhIQXtMFaaKkUkV77tmyg7P3WTC8bCDyXHtck3eER3qWTQHv5zKkbN0ntmp/3+IKFHUC+XEkPfkJfnrHMQ/QK7YRCPKI1VA0DQvllziFR8LTK6qpExtYaLDJiuoXAHPzKA41/MhaE62TsQ/VhVqzk4HSShbcAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmKb5m3sVhwQEwpSMpdRyg/LzslDWgf2918PndYEHrU=;
 b=TPv3MyP+iom7Qmn+c8qOpWzT72qpw1FsX2hXwGMdPT43v+lp3+RDnqfnxaGPdsi/LP4pEtJOtY7Yj0EvZOeR+LZyBWGIzj4foHMACBEwtZtNBlSBY2LGDRayS564FUPZs9TAb/ZpFW094mYQ8og1hgPqhlpIpV0dA5mq2GJsTNg2YRYYi8pJJhMjJzkZngI2EJKgHVdQOf9mIaA4hepTiapSuK4zOHEnuUFrimyj0RgPUxct2GiGoqx9vrgdS1J0QDnA7/G2Of+aVHu87qiX6BnBd5DHZb9JqcqTei12s3g7quRs/6kVwy0T5nXWRjNbofG8W3onC4J025Vmgj2Ohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmKb5m3sVhwQEwpSMpdRyg/LzslDWgf2918PndYEHrU=;
 b=Q68FfLxebawSM/ESRQ6cPjtW19wmBatiIvr9+xWBqLaTUieLMWSJYlBPSOaWFe2njMjCe0wFWRgB4ZQFmhCEP484GMnt9QXP7Gr74JoWvESYpHvljx7L/vrza5GV85RNVpfna7Y2aFBRr3USBuR8fsslXPrxsbLnA+4Ap9sHE38=
Received: from CH2PR11CA0025.namprd11.prod.outlook.com (2603:10b6:610:54::35)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Wed, 14 Feb
 2024 10:40:46 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::1f) by CH2PR11CA0025.outlook.office365.com
 (2603:10b6:610:54::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35 via Frontend
 Transport; Wed, 14 Feb 2024 10:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 10:40:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 04:40:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 02:40:44 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Wed, 14 Feb 2024 04:40:35 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <Mario.Limonciello@amd.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] ASoC: amd: ps: refactor acp child platform device creation code
Date: Wed, 14 Feb 2024 16:10:02 +0530
Message-ID: <20240214104014.1144668-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214104014.1144668-1-Vijendar.Mukunda@amd.com>
References: <20240214104014.1144668-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: a1dc3a00-6c86-4bad-d78c-08dc2d4966f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rvHuuBxk7pXm5aCYbLvsA+5/xNp1T0eC+Yqb/58mDmwT+uvbNwSN7Hvkro08Z8KO7sugtANKHMc+lEi9K0xRybOdQN56Eib0rkzzh49b+/DuKfcIA6aD2BQ8Vk8QIHjnjzakxJQqIckAOVUV+WA07G6L9l1u8JwPU8XkRWz4ft/bAtk3HopYqi9zLZFvsadj/sisUF6JK7X+W0vB2nw8nXoHZxjlxnU9kW9xvEopIpBpK0Qtr7L7IeIIXY4xZzNSaND7GCKI1j1vhvb1gNbYyr4cdVx/41y9GULBa2+EVnz5xO7ano/D4dfyhka3x8hbeXSU5/CUNX804sGBEEXZpUPWIWv3OEmtjSVlb+jKDsgrAeL2Et8HILcyl9T1nEZ2Dw98ewLzajEH1uEFy6ik+0ruEAC5z5trBgCachrcKuU36eS7tuWLd7LIIS4XPTWUitw68JYlExfpcn/PE2WG9vvLiNYKHseJvrd1xdIHJ6q/Am92PMF3wfAjPLLfdH4ut8H3PqZ78fIMf0ITtwCuyw/343OO4/efR4HyH0a12C4u5eGkAdmAa9k/ke7nH+Xw1De2vnzs5XWka1rCtbnmnLT5n+0Flvw+/WULo7RgVu0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(82740400003)(81166007)(356005)(5660300002)(41300700001)(83380400001)(86362001)(30864003)(70206006)(8676002)(36756003)(336012)(70586007)(8936002)(4326008)(2906002)(426003)(54906003)(6666004)(6916009)(1076003)(316002)(478600001)(2616005)(26005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 10:40:46.1052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dc3a00-6c86-4bad-d78c-08dc2d4966f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020

Refactor ACP child platform device creation code based on acp config.
Use common SoundWire manager functions for device probe and exit
sequences.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  |  69 +++--------
 sound/soc/amd/ps/pci-ps.c | 237 +++++++++++++++++---------------------
 2 files changed, 116 insertions(+), 190 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 123b9ade69d4..b2fd554d50d2 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -11,7 +11,6 @@
 #define ACP_DEVICE_ID 0x15E2
 #define ACP63_REG_START		0x1240000
 #define ACP63_REG_END		0x1250200
-#define ACP63_DEVS		5
 
 #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
 #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
@@ -56,32 +55,6 @@
 
 #define ACP_DMIC_DEV	2
 
-/* ACP63_PDM_MODE_DEVS corresponds to platform devices count for ACP PDM configuration */
-#define ACP63_PDM_MODE_DEVS		3
-
-/*
- * ACP63_SDW0_MODE_DEVS corresponds to platform devices count for
- * SW0 SoundWire manager instance configuration
- */
-#define ACP63_SDW0_MODE_DEVS		2
-
-/*
- * ACP63_SDW0_SDW1_MODE_DEVS corresponds to platform devices count for SW0 + SW1 SoundWire manager
- * instances configuration
- */
-#define ACP63_SDW0_SDW1_MODE_DEVS	3
-
-/*
- * ACP63_SDW0_PDM_MODE_DEVS corresponds to platform devices count for SW0 manager
- * instance + ACP PDM controller configuration
- */
-#define ACP63_SDW0_PDM_MODE_DEVS	4
-
-/*
- * ACP63_SDW0_SDW1_PDM_MODE_DEVS corresponds to platform devices count for
- * SW0 + SW1 SoundWire manager instances + ACP PDM controller configuration
- */
-#define ACP63_SDW0_SDW1_PDM_MODE_DEVS   5
 #define ACP63_DMIC_ADDR			2
 #define ACP63_SDW_ADDR			5
 #define AMD_SDW_MAX_MANAGERS		2
@@ -89,17 +62,6 @@
 /* time in ms for acp timeout */
 #define ACP_TIMEOUT		500
 
-/* ACP63_PDM_DEV_CONFIG corresponds to platform device configuration for ACP PDM controller */
-#define ACP63_PDM_DEV_CONFIG		BIT(0)
-
-/* ACP63_SDW_DEV_CONFIG corresponds to platform device configuration for SDW manager instances */
-#define ACP63_SDW_DEV_CONFIG		BIT(1)
-
-/*
- * ACP63_SDW_PDM_DEV_CONFIG corresponds to platform device configuration for ACP PDM + SoundWire
- * manager instance combination.
- */
-#define ACP63_SDW_PDM_DEV_CONFIG	GENMASK(1, 0)
 #define ACP_SDW0_STAT			BIT(21)
 #define ACP_SDW1_STAT			BIT(2)
 #define ACP_ERROR_IRQ			BIT(29)
@@ -254,21 +216,18 @@ struct sdw_dma_ring_buf_reg {
  * struct acp63_dev_data - acp pci driver context
  * @acp63_base: acp mmio base
  * @res: resource
- * @pdev: array of child platform device node structures
+ * @pdm_dev: ACP PDM controller platform device
+ * @dmic_codec: platform device for DMIC Codec
+ * sdw_dma_dev: platform device for SoundWire DMA controller
  * @acp_lock: used to protect acp common registers
- * @sdw_fw_node: SoundWire controller fw node handle
- * @pdev_config: platform device configuration
- * @pdev_count: platform devices count
- * @pdm_dev_index: pdm platform device index
- * @sdw_manager_count: SoundWire manager instance count
- * @sdw0_dev_index: SoundWire Manager-0 platform device index
- * @sdw1_dev_index: SoundWire Manager-1 platform device index
- * @sdw_dma_dev_index: SoundWire DMA controller platform device index
  * @info: SoundWire AMD information found in ACPI tables
+ * @sdw: SoundWire context for all SoundWire manager instances
  * @is_sdw_dev: flag set to true when any SoundWire manager instances are available
  * @is_pdm_dev: flag set to true when ACP PDM controller exists
  * @is_pdm_config: flat set to true when PDM configuration is selected from BIOS
  * @is_sdw_config: flag set to true when SDW configuration is selected from BIOS
+ * @addr: pci ioremap address
+ * @reg_range: ACP reigister range
  * @sdw0-dma_intr_stat: DMA interrupt status array for SoundWire manager-SW0 instance
  * @sdw_dma_intr_stat: DMA interrupt status array for SoundWire manager-SW1 instance
  * @acp_reset: flag set to true when bus reset is applied across all
@@ -278,21 +237,19 @@ struct sdw_dma_ring_buf_reg {
 struct acp63_dev_data {
 	void __iomem *acp63_base;
 	struct resource *res;
-	struct platform_device *pdev[ACP63_DEVS];
+	struct platform_device *pdm_dev;
+	struct platform_device *dmic_codec_dev;
+	struct platform_device *sdw_dma_dev;
 	struct mutex acp_lock; /* protect shared registers */
-	struct fwnode_handle *sdw_fw_node;
-	u16 pdev_config;
-	u16 pdev_count;
-	u16 pdm_dev_index;
-	u8 sdw_manager_count;
-	u16 sdw0_dev_index;
-	u16 sdw1_dev_index;
-	u16 sdw_dma_dev_index;
 	struct sdw_amd_acpi_info info;
+	/* sdw context allocated by SoundWire driver */
+	struct sdw_amd_ctx *sdw;
 	bool is_sdw_dev;
 	bool is_pdm_dev;
 	bool is_pdm_config;
 	bool is_sdw_config;
+	u32 addr;
+	u32 reg_range;
 	u16 sdw0_dma_intr_stat[ACP63_SDW0_DMA_MAX_STREAMS];
 	u16 sdw1_dma_intr_stat[ACP63_SDW1_DMA_MAX_STREAMS];
 	bool acp_reset;
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index c97e418a88ce..b7cb3f98707f 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -104,10 +104,8 @@ static irqreturn_t acp63_irq_thread(int irq, void *context)
 	struct sdw_dma_dev_data *sdw_dma_data;
 	struct acp63_dev_data *adata = context;
 	u32 stream_index;
-	u16 pdev_index;
 
-	pdev_index = adata->sdw_dma_dev_index;
-	sdw_dma_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+	sdw_dma_data = dev_get_drvdata(&adata->sdw_dma_dev->dev);
 
 	for (stream_index = 0; stream_index < ACP63_SDW0_DMA_MAX_STREAMS; stream_index++) {
 		if (adata->sdw0_dma_intr_stat[stream_index]) {
@@ -135,7 +133,6 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 	u32 stream_id = 0;
 	u16 irq_flag = 0;
 	u16 sdw_dma_irq_flag = 0;
-	u16 pdev_index;
 	u16 index;
 
 	adata = dev_id;
@@ -149,8 +146,7 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 	ext_intr_stat = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
 	if (ext_intr_stat & ACP_SDW0_STAT) {
 		writel(ACP_SDW0_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
-		pdev_index = adata->sdw0_dev_index;
-		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+		amd_manager = dev_get_drvdata(&adata->sdw->pdev[0]->dev);
 		if (amd_manager)
 			schedule_work(&amd_manager->amd_sdw_irq_thread);
 		irq_flag = 1;
@@ -159,8 +155,7 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 	ext_intr_stat1 = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
 	if (ext_intr_stat1 & ACP_SDW1_STAT) {
 		writel(ACP_SDW1_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
-		pdev_index = adata->sdw1_dev_index;
-		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+		amd_manager = dev_get_drvdata(&adata->sdw->pdev[1]->dev);
 		if (amd_manager)
 			schedule_work(&amd_manager->amd_sdw_irq_thread);
 		irq_flag = 1;
@@ -176,8 +171,7 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 	}
 
 	if (ext_intr_stat & BIT(PDM_DMA_STAT)) {
-		pdev_index = adata->pdm_dev_index;
-		ps_pdm_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+		ps_pdm_data = dev_get_drvdata(&adata->pdm_dev->dev);
 		writel(BIT(PDM_DMA_STAT), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
 		if (ps_pdm_data->capture_stream)
 			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
@@ -255,11 +249,53 @@ static int acp_scan_sdw_devices(struct device *dev, u64 addr)
 	acp_data->info.count = AMD_SDW_MAX_MANAGERS;
 	return amd_sdw_scan_controller(&acp_data->info);
 }
+
+static int amd_sdw_probe(struct device *dev)
+{
+	struct acp63_dev_data *acp_data;
+	struct sdw_amd_res sdw_res;
+	int ret;
+
+	acp_data = dev_get_drvdata(dev);
+	memset(&sdw_res, 0, sizeof(sdw_res));
+	sdw_res.addr = acp_data->addr;
+	sdw_res.reg_range = acp_data->reg_range;
+	sdw_res.handle = acp_data->info.handle;
+	sdw_res.parent = dev;
+	sdw_res.dev = dev;
+	sdw_res.acp_lock = &acp_data->acp_lock;
+	sdw_res.count = acp_data->info.count;
+	sdw_res.mmio_base = acp_data->acp63_base;
+	sdw_res.link_mask = acp_data->info.link_mask;
+	ret = sdw_amd_probe(&sdw_res, &acp_data->sdw);
+	if (ret)
+		dev_err(dev, "error: SoundWire probe failed\n");
+	return ret;
+}
+
+static int amd_sdw_exit(struct acp63_dev_data *acp_data)
+{
+	if (acp_data->sdw)
+		sdw_amd_exit(acp_data->sdw);
+	acp_data->sdw = NULL;
+
+	return 0;
+}
 #else
 static int acp_scan_sdw_devices(struct device *dev, u64 addr)
 {
 	return 0;
 }
+
+static int amd_sdw_probe(struct device *dev)
+{
+	return 0;
+}
+
+static int amd_sdw_exit(struct acp63_dev_data *acp_data)
+{
+	return 0;
+}
 #endif
 
 static int get_acp63_device_config(struct pci_dev *pci, struct acp63_dev_data *acp_data)
@@ -343,17 +379,13 @@ static void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo,
 
 static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data *adata, u32 addr)
 {
-	struct acp_sdw_pdata *sdw_pdata;
-	struct platform_device_info pdevinfo[ACP63_DEVS];
+	struct platform_device_info pdevinfo;
 	struct device *parent;
-	int index;
 	int ret;
 
 	parent = &pci->dev;
-	dev_dbg(&pci->dev,
-		"%s pdev_config:0x%x pdev_count:0x%x\n", __func__, adata->pdev_config,
-		adata->pdev_count);
-	if (adata->pdev_config) {
+
+	if (adata->is_sdw_dev || adata->is_pdm_dev) {
 		adata->res = devm_kzalloc(&pci->dev, sizeof(struct resource), GFP_KERNEL);
 		if (!adata->res) {
 			ret = -ENOMEM;
@@ -365,130 +397,57 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 	}
 
-	switch (adata->pdev_config) {
-	case ACP63_PDM_DEV_CONFIG:
-		adata->pdm_dev_index  = 0;
-		acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
+	if (adata->is_pdm_dev && adata->is_pdm_config) {
+		acp63_fill_platform_dev_info(&pdevinfo, parent, NULL, "acp_ps_pdm_dma",
 					     0, adata->res, 1, NULL, 0);
-		acp63_fill_platform_dev_info(&pdevinfo[1], parent, NULL, "dmic-codec",
-					     0, NULL, 0, NULL, 0);
-		acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "acp_ps_mach",
-					     0, NULL, 0, NULL, 0);
-		break;
-	case ACP63_SDW_DEV_CONFIG:
-		if (adata->pdev_count == ACP63_SDW0_MODE_DEVS) {
-			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata),
-						 GFP_KERNEL);
-			if (!sdw_pdata) {
-				ret = -ENOMEM;
-				goto de_init;
-			}
 
-			sdw_pdata->instance = 0;
-			sdw_pdata->acp_sdw_lock = &adata->acp_lock;
-			adata->sdw0_dev_index = 0;
-			adata->sdw_dma_dev_index = 1;
-			acp63_fill_platform_dev_info(&pdevinfo[0], parent, adata->sdw_fw_node,
-						     "amd_sdw_manager", 0, adata->res, 1,
-						     sdw_pdata, sizeof(struct acp_sdw_pdata));
-			acp63_fill_platform_dev_info(&pdevinfo[1], parent, NULL, "amd_ps_sdw_dma",
-						     0, adata->res, 1, NULL, 0);
-		} else if (adata->pdev_count == ACP63_SDW0_SDW1_MODE_DEVS) {
-			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata) * 2,
-						 GFP_KERNEL);
-			if (!sdw_pdata) {
-				ret = -ENOMEM;
-				goto de_init;
-			}
-
-			sdw_pdata[0].instance = 0;
-			sdw_pdata[1].instance = 1;
-			sdw_pdata[0].acp_sdw_lock = &adata->acp_lock;
-			sdw_pdata[1].acp_sdw_lock = &adata->acp_lock;
-			sdw_pdata->acp_sdw_lock = &adata->acp_lock;
-			adata->sdw0_dev_index = 0;
-			adata->sdw1_dev_index = 1;
-			adata->sdw_dma_dev_index = 2;
-			acp63_fill_platform_dev_info(&pdevinfo[0], parent, adata->sdw_fw_node,
-						     "amd_sdw_manager", 0, adata->res, 1,
-						     &sdw_pdata[0], sizeof(struct acp_sdw_pdata));
-			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
-						     "amd_sdw_manager", 1, adata->res, 1,
-						     &sdw_pdata[1], sizeof(struct acp_sdw_pdata));
-			acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "amd_ps_sdw_dma",
-						     0, adata->res, 1, NULL, 0);
+		adata->pdm_dev = platform_device_register_full(&pdevinfo);
+		if (IS_ERR(adata->pdm_dev)) {
+			dev_err(&pci->dev,
+				"cannot register %s device\n", pdevinfo.name);
+			ret = PTR_ERR(adata->pdm_dev);
+			goto de_init;
 		}
-		break;
-	case ACP63_SDW_PDM_DEV_CONFIG:
-		if (adata->pdev_count == ACP63_SDW0_PDM_MODE_DEVS) {
-			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata),
-						 GFP_KERNEL);
-			if (!sdw_pdata) {
-				ret = -ENOMEM;
-				goto de_init;
-			}
-
-			sdw_pdata->instance = 0;
-			sdw_pdata->acp_sdw_lock = &adata->acp_lock;
-			adata->pdm_dev_index = 0;
-			adata->sdw0_dev_index = 1;
-			adata->sdw_dma_dev_index = 2;
-			acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
-						     0, adata->res, 1, NULL, 0);
-			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
-						     "amd_sdw_manager", 0, adata->res, 1,
-						     sdw_pdata, sizeof(struct acp_sdw_pdata));
-			acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "amd_ps_sdw_dma",
-						     0, adata->res, 1, NULL, 0);
-			acp63_fill_platform_dev_info(&pdevinfo[3], parent, NULL, "dmic-codec",
-						     0, NULL, 0, NULL, 0);
-		} else if (adata->pdev_count == ACP63_SDW0_SDW1_PDM_MODE_DEVS) {
-			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata) * 2,
-						 GFP_KERNEL);
-			if (!sdw_pdata) {
-				ret = -ENOMEM;
-				goto de_init;
-			}
-			sdw_pdata[0].instance = 0;
-			sdw_pdata[1].instance = 1;
-			sdw_pdata[0].acp_sdw_lock = &adata->acp_lock;
-			sdw_pdata[1].acp_sdw_lock = &adata->acp_lock;
-			adata->pdm_dev_index = 0;
-			adata->sdw0_dev_index = 1;
-			adata->sdw1_dev_index = 2;
-			adata->sdw_dma_dev_index = 3;
-			acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
-						     0, adata->res, 1, NULL, 0);
-			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
-						     "amd_sdw_manager", 0, adata->res, 1,
-						     &sdw_pdata[0], sizeof(struct acp_sdw_pdata));
-			acp63_fill_platform_dev_info(&pdevinfo[2], parent, adata->sdw_fw_node,
-						     "amd_sdw_manager", 1, adata->res, 1,
-						     &sdw_pdata[1], sizeof(struct acp_sdw_pdata));
-			acp63_fill_platform_dev_info(&pdevinfo[3], parent, NULL, "amd_ps_sdw_dma",
-						     0, adata->res, 1, NULL, 0);
-			acp63_fill_platform_dev_info(&pdevinfo[4], parent, NULL, "dmic-codec",
-						     0, NULL, 0, NULL, 0);
+		memset(&pdevinfo, 0, sizeof(pdevinfo));
+		acp63_fill_platform_dev_info(&pdevinfo, parent, NULL, "dmic-codec",
+					     0, NULL, 0, NULL, 0);
+		adata->dmic_codec_dev = platform_device_register_full(&pdevinfo);
+		if (IS_ERR(adata->dmic_codec_dev)) {
+			dev_err(&pci->dev,
+				"cannot register %s device\n", pdevinfo.name);
+			ret = PTR_ERR(adata->dmic_codec_dev);
+			goto unregister_pdm_dev;
 		}
-		break;
-	default:
-		dev_dbg(&pci->dev, "No PDM or SoundWire manager devices found\n");
-		return 0;
 	}
+	if (adata->is_sdw_dev && adata->is_sdw_config) {
+		ret = amd_sdw_probe(&pci->dev);
+		if (ret) {
+			if (adata->is_pdm_dev)
+				goto unregister_dmic_codec_dev;
+			else
+				goto de_init;
+		}
+		memset(&pdevinfo, 0, sizeof(pdevinfo));
+		acp63_fill_platform_dev_info(&pdevinfo, parent, NULL, "amd_ps_sdw_dma",
+					     0, adata->res, 1, NULL, 0);
 
-	for (index = 0; index < adata->pdev_count; index++) {
-		adata->pdev[index] = platform_device_register_full(&pdevinfo[index]);
-		if (IS_ERR(adata->pdev[index])) {
+		adata->sdw_dma_dev = platform_device_register_full(&pdevinfo);
+		if (IS_ERR(adata->sdw_dma_dev)) {
 			dev_err(&pci->dev,
-				"cannot register %s device\n", pdevinfo[index].name);
-			ret = PTR_ERR(adata->pdev[index]);
-			goto unregister_devs;
+				"cannot register %s device\n", pdevinfo.name);
+			ret = PTR_ERR(adata->sdw_dma_dev);
+			if (adata->is_pdm_dev)
+				goto unregister_dmic_codec_dev;
+			else
+				goto de_init;
 		}
 	}
+
 	return 0;
-unregister_devs:
-	for (--index; index >= 0; index--)
-		platform_device_unregister(adata->pdev[index]);
+unregister_dmic_codec_dev:
+		platform_device_unregister(adata->dmic_codec_dev);
+unregister_pdm_dev:
+		platform_device_unregister(adata->pdm_dev);
 de_init:
 	if (acp63_deinit(adata->acp63_base, &pci->dev))
 		dev_err(&pci->dev, "ACP de-init failed\n");
@@ -542,6 +501,8 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		ret = -ENOMEM;
 		goto release_regions;
 	}
+	adata->addr = addr;
+	adata->reg_range = ACP63_REG_END - ACP63_REG_START;
 	/*
 	 * By default acp_reset flag is set to true. i.e acp_deinit() and acp_init()
 	 * will be invoked for all ACP configurations during suspend/resume callbacks.
@@ -572,6 +533,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		dev_err(&pci->dev, "ACP platform devices creation failed\n");
 		goto de_init;
 	}
+
 skip_pdev_creation:
 	device_set_wakeup_enable(&pci->dev, true);
 	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
@@ -626,11 +588,17 @@ static const struct dev_pm_ops acp63_pm_ops = {
 static void snd_acp63_remove(struct pci_dev *pci)
 {
 	struct acp63_dev_data *adata;
-	int ret, index;
+	int ret;
 
 	adata = pci_get_drvdata(pci);
-	for (index = 0; index < adata->pdev_count; index++)
-		platform_device_unregister(adata->pdev[index]);
+	if (adata->sdw) {
+		amd_sdw_exit(adata);
+		platform_device_unregister(adata->sdw_dma_dev);
+	}
+	if (adata->is_pdm_dev) {
+		platform_device_unregister(adata->pdm_dev);
+		platform_device_unregister(adata->dmic_codec_dev);
+	}
 	ret = acp63_deinit(adata->acp63_base, &pci->dev);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
@@ -663,5 +631,6 @@ module_pci_driver(ps_acp63_driver);
 MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
 MODULE_AUTHOR("Syed.SabaKareem@amd.com");
 MODULE_DESCRIPTION("AMD ACP Pink Sardine PCI driver");
+MODULE_IMPORT_NS(SOUNDWIRE_AMD_INIT);
 MODULE_IMPORT_NS(SND_AMD_SOUNDWIRE_ACPI);
 MODULE_LICENSE("GPL v2");
-- 
2.34.1


