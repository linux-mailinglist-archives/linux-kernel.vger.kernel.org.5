Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6777EB320
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjKNPKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjKNPJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:09:38 -0500
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [IPv6:2001:41d0:203:375::af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FE31B5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:09:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699974151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=un07RUcu2zgWpUGIkjqz4RZwf2xRaP/AV1IDnwLkbiQ=;
        b=hbWJRAWGsb2GqirQOKQlvdC45YacNeKEi/rBOc4EJTe9WDpiaj6qOwW+Qf4/9hSOJSbGp8
        mdMq5IocqxI5teuylhH5gVTr6qB9+xwhTPScfL7rJEmaa7LOzCK+zIEenJ4Uwdsj6jDvlH
        8TBlWGDj2kfglMhHbLSBt1wAZnhyj5c=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 8/8] drm/bridge: it66121: Allow link this driver as a lib
Date:   Tue, 14 Nov 2023 23:01:30 +0800
Message-Id: <20231114150130.497915-9-sui.jingfeng@linux.dev>
In-Reply-To: <20231114150130.497915-1-sui.jingfeng@linux.dev>
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

The it66121_create_bridge() and it66121_destroy_bridge() are added to
export the core functionalities. Create a connector manually by using
bridge connector helpers when link as a lib.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 134 +++++++++++++++++++--------
 include/drm/bridge/ite-it66121.h     |  17 ++++
 2 files changed, 113 insertions(+), 38 deletions(-)
 create mode 100644 include/drm/bridge/ite-it66121.h

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 8971414a2a60..f5968b679c5d 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -22,6 +22,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_print.h>
@@ -703,14 +704,32 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
 				 enum drm_bridge_attach_flags flags)
 {
 	struct it66121_ctx *ctx = bridge_to_it66121(bridge);
+	struct drm_bridge *next_bridge = ctx->next_bridge;
+	struct drm_encoder *encoder = bridge->encoder;
 	int ret;
 
-	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
-		return -EINVAL;
+	if (next_bridge) {
+		if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
+			WARN_ON(1);
+			flags |= DRM_BRIDGE_ATTACH_NO_CONNECTOR;
+		}
+		ret = drm_bridge_attach(encoder, next_bridge, bridge, flags);
+		if (ret)
+			return ret;
+	} else {
+		struct drm_connector *connector;
 
-	ret = drm_bridge_attach(bridge->encoder, ctx->next_bridge, bridge, flags);
-	if (ret)
-		return ret;
+		if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
+			WARN_ON(1);
+
+		connector = drm_bridge_connector_init(bridge->dev, encoder);
+		if (IS_ERR(connector))
+			return PTR_ERR(connector);
+
+		drm_connector_attach_encoder(connector, encoder);
+
+		ctx->connector = connector;
+	}
 
 	if (ctx->info->id == ID_IT66121) {
 		ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
@@ -1632,16 +1651,13 @@ static const char * const it66121_supplies[] = {
 	"vcn33", "vcn18", "vrf12"
 };
 
-static int it66121_probe(struct i2c_client *client)
+int it66121_create_bridge(struct i2c_client *client, bool of_support,
+			  bool hpd_support, bool audio_support,
+			  struct drm_bridge **bridge)
 {
+	struct device *dev = &client->dev;
 	int ret;
 	struct it66121_ctx *ctx;
-	struct device *dev = &client->dev;
-
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-		dev_err(dev, "I2C check functionality failed.\n");
-		return -ENXIO;
-	}
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -1649,24 +1665,19 @@ static int it66121_probe(struct i2c_client *client)
 
 	ctx->dev = dev;
 	ctx->client = client;
-	ctx->info = i2c_get_match_data(client);
-
-	ret = it66121_of_read_bus_width(dev, &ctx->bus_width);
-	if (ret)
-		return ret;
-
-	ret = it66121_of_get_next_bridge(dev, &ctx->next_bridge);
-	if (ret)
-		return ret;
-
-	i2c_set_clientdata(client, ctx);
 	mutex_init(&ctx->lock);
 
-	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(it66121_supplies),
-					     it66121_supplies);
-	if (ret) {
-		dev_err(dev, "Failed to enable power supplies\n");
-		return ret;
+	if (of_support) {
+		ret = it66121_of_read_bus_width(dev, &ctx->bus_width);
+		if (ret)
+			return ret;
+
+		ret = it66121_of_get_next_bridge(dev, &ctx->next_bridge);
+		if (ret)
+			return ret;
+	} else {
+		ctx->bus_width = 24;
+		ctx->next_bridge = NULL;
 	}
 
 	it66121_hw_reset(ctx);
@@ -1679,33 +1690,80 @@ static int it66121_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	if (ctx->vender_id != ctx->info->vid ||
-	    ctx->device_id != ctx->info->pid)
+	ctx->info = it66121_get_match_data(ctx->vender_id, ctx->device_id);
+	if (!ctx->info)
 		return -ENODEV;
 
-	ret = devm_request_threaded_irq(dev, client->irq, NULL,	it66121_irq_threaded_handler,
-					IRQF_ONESHOT, dev_name(dev), ctx);
-	if (ret < 0) {
-		dev_err(dev, "Failed to request irq %d:%d\n", client->irq, ret);
-		return ret;
+	if (hpd_support) {
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						it66121_irq_threaded_handler,
+						IRQF_ONESHOT, dev_name(dev),
+						ctx);
+		if (ret < 0) {
+			dev_err(dev, "Failed to request irq: %d\n", ret);
+			return ret;
+		}
 	}
 
 	it66121_bridge_init_base(&ctx->bridge, dev->of_node, true);
 
-	it66121_audio_codec_init(ctx, dev);
+	if (audio_support)
+		it66121_audio_codec_init(ctx, dev);
+
+	*bridge = &ctx->bridge;
 
 	dev_info(dev, "IT66121 probed, chip id: 0x%x:0x%x, revision: %u\n",
 		 ctx->vender_id, ctx->device_id, ctx->revision);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(it66121_create_bridge);
+
+static int it66121_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct it66121_ctx *ctx;
+	struct drm_bridge *bridge;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(dev, "I2C check functionality failed.\n");
+		return -ENXIO;
+	}
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(it66121_supplies),
+					     it66121_supplies);
+	if (ret) {
+		dev_err(dev, "Failed to enable power supplies\n");
+		return ret;
+	}
+
+	ret = it66121_create_bridge(client, true, true, true, &bridge);
+	if (ret)
+		return ret;
+
+	ctx = bridge_to_it66121(bridge);
+
+	i2c_set_clientdata(client, ctx);
+
+	return 0;
+}
+
+void it66121_destroy_bridge(struct drm_bridge *bridge)
+{
+	struct it66121_ctx *ctx = bridge_to_it66121(bridge);
+
+	drm_bridge_remove(bridge);
+
+	mutex_destroy(&ctx->lock);
+}
+EXPORT_SYMBOL_GPL(it66121_destroy_bridge);
 
 static void it66121_remove(struct i2c_client *client)
 {
 	struct it66121_ctx *ctx = i2c_get_clientdata(client);
 
-	drm_bridge_remove(&ctx->bridge);
-	mutex_destroy(&ctx->lock);
+	it66121_destroy_bridge(&ctx->bridge);
 }
 
 static const struct of_device_id it66121_dt_match[] = {
diff --git a/include/drm/bridge/ite-it66121.h b/include/drm/bridge/ite-it66121.h
new file mode 100644
index 000000000000..e6753f695b7f
--- /dev/null
+++ b/include/drm/bridge/ite-it66121.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ITE_IT66121_H__
+#define __ITE_IT66121_H__
+
+#include <linux/i2c.h>
+
+#include <drm/drm_bridge.h>
+#include <drm/drm_device.h>
+
+int it66121_create_bridge(struct i2c_client *client, bool of_support,
+			  bool hpd_support, bool audio_support,
+			  struct drm_bridge **bridge);
+
+void it66121_destroy_bridge(struct drm_bridge *bridge);
+
+#endif
-- 
2.34.1

