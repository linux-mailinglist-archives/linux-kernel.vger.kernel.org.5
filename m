Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33A97BA5F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbjJEQWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241283AbjJEQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:07 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29792695;
        Thu,  5 Oct 2023 08:59:20 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 235561BF208;
        Thu,  5 Oct 2023 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696521559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mkn/+vhJW3sVKv08jw//0zzOWdX1AuMFFQwZrqYl60U=;
        b=BuAUlGFWrQtv2lq9V+KnngOUldENbnUX19nOBaGp2e/UY3Of/BRGKkuOa7AHEARz1a36P8
        4+PpCxMLXEQs0SFUi179tMo9IfmbrdIBsF1rrZQAxzZu3HD/kzZpQmg34BQE9l2GOzGlZn
        6P3+GtBKsrEelOZ2gdErzNcXI5iEGY1LOzhAnipqSl5HXVRn3pJjoDHlQr5o625D1t7q3+
        wrVGaywJUAahOGcn5DnsH4E8juqZ1T7T7yzYHAL2y9Qx0L7q343P8m8gxGVyNTLAC9l82L
        oUQz+gz3K9yhWNTaWl2hjbXcdB/AbgnHSecOEcO18QNwUU+86jy8zPm6GJa0Pg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v12 5/7] nvmem: core: Rework layouts to become regular devices
Date:   Thu,  5 Oct 2023 17:59:05 +0200
Message-Id: <20231005155907.2701706-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current layout support was initially written without modules support in
mind. When the requirement for module support rose, the existing base
was improved to adopt modularization support, but kind of a design flaw
was introduced. With the existing implementation, when a storage device
registers into NVMEM, the core tries to hook a layout (if any) and
populates its cells immediately. This means, if the hardware description
expects a layout to be hooked up, but no driver was provided for that,
the storage medium will fail to probe and try later from
scratch. Technically, the layouts are more like a "plus" and, even we
consider that the hardware description shall be correct, we could still
probe the storage device (especially if it contains the rootfs).

One way to overcome this situation is to consider the layouts as
devices, and leverage the existing notifier mechanism. When a new NVMEM
device is registered, we can:
- populate its nvmem-layout child, if any
- try to modprobe the relevant driver, if relevant
- try to hook the NVMEM device with a layout in the notifier
And when a new layout is registered:
- try to hook all the existing NVMEM devices which are not yet hooked to
  a layout with the new layout
This way, there is no strong order to enforce, any NVMEM device creation
or NVMEM layout driver insertion will be observed as a new event which
may lead to the creation of additional cells, without disturbing the
probes with costly (and sometimes endless) deferrals.

In order to achieve that goal we need:
* To keep track of all nvmem devices
* To create a new bus for the nvmem-layouts with minimal logic to match
  nvmem-layout devices with nvmem-layout drivers.
All this infrastructure code is created in the layouts.c file.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/Makefile           |   2 +-
 drivers/nvmem/core.c             | 126 +++++--------------
 drivers/nvmem/internals.h        |  22 ++++
 drivers/nvmem/layouts.c          | 201 +++++++++++++++++++++++++++++++
 drivers/nvmem/layouts/onie-tlv.c |  36 +++++-
 drivers/nvmem/layouts/sl28vpd.c  |  36 +++++-
 include/linux/nvmem-provider.h   |  25 ++--
 7 files changed, 331 insertions(+), 117 deletions(-)
 create mode 100644 drivers/nvmem/layouts.c

diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 423baf089515..77be96076ea6 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_NVMEM)		+= nvmem_core.o
-nvmem_core-y			:= core.o
+nvmem_core-y			:= core.o layouts.o
 obj-y				+= layouts/
 
 # Devices
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 073fe4a73e37..6c6b0bac24f5 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -55,9 +55,6 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
-static DEFINE_SPINLOCK(nvmem_layout_lock);
-static LIST_HEAD(nvmem_layouts);
-
 static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 			    void *val, size_t bytes)
 {
@@ -744,91 +741,29 @@ static int nvmem_add_cells_from_fixed_layout(struct nvmem_device *nvmem)
 	return err;
 }
 
