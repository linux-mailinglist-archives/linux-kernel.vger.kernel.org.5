Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8575BF5F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjGUHLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGUHLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DDA2D76
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689923422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0oYK01gd9R8CyJOn/uNECjwAoUc3vytnk5FF8VVpYFg=;
        b=jVXyCiwqNBPb16GJghsnRtlyq6kbX1iaoAwsWHH/DgWA2v79N8yv742S9FQR1QK+23F7xG
        8pyN6LtC/0P9E1pMcy3tr/PJmCVUGbtIcQ7hzJR9GbH4pNPgnEu/hfXJXTE4pnC8v07sJl
        jPiOUl9wZRhBwm8OH8xXDjLPq0FCEzw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-t6uPy0kZNrqoljME9-yrXw-1; Fri, 21 Jul 2023 03:10:21 -0400
X-MC-Unique: t6uPy0kZNrqoljME9-yrXw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fab61bb53bso1553373e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689923419; x=1690528219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oYK01gd9R8CyJOn/uNECjwAoUc3vytnk5FF8VVpYFg=;
        b=SQ/krsnTg0fwxgKrBVo8JTHxeOSGYgrqDxNKoSO4U35A8yIBKPUL+nr+tUN8cKUsx5
         NHQT6SIFingYYsJwS1epkXuWI/tDftfvLTbldO7RIBudfqXqlUliM77MzVXqgxoz4piH
         DrMkrk4x5QssIdVGkvF3IlQzjX6ASGsUWWxCT9UGc9V5yLnOL1N6XGs0MqlMdyzKt77f
         V+w3R0jU3eL58wHXpL8gtBCqv93lgBMS2U2d9Ce5HwmAFqP54a5ZLqFrHPBMceTEugT1
         sYuN2BChHsOuVno3DNdcwtEo9NnNqTTNM8kBbdmMVsvSnre8XefkJD4Zq8yFdZqIWUE/
         GBDA==
X-Gm-Message-State: ABy/qLYFtr8x5DV3oTyZG1eLLuwcJY+0r3wd23oPU83TX+eek84ZoEHB
        GQFZ0Dpag8HJlIm9dDJJJNS39Chvjsqb/ZR6/PRUdCU2QnvCyN/uxqw5O7724vJoehjW999SDId
        eY0QDZJwns0BdKcjDFP1008Lm9sPhazyUMvaB1comWCJaX8ie9JN2BbU1CyihQwJtwSxLLbK4YM
        9pN8S1hD4=
X-Received: by 2002:ac2:4dbb:0:b0:4fb:772a:af12 with SMTP id h27-20020ac24dbb000000b004fb772aaf12mr575233lfe.21.1689923419040;
        Fri, 21 Jul 2023 00:10:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHnL3EFs2AmBRnj+FxSdKUhCAxPChlZGPbqrW7fMpr1gkb+bY+ZyqTEzoPsfjHWmJydfQtwzQ==
X-Received: by 2002:ac2:4dbb:0:b0:4fb:772a:af12 with SMTP id h27-20020ac24dbb000000b004fb772aaf12mr575204lfe.21.1689923418510;
        Fri, 21 Jul 2023 00:10:18 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fbb1a9586esm5593956wmj.15.2023.07.21.00.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:10:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4] drm/ssd130x: Allocate buffers in the plane's .atomic_check callback
