Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618B77C9324
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjJNHQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNHQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A08FCC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697267731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51Qew2uNdXy46jxd83dk99KYf2VntkdlXCxlVa8EUwg=;
        b=X3qa3oBsICHRA4IjL5vHSN4PEoXANNrKq5c1o0hQYPmae91umrPkPkLci25GOtETusP35r
        rbgk+/Ji7mAAIpazg9pMWDFQfibLmUEeR5HylRFx5dCc0rqJpcLdOpU8BJWWT2SgpnOx+E
        WM+5CGOyY2ShSknmZNccapJ9pdSTUdA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-yOggCNMRMgu-U0_DF2YQxg-1; Sat, 14 Oct 2023 03:15:29 -0400
X-MC-Unique: yOggCNMRMgu-U0_DF2YQxg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50796a3ac70so1846645e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697267728; x=1697872528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51Qew2uNdXy46jxd83dk99KYf2VntkdlXCxlVa8EUwg=;
        b=u2x2qmimAjkyPr9WNB8qFjqwi9T891WnyX1Iki7JbrHMRnLV3gPYTVyOuEfMdhESwJ
         Rct9doKPI6J/TL4DyxaSiyFk6qxm/sCjYQNQHSfcX/FQy5YeEZ/xYccSfzNRQffbjvKi
         OA6t9pWnEhRJ5QnxUZrPbVGZ0JW3WVY54DbjZ/GOP4p/b2M5ZbUA/mr9ql4dAg7oI5jS
         HcI3u9SD7RFNsb84SbUXT0InDw2MlWNQukn2pABRcaMppED08W7owMrYhVibLW0MUgN4
         KBO95AAq5FzR6ptJj+kwzVWKmM3+WtSY6qxU+XMgUy20qcEEzpvZLeMzmyPn/yfIOsGK
         sXxQ==
X-Gm-Message-State: AOJu0Ywrh5GTVb1lF26ZqcGgrdZTB2BVQfD8Bn6hPkCBkbOjvIvcd4Km
        O57XYXt2+cVrKf1lBUPqQxnxGiBX++72mZ7zqnyU9mYHx5IhFCfNl7PNjtt5MgotzsHuj2qrSUl
        lMvi1UlXUWjsJLhGQ7li/8AdQESF/FCpk/rCwyK0Qb76w8LJYlLYieZmV+EKQatll5nBH04J29S
        4pKLSvrWU=
X-Received: by 2002:a05:6512:1154:b0:500:adbd:43e7 with SMTP id m20-20020a056512115400b00500adbd43e7mr27618219lfg.8.1697267727957;
        Sat, 14 Oct 2023 00:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbvAtxp96f1Iz1xPrysd04137EtIowqf7R+X8hiQiChyiNeBXJJsQGTOpcgvMJXWoYrR1zkQ==
X-Received: by 2002:a05:6512:1154:b0:500:adbd:43e7 with SMTP id m20-20020a056512115400b00500adbd43e7mr27618192lfg.8.1697267727527;
        Sat, 14 Oct 2023 00:15:27 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d55c5000000b003142e438e8csm3187600wrw.26.2023.10.14.00.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:15:27 -0700 (PDT)
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
Subject: [PATCH v4 2/6] drm/ssd130x: Add a controller family id to the device info data
Date:   Sat, 14 Oct 2023 09:15:04 +0200
Message-ID: <20231014071520.1342189-3-javierm@redhat.com>
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

To allow the driver to have a per Solomon display controller modesetting
pipeline and support aother controller families besides SSD130x.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v3)

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
index d530d13eef5a..84093bcc8584 100644
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

