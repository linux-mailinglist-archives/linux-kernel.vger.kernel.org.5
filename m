Return-Path: <linux-kernel+bounces-77629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9B2860842
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B511F23ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A4BAD4C;
	Fri, 23 Feb 2024 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQDroV2F"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85EAD35
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708651945; cv=none; b=UCtU4dFAoT4cEdlNqUowyOmb5ZXxrNXDZLWIecp1/oGyJ84ft5wkGQB9XZUZ0EK4SKueGnbtx8OwgVpPAmcyBfef/M7WPCinT7hYwREZPsBIrvxmUhgvqijTKhXjpuDsqmiTwh7q0qfkGHJuWFfS6CtJWNxrwDG1DFdYDdsVcTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708651945; c=relaxed/simple;
	bh=egWUfa9mpoH3XAG6komng0mYQKjvJLJrhdXOlQ68R4A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oOy0QzNmKNpfZTRekncSrdPAqBLPYK0hH4GQ1fg/kcRTi1pNOzAHJA3BbHLFcEqphSejdt2ahIxiXHpoz3CeFmxPDe/9NGBBZbge/E/GYQ2oRSDE2Leq3aThrXM1ISC0me4Sw0EVCLVo67VNZY4s1r33bfM2XlijbngAi2gxFdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQDroV2F; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3122b70439so41245066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708651941; x=1709256741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/BNlMODgaqJRncFeOsomveD96NTb11ftCWfvLQq0dY=;
        b=cQDroV2FoCt/ysdGbsgb4eClsyiVCP9NHsRBvjwIc2zVjPRRWzsPpuAGG5Jv26XgPB
         dk8NChhXnICAM66P+MntMVMZ/2v1AvlVd1fdJpUSfGWyFwhixNjo9SqWlpUYYj2wqL1T
         GUyE1a+A+HIcszgkw3g5Zh/QQnGilx9SijO5Bn5MzXlTF+wWXsaqGILq0eTU8rBNZUyA
         Ahf00GSwnymEmIMU6ycwJCH0PUZMSU20prCJBvOkXq6TqXl5FUvrB6T3JicOEM4nH1Kr
         9zxk4Lydj7zV/Xh8oRXM8kZYzTeu6+W75okLDjquWOj6Zy5WAnp+DEGX1xua4GCzqc0/
         RTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708651941; x=1709256741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/BNlMODgaqJRncFeOsomveD96NTb11ftCWfvLQq0dY=;
        b=kX70VyV5C39aobnloe8+suuB6xYckEzkADsYLggL0GL3YfJvUollUH9TOMUmg2Gl/B
         PHHO4PT3Co1llVqblCjKEn5k5pZO7YQGE+JvRPlYmTkuJlhfKu7riRr9yq8esigku/8Q
         QI4Z3uAEdAA8pHnMFNyLDXtPmuFNPLF5rWZ36+ppgAouV6jSsR/giOeSIYDL6yCBwhU4
         2FGE6oZqZrSlcoDNJZyr/MFR74kpj+wjx7jF0NcGbzFhhL2o01lAPRgH1SP/3N8mDJg0
         ZhOh2XyLKFv0hA/xnWXNPN33NfIz+zjWuUyaParspVkXksHZcHG/4x+I+B4hTqSVWg9Z
         zJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLKKgtMWcE3pHwySndeiRa06EMxi0Z/v6z6vboiJ3BmmCsAYiX8WGED+sN8Wkjg++hCkVOCZHu4I28QV4C+SaRtNPdCf2dpbMNdk7i
X-Gm-Message-State: AOJu0Yx7v6jEjoS9vQxoe3quozcLtehRSrVSpWeQ+qtasO5r49IwJe9f
	LjTYxxcpGgZ9Lhch+0dIRpgRPi+v/05ycqsjCQ7JRtvxz4fvUFqRbsVoU0GYhXo64VQ3P4B+EHg
	bA+LaXvyHwnnN2fI1Uf9rwOTynAyFd6vMtPs0WQ==
