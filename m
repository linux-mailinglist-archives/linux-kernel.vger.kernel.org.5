Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8E77FE12
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354529AbjHQSoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354528AbjHQSoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:44:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35D930D6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:44:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso1676465e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692297840; x=1692902640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itEstkwBA/RPTkuFy1wLiuSh0rnw+5sBEyROcT+B9XU=;
        b=RKBKwx5OlHzurd1DFn1lfE3stjzkqb/OSnYDA51OQrLSj2GepQQZmnRBhE8eqoOz/3
         D1jE/T9MYyP980ur6Fs7dVIslO296Apd7GWvtTWNR4ZNCc12oo1ShJl0XpIyPWVMtxEC
         yMRaZny8iA2ztxtcM9jlraZFMnrVWDxql/g/oSOdqs1G5srVy4oOU7rw2DfwtSnzfKtz
         IgOd4tf+WnlCYgFpq6j7QcCTjBZVEYgD+J+tNsRArUOhEOCrGtq+MQYHrnek4nfR+JDK
         8wr7Y6ws8zqVx2A70h/nPdKKgQWrwHNeUk287bl6ZklJOkqzMns6iUJ9TGaBL1yZKDZA
         l0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692297840; x=1692902640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itEstkwBA/RPTkuFy1wLiuSh0rnw+5sBEyROcT+B9XU=;
        b=L13g6GGIC70ZcBUJzmv71iG3f9No39fAE4YXYbCEShPyJ3hnGoNj/GLjrqdR+NhzPw
         1YExhCJ/tQbHIgioUFx1ZaOusaUtsoOBwPZnU/h/aTO+ML+ubbjrvITj8WQtOXT1li6h
         66oB4dtGTu9UmJ4igCYTImrFvEG0NLh6C7vJ1FiAEJ3JkkVB1Eh8Cr28LCo6G7rJcmqn
         t4YLAGxCGyIZyHs3RVnes0FXkRmlNLJfZn2+ZhsJ1oFpdvn14mm8b16NSIJCZRY/ncsy
         J6tz+8M61KxBgiC2TEBpS4+bYUnYsrJZnqFpyMWfPC3MF3S0jyoV6v0pUf/3avJtJSDx
         LwEg==
X-Gm-Message-State: AOJu0YyW97lFn9q3dLkjzCbxEQgb+kbjpsN7U2mrBnQxyUMqkskoQjWs
        hNdPgPgjI8m2Ku/mqiPEciEtOA==
X-Google-Smtp-Source: AGHT+IG92vHvCWLypAuVMe2mgdeLwOcPA1KG/5jnoN51mKf437iudJKmhEtHaelCJf+AUxGSbF+KSA==
X-Received: by 2002:a05:600c:1c9b:b0:3fd:e86b:f095 with SMTP id k27-20020a05600c1c9b00b003fde86bf095mr466184wms.13.1692297840142;
        Thu, 17 Aug 2023 11:44:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2f99:c690:b4da:e3d2])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c235300b003fe601a7d46sm3823628wmq.45.2023.08.17.11.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:43:59 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6] gpio: consumer: new virtual driver
Date:   Thu, 17 Aug 2023 20:43:56 +0200
Message-Id: <20230817184356.25020-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The GPIO subsystem has a serious problem with undefined behavior and
use-after-free bugs on hot-unplug of GPIO chips. This can be considered a
corner-case by some as most GPIO controllers are enabled early in the
boot process and live until the system goes down but most GPIO drivers
do allow unbind over sysfs, many are loadable modules that can be (force)
unloaded and there are also GPIO devices that can be dynamically detached,
for instance CP2112 which is a USB GPIO expender.

Bugs can be triggered both from user-space as well as by in-kernel users.
We have the means of testing it from user-space via the character device
but the issues manifest themselves differently in the kernel.

This is a proposition of adding a new virtual driver - a configurable
GPIO consumer that can be configured over configfs (similarly to
gpio-sim).

The configfs interface allows users to create dynamic GPIO lookup tables
that are registered with the GPIO subsystem. Every config group
represents a consumer device. Every sub-group represents a single GPIO
lookup. The device can work in three modes: just keeping the line
active, toggling it every second or requesting its interrupt and
reporting edges. Every lookup allows to specify the key, offset and
flags as per the lookup struct defined in linux/gpio/machine.h.

The module together with gpio-sim allows to easily trigger kernel
hot-unplug errors. A simple use-case is to create a simulated chip,
setup the consumer to lookup one of its lines in 'monitor' mode, unbind
the simulator, unbind the consumer and observe the fireworks in dmesg.

This driver is aimed as a helper in tackling the hot-unplug problem in
GPIO as well as basis for future regression testing once the fixes are
upstream.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
RFC -> v2:
- add documentation
- fix various issues pointed out by Andy: use struct_size() where
  applicable, improve the logic when storing the 'live' property,
  improve log messages, remove commas in terminators, etc.

v2 -> v3:
- use cleanup.h interfaces
- add some clarifying commets
- more minor code tweaks

v3 -> v4:
- fix the toggle value assignment
- use guard(mutex)() wherever we can return directly from the subsequent
  function call
- use skip_spaces() + strim() to avoid having to do a memmove() when
  stripping strings off whitespaces
