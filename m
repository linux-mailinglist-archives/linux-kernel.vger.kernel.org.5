Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B429F7E675F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjKIKHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjKIKG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:06:57 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC032D76
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:06:50 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5bdc185c449so544923a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699524410; x=1700129210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5ye6xQE9knRoa1If0NJpRXCWT7E3YY80pCdkZR9RUU=;
        b=hZBMy4UDuygUobGSPbCJdhb96NSnsSTjP2nF6QnsG8V12c3KKo1pIJGq9xtZ7CzMzY
         sphs0p80O7vxqDIuBLcl+hRtdFJL03cgV2gegaHWB213UJhwgOSwZaUZi1lFIzORVff0
         QZyTC2jQNVjSP1hJ5OG/14Q6vcmTeKlec3gqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524410; x=1700129210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5ye6xQE9knRoa1If0NJpRXCWT7E3YY80pCdkZR9RUU=;
        b=o/Z3Av/unfTUzBv/EXwSIhU2ck4pF1CbWc8iGD/Tnc23y9y1u/EnbautJgmEsGUMoj
         Q7n5baLdRKHNT82IP20xs1lapHF+5zW19DknT+fymZhq/tkkfcf80RTJVZBthgf0kC5x
         xXp/ErQgkAPNzV7kwb2lVr09y5L9Ygb+KFSvitIcKrE1L8dJJ45j57GgXjaaA7Wm6iYS
         f9PgyBJ+eooL3HWnLRP35ZTlCkxssQGwHi8cc81+QyQkT1LcTHOi550QHt23HG4Uf2QA
         7Vku+knwk+Q/pVXWwlEkigHh3s3rBIaAfvLHAnfUTzQ/1KkWXDmd9RNBPTNhpV3QSjuJ
         HIxw==
X-Gm-Message-State: AOJu0Yy3Lcgw0poXg+dHNkDxPnaABPuvWny0JTYlcC0kpD2TZjqVCKk3
        TxgNGcEnHfcrGMIMIEv4ixWn9w==
X-Google-Smtp-Source: AGHT+IHfRhp6aSHaPlAD6Z0UbsTUInpZ/6xri+wdrZK5r1MjtzbG8S3+Ea6iHjo67SKMt6d5dpyRgA==
X-Received: by 2002:a17:902:8c83:b0:1cc:2c45:757a with SMTP id t3-20020a1709028c8300b001cc2c45757amr4475248plo.10.1699524409702;
        Thu, 09 Nov 2023 02:06:49 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6f57:d4c:468c:5daf])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001c60ba709b7sm3127511plg.125.2023.11.09.02.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:06:49 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hovold <johan@kernel.org>
Subject: [RFC PATCH v2 2/7] of: Introduce hardware prober driver
Date:   Thu,  9 Nov 2023 18:05:59 +0800
Message-ID: <20231109100606.1245545-3-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231109100606.1245545-1-wenst@chromium.org>
References: <20231109100606.1245545-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices are designed and manufactured with some components having
multiple drop-in replacement options. These components are often
connected to the mainboard via ribbon cables, having the same signals
and pin assignments across all options. These may include the display
panel and touchscreen on laptops and tablets, and the trackpad on
laptops. Sometimes which component option is used in a particular device
can be detected by some firmware provided identifier, other times that
information is not available, and the kernel has to try to probe each
device.

This change attempts to make the "probe each device" case cleaner. The
current approach is to have all options added and enabled in the device
tree. The kernel would then bind each device and run each driver's probe
function. This works, but has been broken before due to the introduction
of asynchronous probing, causing multiple instances requesting "shared"
resources, such as pinmuxes, GPIO pins, interrupt lines, at the same
time, with only one instance succeeding. Work arounds for these include
moving the pinmux to the parent I2C controller, using GPIO hogs or
pinmux settings to keep the GPIO pins in some fixed configuration, and
requesting the interrupt line very late. Such configurations can be seen
on the MT8183 Krane Chromebook tablets, and the Qualcomm sc8280xp-based
Lenovo Thinkpad 13S.

Instead of this delicate dance between drivers and device tree quirks,
this change introduces a simple I2C component prober. For any given
class of devices on the same I2C bus, it will go through all of them,
doing a simple I2C read transfer and see which one of them responds.
It will then enable the device that responds.

This requires some minor modifications in the existing device tree.
The status for all the device nodes for the component options must be
set to "failed-needs-probe-xxx". This makes it clear that some mechanism
is needed to enable one of them, and also prevents the prober and device
drivers running at the same time.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/of/Kconfig     |  13 ++++
 drivers/of/Makefile    |   1 +
 drivers/of/hw_prober.c | 154 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/of/hw_prober.c

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index da9826accb1b..269d20d51936 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -102,4 +102,17 @@ config OF_OVERLAY
 config OF_NUMA
 	bool
 
+config HW_PROBER
+	bool "Hardware Prober driver"
+	select I2C
+	select OF_DYNAMIC
+	help
+	  Some devices will have multiple drop-in options for one component.
+	  In many cases the different options are indistinguishable by the
+	  kernel without actually probing each possible option.
+
+	  This driver is meant to handle the probing of such components, and
+	  update the running device tree such that the correct variant is
+	  made available.
+
 endif # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index eff624854575..ed3875cdc554 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
 obj-$(CONFIG_OF_RESOLVE)  += resolver.o
 obj-$(CONFIG_OF_OVERLAY) += overlay.o
 obj-$(CONFIG_OF_NUMA) += of_numa.o
