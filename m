Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28251763456
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjGZKzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGZKzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4819B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690368902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tfHzE8mqv6PAsMGXTnVJTu2nJA1vsdj//P7y8dVLEok=;
        b=OeFD0NDTPWwG2TiQoJlJYiqdT1bTRUM077b8k2so+7hyjwJNPZWOU0NOMvEYW7T8dnpHEW
        9XSEtr/oX0NB3c1EBlwOQ3olrXCyMiRXMKIFQ7I1MEh5WGl1RL1L043qQMiqkL5q4b5+KW
        MoGScOY/3G7O19IuKNK90ekdsq5RS0s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-zqRPB0TCPcGqtfWD9YGOLw-1; Wed, 26 Jul 2023 06:55:01 -0400
X-MC-Unique: zqRPB0TCPcGqtfWD9YGOLw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fdf1798575so3337156e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690368899; x=1690973699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfHzE8mqv6PAsMGXTnVJTu2nJA1vsdj//P7y8dVLEok=;
        b=NFmMC/0/dKMS1WhPrBg7OeaWLPp1RmhV5hguWd5dE2RkZadVdF2Ub3GLQQ7g03XLKz
         UgPFSdkUq+Rp3Q5/RUSOhIPIeNKWLiEv7fleYdYA/Yn6Iha9q5krlRwpzE0h12liQZgx
         qbRTT8rHTkpq0dJ0k7kzAjnLIoeC7MPGoEnaU00tAgzHpNtZIcSNexCB45x/nbe4j2PK
         j1xTqWTvL+NB5R2BxyBH5Xd5DzJSUAreyTC87tyVQZMZ5rcuMJF87mqBY3QdyqiHjfzR
         0UNeH9FcQ1fFpI81Gtd9HEIfiMLmNNFGM2GG3ydX/BVp4DWa77qknuXDJFMoEEclIH54
         Puag==
X-Gm-Message-State: ABy/qLbH3byO6zdt8epP/yV4Jwaa6rsC1mxlzbK2HLTeJGvnzSVylFMY
        dfoeEoUNIgNIx8ckpOl7+fI72BIwLliY5hS2mbQbVIgxV+EFqk1C4PDr7rgpfh9k/mcRKEF2k4B
        ymtp2pF5qMLgpaSUDomrTpzAdHxhrr2XDd09gbGnOs43npa5A5pGEn/xFMJbOzBNAZZbX5A4gJY
        JSADx94PQ=
X-Received: by 2002:a05:6512:34cd:b0:4fb:9d61:db44 with SMTP id w13-20020a05651234cd00b004fb9d61db44mr1036699lfr.12.1690368899232;
        Wed, 26 Jul 2023 03:54:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG4M6oiarh0Xm/7HopC7xRqk6r+6luRSOyTY/5/GDWP27gAFA5v2BnpBh3YFnDiAKxMpFWZ9A==
X-Received: by 2002:a05:6512:34cd:b0:4fb:9d61:db44 with SMTP id w13-20020a05651234cd00b004fb9d61db44mr1036676lfr.12.1690368898825;
        Wed, 26 Jul 2023 03:54:58 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n7-20020adffe07000000b003176c6e87b1sm4894703wrr.81.2023.07.26.03.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 03:54:58 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v5 1/2] drm/ssd130x: Inline the ssd130x_buf_{alloc,free}() function helpers
Date:   Wed, 26 Jul 2023 12:54:27 +0200
Message-ID: <20230726105433.389740-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only a single caller for both helper functions and these don't do
much other than allocate and free two buffers, so let's just inline them.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/solomon/ssd130x.c | 55 +++++++++++--------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index b4c376962629..51472a184ef9 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -146,38 +146,6 @@ static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
 	return container_of(drm, struct ssd130x_device, drm);
 }
 
-static int ssd130x_buf_alloc(struct ssd130x_device *ssd130x)
-{
-	unsigned int page_height = ssd130x->device_info->page_height;
-	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
-	const struct drm_format_info *fi;
-	unsigned int pitch;
-
-	fi = drm_format_info(DRM_FORMAT_R1);
-	if (!fi)
-		return -EINVAL;
-
-	pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
-
-	ssd130x->buffer = kcalloc(pitch, ssd130x->height, GFP_KERNEL);
-	if (!ssd130x->buffer)
-		return -ENOMEM;
-
-	ssd130x->data_array = kcalloc(ssd130x->width, pages, GFP_KERNEL);
-	if (!ssd130x->data_array) {
-		kfree(ssd130x->buffer);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void ssd130x_buf_free(struct ssd130x_device *ssd130x)
-{
-	kfree(ssd130x->data_array);
-	kfree(ssd130x->buffer);
-}
-
 /*
  * Helper to write data (SSD130X_DATA) to the device.
  */
@@ -709,6 +677,10 @@ static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
 {
 	struct drm_device *drm = encoder->dev;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
+	unsigned int page_height = ssd130x->device_info->page_height;
+	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
+	const struct drm_format_info *fi;
+	unsigned int pitch;
 	int ret;
 
 	ret = ssd130x_power_on(ssd130x);
@@ -719,9 +691,21 @@ static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		goto power_off;
 
-	ret = ssd130x_buf_alloc(ssd130x);
-	if (ret)
+	fi = drm_format_info(DRM_FORMAT_R1);
+	if (!fi)
+		goto power_off;
+
+	pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
+
+	ssd130x->buffer = kcalloc(pitch, ssd130x->height, GFP_KERNEL);
+	if (!ssd130x->buffer)
+		goto power_off;
+
+	ssd130x->data_array = kcalloc(ssd130x->width, pages, GFP_KERNEL);
+	if (!ssd130x->data_array) {
+		kfree(ssd130x->buffer);
 		goto power_off;
+	}
 
 	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_ON);
 
@@ -744,7 +728,8 @@ static void ssd130x_encoder_helper_atomic_disable(struct drm_encoder *encoder,
 
 	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_OFF);
 
-	ssd130x_buf_free(ssd130x);
+	kfree(ssd130x->data_array);
+	kfree(ssd130x->buffer);
 
 	ssd130x_power_off(ssd130x);
 }
-- 
2.41.0

