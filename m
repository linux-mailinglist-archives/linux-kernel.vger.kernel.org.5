Return-Path: <linux-kernel+bounces-124756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC8F891C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA391C26C39
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B2917E3C1;
	Fri, 29 Mar 2024 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn+lR7Xd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2517EB95;
	Fri, 29 Mar 2024 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716086; cv=none; b=ikSo7M+SsGU+u5p01xIFeUNilhlM7ajiP98AEuYORJKZw9r/fE9zFWkgi1FngShnzCUgR7/uaCzubP9/PEK+7yNp9r2iCzjLWwsZgYxbeQIsxhP+4WwWsjLXiH12AhV7wUUkhqESHY7PAAoYjozNjFg78ZZOb7WaB1iWuH9OlEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716086; c=relaxed/simple;
	bh=XWkniX1skEKP4mTzuIar8LWCn5vxSw8q1Y8+BUx3AOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHtwrIBwI47zo2vZFlhHH8Y6Vdr9f38cMBFHB7u8rJVlsc4B/ivW6adsJqxMJqXMt4b5BdNyKlfpVn3uVh6bLRybpTyl5rtm6aNmMHWeqeHkYhbODJ/PhMAO97wpS5as8RNIZqLfw+pXLvXdTuL0IQlXFj3Wqb8lWPQacl8auJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn+lR7Xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37733C433F1;
	Fri, 29 Mar 2024 12:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716085;
	bh=XWkniX1skEKP4mTzuIar8LWCn5vxSw8q1Y8+BUx3AOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xn+lR7XdOMIfZzF73TgsTx+TluFItbtHp5rT6A5DC7TRUCPNqz2OljcoqI3Y+QNr0
	 TuqIr2R/Hp5Bh868pJnGMB6h51YuLZt5TkA1kHgj9OgILJloeukFZr8P9GQsJr73jf
	 opzQW21Aq7iXXC2QyPpi0H/E9oiEPd4Y0KYfBNd3LQdbQ9+Et+D4GbexkI6Twz5iot
	 n1xvpWTyWDZgC/d369ayWcWoiD7z9ZyzG8gcLSkpwLfur5/cX6zxxDKQZmEYSFr4Uc
	 LB1V4heYDyfj0ZostI8SUGshV7/bKNc8O49DtLWO6FKW2durZyU6Um1aSWtqcGf1Hg
	 y2/LboB0Q64DA==
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
Subject: [PATCH AUTOSEL 6.8 47/98] x86/vdso: Fix rethunk patching for vdso-image-{32,64}.o
Date: Fri, 29 Mar 2024 08:37:18 -0400
Message-ID: <20240329123919.3087149-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
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