- DON'T try to save a couple LOC in ifdefs if that makes them less
  readable (Andy :) )

v4 -> v5:
- add the gpio-consumer docs to the admin-guide/gpio/ index (reported
  by kernel test robot <lkp@intel.com>)

v5 -> v6:
- initialize the flags temp variables at declaration and hopefully make
  Andy happy finally :)

 .../admin-guide/gpio/gpio-consumer.rst        | 111 ++
 Documentation/admin-guide/gpio/index.rst      |   1 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-consumer.c                  | 946 ++++++++++++++++++
 5 files changed, 1066 insertions(+)
 create mode 100644 Documentation/admin-guide/gpio/gpio-consumer.rst
 create mode 100644 drivers/gpio/gpio-consumer.c

diff --git a/Documentation/admin-guide/gpio/gpio-consumer.rst b/Documentation/admin-guide/gpio/gpio-consumer.rst
new file mode 100644
index 000000000000..50ec57088e5a
--- /dev/null
+++ b/Documentation/admin-guide/gpio/gpio-consumer.rst
@@ -0,0 +1,111 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Virtual GPIO Consumer
+=====================
+
+The virtual GPIO Consumer module allows users to create dynamic GPIO lookup
+tables using the exposed configfs interface and instantiate virtual GPIO
+consumer devices that retrieve and use GPIOs using these tables.
+
+Creating GPIO consumers
+-----------------------
+
+The gpio-consumer module registers a configfs subsystem called
+``'gpio-consumer'``. For details of the configfs filesystem, please refer to
+the configfs documentation.
+
+The user can create a hierarchy of configfs groups and items as well as modify
+values of exposed attributes. Once the consumer is instantiated, this hierarchy
+will be translated to appropriate device properties. The general structure is:
+
+**Group:** ``/config/gpio-consumer``
+
+This is the top directory of the gpio-consumer configfs tree.
+
+**Group:** ``/config/gpio-consumer/consumer-device``
+
+**Attribute:** ``/config/gpio-consumer/gpio-device/function``
+
+**Attribute:** ``/config/gpio-consumer/gpio-device/live``
+
+This is a directory representing a GPIO consumer device. The ``'function'``
+attribute defines how the device will use requested GPIOs. It takes the
+following values: ``'active'`` - GPIOs will be requested as output-high and
+kept in this state until the device is unbound, ``'toggle'`` - GPIOs will
+be requested in output mode and then toggled periodically (every second)
+between 1 and 0, ``'monitor'`` - GPIOs will be requested in input mode, then
+requested as interrupts and their firing reported in the kernel log.
+
+The ``'live'`` attribute allows to trigger the actual creation of the device
+once it's fully configured. The accepted values are: ``'1'`` to enable the
+virtual device and ``'0'`` to disable and tear it down.
+
+Creating GPIO lookup tables
+---------------------------
+
+User can create a number of configfs groups under the device group with the
+following properties:
+
+**Group:** ``/config/gpio-consumer/consumer-device/lookupX``
+
+**Attribute:** ``/config/gpio-consumer/consumer-device/lookupX/key``
+
+**Attribute:** ``/config/gpio-consumer/consumer-device/lookupX/offset``
+
+**Attribute:** ``/config/gpio-consumer/consumer-device/lookupX/drive``
+
+**Attribute:** ``/config/gpio-consumer/consumer-device/lookupX/pull``
+
+**Attribute:** ``/config/gpio-consumer/consumer-device/lookupX/active_low``
+
+**Attribute:** ``/config/gpio-consumer/consumer-device/lookupX/transitory``
+
+This group represents a single entry in the GPIO lookup table. The name of the
+sub-directory maps to the ``'con_id'`` field of ``'struct gpiod_lookup'``. The
+``'key'`` attribute represents either the name of the chip this GPIO belongs to
+or the GPIO line name. This depends on the value of the ``'offset'`` attribute:
+if its value is >= 0, then ``'key'`` represents the label of the chip to lookup
+while ``'offset'`` represents the offset of the line in that chip. If
+``'offset'`` is < 0, then ``'key'`` represents the name of the line.
+
+The remaining attributes map to the ``'flags'`` field of the GPIO lookup struct.
+The first two take string values as arguments:
+
+**``'drive'``:** ``'push-pull'``, ``'open-drain'``, ``'open-source'``
+**``'pull'``:** ``'pull-up'``, ``'pull-down'``, ``'pull-disabled'``, ``'as-is'``
+
+``'active_low'`` and ``'transitory'`` are boolean attributes.
+
+Activating GPIO consumers
+-------------------------
+
+Once the confiuration is complete, the ``'live'`` attribute must be set to 1 in
+order to instantiate the consumer. It can be set back to 0 to destroy the
+virtual devices. The module will synchronously wait for the new simulated device
+to be successfully probed and if this doesn't happen, writing to ``'live'`` will
+result in an error.
+
+Device-tree
+-----------
+
+Virtual GPIO consumers can also be defined in device-tree. The compatible string
+must be: ``"gpio-virtual-consumer"``. Supported properties are:
+
+  ``"gpio-virtual-consumer,function"`` - function of the virtual device
+  ``"gpio-virtual-consumer,lines"`` - list of lookup keys
+
+An example device-tree code defining a virtual GPIO consumer:
+
+.. code-block :: none
+
+    gpio-virt-consumer {
+        compatible = "gpio-virtual-consumer";
+
+        foo-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+        bar-gpios = <&gpio0 6 0>;
+
+        gpio-virtual-consumer,function = "toggle";
+        gpio-virtual-consumer,lines = "foo", "bar";
+    };
+
+.. SPDX-License-Identifier: GPL-2.0-or-later
diff --git a/Documentation/admin-guide/gpio/index.rst b/Documentation/admin-guide/gpio/index.rst
index f6861ca16ffe..be89cb99c027 100644
--- a/Documentation/admin-guide/gpio/index.rst
+++ b/Documentation/admin-guide/gpio/index.rst
@@ -8,6 +8,7 @@ gpio
     :maxdepth: 1
 
     gpio-aggregator
