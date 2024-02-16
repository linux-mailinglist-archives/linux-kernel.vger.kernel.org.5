Return-Path: <linux-kernel+bounces-68165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A0A8576B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472592821F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561F114F65;
	Fri, 16 Feb 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgmfoepS"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C463CF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708068055; cv=none; b=pQ3lkxbRahscbfWFLjJtfveBizzHOxuyXQSSpAmnzI6Ktl9U2fD1lHh9Wod5Q1JBG5sXqPUEqrwiWPLR1p+sU9yXbXBGYvQS91k1SKHCZomYCFDUtQ0lpj+7VO4y5sb6unq1MLzc8h4HaOS4Ko9lJD25Yxtf+Xbl1H3ohQpiKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708068055; c=relaxed/simple;
	bh=e4FgpGfnwOmoacNA4zRcvpQJkjY0NthpYMQOXnP7Iuo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VGG5xMp6ljBb5OQJ1+Z+bsaHxfLXb5/RV7XZBwe7/gWVRQ70hUGGXXuPgNsXZIs5cXAWqDns+BlefH99bj5zrMY9kmPurvXsI1H4SIykvn+0phCglziugCLE84oa0F2X+MTf/P+xlwZ1gj9suotMBTFTb0gsb34z7gT2MrZ3o30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgmfoepS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3deb3f563bso12649666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708068052; x=1708672852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z3fnE8lu4OwnmF+xCktEvTcMyuCb+rBJsjQn+t81tu8=;
        b=LgmfoepSFtOWHizAxMqLZOLuolvkUU6IGFOK6iGiy2Ab7Q/Zkjvw8S7M6Dw2nJUmjG
         rtpal1EbOt92DWDBbzahJhpGFMnR4YMSPYLVJ2qBg8qiswYzS+KOzh4B0VX9Eaq8rgg2
         BS/YR2YllnqXsJi5NiVEnidW1/3RbUPWAAaW9SUKfEEc7J7/GCbHJaZ19+9YPcur+yqr
         T4T504yl5AeqZst/HRwksPWm0JhKFlnDPV4gWxtWzXfeptEwNNDj2OWuruhvlLoQ4vVI
         M1sW4NWrTfldmLlMnkRQGxE58XgCtSguOtlJRc90anhQIa0BExYsk1tPiWYPX40nvYER
         0G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708068052; x=1708672852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3fnE8lu4OwnmF+xCktEvTcMyuCb+rBJsjQn+t81tu8=;
        b=FMvPw8UjlMfmYDbOhIkFEDGhoJrkuJLjwBFuIXYMJeWFprIEh3HsVkEPDX68egwV9D
         jxIMjXR2/t9AGacYVC2vKWu+bUK3036hLCTDymJZtn9OclY2qZ3cT0mFZgswQ5F0O81w
         N/MBo2exORgJOF9ctVl1V+yrwlIcUYwz8Xa9KKXrif58xLg41f3At9RuafFKNuPHuoEW
         b+i9yoNZePMotNAuLTXI1Htsu0yUqZwT2DuqLRPk+d/NbAFxFkCXW8Ps6Nf1mrnrSQr+
         PBZN47OF7Heqp/s2j8dFDI+dVbeLn8T2Uhk4oVaGeAGpOGhV9OY79UsqUzms/95NCAeJ
         zawg==
X-Forwarded-Encrypted: i=1; AJvYcCUdw/yQvdLmXbi2pnEL49h5KhPPWYDKdAj0ZehlFeYIkyNuX6koME3ItZM7gssP9GZK8uoCgFPKGhdJOYhQHQPfnmcUFNAiQ3GoXNkx
X-Gm-Message-State: AOJu0YwKiSE7UMsskucpwq86QWpbVVcef+D1DR5/Xr5WozGAFwS8j/34
	Sdn9UZEm923SH5snEIsiWrsTRqNBSBwGi3GT538tKJDPSiebXbzhGuNUtU9/uN04yJAiu/uISxF
	hHr1O/xXBCXpv2EMwhb1+LaHaX+rxk7BnjywLQQ==
X-Google-Smtp-Source: AGHT+IEUsKHwEk2Ruab0YAEA9zOuKmflD6/WuhtPZWfs9PJBkMyDYVmuCtdcHJe6LwNgjUc1i+VzPUJG8wx634SQ5Q4=
X-Received: by 2002:a17:906:451:b0:a3d:9962:f05f with SMTP id
 e17-20020a170906045100b00a3d9962f05fmr2410505eja.74.1708068051261; Thu, 15
 Feb 2024 23:20:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 16 Feb 2024 17:20:39 +1000
