Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7207F058C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 11:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjKSK5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 05:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjKSK5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 05:57:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B69E6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700391446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=272K2eB9MyeGkXnHsQZRLNPPDUgj78GVefhevePLWuQ=;
        b=W0viOslMd9bVTgnlZYPSEBJRjRV4VPXvVxQZwK8ma33EELvQs3vnkO3qT5oQNVS6wLGSuD
        yP6hdJQms4/qQ/ZIJe7z48/1HUX8UCfbJdIwZ7VlHj+RT2J35SQEvPGG8YSSGEeTSY8/wk
        iAjTVlcEMkGjZIT9kusWyaDxQ1v8OfI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-6UjYQEbmOC-NalJrZc6m7Q-1; Sun, 19 Nov 2023 05:57:24 -0500
X-MC-Unique: 6UjYQEbmOC-NalJrZc6m7Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4095fcbba0aso7883165e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700391442; x=1700996242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=272K2eB9MyeGkXnHsQZRLNPPDUgj78GVefhevePLWuQ=;
        b=oSx9R/CKTQJfgnHqbFuuPEmdVoAn0bfoI2Ac4gZpInLBguGc9Gy2ydsMH8cvxmgZVC
         iyDcsTQXqNHOe92jmxD1954MyRH6PHBM4XQU1oxpkiw8M+Nn7iimfDifWD0yPIQxRhDG
         aakST4Pe+gvPXnr614NSPBiYQ/RAzlONOJA/1sbbj70I1ngMZG55awT/5HKUjcZHt8di
         HDJ02isbJNZDHVqkvL2QU0nc9bo4P/WX0lBQRY30I0DS9VYdQYVpHhaiRMutOMArmTKF
         T3G9Kydbj4gZ1l2ZHlrcP3Q1IlE4GKKUtXHMzvcWH01oZmb+Tb9JKVVBCMUWfnGg6iUp
         M0Ag==
X-Gm-Message-State: AOJu0YxmqtXYyyEwHse2k+b7fm+ahqfmVUhkly59r9C6p25YIdW/MwKq
        0mH0RrsGoO8eOYdQa/Jw4lvBew6wDhEWIiHn+nTRhGiz3qBAjKoFA11lhx7WdmHFR3RXr7mXSse
        I8GtmPqTGwuJM844Z+6ehhvClP7mYEuNbNpgjIPlqKzUL77kGnmL47N8o3aYAHLD+jx0+TkMIj0
        0WSOhun6w=
X-Received: by 2002:a05:600c:3c8f:b0:40a:3e13:22aa with SMTP id bg15-20020a05600c3c8f00b0040a3e1322aamr3944008wmb.7.1700391442504;
        Sun, 19 Nov 2023 02:57:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYUt/8Jcf7ERcy5KXqfH+OtRpcgE15vf7fYhtZFTeCEEm0OJBSqdb3sD/eG2BQK1nsRynYmQ==
X-Received: by 2002:a05:600c:3c8f:b0:40a:3e13:22aa with SMTP id bg15-20020a05600c3c8f00b0040a3e1322aamr3943987wmb.7.1700391442133;
        Sun, 19 Nov 2023 02:57:22 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b0040a45fffd27sm14009431wmq.10.2023.11.19.02.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 02:57:20 -0800 (PST)
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
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 4/5] drm/plane: Extend damage tracking kernel-doc
Date:   Sun, 19 Nov 2023 11:57:00 +0100
Message-ID: <20231119105709.3143489-5-javierm@redhat.com>
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

The "Damage Tracking Properties" section in the documentation doesn't have
info about the two type of damage handling: frame damage vs buffer damage.

Add it to the section and mention that helpers only support frame damage,
and how drivers handling buffer damage can indicate that the damage clips
should be ignored.

Also add references to further documentation about the two damage types.

Suggested-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Simon Ser <contact@emersion.fr>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

Changes in v3:
- Fix typo in the kernel-doc (Simon Ser).
- Add a paragraph explaining what the problem in the kernel is and
  make it clear that the refeference documents are related to how
  user-space handles this case (Thomas Zimmermann).

 drivers/gpu/drm/drm_plane.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 24e7998d1731..87edd6c3c5a4 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1442,6 +1442,32 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
  * Drivers implementing damage can use drm_atomic_helper_damage_iter_init() and
  * drm_atomic_helper_damage_iter_next() helper iterator function to get damage
  * rectangles clipped to &drm_plane_state.src.
+ *
+ * Note that there are two types of damage handling: frame damage and buffer
+ * damage, the type of damage handling implemented depends on a driver's upload
+ * target. Drivers implementing a per-plane or per-CRTC upload target need to
+ * handle frame damage, while drivers implementing a per-buffer upload target
+ * need to handle buffer damage.
+ *
+ * The existing damage helpers only support the frame damage type, there is no
+ * buffer age support or similar damage accumulation algorithm implemented yet.
+ *
+ * Only drivers handling frame damage can use the mentioned damage helpers to
+ * iterate over the damaged regions. Drivers that handle buffer damage, need to
+ * set &struct drm_plane_state.ignore_damage_clips as an indication to
+ * drm_atomic_helper_damage_iter_init() that the damage clips should be ignored.
+ * In that case, the returned damage rectangle is the &drm_plane_state.src since
+ * a full plane update should happen.
+ *
+ * That is because drivers with a per-plane upload target, expect the backing
+ * storage buffer to not change for a given plane. If the upload buffer changes
+ * between page flips, the new  upload buffer has to be updated as a whole. This
+ * can be improved in the future if support for frame damage is added to the DRM
+ * damage helpers, similarly to how user-space already handle this case as it is
+ * explained in the following documents:
+ *
+ *     https://registry.khronos.org/EGL/extensions/KHR/EGL_KHR_swap_buffers_with_damage.txt
+ *     https://emersion.fr/blog/2019/intro-to-damage-tracking/
  */
 
 /**
-- 
2.41.0

