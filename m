Return-Path: <linux-kernel+bounces-65062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E150854755
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB9128990A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CAF16423;
	Wed, 14 Feb 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JrfAXeRO"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A1117543;
	Wed, 14 Feb 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907238; cv=fail; b=fJ+998kd7jIfFFb0xrUpG1cRkmZof7/Ll/XGZYqF/eJ/9UVd8B+YhZtfrG0VGl9zw27cCxBHPmQGPH4r/s/+Yh/hE6eK+riTE2y7YcO2gYWAUGtFqt+TBJMxMlxlszEJ7xMwE1K5vN1hwINbvxNLaI1LTN+EOqqZXqjMuxwrEEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907238; c=relaxed/simple;
	bh=KiRUhiXNkrqEbk9MsELgK/UZKEb9ywA04Zw3Q6SvgBM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z2YlKuuLRkLR1m4/Rou/GrsW0EW7NgoxhyMcSjKIzERRzCc2xydtlztwNJ9MLjfPXZJgiyn4smzLYTUgQh+C4LoO8WnU7mOwTF5ofXEwZOcnOa9rG6vMhc/pZyxBF4Sh9aGBZe5UvZiGbnhgKd4VgeQaPCLxknVIIbZj7YaGW/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JrfAXeRO; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4gsMPkGNEHpd1+WWX0INZaucmq2nTxuXeSX6Ybd/BuqWUAFYwnenY+RxhX1NLTBaolB0uBA/H2vbM33uyjOdAhp3BqGosu0GEeh2uLxcH/65mjdrXBNBjvwaDxrptxMTFVZVwFyGgp30OGAE6TLYAG4IBXo8POjLHkKYOMXsncKd25w0kPhJUvCmNKpRwEilM1j/sWgT2dtbZnQIigje4RrVtA2Ful5caTiyY7fcZ8lHOI0cOm7l9YmJhEsRcO4WUwaeP/O8hwkhBAsWMfoIuMdL8+6iZyDy+u6DgT53zPDzsfyRQ933mMzsADT+DOZeoy5M4o5dvQY6MVKg6AkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmNHY+JFIU9aBiXzGwh7sfFVz0C2synAQYrNH6fYGio=;
 b=JVUH1Vd26Amx1vfKzgtaHL110Z1756dpE1Fnsc0Br1aCFlDDlogKEpobLR23hb91d+5tbvoNbezBNle2aiBFqz5jhhXLxq2Ou5qoKbqgUwSlMUsgCzAVjyJ33s+SvVonXxbEe7ensTqXcyeNUeOp5cN5hPP6uWdbOc+lDa8rKFOO2gP6Npiu3th0UtPfOVf89UvL/SA+jTdeZJARm8kRugGE6oOyMBfiH68EcpdZlSwZ0TByiHjoOnxKQrwmLxiH9ZA0tseqwS/RAbqgbnAThkCWUJijuWxK2E66CXB+W2xbc61Wn5NEjH5MFchv+q2fmIOHGl6gOq95dX0X1okbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmNHY+JFIU9aBiXzGwh7sfFVz0C2synAQYrNH6fYGio=;
 b=JrfAXeRObpjhiLC7VnBYWLyule6IlnNUEKTJhSecyZkb7WxEowMVZkEGgBucv97dfuLAP8UXGDwQugL1B6+Mg+/i02L5ieUL9CeE+32L+kuFYRQ+naLBuJutwHnvsNxFZN3pqGdIOY5aotHBMwMJsV5jf7uCbUDbivBXf0KC8JQ=
Received: from MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::18)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 10:40:32 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::39) by MW4P223CA0013.outlook.office365.com
 (2603:10b6:303:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 10:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 10:40:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 04:40:29 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Wed, 14 Feb 2024 04:40:20 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <Mario.Limonciello@amd.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, "Cristian
 Ciocaltea" <cristian.ciocaltea@collabora.com>, Lucas Tanure
	<lucas.tanure@collabora.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] ASoC: amd: ps: refactor acp device configuration read logic
