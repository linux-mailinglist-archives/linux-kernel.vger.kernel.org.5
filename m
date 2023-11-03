Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6116B7E0A37
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378279AbjKCUTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378193AbjKCUSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:18:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEC4B8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699042724; x=1730578724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mxriWgsT/BR/PEWccYibzv6yVC4qNoxmHPUVcpwzS68=;
  b=KQC7RifZoU8pR7OPzZc6K7Ui8hF82dENPwLh5RkaOCan20zIiMOLviky
   19v/F9XTRZE3qWh2wZTF6VO8Xy/LTdIxe4cwjjuvZNVB+szq/yzKvmQ/G
   XGbxzZmaGynAgu8tAZCmXMCE+0XbSjfl7hh+O1fV772z/0r1rcUhUGphs
   AwwKDwT68b+A67JlRIreBsrDtnPns/g7Wja+HEDLNXCNuH6BSgRH6QGHC
   i6XoYyXmz3khIMM1FXrWpxMNbdQkzROWDx4050OKiTomCH/lNDyM2rLfN
   8PYMRQWZ2NVP9yMx/mgwq+c7LfbTV8AAD1CHcgSoS4XEGuv5h7Rey+x2M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="387904522"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="387904522"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="885303685"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="885303685"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 03 Nov 2023 13:18:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2454E72F; Fri,  3 Nov 2023 22:18:34 +0200 (EET)
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
Subject: [PATCH v4 11/16] drm/i915/dsi: Extract common soc_gpio_set_value() helper
Date:   Fri,  3 Nov 2023 22:18:26 +0200
Message-Id: <20231103201831.1037416-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
References: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract a common soc_gpio_set_value() helper that may be used by a few SoCs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 46 +++++++++++---------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 0f9da0168a7b..9847a92fdfc3 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -243,6 +243,31 @@ static const u8 *mipi_exec_delay(struct intel_dsi *intel_dsi, const u8 *data)
 	return data;
 }
 
+static void soc_gpio_set_value(struct intel_connector *connector, const char *con_id,
+			       u8 gpio_index, bool value)
+{
+	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
+	/* XXX: this table is a quick ugly hack. */
+	static struct gpio_desc *soc_gpio_table[U8_MAX + 1];
+	struct gpio_desc *gpio_desc = soc_gpio_table[gpio_index];
+
+	if (gpio_desc) {
+		gpiod_set_value(gpio_desc, value);
+	} else {
+		gpio_desc = devm_gpiod_get_index(dev_priv->drm.dev,
+						 con_id, gpio_index,
+						 value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
+		if (IS_ERR(gpio_desc)) {
+			drm_err(&dev_priv->drm,
+				"GPIO index %u request failed (%pe)\n",
+				gpio_index, gpio_desc);
+			return;
+		}
+
+		soc_gpio_table[gpio_index] = gpio_desc;
+	}
+}
+
 static void vlv_gpio_set_value(struct intel_connector *connector,
 			       u8 gpio_source, u8 gpio_index, bool value)
 {
@@ -348,26 +373,7 @@ static void chv_gpio_set_value(struct intel_connector *connector,
 static void bxt_gpio_set_value(struct intel_connector *connector,
 			       u8 gpio_index, bool value)
 {
-	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
-	/* XXX: this table is a quick ugly hack. */
-	static struct gpio_desc *bxt_gpio_table[U8_MAX + 1];
-	struct gpio_desc *gpio_desc = bxt_gpio_table[gpio_index];
-
-	if (!gpio_desc) {
-		gpio_desc = devm_gpiod_get_index(dev_priv->drm.dev,
-						 NULL, gpio_index,
-						 value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(gpio_desc)) {
-			drm_err(&dev_priv->drm,
-				"GPIO index %u request failed (%ld)\n",
-				gpio_index, PTR_ERR(gpio_desc));
-			return;
-		}
-
-		bxt_gpio_table[gpio_index] = gpio_desc;
-	}
-
-	gpiod_set_value(gpio_desc, value);
+	soc_gpio_set_value(connector, NULL, gpio_index, value);
 }
 
 enum {
-- 
2.40.0.1.gaa8946217a0b

