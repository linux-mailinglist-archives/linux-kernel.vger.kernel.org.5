Return-Path: <linux-kernel+bounces-57317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B1F84D6F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AF2B22354
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00B8DDBC;
	Thu,  8 Feb 2024 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyoJPxQV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF312E7C;
	Thu,  8 Feb 2024 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351306; cv=none; b=DQP7C8Xa+XQaHZRpviPKz4GC0endFUspiLs9XyrCQAGX6y8e5/C5WXaY/mQhMiHyA/oSZf0uei6gSG9ZxEAEExye5ypMJjg/AZoRR3SYkEMzJvn0tnWuRTD7AwJS9rMcxFAlah3OAXtWk0Rnsp3BnKLdlk5yt9rmRK3npuTX9b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351306; c=relaxed/simple;
	bh=4r4lVMT5XZg/PVxx8uc9r6bi2UoaXPgMwWYNnJay8/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZXgok7JPrOP9P6VMsRt62IDKl5eFTrL4NMKibXb72yo2zpdjWXcRpzZc9KpYzlnuRbZKqpmVK3bVTMzuuTXEKXj1XNXVwyUqp9Pxf17QsTcJQX0LKRZE8YSBzuS1sZ8t6U6zGr3LIAD4tbTUyBzfm/B9V9zN3xv3qpXB2FPKWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyoJPxQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAC9C433F1;
	Thu,  8 Feb 2024 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351305;
	bh=4r4lVMT5XZg/PVxx8uc9r6bi2UoaXPgMwWYNnJay8/Y=;
	h=From:Subject:Date:To:Cc:From;
	b=cyoJPxQVgZBDF4tloJ26tP+4yzsbDNNYCZPbf1clbDlVeamoJx2nxem5nxkElPVGI
	 +hVfQN93B9N+Uw/WqjhWyn/85TcjxdkJbRQZ58dUgtK/R4KBeYWC0sYqCIZamXYHiU
	 y97ach5l2wnP8l44JXHs2db4lEm4039UW7s4/d4kZp/B5kGXQ09BSFnKtmHlxcAdSM
	 X8RQP39kN7W/Zfi6sDtTzE964MzV6YPg64cj1EJZYbX8R/FGjYGSG81UCDcTUzaniq
	 Qu6g88l36pkFluPswNcfgorEOSWxRaEkdruAd+BexZgJ5E4/C+oLXaq3gEK8NFM/ms
	 uogY0Zc2ThLqA==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 00/11] s390: Support linking with ld.lld
Date: Wed, 07 Feb 2024 17:14:52 -0700
Message-Id: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPwcxGUC/x2M0QqDMAwAf0XyvEBW3Yr7leFDtckWkCopqCD9d
 4uPB3d3QmZTzvBpTjDeNOuSKjwfDUz/kH6MGiuDI9eRI4+57QnnOWJIERdbq4R7sISRRDqR98u
 PBDVfjUWPe/0dSrkAxMRk4WoAAAA=
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com, 
 ndesaulniers@google.com, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5045; i=nathan@kernel.org;
 h=from:subject:message-id; bh=4r4lVMT5XZg/PVxx8uc9r6bi2UoaXPgMwWYNnJay8/Y=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHZNkfdW+1yr2rwiPTyV6bsIbXxizsEvMOP9WyHzImE
 jmyvaodpSwMYlwMsmKKLNWPVY8bGs45y3jj1CSYOaxMIEMYuDgFYCIrHzIynD2l3q65zI3jhG1S
 0WyGZpefDpc+PQiY0Xwh7cqD88Lc+owMd+WXN27/dnrGnWc1dRwNE5rLVke3li+ay+Eucj35oLw
 HPwA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

This series allows the s390 kernel to be linked with ld.lld (support for
s390 is under review at [1]). This implicitly depends on [2], which was
created and sent before it was realized that this series was necessary.

The first chunk of this series enables support for
CONFIG_LD_ORPHAN_WARN, as it was discovered during testing that the
kernel fails to build with ld.lld due to differences in orphan section
handling, which would have been caught with the linker's orphan section
warnings ahead of the actual build error. There are no warnings when
building ARCH=s390 defconfig and allmodconfig with GCC 6 through 13 or
tip of tree Clang using ld.bfd or ld.lld

The final patch resolves a series of errors due to ld.lld having a
different default for checking for DT_TEXTREL ('-z text') vs ld.bfd,
which defaults to '-z notext' (but this is configurable at build time).

There is one outstanding issue due to something that ld.lld does not
support that the kernel relies on:

  ld.lld: error: drivers/nvme/host/fc.o:(__bug_table): writable SHF_MERGE section is not supported

