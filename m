Return-Path: <linux-kernel+bounces-49764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E59846F1C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5951C22CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA7613BE9E;
	Fri,  2 Feb 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="trE6vCiu"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E138460BA2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873908; cv=fail; b=MpxHbJwVdhopTEAPHYpuGf9QBfGGVDnD/IhovPonQVGtRe1PsTT3WtrIy/lB2NT/hwXm7SJiswfBSClaMRhbK7apdydgFv3xK3X+i8rFvrB+si7/aVcmC7Pj2Q5r7pxaq4iQkiou4UUKktffboXyvzOitXYfn+HAj0hQLckFjvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873908; c=relaxed/simple;
	bh=Fmy5iCwOcBFK9OCamKKWNCyZXIZGwlzZ8ttt0R9h86Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kXWLy/DgcUB4JTLlAkNa9aj3l7JcI7VE+Ih7e8l6HUw6OCVXSXdZmhzEUEla0hiygkxJUqso6fLRVEIM135i4xJwaZ+4OcLtNkPWViWi5F4Kya1I5QZIoOWLSkM05Bsm19h2I1ExuMsO4tYuqrtDCMwIKF+VKRXetVleWuoAN3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=trE6vCiu; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdlxXC+id7BzwpMIeqo4rtg4sa6oF3OQBDLgluGy7bISF/6pholRpRUinZ2gZ18y28pa5ikfxV6sUe1faS8fqpeoAin6BerkUROb7gtuxuT5Ikr2ggqnCdiRiLw6gR9PnlhOG8kFrV/l/DaX2+JEntpQ6+8teOn8Zxa5TzzpLWN2DJ+PknwmcwNez/F9HSR9rDwYrX7dl1kR6x53VTX6n7Ooi6yAWzc0BqbFwbnNVjI5oPb++AbJF+ZtMCfYPLnJlSpeUCO7AMQ4shIEut5I9vx39wxNfwZdQeVaE8TyzD/eNtHaf7WAJiQTnvMzGWSWzleq7aBoom1+Ezrd0peR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpIe+RY54xRiuGqFSlJQKLJV0zGvDUoxCjh3b/cVqk8=;
 b=BeqRhtPZ4Y4yyuxkC9ODNpS5DjoToNE4dzuicABFy8CxGsYuOKB7C1Gbp/Cr7egcZGPl6z3rjn9hOd1nDSMF2ujYFVS0ItgpS6B6w65DYLPKlIJb1o2dULLkLcU99zfNRN6U/r4Qg0LzEgoyQCAgJvOC6Uc1xPrE26Gqm2TDOJeG0zy2blH/4eJQ9QOO07Atl5S2NByR9EtgFTfGpj7t4tYtvaFgRya/DKCG9naazUTFUfmJMJY3qbno1t7fSoriXgpoelZsAjlMiUrPeSWcGcICd0SBigx6pgVghyrDGDr8bX+1Ks1BViv9wPCPwDF/AIpYHNvgEFoQFQlAwa9TNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpIe+RY54xRiuGqFSlJQKLJV0zGvDUoxCjh3b/cVqk8=;
 b=trE6vCiuSt59kEG2w7moi99ZF2i1dl+D1w1F0oVOmOF/dnxC0utiMBlS2R3j1fQur6NeF3YgZ71V8P8iwm3g3/UGv4pi8Y3tu5FXTNeA2LKg6bpxiMrwwxuXbVdGqWDduShrRx4fW2o8a6ysHKytv5QCPPXiOs7Gdgbuuw9A/IY=
Received: from CYZPR17CA0016.namprd17.prod.outlook.com (2603:10b6:930:8c::25)
 by BN9PR12MB5353.namprd12.prod.outlook.com (2603:10b6:408:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Fri, 2 Feb
 2024 11:38:21 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::e9) by CYZPR17CA0016.outlook.office365.com
 (2603:10b6:930:8c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29 via Frontend
 Transport; Fri, 2 Feb 2024 11:38:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 11:38:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 05:38:19 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 2 Feb 2024 05:38:16 -0600
From: Nipun Gupta <nipun.gupta@amd.com>
To: <gregkh@linuxfoundation.org>, <maz@kernel.org>, <tglx@linutronix.de>,
	<jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>
CC: <git@amd.com>, <harpreet.anand@amd.com>,
	<pieter.jansen-van-vuuren@amd.com>, <nikhil.agarwal@amd.com>,
	<michal.simek@amd.com>, <abhijit.gangurde@amd.com>, <srivatsa@csail.mit.edu>,
	Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v7] cdx: add MSI support for CDX bus
