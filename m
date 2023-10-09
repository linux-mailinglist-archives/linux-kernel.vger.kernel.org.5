Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2707BE9B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378297AbjJISh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377787AbjJIShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD51AA4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696876581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j5ZrsHwzLorvUYPP8a8dcsR2FiW1aaopcCHsyKU7r9w=;
        b=UBzBED79ZspZUSpwFPDhuu77j5bq3SV7TBGTPYtEI/0e6++NXZWZk/I8tqXeMN2/cs81rc
        vLEsewLqO0fXVZSaklH/GSIGuNTUu8jEMDcYvXWv66D97yYY8uQPhxf4C/GYyv4N1msTGy
        Bt1tUcBrDmf7ZdQvQJfRoZPt4F7jV8A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-5X6HZGfrPbeygmPqagbHJA-1; Mon, 09 Oct 2023 14:36:05 -0400
X-MC-Unique: 5X6HZGfrPbeygmPqagbHJA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-323334992fbso3420622f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876564; x=1697481364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5ZrsHwzLorvUYPP8a8dcsR2FiW1aaopcCHsyKU7r9w=;
        b=sZmxvDMGHE5pdZbgeOY6rr31VEISZAMfgjY8ApUBS6Mv59MlwnEIpaIhMgmJr3y2PP
         HiLl6b2WsNZhAreChxKfdKzKED0Tu/TqN40ndU7oA7j4dlinfkg49ImJbBO5m3zHWJ1y
         hm3hHc/YSuPQ8kMBdDU0fEgEjU4ZueBESMappCYkfKtu8nqxlBpOmzcYRhcU+gP5Y/7D
         Zkozs5/oDzwUwa5+0DzdxKOlu/OLaJ82jtT0yCZI4KrRnLYcL2dBdD/Iu07kakd0Slrz
         OY691F0b1uJ26erkmcSQxYIbHFRkN3ntnHGjkT1bWZ/5JU4wucsgKgd6/LDWvIxPmrGg
         hTSQ==
X-Gm-Message-State: AOJu0Yz5Cip8n320gB3AEC+e0chgFNzlwQkRswXVk1ydHATATKud51Jh
        tQWygg2qXuoqkKf3gYcUPhLc8SyiI3HO/8W8sm+2lG0bmR/U43mpzW5EEjOZoWOdjcsZpUnIvDB
        eD+P/0BvV4nbCKI1XR9WGgzgsV20MGK3hdnMN1YAyaG6BZ3BOroSKyZD/wjKy0UzGXFBjxskmYv
        ktigy7TgQ=
X-Received: by 2002:a5d:5187:0:b0:31f:ec06:20f with SMTP id k7-20020a5d5187000000b0031fec06020fmr13559055wrv.14.1696876564247;
        Mon, 09 Oct 2023 11:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqZW1dmkwdaHjEnu5wPTZrKs4GUXK67CJwBipf1KKjzq7yNzfyAyt2SuzJkZ1eYkixZxo4Qg==
X-Received: by 2002:a5d:5187:0:b0:31f:ec06:20f with SMTP id k7-20020a5d5187000000b0031fec06020fmr13559037wrv.14.1696876563940;
        Mon, 09 Oct 2023 11:36:03 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x8-20020adfcc08000000b003296bb21c77sm9747623wrh.80.2023.10.09.11.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:36:03 -0700 (PDT)
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
Subject: [PATCH 4/8] drm/ssd13xx: Use drm_format_info_min_pitch() to calculate the dest_pitch
Date:   Mon,  9 Oct 2023 20:34:18 +0200
Message-ID: <20231009183522.543918-5-javierm@redhat.com>
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

Don't assume bpp of 1 and instead compute the destination pitch using the
intermediate buffer pixel format info when doing a format conversion.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd13xx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd13xx.c b/drivers/gpu/drm/solomon/ssd13xx.c
index d29be17665b5..9747f8656636 100644
--- a/drivers/gpu/drm/solomon/ssd13xx.c
+++ b/drivers/gpu/drm/solomon/ssd13xx.c
@@ -148,6 +148,8 @@ struct ssd13xx_plane_state {
 	struct drm_shadow_plane_state base;
 	/* Intermediate buffer to convert pixels from XRGB8888 to HW format */
 	u8 *buffer;
+	/* Pixel format info for the intermediate buffer */
+	const struct drm_format_info *fi;
 };
 
 static inline struct ssd13xx_crtc_state *to_ssd13xx_crtc_state(struct drm_crtc_state *state)
@@ -602,8 +604,9 @@ static void ssd13xx_clear_screen(struct ssd13xx_device *ssd13xx, u8 *data_array)
 
 static int ssd13xx_fb_blit_rect(struct drm_framebuffer *fb,
 				const struct iosys_map *vmap,
-				struct drm_rect *rect,
-				u8 *buf, u8 *data_array)
+				struct drm_rect *rect, u8 *buf,
+				const struct drm_format_info *fi,
+				u8 *data_array)
 {
 	struct ssd13xx_device *ssd13xx = drm_to_ssd13xx(fb->dev);
 	struct iosys_map dst;
@@ -614,7 +617,7 @@ static int ssd13xx_fb_blit_rect(struct drm_framebuffer *fb,
 	rect->y1 = round_down(rect->y1, SSD130X_PAGE_HEIGHT);
 	rect->y2 = min_t(unsigned int, round_up(rect->y2, SSD130X_PAGE_HEIGHT), ssd13xx->height);
 
-	dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 8);
+	dst_pitch = drm_format_info_min_pitch(fi, 0, drm_rect_width(rect));
 
 	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
 	if (ret)
@@ -664,6 +667,8 @@ static int ssd13xx_primary_plane_atomic_check(struct drm_plane *plane,
 	if (!ssd13xx_state->buffer)
 		return -ENOMEM;
 
+	ssd13xx_state->fi = fi;
+
 	return 0;
 }
 
@@ -695,6 +700,7 @@ static void ssd13xx_primary_plane_atomic_update(struct drm_plane *plane,
 
 		ssd13xx_fb_blit_rect(fb, &shadow_plane_state->data[0], &dst_clip,
 				     ssd13xx_plane_state->buffer,
+				     ssd13xx_plane_state->fi,
 				     ssd13xx_crtc_state->data_array);
 	}
 
-- 
2.41.0

