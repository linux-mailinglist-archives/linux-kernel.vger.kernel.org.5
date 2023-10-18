Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EB47CD369
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjJRFLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJRFLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:11:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1511010B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697605864; x=1729141864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YvDBqhfDgnDd5m69diSkC/yOJ2Ix4OIlArCI45h7ELg=;
  b=lTGrtu5l8pbx4Le7e4f1/81QB/SaUugv8R55hypZoua+3EZtvbgQtOgC
   979NraneN8R+qPQbQcZwq6CWnfp+gKM/0aiPJnarjadJSXqs06n0AtGAZ
   gxmZOkYVc/KuRais7m++CmZ29H84rajOyo+Bg1Nlyz6bgaVN3yEOyLSRl
   2rvBWFnMSrKalkkIXZTO2Nix03rYrAYET4gPuLSo8hCbt1QjqcifakOMp
   isDczgtydJ57U3Cjkpjf2HVpGOe6KMC8FQ99VFfLhMGpQFg9GoIctjaU3
   FK9ofk6tH9xq5t/eXSlWYhQJmCXprRR6H/Vb6nvaZjFd8lH3H7xZTxpks
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388803240"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="388803240"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 22:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="785736947"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="785736947"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2023 22:10:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8BE61BF; Wed, 18 Oct 2023 08:10:58 +0300 (EEST)
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
Subject: [PATCH v1 1/2] drm/i915/dsi: Extract common soc_gpio_exec() helper
Date:   Wed, 18 Oct 2023 08:10:51 +0300
Message-Id: <20231018051052.1328852-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231018051052.1328852-1-andriy.shevchenko@linux.intel.com>
References: <20231018051052.1328852-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 24b2cbcfc1ef..c3c3f4df9ac4 100644
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

