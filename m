Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33308802353
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjLCLnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjLCLnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:43:33 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F3CFE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:43:37 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9fbb846b7so2806551fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701603815; x=1702208615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLMeGR8g0M1G6Cc/8n9JC9W0cxmAoHOfp3zgP4y1Lrk=;
        b=QEFu1r8SPNbeEXeuYGxWL7BulvxVJKSjFh0y0OOiu8WZbYCIyunEnlO70RJNdCg3cO
         2b71AhgumWMy0efhlaNIjhhfm7a3nYifnANvgKZzzIeOmsAeujmuelGZgUW59GACb+t8
         jpdQcUGue4hyfgrIyceXvPmQSsKY4Vw0YQ9fhlXykIETu+8fpoeuFqCMnkSeroa9wQYK
         9QNLdJdZMTuXSlIOAH3O/IQic0TSYBytiCI/6SaKphANgN7mZfVNIQ8iyTsOuuwFTrrY
         k0Q0QSsG+5FqjKcH160Qy3JeIcBNEFym2HpOuc6Uf4Vrn0uszvVlqzA/q5zDRpHjCDDK
         V/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701603815; x=1702208615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLMeGR8g0M1G6Cc/8n9JC9W0cxmAoHOfp3zgP4y1Lrk=;
        b=iwAbt0l+4MQxVKYdu2Nmwx7eQWBoCyKPa5Xr8DQ9hXLH2WA8xWpRNPxPXu3jfKYDZo
         mFC3sroXNlI0y8jSPkY7m/mTnmed9UMg4vvqFrQZg4DhU2hENEEf8Ky9vmGl0+BOVzoL
         lWuoSWkEfcQD1U6nbsY80oXjzh8VaBgKRTzTctJqJdxaFW7eUotKsKW8JctR+UW1iMJC
         lvYzNtK3A1553FrTLoWTlfrY4aRcQ05LsF3R8d7GJNONtZhdOfKEP+tI8OTu/YESwRA1
         W+84VO6BNXdzHe3DFQjVoydeX2ljkti5ZYsPbDVL+n9nLgVc4Mz4XPsLuuoJghyV6Kwd
         KxRA==
X-Gm-Message-State: AOJu0YzX1Z2mPdr0N9U4vvVS3FgMKG2YTyG0/WtuRVJdb8Nzidn0Libj
        CvMkBE+cwAOz7sFny7zfiQGOHQ==
X-Google-Smtp-Source: AGHT+IG/YwWznfB07jLqx6YXqnCXGzRNSUNjT1p5TDbnkaR8/pSEt/QRIRyE/eNsrkyYVr4SFow4fQ==
X-Received: by 2002:a2e:7c05:0:b0:2c9:ebd6:ed11 with SMTP id x5-20020a2e7c05000000b002c9ebd6ed11mr1006232ljc.45.1701603815199;
        Sun, 03 Dec 2023 03:43:35 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id o17-20020a2e90d1000000b002c993c5d4c6sm894666ljg.105.2023.12.03.03.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:43:34 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH RESEND 1/6] drm/bridge: add transparent bridge helper
Date:   Sun,  3 Dec 2023 14:43:28 +0300
Message-Id: <20231203114333.1305826-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231203114333.1305826-1-dmitry.baryshkov@linaro.org>
References: <20231203114333.1305826-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a helper for creating simple transparent bridges which serve the
only purpose of linking devices into the bridge chain up to the last
bridge representing the connector. This is especially useful for
DP/USB-C bridge chains, which can span across several devices, but do
not require any additional functionality from the intermediate bridges.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/Kconfig      |   9 ++
 drivers/gpu/drm/bridge/Makefile     |   1 +
 drivers/gpu/drm/bridge/aux-bridge.c | 140 ++++++++++++++++++++++++++++
 include/drm/bridge/aux-bridge.h     |  19 ++++
 4 files changed, 169 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/aux-bridge.c
 create mode 100644 include/drm/bridge/aux-bridge.h

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index ba82a1142adf..f12eab62799f 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -12,6 +12,15 @@ config DRM_PANEL_BRIDGE
 	help
 	  DRM bridge wrapper of DRM panels
 
+config DRM_AUX_BRIDGE
+	tristate
+	depends on DRM_BRIDGE && OF
+	select AUXILIARY_BUS
+	select DRM_PANEL_BRIDGE
+	help
+	  Simple transparent bridge that is used by several non-DRM drivers to
+	  build bridges chain.
+
 menu "Display Interface Bridges"
 	depends on DRM && DRM_BRIDGE
 
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 2b892b7ed59e..918e3bfff079 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_DRM_AUX_BRIDGE) += aux-bridge.o
 obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
 obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
 obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge/aux-bridge.c
