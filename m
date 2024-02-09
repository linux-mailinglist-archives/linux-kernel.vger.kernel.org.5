Return-Path: <linux-kernel+bounces-58993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B04384EF9F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496BC2827D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1214A538A;
	Fri,  9 Feb 2024 04:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzYDNxMM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0EC522A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 04:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707452935; cv=none; b=p9SK1CVdiiUJ4WvkIH/8WPAsA3+Cc2kaS42YvAe+hguaROJpvLRHrhi0VJbwqqHvdMKJ9yqeXqyPVl+ay3bJcCevTOS+c68hCcI9HTYYOD4T2nNwawfq264LmjMdvRYyKveVSDd98DYBPka46UpajxWgC2D8Qu1MAatPwxife+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707452935; c=relaxed/simple;
	bh=RJ6nWteqmPE915mFbKVDLoJWx8uUR7QPzs5Se7TjWOw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UWgQJja7rcl4QrBYLOI1MOnaWamh6UUa0+dAd8p+ebMW+ZTi2zjc97rDaUR27DHMGNTAY/cEXfn2mWO/mHUv/5pkO0rFv5lHwAtoMb7rRiidSCKZKbhj4y7//DI0F2DUtBoyoDHcjzeziwtDQVPkAeTKO9FXZmafPvLlCoKQpc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzYDNxMM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso71092766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 20:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707452931; x=1708057731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bTXBw/uQ/AZU1ICWB/ng0btsHfhbv8yVH9M0U5Q5wDw=;
        b=AzYDNxMMkeh99i6ulE0i7t0T8MTbwtWfLYq26roOmqyxjlTg0dLMvXBIFdOpMD8drW
         PHTDSyrUub6q2hJ3Cd14WPzxn61AWrHJ7vOrdCpHIEwM00qFOrg9eA07GHnOvYiD5OpU
         pIO9SKtO1qfqTEYE9T1fzfE7Lov4Jabz+q2R81zYZrEs/Ac5EfyUOFwKU9PUFvCQcAFk
         OFnCU2cFmDIyU66hxhtjD8W4DwXGeXDUl/LHAq+BaBufe015bYtrrOyVksTBOjxeU5/R
         y4cgXqKUR8opietAjX/jrtCyppqn0l4kaSRW1+pUqhxz8E4YIPF0Imix8yZk/bJBamFd
         KuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707452931; x=1708057731;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTXBw/uQ/AZU1ICWB/ng0btsHfhbv8yVH9M0U5Q5wDw=;
        b=gUcA5y0lL3D5LClIKcS1uN7rzl5ER2OXDxBn1VVYtHgOE76wyezLZG+Xes3MRdPJRR
         s9JF0GXIaYNSjZJzD2Y8vcjrFD6YAMhpRKkzLysFD1aAHcDx3Tc+O9UtGhoFxsayOupj
         SLebdxK4XIkwiEKUDVPDIdWh9i1DqhJCes1XudCUW/ojBMXiF65gGTp6FKePN4ADQ3Ww
         ff1tqVYwlCby2Gavvf0XmXmRlD8UCPZs5x1+oDU5NoVfyN97HXTGYlxljxDG9Pg3Zuda
         nHW/hbH35ezd8eygTBVaEAmp3tcWGgQKNRbv4e6sgwUhhcqCs0AjEp77RIEIjR/OTKn/
         3zFA==
X-Forwarded-Encrypted: i=1; AJvYcCVmIzAOX6NhlzuZVSmhL/w0hGcAeuAC4AFP4Vhkun0iiKCBH958or2MNF99N5keVVVE1o+IW0RQAew70gWVcO9JkSzEtoxzlIsme097
X-Gm-Message-State: AOJu0YxTYBRpewKJFjxSrUvjJVWtHumMjF1thGe1/0QqfOwwHTw1Pd/p
	ne/ahORfaybtoZzGx5gEhsE40j+LFCMnO9SG/nC+MQiDvn8gm0CZKxlWeM3w6gbvi+UnljtJClw
	z5vKkXnMorD1WvNlHMPs131gGFo/2vf5yPLAPMA==
X-Google-Smtp-Source: AGHT+IGQ10oVX/InR0AS7IEriYHTOzBqmi9NrTQGqS29Hpkx0l0v3t3dWg2qkQPimSHL0GHV2wlsPcfu37gMa0bTLFw=
X-Received: by 2002:a17:906:6808:b0:a3b:cb42:80de with SMTP id
 k8-20020a170906680800b00a3bcb4280demr242808ejr.70.1707452930869; Thu, 08 Feb
 2024 20:28:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 9 Feb 2024 14:28:39 +1000
Message-ID: <CAPM=9tykW0CySOLSBfxiopj2xSnBi18LtzuFHmabFY3kFhZ6Lw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.8-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Regular weekly fixes, xe, amdgpu and msm are most of them, with some
misc in i915, ivpu and nouveau, scattered but nothing too intense at
this point.

Dave.

drm-fixes-2024-02-09:
drm fixes for 6.8-rc4