Message-ID: <CAPM=9tz=LsdsWYZ0hG3Zuw_pLTsV-7wBh7C3hUmAcY9fcJf_ww@mail.gmail.com>
Subject: [git pull] drm fixes for 6.8-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Regular weekly fixes, nothing too major, mostly amdgpu, then i915, xe,
msm and nouveau with some scattered bits elsewhere.

Dave.

drm-fixes-2024-02-16:
drm fixes for 6.8-rc5

crtc:
- fix uninit variable

prime:
- support > 4GB page arrays

buddy:
- fix error handling in allocations

i915:
- fix blankscreen on JSL chromebooks
- stable fix to limit DP sst link rates

xe:
- Fix an out-of-bounds shift.
- Fix the display code thinking xe uses shmem
- Fix a warning about index out-of-bound
- Fix a clang-16 compilation warning

amdgpu:
- PSR fixes
- Suspend/resume fixes
- Link training fix
- Aspect ratio fix
- DCN 3.5 fixes
- VCN 4.x fix
- GFX 11 fix
- Misc display fixes
- Misc small fixes

amdkfd:
- Cache size reporting fix
- SIMD distribution fix

msm:
- GPU:
- dmabuf vmap fix
- a610 UBWC corruption fix (incorrect hbb)
- revert a commit that was making GPU recovery unreliable
 - tlb invalidation fix

ivpu:
- suspend/resume fix

nouveau:
- fix scheduler cleanup path
- fix pointless scheduler creation
- fix kvalloc argument order

rockchip:
- vop2 locking fix
The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de=
:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-02-16

for you to fetch changes up to ea69f782d0e37d9658d4b7df241661e651c43af5:

  Merge tag 'drm-msm-fixes-2024-02-15' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes (2024-02-16
15:47:15 +1000)

----------------------------------------------------------------
drm fixes for 6.8-rc5

crtc:
- fix uninit variable

prime:
- support > 4GB page arrays

buddy:
- fix error handling in allocations

i915:
- fix blankscreen on JSL chromebooks
- stable fix to limit DP sst link rates

xe:
- Fix an out-of-bounds shift.
- Fix the display code thinking xe uses shmem
- Fix a warning about index out-of-bound
- Fix a clang-16 compilation warning

amdgpu:
- PSR fixes
- Suspend/resume fixes
- Link training fix
- Aspect ratio fix
- DCN 3.5 fixes
- VCN 4.x fix
- GFX 11 fix
- Misc display fixes
- Misc small fixes

amdkfd:
- Cache size reporting fix
- SIMD distribution fix

msm:
- GPU:
- dmabuf vmap fix
- a610 UBWC corruption fix (incorrect hbb)
- revert a commit that was making GPU recovery unreliable
 - tlb invalidation fix

ivpu:
- suspend/resume fix

nouveau:
- fix scheduler cleanup path
- fix pointless scheduler creation
- fix kvalloc argument order

rockchip:
- vop2 locking fix

----------------------------------------------------------------
Arnd Bergmann (2):
      nouveau/svm: fix kvcalloc() argument order
      drm/xe: avoid function cast warnings

Arunpravin Paneer Selvam (1):
      drm/buddy: Fix alloc_range() error handling code

Dan Carpenter (1):
      drm/amd/display: Fix && vs || typos

Danilo Krummrich (2):
      drm/nouveau: don't fini scheduler if not initialized
      drm/nouveau: omit to create schedulers using the legacy uAPI

Dave Airlie (5):
      Merge tag 'drm-misc-fixes-2024-02-15' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2024-02-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-02-15' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.8-2024-02-15-2' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-msm-fixes-2024-02-15' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes

Dmitry Baryshkov (1):
      drm/msm/a6xx: set highest_bank_bit to 13 for a610

Hamza Mahfooz (1):
      drm/amdgpu: make damage clips support configurable

Harshit Mogalapalli (1):
      drm/rockchip: vop2: add a missing unlock in vop2_crtc_atomic_enable()

Jacek Lawrynowicz (1):
      accel/ivpu: Fix DevTLB errors on suspend/resume and recovery

Kent Russell (1):
      drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3

Manasi Navare (1):
      drm/i915/dsc: Fix the macro that calculates DSCC_/DSCA_ PPS reg addre=
ss