Date: Wed, 14 Feb 2024 16:10:01 +0530
Message-ID: <20240214104014.1144668-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 0265def9-00cf-4a97-ab53-08dc2d495df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	phiTRaMD/BFHJjuvd/20L0+JtD6u+rJ4tG5fanZgXS9aFknIIHPZ6bdZ9rkvOe0zVIQb/eePAmJ7iDnCS0ZGSKzQhuE4tH7qR4PR/s5wJyOCrkdlEPGFCCVkmX5CW3nKQg5g6rcv810y5lQuesUsIyf8U0mkZBu6zoETQd4gkvwtPU6HJE827jJHvtcspU1/K2mzQGz1qHz0sHxD8tan/X9HTYLgKE6X5iRpGtE6xyswteewCfg2VlwSopzh5Iiqv7V5kVPRvsKXyRkx6rDJKenM9XymlPgQ0keRSYIidxZH34qSEtaVRYwAQYP+E6yR4p+h97n5tgz6TT6BlSr7gMNwwFbPqEmGMvREb2Uv1b0hTQQTUbRWHBuYDPvqmjQ0zGabTVMpQsH5k58Xiq+QET9kJB0nvHaECw3VuAH4Z2FSmyq0UPfi8XANcKsyiRAm7VoqjVoyRyk+VjxndX2vq8T+6dSzB9rU5LZssTMN7JBIwfLoB4VvmBBctysFw/HnNF8tdCTDI8AYG7g4RYeoxxIYiZ6X+LSKJNKo1NjTUpLk3nXJzSr6iwM61fUMKmicHNh4xrbA3kYRvdXjfePWDKYu9VMxNG+icqFd5ItlOak=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(30864003)(7416002)(5660300002)(478600001)(7696005)(86362001)(83380400001)(41300700001)(36756003)(426003)(2616005)(26005)(1076003)(336012)(4326008)(54906003)(70586007)(8936002)(8676002)(6916009)(70206006)(6666004)(316002)(82740400003)(81166007)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 10:40:30.9889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0265def9-00cf-4a97-ab53-08dc2d495df6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

