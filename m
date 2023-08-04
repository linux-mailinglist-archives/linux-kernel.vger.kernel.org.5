Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF50D770A81
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjHDVIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjHDVIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:08:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFF6E46
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:07:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686be3cbea0so2475633b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691183241; x=1691788041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgZd04X0Jnac/fFUkos5qfSoj7pVaTLYh5udS8UWgcQ=;
        b=dWh3dGKdYpdYdRJj8hocS/Jx852k0NaOXKh3si1et2/K0fsZUcbFeMkfTyTNYq5AhB
         cJNWWInbDx8vJsvS+phmgohWTE73bsjN/5Z80kAS0A//0yp2Xzm9tudwtnQygKNbWH95
         K/Xrfpa2vyLkXmYwfbCkA4JEa0g85HOvBrD4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183241; x=1691788041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgZd04X0Jnac/fFUkos5qfSoj7pVaTLYh5udS8UWgcQ=;
        b=OmAmtqvNvR/XqDBsJY1n9rwemQ0Y00W9q2304Il+9wvyC+7dDRJk/fOtO6vrG8AnM+
         DMYYyjY+tR04GDTVO58QAFiaJHTf4KXfkr8OeJ6F/9V7/sIo99WUZ/yQ9LYfZupdfBqR
         K9/g99zOHHpWFo158/M1AxUyQdJJD4999L/aVfENTvsTXBl1k8/361zU4qseakR4nZ9N
         V1YjaLWjtQclxlObTMRuHL/nM0aD4VK2EidnHLjb5Tz0Y1HfU8mTklrxKFTYft1dvXmJ
         siwKanZ0unGHQPeMRtE6fdK4YDsjSx9AcwGw+PZwF94kNai3Qq7gEaDUr2fMEOBGvPw3
         Xv3g==
X-Gm-Message-State: AOJu0Yy00rydpNfkHhlJEEaszQUYFbG9w7u0e/0spXj+n2jQOPVM+bKd
        0tP3yHCl5lROQPuLboQ1M8OxrA==
X-Google-Smtp-Source: AGHT+IEbxPqp6oqwMPfwc7PpRL6ZB+4GzifFwsSYO2+bjpdObcW4hQ6c42ATbNHl6lOFiZwol+g7yw==
X-Received: by 2002:a05:6a20:548e:b0:127:72c3:6428 with SMTP id i14-20020a056a20548e00b0012772c36428mr1108268pzk.18.1691183240969;
        Fri, 04 Aug 2023 14:07:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e186:e5d2:e60:bad3])
        by smtp.gmail.com with ESMTPSA id n22-20020aa78a56000000b0068664ace38asm2037584pfa.19.2023.08.04.14.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:07:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/10] drm/panel_helper: Introduce drm_panel_helper
Date:   Fri,  4 Aug 2023 14:06:07 -0700
Message-ID: <20230804140605.RFC.4.I930069a32baab6faf46d6b234f89613b5cec0f14@changeid>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230804210644.1862287-1-dianders@chromium.org>
References: <20230804210644.1862287-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this file is to contain helper functions for panel drivers
to use. To start off with, let's add drm_panel_helper_shutdown() for
use by panels that want to make sure they're powered off at
shutdown/remove time if they happen to be powered on.

The main goal of introducting this function is so that panel drivers
don't need to track the enabled/prepared state themselves.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
If I've misunderstood and the drm_panel_helper_shutdown() should
belong in some other file and we don't need to introduce a "helper"
for this then please le me know.

 drivers/gpu/drm/Makefile           |  1 +
 drivers/gpu/drm/drm_panel_helper.c | 37 ++++++++++++++++++++++++++++++
 include/drm/drm_panel_helper.h     | 13 +++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_panel_helper.c
 create mode 100644 include/drm/drm_panel_helper.h

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 215e78e79125..e811f3d68235 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -118,6 +118,7 @@ drm_kms_helper-y := \
 	drm_gem_framebuffer_helper.o \
 	drm_kms_helper_common.o \
 	drm_modeset_helper.o \
+	drm_panel_helper.o \
 	drm_plane_helper.o \
 	drm_probe_helper.o \
 	drm_rect.o \
diff --git a/drivers/gpu/drm/drm_panel_helper.c b/drivers/gpu/drm/drm_panel_helper.c
new file mode 100644
index 000000000000..85a55b5731cf
--- /dev/null
+++ b/drivers/gpu/drm/drm_panel_helper.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Google Inc.
+ */
+
+#include <linux/dev_printk.h>
+
+#include <drm/drm_panel.h>
+#include <drm/drm_panel_helper.h>
+
+/**
+ * drm_panel_helper_shutdown - helper for panels to use at shutdown time
+ * @panel: DRM panel
+ *
+ * Panels may call this function unconditionally at shutdown time to ensure
+ * that they are disabled and unprepared if necessary.
+ *
+ * As part of this function:
+ * - The backlight will be turned off, if it was on.
+ * - Any panel followers will be power sequenced.
+ */
+void drm_panel_helper_shutdown(struct drm_panel *panel)
+{
+	int ret;
+
+	if (panel->enabled) {
+		ret = drm_panel_disable(panel);
+		if (ret)
+			dev_warn(panel->dev, "Error disabling panel %d\n", ret);
+	}
+	if (panel->prepared) {
+		ret = drm_panel_unprepare(panel);
+		if (ret)
+			dev_warn(panel->dev, "Error unpreparing panel %d\n", ret);
+	}
+}
+EXPORT_SYMBOL_GPL(drm_panel_helper_shutdown);
diff --git a/include/drm/drm_panel_helper.h b/include/drm/drm_panel_helper.h
new file mode 100644
index 000000000000..5621482053a9
--- /dev/null
+++ b/include/drm/drm_panel_helper.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2023 Google Inc.
+ */
+
+#ifndef DRM_PANEL_HELPER_H
+#define DRM_PANEL_HELPER_H
+
+struct drm_panel;
+
+void drm_panel_helper_shutdown(struct drm_panel *panel);
+
+#endif /* DRM_PANEL_HELPER_H */
-- 
2.41.0.585.gd2178a4bd4-goog