X-Google-Smtp-Source: AGHT+IGkCzeuli7eOzYMSqqBixtZ+GmvEd1t9FWMXhItJetRw3EEdmkf5x2W9OWcHwfeXWK82Nv5jZBBWVNWWKvWXdA=
X-Received: by 2002:a17:906:f915:b0:a3f:988f:b9c4 with SMTP id
 lc21-20020a170906f91500b00a3f988fb9c4mr310260ejb.7.1708651941409; Thu, 22 Feb
 2024 17:32:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 23 Feb 2024 11:32:09 +1000
Message-ID: <CAPM=9tzmzFd8UsKbpvo0vMh08DmgKMNgOCVZ-T5KgfZHyw-4bw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.8-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

This is the weekly drm fixes. Non-drivers there is a fbdev/sparc fix,
syncobj, ttm and buddy fixes.
On the driver side, ivpu, meson, i915 have a small fix each. Then
amdgpu and xe have a bunch. Nouveau has some minor uapi additions to
give userspace some useful info along with a Kconfig change to allow
the new GSP firmware paths to be used by default on the GPUs it
supports.

Seems about the usual amount for this time of release cycle.

Dave.

drm-fixes-2024-02-23:
drm fixes for 6.8-rc6

fbdev:
- fix sparc undefined reference

syncobj:
- fix sync obj fence waiting
- handle NULL fence in syncobj eventfd code

ttm:
- fix invalid free

buddy:
- fix list handling
- fix 32-bit build

meson:
- don't remove bridges from other drivers

nouveau:
- fix build warnings
- add two minor info parameters
- add a Kconfig to allow GSP by default on some GPUs

ivpu:
- allow fw to do initial tile config

i915:
- fix TV mode

amdgpu:
- Suspend/resume fixes
- Backlight error fix
- DCN 3.5 fixes
- Misc fixes

xe:
- Remove support for persistent exec_queues
- Drop a reduntant sysfs newline printout
- A three-patch fix for a VM_BIND rebind optimization path
- Fix a modpost warning on an xe KUNIT module
The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d=
:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-02-23

for you to fetch changes up to 72fa02fdf83306c52bc1eede28359e3fa32a151a:

  nouveau: add an ioctl to report vram usage (2024-02-23 10:20:07 +1000)

----------------------------------------------------------------
drm fixes for 6.8-rc6

fbdev:
- fix sparc undefined reference

syncobj:
- fix sync obj fence waiting
- handle NULL fence in syncobj eventfd code

ttm:
- fix invalid free

buddy:
- fix list handling
- fix 32-bit build

meson:
- don't remove bridges from other drivers

nouveau:
- fix build warnings
- add two minor info parameters
- add a Kconfig to allow GSP by default on some GPUs

ivpu:
- allow fw to do initial tile config

i915:
- fix TV mode

amdgpu:
- Suspend/resume fixes
- Backlight error fix
- DCN 3.5 fixes
- Misc fixes

xe:
- Remove support for persistent exec_queues
- Drop a reduntant sysfs newline printout
- A three-patch fix for a VM_BIND rebind optimization path
- Fix a modpost warning on an xe KUNIT module

----------------------------------------------------------------
Andrzej Kacprowski (1):
      accel/ivpu: Don't enable any tiles by default on VPU40xx

Armin Wolf (1):
      drm/amd/display: Fix memory leak in dm_sw_fini()

Arnd Bergmann (1):
      nouveau: fix function cast warnings

Arunpravin Paneer Selvam (1):
      drm/buddy: Modify duplicate list_splice_tail call

Ashutosh Dixit (2):
      drm/xe/xe_gt_idle: Drop redundant newline in name
      drm/xe: Fix modpost warning on xe_mocs kunit module

Dan Carpenter (1):
      drm/nouveau/mmu/r535: uninitialized variable in r535_bar_new_()

Dave Airlie (7):
      Merge tag 'drm-misc-fixes-2024-02-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2024-02-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.8-2024-02-22' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-xe-fixes-2024-02-22' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      nouveau/gsp: add kconfig option to enable GSP paths by default
      nouveau: add an ioctl to return vram bar size.
      nouveau: add an ioctl to report vram usage

Erik Kurzinger (2):
      drm/syncobj: call drm_syncobj_fence_add_wait when WAIT_AVAILABLE
