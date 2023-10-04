Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C407A7B97E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbjJDWXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjJDWXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:23:00 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98F8E5;
        Wed,  4 Oct 2023 15:22:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 182031C0003;
        Wed,  4 Oct 2023 22:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696458173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+IyQ6AFHVL8vkHiWDUBkK8L51Tp6FEdFJJZ33XmkB0=;
        b=G2NP9LLV2baSTs+QesOicML/NnkVmhD2glBvDYzhompDMzeD+6XWF1RrYZVldV1gFlvV+e
        d6K7yEs0vPfFH3zJnFXaQUng0SpSTwvRV8pDptWN6vOykjbP6Czd6wQEji0k76KIlDsvW3
        1GGqsjwEE01PMCwS4sC9V/iGNZiKOg3kyeKJzm/p2/w6v/741cNUzJl9B7GIzcraaav/mQ
        NVST/Lc7pc7e/zIOuOYOtDK/XQBBtWdNKV1WlT5kCnkL15cUShTrl7rnsdwaRO7rOWl2BV
        JRjR5i+yBeWWtttbblTYpIsWw0X8nCOZ1Kw718fEbj2AMwJRdBeU7mXFOxeVpw==
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
Subject: [PATCH v11 5/7] nvmem: core: Rework layouts to become regular devices
Date:   Thu,  5 Oct 2023 00:22:34 +0200
Message-Id: <20231004222236.411248-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004222236.411248-1-miquel.raynal@bootlin.com>
References: <20231004222236.411248-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/nvmem/core.c             | 157 +++++++++++++++++++++-------
 drivers/nvmem/internals.h        |   4 +
 drivers/nvmem/layouts.c          | 171 +++++++++++++++++++++++++++++++
 drivers/nvmem/layouts/onie-tlv.c |  37 ++++++-
 drivers/nvmem/layouts/sl28vpd.c  |  37 ++++++-
 include/linux/nvmem-provider.h   |  24 +++--
 7 files changed, 376 insertions(+), 56 deletions(-)
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
index 073fe4a73e37..1f311c899ae1 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -53,6 +53,7 @@ static LIST_HEAD(nvmem_cell_tables);
 static DEFINE_MUTEX(nvmem_lookup_mutex);
 static LIST_HEAD(nvmem_lookup_list);
 
+struct notifier_block nvmem_nb;
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
 static DEFINE_SPINLOCK(nvmem_layout_lock);
