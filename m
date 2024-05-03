Return-Path: <linux-kernel+bounces-167220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA328BA5D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C601B1F224ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F11F951;
	Fri,  3 May 2024 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv7Tww9u"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE21CD24
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714708378; cv=none; b=BjHU8F4JxthntPKQ6hf58/pgo8e4jFQQVj5OAKAgGDVdNZi3jMQXYd2PtNjdOd4fqxTAwbxvetxGz5Z8GLfLrM6cptOMSBvLmrfowM0ajR4glhZJI1A5NKIjbwxQFgDVjmQkLBz/GMjUCYvU/TO0zN6rpmMqtf4+RY67EiC/KjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714708378; c=relaxed/simple;
	bh=K3NxHbNH2ft4WoOJmQoPLsuG2f7rEusfhMLBNGOsqJg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P1dWaDoC7tCviKiXMd0R6yHkS4kJcMz9KYT01N1sZQ6nMCa3Ka48LwwvEYrqgwKcvi5YV46rZ2J3XDc8eXigiMMD6HTr7dpfnxf6HyrtuWqPczGf2+2LufXUwoGc59Ja4ovIZb57ZaTLXtdj0XElOtebWI9v3OZtst+YFsJlvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv7Tww9u; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a58fc650f8fso740728366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 20:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714708375; x=1715313175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iy4Fc+Is3/f7DsGtTqeBrCfKRHTo9HAk7taFS9ybm40=;
        b=hv7Tww9u2upvF2xP6zRuSZkNjuHDIPsMG9aAWuIhSkiLXfA68KI03wJfoJjpJB0pWf
         4s4I+tIwZS+rK8MDy7HdDOy9OfkXUyXdB8Lx90/xgWI3d6DnLTok+e03IKll1DsYbLN2
         mSd6cUEYbw86iT8GjvOrqgdnNNL36Uwq9tuI/BrqaHDVKb6ZYKMyzHSjHreRwwqEbJ3y
         YojlvTsjWldlOZQZjrzVYQA0AIySN4Q7fIeiWusezblfj17c7AxXqp3wB2K8sJuwBvcx
         HAGHdMe18WFQ+E7pkre6gj4es7ZOMCHPJVDGslzpFpTJnr8HJ/mWvGF6OI0LvpKnfOrM
         mQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714708375; x=1715313175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iy4Fc+Is3/f7DsGtTqeBrCfKRHTo9HAk7taFS9ybm40=;
        b=as/QkFpWp2ZzBJQI03Lk+ND37iVeoY9bdm+SCjEgoDc7PglKs7pBQa2GHOc2GVi0VM
         CUeBXsJ5nMLNPIBKXAoAl6hrfMb31qCjyGJeQNO/Eg6Y8X9jHna9iHXtFdEgc/Kq6s1X
         OecVT8xIQ9pDS8kkuKsyV80C1qwHKSavETljXv2ZcTRsyKL2fMaDT9RIurpqymA2NIVO
         +SZEfkFcn/5LOFb1O/IWufjCnf8X6LWhaRiXWCZNmyxhaNVP2CbrhfqvbD7czYeRfVF8
         zv51iy+LD1k80Qn/xYtNQcG3eiTpSW0faEE8mAQr/+kWvJdNGZVWlifqPio6e1niqsKy
         c50g==
X-Forwarded-Encrypted: i=1; AJvYcCU31fn5c4adsiaK+ZsLR+FCkgiPnTYFBBWsUIi0JzictHKrRyHWjkhudup5nQw4VwDCysB7VJnE/zHsqgj4szocMg6oHC3jPDhH/qVE
X-Gm-Message-State: AOJu0Yzle4NhagGZz6ue1qQASrhAcsKQOJj6v4sIXTUUEXHfEBsn/p1G
	UMHddgkyGdIKkRahStsfyKlSi3T7MNWIaeTkusleM03b5TQkQyotTi1TTM8VSamaR0jFai9BZQX
	x2CWq1oK87HgxaRe1wtJG/ZHjh4s=
X-Google-Smtp-Source: AGHT+IHGWMY7wl/zE8XeCsE0g+Zrazhy7xVmSU3nOJqYRmJvCWUTcKzS2GMAJj1HlF+JqPwQr1xf8r3VWBROJwHDXOM=
X-Received: by 2002:a17:906:fa0c:b0:a58:7ce0:8ebd with SMTP id
 lo12-20020a170906fa0c00b00a587ce08ebdmr742405ejb.19.1714708375060; Thu, 02
 May 2024 20:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 3 May 2024 13:52:43 +1000
Message-ID: <CAPM=9ty6LzXnyr5J1RrR8xRdiRcooTkoPuq9m108mUEsF7R98g@mail.gmail.com>
Subject: [git pull] drm fixes for 6.9-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Weekly fixes, mostly made up from amdgpu and some panel changes.
Otherwise xe, nouveau, vmwgfx and a couple of others, all seems pretty
on track.

Dave.

drm-fixes-2024-05-03:
drm fixes for 6.9-rc7

