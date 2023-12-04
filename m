Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41EE8032D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344109AbjLDMdj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 07:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjLDMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:33:23 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14B010E;
        Mon,  4 Dec 2023 04:33:20 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 112F624E255;
        Mon,  4 Dec 2023 20:33:18 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 4 Dec
 2023 20:33:17 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 4 Dec
 2023 20:33:17 +0800
From:   Keith Zhao <keith.zhao@starfivetech.com>
To:     Keith Zhao <keith.zhao@starfivetech.com>,
        <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <william.qiu@starfivetech.com>, <xingyu.wu@starfivetech.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <p.zabel@pengutronix.de>,
        <shengyang.chen@starfivetech.com>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>,
        <maarten.lankhorst@linux.intel.com>, <suijingfeng@loongson.cn>
Subject: [v3 3/6] drm/vs: Register DRM device
Date:   Mon, 4 Dec 2023 20:33:12 +0800
Message-ID: <20231204123315.28456-4-keith.zhao@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204123315.28456-1-keith.zhao@starfivetech.com>
References: <20231204123315.28456-1-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement drm device registration interface

Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
---
 MAINTAINERS                              |   1 +
 drivers/gpu/drm/Kconfig                  |   2 +
 drivers/gpu/drm/Makefile                 |   1 +
 drivers/gpu/drm/verisilicon/Kconfig      |  13 +
 drivers/gpu/drm/verisilicon/Makefile     |   6 +
 drivers/gpu/drm/verisilicon/vs_drv.c     | 316 +++++++++++++++++++++++
 drivers/gpu/drm/verisilicon/vs_drv.h     |  42 +++
 drivers/gpu/drm/verisilicon/vs_modeset.c |  39 +++
 drivers/gpu/drm/verisilicon/vs_modeset.h |  10 +
 9 files changed, 430 insertions(+)
 create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
 create mode 100644 drivers/gpu/drm/verisilicon/Makefile
 create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7caaadb83f3f..8dc9ebfe4605 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6887,6 +6887,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/starfive/
+F:	drivers/gpu/drm/verisilicon/
 
 DRM DRIVER FOR TI DLPC3433 MIPI DSI TO DMD BRIDGE
 M:	Jagan Teki <jagan@amarulasolutions.com>
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 3eee8636f847..e8d53c2e7c86 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -394,6 +394,8 @@ source "drivers/gpu/drm/solomon/Kconfig"
 
 source "drivers/gpu/drm/sprd/Kconfig"
 
+source "drivers/gpu/drm/verisilicon/Kconfig"
+
 config DRM_HYPERV
 	tristate "DRM Support for Hyper-V synthetic video device"
 	depends on DRM && PCI && MMU && HYPERV
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 8e1bde059170..29e04acded06 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -198,3 +198,4 @@ obj-$(CONFIG_DRM_HYPERV) += hyperv/
 obj-y			+= solomon/
 obj-$(CONFIG_DRM_SPRD) += sprd/
 obj-$(CONFIG_DRM_LOONGSON) += loongson/
