Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0375C790D70
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 20:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbjICSqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 14:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343686AbjICSqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 14:46:19 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC4810C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 11:46:15 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34dec9c77d4so3044325ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693766774; x=1694371574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7joZjSDNylfwIjlN/v1EJKsLNVMUogPTU5+zZ+4Y2sA=;
        b=k3upxpdE+n3eEtG5UDvl1fWBr8ywOcY4pq6/5laEhs50V4wEVXZf6gkcWDJDOE7rXg
         zywgJxOJUPwMJR0KlFA5xPcJqB+z8QYCJutV0QAdHs9Uu8ZjGFDEetrEm/wNms+pz8BN
         ydGRb180fzgOJs1aVx40sHKXQliVREXC3oqyYN8z5uDdJc2VhJJMPLkaRKotamcRvy6k
         JfEZIFPTZCQ4w/h4VURANPWuK5C68u1wmqYNHm9AkbIFwON8Hp7ONhhHpBoiKdo2Z3PP
         XccF5RDpLkBCNPrfWWAWko3HNhQbu13/FtQYYKrRRW/oi7ZtwDX0CMh8OB5sRs+PuOPq
         my4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693766774; x=1694371574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7joZjSDNylfwIjlN/v1EJKsLNVMUogPTU5+zZ+4Y2sA=;
        b=Q3yI9+QFuTAQjAIUmiJg56455KDoMhBUT5WS5KZE8xI6/Q5AmMoHlIN1Ic5SHMEJFX
         54rz/Lhdc5XxatZaOWRcH5uicLrOXPJ6bMnFcrGMvilVH718manY9wgH4AwQxE9gHWMA
         tlxA9bMcvHTWiHdwgMlqo7vztJaZ2fONFHmpbnRQT0Lb+f1L8GtiWaOYQB+epyrJLqxe
         Nc0PMHvsux+lXN+i47IxDFGn51COPYeuH/dHboUxa6f31lyEDdIBiZU4L7Ha+19VEsKF
         PEGXSeQ3MD86gVD4M1mR9j7Fu540MnkzzDI2evMgtGhc0P4rbkg3dEjSwlbsLRdgOkOQ
         MUHw==
X-Gm-Message-State: AOJu0Yw6xXUDvvV+3xAAp5+fDW/ouBddgQNtd5bSi/hmiy8wX3hwZgr9
        eU/SJM7gHdv6YGb/YZ+lczRNad2L+QS0Hg==
X-Google-Smtp-Source: AGHT+IHUzoCTyhxdX6icAGEBT8dXiH/ioOo1c7WiBYkDqk/qvBXBfPW/4NAojWOMT3RGaqLcGBJwug==
X-Received: by 2002:a05:6e02:964:b0:34c:abcb:97e8 with SMTP id q4-20020a056e02096400b0034cabcb97e8mr7956738ilt.24.1693766774237;
        Sun, 03 Sep 2023 11:46:14 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id u9-20020a02cb89000000b0042b37dda71asm2519968jap.136.2023.09.03.11.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 11:46:13 -0700 (PDT)
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
Subject: [PATCH v2 2/6] drm_dbg: add trailing newlines to msgs
Date:   Sun,  3 Sep 2023 12:45:59 -0600
Message-ID: <20230903184607.272198-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230903184607.272198-1-jim.cromie@gmail.com>
References: <20230903184607.272198-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

