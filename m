Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBE578B464
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjH1PYj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Aug 2023 11:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjH1PYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:24:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E0F124
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:24:11 -0700 (PDT)
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
        by madras.collabora.co.uk (Postfix) with ESMTP id 4A606660716E;
        Mon, 28 Aug 2023 16:24:08 +0100 (BST)
From:   "Helen Mae Koike Fornazier" <helen.koike@collabora.com>
In-Reply-To: <55db-64ecb100-57-403f1500@96946290>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Mon, 28 Aug 2023 16:24:08 +0100
Cc:     "Dmitry Osipenko" <dmitry.osipenko@collabora.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Emma Anholt" <emma@anholt.net>,
        "Peter Zijlstra" <peterz@infradead.org>,
        dri-devel@lists.freedesktop.org,
        "Gurchetan Singh" <gurchetansingh@chromium.org>,
        "Gerd Hoffmann" <kraxel@redhat.com>, kernel@collabora.com,
        "Will Deacon" <will@kernel.org>,
        "Steven Price" <steven.price@arm.com>,
        intel-gfx@lists.freedesktop.org,
        "Boqun Feng" <boqun.feng@gmail.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Melissa Wen" <mwen@igalia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Boris Brezillon" <boris.brezillon@collabora.com>,
        "Qiang Yu" <yuq825@gmail.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
To:     "Helen Mae Koike Fornazier" <helen.koike@collabora.com>
MIME-Version: 1.0
Message-ID: <6d93-64ecbc00-3-3c8ca040@163557744>
Subject: =?utf-8?q?Re=3A?= [PATCH v15 00/23] Add generic memory shrinker to 
 VirtIO-GPU and Panfrost DRM drivers
User-Agent: SOGoMail 5.8.4
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 28, 2023 11:37 -03, "Helen Mae Koike Fornazier" <helen.koike@collabora.com> wrote:

> On Sunday, August 27, 2023 14:54 -03, Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
> > This series:
> > 
> >   1. Adds common drm-shmem memory shrinker
> >   2. Enables shrinker for VirtIO-GPU driver
> >   3. Switches Panfrost driver to the common shrinker
> 
> Hi Dmitry, 
> 
> Would you mind testing with drm-ci? We virt-io tests there and it would be
> really great to get your feedback of it.
> 
> https://cgit.freedesktop.org/drm/drm/log/?h=topic/drm-ci

sorry, I forgot that you also need this patchset:
    https://lists.freedesktop.org/archives/dri-devel/2023-August/420063.html
to enable virtio_gpu test job.

Thanks again.
Helen

