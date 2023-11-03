Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E55E7E0A11
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378169AbjKCUSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKCUSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:18:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A518B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699042718; x=1730578718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aU19ThGhUQIWXfbukrzCcpY3j2hr2UFUIRy/UhZ9hVU=;
  b=NgS+kBV27uWlNCtIWfZo/CVflYKE5UNQikqeEyzn4X17a8MH678Gonf/
   wFse4tX/XCYVlvUTdb+c9GCqjzehPoIwGUTj4tzDGBNRAXZ4roorOu0Ne
   dTk5T0eFriztrl1X6pRKZHYVqmaecQ3UEdrUGGLfhOIwRu1iuvfKce7mc
   cX9gkseoYX0iAE1F9aoZclE0YisYpaKWbtQX4YIsgrY/bv4pxJy28CuXf
   /reOkdVoj7IT0RdtbG+TM3xrnWZP794t3JA8oZ0u1NXv1uzoJYCBAQX7D
   NqyX7IKLxNvBu/7w5UwaJIYJAr17sN9MlSVWYcTofmGGhViMYYHdFSdPC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1896041"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1896041"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="832131115"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="832131115"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Nov 2023 13:18:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A84A25E8; Fri,  3 Nov 2023 22:18:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 02/16] drm/i915/dsi: switch mipi_exec_gpio() from dev_priv to i915
Date:   Fri,  3 Nov 2023 22:18:17 +0200
Message-Id: <20231103201831.1037416-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
References: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jani Nikula <jani.nikula@intel.com>

Follow the contemporary conventions.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index b2c0cc11f8c1..8b962f2ac475 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -454,11 +454,11 @@ static void icl_native_gpio_set_value(struct drm_i915_private *dev_priv,
 static const u8 *mipi_exec_gpio(struct intel_dsi *intel_dsi, const u8 *data)
 {
 	struct drm_device *dev = intel_dsi->base.base.dev;
-	struct drm_i915_private *dev_priv = to_i915(dev);
+	struct drm_i915_private *i915 = to_i915(dev);
 	struct intel_connector *connector = intel_dsi->attached_connector;
 	u8 gpio_source, gpio_index = 0, gpio_number;
 	bool value;
-	bool native = DISPLAY_VER(dev_priv) >= 11;
+	bool native = DISPLAY_VER(i915) >= 11;
 
 	if (connector->panel.vbt.dsi.seq_version >= 3)
 		gpio_index = *data++;
@@ -477,16 +477,16 @@ static const u8 *mipi_exec_gpio(struct intel_dsi *intel_dsi, const u8 *data)
 	/* pull up/down */
 	value = *data++ & 1;
 
-	drm_dbg_kms(&dev_priv->drm, "GPIO index %u, number %u, source %u, native %s, set to %s\n",
+	drm_dbg_kms(&i915->drm, "GPIO index %u, number %u, source %u, native %s, set to %s\n",
 		    gpio_index, gpio_number, gpio_source, str_yes_no(native), str_on_off(value));
 
 	if (native)
-		icl_native_gpio_set_value(dev_priv, gpio_number, value);
-	else if (DISPLAY_VER(dev_priv) >= 11)
+		icl_native_gpio_set_value(i915, gpio_number, value);
+	else if (DISPLAY_VER(i915) >= 11)
 		bxt_exec_gpio(connector, gpio_source, gpio_index, value);
-	else if (IS_VALLEYVIEW(dev_priv))
+	else if (IS_VALLEYVIEW(i915))
 		vlv_exec_gpio(connector, gpio_source, gpio_number, value);
-	else if (IS_CHERRYVIEW(dev_priv))
+	else if (IS_CHERRYVIEW(i915))
 		chv_exec_gpio(connector, gpio_source, gpio_number, value);
 	else
 		bxt_exec_gpio(connector, gpio_source, gpio_index, value);
-- 
2.40.0.1.gaa8946217a0b

