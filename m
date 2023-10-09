Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987B57BE9AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378140AbjJIShE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378105AbjJISg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF0D9C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696876573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKWds3HtLR10dcr4aoo+utAQtVVVNzCAHahFeeRCifI=;
        b=hZJuMJvYWhi0U1FpsYflLyF+qa2NFYozmRrYX5HvkjK/u7SrSG21vprpYTXvBEK1KV31xY
        KHd2chJxXoxRZ70CsGzrccBXUOYlVmRn9i7ri9GokVdtnROY2W74J014os04JvRbDi6IK4
        ntNRv4MPzr/2hBEIsQ0JOJ1sF1jrGC0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-JC4QikPOMDCWCexyzZj2Lw-1; Mon, 09 Oct 2023 14:36:07 -0400
X-MC-Unique: JC4QikPOMDCWCexyzZj2Lw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3231f43fc5eso3397863f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876566; x=1697481366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKWds3HtLR10dcr4aoo+utAQtVVVNzCAHahFeeRCifI=;
        b=QlkSG4mxFyqpIg/ep99ZB//XchapYTHaZxbAwFcxCkwVPhF+daNo2tx3vuZ3B3v5zy
         W1lSSmT5I/SDimA/pnKNr/tjN6M7tTCXg28mJmEgGjLQGfkNxmqxmeIv38bbHP9Eiybs
         EPe6oi199+zvYoTSZIVs8UT/Gx9q9hmuPPrRVCVxWpIREWcB4J8UmiCH7N4TZP7GFTxH
         cBThMaOzVaxZI85QpigMWsY7Dtz60j75zSKk3qcQvsh9u6XAEM4Cr9YEOL0qpD/Od+1d
         LFA72hjM+6CMFQc3NQptsumRw6CAt6Q30eUW16GZWu3ziBOz7lKxg3hNee4bZqWES+6c
         +YhA==
X-Gm-Message-State: AOJu0Yy/9Xig9U/9Is0CI0ApjrLELSiLKVgElpCP4e3si3u/Yr40YdEb
        2tDlSTM1IDkbgummnJP/lckgvL7MciE108GSDwI8IK67C9tLMQpfC24mkaocrCz9hk6W2jjaZYU
        fy3RqJ/q1gMcfL9tPzhYAoOaItQJOTXrSlaCq+606VkRt9wIp9ksfUazFdBVa2HcryIoJ0a6gZy
        90zqAJNT4=
X-Received: by 2002:adf:ea8f:0:b0:317:6175:95fd with SMTP id s15-20020adfea8f000000b00317617595fdmr14990538wrm.43.1696876565726;
        Mon, 09 Oct 2023 11:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB61EIlQsYZ6j7/oURYZv5G2X0Vw8t58q6yedzHXwLbHyWJagJU9xZ1E61AxSRQC6PdxFq1w==
X-Received: by 2002:adf:ea8f:0:b0:317:6175:95fd with SMTP id s15-20020adfea8f000000b00317617595fdmr14990522wrm.43.1696876565360;
        Mon, 09 Oct 2023 11:36:05 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fc02e8ea68sm14008591wmd.13.2023.10.09.11.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:36:05 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 5/8] drm/ssd13xx: Add a per controller family functions table
Date:   Mon,  9 Oct 2023 20:34:19 +0200
Message-ID: <20231009183522.543918-6-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009183522.543918-1-javierm@redhat.com>
References: <20231009183522.543918-1-javierm@redhat.com>
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

To allow the driver to decouple the common logic in the function callbacks
from the behaviour that is specific of a given Solomon controller family.

For this, include a chip family to the device info and add fields to the
driver-private device struct, to store the hardware buffer maximum size,
the intermediate buffer maximum size and pixel format, and a set of per
chip family function handlers.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd13xx.c | 88 ++++++++++++++++++++++---------
 drivers/gpu/drm/solomon/ssd13xx.h | 27 ++++++++++
 2 files changed, 90 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd13xx.c b/drivers/gpu/drm/solomon/ssd13xx.c
index 9747f8656636..5a426ac10c58 100644
--- a/drivers/gpu/drm/solomon/ssd13xx.c
+++ b/drivers/gpu/drm/solomon/ssd13xx.c
@@ -104,6 +104,7 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
 		.default_width = 132,
 		.default_height = 64,
 		.page_mode_only = 1,
