Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D04A757161
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGRBdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRBdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:33:06 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0AF8A19F;
        Mon, 17 Jul 2023 18:33:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 840BF608631F4;
        Tue, 18 Jul 2023 09:33:01 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, andrzej.hajda@intel.com
Cc:     ville.syrjala@linux.intel.com, lyude@redhat.com,
        mripard@kernel.org, suhui@nfschina.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] drm/i915/tv: avoid possible division by zero
Date:   Tue, 18 Jul 2023 09:32:17 +0800
Message-Id: <20230718013216.495830-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warning: drivers/gpu/drm/i915/display/intel_tv.c:
line 991, column 22 Division by zero.
Assuming tv_mode->oversample=1 and (!tv_mode->progressive)=1,
then division by zero will happen.

Fixes: 1bba5543e4fe ("drm/i915: Fix TV encoder clock computation")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/gpu/drm/i915/display/intel_tv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
index 36b479b46b60..f59553f7c132 100644
--- a/drivers/gpu/drm/i915/display/intel_tv.c
+++ b/drivers/gpu/drm/i915/display/intel_tv.c
@@ -988,7 +988,7 @@ intel_tv_mode_to_mode(struct drm_display_mode *mode,
 		      const struct tv_mode *tv_mode,
 		      int clock)
 {
-	mode->clock = clock / (tv_mode->oversample >> !tv_mode->progressive);
+	mode->clock = clock / tv_mode->oversample << !tv_mode->progressive;
 
 	/*
 	 * tv_mode horizontal timings:
-- 
2.30.2

