Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DAF779EA9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbjHLJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHLJjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:39:41 -0400
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3117226A0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 02:39:41 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4RNFvq0Jvrz9xrdT;
        Sat, 12 Aug 2023 17:38:15 +0800 (CST)
Received: from fedora (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 12 Aug
 2023 17:39:28 +0800
Date:   Sat, 12 Aug 2023 17:39:27 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/i915: Fix Kconfig error for CONFIG_DRM_I915
Message-ID: <ZNdOoHvIg7HXh7Gg@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00603.xfusion.com (10.32.134.231) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
This led to an error, which can be resolved by removing the
conditional statements related to ACPI.

v2: Add a line starting with #

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 drivers/gpu/drm/i915/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 01b5a8272a27..5003de921bf7 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -24,7 +24,7 @@ config DRM_I915
 	select IRQ_WORK
 	# i915 depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select BACKLIGHT_CLASS_DEVICE
 	select INPUT if ACPI
 	select X86_PLATFORM_DEVICES if ACPI
 	select ACPI_WMI if ACPI
-- 
2.40.0

