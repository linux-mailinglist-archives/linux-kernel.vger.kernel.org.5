Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE587C9328
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjJNHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjJNHQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEFECA
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697267742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PmDJiv92acs9uEtKbZkCxo3ZKsi7KN41G3AhaT91mXg=;
        b=f2BSZDcZacLZAkDcFG28vz47DrasunIRZvSMs7aw8x0/c1mHjkkax35RQMlz3xiummEucW
        vYZlidziaQ2vt+vwrS4fYM+7L6PVA2pZGQF1X5rqaFF8NpnZVkjclotFuYcZ644sKD2GpT
        DH3EMTcdejFqqWQ8yjzBQNVgQa+nqsk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-JmWTT1rUOyeV18uDuFLqCA-1; Sat, 14 Oct 2023 03:15:31 -0400
X-MC-Unique: JmWTT1rUOyeV18uDuFLqCA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32da7983d20so33193f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697267729; x=1697872529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmDJiv92acs9uEtKbZkCxo3ZKsi7KN41G3AhaT91mXg=;
        b=E87Wf/A+KoJFjvfiars2as2azRcUx/5/kE8/OquWfSD7mu0x5iIEcNZxNaIM1uI+kf
         TOQJMEmguqS72GKNSm6XF0rEsQMEYq+NGYTPoo+5M3Df7cGQBfKg3HarB/NkKbUOK3wr
         WMyD00zs4RBEJP/auoPDLysIvHo1twkWanGRxPlqDmRYvcGaQZ56IIKD2jXGpDTfr4KS
         innFxdWb47PEiTp5p2MCLaPTIMMBqrfvUJx+gpUlfwYHcgI2mG2SHVoKv/4Ucv7fzfRm
         LzjbD/qyvqXdId4xh9DgXPlekBqiNW84HAHea6ICrjSxNKYHkb5MpCxpnTZ9iIHx2mg6
         S8ww==
X-Gm-Message-State: AOJu0YzWXgjNb1PoY/GW5yFFVFyYu1v7ZGiz7zYDH/G53Lav5a83BpGw
        14JeAqnM0x4iUXiEsU5VUmFBY3AaXt7vLhcOTqE7ox279f182jFcJDzIFJzOXLJGoUDPaDXTMmL
        mbV2jIZCRv2h/L/DdwX2RjFVZamCiHJjEXbTPX8CFJ7W4sn8PdJajil2PkKnw/vOK32JI9McSe7
        qiGTsO3AM=
X-Received: by 2002:adf:e892:0:b0:32d:92fc:a625 with SMTP id d18-20020adfe892000000b0032d92fca625mr1639297wrm.24.1697267729498;
        Sat, 14 Oct 2023 00:15:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+SHc9VHoureiTCX0rTZUMs+L5HVOkEPxo+4ovkcqtrG/uV48TSTOwAVrBwQLS3kfb8Zclcg==
X-Received: by 2002:adf:e892:0:b0:32d:92fc:a625 with SMTP id d18-20020adfe892000000b0032d92fca625mr1639265wrm.24.1697267728872;
        Sat, 14 Oct 2023 00:15:28 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d7-20020adfa347000000b0032d72f48555sm7028367wrb.36.2023.10.14.00.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:15:28 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 3/6] drm/ssd130x: Rename commands that are shared across chip families
Date:   Sat, 14 Oct 2023 09:15:05 +0200
Message-ID: <20231014071520.1342189-4-javierm@redhat.com>
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

There are some commands that are shared between the SSD130x and SSD132x
controller families, define these as a common SSD13XX set of commands.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

 drivers/gpu/drm/solomon/ssd130x-spi.c |  4 +--
 drivers/gpu/drm/solomon/ssd130x.c     | 47 +++++++++++++++------------
 drivers/gpu/drm/solomon/ssd130x.h     |  4 +--
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
index 257819bccbc8..89989da705d7 100644
--- a/drivers/gpu/drm/solomon/ssd130x-spi.c
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -34,10 +34,10 @@ static int ssd130x_spi_write(void *context, const void *data, size_t count)
 	struct spi_device *spi = t->spi;
 	const u8 *reg = data;
 
-	if (*reg == SSD130X_COMMAND)
+	if (*reg == SSD13XX_COMMAND)
 		gpiod_set_value_cansleep(t->dc, 0);
 