@@ -771,23 +772,16 @@ EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
 static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
 {
 	struct device_node *layout_np;
-	struct nvmem_layout *l, *layout = ERR_PTR(-EPROBE_DEFER);
+	struct nvmem_layout *l, *layout = NULL;
 
 	layout_np = of_nvmem_layout_get_container(nvmem);
 	if (!layout_np)
 		return NULL;
 
-	/*
-	 * In case the nvmem device was built-in while the layout was built as a
-	 * module, we shall manually request the layout driver loading otherwise
-	 * we'll never have any match.
-	 */
-	of_request_module(layout_np);
-
 	spin_lock(&nvmem_layout_lock);
 
 	list_for_each_entry(l, &nvmem_layouts, node) {
-		if (of_match_node(l->of_match_table, layout_np)) {
+		if (of_match_node(l->dev->driver->of_match_table, layout_np)) {
 			if (try_module_get(l->owner))
 				layout = l;
 
@@ -821,14 +815,6 @@ static int nvmem_add_cells_from_layout(struct nvmem_device *nvmem)
 	return 0;
 }
 
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
@@ -836,7 +822,7 @@ const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 	const struct of_device_id *match;
 
 	layout_np = of_nvmem_layout_get_container(nvmem);
-	match = of_match_node(layout->of_match_table, layout_np);
+	match = of_match_node(layout->dev->driver->of_match_table, layout_np);
 
 	return match ? match->data : NULL;
 }
@@ -947,19 +933,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
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
@@ -978,24 +951,23 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_layout(nvmem);
-	if (rval)
-		goto err_remove_cells;
-
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
 	rval = device_add(&nvmem->dev);
 	if (rval)
 		goto err_remove_cells;
 
+	/* Populate the layout bus */
+	rval = nvmem_populate_layout(nvmem);
+	if (rval)
+		goto err_remove_cells;
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
 
 err_remove_cells:
 	nvmem_device_remove_all_cells(nvmem);
-	nvmem_layout_put(nvmem->layout);
-err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
 err_put_device:
@@ -2097,13 +2069,122 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
+static void nvmem_try_loading_layout_driver(struct nvmem_device *nvmem)
+{
+	struct device_node *layout_np;
+
+	layout_np = of_nvmem_layout_get_container(nvmem);
+	if (layout_np) {
+		of_request_module(layout_np);
+		of_node_put(layout_np);
+	}
+}
+
+static int nvmem_match_available_layout(struct nvmem_device *nvmem)
+{
+	int ret;
+
+	if (nvmem->layout)
+		return 0;
+
+	nvmem->layout = nvmem_layout_get(nvmem);
+	if (!nvmem->layout)
+		return 0;
+
+	ret = nvmem_add_cells_from_layout(nvmem);
+	if (ret) {
+		nvmem_layout_put(nvmem->layout);
+		nvmem->layout = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int nvmem_dev_match_available_layout(struct device *dev, void *data)
+{
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+
+	return nvmem_match_available_layout(nvmem);
+}
+
+static int nvmem_for_each_dev(int (*fn)(struct device *dev, void *data))
+{
+	return bus_for_each_dev(&nvmem_bus_type, NULL, NULL, fn);
+}
+
+/*
+ * When an NVMEM device is registered, try to match against a layout and
+ * populate the cells. When an NVMEM layout is probed, ensure all NVMEM devices
+ * which could use it properly expose their cells.
+ */
+static int nvmem_notifier_call(struct notifier_block *notifier,
+			       unsigned long event_flags, void *context)
+{
+	struct nvmem_device *nvmem = NULL;
+	int ret;
+
+	switch (event_flags) {
+	case NVMEM_ADD:
+		nvmem = context;
+		break;
+	case NVMEM_LAYOUT_ADD:
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	if (nvmem) {
+		/*
+		 * In case the nvmem device was built-in while the layout was
+		 * built as a module, manually request loading the layout driver.
+		 */
+		nvmem_try_loading_layout_driver(nvmem);
+
+		/* Populate the cells of the new nvmem device from its layout, if any */
+		ret = nvmem_match_available_layout(nvmem);
+	} else {
+		/* NVMEM devices might be "waiting" for this layout */
+		ret = nvmem_for_each_dev(nvmem_dev_match_available_layout);
+	}
+
+	if (ret)
+		return notifier_from_errno(ret);
+
+	return NOTIFY_OK;
+}
+
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
+		goto unregister_nvmem_bus;
+
+	nvmem_nb.notifier_call = &nvmem_notifier_call;
+	ret = nvmem_register_notifier(&nvmem_nb);
+	if (ret)
+		goto unregister_nvmem_layout_bus;
+
+	return 0;
+
+unregister_nvmem_layout_bus:
+	nvmem_layout_bus_unregister();
+unregister_nvmem_bus:
+	bus_unregister(&nvmem_bus_type);
+
+	return ret;
 }
 
 static void __exit nvmem_exit(void)
 {
+	nvmem_unregister_notifier(&nvmem_nb);
+	nvmem_layout_bus_unregister();
 	bus_unregister(&nvmem_bus_type);
 }
 
diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
index ce353831cd65..eb73b59d1fd9 100644
--- a/drivers/nvmem/internals.h
+++ b/drivers/nvmem/internals.h
@@ -32,4 +32,8 @@ struct nvmem_device {
 	void *priv;
 };
 
+int nvmem_layout_bus_register(void);
+void nvmem_layout_bus_unregister(void);
+int nvmem_populate_layout(struct nvmem_device *nvmem);
+
 #endif  /* ifndef _LINUX_NVMEM_INTERNALS_H */
diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
new file mode 100644
index 000000000000..3b11ec70edec
--- /dev/null
+++ b/drivers/nvmem/layouts.c
@@ -0,0 +1,171 @@
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
+#if CONFIG_OF
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
+int __nvmem_layout_driver_register(struct nvmem_layout_driver *drv,
+				   struct module *owner)
+{
+	drv->driver.owner = owner;
+	drv->driver.bus = &nvmem_layout_bus_type;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(__nvmem_layout_driver_register);
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
+static struct device *of_nvmem_layout_create_device(struct device_node *np)
+{
+	struct device *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return NULL;
+
+	device_initialize(dev);
+	dev->parent = &nvmem_layout_bus;
+	dev->bus = &nvmem_layout_bus_type;
+	dev->release = nvmem_layout_device_release;
+	dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	dev->dma_mask = &dev->coherent_dma_mask;
+	device_set_node(dev, of_fwnode_handle(of_node_get(np)));
+	of_device_make_bus_id(dev);
+	of_msi_configure(dev, dev->of_node);
+
+	if (device_add(dev)) {
+		put_device(dev);
+		return NULL;
+	}
+
+	return dev;
+}
+
+static const struct of_device_id of_nvmem_layout_skip_table[] = {
+	{ .compatible = "fixed-layout", },
+	{}
+};
+
+static int of_nvmem_layout_bus_populate(struct device_node *layout_dn)
+{
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
+	of_nvmem_layout_create_device(layout_dn);
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
+int nvmem_populate_layout(struct nvmem_device *nvmem)
+{
+	struct device_node *nvmem_dn, *layout_dn;
+	int ret;
+
+	nvmem_dn = of_node_get(nvmem->dev.of_node);
+	if (!nvmem_dn)
+		return 0;
+
+	layout_dn = of_nvmem_layout_get_container(nvmem);
+	if (!layout_dn) {
+		of_node_put(nvmem_dn);
+		return 0;
+	}
+
+	device_links_supplier_sync_state_pause();
+	ret = of_nvmem_layout_bus_populate(layout_dn);
+	device_links_supplier_sync_state_resume();
+
+	of_node_set_flag(nvmem_dn, OF_POPULATED_BUS);
+
+	of_node_put(layout_dn);
+	of_node_put(nvmem_dn);
+	return ret;
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
index 59fc87ccfcff..9c269e389b28 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -13,6 +13,7 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 
 #define ONIE_TLV_MAX_LEN 2048
 #define ONIE_TLV_CRC_FIELD_SZ 6
@@ -226,16 +227,44 @@ static int onie_tlv_parse_table(struct device *dev, struct nvmem_device *nvmem,
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
index 05671371f631..6857b1472288 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -5,6 +5,7 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <uapi/linux/if_ether.h>
 
 #define SL28VPD_MAGIC 'V'
@@ -135,16 +136,44 @@ static int sl28vpd_add_cells(struct device *dev, struct nvmem_device *nvmem,
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
index d260738ad03c..a1b982f4092e 100644
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
@@ -202,6 +204,15 @@ int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner);
 	__nvmem_layout_register(layout, THIS_MODULE)
 void nvmem_layout_unregister(struct nvmem_layout *layout);
 
+#define nvmem_layout_driver_register(drv) \
+	__nvmem_layout_driver_register(drv, THIS_MODULE)
+int __nvmem_layout_driver_register(struct nvmem_layout_driver *drv,
+				   struct module *owner);
+void nvmem_layout_driver_unregister(struct nvmem_layout_driver *drv);
+#define module_nvmem_layout_driver(__nvmem_layout_driver)		\
+	module_driver(__nvmem_layout_driver, nvmem_layout_driver_register, \
+		      nvmem_layout_driver_unregister)
+
 const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 					struct nvmem_layout *layout);
 
@@ -257,9 +268,4 @@ static inline struct device_node *of_nvmem_layout_get_container(struct nvmem_dev
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

