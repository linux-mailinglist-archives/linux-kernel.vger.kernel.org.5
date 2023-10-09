Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D557BE9AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378185AbjJIShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378155AbjJIShF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE089AF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696876572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZmdLaoW0F30jKaDHNrK6iK6jvqeSrkXDxHFhLB7O+XU=;
        b=XwSXWQ32xZHzse7TtRDwHu9iGSboEtb7EKsi52v4Lc7xRoUh5dOe88Vrh52y+HiIEGsxuC
        RtpRnfhqOhl/RpGTnPZShMQenJu4L7N2fR54AlsyZfHQVZFq3eZ/4ACRpcesC2RzCm20yQ
        6L/bRV1CCAn9++N/9U9eUvcB/FAwoZs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-hDtuha9eOsqQYWp2JIUL_g-1; Mon, 09 Oct 2023 14:36:08 -0400
X-MC-Unique: hDtuha9eOsqQYWp2JIUL_g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4064b38dc63so26333965e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876567; x=1697481367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmdLaoW0F30jKaDHNrK6iK6jvqeSrkXDxHFhLB7O+XU=;
        b=BIxmsfuk3k//lP4kmFu5E4HAMFcjBFKjpkmvz13EPJF+8ZovWHO6Pj2alKraX3i0Su
         WN3szofgaXBtlpV1MODJLKfihUpJHcCPxvhZe7YlRKBxWE26JjkCIJ0cUT9/cQJbr3eT
         BeVJ9Q4cR0+k75Gr+OewfhlzV+zj+lEgGMIwYTSYU+1/lr6sJZUFqqjGnwJXdVGog5lN
         U1k3aIOIslw8xJ2M41S5BDJlNQa0nk+40zrHxI3VUpwliP4rEa/eSRaC605n+1/jXPcs
         rJn5AB+k0z8HhnFTSaXnfaajlDr8/8CwDzUE3EznwNS0OWAZ2FejftQc9FoNSpbfKjp6
         5HEA==
X-Gm-Message-State: AOJu0Yw04XUEGysXR6Aq29Rcib+Fc2PbPXiRl8j1+q0/Kbp6oArpthwi
        VluVao6PwbjZlpIAkKtVmWuELecN4CjebLQRQ8K/BdayzmD5YiXzwdFHbch40+/mh2I0gOpFAPa
        J5umDM5Lm4gBP+e3tA2iX9xHbEKHXtV3Ul+hZ5s/J0MfdV88K4agYHdOYyj7WqggbrizGOMic+F
        qfofNhDrM=
X-Received: by 2002:a05:600c:4f51:b0:403:aced:f7f4 with SMTP id m17-20020a05600c4f5100b00403acedf7f4mr11347606wmq.12.1696876567046;
        Mon, 09 Oct 2023 11:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPiQQ2IHRmlkRAdSD3xtyc6wwq0bdpnugNy/1WSPvCyhAo3jLFf0Py7gaFUOe0tOZxAO9qMw==
X-Received: by 2002:a05:600c:4f51:b0:403:aced:f7f4 with SMTP id m17-20020a05600c4f5100b00403acedf7f4mr11347585wmq.12.1696876566650;
        Mon, 09 Oct 2023 11:36:06 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c230100b0040644e699a0sm14171296wmo.45.2023.10.09.11.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:36:06 -0700 (PDT)
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
Subject: [PATCH 6/8] drm/ssd13xx: Rename commands that are shared across chip families
Date:   Mon,  9 Oct 2023 20:34:20 +0200
Message-ID: <20231009183522.543918-7-javierm@redhat.com>
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

There are some commands that are shared between the SSD130x and SSD132x
controller families, define these as a common SSD13XX set of commands.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd13xx-spi.c |  4 +--
 drivers/gpu/drm/solomon/ssd13xx.c     | 45 +++++++++++++++------------
 drivers/gpu/drm/solomon/ssd13xx.h     |  4 +--
 3 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd13xx-spi.c b/drivers/gpu/drm/solomon/ssd13xx-spi.c
index a5ebe5475a49..2416756686cc 100644
--- a/drivers/gpu/drm/solomon/ssd13xx-spi.c
+++ b/drivers/gpu/drm/solomon/ssd13xx-spi.c
@@ -34,10 +34,10 @@ static int ssd13xx_spi_write(void *context, const void *data, size_t count)
 	struct spi_device *spi = t->spi;
 	const u8 *reg = data;
 
-	if (*reg == SSD130X_COMMAND)
+	if (*reg == SSD13XX_COMMAND)
 		gpiod_set_value_cansleep(t->dc, 0);
 
