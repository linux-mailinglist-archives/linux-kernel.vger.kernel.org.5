Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBB67DF616
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346739AbjKBPNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347559AbjKBPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:13:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F13195
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698937974; x=1730473974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tPOo2JFZjmGlcEg5hgEz5myL83a6tVD72rxMxo2uXXU=;
  b=fwT7YyvjwVRWmFcnoROh1R+USKvJKfte2AKeIAOEQZ0pHlSAbV5CHHi0
   04Y/3kNOxuA5w9hFgkNqCkP7rkMQ4d/sO9m3fsO7z4s8kFLFXDp5O8zw+
   E5zRHpNuHGjBjInnUvk14HpyKizm2WA06Ls/EXnGL3EAE1GvI+GZ1wW48
   Jq76AgzJMo55x3Qr7QiuZwHV5H8yGKt57TgKKL7OjCpQjsjybw95uNtRb
   5FTopYKyGimgjIusBlC3xpvt4P1DrwloArK4ur6OenISBMe/Nr5HwGQWQ
   EGS3LqwQh1aYL7zaToEUESMH+P563LgRCrwQmnctHLiUwnfRh6ZRKx+v2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373773487"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="373773487"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="711174078"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="711174078"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2023 08:12:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 32AC672F; Thu,  2 Nov 2023 17:12:31 +0200 (EET)
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
Subject: [PATCH v3 13/15] drm/i915/dsi: Prepare soc_gpio_set_value() to distinguish GPIO communities
Date:   Thu,  2 Nov 2023 17:12:26 +0200
Message-Id: <20231102151228.668842-14-andriy.shevchenko@linux.intel.com>
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

Currently soc_gpio_set_value() supports only a single indexing for GPIO pin.
For CHV case, for example, we will need to distinguish community based index
from the one that VBT is using. Introduce an additional parameter to
soc_gpio_set_value() and its callers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

