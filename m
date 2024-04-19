Return-Path: <linux-kernel+bounces-150895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F248AA65F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23931F21EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DFC818;
	Fri, 19 Apr 2024 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9O1lYSe"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E164A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713488001; cv=none; b=i7FJFeAvNMhOF+BpBF6kZRXst2JxRd7nhz/8rw4643CSDeg3UWC0sqs8D8uawAFRtwyjOJmLbQoEayoNSP/Z0kR3pp2wYvE7EH/j8PgBBaVyHKrr3nk7MojsghPtuTFCoOv5yYXMiBC20p4t40ncJJN9Aue0Q6Y4KgKZPrjZcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713488001; c=relaxed/simple;
	bh=s1EyO+nCqcbRIMnoZIpasGkPtjAzyN1jGVZ9F1RpEQo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Tuqm+61B8M9EtVpG5oS7g1CjdJZ76Ow0KSBYlqqJ3iZnQWYn75SJZq+K+cbOT1IAj19pksxQJ8WznBdNuSo2hRhRkpfzr66Anw8paHy5R9B4GULREyAxErgRBxp6lKP5CsjD4ZRPaSNNd//dlRfDz8YUFNbYuzajytWNW8QV5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9O1lYSe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-418f1d77adaso7953445e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713487997; x=1714092797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=75zr9p/fh/PWCweFikTRplCtvZIMjSWtAwBUBiqCtJY=;
        b=K9O1lYSeRHuaIinj06xqPzJWUj5Nv9grrYM7NmimbCoOiH8zNukZ2wnEqEc33Nija2
         CoxbV+EV/PwYmJIwxxxmSNYZ9j1DxnCIayIdFi26JuGZoW/TMJWahcKB6fbIunY1B53/
         wUzCs4sNBvWwoABXdqUHjd76o9zf3ZyVV+4ty3szGNoad8oKDEqY9TY5X+hPUVY4i7lH
         xaSVpRab388Vh7serTyvymjKpFLUPZtCcBHVqOr8seEMg/M2+Xo7J3aEk6qWcn3WjLQy
         rmUMxmMaf5/tYmBIjnCdB0N412+gR2TPxeaD41FvrHk2Eabj7Bvp83HGzM9J4dlhz5WB
         Ozwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713487997; x=1714092797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75zr9p/fh/PWCweFikTRplCtvZIMjSWtAwBUBiqCtJY=;
        b=j2Y0NoWga5B3lIzg9W+8X5EDWh1grrMG0uJ1RZIYfsr7rlK/WkIpcKDvOWsVBr7WfD
         uNHAad6MtwyG7bHIHBWfjCyqakNTei1jMcY/uN8XYmzoJGOtsEDCwUP3ZX83+WhCLvC0
         xUsIQVXLsvGG3wTBsNxQWLKDzJZTTjo4SfUdSUlvQq0w03jz08V5Vq81FgiyxEW8AG6b
         uvqzvVs3gPRaZfEGKapsDuCtJ84HwSCZCTTSc4W30Vc3scumyL7iCUFaCV9Kb8G109gx
         pWiC8qiyUR5iwtYrS9VH1R8c9nwOryMjxczN7kkxQIvwkV+/Ej8izWUIsMJytda9Og2i
         oyUA==
X-Forwarded-Encrypted: i=1; AJvYcCVh5aI+veI9y0z/pddp1Tu4ou+LZ5yQqffok6eKbsFKDNT7fZocgTpztkNSTOVAEJVolRzUTJaLsIp1VL+ZE5k04wkninl69gAUunsf
X-Gm-Message-State: AOJu0YwdhLtZQ4/D2PO56FpwUYfeDfXHFGatKTWuHAQ8n3fNnaPGRW/F
	toRz9O57Nt1GCt6AKyeJr/fEHY/vFRV/7kXPYyiS1LM7jTJdiv3KTACK6VJd5EHfhjXTJzZxTz1
	8BnSTcYtFuBZfWR6dD8CbfN/Msswew3pF
X-Google-Smtp-Source: AGHT+IHDxhNcglaeB2Qft4xeEEFXKNdWCvstiy/xJVZXvE2C3LfODAnguT6hDp2iE94yPOgU9gbPKG4J1PLVijHSinM=
X-Received: by 2002:a5d:4147:0:b0:34a:2d0c:4463 with SMTP id
 c7-20020a5d4147000000b0034a2d0c4463mr393091wrq.4.1713487997324; Thu, 18 Apr
 2024 17:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 19 Apr 2024 10:53:05 +1000
Message-ID: <CAPM=9tyKSyw-hDGcGSHom+C0iiagDbgrX=1oxv08jV+KRL=m8w@mail.gmail.com>
Subject: [git pull] drm fixes for 6.9-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Regular week of fixes, seems to be about right for this time in the
release cycle, amdgpu, and nouveau are the main one with some
scattered fixes otherwise.

Dave.

drm-fixes-2024-04-19:
drm fixes for v6.9-rc5