This was changed in the kernel in commit e21f8baf8d9a ("s390/bug: add
entry size to the __bug_table section"). Is this change truly necessary?
I selectively applied a revert on top of current mainline and I did not
observe any issues with either Clang or GCC.

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index aebe1e22c7be..c500d45fb465 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -14,7 +14,7 @@
 		".section .rodata.str,\"aMS\",@progbits,1\n"	\
 		"1:	.asciz	\""__FILE__"\"\n"		\
 		".previous\n"					\
-		".section __bug_table,\"awM\",@progbits,%2\n"	\
+		".section __bug_table,\"aw\"\n"			\
 		"2:	.long	0b-.\n"				\
 		"	.long	1b-.\n"				\
 		"	.short	%0,%1\n"			\
@@ -30,7 +30,7 @@
 #define __EMIT_BUG(x) do {					\
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
-		".section __bug_table,\"awM\",@progbits,%1\n"	\
+		".section __bug_table,\"aw\"\n"			\
 		"1:	.long	0b-.\n"				\
 		"	.short	%0\n"				\
 		"	.org	1b+%1\n"			\

If it is necessary, is there any way to work around this error? For
testing purposes, disabling CONFIG_BUG is easy enough but that is not
usable in the real world.

To test this series with ld.lld, you'll need to build ld.lld from the
pull request, which is easy to do following LLVM's instructions [3].
Here is a TL;DR version I tested that just builds LLD with minimal noise
during the build.

$ git clone https://github.com/llvm/llvm-project
$ cd llvm-project
$ git fetch https://github.com/llvm/llvm-project pull/75643/head
$ git switch -d FETCH_HEAD
$ cmake \
    -B build \
    -G Ninja \
    -S llvm \
    --log-level=NOTICE \
    -Wno-dev \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_PROJECTS=lld \
    -DLLVM_ENABLE_WARNINGS=OFF \
    -DLLVM_TARGETS_TO_BUILD=SystemZ
$ ninja -C build lld
$ export PATH=$PWD/build/bin:$PATH

Then build the kernel with 'LD=ld.lld' in addition to whatever command
line you use (I tested both Clang and GCC). I can boot an ld.lld linked
kernel built with both compilers in QEMU with this series.

[    1.386970] Linux version 6.8.0-rc3-00043-g05761ede85d6-dirty (nathan@dev-fedora.aadp) (s390-linux-gcc (GCC) 13.2.0, ClangBuiltLinux LLD 19.0.0) #1 SMP Wed Feb  7 16:51:12 MST 2024

[    0.871923] Linux version 6.8.0-rc3-00043-g05761ede85d6-dirty (nathan@dev-fedora.aadp) (ClangBuiltLinux clang version 19.0.0git (https://github.com/llvm/llvm-project 417075e56aeba5a5b20301c7bfeba9c2a800982b), ClangBuiltLinux LLD 19.0.0) #1 SMP Wed Feb  7 17:01:22 MST 2024

[1]: https://github.com/llvm/llvm-project/pull/75643
[2]: https://lore.kernel.org/r/20240130-s390-vdso-drop-fpic-from-ldflags-v1-1-094ad104fc55@kernel.org/
[3]: https://llvm.org/docs/CMake.html

---
Nathan Chancellor (11):
      s390: boot: Add support for CONFIG_LD_ORPHAN_WARN
      s390: vmlinux.lds.S: Handle '.data.rel' sections explicitly
      s390: vmlinux.lds.S: Explicitly handle '.got' and '.plt' sections
      s390: vmlinux.lds.S: Discard unnecessary sections
      s390/boot: vmlinux.lds.S: Handle '.init.text'
      s390/boot: vmlinux.lds.S: Handle '.rela' sections
      s390/boot: vmlinux.lds.S: Handle DWARF debug sections
      s390/boot: vmlinux.lds.S: Handle ELF required sections
      s390/boot: vmlinux.lds.S: Handle commonly discarded sections
      s390: Select CONFIG_ARCH_WANT_LD_ORPHAN_WARN
      s390: Link vmlinux with '-z notext'

 arch/s390/Kconfig              |  1 +
 arch/s390/Makefile             |  2 +-
 arch/s390/boot/Makefile        |  5 +++--
 arch/s390/boot/vmlinux.lds.S   | 28 ++++++++++++++++++++++++++++
 arch/s390/kernel/vmlinux.lds.S | 28 +++++++++++++++++++++++++++-
 5 files changed, 60 insertions(+), 4 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240207-s390-lld-and-orphan-warn-d0ff4ff657b0

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


