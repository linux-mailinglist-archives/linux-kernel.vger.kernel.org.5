Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F7C7EC36A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbjKONQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343883AbjKONQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:16:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB38121
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700054158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdkCfOkpqSODFD3esOEEEI4uePJ2ewc8SQpEyHY/6Ls=;
        b=U6Z/n1p9JiqDC6CIvylOv98blOLZil+5Sn44C/Bc1UnsV6Uv/mvGji5mqDQGzv2m6fbzLS
        lT8LefOSQ+/GsB++WOMHvDIVtNjNYomAprvbfiaZUD0j7DAOW4fLo+kjEVV0x7J1edAxQk
        kMsaIaDL1U9DM7PoYyD7blRkr+ZOlMA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-XOgwZ_QaOJi5G-tYXSK-Nw-1; Wed, 15 Nov 2023 08:15:57 -0500
X-MC-Unique: XOgwZ_QaOJi5G-tYXSK-Nw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40a5290e259so20789795e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054155; x=1700658955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdkCfOkpqSODFD3esOEEEI4uePJ2ewc8SQpEyHY/6Ls=;
        b=JfuC6tUtB5+C+nrFGFJS0nFApWgv9b7OuJrmIRUQ2Ag8vDgvyMchbvlGsULCVsfQ5L
         pjq1H+BIQrQ+R2XyKJr0sC5uPl4mwG0LHw1xbwjrzADF49Fo5ZiU2x76QMWSLxVMB5nN
         qd0gVnuIwuGFx9S8CGZNz3eWXdSle4BSGKZlA7x5vUj5COKxTJacFvT37VHPhhbUpbz/
         zMvmSkRRrTWZF8XwO9NN9sRwvK0zIxtd6/VY4ALpNq/IYU3HFtNQG3eZuEgeaOgzRzji
         Z+9uxdFkm4nwQXfINIym7fuvJi9mgjxNG3KxD1E4kbLd+vJ9vi9SL7YpsVHveXCdlTnA
         f2tQ==
X-Gm-Message-State: AOJu0Yw8hAHlbZ/Vt4jTHxFE85VnOluN/aEZa7bSjsBiwq38Ragbmfzy
        vuoOM0rJzZoyQOW/SPYwl/WmxXbkmxwJq9LueB1AnuftioEojN+a1uyu6RjHg2yqCzKm0H3uRH9
        vKJfWL+U7hnxxgiIAieBbEWIXCu0y09FoyF5bE7H1lZY5s5/0WxakXuAoc26yC+pg9Ywp51n0cT
        SbxPuC6QY=
X-Received: by 2002:a05:600c:1d12:b0:40a:4429:a994 with SMTP id l18-20020a05600c1d1200b0040a4429a994mr9334056wms.28.1700054155096;
        Wed, 15 Nov 2023 05:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoWZxbtxmm92MRQ4/GXfrWok30Xz8lAdSnCK8MW1HWy9dYer1O9tD6vbzy8D8AMhy89TPi+g==
X-Received: by 2002:a05:600c:1d12:b0:40a:4429:a994 with SMTP id l18-20020a05600c1d1200b0040a4429a994mr9334033wms.28.1700054154854;
        Wed, 15 Nov 2023 05:15:54 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bca50000000b0040841e79715sm14706785wml.27.2023.11.15.05.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:15:54 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Erico Nunes <nunes.erico@gmail.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        stable@vger.kernel.org,
        nerdopolis <bluescreen_avenger@verizon.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/5] drm: Allow drivers to indicate the damage helpers to ignore damage clips
Date:   Wed, 15 Nov 2023 14:15:40 +0100
Message-ID: <20231115131549.2191589-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115131549.2191589-1-javierm@redhat.com>
References: <20231115131549.2191589-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It allows drivers to set a struct drm_plane_state .ignore_damage_clips in
their plane's .atomic_check callback, as an indication to damage helpers
such as drm_atomic_helper_damage_iter_init() that the damage clips should
be ignored.

To be used by drivers that do per-buffer (e.g: virtio-gpu) uploads (rather
than per-plane uploads), since these type of drivers need to handle buffer
damages instead of frame damages.

That way, these drivers could force a full plane update if the framebuffer
attached to a plane's state has changed since the last update (page-flip).

Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Add a struct drm_plane_state .ignore_damage_clips to set in the plane's
  .atomic_check, instead of having different helpers (Thomas Zimmermann).

 drivers/gpu/drm/drm_damage_helper.c | 3 ++-
 include/drm/drm_plane.h             | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index d8b2955e88fd..afb02aae707b 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -241,7 +241,8 @@ drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
 	iter->plane_src.x2 = (src.x2 >> 16) + !!(src.x2 & 0xFFFF);
 	iter->plane_src.y2 = (src.y2 >> 16) + !!(src.y2 & 0xFFFF);
 
-	if (!iter->clips || !drm_rect_equals(&state->src, &old_state->src)) {
+	if (!iter->clips || state->ignore_damage_clips ||
+	    !drm_rect_equals(&state->src, &old_state->src)) {
 		iter->clips = NULL;
 		iter->num_clips = 0;
 		iter->full_update = true;
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 79d62856defb..cc2e8fc35fd2 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -190,6 +190,14 @@ struct drm_plane_state {
 	 */
 	struct drm_property_blob *fb_damage_clips;
 
+	/**
+	 * @ignore_damage_clips:
+	 *
+	 * Set by drivers to indicate the drm_atomic_helper_damage_iter_init()
+	 * helper that the @fb_damage_clips blob property should be ignored.
+	 */
+	bool ignore_damage_clips;
+
 	/**
 	 * @src:
 	 *
-- 
2.41.0

