Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D321B794381
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbjIFTDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243995AbjIFTCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:02:37 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CB41B7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 12:02:33 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79565370aa3so5564239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694026952; x=1694631752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7joZjSDNylfwIjlN/v1EJKsLNVMUogPTU5+zZ+4Y2sA=;
        b=l7bUw00O7hX9W/k/qeYBNo2ag8y4j+NYyhtg5DnM/VAbDgD/eoKqPx1C7gciq2KddS
         oCAk8hs1w4N8oQa9L8EZD57ONP1xsQdBw6S4QQRKPjhYTFBQ8uKUbcR1UXbgT0MOKaZq
         Wp0MYKwwic7VhX6QD65foIplDNaeR4EDbo2OnMYenLVq9mgA9KOyDhsV9mfq/bW9+NeC
         JwGM54IyAWTtCqkeCm9ugNQdXL/Fn4kkT7wG85SL1k1RMIQNhIfPQ3IOhuzt8VZ6vqqz
         L7rs0o/TBZd3W22a2zqCpeygtfSRMF0O10pwQlItCl7MOEGa7eSVioR7C0jzOjr9SWoV
         WIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694026952; x=1694631752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7joZjSDNylfwIjlN/v1EJKsLNVMUogPTU5+zZ+4Y2sA=;
        b=i2cNQ7T+RlAzl+9zWE7hFo1l8Ql7Ou5WXHbzwBsfF9XC4A8/HK/ShI5urivHgYMKxE
         RVRpJwXnkj9bGG+bh2D896+C5Z1VpkfFc3CxX7s9+pDC4J8buI5gCCgV0FXpAloIufHz
         b3bCOgxxefWOTwkp8OMcv4GDWrfgOYXVXRlD8ZEPb6gXoaIozibcPy3HD2xl3Xpijm38
         Mm+TRbIKnYAHIgvpFRrBSNrImaFisLR5AhxFLyBuqfN++uzu/ZxGojwMmxNFz+ibFQEJ
         Ym2pXTdUJqtNCsQkuuM7wlmn9QZUyCqm11mRO+Xq1h6gedN//I9dAV8+RNKe4cnfvajQ
         1spg==
X-Gm-Message-State: AOJu0Yz+D/br8p57GRh3RsCaUXUb2/UBaENBzuGro8N24In3Dkx5x+J1
        fTqCY4Vujf7TsUP2TuPTev8Et652LEK/Ow==
X-Google-Smtp-Source: AGHT+IF9+5z8gW/L2WmhxsI+81BMma/N4jRZCRB7iE4meseUn0CUi23FnZlRHWkkTJI6XVkfvLHlSg==
X-Received: by 2002:a5e:8913:0:b0:783:47cd:27b5 with SMTP id k19-20020a5e8913000000b0078347cd27b5mr18383468ioj.3.1694026952009;
        Wed, 06 Sep 2023 12:02:32 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id w11-20020a5d844b000000b0076ffebfc9fasm5152306ior.47.2023.09.06.12.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:02:31 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        David Airlie <airlied@gmail.com>
Subject: [PATCH v3 2/5] drm/kmb: add trailing newlines to drm_dbg msgs
Date:   Wed,  6 Sep 2023 13:02:20 -0600
Message-ID: <20230906190224.583577-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906190224.583577-1-jim.cromie@gmail.com>
References: <20230906190224.583577-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By at least strong convention, a print-buffer's trailing newline says
"message complete, send it".  The exception (no TNL, followed by a call
to pr_cont) proves the general rule.

Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
1288 drm_dbg.  Clean up the remainders, in maintainer sized chunks.

No functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/kmb/kmb_crtc.c  | 10 +++++-----
 drivers/gpu/drm/kmb/kmb_plane.c |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_crtc.c b/drivers/gpu/drm/kmb/kmb_crtc.c