flag is set
      drm/syncobj: handle NULL fence in syncobj_eventfd_entry_func

Javier Martinez Canillas (1):
      sparc: Fix undefined reference to fb_is_primary_device

Lewis Huang (1):
      drm/amd/display: Only allow dig mapping to pwrseq in new asic

Ma Jun (1):
      drm/amdgpu: Fix the runtime resume failure issue

Martin Blumenstingl (1):
      drm/meson: Don't remove bridges which are created by other drivers

Matthew Auld (1):
      drm/tests/drm_buddy: fix 32b build

Matthew Brost (3):
      drm/xe: Fix xe_vma_set_pte_size
      drm/xe: Add XE_VMA_PTE_64K VMA flag
      drm/xe: Return 2MB page size for compact 64k PTEs

Maxime Ripard (1):
      drm/i915/tv: Fix TV mode

Melissa Wen (1):
      drm/amd/display: fix null-pointer dereference on edid reading

Srinivasan Shanmugam (1):
      drm/amd/display: Fix potential null pointer dereference in dc_dmub_sr=
v

Swapnil Patel (1):
      drm/amd/display: fix input states translation error for dcn35 & dcn35=
1

Thomas Hellstr=C3=B6m (2):
      drm/xe/uapi: Remove support for persistent exec_queues
      drm/ttm: Fix an invalid freeing on already freed page in error path

Wayne Lin (1):
      drm/amd/display: adjust few initialization order in dm

 arch/sparc/Makefile                                |  2 +-
 arch/sparc/video/Makefile                          |  2 +-
 drivers/accel/ivpu/ivpu_hw_40xx.c                  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  3 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 57 +++++++++++++-----=
----
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |  7 ++-
 .../gpu/drm/amd/display/dc/dce/dce_panel_cntl.c    |  1 +
 .../drm/amd/display/dc/dcn301/dcn301_panel_cntl.c  |  1 +
 .../drm/amd/display/dc/dcn31/dcn31_panel_cntl.c    | 18 ++++++-
 .../amd/display/dc/dml2/dml2_translation_helper.c  |  9 +++-
 drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h |  2 +-
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 26 +---------
 drivers/gpu/drm/drm_buddy.c                        |  4 +-
 drivers/gpu/drm/drm_syncobj.c                      | 19 ++++++--
 drivers/gpu/drm/i915/display/intel_sdvo.c          | 10 ++--
 drivers/gpu/drm/i915/display/intel_tv.c            | 10 ++--
 drivers/gpu/drm/meson/meson_encoder_cvbs.c         |  1 -
 drivers/gpu/drm/meson/meson_encoder_dsi.c          |  1 -
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |  1 -
 drivers/gpu/drm/nouveau/Kconfig                    |  8 +++
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |  9 ++++
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c     |  5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c  |  8 ++-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     |  6 ++-
 drivers/gpu/drm/tests/drm_buddy_test.c             | 16 +++---
 drivers/gpu/drm/ttm/ttm_pool.c                     |  2 +-
 drivers/gpu/drm/xe/tests/xe_mocs_test.c            |  1 +
 drivers/gpu/drm/xe/xe_device.c                     | 39 ---------------
 drivers/gpu/drm/xe/xe_device.h                     |  4 --
 drivers/gpu/drm/xe/xe_device_types.h               |  8 ---
 drivers/gpu/drm/xe/xe_exec_queue.c                 | 33 ++-----------
 drivers/gpu/drm/xe/xe_exec_queue_types.h           | 10 ----
 drivers/gpu/drm/xe/xe_execlist.c                   |  2 -
 drivers/gpu/drm/xe/xe_gt_idle.c                    |  4 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  2 -
 drivers/gpu/drm/xe/xe_pt.c                         | 11 +++--
 drivers/gpu/drm/xe/xe_vm.c                         | 14 ++++--
 drivers/gpu/drm/xe/xe_vm_types.h                   |  2 +
 include/uapi/drm/nouveau_drm.h                     | 14 ++++++
 include/uapi/drm/xe_drm.h                          |  1 -
 40 files changed, 184 insertions(+), 191 deletions(-)

