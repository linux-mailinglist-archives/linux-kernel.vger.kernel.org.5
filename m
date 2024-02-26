Return-Path: <linux-kernel+bounces-80841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6FD866D31
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AE7283FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EF1762F8;
	Mon, 26 Feb 2024 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RxKK/yhs"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CBA6A32A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936119; cv=fail; b=A961Cgl/eFU6va5On5nTBMZp4Jb8M7/BP02Q2B5ECDtWO5xVC3J7zttfyMQcjV6zk3prNz/Q5PcMTEoncniW4xtlEYWczvUX4VB3gFrTGb+UebCSbJokEC9FrC8xcPZw/uGmg8Ulizmv2rlgVHEjLGxKgdHeY1coyMMqvHa3GGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936119; c=relaxed/simple;
	bh=fFVfdTp6ZkVKRH5PS1P8k/3X2kQPkAZRsVf2zqLNNlk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AR5tKfte4qXk6iR7miJ9bO7DGuQnxbQWWOOK3rGXpDsO0JusnU9do+acUYUwn1aQI56KzctbX9+cPbxnEpz+Ss8naGBmV9UNAalTubRwQFp2My9mlRAWYvKBFxhYRVCqEUgyLKmAOfQbsTN9xgqloTgXMOlix1I/4YIk0FvR7XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RxKK/yhs; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCq2V57HvsoptCmV7D4Yb9+WwQ4TUq2uPtJuzPmmfwc/F5rYfT0vCwN5AwPuI96ZFlfCcvpModVJxeH7U/7B2XwgoaSZAKIKuPzC8pizZdRmcaR3xi8Rt4IfP17QAAmFVJXZRgKEx4G7Q8piHCtigKfVyxO7f835gj3X2u5VtyDapNd7F1JghQh4Xa9gRyMYWkdoCdtBdpJqfyI2ZjOrYx9gkeiquwVeczWlO2Vac5QKw8lUOEpWVuzGCkg3sqEFXelXh8QNmZ/BaXloyCNBK8x9Ye3otCZV+yqz1KOcmn5DirOrpy1VcO7JT5aJQV+DWzkSUH/BMhBlVo55rMzGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEGdc56VXQ/EXJmgRCRnk703IS1yD6WtApAbGG+2fk8=;
 b=T0AgzXQWI54QPG1e29cYq8BO2kbIVz5s5xO7omsHggCGkJmgYSZIre+ymn6k5MnSjqs8TodkZeb7iGq5zR1EMAPESb4j+3u3a3P7gy3UINo++U5LJMTIGzG16+blK0NfQvURp3JusdZ7OZmwjvG6QeJHH5EwVLfRfQ2lZ+Wr4kIt0eQnCcWsKEh4rHDbWIXG2rEdr32/VtKmvH7Awo2hidcnktCcyIY8IX1sBpZo9f6W6lUSMAaKl+7ZX2H8gUH+ir3KUKOOc5+M4KmeRDaEzJ19IJXqXJ5etvFu2gggyF++2wAdK5rM+Hod6gfbMX+d6lfWcCnNHXD86C/h5tXwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEGdc56VXQ/EXJmgRCRnk703IS1yD6WtApAbGG+2fk8=;
 b=RxKK/yhsNy/ZfmXq8pNrM87/DNiHGHc5zJZbHh76wZg0BkbRqqY4yMlx9b1UW9FCepDXes4YloqQf11MlEk4Qh4NCftN/VnomSjx7E9eWNw+oID2PB4+AKyVwqDkNSL/lMNvGo0EIEbY40c/W21xAVMtPw6i2kWkdVVA/3Sjc0g=
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 08:28:32 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::da) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 08:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 08:28:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 02:28:30 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 02:28:29 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 02:28:25 -0600
From: Nipun Gupta <nipun.gupta@amd.com>
To: <gregkh@linuxfoundation.org>, <maz@kernel.org>, <tglx@linutronix.de>,
	<jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>
CC: <git@amd.com>, <harpreet.anand@amd.com>,
	<pieter.jansen-van-vuuren@amd.com>, <nikhil.agarwal@amd.com>,
	<michal.simek@amd.com>, <abhijit.gangurde@amd.com>, <srivatsa@csail.mit.edu>,
	Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v9] cdx: add MSI support for CDX bus