Mario Limonciello (2):
      drm/amd: Stop evicting resources on APUs in suspend
      Revert "drm/amd: flush any delayed gfxoff on suspend entry"

Matthew Auld (2):
      drm/tests/drm_buddy: add alloc_contiguous test
      drm/xe/display: fix i915_gem_object_is_shmem() wrapper

Nicholas Kazlauskas (1):
      drm/amd/display: Increase ips2_eval delay for DCN35

Philip Yang (1):
      drm/prime: Support page array >=3D 4GB

Rajneesh Bhardwaj (2):
      drm/amdkfd: update SIMD distribution algo for GFXIP 9.4.2 onwards
      drm/amdgpu: Fix implicit assumtion in gfx11 debug flags

Rob Clark (4):
      drm/msm/gem: Fix double resv lock aquire
      Revert "drm/msm/gpu: Push gpu lock down past runpm"
      drm/crtc: fix uninitialized variable use even harder
      drm/msm: Wire up tlb ops

Roman Li (1):
      drm/amd/display: Fix array-index-out-of-bounds in dcn35_clkmgr

Sohaib Nadeem (2):
      Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"
      drm/amd/display: fixed integer types and null check locations

Srinivasan Shanmugam (5):
      drm/amd/display: Initialize 'wait_time_microsec' variable in
link_dp_training_dpia.c
      drm/amd/display: Fix possible use of uninitialized
'max_chunks_fbc_mode' in 'calculate_bandwidth()'
      drm/amd/display: Fix possible buffer overflow in
'find_dcfclk_for_voltage()'
      drm/amd/display: Fix possible NULL dereference on device
remove/driver unload
      drm/amdgpu/display: Initialize gamma correction mode variable in
dcn30_get_gamcor_current()

Thomas Hellstr=C3=B6m (2):
      drm/xe/vm: Avoid reserving zero fences
      drm/xe/pt: Allow for stricter type- and range checking

Thong (1):
      drm/amdgpu/soc21: update VCN 4 max HEVC encoding resolution

Tom Chung (1):
      drm/amd/display: Preserve original aspect ratio in create stream

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915/dp: Limit SST link rate to <=3D8.1Gbps

Zhikai Zhai (1):
      drm/amd/display: Add align done check

 drivers/accel/ivpu/ivpu_hw_37xx.c                  | 44 ++++++++---
 drivers/accel/ivpu/ivpu_pm.c                       | 39 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           | 15 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 12 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 13 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  9 ++-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  9 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  1 +
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          | 10 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 11 ++-
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 16 ++--
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |  2 +
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 15 +++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c    |  5 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  2 +-
 .../drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c    |  4 +-
 .../gpu/drm/amd/display/dc/link/link_validation.c  |  2 +-
 .../display/dc/link/protocols/link_dp_training.c   |  5 +-
 .../dc/link/protocols/link_dp_training_dpia.c      |  2 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |  2 +-
 drivers/gpu/drm/drm_buddy.c                        |  6 ++
 drivers/gpu/drm/drm_crtc.c                         |  1 +
 drivers/gpu/drm/drm_prime.c                        |  2 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  3 +
 drivers/gpu/drm/i915/display/intel_vdsc_regs.h     |  4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  2 +-
 drivers/gpu/drm/msm/msm_gem_prime.c                |  4 +-
 drivers/gpu/drm/msm/msm_gpu.c                      | 11 ++-
 drivers/gpu/drm/msm/msm_iommu.c                    | 32 +++++++-
 drivers/gpu/drm/msm/msm_ringbuffer.c               |  7 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c            | 20 +++--
 drivers/gpu/drm/nouveau/nouveau_abi16.h            |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  7 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |  2 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c             |  2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.c            | 38 ++++++++-
 drivers/gpu/drm/nouveau/nouveau_sched.h            |  6 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c              |  2 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c             |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |  4 +-
 drivers/gpu/drm/tests/drm_buddy_test.c             | 89 ++++++++++++++++++=
++++
 .../xe/compat-i915-headers/gem/i915_gem_object.h   |  2 +-
 drivers/gpu/drm/xe/xe_pt.c                         | 39 ++++++----
 drivers/gpu/drm/xe/xe_pt_walk.c                    |  2 +-
 drivers/gpu/drm/xe/xe_pt_walk.h                    | 19 +----
 drivers/gpu/drm/xe/xe_range_fence.c                |  7 +-
 drivers/gpu/drm/xe/xe_vm.c                         | 13 +++-
 52 files changed, 423 insertions(+), 140 deletions(-)

