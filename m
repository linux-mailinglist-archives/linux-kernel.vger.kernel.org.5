Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5DF7E0A13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378199AbjKCUSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjKCUSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:18:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58879D53
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699042720; x=1730578720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zPRCzYNN16HwjO3RHBcn1H7M4PO+1uvgVko+eIKdfwQ=;
  b=av1ig0i/rIAFEXjEDvovP3EV3L7sb5FEjjH+uo8WoZFkqa8JNFW+inVn
   ptOvIqwpEXED8BVVxS7bkx7EWv0DBHVo/h1pFCAbMIrUAASS21wI5dO7i
   tjw5iBjc8Ksn2svoAgY5hvX/+veBoqq9VTaOnTggHTnsPZiSb3wUaxkwR
   plK7Jlmf+T9NJIYMjdQyChzjXTV8L10GmeaVYWsZeoQMk6V92D5gsTFDg
   Vh21sU380LTODSWD77wBkGiNmwBNUVrVmp6h56Jf7U0fh49IkmypF0Npf
   HdLxmLYdPPLWkHzg/FIJN/NOALfJwIBSh/+u59aD0MqBlBMLlo/JENk1P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="387904499"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="387904499"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="885303644"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="885303644"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 03 Nov 2023 13:18:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9BEB42A6; Fri,  3 Nov 2023 22:18:33 +0200 (EET)
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
Subject: [PATCH v4 01/16] drm/i915/dsi: assume BXT gpio works for non-native GPIO
Date:   Fri,  3 Nov 2023 22:18:16 +0200
Message-Id: <20231103201831.1037416-2-andriy.shevchenko@linux.intel.com>
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

From: Jani Nikula <jani.nikula@intel.com>

Purely a guess. Drop the nop function.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 24b2cbcfc1ef..b2c0cc11f8c1 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -372,14 +372,6 @@ static void bxt_exec_gpio(struct intel_connector *connector,
 	gpiod_set_value(gpio_desc, value);
 }
 
-static void icl_exec_gpio(struct intel_connector *connector,
-			  u8 gpio_source, u8 gpio_index, bool value)
-{
-	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
-
-	drm_dbg_kms(&dev_priv->drm, "Skipping ICL GPIO element execution\n");
-}
-
 enum {
 	MIPI_RESET_1 = 0,
 	MIPI_AVDD_EN_1,
@@ -491,7 +483,7 @@ static const u8 *mipi_exec_gpio(struct intel_dsi *intel_dsi, const u8 *data)
 	if (native)
 		icl_native_gpio_set_value(dev_priv, gpio_number, value);
 	else if (DISPLAY_VER(dev_priv) >= 11)
-		icl_exec_gpio(connector, gpio_source, gpio_index, value);
+		bxt_exec_gpio(connector, gpio_source, gpio_index, value);
 	else if (IS_VALLEYVIEW(dev_priv))
 		vlv_exec_gpio(connector, gpio_source, gpio_number, value);
 	else if (IS_CHERRYVIEW(dev_priv))
-- 
2.40.0.1.gaa8946217a0b

