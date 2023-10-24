Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD917D5716
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343992AbjJXP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343989AbjJXP5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:57:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85F610C9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698163070; x=1729699070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dnQFwufB5Hr81HvGwsAEkxbIJnfWkJTFO23E+pdW1kc=;
  b=EjXFNi1EyrSOuIr2s6su7IylH5rb0Pyj2xEueIgE0uKwvpTTcYp+kYG0
   jJcKraW9WPVL+0T9yV6c5u3dOfcIg09eTPInrrAJ4ZaKlvNOhUNXYNn7g
   eiZJMGZH/y3y74jI6rFKEotLq2LbRmuY2qI1v07z/2ZLTqwJ9HM8Tn1sA
   Dlae3PUwjoMxenOTqNZMyp363IxjI/pAqqPRX1kp1OTckWbq760xusyHx
   UNUkGMwlfUUuM4Wfq8vhLOTnp2rIZzz9jXvhVfNJkNvia4yISC7fqdcNI
   CKbuGPL83fbmlRR70xmZgrQs0C0YB/RylWCMtpoSIATypdynp0IHbMRfV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="8649803"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="8649803"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902233870"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="902233870"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2023 08:55:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 67009BE1; Tue, 24 Oct 2023 18:57:42 +0300 (EEST)
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
Subject: [PATCH v2 6/7] drm/i915/dsi: Replace poking of CHV GPIOs behind the driver's back
Date:   Tue, 24 Oct 2023 18:57:38 +0300
Message-Id: <20231024155739.3861342-7-andriy.shevchenko@linux.intel.com>
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

It's a dirty hack in the driver that pokes GPIO registers behind
the driver's back. Moreoever it might be problematic as simultaneous
I/O may hang the system, see the commit 0bd50d719b00 ("pinctrl:
cherryview: prevent concurrent access to GPIO controllers") for
the details. Taking all this into consideration replace the hack
with proper GPIO APIs being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 47 +++++---------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 8fc82aceae14..a393ddaff0dd 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -66,19 +66,6 @@ struct i2c_adapter_lookup {
 #define CHV_GPIO_IDX_START_SW		100
 #define CHV_GPIO_IDX_START_SE		198
 
-#define CHV_VBT_MAX_PINS_PER_FMLY	15
-
-#define CHV_GPIO_PAD_CFG0(f, i)		(0x4400 + (f) * 0x400 + (i) * 8)
-#define  CHV_GPIO_GPIOEN		(1 << 15)
-#define  CHV_GPIO_GPIOCFG_GPIO		(0 << 8)
-#define  CHV_GPIO_GPIOCFG_GPO		(1 << 8)
-#define  CHV_GPIO_GPIOCFG_GPI		(2 << 8)
-#define  CHV_GPIO_GPIOCFG_HIZ		(3 << 8)
-#define  CHV_GPIO_GPIOTXSTATE(state)	((!!(state)) << 1)
-
-#define CHV_GPIO_PAD_CFG1(f, i)		(0x4400 + (f) * 0x400 + (i) * 8 + 4)
-#define  CHV_GPIO_CFGLOCK		(1 << 31)
-
 /* ICL DSI Display GPIO Pins */
 #define  ICL_GPIO_DDSP_HPD_A		0
 #define  ICL_GPIO_L_VDDEN_1		1
@@ -279,23 +266,21 @@ static void chv_exec_gpio(struct intel_connector *connector,
 			  u8 gpio_source, u8 gpio_index, bool value)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
-	u16 cfg0, cfg1;
-	u16 family_num;
-	u8 port;
 
 	if (connector->panel.vbt.dsi.seq_version >= 3) {
 		if (gpio_index >= CHV_GPIO_IDX_START_SE) {
 			/* XXX: it's unclear whether 255->57 is part of SE. */
-			gpio_index -= CHV_GPIO_IDX_START_SE;
-			port = CHV_IOSF_PORT_GPIO_SE;
+			soc_exec_opaque_gpio(connector, "INT33FF:03", "Panel SE",
+					     gpio_index - CHV_GPIO_IDX_START_SW, value);
 		} else if (gpio_index >= CHV_GPIO_IDX_START_SW) {
-			gpio_index -= CHV_GPIO_IDX_START_SW;
-			port = CHV_IOSF_PORT_GPIO_SW;
+			soc_exec_opaque_gpio(connector, "INT33FF:00", "Panel SW",
+					     gpio_index - CHV_GPIO_IDX_START_SW, value);
 		} else if (gpio_index >= CHV_GPIO_IDX_START_E) {
-			gpio_index -= CHV_GPIO_IDX_START_E;
-			port = CHV_IOSF_PORT_GPIO_E;
+			soc_exec_opaque_gpio(connector, "INT33FF:02", "Panel E",
+					     gpio_index - CHV_GPIO_IDX_START_E, value);
 		} else {
-			port = CHV_IOSF_PORT_GPIO_N;
+			soc_exec_opaque_gpio(connector, "INT33FF:01", "Panel N",
+					     gpio_index - CHV_GPIO_IDX_START_N, value);
 		}
 	} else {
 		/* XXX: The spec is unclear about CHV GPIO on seq v2 */
@@ -312,21 +297,9 @@ static void chv_exec_gpio(struct intel_connector *connector,
 			return;
 		}
 
-		port = CHV_IOSF_PORT_GPIO_N;
+		soc_exec_opaque_gpio(connector, "INT33FF:01", "Panel N",
+				     gpio_index - CHV_GPIO_IDX_START_N, value);
 	}
-
-	family_num = gpio_index / CHV_VBT_MAX_PINS_PER_FMLY;
-	gpio_index = gpio_index % CHV_VBT_MAX_PINS_PER_FMLY;
-
-	cfg0 = CHV_GPIO_PAD_CFG0(family_num, gpio_index);
-	cfg1 = CHV_GPIO_PAD_CFG1(family_num, gpio_index);
-
-	vlv_iosf_sb_get(dev_priv, BIT(VLV_IOSF_SB_GPIO));
-	vlv_iosf_sb_write(dev_priv, port, cfg1, 0);
-	vlv_iosf_sb_write(dev_priv, port, cfg0,
-			  CHV_GPIO_GPIOEN | CHV_GPIO_GPIOCFG_GPO |
-			  CHV_GPIO_GPIOTXSTATE(value));
-	vlv_iosf_sb_put(dev_priv, BIT(VLV_IOSF_SB_GPIO));
 }
 
 static void bxt_exec_gpio(struct intel_connector *connector,
-- 
2.40.0.1.gaa8946217a0b