Date:   Fri, 21 Jul 2023 09:09:50 +0200
Message-ID: <20230721070955.1170974-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert reports that the following NULL pointer dereference happens for him
after commit 49d7d581ceaf ("drm/ssd130x: Don't allocate buffers on each
plane update"):

    [drm] Initialized ssd130x 1.0.0 20220131 for 0-003c on minor 0
    ssd130x-i2c 0-003c: [drm] surface width(128), height(32), bpp(1)
    and format(R1   little-endian (0x20203152))
    Unable to handle kernel NULL pointer dereference at virtual address 00000000
    Oops [#1]
    CPU: 0 PID: 1 Comm: swapper Not tainted
    6.5.0-rc1-orangecrab-02219-g0a529a1e4bf4 #565
    epc : ssd130x_update_rect.isra.0+0x13c/0x340
     ra : ssd130x_update_rect.isra.0+0x2bc/0x340
    ...
    status: 00000120 badaddr: 00000000 cause: 0000000f
    [<c0303d90>] ssd130x_update_rect.isra.0+0x13c/0x340
    [<c0304200>] ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
    [<c02f8d54>] drm_atomic_helper_commit_planes+0xfc/0x27c
    [<c02f9314>] drm_atomic_helper_commit_tail+0x5c/0xb4
    [<c02f94fc>] commit_tail+0x190/0x1b8
    [<c02f99fc>] drm_atomic_helper_commit+0x194/0x1c0
    [<c02c5d00>] drm_atomic_commit+0xa4/0xe4
    [<c02cce40>] drm_client_modeset_commit_atomic+0x244/0x278
    [<c02ccef0>] drm_client_modeset_commit_locked+0x7c/0x1bc
    [<c02cd064>] drm_client_modeset_commit+0x34/0x64
    [<c0301a78>] __drm_fb_helper_restore_fbdev_mode_unlocked+0xc4/0xe8
    [<c0303424>] drm_fb_helper_set_par+0x38/0x58
    [<c027c410>] fbcon_init+0x294/0x534
    ...

The problem is that fbcon calls fbcon_init() which triggers a DRM modeset
and this leads to drm_atomic_helper_commit_planes() attempting to commit
the atomic state for all planes, even the ones whose CRTC is not enabled.

Since the primary plane buffer is allocated in the encoder .atomic_enable
callback, this happens after that initial modeset commit and leads to the
mentioned NULL pointer dereference.

Fix this by having custom helpers to allocate, duplicate and destroy the
plane state, that will take care of allocating and freeing these buffers.

Instead of doing it in the encoder atomic enabled and disabled callbacks,
since allocations must not be done in an .atomic_enable handler. Because
drivers are not allowed to fail after drm_atomic_helper_swap_state() has
been called and the new atomic state is stored into the current sw state.

Fixes: 49d7d581ceaf ("drm/ssd130x: Don't allocate buffers on each plane update")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v4:
- Move buffers allocation/free to plane .reset/.destroy helpers (Maxime Ripard).

Changes in v3:
- Move the buffers allocation to the plane helper funcs .begin_fb_access
  and the free to .end_fb_access callbacks.
- Always allocate intermediate buffer because is use in ssd130x_clear_screen().
- Don't allocate the buffers as device managed resources.

Changes in v2:
- Move the buffers allocation to .fb_create instead of preventing atomic
  updates for disable planes.
- Don't allocate the intermediate buffer when using the native R1 format.
- Allocate buffers as device managed resources.

 drivers/gpu/drm/solomon/ssd130x.c | 134 ++++++++++++++++++++++++------
 drivers/gpu/drm/solomon/ssd130x.h |   3 -
 2 files changed, 108 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index afb08a8aa9fc..21b2afe40b13 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -141,12 +141,26 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 };
 EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
 
+struct ssd130x_plane_state {
+	struct drm_plane_state base;
+	/* Intermediate buffer to convert pixels from XRGB8888 to R1 */
+	u8 *buffer;
+	/* Buffer that contains R1 pixels to be written to the panel */
+	u8 *data_array;
+};
+
+static inline struct ssd130x_plane_state *to_ssd130x_plane_state(struct drm_plane_state *state)
+{
+	return container_of(state, struct ssd130x_plane_state, base);
+}
+
 static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
 {
 	return container_of(drm, struct ssd130x_device, drm);
 }
 
-static int ssd130x_buf_alloc(struct ssd130x_device *ssd130x)
+static int ssd130x_buf_alloc(struct ssd130x_device *ssd130x,
+			     struct ssd130x_plane_state *ssd130x_state)
 {
 	unsigned int page_height = ssd130x->device_info->page_height;
 	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
@@ -159,23 +173,23 @@ static int ssd130x_buf_alloc(struct ssd130x_device *ssd130x)
 
 	pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
 
-	ssd130x->buffer = kcalloc(pitch, ssd130x->height, GFP_KERNEL);
-	if (!ssd130x->buffer)
+	ssd130x_state->buffer = kcalloc(pitch, ssd130x->height, GFP_KERNEL);
+	if (!ssd130x_state->buffer)
 		return -ENOMEM;
 
-	ssd130x->data_array = kcalloc(ssd130x->width, pages, GFP_KERNEL);
-	if (!ssd130x->data_array) {
-		kfree(ssd130x->buffer);
+	ssd130x_state->data_array = kcalloc(ssd130x->width, pages, GFP_KERNEL);
+	if (!ssd130x_state->data_array) {
+		kfree(ssd130x_state->buffer);
 		return -ENOMEM;
 	}
 
 	return 0;
 }
 
-static void ssd130x_buf_free(struct ssd130x_device *ssd130x)
+static void ssd130x_buf_free(struct ssd130x_plane_state *ssd130x_state)
 {
-	kfree(ssd130x->data_array);
-	kfree(ssd130x->buffer);
+	kfree(ssd130x_state->data_array);
+	kfree(ssd130x_state->buffer);
 }
 
 /*
@@ -466,12 +480,14 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
 				 SSD130X_SET_ADDRESS_MODE_HORIZONTAL);
 }
 
-static int ssd130x_update_rect(struct ssd130x_device *ssd130x, struct drm_rect *rect)
+static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
+			       struct ssd130x_plane_state *ssd130x_state,
+			       struct drm_rect *rect)
 {
 	unsigned int x = rect->x1;
 	unsigned int y = rect->y1;
-	u8 *buf = ssd130x->buffer;
-	u8 *data_array = ssd130x->data_array;
+	u8 *buf = ssd130x_state->buffer;
+	u8 *data_array = ssd130x_state->data_array;
 	unsigned int width = drm_rect_width(rect);
 	unsigned int height = drm_rect_height(rect);
 	unsigned int line_length = DIV_ROUND_UP(width, 8);
@@ -567,7 +583,8 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x, struct drm_rect *
 	return ret;
 }
 
-static void ssd130x_clear_screen(struct ssd130x_device *ssd130x)
+static void ssd130x_clear_screen(struct ssd130x_device *ssd130x,
+				 struct ssd130x_plane_state *ssd130x_state)
 {
 	struct drm_rect fullscreen = {
 		.x1 = 0,
@@ -576,18 +593,21 @@ static void ssd130x_clear_screen(struct ssd130x_device *ssd130x)
 		.y2 = ssd130x->height,
 	};
 
-	ssd130x_update_rect(ssd130x, &fullscreen);
+	ssd130x_update_rect(ssd130x, ssd130x_state, &fullscreen);
 }
 
-static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_map *vmap,
+static int ssd130x_fb_blit_rect(struct drm_plane_state *state,
+				const struct iosys_map *vmap,
 				struct drm_rect *rect)
 {
+	struct drm_framebuffer *fb = state->fb;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
+	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(state);
 	unsigned int page_height = ssd130x->device_info->page_height;
 	struct iosys_map dst;
 	unsigned int dst_pitch;
 	int ret = 0;
-	u8 *buf = ssd130x->buffer;
+	u8 *buf = ssd130x_state->buffer;
 
 	if (!buf)
 		return 0;
@@ -607,11 +627,27 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_m
 
 	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
 
-	ssd130x_update_rect(ssd130x, rect);
+	ssd130x_update_rect(ssd130x, ssd130x_state, rect);
 
 	return ret;
 }
 
+static int ssd130x_primary_plane_helper_atomic_check(struct drm_plane *plane,
+						     struct drm_atomic_state *state)
+{
+	struct drm_device *drm = plane->dev;
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(plane_state);
+	int ret;
+
+	ret = drm_plane_helper_atomic_check(plane, state);
+	if (ret)
+		return ret;
+
+	return ssd130x_buf_alloc(ssd130x, ssd130x_state);
+}
+
 static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
 						       struct drm_atomic_state *state)
 {
@@ -634,7 +670,7 @@ static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
 		if (!drm_rect_intersect(&dst_clip, &damage))
 			continue;
 
-		ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &dst_clip);
+		ssd130x_fb_blit_rect(plane_state, &shadow_plane_state->data[0], &dst_clip);
 	}
 
 	drm_dev_exit(idx);
@@ -645,19 +681,68 @@ static void ssd130x_primary_plane_helper_atomic_disable(struct drm_plane *plane,
 {
 	struct drm_device *drm = plane->dev;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
+	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(plane->state);
 	int idx;
 
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
-	ssd130x_clear_screen(ssd130x);
+	ssd130x_clear_screen(ssd130x, ssd130x_state);
 
 	drm_dev_exit(idx);
 }
 
+/* Called during init to allocate the plane's atomic state. */
+static void ssd130x_primary_plane_reset(struct drm_plane *plane)
+{
+	struct ssd130x_plane_state *ssd130x_state;
+
+	WARN_ON(plane->state);
+
+	ssd130x_state = kzalloc(sizeof(*ssd130x_state), GFP_KERNEL);
+	if (!ssd130x_state)
+		return;
+
+	__drm_atomic_helper_plane_reset(plane, &ssd130x_state->base);
+}
+
+static struct drm_plane_state *ssd130x_primary_plane_duplicate_state(struct drm_plane *plane)
+{
+	struct ssd130x_plane_state *old_ssd130x_state;
+	struct ssd130x_plane_state *ssd130x_state;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+
+	old_ssd130x_state = to_ssd130x_plane_state(plane->state);
+	ssd130x_state = kmemdup(old_ssd130x_state, sizeof(*ssd130x_state), GFP_KERNEL);
+	if (!ssd130x_state)
+		return NULL;
+
+	/* The buffers are not duplicated and are allocated in .atomic_check */
+	ssd130x_state->buffer = NULL;
+	ssd130x_state->data_array = NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &ssd130x_state->base);
+
+	return &ssd130x_state->base;
+}
+
+static void ssd130x_primary_plane_destroy_state(struct drm_plane *plane,
+						struct drm_plane_state *state)
+{
+	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(state);
+
+	ssd130x_buf_free(ssd130x_state);
+
+	__drm_atomic_helper_plane_destroy_state(&ssd130x_state->base);
+
+	kfree(ssd130x_state);
+}
+
 static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs = {
 	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
-	.atomic_check = drm_plane_helper_atomic_check,
+	.atomic_check = ssd130x_primary_plane_helper_atomic_check,
 	.atomic_update = ssd130x_primary_plane_helper_atomic_update,
 	.atomic_disable = ssd130x_primary_plane_helper_atomic_disable,
 };
@@ -665,6 +750,9 @@ static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs =
 static const struct drm_plane_funcs ssd130x_primary_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
+	.reset = ssd130x_primary_plane_reset,
+	.atomic_duplicate_state = ssd130x_primary_plane_duplicate_state,
+	.atomic_destroy_state = ssd130x_primary_plane_destroy_state,
 	.destroy = drm_plane_cleanup,
 	DRM_GEM_SHADOW_PLANE_FUNCS,
 };
@@ -719,10 +807,6 @@ static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		goto power_off;
 
-	ret = ssd130x_buf_alloc(ssd130x);
-	if (ret)
-		goto power_off;
-
 	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_ON);
 
 	backlight_enable(ssd130x->bl_dev);
@@ -744,8 +828,6 @@ static void ssd130x_encoder_helper_atomic_disable(struct drm_encoder *encoder,
 
 	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_OFF);
 
-	ssd130x_buf_free(ssd130x);
-
 	ssd130x_power_off(ssd130x);
 }
 
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index 161588b1cc4d..87968b3e7fb8 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -89,9 +89,6 @@ struct ssd130x_device {
 	u8 col_end;
 	u8 page_start;
 	u8 page_end;
-
-	u8 *buffer;
-	u8 *data_array;
 };
 
 extern const struct ssd130x_deviceinfo ssd130x_variants[];
-- 
2.41.0