ttm:
- Stop pooling cached NUMA pages

amdgpu:
- Fix invalid resource->start check
- USB-C DSC fix
- Fix a potential UAF in VA IOCTL
- Fix visible VRAM handling during faults

amdkfd:
- Fix memory leak in create_process failure

radeon:
- Silence UBSAN warnings from variable sized arrays

nouveau:
- dp: Don't probe DP ports twice
- nv04: Fix OOB access
- nv50: Disable AUX bus for disconnected DP ports
- nvkm: Fix instmem race condition

panel:
- Don't unregister DSI devices in several drivers

v3d:
- Fix enabled_ns increment

xe:
- Fix bo leak on error path during fb init
- Fix use-after-free due to order vm is put and destroyed
The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680=
:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-19

for you to fetch changes up to 52c8b6e1c007b93d35058508fbe1ec80a1d9ca39:

  Merge tag 'drm-xe-fixes-2024-04-18' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2024-04-19 10:40:47 +1000)

----------------------------------------------------------------
drm fixes for v6.9-rc5

ttm:
- Stop pooling cached NUMA pages

amdgpu:
- Fix invalid resource->start check
- USB-C DSC fix
- Fix a potential UAF in VA IOCTL
- Fix visible VRAM handling during faults

amdkfd:
- Fix memory leak in create_process failure

radeon:
- Silence UBSAN warnings from variable sized arrays

nouveau:
- dp: Don't probe DP ports twice
- nv04: Fix OOB access
- nv50: Disable AUX bus for disconnected DP ports
- nvkm: Fix instmem race condition

panel:
- Don't unregister DSI devices in several drivers

v3d:
- Fix enabled_ns increment

xe:
- Fix bo leak on error path during fb init
- Fix use-after-free due to order vm is put and destroyed

----------------------------------------------------------------
Alex Deucher (3):
      Revert "drm/amd/display: fix USB-C flag update after enc10 feature in=
it"
      drm/radeon: make -fstrict-flex-arrays=3D3 happy
      drm/radeon: silence UBSAN warning (v3)

Christian K=C3=B6nig (3):
      drm/ttm: stop pooling cached NUMA pages v2
      drm/amdgpu: remove invalid resource->start check v2
      drm/amdgpu: fix visible VRAM handling during faults

Dave Airlie (4):
      nouveau: fix instmem race condition around ptr stores
      Merge tag 'amd-drm-fixes-6.9-2024-04-17' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2024-04-18' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-04-18' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Dmitry Baryshkov (2):
      drm/panel: visionox-rm69299: don't unregister DSI device
      drm/panel: novatek-nt36682e: don't unregister DSI device

Felix Kuehling (1):
      drm/amdkfd: Fix memory leak in create_process failure

Lyude Paul (2):
      drm/nouveau/kms/nv50-: Disable AUX bus for disconnected DP ports
      drm/nouveau/dp: Don't probe eDP ports twice harder

Maarten Lankhorst (1):
      drm/xe: Fix bo leak in intel_fb_bo_framebuffer_init

Matthew Auld (1):
      drm/xe/vm: prevent UAF with asid based lookup

Ma=C3=ADra Canal (1):
      drm/v3d: Don't increment `enabled_ns` twice

Mikhail Kobuk (1):
      drm: nv04: Fix out of bounds access

Zack Rusin (3):
      drm/vmwgfx: Fix prime import/export
      drm/vmwgfx: Fix crtc's atomic check conditional
      drm/vmwgfx: Sort primary plane formats by order of preference

xinhui pan (1):
      drm/amdgpu: validate the parameters of bo mapping operations more cle=
arly

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         | 22 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         | 22 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 65 +++++++++++-------=
-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 72 ++++++++++++++----=
----
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  4 +-
 .../amd/display/dc/dcn32/dcn32_dio_link_encoder.c  |  8 +--
 .../amd/display/dc/dcn35/dcn35_dio_link_encoder.c  |  4 +-
 drivers/gpu/drm/nouveau/nouveau_bios.c             | 13 ++--
 drivers/gpu/drm/nouveau/nouveau_dp.c               | 23 +++++--
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |  7 ++-
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c     |  2 -
 drivers/gpu/drm/panel/panel-visionox-rm69299.c     |  2 -
 drivers/gpu/drm/radeon/pptable.h                   | 10 +--
 drivers/gpu/drm/radeon/radeon_atombios.c           |  8 ++-
 drivers/gpu/drm/ttm/ttm_pool.c                     | 38 +++++++++---
 drivers/gpu/drm/v3d/v3d_irq.c                      |  4 --
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               | 35 ++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |  7 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                 |  2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                | 32 ++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 11 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c              | 15 ++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         | 44 ++++++++-----
 drivers/gpu/drm/xe/display/intel_fb_bo.c           |  8 ++-
 drivers/gpu/drm/xe/xe_vm.c                         | 21 ++++---
 30 files changed, 320 insertions(+), 172 deletions(-)