Date: Fri, 2 Feb 2024 17:08:11 +0530
Message-ID: <20240202113811.2546311-1-nipun.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|BN9PR12MB5353:EE_
X-MS-Office365-Filtering-Correlation-Id: 749116f1-d928-498a-e774-08dc23e37534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/I+hVo9rW/9iG2bf4CvYArDEFUScNy8iBNkkZ2btUh90MW1U9q1wEgyYc9B+ep43df42AQDHIPSZuMRqnGfCpGERHnAp/lbouIVz3RyewuM/aNfJ/yRdIqOY5ERqwF9Bq143das/R6RSXgJJ0v2tncykAPzMZayYEhENq8bu5zd1bcSP6aQjq+gD6QIko8eNWZqC3o9/mwwN26IvEB4Xd4WqqNutec8XPw8rLVg52x/tIiP5Y4JGQNuGi8oF5T1SxbHD6rmZFdPhM72+S7LdKeuM5Xa/DS+lzDffxYyuQbXl98OFLnRD0KDqxoeAvKzlYbqupIXYZTqy3LuVCj192DkPJvpMd4h2JZmBR1zJNWzzD17eUwXhFBPny2r0VVP2YerADW1LuUookh3nbYiHbHj/KsZqJrP0Zx01H3xPHxhp2Go0adeQZ2b+mUvwgKFYt2lidlNmvY6FeMf3OdIPdGJyMLL7vhUc84HWhdQTsYjwRmYsJgm05nKcpmgpWHe9Chi4zDuA/x8+b4gBgLrU3+V/FG0acULxi4yxK0kLghFhuW5yyqXhXhLWRqoVt9+f1C/OkFidMcCQn4jpxSGRI5/29TRCpoHfPaalBqC4syBl0kTMRG+3CaRl+tzlbecyl7RrpJm5xWHM8sKVW/p0sAVOXqIPoseKvumKGfbrkUu3lMYiwV5m0+i/kLeZJujeS4AmVLney1CLa/z9y3SMgW7Ga60neI1mAplkj3IPux9Yx3d7fPpt7CZoVXRHZaxjgS6zT+84Iv200HZTYAZSDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(26005)(40480700001)(40460700003)(426003)(336012)(2616005)(1076003)(41300700001)(36860700001)(316002)(83380400001)(47076005)(6666004)(478600001)(36756003)(81166007)(82740400003)(356005)(30864003)(54906003)(70206006)(5660300002)(110136005)(2906002)(8676002)(86362001)(4326008)(70586007)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:38:20.9467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 749116f1-d928-498a-e774-08dc23e37534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5353

Add CDX-MSI domain per CDX controller with gic-its domain as
a parent, to support MSI for CDX devices. CDX devices allocate
MSIs from the CDX domain. Also, introduce APIs to alloc and free
IRQs for CDX domain.

In CDX subsystem firmware is a controller for all devices and
their configuration. CDX bus controller sends all the write_msi_msg
commands to firmware running on RPU and the firmware interfaces with
actual devices to pass this information to devices

Since, CDX controller is the only way to communicate with the Firmware
for MSI write info, CDX domain per controller required in contrast to
having a CDX domain per device.

Changes v6->v7:
- Rebased on Linux 6.8-rc2

Changes v5->v6:
- Rebased on Linux 6.7-rc1

Changes v4->v5:
- Use GENERIC_MSI_IRQ instead of deprecated GENERIC_MSI_IRQ_DOMAIN
  config option.
- Remove CDX bus dependency on MSI support (CDX can compile without
  MSI as well).
- Remove un-necessary debug logs
- Remove un-necessay initialization of dev_id in msi_prepare
- Add required msi enable and disable APIs

Changes v3->v4:
- Rebased on Linux 6.6-rc1

Changes v2->v3:
- Rebased on Linux 6.5-rc1
- Used FW provided 'msi_dev_id' as device ID for GIC instead of 'req_id'.

Changes v1->v2:
- fixed scenario where msi write was called asynchronously in
  an atomic context, by using irq_chip_(un)lock, and using sync
  MCDI API for write MSI message.