> 
> You need to merge your changes with the above tree.
> To configure it, you just need to have a tree on gitlab.freedesktop.org,
> go to the settings and change the CI/CD configuration file from .gitlab-ci.yml
> to drivers/gpu/drm/ci/gitlab-ci.yml, and you can start a pipeline
> on your branch.
> 
> at the time of this writting, gitlab.freedesktop.org is under maintenance,
> but it should be back soon.
> 
> Thank you!
> Helen
> 
> > 
> > Changelog:
> > 
> > v15:- Moved drm-shmem reference counters to use kref that allows to
> >       optimize unlocked functions, like was suggested by Boris Brezillon.
> > 
> >     - Changed drm/gem/shmem function names to use _locked postfix and
> >       dropped the _unlocked, making the naming scheme consistent across
> >       DRM code, like was suggested by Boris Brezillon.
> > 
> >     - Added patch that fixes UAF in drm-shmem for drivers that import
> >       dma-buf and then release buffer in the import error code path.
> > 
> >     - Added patch that makes drm-shmem use new flag for SGT's get_pages()
> >       refcounting, preventing unbalanced refcounting when GEM is freed.
> > 
> >     - Fixed guest blob pinning in virtio-gpu driver that was missed
> >       previously in the shrinker patch.
> > 
> >     - Moved VC4 and virtio-gpu drivers to use drm_gem_put() in
> >       GEM-creation error code paths, which is now required by drm-shmem
> >       and was missed in a previous patch versions.
> > 
> >     - Virtio-GPU now attaches shmem pages to host on first use and not
> >       when BO is created. In older patch versions there was a potential
> >       race condition in the BO creation code path where both
> >       get_sgt()+object_attach() should've been made under same resv lock,
> >       otherwise pages could be evicted before attachment is invoked.
> > 
> >     - Virtio-GPU and drm-shmem shrinker patches are split into smaller
> >       ones.
> > 
> > v14:- All the prerequisite reservation locking patches landed upstream,
> >       previously were a part of this series in v13 and older.
> > 
> >         https://lore.kernel.org/dri-devel/20230529223935.2672495-1-dmitry.osipenko@collabora.com/
> > 
> >     - Added patches to improve locked/unlocked function names, like was
> >       suggested by Boris Brezillon for v13.
> > 
> >     - Made all exported drm-shmem symbols GPL, like was previously
> >       discussed with Thomas Zimmermann on this series.
> > 
> >     - Improved virtio-gpu shrinker patch. Now it won't detach purged BO
> >       when userspace closes GEM. Crosvm (and not qemu) checks res_id on
> >       CMD_CTX_DETACH_RESOURCE and prints noisy error message if ID is
> >       invalid, which wasn't noticed before.
> > 
> > v13:- Updated virtio-gpu shrinker patch to use drm_gem_shmem_object_pin()
> >       directly instead of drm_gem_pin() and dropped patch that exported
> >       drm_gem_pin() functions, like was requested by Thomas Zimmermann in
> >       v12.
> > 
> > v12:- Fixed the "no previous prototype for function" warning reported by
> >       kernel build bot for v11.
> > 
> >     - Fixed the missing reservation lock reported by Intel CI for VGEM
> >       driver. Other drivers using drm-shmem were affected similarly to
> >       VGEM. The problem was in the dma-buf attachment code path that led
> >       to drm-shmem pinning function which assumed the held reservation lock
> >       by drm_gem_pin(). In the past that code path was causing trouble for
> >       i915 driver and we've changed the locking scheme for the attachment
> >       code path in the dma-buf core to let exporters to handle the locking
> >       themselves. After a closer investigation, I realized that my assumption
> >       about testing of dma-buf export code path using Panfrost driver was
> >       incorrect. Now I created additional local test to exrecise the Panfrost
> >       export path. I also reproduced the issue reported by the Intel CI for
> >       v10. It's all fixed now by making the drm_gem_shmem_pin() to take the
> >       resv lock by itself.
> > 
> >     - Patches are based on top of drm-tip, CC'd intel-gfx CI for testing.
> > 
> > v11:- Rebased on a recent linux-next. Added new patch as a result:
> > 
> >         drm/shmem-helper: Export drm_gem_shmem_get_pages_sgt_locked()
> > 
> >         It's needed by the virtio-gpu driver to swap-in/unevict shmem
> >         object, previously get_pages_sgt() didn't use locking.
> > 
> >     - Separated the "Add memory shrinker" patch into smaller parts to ease
> >       the reviewing, as was requested by Thomas Zimmermann:
> > 
> >         drm/shmem-helper: Factor out pages alloc/release from
> >           drm_gem_shmem_get/put_pages()
> >         drm/shmem-helper: Add pages_pin_count field
> >         drm/shmem-helper: Switch drm_gem_shmem_vmap/vunmap to use pin/unpin
> >         drm/shmem-helper: Factor out unpinning part from drm_gem_shmem_purge()
> > 
> >     - Addessed the v10 review comments from Thomas Zimmermann: return errno
> >       instead of bool, sort code alphabetically, rename function and etc
> >       minor changes.
> > 
> >     - Added new patch to remove the "map->is_iomem" from drm-shmem, as
> >       was suggested by Thomas Zimmermann.
> > 
> >     - Added acks and r-b's that were given to v10.
> > 
> > v10:- Was partially applied to misc-fixes/next.
> > 
> >       https://lore.kernel.org/dri-devel/6c16f303-81df-7ebe-85e9-51bb40a8b301@collabora.com/T/
> > 
> > Dmitry Osipenko (23):
> >   drm/shmem-helper: Fix UAF in error path when freeing SGT of imported
> >     GEM
> >   drm/shmem-helper: Use flag for tracking page count bumped by
> >     get_pages_sgt()
> >   drm/gem: Change locked/unlocked postfix of drm_gem_v/unmap() function
> >     names
> >   drm/gem: Add _locked postfix to functions that have unlocked
> >     counterpart
> >   drm/v3d: Replace open-coded drm_gem_shmem_free() with
> >     drm_gem_object_put()
> >   drm/virtio: Replace drm_gem_shmem_free() with drm_gem_object_put()
> >   drm/shmem-helper: Make all exported symbols GPL
> >   drm/shmem-helper: Refactor locked/unlocked functions
> >   drm/shmem-helper: Remove obsoleted is_iomem test
> >   locking/refcount, kref: Add kref_put_ww_mutex()
> >   dma-resv: Add kref_put_dma_resv()
> >   drm/shmem-helper: Add and use pages_pin_count
> >   drm/shmem-helper: Use kref for pages_use_count
> >   drm/shmem-helper: Add and use lockless drm_gem_shmem_get_pages()
> >   drm/shmem-helper: Switch drm_gem_shmem_vmap/vunmap to use pin/unpin
> >   drm/shmem-helper: Use kref for vmap_use_count
> >   drm/shmem-helper: Add and use drm_gem_shmem_resv_assert_held() helper
> >   drm/shmem-helper: Add memory shrinker
> >   drm/shmem-helper: Export drm_gem_shmem_get_pages_sgt_locked()
> >   drm/virtio: Pin display framebuffer BO
> >   drm/virtio: Attach shmem BOs dynamically
> >   drm/virtio: Support memory shrinking
> >   drm/panfrost: Switch to generic memory shrinker
> > 
> >  drivers/gpu/drm/drm_client.c                  |   6 +-
> >  drivers/gpu/drm/drm_gem.c                     |  26 +-
> >  drivers/gpu/drm/drm_gem_framebuffer_helper.c  |   6 +-
> >  drivers/gpu/drm/drm_gem_shmem_helper.c        | 616 +++++++++++++++---
> >  drivers/gpu/drm/drm_internal.h                |   4 +-
> >  drivers/gpu/drm/drm_prime.c                   |   4 +-
> >  drivers/gpu/drm/lima/lima_gem.c               |  11 +-
> >  drivers/gpu/drm/lima/lima_sched.c             |   4 +-
> >  drivers/gpu/drm/panfrost/Makefile             |   1 -
> >  drivers/gpu/drm/panfrost/panfrost_device.h    |   4 -
> >  drivers/gpu/drm/panfrost/panfrost_drv.c       |  29 +-
> >  drivers/gpu/drm/panfrost/panfrost_dump.c      |   4 +-
> >  drivers/gpu/drm/panfrost/panfrost_gem.c       |  36 +-
> >  drivers/gpu/drm/panfrost/panfrost_gem.h       |   9 -
> >  .../gpu/drm/panfrost/panfrost_gem_shrinker.c  | 122 ----
> >  drivers/gpu/drm/panfrost/panfrost_job.c       |  18 +-
> >  drivers/gpu/drm/panfrost/panfrost_mmu.c       |   4 +-
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c   |   6 +-
> >  drivers/gpu/drm/v3d/v3d_bo.c                  |  26 +-
> >  drivers/gpu/drm/virtio/virtgpu_drv.h          |  22 +-
> >  drivers/gpu/drm/virtio/virtgpu_gem.c          |  80 +++
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c        |  57 +-
> >  drivers/gpu/drm/virtio/virtgpu_kms.c          |   8 +
> >  drivers/gpu/drm/virtio/virtgpu_object.c       | 147 ++++-
> >  drivers/gpu/drm/virtio/virtgpu_plane.c        |  17 +-
> >  drivers/gpu/drm/virtio/virtgpu_submit.c       |  15 +-
> >  drivers/gpu/drm/virtio/virtgpu_vq.c           |  40 ++
> >  include/drm/drm_device.h                      |  10 +-
> >  include/drm/drm_gem.h                         |   6 +-
> >  include/drm/drm_gem_shmem_helper.h            | 141 +++-
> >  include/linux/dma-resv.h                      |   9 +
> >  include/linux/kref.h                          |  12 +
> >  include/linux/refcount.h                      |   5 +
> >  include/uapi/drm/virtgpu_drm.h                |  14 +
> >  lib/refcount.c                                |  34 +
> >  35 files changed, 1167 insertions(+), 386 deletions(-)
> >  delete mode 100644 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> > 
> > -- 
> > 2.41.0
> >
>