new file mode 100644
index 000000000000..6245976b8fef
--- /dev/null
+++ b/drivers/gpu/drm/bridge/aux-bridge.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/module.h>
+
+#include <drm/drm_bridge.h>
+#include <drm/bridge/aux-bridge.h>
+
+static DEFINE_IDA(drm_aux_bridge_ida);
+
+static void drm_aux_bridge_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	ida_free(&drm_aux_bridge_ida, adev->id);
+
+	kfree(adev);
+}
+
+static void drm_aux_bridge_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+/**
+ * drm_aux_bridge_register - Create a simple bridge device to link the chain
+ * @parent: device instance providing this bridge
+ *
+ * Creates a simple DRM bridge that doesn't implement any drm_bridge
+ * operations. Such bridges merely fill a place in the bridge chain linking
+ * surrounding DRM bridges.
+ *
+ * Return: zero on success, negative error code on failure
+ */
+int drm_aux_bridge_register(struct device *parent)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	ret = ida_alloc(&drm_aux_bridge_ida, GFP_KERNEL);
+	if (ret < 0) {
+		kfree(adev);
+		return ret;
+	}
+
+	adev->id = ret;
+	adev->name = "aux_bridge";
+	adev->dev.parent = parent;
+	adev->dev.of_node = parent->of_node;
+	adev->dev.release = drm_aux_bridge_release;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		ida_free(&drm_aux_bridge_ida, adev->id);
+		kfree(adev);
+		return ret;
+	}
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(parent, drm_aux_bridge_unregister_adev, adev);
+}
+EXPORT_SYMBOL_GPL(drm_aux_bridge_register);
+
+struct drm_aux_bridge_data {
+	struct drm_bridge bridge;
+	struct drm_bridge *next_bridge;
+	struct device *dev;
+};
+
+static int drm_aux_bridge_attach(struct drm_bridge *bridge,
+				    enum drm_bridge_attach_flags flags)
+{
+	struct drm_aux_bridge_data *data;
+
+	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
+		return -EINVAL;
+
+	data = container_of(bridge, struct drm_aux_bridge_data, bridge);
+
+	return drm_bridge_attach(bridge->encoder, data->next_bridge, bridge,
+				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+}
+
+static const struct drm_bridge_funcs drm_aux_bridge_funcs = {
+	.attach	= drm_aux_bridge_attach,
+};
+
+static int drm_aux_bridge_probe(struct auxiliary_device *auxdev,
+				   const struct auxiliary_device_id *id)
+{
+	struct drm_aux_bridge_data *data;
+
+	data = devm_kzalloc(&auxdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = &auxdev->dev;
+	data->next_bridge = devm_drm_of_get_bridge(&auxdev->dev, auxdev->dev.of_node, 0, 0);
+	if (IS_ERR(data->next_bridge))
+		return dev_err_probe(&auxdev->dev, PTR_ERR(data->next_bridge),
+				     "failed to acquire drm_bridge\n");
+
+	data->bridge.funcs = &drm_aux_bridge_funcs;
+	data->bridge.of_node = data->dev->of_node;
+
+	return devm_drm_bridge_add(data->dev, &data->bridge);
+}
+
+static const struct auxiliary_device_id drm_aux_bridge_table[] = {
+	{ .name = KBUILD_MODNAME ".aux_bridge" },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, drm_aux_bridge_table);
+
+static struct auxiliary_driver drm_aux_bridge_drv = {
+	.name = "aux_bridge",
+	.id_table = drm_aux_bridge_table,
+	.probe = drm_aux_bridge_probe,
+};
+module_auxiliary_driver(drm_aux_bridge_drv);
+
+MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
+MODULE_DESCRIPTION("DRM transparent bridge");
+MODULE_LICENSE("GPL");
diff --git a/include/drm/bridge/aux-bridge.h b/include/drm/bridge/aux-bridge.h
new file mode 100644
index 000000000000..441ab3f0e920
--- /dev/null
+++ b/include/drm/bridge/aux-bridge.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+ */
+#ifndef DRM_AUX_BRIDGE_H
+#define DRM_AUX_BRIDGE_H
+
+#if IS_ENABLED(CONFIG_DRM_AUX_BRIDGE)
+int drm_aux_bridge_register(struct device *parent);
+#else
+static inline int drm_aux_bridge_register(struct device *parent)
+{
+	return 0;
+}
+#endif
+
+#endif
-- 
2.39.2