- fixed broken Signed-off-by chain.

Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 drivers/cdx/Makefile                    |   4 +
 drivers/cdx/cdx.c                       |   9 +
 drivers/cdx/cdx.h                       |  14 +-
 drivers/cdx/cdx_msi.c                   | 217 ++++++++++++++++++++++++
 drivers/cdx/controller/Kconfig          |   1 +
 drivers/cdx/controller/cdx_controller.c |  27 +++
 drivers/cdx/controller/mc_cdx_pcol.h    |  64 +++++++
 drivers/cdx/controller/mcdi_functions.c |  33 +++-
 drivers/cdx/controller/mcdi_functions.h |  33 ++++
 include/linux/cdx/cdx_bus.h             |  76 ++++++++-
 kernel/irq/msi.c                        |   1 +
 11 files changed, 475 insertions(+), 4 deletions(-)
 create mode 100644 drivers/cdx/cdx_msi.c

diff --git a/drivers/cdx/Makefile b/drivers/cdx/Makefile
index 5d1ea482419f..749a3295c2bd 100644
--- a/drivers/cdx/Makefile
+++ b/drivers/cdx/Makefile
@@ -8,3 +8,7 @@
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CDX_BUS
 
 obj-$(CONFIG_CDX_BUS) += cdx.o controller/
+
+ifdef CONFIG_GENERIC_MSI_IRQ
+obj-$(CONFIG_CDX_BUS) += cdx_msi.o
+endif
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index b74d76afccb6..686894e28c2b 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -56,6 +56,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -787,6 +788,7 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 
 	/* Populate CDX dev params */
 	cdx_dev->req_id = dev_params->req_id;
+	cdx_dev->msi_dev_id = dev_params->msi_dev_id;
 	cdx_dev->vendor = dev_params->vendor;
 	cdx_dev->device = dev_params->device;
 	cdx_dev->subsystem_vendor = dev_params->subsys_vendor;
@@ -804,12 +806,19 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 	cdx_dev->dev.bus = &cdx_bus_type;
 	cdx_dev->dev.dma_mask = &cdx_dev->dma_mask;
 	cdx_dev->dev.release = cdx_device_release;
+	cdx_dev->msi_write_pending = false;
+	mutex_init(&cdx_dev->irqchip_lock);
 
 	/* Set Name */
 	dev_set_name(&cdx_dev->dev, "cdx-%02x:%02x",
 		     ((cdx->id << CDX_CONTROLLER_ID_SHIFT) | (cdx_dev->bus_num & CDX_BUS_NUM_MASK)),
 		     cdx_dev->dev_num);
 
