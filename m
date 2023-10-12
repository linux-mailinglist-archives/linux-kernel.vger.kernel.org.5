Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496EB7C6614
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377750AbjJLG7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377691AbjJLG7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D676C9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697093915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ua/s/6zVxVPQdvrXk/5nO3FL9GEurLmhO2C94hV695w=;
        b=MdTP5CV7U5rwsnxCVDMd9otBtbVowluNz0AkPBy7Qggw9DAGRHut2JiBWNf6FYvqjFud5/
        DXGZbu3Rnjqb6u1df8vfeY4az3jkJ4mRldFjeWhJAncskeQeGGxZap9wO32S4AguT3CacE
        u7yanfq1X/HzcnsvTGvlZjluAkJ/014=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-m0-FtfAgNliZnc88vj3Bcg-1; Thu, 12 Oct 2023 02:58:33 -0400
X-MC-Unique: m0-FtfAgNliZnc88vj3Bcg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40554735995so5725665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697093912; x=1697698712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ua/s/6zVxVPQdvrXk/5nO3FL9GEurLmhO2C94hV695w=;
        b=YISqj58GJq4dC0wpFVJ+FyoE7F5hqmm7ZH4xRXNSB0PrvaYQryMmk9vc85VJjplqa3
         4oFi53UEtDQY3bvZC9047xzKSslXmSVw3OZ/ibPcPl0sakGJS6SgK7HOIjNoyUrK8q5x
         Vd/bZUR8Lw7pudTTI+/iQ2g4QIbxWr9yF8fhdJqxyQV7Mow6ryf7yn3dtHXxbHMRFRPx
         l9GwYfLLlWAVrSo7O0IKfZjzPClVsQChZbbL4nYCcY1zjyHf0DjOTWGIitO0fEtOHKbn
         3hJzMHXkfefICPouQwyYMXK5SAeIHlOuXzAaP3oOvyK/99AWUekG+zT69nx08ixJkPGh
         B6EQ==
X-Gm-Message-State: AOJu0YxhyNQbTehTnb7cdBMrNX3WTtKrT3jVekRp2vTzUpagFy/snItM
        IY7T/FvCeTqYkMg8Sk367c7rIQ7f3qmh0NDiSug2pEik5QavSZBDNyiqDC46P5mS8PsWFojobL7
        /EDaBwnXxwFj8OwvJOAx/mcHTwhjd7mBU58YK3kCM9glyg6dezhvEBQnEBLgyYKKgEb5sSIR1wC
        PZDt5Zblg=
X-Received: by 2002:a1c:7c0a:0:b0:405:39c1:a98b with SMTP id x10-20020a1c7c0a000000b0040539c1a98bmr20087092wmc.20.1697093912072;
        Wed, 11 Oct 2023 23:58:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIbLhskul3YFdQuyDqRXpXMAL/mqUAmd1upTu1Ygb/xaNHEaBpTlnl3AhDuQ709YUQh4rT+Q==
X-Received: by 2002:a1c:7c0a:0:b0:405:39c1:a98b with SMTP id x10-20020a1c7c0a000000b0040539c1a98bmr20087063wmc.20.1697093911577;
        Wed, 11 Oct 2023 23:58:31 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f17-20020a1c6a11000000b004063ea92492sm18631540wmc.22.2023.10.11.23.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:58:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Conor Dooley <conor@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 4/6] drm/ssd130x: Add support for the SSD132x OLED controller family
Date:   Thu, 12 Oct 2023 08:58:13 +0200
Message-ID: <20231012065822.1007930-5-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012065822.1007930-1-javierm@redhat.com>
References: <20231012065822.1007930-1-javierm@redhat.com>
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

The Solomon SSD132x controllers (such as the SSD1322, SSD1325 and SSD1327)
are used by 16 grayscale dot matrix OLED panels, extend the driver to also
support this chip family.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Align the rectangle to the segment width (Geert Uytterhoeven).

 drivers/gpu/drm/solomon/Kconfig       |  12 +-
 drivers/gpu/drm/solomon/ssd130x-i2c.c |  17 +-
 drivers/gpu/drm/solomon/ssd130x-spi.c |  21 ++-
 drivers/gpu/drm/solomon/ssd130x.c     | 234 +++++++++++++++++++++++++-
 drivers/gpu/drm/solomon/ssd130x.h     |   4 +
 5 files changed, 275 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
index e170716d976b..c3ee956c2bb9 100644
--- a/drivers/gpu/drm/solomon/Kconfig
+++ b/drivers/gpu/drm/solomon/Kconfig
@@ -1,31 +1,31 @@
 config DRM_SSD130X
