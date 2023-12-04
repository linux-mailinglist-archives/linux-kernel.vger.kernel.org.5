Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E71B8032D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjLDMde convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 07:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbjLDMdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:33:21 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2FF138;
        Mon,  4 Dec 2023 04:33:20 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 061067FEF;
        Mon,  4 Dec 2023 20:33:19 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 4 Dec
 2023 20:33:18 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 4 Dec
 2023 20:33:18 +0800
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
Subject: [v3 6/6] drm/vs: simple encoder
Date:   Mon, 4 Dec 2023 20:33:15 +0800
Message-ID: <20231204123315.28456-7-keith.zhao@starfivetech.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add simple encoder for dsi bridge

Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
---
 drivers/gpu/drm/verisilicon/Makefile        |   4 +-
 drivers/gpu/drm/verisilicon/vs_drv.c        |   2 +
 drivers/gpu/drm/verisilicon/vs_simple_enc.c | 195 ++++++++++++++++++++
 drivers/gpu/drm/verisilicon/vs_simple_enc.h |  23 +++
 4 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/verisilicon/vs_simple_enc.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_simple_enc.h

diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
index 71fadafcee13..cd5d0a90bcfe 100644
--- a/drivers/gpu/drm/verisilicon/Makefile
+++ b/drivers/gpu/drm/verisilicon/Makefile
@@ -5,6 +5,8 @@ vs_drm-objs := vs_dc_hw.o \
 		vs_crtc.o \
 		vs_drv.o \
 		vs_modeset.o \
-		vs_plane.o
+		vs_plane.o \
+		vs_simple_enc.o
+
 vs_drm-$(CONFIG_DRM_VERISILICON_STARFIVE_HDMI) += starfive_hdmi.o
 obj-$(CONFIG_DRM_VERISILICON) += vs_drm.o
diff --git a/drivers/gpu/drm/verisilicon/vs_drv.c b/drivers/gpu/drm/verisilicon/vs_drv.c
index d7e5199fe293..946f137ab124 100644
--- a/drivers/gpu/drm/verisilicon/vs_drv.c
+++ b/drivers/gpu/drm/verisilicon/vs_drv.c
@@ -23,6 +23,7 @@
 #include "vs_drv.h"
 #include "vs_modeset.h"
 #include "vs_dc.h"
+#include "vs_simple_enc.h"
 
 #define DRV_NAME	"verisilicon"
 #define DRV_DESC	"Verisilicon DRM driver"
@@ -217,6 +218,7 @@ static struct platform_driver *drm_sub_drivers[] = {
 #ifdef CONFIG_DRM_VERISILICON_STARFIVE_HDMI
 	&starfive_hdmi_driver,
 #endif
+	&simple_encoder_driver,
 };
 
 static struct component_match *vs_drm_match_add(struct device *dev)
