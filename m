Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD817E7027
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbjKIR0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343808AbjKIR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C28B325B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699550709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KM+kZjFHA8E0A+l+o485oGQAZV87bwGJzM3u9NBaaMA=;
        b=e/cGm8lYKvoeQYINzkmtM+ll6tQjTbbgMlj+O7XVmg9vhZHZdmMZIM5qvj+W8Fr/jFm0ZX
        P7K3mNfN9ua/yU7uhevO+qWx7CWiFLNOgXUHBEi1pMBJuuU2Hbw2xJihTKJd7U8LdC7q2z
        XaF5uI6BHfHQ2Em0LlIjGVWeVPKmZ54=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-Gupn3hwQOBOfC2d31EDtLQ-1; Thu, 09 Nov 2023 12:25:08 -0500
X-MC-Unique: Gupn3hwQOBOfC2d31EDtLQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-408508aa81cso7221165e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550706; x=1700155506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KM+kZjFHA8E0A+l+o485oGQAZV87bwGJzM3u9NBaaMA=;
        b=XT7QYsa8SbI5B1+l+i7BwAl65Au8417ZAim1k6E0j1tHfHH/DLEtA3x47Y6tI4lErn
         eTHi+EbT61sANzIa6K72+LWGzjBcVEoiytjhN/EYPJ1e3FS21+hkU875x79iNhVUqspH
         6PdhrFQykXbYytqdKqRwFSKbZ0iA+sK7KPT/rYIIkG44lOcuQnBWbTAZqJeS0mdcQDTF
         alqODZyklFxdrvUw7/7qxRtjFl52+mAOi7I1GLW5tp5Vtew0KtkxqD2cs0ISRBqQLnbu
         iOLr7EGo5EpTipVIUnXSejCfsNUrbbQBxx4OO+I357P3ZEJE9k87o/e0fbntIZWmfRiC
         5JfQ==
X-Gm-Message-State: AOJu0YycmiQVLCmxDLAZ+w7pL9Bdr8yrSYuWkSWwak4a1Tzrzoz+aqMU
        bQen4Y1ewFDiF/7Dc1F0Gw6CVDmfF4ekQraPCumeZfYy+Dg7I6idIxhXb86DY57yyav+0AE6VJv
        NZOblPd4lXUYsUFBEyzh/jgdT9u/ZY4JV7bdHJjC9I4ksMIbybDL0Mru1sL0JymYyiK9oXYmcsL
        30e4gGQJ0=
X-Received: by 2002:a05:600c:3d9a:b0:408:5bc6:a7d with SMTP id bi26-20020a05600c3d9a00b004085bc60a7dmr4807933wmb.19.1699550706541;
        Thu, 09 Nov 2023 09:25:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBYNpBFpSwc4pVpHVCRnVRLdnQyz2wbfqHlyA9KAIkGVscHGBHFPnaFmMk7VrRW7vmMUDnCw==
X-Received: by 2002:a05:600c:3d9a:b0:408:5bc6:a7d with SMTP id bi26-20020a05600c3d9a00b004085bc60a7dmr4807894wmb.19.1699550706031;
        Thu, 09 Nov 2023 09:25:06 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c3b9200b0040839fcb217sm646229wms.8.2023.11.09.09.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:25:04 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Simon Ser <contact@emersion.fr>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 0/6] drm: Allow the damage helpers to handle buffer damage
Date:   Thu,  9 Nov 2023 18:24:34 +0100
Message-ID: <20231109172449.1599262-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Patch #1 is just a refactoring to allow the logic of the frame damage
helpers to be shared by the buffer damage helpers.

Patch #2 adds the helpers that are needed for buffer damage handling.

Patch #3 fixes the virtio-gpu damage handling logic by using the
helper that is required by drivers that need to handle buffer damage.

Patch #4 fixes the vmwgfx similarly, since that driver also needs to
handle buffer damage and should have the same issue (although I have
not tested it due not having a VMWare setup).

Patch #5 adds to the KMS damage tracking kernel-doc some paragraphs
about damage tracking types and references to links that explain
frame damage vs buffer damage.

Finally patch #6 adds an item to the DRM/KMS todo, about the need to
implement some buffer damage accumulation algorithm instead of just
doing a full plane update in this case.

Because commit 01f05940a9a7 landed in v6.4, the first three patches
are marked as Fixes and Cc stable.

I've tested this on a VM with weston, was able to reproduce the issue
reported and the patches did fix the problem.

Please let me know what you think. Specially on the wording since could
made mistakes due just learning about these concepts yesterday thanks to
Sima, Simon and Pekka.

Best regards,
Javier


Javier Martinez Canillas (6):
  drm: Move drm_atomic_helper_damage_{iter_init,merged}() to helpers
  drm: Add drm_atomic_helper_buffer_damage_{iter_init,merged}() helpers
  drm/virtio: Use drm_atomic_helper_buffer_damage_merged() for buffer
    damage
  drm/vmwgfx: Use drm_atomic_helper_buffer_damage_iter_init() for buffer
    damage
  drm/plane: Extend damage tracking kernel-doc
  drm/todo: Add entry about implementing buffer age for damage tracking

 Documentation/gpu/todo.rst             |  20 +++
 drivers/gpu/drm/drm_damage_helper.c    | 166 +++++++++++++++++++------
 drivers/gpu/drm/drm_plane.c            |  22 +++-
 drivers/gpu/drm/virtio/virtgpu_plane.c |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c    |   2 +-
 include/drm/drm_damage_helper.h        |   7 ++
 6 files changed, 173 insertions(+), 46 deletions(-)

-- 
2.41.0

