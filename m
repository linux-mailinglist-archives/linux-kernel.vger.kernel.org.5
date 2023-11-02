Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87C57DF611
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347488AbjKBPNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345957AbjKBPMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:12:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E681A2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698937965; x=1730473965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wc6Dw16jrK2JuaQigVkusqKe77bPKOF3ZrL7ybVE950=;
  b=mY+NxiR2KLNLY/QfcNVAnyYqNn1ei4wWZajfHIazNUU3vgDNORHMXLct
   WIhCSgxhKIMePEKGJa7VbWe5Tbqf1aN8y6k1yxlwggqqXXeuD9Nk4+iCV
   lSdBPENYtelq+PvfuPHBIZDUQ6DPbMXo/A/nXCC7xk70nydnp8PjtCNC9
   OZW5L9vi8h2/mKs3RZ61pRftLNWayCgs0kZhm6Ck6lGG0h4whg7nE6gZC
   nUp4pkENO1xyo6E6oSatxGFMbCDvLdwRrGRI1xI7Qp0vH9ZV4qiwJIFQ7
   nGyAAV+jSYhSff8Lul+kLFuDXYlXMxtT2V56tXi/zhH0/gWQVApXddB1Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373773456"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="373773456"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="711174060"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="711174060"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2023 08:12:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C426A5F9; Thu,  2 Nov 2023 17:12:30 +0200 (EET)
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
Subject: [PATCH v3 05/15] drm/i915/dsi: bxt/icl GPIO set value do not need gpio source
Date:   Thu,  2 Nov 2023 17:12:18 +0200
Message-Id: <20231102151228.668842-6-andriy.shevchenko@linux.intel.com>
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