+	if (cdx->msi_domain) {
+		cdx_dev->num_msi = dev_params->num_msi;
+		dev_set_msi_domain(&cdx_dev->dev, cdx->msi_domain);
+	}
+
 	ret = device_add(&cdx_dev->dev);
 	if (ret) {
 		dev_err(&cdx_dev->dev,
diff --git a/drivers/cdx/cdx.h b/drivers/cdx/cdx.h
index 300ad8be7a34..23628b07fb2d 100644
--- a/drivers/cdx/cdx.h
+++ b/drivers/cdx/cdx.h
@@ -25,6 +25,8 @@
  * @req_id: Requestor ID associated with CDX device
  * @class: Class of the CDX Device
  * @revision: Revision of the CDX device
+ * @msi_dev_id: MSI device ID associated with CDX device
+ * @num_msi: Number of MSI's supported by the device
  */
 struct cdx_dev_params {
 	struct cdx_controller *cdx;
@@ -40,6 +42,8 @@ struct cdx_dev_params {
 	u32 req_id;
 	u32 class;
 	u8 revision;
+	u32 msi_dev_id;
+	u32 num_msi;
 };
 
 /**
@@ -78,5 +82,13 @@ int cdx_device_add(struct cdx_dev_params *dev_params);
  * Return: associated Linux generic device pointer on success or NULL on failure.
  */
 struct device *cdx_bus_add(struct cdx_controller *cdx, u8 bus_num);
-
+#ifdef CONFIG_GENERIC_MSI_IRQ
+/**
+ * cdx_msi_domain_init - Init the CDX bus MSI domain.
+ * @dev: Device of the CDX bus controller
+ *
+ * Return: CDX MSI domain, NULL on failure
+ */
+struct irq_domain *cdx_msi_domain_init(struct device *dev);
+#endif
 #endif /* _CDX_H_ */
diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
new file mode 100644
index 000000000000..12d0fbd1d4cd
--- /dev/null
+++ b/drivers/cdx/cdx_msi.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD CDX bus driver MSI support
+ *
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/cdx/cdx_bus.h>
+
+#include "cdx.h"
+
+static void cdx_msi_write_msg(struct irq_data *irq_data,
+			      struct msi_msg *msg)
+{
+	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
+	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
+
+	/* We would not operate on msg here rather we wait for
+	 * irq_bus_sync_unlock() to be called from preemptible
+	 * task context.
+	 */
+	msi_desc->msg = *msg;
+	cdx_dev->msi_write_pending = true;
+}
+
+static void cdx_msi_write_irq_lock(struct irq_data *irq_data)
+{
+	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
+	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
+
+	mutex_lock(&cdx_dev->irqchip_lock);
+}
+
+static void cdx_msi_write_irq_unlock(struct irq_data *irq_data)
+{
+	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
+	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config;
+
+	if (!cdx_dev->msi_write_pending) {
+		mutex_unlock(&cdx_dev->irqchip_lock);
+		return;
+	}
+
+	cdx_dev->msi_write_pending = false;
+	mutex_unlock(&cdx_dev->irqchip_lock);
+
+	dev_config.msi.msi_index = msi_desc->msi_index;
+	dev_config.msi.data = msi_desc->msg.data;
+	dev_config.msi.addr = ((u64)(msi_desc->msg.address_hi) << 32) |
+			      msi_desc->msg.address_lo;
+
+	/*
+	 * dev_configure is a controller callback which can interact with
+	 * Firmware or other entities, and can sleep, so invoke this function
+	 * outside of the mutex lock.
+	 */
+	dev_config.type = CDX_DEV_MSI_CONF;
+	if (cdx->ops->dev_configure)
+		cdx->ops->dev_configure(cdx, cdx_dev->bus_num, cdx_dev->dev_num,
+					&dev_config);
+}
+
+int cdx_enable_msi(struct cdx_device *cdx_dev)
+{
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config;
+
+	dev_config.type = CDX_DEV_MSI_ENABLE;
+	dev_config.msi_enable = true;
+	if (cdx->ops->dev_configure)
+		return cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
+					       cdx_dev->dev_num,
+					       &dev_config);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(cdx_enable_msi);
+
+void cdx_disable_msi(struct cdx_device *cdx_dev)
+{
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config;
+
+	dev_config.type = CDX_DEV_MSI_ENABLE;
+	dev_config.msi_enable = false;
+	if (cdx->ops->dev_configure)
+		cdx->ops->dev_configure(cdx, cdx_dev->bus_num, cdx_dev->dev_num,
+					&dev_config);
+}
+EXPORT_SYMBOL_GPL(cdx_disable_msi);
+
+static struct irq_chip cdx_msi_irq_chip = {
+	.name			= "CDX-MSI",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= msi_domain_set_affinity,
+	.irq_write_msi_msg	= cdx_msi_write_msg,
+	.irq_bus_lock		= cdx_msi_write_irq_lock,
+	.irq_bus_sync_unlock	= cdx_msi_write_irq_unlock
+};
+
+int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_count)
+{
+	int ret;
+
+	ret = msi_setup_device_data(dev);
+	if (ret)
+		return ret;
+
+	ret = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN,
+					  0, irq_count - 1);
+	if (ret)
+		dev_err(dev, "Failed to allocate IRQs: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdx_msi_domain_alloc_irqs);
+
+/* Convert an msi_desc to a unique identifier within the domain. */
+static irq_hw_number_t cdx_domain_calc_hwirq(struct cdx_device *dev,
+					     struct msi_desc *desc)
+{
+	return ((irq_hw_number_t)dev->msi_dev_id << 10) | desc->msi_index;
+}
+
+static void cdx_msi_set_desc(msi_alloc_info_t *arg,
+			     struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = cdx_domain_calc_hwirq(to_cdx_device(desc->dev), desc);
+}
+
+static int cdx_msi_prepare(struct irq_domain *msi_domain,
+			   struct device *dev,
+			   int nvec, msi_alloc_info_t *info)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct device *parent = cdx_dev->cdx->dev;
+	struct msi_domain_info *msi_info;
+	u32 dev_id;
+	int ret;
+
+	/* Retrieve device ID from requestor ID using parent device */
+	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map",
+			"msi-map-mask", NULL, &dev_id);
+	if (ret) {
+		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
+		return ret;
+	}
+
+#ifdef GENERIC_MSI_DOMAIN_OPS
+	/* Set the device Id to be passed to the GIC-ITS */
+	info->scratchpad[0].ul = dev_id;
+#endif
+
+	msi_info = msi_get_domain_info(msi_domain->parent);
+
+	return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec, info);
+}
+
+static struct msi_domain_ops cdx_msi_ops = {
+	.msi_prepare	= cdx_msi_prepare,
+	.set_desc	= cdx_msi_set_desc
+};
+
+static struct msi_domain_info cdx_msi_domain_info = {
+	.ops	= &cdx_msi_ops,
+	.chip	= &cdx_msi_irq_chip,
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS
+};
+
+struct irq_domain *cdx_msi_domain_init(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct fwnode_handle *fwnode_handle;
+	struct irq_domain *cdx_msi_domain;
+	struct device_node *parent_node;
+	struct irq_domain *parent;
+
+	fwnode_handle = of_node_to_fwnode(np);
+
+	parent_node = of_parse_phandle(np, "msi-map", 1);
+	if (!parent_node) {
+		dev_err(dev, "msi-map not present on cdx controller\n");
+		return NULL;
+	}
+
+	parent = irq_find_matching_fwnode(of_node_to_fwnode(parent_node),
+					  DOMAIN_BUS_NEXUS);
+	if (!parent || !msi_get_domain_info(parent)) {
+		dev_err(dev, "unable to locate ITS domain\n");
+		return NULL;
+	}
+
+	cdx_msi_domain = msi_create_irq_domain(fwnode_handle, &cdx_msi_domain_info,
+					       parent);
+	if (!cdx_msi_domain) {
+		dev_err(dev, "unable to create CDX-MSI domain\n");
+		return NULL;
+	}
+
+	dev_dbg(dev, "CDX-MSI domain created\n");
+
+	return cdx_msi_domain;
+}
+EXPORT_SYMBOL_NS_GPL(cdx_msi_domain_init, CDX_BUS_CONTROLLER);
diff --git a/drivers/cdx/controller/Kconfig b/drivers/cdx/controller/Kconfig
index 61bf17fbe433..f8e729761aee 100644
--- a/drivers/cdx/controller/Kconfig
+++ b/drivers/cdx/controller/Kconfig
@@ -9,6 +9,7 @@ if CDX_BUS
 
 config CDX_CONTROLLER
 	tristate "CDX bus controller"