-	tristate "DRM support for Solomon SSD130x OLED displays"
+	tristate "DRM support for Solomon SSD13xx OLED displays"
 	depends on DRM && MMU
 	select BACKLIGHT_CLASS_DEVICE
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
 	help
-	  DRM driver for the SSD130x Solomon and SINO WEALTH SH110x OLED
+	  DRM driver for the SSD13xx Solomon and SINO WEALTH SH110x OLED
 	  controllers. This is only for the core driver, a driver for the
 	  appropriate bus transport in your chip also must be selected.
 
 	  If M is selected the module will be called ssd130x.
 
 config DRM_SSD130X_I2C
-	tristate "DRM support for Solomon SSD130x OLED displays (I2C bus)"
+	tristate "DRM support for Solomon SSD13xx OLED displays (I2C bus)"
 	depends on DRM_SSD130X && I2C
 	select REGMAP_I2C
 	help
-	  Say Y here if the SSD130x or SH110x OLED display is connected via
+	  Say Y here if the SSD13xx or SH110x OLED display is connected via
 	  I2C bus.
 
 	  If M is selected the module will be called ssd130x-i2c.
 
 config DRM_SSD130X_SPI
-	tristate "DRM support for Solomon SSD130X OLED displays (SPI bus)"
+	tristate "DRM support for Solomon SSD13xx OLED displays (SPI bus)"
 	depends on DRM_SSD130X && SPI
 	select REGMAP
 	help
-	  Say Y here if the SSD130x OLED display is connected via SPI bus.
+	  Say Y here if the SSD13xx OLED display is connected via SPI bus.
 
 	  If M is selected the module will be called ssd130x-spi.
diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
index 8f89b89d553f..f2ccab9c06d9 100644
--- a/drivers/gpu/drm/solomon/ssd130x-i2c.c
+++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * DRM driver for Solomon SSD130x OLED displays (I2C bus)
+ * DRM driver for Solomon SSD13xx OLED displays (I2C bus)
  *
  * Copyright 2022 Red Hat Inc.
  * Author: Javier Martinez Canillas <javierm@redhat.com>
@@ -14,7 +14,7 @@
 #include "ssd130x.h"
 
 #define DRIVER_NAME	"ssd130x-i2c"
