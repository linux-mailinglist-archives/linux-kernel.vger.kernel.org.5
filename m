Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227C37C932A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjJNHQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjJNHQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358A9CF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697267739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDhBOagYld3bAeOqNv/tg7J2air7S2lsaF1w29lcFmU=;
        b=DhOhuH6CyGPV3D7BH0Cj+zq4L+vAxgcnMSdouHkCCfZHlQXWo1/ZwGnabmYj3X5yBTQHO0
        OKuyFNEzak6QjTZp6PEKmImjQq63sEzReMsk5qwAqELdSgr9IutRHasXIV75PbkkjcduuV
        jQRh/TXBNxHR14mV3SdUg6s6VaeME0A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-TfslZxK3M6aWWcxg4Mp8ZA-1; Sat, 14 Oct 2023 03:15:28 -0400
X-MC-Unique: TfslZxK3M6aWWcxg4Mp8ZA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30e4943ca7fso1763357f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697267726; x=1697872526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDhBOagYld3bAeOqNv/tg7J2air7S2lsaF1w29lcFmU=;
        b=l/awUbIKCATTNuDXBppE/DHBc1XyS6n8kywIn3xXhHtHhTy8UFeXWK+Mv20+Os6PUr
         gs8MRdFKIK6VJQE487c88kpqNUen8dphe1a2rUtmm1oXkzrzVO0nEiT9yU3vniP591BL
         Gq83eaCiYqCp/6rGTd6nHhxjR+y2+pQrlpt60vUd02DKv1e1zim0vGWUKR6+jxz/qZ4H
         MtZRTgqZRPZ3qolcvGzQwjqhXihQCX4c6HsSqSKo1WUFmEXIil2U2GJe/guzdkusCqLU
         4Y0gUJBAwvR6CjNuHw9vufEahEpRAFwse4BckPr1d2T54S2cTasJX6QATrgEUo1ByUDR
         pP5A==
X-Gm-Message-State: AOJu0YzMwGVXaB41Bk+CIXngaXbbCFda/bmBGcbWdZJWQkLjJAdzu6mO
        93UhokHLgcUWRcSrlrxqEx+oAGn55aMVdoIrj8P3LLXy6jwDkBgeIqTsrQIB8+xe8Qy/ZDDX660
        aRlvOWoniLWZ4SsoC11KQBG0W1TrbGjlg67qyrKwQaI0LnpOPU3URC17yPlp4ZzSdgz/krpzBVv
        zF+GzC2VE=
X-Received: by 2002:a05:6000:1152:b0:32d:9879:1dcd with SMTP id d18-20020a056000115200b0032d98791dcdmr3305413wrx.49.1697267726566;
        Sat, 14 Oct 2023 00:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIbrhlZuWSTOSh0vRiW0WkC5uVDYZjP3r2MiziuSQOrnrYbkAHnf3MwR/B18BoX0dg9K1HAg==
X-Received: by 2002:a05:6000:1152:b0:32d:9879:1dcd with SMTP id d18-20020a056000115200b0032d98791dcdmr3305385wrx.49.1697267726171;
        Sat, 14 Oct 2023 00:15:26 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v3-20020adfa1c3000000b0032d8354fb43sm9135731wrv.76.2023.10.14.00.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:15:25 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 1/6] drm/ssd130x: Replace .page_height field in device info with a constant
Date:   Sat, 14 Oct 2023 09:15:03 +0200
Message-ID: <20231014071520.1342189-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014071520.1342189-1-javierm@redhat.com>
References: <20231014071520.1342189-1-javierm@redhat.com>
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

This deemed useful to avoid hardcoding a page height and allow to support
other Solomon controller families, but dividing the screen in pages seems
to be something that is specific to the SSD130x chip family.

For example, SSD132x chip family divides the screen in segments (columns)
and common outputs (rows), so the concept of screen pages does not exist
for the SSD132x family.

Let's drop this field from the device info struct and just use a constant
SSD130X_PAGE_HEIGHT macro to define the page height. While being there,
replace hardcoded 8 values in places where it is used as the page height.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v2)

Changes in v2:
- Add Geert Uytterhoeven's Reviewed-by tag to patch #1.

 drivers/gpu/drm/solomon/ssd130x.c | 37 +++++++++++++++----------------
 drivers/gpu/drm/solomon/ssd130x.h |  1 -
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 0c716136c538..d530d13eef5a 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -42,6 +42,8 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+#define SSD130X_PAGE_HEIGHT 8
+
 #define SSD130X_PAGE_COL_START_LOW		0x00
 #define SSD130X_PAGE_COL_START_HIGH		0x10
 #define SSD130X_SET_ADDRESS_MODE		0x20
@@ -102,7 +104,6 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.default_width = 132,
 		.default_height = 64,
 		.page_mode_only = 1,