+    gpio-consumer
     sysfs
     gpio-mockup
     gpio-sim
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e382dfebad7c..c152fcf6c54f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1762,6 +1762,13 @@ config GPIO_AGGREGATOR
 	      industrial control context, to be operated from userspace using
 	      the GPIO chardev interface.
 
+config GPIO_CONSUMER
+	tristate "GPIO Consumer Testing Module"
+	select CONFIGFS_FS
+	help
+	  This enables the configurable, configfs-based virtual GPIO consumer
+	  testing driver.
+
 config GPIO_LATCH
 	tristate "GPIO latch driver"
 	help
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c3ac51d47aa9..268e8f65f3c8 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_GPIO_BT8XX)		+= gpio-bt8xx.o
 obj-$(CONFIG_GPIO_CADENCE)		+= gpio-cadence.o
 obj-$(CONFIG_GPIO_CLPS711X)		+= gpio-clps711x.o
 obj-$(CONFIG_GPIO_SNPS_CREG)		+= gpio-creg-snps.o
+obj-$(CONFIG_GPIO_CONSUMER)		+= gpio-consumer.o
 obj-$(CONFIG_GPIO_CRYSTAL_COVE)		+= gpio-crystalcove.o
 obj-$(CONFIG_GPIO_CS5535)		+= gpio-cs5535.o
 obj-$(CONFIG_GPIO_DA9052)		+= gpio-da9052.o
