Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327187BE9AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378173AbjJIShL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378138AbjJIShE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:37:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45A9A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696876571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cAaThqSJ1bntsN2jg+kycHzuBu+ozB5ircxnmQS3wP4=;
        b=ZNfKXxFUPGR6mtpdXS5VslKDX6FDUrmLvETE2qy67vtPoS0tveg1PJlsw/X8jp3v5BlYyp
        tTJZ+681zPtnZppnslJqFGmi4PmoYGBFggMhoW9Uc9QdtYI+eBXAKYDz2VvgvmyIcBeXuE
        0fh/sYmw9KvhBrIlCnMkkyoEOur++QI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-vlD2x_M0NbiM2ZueCIMuQg-1; Mon, 09 Oct 2023 14:36:09 -0400
X-MC-Unique: vlD2x_M0NbiM2ZueCIMuQg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3231f43fc5eso3397881f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876568; x=1697481368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAaThqSJ1bntsN2jg+kycHzuBu+ozB5ircxnmQS3wP4=;
        b=TtdqZpXTeifxZ+V41VreH3xED8fdUM2oiwDgw3K5Ns1CXBllrytD33O7fk9zOX4GP/
         2Oriq+gWm2hxdrV5XpkPRArBJNLigonf2va5FYcXyTUV9fZPPVZVAuj2Q794dMEXNl8E
         dTY2CWB/2YnShdZBjcuFM6L3ztqvN4YPBeSlewnEBmjKsQ7uFluPFylZblY5EyQ8Q/Eu
         Pyv8Xk/ArrnXaQ2DnfjiKT0o8Zq0BmGacZB3va4KRiHpYXz5PJFCjFQOMyusxQJtyNW6
         vG94x3mgXTtKz7OWQAAO9TMtxpXTDyw/0Gmr0/ly89tL5r+gFVkZSHdmkib5sRrFzhVU
         C81w==
X-Gm-Message-State: AOJu0YxRydIqEODJvbZFIEuMe9mjsEcPYg5/4q9nv8wFe9sQSeteDyMV
        qogc4Izhr1PogcaI1v632pR4Y1MUsWHzHfC6Q8AvWNSNSAaLl3jD1M8tKtpMcLgqOqO8g2GORoz
        sMKaBJkBvUrY4GqAxZvvSFVqEdBP+tQf2mwaZMcMhXUlNcu99c6bq6Z8VjFIEsJHeqdxQtbCVar
        zY91mRjog=
X-Received: by 2002:a5d:4650:0:b0:319:7c14:b06b with SMTP id j16-20020a5d4650000000b003197c14b06bmr14360247wrs.47.1696876568456;
        Mon, 09 Oct 2023 11:36:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmiIGqQ4xbXICwKFnBJtMR2yQZr9iiHnXKi+pbx5GVR/MJi6cvkyOFjq45ubbCtuMrA4YqbA==
X-Received: by 2002:a5d:4650:0:b0:319:7c14:b06b with SMTP id j16-20020a5d4650000000b003197c14b06bmr14360222wrs.47.1696876568045;
        Mon, 09 Oct 2023 11:36:08 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d4802000000b0031fe0576460sm10335828wrq.11.2023.10.09.11.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:36:07 -0700 (PDT)
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
Subject: [PATCH 7/8] drm/ssd13xx: Add support for the SSD132x OLED controller family
Date:   Mon,  9 Oct 2023 20:34:21 +0200
Message-ID: <20231009183522.543918-8-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009183522.543918-1-javierm@redhat.com>
References: <20231009183522.543918-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Solomon SSD132x controllers (such as the SSD1322, SSD1325 and SSD1327)
are used by 16 grayscale dot matrix OLED panels, extend the driver to also
support this chip family.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd13xx-i2c.c |  13 ++
 drivers/gpu/drm/solomon/ssd13xx-spi.c |  13 ++
 drivers/gpu/drm/solomon/ssd13xx.c     | 206 +++++++++++++++++++++++++-
 drivers/gpu/drm/solomon/ssd13xx.h     |   5 +
 4 files changed, 234 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd13xx-i2c.c b/drivers/gpu/drm/solomon/ssd13xx-i2c.c
