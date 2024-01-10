Return-Path: <linux-kernel+bounces-22508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE086829ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1071C2244D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736604CDFF;
	Wed, 10 Jan 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6kbCs0M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2B4CDE6;
	Wed, 10 Jan 2024 16:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA243C433F1;
	Wed, 10 Jan 2024 16:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704905621;
	bh=fcuYgt74f2P4yBAhexY/8EHVuIglVpbVwK0yCD4Ffh4=;
	h=Date:From:To:Subject:From;
	b=a6kbCs0MT39Yx/h1cAbOOlgEUHYix4EqTTNAnUex4VCK9WM7jDvfu6HBL3psXz5Vy
	 9dM+savCYpvsrj3oOOSMNu3rgOVAIP4r3pdcpcn/nFUqtcn6iHdvT51PvjXpkrBpV3
	 UJjrBg+VZedRb2xcrpdrZHmikxx/LeCl6hiKIm1gUe0qdGuGU07PLdILJvAK1ftaSG
	 ugxNsZ6jjNJ9o4O8D1HiVR2o0I+n4RWi2cfb4htajbYWCzGEKAG9VJ3e5AMSUtzN6j
	 f47sX3RPFFbAcxKQtrTfKtDHhd5vWcsAdhLSJyPrxqgbjcDnpvNbEBhPiKpAbePgyp
	 L1zpt05j4XBJA==
Date: Wed, 10 Jan 2024 09:53:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [RFC] Bumping the minimum supported version of LLVM to 13.0.1
Message-ID: <20240110165339.GA3105@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

It has been some time since we have bumped the minimum supported version
of LLVM for building the kernel, the last time being commit df05c0e9496c
("Documentation: Raise the minimum supported version of LLVM to 11.0.0")
in November of 2021. While I think we have done a pretty good job around
supporting the current range of LLVM versions, it may be worth
considering bumping the minimum supported version to 13.0.1 for a few
reasons:

1. It would immediately resolve the massive build breakage with LLVM 11
   in -next:

   https://github.com/ClangBuiltLinux/linux/issues/1958#issuecomment-1836559075

2. It would immediately save us almost 1300 builds per week with our
   current CI matrix, as we would be able to drop mainline and -next,
   which are our most frequently built trees.

3. It allows us to drop a good number of Kconfig and source workarounds.
   I have included a sample diff below.

The downside of upgrading the minimum version is leaving distributions
that have an older clang version behind. However, based on examining
Docker images for the currently supported versions of the big
distributions, I do not believe this upgrade should impact distribution
support too much.

    archlinux:latest              clang version 16.0.6
    debian:oldoldstable-slim      clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
    debian:oldstable-slim         Debian clang version 11.0.1-2
    debian:stable-slim            Debian clang version 14.0.6
    debian:testing-slim           Debian clang version 16.0.6 (19)
    debian:unstable-slim          Debian clang version 16.0.6 (19)
    fedora:38                     clang version 16.0.6 (Fedora 16.0.6-3.fc38)
    fedora:latest                 clang version 17.0.6 (Fedora 17.0.6-1.fc39)
    fedora:rawhide                clang version 17.0.6 (Fedora 17.0.6-1.fc40)
    opensuse/leap:latest          clang version 15.0.7
    opensuse/tumbleweed:latest    clang version 17.0.6
    ubuntu:focal                  clang version 10.0.0-4ubuntu1
    ubuntu:latest                 Ubuntu clang version 14.0.0-1ubuntu1.1
    ubuntu:rolling                Ubuntu clang version 16.0.6 (15)
    ubuntu:devel                  Ubuntu clang version 17.0.6 (3)

As we can see, the only distribution in that list that would be impacted
by this change would be Debian Bullseye (oldstable), as its clang
version in the default repositories is 11.0.1. Other distributions that
have a clang older than 11.0.1 already cannot build the upstream kernel.
In Debian's case, access to newer versions of LLVM is relatively simple
because of https://apt.llvm.org. There is also the kernel.org LLVM
toolchains I publish: https://mirrors.edge.kernel.org/pub/tools/llvm/

Thoughts or concerns?

I have posted this on GitHub as well in case people want to chime in
there instead of here for some reason:

https://github.com/ClangBuiltLinux/linux/issues/1975

Cheers,
Nathan

diff --git a/Makefile b/Makefile
index f1b2fd977275..32f42f4470ec 100644
--- a/Makefile
+++ b/Makefile
@@ -948,15 +948,6 @@ CC_FLAGS_LTO	+= -fvisibility=hidden
 # Limit inlining across translation units to reduce binary size
 KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
 
