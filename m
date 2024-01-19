Return-Path: <linux-kernel+bounces-30833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFB18324CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6AB1C22C24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0C4D529;
	Fri, 19 Jan 2024 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgDmvUEO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E316D51C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647556; cv=none; b=QLgNtiDEePvBEfsuQC3VYCFLoRAUrs+sx4/aJKNgxC2d7uy3UuZAHI8Xmz+lDZDLFUjOegIP6BCqJ1ZMnE2abU3OU/UXMsptzBYfQyIRfLqXTkhksUGUtsLLSS1oFY9r8hRaPRWnIEy+gcz30Ybq6d+FXvjuN4sT/0rhiTBGhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647556; c=relaxed/simple;
	bh=RaNSDMuVOHk0FMeMVPelsB+UTwKg0CQlyQfsqC24bTA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oxKI1H9ZJiz7x966UowvMdXwwfpeCjbdjieVFwJwRRM5HWKLSQItjbh+eQMVhEPW4GTaxn2BEcRt5dzmcmZ6Z0limr29Zuvnzp25jCLv3IAA9Pw+cl7ZWuylgselbJlH2zbHlDekxQ3pZNSoLxU5rsTEOFH6dJRjfd/97xm0Uk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgDmvUEO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-337c5eb1bddso359928f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705647552; x=1706252352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dEGJX2ExdSxVIfQMACLKAruVtJHcFFyo9DUUdCgWpHs=;
        b=WgDmvUEOaHNOWxzB7+H9iLm4eRXca6HWW7tL9fFABRomeN2B0pegpbTOUIRm5IzG2b
         5Tr/7r2tRwfIuM6qIy3dP1fbiPJaLAdu432FVWVYQkn78zzoPqF311uuXKxMsbr79lSB
         2lNODmIxs782Wa198vXAmH+/0Kgqz0CdG3oAamNCJKJp3uX4UK2+zhYp+J6XszJHuTEA
         afp77ct2unrIHxBMDqCZR52wNvrfYi6afBm5Cag8x7GaabHZ6CIdxDc6zgMy5eW77j47
         RJWewxFELFv+F1+yd9jjHwmRRKOp8V7zsysN85HxcEzvb2QvzG4XYoYhPxtM6UZTLjrm
         GHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705647552; x=1706252352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEGJX2ExdSxVIfQMACLKAruVtJHcFFyo9DUUdCgWpHs=;
        b=e1YBi4aHxTNSXR7QHKTBArQAITdudrzcWXV0nRWoPIiokp5CpWxjrkffW3Jwi5DYIp
         AidvPj64gFYaEGLwKA50dAckNEBbi8XC/85Ro8n4ji3eNtPUQCyXWGPI9Amk4e4QiEr2
         6kSVOmJqeE/I1OAn9iZmOFKSw83gghOiQWzA/hge2z29J5PdLeyYLZ2uaqvY4r7NaS/8
         +Dji1IeIjcJdcE8UH/7vd/t1ig9Xyqk5QxPX3nDHIcCWpyAzOt11Q72qbYN/1ZNRp7EV
         oMWNYYLX3RlTiuNBv03vG+opwsdVvl06zWQzkYyNSN0T91O4HJQFwY378JAcsV/7RjfJ
         pVow==
X-Gm-Message-State: AOJu0YzayPplSvwB+O1II7JC8toKJGNe4804ohjX03Z4GMa0i9/73byj
	5KBkaLxklvv98Cwgt3xBDPryXXHilt1N4M6PESc+1eZ1YUdlz/6tVGv6YPbTt/tWUjJ13FIgbtU
	yj2sh0MG9fLGZxEu2T+oB/vKT9wI=
X-Google-Smtp-Source: AGHT+IG4zle8MUunjiLHKCWxHBtPPcU8C62sQR8A1Tj6NebKLtG+97GSNne8OJuYk8/zbaCl1bT4W0rRoZSQv451q0U=
X-Received: by 2002:a05:600c:54e7:b0:40e:5c65:6880 with SMTP id
 jb7-20020a05600c54e700b0040e5c656880mr1176042wmb.89.1705647551991; Thu, 18
 Jan 2024 22:59:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 19 Jan 2024 16:58:59 +1000
