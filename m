Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2C178D35B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 08:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbjH3G1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 02:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjH3G0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5EBE9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693376754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Bck91h4ecr3Co3tJzlcq1wsKaOVtegEctcyU5tCF8E=;
        b=Na8yfC6CSDLQ0Eb/Ksv/6lXAjSizNXdLzbrzLszTSX6TRYxTquIIpOoddyMk3yubK2wq4V
        Jvrh2QzoB1hsUyBZqN7zViOjwbJmTnc4uAKgxcI9yKlvWp2K/mNrdJX1wPehtBMfBBOviy
        W+6f42cvOtCO+WN2Pw8yqV/oeVhTCo0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-v6fW-8mBNBmeAYc3Y8-mxQ-1; Wed, 30 Aug 2023 02:25:52 -0400
X-MC-Unique: v6fW-8mBNBmeAYc3Y8-mxQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31adc3ca07aso3154478f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693376751; x=1693981551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Bck91h4ecr3Co3tJzlcq1wsKaOVtegEctcyU5tCF8E=;
        b=b9IXRMEMotYSOESmM4h0ewmAPCU1WB9KCy0XTxAdEv/+vAeiG0UFSXp2tsJx95KbOB
         seZbKxh304PcOu8JOrWOZRoBPB171rgwywTBlIgRT0Tg/H9emnDmxGEOT9hnu1fFH6Ft
         jChMqK7k22v6GlLzLIRkwbUulW9ILZfz4RdzxlsP57av+5pR2cVgvxKEYbzpqfziua1K
         3gkYE6FdMSSQ/Vc08tqGIW6oEDVHKoWrJM55uolmMKLJ7u895dEDBqm0y3hK/rr70PG4
         tlp4204yfoQah4G+IXJjQPNs3VEGvVrMfdXwhAhnyoF0jZ3IU+O85cFuAN1ls0DVpEZ7
         SVsg==
X-Gm-Message-State: AOJu0Yyxu7i8AvU01fY3shjWjNHD+4iY2obwqxZT7/aQ1YXa0OF55IlD
        JCUrrjS+VWdGy4uc+7cAcPiCwjakQ1eXtIDdJlY3cDJjhRXyGkI6EcIuRiDPkMO4gJje75v7p5m
        u8dQB+1QPM7Usxo8lNqxBU8Ru7KorGwYbIyEZHkU+Ld2oDFjrOdi5gJ87LL8Q3D5JzzUlzf9DtQ
        wcKNuFFy0=
X-Received: by 2002:a5d:4c47:0:b0:31d:cf59:8de with SMTP id n7-20020a5d4c47000000b0031dcf5908demr877100wrt.19.1693376751220;
        Tue, 29 Aug 2023 23:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGkjHuOu5s6UltQpdDLgmsZ2+vkqG0rncWb93cDUvjACjGuAGSQurlsw0WrKhuai7PTZUJtg==
X-Received: by 2002:a5d:4c47:0:b0:31d:cf59:8de with SMTP id n7-20020a5d4c47000000b0031dcf5908demr877068wrt.19.1693376750276;
        Tue, 29 Aug 2023 23:25:50 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d6510000000b003143c9beeaesm15663899wru.44.2023.08.29.23.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 23:25:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [RFC PATCH] drm/ssd130x: Allocate buffer in the CRTC's .atomic_check() callback
Date:   Wed, 30 Aug 2023 08:25:08 +0200
Message-ID: <20230830062546.720679-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's
.atomic_check() callback") moved the allocation of the intermediate and
HW buffers from the encoder's .atomic_enable callback to primary plane's
.atomic_check callback.

This was suggested by Maxime Ripard because drivers aren't allowed to fail
after drm_atomic_helper_swap_state() has been called, and the encoder's
.atomic_enable happens after the new atomic state has been swapped.

But that change caused a performance regression in very slow platforms,
since now the allocation happens for every plane's atomic state commit.
For example, Geert Uytterhoeven reports that is the case on a VexRiscV
softcore (RISC-V CPU implementation on an FPGA).

To prevent that, move the move the buffers' allocation and free to the
CRTC's .atomic_check and .atomic_destroy_state callbacks, so that only
happens on a modeset. Since the intermediate buffer is only needed when
not using the controller native format (R1), doing the buffer allocation
at that CRTC's .atomic_check time would be enough.

Fixes: 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's .atomic_check() callback")
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
Hello,

This is a RFC because I'm not sure if there is a net benefit after this
change. I find the currect code much cleaner and less error prone, even
when Geert reports that performs worse on his (very slow) platform.

But I'm still posting it to see what others think. I've tested the patch
on an I2C ssd1306 OLED and found no regressions.

The patch is on top on Geert's latest patch-set that adds support for the
DRM_FORMAT_R1 to the ssd130x driver:

https://lore.kernel.org/dri-devel/cover.1692888745.git.geert@linux-m68k.org

Best regards,
Javier

 drivers/gpu/drm/solomon/ssd130x.c | 106 ++++++++++++++++--------------
 1 file changed, 56 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 0d2b36ba4011..60536cd0c42d 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -650,46 +650,6 @@ static int ssd130x_fb_blit_rect(struct drm_plane_state *state,
 	return ret;
 }
 
