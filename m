Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840F975CAD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGUPCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGUPB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:01:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210B19B6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:01:56 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AAAFE373D;
        Fri, 21 Jul 2023 17:00:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689951658;
        bh=4nm4wx+l0xwMFnD7iQ7DJRq8Sf5u93Eqf1FNBIrZtOw=;
        h=From:Date:Subject:To:Cc:From;
        b=XNFuBZUDo6HNewWVHMh44DfIZmRoPecUxykc/LjVzH2qvdKhF1Qnim5Nu21n0Wddb
         W/p2Be5Q6Q7P+9/hZZGLHH3R4Jt60LRBBE0pvx5RiuVjLoqCsqSAWmqT+OcsZBNQl0
         MqqEK6QKWwYXU1UqLv6G5ABNGBeG71Ki9cjsmIS8=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 21 Jul 2023 18:01:39 +0300
Subject: [PATCH v2] drm/bridge: Add debugfs print for bridge chains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-drm-bridge-chain-debugfs-v2-1-76df94347962@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIANKdumQC/42NSw6CMBCGr0JmbU1bRdCV9zAsWmYKs6AlUyUaw
 t2tnMDl9z9XyCRMGW7VCkILZ06xgD1U0I8uDqQYC4PV9qQbaxTKpLwwFqcEOCok/xpCVtr73tT
 WhrpxUOqzUOD3Pv3oCo+cn0k++9Nifuofo4tRRrUXcw6hofaq8c5ILqfokxM89mmCbtu2L0HkN
 PrHAAAA
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4609;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=4nm4wx+l0xwMFnD7iQ7DJRq8Sf5u93Eqf1FNBIrZtOw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkup3gY3JTBj4iBgQmW0jNX5bUcf+8iCQuTi8jj
 mXY9zufs+SJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZLqd4AAKCRD6PaqMvJYe
 9WtEEACyKk2djT/HNrT5YHgOGzzZeFC/3ChyS02RzteuOzqRnqxml2CfMR2lCOIc9mxDyBks1VL
 4gnT9zRK8CZN7GHiEChvBprlv7UcmIYp/un8ImuST87cpmneqS+VrihqI8a6XdN9YYZPkTNRDX3
 803LSWjWH7msGKRFUZzLRtIEhSmj+T0I78wZekbLn+qlyz9cTPBRcvigbsG9Z7pZn4j6QLqXPMd
 jGHI5lDDkogZa92Oewb50RSiRmKdS2/PikiNjrWEYVpZOFYPY/0UAvqP9msk9ogjDhdHLLdR7/P
 aeFMwdggsW2OXXjjU67bksXzUjBzs8RAxdCtWEIgRg9kkHwW59Ud9G7MfFQxJZYylpwGHbMlD1S
 Cm53whKwkrr23VzkR/VFk7hYSwvZ7j8RWvLEPVlyoSlOH+8CGeJhe0ViHRUl2T7y09NQBhQKT19
 e3TpN4kHrRfaqS9sViSNgbsfIB4gtkzl4WcZSa+A4Yy/3o0qKzslttD8zxeQINuyBA14jh7TNY/
 iyEEmR+1DFMu02VlGwc5LF5+Xue6070lCbaGxQlyojQuhWMIjNOc/dSKJSwKM+ukQ4UZZ3E5WAW
 NYScjdcwJQHveoJlJkz4K42w/R/8IgmemTrZkDp+nD8wUMLy9qocBu656zvDls9Yg3ZFrlrAWp3
 qIo5Wuw+x5aVIWw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM bridges are not visible to the userspace and it may not be
immediately clear if the chain is somehow constructed incorrectly. I
have had two separate instances of a bridge driver failing to do a
drm_bridge_attach() call, resulting in the bridge connector not being
part of the chain. In some situations this doesn't seem to cause issues,
but it will if DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is used.

Add a debugfs file to print the bridge chains. For me, on this TI AM62
based platform, I get the following output:

encoder[39]
	bridge[0] type: 0, ops: 0x0
	bridge[1] type: 0, ops: 0x0, OF: /bus@f0000/i2c@20000000/dsi@e:toshiba,tc358778
	bridge[2] type: 0, ops: 0x3, OF: /bus@f0000/i2c@20010000/hdmi@48:lontium,lt8912b
	bridge[3] type: 11, ops: 0x7, OF: /hdmi-connector:hdmi-connector

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v2:
- Fixed compilation issue when !CONFIG_OF
- Link to v1: https://lore.kernel.org/r/20230721-drm-bridge-chain-debugfs-v1-1-8614ff7e890d@ideasonboard.com
---
 drivers/gpu/drm/drm_bridge.c  | 50 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_debugfs.c |  3 +++
 include/drm/drm_bridge.h      |  5 +++++
 3 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index c3d69af02e79..d3eb62d5ef3b 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -27,8 +27,10 @@
 #include <linux/mutex.h>
 
 #include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_debugfs.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_file.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 
@@ -1345,6 +1347,54 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 EXPORT_SYMBOL(of_drm_find_bridge);
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+static int drm_bridge_chains_info(struct seq_file *m, void *data)
+{
+	struct drm_debugfs_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
+	struct drm_printer p = drm_seq_file_printer(m);
+	struct drm_mode_config *config = &dev->mode_config;
+	struct drm_encoder *encoder;
+	unsigned int bridge_idx = 0;
+
+	list_for_each_entry(encoder, &config->encoder_list, head) {
+		struct drm_bridge *bridge;
+
+		drm_printf(&p, "encoder[%u]\n", encoder->base.id);
+
+		bridge = drm_bridge_chain_get_first_bridge(encoder);
+
+		while (bridge) {
+			drm_printf(&p, "\tbridge[%u] type: %u, ops: %#x",
+				   bridge_idx, bridge->type, bridge->ops);
+
+#ifdef CONFIG_OF
+			if (bridge->of_node)
+				drm_printf(&p, ", OF: %pOFfc", bridge->of_node);
+#endif
+
+			drm_printf(&p, "\n");
+
+			bridge_idx++;
+			bridge = drm_bridge_get_next_bridge(bridge);
+		}
+	}
+
+	return 0;
+}
+
+/* any use in debugfs files to dump individual planes/crtc/etc? */
+static const struct drm_debugfs_info drm_bridge_debugfs_list[] = {
+	{"bridge_chains", drm_bridge_chains_info, 0},
+};
+
+void drm_bridge_debugfs_init(struct drm_minor *minor)
+{
+	drm_debugfs_add_files(minor->dev, drm_bridge_debugfs_list,
+			      ARRAY_SIZE(drm_bridge_debugfs_list));
+}
+#endif
+
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
 MODULE_DESCRIPTION("DRM bridge infrastructure");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index c90dbcffa0dc..3e89559d68cd 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -31,6 +31,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_auth.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_client.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_device.h>
@@ -272,6 +273,8 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
 
 	drm_debugfs_add_files(minor->dev, drm_debugfs_list, DRM_DEBUGFS_ENTRIES);
 
+	drm_bridge_debugfs_init(minor);
+
 	if (drm_drv_uses_atomic_modeset(dev)) {
 		drm_atomic_debugfs_init(minor);
 	}
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index bf964cdfb330..60dbee6bd1e6 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -949,4 +949,9 @@ static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
 }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+struct drm_minor;
+void drm_bridge_debugfs_init(struct drm_minor *minor);
+#endif
+
 #endif

---
base-commit: c7a472297169156252a50d76965eb36b081186e2
change-id: 20230721-drm-bridge-chain-debugfs-0bbc1522f57a

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