diff --git a/drivers/gpio/gpio-consumer.c b/drivers/gpio/gpio-consumer.c
new file mode 100644
index 000000000000..43c57747b2e1
--- /dev/null
+++ b/drivers/gpio/gpio-consumer.c
@@ -0,0 +1,946 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Configurable virtual GPIO consumer module.
+ *
+ * Copyright (C) 2023 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/configfs.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/overflow.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+
+#include "gpiolib.h"
+
+#define GPIO_CONSUMER_MAX_PROPS 3
+
+enum gpio_consumer_function {
+	GPIO_CONSUMER_FUNCTION_ACTIVE = 0,
+	GPIO_CONSUMER_FUNCTION_TOGGLE,
+	GPIO_CONSUMER_FUNCTION_MONITOR,
+	__GPIO_CONSUMER_FUNCTION_LAST
+};
+
+static const char *const gpio_consumer_function_strings[] = {
+	[GPIO_CONSUMER_FUNCTION_ACTIVE] = "active",
+	[GPIO_CONSUMER_FUNCTION_TOGGLE] = "toggle",
+	[GPIO_CONSUMER_FUNCTION_MONITOR] = "monitor",
+	NULL
+};
+
+struct gpio_consumer_irq_data {
+	struct device *dev;
+	struct gpio_desc *desc;
+};
+
+struct gpio_consumer_timer_data {
+	struct timer_list timer;
+	struct gpio_desc *desc;
+	int val;
+};
+
+static struct gpio_consumer_timer_data *to_timer_data(struct timer_list *timer)
+{
+	return container_of(timer, struct gpio_consumer_timer_data, timer);
+}
+
+static DEFINE_IDA(gpio_consumer_ida);
+
+static irqreturn_t gpio_consumer_on_irq(int irq, void *data)
+{
+	struct gpio_consumer_irq_data *irq_data = data;
+	struct gpio_desc *desc = irq_data->desc;
+	struct gpio_device *gdev = desc->gdev;
+	struct device *dev = irq_data->dev;
+	int val;
+
+	val = gpiod_get_value_cansleep(desc);
+	if (val < 0) {
+		dev_err(dev, "failed to read GPIO value: %d\n", val);
+		return IRQ_HANDLED;
+	}
+
+	dev_info(dev, "interrupt triggered on line %u of %s, new value: %d\n",
+		 gpio_chip_hwgpio(desc), dev_name(&gdev->dev), val);
+
+	return IRQ_HANDLED;
+}
+
+static void gpio_consumer_on_timer(struct timer_list *timer)
+{
+	struct gpio_consumer_timer_data *timer_data = to_timer_data(timer);
+
+	timer_data->val = timer_data->val ? 0 : 1;
+	gpiod_set_value_cansleep(timer_data->desc, timer_data->val);
+	mod_timer(&timer_data->timer, jiffies + msecs_to_jiffies(1000));
+}
+
+static void gpio_consumer_del_timer(void *data)
+{
+	struct timer_list *timer = data;
+
+	del_timer(timer);
+}
+
+static int gpio_consumer_probe(struct platform_device *pdev)
+{
+	struct gpio_consumer_timer_data *timer_data;
+	struct gpio_consumer_irq_data *irq_data;
+	enum gpio_consumer_function function;
+	const char *function_prop, **lines;
+	struct device *dev = &pdev->dev;
+	struct gpio_desc *desc;
+	enum gpiod_flags flags;
+	int ret, num_lines, i;
+
+	ret = device_property_read_string(dev, "gpio-virtual-consumer,function",
+					  &function_prop);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read the consumer GPIO function\n");
+
+	ret = match_string(gpio_consumer_function_strings, -1, function_prop);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Invalid consumer function: '%s'\n",
+				     function_prop);
+
+	function = ret;
+	num_lines = device_property_string_array_count(dev,
+					"gpio-virtual-consumer,lines");
+	if (num_lines < 0)
+		return dev_err_probe(dev, num_lines,
+				     "List of GPIO lines to request not found\n");
+
+	lines = devm_kcalloc(dev, num_lines, sizeof(*lines), GFP_KERNEL);
+	if (!lines)
+		return -ENOMEM;
+
+	ret = device_property_read_string_array(dev,
+						"gpio-virtual-consumer,lines",
+						lines, num_lines);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to read GPIO line names\n");
+
+	flags = function == GPIO_CONSUMER_FUNCTION_MONITOR ?
+					GPIOD_IN : GPIOD_OUT_HIGH;
+	for (i = 0; i < num_lines; i++) {
+		desc = devm_gpiod_get(dev, lines[i], flags);
+		if (IS_ERR(desc))
+			return dev_err_probe(dev, PTR_ERR(desc),
+					     "Failed to get GPIO '%s'\n",
+					     lines[i]);
+
+		if (function == GPIO_CONSUMER_FUNCTION_MONITOR) {
+			irq_data = devm_kzalloc(dev, sizeof(*irq_data),
+						GFP_KERNEL);
+			if (!irq_data)
+				return -ENOMEM;
+
+			irq_data->dev = dev;
+			irq_data->desc = desc;
+
+			ret = devm_request_threaded_irq(dev, gpiod_to_irq(desc),
+							NULL,
+							gpio_consumer_on_irq,
+							IRQF_TRIGGER_FALLING |
+							IRQF_TRIGGER_RISING |
+							IRQF_ONESHOT,
+							lines[i], irq_data);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						"Failed to request GPIO line interrupt\n");
+		} else if (function == GPIO_CONSUMER_FUNCTION_TOGGLE) {
+			timer_data = devm_kzalloc(dev, sizeof(*timer_data),
+						  GFP_KERNEL);
+			if (!timer_data)
+				return -ENOMEM;
+
+			timer_data->desc = desc;
+			timer_data->val = 1;
+
+			timer_setup(&timer_data->timer,
+				    gpio_consumer_on_timer, 0);
+			mod_timer(&timer_data->timer,
+				  jiffies + msecs_to_jiffies(1000));
+
+			ret = devm_add_action_or_reset(dev,
+						       gpio_consumer_del_timer,
+						       &timer_data->timer);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id gpio_consumer_of_match[] = {
+	{ .compatible = "gpio-virtual-consumer" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpio_consumer_of_match);
+
+static struct platform_driver gpio_consumer_driver = {
+	.driver = {
+		.name = "gpio-virtual-consumer",
+		.of_match_table = gpio_consumer_of_match,
+	},
+	.probe = gpio_consumer_probe,
+};
+
+struct gpio_consumer_device {
+	struct config_group group;
+
+	struct platform_device *pdev;
+	int id;
+	struct mutex lock;
+
+	struct notifier_block bus_notifier;
+	struct completion probe_completion;
+	bool driver_bound;
+
+	struct gpiod_lookup_table *lookup_table;
+	enum gpio_consumer_function function;
+
+	struct list_head lookup_list;
+};
+
+static int gpio_consumer_bus_notifier_call(struct notifier_block *nb,
+					   unsigned long action, void *data)
+{
+	struct gpio_consumer_device *consumer;
+	struct device *dev = data;
+	char devname[32];
+
+	consumer = container_of(nb, struct gpio_consumer_device, bus_notifier);
+	snprintf(devname, sizeof(devname), "gpio-virtual-consumer.%d",
+		 consumer->id);
+
+	if (strcmp(dev_name(dev), devname))
+		return NOTIFY_DONE;
+
+	switch (action) {
+	case BUS_NOTIFY_BOUND_DRIVER:
+		consumer->driver_bound = true;
+		break;
+	case BUS_NOTIFY_DRIVER_NOT_BOUND:
+		consumer->driver_bound = false;
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	complete(&consumer->probe_completion);
+	return NOTIFY_OK;
+}
+
+static struct gpio_consumer_device *
+to_gpio_consumer_device(struct config_item *item)
+{
+	struct config_group *group = to_config_group(item);
+
+	return container_of(group, struct gpio_consumer_device, group);
+}
+
+static bool
+gpio_consumer_device_is_live_unlocked(struct gpio_consumer_device *dev)
+{
+	return !!dev->pdev;
+}
+
+struct gpio_consumer_lookup {
+	struct config_group group;
+
+	struct gpio_consumer_device *parent;
+	struct list_head siblings;
+
+	char *con_id;
+	char *key;
+	/* Can be negative to indicate lookup by name. */
+	int offset;
+
+	enum gpio_lookup_flags flags;
+};
+
+static struct gpio_consumer_lookup *
+to_gpio_consumer_lookup(struct config_item *item)
+{
+	struct config_group *group = to_config_group(item);
+
+	return container_of(group, struct gpio_consumer_lookup, group);
+}
+
+static ssize_t
+gpio_consumer_lookup_config_key_show(struct config_item *item, char *page)
+{
+	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
+	struct gpio_consumer_device *dev = lookup->parent;
+
+	guard(mutex)(&dev->lock);
+
+	return sprintf(page, "%s\n", lookup->key);
+}
+
+static ssize_t
+gpio_consumer_lookup_config_key_store(struct config_item *item,
+				      const char *page, size_t count)
+{
+	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
+	struct gpio_consumer_device *dev = lookup->parent;
+	char *key __free(kfree) = NULL;
+
+	key = kstrndup(skip_spaces(page), count, GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
+
+	strim(key);
+
+	guard(mutex)(&dev->lock);
+
+	if (gpio_consumer_device_is_live_unlocked(dev))
+		return -EBUSY;
+
+	kfree(lookup->key);
+	lookup->key = no_free_ptr(key);
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_consumer_lookup_config_, key);
+
+static ssize_t
+gpio_consumer_lookup_config_offset_show(struct config_item *item, char *page)
+{
+	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
+	struct gpio_consumer_device *dev = lookup->parent;
+	unsigned int offset;
+
+	scoped_guard(mutex, &dev->lock)
+		offset = lookup->offset;
+
+	return sprintf(page, "%d\n", offset);
+}
+
+static ssize_t
+gpio_consumer_lookup_config_offset_store(struct config_item *item,
+					 const char *page, size_t count)
+{
+	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
+	struct gpio_consumer_device *dev = lookup->parent;
+	int offset, ret;
+
+	ret = kstrtoint(page, 0, &offset);
+	if (ret)
+		return ret;
+
+	/*
+	 * Negative number here means: 'key' represents a line name to lookup.
+	 * Non-negative means: 'key' represents the label of the chip with
+	 * the 'offset' value representing the line within that chip.
+	 *
+	 * GPIOLIB uses the U16_MAX value to indicate lookup by line name so
+	 * the greatest offset we can accept is (U16_MAX - 1).
+	 */
+	if (offset > (U16_MAX - 1))
+		return -EINVAL;
+
+	guard(mutex)(&dev->lock);
+
+	if (gpio_consumer_device_is_live_unlocked(dev))
+		return -EBUSY;
+
+	lookup->offset = offset;
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_consumer_lookup_config_, offset);
+
+static enum gpio_lookup_flags
+gpio_consumer_lookup_get_flags(struct config_item *item)
+{
+	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
+	struct gpio_consumer_device *dev = lookup->parent;
+
+	guard(mutex)(&dev->lock);
+
+	return lookup->flags;
+}
+
+static ssize_t
+gpio_consumer_lookup_config_drive_show(struct config_item *item, char *page)
+{
+	enum gpio_lookup_flags flags = gpio_consumer_lookup_get_flags(item);
+	const char *repr;
+
+	if (flags & GPIO_OPEN_DRAIN)
+		repr = "open-drain";
+	else if (flags & GPIO_OPEN_SOURCE)
+		repr = "open-source";
+	else
+		repr = "push-pull";
+
+	return sprintf(page, "%s\n", repr);
+}
+
+static ssize_t
+gpio_consumer_lookup_config_drive_store(struct config_item *item,
+					const char *page, size_t count)
+{
+	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
+	struct gpio_consumer_device *dev = lookup->parent;
+
+	guard(mutex)(&dev->lock);
+
+	if (gpio_consumer_device_is_live_unlocked(dev))
+		return -EBUSY;
+
+	if (sysfs_streq(page, "push-pull")) {
+		lookup->flags &= ~(GPIO_OPEN_DRAIN | GPIO_OPEN_SOURCE);
+	} else if (sysfs_streq(page, "open-drain")) {
+		lookup->flags &= ~GPIO_OPEN_SOURCE;
+		lookup->flags |= GPIO_OPEN_DRAIN;
+	} else if (sysfs_streq(page, "open-source")) {
+		lookup->flags &= ~GPIO_OPEN_DRAIN;
+		lookup->flags |= GPIO_OPEN_SOURCE;
+	} else {
+		count = -EINVAL;
+	}
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_consumer_lookup_config_, drive);
+
+static ssize_t
+gpio_consumer_lookup_config_pull_show(struct config_item *item, char *page)
+{
+	enum gpio_lookup_flags flags = gpio_consumer_lookup_get_flags(item);
+	const char *repr;
+
+	if (flags & GPIO_PULL_UP)
+		repr = "pull-up";
+	else if (flags & GPIO_PULL_DOWN)
+		repr = "pull-down";
+	else if (flags & GPIO_PULL_DISABLE)
+		repr = "pull-disabled";
+	else
+		repr = "as-is";
+
+	return sprintf(page, "%s\n", repr);
+}
+
+static ssize_t
+gpio_consumer_lookup_config_pull_store(struct config_item *item,
+				       const char *page, size_t count)
+{
+	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
+	struct gpio_consumer_device *dev = lookup->parent;
+
+	guard(mutex)(&dev->lock);
+
+	if (gpio_consumer_device_is_live_unlocked(dev))
+		return -EBUSY;
+
+	if (sysfs_streq(page, "pull-up")) {
+		lookup->flags &= ~(GPIO_PULL_DOWN | GPIO_PULL_DISABLE);
+		lookup->flags |= GPIO_PULL_UP;
+	} else if (sysfs_streq(page, "pull-down")) {
+		lookup->flags &= ~(GPIO_PULL_UP | GPIO_PULL_DISABLE);
+		lookup->flags |= GPIO_PULL_DOWN;
+	} else if (sysfs_streq(page, "pull-disabled")) {
+		lookup->flags &= ~(GPIO_PULL_UP | GPIO_PULL_DOWN);
+		lookup->flags |= GPIO_PULL_DISABLE;
+	} else if (sysfs_streq(page, "as-is")) {
+		lookup->flags &= ~(GPIO_PULL_UP | GPIO_PULL_DOWN |
+				   GPIO_PULL_DISABLE);
+	} else {
+		count = -EINVAL;
+	}
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_consumer_lookup_config_, pull);
+
+static ssize_t
+gpio_consumer_lookup_config_active_low_show(struct config_item *item,
+					    char *page)
+{
+	enum gpio_lookup_flags flags = gpio_consumer_lookup_get_flags(item);
+
+	return sprintf(page, "%s\n", flags & GPIO_ACTIVE_LOW ? "1" : "0");
+}
+
+static ssize_t
+gpio_consumer_lookup_config_active_low_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
+	struct gpio_consumer_device *dev = lookup->parent;
+	bool active_low;
+	int ret;
+
+	ret = kstrtobool(page, &active_low);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&dev->lock);
+
+	if (gpio_consumer_device_is_live_unlocked(dev))
+		return -EBUSY;
+
+	if (active_low)
+		lookup->flags |= GPIO_ACTIVE_LOW;
+	else
+		lookup->flags &= ~GPIO_ACTIVE_LOW;
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_consumer_lookup_config_, active_low);
+
+static ssize_t
+gpio_consumer_lookup_config_transitory_show(struct config_item *item,
+					    char *page)
+{
+	enum gpio_lookup_flags flags = gpio_consumer_lookup_get_flags(item);
+
+	return sprintf(page, "%s\n", flags & GPIO_TRANSITORY ? "1" : "0");
+}
+
+static ssize_t
+gpio_consumer_lookup_config_transitory_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
+	struct gpio_consumer_device *dev = lookup->parent;
+	bool transitory;
+	int ret;
+
+	ret = kstrtobool(page, &transitory);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&dev->lock);
+
+	if (gpio_consumer_device_is_live_unlocked(dev))
+		return -EBUSY;
+
+	if (transitory)
+		lookup->flags |= GPIO_TRANSITORY;
+	else
+		lookup->flags &= ~GPIO_TRANSITORY;
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_consumer_lookup_config_, transitory);
+
+static struct configfs_attribute *gpio_consumer_lookup_config_attrs[] = {
+	&gpio_consumer_lookup_config_attr_key,
+	&gpio_consumer_lookup_config_attr_offset,
+	&gpio_consumer_lookup_config_attr_drive,
+	&gpio_consumer_lookup_config_attr_pull,
+	&gpio_consumer_lookup_config_attr_active_low,
+	&gpio_consumer_lookup_config_attr_transitory,
+	NULL
+};
+
+static ssize_t gpio_consumer_device_config_live_show(struct config_item *item,
+						     char *page)
+{
+	struct gpio_consumer_device *dev = to_gpio_consumer_device(item);
+	bool live;
+
+	scoped_guard(mutex, &dev->lock)
+		live = gpio_consumer_device_is_live_unlocked(dev);
+
+	return sprintf(page, "%c\n", live ? '1' : '0');
+}
+
+static int
+gpio_consumer_make_lookup_table_unlocked(struct gpio_consumer_device *dev)
+{
+	struct gpiod_lookup_table *table __free(kfree) = NULL;
+	struct gpio_consumer_lookup *lookup;
+	struct gpiod_lookup *curr;
+	size_t num_entries;
+	unsigned int i = 0;
+
+	num_entries = list_count_nodes(&dev->lookup_list);
+	table = kzalloc(struct_size(table, table, num_entries), GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	table->dev_id = kasprintf(GFP_KERNEL, "gpio-virtual-consumer.%d",
+				  dev->id);
+	if (!table->dev_id)
+		return -ENOMEM;
+
+	list_for_each_entry(lookup, &dev->lookup_list, siblings) {
+		curr = &table->table[i];
+
+		curr->key = lookup->key;
+		curr->chip_hwnum = lookup->offset < 0 ?
+					U16_MAX : lookup->offset;
+		curr->con_id = lookup->con_id;
+		curr->flags = lookup->flags;
+	}
+
+	gpiod_add_lookup_table(table);
+	dev->lookup_table = no_free_ptr(table);
+
+	return 0;
+}
+
+static struct fwnode_handle *
+gpio_consumer_make_device_swnode(struct gpio_consumer_device *dev)
+{
+	struct property_entry properties[GPIO_CONSUMER_MAX_PROPS];
+	struct gpio_consumer_lookup *lookup;
+	char **lines __free(kfree) = NULL;
+	int prop_idx = 0, i = 0;
+	size_t num_lookups;
+
+	memset(properties, 0, sizeof(properties));
+
+	properties[prop_idx++] = PROPERTY_ENTRY_STRING(
+			"gpio-virtual-consumer,function",
+			gpio_consumer_function_strings[dev->function]);
+
+	num_lookups = list_count_nodes(&dev->lookup_list);
+	lines = kcalloc(num_lookups + 1, sizeof(*lines), GFP_KERNEL);
+	if (!lines)
+		return ERR_PTR(-ENOMEM);
+
+	list_for_each_entry(lookup, &dev->lookup_list, siblings)
+		lines[i++] = lookup->con_id;
+
+	properties[prop_idx++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
+		"gpio-virtual-consumer,lines", lines, num_lookups);
+
+	return fwnode_create_software_node(properties, NULL);
+}
+
+static int
+gpio_consumer_device_activate_unlocked(struct gpio_consumer_device *dev)
+{
+	struct platform_device_info pdevinfo;
+	struct fwnode_handle *swnode;
+	struct platform_device *pdev;
+	int ret;
+
+	if (list_empty(&dev->lookup_list))
+		return -ENODATA;
+
+	swnode = gpio_consumer_make_device_swnode(dev);
+	if (IS_ERR(swnode))
+		return PTR_ERR(swnode);
+
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+	pdevinfo.name = "gpio-virtual-consumer";
+	pdevinfo.id = dev->id;
+	pdevinfo.fwnode = swnode;
+
+	ret = gpio_consumer_make_lookup_table_unlocked(dev);
+	if (ret) {
+		fwnode_remove_software_node(swnode);
+		return ret;
+	}
+
+	reinit_completion(&dev->probe_completion);
+	dev->driver_bound = false;
+	bus_register_notifier(&platform_bus_type, &dev->bus_notifier);
+
+	pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(pdev)) {
+		bus_unregister_notifier(&platform_bus_type, &dev->bus_notifier);
+		fwnode_remove_software_node(swnode);
+		return PTR_ERR(pdev);
+	}
+
+	wait_for_completion(&dev->probe_completion);
+	bus_unregister_notifier(&platform_bus_type, &dev->bus_notifier);
+
+	if (!dev->driver_bound) {
+		platform_device_unregister(pdev);
+		fwnode_remove_software_node(swnode);
+		return -ENXIO;
+	}
+
+	dev->pdev = pdev;
+
+	return 0;
+}
+
+static void
+gpio_consumer_device_deactivate_unlocked(struct gpio_consumer_device *dev)
+{
+	struct fwnode_handle *swnode;
+
+	swnode = dev_fwnode(&dev->pdev->dev);
+	platform_device_unregister(dev->pdev);
+	fwnode_remove_software_node(swnode);
+	dev->pdev = NULL;
+	gpiod_remove_lookup_table(dev->lookup_table);
+	kfree(dev->lookup_table);
+}
+
+static ssize_t
+gpio_consumer_device_config_live_store(struct config_item *item,
+				       const char *page, size_t count)
+{
+	struct gpio_consumer_device *dev = to_gpio_consumer_device(item);
+	bool live;
+	int ret;
+
+	ret = kstrtobool(page, &live);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&dev->lock);
+
+	if (live == gpio_consumer_device_is_live_unlocked(dev))
+		ret = -EPERM;
+	else if (live)
+		ret = gpio_consumer_device_activate_unlocked(dev);
+	else
+		gpio_consumer_device_deactivate_unlocked(dev);
+
+	return ret ?: count;
+}
+
+CONFIGFS_ATTR(gpio_consumer_device_config_, live);
+
+static ssize_t
+gpio_consumer_device_config_function_show(struct config_item *item, char *page)
+{
+	struct gpio_consumer_device *dev = to_gpio_consumer_device(item);
+	enum gpio_consumer_function function;
+	const char *repr;
+
+	scoped_guard(mutex, &dev->lock)
+		function = dev->function;
+
+	repr = gpio_consumer_function_strings[function];
+
+	return sprintf(page, "%s\n", repr);
+}
+
+static ssize_t
+gpio_consumer_device_config_function_store(struct config_item *item,
+					   const char *page, size_t count)
+{
+	struct gpio_consumer_device *dev = to_gpio_consumer_device(item);
+	int ret;
+
+	ret = sysfs_match_string(gpio_consumer_function_strings, page);
+	if (ret < 0)
+		return -EINVAL;
+
+	guard(mutex)(&dev->lock);
+
+	if (gpio_consumer_device_is_live_unlocked(dev))
+		return -EBUSY;
+
+	dev->function = ret;
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_consumer_device_config_, function);
+
+static struct configfs_attribute *gpio_consumer_device_config_attrs[] = {
+	&gpio_consumer_device_config_attr_live,
+	&gpio_consumer_device_config_attr_function,
+	NULL
+};
+
+static void gpio_consumer_lookup_config_group_release(struct config_item *item)
+{
+	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
+	struct gpio_consumer_device *dev = lookup->parent;
+
+	guard(mutex)(&dev->lock);
+
+	list_del(&lookup->siblings);
+
+	kfree(lookup->con_id);
+	kfree(lookup->key);
+	kfree(lookup);
+}
+
+static struct configfs_item_operations gpio_consumer_lookup_config_item_ops = {
+	.release	= gpio_consumer_lookup_config_group_release,
+};
+
+static const struct config_item_type gpio_consumer_lookup_config_group_type = {
+	.ct_item_ops	= &gpio_consumer_lookup_config_item_ops,
+	.ct_attrs	= gpio_consumer_lookup_config_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *
+gpio_consumer_device_make_lookup_group(struct config_group *group,
+				       const char *name)
+{
+	struct gpio_consumer_device *dev =
+			to_gpio_consumer_device(&group->cg_item);
+	struct gpio_consumer_lookup *lookup __free(kfree) = NULL;
+
+	guard(mutex)(&dev->lock);
+
+	if (gpio_consumer_device_is_live_unlocked(dev))
+		return ERR_PTR(-EBUSY);
+
+	lookup = kzalloc(sizeof(*lookup), GFP_KERNEL);
+	if (!lookup)
+		return ERR_PTR(-ENOMEM);
+
+	lookup->con_id = kstrdup(name, GFP_KERNEL);
+	if (!lookup->con_id)
+		return ERR_PTR(-ENOMEM);
+
+	config_group_init_type_name(&lookup->group, name,
+				    &gpio_consumer_lookup_config_group_type);
+	lookup->flags = GPIO_LOOKUP_FLAGS_DEFAULT;
+	lookup->parent = dev;
+	list_add_tail(&lookup->siblings, &dev->lookup_list);
+
+	return &no_free_ptr(lookup)->group;
+}
+
+static void gpio_consumer_device_config_group_release(struct config_item *item)
+{
+	struct gpio_consumer_device *dev = to_gpio_consumer_device(item);
+
+	guard(mutex)(&dev->lock);
+
+	if (gpio_consumer_device_is_live_unlocked(dev))
+		gpio_consumer_device_deactivate_unlocked(dev);
+
+	mutex_destroy(&dev->lock);
+	ida_free(&gpio_consumer_ida, dev->id);
+	kfree(dev);
+}
+
+static struct configfs_item_operations gpio_consumer_device_config_item_ops = {
+	.release	= gpio_consumer_device_config_group_release,
+};
+
+static struct configfs_group_operations gpio_consumer_device_config_group_ops = {
+	.make_group	= gpio_consumer_device_make_lookup_group,
+};
+
+static const struct config_item_type gpio_consumer_device_config_group_type = {
+	.ct_group_ops	= &gpio_consumer_device_config_group_ops,
+	.ct_item_ops	= &gpio_consumer_device_config_item_ops,
+	.ct_attrs	= gpio_consumer_device_config_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *
+gpio_consumer_config_make_device_group(struct config_group *group,
+				       const char *name)
+{
+	struct gpio_consumer_device *dev __free(kfree) = NULL;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->id = ida_alloc(&gpio_consumer_ida, GFP_KERNEL);
+	if (dev->id < 0)
+		return ERR_PTR(dev->id);
+
+	config_group_init_type_name(&dev->group, name,
+				    &gpio_consumer_device_config_group_type);
+	mutex_init(&dev->lock);
+	INIT_LIST_HEAD(&dev->lookup_list);
+	dev->bus_notifier.notifier_call = gpio_consumer_bus_notifier_call;
+	dev->function = GPIO_CONSUMER_FUNCTION_ACTIVE;
+	init_completion(&dev->probe_completion);
+
+	return &no_free_ptr(dev)->group;
+}
+
+static struct configfs_group_operations gpio_consumer_config_group_ops = {
+	.make_group	= gpio_consumer_config_make_device_group,
+};
+
+static const struct config_item_type gpio_consumer_config_type = {
+	.ct_group_ops	= &gpio_consumer_config_group_ops,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct configfs_subsystem gpio_consumer_config_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf	= "gpio-consumer",
+			.ci_type	= &gpio_consumer_config_type,
+		},
+	},
+};
+
+static int __init gpio_consumer_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&gpio_consumer_driver);
+	if (ret) {
+		pr_err("Failed to register the platform driver: %d\n",
+		       ret);
+		return ret;
+	}
+
+	config_group_init(&gpio_consumer_config_subsys.su_group);
+	mutex_init(&gpio_consumer_config_subsys.su_mutex);
+	ret = configfs_register_subsystem(&gpio_consumer_config_subsys);
+	if (ret) {
+		pr_err("Failed to register the '%s' configfs subsystem: %d\n",
+		       gpio_consumer_config_subsys.su_group.cg_item.ci_namebuf,
+		       ret);
+		mutex_destroy(&gpio_consumer_config_subsys.su_mutex);
+		platform_driver_unregister(&gpio_consumer_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(gpio_consumer_init);
+
+static void __exit gpio_consumer_exit(void)
+{
+	configfs_unregister_subsystem(&gpio_consumer_config_subsys);
+	mutex_destroy(&gpio_consumer_config_subsys.su_mutex);
+	platform_driver_unregister(&gpio_consumer_driver);
+}
+module_exit(gpio_consumer_exit);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("Virtual GPIO consumer module");
+MODULE_LICENSE("GPL");
-- 
2.39.2

