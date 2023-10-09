Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CF47BE9B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378095AbjJIShY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378121AbjJIShK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159C8B7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696876577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQtzxS22vOw1sYR83d0Rh3aDs2Kq0xcl9WK0ryRbJEA=;
        b=KuQ1jihf1IFIGecFzJgt5Nzrls+S6H/iKTBoRlIDthvlvfotYCKiCsy/kCM0B4woMBfjWG
        zEnrIZ2C72RcKhOEz5Hr79jvSpWs6Nx01CUMvqaj1vahIqZroNbEigdLDqPY3vcYxxZnvm
        P/1Ml/U1oBSgNdAa9+NjM42GkN6Dqfo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-qDZySENjOxGobsVmlMK9ig-1; Mon, 09 Oct 2023 14:36:01 -0400
X-MC-Unique: qDZySENjOxGobsVmlMK9ig-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-323306960e3so3212687f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876560; x=1697481360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQtzxS22vOw1sYR83d0Rh3aDs2Kq0xcl9WK0ryRbJEA=;
        b=E76NZL7U22YQl8JKRQdXIaYfvQ9+l5yjq3hMds2QsjOitHwnttrmcpJSnvkoAXFspW
         5Pb1hZMzJhGDHeSAJt8peZRle0CZJJKZ4OiAKM1bUd29sw6zvQQlPe3DenEu3fbLCK/E
         mX5/PrQarUspCNJfjvdJ2Xsg8qKwZmhIavjWGi3D+HraPKjyYjmXtP2lj3j8i3CCx5qB
         E0uhBlxL1kSP8jF1t81MLVrRdAkO1OzfDuxA9PfufUoY17d3rNk0B3ry7SoxR6r5Eyq7
         nRcakaeXOThuFagReSU00Yfp3Zw1CEC7ZW6g5YazXio7NhgiSIkYyv15KfKcgOElNmB1
         klqw==
X-Gm-Message-State: AOJu0YyeTStptYv5rz6P+R/C7OyTitUzVGr2XIbN8EVl9lV2Hx24XD7K
        l7hKqFF4gvzVLoT1nqU1wRh6oqBZez8g/Bk/LVOsT/3Xc/45NtUXsiydqdrVrslyjJjAx79Tghh
        N0sWsn+YiS/tpk1tNLVs7PEhYDsEpUqxX0+EUU7vbR6xVS/384fLslq7R7w9tO8mc+onvSenT26
        Tmy8oZQLM=
X-Received: by 2002:adf:edce:0:b0:317:58e4:e941 with SMTP id v14-20020adfedce000000b0031758e4e941mr14527342wro.33.1696876559733;
        Mon, 09 Oct 2023 11:35:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLxco/wzAWiAo6IzkCN3y+muqM+F9g/NYV5e2UUAr05jilQZ8GgRD3J7WRGsBFHNEOBkwloQ==
X-Received: by 2002:adf:edce:0:b0:317:58e4:e941 with SMTP id v14-20020adfedce000000b0031758e4e941mr14527317wro.33.1696876559164;
        Mon, 09 Oct 2023 11:35:59 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc44a000000b004067e905f44sm11968813wmi.9.2023.10.09.11.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:35:58 -0700 (PDT)
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
Subject: [PATCH 1/8] drm/solomon: Rename ssd130x driver to ssd13xx
Date:   Mon,  9 Oct 2023 20:34:15 +0200
Message-ID: <20231009183522.543918-2-javierm@redhat.com>
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

