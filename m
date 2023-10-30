Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A37DBB72
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjJ3OLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjJ3OKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:10:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEDDC0;
        Mon, 30 Oct 2023 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698675046; x=1730211046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uGB4jg6XIxc7IMEu6ImEB9gv7asQs83ih6t49ztympg=;
  b=Efk5FWJJYdSP3F4TxW4Hviv6Rxrnu7Hk82Q80oZS6uAI0wyAK/ODE7lf
   FrMfWt/9HnmAzyqaQ+/p/N8fR+2BK0jkefXgf+AY+pyJDmL5B0pebChYg
   hMlbl+zVeK+N3GZZrqIAX/WTMaNBykDNSmhhuOLV6Tj+4X0vPK8Hw0wWb
   ncO+z5GkTUcqd3nrrrKgN5EH/BsWj+0mEfE9PafbMm5oHiFLEIeEYPXSk
   O2TKsjbT7qsxYFFxRO1eUy8F9XzLmnDKnjPR4QUgvEDSwD9/X/Mq+0Qp2
   oW6UOmMlJcI0iRrNKliRb3hM635HXzGACMqk2IdFLQ2I74G+k5MZyUtSM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="378447171"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="378447171"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 07:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="710102230"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="710102230"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2023 07:10:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 894B3304; Mon, 30 Oct 2023 16:10:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raag Jadav <raag.jadav@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/3] pinctrl: intel: Add a generic Intel pin control platform driver
Date:   Mon, 30 Oct 2023 16:10:33 +0200
Message-Id: <20231030141034.3241674-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231030141034.3241674-1-andriy.shevchenko@linux.intel.com>
References: <20231030141034.3241674-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New generations of Intel platforms will provide better description
of the pin control devices in the ACPI tables. Hence, we may provide
a generic pin control platform driver to cover all of them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/Kconfig                 |   8 +
 drivers/pinctrl/intel/Makefile                |   1 +
 .../pinctrl/intel/pinctrl-intel-platform.c    | 223 ++++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100644 drivers/pinctrl/intel/pinctrl-intel-platform.c

diff --git a/drivers/pinctrl/intel/Kconfig b/drivers/pinctrl/intel/Kconfig
index d66f4f6932d8..42a6bc8b7a45 100644
--- a/drivers/pinctrl/intel/Kconfig
+++ b/drivers/pinctrl/intel/Kconfig
@@ -37,6 +37,14 @@ config PINCTRL_INTEL
 	select GPIOLIB
 	select GPIOLIB_IRQCHIP
 
+config PINCTRL_INTEL_PLATFORM
+	tristate "Intel pinctrl and GPIO platform driver"
+	depends on ACPI
+	select PINCTRL_INTEL
+	help
+	  This pinctrl driver provides an interface that allows configuring
+	  of Intel PCH pins and using them as GPIOs.
+
 config PINCTRL_ALDERLAKE
 	tristate "Intel Alder Lake pinctrl and GPIO driver"
 	select PINCTRL_INTEL
diff --git a/drivers/pinctrl/intel/Makefile b/drivers/pinctrl/intel/Makefile
index f6d30f2d973a..96c93ed4bd58 100644
--- a/drivers/pinctrl/intel/Makefile
+++ b/drivers/pinctrl/intel/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PINCTRL_TANGIER)		+= pinctrl-tangier.o
 obj-$(CONFIG_PINCTRL_MERRIFIELD)	+= pinctrl-merrifield.o
 obj-$(CONFIG_PINCTRL_MOOREFIELD)	+= pinctrl-moorefield.o
 obj-$(CONFIG_PINCTRL_INTEL)		+= pinctrl-intel.o
+obj-$(CONFIG_PINCTRL_INTEL_PLATFORM)	+= pinctrl-intel-platform.o
 obj-$(CONFIG_PINCTRL_ALDERLAKE)		+= pinctrl-alderlake.o
 obj-$(CONFIG_PINCTRL_BROXTON)		+= pinctrl-broxton.o
 obj-$(CONFIG_PINCTRL_CANNONLAKE)	+= pinctrl-cannonlake.o