+	select GENERIC_MSI_IRQ
 	select REMOTEPROC
 	select RPMSG
 	help
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index 85fe4b1c4e5e..1a4782c5601f 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/cdx/cdx_bus.h>
+#include <linux/irqdomain.h>
 
 #include "cdx_controller.h"
 #include "../cdx.h"
@@ -60,9 +61,20 @@ static int cdx_configure_device(struct cdx_controller *cdx,
 				u8 bus_num, u8 dev_num,
 				struct cdx_device_config *dev_config)
 {
+	u16 msi_index;
 	int ret = 0;
+	u32 data;
+	u64 addr;
 
 	switch (dev_config->type) {
+	case CDX_DEV_MSI_CONF:
+		msi_index = dev_config->msi.msi_index;
+		data = dev_config->msi.data;
+		addr = dev_config->msi.addr;
+
+		ret = cdx_mcdi_write_msi(cdx->priv, bus_num, dev_num,
+					 msi_index, addr, data);
+		break;
 	case CDX_DEV_RESET_CONF:
 		ret = cdx_mcdi_reset_device(cdx->priv, bus_num, dev_num);
 		break;
@@ -70,6 +82,10 @@ static int cdx_configure_device(struct cdx_controller *cdx,
 		ret = cdx_mcdi_bus_master_enable(cdx->priv, bus_num, dev_num,
 						 dev_config->bus_master_enable);
 		break;
+	case CDX_DEV_MSI_ENABLE:
+		ret = cdx_mcdi_msi_enable(cdx->priv, bus_num, dev_num,
+					  dev_config->msi_enable);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -178,6 +194,14 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
 	cdx->priv = cdx_mcdi;
 	cdx->ops = &cdx_ops;
 
+	/* Create MSI domain */
+	cdx->msi_domain = cdx_msi_domain_init(&pdev->dev);
+	if (!cdx->msi_domain) {
+		dev_err(&pdev->dev, "cdx_msi_domain_init() failed");
+		ret = -ENODEV;
+		goto cdx_msi_fail;
+	}
+
 	ret = cdx_setup_rpmsg(pdev);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
@@ -189,6 +213,8 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
 	return 0;
 
 cdx_rpmsg_fail:
+	irq_domain_remove(cdx->msi_domain);
+cdx_msi_fail:
 	kfree(cdx);
 cdx_alloc_fail:
 	cdx_mcdi_finish(cdx_mcdi);
@@ -205,6 +231,7 @@ static int xlnx_cdx_remove(struct platform_device *pdev)
 
 	cdx_destroy_rpmsg(pdev);
 
+	irq_domain_remove(cdx->msi_domain);
 	kfree(cdx);
 
 	cdx_mcdi_finish(cdx_mcdi);
diff --git a/drivers/cdx/controller/mc_cdx_pcol.h b/drivers/cdx/controller/mc_cdx_pcol.h
index 2de019406b57..832a44af963e 100644
--- a/drivers/cdx/controller/mc_cdx_pcol.h
+++ b/drivers/cdx/controller/mc_cdx_pcol.h
@@ -455,6 +455,12 @@
 #define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID_OFST			84
 #define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID_LEN			4
 
+/* MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_V2 msgresponse */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_V2_LEN				92
+/* Requester ID used by device for GIC ITS DeviceID */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_V2_REQUESTER_DEVICE_ID_OFST	88
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_V2_REQUESTER_DEVICE_ID_LEN		4
+
 /***********************************/
 /*
  * MC_CMD_CDX_BUS_DOWN
@@ -616,6 +622,64 @@
 #define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_MMIO_REGIONS_ENABLE_LBN	2
 #define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_MMIO_REGIONS_ENABLE_WIDTH	1
 
+/***********************************/
+/*
+ * MC_CMD_CDX_DEVICE_WRITE_MSI_MSG
+ * Populates the MSI message to be used by the hardware to raise the specified
+ * interrupt vector. Versal-net implementation specific limitations are that
+ * only 4 CDX devices with MSI interrupt capability are supported and all
+ * vectors within a device must use the same write address. The command will
+ * return EINVAL if any of these limitations is violated.
+ */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG					0x9
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_MSGSET				0x9
+#undef MC_CMD_0x9_PRIVILEGE_CTG
+
+#define MC_CMD_0x9_PRIVILEGE_CTG SRIOV_CTG_ADMIN
+
+/* MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN msgrequest */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_LEN				28
+/* Device bus number, in range 0 to BUS_COUNT-1 */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_BUS_OFST			0
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_BUS_LEN			4
+/* Device number relative to the bus, in range 0 to DEVICE_COUNT-1 for that bus */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_DEVICE_OFST			4
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_DEVICE_LEN			4
+/*
+ * Device-relative MSI vector number. Must be < MSI_COUNT reported for the
+ * device.
+ */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_VECTOR_OFST		8
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_VECTOR_LEN		4
+/* Reserved (alignment) */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_RESERVED_OFST		12
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_RESERVED_LEN			4
+/*
+ * MSI address to be used by the hardware. Typically, on ARM systems this
+ * address is translated by the IOMMU (if enabled) and it is the responsibility
+ * of the entity managing the IOMMU (APU kernel) to supply the correct IOVA
+ * here.
+ */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_OFST		16
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LEN		8
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LO_OFST		16
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LO_LEN		4
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LO_LBN		128
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LO_WIDTH		32
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_HI_OFST		20
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_HI_LEN		4
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_HI_LBN		160
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_HI_WIDTH		32
+/*
+ * MSI data to be used by the hardware. On versal-net, only the lower 16-bits
+ * are used, the remaining bits are ignored and should be set to zero.
+ */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_DATA_OFST		24
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_DATA_LEN			4
+
+/* MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_OUT msgresponse */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_OUT_LEN				0
+
 /***********************************/
 /* MC_CMD_V2_EXTN - Encapsulation for a v2 extended command */
 #define MC_CMD_V2_EXTN					0x7f
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
index b1f530946389..885c69e6ebe5 100644
--- a/drivers/cdx/controller/mcdi_functions.c
+++ b/drivers/cdx/controller/mcdi_functions.c
@@ -49,7 +49,7 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 			    u8 bus_num, u8 dev_num,
 			    struct cdx_dev_params *dev_params)
 {
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_LEN);
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_V2_LEN);
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_IN_LEN);
 	struct resource *res = &dev_params->res[0];
 	size_t outlen;
