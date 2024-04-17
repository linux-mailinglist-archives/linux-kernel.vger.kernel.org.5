Return-Path: <linux-kernel+bounces-149268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6AB8A8E57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DB32845AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9A113B7AF;
	Wed, 17 Apr 2024 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGFaPXXU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B081734;
	Wed, 17 Apr 2024 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713390841; cv=none; b=CgYq2Sa5ncewmq7Kl/pJugMnn+OMFkI/nqrv3jfNCP0VmOa4hod1deIT7D8D1J/TJiv0igHWrKO0n+IS+Vlf273yiM/m12fUA15KsPU+P4+aWMUQXIItKpx8daj1lxOhAk8SJhzltDHlPykmV/qPrjHoiBOeswTTGOWcoCUVOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713390841; c=relaxed/simple;
	bh=nj6IuYV9udEmOQvECHtrngWjjKkWXQbGOmaAIgtPHYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MC1dKDBcvse8HXiBmzJOluBYDx5oGAOVwPlWQxQ+QVlv9Iwz9HJ/AdkB0SuI+0LlP51P9JNaXgLS4rkd9wY4jPCf5h3fQOFLo7gY1VW73AziNb63Lw7q/HQOCtNW5mz3wbY0DDOqiUmj7nOo3Gc26WNG81Br3QliZw47MAjMw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGFaPXXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9CBC116B1;
	Wed, 17 Apr 2024 21:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713390841;
	bh=nj6IuYV9udEmOQvECHtrngWjjKkWXQbGOmaAIgtPHYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VGFaPXXUmIkW6Tlkt3PGpz/07oiNJqYKB2SwV69x1kaVPe8kCXWsb7Q0y5QHKi785
	 RGqPZlWTx6t4BufOHgkDay91ja/+QHAJfqPkifUo/5Z38FEnOpjuEtVdTx1dhcFzTE
	 41hAAVqrmLRsI3X7kORW0toPVK93nqctb1//tfFDVaN2pfPc5LGhGCCLvYLrNuXSTS
	 NaVkpR3KJZTpQHeO4CnQd/BCFn2z7M/T0HDOElQUpLNFGc9qvzWhz07oR6W/T7oHX6
	 8Z6SF7JSF7uluepfj5JMB83mnvW7WPM/FsuRb5XH5w3mlFzhVBQuGFgiDGcUJxa8Sp
	 qF9bP9F9XojBQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 17 Apr 2024 14:53:45 -0700
