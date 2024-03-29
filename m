Return-Path: <linux-kernel+bounces-124476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301AE8918A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42281F24A23
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1848792;
	Fri, 29 Mar 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHkRKH2P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B986AF88;
	Fri, 29 Mar 2024 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715155; cv=none; b=t1hW/XADKElMvmnRHQ1RbxNomAUREh7EGb9HZsOjPB46eY5A5wJU6hRumgI2Rd5abrOIKYO2craex0cOPniFG2pD2QoV9RGISyq79aSC74nR2RReG8iTE6VRyrNBlWDpsdt3r6ccTKpMtlRaMSlIqAKrl+Pvy2Zx06Aem6X0XgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715155; c=relaxed/simple;
	bh=XWkniX1skEKP4mTzuIar8LWCn5vxSw8q1Y8+BUx3AOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfRbomVEJHbxPEoHvDoYLObFh1wusiLM0o5DuTQye/vNyuUzaXcS1qeOI29fofc5kTQqelkim1U4cW2DR2/ScYPAserCI9Elb52TNrjhbdONC/pkdoI/VZy353A1KsZarYOWkE5RP7I5bzMTXZ9pP7qFlxTuB5st/AwB6NNlEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHkRKH2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A156CC433C7;
	Fri, 29 Mar 2024 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715154;
	bh=XWkniX1skEKP4mTzuIar8LWCn5vxSw8q1Y8+BUx3AOw=;
	h=From:To:Cc:Subject:Date:From;
	b=dHkRKH2PzDTecZvBIcA2hzUR+7/cass3uUOTo9sSIwScxZFYYkELUWS4ABZWD8dxs
	 f4f/Mj8mt4YEjQdSszfWH5mPyKLJUQzQx3D0YqIYre5nZv3/6TNn4WC5KcQYdBIJHD
	 b772UyLxAA9xdt9wz16YH0Y6u8lrs47GrD4yRUxHyxpizYkJqJorw0Tp6qLtDL0mj/
	 lrKzYomrAZmPn+ryWwXUQvTlUf8ZUdDo2ZPxXCh1Nglp3MHUykDu8dKEph7rP67gu6
	 gxlksFRTcYJ4jlmehLVvjZmQq1vBfLkfoXCGGUgN2FNBBuNY4yPL0nQednkk0eyYvC
	 4vDKZjyM9aJQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.8] x86/vdso: Fix rethunk patching for vdso-image-{32,64}.o
Date: Fri, 29 Mar 2024 08:25:53 -0400
Message-ID: <20240329122553.3082213-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit b388e57d4628eb22782bdad4cd5b83ca87a1b7c9 ]

For CONFIG_RETHUNK kernels, objtool annotates all the function return
sites so they can be patched during boot.  By design, after
apply_returns() is called, all tail-calls to the compiler-generated
default return thunk (__x86_return_thunk) should be patched out and
replaced with whatever's needed for any mitigations (or lack thereof).

The commit

  4461438a8405 ("x86/retpoline: Ensure default return thunk isn't used at runtime")

adds a runtime check and a WARN_ONCE() if the default return thunk ever
gets executed after alternatives have been applied.  This warning is
a sanity check to make sure objtool and apply_returns() are doing their
job.

As Nathan reported, that check found something:

  Unpatched return thunk in use. This should not happen!
  WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:2856 __warn_thunk+0x27/0x40
  RIP: 0010:__warn_thunk+0x27/0x40
  Call Trace:
   <TASK>
   ? show_regs
   ? __warn
   ? __warn_thunk
   ? report_bug
   ? console_unlock
   ? handle_bug
   ? exc_invalid_op
   ? asm_exc_invalid_op
   ? ia32_binfmt_init
   ? __warn_thunk
   warn_thunk_thunk
   do_one_initcall
   kernel_init_freeable
   ? __pfx_kernel_init
   kernel_init
   ret_from_fork
   ? __pfx_kernel_init
   ret_from_fork_asm
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

  [ bp: Massage commit message. ]

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240215032049.GA3944823@dev-arch.thelio-3990X
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index b1b8dd1608f7e..4ee59121b9053 100644
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