@@ -64,7 +64,7 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 	if (ret)
 		return ret;
 
-	if (outlen != MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_LEN)
+	if (outlen != MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_V2_LEN)
 		return -EIO;
 
 	dev_params->bus_num = bus_num;
@@ -73,6 +73,9 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 	req_id = MCDI_DWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID);
 	dev_params->req_id = req_id;
 
+	dev_params->msi_dev_id = MCDI_DWORD(outbuf,
+					    CDX_BUS_GET_DEVICE_CONFIG_OUT_V2_REQUESTER_DEVICE_ID);
+
 	dev_params->res_count = 0;
 	if (MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE) != 0) {
 		res[dev_params->res_count].start =
@@ -127,6 +130,7 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 	dev_params->class = MCDI_DWORD(outbuf,
 				       CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_CLASS) & 0xFFFFFF;
 	dev_params->revision = MCDI_BYTE(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_REVISION);
+	dev_params->num_msi = MCDI_DWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MSI_COUNT);
 
 	return 0;
 }
@@ -155,6 +159,24 @@ int cdx_mcdi_bus_disable(struct cdx_mcdi *cdx, u8 bus_num)
 	return ret;
 }
 
+int cdx_mcdi_write_msi(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num,
+		       u32 msi_vector, u64 msi_address, u32 msi_data)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_LEN);
+	int ret;
+
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_BUS, bus_num);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_DEVICE, dev_num);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_VECTOR, msi_vector);
+	MCDI_SET_QWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS, msi_address);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_DATA, msi_data);
+
+	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_DEVICE_WRITE_MSI_MSG, inbuf, sizeof(inbuf),
+			   NULL, 0, NULL);
+
+	return ret;
+}
+
 int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_RESET_IN_LEN);
