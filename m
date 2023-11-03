Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F4A7E0A38
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378294AbjKCUTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378197AbjKCUSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:18:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6A418B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699042724; x=1730578724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9fjZkSqZ2/vke86mtzG4YvB7Q8n7TXNivYgzodiXkaY=;
  b=fbLyXMXMx/nZePIhwjZv1Iw3kQeqtuPvgF5tS48d+BfCfE/bssyb0727
   EiHNPdZjpmohbHQqHlBxiH1voMzMWAXfEshKcEIE7IYFukwcOf1W7JxZe
   457RtcsWmPNfCrpoJaeQZHDv+w7Q2nvONiSfSsPYlq9X1jOo/Tn8g0spW
   /mYhq1pyNPFyy8K/ogZt/L5eHr/91JkmvyABfY4GrBYvdeTKQgdmF1Zz2
   K/iaOSpuFoDZmboxLasOtCjirzURtmZKc8JtV7vBMTGVX+xvg4r9Xse6/
   kQ1tf/IOkNAimbXETtshex5bbkZsTeBcKzI9o9By1Uz2MsUPs+xGnDbOU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="387904531"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="387904531"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="885303688"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="885303688"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 03 Nov 2023 13:18:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3F1BF76F; Fri,  3 Nov 2023 22:18:34 +0200 (EET)
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
Subject: [PATCH v4 13/16] drm/i915/dsi: Prepare soc_gpio_set_value() to distinguish GPIO communities
Date:   Fri,  3 Nov 2023 22:18:28 +0200
Message-Id: <20231103201831.1037416-14-andriy.shevchenko@linux.intel.com>
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

Currently soc_gpio_set_value() supports only a single indexing for GPIO pin.
For CHV case, for example, we will need to distinguish community based index
from the one that VBT is using. Introduce an additional parameter to
soc_gpio_set_value() and its callers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 552bc6564d79..b1736c1301ea 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -206,8 +206,8 @@ static const u8 *mipi_exec_delay(struct intel_dsi *intel_dsi, const u8 *data)
 	return data;
 }
 
-static void soc_gpio_set_value(struct intel_connector *connector, const char *con_id,
-			       u8 gpio_index, bool value)
+static void soc_gpio_set_value(struct intel_connector *connector, u8 gpio_index,
+			       const char *con_id, u8 idx, bool value)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
 	/* XXX: this table is a quick ugly hack. */
@@ -217,8 +217,7 @@ static void soc_gpio_set_value(struct intel_connector *connector, const char *co
 	if (gpio_desc) {
 		gpiod_set_value(gpio_desc, value);
 	} else {
-		gpio_desc = devm_gpiod_get_index(dev_priv->drm.dev,
-						 con_id, gpio_index,
+		gpio_desc = devm_gpiod_get_index(dev_priv->drm.dev, con_id, idx,
 						 value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
 		if (IS_ERR(gpio_desc)) {
 			drm_err(&dev_priv->drm,
@@ -232,8 +231,8 @@ static void soc_gpio_set_value(struct intel_connector *connector, const char *co
 }
 
 static void soc_opaque_gpio_set_value(struct intel_connector *connector,
-				      const char *chip, const char *con_id,
-				      u8 gpio_index, bool value)
+				      u8 gpio_index, const char *chip,
+				      const char *con_id, u8 idx, bool value)
 {
 	struct gpiod_lookup_table *lookup;
 
@@ -243,11 +242,11 @@ static void soc_opaque_gpio_set_value(struct intel_connector *connector,
 
 	lookup->dev_id = "0000:00:02.0";
 	lookup->table[0] =
-		GPIO_LOOKUP_IDX(chip, gpio_index, con_id, gpio_index, GPIO_ACTIVE_HIGH);
+		GPIO_LOOKUP_IDX(chip, idx, con_id, idx, GPIO_ACTIVE_HIGH);
 
 	gpiod_add_lookup_table(lookup);
 
-	soc_gpio_set_value(connector, con_id, gpio_index, value);
+	soc_gpio_set_value(connector, gpio_index, con_id, idx, value);
 
 	gpiod_remove_lookup_table(lookup);
 	kfree(lookup);
@@ -271,7 +270,8 @@ static void vlv_gpio_set_value(struct intel_connector *connector,
 		}
 	}
 
-	soc_opaque_gpio_set_value(connector, "INT33FC:01", "Panel N", gpio_index, value);
+	soc_opaque_gpio_set_value(connector, gpio_index,
+				  "INT33FC:01", "Panel N", gpio_index, value);
 }
 
 static void chv_gpio_set_value(struct intel_connector *connector,
@@ -331,7 +331,7 @@ static void chv_gpio_set_value(struct intel_connector *connector,
 static void bxt_gpio_set_value(struct intel_connector *connector,
 			       u8 gpio_index, bool value)
 {
-	soc_gpio_set_value(connector, NULL, gpio_index, value);
+	soc_gpio_set_value(connector, gpio_index, NULL, gpio_index, value);
 }
 
 enum {
-- 
2.40.0.1.gaa8946217a0b

