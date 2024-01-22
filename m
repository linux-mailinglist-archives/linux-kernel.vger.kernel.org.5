Return-Path: <linux-kernel+bounces-32621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B28835E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919742814A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF039ACD;
	Mon, 22 Jan 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QMaZS1gH"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60AD39861
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915532; cv=fail; b=GzJT9Ua9uOtRbBaUs7hCZmZtB6UEPWQPGYVFsyEAnBzBBgdRvspYvfg4PiRBKT74sK37hVPPRvPL2xaDuRzAOtA7WUGm0BdolbYw15II3fWPN894SOmln+11SO0JJ8YNO3FRkzJGklKPq5wbfY7K0gd6f1PEXc8ahs/6d8bu6JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915532; c=relaxed/simple;
	bh=I48p3FJYrdqBq+qB7J9cth7qpgrcQCD76Ylex+9CBRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkRu9Co/UbUxhdukqoYI5o6knNvN3Y7rRPei8XRfJhvVkyaUR9VXp957EiXIzPqs/RUePMpg/W4tk6UH7FkPWIw49xuL1qr0og8bjXf4+R3G4ye3S8+x6SKHUl3FtA6J9CvzxzLxNX+i4aeZDrQTmO8VLCTX+JINxgoyVCw8jD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QMaZS1gH; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU6aYVBYQdBVQvgZrhmYIyKkMf3NRxi5XlKHsOITLtXIkMyagU8uSWc+YqX+CN73zgVEjbzYItXAeP5PBN2JWDa5YagutR+fSwuu/ubH4rfPanYB/4NQmzmu983sopy/qQLcPTEBO36dcU44s/B0AjB8XbOwxNNN9phmaTmNz0vvj95bpELkXoKBSRwHIFpfmxwUwDOQSE0wTvlFcTOQTAmE6pyZUUTKjY+l2kYOUpRCRo3PTjBoQNLr1qinnViSxGZEDrR5bMqrFc16DRkPSfgtAgy0npxGYq8SSMJh64TNqJ90JA4xJKqiKsSOYW+2HZwUK6ka3wxlD8VMR6nyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3rsuiLG/ffVyByi+S/ebYQm2FWLXFkmTlfmDuiOlks=;
 b=k68Gzw+W5km37pdDZEVUJ/DzQaya4tkx7N4ErpDw9AUZUKcE9Cw2Oh0DKK0QcL8eEaHhDR9tP/O6q4ARGJbcw6HZf8ytXPNNtgUkHAoNMUIpHTq2WI65OzVoGusUJxyYAP30mdl+smulX3zNYO2bUuColSs8qUqx/ZMbWBhHaMJ/yCc9JBnCSwMnxnAj3bkjr1mo8+vkL+GCLkVlGS20EhZZ0aQzqFtGQ7sXE/iSQrPPc8rct+RHfDT8JUkfhQAUGUrrrkrFNDh4cQrBhQhg1HnhwNjiIbuoJ2ViXT1WA+y9cIeMwlnIxLxiynBanmQlrdOr+luId/ggkPuWWRHVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3rsuiLG/ffVyByi+S/ebYQm2FWLXFkmTlfmDuiOlks=;
 b=QMaZS1gHF1uoxTEb/H90Sx9e/wVmpsrMswfGNgLF6Umo1RhllYUTCN9hi1f7h+Lv54XG7k0FTODneGJ0U+LxDioMNuuQhF2+tohS7FJwB2haRcO+kA2OyAPFa5kAP8xJPK4tjAxszCBm+wNH3qqwr+KeDHAygDsPPRQocZNRxwk=
Received: from DS7PR03CA0253.namprd03.prod.outlook.com (2603:10b6:5:3b3::18)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 09:25:28 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::5b) by DS7PR03CA0253.outlook.office365.com
 (2603:10b6:5:3b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 09:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Mon, 22 Jan 2024 09:25:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:25:18 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:25:07 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 22 Jan 2024 03:25:04 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 03/13] soundwire: amd: refactor amd soundwire manager device node creation
