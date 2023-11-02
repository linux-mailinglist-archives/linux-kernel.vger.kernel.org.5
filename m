Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D036F7DF613
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347655AbjKBPNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347529AbjKBPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:13:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E851193
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698937973; x=1730473973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OjtX56iRe2R3p5yMpkS5TZ75eagAFRwkxp7gUYAmyeg=;
  b=Gd9C50G+Moyuqb1fDgEDubMSgw9GEe4Gt1MY8yv6XV0ukjnhjJz1V6S9
   XBRp/qNqMQRDSBGoWGw0YLbApxl6M8xkyNK+SE5qdJfyzmJ+J+8RoCK0f
   u+VP7jzw7xAN/UWgFjnqyD6Nmi8ce4fxXWTsA9UwM102ypxWAeBvMuJoh
   fOx9bG+fp8r6TXyCde+qLJiJJgb8SUWwINUbtvZP5EMMo4p7GbuQLbxpu
   hlk3MOHAIASjKn+we0B+DEBozoV3hUqs+XwmfdzyN1oCfP30INg9s7ZfS
   UHIA1QIi8cNk9lsds6hWUZaiUBqnU/SV1SogP+aJQ3Nu+pHRrd9bGmzva
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373773472"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="373773472"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="711174072"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="711174072"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2023 08:12:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DC358644; Thu,  2 Nov 2023 17:12:30 +0200 (EET)
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
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v3 07/15] drm/i915/dsi: Get rid of redundant 'else'
Date:   Thu,  2 Nov 2023 17:12:20 +0200
Message-Id: <20231102151228.668842-8-andriy.shevchenko@linux.intel.com>
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

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it.

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 58 ++++++++++----------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 290a112f1b63..4ed5ede9ec5b 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -142,7 +142,7 @@ static enum port intel_dsi_seq_port_to_port(struct intel_dsi *intel_dsi,
 	if (seq_port) {
 		if (intel_dsi->ports & BIT(PORT_B))
 			return PORT_B;
-		else if (intel_dsi->ports & BIT(PORT_C))
+		if (intel_dsi->ports & BIT(PORT_C))
 			return PORT_C;
 	}
 
@@ -670,8 +670,8 @@ static const char *sequence_name(enum mipi_seq seq_id)
 {
 	if (seq_id < ARRAY_SIZE(seq_name) && seq_name[seq_id])
 		return seq_name[seq_id];
-	else
-		return "(unknown)";
+
+	return "(unknown)";
 }
 
 static void intel_dsi_vbt_exec(struct intel_dsi *intel_dsi,
@@ -865,36 +865,34 @@ bool intel_dsi_vbt_init(struct intel_dsi *intel_dsi, u16 panel_id)
 	 * multiply by 100 to preserve remainder
 	 */
 	if (intel_dsi->video_mode == BURST_MODE) {
-		if (mipi_config->target_burst_mode_freq) {
-			u32 bitrate = intel_dsi_bitrate(intel_dsi);
+		u32 bitrate;
 
-			/*
-			 * Sometimes the VBT contains a slightly lower clock,
-			 * then the bitrate we have calculated, in this case
-			 * just replace it with the calculated bitrate.
-			 */
-			if (mipi_config->target_burst_mode_freq < bitrate &&
-			    intel_fuzzy_clock_check(
-					mipi_config->target_burst_mode_freq,
-					bitrate))
-				mipi_config->target_burst_mode_freq = bitrate;
-
-			if (mipi_config->target_burst_mode_freq < bitrate) {
-				drm_err(&dev_priv->drm,
-					"Burst mode freq is less than computed\n");
-				return false;
-			}
-
-			burst_mode_ratio = DIV_ROUND_UP(
-				mipi_config->target_burst_mode_freq * 100,
-				bitrate);
-
-			intel_dsi->pclk = DIV_ROUND_UP(intel_dsi->pclk * burst_mode_ratio, 100);
-		} else {
-			drm_err(&dev_priv->drm,
-				"Burst mode target is not set\n");
+		if (mipi_config->target_burst_mode_freq == 0) {
+			drm_err(&dev_priv->drm, "Burst mode target is not set\n");
 			return false;
 		}
+
+		bitrate = intel_dsi_bitrate(intel_dsi);
+
+		/*
+		 * Sometimes the VBT contains a slightly lower clock, then
+		 * the bitrate we have calculated, in this case just replace it
+		 * with the calculated bitrate.
+		 */
+		if (mipi_config->target_burst_mode_freq < bitrate &&
+		    intel_fuzzy_clock_check(mipi_config->target_burst_mode_freq,
+					    bitrate))
+			mipi_config->target_burst_mode_freq = bitrate;
+
+		if (mipi_config->target_burst_mode_freq < bitrate) {
+			drm_err(&dev_priv->drm, "Burst mode freq is less than computed\n");
+			return false;
+		}
+
+		burst_mode_ratio =
+			DIV_ROUND_UP(mipi_config->target_burst_mode_freq * 100, bitrate);
+
+		intel_dsi->pclk = DIV_ROUND_UP(intel_dsi->pclk * burst_mode_ratio, 100);
 	} else
 		burst_mode_ratio = 100;
 
-- 
2.40.0.1.gaa8946217a0b

