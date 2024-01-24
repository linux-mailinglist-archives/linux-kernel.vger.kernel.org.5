Return-Path: <linux-kernel+bounces-36969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE67783A9A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F260287AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AA465BBE;
	Wed, 24 Jan 2024 12:22:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575F634F7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098951; cv=none; b=Lfje9tsKS3+w4nIBty3bWV466cJkn4LaKlQ89pBa2VYuXYCusWaZ97kr38iRg88NffHo783+5aDML9akpt/3z+wzVLwKVLi80qaQ7ShtK2mMqc5vzZ2VUXDpb4DjevOwG2DZY7Tj63mRndJRwHfovWCWmox75bMwDpaGzv9C6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098951; c=relaxed/simple;
	bh=Q7CJ22s7cVnisV7JjfaOll6mFN9dCNJwXRW0hKY8Xlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=llMqPsY/riYZX0SJ1GL51LQ8AxwxULXxNCiDDESl4UOczHKMArjk2jmoyC9gohNeAKnQuY42qJG+VTFHzZkjSy0k2jPQEHIi9A0GyDAV7mAIj7AevCBQ5KydRNWIjXepfjz1m8G8B5pIqRAK5mRJo9IdusUICa66MYo2ECCKYPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGd-0007o7-1C; Wed, 24 Jan 2024 13:22:07 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGc-0023Zd-0H; Wed, 24 Jan 2024 13:22:06 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGb-00341E-30;
	Wed, 24 Jan 2024 13:22:05 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v2 3/8] power: reset: Introduce PSCR Recording Framework for Non-Volatile Storage
Date: Wed, 24 Jan 2024 13:21:59 +0100
Message-Id: <20240124122204.730370-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124122204.730370-1-o.rempel@pengutronix.de>
References: <20240124122204.730370-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This commit introduces the Power State Change Reasons Recording (PSCRR)
framework into the kernel. The framework is vital for systems where
PMICs or watchdogs cannot provide information on power state changes. It
stores reasons for system shutdowns and reboots, like under-voltage or
software-triggered events, in non-volatile hardware storage. This
approach is essential for postmortem analysis in scenarios where
traditional storage methods (block devices, RAM) are not feasible. The
framework aids bootloaders and early-stage system components in recovery
decision-making, although it does not cover resets caused by hardware
issues like system freezes or watchdog timeouts.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/power/reset/Kconfig  |  19 ++
 drivers/power/reset/Makefile |   1 +
 drivers/power/reset/pscrr.c  | 353 +++++++++++++++++++++++++++++++++++
 include/linux/pscrr.h        |  73 ++++++++
 4 files changed, 446 insertions(+)
 create mode 100644 drivers/power/reset/pscrr.c
 create mode 100644 include/linux/pscrr.h

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fece990af4a7..c6ce7e647048 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -305,3 +305,22 @@ config POWER_MLXBF
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
 endif
+
+menuconfig PSCRR
+    bool "Power State Change Reasons (PSCR) Recording Framework"
+    help
+      Enables the Power State Change Reasons (PSCR) Recording framework.
+
+      This framework is designed to store reasons for system shutdowns or
+      reboots,  like under voltage or software-triggered events, in non-volatile
+      hardware storage. It is particularly useful for postmortem analysis, where
+      traditional storage methods (like block devices or RAM) are not feasible
+      due to immediate power-down requirements or insufficient power to retain
+      data.
+
+      This is useful for bootloaders or other early-stage system components to
+      make recovery decisions based on the last known system state. Note that it
+      does not cover hardware-induced resets like system freezes or watchdog
+      timeouts.
+
+      If unsure, say N.
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index a95d1bd275d1..e618c34a30f9 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
 obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
