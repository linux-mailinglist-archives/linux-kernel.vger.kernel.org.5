Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D74755B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGQGXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjGQGXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:23:19 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5E42611C;
        Sun, 16 Jul 2023 23:23:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 391F260198854;
        Mon, 17 Jul 2023 14:22:45 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com
Cc:     ville.syrjala@linux.intel.com, mripard@kernel.org,
        andrzej.hajda@intel.com, ankit.k.nautiyal@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, Su Hui <suhui@nfschina.com>
Subject: [PATCH] drm/i915/tv: avoid possible division by zero
Date:   Mon, 17 Jul 2023 14:22:10 +0800
Message-Id: <20230717062209.124106-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/i915/display/intel_tv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
index 36b479b46b60..82b54af51f23 100644
--- a/drivers/gpu/drm/i915/display/intel_tv.c
+++ b/drivers/gpu/drm/i915/display/intel_tv.c
@@ -988,7 +988,8 @@ intel_tv_mode_to_mode(struct drm_display_mode *mode,
 		      const struct tv_mode *tv_mode,
 		      int clock)
 {
-	mode->clock = clock / (tv_mode->oversample >> !tv_mode->progressive);
+	mode->clock = clock / (tv_mode->oversample != 1 ?
+			tv_mode->oversample >> !tv_mode->progressive : 1);
 
 	/*
 	 * tv_mode horizontal timings:
-- 
2.30.2

