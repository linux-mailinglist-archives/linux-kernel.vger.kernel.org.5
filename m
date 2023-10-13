Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9037B7C7D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjJMGKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjJMGKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:10:04 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC9FD6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:09:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+OQN6AynaVLG9asefdpTCkxyZT8rIjYG8+pAl6lw3wh1/VP9vyI17dkYvbr8RpDfIhgEXVNftXL0sWNGLpkeWJaUw0VGBBHAr09uYCaisRSS0HqOvH995s3fn52PTfe3rftuSISNhPWZcxdbkURs1M9d406TyNE6mVCw5YB4BC4xmwVeXIOAjUoGTrHQXeGDjXwVZyUrEPGRUAtA6nO4iCey00NoF7/NCRijd64YCQ+1H3BmdmBpG9Jt7pSVAptcWz3ikpokhEplnubEgalmedmisjjwdLFzdiE9iFV6zNW1i7JrMW+q5R07+ypp/QPmbtTevl918mgzlV3Ci8MbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAA50OrtvwIvupFMiuUMOYlEa5jURPwM6otSw/trtus=;
 b=TQadbkvL0OOVMdqTqfnV1mAn43HCQLc5U1Ys6oNhHbFEmO24j7AxkV+gr7GSlo0Ybbiie9530DUqsJXM+ITnK2BHo+bA5xm17AGHOgD0I1LpwQpv94010lM4co5gfJcaL52gGvmyoPVGjCuINFeCAoSYEqju4YVR1YmDi+yvH9XNYLOMFJHlFM1jY0hw5PGVSVDVSPY92UnI72ZLYz2SrvRO+HH2rfvvZKM7FdIMLt3QeQ2tbGYi1R1U2BRO2YVVJdMK/XLgaWLC6PUjCu1SERrfNSmoltiCM/bbe58FbEx1XFNwb5ZaFIaFCaiPz+q18VQHpGJkXrmKuasDVttQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAA50OrtvwIvupFMiuUMOYlEa5jURPwM6otSw/trtus=;
 b=jYlfM+ZNQXXdRsau0V83+kZbriP4RaZMDzmM9twqcKNfYXonUbdY+1iCfoC/yL/2I+Cyciy44OK8U10Y4JwnKlG/GyBq4z0gQBeqQ0DehSGnSx+o+lGZVOamrR9Mn9wAC5BWOZHrd9wts+tiIQfINF/ii5y2j12Wmg4s8ctB2tU=
Received: from CH0PR08CA0028.namprd08.prod.outlook.com (2603:10b6:610:33::33)
 by SJ0PR12MB5674.namprd12.prod.outlook.com (2603:10b6:a03:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 06:09:56 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:610:33:cafe::16) by CH0PR08CA0028.outlook.office365.com
 (2603:10b6:610:33::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 06:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 06:09:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 01:09:48 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 01:09:34 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v6 3/6] cdx: Register cdx bus as a device on cdx subsystem
