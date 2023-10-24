Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170987D5710
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbjJXP5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjJXP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:57:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB628DE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698163068; x=1729699068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wMAwZJV3JScd0HFc2FZs453eK1PNONybSnww0CEKj2E=;
  b=SrYenym5ac0aWflqdAl8LGtBrCkTfFHkkO+o8NlcN0HRqoYJed46uD/l
   1pGtsFhIVA6e758sr6XMO8F2Xn224aBn9k0uKZq/+X5RXgSrckcjSFTpg
   2AcViAXBHkDRYQbkS0/hGjLYnh6W4xSSSB92IhFgR1FYcjcjN9qFfREhQ
   MtXxwZCOL/O6CzjX3w1JMMeBW82k76IbpTj/9seWPtmZKd1ftyjeVFUtC
   1pdafYZJZrGkEZWnHcxLGNxGnkzd2t3ZOcIr5CXbmnG9BB5qhOJmiI2+o
   a3QuVg4Y/giZ8NUoub7a6w8/k3ggCyqECkIf4TiExINgqcNKWaK1pNx8t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="8649785"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="8649785"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902233849"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="902233849"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2023 08:55:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 431799CE; Tue, 24 Oct 2023 18:57:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 4/7] drm/i915/dsi: Extract common soc_gpio_exec() helper
Date:   Tue, 24 Oct 2023 18:57:36 +0300
Message-Id: <20231024155739.3861342-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract a common soc_gpio_exec() helper that may be used by a few SoCs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 49 +++++++++++---------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 1014051a6866..3fb85b6d320e 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -243,6 +243,32 @@ static const u8 *mipi_exec_delay(struct intel_dsi *intel_dsi, const u8 *data)
 	return data;
 }
 
+static void soc_exec_gpio(struct intel_connector *connector, const char *con_id,
+			  u8 gpio_index, bool value)
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
+						 value ? GPIOD_OUT_LOW :
+						 GPIOD_OUT_HIGH);
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
 static void vlv_exec_gpio(struct intel_connector *connector,
 			  u8 gpio_source, u8 gpio_index, bool value)
 {
@@ -348,28 +374,7 @@ static void chv_exec_gpio(struct intel_connector *connector,
 static void bxt_exec_gpio(struct intel_connector *connector,
 			  u8 gpio_source, u8 gpio_index, bool value)
 {
-	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
-	/* XXX: this table is a quick ugly hack. */
-	static struct gpio_desc *bxt_gpio_table[U8_MAX + 1];
-	struct gpio_desc *gpio_desc = bxt_gpio_table[gpio_index];
-
-	if (!gpio_desc) {
-		gpio_desc = devm_gpiod_get_index(dev_priv->drm.dev,
-						 NULL, gpio_index,
-						 value ? GPIOD_OUT_LOW :
-						 GPIOD_OUT_HIGH);
-
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
+	soc_exec_gpio(connector, NULL, gpio_index, value);
 }
 
 static void icl_exec_gpio(struct intel_connector *connector,
-- 
2.40.0.1.gaa8946217a0b

