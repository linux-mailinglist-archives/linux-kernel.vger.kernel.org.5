Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E227F68E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjKWWN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjKWWNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:13:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E210D1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700777607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eevPmuhRFAgVhLHOGTOOcRfbcoEzUftUVXb0Oh9ok7w=;
        b=XrVBv3AqLvNGaf15QiXuDYaXp7+w1htPBpJNE/Zn7qs64OqTUrq7xCWMA9vXBmDyDl3UUP
        Ht01vtT9QgSWrrMjfIf0ofkJfikM9ue7RjAl22N08yu194HX+ioPSxpWlYW+UguS6VFngm
        J9P/c9h+DnfC52SFTiFAoduOo4Xg+ok=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-vjnvqvc3OO6esU69qhtU4A-1; Thu, 23 Nov 2023 17:13:26 -0500
X-MC-Unique: vjnvqvc3OO6esU69qhtU4A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b349b990fso6276235e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700777604; x=1701382404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eevPmuhRFAgVhLHOGTOOcRfbcoEzUftUVXb0Oh9ok7w=;
        b=mRQGqiPnghjHo7RgaCdGpdj+k5XTMsRNEoUya59XXLU2U99FHBxnoULLIl4wiSousX
         ddpCp4/+ODaDI71m1O4jSUnqYKMcqdEfM5Ic+xkMFykvmRfQOAc4rRl4YxThTCLqksvV
         G1XGpRKL2aIsoEWtuQUjhOje3fPNYDh3HFjXrAKGOVP8EKdttxkmgg0yxVqGDIsTrcug
         T1vGW0TKyZmCzfQzjaxP/FIJg9yO6x+GVHJoUDzbCyEv+xDq9ewb35lo/edLPrbBpJbZ
         5qpQ1DrZlKDsZyoSNU2nU36d06ulOLOxfRd/QuPRpxc2a9db9B6athxA2owSOXcpvwoZ
         FVPA==
X-Gm-Message-State: AOJu0YxUiw2sxgmWKKrC0JckpghrJP3OTpsxmymG0ci7I30SkqSlONsJ
        TM73WiHLOCWpwwsWog9pYv0F1H3p/7A4UhrEgz4iR6WTXQDwSAqeqtzaf3mrHFfUEnsGwQ6ZBCc
        IQlcRkDiAzcvB+3C1udqWLu9YI79rYEfsw/ks9ksVi0gzJa2EtoBF61iQ3WWpcGjf75wNM80y3y
        nmP3lCEV4=
X-Received: by 2002:a05:600c:138e:b0:40b:3605:acda with SMTP id u14-20020a05600c138e00b0040b3605acdamr646923wmf.25.1700777604124;
        Thu, 23 Nov 2023 14:13:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6aWgfy8x/Q5jWLkQk58MrIjsjFwETk6FGO3Io9BSfMMwRCBkkQZXEsO4x5dsaE1onwWQGvg==
X-Received: by 2002:a05:600c:138e:b0:40b:3605:acda with SMTP id u14-20020a05600c138e00b0040b3605acdamr646901wmf.25.1700777603855;
        Thu, 23 Nov 2023 14:13:23 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b00405c7591b09sm3180629wmp.35.2023.11.23.14.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 14:13:22 -0800 (PST)
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
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 3/5] drm/vmwgfx: Disable damage clipping if FB changed since last page-flip
Date:   Thu, 23 Nov 2023 23:13:02 +0100
Message-ID: <20231123221315.3579454-4-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123221315.3579454-1-javierm@redhat.com>
References: <20231123221315.3579454-1-javierm@redhat.com>
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Acked-by: Sima Vetter <daniel.vetter@ffwll.ch>
---

(no changes since v2)

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

