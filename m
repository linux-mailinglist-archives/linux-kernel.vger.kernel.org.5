Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7D87E0A3A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378237AbjKCUS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378185AbjKCUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:18:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58782D63
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699042723; x=1730578723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wc6Dw16jrK2JuaQigVkusqKe77bPKOF3ZrL7ybVE950=;
  b=GOUCGsBDPAeaSEeyPQhrc42zmBEu9zJVgtNe/gn2xfrtDroLo/WwXcJT
   V018eOpdMY6PecZk+14e2jLkkYp1gqKFc1uHzOWXTjpEJ4h2Iz1uPvDdw
   nMv7Qk90uhZPY1qLJTru46MPNSNJQ7f7B/G6+AIeLDmPe+cAVWMeBZo4h
   x+5np31xH0kshihOOr6JfFmvNrF7DhuQzu/alDiW3CBHtLTV3iX4HfBwZ
   UsDdrnVxZgpbi3SR7L2HUNSmC7/iANJpcrt/PQ7s7OOW4Ww0IteUQfGcd
   bKqeJ4GAS1yn6wZFbfQkDOTo12QrAS9sV3fJdEs3zrwKGVtCklQ28mghf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1896071"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1896071"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="832131146"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="832131146"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Nov 2023 13:18:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D39D4644; Fri,  3 Nov 2023 22:18:33 +0200 (EET)
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
Subject: [PATCH v4 05/16] drm/i915/dsi: bxt/icl GPIO set value do not need gpio source
Date:   Fri,  3 Nov 2023 22:18:20 +0200
Message-Id: <20231103201831.1037416-6-andriy.shevchenko@linux.intel.com>
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

Drop the unused parameter.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index f977d63a0ad4..4af43cf3cee0 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -346,7 +346,7 @@ static void chv_gpio_set_value(struct intel_connector *connector,
 }
 
 static void bxt_gpio_set_value(struct intel_connector *connector,
-			       u8 gpio_source, u8 gpio_index, bool value)
+			       u8 gpio_index, bool value)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
 	/* XXX: this table is a quick ugly hack. */
@@ -486,13 +486,13 @@ static const u8 *mipi_exec_gpio(struct intel_dsi *intel_dsi, const u8 *data)
 	if (native)
 		icl_native_gpio_set_value(i915, gpio_number, value);
 	else if (DISPLAY_VER(i915) >= 11)
-		bxt_gpio_set_value(connector, gpio_source, gpio_index, value);
+		bxt_gpio_set_value(connector, gpio_index, value);
 	else if (IS_VALLEYVIEW(i915))
 		vlv_gpio_set_value(connector, gpio_source, gpio_number, value);
 	else if (IS_CHERRYVIEW(i915))
 		chv_gpio_set_value(connector, gpio_source, gpio_number, value);
 	else
-		bxt_gpio_set_value(connector, gpio_source, gpio_index, value);
+		bxt_gpio_set_value(connector, gpio_index, value);
 
 	return data + size;
 }
-- 
2.40.0.1.gaa8946217a0b