@@ -226,3 +248,10 @@ int cdx_mcdi_bus_master_enable(struct cdx_mcdi *cdx, u8 bus_num,
 	return cdx_mcdi_ctrl_flag_set(cdx, bus_num, dev_num, enable,
 			MC_CMD_CDX_DEVICE_CONTROL_SET_IN_BUS_MASTER_ENABLE_LBN);
 }
+
+int cdx_mcdi_msi_enable(struct cdx_mcdi *cdx, u8 bus_num,
+			u8 dev_num, bool enable)
+{
+	return cdx_mcdi_ctrl_flag_set(cdx, bus_num, dev_num, enable,
+			MC_CMD_CDX_DEVICE_CONTROL_SET_IN_MSI_ENABLE_LBN);
+}
diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
index 258a5462fbe3..b9942affdc6b 100644
--- a/drivers/cdx/controller/mcdi_functions.h
+++ b/drivers/cdx/controller/mcdi_functions.h
@@ -65,6 +65,26 @@ int cdx_mcdi_bus_enable(struct cdx_mcdi *cdx, u8 bus_num);
  */
 int cdx_mcdi_bus_disable(struct cdx_mcdi *cdx, u8 bus_num);
 
+/**
+ * cdx_mcdi_write_msi - Write MSI configuration for CDX device
+ * @cdx: pointer to MCDI interface.
+ * @bus_num: Bus number.
+ * @dev_num: Device number.
+ * @msi_vector: Device-relative MSI vector number.
+ *	Must be < MSI_COUNT reported for the device.
+ * @msi_address: MSI address to be used by the hardware. Typically, on ARM
+ *	systems this address is translated by the IOMMU (if enabled) and
+ *	it is the responsibility of the entity managing the IOMMU (APU kernel)
+ *	to supply the correct IOVA here.
+ * @msi_data: MSI data to be used by the hardware. On versal-net, only the
+ *	lower 16-bits are used, the remaining bits are ignored and should be
+ *	set to zero.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int cdx_mcdi_write_msi(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num,
+		       u32 msi_vector, u64 msi_address, u32 msi_data);
+
 /**
  * cdx_mcdi_reset_device - Reset cdx device represented by bus_num:dev_num
  * @cdx: pointer to MCDI interface.
@@ -89,4 +109,17 @@ int cdx_mcdi_reset_device(struct cdx_mcdi *cdx,
 int cdx_mcdi_bus_master_enable(struct cdx_mcdi *cdx, u8 bus_num,
 			       u8 dev_num, bool enable);
 
+/**
+ * cdx_mcdi_msi_enable - Enable/Disable MSIs for cdx device represented
+ *			 by bus_num:dev_num
+ * @cdx: pointer to MCDI interface.
+ * @bus_num: Bus number.
+ * @dev_num: Device number.
+ * @enable: Enable msi's if set, disable otherwise.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int cdx_mcdi_msi_enable(struct cdx_mcdi *cdx, u8 bus_num,
+			u8 dev_num, bool enable);
+
 #endif /* CDX_MCDI_FUNCTIONS_H */
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index 6355a36a3f81..681fd4d644ab 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 
 #define MAX_CDX_DEV_RESOURCES	4
 #define CDX_CONTROLLER_ID_SHIFT 4