amdgpu:
- Fix VRAM memory accounting
- DCN 3.1 fixes
- DCN 2.0 fix
- DCN 3.1.5 fix
- DCN 3.5 fix
- DCN 3.2.1 fix
- DP fixes
- Seamless boot fix
- Fix call order in amdgpu_ttm_move()
- Fix doorbell regression
- Disable panel replay temporarily

amdkfd:
- Flush wq before creating kfd process

xe:
- Fix UAF on rebind worker
- Fix ADL-N display integration

imagination:
- fix page-count macro

nouveau:
- avoid page-table allocation failures
- fix firmware memory allocation

panel:
- ili9341: avoid OF for device properties; respect deferred probe; fix
  usage of errno codes

ttm:
- fix status output

vmwgfx:
- fix legacy display unit
- fix read length in fence signalling
The following changes since commit e67572cd2204894179d89bd7b984072f19313b03=
:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-05-03

for you to fetch changes up to 09e10499ee6a5a89fc352f25881276398a49596a:

  Merge tag 'drm-misc-fixes-2024-05-02' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2024-05-03 11:16:40 +1000)

----------------------------------------------------------------
drm fixes for 6.9-rc7

amdgpu:
- Fix VRAM memory accounting
- DCN 3.1 fixes
- DCN 2.0 fix
- DCN 3.1.5 fix
- DCN 3.5 fix
- DCN 3.2.1 fix
- DP fixes
- Seamless boot fix
- Fix call order in amdgpu_ttm_move()
- Fix doorbell regression
- Disable panel replay temporarily

amdkfd:
- Flush wq before creating kfd process

xe:
- Fix UAF on rebind worker
- Fix ADL-N display integration

imagination:
- fix page-count macro

nouveau:
- avoid page-table allocation failures
- fix firmware memory allocation

panel:
- ili9341: avoid OF for device properties; respect deferred probe; fix
  usage of errno codes

ttm:
- fix status output

vmwgfx:
- fix legacy display unit
- fix read length in fence signalling

----------------------------------------------------------------
Andy Shevchenko (3):
      drm/panel: ili9341: Correct use of device property APIs
      drm/panel: ili9341: Respect deferred probe
      drm/panel: ili9341: Use predefined error codes

Christian K=C3=B6nig (1):
      drm/amdgpu: once more fix the call oder in amdgpu_ttm_move() v2

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-6.9-2024-05-01' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-xe-fixes-2024-05-02' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-05-02' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Gabe Teeger (1):
      drm/amd/display: Atom Integrated System Info v2_2 for DCN35

George Shen (1):
      drm/amd/display: Handle Y carry-over in VCP X.Y calculation

Hersen Wu (1):
      drm/amd/display: Fix incorrect DSC instance for MST

Ian Forbes (1):
      drm/vmwgfx: Fix Legacy Display Unit

Lancelot SIX (1):
      drm/amdkfd: Flush the process wq before creating a kfd_process

Leo Ma (1):
      drm/amd/display: Fix DC mode screen flickering on DCN321

Lucas De Marchi (1):
      drm/xe/display: Fix ADL-N detection

Lyude Paul (2):
      drm/nouveau/firmware: Fix SG_DEBUG error with nvkm_firmware_ctor()
      drm/nouveau/gsp: Use the sg allocator for level 2 of radix3

Mario Limonciello (1):
      drm/amd/display: Disable panel replay by default for now

Matt Coster (1):
      drm/imagination: Ensure PVR_MIPS_PT_PAGE_COUNT is never zero

Matthew Auld (1):
      drm/xe/vm: prevent UAF in rebind_work_func()

Meenakshikumar Somasundaram (1):
      drm/amd/display: Allocate zero bw after bw alloc enable

Mukul Joshi (1):
      drm/amdgpu: Fix VRAM memory accounting

Rodrigo Siqueira (2):
      drm/amd/display: Ensure that dmcub support flag is set for DCN20
      drm/amd/display: Add VCO speed parameter for DCN31 FPU

Shashank Sharma (1):
      drm/amdgpu: fix doorbell regression

Sung Joon Kim (1):
      drm/amd/display: Disable seamless boot on 128b/132b encoding

Swapnil Patel (1):
      drm/amd/display: Add dtbclk access to dcn315

Zack Rusin (2):
      drm/ttm: Print the memory decryption status just once
      drm/vmwgfx: Fix invalid reads in fence signaled events

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         | 14 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 50 +++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  8 +++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 21 +++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 48 ++++++++++----
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |  1 +
 .../amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |  8 +++
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   | 15 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  3 +
 .../display/dc/dcn31/dcn31_hpo_dp_link_encoder.c   |  6 ++
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c   |  2 +
 .../display/dc/link/protocols/link_dp_dpia_bw.c    | 10 ++-
 .../amd/display/dc/resource/dcn20/dcn20_resource.c |  1 +
 drivers/gpu/drm/imagination/pvr_fw_mips.h          |  5 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h  |  4 +-
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c       | 19 ++++--
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     | 77 ++++++++++++++----=
----
 drivers/gpu/drm/panel/Kconfig                      |  2 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c       | 13 ++--
 drivers/gpu/drm/ttm/ttm_tt.c                       |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |  2 +-
 drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h  |  3 +-
 drivers/gpu/drm/xe/xe_vm.c                         |  3 +
 26 files changed, 223 insertions(+), 101 deletions(-)

