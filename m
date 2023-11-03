Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C443E7E0A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378258AbjKCUTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378181AbjKCUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:18:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266BEB8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699042723; x=1730578723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=grTcdks/Ll70fGBWNiqdqzL8NMj1dVygNqVaInrANw8=;
  b=Fku0v1hB0Hlf7YCcHkiuwwMpLFkp6h5L1wt7H07mBJFsJt1VlreuhCpp
   7zCMRRwYkfmp9HPoo+jniGX2/j392migelgsTCG1lABe1BAq5T/Wo7s7g
   LQbtEka5oMsysbNxYggPTpKIlpP0mRobJqMMbKNOw3tl0gWjZjuIKl5Ba
   cWGGmoHX4BwYNvHpVjyMP/ENri6qG2379SF4+b/5aB93w3oA5i+Q+eziY
   3SUstFmHWI17ykTtSbHVy/uI+o7zgGsbqg0+xy0mQR41m5Xo/hC5wWH9S
   lBCyUMJ5upssLjKhGSZfiPgXrNpBH10EESkk9l7azi3j9081fnXFCIiAb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="387904511"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="387904511"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="885303671"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="885303671"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 03 Nov 2023 13:18:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 018C06B4; Fri,  3 Nov 2023 22:18:33 +0200 (EET)
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
Subject: [PATCH v4 08/16] drm/i915/dsi: Replace check with a (missing) MIPI sequence name
Date:   Fri,  3 Nov 2023 22:18:23 +0200
Message-Id: <20231103201831.1037416-9-andriy.shevchenko@linux.intel.com>
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

Names of the MIPI sequence steps are sequential and defined, no
need to check for the gaps. However in seq_name the MIPI_SEQ_END
is missing. Add it there, and drop unneeded NULL check in
sequence_name().

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 4ed5ede9ec5b..d270437217b3 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -653,6 +653,7 @@ static const fn_mipi_elem_exec exec_elem[] = {
  */
 
 static const char * const seq_name[] = {
+	[MIPI_SEQ_END] = "MIPI_SEQ_END",
 	[MIPI_SEQ_DEASSERT_RESET] = "MIPI_SEQ_DEASSERT_RESET",
 	[MIPI_SEQ_INIT_OTP] = "MIPI_SEQ_INIT_OTP",
 	[MIPI_SEQ_DISPLAY_ON] = "MIPI_SEQ_DISPLAY_ON",
@@ -668,7 +669,7 @@ static const char * const seq_name[] = {
 
 static const char *sequence_name(enum mipi_seq seq_id)
 {
-	if (seq_id < ARRAY_SIZE(seq_name) && seq_name[seq_id])
+	if (seq_id < ARRAY_SIZE(seq_name))
 		return seq_name[seq_id];
 
 	return "(unknown)";
-- 
2.40.0.1.gaa8946217a0b