+obj-$(CONFIG_PSCRR) += pscrr.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
new file mode 100644
index 000000000000..651fc210878d
--- /dev/null
+++ b/drivers/power/reset/pscrr.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2016, Fuzhou Rockchip Electronics Co., Ltd
+// Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+/*
+ * Based on drivers/power/reset/reboot-mode.c
+ * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/power/power_on_reason.h>
+#include <linux/pscrr.h>
+#include <linux/reboot.h>
+
+#define PREFIX "pscr-"
+
+enum pscr system_pscr;
+
+/*
+ * struct pscr_to_magic_entry - Entry for mapping PSCR to magic values.
+ *
+ * This structure represents a single entry in a list that maps Power State
+ * Change Reason (PSCR) values to corresponding magic values. Each entry
+ * associates a specific PSCR with a unique magic value, facilitating easy
+ * translation between the two.
+ *
+ * @pscr: The PSCR value.
+ * @magic: The corresponding magic value.
+ * @list: List head for chaining multiple such entries.
+ */
+struct pscr_to_magic_entry {
+	enum pscr pscr;
+	u32 magic;
+	struct list_head list;
+};
+
+/*
+ * struct pscr_map - Maps device tree property names to PSCR values.
+ *
+ * @dt_prop_name: Device tree property name without the "pscr-" prefix.
+ * @pscr: The corresponding PSCR enum value for the given property name.
+ */
+struct pscr_map {
+	const char *dt_prop_name;
+	enum pscr pscr;
+};
+
+/*
+ * struct pscr_map - Maps shortened DT property names to PSCR values.
+ *
+ * This structure maps device tree property names, with the "pscr-" prefix
+ * omitted, to their corresponding Power State Change Reason (PSCR) values.
+ */
+struct pscr_map pscr_map_table[] = {
+	{ "under-voltage", PSCR_UNDER_VOLTAGE },
+	{ "over-current", PSCR_OVER_CURRENT },
+	{ "regulator-failure", PSCR_REGULATOR_FAILURE },
+	{ "over-temperature", PSCR_OVERTEMPERATURE },
+};
+
+/*
+ * pscr_find_from_dt_name - Finds the PSCR value for a given DT property name.
+ *
+ * @dt_prop_name: The device tree property name, without the "pscr-" prefix, to
+ * look up.
+ * Returns the corresponding PSCR value or -ENOENT if not found.
+ */
+static int find_pscr_by_string(const char *dt_prop_name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pscr_map_table); i++) {
+		if (!strcmp(dt_prop_name, pscr_map_table[i].dt_prop_name))
+			return pscr_map_table[i].pscr;
+	}
+
+	return -ENOENT;
+}
+
+static enum pscr get_pscr_by_magic(struct pscrr_device *pscrr_dev, u32 magic)
+{
+	struct pscr_to_magic_entry *map_entry;
+
+	list_for_each_entry(map_entry, &pscrr_dev->pscr_map_list, list) {
+		if (map_entry->magic == magic)
+			return map_entry->pscr;
+	}
+
+	return 0;
+}
+
+static u32 get_magic_by_pscr(struct pscrr_device *pscrr_dev, enum pscr pscr)
+{
+	struct pscr_to_magic_entry *map_entry;
+
+	list_for_each_entry(map_entry, &pscrr_dev->pscr_map_list, list) {
+		if (map_entry->pscr == pscr)
+			return map_entry->magic;
+	}
+
+	return 0;
+}
+
+/**
+ * set_power_state_change_reason() - Set the system's power state change reason
+ * @pscr: The enum value representing the power state change reason
+ *
+ * This function sets the system's power state change reason based on the
+ * provided enum value.
+ */
+void set_power_state_change_reason(enum pscr pscr)
+{
+	system_pscr = pscr;
+}
+EXPORT_SYMBOL_GPL(set_power_state_change_reason);
+
+static const char *pscr_to_por_string(enum pscr pscr)
+{
+	switch (pscr) {
+	case PSCR_UNDER_VOLTAGE:
+		return POWER_ON_REASON_BROWN_OUT;
+	case PSCR_OVER_CURRENT:
+		return POWER_ON_REASON_OVER_CURRENT;
+	case PSCR_REGULATOR_FAILURE:
+		return POWER_ON_REASON_REGULATOR_FAILURE;
+	case PSCR_OVERTEMPERATURE:
+		return POWER_ON_REASON_OVERTEMPERATURE;
+	default:
+	}
+
+	return POWER_ON_REASON_UNKNOWN;
+}
+
+static ssize_t power_state_change_reason_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct pscrr_device *pscrr_dev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", pscr_to_por_string(pscrr_dev->last_pscr));
+}
+static DEVICE_ATTR_RO(power_state_change_reason);
+
+int handle_last_pscr(struct pscrr_device *pscrr_dev)
+{
+	u32 magic;
+	int ret;
+
+	ret = pscrr_dev->read(pscrr_dev, &magic);
+	if (ret)
+		return ret;
+
+	pscrr_dev->last_pscr = get_pscr_by_magic(pscrr_dev, magic);
+
+	dev_info(pscrr_dev->dev, "Last recorded power state change reason: %s\n",
+		 pscr_to_por_string(pscrr_dev->last_pscr));
+
+	ret = pscrr_dev->write(pscrr_dev, 0);
+	if (ret)
+		dev_err(pscrr_dev->dev, "Failed to clear power state change reason\n");
+
+	return ret;
+}
+
+static int pscrr_notify(struct notifier_block *this, unsigned long x, void *c)
+{
+	struct pscrr_device *pscrr_dev = container_of(this, struct pscrr_device,
+						      reboot_notifier);
+	u32 magic;
+
+	magic = get_magic_by_pscr(pscrr_dev, system_pscr);
+	pscrr_dev->write(pscrr_dev, magic);
+
+	return NOTIFY_DONE;
+}
+
+/**
+ * pscrr_process_property() - Process a power state change reason property
+ * @pscrr_dev: Pointer to the pscrr_device structure
+ * @prop: Pointer to the property structure to be processed
+ *
+ * This function processes a device tree property representing a power state
+ * change reason and initializes the relevant data structures.
+ *
+ * Returns: 0 on success, -ENOMEM on memory allocation failure.
+ */
+static int pscrr_process_property(struct pscrr_device *pscrr_dev,
+				  struct property *prop)
+{
+	struct pscr_to_magic_entry *map_entry;
+	struct device *dev = pscrr_dev->dev;
+	size_t len = strlen(PREFIX);
+	int ret;
+
+	if (strncmp(prop->name, PREFIX, len))
+		return 0;
+
+	map_entry = devm_kzalloc(dev, sizeof(*map_entry), GFP_KERNEL);
+	if (!map_entry)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(dev->of_node, prop->name, &map_entry->magic);
+	if (ret) {
+		dev_err(dev, "Can't read magic number for %s: %pe\n",
+			prop->name, ERR_PTR(ret));
+		devm_kfree(dev, map_entry);
+		return 0;
+	}
+
+	if (!map_entry->magic) {
+		dev_err(dev, "%s with magic number == 0\n", prop->name);
+		devm_kfree(dev, map_entry);
+		return 0;
+	}
+
+	map_entry->pscr = find_pscr_by_string(prop->name + len);
+	if (map_entry->pscr < 0) {
+		dev_err(dev, "unsupported reason name(%s): %pe\n",
+			prop->name, ERR_PTR(map_entry->pscr));
+		devm_kfree(dev, map_entry);
+		return 0;
+	}
+
+	if (map_entry->magic > pscrr_dev->max_magic_val)
+		pscrr_dev->max_magic_val = map_entry->magic;
+
+	dev_dbg(dev, "registering reason = %s, magic = %d, pscr = %d\n",
+		prop->name, map_entry->magic, map_entry->pscr);
+	list_add_tail(&map_entry->list, &pscrr_dev->pscr_map_list);
+
+	return 0;
+}
+
+/*
+ * pscrr_register() - Register the pscr driver and initialize power state change
+ *                   reasons
+ * @pscrr_dev: Pointer to the pscrr_device structure
+ *
+ * This function registers the pscr driver and initializes power state change
+ * reasons based on device tree properties.
+ *
+ * Returns: 0 on success, -ENOMEM on memory allocation failure
+ */
+int pscrr_register(struct pscrr_device *pscrr_dev)
+{
+	struct device_node *np = pscrr_dev->dev->of_node;
+	struct property *prop;
+	int ret;
+
+	INIT_LIST_HEAD(&pscrr_dev->pscr_map_list);
+
+	for_each_property_of_node(np, prop) {
+		ret = pscrr_process_property(pscrr_dev, prop);
+		if (ret)
+			return ret;
+	}
+
+	pscrr_dev->reboot_notifier.notifier_call = pscrr_notify;
+	register_reboot_notifier(&pscrr_dev->reboot_notifier);
+
+	dev_set_drvdata(pscrr_dev->dev, pscrr_dev);
+
+	ret = device_create_file(pscrr_dev->dev, &dev_attr_power_state_change_reason);
+	if (ret)
+		dev_err(pscrr_dev->dev, "Could not create sysfs entry\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pscrr_register);
+
+/*
+ * pscrr_unregister() - Unregister the pscr driver's reboot notifier
+ * @pscrr_dev: Pointer to the pscrr_device structure
+ *
+ * This function unregisters the reboot notifier for the pscr driver.
+ */
+void pscrr_unregister(struct pscrr_device *pscrr_dev)
+{
+	unregister_reboot_notifier(&pscrr_dev->reboot_notifier);
+}
+EXPORT_SYMBOL_GPL(pscrr_unregister);
+
+static void devm_pscrr_release(struct device *dev, void *res)
+{
+	pscrr_unregister(*(struct pscrr_device **)res);
+}
+
+/**
+ * devm_pscrr_register - Register a device-managed PSCR driver
+ * @dev: Device to associate the PSCR driver with
+ * @pscrr_dev: Pointer to the PSCR driver to be registered
+ *
+ * Registers a Power State Change Reason (PSCR) driver as a device-managed
+ * resource.
+ *
+ * Returns: 0 on successful registration or a negative error code on failure.
+ */
+int devm_pscrr_register(struct device *dev, struct pscrr_device *pscrr_dev)
+{
+	struct pscrr_device **dr;
+	int rc;
+
+	dr = devres_alloc(devm_pscrr_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	rc = pscrr_register(pscrr_dev);
+	if (rc) {
+		devres_free(dr);
+		return rc;
+	}
+
+	*dr = pscrr_dev;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_pscrr_register);
+
+static int devm_pscrr_match(struct device *dev, void *res, void *data)
+{
+	struct pscrr_device **p = res;
+
+	if (WARN_ON(!p || !*p))
+		return 0;
+
+	return *p == data;
+}
+
+/**
+ * devm_pscrr_unregister - Unregister a managed PSCR driver
+ * @dev: Device associated with the PSCR driver
+ * @pscrr_dev: Pointer to the PSCR driver to unregister
+ *
+ * Unregisters a device-managed Power State Change Reason (PSCR) driver.
+ * It handles the cleanup and release of resources associated with the PSCR
+ * driver which was previously registered.
+ */
+void devm_pscrr_unregister(struct device *dev,
+			   struct pscrr_device *pscrr_dev)
+{
+	WARN_ON(devres_release(dev,
+			       devm_pscrr_release,
+			       devm_pscrr_match, pscrr_dev));
+}
+EXPORT_SYMBOL_GPL(devm_pscrr_unregister);
+
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_DESCRIPTION("Power State Change Reason (PSCR) Recording framework");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pscrr.h b/include/linux/pscrr.h
new file mode 100644
index 000000000000..2de9d9bc9aeb
--- /dev/null
+++ b/include/linux/pscrr.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PSCRR_H__
+#define __PSCRR_H__
+
+/*
+ * enum pscr - Enumerates reasons for power state changes.
+ *
+ * This enum lists the various reasons why a power state change might
+ * occur in a system. Each value represents a specific condition that
+ * could trigger a change in power state, such as shutdown or reboot.
+ *
+ * PSCR_UNKNOWN: Represents an unknown or unspecified reason.
+ * PSCR_UNDER_VOLTAGE: Indicates a power state change due to under-voltage.
+ * PSCR_OVER_CURRENT: Indicates a power state change due to over-current.
+ * PSCR_REGULATOR_FAILURE: Indicates a failure in a voltage regulator.
+ * PSCR_OVERTEMPERATURE: Indicates an over-temperature condition.
+ */
+enum pscr {
+	PSCR_UNKNOWN,
+	PSCR_UNDER_VOLTAGE,
+	PSCR_OVER_CURRENT,
+	PSCR_REGULATOR_FAILURE,
+	PSCR_OVERTEMPERATURE,
+};
+
+/*
+ * struct pscrr_device - Manages a Power State Change Reason Recorder device.
+ *
+ * This structure is utilized for controlling a device responsible for
+ * recording reasons for power state changes (PSCR). It includes mechanisms
+ * for mapping PSCR values to specific magic codes, storing these mappings,
+ * and recovering the last PSCR value from storage during system start-up.
+ *
+ * @dev: Device structure pointer.
+ * @pscr_map_list: List head for structs holding PSCR to magic code mappings.
+ * @write: Function pointer to write a new mapped PSCR value.
+ * @read: Function pointer to read the current mapped PSCR value.
+ * @reboot_notifier: Notifier block for recording PSCR at reboot.
+ * @max_magic_val: Maximum permissible magic code, used for verifying storage
+ *                 capacity and mapping integrity.
+ * @last_pscr: Last PSCR value recovered from storage at system start,
+ *             representing the reason for the last system power cycle.
+ */
+struct pscrr_device {
+	struct device *dev;
+	struct list_head pscr_map_list;
+	int (*write)(struct pscrr_device *pscrr_dev, u32 magic);
+	int (*read)(struct pscrr_device *pscrr_dev, u32 *magic);
+	struct notifier_block reboot_notifier;
+	u32 max_magic_val;
+	enum pscr last_pscr;
+};
+
+int pscrr_register(struct pscrr_device *pscrr_dev);
+void pscrr_unregister(struct pscrr_device *pscrr_dev);
+int devm_pscrr_register(struct device *dev,
+			struct pscrr_device *pscrr_dev);
+void devm_pscrr_unregister(struct device *dev,
+			   struct pscrr_device *pscrr_dev);
+int handle_last_pscr(struct pscrr_device *pscrr_dev);
+
+#if IS_ENABLED(CONFIG_PSCRR)
+
+void set_power_state_change_reason(enum pscr pscr);
+
+#else
+
+static inline void set_power_state_change_reason(enum pscr pscr)
+{
+}
+#endif
+
+#endif
-- 
2.39.2