-#define DRIVER_DESC	"DRM driver for Solomon SSD130x OLED displays (I2C)"
+#define DRIVER_DESC	"DRM driver for Solomon SSD13xx OLED displays (I2C)"
 
 static const struct regmap_config ssd130x_i2c_regmap_config = {
 	.reg_bits = 8,
@@ -92,6 +92,19 @@ static const struct of_device_id ssd130x_of_match[] = {
 		.compatible = "solomon,ssd1309fb-i2c",
 		.data = &ssd130x_variants[SSD1309_ID],
 	},
+	/* ssd132x family */
+	{
+		.compatible = "solomon,ssd1322",
+		.data = &ssd130x_variants[SSD1322_ID],
+	},
+	{
+		.compatible = "solomon,ssd1325",
+		.data = &ssd130x_variants[SSD1325_ID],
+	},
+	{
+		.compatible = "solomon,ssd1327",
+		.data = &ssd130x_variants[SSD1327_ID],
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ssd130x_of_match);
diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
index 89989da705d7..84e035a7ab3f 100644
--- a/drivers/gpu/drm/solomon/ssd130x-spi.c
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * DRM driver for Solomon SSD130X OLED displays (SPI bus)
+ * DRM driver for Solomon SSD13xx OLED displays (SPI bus)
  *
  * Copyright 2022 Red Hat Inc.
  * Authors: Javier Martinez Canillas <javierm@redhat.com>
@@ -11,7 +11,7 @@
 #include "ssd130x.h"
 
 #define DRIVER_NAME	"ssd130x-spi"
-#define DRIVER_DESC	"DRM driver for Solomon SSD130X OLED displays (SPI)"
+#define DRIVER_DESC	"DRM driver for Solomon SSD13xx OLED displays (SPI)"
 
 struct ssd130x_spi_transport {
 	struct spi_device *spi;
@@ -129,6 +129,19 @@ static const struct of_device_id ssd130x_of_match[] = {
 		.compatible = "solomon,ssd1309",
 		.data = &ssd130x_variants[SSD1309_ID],
 	},
+	/* ssd132x family */
+	{
+		.compatible = "solomon,ssd1322",
+		.data = &ssd130x_variants[SSD1322_ID],
+	},
+	{
+		.compatible = "solomon,ssd1325",
+		.data = &ssd130x_variants[SSD1325_ID],
+	},
+	{
+		.compatible = "solomon,ssd1327",
+		.data = &ssd130x_variants[SSD1327_ID],
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ssd130x_of_match);
@@ -149,6 +162,10 @@ static const struct spi_device_id ssd130x_spi_table[] = {
 	{ "ssd1306", SSD1306_ID },
 	{ "ssd1307", SSD1307_ID },
 	{ "ssd1309", SSD1309_ID },
+	/* ssd132x family */
+	{ "ssd1322", SSD1322_ID },
+	{ "ssd1325", SSD1325_ID },
+	{ "ssd1327", SSD1327_ID },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, ssd130x_spi_table);
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 4bdc06d6aed4..94a6a6ebd6e8 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * DRM driver for Solomon SSD130x OLED displays
+ * DRM driver for Solomon SSD13xx OLED displays
  *
  * Copyright 2022 Red Hat Inc.
  * Author: Javier Martinez Canillas <javierm@redhat.com>
@@ -37,13 +37,15 @@
 #include "ssd130x.h"
 
 #define DRIVER_NAME	"ssd130x"
-#define DRIVER_DESC	"DRM driver for Solomon SSD130x OLED displays"
+#define DRIVER_DESC	"DRM driver for Solomon SSD13xx OLED displays"
 #define DRIVER_DATE	"20220131"
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
 #define SSD130X_PAGE_HEIGHT 8
 
+#define SSD132X_SEGMENT_WIDTH 2
+
 /* ssd13xx commands */
 #define SSD13XX_CONTRAST			0x81
 #define SSD13XX_SET_SEG_REMAP			0xa0
@@ -99,10 +101,29 @@
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
 
 enum ssd130x_family_ids {
-	SSD130X_FAMILY
+	SSD130X_FAMILY,
+	SSD132X_FAMILY
 };
 
 static const struct ssd130x_funcs ssd130x_family_funcs[];
@@ -150,6 +171,22 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.default_width = 128,
 		.default_height = 64,
 		.funcs = &ssd130x_family_funcs[SSD130X_FAMILY],
+	},
+	/* ssd132x family */
+	[SSD1322_ID] = {
+		.default_width = 480,
+		.default_height = 128,
+		.funcs = &ssd130x_family_funcs[SSD132X_FAMILY],
+	},
+	[SSD1325_ID] = {
+		.default_width = 128,
+		.default_height = 80,
+		.funcs = &ssd130x_family_funcs[SSD132X_FAMILY],
+	},
+	[SSD1327_ID] = {
+		.default_width = 128,
+		.default_height = 128,
+		.funcs = &ssd130x_family_funcs[SSD132X_FAMILY],
 	}
 };
 EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
@@ -643,6 +680,189 @@ static void ssd130x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 	}
 }
 
