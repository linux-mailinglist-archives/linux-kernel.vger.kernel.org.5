Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5830D7B5D3D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjJBWkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjJBWkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:40:41 -0400
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB6B7;
        Mon,  2 Oct 2023 15:40:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 648DC82859F5;
        Mon,  2 Oct 2023 17:32:37 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RwqQdCb5DVhl; Mon,  2 Oct 2023 17:32:35 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 4A44D8286991;
        Mon,  2 Oct 2023 17:32:35 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 4A44D8286991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1696285955; bh=FENQxFl2vU5NVFpz+ChM8Sok4Y7J//ItdVczRNx9FMQ=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=HGb0Hv/iId7ARLXjt791adsqDCnxcIdPRq2El3tXZcCiKSVahxIXtgwWPn7HKmY1H
         K5AajneV1JfJw6dA0We7zttvcSHnwlh4C/5DGMa5Ti8SOntzF1RtztXsQVll5VFCL0
         2Brt1r+5rSmORRc0FIaFTPOOo+hQf8YBszL85E8c=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hYrUXDMnt-DJ; Mon,  2 Oct 2023 17:32:34 -0500 (CDT)
Received: from raptor-ewks-026.lan (5.edge.rptsys.com [23.155.224.38])
        by mail.rptsys.com (Postfix) with ESMTPSA id 5524F828574D;
        Mon,  2 Oct 2023 17:32:34 -0500 (CDT)
From:   Shawn Anastasio <sanastasio@raptorengineering.com>
To:     devicetree@vger.kernel.org, lee@kernel.org
Cc:     Timothy Pearson <tpearson@raptorengineering.com>,
        linux-kernel@vger.kernel.org,
        Georgy Yakovlev <Georgy.Yakovlev@sony.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: [PATCH 3/3] mfd: sie-cronos-cpld: Add driver for SIE cronos CPLD
Date:   Mon,  2 Oct 2023 17:32:22 -0500
Message-Id: <2e9763cb4fa258fe11769a4ff1544d96c536a4a2.1696285339.git.sanastasio@raptorengineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1696285339.git.sanastasio@raptorengineering.com>
References: <cover.1696285339.git.sanastasio@raptorengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timothy Pearson <tpearson@raptorengineering.com>

The SIE Cronos Platform Controller CPLD is a multi-purpose platform
controller that provides both a watchdog timer and an LED controller. As
both functions are provided by the same CPLD, a multi-function device is
exposed as the parent of both functions.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
---
 MAINTAINERS                              |   7 +
 drivers/mfd/Kconfig                      |  11 +
 drivers/mfd/Makefile                     |   1 +
 drivers/mfd/sie-cronos-cpld.c            | 589 +++++++++++++++++++++++
 include/linux/mfd/sie/cronos/core.h      |  17 +
 include/linux/mfd/sie/cronos/registers.h |  59 +++
 6 files changed, 684 insertions(+)
 create mode 100644 drivers/mfd/sie-cronos-cpld.c
 create mode 100644 include/linux/mfd/sie/cronos/core.h
 create mode 100644 include/linux/mfd/sie/cronos/registers.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 79630b7d946e..1e9c044455f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19545,6 +19545,13 @@ F:	drivers/media/mmc/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/

+SIE CRONOS CPLD DRIVER
+M:	Georgy Yakovlev <Georgy.Yakovlev@sony.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/sie,cronos-cpld.yaml
+F:	drivers/mfd/sie-cronos-cpld.c
+F:	include/linux/mfd/sie/cronos/
+
 SIEMENS IPC LED DRIVERS
 M:	Gerd Haeussler <gerd.haeussler.ext@siemens.com>
 M:	Xing Tong Wu <xingtong.wu@siemens.com>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index aea95745c73f..8312759ce5c9 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2216,6 +2216,17 @@ config MFD_QCOM_PM8008
 	  under it in the device tree. Additional drivers must be enabled in
 	  order to use the functionality of the device.

+config MFD_SIE_CRONOS_CPLD
+	tristate "SIE Cronos CPLD Support"
+	select MFD_CORE
+	select REGMAP_I2C
+	depends on I2C
+	help
+      Support for the SIE Cronos system control CPLDs. Additional drivers must
+      be enabled in order to use the functionality of the device, including LED
+      control and the system watchdog. The controller itself is a custom design
+      tailored to the specific needs of the SIE Cronos hardware platform.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index c66f07edcd0e..a580c549e3ab 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -284,3 +284,4 @@ rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
 rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
 obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
 obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