Date: Mon, 22 Jan 2024 14:54:25 +0530
Message-ID: <20240122092435.3791175-4-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a690c4-ca42-4303-88cc-08dc1b2c124d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eZjORHLe1mM/dBckF9VVAhO1BIapO/XzoCkeYU2dvowxQxPvN6Vz5Eh/LXON0srY/q7c49Oex8308HnqBWVRzTmComMts2cPR/LwMiW2bkh8njBRZsZXFxCZfWNU+JvSXMQyoQBsWQCHHVIvYv68RgnGO6r3KOhUgUgJXA7FjbjvU6iim04/edOZwlYedO/igmqZsf+qgykwND8G3aM5jK/2Qc03kQsiMMXsirlHVWraZM1i0SnJkwXgJmS7+GvKBPfenfMXNu7kjxdbChzJgpqj9GeWxk8YaPBEIBXQYrlaTD3QABY+hqNKAtBIusdZPVXiPwY54dPHOhjgXiB8x+OGDw4QppJ7BADPby5UKKelx5r4LfFfESGpnEIWVVlI/tT+GRckWbfPF1UJYxEmlX7RqfK0hr+5bEgs+hpPwR/JmXS/k8LGd9xV/KXnLOucYcdLk1i11Ich5cqETwZ8/zR6gU5HCxWwfpmwjb+4wdDNEiyiqW53XY5g/Azdbjd7B5qsbc8zkxboR+zFrSlMHbIloRgwS8AKTYkuCjlSvNAzpJ9YS9Ajbmffs8V1ToPnpQ3GfgVqCQct0g30b8wA7SOgP0wud72RMs7udf+IN33soP22Q6/3uVhEkulgOtf+1lqy4eFFQcaO4ZvhUvU5Sjsoggx/tbZV4tTQLLvnSe/21ivsl+zxpS1TaHxC3shnibPsrqJrOeB12D5jKAWzHKuJsitMAmzswwYG5yTMzpm6x9nSAdeTWzx2ZuFRPQRlT0hpMubM7W3WO+BPvS8kEQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(356005)(26005)(1076003)(426003)(7696005)(336012)(6666004)(2616005)(36860700001)(83380400001)(5660300002)(2906002)(47076005)(30864003)(8936002)(8676002)(70586007)(54906003)(478600001)(316002)(70206006)(4326008)(110136005)(41300700001)(81166007)(86362001)(82740400003)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:25:27.8256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a690c4-ca42-4303-88cc-08dc1b2c124d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911

Refactor amd SoundWire manager device node creation logic and implement
generic functions to have a common functionality for SoundWire manager
platform device creation, start and exit sequence for both legacy(NO DSP)
and SOF stack for AMD platforms. These functions will be invoked from
legacy and SOF stack.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/Makefile        |   2 +-
 drivers/soundwire/amd_init.c      | 147 ++++++++++++++++++++++++++++++
 drivers/soundwire/amd_init.h      |  13 +++
 drivers/soundwire/amd_manager.c   |  16 +---
 include/linux/soundwire/sdw_amd.h |  54 ++++++++++-
 5 files changed, 218 insertions(+), 14 deletions(-)
 create mode 100644 drivers/soundwire/amd_init.c
 create mode 100644 drivers/soundwire/amd_init.h

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 657f5888a77b..e80a2c2cf3e7 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -20,7 +20,7 @@ soundwire-bus-y += irq.o
 endif
 
 #AMD driver
-soundwire-amd-y :=	amd_manager.o
+soundwire-amd-y := amd_init.o amd_manager.o
 obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o
 
 #Cadence Objs
diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
new file mode 100644
index 000000000000..d732ab0bfd59
--- /dev/null
+++ b/drivers/soundwire/amd_init.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * SoundWire AMD Manager Initialize routines
+ *
+ * Initializes and creates SDW devices based on ACPI and Hardware values
+ *
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/acpi.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "amd_init.h"
+
+static int sdw_amd_cleanup(struct sdw_amd_ctx *ctx)
+{
+	int i;
+
+	for (i = 0; i < ctx->count; i++) {
+		if (!(ctx->link_mask & BIT(i)))
+			continue;
+		platform_device_unregister(ctx->pdev[i]);
+	}
+
+	return 0;
+}
+
+static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
+{
+	struct sdw_amd_ctx *ctx;
+	struct acpi_device *adev;
+	struct resource *sdw_res;
+	struct acp_sdw_pdata sdw_pdata[2];
+	struct platform_device_info pdevinfo[2];
+	u32 link_mask;
+	int count, index;
+
+	if (!res)
+		return NULL;
+
+	adev = acpi_fetch_acpi_dev(res->handle);
+	if (!adev)
+		return NULL;
+
+	if (!res->count)
+		return NULL;
+
+	count = res->count;
+	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
+
+	/*
+	 * we need to alloc/free memory manually and can't use devm:
+	 * this routine may be called from a workqueue, and not from
+	 * the parent .probe.
+	 * If devm_ was used, the memory might never be freed on errors.
+	 */
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->count = count;
+	ctx->link_mask = res->link_mask;
+	sdw_res = kzalloc(sizeof(*sdw_res), GFP_KERNEL);
+	if (!sdw_res) {
+		kfree(ctx);
+		return NULL;
+	}
+	sdw_res->flags = IORESOURCE_MEM;
+	sdw_res->start = res->addr;
+	sdw_res->end = res->addr + res->reg_range;
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+	link_mask = ctx->link_mask;
+	for (index = 0; index < count; index++) {
+		if (!(link_mask & BIT(index)))
+			continue;
+
+		sdw_pdata[index].instance = index;
+		sdw_pdata[index].acp_sdw_lock = res->acp_lock;
+		pdevinfo[index].name = "amd_sdw_manager";
+		pdevinfo[index].id = index;
+		pdevinfo[index].parent = res->parent;
+		pdevinfo[index].num_res = 1;
+		pdevinfo[index].res = sdw_res;
+		pdevinfo[index].data = &sdw_pdata[index];
+		pdevinfo[index].size_data = sizeof(struct acp_sdw_pdata);
+		pdevinfo[index].fwnode = acpi_fwnode_handle(adev);
+		ctx->pdev[index] = platform_device_register_full(&pdevinfo[index]);
+		if (IS_ERR(ctx->pdev[index]))
+			goto err;
+	}
+	kfree(sdw_res);
+	return ctx;
+err:
+	while (index--) {
+		if (!(link_mask & BIT(index)))
+			continue;
+
+		platform_device_unregister(ctx->pdev[index]);
+	}
+
+	kfree(sdw_res);
+	kfree(ctx);
+	return NULL;
+}
+
+static int sdw_amd_startup(struct sdw_amd_ctx *ctx)
+{
+	struct amd_sdw_manager *amd_manager;
+	int i, ret;
+
+	/* Startup SDW Manager devices */
+	for (i = 0; i < ctx->count; i++) {
+		if (!(ctx->link_mask & BIT(i)))
+			continue;
+		amd_manager = dev_get_drvdata(&ctx->pdev[i]->dev);
+		ret = amd_sdw_manager_start(amd_manager);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **sdw_ctx)
+{
+	*sdw_ctx = sdw_amd_probe_controller(res);
+	if (!*sdw_ctx)
+		return -ENODEV;
+
+	return sdw_amd_startup(*sdw_ctx);
+}
+EXPORT_SYMBOL_NS(sdw_amd_probe, SOUNDWIRE_AMD_INIT);
+
+void sdw_amd_exit(struct sdw_amd_ctx *ctx)
+{
+	sdw_amd_cleanup(ctx);
+	kfree(ctx->ids);
+	kfree(ctx);
+}
+EXPORT_SYMBOL_NS(sdw_amd_exit, SOUNDWIRE_AMD_INIT);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD SoundWire Init Library");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/soundwire/amd_init.h b/drivers/soundwire/amd_init.h
new file mode 100644
index 000000000000..f710703ffae9
--- /dev/null
+++ b/drivers/soundwire/amd_init.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __AMD_INIT_H
+#define __AMD_INIT_H
+
+#include <linux/soundwire/sdw_amd.h>
+
+int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager);
+
+#endif
diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index afa2d83b7e69..0fcf8f8545b1 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -19,6 +19,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "bus.h"
+#include "amd_init.h"
 #include "amd_manager.h"
 
 #define DRV_NAME "amd_sdw_manager"
@@ -864,10 +865,8 @@ static void amd_sdw_irq_thread(struct work_struct *work)
 	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
 }
 
-static void amd_sdw_probe_work(struct work_struct *work)
+int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
 {
-	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
-							   probe_work);
 	struct sdw_master_prop *prop;
 	int ret;
 
@@ -876,11 +875,11 @@ static void amd_sdw_probe_work(struct work_struct *work)
 		amd_enable_sdw_pads(amd_manager);
 		ret = amd_init_sdw_manager(amd_manager);
 		if (ret)
