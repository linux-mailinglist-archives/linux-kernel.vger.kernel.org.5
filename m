Return-Path: <linux-kernel+bounces-7939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12981AF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D7E1C22C41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1414A8B;
	Thu, 21 Dec 2023 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ms9exYsz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EF211735;
	Thu, 21 Dec 2023 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaprQO9U5H31ZApSI+N1Lo+abByXHT0saIKKqifGlIIyWw9fMzOZMjnnPK9E7q2VPZi/17NOy2uB6LzEelswC4KFHtTrdd1r/g7+TOtKk5FgRq3iBcj4bGZsW30FQxixB685jVwE+z1cgiy10fTzkQnwH0yxkRgT5VUB+TidCf7rrXygvsKQR020LkKaywZfSpFQdDDJ+PXV9oNjY8WmvypUA1mdZGUP9U9VHyL/0wHxmCsw3WrmbJLXkWsADpup9odHkNNNcrLWTNoZLo+kh0x9Pyf0XuyODnOSt5YGWEqpOLfTosa8nU/uCQ/453FMo3cambRy9+ftqXV9RYUU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I5faMlbiK2WABI1X3s7NUbtTh8LQQWNgrQ5ilX7d0Y=;
 b=KKo/rwI5IsVGfPGmBElJJLGgJUwSVpCpMznRSZQjD1IghyOHmtrcr6zujnBtYAX7CQXNyJ86z0yZf+qrV0LOinl2bDFrPmQavi9oHPygiX+FJbu1Hc1GOBYzTg8GQWSFkdmaj5iYT6Z94iVlMJeEve1xTmhwHqpqL+26n8FFaKZZX4t2cFDdTAA84fkorm2dSF/KZxLYlvTLezHobWaVjTXWWSWi10yD1F7toeKTfnYa3WeeZEkeABAkn8a6MtK1jfJ560sMVramB13+asSKa/tev1yPG6mwwCB9I0OtyCGIR3EIgVMFDTyrwDCUqGZ75WsTpyC62UI99pEz+LCxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I5faMlbiK2WABI1X3s7NUbtTh8LQQWNgrQ5ilX7d0Y=;
 b=ms9exYsz2BsvY+xu0C8uBaznJvA+OPuilwNDkLhNbI4woCkhUFp86+n1Oi88QnC4JoAAbiumrQaPvpg53a/AnK61ne5a3IW+IJBCULyr4gkKd4ee1c+GHx/Lf5o6nGzX4T6xzyDOlvH0vWg5BAIhHjh7ZjA3Z/ymzZftLx2a4/k=
Received: from MW4PR04CA0214.namprd04.prod.outlook.com (2603:10b6:303:87::9)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.21; Thu, 21 Dec 2023 07:36:23 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::f3) by MW4PR04CA0214.outlook.office365.com
 (2603:10b6:303:87::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 07:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.18 via Frontend Transport; Thu, 21 Dec 2023 07:36:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:36:22 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:36:21 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Thu, 21 Dec 2023 01:36:16 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <pierre-louis.bossart@linux.intel.com>,
	<vinod.koul@intel.com>, <venkataprasad.potturu@amd.com>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Syed Saba
 Kareem" <Syed.SabaKareem@amd.com>, Arnd Bergmann <arnd@arndb.de>, "Marian
 Postevca" <posteuca@mutex.one>, open list <linux-kernel@vger.kernel.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>
Subject: [PATCH 01/12] ASoC/soundwire: implement generic api for scanning amd soundwire controller
Date: Thu, 21 Dec 2023 13:05:47 +0530
Message-ID: <20231221073558.3181911-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c8e2cc-70d1-4d77-dafa-08dc01f787f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KxH1s/lZtLf5FuPf++KZnlwktaPhnjTk8IFgRziT+7s2xDV9qDJ/gYz5l+xdqh2q5RqCLtegGmlsZleLbNNdj0dNANOBBkp1tKnloCeIU0EKtQt/CCscYvfdqgabiE74Hb7ojEIWCUM4KpofdT5AOs/p8vfWbCrgGTND+l5T4jkp7W9FDaTkD/ngiwoIKhPI1gm/4Y9If4Wum4LqCLzdD8oD+I4LR1SFiKY2e6EFMsjKWOILqtEtzfBTdp+uITjevFmMo4IxgjYda49xKgLdm0eB2wNeTrN6NPVPLc2Pmxnrdj/Lb8628rDBqP8lXARVlRWb+bN1oPiLqKU/fOoof1Sqs4JFxcozkm0yaFvpK7vpYZwGmP3gIxWktBxsbbZoguDW65wbKtIteZ2IQMZj9PjxdKkksdo8rQnVR47Cq4GvibRtmyZ8JtGnP4Aj+9OqvHDcpblJELZOAwNfv1fQfAmAhvkQ03qLrPZtYpsgxQAbjE/I43ec5kU1Av1dyQMGYMWR6471+2fQWE8pdM6TTDkCvI1FeScZDzlq++JmkRlyDbLV/kfcHcsFGhnhzEsBlB7eR7vIhHom3qjUYiwaq9xnN6aDVtfb0h/gemO5wzcOhf5PtipaQhunF+yPTyBI9wdWtFBe5iyUD61/d44eNCIQFy51Uofv/V3Uu6fEjqP/TWLcxIREfWwR0hEc1R6EfInklQDtsZFarQZ+5DFVszWjfkXe9RevO3OldjNtet9GMhExYCQsZ9IPv6Rf9VKUGE9bcMITRs53Xn+1fnrLkfTb0849VZFuuS1nP4gQPq8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(6666004)(478600001)(54906003)(110136005)(316002)(8676002)(8936002)(70586007)(70206006)(83380400001)(36860700001)(47076005)(7696005)(1076003)(26005)(336012)(426003)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(40480700001)(86362001)(36756003)(82740400003)(81166007)(356005)(40460700003)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 07:36:22.7464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c8e2cc-70d1-4d77-dafa-08dc01f787f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084

Implement generic function for scanning SoundWire controller.
Same function will be used for legacy and sof stack for AMD platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 include/linux/soundwire/sdw_amd.h | 15 ++++++++
 sound/soc/amd/acp/Kconfig         |  7 ++++
 sound/soc/amd/acp/Makefile        |  2 +
 sound/soc/amd/acp/amd-sdw-acpi.c  | 62 +++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)
 create mode 100644 sound/soc/amd/acp/amd-sdw-acpi.c

diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index ceecad74aef9..41dd64941cef 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -6,6 +6,7 @@
 #ifndef __SDW_AMD_H
 #define __SDW_AMD_H
 
+#include <linux/acpi.h>
 #include <linux/soundwire/sdw.h>
 
 /* AMD pm_runtime quirk definitions */
@@ -106,4 +107,18 @@ struct amd_sdw_manager {
 
 	struct sdw_amd_dai_runtime **dai_runtime_array;
 };
+
+/**
+ * struct sdw_amd_acpi_info - Soundwire AMD information found in ACPI tables
+ * @handle: ACPI controller handle
+ * @count: maximum no of soundwire manager links supported on AMD platform.
+ * @link_mask: bit-wise mask listing links enabled by BIOS menu
+ */
+struct sdw_amd_acpi_info {
+	acpi_handle handle;
+	int count;
+	u32 link_mask;
+};
+
+int amd_sdw_scan_controller(struct sdw_amd_acpi_info *info);
 #endif
diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 84c963241dc5..b3105ba9c3a3 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -101,6 +101,13 @@ config SND_SOC_AMD_MACH_COMMON
 	help
 	  This option enables common Machine driver module for ACP.
 
+config SND_AMD_SOUNDWIRE_ACPI
+	tristate "AMD SoundWire ACPI Support"
+	depends on ACPI
+	help
+	  This options enables ACPI helper functions for SoundWire
+	  interface for AMD platforms.
+
 config SND_SOC_AMD_LEGACY_MACH
 	tristate "AMD Legacy Machine Driver Support"
 	depends on X86 && PCI && I2C
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index ff5f7893b81e..1fd581a2aa33 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -10,6 +10,7 @@ snd-acp-i2s-objs     := acp-i2s.o
 snd-acp-pdm-objs     := acp-pdm.o
 snd-acp-legacy-common-objs   := acp-legacy-common.o
 snd-acp-pci-objs     := acp-pci.o
+snd-amd-sdw-acpi-objs := amd-sdw-acpi.o
 
 #platform specific driver
 snd-acp-renoir-objs     := acp-renoir.o
@@ -33,6 +34,7 @@ obj-$(CONFIG_SND_AMD_ASOC_REMBRANDT) += snd-acp-rembrandt.o
 obj-$(CONFIG_SND_AMD_ASOC_ACP63) += snd-acp63.o
 obj-$(CONFIG_SND_AMD_ASOC_ACP70) += snd-acp70.o
 
+obj-$(CONFIG_SND_AMD_SOUNDWIRE_ACPI) += snd-amd-sdw-acpi.o
 obj-$(CONFIG_SND_SOC_AMD_MACH_COMMON) += snd-acp-mach.o
 obj-$(CONFIG_SND_SOC_AMD_LEGACY_MACH) += snd-acp-legacy-mach.o
 obj-$(CONFIG_SND_SOC_AMD_SOF_MACH) += snd-acp-sof-mach.o
diff --git a/sound/soc/amd/acp/amd-sdw-acpi.c b/sound/soc/amd/acp/amd-sdw-acpi.c
new file mode 100644
index 000000000000..babd841d3296
--- /dev/null
+++ b/sound/soc/amd/acp/amd-sdw-acpi.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2023 Advanced Micro Devices, Inc. All rights reserved.
+//
+// Authors: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
+
+/*
+ * SDW AMD ACPI scan helper function
+ */
+
+#include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/fwnode.h>
+#include <linux/module.h>
+#include <linux/soundwire/sdw_amd.h>
+#include <linux/string.h>
+
+int amd_sdw_scan_controller(struct sdw_amd_acpi_info *info)
+{
+	struct acpi_device *adev = acpi_fetch_acpi_dev(info->handle);
+	u32 sdw_bitmap = 0;
+	u8 count = 0;
+	int ret;
+
+	if (!adev)
+		return -EINVAL;
+
+	/* Found controller, find links supported */
+	ret = fwnode_property_read_u32_array(acpi_fwnode_handle(adev),
+					     "mipi-sdw-manager-list", &sdw_bitmap, 1);
+	if (ret) {
+		dev_err(&adev->dev,
+			"Failed to read mipi-sdw-manager-list: %d\n", ret);
+		return -EINVAL;
+	}
+	count = hweight32(sdw_bitmap);
+	/* Check count is within bounds */
+	if (count > info->count) {
+		dev_err(&adev->dev, "Manager count %d exceeds max %d\n",
+			count, info->count);
+		return -EINVAL;
+	}
+
+	if (!count) {
+		dev_dbg(&adev->dev, "No SoundWire Managers detected\n");
+		return -EINVAL;
+	}
+	dev_dbg(&adev->dev, "ACPI reports %d SoundWire Manager devices\n", count);
+	info->link_mask = sdw_bitmap;
+	return 0;
+}
+EXPORT_SYMBOL_NS(amd_sdw_scan_controller, SND_AMD_SOUNDWIRE_ACPI);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("AMD SoundWire ACPI helpers");
-- 
2.34.1