-		.page_height = 8,
 	},
 	[SSD1305_ID] = {
 		.default_vcomh = 0x34,
@@ -110,7 +111,6 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.default_dclk_frq = 7,
 		.default_width = 132,
 		.default_height = 64,
-		.page_height = 8,
 	},
 	[SSD1306_ID] = {
 		.default_vcomh = 0x20,
@@ -119,7 +119,6 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.need_chargepump = 1,
 		.default_width = 128,
 		.default_height = 64,
-		.page_height = 8,
 	},
 	[SSD1307_ID] = {
 		.default_vcomh = 0x20,
@@ -128,7 +127,6 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.need_pwm = 1,
 		.default_width = 128,
 		.default_height = 39,
-		.page_height = 8,
 	},
 	[SSD1309_ID] = {
 		.default_vcomh = 0x34,
@@ -136,7 +134,6 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.default_dclk_frq = 10,
 		.default_width = 128,
 		.default_height = 64,
-		.page_height = 8,
 	}
 };
 EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
@@ -465,13 +462,13 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
 	unsigned int width = drm_rect_width(rect);
 	unsigned int height = drm_rect_height(rect);
 	unsigned int line_length = DIV_ROUND_UP(width, 8);
-	unsigned int page_height = ssd130x->device_info->page_height;
+	unsigned int page_height = SSD130X_PAGE_HEIGHT;
 	unsigned int pages = DIV_ROUND_UP(height, page_height);
 	struct drm_device *drm = &ssd130x->drm;
 	u32 array_idx = 0;
 	int ret, i, j, k;
 
-	drm_WARN_ONCE(drm, y % 8 != 0, "y must be aligned to screen page\n");
+	drm_WARN_ONCE(drm, y % page_height != 0, "y must be aligned to screen page\n");
 
 	/*
 	 * The screen is divided in pages, each having a height of 8
@@ -503,27 +500,32 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
 	 */
 
 	if (!ssd130x->page_address_mode) {
+		u8 page_start;
+
 		/* Set address range for horizontal addressing mode */
 		ret = ssd130x_set_col_range(ssd130x, ssd130x->col_offset + x, width);
 		if (ret < 0)
 			return ret;
 
-		ret = ssd130x_set_page_range(ssd130x, ssd130x->page_offset + y / 8, pages);
+		page_start = ssd130x->page_offset + y / page_height;
+		ret = ssd130x_set_page_range(ssd130x, page_start, pages);
 		if (ret < 0)
 			return ret;
 	}
 
 	for (i = 0; i < pages; i++) {
-		int m = 8;
+		int m = page_height;
 
 		/* Last page may be partial */
-		if (8 * (y / 8 + i + 1) > ssd130x->height)
-			m = ssd130x->height % 8;
+		if (page_height * (y / page_height + i + 1) > ssd130x->height)
+			m = ssd130x->height % page_height;
+
 		for (j = 0; j < width; j++) {
 			u8 data = 0;
 
 			for (k = 0; k < m; k++) {
-				u8 byte = buf[(8 * i + k) * line_length + j / 8];
+				u32 idx = (page_height * i + k) * line_length + j / 8;
+				u8 byte = buf[idx];
 				u8 bit = (byte >> (j % 8)) & 1;
 
 				data |= bit << k;
@@ -559,8 +561,7 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
 
 static void ssd130x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 {
-	unsigned int page_height = ssd130x->device_info->page_height;
-	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
+	unsigned int pages = DIV_ROUND_UP(ssd130x->height, SSD130X_PAGE_HEIGHT);
 	unsigned int width = ssd130x->width;
 	int ret, i;
 
@@ -605,14 +606,13 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb,
 				u8 *buf, u8 *data_array)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
-	unsigned int page_height = ssd130x->device_info->page_height;
 	struct iosys_map dst;
 	unsigned int dst_pitch;
 	int ret = 0;
 
 	/* Align y to display page boundaries */
-	rect->y1 = round_down(rect->y1, page_height);
-	rect->y2 = min_t(unsigned int, round_up(rect->y2, page_height), ssd130x->height);
+	rect->y1 = round_down(rect->y1, SSD130X_PAGE_HEIGHT);
+	rect->y2 = min_t(unsigned int, round_up(rect->y2, SSD130X_PAGE_HEIGHT), ssd130x->height);
 
 	dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 8);
 
@@ -815,8 +815,7 @@ static int ssd130x_crtc_atomic_check(struct drm_crtc *crtc,
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	struct ssd130x_crtc_state *ssd130x_state = to_ssd130x_crtc_state(crtc_state);
-	unsigned int page_height = ssd130x->device_info->page_height;
-	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
+	unsigned int pages = DIV_ROUND_UP(ssd130x->height, SSD130X_PAGE_HEIGHT);
 	int ret;
 
 	ret = drm_crtc_helper_atomic_check(crtc, state);
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index aa39b13615eb..bbe374453605 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -39,7 +39,6 @@ struct ssd130x_deviceinfo {
 	u32 default_dclk_frq;
 	u32 default_width;
 	u32 default_height;
-	u32 page_height;
 	bool need_pwm;
 	bool need_chargepump;
 	bool page_mode_only;
-- 
2.41.0