-			return;
+			return ret;
 		amd_enable_sdw_interrupts(amd_manager);
 		ret = amd_enable_sdw_manager(amd_manager);
 		if (ret)
-			return;
+			return ret;
 		amd_sdw_set_frameshape(amd_manager);
 	}
 	/* Enable runtime PM */
@@ -889,6 +888,7 @@ static void amd_sdw_probe_work(struct work_struct *work)
 	pm_runtime_mark_last_busy(amd_manager->dev);
 	pm_runtime_set_active(amd_manager->dev);
 	pm_runtime_enable(amd_manager->dev);
+	return 0;
 }
 
 static int amd_sdw_manager_probe(struct platform_device *pdev)
@@ -964,11 +964,6 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, amd_manager);
 	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
 	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
-	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
-	/*
-	 * Instead of having lengthy probe sequence, use deferred probe.
-	 */
-	schedule_work(&amd_manager->probe_work);
 	return 0;
 }
 
@@ -978,7 +973,6 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
 	int ret;
 
 	pm_runtime_disable(&pdev->dev);
-	cancel_work_sync(&amd_manager->probe_work);
 	amd_disable_sdw_interrupts(amd_manager);
 	sdw_bus_master_delete(&amd_manager->bus);
 	ret = amd_disable_sdw_manager(amd_manager);
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 56b4117c087a..1e5ff4c46365 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -26,6 +26,7 @@
 #define AMD_SDW_POWER_OFF_MODE		2
 #define ACP_SDW0	0
 #define ACP_SDW1	1
+#define AMD_SDW_MAX_MANAGER_COUNT	2
 
 struct acp_sdw_pdata {
 	u16 instance;
@@ -63,7 +64,6 @@ struct sdw_amd_dai_runtime {
  * @reg_mask: register mask structure per manager instance
  * @amd_sdw_irq_thread: SoundWire manager irq workqueue
  * @amd_sdw_work: peripheral status work queue
- * @probe_work: SoundWire manager probe workqueue
  * @acp_sdw_lock: mutex to protect acp share register access
  * @status: peripheral devices status array
  * @num_din_ports: number of input ports
@@ -87,7 +87,6 @@ struct amd_sdw_manager {
 	struct sdw_manager_reg_mask *reg_mask;
 	struct work_struct amd_sdw_irq_thread;
 	struct work_struct amd_sdw_work;
-	struct work_struct probe_work;
 	/* mutex to protect acp common register access */
 	struct mutex *acp_sdw_lock;
 
@@ -120,5 +119,56 @@ struct sdw_amd_acpi_info {
 	u32 link_mask;
 };
 
+/**
+ * struct sdw_amd_ctx - context allocated by the controller
+ * driver probe
+ * @count: link count
+ * @num_slaves: total number of devices exposed across all enabled links
+ * @link_mask: bit-wise mask listing SoundWire links reported by the
+ * Controller
+ * @ids: array of slave_id, representing Slaves exposed across all enabled
+ * links
+ * @pdev: platform device structure
+ */
+struct sdw_amd_ctx {
+	int count;
+	int num_slaves;
+	u32 link_mask;
+	struct sdw_extended_slave_id *ids;
+	struct platform_device *pdev[AMD_SDW_MAX_MANAGER_COUNT];
+};
+
+/**
+ * struct sdw_amd_res - Soundwire AMD global resource structure,
+ * typically populated by the DSP driver/Legacy driver
+ *
+ * @addr: acp pci device resource start address
+ * @reg_range: ACP register range
+ * @link_mask: bit-wise mask listing links selected by the DSP driver/
+ * legacy driver
+ * @count: link count
+ * @mmio_base: mmio base of SoundWire registers
+ * @handle: ACPI parent handle
+ * @parent: parent device
+ * @dev: device implementing hwparams and free callbacks
+ * @acp_lock: mutex protecting acp common registers access
+ */
+struct sdw_amd_res {
+	u32 addr;
+	u32 reg_range;
+	u32 link_mask;
+	int count;
+	void __iomem *mmio_base;
+	acpi_handle handle;
+	struct device *parent;
+	struct device *dev;
+	/* use to protect acp common registers access */
+	struct mutex *acp_lock;
+};
+
+int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **ctx);
+
+void sdw_amd_exit(struct sdw_amd_ctx *ctx);
+
 int amd_sdw_scan_controller(struct sdw_amd_acpi_info *info);
 #endif
-- 
2.34.1