index d9cece374331..9cf78d206c6e 100644
--- a/drivers/gpu/drm/solomon/ssd13xx-i2c.c
+++ b/drivers/gpu/drm/solomon/ssd13xx-i2c.c
@@ -92,6 +92,19 @@ static const struct of_device_id ssd13xx_of_match[] = {
 		.compatible = "solomon,ssd1309fb-i2c",
 		.data = &ssd13xx_variants[SSD1309_ID],
 	},
+	/* ssd1302x family */
+	{
+		.compatible = "solomon,ssd1322",
+		.data = &ssd13xx_variants[SSD1322_ID],
+	},
+	{
+		.compatible = "solomon,ssd1325",
+		.data = &ssd13xx_variants[SSD1325_ID],
+	},
+	{
+		.compatible = "solomon,ssd1327",
+		.data = &ssd13xx_variants[SSD1327_ID],
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ssd13xx_of_match);
diff --git a/drivers/gpu/drm/solomon/ssd13xx-spi.c b/drivers/gpu/drm/solomon/ssd13xx-spi.c
index 2416756686cc..55162e49f037 100644
--- a/drivers/gpu/drm/solomon/ssd13xx-spi.c
+++ b/drivers/gpu/drm/solomon/ssd13xx-spi.c
@@ -129,6 +129,19 @@ static const struct of_device_id ssd13xx_of_match[] = {
 		.compatible = "solomon,ssd1309",
 		.data = &ssd13xx_variants[SSD1309_ID],
 	},
+	/* ssd1302x family */
+	{
+		.compatible = "solomon,ssd1322",
+		.data = &ssd13xx_variants[SSD1322_ID],
+	},
+	{
+		.compatible = "solomon,ssd1325",
+		.data = &ssd13xx_variants[SSD1325_ID],
+	},
+	{
+		.compatible = "solomon,ssd1327",
+		.data = &ssd13xx_variants[SSD1327_ID],
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ssd13xx_of_match);
diff --git a/drivers/gpu/drm/solomon/ssd13xx.c b/drivers/gpu/drm/solomon/ssd13xx.c
index b30224856518..bc53e7c80ffe 100644
--- a/drivers/gpu/drm/solomon/ssd13xx.c
+++ b/drivers/gpu/drm/solomon/ssd13xx.c
@@ -99,6 +99,24 @@
 #define SSD130X_SET_AREA_COLOR_MODE_ENABLE	0x1e
 #define SSD130X_SET_AREA_COLOR_MODE_LOW_POWER	0x05
 
+/* ssd132x commands */
+#define SSD132X_SET_COL_RANGE			0x15
+#define SSD132X_SET_DEACTIVATE_SCROLL		0x2e
+#define SSD132X_SET_ROW_RANGE			0x75
+#define SSD132X_SET_DISPLAY_START		0xa1
+#define SSD132X_SET_DISPLAY_OFFSET		0xa2
+#define SSD132X_SET_DISPLAY_NORMAL		0xa4
+#define SSD132X_SET_FUNCTION_SELECT_A		0xab
+#define SSD132X_SET_PHASE_LENGTH		0xb1
+#define SSD132X_SET_CLOCK_FREQ			0xb3
+#define SSD132X_SET_GPIO			0xb5
+#define SSD132X_SET_PRECHARGE_PERIOD		0xb6
+#define SSD132X_SET_GRAY_SCALE_TABLE		0xb8
+#define SSD132X_SELECT_DEFAULT_TABLE		0xb9
+#define SSD132X_SET_PRECHARGE_VOLTAGE		0xbc
+#define SSD130X_SET_VCOMH_VOLTAGE		0xbe
+#define SSD132X_SET_FUNCTION_SELECT_B		0xd5
+
 #define MAX_CONTRAST 255
 
 const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
@@ -144,6 +162,22 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
 		.default_width = 128,
 		.default_height = 64,
 		.family_id = SSD130X_FAMILY,
+	},
+	/* ssd132x family */
+	[SSD1322_ID] = {
+		.default_width = 480,
+		.default_height = 128,
+		.family_id = SSD132X_FAMILY,
+	},
+	[SSD1325_ID] = {
+		.default_width = 128,
+		.default_height = 80,
+		.family_id = SSD132X_FAMILY,
+	},
+	[SSD1327_ID] = {
+		.default_width = 128,
+		.default_height = 128,
+		.family_id = SSD132X_FAMILY,
 	}
 };
 EXPORT_SYMBOL_NS_GPL(ssd13xx_variants, DRM_SSD13XX);
