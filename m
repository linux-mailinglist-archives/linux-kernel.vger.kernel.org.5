Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1401376558A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjG0OFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjG0OFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B2930C0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690466700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G2DWn0DKp8//6UIeLtFfeDcJfrBuTBNRBy0cXTadnVg=;
        b=Fmmb/fynB/ZCagn+Yt7NUuWf6K6mif851rpSF5VV3JwkPXQOLeLmZrIwuL3bca3O+6b/cA
        k1PQt+638Zto0yRMyb6HLML2kykwSNZWybZKeyFhV30680Wq1lWNTEU4dK98u5l9mLNjn3
        qBTS8WjvTLsb+pNjbiWbyKYwKgN2vgY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-2cLpnI1qPX-Bat0qTYedbg-1; Thu, 27 Jul 2023 10:04:58 -0400
X-MC-Unique: 2cLpnI1qPX-Bat0qTYedbg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31775a8546fso557337f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690466697; x=1691071497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2DWn0DKp8//6UIeLtFfeDcJfrBuTBNRBy0cXTadnVg=;
        b=iLyPgD+UNjGrNFXLRcq6F49mnuIvM56Cg9dHN9LMawahhHpnCxw08d9qdgjco7fqsD
         N8S75mV7Q+VrzNrXMIghHNu3qOyVzwW97ED6NnbSqAGro8sJg9jVIPP+VKcoNSjoJ7sp
         zAzcMqdJC/hh75H/bOMchx/AmDKCKjjLow/VBtSTBKM3ivVvW9JaafhUyOJbhP0l/hvi
         5TtaLhMJcgHcU2Dv10PDr4N+D1yxiP+fp+Lz4nPnoUdVSvQe0I67vX2J7/NO9m8QlLLC
         tZMj1fh54AEYzloIxrRFJQamW+jeIchQa8RMOFDHmlxj7pb5bbA9xn2yfmd1yuagcpu2
         fi0g==
X-Gm-Message-State: ABy/qLZybvIzE+BgFPlcOCfPtaC4+sL1eQQpba6rhdOKH7mnvQn0wSRH
        FkYuvnNLzgHJ/KfYH5Y2/oeh7+6qjnNvPhOqpWl8kyVFn+/bfXBgTwLVhFeNqIWFaUNBW7k9rf/
        894hLzeDF4r52RI12Nv8ytYN3g0eBC7uhTH15YDynzsjuPzpgDUhme02K/3LXA+P09y4BoHkS8P
        8yNhJ5V30=
X-Received: by 2002:a05:6000:10c5:b0:314:1fdc:796d with SMTP id b5-20020a05600010c500b003141fdc796dmr1552157wrx.70.1690466697481;
        Thu, 27 Jul 2023 07:04:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGoKzp+/7F3wq28GuRDTjwGfJtXThaYIvpbnYch1t9SBxjGtyBSlxrgK5b73PYNGXg/Dv01sQ==
X-Received: by 2002:a05:6000:10c5:b0:314:1fdc:796d with SMTP id b5-20020a05600010c500b003141fdc796dmr1552138wrx.70.1690466697030;
        Thu, 27 Jul 2023 07:04:57 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n7-20020a1c7207000000b003fbb8c7c799sm4754721wmc.30.2023.07.27.07.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:04:56 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Use shadow-buffer helpers when managing plane's state
Date:   Thu, 27 Jul 2023 16:04:19 +0200
Message-ID: <20230727140453.577445-1-javierm@redhat.com>
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

The commit 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's
.atomic_check() callback") moved the buffers allocation to be done in
the primary plane's .atomic_check() callback.

But it missed that since the driver uses a shadow-buffered plane, the
__drm_gem_{reset,duplicate,destroy}_shadow_plane() helper functions
must be used in the struct drm_plane_funcs handlers.

This was missed because the mentioned commit did not remove the macro
DRM_GEM_SHADOW_PLANE_FUNCS, which leads to the custom plane's atomic
state management handlers to not be used.

Fixes: 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's .atomic_check() callback")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index d2f8dd6a6347..971c425340c1 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -142,7 +142,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
 
 struct ssd130x_plane_state {
-	struct drm_plane_state base;
+	struct drm_shadow_plane_state base;
 	/* Intermediate buffer to convert pixels from XRGB8888 to HW format */
 	u8 *buffer;
 	/* Buffer to store pixels in HW format and written to the panel */
@@ -151,7 +151,7 @@ struct ssd130x_plane_state {
 
 static inline struct ssd130x_plane_state *to_ssd130x_plane_state(struct drm_plane_state *state)
 {
-	return container_of(state, struct ssd130x_plane_state, base);
+	return container_of(state, struct ssd130x_plane_state, base.base);
 }
 
 static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
@@ -689,11 +689,12 @@ static void ssd130x_primary_plane_reset(struct drm_plane *plane)
 	if (!ssd130x_state)
 		return;
 
-	__drm_atomic_helper_plane_reset(plane, &ssd130x_state->base);
+	__drm_gem_reset_shadow_plane(plane, &ssd130x_state->base);
 }
 
 static struct drm_plane_state *ssd130x_primary_plane_duplicate_state(struct drm_plane *plane)
 {
+	struct drm_shadow_plane_state *new_shadow_plane_state;
 	struct ssd130x_plane_state *old_ssd130x_state;
 	struct ssd130x_plane_state *ssd130x_state;
 
@@ -709,9 +710,11 @@ static struct drm_plane_state *ssd130x_primary_plane_duplicate_state(struct drm_
 	ssd130x_state->buffer = NULL;
 	ssd130x_state->data_array = NULL;
 
-	__drm_atomic_helper_plane_duplicate_state(plane, &ssd130x_state->base);
+	new_shadow_plane_state = &ssd130x_state->base;
 
-	return &ssd130x_state->base;
+	 __drm_gem_duplicate_shadow_plane_state(plane, new_shadow_plane_state);
+
+	return &new_shadow_plane_state->base;
 }
 
 static void ssd130x_primary_plane_destroy_state(struct drm_plane *plane,
@@ -722,7 +725,7 @@ static void ssd130x_primary_plane_destroy_state(struct drm_plane *plane,
 	kfree(ssd130x_state->data_array);
 	kfree(ssd130x_state->buffer);
 
-	__drm_atomic_helper_plane_destroy_state(&ssd130x_state->base);
+	__drm_gem_destroy_shadow_plane_state(&ssd130x_state->base);
 
 	kfree(ssd130x_state);
 }
@@ -741,7 +744,6 @@ static const struct drm_plane_funcs ssd130x_primary_plane_funcs = {
 	.atomic_duplicate_state = ssd130x_primary_plane_duplicate_state,
 	.atomic_destroy_state = ssd130x_primary_plane_destroy_state,
 	.destroy = drm_plane_cleanup,
-	DRM_GEM_SHADOW_PLANE_FUNCS,
 };
 
 static enum drm_mode_status ssd130x_crtc_helper_mode_valid(struct drm_crtc *crtc,
-- 
2.41.0

