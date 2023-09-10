Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011C1799D8A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346580AbjIJJlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjIJJln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 05:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAB7CD3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694338851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qp4NjvamSjckaZYHYk1qGomwJbnOFQOywWv5ofGJ5yM=;
        b=ImPKlg6+4BCOFgWvhvdVaUOCRiMMMvX72IONI8psvIvhcV602zjyjU70WnN+tn+IqN+z/H
        c5qSele03S+sNkHiVTXz/VaiVBUgQebFHuJ+1iNibHXD/W38Lt70nONgxPidUEMOcGmRXl
        76quERlvVtPhS2+82NVrbHZdmYVixPI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-lM62zjY3OhWbo2Rj622TQA-1; Sun, 10 Sep 2023 05:40:50 -0400
X-MC-Unique: lM62zjY3OhWbo2Rj622TQA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40298cbbcdbso24335265e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 02:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694338849; x=1694943649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qp4NjvamSjckaZYHYk1qGomwJbnOFQOywWv5ofGJ5yM=;
        b=lqrXPsqFZSfsJjd5pdKZ0+Q2WBJGCp4CIB2m8yzhA++VhYXm7MwwQGTcxL/Hm7W7R2
         j0gksOn4/octUP+EXFqajgb4Cm+28VQ88Z9lPLTg+QytsjZzc43wGyRK1iEzBqHmitxS
         HBj0zDIrcgVCzfC6mrHnEeAgCwADVMemoBWaGRYchOx7T1QC8FWNt7khbyoBFPQSgvFK
         0Y5rqAksZfPSfKsgWw9HZZbFyh6Z4w+PTnBWzjM4Jx20dR5FzADVunGUDPFv8UyitRaR
         C8QBBj/FrqGHx/ZMpp4ubxh7JAugYz/+DxV9WQuTpMcDK+QoVtghL6YF1/jeDnI8T7mz
         nU2Q==
X-Gm-Message-State: AOJu0YxCyYka+Im/jlSTZg0JtAu8DT01Ttfcl3HlHNVtom1li0QkpAu1
        SYQzQu/QV7iCO5s098TDLzyKIssyjJcrqniFBmULo6ry37z+LiU/c3TkO1EIDgYKD7nle3Fh2yH
        iGeMKFT9ThACnmacy9PXPHDveypC09uYmdM3OZFTL/pCoo1O40GMjdoDyJ4UmhH+1A4snNaosA+
        iSotmCTjQmYw==
X-Received: by 2002:a1c:4c0d:0:b0:402:906:1e87 with SMTP id z13-20020a1c4c0d000000b0040209061e87mr6357797wmf.31.1694338849188;
        Sun, 10 Sep 2023 02:40:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZtsMpxtQcnddHJe3tqRyJyIAM6KvRdhVqaiSp5IEqdBPcPxlnrE3cw3NEjn6z6VHXBaMWoQ==
X-Received: by 2002:a1c:4c0d:0:b0:402:906:1e87 with SMTP id z13-20020a1c4c0d000000b0040209061e87mr6357777wmf.31.1694338848651;
        Sun, 10 Sep 2023 02:40:48 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x8-20020a05600c21c800b003fed78b03b4sm6721874wmj.20.2023.09.10.02.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 02:40:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/ssd130x: Store the HW buffer in the driver-private CRTC state
Date:   Sun, 10 Sep 2023 11:40:28 +0200
Message-ID: <20230910094041.715408-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's
.atomic_check() callback") moved the allocation of the intermediate and
HW buffers from the encoder's .atomic_enable callback, to the plane's
.atomic_check callback.

This was suggested by Maxime Ripard, because drivers aren't allowed to
fail after the drm_atomic_helper_swap_state() function has been called.

And the encoder's .atomic_enable happens after the new atomic state has
been swapped, so allocations (that can fail) shouldn't be done there.

But the HW buffer isn't really tied to the plane's state. It has a fixed
size that only depends on the (also fixed) display resolution defined in
the Device Tree Blob.

That buffer can be considered part of the CRTC state, and for this reason
makes more sense to do its allocation in the CRTC .atomic_check callback.

The other allocated buffer (used to store a conversion from the emulated
XR24 format to the native R1 format) is part of the plane's state, since
it will be optional once the driver supports R1 and allows user-space to
set that pixel format.

So let's keep the allocation for it in the plane's .atomic_check callback,
this can't be moved to the CRTC's .atomic_check because changing a format
does not trigger a CRTC mode set.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/dri-devel/CAMuHMdWv_QSatDgihr8=2SXHhvp=icNxumZcZOPwT9Q_QiogNQ@mail.gmail.com/
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Drop RFC prefix.
- Fix typo in commit message (Thomas Zimmermann).
- Store the HW buffer in the driver's private CRTC state (Thomas Zimmermann).
- Just use kmalloc() kcalloc() when allocating buffers (Thomas Zimmermann).
- Keep the allocation of the intermediate buffer in the plane's .atomic_check

 drivers/gpu/drm/solomon/ssd130x.c | 143 ++++++++++++++++++++++--------
 1 file changed, 108 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 3b4dde09538a..c866dd40d163 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -141,14 +141,23 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 };
 EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
 
