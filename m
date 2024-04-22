Return-Path: <linux-kernel+bounces-154162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6968AD875
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909451C21217
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DE944C7E;
	Mon, 22 Apr 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dIaTffOg"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6A446D9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826630; cv=none; b=lrna77g1cU7YLlLTR5b8SUSVicg2R5KX7MbCDUN95izaZmcwui2+E7AijLKH4NMmj+cRAFjiYaVLPNNhZexLiPvPh6+nzWCKa02/dWkqVSsDcGRYjQcCyjHZIBsRHtzZxk+sobtmt3Ojc6DCOdl80f7lyY9SU65SJIwgDJM45Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826630; c=relaxed/simple;
	bh=RrrYRTkkswf/gjOqFjZlaogI7ruiGe39kkmwqnMOSP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dx0ZXBbMFM4CP6c1BuKce6207NoJfxh97sT2A4CJGr3ZfabnOVAijwUjXwa8iLYK0Ba3YE4tvtzDy9T8Sz3BKjRbobUy199+fd13SvVz3JUOqTek2/555C8JRlsFDbJ4sqiNkVTpeMvrnjmXSMSPlF2oKeMSpkwkcNJgKd0oytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dIaTffOg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ff57410ebbso1314395a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713826628; x=1714431428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQbI2isQrIeFdi3NSj8YhWPg4Ob4QiVW/wigPh5fM2E=;
        b=dIaTffOgc0Jx0GWZIBsoqb4F30ntqNwycbgfzn6EA/Pwpw8qwi6pJMY6KL8bakzxgp
         sITyDJlOMpe8yDUgy3OLbU8347YEgmqxTc1Y/93ep5zS5TGAqq9HRZIsZrQBqklQGcQJ
         EpFof2O0qxEPr5N3oYu+J2P1qXIjXKQepCjTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826628; x=1714431428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQbI2isQrIeFdi3NSj8YhWPg4Ob4QiVW/wigPh5fM2E=;
        b=dgJLymRu8XU0KGlX/cf5zaAVxXyEOArCe2b7sNW8cYpd2vsX588Bb5kVZaReP2dLzz
         bqw39p8J0LUG3swljGxQ421YXpo7y9znSU7/+yndMWXR30aomEivYNJWnJtHIZyv5ubD
         FQuBuYJBBmohkuGTN/bD621Vhxh5wD3vFpawBHTSShduzSa8blXiM1cWlJRNbIM618K1
         FPy9QPy5VU4VQabsaoO8wq0+myC9Gua7VNzzoWw8+TWOMQ5O4BNp5/jl3V3JrsjWZOMW
         2bcFRizRfFx5f47mFOV5hdZo8fkHf6TnaIEVHUU3YF+Nfh8+SVtz4TW2u7j/SoIOgrtA
         gaYg==
X-Gm-Message-State: AOJu0YyFxjmlrtRyRlTAlPv8230QA35OkXxVRQNASOBlZr/A4xah9QZk
	pPDdJAONmLfdNLr7lfeHphYlrmXh7lrYiB8g7BTKLRUNQw0zurwEg05iq960a/r54AuhasWzT5f
	39mnBoapu8SHvbOiKEXocZtSFV/d/iWbDvOj9mcGgZiLhjnyIV5WYakKlBRtLn6iA3fSy/SlM+K
	gh2LaaK1ZhDnWm6S47oNMd8rIN+TnWFsV4gWH3E4poYFSrAdBixrUuyNY=
X-Google-Smtp-Source: AGHT+IHoQIjxOX9Ar02IvVZtYDFrS78a9YsPclc2gjJ3AAG9FEHisboEyDHDvj6Ddco66aGsKCkrLg==
X-Received: by 2002:a05:6300:8081:b0:1a9:5a2a:7e51 with SMTP id ap1-20020a056300808100b001a95a2a7e51mr10402501pzc.24.1713826627745;
        Mon, 22 Apr 2024 15:57:07 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id e131-20020a636989000000b005e43cce33f8sm8093597pgc.88.2024.04.22.15.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:57:07 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v8 0/7] VMware hypercalls enhancements
