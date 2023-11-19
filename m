Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AB57F0589
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 11:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjKSK5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 05:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjKSK52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 05:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B503AE5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700391444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wH8NdnscsW10bLIOLUB7ubQDTo0O64XVfw9Xt/3TIE=;
        b=fSI6ecqS5+V6/MWjONDg0SzTNTXwG4qdKpMbkHPo1ak9jBaLQClX0uzPUlvWPVlIHli48t
        An10Y5VHDbaGKD06vrrRRzv6YSYnPfkoyzY/pKdketpM9miAXxHtkFIlqfNUxP6CVhpFIa
        QNr+0SVGqdP3Fb7wORhQof8BA7q//NE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-C0IzsknpNIWXX_uTENr_4w-1; Sun, 19 Nov 2023 05:57:22 -0500
X-MC-Unique: C0IzsknpNIWXX_uTENr_4w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32d9cd6eb0bso1862972f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700391440; x=1700996240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wH8NdnscsW10bLIOLUB7ubQDTo0O64XVfw9Xt/3TIE=;
        b=IZ+g6sccgjcVI8nDO2ATvlX/5QjBJoeXApn/5DBQYd6sKTbaydM4HZZjkS0YHryaEk
         9yxLt3UsmejTORNYBwsSOCamup8vAqcmNHIadhcJRQmoEhHf0VwEWN8HCl+YDXDvx0E6
         IYXmGp6g8MdkzQFhYxt/D8XUgcoXF/lr+qL4n+hHwbiKQMv3D5QcOZGUsed3ABhQNSnD
         BwIPTqX44VqdlPW/w4mk1dBTfp9dYArDetoW6XdRHEPjyNC6w8sRWWiasysaqIFqrtnt
         alYyNMRAOVnq1MWn3wKhaNB0W3Cr48cCvONs9oCegTofDWm4JOGnxdAkHc3jH19Ce+o5
         D45A==
X-Gm-Message-State: AOJu0YwUhbleifPJmHeG07xJmBaiTP78Y/HsiN7BVAT5wKP4/BxyoVQi
        YNHa+uNEZBmOWQPunNOjl3bmCcyyGwDlyxhJWF9XnZjQMYw/hGK4SexfPxVaGKkzsbD/28KdLUW
        69RZCofxCFGJcPcv/8BcA0ugCgZNrzo8QaksWDF3Iu65SEf2oCYHB68T6Bdf1wHniKxrTCpQfCv
        yxc7BRUos=
X-Received: by 2002:adf:f78e:0:b0:32d:a430:beb with SMTP id q14-20020adff78e000000b0032da4300bebmr2829977wrp.39.1700391440297;
        Sun, 19 Nov 2023 02:57:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESPRpTD7i8bW20zZ0kQ4KfQTQl0DUNLoPKZy8ul6xpiKdduzWRa53ZcDf8J/6wMLLH73rZlQ==
X-Received: by 2002:adf:f78e:0:b0:32d:a430:beb with SMTP id q14-20020adff78e000000b0032da4300bebmr2829957wrp.39.1700391440007;
        Sun, 19 Nov 2023 02:57:20 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i3-20020a5d5583000000b0031f82743e25sm7726978wrv.67.2023.11.19.02.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 02:57:19 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Erico Nunes <nunes.erico@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 3/5] drm/vmwgfx: Disable damage clipping if FB changed since last page-flip
Date:   Sun, 19 Nov 2023 11:56:59 +0100
Message-ID: <20231119105709.3143489-4-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231119105709.3143489-1-javierm@redhat.com>
References: <20231119105709.3143489-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

