Return-Path: <linux-kernel+bounces-32619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A956A835E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5FA1C224AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B439AC5;
	Mon, 22 Jan 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ccy0XWIH"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDE39FC0;
	Mon, 22 Jan 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915503; cv=fail; b=DeYYpQAAOS6/0iVGJ4bcC1aKv+mdOG/viRfBxbJKT4+x7keRt2wFMeQaccDSJBHMABMLddaDAhF64S2Op9gxKP9oESkPqdeW0cYni4aDkjsfjDLyAwz36B6raXBpudLw95dfAdAhX4pjq0X0NvJBpowvm5k+nkM/b7AaEsyvOIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915503; c=relaxed/simple;
	bh=c8pyGPpBIPuuzo3IuY/HnWAHT2Hq/EMvv52T1XmEyBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swAxJ0ok3pCfRDGyB9kyqmbO1AuF9xceTW2W5elHjGSXTHaOlcQb0HMsiaufQnonSH0qWjlEvKKVs98CelBKp06rGqt2/ZaH71bTj5Atog6gJEo0XxCWlGXTH4ttYstMOr8wDRKL5LnXwaKtUSqNBTqoNk56ICJiYMXTsBqug2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ccy0XWIH; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtdgBJI9GKUgbCUz+av+Bn3DDIVgIaZLO6rRd0OPpbWsBRZmcOoESWg+XvpluwhtDD+9m6Cs1h3XaAv0DbuQrMse0PTaT65v9CxpUdQ95jUp4Iudz3u/XWiDOyts/KvOE5kNjQ7rzW/50YMiMxxeLRgt4d6HIWZuvBDm/0xbLwu+ckQFF73f4SZHg98zb2qTPYoOyY3ldRBij8HaDOaP3Yb2pghWgkQmEDFxdL2A0aYD5QQ8ppibQNgwQ9xN5L/uRLwOmI7rpz+eYquoQKDAbkQoxHcDtc079A5KNJGfu2zAOW1d3vH1uNwTmXIJzT2ImRGwdLLptOKMd3Hlc1g5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOhMtVCesN+ur8N0oWmzRRCxIH3/QbXj3Wrd5lQ7D7M=;
 b=DqfwXob22F6tejRoTHsWwOuf9R24lL6FllbnharuTTVNWeSXFJBSiEudCAmoTP2tyJe3DC6Qs8VGn3mR0VBz88oFGeVPyQ5Iqhbr0yWIdjNJ0i/GFtYYWk2gS8m+pIkNzWs3Va8AxcRBVQgyR2agLzuBylabt71NdxbBbqBfnhHcVBFUxv3iZJ7yN1czIIeOvK5TkzvQfeIbeUd29R1Eal/NdL4rZdDzFBcrkk9Ux0ofRXI7zYgEhDBKkd+H6F2kZJK88kpThaYQ426VUKd8egjTVye/0pYGKgOY7tu9RMpwNvKaCBkpYtsz2cRePh1+Ltt3YAi+P2ZGPNHG5dgkng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOhMtVCesN+ur8N0oWmzRRCxIH3/QbXj3Wrd5lQ7D7M=;
 b=ccy0XWIHwdx55C7icibTtE2g1HdxbICt33l5qv7URqjSRxTNMaxh8hUpj0CFb0bDa+yJX4tXcAdI68zRA64fEnCpV1UWJv4fNswmzZJVoikTYLsS51GAtj/Em4aLndaxxFZL6SEdWa25JyT1AZ1B0nszFEfjxq6UfWbuP6gAlI0=
Received: from DS7PR03CA0248.namprd03.prod.outlook.com (2603:10b6:5:3b3::13)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Mon, 22 Jan
 2024 09:24:58 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::fe) by DS7PR03CA0248.outlook.office365.com
 (2603:10b6:5:3b3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34 via Frontend
 Transport; Mon, 22 Jan 2024 09:24:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Mon, 22 Jan 2024 09:24:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:24:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:24:57 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 22 Jan 2024 03:24:52 -0600
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
Subject: [PATCH V3 01/13] ASoC/soundwire: implement generic api for scanning amd soundwire controller
Date: Mon, 22 Jan 2024 14:54:23 +0530
Message-ID: <20240122092435.3791175-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122092435.3791175-1-Vijendar.Mukunda@amd.com>
References: <20240122092435.3791175-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b101eb4-cef1-4455-b6b9-08dc1b2c00a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RX9tVpMF6yuX5/957+0a6Ey/qjvo36YyOGglkDZCAD0oaUtNdv4rImteq7uAGzwNg6Mx9YrH4Ar4AUqxMstPVI3I28D2l2RySTEOUPnPLv9AG49i4UGhYoHwAsGSj0BeDjHpFYmkz5ApyGCxQVNjchTZh+h+hOEhi0NDQ4Q/TReqUOGcniLsI1WIa3/8dPbm7L/ANmFWW+sFkJjyR7RBAtHugFZ/urX1ANCp2lgb4iszPKOtiRsyBq5NW5ur6mLQBAxbsrJcY8gjQZQLFJRbxNg60LeDBZ4iMP5gF9qsCIHwR7p+SF/SDm1jI/5MadCQZWJWNx9UvNr5D/g/cWDyPHlBwDeDhbkByZLVqM+firrTEdOxP82Wo1AzvC64wTOgUHnkSE0pkYaJxIsYi44S01HS+dU9Ds2nrNMhnSjk7X52a7sY8z52LYveP04M2zBq/chFgMxqtI7iqPJ78MtDF+UdKL+3/0xG6J0/d1XIuuUCSNlhBKqmye2gKUWVg4cIq0chiSaXGogTusGN5yFfBJJLYUr7lR4drjwKz9RzuH5CA6SyfRRbJvpe8OROcm0X2ta2uD2bR8bgVIKPMvy6vq2PLQ+6OGE8nQIgaX9aLmnP0vVEIce4FTxntGzkkEQ6UZOHghuGp2jLL74TIKAwuWw6WvNR7RX68zf5jU1JSQogv7D2Vpd30/XpFzLirXSTPp1E4uG7MXh2x7X/Ib4riAJmAbF7U0bRQJJXkoladkHu7fBqXvRyyT5wxM8d4p/viNVhH5wy3yLyDiFxMUKazTi54gqVnPpkgL5ImGhIr08=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(81166007)(356005)(82740400003)(86362001)(36756003)(316002)(110136005)(478600001)(70206006)(54906003)(7696005)(70586007)(6666004)(2906002)(8936002)(8676002)(7416002)(5660300002)(4326008)(47076005)(41300700001)(40480700001)(36860700001)(1076003)(426003)(336012)(26005)(83380400001)(40460700003)(2616005)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:24:58.2004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b101eb4-cef1-4455-b6b9-08dc1b2c00a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434

Implement generic function for scanning SoundWire controller.
Same function will be used for legacy and sof stack for AMD platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
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