+obj-$(CONFIG_DRM_VERISILICON) += verisilicon/
diff --git a/drivers/gpu/drm/verisilicon/Kconfig b/drivers/gpu/drm/verisilicon/Kconfig
new file mode 100644
index 000000000000..e10fa97635aa
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+config DRM_VERISILICON
+	tristate "DRM Support for VeriSilicon"
+	depends on DRM
+	select DRM_KMS_HELPER
+	select DRM_GEM_DMA_HELPER
+	select CMA
+	select DMA_CMA
+	help
+	  Choose this option if you have a VeriSilicon soc chipset.
+	  This driver provides VeriSilicon kernel mode
+	  setting and buffer management. It does not
+	  provide 2D or 3D acceleration.
diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
new file mode 100644
index 000000000000..d785a1dfaa7f
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+vs_drm-objs := vs_drv.o \
+	       vs_modeset.o
+
+obj-$(CONFIG_DRM_VERISILICON) += vs_drm.o
diff --git a/drivers/gpu/drm/verisilicon/vs_drv.c b/drivers/gpu/drm/verisilicon/vs_drv.c
new file mode 100644
index 000000000000..4fb1f29ef84b
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_drv.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
+ */
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/of_clk.h>
+#include <linux/pm_runtime.h>
+
+#include <drm/drm_aperture.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_module.h>
+#include <drm/drm_of.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
+
+#include "vs_drv.h"
+#include "vs_modeset.h"
+
+#define DRV_NAME	"verisilicon"
+#define DRV_DESC	"Verisilicon DRM driver"
+#define DRV_DATE	"20230516"
+#define DRV_MAJOR	1
+#define DRV_MINOR	0
+
+static int vs_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
+			      struct drm_mode_create_dumb *args)
+{
+	struct vs_drm_device *priv = to_vs_drm_private(dev);
+	unsigned int pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
+
+	args->pitch = ALIGN(pitch, priv->pitch_alignment);
+	return drm_gem_dma_dumb_create_internal(file, dev, args);
+}
+
+DEFINE_DRM_GEM_FOPS(vs_drm_fops);
+
+static struct drm_driver vs_drm_driver = {
+	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
+
+	DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(vs_gem_dumb_create),
+
+	.fops			= &vs_drm_fops,
+	.name			= DRV_NAME,
+	.desc			= DRV_DESC,
+	.date			= DRV_DATE,
+	.major			= DRV_MAJOR,
+	.minor			= DRV_MINOR,
+};
+
+static void vs_drm_device_release_clocks(void *res)
+{
+	struct vs_drm_device *priv = res;
+	unsigned int i;
+
+	reset_control_bulk_assert(priv->nrsts, priv->rst_vout);
+
+	for (i = 0; i < priv->clk_count; ++i) {
+		if (priv->clks[i]) {
+			clk_disable_unprepare(priv->clks[i]);
+			clk_put(priv->clks[i]);
+		}
+	}
+}
+
+static const char * const vout_resets[] = {
+	"axi",
+	"ahb",
+	"core",
+};
+
+static int vs_drm_device_init_clocks(struct vs_drm_device *priv)
+{
+	struct drm_device *dev = &priv->base;
+	struct platform_device *pdev = to_platform_device(dev->dev);
+	struct device_node *of_node = pdev->dev.of_node;
+	struct clk *clock;
+	unsigned int i;
+	int ret;
+
+	if (dev_get_platdata(&pdev->dev) || !of_node)
+		return 0;
+
+	priv->nrsts = ARRAY_SIZE(priv->rst_vout);
+	for (int i = 0; i < priv->nrsts; ++i)
+		priv->rst_vout[i].id = vout_resets[i];
+	ret = devm_reset_control_bulk_get_shared(dev->dev, priv->nrsts,
+						 priv->rst_vout);
+	if (ret) {
+		drm_err(dev, "Failed to get reset controls\n");
+		return ret;
+	}
+
+	priv->clk_count = of_clk_get_parent_count(of_node);
+	if (!priv->clk_count)
+		return 0;
+
+	priv->clks = drmm_kzalloc(dev, priv->clk_count * sizeof(priv->clks[0]),
+				  GFP_KERNEL);
+	if (!priv->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->clk_count; ++i) {
+		clock = of_clk_get(of_node, i);
+		if (IS_ERR(clock)) {
+			ret = PTR_ERR(clock);
+			if (ret == -EPROBE_DEFER)
+				goto err;
+			drm_err(dev, "clock %u not found: %d\n", i, ret);
+			continue;
+		}
+		ret = clk_prepare_enable(clock);
+		if (ret) {
+			drm_err(dev, "failed to enable clock %u: %d\n",
+				i, ret);
+			clk_put(clock);
+			continue;
+		}
+		priv->clks[i] = clock;
+	}
+
+	ret = reset_control_bulk_deassert(priv->nrsts, priv->rst_vout);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&pdev->dev,
+					vs_drm_device_release_clocks,
+					priv);
+
+err:
+	while (i) {
+		--i;
+		if (priv->clks[i]) {
+			clk_disable_unprepare(priv->clks[i]);
+			clk_put(priv->clks[i]);
+		}
+	}
+	return ret;
+}
+
+static int vs_drm_bind(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct vs_drm_device *priv;
+	int ret;
+	struct drm_device *drm_dev;
+
+	/* Remove existing drivers that may own the framebuffer memory. */
+	ret = drm_aperture_remove_framebuffers(&vs_drm_driver);
+	if (ret)
+		return ret;
+
+	priv = devm_drm_dev_alloc(dev, &vs_drm_driver, struct vs_drm_device, base);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
+
+	priv->pitch_alignment = 64;
+
+	ret = dma_set_coherent_mask(priv->base.dev, DMA_BIT_MASK(40));
+	if (ret)
+		return ret;
+
+	drm_dev = &priv->base;
+	platform_set_drvdata(pdev, drm_dev);
+
+	ret = vs_drm_device_init_clocks(priv);
+	if (ret)
+		return ret;
+
+	vs_mode_config_init(drm_dev);
+
+	/* Now try and bind all our sub-components */
+	ret = component_bind_all(dev, drm_dev);
+	if (ret)
+		return ret;
+
+	ret = drm_vblank_init(drm_dev, drm_dev->mode_config.num_crtc);
+	if (ret)
+		return ret;
+
+	drm_mode_config_reset(drm_dev);
+
+	drm_kms_helper_poll_init(drm_dev);
+
+	ret = drm_dev_register(drm_dev, 0);
+	if (ret)
+		return ret;
+
+	drm_fbdev_generic_setup(drm_dev, 32);
+
+	return 0;
+}
+
+static void vs_drm_unbind(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	drm_dev_unregister(drm_dev);
+	drm_kms_helper_poll_fini(drm_dev);
+	component_unbind_all(drm_dev->dev, drm_dev);
+}
+
+static const struct component_master_ops vs_drm_ops = {
+	.bind = vs_drm_bind,
+	.unbind = vs_drm_unbind,
+};
+
+static struct platform_driver *drm_sub_drivers[] = {
+};
+
+static struct component_match *vs_drm_match_add(struct device *dev)
+{
+	struct component_match *match = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(drm_sub_drivers); ++i) {
+		struct platform_driver *drv = drm_sub_drivers[i];
+		struct device *p = NULL, *d;
+
+		while ((d = platform_find_device_by_driver(p, &drv->driver))) {
+			put_device(p);
+
+			drm_of_component_match_add(dev, &match, component_compare_of,
+						   d->of_node);
+			p = d;
+		}
+		put_device(p);
+	}
+
+	return match ? match : ERR_PTR(-ENODEV);
+}
+
+static int vs_drm_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct component_match *match;
+
+	match = vs_drm_match_add(dev);
+	if (IS_ERR(match))
+		return PTR_ERR(match);
+
+	return component_master_add_with_match(dev, &vs_drm_ops, match);
+}
+
+static int vs_drm_platform_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &vs_drm_ops);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int vs_drm_suspend(struct device *dev)
+{
+	return drm_mode_config_helper_suspend(dev_get_drvdata(dev));
+}
+
+static int vs_drm_resume(struct device *dev)
+{
+	drm_mode_config_helper_resume(dev_get_drvdata(dev));
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(vs_drm_pm_ops, vs_drm_suspend, vs_drm_resume);
+
+static const struct of_device_id vs_drm_dt_ids[] = {
+	{ .compatible = "starfive,display-subsystem", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, vs_drm_dt_ids);
+
+static struct platform_driver vs_drm_platform_driver = {
+	.probe = vs_drm_platform_probe,
+	.remove = vs_drm_platform_remove,
+
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = vs_drm_dt_ids,
+		.pm = &vs_drm_pm_ops,
+	},
+};
+
+static int __init vs_drm_init(void)
+{
+	int ret;
+
+	ret = platform_register_drivers(drm_sub_drivers, ARRAY_SIZE(drm_sub_drivers));
+	if (ret)
+		return ret;
+
+	ret = drm_platform_driver_register(&vs_drm_platform_driver);
+	if (ret)
+		platform_unregister_drivers(drm_sub_drivers, ARRAY_SIZE(drm_sub_drivers));
+
+	return ret;
+}
+
+static void __exit vs_drm_fini(void)
+{
+	platform_driver_unregister(&vs_drm_platform_driver);
+	platform_unregister_drivers(drm_sub_drivers, ARRAY_SIZE(drm_sub_drivers));
+}
+
+late_initcall_sync(vs_drm_init);
+module_exit(vs_drm_fini);
+
+MODULE_DESCRIPTION("VeriSilicon DRM Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/verisilicon/vs_drv.h b/drivers/gpu/drm/verisilicon/vs_drv.h
new file mode 100644
index 000000000000..ea2189772980
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_drv.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
+ */
+
+#ifndef __VS_DRV_H__
+#define __VS_DRV_H__
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_managed.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+
+enum rst_vout {
+	RST_VOUT_AXI = 0,
+	RST_VOUT_AHB,
+	RST_VOUT_CORE,
+	RST_VOUT_NUM
+};
+
+/*@pitch_alignment: buffer pitch alignment required by sub-devices.*/
+struct vs_drm_device {
+	struct drm_device base;
+	unsigned int pitch_alignment;
+	/* clocks */
+	unsigned int clk_count;
+	struct clk **clks;
+
+	struct reset_control_bulk_data rst_vout[RST_VOUT_NUM];
+	int	nrsts;
+};
+
+static inline struct vs_drm_device *
+to_vs_drm_private(const struct drm_device *dev)
+{
+	return container_of(dev, struct vs_drm_device, base);
+}
+
+#endif /* __VS_DRV_H__ */
diff --git a/drivers/gpu/drm/verisilicon/vs_modeset.c b/drivers/gpu/drm/verisilicon/vs_modeset.c
new file mode 100644
index 000000000000..eaf406c1b7c7
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_modeset.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
+ */
+
+#include <linux/module.h>
+
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+
+#include "vs_modeset.h"
+
+static const struct drm_mode_config_funcs vs_mode_config_funcs = {
+	.fb_create			 = drm_gem_fb_create,
+	.atomic_check		 = drm_atomic_helper_check,
+	.atomic_commit		 = drm_atomic_helper_commit,
+};
+
+static struct drm_mode_config_helper_funcs vs_mode_config_helpers = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
+void vs_mode_config_init(struct drm_device *dev)
+{
+	int ret;
+
+	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return;
+
+	dev->mode_config.min_width  = 0;
+	dev->mode_config.min_height = 0;
+	dev->mode_config.max_width  = 4096;
+	dev->mode_config.max_height = 4096;
+
+	dev->mode_config.funcs = &vs_mode_config_funcs;
+	dev->mode_config.helper_private = &vs_mode_config_helpers;
+}
diff --git a/drivers/gpu/drm/verisilicon/vs_modeset.h b/drivers/gpu/drm/verisilicon/vs_modeset.h
new file mode 100644
index 000000000000..bd04f81d2ad2
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_modeset.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 VeriSilicon Holdings Co., Ltd.
+ */
+
+#ifndef __VS_MODESET_H__
+#define __VS_MODESET_H__
+
+void vs_mode_config_init(struct drm_device *dev);
+#endif /* __VS_FB_H__ */
-- 
2.34.1

