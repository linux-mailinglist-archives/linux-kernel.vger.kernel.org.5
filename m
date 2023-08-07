Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78947771C3C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjHGIYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjHGIYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:24:31 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8FF170A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:24:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B5EBDE0007;
        Mon,  7 Aug 2023 08:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691396668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQ7q+S0WA0btHb97Zj7i/4YX+TmscMRWUDpKDDLHHz0=;
        b=XqFD2h4SHy90or4PHN6ihAb8LqwK6j9Hbtm77HM1DnMgJIR7h81TILlSsKASbc2TejCYDc
        cJ5qdXbsgReTISed192tNsSqXnZQc/28xsMou2Bhru45wokp7/csujF2Hg8JlIHbSOh+vN
        Km9co7BsbGYo7gOnoV8WePfs/sTwaEH660la/epu/171u5Nx5/kkgf36848k8RaRamfGpo
        qqf+lNKqEXUOWknQ36Zw7rBpys53X6e37e2UL889cLv2AOzwWzmr6f6hDHCXXBiEMlILTj
        PNhq0IR+jDY7mCc4e05c0OGIaAHtAePOkA77plwLQkVRIdcZd93dlo1x6s84/g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v8 6/8] nvmem: core: Rework layouts to become platform devices
Date:   Mon,  7 Aug 2023 10:24:17 +0200
Message-Id: <20230807082419.38780-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807082419.38780-1-miquel.raynal@bootlin.com>
References: <20230807082419.38780-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c             | 132 ++++++++++++++++++++++++-------
 drivers/nvmem/layouts/onie-tlv.c |  39 +++++++--
 drivers/nvmem/layouts/sl28vpd.c  |  39 +++++++--
 include/linux/nvmem-provider.h   |  11 +--
 4 files changed, 172 insertions(+), 49 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0406fbc7b750..868a6f8b3227 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -80,6 +80,7 @@ static LIST_HEAD(nvmem_lookup_list);
 static DEFINE_MUTEX(nvmem_devices_mutex);
 static LIST_HEAD(nvmem_devices_list);
 
+struct notifier_block nvmem_nb;
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
 static DEFINE_SPINLOCK(nvmem_layout_lock);
@@ -795,23 +796,16 @@ EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
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
 
@@ -868,7 +862,7 @@ const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 	const struct of_device_id *match;
 
 	layout_np = of_nvmem_layout_get_container(nvmem);
-	match = of_match_node(layout->of_match_table, layout_np);
+	match = of_match_node(layout->dev->driver->of_match_table, layout_np);
 
 	return match ? match->data : NULL;
 }
@@ -887,6 +881,7 @@ EXPORT_SYMBOL_GPL(nvmem_layout_get_match_data);
 struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 {
 	struct nvmem_device *nvmem;
+	struct device_node *layout_np;
 	int rval;
 
 	if (!config->dev)
@@ -979,19 +974,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
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
@@ -1010,16 +992,21 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
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
 
+	/* Populate layouts as devices */
+	layout_np = of_nvmem_layout_get_container(nvmem);
+	if (layout_np) {
+		rval = of_platform_populate(nvmem->dev.of_node, NULL, NULL, NULL);
+		if (rval)
+			goto err_remove_cells;
+		of_node_put(layout_np);
+	}
+
 	mutex_lock(&nvmem_devices_mutex);
 	list_add_tail(&nvmem->node, &nvmem_devices_list);
 	mutex_unlock(&nvmem_devices_mutex);
@@ -1030,8 +1017,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 err_remove_cells:
 	nvmem_device_remove_all_cells(nvmem);
-	nvmem_layout_put(nvmem->layout);
-err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
 err_put_device:
@@ -2137,13 +2122,100 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
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
+static int nvmem_try_matching_available_layout(struct nvmem_device *nvmem)
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
+	if (ret)
+		goto put_layout;
+
+	return 0;
+
+put_layout:
+	nvmem_layout_put(nvmem->layout);
+	return ret;
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
+	struct nvmem_device *nvmem = NULL, *tmp;
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
+		ret = nvmem_try_matching_available_layout(nvmem);
+		if (ret)
+			return notifier_from_errno(ret);
+
+		return NOTIFY_OK;
+	}
+
+	/* NVMEM devices might be "waiting" for this layout */
+	list_for_each_entry_safe(nvmem, tmp, &nvmem_devices_list, node) {
+		ret = nvmem_try_matching_available_layout(nvmem);
+		if (ret)
+			return notifier_from_errno(ret);
+	}
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
+	nvmem_nb.notifier_call = &nvmem_notifier_call;
+	return nvmem_register_notifier(&nvmem_nb);
 }
 
 static void __exit nvmem_exit(void)
 {
+	nvmem_unregister_notifier(&nvmem_nb);
 	bus_unregister(&nvmem_bus_type);
 }
 
diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 59fc87ccfcff..3d54d3be2c93 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -13,6 +13,7 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 
 #define ONIE_TLV_MAX_LEN 2048
 #define ONIE_TLV_CRC_FIELD_SZ 6
@@ -226,18 +227,46 @@ static int onie_tlv_parse_table(struct device *dev, struct nvmem_device *nvmem,
 	return 0;
 }
 
+static int onie_tlv_probe(struct platform_device *pdev)
+{
+	struct nvmem_layout *layout;
+
+	layout = devm_kzalloc(&pdev->dev, sizeof(*layout), GFP_KERNEL);
+	if (!layout)
+		return -ENOMEM;
+
+	layout->add_cells = onie_tlv_parse_table;
+	layout->dev = &pdev->dev;
+
+	platform_set_drvdata(pdev, layout);
+
+	return nvmem_layout_register(layout);
+}
+
+static int onie_tlv_remove(struct platform_device *pdev)
+{
+	struct nvmem_layout *layout = platform_get_drvdata(pdev);
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
+static struct platform_driver onie_tlv_layout = {
+	.driver = {
+		.name = "onie-tlv-layout",
+		.of_match_table = onie_tlv_of_match_table,
+	},
+	.probe = onie_tlv_probe,
+	.remove = onie_tlv_remove,
 };
-module_nvmem_layout_driver(onie_tlv_layout);
+module_platform_driver(onie_tlv_layout);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index 05671371f631..ad0c39fc7943 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -5,6 +5,7 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <uapi/linux/if_ether.h>
 
 #define SL28VPD_MAGIC 'V'
@@ -135,18 +136,46 @@ static int sl28vpd_add_cells(struct device *dev, struct nvmem_device *nvmem,
 	return 0;
 }
 
+static int sl28vpd_probe(struct platform_device *pdev)
+{
+	struct nvmem_layout *layout;
+
+	layout = devm_kzalloc(&pdev->dev, sizeof(*layout), GFP_KERNEL);
+	if (!layout)
+		return -ENOMEM;
+
+	layout->add_cells = sl28vpd_add_cells;
+	layout->dev = &pdev->dev;
+
+	platform_set_drvdata(pdev, layout);
+
+	return nvmem_layout_register(layout);
+}
+
+static int sl28vpd_remove(struct platform_device *pdev)
+{
+	struct nvmem_layout *layout = platform_get_drvdata(pdev);
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
+static struct platform_driver sl28vpd_layout = {
+	.driver = {
+		.name = "kontron-sl28vpd-layout",
+		.of_match_table = sl28vpd_of_match_table,
+	},
+	.probe = sl28vpd_probe,
+	.remove = sl28vpd_remove,
 };
-module_nvmem_layout_driver(sl28vpd_layout);
+module_platform_driver(sl28vpd_layout);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index dae26295e6be..c72064780b50 100644
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
@@ -243,9 +241,4 @@ nvmem_layout_get_match_data(struct nvmem_device *nvmem,
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

