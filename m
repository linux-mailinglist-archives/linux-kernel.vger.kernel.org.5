Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AB47EC372
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343941AbjKONQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbjKONQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:16:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1FE11D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700054162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g4aNlMTSkF6Z7WtRPqPRRN4O3d3mqRlG6UdzSZTHX4Q=;
        b=Zc6r4a5ELkoj29e+7WzDYM4gddcQRuATlVqetDnRFZZgI/Bth/MnbTt1/m1yBM7WvwWkvK
        FC2244qfuo5bNnNyURSFTE6QC5Q5RA8Lh29GoSDn49ce0nflDFQDBo0JEvivsfms9YVp1a
        lNYXkpCSaQo4uiylzn8+hwElSjUgmvA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-rcU_iRgZNAqTnCDQ5ps-Iw-1; Wed, 15 Nov 2023 08:16:01 -0500
X-MC-Unique: rcU_iRgZNAqTnCDQ5ps-Iw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4084d08235fso43103385e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054159; x=1700658959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4aNlMTSkF6Z7WtRPqPRRN4O3d3mqRlG6UdzSZTHX4Q=;
        b=EivhpINEIiqbKLoN4ELOESxhMt5oL62Pb5mzFJZVegJZSHyJWVFw7tUXCZvmbS5QzJ
         Lq5xfrKKUPT4wu2P9Wm4qnSsIgchaVvkdlb9eooz3D8nDLxeoEj7WqOe+nZHmfWeoIdl
         r5lYtRjCh8JngDc7IT9SQQI6ZUdK7bLJlPRvvwvRuoYHbgUMeqw9N9zOha6rIBbQvuhb
         NPkJB0UzeEB5HxERZe3iUmnmXE7A7DxjFUhlzwJzCDkvjUYqOzCaaV4zK49KwIDIy8vn
         XSq9a9yEgQ1GAL8VJoCA8kqfNA8gCOxrlxjCw/Ljv3dflQlq2ETB9SlTJln3a8vAKi+P
         U/OA==
X-Gm-Message-State: AOJu0YyyiCTOBVa5fd1RGDYI7/px/n5OE3xDrvtHBL/3PvG5iy7JHXFL
        bdy0KyztV4u51oGa29HFi8kAz3wY5oCxCS40gaMLL7GGvc/akc3A0QS2SdRKoqtsX9WNBDjZAI1
        Tv5zcZ0wcSkgdUJz/wX1vbFuDsBjUImldOZYkpr3ERfxCRf32PRSbb1LE+2J/r3l8LxbfSdrndl
        hYw6gZGLs=
X-Received: by 2002:a5d:49c4:0:b0:32d:bc6e:7f0d with SMTP id t4-20020a5d49c4000000b0032dbc6e7f0dmr8014903wrs.18.1700054159384;
        Wed, 15 Nov 2023 05:15:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqQImNi2W5AgGnJqpoMjjFu3Gcn9f11D4+yPZSZnB8N53BgtMbv3StA4wZdzqIdJ6tBIc4eg==
X-Received: by 2002:a5d:49c4:0:b0:32d:bc6e:7f0d with SMTP id t4-20020a5d49c4000000b0032dbc6e7f0dmr8014875wrs.18.1700054159031;
        Wed, 15 Nov 2023 05:15:59 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4202000000b0032d886039easm10435546wrq.14.2023.11.15.05.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:15:57 -0800 (PST)
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
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/5] drm/vmwgfx: Disable damage clipping if FB changed since last page-flip
Date:   Wed, 15 Nov 2023 14:15:42 +0100
Message-ID: <20231115131549.2191589-4-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115131549.2191589-1-javierm@redhat.com>
References: <20231115131549.2191589-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does per-buffer uploads and needs to force a full plane update
if the plane's attached framebuffer has change since the last page-flip.

Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Set struct drm_plane_state .ignore_damage_clips in vmwgfx plane's
  .atomic_check instead of using a different helpers (Thomas Zimmermann).

 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 818b7f109f53..f9364bf222e3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -837,10 +837,21 @@ int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
 {
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
+									   plane);
 	struct drm_crtc_state *crtc_state = NULL;
 	struct drm_framebuffer *new_fb = new_state->fb;
+	struct drm_framebuffer *old_fb = old_state->fb;
 	int ret;
 
+	/*
+	 * Ignore damage clips if the framebuffer attached to the plane's state
+	 * has changed since the last plane update (page-flip). In this case, a
+	 * full plane update should happen because uploads are done per-buffer.
+	 */
+	if (old_fb != new_fb)
+		new_state->ignore_damage_clips = true;
+
 	if (new_state->crtc)
 		crtc_state = drm_atomic_get_new_crtc_state(state,
 							   new_state->crtc);
-- 
2.41.0