index 647872f65bff..a58baf25322d 100644
--- a/drivers/gpu/drm/kmb/kmb_crtc.c
+++ b/drivers/gpu/drm/kmb/kmb_crtc.c
@@ -94,7 +94,7 @@ static void kmb_crtc_set_mode(struct drm_crtc *crtc,
 	vm.hback_porch = 0;
 	vm.hsync_len = 28;
 
-	drm_dbg(dev, "%s : %dactive height= %d vbp=%d vfp=%d vsync-w=%d h-active=%d h-bp=%d h-fp=%d hsync-l=%d",
+	drm_dbg(dev, "%s : %dactive height= %d vbp=%d vfp=%d vsync-w=%d h-active=%d h-bp=%d h-fp=%d hsync-l=%d\n",
 		__func__, __LINE__,
 			m->crtc_vdisplay, vm.vback_porch, vm.vfront_porch,
 			vm.vsync_len, m->crtc_hdisplay, vm.hback_porch,
@@ -194,24 +194,24 @@ static enum drm_mode_status
 	int vfp = mode->vsync_start - mode->vdisplay;
 
 	if (mode->vdisplay < KMB_CRTC_MAX_HEIGHT) {
-		drm_dbg(dev, "height = %d less than %d",
+		drm_dbg(dev, "height = %d less than %d\n",
 			mode->vdisplay, KMB_CRTC_MAX_HEIGHT);
 		return MODE_BAD_VVALUE;
 	}
 	if (mode->hdisplay < KMB_CRTC_MAX_WIDTH) {
-		drm_dbg(dev, "width = %d less than %d",
+		drm_dbg(dev, "width = %d less than %d\n",
 			mode->hdisplay, KMB_CRTC_MAX_WIDTH);
 		return MODE_BAD_HVALUE;
 	}
 	refresh = drm_mode_vrefresh(mode);
 	if (refresh < KMB_MIN_VREFRESH || refresh > KMB_MAX_VREFRESH) {
-		drm_dbg(dev, "refresh = %d less than %d or greater than %d",
+		drm_dbg(dev, "refresh = %d less than %d or greater than %d\n",
 			refresh, KMB_MIN_VREFRESH, KMB_MAX_VREFRESH);
 		return MODE_BAD;
 	}
 
 	if (vfp < KMB_CRTC_MIN_VFP) {
-		drm_dbg(dev, "vfp = %d less than %d", vfp, KMB_CRTC_MIN_VFP);
+		drm_dbg(dev, "vfp = %d less than %d\n", vfp, KMB_CRTC_MIN_VFP);
 		return MODE_BAD;
 	}
 
diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plane.c
index 9e0562aa2bcb..308bd1cb50c8 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.c
+++ b/drivers/gpu/drm/kmb/kmb_plane.c
@@ -78,7 +78,7 @@ static unsigned int check_pixel_format(struct drm_plane *plane, u32 format)
 	 * plane configuration is not supported.
 	 */
 	if (init_disp_cfg.format && init_disp_cfg.format != format) {
-		drm_dbg(&kmb->drm, "Cannot change format after initial plane configuration");
+		drm_dbg(&kmb->drm, "Cannot change format after initial plane configuration\n");
 		return -EINVAL;
 	}
 	for (i = 0; i < plane->format_count; i++) {
@@ -124,7 +124,7 @@ static int kmb_plane_atomic_check(struct drm_plane *plane,
 	if ((init_disp_cfg.width && init_disp_cfg.height) &&
 	    (init_disp_cfg.width != fb->width ||
 	    init_disp_cfg.height != fb->height)) {
-		drm_dbg(&kmb->drm, "Cannot change plane height or width after initial configuration");
+		drm_dbg(&kmb->drm, "Cannot change plane height or width after initial configuration\n");
 		return -EINVAL;
 	}
 	can_position = (plane->type == DRM_PLANE_TYPE_OVERLAY);
@@ -375,7 +375,7 @@ static void kmb_plane_atomic_update(struct drm_plane *plane,
 	spin_lock_irq(&kmb->irq_lock);
 	if (kmb->kmb_under_flow || kmb->kmb_flush_done) {
 		spin_unlock_irq(&kmb->irq_lock);
-		drm_dbg(&kmb->drm, "plane_update:underflow!!!! returning");
+		drm_dbg(&kmb->drm, "plane_update:underflow!!!! returning\n");
 		return;
 	}
 	spin_unlock_irq(&kmb->irq_lock);
-- 
2.41.0