Message-ID: <CAPM=9txpkzp1nciq+8TrVU1pmsRC9LEVqLaQV9ug=XX0hnmLmw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.8-rc1 (part two)
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Hope your power/internet stabilizes, this is the last set of fixes
before rc1 for drm. This is mostly amdgpu and xe fixes, with an amdkfd
and nouveau fix thrown in.

The amdgpu ones are just the usual couple of weeks of fixes. The xe
ones are bunch of cleanups for the new xe driver, the fix you put in
on the merge commit and the kconfig fix that was hiding the problem
from me are all in here, it seems to merge fine.

Let me know if there are any problems,

Dave.

drm-next-2024-01-19:
drm fixes for 6.8-rc1

amdgpu:
- DSC fixes
- DC resource pool fixes
- OTG fix
- DML2 fixes
- Aux fix
- GFX10 RLC firmware handling fix
- Revert a broken workaround for SMU 13.0.2
- DC writeback fix
- Enable gfxoff when ROCm apps are active on gfx11 with the proper FW versi=
on

amdkfd:
- Fix dma-buf exports using GEM handles

nouveau:
- fix a unneeded WARN_ON triggering

xe:
- Fix for definition of wakeref_t
- Fix for an error code aliasing
- Fix for VM_UNBIND_ALL in the case there are no bound VMAs
- Fixes for a number of __iomem address space mismatches reported by sparse
- Fixes for the assignment of exec_queue priority
- A Fix for skip_guc_pc not taking effect
- Workaround for a build problem on GCC 11
- A couple of fixes for error paths
- Fix a Flat CCS compression metadata copy issue
- Fix a misplace array bounds checking
- Don't have display support depend on EXPERT (as discussed on IRC)
The following changes since commit 205e18c13545ab43cc4fe4930732b4feef551198=
:

  nouveau/gsp: handle engines in runl without nonstall interrupts.