Date: Mon, 26 Feb 2024 13:58:16 +0530
Message-ID: <20240226082816.100872-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: nipun.gupta@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d345ae-3d31-455f-904d-08dc36a4eabf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hgHevDENanctlyCwIs2lsM+7WPBeFznFzcEx9LeXyFazKSPG7vZhd5IJO4eIN7UaXojMzufadX6T02Rla9KybRamtYND1i5rHxG0LXxy7GabUz3Uoj6tf0QtKF2ZUU2lpWMGcmWEOeHKUwFzQrL3zofUIzuAkEZDLx6VrD41yf5S66qQwAuO328OnwWiZ1l/+QItvnu06m+ptdBUu/uKnDjDPvbzpYxhrPcaegATSsrV5mZSK/lZCzqDfpAA/+tnKjUo68ng0yuoRmWxzIb5Ppe2SfyDQmCX7tFJc/64TxMeiXBaY1qMJNpn808W3UmE+DZA4MgI/lFX1nTGYrovtR51zwUh/WLm0Kkk+OtTynMoCSjuqpnzQdsxA7kQjVOww0zxSzaynxtAN7mfFiS/FpR12GqCJous7e9zNMo61Bt4eq+oL/CPHl8ZrNCAHil3RUDrxx8YJURGlIXrxUuwY5j8QLQERIKCqo+h3taLOSWfOJoHxmRFDoXQThT4GXeXBFFIVJt3NZsYRP5JlsPFj8nzW6AK/713M8GYekdyJTyTF+60J7C4lXQo4B3fTtYhKIK7dAsHNlZQn3B6AaUfXt/67Xw7w/+UvMbKUectj2nqOdCi6O9cOmzY3l74B7dabAYKGFWl5l1ah63utp1Y7EZjRIGO+dtUpQbvqXwaBCFDI9hQpGkvZCO2TrZMyjrUJ0QVJ334HMircJC+bmDV2oXXAwn+cG+Mx9MhVlxkd2ih6nGGvI/zSgCrJjkyKTnz
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 08:28:31.9008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d345ae-3d31-455f-904d-08dc36a4eabf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096

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

Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---

Changes v8->v9:
- remove patch for genirq msi wrapper API and export symbol
  (this will be added with its usage)

Changes v7->v8:
- Fix commit log and move the change log after ---
- removed unrequired #ifdef CONFIG_GENERIC_MSI_IRQ in cdx bus header
- replace dev_configure with dev_configure() and lock with held region
  in the code comments.
- Update code to use single line in if statement without { }
- remove cdx specific MSI allocation function and call msi setup data
  during device probe.