-	if (*reg == SSD130X_DATA)
+	if (*reg == SSD13XX_DATA)
 		gpiod_set_value_cansleep(t->dc, 1);
 
 	/* Remove control byte since is not used in a 4-wire SPI interface */
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 84093bcc8584..e11f16bf795e 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
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
@@ -171,20 +176,20 @@ static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
 }
 
 /*
- * Helper to write data (SSD130X_DATA) to the device.
+ * Helper to write data (SSD13XX_DATA) to the device.
  */
 static int ssd130x_write_data(struct ssd130x_device *ssd130x, u8 *values, int count)
 {
-	return regmap_bulk_write(ssd130x->regmap, SSD130X_DATA, values, count);
+	return regmap_bulk_write(ssd130x->regmap, SSD13XX_DATA, values, count);
 }
 
 /*
- * Helper to write command (SSD130X_COMMAND). The fist variadic argument
+ * Helper to write command (SSD13XX_COMMAND). The fist variadic argument
  * is the command to write and the following are the command options.
  *
- * Note that the ssd130x protocol requires each command and option to be
- * written as a SSD130X_COMMAND device register value. That is why a call
- * to regmap_write(..., SSD130X_COMMAND, ...) is done for each argument.
+ * Note that the ssd13xx protocol requires each command and option to be
+ * written as a SSD13XX_COMMAND device register value. That is why a call
+ * to regmap_write(..., SSD13XX_COMMAND, ...) is done for each argument.
  */
 static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
 			     /* u8 cmd, u8 option, ... */...)
@@ -197,7 +202,7 @@ static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
 
 	do {
 		value = va_arg(ap, int);
-		ret = regmap_write(ssd130x->regmap, SSD130X_COMMAND, value);
+		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, value);
 		if (ret)
 			goto out_end;
 	} while (--count);
@@ -341,13 +346,13 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
 	int ret;
 
 	/* Set initial contrast */
-	ret = ssd130x_write_cmd(ssd130x, 2, SSD130X_CONTRAST, ssd130x->contrast);
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD13XX_CONTRAST, ssd130x->contrast);
 	if (ret < 0)
 		return ret;
 
 	/* Set segment re-map */
-	seg_remap = (SSD130X_SET_SEG_REMAP |
-		     SSD130X_SET_SEG_REMAP_SET(ssd130x->seg_remap));
+	seg_remap = (SSD13XX_SET_SEG_REMAP |
+		     SSD13XX_SET_SEG_REMAP_SET(ssd130x->seg_remap));
 	ret = ssd130x_write_cmd(ssd130x, 1, seg_remap);
 	if (ret < 0)
 		return ret;
@@ -360,7 +365,7 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
 		return ret;
 
 	/* Set multiplex ratio value */
-	ret = ssd130x_write_cmd(ssd130x, 2, SSD130X_SET_MULTIPLEX_RATIO, ssd130x->height - 1);
+	ret = ssd130x_write_cmd(ssd130x, 2, SSD13XX_SET_MULTIPLEX_RATIO, ssd130x->height - 1);
 	if (ret < 0)
 		return ret;
 
@@ -915,7 +920,7 @@ static void ssd130x_encoder_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		goto power_off;
 
-	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_ON);
+	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
 	backlight_enable(ssd130x->bl_dev);
 
@@ -934,7 +939,7 @@ static void ssd130x_encoder_atomic_disable(struct drm_encoder *encoder,
 
 	backlight_disable(ssd130x->bl_dev);
 
-	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_OFF);
+	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_OFF);
 
 	ssd130x_power_off(ssd130x);
 }
@@ -1010,7 +1015,7 @@ static int ssd130x_update_bl(struct backlight_device *bdev)
 
 	ssd130x->contrast = brightness;
 
-	ret = ssd130x_write_cmd(ssd130x, 1, SSD130X_CONTRAST);
+	ret = ssd130x_write_cmd(ssd130x, 1, SSD13XX_CONTRAST);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index c562c2d00c16..a5a25e054d2f 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -21,8 +21,8 @@
 
 #include <linux/regmap.h>
 
-#define SSD130X_DATA				0x40
-#define SSD130X_COMMAND				0x80
+#define SSD13XX_DATA				0x40
+#define SSD13XX_COMMAND				0x80
 
 enum ssd130x_family_ids {
 	SSD130X_FAMILY
-- 
2.41.0