(2024-01-15 16:04:48 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2024-01-19

for you to fetch changes up to 009f0a64f9ccee9db9d758b883059e5c74bb7330:

  Merge tag 'drm-xe-next-fixes-2024-01-16' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next (2024-01-19
16:13:51 +1000)

----------------------------------------------------------------
drm fixes for 6.8-rc1

amdgpu:
- DSC fixes
- DC resource pool fixes
- OTG fix
- DML2 fixes
- Aux fix
- GFX10 RLC firmware handling fix
- Revert a broken workaround for SMU 13.0.2
- DC writeback fix
- Enable gfxoff when ROCm apps are active on gfx11 with the proper FW versi=
on

amdkfd:
- Fix dma-buf exports using GEM handles

nouveau:
- fix a unneeded WARN_ON triggering

xe:
- Fix for definition of wakeref_t
- Fix for an error code aliasing
- Fix for VM_UNBIND_ALL in the case there are no bound VMAs
- Fixes for a number of __iomem address space mismatches reported by sparse
- Fixes for the assignment of exec_queue priority
- A Fix for skip_guc_pc not taking effect
- Workaround for a build problem on GCC 11
- A couple of fixes for error paths
- Fix a Flat CCS compression metadata copy issue
- Fix a misplace array bounds checking
- Don't have display support depend on EXPERT (as discussed on IRC)

----------------------------------------------------------------
Alex Deucher (4):
      drm/amdgpu: fix avg vs input power reporting on smu7
      drm/amdgpu: fall back to INPUT power for AVG power via INFO IOCTL
      drm/amdgpu/pm: clarify debugfs pm output
      drm/amdgpu: drop exp hw support check for GC 9.4.3

Aric Cyr (1):
      drm/amd/display: 3.2.266

Brian Welty (3):
      drm/xe: Fix guc_exec_queue_set_priority
      drm/xe: Fix modifying exec_queue priority in xe_migrate_init
      drm/xe: Fix bounds checking in __xe_bo_placement_for_flags()

Candice Li (2):
      drm/amdgpu: Drop unnecessary sentences about CE and deferred error.
      drm/amdgpu: Support poison error injection via ras_ctrl debugfs

Charlene Liu (2):
      drm/amd/display: Update z8 latency
      drm/amd/display: Add logging resource checks

Christian K=C3=B6nig (1):
      drm/amdgpu: revert "Adjust removal control flow for smu v13_0_2"

Christophe JAILLET (1):
      drm/amd/display: Fix a switch statement in
populate_dml_output_cfg_from_stream_state()

Dafna Hirschfeld (1):
      drm/amdkfd: fixes for HMM mem allocation

Dan Carpenter (3):
      drm/xe/device: clean up on error in probe()
      drm/xe/selftests: Fix an error pointer dereference bug
      drm/xe: unlock on error path in xe_vm_add_compute_exec_queue()

Daniel Miess (1):
      Revert "drm/amd/display: Fix conversions between bytes and KB"

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-6.8-2024-01-18' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      nouveau/vmm: don't set addr on the fail path to avoid warning
      Merge tag 'drm-xe-next-fixes-2024-01-16' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next

Dillon Varone (1):
      drm/amd/display: Init link enc resources in dc_state only if
res_pool presents

Felix Kuehling (2):
      drm/amdkfd: Fix lock dependency warning
      drm/amdkfd: Fix sparse __rcu annotation warnings

Flora Cui (1):
      drm/amdkfd: init drm_client with funcs hook

George Shen (1):
      drm/amd/display: Disconnect phantom pipe OPP from OPTC being disabled

Hawking Zhang (1):
      drm/amdgpu: Packed socket_id to ras feature mask

Ilya Bakoulin (1):
      drm/amd/display: Clear OPTC mem select on disable

Ivan Lipski (1):
      Revert "drm/amd/display: fix bandwidth validation failure on DCN 2.1"

James Zhu (1):
      drm/amdgpu: make a correction on comment

Jani Nikula (1):
      drm/xe: display support should not depend on EXPERT

Jos=C3=A9 Roberto de Souza (1):
      drm/xe: Fix definition of intel_wakeref_t

Le Ma (3):
      Revert "drm/amdgpu: add param to specify fw bo location for
front-door loading"
      drm/amdgpu: add debug flag to place fw bo on vram for frontdoor loadi=
ng
      drm/amdgpu: move debug options init prior to amdgpu device init

Lijo Lazar (2):
      drm/amd/pm: Add error log for smu v13.0.6 reset
      drm/amd/pm: Fix smuv13.0.6 current clock reporting

Likun Gao (1):
      drm/amdgpu: correct the cu count for gfx v11

Ma Jun (1):
      drm/amdgpu: Fix the null pointer when load rlc firmware

Martin Leung (2):
      drm/amd/display: revert "for FPO & SubVP/DRR config program vmin/max"
      drm/amd/display: revert "Optimize VRR updates to only necessary ones"

Martin Tsai (1):
      drm/amd/display: To adjust dprefclk by down spread percentage

Matthew Brost (1):
      drm/xe: Fix exec IOCTL long running exec queue ring full condition

Meenakshikumar Somasundaram (1):
      drm/amd/display: Dpia hpd status not in sync after S4

Melissa Wen (1):
      drm/amd/display: cleanup inconsistent indenting in amdgpu_dm_color

Nathan Chancellor (1):
      drm/amd/display: Avoid enum conversion warning

Nicholas Kazlauskas (1):
      drm/amd/display: Port DENTIST hang and TDR fixes to OTG disable W/A

Ori Messinger (1):
      drm/amdgpu: Enable GFXOFF for Compute on GFX11

Ovidiu Bunea (1):
      drm/amd/display: Fix DML2 watermark calculation

Paul E. McKenney (1):
      drm/xe: Fix build bug for GCC 11

Peichen Huang (1):
      drm/amd/display: Request usb4 bw for mst streams

Philip Yang (1):
      drm/amdkfd: Fix lock dependency warning with srcu

Srinivasan Shanmugam (8):
      drm/amd/powerplay: Fix kzalloc parameter 'ATOM_Tonga_PPM_Table'
in 'get_platform_power_management_table()'
      drm/amdgpu: Fix with right return code '-EIO' in
'amdgpu_gmc_vram_checking()'
      drm/amdgpu: Fix unsigned comparison with less than zero in
vpe_u1_8_from_fraction()
      drm/amdgpu: Release 'adev->pm.fw' before return in
'amdgpu_device_need_post()'
      drm/amd/display: Fix variable deferencing before NULL check in
edp_setup_replay()
      drm/amdkfd: Fix 'node' NULL check in 'svm_range_get_range_boundaries(=
)'
      drm/amd/display: Fix late derefrence 'dsc' check in