-# Check for frame size exceeding threshold during prolog/epilog insertion
-# when using lld < 13.0.0.
-ifneq ($(CONFIG_FRAME_WARN),0)
-ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
-KBUILD_LDFLAGS	+= -plugin-opt=-warn-stack-size=$(CONFIG_FRAME_WARN)
-endif
-endif
-endif
-
 ifdef CONFIG_LTO
 KBUILD_CFLAGS	+= -fno-lto $(CC_FLAGS_LTO)
 KBUILD_AFLAGS	+= -fno-lto
diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
index 1e1178bf176d..5225cb1c803b 100644
--- a/arch/arm/include/asm/current.h
+++ b/arch/arm/include/asm/current.h
@@ -18,18 +18,12 @@ static __always_inline __attribute_const__ struct task_struct *get_current(void)
 {
 	struct task_struct *cur;
 
-#if __has_builtin(__builtin_thread_pointer) && \
-    defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO) && \
-    !(defined(CONFIG_THUMB2_KERNEL) && \
-      defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 130001)
+#if __has_builtin(__builtin_thread_pointer) && defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO)
 	/*
 	 * Use the __builtin helper when available - this results in better
 	 * code, especially when using GCC in combination with the per-task
 	 * stack protector, as the compiler will recognize that it needs to
 	 * load the TLS register only once in every function.
-	 *
-	 * Clang < 13.0.1 gets this wrong for Thumb2 builds:
-	 * https://github.com/ClangBuiltLinux/linux/issues/1485
 	 */
 	cur = __builtin_thread_pointer();
 #elif defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO) || defined(CONFIG_SMP)
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8f6cf1221b6a..576c203fc2b7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -382,7 +382,7 @@ config BUILTIN_RETURN_ADDRESS_STRIPS_PAC
 	bool
 	# Clang's __builtin_return_adddress() strips the PAC since 12.0.0
 	# https://reviews.llvm.org/D75044
-	default y if CC_IS_CLANG && (CLANG_VERSION >= 120000)
+	default y if CC_IS_CLANG
 	# GCC's __builtin_return_address() strips the PAC since 11.1.0,
 	# and this was backported to 10.2.0, 9.4.0, 8.5.0, but not earlier
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94891
@@ -1368,7 +1368,6 @@ choice
 
 config CPU_BIG_ENDIAN
 	bool "Build big-endian kernel"
-	depends on !LD_IS_LLD || LLD_VERSION >= 130000
 	# https://github.com/llvm/llvm-project/commit/1379b150991f70a5782e9a143c2ba5308da1161c
 	depends on AS_IS_GNU || AS_VERSION >= 150000
 	help
@@ -1999,8 +1998,6 @@ config ARM64_BTI_KERNEL
 	depends on !CC_IS_GCC || GCC_VERSION >= 100100
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106671
 	depends on !CC_IS_GCC
-	# https://github.com/llvm/llvm-project/commit/a88c722e687e6780dcd6a58718350dc76fcc4cc9
-	depends on !CC_IS_CLANG || CLANG_VERSION >= 120000
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_ARGS)
 	help
 	  Build the kernel with Branch Target Identification annotations
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 414b978b8010..58ab1e546c98 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -333,7 +333,6 @@ config PANIC_TIMEOUT
 config COMPAT
 	bool "Enable support for 32bit binaries"
 	depends on PPC64
-	depends on !CC_IS_CLANG || CLANG_VERSION >= 120000
 	default y if !CPU_LITTLE_ENDIAN
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index cd4c9a204d08..6dc601dc6f06 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -167,8 +167,6 @@ config RISCV
 
 config CLANG_SUPPORTS_DYNAMIC_FTRACE
 	def_bool CC_IS_CLANG
-	# https://github.com/llvm/llvm-project/commit/6ab8927931851bb42b2c93a00801dc499d7d9b1e
-	depends on CLANG_VERSION >= 130000
 	# https://github.com/ClangBuiltLinux/linux/issues/1817
 	depends on AS_IS_GNU || (AS_IS_LLVM && (LD_IS_LLD || LD_VERSION >= 23600))
 
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 2b2f5df7ef2c..7113b010cf1f 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -13,19 +13,9 @@
 #endif
 #define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