+obj-$(CONFIG_MFD_SIE_CRONOS_CPLD)	+= sie-cronos-cpld.o
diff --git a/drivers/mfd/sie-cronos-cpld.c b/drivers/mfd/sie-cronos-cpld.c
new file mode 100644
index 000000000000..43fc51e07e7f
--- /dev/null
+++ b/drivers/mfd/sie-cronos-cpld.c
@@ -0,0 +1,589 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * I2C device driver for SIE Cronos CPLDs
+ * Copyright (C) 2015-2017  Dialog Semiconductor
+ * Copyright (C) 2022  Raptor Engineering, LLC
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/regmap.h>
+#include <linux/mfd/core.h>
+#include <linux/i2c.h>
+#include <linux/mfd/sie/cronos/core.h>
+#include <linux/mfd/sie/cronos/registers.h>
+
+static struct resource cronos_wdt_resources[] = {
+};
+
+static struct resource cronos_led_resources[] = {
+};
+
+static const struct mfd_cell cronos_cpld_devs[] = {
+	{
+		.name          = "cronos-watchdog",
+		.num_resources = ARRAY_SIZE(cronos_wdt_resources),
+		.resources     = cronos_wdt_resources,
+		.of_compatible = "sie,cronos-watchdog",
+	},
+	{
+		.name          = "cronos-leds",
+		.id            = 1,
+		.num_resources = ARRAY_SIZE(cronos_led_resources),
+		.resources     = cronos_led_resources,
+		.of_compatible = "sie,cronos-leds",
+	},
+};
+
+static ssize_t payload_power_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	unsigned int payloadpower_val = 0;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	ret = regmap_read(chip->regmap, CRONOS_CPLD_PAYLOAD_POWER_CTL_REG, &payloadpower_val);
+	if (ret < 0)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "0x%02x\n", payloadpower_val);
+}
+
+static ssize_t payload_power_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	u8 val = 0;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	if (kstrtou8(buf, 0, &val))
+		return -EINVAL;
+
+	ret = regmap_write(chip->regmap, CRONOS_CPLD_PAYLOAD_POWER_CTL_REG, val);
+	if (ret) {
+		dev_err(dev, "Failed to write value 0x%02x to address 0x%02x",
+			val, CRONOS_CPLD_PAYLOAD_POWER_CTL_REG);
+		return ret;
+	}
+	return len;
+}
+
+
+static ssize_t bmc_flash_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	unsigned int bmcflash_val = 0;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	ret = regmap_read(chip->regmap, CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG, &bmcflash_val);
+	if (ret < 0)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "0x%02x\n", bmcflash_val);
+}
+
+static ssize_t bmc_flash_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
+{
+	u8 val = 0;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	if (kstrtou8(buf, 0, &val))
+		return -EINVAL;
+
+	ret = regmap_write(chip->regmap, CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG, val);
+	if (ret) {
+		dev_err(dev, "Failed to write value 0x%02x to address 0x%02x",
+			val, CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG);
+		return ret;
+	}
+	return len;
+}
+
+
+static ssize_t switch_reset_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	unsigned int switchreset_val = 0;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	ret = regmap_read(chip->regmap, CRONOS_CPLD_SWITCH_RESET_CMD_REG, &switchreset_val);
+	if (ret < 0)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "0x%02x\n", switchreset_val);
+}
+
+static ssize_t switch_reset_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	unsigned int switchreset_val = 0;
+	u8 val = -EINVAL;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	if (kstrtou8(buf, 0, &val))
+		return -EINVAL;
+
+	if (val != 1)
+		return -EINVAL;
+
+	ret = regmap_read(chip->regmap, CRONOS_CPLD_SWITCH_RESET_CMD_REG, &switchreset_val);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(chip->regmap, CRONOS_CPLD_SWITCH_RESET_CMD_REG, switchreset_val);
+	if (ret) {
+		dev_err(dev, "Failed to write value 0x%02x to address 0x%02x",
+				switchreset_val, CRONOS_CPLD_SWITCH_RESET_CMD_REG);
+		return ret;
+	}
+	return len;
+}
+
+
+static ssize_t switch_flash_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	unsigned int switchflash_val = 0;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	ret = regmap_read(chip->regmap, CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG, &switchflash_val);
+	if (ret < 0)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "0x%02x\n", switchflash_val);
+}
+
+static ssize_t switch_flash_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	u8 val = 0;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	if (kstrtou8(buf, 0, &val))
+		return -EINVAL;
+
+	ret = regmap_write(chip->regmap, CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG, val);
+	if (ret) {
+		dev_err(dev, "Failed to write value 0x%02x to address 0x%02x",
+			val, CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG);
+		return ret;
+	}
+	return len;
+}
+
+
+static ssize_t uart_mux_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	unsigned int uartmux_val = 0;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	ret = regmap_read(chip->regmap, CRONOS_CPLD_UART_MUX_REG, &uartmux_val);
+	if (ret < 0)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "0x%02x\n", uartmux_val);
+}
+
+static ssize_t uart_mux_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t len)
+{
+	u8 val = 0;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	if (kstrtou8(buf, 0, &val))
+		return -EINVAL;
+
+	ret = regmap_write(chip->regmap, CRONOS_CPLD_UART_MUX_REG, val);
+	if (ret) {
+		dev_err(dev, "Failed to write value 0x%02x to address 0x%02x",
+			val, CRONOS_CPLD_UART_MUX_REG);
+		return ret;
+	}
+	return len;
+}
+
+
+static ssize_t led_get_brightness(struct sie_cronos_cpld *chip, unsigned int reg, char *buf)
+{
+	unsigned int brightness_val;
+	int ret = -EIO;
+
+	ret = regmap_read(chip->regmap, reg, &brightness_val);
+	if (ret != 0)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "0x%02x\n", brightness_val);
+}
+
+static ssize_t led_set_brightness(struct sie_cronos_cpld *chip, unsigned int reg, const char *buf,
+	size_t len)
+{
+	u8 val = 0;
+	int ret = -EIO;
+
+	if (kstrtou8(buf, 0, &val))
+		return -EINVAL;
+
+	ret = regmap_update_bits(chip->regmap, reg, CRONOS_CPLD_LEDS_BRIGHTNESS_SET_MASK, val);
+	if (ret) {
+		dev_err(chip->dev, "Failed to write value 0x%02x to address 0x%02x", val, reg);
+		return ret;
+	}
+	return len;
+}
+
+static ssize_t brightness_red_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	return led_get_brightness(chip, CRONOS_CPLD_BRIGHTNESS_RED_REG, buf);
+}
+
+static ssize_t brightness_red_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	return led_set_brightness(chip, CRONOS_CPLD_BRIGHTNESS_RED_REG, buf, len);
+}
+
+static ssize_t brightness_green_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	return led_get_brightness(chip, CRONOS_CPLD_BRIGHTNESS_GREEN_REG, buf);
+}
+
+static ssize_t brightness_green_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	return led_set_brightness(chip, CRONOS_CPLD_BRIGHTNESS_GREEN_REG, buf, len);
+}
+
+static ssize_t brightness_blue_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	return led_get_brightness(chip, CRONOS_CPLD_BRIGHTNESS_BLUE_REG, buf);
+}
+
+static ssize_t brightness_blue_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	return led_set_brightness(chip, CRONOS_CPLD_BRIGHTNESS_BLUE_REG, buf, len);
+}
+
+
+static ssize_t revision_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	u16 revision = 0;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	ret = regmap_bulk_read(chip->regmap, CRONOS_CPLD_REVISION_LOW_REG, &revision, 2);
+	if (ret)
+		return -EIO;
+
+	return snprintf(buf, PAGE_SIZE, "0x%04x\n", revision);
+}
+
+static ssize_t device_id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	u16 device_id = 0;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	ret = regmap_bulk_read(chip->regmap, CRONOS_CPLD_DEVICE_ID_LOW_REG, &device_id, 2);
+	if (ret)
+		return -EIO;
+
+	return snprintf(buf, PAGE_SIZE, "0x%04x\n", device_id);
+}
+
+static ssize_t bmc_mac_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	u8 bmc_mac[6];
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	ret = regmap_bulk_read(chip->regmap, CRONOS_CPLD_BMC_MAC_LOW_REG, bmc_mac, 6);
+	if (ret)
+		return -EIO;
+
+	return snprintf(buf, PAGE_SIZE, "%pM\n", bmc_mac);
+}
+
+static ssize_t status_2_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	unsigned int last_boot = 0;
+	int ret = -EIO;
+	struct sie_cronos_cpld *chip = dev_get_drvdata(dev);
+
+	ret = regmap_read(chip->regmap, CRONOS_CPLD_STATUS_2_REG, &last_boot);
+	if (ret < 0)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "0x%02x\n", last_boot);
+}
+
+
+static DEVICE_ATTR_RO(revision);
+static DEVICE_ATTR_RO(device_id);
+static DEVICE_ATTR_RO(bmc_mac);
+static DEVICE_ATTR_RO(status_2);
+
+static DEVICE_ATTR_RW(uart_mux);
+static DEVICE_ATTR_RW(switch_flash);
+static DEVICE_ATTR_RW(switch_reset);
+static DEVICE_ATTR_RW(bmc_flash);
+static DEVICE_ATTR_RW(payload_power);
+
+static DEVICE_ATTR_RW(brightness_red);
+static DEVICE_ATTR_RW(brightness_green);
+static DEVICE_ATTR_RW(brightness_blue);
+static struct attribute *cronos_cpld_sysfs_entries[] = {
+	&dev_attr_revision.attr,
+	&dev_attr_device_id.attr,
+	&dev_attr_bmc_mac.attr,
+	&dev_attr_status_2.attr,
+	&dev_attr_uart_mux.attr,
+	&dev_attr_switch_flash.attr,
+	&dev_attr_switch_reset.attr,
+	&dev_attr_bmc_flash.attr,
+	&dev_attr_payload_power.attr,
+	&dev_attr_brightness_red.attr,
+	&dev_attr_brightness_green.attr,
+	&dev_attr_brightness_blue.attr,
+	NULL,
+};
+
+static const struct attribute_group cronos_cpld_attr_group = {
+	.attrs	= cronos_cpld_sysfs_entries,
+};
+
+static int sie_cronos_get_device_type(struct sie_cronos_cpld *chip)
+{
+	int device_id;
+	int byte;
+	int ret;
+
+	ret = regmap_read(chip->regmap, CRONOS_CPLD_DEVICE_ID_HIGH_REG, &byte);
+	if (ret < 0) {
+		dev_err(chip->dev, "Cannot read chip ID.\n");
+		return -EIO;
+	}
+	device_id = byte << 8;
+	ret = regmap_read(chip->regmap, CRONOS_CPLD_DEVICE_ID_LOW_REG, &byte);
+	if (ret < 0) {
+		dev_err(chip->dev, "Cannot read chip ID.\n");
+		return -EIO;
+	}
+	device_id |= byte;
+	if (device_id != CRONOS_CPLD_DEVICE_ID) {
+		dev_err(chip->dev, "Invalid device ID: 0x%04x\n", device_id);
+		return -ENODEV;
+	}
+
+	dev_info(chip->dev,
+		 "Device detected (device-ID: 0x%04X)\n",
+		 device_id);
+
+	return ret;
+}
+
+static bool cronos_cpld_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CRONOS_CPLD_BRIGHTNESS_RED_REG:
+	case CRONOS_CPLD_BRIGHTNESS_GREEN_REG:
+	case CRONOS_CPLD_BRIGHTNESS_BLUE_REG:
+	case CRONOS_LEDS_SMC_STATUS_REG:
+	case CRONOS_LEDS_SWITCH_STATUS_REG:
+	case CRONOS_LEDS_CCM1_STATUS_REG:
+	case CRONOS_LEDS_CCM2_STATUS_REG:
+	case CRONOS_LEDS_CCM3_STATUS_REG:
+	case CRONOS_LEDS_CCM4_STATUS_REG:
+	case CRONOS_LEDS_CCM_POWER_REG:
+
+	case CRONOS_WDT_CTL_REG:
+	case CRONOS_WDT_CLR_REG:
+
+	case CRONOS_CPLD_UART_MUX_REG:
+	case CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG:
+	case CRONOS_CPLD_SWITCH_RESET_CMD_REG:
+	case CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG:
+	case CRONOS_CPLD_PAYLOAD_POWER_CTL_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cronos_cpld_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CRONOS_CPLD_REVISION_HIGH_REG:
+	case CRONOS_CPLD_REVISION_LOW_REG:
+	case CRONOS_CPLD_DEVICE_ID_HIGH_REG:
+	case CRONOS_CPLD_DEVICE_ID_LOW_REG:
+
+	case CRONOS_CPLD_BRIGHTNESS_RED_REG:
+	case CRONOS_CPLD_BRIGHTNESS_GREEN_REG:
+	case CRONOS_CPLD_BRIGHTNESS_BLUE_REG:
+	case CRONOS_LEDS_SMC_STATUS_REG:
+	case CRONOS_LEDS_SWITCH_STATUS_REG:
+	case CRONOS_LEDS_CCM1_STATUS_REG:
+	case CRONOS_LEDS_CCM2_STATUS_REG:
+	case CRONOS_LEDS_CCM3_STATUS_REG:
+	case CRONOS_LEDS_CCM4_STATUS_REG:
+	case CRONOS_LEDS_CCM_POWER_REG:
+
+	case CRONOS_WDT_CTL_REG:
+	case CRONOS_WDT_CLR_REG:
+
+	case CRONOS_CPLD_STATUS_2_REG:
+	case CRONOS_CPLD_UART_MUX_REG:
+	case CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG:
+	case CRONOS_CPLD_SWITCH_RESET_CMD_REG:
+	case CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG:
+	case CRONOS_CPLD_PAYLOAD_POWER_CTL_REG:
+
+	case CRONOS_CPLD_BMC_MAC_LOW_REG ... CRONOS_CPLD_BMC_MAC_HIGH_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cronos_cpld_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CRONOS_CPLD_REVISION_HIGH_REG:
+	case CRONOS_CPLD_REVISION_LOW_REG:
+
+	case CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG:
+	case CRONOS_CPLD_SWITCH_RESET_CMD_REG:
+	case CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG:
+	case CRONOS_CPLD_PAYLOAD_POWER_CTL_REG:
+
+	case CRONOS_WDT_CTL_REG:
+	case CRONOS_WDT_CLR_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static struct regmap_config cronos_cpld_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = CRONOS_CPLD_REVISION_HIGH_REG,
+	.writeable_reg = cronos_cpld_is_writeable_reg,
+	.readable_reg = cronos_cpld_is_readable_reg,
+	.volatile_reg = cronos_cpld_is_volatile_reg,
+	.use_single_read = true,
+	.use_single_write = true,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const struct of_device_id cronos_cpld_dt_ids[] = {
+	{ .compatible = "sie,cronos-cpld", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cronos_cpld_dt_ids);
+
+static int sie_cronos_i2c_probe(struct i2c_client *i2c)
+{
+	struct sie_cronos_cpld *chip;
+	const struct of_device_id *match;
+	const struct mfd_cell *cell;
+	const struct regmap_config *config;
+	int cell_num;
+	int ret;
+
+	chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	if (i2c->dev.of_node) {
+		match = of_match_node(cronos_cpld_dt_ids, i2c->dev.of_node);
+		if (!match)
+			return -EINVAL;
+	}
+
+	i2c_set_clientdata(i2c, chip);
+	chip->dev = &i2c->dev;
+
+	cell = cronos_cpld_devs;
+	cell_num = ARRAY_SIZE(cronos_cpld_devs);
+	config = &cronos_cpld_regmap_config;
+
+	chip->regmap = devm_regmap_init_i2c(i2c, config);
+	if (IS_ERR(chip->regmap)) {
+		ret = PTR_ERR(chip->regmap);
+		dev_err(chip->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = sie_cronos_get_device_type(chip);
+	if (ret)
+		return ret;
+
+	ret = mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, cell,
+			      cell_num, NULL, 0, NULL);
+	if (ret) {
+		dev_err(chip->dev, "Cannot register child devices\n");
+		return ret;
+	}
+
+	/* Add sysfs */
+	ret = sysfs_create_group(&chip->dev->kobj, &cronos_cpld_attr_group);
+	if (ret)
+		dev_err(chip->dev, "Failed to create sysfs entries\n");
+
+	return ret;
+}
+
+static void sie_cronos_i2c_remove(struct i2c_client *i2c)
+{
+	struct sie_cronos_cpld *chip = i2c_get_clientdata(i2c);
+
+	sysfs_remove_group(&chip->dev->kobj, &cronos_cpld_attr_group);
+	mfd_remove_devices(chip->dev);
+}
+
+static struct i2c_driver sie_cronos_i2c_driver = {
+	.driver = {
+		.name = "sie-cronos",
+		.of_match_table = of_match_ptr(cronos_cpld_dt_ids),
+	},
+	.probe    = sie_cronos_i2c_probe,
+	.remove   = sie_cronos_i2c_remove,
+};
+
+module_i2c_driver(sie_cronos_i2c_driver);
+
+MODULE_DESCRIPTION("Core device driver for SIE Cronos CPLDs");
+MODULE_AUTHOR("Raptor Engineering, LLC <support@raptorengineering.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/sie/cronos/core.h b/include/linux/mfd/sie/cronos/core.h
new file mode 100644
index 000000000000..a2fcc48012d8
--- /dev/null
+++ b/include/linux/mfd/sie/cronos/core.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2015-2017  Dialog Semiconductor
+ * Copyright (C) 2022  Raptor Engineering, LLC
+ */
+
+#ifndef __MFD_SIE_CRONOS_CORE_H__
+#define __MFD_SIE_CRONOS_CORE_H__
+
+#include <linux/mfd/sie/cronos/registers.h>
+
+struct sie_cronos_cpld {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+#endif /* __MFD_SIE_CRONOS_H__ */
diff --git a/include/linux/mfd/sie/cronos/registers.h b/include/linux/mfd/sie/cronos/registers.h
new file mode 100644
index 000000000000..e70f5ec038cc
--- /dev/null
+++ b/include/linux/mfd/sie/cronos/registers.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2015-2017  Dialog Semiconductor
+ * Copyright (C) 2022  Raptor Engineering, LLC
+ */
+
+#ifndef __SIE_CRONOS_H__
+#define __SIE_CRONOS_H__
+
+#define CRONOS_CPLD_DEVICE_ID		0x0134
+
+/*
+ * Registers and control masks / values
+ */
+
+#define CRONOS_CPLD_REVISION_HIGH_REG			0x73
+#define CRONOS_CPLD_REVISION_LOW_REG			0x72
+#define CRONOS_CPLD_DEVICE_ID_HIGH_REG			0x71
+#define CRONOS_CPLD_DEVICE_ID_LOW_REG			0x70
+
+#define CRONOS_CPLD_BRIGHTNESS_RED_REG			0x17
+#define CRONOS_CPLD_BRIGHTNESS_GREEN_REG		0x18
+#define CRONOS_CPLD_BRIGHTNESS_BLUE_REG			0x19
+
+#define CRONOS_CPLD_LEDS_BRIGHTNESS_SET_MASK		0x7F
+#define CRONOS_LEDS_MAX_BRIGHTNESS			0x7F
+
+#define CRONOS_LEDS_SMC_STATUS_REG			0x10
+#define CRONOS_LEDS_SWITCH_STATUS_REG			0x11
+
+#define CRONOS_LEDS_CCM1_STATUS_REG			0x15
+#define CRONOS_LEDS_CCM2_STATUS_REG			0x13
+#define CRONOS_LEDS_CCM3_STATUS_REG			0x12
+#define CRONOS_LEDS_CCM4_STATUS_REG			0x14
+
+#define CRONOS_LEDS_CCM_POWER_REG			0x16
+
+#define CRONOS_CPLD_UART_MUX_REG			0x0e
+#define CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG	0x00
+#define CRONOS_CPLD_SWITCH_RESET_CMD_REG		0x01
+#define CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG		0x02
+#define CRONOS_CPLD_PAYLOAD_POWER_CTL_REG		0x0a
+#define CRONOS_CPLD_BMC_MAC_LOW_REG			0x30
+#define CRONOS_CPLD_BMC_MAC_HIGH_REG			0x35
+
+#define CRONOS_WDT_CLR_REG		0x03
+#define CRONOS_WDT_CTL_REG		0x0c
+
+#define CRONOS_CPLD_STATUS_2_REG	0x05
+
+#define CRONOS_WDT_CLR_VAL		0xc3
+#define CRONOS_WDT_ENABLE_MASK		0x80
+#define CRONOS_WDT_ENABLE_VAL		0x80
+#define CRONOS_WDT_DISABLE_VAL		0x00
+#define CRONOS_WDT_TIMEOUT_MASK		0x07
+#define CRONOS_WDT_CTL_RESET_VAL	0x00
+
+
+#endif /* __SIE_CRONOS_H__ */
--
2.30.2