-int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner)
+int nvmem_layout_register(struct nvmem_layout *layout)
 {
-	layout->owner = owner;
+	struct nvmem_device *nvmem = dev_get_platdata(layout->dev);
 
-	spin_lock(&nvmem_layout_lock);
-	list_add(&layout->node, &nvmem_layouts);
-	spin_unlock(&nvmem_layout_lock);
+	if (!layout->add_cells)
+		return -EINVAL;
 
-	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_LAYOUT_ADD, layout);
+	/* Link internally the nvmem device to its layout */
+	nvmem->layout = layout;
 
-	return 0;
+	/* Populate the cells */
+	return nvmem->layout->add_cells(&nvmem->dev, nvmem, nvmem->layout);
 }
-EXPORT_SYMBOL_GPL(__nvmem_layout_register);
+EXPORT_SYMBOL_GPL(nvmem_layout_register);
 
 void nvmem_layout_unregister(struct nvmem_layout *layout)
 {
-	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_LAYOUT_REMOVE, layout);
+	struct nvmem_device *nvmem = dev_get_platdata(layout->dev);
 
-	spin_lock(&nvmem_layout_lock);
-	list_del(&layout->node);
-	spin_unlock(&nvmem_layout_lock);
+	nvmem->layout = NULL;
 }
 EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
 
-static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
-{
-	struct device_node *layout_np;
-	struct nvmem_layout *l, *layout = ERR_PTR(-EPROBE_DEFER);
-
-	layout_np = of_nvmem_layout_get_container(nvmem);
-	if (!layout_np)
-		return NULL;
-
-	/*
-	 * In case the nvmem device was built-in while the layout was built as a
-	 * module, we shall manually request the layout driver loading otherwise
-	 * we'll never have any match.
-	 */
-	of_request_module(layout_np);
-
-	spin_lock(&nvmem_layout_lock);
-
-	list_for_each_entry(l, &nvmem_layouts, node) {
-		if (of_match_node(l->of_match_table, layout_np)) {
-			if (try_module_get(l->owner))
-				layout = l;
-
-			break;
-		}
-	}
-
-	spin_unlock(&nvmem_layout_lock);
-	of_node_put(layout_np);
-
-	return layout;
-}
-
-static void nvmem_layout_put(struct nvmem_layout *layout)
-{
-	if (layout)
-		module_put(layout->owner);
-}
-
-static int nvmem_add_cells_from_layout(struct nvmem_device *nvmem)
-{
-	struct nvmem_layout *layout = nvmem->layout;
-	int ret;
-
-	if (layout && layout->add_cells) {
-		ret = layout->add_cells(&nvmem->dev, nvmem, layout);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-#if IS_ENABLED(CONFIG_OF)
-struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
-{
-	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
-}
-EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
-#endif
-
 const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 					struct nvmem_layout *layout)
 {
@@ -836,7 +771,7 @@ const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 	const struct of_device_id *match;
 
 	layout_np = of_nvmem_layout_get_container(nvmem);
-	match = of_match_node(layout->of_match_table, layout_np);
+	match = of_match_node(layout->dev->driver->of_match_table, layout_np);
 
 	return match ? match->data : NULL;
 }
@@ -947,19 +882,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_put_device;
 	}
 
-	/*
-	 * If the driver supplied a layout by config->layout, the module
-	 * pointer will be NULL and nvmem_layout_put() will be a noop.
-	 */
-	nvmem->layout = config->layout ?: nvmem_layout_get(nvmem);
-	if (IS_ERR(nvmem->layout)) {
-		rval = PTR_ERR(nvmem->layout);
-		nvmem->layout = NULL;
-
-		if (rval == -EPROBE_DEFER)
-			goto err_teardown_compat;
-	}
-
 	if (config->cells) {
 		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
 		if (rval)
@@ -978,7 +900,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_layout(nvmem);
+	rval = nvmem_populate_layout(nvmem);
 	if (rval)
 		goto err_remove_cells;
 
@@ -986,16 +908,17 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	rval = device_add(&nvmem->dev);
 	if (rval)
-		goto err_remove_cells;
+		goto err_destroy_layout;
+
 
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
 
+err_destroy_layout:
+	nvmem_destroy_layout(nvmem);
 err_remove_cells:
 	nvmem_device_remove_all_cells(nvmem);
-	nvmem_layout_put(nvmem->layout);
-err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
 err_put_device:
@@ -1017,7 +940,7 @@ static void nvmem_device_release(struct kref *kref)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 
 	nvmem_device_remove_all_cells(nvmem);
-	nvmem_layout_put(nvmem->layout);
+	nvmem_destroy_layout(nvmem);
 	device_unregister(&nvmem->dev);
 }
 