@@ -610,6 +644,156 @@ static void ssd130x_clear_screen(struct ssd13xx_device *ssd13xx, u8 *data_array)
 	}
 }
 
+static int ssd132x_init(struct ssd13xx_device *ssd13xx)
+{
+	int ret;
+
+	/* Set initial contrast */
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD13XX_CONTRAST, 0x80);
+	if (ret < 0)
+		return ret;
+
+	/* Set column start and end */
+	ret = ssd13xx_write_cmd(ssd13xx, 3, SSD132X_SET_COL_RANGE, 0x00, ssd13xx->width / 2 - 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set row start and end */
+	ret = ssd13xx_write_cmd(ssd13xx, 3, SSD132X_SET_ROW_RANGE, 0x00, ssd13xx->height - 1);
+	if (ret < 0)
+		return ret;
+	/*
+	 * Horizontal Address Increment
+	 * Re-map for Column Address, Nibble and COM
+	 * COM Split Odd Even
+	 */
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD13XX_SET_SEG_REMAP, 0x53);
+	if (ret < 0)
+		return ret;
+
+	/* Set display start and offset */
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD132X_SET_DISPLAY_START, 0x00);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD132X_SET_DISPLAY_OFFSET, 0x00);
+	if (ret < 0)
+		return ret;
+
+	/* Set display mode normal */
+	ret = ssd13xx_write_cmd(ssd13xx, 1, SSD132X_SET_DISPLAY_NORMAL);
+	if (ret < 0)
+		return ret;
+
+	/* Set multiplex ratio value */
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD13XX_SET_MULTIPLEX_RATIO, ssd13xx->height - 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set phase length */
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD132X_SET_PHASE_LENGTH, 0x55);
+	if (ret < 0)
+		return ret;
+
+	/* Select default linear gray scale table */
+	ret = ssd13xx_write_cmd(ssd13xx, 1, SSD132X_SELECT_DEFAULT_TABLE);
+	if (ret < 0)
+		return ret;
+
+	/* Set clock frequency */
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD132X_SET_CLOCK_FREQ, 0x01);
+	if (ret < 0)
+		return ret;
+
+	/* Enable internal VDD regulator */
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD132X_SET_FUNCTION_SELECT_A, 0x1);
+	if (ret < 0)
+		return ret;
+
+	/* Set pre-charge period */
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD132X_SET_PRECHARGE_PERIOD, 0x01);
+	if (ret < 0)
+		return ret;
+
+	/* Set pre-charge voltage */
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD132X_SET_PRECHARGE_VOLTAGE, 0x08);
+	if (ret < 0)
+		return ret;
+
+	/* Set VCOMH voltage */
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD130X_SET_VCOMH_VOLTAGE, 0x07);
+	if (ret < 0)
+		return ret;
+
+	/* Enable second pre-charge and internal VSL */
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD132X_SET_FUNCTION_SELECT_B, 0x62);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ssd132x_update_rect(struct ssd13xx_device *ssd13xx,
+			       struct drm_rect *rect, u8 *buf,
+			       u8 *data_array)
+{
+	unsigned int x = rect->x1 / 2;
+	unsigned int y = rect->y1;
+	unsigned int width = drm_rect_width(rect);
+	unsigned int height = drm_rect_height(rect);
+	unsigned int columns = DIV_ROUND_UP(width, 2);
+	unsigned int rows = height;
+	u32 array_idx = 0;
+	int ret, i, j;
+
+	/*
+	 * The screen is divided in Segment and Common outputs, where
+	 * COM0 to COM[N - 1] are the rows and SEG0 to SEG[M - 1] are
+	 * the columns.
+	 *
+	 * Each Segment has a 4-bit pixel and each Common output has a
+	 * row of pixels. When using the (default) horizontal address
+	 * increment mode, each byte of data sent to the controller has
+	 * two Segments (e.g: SEG0 and SEG1) that are stored in the lower
+	 * and higher nibbles of a single byte representing one column.
+	 * That is, the first byte are SEG0 (D0[3:0]) and SEG1 (D0[7:4]),
+	 * the second byte are SEG2 (D1[3:0]) and SEG3 (D1[7:4]) and so on.
+	 */
+
+	/* Set column start and end */
+	ret = ssd13xx_write_cmd(ssd13xx, 3, SSD132X_SET_COL_RANGE, x, columns - 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set row start and end */
+	ret = ssd13xx_write_cmd(ssd13xx, 3, SSD132X_SET_ROW_RANGE, y, rows - 1);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < height; i++) {
+		/* Process pair of pixels and combine them into a single byte */
+		for (j = 0; j < width; j += 2) {
+			u8 n1 = buf[i * width + j];
+			u8 n2 = buf[i * width + j + 1];
+
+			data_array[array_idx++] = (n2 << 4) | n1;
+		}
+	}
+
+	/* Write out update in one go since horizontal addressing mode is used */
+	ret = ssd13xx_write_data(ssd13xx, data_array, columns * rows);
+
+	return ret;
+}
+
+static void ssd132x_clear_screen(struct ssd13xx_device *ssd13xx, u8 *data_array)
+{
+	memset(data_array, 0, ssd13xx->data_array_size);
+
+	/* Write out update in one go since horizontal addressing mode is used */
+	ssd13xx_write_data(ssd13xx, data_array, ssd13xx->data_array_size);
+}
+
 static const struct ssd13xx_funcs ssd13xx_family_funcs[] = {
 	[SSD130X_FAMILY] = {
 		.init = ssd130x_init,
@@ -617,6 +801,12 @@ static const struct ssd13xx_funcs ssd13xx_family_funcs[] = {
 		.clear_screen = ssd130x_clear_screen,
 		.fmt_convert = drm_fb_xrgb8888_to_mono,
 	},
+	[SSD132X_FAMILY] = {
+		.init = ssd132x_init,
+		.update_rect = ssd132x_update_rect,
+		.clear_screen = ssd132x_clear_screen,
+		.fmt_convert = drm_fb_xrgb8888_to_gray8,
+	}
 };
 
 static int ssd13xx_fb_blit_rect(struct drm_framebuffer *fb,
@@ -631,9 +821,12 @@ static int ssd13xx_fb_blit_rect(struct drm_framebuffer *fb,
 	unsigned int dst_pitch;
 	int ret = 0;
 
-	/* Align y to display page boundaries */
-	rect->y1 = round_down(rect->y1, SSD130X_PAGE_HEIGHT);
-	rect->y2 = min_t(unsigned int, round_up(rect->y2, SSD130X_PAGE_HEIGHT), ssd13xx->height);
+	if (ssd13xx->device_info->family_id == SSD130X_FAMILY) {
+		/* Align y to display page boundaries */
+		rect->y1 = round_down(rect->y1, SSD130X_PAGE_HEIGHT);
+		rect->y2 = min_t(unsigned int, round_up(rect->y2, SSD130X_PAGE_HEIGHT),
+				 ssd13xx->height);
+	}
 
 	dst_pitch = drm_format_info_min_pitch(fi, 0, drm_rect_width(rect));
 
@@ -1217,6 +1410,13 @@ static int ssd13xx_set_buffer_sizes(struct ssd13xx_device *ssd13xx,
 
 		fi = drm_format_info(DRM_FORMAT_R1);
 		break;
+	case SSD132X_FAMILY:
+		unsigned int columns = DIV_ROUND_UP(ssd13xx->width, 2);
+		unsigned int rows = ssd13xx->height;
+
+		ssd13xx->data_array_size = columns * rows;
+
+		fi = drm_format_info(DRM_FORMAT_R8);
 	}
 
 	if (!fi)
diff --git a/drivers/gpu/drm/solomon/ssd13xx.h b/drivers/gpu/drm/solomon/ssd13xx.h
index 399b0c8b5680..58083c7e08c8 100644
--- a/drivers/gpu/drm/solomon/ssd13xx.h
+++ b/drivers/gpu/drm/solomon/ssd13xx.h
@@ -27,6 +27,7 @@
 
 enum ssd13xx_family_ids {
 	SSD130X_FAMILY,
+	SSD132X_FAMILY,
 };
 
 enum ssd13xx_variants {
@@ -36,6 +37,10 @@ enum ssd13xx_variants {
 	SSD1306_ID,
 	SSD1307_ID,
 	SSD1309_ID,
+	/* ssd132x family */
+	SSD1322_ID,
+	SSD1325_ID,
+	SSD1327_ID,
 	NR_SSD13XX_VARIANTS
 };
 
-- 
2.41.0

