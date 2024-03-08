Return-Path: <linux-kernel+bounces-96491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B73C0875CEC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0971C20FC6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE6E2C699;
	Fri,  8 Mar 2024 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inHsKSkh"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A207D1E48E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869975; cv=none; b=QB2S3I46LE5MEoZMyWitKRYVr+MwtPLgGlrBu+Q3nuGGT8d6kUjqdHnqaqhJe4c/xmCpHYOKZTX1WoOZWE0XDBLWOGxkF1qJWd3RWGWykyoe6Glw92gDE3EdUH/GpfSFVBN3DV5gm3AFYBj82BldKOoopGLfva6kKJgMjGCGGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869975; c=relaxed/simple;
	bh=ItIr5AdwIHlZxXdn+Lm0x8XVegte5XC09iv8bary6uQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZUOMGwTXBx1E/cm4hzRxKQSCvBRRFH64pCuBSeyqdKIQcFkSd4k50EBSWBppQuWGviRmhHNpm9J9R6085Xna9grvPF3yd3J8HQ5JGjaJUAw0SFWh6NlTfMKrjbxTMprIZkhujk0wCQEwsTtVpUppkyAUrzoYiqXB5MQN6Wqq5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inHsKSkh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so496416566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 19:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709869972; x=1710474772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yaQRbk5QmEJP3wwqgTNAEXZGVsVjV/bZr84Z3Hdwx5g=;
        b=inHsKSkhjxeGM/dlmpzQ9zETKjfSIBADgZZ6D9315DzH/k+ODcOGx+KcuIZsBNe7JH
         IPAgzqfZCLp4/lw/XNZlFl6Wrm0g4NzhOHFimMs+tpcFjTG5ZP3ovNFTyHVL9VmIPx8y
         b9oi15aM8h5K7RqMWYBUGhwi1U2OjUknBX4LjaFRWmihasmzdic+arVh6K44wzntgAku
         mzm5cLaJ2pqXGHGvX4EGjFi3G70DJreng6Q4ZWxhw29uXZRbiFZippDYYt+YZUg3kDh1
         rfsjJo/0cUV0tT2x6h4T4SjmUdhDMjFsSPIZ2nDhWsAmXNVlY+KywkH4oylkPEFJ7QCN
         UicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709869972; x=1710474772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaQRbk5QmEJP3wwqgTNAEXZGVsVjV/bZr84Z3Hdwx5g=;
        b=N7bpRNCUVPM/gkgSeTwHO1NL5dY58G4VxdvIFh1JQqQDPT4U51Dijji8HQyr9oAQit
         ABI6GmzjXWhVw0AGAKd3lOPccwDvysH8paH4/OnCXkjxCmset/hexQFFHoFGIHstZKti
         4k0EOMrFyQA1LZhZzuGCeOjGpYpXfoSXg2ws58QrrRq6Ht0gVUvZMOrSIdBB0jWFfDkh
         b9llFKYKovIkEZfeSP1/tv4wtxvoE3MCuk7HY1QiO/9nyIQtCZy9dZyAi2ezpyeGzSbp
         OB7E5V50CvxKo/TkceDHeB5n03Z/yHcsB/1yUSBTMeATQOm8LKH73L0vNYZYVtNrmjj2
         cBOg==
X-Forwarded-Encrypted: i=1; AJvYcCUbgWIfVUc/ypw0+VexpaSJhM/hJpFDFxrrnXDNfOVeBVD1B2/csJvtx1CPxAsab+iVr7QtjMtbufGc2idShK/Mh7u4sBVy3JaHFaZc
X-Gm-Message-State: AOJu0YxAg3QwSTynqdQ11z1oEYEvCV8b4N/wN2xOcyqfLRnXbCFOGj9w
	4XJ3+dFF/O9pO/xmzeAbGa9GDN6pQba4DvB5pgCXN76+RLxp7LLtUogVDrixiVVv9t5qSfvBqBY
	pfmgIPPWvWZuuJFYWWzP1kmjw/1ywEEmE6G0=
X-Google-Smtp-Source: AGHT+IHnv0YHHWkoO2WX34G9FH8gXPrK1s2Qe2DPcmRL3JizKCox9A4TZ9lr3cjysLeq+OmUGsUxTgFtfkIqhvpziGQ=
X-Received: by 2002:a17:906:f352:b0:a45:af32:5e04 with SMTP id
 hg18-20020a170906f35200b00a45af325e04mr2841791ejb.30.1709869971794; Thu, 07
 Mar 2024 19:52:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 8 Mar 2024 13:52:40 +1000
Message-ID: <CAPM=9tzTeAgY3rUR_KC8=q5MybJ5PDAyzXJyh0RUigR6_ccyZA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.8 final
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

not sure if -final is correct but guess I'll find out if it should
have said rc8.

Regular fixes (two weeks for i915), scattered across drivers, amdgpu
and i915 being the main ones, with nouveau having a couple of fixes.
One patch got applied for udl, but reverted soon after as the
maintainer has missed some crucial prior discussion.

Seems quiet and normal enough for this stage.

Dave.

drm-fixes-2024-03-08:
drm fixes for 6.8 final

MAINTAINERS
- update email address

core:
- fix polling in certain configurations

buddy:
- fix kunit test warning

panel:
- boe-tv101wum-nl6: timing tuning fixes

