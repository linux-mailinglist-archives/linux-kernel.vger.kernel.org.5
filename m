Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3178D7E702C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344736AbjKIR0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344669AbjKIR0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:26:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF235AE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699550719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7tI1v3g4YDcTR34UtN17p6cKRPxCtoGaa2HZ2e5M58=;
        b=KK7Riq2KYMBru1Rk3duHY1otL91m67JKuA1567kQhFbOohEU/cw2G5TU3F9QyD3hZUeCv1
        J5LdspFgMmNXjiwDPL/7emo5TDAHY66iSNtGnj+Fv/MW8j6i4brWbAGWulc6TrdgCnd9nj
        ANq9gh2+FJeUMAhFxur+TOlDEf30VN4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-naX2DB-FN96uVHzC996Idg-1; Thu, 09 Nov 2023 12:25:18 -0500
X-MC-Unique: naX2DB-FN96uVHzC996Idg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c52cbb64c9so10985231fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550716; x=1700155516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7tI1v3g4YDcTR34UtN17p6cKRPxCtoGaa2HZ2e5M58=;
        b=WC8+Y284HbDHJdWMidukrALyg6TGYPl7pWrGB4MDzrLY1lFLM7m1LNOZuwW17l0YWK
         0PJH0UHZbz5Dgt7BOudt4mpULl+koNllZE5wWdcu8p1IEp7JqPgxV03oAzEiSKqIBS24
         qDlsjCfMI/eKBlylFtA4jXPQ7wLOFBOA2dDd9/Lhw1DvXoj/ZNqBGJ9MoUkbRtzLJcVs
         gK5Vxqnjgj/0/Kxj5RQEUch2tAFJsIacYXWiJWIc08R5OA/8onEOx7NsdLYXenHN8YKr
         z7mvdVFL7/OrXn72FEKxtMFaFirqA9MTO5PNkqQLPXNWgGrMBT842XaoLxnbEZje4EPk
         8grQ==
X-Gm-Message-State: AOJu0YyXus4m7BCsr2LqdV/Xbaf+RJepcTaOrC1IpZELLKX69mbs55mW
        lCmwP2VTxx2K0PYn9xqVMYOYT9UNW2zTVTeVxWTDQhbx0KuPkUnbGLU0L5KVwTNrc4/gvn40dJs
        7K3pkhx+LdUsCCuuDfN/OoAwha8J7A2ETd1bLiokJ7f53Z4bXCBlUJrE1nSfs9Cn+rHonRmKfat
        +yDC+iUVk=
X-Received: by 2002:ac2:549c:0:b0:500:b2f6:592 with SMTP id t28-20020ac2549c000000b00500b2f60592mr1983268lfk.50.1699550716579;
        Thu, 09 Nov 2023 09:25:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGse4RCF/67oKfST0CFHyjm+cpu2Cvl4v5lpvsxPTmc5ZS8cA1s3XNc9fBMoe6L+fz5hMsbpg==
X-Received: by 2002:ac2:549c:0:b0:500:b2f6:592 with SMTP id t28-20020ac2549c000000b00500b2f60592mr1983244lfk.50.1699550716301;
        Thu, 09 Nov 2023 09:25:16 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d6608000000b0032da75af3easm119414wru.80.2023.11.09.09.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:25:15 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Simon Ser <contact@emersion.fr>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 5/6] drm/plane: Extend damage tracking kernel-doc
Date:   Thu,  9 Nov 2023 18:24:39 +0100
Message-ID: <20231109172449.1599262-6-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109172449.1599262-1-javierm@redhat.com>
References: <20231109172449.1599262-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Damage Tracking Properties" section in the documentation doesn't have
info about the two type of damage handling: frame damage vs buffer damage.

Add that to the section, mention the different helpers that should be used
by drivers depending on the damage handling type used and refer to sites
that have more content about damage types and damage tracking in general.

Suggested-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_damage_helper.c | 10 ++++++----
 drivers/gpu/drm/drm_plane.c         | 22 +++++++++++++++++++---
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index b72062c9d31c..ac9986da7d7c 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -367,8 +367,9 @@ static bool __drm_atomic_helper_damage_merged(const struct drm_plane_state *old_
  * This function merges any valid plane damage clips into one rectangle and
  * returns it in @rect.
  *
- * For details see: drm_atomic_helper_damage_iter_init() and
- * drm_atomic_helper_damage_iter_next().
+ * For details see: drm_atomic_helper_damage_iter_init(),
+ * drm_atomic_helper_damage_iter_next() and
+ * `Damage Tracking Properties`_.
  *
  * Note that this helper is for drivers that do per-plane uploads and expect
  * to handle frame damages. Drivers that do per-buffer uploads instead should
@@ -400,8 +401,9 @@ EXPORT_SYMBOL(drm_atomic_helper_damage_merged);
  * full plane update should happen. It also ensure helper iterator will return
  * &drm_plane_state.src as damage.
  *
- * For details see: drm_atomic_helper_buffer_damage_iter_init() and
- * drm_atomic_helper_damage_iter_next().
+ * For details see: drm_atomic_helper_buffer_damage_iter_init(),
+ * drm_atomic_helper_damage_iter_next() and
+ * `Damage Tracking Properties`_.
  *
  * Returns:
  * True if there is valid buffer damage otherwise false.
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 24e7998d1731..f137a99b3435 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1439,9 +1439,25 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
  *
  * Drivers that are interested in damage interface for plane should enable
  * FB_DAMAGE_CLIPS property by calling drm_plane_enable_fb_damage_clips().
- * Drivers implementing damage can use drm_atomic_helper_damage_iter_init() and
- * drm_atomic_helper_damage_iter_next() helper iterator function to get damage
- * rectangles clipped to &drm_plane_state.src.
+ *
+ * Note that there are two types of damage handling: frame damage and buffer
+ * damage. The drivers implementing a per-plane or per-CRTC upload target and
+ * need to handle frame damage can use drm_atomic_helper_damage_iter_init(),
+ * but drivers implementing a per-buffer upload target and need to handle buffer
+ * damage should use drm_atomic_helper_buffer_damage_iter_init() helper instead.
+ *
+ * Once the iterator has been initialized by the damage helpers mentioned above,
+ * the drm_atomic_helper_damage_iter_next() helper iterator function can be used
+ * to get damage rectangles clipped to &drm_plane_state.src.
+ *
+ * The type of damage handling implemented depends on the driver's upload target
+ * but notice that when using swap buffers, the returned damage rectangle is the
+ * &drm_plane_state.src, since a full plane update should happen. There is no
+ * buffer age support or similar damage accumulation algorithm implemented yet.
+ *
+ * For more information about the two type of damage, see:
+ *     https://registry.khronos.org/EGL/extensions/KHR/EGL_KHR_swap_buffers_with_damage.txt
+ *     https://emersion.fr/blog/2019/intro-to-damage-tracking/
  */
 
 /**
-- 
2.41.0