+struct ssd130x_crtc_state {
+	struct drm_crtc_state base;
+	/* Buffer to store pixels in HW format and written to the panel */
+	u8 *data_array;
+};
+
 struct ssd130x_plane_state {
 	struct drm_shadow_plane_state base;
 	/* Intermediate buffer to convert pixels from XRGB8888 to HW format */
 	u8 *buffer;
-	/* Buffer to store pixels in HW format and written to the panel */
-	u8 *data_array;
 };
 
+static inline struct ssd130x_crtc_state *to_ssd130x_crtc_state(struct drm_crtc_state *state)
+{
+	return container_of(state, struct ssd130x_crtc_state, base);
+}
+
 static inline struct ssd130x_plane_state *to_ssd130x_plane_state(struct drm_plane_state *state)
 {
 	return container_of(state, struct ssd130x_plane_state, base.base);
@@ -448,13 +457,11 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
 }
 
 static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
-			       struct ssd130x_plane_state *ssd130x_state,
-			       struct drm_rect *rect)
+			       struct drm_rect *rect, u8 *buf,
+			       u8 *data_array)
 {
 	unsigned int x = rect->x1;
 	unsigned int y = rect->y1;
-	u8 *buf = ssd130x_state->buffer;
-	u8 *data_array = ssd130x_state->data_array;
 	unsigned int width = drm_rect_width(rect);
 	unsigned int height = drm_rect_height(rect);
 	unsigned int line_length = DIV_ROUND_UP(width, 8);
@@ -550,12 +557,10 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
 	return ret;
 }
 
-static void ssd130x_clear_screen(struct ssd130x_device *ssd130x,
-				 struct ssd130x_plane_state *ssd130x_state)
+static void ssd130x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 {
 	unsigned int page_height = ssd130x->device_info->page_height;
 	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
-	u8 *data_array = ssd130x_state->data_array;
 	unsigned int width = ssd130x->width;
 	int ret, i;
 
@@ -594,15 +599,13 @@ static void ssd130x_clear_screen(struct ssd130x_device *ssd130x,
 	}
 }
 
