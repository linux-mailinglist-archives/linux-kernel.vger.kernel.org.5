Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CF7781DCE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 14:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjHTMiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 08:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjHTMis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 08:38:48 -0400
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4534E30DA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 05:36:52 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4RTFSV37CMz9v7dp;
        Sun, 20 Aug 2023 20:35:22 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 20 Aug
 2023 20:36:46 +0800
Date:   Sun, 20 Aug 2023 20:36:45 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <stone.xulei@xfusion.com>
Subject: [Intel-gfx] [PATCH v3] drm/i915: Fix Kconfig error for
 CONFIG_DRM_I915
Message-ID: <ZOII3e9nsnmRjTN+@fedora>
Reply-To: <ZNdOoHvIg7HXh7Gg@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00601.xfusion.com (10.32.135.241) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DRM_I915 is set to 'y' and CONFIG_BACKLIGHT_CLASS_DEVICE
is set to 'm', we encountered an ld.lld error during the build process:

	ld.lld: error: undefined symbol: backlight_device_get_by_name
	>>> referenced by intel_backlight.c:955
	>>>               vmlinux.o:(intel_backlight_device_register)

	ld.lld: error: undefined symbol: backlight_device_register
	>>> referenced by intel_backlight.c:971
	>>>               vmlinux.o:(intel_backlight_device_register)

	ld.lld: error: undefined symbol: backlight_device_unregister
	>>> referenced by intel_backlight.c:999
	>>>               vmlinux.o:(intel_backlight_device_unregister)

This issue occurred because intel_backlight_device_register and
intel_backlight_device_unregister were enclosed within
\#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE) and #endif directives.
However, according to Kconfig, CONFIG_DRM_I915 will select
BACKLIGHT_CLASS_DEVICE only if ACPI is enabled.
This led to an error when ACPI is not enabled.
Change IS_ENABLED to IS_REACHABLE and use IS_REACHABLE to encompass
the implementation of intel_connector_register() to solve this issue.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 drivers/gpu/drm/i915/display/intel_backlight.c | 2 +-
 drivers/gpu/drm/i915/display/intel_backlight.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index 2e8f17c04522..d812cdc74a84 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -795,7 +795,7 @@ void intel_backlight_enable(const struct intel_crtc_state *crtc_state,
 	mutex_unlock(&i915->display.backlight.lock);
 }
 
-#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
+#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
 static u32 intel_panel_get_backlight(struct intel_connector *connector)
 {
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
diff --git a/drivers/gpu/drm/i915/display/intel_backlight.h b/drivers/gpu/drm/i915/display/intel_backlight.h
index 339643f63897..207fe1c613d8 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.h
+++ b/drivers/gpu/drm/i915/display/intel_backlight.h
@@ -36,7 +36,7 @@ u32 intel_backlight_invert_pwm_level(struct intel_connector *connector, u32 leve
 u32 intel_backlight_level_to_pwm(struct intel_connector *connector, u32 level);
 u32 intel_backlight_level_from_pwm(struct intel_connector *connector, u32 val);
 
-#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
+#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
 int intel_backlight_device_register(struct intel_connector *connector);
 void intel_backlight_device_unregister(struct intel_connector *connector);
 #else /* CONFIG_BACKLIGHT_CLASS_DEVICE */
-- 
2.40.0