i915:
- gvt: docs fix, uninit var, MAINTAINERS

ivpu:
- add aborted job status
- disable d3 hot delay
- mmu fixes

nouveau:
- fix gsp rpc size request
- fix dma buffer leaks
- use common code for gsp mem ctor

xe:
- Fix a loop in an error path
- Fix a missing dma-fence reference
- Fix a retry path on userptr REMAP
- Workaround for a false gcc warning
- Fix missing map of the usm batch buffer
  in the migrate vm.
- Fix a memory leak.
- Fix a bad assumption of used page size
- Fix hitting a BUG() due to zero pages to map.
- Remove some leftover async bind queue relics

amdgpu:
- Misc NULL/bounds check fixes
- ODM pipe policy fix
- Aborted suspend fixes
- JPEG 4.0.5 fix
- DCN 3.5 fixes
- PSP fix
- DP MST fix
- Phantom pipe fix
- VRAM vendor fix
- Clang fix
- SR-IOV fix

msm:
- DPU:
- fix for kernel doc warnings and smatch warnings in dpu_encoder
- fix for smatch warning in dpu_encoder
- fix the bus bandwidth value for SDM670
- DP:
- fixes to handle unknown bpc case correctly for DP
- fix for MISC0 programming
- GPU:
- dmabuf vmap fix
- a610 UBWC corruption fix (incorrect hbb)
- revert a commit that was making GPU recovery unreliable
The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-02-09

for you to fetch changes up to 311520887d7cad2d5494933bd19bf85eb5398ffc:

  Merge tag 'drm-msm-fixes-2024-02-07' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes (2024-02-09
11:32:38 +1000)

----------------------------------------------------------------
drm fixes for 6.8-rc4

i915:
- gvt: docs fix, uninit var, MAINTAINERS

ivpu:
- add aborted job status
- disable d3 hot delay
- mmu fixes

nouveau:
- fix gsp rpc size request
- fix dma buffer leaks
- use common code for gsp mem ctor

xe:
- Fix a loop in an error path
- Fix a missing dma-fence reference
- Fix a retry path on userptr REMAP
- Workaround for a false gcc warning
- Fix missing map of the usm batch buffer
  in the migrate vm.
- Fix a memory leak.
- Fix a bad assumption of used page size
- Fix hitting a BUG() due to zero pages to map.
- Remove some leftover async bind queue relics

amdgpu:
- Misc NULL/bounds check fixes
- ODM pipe policy fix
- Aborted suspend fixes
- JPEG 4.0.5 fix
- DCN 3.5 fixes
- PSP fix
- DP MST fix
- Phantom pipe fix
- VRAM vendor fix
- Clang fix
- SR-IOV fix

msm:
- DPU:
- fix for kernel doc warnings and smatch warnings in dpu_encoder
- fix for smatch warning in dpu_encoder
- fix the bus bandwidth value for SDM670
- DP:
- fixes to handle unknown bpc case correctly for DP
- fix for MISC0 programming
- GPU:
- dmabuf vmap fix
- a610 UBWC corruption fix (incorrect hbb)
- revert a commit that was making GPU recovery unreliable

----------------------------------------------------------------
Abhinav Kumar (1):
      drm/msm/dpu: check for valid hw_pp in dpu_encoder_helper_phys_cleanup

Alvin Lee (1):
      drm/amd/display: Update phantom pipe enable / disable sequence

Arnd Bergmann (1):
      drm/xe: circumvent bogus stringop-overflow warning

Dan Carpenter (1):
      drm/i915/gvt: Fix uninitialized variable in handle_mmio()

Dave Airlie (6):
      nouveau/gsp: use correct size for registry rpc.
      Merge tag 'drm-misc-fixes-2024-02-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-xe-fixes-2024-02-08' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2024-02-08' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.8-2024-02-08' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-msm-fixes-2024-02-07' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes

Dmitry Baryshkov (1):
      drm/msm/mdss: specify cfg bandwidth for SDM670

Fangzhi Zuo (1):
      drm/amd/display: Fix MST Null Ptr for RV

Grzegorz Trzebiatowski (1):
      accel/ivpu: Add job status for jobs aborted by the driver

Jacek Lawrynowicz (1):
      accel/ivpu: Disable d3hot_delay on all NPU generations

Joonas Lahtinen (1):
      Merge tag 'gvt-fixes-2024-02-05' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Krystian Pradzynski (2):
      accel/ivpu/40xx: Enable D0i3 message
      accel/ivpu/40xx: Stop passing SKU boot parameters to FW

Kuogee Hsieh (2):
      drm/msms/dp: fixed link clock divider bits be over written in
BPC unknown case
      drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case

Li Ma (1):
      drm/amdgpu: remove asymmetrical irq disabling in jpeg 4.0.5 suspend

Lijo Lazar (2):
      drm/amdgpu: Avoid fetching VRAM vendor info
      drm/amdgpu: Fix HDP flush for VFs on nbio v7.9

Mario Limonciello (1):
      drm/amd/display: Clear phantom stream count and plane count

