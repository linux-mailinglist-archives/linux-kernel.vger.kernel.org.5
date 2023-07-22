Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D3275DF57
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGVXxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGVXxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:53:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784DDA0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 16:53:03 -0700 (PDT)
Received: from workpc.. (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 84B116606EFD;
        Sun, 23 Jul 2023 00:52:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690069981;
        bh=81zCbI/f3RiO00IRtoWpBFJlXd/bCmpEfNvrni+jPuI=;
        h=From:To:Cc:Subject:Date:From;
        b=acwfAxtJAVNbxkrHyDamV8IwAWJBjs3vjtQvjxUm5diM9kI6m5eLT6GzV4tBsZno7
         7S6K7aP7NJb56dWksuXyBlGMphqv+7T5eeik95gOGpKX0r+puWjkj9WPeVY/oRJgGm
         QNlqwNzCbz1pykLXwCSWDqGt10BdeWsk+gHYTPumr9mPNVKwEb+lk8jpXu/Wwjy92w
         SETpZB7Tr/yjJMG1wJR/nis9/+KpI7eflhrEq5f1em1q0tnUH9kQWFiE60DZD/HDst
         qWtuvG71p7QJJICdA+rqpwaIYHOTqjYbptD70/9Ot31VqIp0DeKsmnpBg0pXxk4Jpv
         3KquKc1aYL/0w==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v14 00/12] Add generic memory shrinker to VirtIO-GPU and Panfrost DRM drivers
Date:   Sun, 23 Jul 2023 02:47:34 +0300
Message-ID: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series:

  1. Adds common drm-shmem memory shrinker
  2. Enables shrinker for VirtIO-GPU driver
  3. Switches Panfrost driver to the common shrinker

Changelog:

v14:- All the prerequisite reservation locking patches landed upstream,
      previously were a part of this series in v13 and older.

        https://lore.kernel.org/dri-devel/20230529223935.2672495-1-dmitry.osipenko@collabora.com/

    - Added patches to improve locked/unlocked function names, like was
      suggested by Boris Brezillon for v13.

    - Made all exported drm-shmem symbols GPL, like was previously
      discussed with Thomas Zimmermann on this series.

    - Improved virtio-gpu shrinker patch. Now it won't detach purged BO
      when userspace closes GEM. Crosvm (and not qemu) checks res_id on
      CMD_CTX_DETACH_RESOURCE and prints noisy error message if ID is
      invalid, which wasn't noticed before.

v13:- Updated virtio-gpu shrinker patch to use drm_gem_shmem_object_pin()
      directly instead of drm_gem_pin() and dropped patch that exported
      drm_gem_pin() functions, like was requested by Thomas Zimmermann in
      v12.

v12:- Fixed the "no previous prototype for function" warning reported by
      kernel build bot for v11.

    - Fixed the missing reservation lock reported by Intel CI for VGEM
      driver. Other drivers using drm-shmem were affected similarly to
      VGEM. The problem was in the dma-buf attachment code path that led
      to drm-shmem pinning function which assumed the held reservation lock
      by drm_gem_pin(). In the past that code path was causing trouble for
      i915 driver and we've changed the locking scheme for the attachment
      code path in the dma-buf core to let exporters to handle the locking
      themselves. After a closer investigation, I realized that my assumption
      about testing of dma-buf export code path using Panfrost driver was
      incorrect. Now I created additional local test to exrecise the Panfrost
      export path. I also reproduced the issue reported by the Intel CI for
      v10. It's all fixed now by making the drm_gem_shmem_pin() to take the
      resv lock by itself.

    - Patches are based on top of drm-tip, CC'd intel-gfx CI for testing.

v11:- Rebased on a recent linux-next. Added new patch as a result:

        drm/shmem-helper: Export drm_gem_shmem_get_pages_sgt_locked()

        It's needed by the virtio-gpu driver to swap-in/unevict shmem
        object, previously get_pages_sgt() didn't use locking.

    - Separated the "Add memory shrinker" patch into smaller parts to ease
      the reviewing, as was requested by Thomas Zimmermann:

        drm/shmem-helper: Factor out pages alloc/release from
          drm_gem_shmem_get/put_pages()
        drm/shmem-helper: Add pages_pin_count field
        drm/shmem-helper: Switch drm_gem_shmem_vmap/vunmap to use pin/unpin
        drm/shmem-helper: Factor out unpinning part from drm_gem_shmem_purge()

    - Addessed the v10 review comments from Thomas Zimmermann: return errno
      instead of bool, sort code alphabetically, rename function and etc
      minor changes.

    - Added new patch to remove the "map->is_iomem" from drm-shmem, as
      was suggested by Thomas Zimmermann.

    - Added acks and r-b's that were given to v10.

v10:- Was partially applied to misc-fixes/next.

      https://lore.kernel.org/dri-devel/6c16f303-81df-7ebe-85e9-51bb40a8b301@collabora.com/T/

Dmitry Osipenko (12):
  drm/shmem-helper: Factor out pages alloc/release from
    drm_gem_shmem_get/put_pages()
  drm/shmem-helper: Add pages_pin_count field
  drm/shmem-helper: Switch drm_gem_shmem_vmap/vunmap to use pin/unpin
  drm/shmem-helper: Factor out unpinning part from drm_gem_shmem_purge()
  drm/shmem-helper: Add memory shrinker
  drm/shmem-helper: Remove obsoleted is_iomem test
  drm/shmem-helper: Export drm_gem_shmem_get_pages_sgt_locked()
  drm/virtio: Support memory shrinking
  drm/panfrost: Switch to generic memory shrinker
  drm/shmem-helper: Refactor locked/unlocked functions
  drm/shmem-helper: Make drm_gem_shmem_print_info() symbol GPL
  drm/gem: Add _unlocked postfix to drm_gem_pin/unpin()

 drivers/gpu/drm/drm_gem.c                     |   4 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c        | 546 ++++++++++++++----
 drivers/gpu/drm/drm_internal.h                |   4 +-
 drivers/gpu/drm/drm_prime.c                   |   4 +-
 drivers/gpu/drm/lima/lima_gem.c               |  10 +-
 drivers/gpu/drm/panfrost/Makefile             |   1 -
 drivers/gpu/drm/panfrost/panfrost_device.h    |   4 -
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  29 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c       |  40 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h       |   9 -
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  | 122 ----
 drivers/gpu/drm/panfrost/panfrost_job.c       |  18 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c       |   2 +-
 drivers/gpu/drm/v3d/v3d_bo.c                  |  10 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h          |  20 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c          |  72 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c        |  33 ++
 drivers/gpu/drm/virtio/virtgpu_kms.c          |   8 +
 drivers/gpu/drm/virtio/virtgpu_object.c       | 137 ++++-
 drivers/gpu/drm/virtio/virtgpu_plane.c        |  17 +-
 drivers/gpu/drm/virtio/virtgpu_submit.c       |  15 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c           |  40 ++
 include/drm/drm_device.h                      |  10 +-
 include/drm/drm_gem_shmem_helper.h            | 208 +++++--
 include/uapi/drm/virtgpu_drm.h                |  14 +
 25 files changed, 986 insertions(+), 391 deletions(-)
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c

-- 
2.41.0

