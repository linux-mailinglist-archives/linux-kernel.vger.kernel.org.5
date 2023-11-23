Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283E97F68E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjKWWNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjKWWNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:13:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594D41B6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700777604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U3hQPeRRqjnZSS8OWuMWpjh1Oj2NJuDlBMcX3dbEThk=;
        b=CQSFxF5Gj7EEPrrXOHwUJqemxWDXLaQYYZyG/36/HQjl9eNdOCN/U4g6LJkzD6fRDJcuOX
        HSyk4/PRaWxvk4i/nBpGNwpWtMr1LgTOzwxBiQMk6lnLPVozU7H+4O8vtucfkaspiIam4v
        YgS5GZZvU5Cp+M5rrk0hvFuX9DYUaEs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-YactF0ejPsGPsfqTirbi4g-1; Thu, 23 Nov 2023 17:13:23 -0500
X-MC-Unique: YactF0ejPsGPsfqTirbi4g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b349b9711so7664275e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700777601; x=1701382401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3hQPeRRqjnZSS8OWuMWpjh1Oj2NJuDlBMcX3dbEThk=;
        b=duxnrTRgk5VSA6IFya4fVY4ZxHCkwsUrSciDVakHWJnP9MCLwO8gKOiFtK54mVNf6v
         ES4bzBhRGhj0MDFoIRpo6Uj50TJqhTttpFZFZHTxw/zItzgKDBJoKhQlDn7CYB4hH9Kn
         54f0+9FpDPlXnyWQzHNnrOa+p+0G6izvEdz0lmvAltjXkWpqGQIfzvKyAHJtSSOMofBH
         IAkp465eAcik1ZhSJadCv80xI2NYNLgvGpLlnVqb7gR6GzdCHAPfPbpYEpkbIt12yVMA
         P2seRsTRUiinBIG2eXIloHPPf8DvWiYOB8p3Nupwp1KUseXLauvC++ZdbcEovpisEQKb
         9lxw==
X-Gm-Message-State: AOJu0YwSmaNWIZjx3hoePVqHtPy6mv+3Us82JosmJN3H0mKpQteThy7R
        XAFAMari341z25S6K1cHqH45qrGsx3oZ4UjQJ8qwNzr0CzjTOWMlfJ4JEIK2u6rEMEiiWMqYFVR
        GeguWfNgl6khzLuUaHHgmqPUw0iff6e/ibhcrYWSdzxHvypSGK+GSrASw32v2JtTpfuqACyYp+K
        +m4BN8QSw=
X-Received: by 2002:a05:600c:3507:b0:406:44e6:c00d with SMTP id h7-20020a05600c350700b0040644e6c00dmr662896wmq.2.1700777601655;
        Thu, 23 Nov 2023 14:13:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt+DfJY/Kdak/dZD3b9Ayp5iu9B3rETe6oqsTju4XsMZUCKTzrR+3d7cg40KCVTwvZqoHReg==
X-Received: by 2002:a05:600c:3507:b0:406:44e6:c00d with SMTP id h7-20020a05600c350700b0040644e6c00dmr662869wmq.2.1700777601339;
        Thu, 23 Nov 2023 14:13:21 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id je19-20020a05600c1f9300b004083729fc14sm3839537wmb.20.2023.11.23.14.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 14:13:20 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>, Zack Rusin <zackr@vmware.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Erico Nunes <nunes.erico@gmail.com>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        stable@vger.kernel.org,
        nerdopolis <bluescreen_avenger@verizon.net>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: [PATCH v4 2/5] drm/virtio: Disable damage clipping if FB changed since last page-flip
Date:   Thu, 23 Nov 2023 23:13:01 +0100
Message-ID: <20231123221315.3579454-3-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123221315.3579454-1-javierm@redhat.com>
References: <20231123221315.3579454-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does per-buffer uploads and needs to force a full plane update
if the plane's attached framebuffer has change since the last page-flip.

Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Acked-by: Sima Vetter <daniel.vetter@ffwll.ch>
---

(no changes since v2)

Changes in v2:
- Set struct drm_plane_state .ignore_damage_clips in virtio-gpu plane's
  .atomic_check instead of using a different helpers (Thomas Zimmermann).

 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a2e045f3a000..a1ef657eba07 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -79,6 +79,8 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
+										 plane);
 	bool is_cursor = plane->type == DRM_PLANE_TYPE_CURSOR;
 	struct drm_crtc_state *crtc_state;
 	int ret;
@@ -86,6 +88,14 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 	if (!new_plane_state->fb || WARN_ON(!new_plane_state->crtc))
 		return 0;
 
+	/*
+	 * Ignore damage clips if the framebuffer attached to the plane's state
+	 * has changed since the last plane update (page-flip). In this case, a
+	 * full plane update should happen because uploads are done per-buffer.
+	 */
+	if (old_plane_state->fb != new_plane_state->fb)
+		new_plane_state->ignore_damage_clips = true;
+
 	crtc_state = drm_atomic_get_crtc_state(state,
 					       new_plane_state->crtc);
 	if (IS_ERR(crtc_state))
-- 
2.41.0