-	if (*reg == SSD130X_DATA)
+	if (*reg == SSD13XX_DATA)
 		gpiod_set_value_cansleep(t->dc, 1);
 
 	/* Remove control byte since is not used in a 4-wire SPI interface */
diff --git a/drivers/gpu/drm/solomon/ssd13xx.c b/drivers/gpu/drm/solomon/ssd13xx.c
index 5a426ac10c58..b30224856518 100644
--- a/drivers/gpu/drm/solomon/ssd13xx.c
+++ b/drivers/gpu/drm/solomon/ssd13xx.c
@@ -44,18 +44,24 @@
 
 #define SSD130X_PAGE_HEIGHT 8
 
+/* ssd13xx commands */
+#define SSD13XX_CONTRAST			0x81
+#define SSD13XX_SET_SEG_REMAP			0xa0
+#define SSD13XX_SET_MULTIPLEX_RATIO		0xa8
+#define SSD13XX_DISPLAY_OFF			0xae
+#define SSD13XX_DISPLAY_ON			0xaf
+
+#define SSD13XX_SET_SEG_REMAP_MASK		GENMASK(0, 0)
+#define SSD13XX_SET_SEG_REMAP_SET(val)		FIELD_PREP(SSD13XX_SET_SEG_REMAP_MASK, (val))
+
+/* ssd130x commands */
 #define SSD130X_PAGE_COL_START_LOW		0x00
 #define SSD130X_PAGE_COL_START_HIGH		0x10
 #define SSD130X_SET_ADDRESS_MODE		0x20
 #define SSD130X_SET_COL_RANGE			0x21
 #define SSD130X_SET_PAGE_RANGE			0x22
-#define SSD130X_CONTRAST			0x81
 #define SSD130X_SET_LOOKUP_TABLE		0x91
 #define SSD130X_CHARGE_PUMP			0x8d
-#define SSD130X_SET_SEG_REMAP			0xa0
-#define SSD130X_DISPLAY_OFF			0xae
-#define SSD130X_SET_MULTIPLEX_RATIO		0xa8
-#define SSD130X_DISPLAY_ON			0xaf
 #define SSD130X_START_PAGE_ADDRESS		0xb0
 #define SSD130X_SET_COM_SCAN_DIR		0xc0
 #define SSD130X_SET_DISPLAY_OFFSET		0xd3
@@ -65,13 +71,12 @@
 #define SSD130X_SET_COM_PINS_CONFIG		0xda
 #define SSD130X_SET_VCOMH			0xdb
 
+/* ssd130x commands accessors */
 #define SSD130X_PAGE_COL_START_MASK		GENMASK(3, 0)
 #define SSD130X_PAGE_COL_START_HIGH_SET(val)	FIELD_PREP(SSD130X_PAGE_COL_START_MASK, (val) >> 4)
 #define SSD130X_PAGE_COL_START_LOW_SET(val)	FIELD_PREP(SSD130X_PAGE_COL_START_MASK, (val))
 #define SSD130X_START_PAGE_ADDRESS_MASK		GENMASK(2, 0)
 #define SSD130X_START_PAGE_ADDRESS_SET(val)	FIELD_PREP(SSD130X_START_PAGE_ADDRESS_MASK, (val))
-#define SSD130X_SET_SEG_REMAP_MASK		GENMASK(0, 0)
-#define SSD130X_SET_SEG_REMAP_SET(val)		FIELD_PREP(SSD130X_SET_SEG_REMAP_MASK, (val))
 #define SSD130X_SET_COM_SCAN_DIR_MASK		GENMASK(3, 3)
 #define SSD130X_SET_COM_SCAN_DIR_SET(val)	FIELD_PREP(SSD130X_SET_COM_SCAN_DIR_MASK, (val))
 #define SSD130X_SET_CLOCK_DIV_MASK		GENMASK(3, 0)