-/*
- * Clang prior to 13 had "mcount" instead of "_mcount":
- * https://reviews.llvm.org/D98881
- */
-#if defined(CONFIG_CC_IS_GCC) || CONFIG_CLANG_VERSION >= 130000
-#define MCOUNT_NAME _mcount
-#else
-#define MCOUNT_NAME mcount
-#endif
-
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #ifndef __ASSEMBLY__
-void MCOUNT_NAME(void);
+void _mcount(void);
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	return addr;
@@ -75,7 +65,7 @@ struct dyn_arch_ftrace {
  * both auipc and jalr at the same time.
  */
 
-#define MCOUNT_ADDR		((unsigned long)MCOUNT_NAME)
+#define MCOUNT_ADDR		((unsigned long)_mcount)
 #define JALR_SIGN_MASK		(0x00000800)
 #define JALR_OFFSET_MASK	(0x00000fff)
 #define AUIPC_OFFSET_MASK	(0xfffff000)
diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
index b4dd9ed6849e..da00fa3536c8 100644
--- a/arch/riscv/kernel/mcount.S
+++ b/arch/riscv/kernel/mcount.S
@@ -50,8 +50,8 @@
 
 SYM_TYPED_FUNC_START(ftrace_stub)
 #ifdef CONFIG_DYNAMIC_FTRACE
-       .global MCOUNT_NAME
-       .set    MCOUNT_NAME, ftrace_stub
+       .global _mcount
+       .set    _mcount, ftrace_stub
 #endif
 	ret
 SYM_FUNC_END(ftrace_stub)
@@ -80,7 +80,7 @@ SYM_FUNC_END(return_to_handler)
 #endif
 
 #ifndef CONFIG_DYNAMIC_FTRACE
-SYM_FUNC_START(MCOUNT_NAME)
+SYM_FUNC_START(_mcount)
 	la	t4, ftrace_stub
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	la	t0, ftrace_graph_return
@@ -126,6 +126,6 @@ SYM_FUNC_START(MCOUNT_NAME)
 	jalr	t5
 	RESTORE_ABI_STATE
 	ret
-SYM_FUNC_END(MCOUNT_NAME)
+SYM_FUNC_END(_mcount)
 #endif
-EXPORT_SYMBOL(MCOUNT_NAME)
+EXPORT_SYMBOL(_mcount)
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1a068de12a56..de30a8b35c41 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -217,12 +217,6 @@ endif
 
 KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
 
-ifdef CONFIG_LTO_CLANG
-ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
-KBUILD_LDFLAGS	+= -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
-endif
-endif
-
 ifdef CONFIG_X86_NEED_RELOCS
 LDFLAGS_vmlinux := --emit-relocs --discard-none
 else
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index ddab1ef22bee..e7633723dad6 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -114,11 +114,7 @@
 #define __diag_str(s)		__diag_str1(s)
 #define __diag(s)		_Pragma(__diag_str(clang diagnostic s))
 
-#if CONFIG_CLANG_VERSION >= 110000
-#define __diag_clang_11(s)	__diag(s)
-#else
-#define __diag_clang_11(s)
-#endif
+#define __diag_clang_13(s)	__diag(s)
 
 #define __diag_ignore_all(option, comment) \
-	__diag_clang(11, ignore, option)
+	__diag_clang(13, ignore, option)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 97ce28f4d154..6919f0e5fb46 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2081,7 +2081,7 @@ config KCOV
 	depends on ARCH_HAS_KCOV
 	depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
 	depends on !ARCH_WANTS_NO_INSTR || HAVE_NOINSTR_HACK || \
-		   GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
+		   GCC_VERSION >= 120000 || CC_IS_CLANG
 	select DEBUG_FS
 	select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
 	select OBJTOOL if HAVE_NOINSTR_HACK
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index fd5ffdb81bab..d48bd9c87c7b 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -27,7 +27,7 @@ llvm)
 	if [ "$SRCARCH" = s390 ]; then
 		echo 15.0.0
 	else
-		echo 11.0.0
+		echo 13.0.1
 	fi
 	;;
 rustc)
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 6a4645a57976..5794b3a43137 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -359,7 +359,7 @@ if ($arch eq "x86_64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
 } elsif ($arch eq "riscv") {
     $function_regex = "^([0-9a-fA-F]+)\\s+<([^.0-9][0-9a-zA-Z_\\.]+)>:";
-    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\sR_RISCV_CALL(_PLT)?\\s_?mcount\$";
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\sR_RISCV_CALL(_PLT)?\\s_mcount\$";
     $type = ".quad";
     $alignment = 2;
 } elsif ($arch eq "csky") {
diff --git a/security/Kconfig b/security/Kconfig
index 52c9af08ad35..412e76f1575d 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -142,8 +142,6 @@ config HARDENED_USERCOPY
 config FORTIFY_SOURCE
 	bool "Harden common str/mem functions against buffer overflows"
 	depends on ARCH_HAS_FORTIFY_SOURCE
-	# https://bugs.llvm.org/show_bug.cgi?id=41459
-	depends on !CC_IS_CLANG || CLANG_VERSION >= 120001
 	# https://github.com/llvm/llvm-project/issues/53645
 	depends on !CC_IS_CLANG || !X86_32
 	help