diff --git a/drivers/pinctrl/intel/pinctrl-intel-platform.c b/drivers/pinctrl/intel/pinctrl-intel-platform.c
new file mode 100644
index 000000000000..2305d8befdd3
--- /dev/null
+++ b/drivers/pinctrl/intel/pinctrl-intel-platform.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel PCH pinctrl/GPIO driver
+ *
+ * Copyright (C) 2021-2023, Intel Corporation
+ * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/property.h>
+#include <linux/string_helpers.h>
+
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-intel.h"
+
+struct intel_platform_pins {
+	struct pinctrl_pin_desc *pins;
+	size_t npins;
+};
+
+static int intel_platform_pinctrl_prepare_pins(struct device *dev, size_t base,
+					       const char *name, u32 size,
+					       struct intel_platform_pins *pins)
+{
+	struct pinctrl_pin_desc *descs;
+	char **pin_names;
+	unsigned int i;
+
+	pin_names = devm_kasprintf_strarray(dev, name, size);
+	if (IS_ERR(pin_names))
+		return PTR_ERR(pin_names);
+
+	descs = devm_krealloc_array(dev, pins->pins, base + size, sizeof(*descs), GFP_KERNEL);
+	if (!descs)
+		return -ENOMEM;
+
+	for (i = 0; i < size; i++) {
+		unsigned int pin_number = base + i;
+		char *pin_name = pin_names[i];
+		struct pinctrl_pin_desc *desc;
+
+		/* Unify delimiter for pin name */
+		strreplace(pin_name, '-', '_');
+
+		desc = &descs[pin_number];
+		desc->number = pin_number;
+		desc->name = pin_name;
+	}
+
+	pins->pins = descs;
+	pins->npins = base + size;
+
+	return 0;
+}
+
+static int intel_platform_pinctrl_prepare_group(struct device *dev,
+						struct fwnode_handle *child,
+						struct intel_padgroup *gpp,
+						struct intel_platform_pins *pins)
+{
+	size_t base = pins->npins;
+	const char *name;
+	u32 size;
+	int ret;
+
+	ret = fwnode_property_read_string(child, "intc-gpio-group-name", &name);
+	if (ret)
+		return ret;
+
+	ret = fwnode_property_read_u32(child, "intc-gpio-pad-count", &size);
+	if (ret)
+		return ret;
+
+	ret = intel_platform_pinctrl_prepare_pins(dev, base, name, size, pins);
+	if (ret)
+		return ret;
+
+	gpp->base = base;
+	gpp->size = size;
+	gpp->gpio_base = INTEL_GPIO_BASE_MATCH;
+
+	return 0;
+}
+
+static int intel_platform_pinctrl_prepare_community(struct device *dev,
+						    struct intel_community *community,
+						    struct intel_platform_pins *pins)
+{
+	struct fwnode_handle *child;
+	struct intel_padgroup *gpps;
+	unsigned int group;
+	size_t ngpps;
+	u32 offset;
+	int ret;
+
+	ret = device_property_read_u32(dev, "intc-gpio-pad-ownership-offset", &offset);
+	if (ret)
+		return ret;
+	community->padown_offset = offset;
+
+	ret = device_property_read_u32(dev, "intc-gpio-pad-configuration-lock-offset", &offset);
+	if (ret)
+		return ret;
+	community->padcfglock_offset = offset;
+
+	ret = device_property_read_u32(dev, "intc-gpio-host-software-pad-ownership-offset", &offset);
+	if (ret)
+		return ret;
+	community->hostown_offset = offset;
+
+	ret = device_property_read_u32(dev, "intc-gpio-gpi-interrupt-status-offset", &offset);
+	if (ret)
+		return ret;
+	community->is_offset = offset;
+
+	ret = device_property_read_u32(dev, "intc-gpio-gpi-interrupt-enable-offset", &offset);
+	if (ret)
+		return ret;
+	community->ie_offset = offset;
+
+	ngpps = device_get_child_node_count(dev);
+	if (ngpps == 0)
+		return -ENODEV;
+
+	gpps = devm_kcalloc(dev, ngpps, sizeof(*gpps), GFP_KERNEL);
+	if (!gpps)
+		return -ENOMEM;
+
+	group = 0;
+	device_for_each_child_node(dev, child) {
+		struct intel_padgroup *gpp = &gpps[group];
+
+		gpp->reg_num = group;
+
+		ret = intel_platform_pinctrl_prepare_group(dev, child, gpp, pins);
+		if (ret)
+			return ret;
+
+		group++;
+	}
+
+	community->ngpps = ngpps;
+	community->gpps = gpps;
+
+	return 0;
+}
+
+static int intel_platform_pinctrl_prepare_soc_data(struct device *dev,
+						   struct intel_pinctrl_soc_data *data)
+{
+	struct intel_platform_pins pins = {};
+	struct intel_community *communities;
+	size_t ncommunities;
+	unsigned int i;
+	int ret;
+
+	ncommunities = 1,
+	communities = devm_kcalloc(dev, ncommunities, sizeof(*communities), GFP_KERNEL);
+	if (!communities)
+		return -ENOMEM;
+
+	for (i = 0; i < ncommunities; i++) {
+		struct intel_community *community = &communities[i];
+
+		community->barno = i;
+		community->pin_base = pins.npins;
+
+		ret = intel_platform_pinctrl_prepare_community(dev, community, &pins);
+		if (ret)
+			return ret;
+
+		community->npins = pins.npins - community->pin_base;
+	}
+
+	data->ncommunities = ncommunities;
+	data->communities = communities;
+
+	data->npins = pins.npins;
+	data->pins = pins.pins;
+
+	return 0;
+}
+
+static int intel_platform_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_pinctrl_soc_data *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = intel_platform_pinctrl_prepare_soc_data(dev, data);
+	if (ret)
+		return ret;
+
+	return intel_pinctrl_probe(pdev, data);
+}
+
+static const struct acpi_device_id intel_platform_pinctrl_acpi_match[] = {
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, intel_platform_pinctrl_acpi_match);
+
+static struct platform_driver intel_platform_pinctrl_driver = {
+	.probe = intel_platform_pinctrl_probe,
+	.driver = {
+		.name = "intel-pinctrl",
+		.acpi_match_table = intel_platform_pinctrl_acpi_match,
+		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
+	},
+};
+module_platform_driver(intel_platform_pinctrl_driver);
+
+MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_DESCRIPTION("Intel PCH pinctrl/GPIO driver");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PINCTRL_INTEL);
-- 
2.40.0.1.gaa8946217a0b