@@ -21,13 +22,25 @@
 struct cdx_controller;
 
 enum {
+	CDX_DEV_MSI_CONF,
 	CDX_DEV_BUS_MASTER_CONF,
 	CDX_DEV_RESET_CONF,
+	CDX_DEV_MSI_ENABLE,
+};
+
+struct cdx_msi_config {
+	u64 addr;
+	u32 data;
+	u16 msi_index;
 };
 
 struct cdx_device_config {
 	u8 type;
-	bool bus_master_enable;
+	union {
+		struct cdx_msi_config msi;
+		bool bus_master_enable;
+		bool msi_enable;
+	};
 };
 
 typedef int (*cdx_bus_enable_cb)(struct cdx_controller *cdx, u8 bus_num);
@@ -87,6 +100,7 @@ struct cdx_ops {
  * struct cdx_controller: CDX controller object
  * @dev: Linux device associated with the CDX controller.
  * @priv: private data
+ * @msi_domain: MSI domain
  * @id: Controller ID
  * @controller_registered: controller registered with bus
  * @ops: CDX controller ops
@@ -94,6 +108,7 @@ struct cdx_ops {
 struct cdx_controller {
 	struct device *dev;
 	void *priv;
+	struct irq_domain *msi_domain;
 	u32 id;
 	bool controller_registered;
 	struct cdx_ops *ops;
@@ -120,9 +135,13 @@ struct cdx_controller {
  * @req_id: Requestor ID associated with CDX device
  * @is_bus: Is this bus device
  * @enabled: is this bus enabled
+ * @msi_dev_id: MSI Device ID associated with CDX device
+ * @num_msi: Number of MSI's supported by the device
  * @driver_override: driver name to force a match; do not set directly,
  *                   because core frees it; use driver_set_override() to
  *                   set or clear it.
+ * @irqchip_lock: lock to synchronize irq/msi configuration
+ * @msi_write_pending: MSI write pending for this device
  */
 struct cdx_device {
 	struct device dev;
@@ -144,7 +163,11 @@ struct cdx_device {
 	u32 req_id;
 	bool is_bus;
 	bool enabled;
+	u32 msi_dev_id;
+	u32 num_msi;
 	const char *driver_override;
+	struct mutex irqchip_lock; /* Serialize write msi configuration */
+	bool msi_write_pending;
 };
 
 #define to_cdx_device(_dev) \
@@ -237,4 +260,55 @@ int cdx_set_master(struct cdx_device *cdx_dev);
  */
 int cdx_clear_master(struct cdx_device *cdx_dev);
 
+#ifdef CONFIG_GENERIC_MSI_IRQ
+/**
+ * cdx_msi_domain_alloc_irqs - Allocate MSI's for the CDX device
+ * @dev: device pointer
+ * @irq_count: Number of MSI's to be allocated
+ *
+ * Return: 0 for success, -errno on failure
+ */
+int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_count);
+
+/**
+ * cdx_msi_domain_free_irqs - Free MSI's for CDX device
+ */
+#define cdx_msi_domain_free_irqs msi_domain_free_irqs_all
+
+/**
+ * cdx_enable_msi - Enable MSI for the CDX device.
+ * @cdx_dev: device pointer
+ *
+ * Return: 0 for success, -errno on failure
+ */
+int cdx_enable_msi(struct cdx_device *cdx_dev);
+
+/**
+ * cdx_disable_msi - Disable MSI for the CDX device.
+ * @cdx_dev: device pointer
+ */
+void cdx_disable_msi(struct cdx_device *cdx_dev);
+
+#else /* CONFIG_GENERIC_MSI_IRQ */
+
+static inline int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_count)
+{
+	return -ENODEV;
+}
+
+static inline void cdx_msi_domain_free_irqs(struct device *dev, unsigned int domid)
+{
+}
+
+static inline int cdx_enable_msi(struct cdx_device *cdx_dev)
+{
+	return -ENODEV;
+}
+
+static inline void cdx_disable_msi(struct cdx_device *cdx_dev)
+{
+}
+
+#endif /* CONFIG_GENERIC_MSI_IRQ */
+
 #endif /* _CDX_BUS_H_ */
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 79b4a58ba9c3..90b78abcb4c1 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1627,6 +1627,7 @@ void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
 	msi_domain_free_irqs_all_locked(dev, domid);
 	msi_unlock_descs(dev);
 }
+EXPORT_SYMBOL_GPL(msi_domain_free_irqs_all);
 
 /**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
-- 
2.34.1


