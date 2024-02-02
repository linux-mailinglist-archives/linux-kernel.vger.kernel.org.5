Return-Path: <linux-kernel+bounces-50495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69588479DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB28287B02
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1B58060E;
	Fri,  2 Feb 2024 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezb3kvaf"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F51F188
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903176; cv=none; b=tiDyTsU6PQGz34Y36Kj8D4DUCv5gnYVLhvVsL+juCygCdOgJ17CbnPJWWHpXltrkS0kIgty2EcSiwvYF8R8U8QsBxYyo1ygM3HNuCV9/s3Ib1ohkjWOHh7rY6uqTxY2vNtHetlEabQ680xLfAB7p/KwN9pjs/3PJoSViitSgAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903176; c=relaxed/simple;
	bh=ydPlw+k56FH6oloRO1Eu6YfKfiABNX595o75/2IySJo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LGuaUL9E1tcD0KBijmd1ZGvpTcj2mgyGbi8j2GlfLEBBHu/YVaOGdmZKgiVWk/NDFOwAjzu+5r+RSUjDJL4Xbhozqd0zOBsuQK1chn4slPoVUGWb42lKp734dAKgGm4eciK5t2M2pPLzmU9EIgLS1AVo4EoNkCdH9277zdGLeNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ezb3kvaf; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso1751065a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 11:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706903172; x=1707507972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ8s+IKwkefeUnwT1uShIbYYjEfqWxHxFggYwOKgnWE=;
        b=Ezb3kvafM1/o56IPT6Q6w+m9KwcmSPs+UCtgLIIaUW+YTXDtVaX10FhKHdy/lPCXWt
         UmUUDynLgNQXRYB41ag57YR9+qiplP8lvFR9l+A8bd8QNUrrQOftWEpNVlWW4ohGWURw
         ayJ7VDt7hkMgYTJpd0NMN/ac4OGjgdVdXAMtT+WZtrKEhN1nyJPZkBZik9ZvDy19JaiW
         7+VFmPuqXIJXfogAbAZFxBhjQWztUQcoaNt0qWKbQuiZavvwN+vF1loIen+Y0rTedg6x
         KFl9ZkexybOSiSy7JEtaJ+VvPebR1/6fV7dHHpt/ZvWTN3HwjpAMDm3pyl8xTqih04oX
         npUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706903172; x=1707507972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ8s+IKwkefeUnwT1uShIbYYjEfqWxHxFggYwOKgnWE=;
        b=UzEv0yR5Cy2gsWJPAJgsKoYppTez78WXrY80iZhVJfOQMgnPehZuUFTOd9NO7FUKyP
         68fhC5yBhJzjXsNO/MlDt7pO5Kl7noBoXdTZX5DhJeVAb25W6qYvoBnzE2B+coYQstxi
         moAef+NhZRYnnRbBRczbfxPvwY0g+ddYlUgAc0cF/tohFMJjuKOjb6L+EV3P4+6RNrIn
         kyK9lfbItt6b+1XUzTZSrRxYXbH6nUkGoo9oYzA4TL9lhQE15g9gIogRal0PB56ZakeL
         mP91CfdfugOVU8+5nQeuRuW3EwpoGDEE4Y8qIB//h0HOdf3COaAVTXJAXFo3DxrlxR6f
         t1wA==
X-Gm-Message-State: AOJu0YxwdfLC6g5Ha9e42bii95DevqtDjjaKKp8v83YDqcG9tS/8sk6M
	Uuy3LqV4QYTNj6np7GTlj+Zurrm2qEcDlbrVIfWYf0e+VIRqprKqAQZ3ue2V8RJgXM7vh6iF3VT
	kxHGUcshc0eVI81bq7ZGVi+v+Fuk=
X-Google-Smtp-Source: AGHT+IFT2DrPAmcrWJ82zxW0seqIJLJYocsPAnH4XX/0feqmGpe5/tEIYJ8+ZE8hXVkfciPCeGtnizO0CRQqaYncmLY=
X-Received: by 2002:a17:906:3ecc:b0:a36:c466:52ea with SMTP id
 d12-20020a1709063ecc00b00a36c46652eamr2268822ejj.75.1706903171831; Fri, 02
 Feb 2024 11:46:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 3 Feb 2024 05:46:00 +1000