Date:   Fri, 13 Oct 2023 11:38:47 +0530
Message-ID: <20231013060850.424929-4-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013060850.424929-1-abhijit.gangurde@amd.com>
References: <20231013060850.424929-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SJ0PR12MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e22f1c-451b-475f-3081-08dbcbb3056b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8J0oejRBeRVDi/cfpsVscfH4LNinRwOQkVcY44CDOksITvmzeSPAO8IfdOfzjAbugzFv2/8OFtxZZLn8FFhcW8exfO2Vfun+B4l47fXiDyfsbjateN4x7io9vsV66yGgW0Wr3oBC8tEhkoMva3Y71aThIxAaXryYOJKx1J2Z6iDFPof/tfD2pCxFJ7cSW4outUqZaU4+KEsB+g3T7rPTV3GgooTrnISCGCDI4DQVHwh249W+eY2kw/D0XePTNS/MazwBByxoGNPZFWAbefRZuwg7rvEolx5p/r9KeRdw/D/jZi+K4Rg/jApBQt/wPd3ki8gjAejnkpW4OPIxaZYMIlpOLn/Q4csLdmlTjJrFwSjC/tGxvlfxiHB4bVme2uJAm1NH2YNCt2JPoIi6mvTM0bBUooBZHjYx7GGrmgFCbSpkHwZNEkoyB2T6IRl8eJ2C/y1MMgfzUH4ZkXoiyO6ptTUC2VaY4NaLmWBfjZSolxM11aubN/w4CE/WXxksSXdV+kjpKv6VB0v0AVL0vZJjx3B9Ca0hPSNuRVb4UZPQxDVWYj7ctonhNGlrNLtm0gELwbKp9CMvwqszBI63mGjnm4CCHbeJp2FYWY4zXlcFQTSlmTIkDE0E7matmbzCiS4eHtmIDf2UBao02jls+YJ73cYjvMTE1jY5o924bCJCifCz5DnfriUqGSxj/wPbwSbWR+SEzbYiYVjVf5gBPh7dUPwWUYBpXmSzgfIVZOqsE0qSQRg+8mAaLa1k1i6Va2dgtbfx+HIBxcAp6XlIIa3big==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(36756003)(86362001)(40480700001)(40460700003)(110136005)(54906003)(316002)(70586007)(81166007)(82740400003)(356005)(70206006)(47076005)(83380400001)(36860700001)(426003)(26005)(2616005)(1076003)(41300700001)(6666004)(5660300002)(8676002)(478600001)(8936002)(336012)(2906002)(44832011)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 06:09:55.1990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e22f1c-451b-475f-3081-08dbcbb3056b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5674
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While scanning for CDX devices, register newly discovered bus as a
cdx device. CDX device attributes are visible based on device type.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes in v6:
 - New patch in the series
 - Register cdx bus as a device on cdx subsystem

 drivers/cdx/cdx.c                       | 77 +++++++++++++++++++++++--
 drivers/cdx/cdx.h                       | 14 ++++-
 drivers/cdx/controller/cdx_controller.c |  7 +++
 include/linux/cdx/cdx_bus.h             |  2 +
 4 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 75760388f5e7..18da06e0babe 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -125,8 +125,13 @@ static int cdx_unregister_device(struct device *dev,
 {
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
 
-	kfree(cdx_dev->driver_override);
-	cdx_dev->driver_override = NULL;
+	if (cdx_dev->is_bus) {
+		device_for_each_child(dev, NULL, cdx_unregister_device);
+	} else {
+		kfree(cdx_dev->driver_override);
+		cdx_dev->driver_override = NULL;
+	}
+
 	/*
 	 * Do not free cdx_dev here as it would be freed in
 	 * cdx_device_release() called from within put_device().
@@ -201,6 +206,9 @@ static int cdx_bus_match(struct device *dev, struct device_driver *drv)
 	const struct cdx_device_id *found_id = NULL;
 	const struct cdx_device_id *ids;
 
+	if (cdx_dev->is_bus)
+		return false;
+
 	ids = cdx_drv->match_id_table;
 
 	/* When driver_override is set, only bind to the matching driver */
@@ -265,10 +273,11 @@ static int cdx_dma_configure(struct device *dev)
 {
 	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct cdx_controller *cdx = cdx_dev->cdx;
 	u32 input_id = cdx_dev->req_id;
 	int ret;
 
-	ret = of_dma_configure_id(dev, dev->parent->of_node, 0, &input_id);
+	ret = of_dma_configure_id(dev, cdx->dev->of_node, 0, &input_id);
 	if (ret && ret != -EPROBE_DEFER) {
 		dev_err(dev, "of_dma_configure_id() failed\n");
 		return ret;
@@ -374,6 +383,18 @@ static ssize_t driver_override_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(driver_override);
 
+static umode_t cdx_dev_attrs_are_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cdx_device *cdx_dev;
+
+	cdx_dev = to_cdx_device(dev);
+	if (!cdx_dev->is_bus)
+		return a->mode;
+
+	return 0;
+}
+
 static struct attribute *cdx_dev_attrs[] = {
 	&dev_attr_remove.attr,
 	&dev_attr_reset.attr,
@@ -382,7 +403,16 @@ static struct attribute *cdx_dev_attrs[] = {
 	&dev_attr_driver_override.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(cdx_dev);
+
+static const struct attribute_group cdx_dev_group = {
+	.attrs = cdx_dev_attrs,
+	.is_visible = cdx_dev_attrs_are_visible,
+};
+
+static const struct attribute_group *cdx_dev_groups[] = {
+	&cdx_dev_group,
+	NULL,
+};
 
 static ssize_t rescan_store(const struct bus_type *bus,
 			    const char *buf, size_t count)
@@ -479,7 +509,6 @@ static void cdx_device_release(struct device *dev)
 int cdx_device_add(struct cdx_dev_params *dev_params)
 {
 	struct cdx_controller *cdx = dev_params->cdx;
-	struct device *parent = cdx->dev;
 	struct cdx_device *cdx_dev;
 	int ret;
 
@@ -503,7 +532,7 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 
 	/* Initialize generic device */
 	device_initialize(&cdx_dev->dev);
-	cdx_dev->dev.parent = parent;
+	cdx_dev->dev.parent = dev_params->parent;
 	cdx_dev->dev.bus = &cdx_bus_type;
 	cdx_dev->dev.dma_mask = &cdx_dev->dma_mask;
 	cdx_dev->dev.release = cdx_device_release;
@@ -532,6 +561,42 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 }
 EXPORT_SYMBOL_GPL(cdx_device_add);
 
+struct device *cdx_bus_add(struct cdx_controller *cdx, u8 bus_num)
+{
+	struct cdx_device *cdx_dev;
+	int ret;
+
+	cdx_dev = kzalloc(sizeof(*cdx_dev), GFP_KERNEL);
+	if (!cdx_dev)
+		return NULL;
+
+	device_initialize(&cdx_dev->dev);
+	cdx_dev->cdx = cdx;
+
+	cdx_dev->dev.parent = cdx->dev;
+	cdx_dev->dev.bus = &cdx_bus_type;
+	cdx_dev->dev.release = cdx_device_release;
+	cdx_dev->is_bus = true;
+	cdx_dev->bus_num = bus_num;
+
+	dev_set_name(&cdx_dev->dev, "cdx-%02x",
+		     ((cdx->id << CDX_CONTROLLER_ID_SHIFT) | (bus_num & CDX_BUS_NUM_MASK)));
+
+	ret = device_add(&cdx_dev->dev);
+	if (ret) {
+		dev_err(&cdx_dev->dev, "cdx bus device add failed: %d\n", ret);
+		goto device_add_fail;
+	}
+
+	return &cdx_dev->dev;
+
+device_add_fail:
+	put_device(&cdx_dev->dev);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(cdx_bus_add);
+
 int cdx_register_controller(struct cdx_controller *cdx)
 {
 	int ret;
diff --git a/drivers/cdx/cdx.h b/drivers/cdx/cdx.h
index c436ac7ac86f..1f593deb4c9e 100644
--- a/drivers/cdx/cdx.h
+++ b/drivers/cdx/cdx.h
@@ -13,7 +13,7 @@
 /**
  * struct cdx_dev_params - CDX device parameters
  * @cdx: CDX controller associated with the device
- * @parent: Associated CDX controller
+ * @parent: Associated CDX Bus device
  * @vendor: Vendor ID for CDX device
  * @device: Device ID for CDX device
  * @bus_num: Bus number for this CDX device
@@ -24,6 +24,7 @@
  */
 struct cdx_dev_params {
 	struct cdx_controller *cdx;
+	struct device *parent;
 	u16 vendor;
 	u16 device;
 	u8 bus_num;
@@ -59,4 +60,15 @@ void cdx_unregister_controller(struct cdx_controller *cdx);
  */
 int cdx_device_add(struct cdx_dev_params *dev_params);
 
+/**
+ * cdx_bus_add - Add a CDX bus. This function adds a bus on the CDX bus
+ *		subsystem. It creates a CDX device for the corresponding bus and
+ *		also registers an associated Linux generic device.
+ * @cdx: Associated CDX controller
+ * @us_num: Bus number
+ *
+ * Return: associated Linux generic device pointer on success or NULL on failure.
+ */
+struct device *cdx_bus_add(struct cdx_controller *cdx, u8 bus_num);
+
 #endif /* _CDX_H_ */
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index bb4ae7970e21..d1d4606f6c1a 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -79,8 +79,14 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
 	num_cdx_bus = (u8)ret;
 
 	for (bus_num = 0; bus_num < num_cdx_bus; bus_num++) {
+		struct device *bus_dev;
 		u8 num_cdx_dev;
 
+		/* Add the bus on cdx subsystem */
+		bus_dev = cdx_bus_add(cdx, bus_num);
+		if (!bus_dev)
+			continue;
+
 		/* MCDI FW Read: Fetch the number of devices present */
 		ret = cdx_mcdi_get_num_devs(cdx_mcdi, bus_num);
 		if (ret < 0) {
@@ -103,6 +109,7 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
 				continue;
 			}
 			dev_params.cdx = cdx;
+			dev_params.parent = bus_dev;
 
 			/* Add the device to the cdx bus */
 			ret = cdx_device_add(&dev_params);
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index 82c27b8c94e1..b5e4b7e05666 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -88,6 +88,7 @@ struct cdx_controller {
  * @dma_mask: Default DMA mask
  * @flags: CDX device flags
  * @req_id: Requestor ID associated with CDX device
+ * @is_bus: Is this bus device
  * @driver_override: driver name to force a match; do not set directly,
  *                   because core frees it; use driver_set_override() to
  *                   set or clear it.
@@ -104,6 +105,7 @@ struct cdx_device {
 	u64 dma_mask;
 	u16 flags;
 	u32 req_id;
+	bool is_bus;
 	const char *driver_override;
 };
 
-- 
2.34.1

