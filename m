Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57887E0A3E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378247AbjKCUTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378216AbjKCUSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:18:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74826D68
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699042727; x=1730578727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4OY3kIG/Mh3qAhC+/tcUQlmLJd+LmlJUxhST6rmeiio=;
  b=Nw1PKTsUX6jPk3MnYoWEZ0IfYqfqBsPJvgm2tY1Lz0fy7FyVI/5BYn+r
   apyZ5YV2OBfpwiPAyJMsLDaKqh3xKvMrKIuLSMEwJaWr6hcLlWczBD9e2
   lnU0mvpeQLubSig7Qa+sbnnNOSDyApeodaUel55dIkAWQBYbCUdwwzwtQ
   FxAkdDAQokGNrc1k7ce9gMpVhSJ/u8/+7wLGr6kBXTCtykoorWPVOsevi
   34PfQO3SyKXFeH+KVaebYRJiZBnEjh+hVTQJaWl3cTw2TIpR/YfZohlnG
   MibIIPXsoluTQaQzqEwTKqRPwqAVTmfRleF1F60c3xWlj5yQblnYw/ASJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1896127"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1896127"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="832131210"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="832131210"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Nov 2023 13:18:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 51F587C4; Fri,  3 Nov 2023 22:18:34 +0200 (EET)
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
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH v4 15/16] drm/i915/dsi: Combine checks in mipi_exec_gpio()
Date:   Fri,  3 Nov 2023 22:18:30 +0200
Message-Id: <20231103201831.1037416-16-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
References: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a couple of cases the branches call the same bxt_gpio_set_value().
As Ville suggested they can be combined by dropping the DISPLAY_VER()
check from Gen 11 to Gen 9. Do it that way.

Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 9c6946ccb193..275d0218394c 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -420,14 +420,12 @@ static const u8 *mipi_exec_gpio(struct intel_dsi *intel_dsi, const u8 *data)
 
 	if (native)
 		icl_native_gpio_set_value(i915, gpio_number, value);
-	else if (DISPLAY_VER(i915) >= 11)
+	else if (DISPLAY_VER(i915) >= 9)
 		bxt_gpio_set_value(connector, gpio_index, value);
 	else if (IS_VALLEYVIEW(i915))
 		vlv_gpio_set_value(connector, gpio_source, gpio_number, value);
 	else if (IS_CHERRYVIEW(i915))
 		chv_gpio_set_value(connector, gpio_source, gpio_number, value);
-	else
-		bxt_gpio_set_value(connector, gpio_index, value);
 
 	return data + size;
 }
-- 
2.40.0.1.gaa8946217a0b

