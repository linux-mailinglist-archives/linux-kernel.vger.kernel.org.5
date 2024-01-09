Return-Path: <linux-kernel+bounces-20393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A04B827E1C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DDE1C235D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6C76132;
	Tue,  9 Jan 2024 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lu49z6Oe"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459D185D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 05:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28bf1410e37so2274368a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 21:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704777027; x=1705381827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wlf90X0P+vhU5VZcrW3yZ6fVUCCORon75ZKxjDtkw8Q=;
        b=Lu49z6OeN3jBfHdMxZJ4P/LnBNSDl+iPqlVeXQSZBWd1+HqQ5AqVECrACVG8SEiTxB
         shA/N87rv7UlIlep18kBJekX+9YvuYHx/nTzc/lxTlBt3Os3hI7cDE3xV0clwDiKEMC8
         9hcG3Rq5gMCqk4YqkpRM2LBxTI1U004s+hwyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704777027; x=1705381827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlf90X0P+vhU5VZcrW3yZ6fVUCCORon75ZKxjDtkw8Q=;
        b=JYHt8KBVxxXhXpakd6ebmgJJG+21OMT8T2N5Eo61HayEn8ZXOmXzdo8KseCMhHIDX2
         BQ2iqRDs2lV0oQ5fokdRSqvwa4gHFuTJYokVHLu8DQ3Ob6eekaLDfMgpQhoJGgnqctMC
         VV5L5kliiuvG5PP8X4D3dmLuXocJmM3eCeZsQEKbD9ZoFrTo3ZXRSr2U6D8ZXNpSXPfS
         sM+4QoVb7tT8HDZrTeFfs3I/zUzZGIr/NoMwZIo0gxsx3FhS89uo9mX4P8TEY4zWEoXh
         PUw6SmXLWxMyNjApW5Ro4vw30pB+Lmt3ugpU+cxi0I47Kg4xTIy8G87NlRwS4Hv3R8FZ
         iajA==
X-Gm-Message-State: AOJu0YwriLHs+Twz27yFDPzhPoaJgrl/QHUKoB9kwULxRqGc8ERAOd8d
	MJck6Zkfa4SNmUgVUZv04kU+putT4aJ41doRFkaZE0aALa2tc4rzJk4QzTbeJ6nnS/q7spYclfI
	0U4RePflGwU5b3zLIcvY8G7TyslruQiPA/LFAnTs1GQCWh4sNH5GEYUFZg53J+Bsje0SqAYoXmJ
	6hMtDCaVKZ4R0nTuh1MRPs1zI=
X-Google-Smtp-Source: AGHT+IGUxIhi/Ohyh8UO7pb7HZLar6dLBl7zwZDR2s74XJO53hdYfENhj0xjsjxfEi8PSyjsYe/GXQ==
X-Received: by 2002:a17:90b:1e03:b0:28d:1365:baff with SMTP id pg3-20020a17090b1e0300b0028d1365baffmr2647537pjb.32.1704777027291;
        Mon, 08 Jan 2024 21:10:27 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090ac88c00b0028aecd6b29fsm7344115pjt.3.2024.01.08.21.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 21:10:27 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
X-Google-Original-From: Alexey Makhalov <amakhalov@vmware.com>
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
	namit@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	jsipek@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: [PATCH v5 0/7] VMware hypercalls enhancements
Date: Mon,  8 Jan 2024 21:10:10 -0800
Message-Id: <20240109051017.58167-1-amakhalov@vmware.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 arch/x86/include/asm/vmware.h             | 364 ++++++++++++++++++++--
 arch/x86/kernel/cpu/vmware.c              | 117 +++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 ++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 197 ++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 -----------
 drivers/input/mouse/vmmouse.c             |  76 ++---
 drivers/ptp/ptp_vmw.c                     |  12 +-
 7 files changed, 599 insertions(+), 525 deletions(-)

-- 
2.39.0