'link_set_dsc_pps_packet()'
      drm/amd/display: Drop 'acrtc' and add 'new_crtc_state' NULL
check for writeback requests.

Thomas Hellstr=C3=B6m (6):
      drm/xe/vm: Fix an error path
      drm/xe: Use __iomem for the regs pointer
      drm/xe: Annotate xe_mem_region::mapping with __iomem
      drm/xe: Annotate multiple mmio pointers with __iomem
      drm/xe: Annotate xe_ttm_stolen_mgr::mapping with __iomem
      drm/xe/migrate: Fix CCS copy for small VRAM copy chunks

Victor Lu (1):
      drm/amdgpu: Do not program VM_L2_CNTL under SRIOV

Vinay Belgaumkar (1):
      drm/xe: Check skip_guc_pc before setting SLPC flag

Wayne Lin (1):
      drm/amd/display: Align the returned error code with legacy DP

Yifan Zhang (3):
      drm/amdgpu: update headers for nbio v7.11
      drm/amdgpu: update ATHUB_MISC_CNTL offset for athub v3.3
      drm/amdgpu: update regGL2C_CTRL4 value in golden setting

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  33 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  47 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  21 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  26 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h          |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h           |   1 -
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c            |   8 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  15 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   5 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c           |  10 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c              |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  42 +++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   5 +
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |  92 ++++++++++++--
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h |  11 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  18 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  18 +--
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |   8 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |  12 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c     |   2 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   9 +-
 .../amd/display/dc/dcn32/dcn32_resource_helpers.c  |  14 +++
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  11 +-
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   |   6 +-
 .../drm/amd/display/dc/dml2/display_mode_core.c    |  32 ++---
 .../amd/display/dc/dml2/dml2_translation_helper.c  |   2 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   2 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |   2 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  45 +------
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |   3 -
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |  50 ++++++--
 .../gpu/drm/amd/display/dc/link/link_validation.c  |  60 ++++++++--
 .../amd/display/dc/link/protocols/link_dp_dpia.c   |  36 +++---
 .../display/dc/link/protocols/link_dp_dpia_bw.c    |  60 +++++++---
 .../display/dc/link/protocols/link_dp_dpia_bw.h    |   9 ++
 .../dc/link/protocols/link_edp_panel_control.c     |  11 +-
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c |  22 +++-
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |  15 ++-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |   2 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.h |   3 +
 .../display/dc/resource/dcn321/dcn321_resource.c   |   2 +-
 drivers/gpu/drm/amd/display/include/audio_types.h  |   2 +-
 .../amd/include/asic_reg/nbio/nbio_7_11_0_offset.h |   8 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  28 +++--
 .../amd/pm/powerplay/hwmgr/process_pptables_v1_0.c |   2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  17 ++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  15 ++-
 drivers/gpu/drm/nouveau/nouveau_vmm.c              |   3 +
 drivers/gpu/drm/xe/Kconfig                         |   2 +-
 drivers/gpu/drm/xe/Makefile                        |   1 -
 .../gpu/drm/xe/compat-i915-headers/intel_wakeref.h |   2 +-
 drivers/gpu/drm/xe/tests/xe_bo.c                   |   5 +-
 drivers/gpu/drm/xe/tests/xe_migrate.c              |   2 +-
 drivers/gpu/drm/xe/xe_bo.c                         |  16 +--
 drivers/gpu/drm/xe/xe_device.c                     |   2 +-
 drivers/gpu/drm/xe/xe_device_types.h               |   8 +-
 drivers/gpu/drm/xe/xe_exec.c                       |   7 +-
 drivers/gpu/drm/xe/xe_exec_queue.c                 |   5 +
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |   6 +-
 drivers/gpu/drm/xe/xe_gt_freq.c                    |   3 +
 drivers/gpu/drm/xe/xe_guc.c                        |   7 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 |   7 +-
 drivers/gpu/drm/xe/xe_migrate.c                    | 133 +++++++++++++----=
----
 drivers/gpu/drm/xe/xe_mmio.c                       |   2 +-
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c             |   4 +-
 drivers/gpu/drm/xe/xe_vm.c                         |  15 ++-
 86 files changed, 693 insertions(+), 464 deletions(-)