-static int ssd130x_fb_blit_rect(struct drm_plane_state *state,
+static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb,
 				const struct iosys_map *vmap,
-				struct drm_rect *rect)
+				struct drm_rect *rect,
+				u8 *buf, u8 *data_array)
 {
-	struct drm_framebuffer *fb = state->fb;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
 	unsigned int page_height = ssd130x->device_info->page_height;
-	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(state);
-	u8 *buf = ssd130x_state->buffer;
 	struct iosys_map dst;
 	unsigned int dst_pitch;
 	int ret = 0;
@@ -622,7 +625,7 @@ static int ssd130x_fb_blit_rect(struct drm_plane_state *state,
 
 	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
 
-	ssd130x_update_rect(ssd130x, ssd130x_state, rect);
+	ssd130x_update_rect(ssd130x, rect, buf, data_array);
 
 	return ret;
 }
@@ -634,8 +637,6 @@ static int ssd130x_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(plane_state);
-	unsigned int page_height = ssd130x->device_info->page_height;
-	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
 	const struct drm_format_info *fi;
 	unsigned int pitch;
 	int ret;
@@ -654,14 +655,6 @@ static int ssd130x_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	if (!ssd130x_state->buffer)
 		return -ENOMEM;
 
-	ssd130x_state->data_array = kcalloc(ssd130x->width, pages, GFP_KERNEL);
-	if (!ssd130x_state->data_array) {
-		kfree(ssd130x_state->buffer);
-		/* Set to prevent a double free in .atomic_destroy_state() */
-		ssd130x_state->buffer = NULL;
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
@@ -671,6 +664,10 @@ static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
+	struct ssd130x_crtc_state *ssd130x_crtc_state =  to_ssd130x_crtc_state(crtc_state);
+	struct ssd130x_plane_state *ssd130x_plane_state = to_ssd130x_plane_state(plane_state);
+	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_device *drm = plane->dev;
 	struct drm_rect dst_clip;
@@ -687,7 +684,9 @@ static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
 		if (!drm_rect_intersect(&dst_clip, &damage))
 			continue;
 
-		ssd130x_fb_blit_rect(plane_state, &shadow_plane_state->data[0], &dst_clip);
+		ssd130x_fb_blit_rect(fb, &shadow_plane_state->data[0], &dst_clip,
+				     ssd130x_plane_state->buffer,
+				     ssd130x_crtc_state->data_array);
 	}
 
 	drm_dev_exit(idx);
@@ -698,13 +697,21 @@ static void ssd130x_primary_plane_helper_atomic_disable(struct drm_plane *plane,
 {
 	struct drm_device *drm = plane->dev;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
-	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(plane->state);
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc_state *crtc_state;
+	struct ssd130x_crtc_state *ssd130x_crtc_state;
 	int idx;
 
+	if (!plane_state->crtc)
+		return;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
+	ssd130x_crtc_state = to_ssd130x_crtc_state(crtc_state);
+
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
-	ssd130x_clear_screen(ssd130x, ssd130x_state);
+	ssd130x_clear_screen(ssd130x, ssd130x_crtc_state->data_array);
 
 	drm_dev_exit(idx);
 }
@@ -737,9 +744,8 @@ static struct drm_plane_state *ssd130x_primary_plane_duplicate_state(struct drm_
 	if (!ssd130x_state)
 		return NULL;
 
-	/* The buffers are not duplicated and are allocated in .atomic_check */
+	/* The buffer is not duplicated and is allocated in .atomic_check */
 	ssd130x_state->buffer = NULL;
-	ssd130x_state->data_array = NULL;
 
 	new_shadow_plane_state = &ssd130x_state->base;
 
@@ -753,7 +759,6 @@ static void ssd130x_primary_plane_destroy_state(struct drm_plane *plane,
 {
 	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(state);
 
-	kfree(ssd130x_state->data_array);
 	kfree(ssd130x_state->buffer);
 
 	__drm_gem_destroy_shadow_plane_state(&ssd130x_state->base);
@@ -793,6 +798,74 @@ static enum drm_mode_status ssd130x_crtc_helper_mode_valid(struct drm_crtc *crtc
 	return MODE_OK;
 }
 
+int ssd130x_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
+{
+	struct drm_device *drm = crtc->dev;
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	struct ssd130x_crtc_state *ssd130x_state = to_ssd130x_crtc_state(crtc_state);
+	unsigned int page_height = ssd130x->device_info->page_height;
+	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
+	int ret;
+
+	ret = drm_crtc_helper_atomic_check(crtc, state);
+	if (ret)
+		return ret;
+
+	ssd130x_state->data_array = kmalloc(ssd130x->width * pages, GFP_KERNEL);
+	if (!ssd130x_state->data_array)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/* Called during init to allocate the CRTC's atomic state. */
+static void ssd130x_crtc_reset(struct drm_crtc *crtc)
+{
+	struct ssd130x_crtc_state *ssd130x_state;
+
+	WARN_ON(crtc->state);
+
+	ssd130x_state = kzalloc(sizeof(*ssd130x_state), GFP_KERNEL);
+	if (!ssd130x_state)
+		return;
+
+	__drm_atomic_helper_crtc_reset(crtc, &ssd130x_state->base);
+}
+
+static struct drm_crtc_state *ssd130x_crtc_duplicate_state(struct drm_crtc *crtc)
+{
+	struct ssd130x_crtc_state *old_ssd130x_state;
+	struct ssd130x_crtc_state *ssd130x_state;
+
+	if (WARN_ON(!crtc->state))
+		return NULL;
+
+	old_ssd130x_state = to_ssd130x_crtc_state(crtc->state);
+	ssd130x_state = kmemdup(old_ssd130x_state, sizeof(*ssd130x_state), GFP_KERNEL);
+	if (!ssd130x_state)
+		return NULL;
+
+	/* The buffer is not duplicated and is allocated in .atomic_check */
+	ssd130x_state->data_array = NULL;
+
+	__drm_atomic_helper_crtc_duplicate_state(crtc, &ssd130x_state->base);
+
+	return &ssd130x_state->base;
+}
+
+static void ssd130x_crtc_destroy_state(struct drm_crtc *crtc,
+				       struct drm_crtc_state *state)
+{
+	struct ssd130x_crtc_state *ssd130x_state = to_ssd130x_crtc_state(state);
+
+	kfree(ssd130x_state->data_array);
+
+	__drm_atomic_helper_crtc_destroy_state(state);
+
+	kfree(ssd130x_state);
+}
+
 /*
  * The CRTC is always enabled. Screen updates are performed by
  * the primary plane's atomic_update function. Disabling clears
@@ -800,16 +873,16 @@ static enum drm_mode_status ssd130x_crtc_helper_mode_valid(struct drm_crtc *crtc
  */
 static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs = {
 	.mode_valid = ssd130x_crtc_helper_mode_valid,
-	.atomic_check = drm_crtc_helper_atomic_check,
+	.atomic_check = ssd130x_crtc_helper_atomic_check,
 };
 
 static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.reset = ssd130x_crtc_reset,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.atomic_duplicate_state = ssd130x_crtc_duplicate_state,
+	.atomic_destroy_state = ssd130x_crtc_destroy_state,
 };
 
 static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
-- 
2.41.0

