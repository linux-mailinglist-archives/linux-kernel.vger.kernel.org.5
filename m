Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452417F68DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjKWWNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjKWWNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:13:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7F4BC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700777603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNr7AyogBLBECN5NVEc3sDwHAg2qPYRl5gFzwIza95Q=;
        b=XI9OJSV7ULp62EO3Ln5b/Sav/1he4KkkB/BpMPUqdi4VtgvwQxG2H5zHRlViIw3elqRhGU
        vJdlf6zqK40fkpgQmp7mEQj+hR+d0mf85e4XCBkuM8U7Fyl3Bne4+BgZ3L3K3PdlKwIwyS
        C5wWb+G1CLKyD5rWogNw7DG0ldV8YYo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-HCUyQTUWNgymwyPMCQNwbQ-1; Thu, 23 Nov 2023 17:13:21 -0500
X-MC-Unique: HCUyQTUWNgymwyPMCQNwbQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b3712ef28so4618845e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700777600; x=1701382400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNr7AyogBLBECN5NVEc3sDwHAg2qPYRl5gFzwIza95Q=;
        b=wpN33Y/Z6oWEM47E4ZFaSg2OBaFfhjwtwrxC+zchDluqPQ9eSzE32AAG1VAuJOg36r
         YlF9OvmHYurwtg05Uyh18miGBpA4VgjxKvAPqbzp/p8pQR6ql9OswXC809woqpXRQCKm
         7ey4fc3XUxWCfmCzkab7tg/oIT4AshYGbGQ1ZF+iMOfKbt+t8dAoxofzeBSy4JGXa8nU
         Q5X/ID61OAqp2IimemDYPJ74PmekVnojsRcVr1fR7ELkzujVYWss3oYbRKBqDzs5UtvD
         nUAbHhVVnlaZA5CNIv1OLloZPNztyV2tGq3vCYaxvkZeYcNM8sx+i0lQcjY1PJaP7WYr
         ImPg==
X-Gm-Message-State: AOJu0YzlutQ6X6z15w+VDTlDxQcK0nhfeWRBbAojcNTAmOsztMb0ihPF
        U8xHCHJNb8rFzRgh6OHWGPUj51EGfZchkMyAitLymAaHIpPZk9Ud3hyHBBwDh29WjamHTsrF2nr
        /Pes45dlxLkrKHCd4AMYLY8jgABpq7b0dJx/qzNEv9upnrukvz0xq1Oi+TtyWYpjNyaVAFa36qv
        jSrSTXMPI=
X-Received: by 2002:a05:600c:1c9d:b0:408:434c:dae7 with SMTP id k29-20020a05600c1c9d00b00408434cdae7mr695860wms.2.1700777599831;
        Thu, 23 Nov 2023 14:13:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsLgt3C+76rwt6+lTv0sowa6U49h5FFZqfpVdWRCJlUnBufhPrTXVPA1hV/im8nsFEBKfIcQ==
X-Received: by 2002:a05:600c:1c9d:b0:408:434c:dae7 with SMTP id k29-20020a05600c1c9d00b00408434cdae7mr695832wms.2.1700777599346;
        Thu, 23 Nov 2023 14:13:19 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0040b30be6244sm3233457wmq.24.2023.11.23.14.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 14:13:18 -0800 (PST)
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
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 1/5] drm: Allow drivers to indicate the damage helpers to ignore damage clips
Date:   Thu, 23 Nov 2023 23:13:00 +0100
Message-ID: <20231123221315.3579454-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123221315.3579454-1-javierm@redhat.com>
References: <20231123221315.3579454-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Acked-by: Sima Vetter <daniel.vetter@ffwll.ch>
---

Changes in v4:
- Refer in ignore_damage_clips kernel-doc to "Damage Tracking Properties"
  KMS documentation section (Sima Vetter).

Changes in v2:
- Add a struct drm_plane_state .ignore_damage_clips to set in the plane's
  .atomic_check, instead of having different helpers (Thomas Zimmermann).

 Documentation/gpu/drm-kms.rst       |  2 ++
 drivers/gpu/drm/drm_damage_helper.c |  3 ++-
 include/drm/drm_plane.h             | 10 ++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index 270d320407c7..a98a7e04e86f 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -548,6 +548,8 @@ Plane Composition Properties
 .. kernel-doc:: drivers/gpu/drm/drm_blend.c
    :doc: overview
 
+.. _damage_tracking_properties:
+
 Damage Tracking Properties
 --------------------------
 
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
index 79d62856defb..fef775200a81 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -190,6 +190,16 @@ struct drm_plane_state {
 	 */
 	struct drm_property_blob *fb_damage_clips;
 
+	/**
+	 * @ignore_damage_clips:
+	 *
+	 * Set by drivers to indicate the drm_atomic_helper_damage_iter_init()
+	 * helper that the @fb_damage_clips blob property should be ignored.
+	 *
+	 * See :ref:`damage_tracking_properties` for more information.
+	 */
+	bool ignore_damage_clips;
+
 	/**
 	 * @src:
 	 *
-- 
2.41.0