@@ -171,20 +176,20 @@ static inline struct ssd13xx_device *drm_to_ssd13xx(struct drm_device *drm)
 }
 
 /*
- * Helper to write data (SSD130X_DATA) to the device.
+ * Helper to write data (SSD13XX_DATA) to the device.
  */
 static int ssd13xx_write_data(struct ssd13xx_device *ssd13xx, u8 *values, int count)
 {
-	return regmap_bulk_write(ssd13xx->regmap, SSD130X_DATA, values, count);
+	return regmap_bulk_write(ssd13xx->regmap, SSD13XX_DATA, values, count);
 }
 
 /*
- * Helper to write command (SSD130X_COMMAND). The fist variadic argument
+ * Helper to write command (SSD13XX_COMMAND). The fist variadic argument
  * is the command to write and the following are the command options.
  *
  * Note that the ssd13xx protocol requires each command and option to be
- * written as a SSD130X_COMMAND device register value. That is why a call
- * to regmap_write(..., SSD130X_COMMAND, ...) is done for each argument.
+ * written as a SSD13XX_COMMAND device register value. That is why a call
+ * to regmap_write(..., SSD13XX_COMMAND, ...) is done for each argument.
  */
 static int ssd13xx_write_cmd(struct ssd13xx_device *ssd13xx, int count,
 			     /* u8 cmd, u8 option, ... */...)
@@ -197,7 +202,7 @@ static int ssd13xx_write_cmd(struct ssd13xx_device *ssd13xx, int count,
 
 	do {
 		value = va_arg(ap, int);
-		ret = regmap_write(ssd13xx->regmap, SSD130X_COMMAND, value);
+		ret = regmap_write(ssd13xx->regmap, SSD13XX_COMMAND, value);
 		if (ret)
 			goto out_end;
 	} while (--count);
@@ -341,13 +346,13 @@ static int ssd130x_init(struct ssd13xx_device *ssd13xx)
 	int ret;
 
 	/* Set initial contrast */
-	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD130X_CONTRAST, ssd13xx->contrast);
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD13XX_CONTRAST, ssd13xx->contrast);
 	if (ret < 0)
 		return ret;
 
 	/* Set segment re-map */
-	seg_remap = (SSD130X_SET_SEG_REMAP |
-		     SSD130X_SET_SEG_REMAP_SET(ssd13xx->seg_remap));
+	seg_remap = (SSD13XX_SET_SEG_REMAP |
+		     SSD13XX_SET_SEG_REMAP_SET(ssd13xx->seg_remap));
 	ret = ssd13xx_write_cmd(ssd13xx, 1, seg_remap);
 	if (ret < 0)
 		return ret;
@@ -360,7 +365,7 @@ static int ssd130x_init(struct ssd13xx_device *ssd13xx)
 		return ret;
 
 	/* Set multiplex ratio value */
-	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD130X_SET_MULTIPLEX_RATIO, ssd13xx->height - 1);
+	ret = ssd13xx_write_cmd(ssd13xx, 2, SSD13XX_SET_MULTIPLEX_RATIO, ssd13xx->height - 1);
 	if (ret < 0)
 		return ret;
 
@@ -918,7 +923,7 @@ static void ssd13xx_encoder_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		goto power_off;
 
-	ssd13xx_write_cmd(ssd13xx, 1, SSD130X_DISPLAY_ON);
+	ssd13xx_write_cmd(ssd13xx, 1, SSD13XX_DISPLAY_ON);
 
 	backlight_enable(ssd13xx->bl_dev);
 
@@ -937,7 +942,7 @@ static void ssd13xx_encoder_atomic_disable(struct drm_encoder *encoder,
 
 	backlight_disable(ssd13xx->bl_dev);
 
-	ssd13xx_write_cmd(ssd13xx, 1, SSD130X_DISPLAY_OFF);
+	ssd13xx_write_cmd(ssd13xx, 1, SSD13XX_DISPLAY_OFF);
 
 	ssd13xx_power_off(ssd13xx);
 }
@@ -1013,7 +1018,7 @@ static int ssd13xx_update_bl(struct backlight_device *bdev)
 
 	ssd13xx->contrast = brightness;
 
-	ret = ssd13xx_write_cmd(ssd13xx, 1, SSD130X_CONTRAST);
+	ret = ssd13xx_write_cmd(ssd13xx, 1, SSD13XX_CONTRAST);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/gpu/drm/solomon/ssd13xx.h b/drivers/gpu/drm/solomon/ssd13xx.h
index e78d5ab87474..399b0c8b5680 100644
--- a/drivers/gpu/drm/solomon/ssd13xx.h
+++ b/drivers/gpu/drm/solomon/ssd13xx.h
@@ -22,8 +22,8 @@
 #include <linux/regmap.h>
 #include <linux/iosys-map.h>
 
-#define SSD130X_DATA				0x40
-#define SSD130X_COMMAND				0x80
+#define SSD13XX_DATA				0x40
+#define SSD13XX_COMMAND				0x80
 
 enum ssd13xx_family_ids {
 	SSD130X_FAMILY,
-- 
2.41.0

