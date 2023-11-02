Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629B47DF610
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347686AbjKBPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346201AbjKBPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:12:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC727D7B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698937966; x=1730473966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rHniHgFscmNqI1jUGvH0qfntkiUkNVL9qWW5lkhoJb8=;
  b=MVNGOqE0sEs39Ybi+R3Bc61KM4Wy1Tw97A0Lnrqlsd43RgWmcgPeV/YH
   QCLc+S1LsaMvr8+8c132lynsHvuL3GxT8OpiKNOFbZv7nKWa9p+CTQXao
   9+Q/FkE23iYAnjlLJPNz6gGxf+KNXzEHkBi2iUol4qDKoWVSQjFbqNFwi
   hWkrtvdPUxaetHlUFvQaDGRLGah6z5PTtud8i7LKUPC8Lb2hT8wV8ILtH
   SzR/ighcyJdwQJZF0Y+e9CQCFDgHZkNZ0LipfJDtgTyJYvYoZSNF+NpQ8
   Fk/gHVQsYOjb5sU26PqeZMJFv4cIOOIP9I7WOsaBQOPowOD8IoxXvrDG7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1660188"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1660188"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="737784569"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="737784569"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 02 Nov 2023 08:12:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1D98E6B5; Thu,  2 Nov 2023 17:12:31 +0200 (EET)
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
Subject: [PATCH v3 11/15] drm/i915/dsi: Extract common soc_gpio_set_value() helper
Date:   Thu,  2 Nov 2023 17:12:24 +0200
Message-Id: <20231102151228.668842-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231102151228.668842-1-andriy.shevchenko@linux.intel.com>
References: <20231102151228.668842-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract a common soc_gpio_set_value() helper that may be used by a few SoCs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

