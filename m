Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC2E7EC368
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbjKONQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbjKONQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:16:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717FA11D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700054156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4lF7aMHaWE0StDFmSjkvXf9QppPYg6hsJ7Fo37wmlDE=;
        b=SBFJzhWNiZV7zMkfG2Fw00fjpD21P0bvqq+MRpluhQNpk236w0IP0kYmjhwUPubsPudiIm
        MnPASHVrqR+yAXSSqLmeOkxzC1wBaJzfa9OXhQ46JOwIwuD1REscOJDbwiGJAQ6jjQ8Rqz
        Hy0zdaz8zBauDKrIj/MQkl/FKRrn6fU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-8dHQHRuwNaeqz4aXsf2O8Q-1; Wed, 15 Nov 2023 08:15:55 -0500
X-MC-Unique: 8dHQHRuwNaeqz4aXsf2O8Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32fd8da34fbso3090604f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054153; x=1700658953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lF7aMHaWE0StDFmSjkvXf9QppPYg6hsJ7Fo37wmlDE=;
        b=p2mcRmi1uoK212BakDc8UqX2aKHBKoWOfy1msa34BWXnTK5UvLmYLNUx8sRUE//NEk
         lYMy+tzP+YM+gW/qaNlBZwg/VJq2e7Aa5yXhY6I5HBUroiZ4mi47G+J87jhr1mme0j/I
         R7+bVos8i30F8Yl3kKxDt7+BfladNb0JTXPsC1PB0O2eqRIak6Ond2Nba1KqW4PbjJ3a
         6adSxuSPH8emoGfeN7RtAH+tp/p1pR41Fqb3E8JPedrUjMYIQdCT7t75rWelPHcAomeu
         rOEMljEj+JmGHeS6q48Qf6UAM0E0jMYZK+g2HQi7M8UC3iH4NtBDidDODLJGKqx4W+oA
         oNbw==
X-Gm-Message-State: AOJu0YwE7VNb3Uw0y28za2cCPA6FQ6L6zMBgpSqilf1M1dLMBtje1E0i
        dRBNsZHcbBgiKqHYPMNJiravkhASDccxuDwa10W+PiLQgblOx0H2m/rfeYNUoh79D3B4yGwIhAN
        XOpBUXTonakBTHgXbKKf02B5qOjfDxjHzG8W2c5BMQILhLBl+OsC4MwbijHCXVuXJSNiiF1RYer
        Djex3NnwI=
X-Received: by 2002:a5d:64ef:0:b0:31c:8880:5d0f with SMTP id g15-20020a5d64ef000000b0031c88805d0fmr8815350wri.11.1700054153514;
        Wed, 15 Nov 2023 05:15:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8Akj/DP0M6gaPcJ9iKzQAqtuUVukMuYMObXNcXMXbVoCf04jCr7iPlpSq+gDQSE1T7tfrhg==
X-Received: by 2002:a5d:64ef:0:b0:31c:8880:5d0f with SMTP id g15-20020a5d64ef000000b0031c88805d0fmr8815312wri.11.1700054153053;
        Wed, 15 Nov 2023 05:15:53 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600000cc00b0032db4e660d9sm10551595wrx.56.2023.11.15.05.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:15:52 -0800 (PST)
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
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH v2 0/5] drm: Allow the damage helpers to handle buffer damage
Date:   Wed, 15 Nov 2023 14:15:39 +0100
Message-ID: <20231115131549.2191589-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
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

Hello,

This series is to fix an issue that surfaced after damage clipping was
enabled for the virtio-gpu by commit 01f05940a9a7 ("drm/virtio: Enable
fb damage clips property for the primary plane").

After that change, flickering artifacts was reported to be present with
both weston and wlroots wayland compositors when running in a virtual
machine. The cause was identified by Sima Vetter, who pointed out that
virtio-gpu does per-buffer uploads and for this reason it needs to do
a buffer damage handling, instead of frame damage handling.

Their suggestion was to extend the damage helpers to cover that case
and given that there's isn't a buffer damage accumulation algorithm
(e.g: buffer age), just do a full plane update if the framebuffer that
is attached to a plane changed since the last plane update (page-flip).

It is a v2 that addresses issues pointed out by Thomas Zimmermann in v1:
https://lists.freedesktop.org/archives/dri-devel/2023-November/430138.html

Patch #1 adds a ignore_damage_clips field to struct drm_plane_state to be
set by drivers that want the damage helpers to ignore the damage clips.

Patch #2 fixes the virtio-gpu damage handling logic by asking the damage
helper to ignore the damage clips if the framebuffer attached to a plane
has changed since the last page-flip.

Patch #3 does the same but for the vmwgfx driver that also needs to handle
buffer damage and should have the same issue (although I haven't tested it
due not having a VMWare setup).

Patch #4 adds to the KMS damage tracking kernel-doc some paragraphs about
damage tracking types and references to links that explain frame damage vs
buffer damage.

Finally patch #5 adds an item to the DRM todo, about the need to implement
some buffer damage accumulation algorithm instead of just doing full plane
updates in this case.

Because commit 01f05940a9a7 landed in v6.4, the first 2 patches are marked
as Fixes and Cc stable.

I've tested this on a VM with weston, was able to reproduce the issue
reported and the patches did fix the problem.

Best regards,
Javier

Changes in v2:
- Add a struct drm_plane_state .ignore_damage_clips to set in the plane's
  .atomic_check, instead of having different helpers (Thomas Zimmermann).
- Set struct drm_plane_state .ignore_damage_clips in virtio-gpu plane's
  .atomic_check instead of using a different helpers (Thomas Zimmermann).
- Set struct drm_plane_state .ignore_damage_clips in vmwgfx plane's
  .atomic_check instead of using a different helpers (Thomas Zimmermann).

Javier Martinez Canillas (5):
  drm: Allow drivers to indicate the damage helpers to ignore damage
    clips
  drm/virtio: Disable damage clipping if FB changed since last page-flip
  drm/vmwgfx: Disable damage clipping if FB changed since last page-flip
  drm/plane: Extend damage tracking kernel-doc
  drm/todo: Add entry about implementing buffer age for damage tracking

 Documentation/gpu/todo.rst             | 20 ++++++++++++++++++++
 drivers/gpu/drm/drm_damage_helper.c    |  3 ++-
 drivers/gpu/drm/drm_plane.c            | 20 ++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 ++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c    | 11 +++++++++++
 include/drm/drm_plane.h                |  8 ++++++++
 6 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.41.0