Message-ID: <CAPM=9tyM-ERLs5LuMP_QOuJPtR6Yf4f_ON-0dHBd0B-fBVu-4w@mail.gmail.com>
Subject: [git pull] drm fixes for 6.8-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Regular weekly fixes, mostly amdgpu and xe. One nouveau fix is a
better fix for the deadlock and also helps with a sync race we were
seeing.

Dave.

drm-fixes-2024-02-03:
drm fixes for 6.8-rc3

dma-buf:
- heaps CMA page accounting fix

virtio-gpu:
- fix segment size

xe:
- A crash fix
- A fix for an assert due to missing mem_acces ref
- Only allow a single user-fence per exec / bind.
- Some sparse warning fixes
- Two fixes for compilation failures on various odd
  combinations of gcc / arch pointed out on LKML.
- Fix a fragile partial allocation pointed out on LKML.
- A sysfs ABI documentation warning fix

amdgpu:
- Fix reboot issue seen on some 7000 series dGPUs
- Fix client init order for KFD
- Misc display fixes
- USB-C fix
- DCN 3.5 fixes
- Fix issues with GPU scheduler and GPU reset
- GPU firmware loading fix
- Misc fixes
- GC 11.5 fix
- VCN 4.0.5 fix
- IH overflow fix

amdkfd:
- SVM fixes
- Trap handler fix
- Fix device permission lookup
- Properly reserve BO before validating it

nouveau:
- fence/irq lock deadlock fix (second attempt)
- gsp command size fix
The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3=
:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-02-03

for you to fetch changes up to 39126abc5e20611579602f03b66627d7cd1422f0:

  nouveau: offload fence uevents work to workqueue (2024-02-02 17:15:47 +10=
00)

----------------------------------------------------------------
drm fixes for 6.8-rc3

dma-buf:
- heaps CMA page accounting fix

virtio-gpu:
- fix segment size

xe:
- A crash fix
- A fix for an assert due to missing mem_acces ref
- Only allow a single user-fence per exec / bind.
- Some sparse warning fixes
- Two fixes for compilation failures on various odd
  combinations of gcc / arch pointed out on LKML.
- Fix a fragile partial allocation pointed out on LKML.
- A sysfs ABI documentation warning fix

amdgpu:
- Fix reboot issue seen on some 7000 series dGPUs
- Fix client init order for KFD
- Misc display fixes
- USB-C fix
- DCN 3.5 fixes
- Fix issues with GPU scheduler and GPU reset
- GPU firmware loading fix
- Misc fixes
- GC 11.5 fix
- VCN 4.0.5 fix
- IH overflow fix

amdkfd:
- SVM fixes
- Trap handler fix
- Fix device permission lookup
- Properly reserve BO before validating it

nouveau:
- fence/irq lock deadlock fix (second attempt)
- gsp command size fix

----------------------------------------------------------------
Badal Nilawar (1):
      drm/hwmon: Fix abi doc warnings

Charlene Liu (2):
      Revert "drm/amd/display: initialize all the dpm level's stutter laten=
cy"
      drm/amd/display: fix USB-C flag update after enc10 feature init

Dave Airlie (5):
      Merge tag 'drm-misc-fixes-2024-02-01' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-xe-fixes-2024-02-01' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.8-2024-02-01' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      nouveau/gsp: use correct size for registry rpc.
      nouveau: offload fence uevents work to workqueue

David McFarland (1):
      drm/amd: Don't init MEC2 firmware when it fails to load

Dmytro Laktyushkin (1):
      drm/amd/display: Fix DPSTREAM CLK on and off sequence

Fangzhi Zuo (1):
      drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue

Friedrich Vock (1):
      drm/amdgpu: Reset IH OVERFLOW_CLEAR bit

Jay Cornwall (1):
      drm/amdkfd: Use S_ENDPGM_SAVED in trap handler

Jos=C3=A9 Roberto de Souza (1):
      drm/xe: Fix crash in trace_dma_fence_init()

Lang Yu (1):
      drm/amdkfd: reserve the BO before validating it

Le Ma (1):
      drm/amdgpu: move the drm client creation behind drm device registrati=
on

Ma Jun (2):
      drm/amdgpu: Fix the warning info in mode1 reset
      drm/amdgpu/pm: Use inline function for IP version check

Mario Limonciello (1):
      Revert "drm/amd/pm: fix the high voltage and temperature issue"

Matt Roper (1):
      drm/xe: Grab mem_access when disabling C6 on skip_guc_pc platforms

