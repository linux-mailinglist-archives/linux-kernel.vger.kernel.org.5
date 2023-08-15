Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D0B77C83B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjHOG7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjHOG7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:59:02 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0A8C10C6;
        Mon, 14 Aug 2023 23:58:58 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Dxl+gwIttk7akYAA--.14636S3;
        Tue, 15 Aug 2023 14:58:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc8sIttkH_haAA--.27070S2;
        Tue, 15 Aug 2023 14:58:55 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH RESEND v2] usb: dwc2: add pci_device_id driver_data parse support
Date:   Tue, 15 Aug 2023 14:58:33 +0800
Message-Id: <20230815065833.3375-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxDc8sIttkH_haAA--.27070S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc2 driver has everything we need to run in PCI mode except
for pci_device_id driver_data parse.  With that to set Loongson
dwc2 element and added identified as PCI_VENDOR_ID_LOONGSON
and PCI_DEVICE_ID_LOONGSON_DWC2 in dwc2_pci_ids, the Loongson
dwc2 controller will work.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v2:
		1. Move the dwc2 pci ID from pci_ids.h to params.c.
		2. Add some code logic to ensure that the current device is
		   a PCI device.
		3. Fix the compile issue when dwc2 pci driver as module.

 drivers/usb/dwc2/core.h   |  1 +
 drivers/usb/dwc2/params.c | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc2/pci.c    | 14 +-------------
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 0bb4c0c845bf..c92a1da46a01 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1330,6 +1330,7 @@ irqreturn_t dwc2_handle_common_intr(int irq, void *dev);
 /* The device ID match table */
 extern const struct of_device_id dwc2_of_match_table[];
 extern const struct acpi_device_id dwc2_acpi_match[];
+extern const struct pci_device_id dwc2_pci_ids[];
 
 int dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg);
 int dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg);
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 21d16533bd2f..6b68a8830781 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -7,9 +7,14 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/usb/of.h>
+#include <linux/pci_ids.h>
+#include <linux/pci.h>
 
 #include "core.h"
 
+#define PCI_PRODUCT_ID_HAPS_HSOTG	0xabc0
+#define PCI_DEVICE_ID_LOONGSON_DWC2	0x7a04
+
 static void dwc2_set_bcm_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
@@ -55,6 +60,14 @@ static void dwc2_set_jz4775_params(struct dwc2_hsotg *hsotg)
 		!device_property_read_bool(hsotg->dev, "disable-over-current");
 }
 
+static void dwc2_set_loongson_params(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_core_params *p = &hsotg->params;
+
+	p->phy_utmi_width = 8;
+	p->power_down = DWC2_POWER_DOWN_PARAM_PARTIAL;
+}
+
 static void dwc2_set_x1600_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
@@ -281,6 +294,23 @@ const struct acpi_device_id dwc2_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, dwc2_acpi_match);
 
+const struct pci_device_id dwc2_pci_ids[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_PRODUCT_ID_HAPS_HSOTG),
+	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_STMICRO,
+			   PCI_DEVICE_ID_STMICRO_USB_OTG),
+	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DWC2),
+		.driver_data = (unsigned long)dwc2_set_loongson_params,
+	},
+	{ /* end: all zeroes */ }
+};
+MODULE_DEVICE_TABLE(pci, dwc2_pci_ids);
+EXPORT_SYMBOL_GPL(dwc2_pci_ids);
+
 static void dwc2_set_param_otg_cap(struct dwc2_hsotg *hsotg)
 {
 	switch (hsotg->hw_params.op_mode) {
@@ -927,13 +957,20 @@ int dwc2_init_params(struct dwc2_hsotg *hsotg)
 	if (match && match->data) {
 		set_params = match->data;
 		set_params(hsotg);
-	} else {
+	} else if (!match) {
 		const struct acpi_device_id *amatch;
+		const struct pci_device_id *pmatch = NULL;
 
 		amatch = acpi_match_device(dwc2_acpi_match, hsotg->dev);
 		if (amatch && amatch->driver_data) {
 			set_params = (set_params_cb)amatch->driver_data;
 			set_params(hsotg);
+		} else if (!amatch)
+			pmatch = pci_match_id(dwc2_pci_ids, to_pci_dev(hsotg->dev->parent));
+
+		if (pmatch && pmatch->driver_data) {
+			set_params = (set_params_cb)pmatch->driver_data;
+			set_params(hsotg);
 		}
 	}
 
diff --git a/drivers/usb/dwc2/pci.c b/drivers/usb/dwc2/pci.c
index b7306ed8be4c..f3a1e4232a31 100644
--- a/drivers/usb/dwc2/pci.c
+++ b/drivers/usb/dwc2/pci.c
@@ -24,7 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/usb/usb_phy_generic.h>
 
-#define PCI_PRODUCT_ID_HAPS_HSOTG	0xabc0
+#include "core.h"
 
 static const char dwc2_driver_name[] = "dwc2-pci";
 
@@ -122,18 +122,6 @@ static int dwc2_pci_probe(struct pci_dev *pci,
 	return ret;
 }
 
-static const struct pci_device_id dwc2_pci_ids[] = {
-	{
-		PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_PRODUCT_ID_HAPS_HSOTG),
-	},
-	{
-		PCI_DEVICE(PCI_VENDOR_ID_STMICRO,
-			   PCI_DEVICE_ID_STMICRO_USB_OTG),
-	},
-	{ /* end: all zeroes */ }
-};
-MODULE_DEVICE_TABLE(pci, dwc2_pci_ids);
-
 static struct pci_driver dwc2_pci_driver = {
 	.name = dwc2_driver_name,
 	.id_table = dwc2_pci_ids,
-- 
2.31.1