- remove redundant tail comment.
- exported generic MSI allocation routine in separate patch (2/2)

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

 drivers/cdx/Makefile                    |   4 +
 drivers/cdx/cdx.c                       |  20 +++
 drivers/cdx/cdx.h                       |  12 ++
 drivers/cdx/cdx_msi.c                   | 192 ++++++++++++++++++++++++
 drivers/cdx/controller/Kconfig          |   1 +
 drivers/cdx/controller/cdx_controller.c |  25 +++
 drivers/cdx/controller/mc_cdx_pcol.h    |  64 ++++++++
 drivers/cdx/controller/mcdi_functions.c |  33 +++-
 drivers/cdx/controller/mcdi_functions.h |  33 ++++
 include/linux/cdx/cdx_bus.h             |  53 ++++++-
 10 files changed, 434 insertions(+), 3 deletions(-)
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
index b74d76afccb6..236d381dc5f7 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -56,6 +56,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -302,8 +303,19 @@ static int cdx_probe(struct device *dev)
 {
 	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct cdx_controller *cdx = cdx_dev->cdx;
 	int error;
 
+	/*
+	 * Setup MSI device data so that generic MSI alloc/free can
+	 * be used by the device driver.
+	 */
+	if (cdx->msi_domain) {
+		error = msi_setup_device_data(&cdx_dev->dev);
+		if (error)
+			return error;
+	}
+
 	error = cdx_drv->probe(cdx_dev);
 	if (error) {
 		dev_err_probe(dev, error, "%s failed\n", __func__);
@@ -787,6 +799,7 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 
 	/* Populate CDX dev params */
 	cdx_dev->req_id = dev_params->req_id;
+	cdx_dev->msi_dev_id = dev_params->msi_dev_id;
 	cdx_dev->vendor = dev_params->vendor;
 	cdx_dev->device = dev_params->device;
 	cdx_dev->subsystem_vendor = dev_params->subsys_vendor;
@@ -804,12 +817,19 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
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
index 300ad8be7a34..9c60c04dcf87 100644
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
@@ -79,4 +83,12 @@ int cdx_device_add(struct cdx_dev_params *dev_params);
  */
 struct device *cdx_bus_add(struct cdx_controller *cdx, u8 bus_num);
 
+/**
+ * cdx_msi_domain_init - Init the CDX bus MSI domain.
+ * @dev: Device of the CDX bus controller
+ *
+ * Return: CDX MSI domain, NULL on failure
+ */
+struct irq_domain *cdx_msi_domain_init(struct device *dev);
+
 #endif /* _CDX_H_ */
diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
new file mode 100644
index 000000000000..e55f1716cfcb
--- /dev/null
+++ b/drivers/cdx/cdx_msi.c
@@ -0,0 +1,192 @@
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
+static void cdx_msi_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
+{
+	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
+	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
+
+	/* We would not operate on msg here rather we wait for irq_bus_sync_unlock()
+	 * to be called from preemptible task context.
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
+	dev_config.msi.addr = ((u64)(msi_desc->msg.address_hi) << 32) | msi_desc->msg.address_lo;
+
+	/*
+	 * dev_configure() is a controller callback which can interact with
+	 * Firmware or other entities, and can sleep, so invoke this function
+	 * outside of the mutex held region.
+	 */
+	dev_config.type = CDX_DEV_MSI_CONF;
+	if (cdx->ops->dev_configure)
+		cdx->ops->dev_configure(cdx, cdx_dev->bus_num, cdx_dev->dev_num, &dev_config);
+}
+
+int cdx_enable_msi(struct cdx_device *cdx_dev)
+{
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config;
+
+	dev_config.type = CDX_DEV_MSI_ENABLE;
+	dev_config.msi_enable = true;
+	if (cdx->ops->dev_configure) {
+		return cdx->ops->dev_configure(cdx, cdx_dev->bus_num, cdx_dev->dev_num,
+					       &dev_config);
+	}
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
+		cdx->ops->dev_configure(cdx, cdx_dev->bus_num, cdx_dev->dev_num, &dev_config);
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
+/* Convert an msi_desc to a unique identifier within the domain. */
+static irq_hw_number_t cdx_domain_calc_hwirq(struct cdx_device *dev,
+					     struct msi_desc *desc)
+{
+	return ((irq_hw_number_t)dev->msi_dev_id << 10) | desc->msi_index;
+}
+
+static void cdx_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
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
+	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map", "msi-map-mask",
+			NULL, &dev_id);
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
+	parent = irq_find_matching_fwnode(of_node_to_fwnode(parent_node), DOMAIN_BUS_NEXUS);
+	if (!parent || !msi_get_domain_info(parent)) {
+		dev_err(dev, "unable to locate ITS domain\n");
+		return NULL;
+	}
+
+	cdx_msi_domain = msi_create_irq_domain(fwnode_handle, &cdx_msi_domain_info, parent);
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
index 85fe4b1c4e5e..112a1541de6d 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/cdx/cdx_bus.h>
+#include <linux/irqdomain.h>
 
 #include "cdx_controller.h"
 #include "../cdx.h"
@@ -60,9 +61,19 @@ static int cdx_configure_device(struct cdx_controller *cdx,
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
+		ret = cdx_mcdi_write_msi(cdx->priv, bus_num, dev_num, msi_index, addr, data);
+		break;
 	case CDX_DEV_RESET_CONF:
 		ret = cdx_mcdi_reset_device(cdx->priv, bus_num, dev_num);
 		break;
@@ -70,6 +81,9 @@ static int cdx_configure_device(struct cdx_controller *cdx,
 		ret = cdx_mcdi_bus_master_enable(cdx->priv, bus_num, dev_num,
 						 dev_config->bus_master_enable);
 		break;
+	case CDX_DEV_MSI_ENABLE:
+		ret = cdx_mcdi_msi_enable(cdx->priv, bus_num, dev_num, dev_config->msi_enable);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -178,6 +192,14 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
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
@@ -189,6 +211,8 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
 	return 0;
 
 cdx_rpmsg_fail:
+	irq_domain_remove(cdx->msi_domain);
+cdx_msi_fail:
 	kfree(cdx);
 cdx_alloc_fail:
 	cdx_mcdi_finish(cdx_mcdi);
@@ -205,6 +229,7 @@ static int xlnx_cdx_remove(struct platform_device *pdev)
 
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
index 6355a36a3f81..b57118aaa679 100644
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
+	struct mutex irqchip_lock;
+	bool msi_write_pending;
 };
 
 #define to_cdx_device(_dev) \
@@ -237,4 +260,32 @@ int cdx_set_master(struct cdx_device *cdx_dev);
  */
 int cdx_clear_master(struct cdx_device *cdx_dev);
 
+#ifdef CONFIG_GENERIC_MSI_IRQ
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
-- 
2.34.1


