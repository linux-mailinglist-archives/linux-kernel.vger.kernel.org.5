Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37147D5F34
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJYAxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYAxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:53:43 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07E4E5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VnS1q2clKXLAKj9U3PxexRupTcDUxeTgMSxPQmKaBQc=; b=qnKRGVmhGbMsLeRQzYW6rb2Lr3
        sYVnS0V5BYAgo1xgfIOSDCHItHzKHGJhFx6b7SOImuruAaOEdqfhV01RZEMrAZG5UyJ9p0uwdg5u9
        I+KkZuplcT9oeHJh0IvwNImDHidlc7CVbZEd5BRBdfUu4NVEfv/910VCnMKIkg649L1r/OOOX/BN+
        Xf9rfct32a/Z7BSEDrwDMsLpQkfpgRv/7neBuGutiRyMFPIMoAO6tnggEuAQXcbEBaCGTDc1Fb596
        JXqUtnllh93aPQVMRufzGtU+jliW9oz0W5qCKEZn4HckDmkf8jDvi3VvehhDUlidZbIFFOPwFSnAx
        nj/0DbWA==;
Received: from [191.193.179.125] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qvS9H-006qog-Vs; Wed, 25 Oct 2023 02:53:28 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v8 0/6] drm: Add support for atomic async page-flip
Date:   Tue, 24 Oct 2023 21:53:12 -0300
Message-ID: <20231025005318.293690-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This work from me and Simon adds support for DRM_MODE_PAGE_FLIP_ASYNC through
the atomic API. This feature is already available via the legacy API. The use
case is to be able to present a new frame immediately (or as soon as
possible), even if after missing a vblank. This might result in tearing, but
it's useful when a high framerate is desired, such as for gaming.

Differently from earlier versions, this one refuses to flip if any prop changes
for async flips. The idea is that the fast path of immediate page flips doesn't
play well with modeset changes, so only the fb_id can be changed.

Thanks,
	André

- User-space patch: https://github.com/Plagman/gamescope/pull/595
- IGT tests: https://gitlab.freedesktop.org/andrealmeid/igt-gpu-tools/-/tree/atomic_async_page_flip

Changes from v7:
- Only accept flips to primary planes. If a driver support flips in different
planes, support will be added  later.
v7: https://lore.kernel.org/dri-devel/20231017092837.32428-1-andrealmeid@igalia.com/

Changes from v6:
- Dropped the exception to allow MODE_ID changes (Simon)
- Clarify what happens when flipping with the same FB_ID (Pekka)

v6: https://lore.kernel.org/dri-devel/20230815185710.159779-1-andrealmeid@igalia.com/

Changes from v5:
- Add note in the docs that not every redundant attribute will result in no-op,
  some might cause oversynchronization issues.

v5: https://lore.kernel.org/dri-devel/20230707224059.305474-1-andrealmeid@igalia.com/

Changes from v4:
 - Documentation rewrote by Pekka Paalanen

v4: https://lore.kernel.org/dri-devel/20230701020917.143394-1-andrealmeid@igalia.com/

Changes from v3:
 - Add new patch to reject prop changes
 - Add a documentation clarifying the KMS atomic state set

v3: https://lore.kernel.org/dri-devel/20220929184307.258331-1-contact@emersion.fr/

André Almeida (1):
  drm: Refuse to async flip with atomic prop changes

Pekka Paalanen (1):
  drm/doc: Define KMS atomic state set

Simon Ser (4):
  drm: allow DRM_MODE_PAGE_FLIP_ASYNC for atomic commits
  drm: introduce DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP
  drm: introduce drm_mode_config.atomic_async_page_flip_not_supported
  amd/display: indicate support for atomic async page-flips on DC

 Documentation/gpu/drm-uapi.rst                | 47 +++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  1 +
 drivers/gpu/drm/drm_atomic_uapi.c             | 82 +++++++++++++++++--
 drivers/gpu/drm/drm_crtc_internal.h           |  2 +-
 drivers/gpu/drm/drm_ioctl.c                   |  5 ++
 drivers/gpu/drm/drm_mode_object.c             |  2 +-
 .../drm/i915/display/intel_display_driver.c   |  1 +
 drivers/gpu/drm/nouveau/nouveau_display.c     |  1 +
 include/drm/drm_mode_config.h                 | 11 +++
 include/uapi/drm/drm.h                        | 10 ++-
 include/uapi/drm/drm_mode.h                   |  9 ++
 11 files changed, 162 insertions(+), 9 deletions(-)

-- 
2.42.0