Refactor acp device configuration read logic and use common function
to scan SoundWire devices.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig     |  17 ++++
 sound/soc/amd/ps/acp63.h  |  11 +++
 sound/soc/amd/ps/pci-ps.c | 176 +++++++++++---------------------------
 3 files changed, 78 insertions(+), 126 deletions(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 273688c05317..fa74635cee08 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -132,9 +132,26 @@ config SND_SOC_AMD_RPL_ACP6x
           Say m if you have such a device.
           If unsure select "N".
 
+config SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
+	tristate
+	select SOUNDWIRE_AMD if SND_SOC_AMD_SOUNDWIRE != n
+	select SND_AMD_SOUNDWIRE_ACPI if ACPI
+
+config SND_SOC_AMD_SOUNDWIRE
+	tristate "Support for SoundWire based AMD platforms"
+	default SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
+	depends on SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
+	depends on ACPI && SOUNDWIRE
+	depends on !(SOUNDWIRE=m && SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE=y)
+	help
+	  This adds support for SoundWire for AMD platforms.
+	  Say Y if you want to enable SoundWire links with SOF.
+	  If unsure select "N".
+
 config SND_SOC_AMD_PS
         tristate "AMD Audio Coprocessor-v6.3 Pink Sardine support"
 	select SND_AMD_ACP_CONFIG
+	select SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
         depends on X86 && PCI && ACPI
         help
           This option enables Audio Coprocessor i.e ACP v6.3 support on
diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 8b853b8d0219..123b9ade69d4 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -5,6 +5,7 @@
  * Copyright (C) 2022, 2023 Advanced Micro Devices, Inc. All rights reserved.
  */
 
+#include <linux/soundwire/sdw_amd.h>
 #include <sound/acp63_chip_offset_byte.h>
 
 #define ACP_DEVICE_ID 0x15E2
@@ -263,6 +264,11 @@ struct sdw_dma_ring_buf_reg {
  * @sdw0_dev_index: SoundWire Manager-0 platform device index
  * @sdw1_dev_index: SoundWire Manager-1 platform device index
  * @sdw_dma_dev_index: SoundWire DMA controller platform device index
+ * @info: SoundWire AMD information found in ACPI tables
+ * @is_sdw_dev: flag set to true when any SoundWire manager instances are available
+ * @is_pdm_dev: flag set to true when ACP PDM controller exists
+ * @is_pdm_config: flat set to true when PDM configuration is selected from BIOS
+ * @is_sdw_config: flag set to true when SDW configuration is selected from BIOS
  * @sdw0-dma_intr_stat: DMA interrupt status array for SoundWire manager-SW0 instance
  * @sdw_dma_intr_stat: DMA interrupt status array for SoundWire manager-SW1 instance
  * @acp_reset: flag set to true when bus reset is applied across all
@@ -282,6 +288,11 @@ struct acp63_dev_data {
 	u16 sdw0_dev_index;
 	u16 sdw1_dev_index;
 	u16 sdw_dma_dev_index;
+	struct sdw_amd_acpi_info info;
+	bool is_sdw_dev;
+	bool is_pdm_dev;
+	bool is_pdm_config;
+	bool is_sdw_config;
 	u16 sdw0_dma_intr_stat[ACP63_SDW0_DMA_MAX_STREAMS];
 	u16 sdw1_dma_intr_stat[ACP63_SDW1_DMA_MAX_STREAMS];
 	bool acp_reset;
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 5927eef04170..c97e418a88ce 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -237,122 +237,51 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 }
 
-static int sdw_amd_scan_controller(struct device *dev)
+#if IS_ENABLED(CONFIG_SND_SOC_AMD_SOUNDWIRE)
+static int acp_scan_sdw_devices(struct device *dev, u64 addr)
 {
+	struct acpi_device *sdw_dev;
 	struct acp63_dev_data *acp_data;
-	struct fwnode_handle *link;
-	char name[32];
-	u32 sdw_manager_bitmap;
-	u8 count = 0;
-	u32 acp_sdw_power_mode = 0;
-	int index;
-	int ret;
 
 	acp_data = dev_get_drvdata(dev);
-	/*
-	 * Current implementation is based on MIPI DisCo 2.0 spec.
-	 * Found controller, find links supported.
-	 */
-	ret = fwnode_property_read_u32_array((acp_data->sdw_fw_node), "mipi-sdw-manager-list",
-					     &sdw_manager_bitmap, 1);
-
-	if (ret) {
-		dev_dbg(dev, "Failed to read mipi-sdw-manager-list: %d\n", ret);
-		return -EINVAL;
-	}
-	count = hweight32(sdw_manager_bitmap);
-	/* Check count is within bounds */
-	if (count > AMD_SDW_MAX_MANAGERS) {
-		dev_err(dev, "Manager count %d exceeds max %d\n", count, AMD_SDW_MAX_MANAGERS);
-		return -EINVAL;
-	}
+	if (!addr)
+		return -ENODEV;
 
-	if (!count) {
-		dev_dbg(dev, "No SoundWire Managers detected\n");
-		return -EINVAL;
-	}
-	dev_dbg(dev, "ACPI reports %d SoundWire Manager devices\n", count);
-	acp_data->sdw_manager_count = count;
-	for (index = 0; index < count; index++) {
-		scnprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
-		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
-		if (!link) {
-			dev_err(dev, "Manager node %s not found\n", name);
-			return -EIO;
-		}
+	sdw_dev = acpi_find_child_device(ACPI_COMPANION(dev), addr, 0);
+	if (!sdw_dev)
+		return -ENODEV;
 
-		ret = fwnode_property_read_u32(link, "amd-sdw-power-mode", &acp_sdw_power_mode);
-		if (ret)
-			return ret;
-		/*
-		 * when SoundWire configuration is selected from acp pin config,
-		 * based on manager instances count, acp init/de-init sequence should be
-		 * executed as part of PM ops only when Bus reset is applied for the active
-		 * SoundWire manager instances.
-		 */
-		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE) {
-			acp_data->acp_reset = false;
-			return 0;
-		}
-	}
+	acp_data->info.handle = sdw_dev->handle;
+	acp_data->info.count = AMD_SDW_MAX_MANAGERS;
+	return amd_sdw_scan_controller(&acp_data->info);
+}
+#else
+static int acp_scan_sdw_devices(struct device *dev, u64 addr)
+{
 	return 0;
 }
+#endif
 
-static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
+static int get_acp63_device_config(struct pci_dev *pci, struct acp63_dev_data *acp_data)
 {
-	struct acpi_device *dmic_dev;
-	struct acpi_device *sdw_dev;
+	struct acpi_device *pdm_dev;
 	const union acpi_object *obj;
+	u32 config;
 	bool is_dmic_dev = false;
 	bool is_sdw_dev = false;
 	int ret;
 
-	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
-	if (dmic_dev) {
-		/* is_dmic_dev flag will be set when ACP PDM controller device exists */
-		if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",
-					   ACPI_TYPE_INTEGER, &obj) &&
-					   obj->integer.value == ACP_DMIC_DEV)
-			is_dmic_dev = true;
-	}
-
-	sdw_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_SDW_ADDR, 0);
-	if (sdw_dev) {
-		acp_data->sdw_fw_node = acpi_fwnode_handle(sdw_dev);
-		ret = sdw_amd_scan_controller(&pci->dev);
-		/* is_sdw_dev flag will be set when SoundWire Manager device exists */
-		if (!ret)
-			is_sdw_dev = true;
-	}
-	if (!is_dmic_dev && !is_sdw_dev)
-		return -ENODEV;
-	dev_dbg(&pci->dev, "Audio Mode %d\n", config);
+	config = readl(acp_data->acp63_base + ACP_PIN_CONFIG);
 	switch (config) {
 	case ACP_CONFIG_4:
 	case ACP_CONFIG_5:
 	case ACP_CONFIG_10:
 	case ACP_CONFIG_11:
-		if (is_dmic_dev) {
-			acp_data->pdev_config = ACP63_PDM_DEV_CONFIG;
-			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
-		}
+		acp_data->is_pdm_config = true;
 		break;
 	case ACP_CONFIG_2:
 	case ACP_CONFIG_3:
-		if (is_sdw_dev) {
-			switch (acp_data->sdw_manager_count) {
-			case 1:
-				acp_data->pdev_config = ACP63_SDW_DEV_CONFIG;
-				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
-				break;
-			case 2:
-				acp_data->pdev_config = ACP63_SDW_DEV_CONFIG;
-				acp_data->pdev_count = ACP63_SDW0_SDW1_MODE_DEVS;
-				break;
-			default:
-				return -EINVAL;
-			}
-		}
+		acp_data->is_sdw_config = true;
 		break;
 	case ACP_CONFIG_6:
 	case ACP_CONFIG_7:
@@ -360,40 +289,36 @@ static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63
 	case ACP_CONFIG_8:
 	case ACP_CONFIG_13:
 	case ACP_CONFIG_14:
-		if (is_dmic_dev && is_sdw_dev) {
-			switch (acp_data->sdw_manager_count) {
-			case 1:
-				acp_data->pdev_config = ACP63_SDW_PDM_DEV_CONFIG;
-				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
-				break;
-			case 2:
-				acp_data->pdev_config = ACP63_SDW_PDM_DEV_CONFIG;
-				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
-				break;
-			default:
-				return -EINVAL;
-			}
-		} else if (is_dmic_dev) {
-			acp_data->pdev_config = ACP63_PDM_DEV_CONFIG;
-			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
-		} else if (is_sdw_dev) {
-			switch (acp_data->sdw_manager_count) {
-			case 1:
-				acp_data->pdev_config = ACP63_SDW_DEV_CONFIG;
-				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
-				break;
-			case 2:
-				acp_data->pdev_config = ACP63_SDW_DEV_CONFIG;
-				acp_data->pdev_count = ACP63_SDW0_SDW1_MODE_DEVS;
-				break;
-			default:
-				return -EINVAL;
-			}
-		}
+		acp_data->is_pdm_config = true;
+		acp_data->is_sdw_config = true;
 		break;
 	default:
 		break;
 	}