+		.family_id = SSD130X_FAMILY,
 	},
 	[SSD1305_ID] = {
 		.default_vcomh = 0x34,
@@ -111,6 +112,7 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
 		.default_dclk_frq = 7,
 		.default_width = 132,
 		.default_height = 64,
+		.family_id = SSD130X_FAMILY,
 	},
 	[SSD1306_ID] = {
 		.default_vcomh = 0x20,
@@ -119,6 +121,7 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
 		.need_chargepump = 1,
 		.default_width = 128,
 		.default_height = 64,
+		.family_id = SSD130X_FAMILY,
 	},
 	[SSD1307_ID] = {
 		.default_vcomh = 0x20,
@@ -127,6 +130,7 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
 		.need_pwm = 1,
 		.default_width = 128,
 		.default_height = 39,
+		.family_id = SSD130X_FAMILY,
 	},
 	[SSD1309_ID] = {
 		.default_vcomh = 0x34,
@@ -134,6 +138,7 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
 		.default_dclk_frq = 10,
 		.default_width = 128,
 		.default_height = 64,
+		.family_id = SSD130X_FAMILY,
 	}
 };
 EXPORT_SYMBOL_NS_GPL(ssd13xx_variants, DRM_SSD13XX);
@@ -148,8 +153,6 @@ struct ssd13xx_plane_state {
 	struct drm_shadow_plane_state base;
 	/* Intermediate buffer to convert pixels from XRGB8888 to HW format */
 	u8 *buffer;
-	/* Pixel format info for the intermediate buffer */
-	const struct drm_format_info *fi;
 };
 
 static inline struct ssd13xx_crtc_state *to_ssd13xx_crtc_state(struct drm_crtc_state *state)
@@ -331,7 +334,7 @@ static void ssd13xx_power_off(struct ssd13xx_device *ssd13xx)
 	regulator_disable(ssd13xx->vcc_reg);
 }
 
-static int ssd13xx_init(struct ssd13xx_device *ssd13xx)
+static int ssd130x_init(struct ssd13xx_device *ssd13xx)
 {
 	u32 precharge, dclk, com_invdir, compins, chargepump, seg_remap;
 	bool scan_mode;
@@ -455,7 +458,7 @@ static int ssd13xx_init(struct ssd13xx_device *ssd13xx)
 				 SSD130X_SET_ADDRESS_MODE_HORIZONTAL);
 }
 
