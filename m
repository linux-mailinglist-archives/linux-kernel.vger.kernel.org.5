Return-Path: <linux-kernel+bounces-119480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4951488C981
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E093058A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAB41AAD3;
	Tue, 26 Mar 2024 16:36:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D0C1C6A4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471006; cv=none; b=SLQQ/oy1rRY+1EC2+O+RhVLVxBPP/p722eiJkNHvw3RmjL0QD55rknboweceJfggYPg+UiauKKqn+07JcMlwsbuLNdPbKsrpaZHwRUMzTzyASPj+t3CQ9mqEop7O6z7Eo2XUPPFZfRb+oZ6AHANIi0VQda05aWdcZ9fevlyQoas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471006; c=relaxed/simple;
	bh=HH/aXw3LEQSC154zqpN8pKWClFysixAgniHkJVxue28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PN+iXvmhs7EeyWSrH00+Bd/BgMllSrCS519sRQef0IEvh1PbgCszzMW2DJ8LxB6eOlku8wQ5Sk/OR3ZXYhF/D2BMLr1d7sdAcCeF9ruTrD34t/aWi28Z9CCbsYHypmU+2WKPq8HM+ooiw9yTikHvqeC0frpIZ027WLqLfPtdx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45EB51474;
	Tue, 26 Mar 2024 09:37:17 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0448E3F694;
	Tue, 26 Mar 2024 09:36:40 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: agordeev@linux.ibm.com,
	anil.s.keshavamurthy@intel.com,
	aou@eecs.berkeley.edu,
	bp@alien8.de,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	jarkko@kernel.org,
	jcalvinowens@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	tglx@linutronix.de,
	will@kernel.org
Subject: [PATCH 3/4] kprobes/treewide: Explicitly override alloc/free functions
Date: Tue, 26 Mar 2024 16:36:23 +0000
Message-Id: <20240326163624.3253157-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240326163624.3253157-1-mark.rutland@arm.com>
References: <20240326163624.3253157-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently architectures can override kprobes_alloc_insn_page(), but
kprobes_free_insn_page() is always implemented using module_memfree(),
which might not be what an architecture needs, especially as we'd like
to make it possible to use kprobes without requiring MODULES.

It would be nicer if architectures either:

(a) Used only the generic kprobes_alloc_insn_page() and
    kprobes_free_insn_page(), implicitly depending on MODULES.

(b) Provided their own implementation of both kprobes_alloc_insn_page()
    and kprobes_free_insn_page(), handling the relevant dependencies
    themselves.

This patch applies that split treewide:

(a) Architectures using the generic kprobes_free_insn_page() and
    kprobes_free_insn_page() are left as-is. The __weak annotation is
    removed from the generic implementations so that accidental
    overrides/misuse can be detected easily.

(b) Architectures which provide their own kprobes_free_insn_page() are
    given a matching implementation of kprobes_free_insn_page(), and
    select HAVE_KPROBES_ALLOC.

    This new Kconfig symbol will allow subsequent patches to relax the
    dependency on MODULES to (MODULES || HAVE_KPROBES_ALLOC) once other
    module dependencies in the core kprobes code are cleaned up.

    Architectures which use module_alloc() are given an implementation
    using module_memfree() along with an explicit dependency on MODULES.

    Architectures using __vmalloc_node_range() are given an
    implementation using vfree(). This loses the warning for
    in_interrupt(), but vfree() can handle this via vfree_atomic(), so
    the warning isn't necessary.

    On riscv, the allocator depends on !XIP_KERNEL, which is already a
    dependency for HAVE_KPROBES in arch/riscv/Kconfig.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
---
 arch/Kconfig                       | 3 +++
 arch/arm64/Kconfig                 | 1 +
 arch/arm64/kernel/probes/kprobes.c | 5 +++++
 arch/powerpc/Kconfig               | 3 ++-
 arch/powerpc/kernel/kprobes.c      | 5 +++++
 arch/riscv/Kconfig                 | 1 +
 arch/riscv/kernel/probes/kprobes.c | 5 +++++
 arch/s390/Kconfig                  | 3 ++-
 arch/s390/kernel/kprobes.c         | 5 +++++
 arch/x86/Kconfig                   | 3 ++-
 arch/x86/kernel/kprobes/core.c     | 5 +++++
 include/linux/kprobes.h            | 1 +
 kernel/kprobes.c                   | 6 ++++--
 13 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9f066785bb71d..85bb59f7b8c07 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -206,6 +206,9 @@ config HAVE_IOREMAP_PROT
 config HAVE_KPROBES
 	bool
 