i915:
- Fix to extract HDCP information from primary connector
- Check for NULL mmu_interval_notifier before removing
- Fix for #10184: Kernel crash on UHD Graphics 730 (Cc stable)
- Fix for #10284: Boot delay regresion with PSR
- Fix DP connector DSC HW state readout
- Selftest fix to convert msecs to jiffies

xe:
- error path fix

amdgpu:
- SMU14 fix
- Fix possible NULL pointer
- VRR fix
- pwm fix

nouveau:
- fix deadlock in new ioctls fail path
- fix missing locking around object rbtree

udl:
- apply and revert format change
The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72=
:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-03-08

for you to fetch changes up to b7cc4ff787a572edf2c55caeffaa88cd801eb135:

  nouveau: lock the client object tree. (2024-03-08 13:40:56 +1000)

----------------------------------------------------------------
drm fixes for 6.8 final

MAINTAINERS
- update email address

core:
- fix polling in certain configurations

buddy:
- fix kunit test warning

panel:
- boe-tv101wum-nl6: timing tuning fixes

i915:
- Fix to extract HDCP information from primary connector
- Check for NULL mmu_interval_notifier before removing
- Fix for #10184: Kernel crash on UHD Graphics 730 (Cc stable)
- Fix for #10284: Boot delay regresion with PSR
- Fix DP connector DSC HW state readout
- Selftest fix to convert msecs to jiffies

xe:
- error path fix

amdgpu:
- SMU14 fix
- Fix possible NULL pointer
- VRR fix
- pwm fix

nouveau:
- fix deadlock in new ioctls fail path
- fix missing locking around object rbtree

udl:
- apply and revert format change

----------------------------------------------------------------
Alex Deucher (1):
      drm/amd/display: handle range offsets in VRR ranges

Animesh Manna (1):
      drm/i915/panelreplay: Move out psr_init_dpcd() from init_connector()

Cong Yang (1):
      drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02 panel HFP
and HBP (again)

Daniel Vetter (1):
      Merge tag 'drm-intel-fixes-2024-03-01' of
https://anongit.freedesktop.org/git/drm/drm-intel into drm-fixes

Dave Airlie (5):
      Merge tag 'drm-intel-fixes-2024-03-07' of
https://anongit.freedesktop.org/git/drm/drm-intel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-03-07' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.8-2024-03-07' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2024-03-07' of
https://anongit.freedesktop.org/git/drm/drm-misc into drm-fixes
      nouveau: lock the client object tree.

Douglas Anderson (2):
      drm/udl: Add ARGB8888 as a format
      Revert "drm/udl: Add ARGB8888 as a format"

Imre Deak (2):
      drm: Fix output poll work for drm_kms_helper_poll=3Dn
      drm/i915/dp: Fix connector DSC HW state readout

Janusz Krzysztofik (1):
      drm/i915/selftests: Fix dependency of some timeouts on HZ

Karol Herbst (1):
      drm/nouveau: fix stale locked mutex in nouveau_gem_ioctl_pushbuf

Li Ma (1):
      drm/amd/swsmu: modify the gfx activity scaling

Ma Jun (1):
      drm/amdgpu/pm: Fix the error of pwm1_enable setting

Matthew Auld (1):
      drm/tests/buddy: fix print format

Melissa Wen (1):
      drm/amd/display: check dc_link before dereferencing

Nirmoy Das (1):
      drm/i915: Check before removing mm notifier

Rodrigo Vivi (1):
      drm/xe: Return immediately on tile_init failure

Suraj Kandpal (3):
      drm/i915/hdcp: Move to direct reads for HDCP
      drm/i915/hdcp: Remove additional timing for reading mst hdcp message
      drm/i915/hdcp: Extract hdcp structure from correct connector

Tvrtko Ursulin (1):
      MAINTAINERS: Update email address for Tvrtko Ursulin

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Don't explode when the dig port we don't have an AUX CH

 .mailmap                                           |  5 +++
 MAINTAINERS                                        |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 21 +++++++---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 | 12 +++++-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |  2 -
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |  5 ++-
 drivers/gpu/drm/drm_probe_helper.c                 |  8 ++--
 .../drm/i915/display/intel_display_power_well.c    | 17 ++++++--
 drivers/gpu/drm/i915/display/intel_display_types.h |  7 ++++
 drivers/gpu/drm/i915/display/intel_dp.c            | 16 ++++++++
 drivers/gpu/drm/i915/display/intel_dp.h            |  2 +
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c       | 47 ++++++++----------=
----
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  1 +
 drivers/gpu/drm/i915/display/intel_modeset_setup.c | 13 +++---
 drivers/gpu/drm/i915/display/intel_psr.c           |  3 --
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |  3 ++
 .../drm/i915/selftests/intel_scheduler_helpers.c   |  6 ++-
 drivers/gpu/drm/nouveau/include/nvkm/core/client.h |  1 +
 drivers/gpu/drm/nouveau/nouveau_gem.c              |  2 +-
 drivers/gpu/drm/nouveau/nvkm/core/client.c         |  1 +
 drivers/gpu/drm/nouveau/nvkm/core/object.c         | 26 +++++++++---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |  8 ++--
 drivers/gpu/drm/tests/drm_buddy_test.c             |  2 +-
 drivers/gpu/drm/xe/xe_tile.c                       |  5 ++-
 24 files changed, 141 insertions(+), 74 deletions(-)