+static int ssd132x_init(struct ssd130x_device *ssd130x)
+{
+	int ret;
+
+	/* Set initial contrast */
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD13XX_CONTRAST, 0x80);
+	if (ret < 0)
+		return ret;
+
+	/* Set column start and end */
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, 0x00,
+				ssd130x->width / SSD132X_SEGMENT_WIDTH - 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set row start and end */
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, 0x00, ssd130x->height - 1);
+	if (ret < 0)
+		return ret;
+	/*
+	 * Horizontal Address Increment
+	 * Re-map for Column Address, Nibble and COM
+	 * COM Split Odd Even
+	 */
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD13XX_SET_SEG_REMAP, 0x53);
+	if (ret < 0)
+		return ret;
+
+	/* Set display start and offset */
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD132X_SET_DISPLAY_START, 0x00);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD132X_SET_DISPLAY_OFFSET, 0x00);
+	if (ret < 0)
+		return ret;
+
+	/* Set display mode normal */
+	ret = ssd130x_write_cmd(ssd130x, 1, SSD132X_SET_DISPLAY_NORMAL);
+	if (ret < 0)
+		return ret;
+
+	/* Set multiplex ratio value */
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD13XX_SET_MULTIPLEX_RATIO, ssd130x->height - 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set phase length */
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD132X_SET_PHASE_LENGTH, 0x55);
+	if (ret < 0)
+		return ret;
+
+	/* Select default linear gray scale table */
+	ret = ssd130x_write_cmd(ssd130x, 1, SSD132X_SELECT_DEFAULT_TABLE);
+	if (ret < 0)
+		return ret;
+
+	/* Set clock frequency */
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD132X_SET_CLOCK_FREQ, 0x01);
+	if (ret < 0)
+		return ret;
+
+	/* Enable internal VDD regulator */
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD132X_SET_FUNCTION_SELECT_A, 0x1);
+	if (ret < 0)
+		return ret;
+
+	/* Set pre-charge period */
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD132X_SET_PRECHARGE_PERIOD, 0x01);
+	if (ret < 0)
+		return ret;
+
+	/* Set pre-charge voltage */
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD132X_SET_PRECHARGE_VOLTAGE, 0x08);
+	if (ret < 0)
+		return ret;
+
+	/* Set VCOMH voltage */
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD130X_SET_VCOMH_VOLTAGE, 0x07);
+	if (ret < 0)
+		return ret;
+
+	/* Enable second pre-charge and internal VSL */
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD132X_SET_FUNCTION_SELECT_B, 0x62);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ssd132x_set_buffer_sizes(struct ssd130x_device *ssd130x)
+{
+	unsigned int buffer_pitch;
+	unsigned int columns = DIV_ROUND_UP(ssd130x->width, SSD132X_SEGMENT_WIDTH);
+	unsigned int rows = ssd130x->height;
+
+	ssd130x->data_array_size = columns * rows;
+
+	ssd130x->buffer_fi = drm_format_info(DRM_FORMAT_R8);
+
+	if (!ssd130x->buffer_fi)
+		return -EINVAL;
+
+	buffer_pitch = drm_format_info_min_pitch(ssd130x->buffer_fi, 0, ssd130x->width);
+	ssd130x->buffer_size = buffer_pitch * ssd130x->height;
+
+	return 0;
+}
+
+static void ssd132x_align_rect(struct ssd130x_device *ssd130x,
+			       struct drm_rect *rect)
+{
+	/* Align x to display segment boundaries */
+	rect->x1 = round_down(rect->x1, SSD132X_SEGMENT_WIDTH);
+	rect->x2 = min_t(unsigned int, round_up(rect->x2, SSD132X_SEGMENT_WIDTH),
+			 ssd130x->width);
+}
+
+static int ssd132x_update_rect(struct ssd130x_device *ssd130x,
+			       struct drm_rect *rect, u8 *buf,
+			       u8 *data_array)
+{
+	unsigned int x = rect->x1;
+	unsigned int y = rect->y1;
+	unsigned int segment_width = SSD132X_SEGMENT_WIDTH;
+	unsigned int width = drm_rect_width(rect);
+	unsigned int height = drm_rect_height(rect);
+	unsigned int columns = DIV_ROUND_UP(width, segment_width);
+	unsigned int rows = height;
+	struct drm_device *drm = &ssd130x->drm;
+	u32 array_idx = 0;
+	int ret, i, j;
+
+	drm_WARN_ONCE(drm, x % segment_width != 0, "x must be aligned to screen segment\n");
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
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, x / segment_width, columns - 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set row start and end */
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, y, rows - 1);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < height; i++) {
+		/* Process pair of pixels and combine them into a single byte */
+		for (j = 0; j < width; j += segment_width) {
+			u8 n1 = buf[i * width + j];
+			u8 n2 = buf[i * width + j + 1];
+
+			data_array[array_idx++] = (n2 << 4) | n1;
+		}
+	}
+
+	/* Write out update in one go since horizontal addressing mode is used */
+	ret = ssd130x_write_data(ssd130x, data_array, columns * rows);
+
+	return ret;
+}
+
+static void ssd132x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
+{
+	memset(data_array, 0, ssd130x->data_array_size);
+
+	/* Write out update in one go since horizontal addressing mode is used */
+	ssd130x_write_data(ssd130x, data_array, ssd130x->data_array_size);
+}
+
 static const struct ssd130x_funcs ssd130x_family_funcs[] = {
 	[SSD130X_FAMILY] = {
 		.init = ssd130x_init,
@@ -652,6 +872,14 @@ static const struct ssd130x_funcs ssd130x_family_funcs[] = {
 		.clear_screen = ssd130x_clear_screen,
 		.fmt_convert = drm_fb_xrgb8888_to_mono,
 	},
+	[SSD132X_FAMILY] = {
+		.init = ssd132x_init,
+		.set_buffer_sizes = ssd132x_set_buffer_sizes,
+		.align_rect = ssd132x_align_rect,
+		.update_rect = ssd132x_update_rect,
+		.clear_screen = ssd132x_clear_screen,
+		.fmt_convert = drm_fb_xrgb8888_to_gray8,
+	}
 };
 
 static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb,
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index b508ab98be2f..e93288b5a9c2 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -32,6 +32,10 @@ enum ssd130x_variants {
 	SSD1306_ID,
 	SSD1307_ID,
 	SSD1309_ID,
+	/* ssd132x family */
+	SSD1322_ID,
+	SSD1325_ID,
+	SSD1327_ID,
 	NR_SSD130X_VARIANTS
 };
 
-- 
2.41.0

