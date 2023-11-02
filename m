Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA77DF612
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347703AbjKBPN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346414AbjKBPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:12:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C190181
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698937966; x=1730473966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EwelSoZ61k9tZJuVFvgxr/RQChgXvtfD52YtSTJ+m/s=;
  b=kCQ/YfB6dv3DozGZmO3Whqpyrom519b9WRFRNw/fc2WKnKsJmV3Pi3Mz
   DN/qlCRCLP1nNFDu4ttBfxASh+w6tZqDyjiTHwr6MC8X5a0sj0/7orGT6
   c9JLNDKGXqfvx84e0NCjhjIJl1NjiYVKL5EVkmhwO+rCpRW0gXOdtvUVF
   uXoXau2HX9/m4YPsTvQdjNZhrcQ/QIlaDQl7SAsxhN2amYTGQ4SoxxGVJ
   wID4ZbPdQmDmQqCgCOKOgXUCqqowB3UTNuzk+z+JV85LUAgWsQO9m67jh
   FZAtVq+VMjU5rD329Af46GppQ7cRO8TtuTyK/PIGzhzH/pXl3UaaJaSzt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373773461"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="373773461"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="711174065"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="711174065"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2023 08:12:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D074C618; Thu,  2 Nov 2023 17:12:30 +0200 (EET)
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
Subject: [PATCH v3 06/15] drm/i915/dsi: Replace while(1) with one with clear exit condition
Date:   Thu,  2 Nov 2023 17:12:19 +0200
Message-Id: <20231102151228.668842-7-andriy.shevchenko@linux.intel.com>
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

Move existing condition to while(), so it will be clear on what
circumstances the loop is successfully finishing.

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 4af43cf3cee0..290a112f1b63 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -702,13 +702,10 @@ static void intel_dsi_vbt_exec(struct intel_dsi *intel_dsi,
 	if (connector->panel.vbt.dsi.seq_version >= 3)
 		data += 4;
 
-	while (1) {
+	while (*data != MIPI_SEQ_ELEM_END) {
 		u8 operation_byte = *data++;
 		u8 operation_size = 0;
 
-		if (operation_byte == MIPI_SEQ_ELEM_END)
-			break;
-
 		if (operation_byte < ARRAY_SIZE(exec_elem))
 			mipi_elem_exec = exec_elem[operation_byte];
 		else
-- 
2.40.0.1.gaa8946217a0b