+config HAVE_KPROBES_ALLOC
+	bool
+
 config HAVE_KRETPROBES
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84b..bda7913d6c9b8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -233,6 +233,7 @@ config ARM64
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
+	select HAVE_KPROBES_ALLOC
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 4b6ab7b1fa211..69d19a390cd48 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -136,6 +136,11 @@ void *kprobes_alloc_insn_page(void)
 			NUMA_NO_NODE, __builtin_return_address(0));
 }
 
+void kprobes_free_insn_page(void *page)
+{
+	vfree(page);
+}
+
 /* arm kprobe: install breakpoint in text */
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1c4be33736860..13e0fc51dcdcf 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -254,7 +254,8 @@ config PPC
 	select HAVE_KERNEL_LZMA			if DEFAULT_UIMAGE
 	select HAVE_KERNEL_LZO			if DEFAULT_UIMAGE
 	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x
-	select HAVE_KPROBES
+	select HAVE_KPROBES			if MODULES
+	select HAVE_KPROBES_ALLOC
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if HAVE_OBJTOOL_MCOUNT && (!ARCH_USING_PATCHABLE_FUNCTION_ENTRY || (!CC_IS_GCC || GCC_VERSION >= 110100))
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 0b297718d5de6..d0332aaebab09 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -146,6 +146,11 @@ void *kprobes_alloc_insn_page(void)
 	return NULL;
 }
 
+void kprobes_free_insn_page(void *page)
+{
+	module_memfree(page);
+}
+
 int arch_prepare_kprobe(struct kprobe *p)
 {
 	int ret = 0;
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56b..4e22549a522a5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -139,6 +139,7 @@ config RISCV
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES if !XIP_KERNEL
+	select HAVE_KPROBES_ALLOC
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
 	# https://github.com/ClangBuiltLinux/linux/issues/1881
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 75201ce721057..37fdfa952d999 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -112,6 +112,11 @@ void *kprobes_alloc_insn_page(void)
 				     VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
 				     __builtin_return_address(0));
 }
+
+void kprobes_free_insn_page(void *page)
+{
+	vfree(page);
+}
 #endif
 
 /* install breakpoint in text */
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8f01ada6845e3..635eddc3fce80 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -193,7 +193,8 @@ config S390
 	select HAVE_KERNEL_UNCOMPRESSED
 	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_ZSTD
-	select HAVE_KPROBES
+	select HAVE_KPROBES		if MODULES
+	select HAVE_KPROBES_ALLOC
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
 	select HAVE_LIVEPATCH
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 91ca4d501d4ef..a5b142b8eb0f7 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -45,6 +45,11 @@ void *kprobes_alloc_insn_page(void)
 	return page;
 }
 
+void kprobes_free_insn_page(void *page)
+{
+	module_memfree(page);
+}
+
 static void *alloc_s390_insn_page(void)
 {
 	if (xchg(&insn_page_in_use, 1) == 1)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39886bab943a8..bdd327b0124e2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -240,7 +240,8 @@ config X86
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_ZSTD
-	select HAVE_KPROBES
+	select HAVE_KPROBES			if MODULES
+	select HAVE_KPROBES_ALLOC
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_KRETPROBES
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 7f01bbbfa9e2a..5f093b94d9b40 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -508,6 +508,11 @@ void *kprobes_alloc_insn_page(void)
 	return page;
 }
 
+void kprobes_free_insn_page(void *page)
+{
+	module_memfree(page);
+}
+
 /* Kprobe x86 instruction emulation - only regs->ip or IF flag modifiers */
 
 static void kprobe_emulate_ifmodifiers(struct kprobe *p, struct pt_regs *regs)
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index ad4b561100f9e..651c807727bea 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -431,6 +431,7 @@ int enable_kprobe(struct kprobe *kp);
 void dump_kprobe(struct kprobe *kp);
 
 void *kprobes_alloc_insn_page(void);
+void kprobes_free_insn_page(void *page);
 
 void *kprobes_alloc_optinsn_page(void);
 void kprobes_free_optinsn_page(void *page);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 35adf56430c9b..fa2ee4e59eca2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -110,7 +110,8 @@ enum kprobe_slot_state {
 	SLOT_USED = 2,
 };
 
-void __weak *kprobes_alloc_insn_page(void)
+#ifndef CONFIG_HAVE_KPROBES_ALLOC
+void *kprobes_alloc_insn_page(void)
 {
 	/*
 	 * Use module_alloc() so this page is within +/- 2GB of where the
@@ -121,10 +122,11 @@ void __weak *kprobes_alloc_insn_page(void)
 	return module_alloc(PAGE_SIZE);
 }
 
-static void kprobes_free_insn_page(void *page)
+void kprobes_free_insn_page(void *page)
 {
 	module_memfree(page);
 }
+#endif
 
 struct kprobe_insn_cache kprobe_insn_slots = {
 	.mutex = __MUTEX_INITIALIZER(kprobe_insn_slots.mutex),
-- 
2.30.2