+
+	if (acp_data->is_pdm_config) {
+		pdm_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
+		if (pdm_dev) {
+			/* is_dmic_dev flag will be set when ACP PDM controller device exists */
+			if (!acpi_dev_get_property(pdm_dev, "acp-audio-device-type",
+						   ACPI_TYPE_INTEGER, &obj) &&
+						   obj->integer.value == ACP_DMIC_DEV)
+				is_dmic_dev = true;
+		}
+	}
+
+	if (acp_data->is_sdw_config) {
+		ret = acp_scan_sdw_devices(&pci->dev, ACP63_SDW_ADDR);
+		if (!ret && acp_data->info.link_mask)
+			is_sdw_dev = true;
+	}
+
+	acp_data->is_pdm_dev = is_dmic_dev;
+	acp_data->is_sdw_dev = is_sdw_dev;
+	if (!is_dmic_dev && !is_sdw_dev) {
+		dev_dbg(&pci->dev, "No PDM or SoundWire manager devices found\n");
+		return -ENODEV;
+	}
 	return 0;
 }
 
@@ -576,7 +501,6 @@ static int snd_acp63_probe(struct pci_dev *pci,
 	struct acp63_dev_data *adata;
 	u32 addr;
 	u32 irqflags, flag;
-	int val;
 	int ret;
 
 	irqflags = IRQF_SHARED;
@@ -637,8 +561,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
 		goto de_init;
 	}
-	val = readl(adata->acp63_base + ACP_PIN_CONFIG);
-	ret = get_acp63_device_config(val, pci, adata);
+	ret = get_acp63_device_config(pci, adata);
 	/* ACP PCI driver probe should be continued even PDM or SoundWire Devices are not found */
 	if (ret) {
 		dev_dbg(&pci->dev, "get acp device config failed:%d\n", ret);
@@ -740,4 +663,5 @@ module_pci_driver(ps_acp63_driver);
 MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
 MODULE_AUTHOR("Syed.SabaKareem@amd.com");
 MODULE_DESCRIPTION("AMD ACP Pink Sardine PCI driver");
+MODULE_IMPORT_NS(SND_AMD_SOUNDWIRE_ACPI);
 MODULE_LICENSE("GPL v2");
-- 
2.34.1


