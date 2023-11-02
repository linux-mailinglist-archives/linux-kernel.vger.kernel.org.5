Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E327DF615
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347720AbjKBPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347540AbjKBPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:13:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2563918B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698937974; x=1730473974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d5TnJD8mZT4XCWRMm2D4HqLq+7mmDEPFtEmjmsmEvVE=;
  b=mFLgUlR76hkhjwo4koa+PL3BEYgn3Yuw0U48qFrE+/jGbvO4h2JmWFri
   UAtTTfx7oa7ygFmfFVU5Y9bqAT9t0WrZvjr1LBj1esZCgvIbskYBEqizj
   ktbhtJB5SV+2ndjodZbncQIUdo2iAjttgz0x3jZL7abD3jXfxCDSjIiEv
   4y4OPkD6E23XXO9MBw3cdnz+XV1zUhp4utVnW6FljyIP+6suhJChViZI0
   WeTTZohX+2uQIAmukIWA9mF4hf18EBTwIgvlTzAMe498Mwrmibmx7STMo
   APdDFf24tzbrGqwmON70DfWKijTRRo9EdlBPg82biCuYNaOUHOIKVG37K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373773478"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="373773478"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="711174074"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="711174074"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2023 08:12:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 03C84690; Thu,  2 Nov 2023 17:12:30 +0200 (EET)
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
Subject: [PATCH v3 09/15] drm/i915/dsi: Remove GPIO lookup table at the end of intel_dsi_vbt_gpio_init()
Date:   Thu,  2 Nov 2023 17:12:22 +0200
Message-Id: <20231102151228.668842-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231102151228.668842-1-andriy.shevchenko@linux.intel.com>
References: <20231102151228.668842-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

To properly deal with GPIOs used in MIPI panel sequences a temporary
GPIO lookup will be used. Since there can only be 1 GPIO lookup table
for the "0000:00:02.0" device this will not work if the GPIO lookup
table used by intel_dsi_vbt_gpio_init() is still registered.

After getting the "backlight" and "panel" GPIOs the lookup table
registered by intel_dsi_vbt_gpio_init() is no longer necessary,
remove it so that another temporary lookup-table for the "0000:00:02.0"
device can be added.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 25 +++++++-------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index d270437217b3..8e6beef90e5e 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -955,6 +955,7 @@ void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on)
 	struct intel_connector *connector = intel_dsi->attached_connector;
 	struct mipi_config *mipi_config = connector->panel.vbt.dsi.config;
 	enum gpiod_flags flags = panel_is_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	struct gpiod_lookup_table *gpiod_lookup_table = NULL;
 	bool want_backlight_gpio = false;
 	bool want_panel_gpio = false;
 	struct pinctrl *pinctrl;
@@ -962,12 +963,12 @@ void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on)
 
 	if ((IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) &&
 	    mipi_config->pwm_blc == PPS_BLC_PMIC) {
-		gpiod_add_lookup_table(&pmic_panel_gpio_table);
+		gpiod_lookup_table = &pmic_panel_gpio_table;
 		want_panel_gpio = true;
 	}
 
 	if (IS_VALLEYVIEW(dev_priv) && mipi_config->pwm_blc == PPS_BLC_SOC) {
-		gpiod_add_lookup_table(&soc_panel_gpio_table);
+		gpiod_lookup_table = &soc_panel_gpio_table;
 		want_panel_gpio = true;
 		want_backlight_gpio = true;
 
@@ -984,6 +985,9 @@ void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on)
 				"Failed to set pinmux to PWM\n");
 	}
 
+	if (gpiod_lookup_table)
+		gpiod_add_lookup_table(gpiod_lookup_table);
+
 	if (want_panel_gpio) {
 		intel_dsi->gpio_panel = gpiod_get(dev->dev, "panel", flags);
 		if (IS_ERR(intel_dsi->gpio_panel)) {
@@ -1002,15 +1006,13 @@ void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on)
 			intel_dsi->gpio_backlight = NULL;
 		}
 	}
+
+	if (gpiod_lookup_table)
+		gpiod_remove_lookup_table(gpiod_lookup_table);
 }
 
 void intel_dsi_vbt_gpio_cleanup(struct intel_dsi *intel_dsi)
 {
-	struct drm_device *dev = intel_dsi->base.base.dev;
-	struct drm_i915_private *dev_priv = to_i915(dev);
-	struct intel_connector *connector = intel_dsi->attached_connector;
-	struct mipi_config *mipi_config = connector->panel.vbt.dsi.config;
-
 	if (intel_dsi->gpio_panel) {
 		gpiod_put(intel_dsi->gpio_panel);
 		intel_dsi->gpio_panel = NULL;
@@ -1020,13 +1022,4 @@ void intel_dsi_vbt_gpio_cleanup(struct intel_dsi *intel_dsi)
 		gpiod_put(intel_dsi->gpio_backlight);
 		intel_dsi->gpio_backlight = NULL;
 	}
-
-	if ((IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) &&
-	    mipi_config->pwm_blc == PPS_BLC_PMIC)
-		gpiod_remove_lookup_table(&pmic_panel_gpio_table);
-
-	if (IS_VALLEYVIEW(dev_priv) && mipi_config->pwm_blc == PPS_BLC_SOC) {
-		pinctrl_unregister_mappings(soc_pwm_pinctrl_map);
-		gpiod_remove_lookup_table(&soc_panel_gpio_table);
-	}
 }
-- 
2.40.0.1.gaa8946217a0b