+obj-$(CONFIG_HW_PROBER) += hw_prober.o
 
 ifdef CONFIG_KEXEC_FILE
 ifdef CONFIG_OF_FLATTREE
diff --git a/drivers/of/hw_prober.c b/drivers/of/hw_prober.c
new file mode 100644
index 000000000000..442da6eff896
--- /dev/null
+++ b/drivers/of/hw_prober.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * hw_prober.c - Hardware prober driver
+ *
+ * Copyright (c) 2023 Google LLC
+ */
+
+#include <linux/array_size.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#define DRV_NAME	"hw_prober"
+
+/**
+ * struct hw_prober_entry - Holds an entry for the hardware prober
+ *
+ * @compatible:	compatible string to match against the machine
+ * @prober:	prober function to call when machine matches
+ * @data:	extra data for the prober function
+ */
+struct hw_prober_entry {
+	const char *compatible;
+	int (*prober)(struct platform_device *pdev, const void *data);
+	const void *data;
+};
+
+/*
+ * Some devices, such as Google Hana Chromebooks, are produced by multiple
+ * vendors each using their preferred components. This prober assumes such
+ * drop-in parts are on dedicated I2C busses, have non-conflicting addresses,
+ * and can be directly probed by seeing which address responds without needing
+ * regulators or GPIOs being enabled or toggled.
+ */
+static int i2c_component_prober(struct platform_device *pdev, const void *data)
+{
+	const char *node_name = data;
+	struct device_node *node, *i2c_node;
+	struct i2c_adapter *i2c;
+	int ret = 0;
+
+	node = of_find_node_by_name(NULL, node_name);
+	if (!node)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Could not find %s device node\n",
+				     node_name);
+
+	i2c_node = of_get_next_parent(node);
+	if (strcmp(i2c_node->name, "i2c")) {
+		of_node_put(i2c_node);
+		return dev_err_probe(&pdev->dev, -EINVAL, "%s device isn't on I2C bus\n",
+				     node_name);
+	}
+
+	for_each_child_of_node(i2c_node, node) {
+		if (!of_node_name_prefix(node, node_name))
+			continue;
+		if (!of_device_is_fail(node)) {
+			/* device tree has component already enabled */
+			of_node_put(node);
+			of_node_put(i2c_node);
+			return 0;
+		}
+	}
+
+	i2c = of_get_i2c_adapter_by_node(i2c_node);
+	if (!i2c) {
+		of_node_put(i2c_node);
+		return dev_err_probe(&pdev->dev, -EPROBE_DEFER, "Couldn't get I2C adapter\n");
+	}
+
+	for_each_child_of_node(i2c_node, node) {
+		struct property *prop;
+		union i2c_smbus_data data;
+		u32 addr;
+
+		if (!of_node_name_prefix(node, node_name))
+			continue;
+		if (of_property_read_u32(node, "reg", &addr))
+			continue;
+		if (i2c_smbus_xfer(i2c, addr, 0, I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &data) < 0)
+			continue;
+
+		dev_info(&pdev->dev, "Enabling %pOF\n", node);
+
+		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+		if (!prop) {
+			ret = -ENOMEM;
+			of_node_put(node);
+			break;
+		}
+
+		prop->name	= "status";
+		prop->length	= 5;
+		prop->value	= "okay";
+
+		/* Found a device that is responding */
+		ret = of_update_property(node, prop);
+		if (ret)
+			kfree(prop);
+
+		of_node_put(node);
+		break;
+	}
+
+	i2c_put_adapter(i2c);
+	of_node_put(i2c_node);
+
+	return ret;
+}
+
+static const struct hw_prober_entry hw_prober_platforms[] = {
+	{ .compatible = "google,hana", .prober = i2c_component_prober, .data = "touchscreen" },
+	{ .compatible = "google,hana", .prober = i2c_component_prober, .data = "trackpad" },
+};
+
+static int hw_prober_probe(struct platform_device *pdev)
+{
+	for (int i = 0; i < ARRAY_SIZE(hw_prober_platforms); i++)
+		if (of_machine_is_compatible(hw_prober_platforms[i].compatible)) {
+			int ret;
+
+			ret = hw_prober_platforms[i].prober(pdev, hw_prober_platforms[i].data);
+			if (ret)
+				return ret;
+		}
+
+	return 0;
+}
+
+static struct platform_driver hw_prober_driver = {
+	.probe	= hw_prober_probe,
+	.driver	= {
+		.name = DRV_NAME,
+	},
+};
+
+static int __init hw_prober_driver_init(void)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	ret = platform_driver_register(&hw_prober_driver);
+	if (ret)
+		return ret;
+
+	pdev = platform_device_register_simple(DRV_NAME, -1, NULL, 0);
+	if (!IS_ERR(pdev))
+		return 0;
+
+	platform_driver_unregister(&hw_prober_driver);
+
+	return PTR_ERR(pdev);
+}
+device_initcall(hw_prober_driver_init);
-- 
2.42.0.869.gea05f2083d-goog