Date: Mon, 22 Apr 2024 15:56:49 -0700
Message-Id: <20240422225656.10309-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes from version 7. Peter please consider reviewing
patch 7 where we addressed your comments from version 6. Thanks!

VMware hypercalls invocations were all spread out across the kernel
implementing same ABI as in-place asm-inline. With encrypted memory
and confidential computing it became harder to maintain every changes
in these hypercall implementations.

Intention of this patchset is to introduce arch independent VMware
hypercall API layer other subsystems such as device drivers can call
to, while hiding architecture specific implementation behind.

Second patch introduces the vmware_hypercall low and high bandwidth
families of functions, with little enhancements there.
Sixth patch adds tdx hypercall support

arm64 implementation of vmware_hypercalls is in drivers/gpu/drm/
vmwgfx/vmwgfx_msg_arm64.h and going to be moved to arch/arm64 with
a separate patchset with the introduction of VMware Linux guest
support for arm64.

No functional changes in drivers/input/mouse/vmmouse.c and
drivers/ptp/ptp_vmw.c

v7->v8 no functional changes. Updated authors and reviewers emails to
@broadcom.com

v6->v7 changes (only in patch 7):
- Addressed comments from H. Peter Anvin:
  1. Removed vmware_tdx_hypercall_args(), moved args handling inside
     vmware_tdx_hypercall().
  2. Added pr_warn_once() for !hypervisor_is_type(X86_HYPER_VMWARE) case.
- Added ack by Dave Hansen.

v5->v6 change:
- Added ack by Kirill A. Shutemov in patch 7. 

v4->v5 changes:
  [patch 2]:
- Fixed the problem reported by Simon Horman where build fails after
  patch 2 application. Do not undefine VMWARE_HYPERCALL for now, and
  update vmwgfx, vmmouse and ptp_vmw code for new VMWARE_HYPERCALL macro.
- Introduce new patch 6 to undefine VMWARE_HYPERCALL, which is safe to do
  after patches 3 to 5.
- [patch 7 (former patch 6)]: Add missing r15 (CPL) initialization.

v3->v4 changes: (no functional changes in patches 1-5)
  [patch 2]:
- Added the comment with VMware hypercall ABI description.
  [patch 6]:
- vmware_tdx_hypercall_args remove in6/out6 arguments as excessive.
- vmware_tdx_hypercall return ULONG_MAX on error to mimic bad hypercall
  command error from the hypervisor.
- Replaced pr_warn by pr_warn_once as pointed by Kirill Shutemov.
- Fixed the warning reported by Intel's kernel test robot.
- Added the comment describing VMware TDX hypercall ABI.

v2->v3 changes: (no functional changes in patches 1-5)
- Improved commit message in patches 1, 2 and 5 as was suggested by
  Borislav Petkov.
- To address Dave Hansen's concern, patch 6 was reorganized to avoid
  exporting bare __tdx_hypercall and to make exported vmware_tdx_hypercall
  VMWare guest specific.

v1->v2 changes (no functional changes):
- Improved commit message in patches 2 and 5.
- Added Reviewed-by for all patches.
- Added Ack from Dmitry Torokhov in patch 4. No fixes regarding reported
  by Simon Horman gcc error in this patch.


Alexey Makhalov (7):
  x86/vmware: Move common macros to vmware.h
  x86/vmware: Introduce VMware hypercall API
  ptp/vmware: Use VMware hypercall API
  input/vmmouse: Use VMware hypercall API
  drm/vmwgfx: Use VMware hypercall API
  x86/vmware: Undefine VMWARE_HYPERCALL
  x86/vmware: Add TDX hypercall support

 arch/x86/include/asm/vmware.h             | 331 +++++++++++++++++++---
 arch/x86/kernel/cpu/vmware.c              | 144 +++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 ++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 197 +++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 ------------
 drivers/input/mouse/vmmouse.c             |  76 ++---
 drivers/ptp/ptp_vmw.c                     |  12 +-
 7 files changed, 593 insertions(+), 525 deletions(-)

-- 
2.39.0


