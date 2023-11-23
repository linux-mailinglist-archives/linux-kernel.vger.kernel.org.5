Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9867F68E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjKWWNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjKWWNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:13:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02CE10D7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700777609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dih2whL2MPf6NwDlCWNCaNjlgkoV00h0l9L+4gltDhE=;
        b=RsoZcTvtpiZ7Bw2iO5CPMeQw9bJ26x5t/IAReYx+Uua6PbKMd82Y9x2390NlttCdl1m4tD
        9AH8UJxznctmPga89B3mHhlgbefmIP/7Cw2RmOo9iG51deIrHiPW66++eQ9TCKhGl8tfut
        U5HadLXkoQRIXrY+9p0QkbmZbAZ8u+A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-I63rtFG7MvWF3fMaZiUCUg-1; Thu, 23 Nov 2023 17:13:27 -0500
X-MC-Unique: I63rtFG7MvWF3fMaZiUCUg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40845fe2d1cso6948565e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700777606; x=1701382406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dih2whL2MPf6NwDlCWNCaNjlgkoV00h0l9L+4gltDhE=;
        b=sSVVBc4dn7JkTqLcRY9868qZ3W4SkSPgtaKUN2mgrONmR72WdlNNddR/Yu5ws55tBW
         OmC+Hd34rCzpceZAK6wKrJEzuVp76CMHl3sqnZYBys6vEN2ibtU/sFmBKDMMK7fbTWSA
         ZQ3aodofTzEFBh4JJhJfG4kJtw4CQjzkj0SKUuSbcn1HRxLm1CaNiHcWd5QNcCIA7SYy
         7YpOziyKOuoR3WFrqHne/bHWVDkGSrk7CoU12kQi50bV+nCf9PfkTnTrIMyBeCcNeBTp
         TzDjyMfpoz6cL8x2Vbhw3+MLr5XgMbYWH2GbsUsGtOBNG8oABreu+L7IHy7Edqlg+TK6
         HWiQ==
X-Gm-Message-State: AOJu0Yxjg3ID/s/3XHuwqxMqH/dFZtUZUUk+BiIFslic6fBzP+PCLJh3
        09E8XY81Zo3JNxJZMZQjRAIzq7y0T84JKHO0sIAJSTrASfOd2jHZTMgygx7d6QuEHxSGWVgogHi
        pe+4DXN3jKFqY6m1AMAEXy0vI4/fjIo4CRIn3pOTzRoN811TEA8CIpvuR1um2bW9nvJzkr3g/tt
        l1JV6f84w=
X-Received: by 2002:a7b:cc8f:0:b0:40a:6235:e832 with SMTP id p15-20020a7bcc8f000000b0040a6235e832mr646341wma.19.1700777606366;
        Thu, 23 Nov 2023 14:13:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUS52KyNbklxpPEj23AckZsdZntJX98+LIJ9h/c+7dPvbvw5i7N6FBV/jDsPgq5cqyhTFDUQ==
X-Received: by 2002:a7b:cc8f:0:b0:40a:6235:e832 with SMTP id p15-20020a7bcc8f000000b0040a6235e832mr646322wma.19.1700777606063;
        Thu, 23 Nov 2023 14:13:26 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t5-20020adff045000000b00332e6a0e9f4sm1363883wro.75.2023.11.23.14.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 14:13:24 -0800 (PST)
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
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 4/5] drm/plane: Extend damage tracking kernel-doc
Date:   Thu, 23 Nov 2023 23:13:03 +0100
Message-ID: <20231123221315.3579454-5-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123221315.3579454-1-javierm@redhat.com>
References: <20231123221315.3579454-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Zack Rusin <zackr@vmware.com>
Acked-by: Sima Vetter <daniel.vetter@ffwll.ch>
---

Changes in v4:
- Add another paragraph to "Damage Tracking Properties" section to mention
  the fields that drivers with per-buffer upload target should check to set
  drm_plane_state.ignore_damage_clips (Sima Vetter).

Changes in v3:
- Fix typo in the kernel-doc (Simon Ser).
- Add a paragraph explaining what the problem in the kernel is and
  make it clear that the refeference documents are related to how
  user-space handles this case (Thomas Zimmermann).

 drivers/gpu/drm/drm_plane.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 24e7998d1731..662e0ba2707a 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1442,6 +1442,36 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
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
+ * iterate over the damaged regions. Drivers that handle buffer damage, must set
+ * &drm_plane_state.ignore_damage_clips for drm_atomic_helper_damage_iter_init()
+ * to know that damage clips should be ignored and return &drm_plane_state.src
+ * as the damage rectangle, to force a full plane update.
+ *
+ * Drivers with a per-buffer upload target could compare the &drm_plane_state.fb
+ * of the old and new plane states to determine if the framebuffer attached to a
+ * plane has changed or not since the last plane update. If &drm_plane_state.fb
+ * has changed, then &drm_plane_state.ignore_damage_clips must be set to true.
+ *
+ * That is because drivers with a per-plane upload target, expect the backing
+ * storage buffer to not change for a given plane. If the upload buffer changes
+ * between page flips, the new upload buffer has to be updated as a whole. This
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