The driver only supports the SSD130x family of Solomon OLED controllers
now, but will be extended to also support the SSD132x (4-bit grayscale)
and SSD133x (16-bit RGB) controller families. Rename driver to ssd13xx.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 MAINTAINERS                                   |  6 ++--
 drivers/gpu/drm/solomon/Kconfig               | 28 +++++++++----------
 drivers/gpu/drm/solomon/Makefile              |  6 ++--
 .../solomon/{ssd130x-i2c.c => ssd13xx-i2c.c}  | 10 +++----
 .../solomon/{ssd130x-spi.c => ssd13xx-spi.c}  | 14 +++++-----
 .../gpu/drm/solomon/{ssd130x.c => ssd13xx.c}  | 10 +++----
 .../gpu/drm/solomon/{ssd130x.h => ssd13xx.h}  |  8 +++---
 7 files changed, 41 insertions(+), 41 deletions(-)
 rename drivers/gpu/drm/solomon/{ssd130x-i2c.c => ssd13xx-i2c.c} (92%)
 rename drivers/gpu/drm/solomon/{ssd130x-spi.c => ssd13xx-spi.c} (93%)
 rename drivers/gpu/drm/solomon/{ssd130x.c => ssd13xx.c} (99%)
 rename drivers/gpu/drm/solomon/{ssd130x.h => ssd13xx.h} (94%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46ca5c4affdb..8eab0d9dca89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6728,12 +6728,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
 F:	drivers/gpu/drm/tiny/st7735r.c
 
-DRM DRIVER FOR SOLOMON SSD130X OLED DISPLAYS
+DRM DRIVER FOR SOLOMON SSD13XX OLED DISPLAYS
 M:	Javier Martinez Canillas <javierm@redhat.com>
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
-F:	drivers/gpu/drm/solomon/ssd130x*
+F:	Documentation/devicetree/bindings/display/solomon,ssd13*.yaml
+F:	drivers/gpu/drm/solomon/ssd13*
 
 DRM DRIVER FOR ST-ERICSSON MCDE
 M:	Linus Walleij <linus.walleij@linaro.org>
diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
index e170716d976b..ba9f631402bc 100644
--- a/drivers/gpu/drm/solomon/Kconfig
+++ b/drivers/gpu/drm/solomon/Kconfig
@@ -1,31 +1,31 @@
-config DRM_SSD130X
-	tristate "DRM support for Solomon SSD130x OLED displays"
+config DRM_SSD13XX
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
 
-	  If M is selected the module will be called ssd130x.
+	  If M is selected the module will be called ssd13xx.
 
-config DRM_SSD130X_I2C
-	tristate "DRM support for Solomon SSD130x OLED displays (I2C bus)"
-	depends on DRM_SSD130X && I2C
+config DRM_SSD13XX_I2C
+	tristate "DRM support for Solomon SSD13xx OLED displays (I2C bus)"
+	depends on DRM_SSD13XX && I2C
 	select REGMAP_I2C
 	help
-	  Say Y here if the SSD130x or SH110x OLED display is connected via
+	  Say Y here if the SSD13xx or SH110x OLED display is connected via
 	  I2C bus.
 
-	  If M is selected the module will be called ssd130x-i2c.
+	  If M is selected the module will be called ssd13xx-i2c.
 
-config DRM_SSD130X_SPI
-	tristate "DRM support for Solomon SSD130X OLED displays (SPI bus)"
-	depends on DRM_SSD130X && SPI
+config DRM_SSD13XX_SPI
+	tristate "DRM support for Solomon SSD13xx OLED displays (SPI bus)"
+	depends on DRM_SSD13XX && SPI
 	select REGMAP
 	help
-	  Say Y here if the SSD130x OLED display is connected via SPI bus.
+	  Say Y here if the SSD13xx OLED display is connected via SPI bus.
 
-	  If M is selected the module will be called ssd130x-spi.
+	  If M is selected the module will be called ssd13xx-spi.
diff --git a/drivers/gpu/drm/solomon/Makefile b/drivers/gpu/drm/solomon/Makefile
index b5fc792257d7..6cec14c4062d 100644
--- a/drivers/gpu/drm/solomon/Makefile
+++ b/drivers/gpu/drm/solomon/Makefile
@@ -1,3 +1,3 @@
-obj-$(CONFIG_DRM_SSD130X)	+= ssd130x.o
-obj-$(CONFIG_DRM_SSD130X_I2C)	+= ssd130x-i2c.o
-obj-$(CONFIG_DRM_SSD130X_SPI)	+= ssd130x-spi.o
+obj-$(CONFIG_DRM_SSD13XX)	+= ssd13xx.o
+obj-$(CONFIG_DRM_SSD13XX_I2C)	+= ssd13xx-i2c.o
+obj-$(CONFIG_DRM_SSD13XX_SPI)	+= ssd13xx-spi.o
diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd13xx-i2c.c
similarity index 92%
rename from drivers/gpu/drm/solomon/ssd130x-i2c.c
rename to drivers/gpu/drm/solomon/ssd13xx-i2c.c
index b4eb2d64bf6e..f4d0feaa8515 100644
--- a/drivers/gpu/drm/solomon/ssd130x-i2c.c
+++ b/drivers/gpu/drm/solomon/ssd13xx-i2c.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * DRM driver for Solomon SSD130x OLED displays (I2C bus)
+ * DRM driver for Solomon SSD13xx OLED displays (I2C bus)
  *
  * Copyright 2022 Red Hat Inc.
  * Author: Javier Martinez Canillas <javierm@redhat.com>
@@ -11,10 +11,10 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 
-#include "ssd130x.h"
+#include "ssd13xx.h"
 
-#define DRIVER_NAME	"ssd130x-i2c"
-#define DRIVER_DESC	"DRM driver for Solomon SSD130x OLED displays (I2C)"
+#define DRIVER_NAME	"ssd13xx-i2c"
+#define DRIVER_DESC	"DRM driver for Solomon SSD13xx OLED displays (I2C)"
 
 static const struct regmap_config ssd130x_i2c_regmap_config = {
 	.reg_bits = 8,
@@ -109,4 +109,4 @@ module_i2c_driver(ssd130x_i2c_driver);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_AUTHOR("Javier Martinez Canillas <javierm@redhat.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_IMPORT_NS(DRM_SSD130X);
+MODULE_IMPORT_NS(DRM_SSD13XX);
diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd13xx-spi.c
similarity index 93%
rename from drivers/gpu/drm/solomon/ssd130x-spi.c
rename to drivers/gpu/drm/solomon/ssd13xx-spi.c
index 19ab4942cb33..20d1e3711e2f 100644
--- a/drivers/gpu/drm/solomon/ssd130x-spi.c
+++ b/drivers/gpu/drm/solomon/ssd13xx-spi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * DRM driver for Solomon SSD130X OLED displays (SPI bus)
+ * DRM driver for Solomon SSD13xx OLED displays (SPI bus)
  *
  * Copyright 2022 Red Hat Inc.
  * Authors: Javier Martinez Canillas <javierm@redhat.com>
@@ -8,10 +8,10 @@
 #include <linux/spi/spi.h>
 #include <linux/module.h>
 
-#include "ssd130x.h"
+#include "ssd13xx.h"
 
-#define DRIVER_NAME	"ssd130x-spi"
-#define DRIVER_DESC	"DRM driver for Solomon SSD130X OLED displays (SPI)"
+#define DRIVER_NAME	"ssd13xx-spi"
+#define DRIVER_DESC	"DRM driver for Solomon SSD13xx OLED displays (SPI)"
 
 struct ssd130x_spi_transport {
 	struct spi_device *spi;
@@ -25,7 +25,7 @@ struct ssd130x_spi_transport {
  * prior to every data byte, that contains a bit with the D/C# value.
  *
  * These control bytes are considered registers by the ssd130x core driver
- * and can be used by the ssd130x SPI driver to determine if the data sent
+ * and can be used by the ssd13xx SPI driver to determine if the data sent
  * is for a command register or for the Graphic Display Data RAM (GDDRAM).
  */
 static int ssd130x_spi_write(void *context, const void *data, size_t count)
@@ -132,7 +132,7 @@ static const struct of_device_id ssd130x_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ssd130x_of_match);
 
-#if IS_MODULE(CONFIG_DRM_SSD130X_SPI)
+#if IS_MODULE(CONFIG_DRM_SSD13XX_SPI)
 /*
  * The SPI core always reports a MODALIAS uevent of the form "spi:<dev>", even
  * if the device was registered via OF. This means that the module will not be
@@ -166,4 +166,4 @@ module_spi_driver(ssd130x_spi_driver);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_AUTHOR("Javier Martinez Canillas <javierm@redhat.com>");
 MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS(DRM_SSD130X);
+MODULE_IMPORT_NS(DRM_SSD13XX);
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd13xx.c
similarity index 99%
rename from drivers/gpu/drm/solomon/ssd130x.c
rename to drivers/gpu/drm/solomon/ssd13xx.c
index 6dcf3e041113..0bf12965719a 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd13xx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * DRM driver for Solomon SSD130x OLED displays
+ * DRM driver for Solomon SSD13xx OLED displays
  *
  * Copyright 2022 Red Hat Inc.
  * Author: Javier Martinez Canillas <javierm@redhat.com>
@@ -34,10 +34,10 @@
 #include <drm/drm_rect.h>
 #include <drm/drm_probe_helper.h>
 
-#include "ssd130x.h"
+#include "ssd13xx.h"
 
-#define DRIVER_NAME	"ssd130x"
-#define DRIVER_DESC	"DRM driver for Solomon SSD130x OLED displays"
+#define DRIVER_NAME	"ssd13xx"
+#define DRIVER_DESC	"DRM driver for Solomon SSD13xx OLED displays"
 #define DRIVER_DATE	"20220131"
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
@@ -139,7 +139,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.page_height = 8,
 	}
 };
-EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
+EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD13XX);
 
 struct ssd130x_crtc_state {
 	struct drm_crtc_state base;
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd13xx.h
similarity index 94%
rename from drivers/gpu/drm/solomon/ssd130x.h
rename to drivers/gpu/drm/solomon/ssd13xx.h
index aa39b13615eb..f89ccd11cd29 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd13xx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Header file for:
- * DRM driver for Solomon SSD130x OLED displays
+ * DRM driver for Solomon SSD13xx OLED displays
  *
  * Copyright 2022 Red Hat Inc.
  * Author: Javier Martinez Canillas <javierm@redhat.com>
@@ -10,8 +10,8 @@
  * Copyright 2012 Free Electrons
  */
 
-#ifndef __SSD130X_H__
-#define __SSD130X_H__
+#ifndef __SSD13XX_H__
+#define __SSD13XX_H__
 
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
@@ -97,4 +97,4 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap);
 void ssd130x_remove(struct ssd130x_device *ssd130x);
 void ssd130x_shutdown(struct ssd130x_device *ssd130x);
 
-#endif /* __SSD130X_H__ */
+#endif /* __SSD13XX_H__ */
-- 
2.41.0

