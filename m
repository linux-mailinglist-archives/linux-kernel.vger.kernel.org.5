Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BE77C78BC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442947AbjJLVkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347421AbjJLVkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:40:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86AEBB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697146756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJ9Uk8vtob23yRuVF7wPahjMzWrUIOh41bFxqRCyBio=;
        b=WBczC93Hzv5F01qwkPWczYVlzFe0St0+BiU0tfkt/ZT8HF6VsWn2apCvF2jLVHO0DJI5RZ
        9QRexNIomWoXO2y3fgBCdY+ySMZlUCiHAwSrJ6z/ln8cWc+TomOa1Nq/kGpUNUw9VtPREU
        R4kaTRmPou6Nco73epTHrFhmOsb+N4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-e63ZL4ctPCqtguVsfO0pIg-1; Thu, 12 Oct 2023 17:39:09 -0400
X-MC-Unique: e63ZL4ctPCqtguVsfO0pIg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4074f9d17a5so9885145e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697146748; x=1697751548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJ9Uk8vtob23yRuVF7wPahjMzWrUIOh41bFxqRCyBio=;
        b=pwNjABrAVjnIqNSGWCwhaS9XliANjghtykOTSnhDjdY3DGfOvDGHa7W1ovU7haUmqb
         b27JTifeLBvz0MeEYySysX/3hG6NY8a/1IcuxnhFe/w047y6WBw4daua4crvoip74RjC
         1URLryaGDwawSE8sNm9yNjrttcJrHDWnKbGox3F1HTyH7IgOWpN34WEXbMU5uO/wRluQ
         HOJYJjot3x8iMPI+klolyCVu+FB3gvl+q7RjQjR8nJ6M6TjsDnwVwiY+Vn3bPTdzZPym
         r1xsCSbAg0cG6J+Cwlypem7ER5QDKaW055pDUIFgJyKGdkQyqzA6unRqhlaSgk++rCc1
         HfPQ==
X-Gm-Message-State: AOJu0YxOSWSHG+cRfwKtKd9GczgaUyLv6U8Q46cm0rJ5VQebg906cVQw
        tVnVFdq+DO6V5rAPP5qLzHTIr0kfWPgV1Lr9B8fE2FKu1BzgzFLC7HA9qapSIJS9A6TO9ue+Yro
        A8nziSV9Sefo0VlIBTC3dYwEp+PCJAUjBB+0Wjut6jvDwAe/5rQZUiNCklfxMRRdKAOQ1uoqoNT
        kLC5k1XwE=
X-Received: by 2002:a05:600c:c9:b0:406:4d8f:9fee with SMTP id u9-20020a05600c00c900b004064d8f9feemr22839631wmm.24.1697146747918;
        Thu, 12 Oct 2023 14:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVwgjP/Hf7E+GTWU2/1n528HLM8zVIW2Oo2fN83cMqwCJNV+YlT48U377E2jCVzQzV4FwMbQ==
X-Received: by 2002:a05:600c:c9:b0:406:4d8f:9fee with SMTP id u9-20020a05600c00c900b004064d8f9feemr22839612wmm.24.1697146747448;
        Thu, 12 Oct 2023 14:39:07 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c205700b004064741f855sm801123wmg.47.2023.10.12.14.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:39:07 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/6] drm/ssd130x: Add a controller family id to the device info data
Date:   Thu, 12 Oct 2023 23:38:32 +0200
Message-ID: <20231012213843.1151060-3-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012213843.1151060-1-javierm@redhat.com>
References: <20231012213843.1151060-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow the driver to have a per Solomon display controller modesetting
pipeline and support aother controller families besides SSD130x.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v3:
- Drop the per controller family functions table (Thomas Zimmermann).

Changes in v2:
- Squash patch that uses drm_format_info_min_pitch() to calculate dest_pitch
  with the following patch (Geert Uytterhoeven).
- Store ssd13xx_family_funcs[SSD130X_FAMILY] in struct ssd130x_deviceinfo
  (Geert Uytterhoeven).