Subject: [PATCH 1/2] x86/purgatory: Add a linker script
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-x86-fix-kexec-with-llvm-18-v1-1-5383121e8fb7@kernel.org>
References: <20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org>
In-Reply-To: <20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, ndesaulniers@google.com, 
 morbo@google.com, justinstitt@google.com, song@kernel.org, 
 ribalda@chromium.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, ns <0n-s@users.noreply.github.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6028; i=nathan@kernel.org;
 h=from:subject:message-id; bh=nj6IuYV9udEmOQvECHtrngWjjKkWXQbGOmaAIgtPHYA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGkKLt993T59+ZxxYueKJqnn29VYza74f3W3bJ11wU3C6
 M/RnPCqjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRWQkMv5iE1C3vNfrcs7vU
 saDgmFP56xuLzq2y/2W/k6Hd12RT81lGhlu/A2r2vzmrfv3G//Dv6z5/NOZ/ErtN0VdRYNUaPXf
 l9cwA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit 8652d44f466a ("kexec: support purgatories with .text.hot
sections") added a warning when the purgatory has more than one .text
section, which is unsupported. A couple of changes have been made to the
x86 purgatory's Makefile to prevent the compiler from splitting the
text section as a result:

  97b6b9cbba40 ("x86/purgatory: remove PGO flags")
  75b2f7e4c9e0 ("x86/purgatory: Remove LTO flags")

Unfortunately, there may be compiler optimizations that add other text
sections that cannot be disabled. For example, starting with LLVM 18,
large text is emitted in '.ltext', which happens for the purgatory due
to commit e16c2983fba0 ("x86/purgatory: Change compiler flags from
-mcmodel=kernel to -mcmodel=large to fix kexec relocation errors"), but
there are out of line assembly files that use '.text'.

  $ llvm-readelf -S arch/x86/purgatory/purgatory.ro | rg ' .[a-z]?text'
    [ 1] .text             PROGBITS        0000000000000000 000040 0000d0 00  AX  0   0 16
    [ 2] .ltext            PROGBITS        0000000000000000 000110 0015a6 00 AXl  0   0 16

To avoid the runtime warning when the purgatory has been built with LLVM
18, add a linker script that explicitly describes the sections of the
purgatory.ro and use it to merge '.ltext' and '.lrodata' back into
'.text' and '.rodata' to match the behavior of GCC and LLVM prior to the
optimization, as the distinction between small and large text is not
important in this case. This results in no warnings with
'--orphan-handling=warn' with either GNU or LLVM toolchains and the
resulting kernels can properly kexec other kernels.

This linker script is based on arch/s390/purgatory/purgatory.lds.S and
Ricardo Ribalda's prior attempt to add one for arch/x86 [1].

As a consequence of this change, the aforementioned flag changes can be
reverted because the '.text.*' sections generated by those options will
be combined properly by the linker script, which avoids the only reason
they were added in the first place. kexec continues to work with LTO
enabled.

[1]: https://lore.kernel.org/20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org/

Reported-by: ns <0n-s@users.noreply.github.com>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2016
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/purgatory/.gitignore      |  1 +
 arch/x86/purgatory/Makefile        | 19 +++---------
 arch/x86/purgatory/purgatory.lds.S | 63 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/arch/x86/purgatory/.gitignore b/arch/x86/purgatory/.gitignore
index d2be1500671d..71bd99d98906 100644
--- a/arch/x86/purgatory/.gitignore
+++ b/arch/x86/purgatory/.gitignore
@@ -1 +1,2 @@
 purgatory.chk
+purgatory.lds
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index bc31863c5ee6..dfc030a4cca9 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
 
-purgatory-y := purgatory.o stack.o setup-x86_$(BITS).o sha256.o entry64.o string.o
+purgatory-y := purgatory.o purgatory.lds stack.o setup-x86_$(BITS).o sha256.o entry64.o string.o
 
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
@@ -14,20 +14,11 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 
-# When profile-guided optimization is enabled, llvm emits two different
-# overlapping text sections, which is not supported by kexec. Remove profile
-# optimization flags.
-KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
-
-# When LTO is enabled, llvm emits many text sections, which is not supported
-# by kexec. Remove -flto=* flags.
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
-
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
-PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
-LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
-LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
+PURGATORY_LDFLAGS := -z nodefaultlib
+LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS) -T
+LDFLAGS_purgatory.chk := -e purgatory_start $(PURGATORY_LDFLAGS)
 targets += purgatory.ro purgatory.chk
 
 # Sanitizer, etc. runtimes are unavailable and cannot be linked here.
@@ -80,7 +71,7 @@ CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
 
 asflags-remove-y		+= $(foreach x, -g -gdwarf-4 -gdwarf-5, $(x) -Wa,$(x))
 
-$(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
+$(obj)/purgatory.ro: $(obj)/purgatory.lds $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
 $(obj)/purgatory.chk: $(obj)/purgatory.ro FORCE
diff --git a/arch/x86/purgatory/purgatory.lds.S b/arch/x86/purgatory/purgatory.lds.S
new file mode 100644
index 000000000000..4fb155942642
--- /dev/null
+++ b/arch/x86/purgatory/purgatory.lds.S
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <asm-generic/vmlinux.lds.h>
+#include <asm/cache.h>
+
+OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
+
+#undef i386
+
+#ifdef CONFIG_X86_64
+OUTPUT_ARCH(i386:x86-64)
+#else
+OUTPUT_ARCH(i386)
+#endif
+
+ENTRY(purgatory_start)
+
+SECTIONS
+{
+	. = 0;
+
+	.kexec-purgatory : {
+		*(.kexec-purgatory)
+	}
+
+	.text : {
+		_text = .;
+		*(.text .text.*)
+		*(.ltext .ltext.*)
+		_etext = .;
+	}
+
+	.rodata : {
+		_rodata = .;
+		*(.rodata .rodata.*)
+		*(.lrodata .lrodata.*)
+		_erodata = .;
+	}
+
+	.data : {
+		_data = .;
+		*(.data .data.*)
+		_edata = .;
+	}
+
+	. = ALIGN(L1_CACHE_BYTES);
+	.bss : {
+		_bss = .;
+		*(.bss .bss.*)
+		*(COMMON)
+		. = ALIGN(8);	/* For convenience during zeroing */
+		_ebss = .;
+	}
+	_end = .;
+
+	ELF_DETAILS
+
+	DISCARDS
+	/DISCARD/ : {
+		*(.note.GNU-stack .note.gnu.property)
+		*(.llvm_addrsig)
+	}
+}

-- 
2.44.0