diff --git a/drivers/gpu/drm/verisilicon/vs_simple_enc.c b/drivers/gpu/drm/verisilicon/vs_simple_enc.c
new file mode 100644
index 000000000000..c5a8d82bc469
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_simple_enc.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 VeriSilicon Holdings Co., Ltd.
+ */
+#include <linux/component.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_of.h>
+#include <linux/regmap.h>
+#include <linux/media-bus-format.h>
+#include <linux/mfd/syscon.h>
+
+#include "vs_crtc.h"
+#include "vs_simple_enc.h"
+
+static const struct simple_encoder_priv dsi_priv = {
+	.encoder_type = DRM_MODE_ENCODER_DSI
+};
+
+static inline struct simple_encoder *to_simple_encoder(struct drm_encoder *enc)
+{
+	return container_of(enc, struct simple_encoder, encoder);
+}
+
+static int encoder_parse_dt(struct device *dev)
+{
+	struct simple_encoder *simple = dev_get_drvdata(dev);
+	unsigned int args[2];
+
+	simple->dss_regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+								  "starfive,syscon",
+								  2, args);
+
+	if (IS_ERR(simple->dss_regmap)) {
+		return dev_err_probe(dev, PTR_ERR(simple->dss_regmap),
+				     "getting the regmap failed\n");
+	}
+
+	simple->offset = args[0];
+	simple->mask = args[1];
+
+	return 0;
+}
+
+void encoder_atomic_enable(struct drm_encoder *encoder,
+			   struct drm_atomic_state *state)
+{
+	struct simple_encoder *simple = to_simple_encoder(encoder);
+
+	regmap_update_bits(simple->dss_regmap, simple->offset, simple->mask,
+			   simple->mask);
+}
+
+int encoder_atomic_check(struct drm_encoder *encoder,
+			 struct drm_crtc_state *crtc_state,
+			 struct drm_connector_state *conn_state)
+{
+	struct vs_crtc_state *vs_crtc_state = to_vs_crtc_state(crtc_state);
+	struct drm_connector *connector = conn_state->connector;
+	int ret = 0;
+
+	struct drm_bridge *first_bridge = drm_bridge_chain_get_first_bridge(encoder);
+	struct drm_bridge_state *bridge_state = ERR_PTR(-EINVAL);
+
+	vs_crtc_state->encoder_type = encoder->encoder_type;
+
+	if (first_bridge && first_bridge->funcs->atomic_duplicate_state)
+		bridge_state = drm_atomic_get_bridge_state(crtc_state->state, first_bridge);
+
+	if (IS_ERR(bridge_state)) {
+		if (connector->display_info.num_bus_formats)
+			vs_crtc_state->output_fmt = connector->display_info.bus_formats[0];
+		else
+			vs_crtc_state->output_fmt = MEDIA_BUS_FMT_FIXED;
+	} else {
+		vs_crtc_state->output_fmt = bridge_state->input_bus_cfg.format;
+	}
+
+	switch (vs_crtc_state->output_fmt) {
+	case MEDIA_BUS_FMT_FIXED:
+	case MEDIA_BUS_FMT_RGB565_1X16:
+	case MEDIA_BUS_FMT_RGB666_1X18:
+	case MEDIA_BUS_FMT_RGB888_1X24:
+	case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
+	case MEDIA_BUS_FMT_RGB101010_1X30:
+	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+	case MEDIA_BUS_FMT_YUV8_1X24:
+	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
+	case MEDIA_BUS_FMT_UYVY10_1X20:
+	case MEDIA_BUS_FMT_YUV10_1X30:
+		ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	/* If MEDIA_BUS_FMT_FIXED, set it to default value */
+	if (vs_crtc_state->output_fmt == MEDIA_BUS_FMT_FIXED)
+		vs_crtc_state->output_fmt = MEDIA_BUS_FMT_RGB888_1X24;
+
+	return ret;
+}
+
+static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
+	.atomic_check = encoder_atomic_check,
+	.atomic_enable = encoder_atomic_enable,
+};
+
+static int encoder_bind(struct device *dev, struct device *master, void *data)
+{
+	struct drm_device *drm_dev = data;
+	struct simple_encoder *simple = dev_get_drvdata(dev);
+	struct drm_encoder *encoder;
+	struct drm_bridge *bridge;
+	int ret;
+
+	encoder = &simple->encoder;
+
+	ret = drmm_encoder_init(drm_dev, encoder, NULL, simple->priv->encoder_type, NULL);
+	if (ret)
+		return ret;
+
+	drm_encoder_helper_add(encoder, &encoder_helper_funcs);
+
+	encoder->possible_crtcs =
+			drm_of_find_possible_crtcs(drm_dev, dev->of_node);
+
+	/* output port is port1*/
+	bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
+	if (IS_ERR(bridge))
+		return 0;
+
+	return drm_bridge_attach(encoder, bridge, NULL, 0);
+}
+
+static const struct component_ops encoder_component_ops = {
+	.bind = encoder_bind,
+};
+
+static const struct of_device_id simple_encoder_dt_match[] = {
+	{ .compatible = "starfive,dsi-encoder", .data = &dsi_priv},
+	{},
+};
+MODULE_DEVICE_TABLE(of, simple_encoder_dt_match);
+
+static int encoder_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct simple_encoder *simple;
+	int ret;
+
+	simple = devm_kzalloc(dev, sizeof(*simple), GFP_KERNEL);
+	if (!simple)
+		return -ENOMEM;
+
+	simple->priv = of_device_get_match_data(dev);
+
+	simple->dev = dev;
+
+	dev_set_drvdata(dev, simple);
+
+	ret = encoder_parse_dt(dev);
+	if (ret)
+		return ret;
+
+	return component_add(dev, &encoder_component_ops);
+}
+
+static int encoder_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	component_del(dev, &encoder_component_ops);
+	dev_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+struct platform_driver simple_encoder_driver = {
+	.probe = encoder_probe,
+	.remove = encoder_remove,
+	.driver = {
+		.name = "vs-simple-encoder",
+		.of_match_table = of_match_ptr(simple_encoder_dt_match),
+	},
+};
+
+MODULE_DESCRIPTION("Simple Encoder Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/verisilicon/vs_simple_enc.h b/drivers/gpu/drm/verisilicon/vs_simple_enc.h
new file mode 100644
index 000000000000..fb33ca9e18d6
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_simple_enc.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 VeriSilicon Holdings Co., Ltd.
+ */
+
+#ifndef __VS_SIMPLE_ENC_H_
+#define __VS_SIMPLE_ENC_H_
+
+struct simple_encoder_priv {
+	unsigned char encoder_type;
+};
+
+struct simple_encoder {
+	struct drm_encoder encoder;
+	struct device *dev;
+	const struct simple_encoder_priv *priv;
+	struct regmap *dss_regmap;
+	unsigned int offset;
+	unsigned int mask;
+};
+
+extern struct platform_driver simple_encoder_driver;
+#endif /* __VS_SIMPLE_ENC_H_ */
-- 
2.34.1