@@ -2099,11 +2022,22 @@ EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
 static int __init nvmem_init(void)
 {
-	return bus_register(&nvmem_bus_type);
+	int ret;
+
+	ret = bus_register(&nvmem_bus_type);
+	if (ret)
+		return ret;
+
+	ret = nvmem_layout_bus_register();
+	if (ret)
+		bus_unregister(&nvmem_bus_type);
+
+	return ret;
 }
 
 static void __exit nvmem_exit(void)
 {
+	nvmem_layout_bus_unregister();
 	bus_unregister(&nvmem_bus_type);
 }
 
diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
index ce353831cd65..10a317d46fb6 100644
--- a/drivers/nvmem/internals.h
+++ b/drivers/nvmem/internals.h
@@ -28,8 +28,30 @@ struct nvmem_device {
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	struct gpio_desc	*wp_gpio;
+	struct device		*layout_dev;
 	struct nvmem_layout	*layout;
 	void *priv;
 };
 
+#if IS_ENABLED(CONFIG_OF)
+int nvmem_layout_bus_register(void);
+void nvmem_layout_bus_unregister(void);
+int nvmem_populate_layout(struct nvmem_device *nvmem);
+void nvmem_destroy_layout(struct nvmem_device *nvmem);
+#else /* CONFIG_OF */
+static inline int nvmem_layout_bus_register(void)
+{
+	return 0;
+}
+
+static inline void nvmem_layout_bus_unregister(void) {}
+
+static inline int nvmem_populate_layout(struct nvmem_device *nvmem)
+{
+	return 0;
+}
+
+static inline int nvmem_destroy_layout(struct nvmem_device *nvmem) { }
+#endif /* CONFIG_OF */
+
 #endif  /* ifndef _LINUX_NVMEM_INTERNALS_H */
diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
new file mode 100644
index 000000000000..5f2ec4213469
--- /dev/null
+++ b/drivers/nvmem/layouts.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMEM layout bus handling
+ *
+ * Copyright (C) 2023 Bootlin
+ * Author: Miquel Raynal <miquel.raynal@bootlin.com
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+
+#include "internals.h"
+
+#if IS_ENABLED(CONFIG_OF)
+static int nvmem_layout_bus_match(struct device *dev, struct device_driver *drv)
+{
+	return of_driver_match_device(dev, drv);
+}
+
+static struct bus_type nvmem_layout_bus_type = {
+	.name		= "nvmem-layouts",
+	.match		= nvmem_layout_bus_match,
+};
+
+static struct device nvmem_layout_bus = {
+	.init_name	= "nvmem-layouts",
+};
+
+int nvmem_layout_driver_register(struct nvmem_layout_driver *drv)
+{
+	drv->driver.bus = &nvmem_layout_bus_type;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(nvmem_layout_driver_register);
+
+void nvmem_layout_driver_unregister(struct nvmem_layout_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(nvmem_layout_driver_unregister);
+
+static void nvmem_layout_device_release(struct device *dev)
+{
+	of_node_put(dev->of_node);
+	kfree(dev);
+}
+
+static int nvmem_layout_create_device(struct nvmem_device *nvmem,
+				      struct device_node *np)
+{
+	struct device *dev;
+	int ret;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	device_initialize(dev);
+	dev->parent = &nvmem_layout_bus;
+	dev->bus = &nvmem_layout_bus_type;
+	dev->release = nvmem_layout_device_release;
+	dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	dev->dma_mask = &dev->coherent_dma_mask;
+	dev->platform_data = nvmem;
+	device_set_node(dev, of_fwnode_handle(of_node_get(np)));
+	of_device_make_bus_id(dev);
+	of_msi_configure(dev, dev->of_node);
+
+	ret = device_add(dev);
+	if (ret) {
+		put_device(dev);
+		return ret;
+	}
+
+	nvmem->layout_dev = dev;
+
+	return 0;
+}
+
+static const struct of_device_id of_nvmem_layout_skip_table[] = {
+	{ .compatible = "fixed-layout", },
+	{}
+};
+
+static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
+				     struct device_node *layout_dn)
+{
+	int ret;
+
+	/* Make sure it has a compatible property */
+	if (!of_get_property(layout_dn, "compatible", NULL)) {
+		pr_debug("%s() - skipping %pOF, no compatible prop\n",
+			 __func__, layout_dn);
+		return 0;
+	}
+
+	/* Fixed layouts are parsed manually somewhere else for now */
+	if (of_match_node(of_nvmem_layout_skip_table, layout_dn)) {
+		pr_debug("%s() - skipping %pOF node\n", __func__, layout_dn);
+		return 0;
+	}
+
+	if (of_node_check_flag(layout_dn, OF_POPULATED_BUS)) {
+		pr_debug("%s() - skipping %pOF, already populated\n",
+			 __func__, layout_dn);
+		return 0;
+	}
+
+	/* NVMEM layout buses expect only a single device representing the layout */
+	ret = nvmem_layout_create_device(nvmem, layout_dn);
+	if (ret)
+		return ret;
+
+	of_node_set_flag(layout_dn, OF_POPULATED_BUS);
+
+	return 0;
+}
+
+struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
+{
+	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+}
+EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
+
+/*
+ * Returns the number of devices populated, 0 if the operation was not relevant
+ * for this nvmem device, an error code otherwise.
+ */
+int nvmem_populate_layout(struct nvmem_device *nvmem)
+{
+	struct device_node *nvmem_dn, *layout_dn;
+	int ret;
+
+	layout_dn = of_nvmem_layout_get_container(nvmem);
+	if (!layout_dn)
+		return 0;
+
+	nvmem_dn = of_node_get(nvmem->dev.of_node);
+	if (!nvmem_dn) {
+		of_node_put(layout_dn);
+		return 0;
+	}
+
+	/* Ensure the layout driver is loaded */
+	of_request_module(layout_dn);
+
+	/* Populate the layout device */
+	device_links_supplier_sync_state_pause();
+	ret = nvmem_layout_bus_populate(nvmem, layout_dn);
+	device_links_supplier_sync_state_resume();
+
+	of_node_put(nvmem_dn);
+	of_node_put(layout_dn);
+	return ret;
+}
+
+void nvmem_destroy_layout(struct nvmem_device *nvmem)
+{
+	struct device_node *layout_dn;
+
+	layout_dn = of_nvmem_layout_get_container(nvmem);
+	if (!layout_dn)
+		return;
+
+	of_node_clear_flag(layout_dn, OF_POPULATED_BUS);
+	put_device(nvmem->layout_dev);
+
+	of_node_put(layout_dn);
+}
+
+int nvmem_layout_bus_register(void)
+{
+	int ret;
+
+	ret = device_register(&nvmem_layout_bus);
+	if (ret) {
+		put_device(&nvmem_layout_bus);
+		return ret;
+	}
+
+	ret = bus_register(&nvmem_layout_bus_type);
+	if (ret) {
+		device_unregister(&nvmem_layout_bus);
+		return ret;
+	}
+
+	return 0;
+}
+
+void nvmem_layout_bus_unregister(void)
+{
+	bus_unregister(&nvmem_layout_bus_type);
+	device_unregister(&nvmem_layout_bus);
+}
+#endif
diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 59fc87ccfcff..191b2540d347 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -226,16 +226,44 @@ static int onie_tlv_parse_table(struct device *dev, struct nvmem_device *nvmem,
 	return 0;
 }
 
+static int onie_tlv_probe(struct device *dev)
+{
+	struct nvmem_layout *layout;
+
+	layout = devm_kzalloc(dev, sizeof(*layout), GFP_KERNEL);
+	if (!layout)
+		return -ENOMEM;
+
+	layout->add_cells = onie_tlv_parse_table;
+	layout->dev = dev;
+
+	dev_set_drvdata(dev, layout);
+
+	return nvmem_layout_register(layout);
+}
+
+static int onie_tlv_remove(struct device *dev)
+{
+	struct nvmem_layout *layout = dev_get_drvdata(dev);
+
+	nvmem_layout_unregister(layout);
+
+	return 0;
+}
+
 static const struct of_device_id onie_tlv_of_match_table[] = {
 	{ .compatible = "onie,tlv-layout", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, onie_tlv_of_match_table);
 
-static struct nvmem_layout onie_tlv_layout = {
-	.name = "ONIE tlv layout",
-	.of_match_table = onie_tlv_of_match_table,
-	.add_cells = onie_tlv_parse_table,
+static struct nvmem_layout_driver onie_tlv_layout = {
+	.driver = {
+		.name = "onie-tlv-layout",
+		.of_match_table = onie_tlv_of_match_table,
+		.probe = onie_tlv_probe,
+		.remove = onie_tlv_remove,
+	},
 };
 module_nvmem_layout_driver(onie_tlv_layout);
 
diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index 05671371f631..330badebfcf6 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -135,16 +135,44 @@ static int sl28vpd_add_cells(struct device *dev, struct nvmem_device *nvmem,
 	return 0;
 }
 
+static int sl28vpd_probe(struct device *dev)
+{
+	struct nvmem_layout *layout;
+
+	layout = devm_kzalloc(dev, sizeof(*layout), GFP_KERNEL);
+	if (!layout)
+		return -ENOMEM;
+
+	layout->add_cells = sl28vpd_add_cells;
+	layout->dev = dev;
+
+	dev_set_drvdata(dev, layout);
+
+	return nvmem_layout_register(layout);
+}
+
+static int sl28vpd_remove(struct device *dev)
+{
+	struct nvmem_layout *layout = dev_get_drvdata(dev);
+
+	nvmem_layout_unregister(layout);
+
+	return 0;
+}
+
 static const struct of_device_id sl28vpd_of_match_table[] = {
 	{ .compatible = "kontron,sl28-vpd" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sl28vpd_of_match_table);
 
-static struct nvmem_layout sl28vpd_layout = {
-	.name = "sl28-vpd",
-	.of_match_table = sl28vpd_of_match_table,
-	.add_cells = sl28vpd_add_cells,
+static struct nvmem_layout_driver sl28vpd_layout = {
+	.driver = {
+		.name = "kontron-sl28vpd-layout",
+		.of_match_table = sl28vpd_of_match_table,
+		.probe = sl28vpd_probe,
+		.remove = sl28vpd_remove,
+	},
 };
 module_nvmem_layout_driver(sl28vpd_layout);
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 2905f9e6fc2a..10537abea008 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -154,8 +154,7 @@ struct nvmem_cell_table {
 /**
  * struct nvmem_layout - NVMEM layout definitions
  *
- * @name:		Layout name.
- * @of_match_table:	Open firmware match table.
+ * @dev:		Device-model layout device.
  * @add_cells:		Will be called if a nvmem device is found which
  *			has this layout. The function will add layout
  *			specific cells with nvmem_add_one_cell().
@@ -170,8 +169,7 @@ struct nvmem_cell_table {
  * cells.
  */
 struct nvmem_layout {
-	const char *name;
-	const struct of_device_id *of_match_table;
+	struct device *dev;
 	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem,
 			 struct nvmem_layout *layout);
 	void (*fixup_cell_info)(struct nvmem_device *nvmem,
@@ -183,6 +181,10 @@ struct nvmem_layout {
 	struct list_head node;
 };
 
+struct nvmem_layout_driver {
+	struct device_driver driver;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
@@ -197,11 +199,15 @@ void nvmem_del_cell_table(struct nvmem_cell_table *table);
 int nvmem_add_one_cell(struct nvmem_device *nvmem,
 		       const struct nvmem_cell_info *info);
 
-int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner);
-#define nvmem_layout_register(layout) \
-	__nvmem_layout_register(layout, THIS_MODULE)
+int nvmem_layout_register(struct nvmem_layout *layout);
 void nvmem_layout_unregister(struct nvmem_layout *layout);
 
+int nvmem_layout_driver_register(struct nvmem_layout_driver *drv);
+void nvmem_layout_driver_unregister(struct nvmem_layout_driver *drv);
+#define module_nvmem_layout_driver(__nvmem_layout_driver)		\
+	module_driver(__nvmem_layout_driver, nvmem_layout_driver_register, \
+		      nvmem_layout_driver_unregister)
+
 const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 					struct nvmem_layout *layout);
 
@@ -257,9 +263,4 @@ static inline struct device_node *of_nvmem_layout_get_container(struct nvmem_dev
 	return NULL;
 }
 #endif /* CONFIG_NVMEM */
-
-#define module_nvmem_layout_driver(__layout_driver)		\
-	module_driver(__layout_driver, nvmem_layout_register,	\
-		      nvmem_layout_unregister)
-
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.34.1

