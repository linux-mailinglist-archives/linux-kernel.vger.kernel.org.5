Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3C7F68DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjKWWNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWWNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:13:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4437910C9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700777601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BMSDWzklTKYX0k//1UvbJiLR3VQJPVSpH9qxFC3znV0=;
        b=VVpRFeNrfiZyV3S9w27Q93x1UWr8OCKz6L92NCySUxYfM0/qPfm3cpOaMMP1VakAAmygkS
        khHPg3fnaehGxtmgytvkBCCZ8sFHS8MkQ+I+aXOdeMb/jUh5zIqsQvXw0xS5eCSDaJV+m9
        PJCtYMUgJwae+3cYevCL93rmh1w28J0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-bL6lW-4HNXygtTLd9RWoJA-1; Thu, 23 Nov 2023 17:13:20 -0500
X-MC-Unique: bL6lW-4HNXygtTLd9RWoJA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b3487fa9eso7584655e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700777598; x=1701382398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMSDWzklTKYX0k//1UvbJiLR3VQJPVSpH9qxFC3znV0=;
        b=SQQSd6MqeXxjdejezqkfuncmBTXtMPUxxQpzWevPUoHeoTVwQUtQaJ8pQR8qBVLjVY
         VLnNZhQupwKKMytWo/LxmXE38W1hGywvla+vSTVjJQKgrNKCNtq+75L6kC9D6ibqlXli
         /WvzZGWxE2mTK4bUMEN91uE1vFEV3zrPZieCnZ68H1JtdDr2zG/A7QzAmnzBLTrJIfpV
         s80/HGHmyPBBsLFioL93LKM39t2vh6W2Avl5HO+5FBQtoEH88x0Q+9M2ugPjU6gjwz9v
         xNymx0hD1KfaSqDxLHkPA0ivLFlPGVKFEIsnPwPRgrh+PenOwXQXnjBmoLAnpcDmwyVn
         DdVw==
X-Gm-Message-State: AOJu0YxU1JhikI0crdy6zzOBi9hv5fvzqaH3qi5GEralDILUHO0BJgwz
        qZm1ONNtA/jq8H3U7ucRqG4lUkMhZb8LwW4yDqw01CYUErEBJfjOfOUwCXsAkUmibopDqYf+Atd
        y3lkFWctjC/+t0X9gUmq6CSPpREWw9mIWSoAL9OiiA8ZZJYo+En7xTlXv7wae1FKOlp8JGDiXd6
        sbM67q3d8=
X-Received: by 2002:adf:f24e:0:b0:332:e5e4:35a0 with SMTP id b14-20020adff24e000000b00332e5e435a0mr514665wrp.51.1700777597873;
        Thu, 23 Nov 2023 14:13:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTc5cyyb2Lj+zZeLr8whfuiAjV15w5NBZGgF7fkaZUdpQEkaRfYZjLuIjGVT+m4u1zAGDz6w==
X-Received: by 2002:adf:f24e:0:b0:332:e5e4:35a0 with SMTP id b14-20020adff24e000000b00332e5e435a0mr514631wrp.51.1700777597458;
        Thu, 23 Nov 2023 14:13:17 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v19-20020adfd053000000b0032f79e55eb8sm2641676wrh.16.2023.11.23.14.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 14:13:17 -0800 (PST)
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
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH v4 0/5] drm: Allow the damage helpers to handle buffer damage
Date:   Thu, 23 Nov 2023 23:12:59 +0100
Message-ID: <20231123221315.3579454-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
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

It is a v4 that addresses issues pointed out by Sima Vetter in v3:

https://lists.freedesktop.org/archives/dri-devel/2023-November/431409.html

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

Changes in v4:
- Refer in ignore_damage_clips kernel-doc to "Damage Tracking Properties"
  KMS documentation section (Sima Vetter).
- Add another paragraph to "Damage Tracking Properties" section to mention
  the fields that drivers with per-buffer upload target should check to set
  drm_plane_state.ignore_damage_clips (Sima Vetter).
- Reference the &drm_plane_state.ignore_damage_clips and the damage helpers
  in the buffer damage TODO entry (Sima Vetter).

Changes in v3:
- Fix typo in the kernel-doc (Simon Ser).
- Add a paragraph explaining what the problem in the kernel is and
  make it clear that the refeference documents are related to how
  user-space handles this case (Thomas Zimmermann).

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

 Documentation/gpu/drm-kms.rst          |  2 ++
 Documentation/gpu/todo.rst             | 23 ++++++++++++++++++++
 drivers/gpu/drm/drm_damage_helper.c    |  3 ++-
 drivers/gpu/drm/drm_plane.c            | 30 ++++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 +++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c    | 11 ++++++++++
 include/drm/drm_plane.h                | 10 +++++++++
 7 files changed, 88 insertions(+), 1 deletion(-)

-- 
2.41.0

