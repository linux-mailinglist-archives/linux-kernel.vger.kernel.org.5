Return-Path: <linux-kernel+bounces-72370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A60485B284
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412C028385B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8708458135;
	Tue, 20 Feb 2024 05:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxiwAwk6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10857872;
	Tue, 20 Feb 2024 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708408640; cv=none; b=cWNduBsgyc7MyEdGCWcWEHLr/KGHluS8PoZhfcKjyHOtUd2OmXIbkvuX+v6v//tZv+0LpY1KqhrVKb1eokjy2SGhGTfsTO3GsexW4S3L93ZA5F/xs9951e+ozHpMFSRHmylh8NCP3xJSIbJM7JimPWZk5hviZTrhG+Q2/LkBGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708408640; c=relaxed/simple;
	bh=WvokzzLHQxAh7hjD95ixAi7uyIoGuo8fqr2T3mjV6Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4ZL8zS62G4GA0MbiCXzOujq/jwZuCwy6REjOIMItnWGpAdQfaynXPzO3ODqUnkvtj6qfAjPowrKxOdO3RkcdQmeo7aXulY4m3BDGKscz3E028j7NeKNztV8V23kZ0IdO1BeIE+ZZpXjyLdue/A0qbodvoJDpkqsRE0mJhFT0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxiwAwk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3123C433C7;
	Tue, 20 Feb 2024 05:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708408640;
	bh=WvokzzLHQxAh7hjD95ixAi7uyIoGuo8fqr2T3mjV6Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxiwAwk6veKOA6h7hDm2XNyIDzTaiwW1xAiSaTZjB4d2j4h3oKGqu4z7ajkM8Sp1z
	 Jcvl6Yr4sHE9xMi1+Qf7RwC/gORwG0seQEH0PDSMcQ7njuOMYI9KiavlK97j/go4/H
	 tNpCb5Fq9aHrcNQPkE3Nv9PYiLt5CybzlwawtwCm+kMZ7Nfxq3ehgp2oDygH6QV3Du
	 3siNAoFwPLsCoR32yG/Vgg6aq5gw0T4zQPIo5DxK9ZhjR6wVckMt+QT1bDd9f8b5h2
	 D6hs8p8gMZCJo31RI6D1iP9fqauX2zm9rqOVbO/18mc5eCkaJ2Et1p9D5ZbYmnVtSS
	 HBkjqPZjpZ9Yw==
Date: Mon, 19 Feb 2024 21:57:18 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/vdso: Fix rethunk patching for vdso-image-{32,64}.o
Message-ID: <20240220055718.turlqf2rfp36zsd5@treble>
References: <20231010171020.462211-4-david.kaplan@amd.com>
 <170774721951.398.8999401565129728535.tip-bot2@tip-bot2>
 <20240215032049.GA3944823@dev-arch.thelio-3990X>
 <20240215155349.GBZc4zjaHn8hj6xOq3@fat_crate.local>
 <20240216054235.ecpwuni2f3yphhuc@treble>
 <20240216212745.GAZc_TURO0t35GjTQM@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216212745.GAZc_TURO0t35GjTQM@fat_crate.local>

For CONFIG_RETHUNK kernels, objtool annotates all the function return
sites so they can be patched during boot.  By design, after
apply_returns() is called, all tail-calls to the compiler-generated
default return thunk (__x86_return_thunk) should be patched out and
replaced with whatever's needed for any mitigations (or lack thereof).

With the following commit

  4461438a8405 ("x86/retpoline: Ensure default return thunk isn't used at runtime")

a runtime check was added to do a WARN_ONCE() if the default return
thunk ever gets executed after alternatives have been applied.  This
warning is a sanity check to make sure objtool and apply_returns() are
doing their job.

As Nathan reported, that check found something:

  Unpatched return thunk in use. This should not happen!
  WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:2856 __warn_thunk+0x27/0x40
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-01738-g4461438a8405-dirty #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
  RIP: 0010:__warn_thunk+0x27/0x40
  Code: 90 90 90 80 3d 22 20 c3 01 00 74 05 e9 32 a5 eb 00 55 c6 05 13 20 c3 01 01 48 89 e5 90 48 c7 c7 80 80 50 89 e8 6a c4 03 00 90 <0f> 0b 90 90 5d e9 0f a5 eb 00 cc cc cc cc cc cc cc cc cc cc cc cc
  RSP: 0018:ffff8ba9c0013e10 EFLAGS: 00010286
  RAX: 0000000000000000 RBX: ffffffff89afba70 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: 0000000000000001
  RBP: ffff8ba9c0013e10 R08: 00000000ffffdfff R09: ffff8ba9c0013c88
  R10: 0000000000000001 R11: ffffffff89856ae0 R12: 0000000000000000
  R13: ffff88c101126ac0 R14: ffff8ba9c0013e78 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff88c11f000000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffff88c119601000 CR3: 0000000018e2c000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   ? show_regs+0x60/0x70
   ? __warn+0x84/0x150
   ? __warn_thunk+0x27/0x40
   ? report_bug+0x16d/0x1a0
   ? console_unlock+0x4f/0xe0
   ? handle_bug+0x43/0x80
   ? exc_invalid_op+0x18/0x70
   ? asm_exc_invalid_op+0x1b/0x20
   ? ia32_binfmt_init+0x40/0x40
   ? __warn_thunk+0x27/0x40
   warn_thunk_thunk+0x16/0x30
   do_one_initcall+0x59/0x230
   kernel_init_freeable+0x1a4/0x2e0
   ? __pfx_kernel_init+0x10/0x10
   kernel_init+0x15/0x1b0
   ret_from_fork+0x38/0x60
   ? __pfx_kernel_init+0x10/0x10
   ret_from_fork_asm+0x1b/0x30
   </TASK>

Boris debugged to find that the unpatched return site was in
init_vdso_image_64(), and its translation unit wasn't being analyzed by
objtool, so it never got annotated.  So it got ignored by
apply_returns().

This is only a minor issue, as this function is only called during boot.
Still, objtool needs full visibility to the kernel.  Fix it by enabling
objtool on vdso-image-{32,64}.o.

Note this problem can only be seen with !CONFIG_X86_KERNEL_IBT, as that
requires objtool to run individually on all translation units rather on
vmlinux.o.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Debugged-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index b1b8dd1608f7..4ee59121b905 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -34,8 +34,12 @@ obj-y					+= vma.o extable.o
 KASAN_SANITIZE_vma.o			:= y
 UBSAN_SANITIZE_vma.o			:= y
 KCSAN_SANITIZE_vma.o			:= y
-OBJECT_FILES_NON_STANDARD_vma.o		:= n
-OBJECT_FILES_NON_STANDARD_extable.o	:= n
+
+OBJECT_FILES_NON_STANDARD_extable.o		:= n
+OBJECT_FILES_NON_STANDARD_vdso-image-32.o 	:= n
+OBJECT_FILES_NON_STANDARD_vdso-image-64.o 	:= n
+OBJECT_FILES_NON_STANDARD_vdso32-setup.o	:= n
+OBJECT_FILES_NON_STANDARD_vma.o			:= n
 
 # vDSO images to build
 vdso_img-$(VDSO64-y)		+= 64
@@ -43,7 +47,6 @@ vdso_img-$(VDSOX32-y)		+= x32
 vdso_img-$(VDSO32-y)		+= 32
 
 obj-$(VDSO32-y)				 += vdso32-setup.o
-OBJECT_FILES_NON_STANDARD_vdso32-setup.o := n
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
 vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
-- 
2.43.0