Matthew Auld (1):
      drm/xe/vm: don't ignore error when in_kthread

Matthew Brost (7):
      drm/sched: Re-queue run job worker when
drm_sched_entity_pop_job() returns NULL
      drm/xe: Fix loop in vm_bind_ioctl_ops_unwind
      drm/xe: Take a reference in xe_exec_queue_last_fence_get()
      drm/xe: Pick correct userptr VMA to repin on REMAP op failure
      drm/xe: Map both mem.kernel_bb_pool and usm.bb_pool
      drm/xe: Assume large page size if VMA not yet bound
      drm/xe: Remove TEST_VM_ASYNC_OPS_ERROR

Maxime Ripard (1):
      Merge drm-misc-next-fixes-2024-01-19 into drm-misc-fixes

Nathan Chancellor (1):
      drm/amd/display: Increase frame-larger-than for all display_mode_vba files

Nicholas Kazlauskas (1):
      drm/amd/display: Increase eval/entry delay for DCN35

Prike Liang (2):
      drm/amdgpu: skip to program GFXDEC registers for suspend abort
      drm/amdgpu: reset gpu for s3 suspend abort case

Randy Dunlap (1):
      drm/msm/dpu: fix kernel-doc warnings

Rodrigo Siqueira (1):
      drm/amd/display: Disable ODM by default for DCN35

Srinivasan Shanmugam (3):
      drm/amd/display: Fix 'panel_cntl' could be null in
'dcn21_set_backlight_level()'
      drm/amd/display: Add NULL test for 'timing generator' in
'dcn21_set_pipe()'
      drm/amd/display: Implement bounds check for stream encoder
creation in DCN301

Stanley.Yang (1):
      drm/amdgpu: Fix shared buff copy to user

Timur Tabi (2):
      drm/nouveau: fix several DMA buffer leaks
      drm/nouveau: nvkm_gsp_radix3_sg() should use nvkm_gsp_mem_ctor()

Wachowski, Karol (2):
      accel/ivpu: Force snooping for MMU writes
      accel/ivpu: Correct MMU queue size checking functions

Wenjing Liu (1):
      drm/amd/display: set odm_combine_policy based on context in dcn32 resource

Xiaoming Wang (1):
      drm/xe/display: Fix memleak in display initialization

Zhenyu Wang (1):
      drm/i915: Replace dead 01.org link

Zhi Wang (1):
      MAINTAINERS: Update Zhi Wang's email address

 MAINTAINERS                                        |  4 +-
 drivers/accel/ivpu/ivpu_drv.c                      |  5 +-
 drivers/accel/ivpu/ivpu_fw.c                       |  1 -
 drivers/accel/ivpu/ivpu_hw_37xx.c                  |  2 +-
 drivers/accel/ivpu/ivpu_hw_40xx.c                  |  7 +-
 drivers/accel/ivpu/ivpu_job.c                      |  4 +-
 drivers/accel/ivpu/ivpu_mmu.c                      | 36 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  8 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  8 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             |  9 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           | 10 ---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c             |  6 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c                 | 22 +++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 12 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |  3 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |  6 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 15 +++--
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |  4 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.h  |  4 ++
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  2 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h    |  4 ++
 .../drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c    | 63 ++++++++++--------
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    | 76 ++++++++++++++++++---
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h    |  2 +
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c |  3 +
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |  7 ++
 drivers/gpu/drm/amd/display/dc/inc/resource.h      | 20 +++---
 .../display/dc/resource/dcn301/dcn301_resource.c   |  2 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c | 16 ++++-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |  5 +-
 drivers/gpu/drm/i915/Kconfig                       |  2 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |  3 +-
 drivers/gpu/drm/i915/intel_gvt.c                   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  8 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  3 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |  5 --
 drivers/gpu/drm/msm/dp/dp_link.c                   | 22 ++++---
 drivers/gpu/drm/msm/dp/dp_reg.h                    |  3 +
 drivers/gpu/drm/msm/msm_mdss.c                     |  1 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h  |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     | 77 +++++++++++++---------
 drivers/gpu/drm/scheduler/sched_main.c             | 15 +++--
 drivers/gpu/drm/xe/xe_display.c                    |  6 --
 drivers/gpu/drm/xe/xe_exec_queue.c                 |  8 ++-
 drivers/gpu/drm/xe/xe_gt.c                         |  5 +-
 drivers/gpu/drm/xe/xe_gt_pagefault.c               |  2 +-
 drivers/gpu/drm/xe/xe_migrate.c                    | 28 ++++++--
 drivers/gpu/drm/xe/xe_sched_job.c                  |  1 -
 drivers/gpu/drm/xe/xe_sync.c                       |  2 -
 drivers/gpu/drm/xe/xe_vm.c                         | 62 +++++++----------
 drivers/gpu/drm/xe/xe_vm_types.h                   |  8 ---
 include/uapi/drm/ivpu_accel.h                      |  1 +
 57 files changed, 390 insertions(+), 253 deletions(-)