-static int ssd130x_primary_plane_helper_atomic_check(struct drm_plane *plane,
-						     struct drm_atomic_state *state)
-{
-	struct drm_device *drm = plane->dev;
-	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
-	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
-	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(plane_state);
-	unsigned int page_height = ssd130x->device_info->page_height;
-	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
-	const struct drm_format_info *fi;
-	unsigned int pitch;
-	int ret;
-
-	ret = drm_plane_helper_atomic_check(plane, state);
-	if (ret)
-		return ret;
-
-	ssd130x_state->data_array = kcalloc(ssd130x->width, pages, GFP_KERNEL);
-	if (!ssd130x_state->data_array)
-		return -ENOMEM;
-
-	if (plane_state->fb->format->format != DRM_FORMAT_R1) {
-		fi = drm_format_info(DRM_FORMAT_R1);
-		if (!fi)
-			return -EINVAL;
-
-		pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
-
-		ssd130x_state->buffer = kcalloc(pitch, ssd130x->height, GFP_KERNEL);
-		if (!ssd130x_state->buffer) {
-			kfree(ssd130x_state->data_array);
-			/* Set to prevent a double free in .atomic_destroy_state() */
-			ssd130x_state->data_array = NULL;
-			return -ENOMEM;
-		}
-	}
-
-	return 0;
-}
-
 static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
 						       struct drm_atomic_state *state)
 {
@@ -762,10 +722,6 @@ static struct drm_plane_state *ssd130x_primary_plane_duplicate_state(struct drm_
 	if (!ssd130x_state)
 		return NULL;
 
-	/* The buffers are not duplicated and are allocated in .atomic_check */
-	ssd130x_state->buffer = NULL;
-	ssd130x_state->data_array = NULL;
-
 	new_shadow_plane_state = &ssd130x_state->base;
 
 	__drm_gem_duplicate_shadow_plane_state(plane, new_shadow_plane_state);
@@ -778,9 +734,6 @@ static void ssd130x_primary_plane_destroy_state(struct drm_plane *plane,
 {
 	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(state);
 
-	kfree(ssd130x_state->data_array);
-	kfree(ssd130x_state->buffer);
-
 	__drm_gem_destroy_shadow_plane_state(&ssd130x_state->base);
 
 	kfree(ssd130x_state);
@@ -788,7 +741,7 @@ static void ssd130x_primary_plane_destroy_state(struct drm_plane *plane,
 
 static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs = {
 	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
-	.atomic_check = ssd130x_primary_plane_helper_atomic_check,
+	.atomic_check = drm_plane_helper_atomic_check,
 	.atomic_update = ssd130x_primary_plane_helper_atomic_update,
 	.atomic_disable = ssd130x_primary_plane_helper_atomic_disable,
 };
@@ -818,6 +771,59 @@ static enum drm_mode_status ssd130x_crtc_helper_mode_valid(struct drm_crtc *crtc
 	return MODE_OK;
 }
 
+int ssd130x_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
+{
+	struct drm_device *drm = crtc->dev;
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
+	struct drm_plane *plane = crtc->primary;
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(plane_state);
+	unsigned int page_height = ssd130x->device_info->page_height;
+	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
+	const struct drm_format_info *fi;
+	unsigned int pitch;
+	int ret;
+
+	ret = drm_crtc_helper_atomic_check(crtc, state);
+	if (ret)
+		return ret;
+
+	ssd130x_state->data_array = kcalloc(ssd130x->width, pages, GFP_KERNEL);
+	if (!ssd130x_state->data_array)
+		return -ENOMEM;
+
+	if (plane_state->fb->format->format != DRM_FORMAT_R1) {
+		fi = drm_format_info(DRM_FORMAT_R1);
+		if (!fi)
+			return -EINVAL;
+
+		pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
+
+		ssd130x_state->buffer = kcalloc(pitch, ssd130x->height, GFP_KERNEL);
+		if (!ssd130x_state->buffer) {
+			kfree(ssd130x_state->data_array);
+			/* Set to prevent a double free in .atomic_destroy_state() */
+			ssd130x_state->data_array = NULL;
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static void ssd130x_crtc_destroy_state(struct drm_crtc *crtc,
+				       struct drm_crtc_state *state)
+{
+	struct drm_plane *plane = crtc->primary;
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state->state, plane);
+	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(plane_state);
+
+	drm_atomic_helper_crtc_destroy_state(crtc, state);
+
+	kfree(ssd130x_state->data_array);
+	kfree(ssd130x_state->buffer);
+}
+
 /*
  * The CRTC is always enabled. Screen updates are performed by
  * the primary plane's atomic_update function. Disabling clears
@@ -825,7 +831,7 @@ static enum drm_mode_status ssd130x_crtc_helper_mode_valid(struct drm_crtc *crtc
  */
 static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs = {
 	.mode_valid = ssd130x_crtc_helper_mode_valid,
-	.atomic_check = drm_crtc_helper_atomic_check,
+	.atomic_check = ssd130x_crtc_helper_atomic_check,
 };
 
 static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
@@ -834,7 +840,7 @@ static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.atomic_destroy_state = ssd130x_crtc_destroy_state,
 };
 
 static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
-- 
2.41.0

