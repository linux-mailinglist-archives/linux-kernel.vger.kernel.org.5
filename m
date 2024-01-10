Return-Path: <linux-kernel+bounces-21905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDD0829673
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FB01F26030
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFF13F8D4;
	Wed, 10 Jan 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y8nuJpWW"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2EC3EA8C;
	Wed, 10 Jan 2024 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIIg3O3azJi8Wfc8zWoXB2yirEyAkgNAVsXk6IUc9N/GQ4iU/FQcIQsmGsUcuU87ArYOadHCi8ebxGP1bCabTPhVJyLt06CCrxi+cKTpH3iaws6gutw/njPzHpXtmQHIOQIiWPB+H4jW9ChCHZawqgwbuBzs85muxQ6oLuCu9UFjdXxF8mg8vWtr/QPT9QyJBHHzqNhLVzraQ+r0RICdqgt+bJTiiT9fterKBIj6sdHh7nrGMRdyWyGXuOQ2sYRPD1Allry6MXR9RYY62sg0pm/cYOK3C6uhLPnSAUWFKKFgx5YfWGpS3AlFnFwQnYPdWJocDCSS4Xunuw13t2fr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I5faMlbiK2WABI1X3s7NUbtTh8LQQWNgrQ5ilX7d0Y=;
 b=OU6srAv0ByKPCVn5LVqUY9ayl4irmgB9avxaXmyNDFEQKnYYwqCSzjGAUu527IPAj1+yeSuVP9H0ajk5vOyHywh5JiWvV9EMOBS6MzBnkCnwMd99ke1nd5nQCFrb1dD8NyAIQgrFxCK2gJ6p9OJcTkjR80TWz72H1w6pO2M5i90SZCdrgRwho8nEDN2B34PDLB37fqvuHcrrVetRXFBXwQyMYUFeEzyE3oUNuVCspeDwPXNMjyBTn4+mlK7g/wmRLGro/fIe+CTFx5xN3ldjA4qPRHK2X33jEbaywCzyqKymL5ESjKEf7evZWKcHcvPpprKKfTNVmO7EQp+7x+HR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I5faMlbiK2WABI1X3s7NUbtTh8LQQWNgrQ5ilX7d0Y=;
 b=Y8nuJpWWzVUmv++umTScvv/Il6XUpGVUYPQUFiZYTSvHEXwwbV4zI+CMXoBxmv26nnX1ng+4Pe3XyZ7AAFYwmQL5DcQcl8vLKBzM8hXf1znZqiy74cdO74xqqslxiCh2nEiM8oEGtIT1vU3Fm1hOnfioaGexMP8uU0fvPXMoAdk=
Received: from DM6PR01CA0014.prod.exchangelabs.com (2603:10b6:5:296::19) by
 DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Wed, 10 Jan 2024 09:45:15 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::fc) by DM6PR01CA0014.outlook.office365.com
 (2603:10b6:5:296::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 09:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 09:45:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:45:04 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Wed, 10 Jan 2024 03:44:59 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Syed Saba
 Kareem" <Syed.SabaKareem@amd.com>, Arnd Bergmann <arnd@arndb.de>, "Marian
 Postevca" <posteuca@mutex.one>, open list <linux-kernel@vger.kernel.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>
Subject: [PATCH V2 01/13] ASoC/soundwire: implement generic api for scanning amd soundwire controller
Date: Wed, 10 Jan 2024 15:14:04 +0530
Message-ID: <20240110094416.853610-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
References: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: f92c4040-4516-4fc8-7fae-08dc11c0d951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SW61RYNmTSFzyg8Kw+aaHard+S95epNu6tVkgQk0SgNVfc5aSWLtumfQ4lO1RxD41ziUfpH6tB2aKcW8bT46lYxErxwvB6r/jDopHzBCG9iSIscBQ2UwooxlJ3qUVOL79jhqEj8PQp54Du4bmPdJF5cyhbUIdHsrxRkg4lLnkXKPqM9bX84CWNx33iVbSWXjCi/H8A+vLOItVTXm8KEXDhxAzK0jL0Ty0sgDe3LMN6RtC00gUCzLVHLf+ztx63lQUfcTVJsoSY+Mpy8PBIi+MxhePXc45Wht5Gc5KCRYj4E/PHKjLrBrZC+ys3e5quUtzIs99VyvXZQlbvFQLUsc5U3akH+npVreceOwsTKJynED3zAHJuBvBVo803CB2aCah40Oue15TMb3TnmJ+KSpaNMDyogCLtty6ZsBLUmrdqTZwRSak0jMx5wpc7N3jb7VpphNbAF6i+44EN/l7gBbYUIxXI7nbKNM5hUCPu4b/uheFFW6cecg1TnQHoQnxWE8H+yDjGK5KsmjgjSUrMkRUZkVn8dbgO6BOdiXTZ+nTkUoB7Wfm9D0hf6Q0u/v4qVvy6yfCO+k/776vxwbgKWqihhsVdxsO16c72b2jpw86IpA2ltfNEg7DlGFkZVW7wOO/RTgRXiqVddLSFmk9n74DubwyjIw4qHJS0Mtj3F3ueMV5OEemRF8SnvSBD+qwknfMpVeRkXStwfiA4+iIpU9kb/ilQOKwRUwavWEWkJA8ZxtuPYjLR5FqmkFUrG5FRKdLN275R4CsJ5lXsGjUkDJ4NH7RVLGMU3uNZEyYniS28k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(478600001)(4326008)(8676002)(8936002)(36860700001)(70206006)(426003)(110136005)(54906003)(316002)(336012)(70586007)(26005)(1076003)(83380400001)(7696005)(6666004)(2616005)(47076005)(5660300002)(2906002)(7416002)(41300700001)(36756003)(82740400003)(81166007)(356005)(86362001)(40480700001)(40460700003)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:45:15.6064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f92c4040-4516-4fc8-7fae-08dc11c0d951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670

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


