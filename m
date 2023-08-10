Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B07779F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbjHJN5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHJN5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:57:09 -0400
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E74212B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:57:04 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4RM7jW43R3z9y0cV;
        Thu, 10 Aug 2023 21:55:27 +0800 (CST)
Received: from fedora (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 10 Aug
 2023 21:56:40 +0800
Date:   Thu, 10 Aug 2023 21:56:39 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <stone.xulei@xfusion.com>
Subject: [PATCH] drm/i915/gmch: fix build error var set but not used
Message-ID: <ZNTsl/mlElF/spog@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PNP is not defined, i915 will fail to compile with error bellow:
	drivers/gpu/drm/i915/soc/intel_gmch.c:43:13: error: variable ‘mchbar_addr’ set but not used
Fix it by surrounding variable declaration and assignment with ifdef

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 drivers/gpu/drm/i915/soc/intel_gmch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/soc/intel_gmch.c b/drivers/gpu/drm/i915/soc/intel_gmch.c
index 6d0204942f7a..d2c442b0b4eb 100644
--- a/drivers/gpu/drm/i915/soc/intel_gmch.c
+++ b/drivers/gpu/drm/i915/soc/intel_gmch.c
@@ -38,16 +38,17 @@ intel_alloc_mchbar_resource(struct drm_i915_private *i915)
 {
 	int reg = GRAPHICS_VER(i915) >= 4 ? MCHBAR_I965 : MCHBAR_I915;
 	u32 temp_lo, temp_hi = 0;
-	u64 mchbar_addr;
 	int ret;
-
+#ifdef CONFIG_PNP
+	u64 mchbar_addr;
+#endif
 	if (GRAPHICS_VER(i915) >= 4)
 		pci_read_config_dword(i915->gmch.pdev, reg + 4, &temp_hi);
 	pci_read_config_dword(i915->gmch.pdev, reg, &temp_lo);
-	mchbar_addr = ((u64)temp_hi << 32) | temp_lo;
 
 	/* If ACPI doesn't have it, assume we need to allocate it ourselves */
 #ifdef CONFIG_PNP
+	mchbar_addr = ((u64)temp_hi << 32) | temp_lo;
 	if (mchbar_addr &&
 	    pnp_range_reserved(mchbar_addr, mchbar_addr + MCHBAR_SIZE))
 		return 0;
-- 
2.40.0