Matthew Brost (3):
      drm/xe: Only allow 1 ufence per exec / bind IOCTL
      drm/xe: Use LRC prefix rather than CTX prefix in lrc desc defines
      drm/xe: Make all GuC ABI shift values unsigned

Mukul Joshi (1):
      drm/amdkfd: Use correct drm device for cgroup permission check

Nicholas Susanto (1):
      drm/amd/display: Underflow workaround by increasing SR exit latency

Philip Yang (1):
      drm/amdkfd: Correct partial migration virtual addr

Sebastian Ott (1):
      drm/virtio: Set segment size for virtio_gpu device

Sohaib Nadeem (1):
      drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz

Srinivasan Shanmugam (3):
      drm/amd/display: Add NULL check for kzalloc in
'amdgpu_dm_atomic_commit_tail()'
      drm/amd/display: Fix buffer overflow in
'get_host_router_total_dp_tunnel_bw()'
      drm/amdgpu: Fix missing error code in 'gmc_v6/7/8/9_0_hw_init()'

T.J. Mercier (1):
      dma-buf: heaps: Don't track CMA dma-buf pages under RssFile

Thomas Hellstr=C3=B6m (3):
      drm/xe: Annotate mcr_[un]lock()
      drm/xe: Don't use __user error pointers
      drm/xe/vm: Subclass userptr vmas

Wenjing Liu (1):
      drm/amd/display: fix incorrect mpc_combine array size

Yifan Zhang (2):
      drm/amdgpu: drm/amdgpu: remove golden setting for gfx 11.5.0
      drm/amdgpu: remove asymmetrical irq disabling in vcn 4.0.5 suspend

 .../ABI/testing/sysfs-driver-intel-i915-hwmon      |  14 +-
 .../ABI/testing/sysfs-driver-intel-xe-hwmon        |  14 +-
 drivers/dma-buf/heaps/cma_heap.c                   |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  32 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  20 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  36 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  12 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |   2 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                |   6 +
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |   5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   2 -
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  22 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |   5 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c               |   6 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c               |   7 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |   6 +
 drivers/gpu/drm/amd/amdgpu/si_ih.c                 |   6 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |   6 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |  17 ---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            |  19 ---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |   6 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c             |   6 +
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |  14 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm |   2 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   9 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   4 +
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |  32 ++--
 .../amd/display/dc/dcn32/dcn32_dio_link_encoder.c  |   4 +-
 .../amd/display/dc/dcn35/dcn35_dio_link_encoder.c  |   4 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |   4 +-
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   |   4 +-
 .../amd/display/dc/dml2/dml2_translation_helper.c  |  33 ++---
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   2 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  11 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   2 +
 .../display/dc/link/protocols/link_dp_dpia_bw.c    |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  33 +----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   1 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  10 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   8 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |  24 ++-
 drivers/gpu/drm/nouveau/nouveau_fence.h            |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     |   2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |   1 +
 drivers/gpu/drm/xe/abi/guc_actions_abi.h           |   4 +-
 drivers/gpu/drm/xe/abi/guc_actions_slpc_abi.h      |   4 +-
 drivers/gpu/drm/xe/abi/guc_communication_ctb_abi.h |   8 +-
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h              |   6 +-
 drivers/gpu/drm/xe/abi/guc_messages_abi.h          |  20 +--
 drivers/gpu/drm/xe/xe_exec.c                       |  10 +-
 drivers/gpu/drm/xe/xe_gt_mcr.c                     |   4 +-
 drivers/gpu/drm/xe/xe_gt_pagefault.c               |  11 +-
 drivers/gpu/drm/xe/xe_guc_pc.c                     |   2 +
 drivers/gpu/drm/xe/xe_hw_fence.c                   |   6 +-
 drivers/gpu/drm/xe/xe_lrc.c                        |  14 +-
 drivers/gpu/drm/xe/xe_pt.c                         |  32 ++--
 drivers/gpu/drm/xe/xe_query.c                      |  50 +++----
 drivers/gpu/drm/xe/xe_sync.h                       |   5 +
 drivers/gpu/drm/xe/xe_vm.c                         | 165 ++++++++++++-----=
----
 drivers/gpu/drm/xe/xe_vm.h                         |  16 +-
 drivers/gpu/drm/xe/xe_vm_types.h                   |  16 +-
 72 files changed, 475 insertions(+), 403 deletions(-)

