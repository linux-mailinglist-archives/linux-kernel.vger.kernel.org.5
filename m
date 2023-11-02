Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304FB7DF614
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347592AbjKBPNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346685AbjKBPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:12:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF7F194
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698937966; x=1730473966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GllTeDr5X3asel3oBTv59ZoUHW/F9FWypvBlv9MLNPM=;
  b=MjE6fIh4ikPtKaBX47Ba5LzOYVic2HPIDI8hYHAcLnt1RWc1QxGXVTtk
   PVdzgIr4YswHxJ9DgCCNryT/ZxBnRAakcXP6JRVP8vaI60VCjwHcw+W3u
   1RbcUa4UYOBNVgXng2E2nRdmtTywDt8zyjHVXVagRC8Ic6oefdxv0CA+z
   B96tS/LvnH5dHx8V0rmhpdC2iwjUFdl7Dw/PmMOZPAcxXY/f3em6C2pL2
   qRZ+XSK9v6tRzQEiaoVyxrzsAmdP6Rs6Jb8Ds81FXE0/vfgtenop7OEVz
   e8CDIAgChpJSpi66sanXDp/qHMoFWTGKEopFh0r9ajMN8ekkqz6u3uejK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373773467"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="373773467"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="711174070"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="711174070"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2023 08:12:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E881D65B; Thu,  2 Nov 2023 17:12:30 +0200 (EET)
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
Subject: [PATCH v3 08/15] drm/i915/dsi: Replace check with a (missing) MIPI sequence name
Date:   Thu,  2 Nov 2023 17:12:21 +0200
Message-Id: <20231102151228.668842-9-andriy.shevchenko@linux.intel.com>
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

Names of the MIPI sequence steps are sequential and defined, no
need to check for the gaps. However in seq_name the MIPI_SEQ_END
is missing. Add it there, and drop unneeded NULL check in
sequence_name().

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

