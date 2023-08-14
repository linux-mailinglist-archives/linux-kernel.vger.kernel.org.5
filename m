Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAAD77BABD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjHNN4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjHNN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:56:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05568E7D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888BA61A55
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BE4C433CA;
        Mon, 14 Aug 2023 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692021388;
        bh=IFS4dquHs0GVQ0YNk9O4KF71KLDK2GvWdi33+XtiI0Y=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=oUwTESRpQHmK/itub/LZ+yB+K/0T9hdRxVopaO1pGG12CA51ovVKS+ys8I9gEEX6u
         wPbZSYDhyAfFNYSX3OA6rOzExjD1gyi8Xzi273+JtKKZQPxCCn3yNpTPSfIhiN6vJK
         15+MJslTwQU0UcBRsQc6zma3lWDGYvi0TaCBk5G9sQDllJqXiwIvAWKNJEM4V+Hjwf
         iIefVgX4WVaLyJaFIBb0XoqhihHwyWdgN5fsf9svxVATi3NMRPkOBEQXJAMt0Zr27N
         946oBF87lL3++VgVdJEEdyd17KwBC0/IF3RlbHWDwe2UORPNbBbUZN+0UYDujzCa+f
         /CMFqgzbl+FKA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Mon, 14 Aug 2023 15:56:13 +0200
Subject: [PATCH RFC 01/13] drm/connector: Introduce an HDMI connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-kms-hdmi-connector-state-v1-1-048054df3654@kernel.org>
References: <20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org>
In-Reply-To: <20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3846; i=mripard@kernel.org;
 h=from:subject:message-id; bh=IFS4dquHs0GVQ0YNk9O4KF71KLDK2GvWdi33+XtiI0Y=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCm3jNqOT/5y68KHkJUz06rK3v+QmXf8rArb+dm3Tua+f
 PTC5Qn3qo5SFgYxLgZZMUWWGGHzJXGnZr3uZOObBzOHlQlkCAMXpwBM5Ho6I8OSDXrpB15depz6
 YNbsK1V8DyvevJj80Crza3r4/Es/XronMPwvEnLtu6p1q5DrxMKma9OuO9Wcj93zfs604+tulYV
 xOxhxAQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of the various HDMI drivers duplicate some logic that depends on
the HDMI spec itself and not really a particular hardware
implementation.

Output BPC or format selection, infoframe generation are good examples
of such areas.

This creates a lot of boilerplate, with a lot of variations, which makes
it hard for userspace to rely on, and makes it difficult to get it right
for drivers.

Let's create a new connector variant specifically dedicated to HDMI
controllers that will allow to abstract away the duplicated logic.

Hopefully, this will make drivers simpler to handle, and their behaviour
more consistent.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/Makefile             |  1 +
 drivers/gpu/drm/drm_hdmi_connector.c | 45 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h          | 16 +++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 7a09a89b493b..1520d4ccd3d7 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -27,6 +27,7 @@ drm-y := \
 	drm_fourcc.o \
 	drm_framebuffer.o \
 	drm_gem.o \
+	drm_hdmi_connector.o \
 	drm_ioctl.o \
 	drm_lease.o \
 	drm_managed.o \
diff --git a/drivers/gpu/drm/drm_hdmi_connector.c b/drivers/gpu/drm/drm_hdmi_connector.c
new file mode 100644
index 000000000000..62f01dd2e6df
--- /dev/null
+++ b/drivers/gpu/drm/drm_hdmi_connector.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <drm/drm_connector.h>
+#include <drm/drm_mode.h>
+
+#include <linux/export.h>
+
+/**
+ * drmm_hdmi_connector_init - Init a preallocated HDMI connector
+ * @dev: DRM device
+ * @hdmi_connector: A pointer to the HDMI connector to init
+ * @connector_type: user visible type of the connector
+ * @ddc: optional pointer to the associated ddc adapter
+ *
+ * Initialises a preallocated HDMI connector. Connectors can be
+ * subclassed as part of driver connector objects.
+ *
+ * Cleanup is automatically handled with a call to
+ * drm_connector_cleanup() in a DRM-managed action.
+ *
+ * The connector structure should be allocated with drmm_kzalloc().
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drmm_hdmi_connector_init(struct drm_device *dev,
+			     struct drm_hdmi_connector *hdmi_connector,
+			     const struct drm_connector_funcs *funcs,
+			     int connector_type,
+			     struct i2c_adapter *ddc)
+{
+	struct drm_connector *connector = &hdmi_connector->base;
+	int ret;
+
+	if (connector_type != DRM_MODE_CONNECTOR_HDMIA ||
+	    connector_type != DRM_MODE_CONNECTOR_HDMIB)
+		return -EINVAL;
+
+	ret = drmm_connector_init(dev, connector, funcs, connector_type, ddc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(drmm_hdmi_connector_init);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index d300fde6c1a4..1859b74083f5 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2042,6 +2042,22 @@ void drm_connector_attach_privacy_screen_provider(
 	struct drm_connector *connector, struct drm_privacy_screen *priv);
 void drm_connector_update_privacy_screen(const struct drm_connector_state *connector_state);
 
+struct drm_hdmi_connector {
+	/**
+	 * @base: Base Connector
+	 */
+	struct drm_connector base;
+};
+
+#define connector_to_hdmi_connector(connector) \
+	container_of_const(connector, struct drm_hdmi_connector, base)
+
+int drmm_hdmi_connector_init(struct drm_device *dev,
+			     struct drm_hdmi_connector *hdmi_connector,
+			     const struct drm_connector_funcs *funcs,
+			     int connector_type,
+			     struct i2c_adapter *ddc);
+
 /**
  * struct drm_tile_group - Tile group metadata
  * @refcount: reference count

-- 
2.41.0