-static int ssd13xx_update_rect(struct ssd13xx_device *ssd13xx,
+static int ssd130x_update_rect(struct ssd13xx_device *ssd13xx,
 			       struct drm_rect *rect, u8 *buf,
 			       u8 *data_array)
 {
@@ -561,7 +564,7 @@ static int ssd13xx_update_rect(struct ssd13xx_device *ssd13xx,
 	return ret;
 }
 
-static void ssd13xx_clear_screen(struct ssd13xx_device *ssd13xx, u8 *data_array)
+static void ssd130x_clear_screen(struct ssd13xx_device *ssd13xx, u8 *data_array)
 {
 	unsigned int pages = DIV_ROUND_UP(ssd13xx->height, SSD130X_PAGE_HEIGHT);
 	unsigned int width = ssd13xx->width;
@@ -602,6 +605,15 @@ static void ssd13xx_clear_screen(struct ssd13xx_device *ssd13xx, u8 *data_array)
 	}
 }
 
+static const struct ssd13xx_funcs ssd13xx_family_funcs[] = {
+	[SSD130X_FAMILY] = {
+		.init = ssd130x_init,
+		.update_rect = ssd130x_update_rect,
+		.clear_screen = ssd130x_clear_screen,
+		.fmt_convert = drm_fb_xrgb8888_to_mono,
+	},
+};
+
 static int ssd13xx_fb_blit_rect(struct drm_framebuffer *fb,
 				const struct iosys_map *vmap,
 				struct drm_rect *rect, u8 *buf,
@@ -609,6 +621,7 @@ static int ssd13xx_fb_blit_rect(struct drm_framebuffer *fb,
 				u8 *data_array)
 {
 	struct ssd13xx_device *ssd13xx = drm_to_ssd13xx(fb->dev);
+	const struct ssd13xx_funcs *ssd13xx_funcs = ssd13xx->funcs;
 	struct iosys_map dst;
 	unsigned int dst_pitch;
 	int ret = 0;
@@ -624,13 +637,11 @@ static int ssd13xx_fb_blit_rect(struct drm_framebuffer *fb,
 		return ret;
 
 	iosys_map_set_vaddr(&dst, buf);
-	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect);
+	ssd13xx_funcs->fmt_convert(&dst, &dst_pitch, vmap, fb, rect);
 
 	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
 
-	ssd13xx_update_rect(ssd13xx, rect, buf, data_array);
-
-	return ret;
+	return ssd13xx_funcs->update_rect(ssd13xx, rect, buf, data_array);
 }
 
 static int ssd13xx_primary_plane_atomic_check(struct drm_plane *plane,
@@ -642,8 +653,6 @@ static int ssd13xx_primary_plane_atomic_check(struct drm_plane *plane,
 	struct ssd13xx_plane_state *ssd13xx_state = to_ssd13xx_plane_state(plane_state);
 	struct drm_crtc *crtc = plane_state->crtc;
 	struct drm_crtc_state *crtc_state;
-	const struct drm_format_info *fi;
-	unsigned int pitch;
 	int ret;
 
 	if (!crtc)
@@ -657,18 +666,10 @@ static int ssd13xx_primary_plane_atomic_check(struct drm_plane *plane,
 	if (ret)
 		return ret;
 
-	fi = drm_format_info(DRM_FORMAT_R1);
-	if (!fi)
-		return -EINVAL;
-
-	pitch = drm_format_info_min_pitch(fi, 0, ssd13xx->width);
-
-	ssd13xx_state->buffer = kcalloc(pitch, ssd13xx->height, GFP_KERNEL);
+	ssd13xx_state->buffer = kzalloc(ssd13xx->buffer_size, GFP_KERNEL);
 	if (!ssd13xx_state->buffer)
 		return -ENOMEM;
 
-	ssd13xx_state->fi = fi;
-
 	return 0;
 }
 
@@ -684,6 +685,7 @@ static void ssd13xx_primary_plane_atomic_update(struct drm_plane *plane,
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_device *drm = plane->dev;
+	struct ssd13xx_device *ssd13xx = drm_to_ssd13xx(drm);
 	struct drm_rect dst_clip;
 	struct drm_rect damage;
 	int idx;
@@ -700,7 +702,7 @@ static void ssd13xx_primary_plane_atomic_update(struct drm_plane *plane,
 
 		ssd13xx_fb_blit_rect(fb, &shadow_plane_state->data[0], &dst_clip,
 				     ssd13xx_plane_state->buffer,
-				     ssd13xx_plane_state->fi,
+				     ssd13xx->buffer_fi,
 				     ssd13xx_crtc_state->data_array);
 	}
 
@@ -712,6 +714,7 @@ static void ssd13xx_primary_plane_atomic_disable(struct drm_plane *plane,
 {
 	struct drm_device *drm = plane->dev;
 	struct ssd13xx_device *ssd13xx = drm_to_ssd13xx(drm);
+	const struct ssd13xx_funcs *ssd13xx_funcs = ssd13xx->funcs;
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_crtc_state *crtc_state;
 	struct ssd13xx_crtc_state *ssd13xx_crtc_state;
@@ -726,7 +729,7 @@ static void ssd13xx_primary_plane_atomic_disable(struct drm_plane *plane,
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
-	ssd13xx_clear_screen(ssd13xx, ssd13xx_crtc_state->data_array);
+	ssd13xx_funcs->clear_screen(ssd13xx, ssd13xx_crtc_state->data_array);
 
 	drm_dev_exit(idx);
 }
@@ -820,14 +823,13 @@ static int ssd13xx_crtc_atomic_check(struct drm_crtc *crtc,
 	struct ssd13xx_device *ssd13xx = drm_to_ssd13xx(drm);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	struct ssd13xx_crtc_state *ssd13xx_state = to_ssd13xx_crtc_state(crtc_state);
-	unsigned int pages = DIV_ROUND_UP(ssd13xx->height, SSD130X_PAGE_HEIGHT);
 	int ret;
 
 	ret = drm_crtc_helper_atomic_check(crtc, state);
 	if (ret)
 		return ret;
 
-	ssd13xx_state->data_array = kmalloc(ssd13xx->width * pages, GFP_KERNEL);
+	ssd13xx_state->data_array = kmalloc(ssd13xx->data_array_size, GFP_KERNEL);
 	if (!ssd13xx_state->data_array)
 		return -ENOMEM;
 
@@ -905,13 +907,14 @@ static void ssd13xx_encoder_atomic_enable(struct drm_encoder *encoder,
 {
 	struct drm_device *drm = encoder->dev;
 	struct ssd13xx_device *ssd13xx = drm_to_ssd13xx(drm);
+	const struct ssd13xx_funcs *ssd13xx_funcs = ssd13xx->funcs;
 	int ret;
 
 	ret = ssd13xx_power_on(ssd13xx);
 	if (ret)
 		return;
 
-	ret = ssd13xx_init(ssd13xx);
+	ret = ssd13xx_funcs->init(ssd13xx);
 	if (ret)
 		goto power_off;
 
@@ -1195,11 +1198,38 @@ static int ssd13xx_get_resources(struct ssd13xx_device *ssd13xx)
 	return 0;
 }
 
+static int ssd13xx_set_buffer_sizes(struct ssd13xx_device *ssd13xx,
+				    enum ssd13xx_family_ids family_id)
+{
+	const struct drm_format_info *fi;
+	unsigned int buffer_pitch;
+
+	switch (family_id) {
+	case SSD130X_FAMILY:
+		unsigned int pages = DIV_ROUND_UP(ssd13xx->height, SSD130X_PAGE_HEIGHT);
+
+		ssd13xx->data_array_size = ssd13xx->width * pages;
+
+		fi = drm_format_info(DRM_FORMAT_R1);
+		break;
+	}
+
+	if (!fi)
+		return -EINVAL;
+
+	buffer_pitch = drm_format_info_min_pitch(fi, 0, ssd13xx->width);
+	ssd13xx->buffer_size = buffer_pitch * ssd13xx->height;
+	ssd13xx->buffer_fi = fi;
+
+	return 0;
+}
+
 struct ssd13xx_device *ssd13xx_probe(struct device *dev, struct regmap *regmap)
 {
 	struct ssd13xx_device *ssd13xx;
 	struct backlight_device *bl;
 	struct drm_device *drm;
+	enum ssd13xx_family_ids family_id;
 	int ret;
 
 	ssd13xx = devm_drm_dev_alloc(dev, &ssd13xx_drm_driver,
@@ -1214,11 +1244,19 @@ struct ssd13xx_device *ssd13xx_probe(struct device *dev, struct regmap *regmap)
 	ssd13xx->regmap = regmap;
 	ssd13xx->device_info = device_get_match_data(dev);
 
+	family_id = ssd13xx->device_info->family_id;
+
+	ssd13xx->funcs = &ssd13xx_family_funcs[family_id];
+
 	if (ssd13xx->device_info->page_mode_only)
 		ssd13xx->page_address_mode = 1;
 
 	ssd13xx_parse_properties(ssd13xx);
 
+	ret = ssd13xx_set_buffer_sizes(ssd13xx, family_id);
+	if (ret)
+		return ERR_PTR(ret);
+
 	ret = ssd13xx_get_resources(ssd13xx);
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/solomon/ssd13xx.h b/drivers/gpu/drm/solomon/ssd13xx.h
index 64283935fbc1..e78d5ab87474 100644
--- a/drivers/gpu/drm/solomon/ssd13xx.h
+++ b/drivers/gpu/drm/solomon/ssd13xx.h
@@ -20,11 +20,17 @@
 #include <drm/drm_plane_helper.h>
 
 #include <linux/regmap.h>
+#include <linux/iosys-map.h>
 
 #define SSD130X_DATA				0x40
 #define SSD130X_COMMAND				0x80
 
+enum ssd13xx_family_ids {
+	SSD130X_FAMILY,
+};
+
 enum ssd13xx_variants {
+	/* ssd130x family */
 	SH1106_ID,
 	SSD1305_ID,
 	SSD1306_ID,
@@ -39,6 +45,7 @@ struct ssd13xx_deviceinfo {
 	u32 default_dclk_frq;
 	u32 default_width;
 	u32 default_height;
+	enum ssd13xx_family_ids family_id;
 	bool need_pwm;
 	bool need_chargepump;
 	bool page_mode_only;
@@ -76,6 +83,12 @@ struct ssd13xx_device {
 	u32 col_offset;
 	u32 prechargep1;
 	u32 prechargep2;
+	/* HW format buffer size */
+	u32 data_array_size;
+	/* Intermediate buffer size */
+	u32 buffer_size;
+	/* Pixel format info for the intermediate buffer */
+	const struct drm_format_info *buffer_fi;
 
 	struct backlight_device *bl_dev;
 	struct pwm_device *pwm;
@@ -88,6 +101,20 @@ struct ssd13xx_device {
 	u8 col_end;
 	u8 page_start;
 	u8 page_end;
+
+	/* Chip family specific operations */
+	const struct ssd13xx_funcs *funcs;
+};
+
+struct ssd13xx_funcs {
+	int (*init)(struct ssd13xx_device *ssd130x);
+	int (*update_rect)(struct ssd13xx_device *ssd13xx, struct drm_rect *rect,
+			   u8 *buf, u8 *data_array);
+	void (*clear_screen)(struct ssd13xx_device *ssd13xx,
+			     u8 *data_array);
+	void (*fmt_convert)(struct iosys_map *dst, const unsigned int *dst_pitch,
+			    const struct iosys_map *src, const struct drm_framebuffer *fb,
+			    const struct drm_rect *clip);
 };
 
 extern const struct ssd13xx_deviceinfo ssd13xx_variants[];
-- 
2.41.0

