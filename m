Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF357EC371
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbjKONQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbjKONQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDF6130
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700054164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJqsY2/QsCenwJh5W290HFz55lPASu6G1HsKVTRTOh0=;
        b=QsOIIPXjEcipN66sXOeLYx+r5AMXp54yxPFDeJjQj/AFNt6OWbZ1R1rwbUVDDI1CJww7+x
        bVCn9HvbUfpNv+9abZl0WreQaPo9zrJYeWd16hG/CXrTX7izGcCQgczhQok882q5z8bpFO
        pnEVh97aE7G23Da0xj/ZWxBeOFcvOQg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-Mtn23c1cOL-IJQryoFb6jg-1; Wed, 15 Nov 2023 08:16:03 -0500
X-MC-Unique: Mtn23c1cOL-IJQryoFb6jg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40839252e81so43567185e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054161; x=1700658961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJqsY2/QsCenwJh5W290HFz55lPASu6G1HsKVTRTOh0=;
        b=nR/JxvDLFteIicTQ9wZho4KNh46Z2VorlHX0hiZ/k5rALHla/c4D6njTC97k7E9aOO
         2/ZlZnr1u5xreLWs52DUBDiuG1azYXRyjCALIzG3Efr+7v2z7GqnkzOnxl8lOTnp0/jO
         sH3gv/9siH20oCAiYkgdeg9I4uQAJdBCdVOsFYy5hUjHivLHIuHAeZAKP9EwoCxSkiEb
         GosTadLn6VftM2opF0w0hCioteRAkSECjlxFPpjNT1W0CHqZ4+QxAEWIkJ1t+oGu4vFr
         bWW4xhOGM9VW5akd/kH/6W4lMWt+pA36vw0ebpNc6t/MFhRquCEAzuiuKU2qMCRGUt0I
         LhKQ==
X-Gm-Message-State: AOJu0Yz3M249KmvAYVjOYa+wSl3IB7zADAgLhOAD0sny6KQbkY+F8dJ+
        iOzpHJMsZDh7i7KWSDHyUi/qJv7NSuujh1dFCoUS4qbGLUyJXgdoNQddwo+cgV6AJGVp5ki9SQ1
        /tZn9tv5Tj3D+xzBNsA+lc6QeSwzcfpndJqIaC94ItzOdd094jTZiWqPDaNicUZfGUkO2uf7mH8
        YRB+BcuyQ=
X-Received: by 2002:a05:600c:4fd2:b0:408:434c:dae7 with SMTP id o18-20020a05600c4fd200b00408434cdae7mr11319529wmq.2.1700054161330;
        Wed, 15 Nov 2023 05:16:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeDdWdtJ7aB4xucaGXBN4YZIdjMA0MwwhEfRrMy5dCuiFqOT3NDoUGtQljuQes2A4j3nnCww==
X-Received: by 2002:a05:600c:4fd2:b0:408:434c:dae7 with SMTP id o18-20020a05600c4fd200b00408434cdae7mr11319502wmq.2.1700054161047;
        Wed, 15 Nov 2023 05:16:01 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b00405959bbf4fsm15025163wmp.19.2023.11.15.05.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:16:00 -0800 (PST)
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
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 4/5] drm/plane: Extend damage tracking kernel-doc
Date:   Wed, 15 Nov 2023 14:15:43 +0100
Message-ID: <20231115131549.2191589-5-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115131549.2191589-1-javierm@redhat.com>
References: <20231115131549.2191589-1-javierm@redhat.com>
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

The "Damage Tracking Properties" section in the documentation doesn't have
info about the two type of damage handling: frame damage vs buffer damage.

Add it to the section and mention that helpers only support frame damage,
and how drivers handling buffer damage can indicate that the damage clips
should be ignored.

Also add references to further documentation about the two damage types.

Suggested-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
- Dropped Simon Ser's Reviwed-by tag because the text changed to adapt
  to the approach Thomas Zimmermann suggested for v2.

(no changes since v1)

 drivers/gpu/drm/drm_plane.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 24e7998d1731..3b1b8bca3065 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1442,6 +1442,26 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
  * Drivers implementing damage can use drm_atomic_helper_damage_iter_init() and
  * drm_atomic_helper_damage_iter_next() helper iterator function to get damage
  * rectangles clipped to &drm_plane_state.src.
+ *
+ * Note that there are two types of damage handling: frame damage and buffer
+ * damage. The type of damage handling implemented depends on a driver's upload
+ * target. Drivers implementing a per-plane or per-CRTC upload target need to
+ * handle frame damage while drivers implementing a per-buffer upload target
+ * need to handle buffer damage.
+ *
+ * The existing damage helpers only support the frame damage type, there is no
+ * buffer age support or similar damage accumulation algorithm implemented yet.
+ *
+ * Only drivers handling frame damage can use the mentiored damage helpers to
+ * iterate over the damaged regions. Drivers that handle buffer damage, need to
+ * set &struct drm_plane_state.ignore_damage_clips as an indication to
+ * drm_atomic_helper_damage_iter_init() that the damage clips should be ignored.
+ * In that case, the returned damage rectangle is the &drm_plane_state.src since
+ * a full plane update should happen.
+ *
+ * For more information about the two type of damage, see:
+ *     https://registry.khronos.org/EGL/extensions/KHR/EGL_KHR_swap_buffers_with_damage.txt
+ *     https://emersion.fr/blog/2019/intro-to-damage-tracking/
  */
 
 /**
-- 
2.41.0