- Don't mix switch (family_id) and ssd13xx_funcs[family_id] (Geert Uytterhoeven).
- Replace switch (family_id) by an .set_buffer_sizes (Geert Uytterhoeven).
- Move the rect alignment to a per chip family function (Geert Uytterhoeven).

 drivers/gpu/drm/solomon/ssd130x-i2c.c | 1 +
 drivers/gpu/drm/solomon/ssd130x-spi.c | 2 ++
 drivers/gpu/drm/solomon/ssd130x.c     | 5 +++++
 drivers/gpu/drm/solomon/ssd130x.h     | 7 +++++++
 4 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
index b4eb2d64bf6e..8f89b89d553f 100644
--- a/drivers/gpu/drm/solomon/ssd130x-i2c.c
+++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c
@@ -54,6 +54,7 @@ static void ssd130x_i2c_shutdown(struct i2c_client *client)
 }
 
 static const struct of_device_id ssd130x_of_match[] = {
+	/* ssd130x family */
 	{
 		.compatible = "sinowealth,sh1106",
 		.data = &ssd130x_variants[SH1106_ID],
diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
index 19ab4942cb33..257819bccbc8 100644
--- a/drivers/gpu/drm/solomon/ssd130x-spi.c
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -108,6 +108,7 @@ static void ssd130x_spi_shutdown(struct spi_device *spi)
 }
 
 static const struct of_device_id ssd130x_of_match[] = {
+	/* ssd130x family */
 	{
 		.compatible = "sinowealth,sh1106",
 		.data = &ssd130x_variants[SH1106_ID],
@@ -142,6 +143,7 @@ MODULE_DEVICE_TABLE(of, ssd130x_of_match);
  * not be needed for this driver to match the registered SPI devices.
  */
 static const struct spi_device_id ssd130x_spi_table[] = {
+	/* ssd130x family */
 	{ "sh1106",  SH1106_ID },
 	{ "ssd1305", SSD1305_ID },
 	{ "ssd1306", SSD1306_ID },
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 2852cddb098b..4df4c4ed61f1 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -104,6 +104,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.default_width = 132,
 		.default_height = 64,
 		.page_mode_only = 1,
+		.family_id = SSD130X_FAMILY,
 	},
 	[SSD1305_ID] = {
 		.default_vcomh = 0x34,
@@ -111,6 +112,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.default_dclk_frq = 7,
 		.default_width = 132,
 		.default_height = 64,
+		.family_id = SSD130X_FAMILY,
 	},
 	[SSD1306_ID] = {
 		.default_vcomh = 0x20,
@@ -119,6 +121,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.need_chargepump = 1,
 		.default_width = 128,
 		.default_height = 64,
+		.family_id = SSD130X_FAMILY,
 	},
 	[SSD1307_ID] = {
 		.default_vcomh = 0x20,
@@ -127,6 +130,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.need_pwm = 1,
 		.default_width = 128,
 		.default_height = 39,
+		.family_id = SSD130X_FAMILY,
 	},
 	[SSD1309_ID] = {
 		.default_vcomh = 0x34,
@@ -134,6 +138,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.default_dclk_frq = 10,
 		.default_width = 128,
 		.default_height = 64,
+		.family_id = SSD130X_FAMILY,
 	}
 };
 EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index bbe374453605..c562c2d00c16 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -24,7 +24,12 @@
 #define SSD130X_DATA				0x40
 #define SSD130X_COMMAND				0x80
 
+enum ssd130x_family_ids {
+	SSD130X_FAMILY
+};
+
 enum ssd130x_variants {
+	/* ssd130x family */
 	SH1106_ID,
 	SSD1305_ID,
 	SSD1306_ID,
@@ -42,6 +47,8 @@ struct ssd130x_deviceinfo {
 	bool need_pwm;
 	bool need_chargepump;
 	bool page_mode_only;
+
+	enum ssd130x_family_ids family_id;
 };
 
 struct ssd130x_device {
-- 
2.41.0

