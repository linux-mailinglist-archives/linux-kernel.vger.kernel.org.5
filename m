Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFFA7DF5F5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjKBPNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjKBPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:12:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613B3D67
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698937961; x=1730473961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sOlXPhm2EWggWgC9auNPoDBOg8jjBU+Gm+8lS7rVTqE=;
  b=HPz4CZZ4V79hoi2qRYOBiisXbor15Rn7KIxwTPQ/cBup7qeWjY5e3rgb
   SG21OGIE8gOAdCRKhMvtq/098yM2W+sXX6YfTjfBWklr60jgmmGHcaKwW
   MJ5Nbdwp8Lvg7MrvWj56H1gHJO1zn70sVTfoqlgx0lryzHxLqOxnyC0F4
   jVzIMI22hoa1Ld7Msf22pnZNZgbnNRzuaZplfn5QYH6VA6cKsksZKKMLg
   rv+xvCqSjD0Wbc0ptTIRcDr1b4jpZxUNN+6iFJjA2ZsDrytCylB9YxqSN
   f9Q+OH6DQDgkuonzCGgnLO9+6Du7AzoaEV9/moTQxIslc/H53L5PAe8KT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373773429"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="373773429"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="711173922"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="711173922"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2023 08:12:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A7C3E5E5; Thu,  2 Nov 2023 17:12:30 +0200 (EET)
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
Subject: [PATCH v3 03/15] drm/i915/dsi: clarify GPIO exec sequence
Date:   Thu,  2 Nov 2023 17:12:16 +0200
Message-Id: <20231102151228.668842-4-andriy.shevchenko@linux.intel.com>
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

With the various sequence versions and pointer increments interleaved,
it's a bit hard to decipher what's going on. Add separate paths for
different sequence versions.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 31 +++++++++++---------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 8b962f2ac475..11073efe26c0 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -456,26 +456,29 @@ static const u8 *mipi_exec_gpio(struct intel_dsi *intel_dsi, const u8 *data)
 	struct drm_device *dev = intel_dsi->base.base.dev;
 	struct drm_i915_private *i915 = to_i915(dev);
 	struct intel_connector *connector = intel_dsi->attached_connector;
-	u8 gpio_source, gpio_index = 0, gpio_number;
+	u8 gpio_source = 0, gpio_index = 0, gpio_number;
 	bool value;
+	int size;
 	bool native = DISPLAY_VER(i915) >= 11;
 
-	if (connector->panel.vbt.dsi.seq_version >= 3)
-		gpio_index = *data++;
+	if (connector->panel.vbt.dsi.seq_version >= 3) {
+		size = 3;
 
-	gpio_number = *data++;
+		gpio_index = data[0];
+		gpio_number = data[1];
+		value = data[2] & BIT(0);
 
-	/* gpio source in sequence v2 only */
-	if (connector->panel.vbt.dsi.seq_version == 2)
-		gpio_source = (*data >> 1) & 3;
-	else
-		gpio_source = 0;
+		if (connector->panel.vbt.dsi.seq_version >= 4 && data[2] & BIT(1))
+			native = false;
+	} else {
+		size = 2;
 
-	if (connector->panel.vbt.dsi.seq_version >= 4 && *data & BIT(1))
-		native = false;
+		gpio_number = data[0];
+		value = data[1] & BIT(0);
 
-	/* pull up/down */
-	value = *data++ & 1;
+		if (connector->panel.vbt.dsi.seq_version == 2)
+			gpio_source = (data[1] >> 1) & 3;
+	}
 
 	drm_dbg_kms(&i915->drm, "GPIO index %u, number %u, source %u, native %s, set to %s\n",
 		    gpio_index, gpio_number, gpio_source, str_yes_no(native), str_on_off(value));
@@ -491,7 +494,7 @@ static const u8 *mipi_exec_gpio(struct intel_dsi *intel_dsi, const u8 *data)
 	else
 		bxt_exec_gpio(connector, gpio_source, gpio_index, value);
 
-	return data;
+	return data + size;
 }
 
 #ifdef CONFIG_ACPI
-- 
2.40.0.1.gaa8946217a0b

