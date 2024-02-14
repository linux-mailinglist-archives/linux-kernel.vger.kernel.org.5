Return-Path: <linux-kernel+bounces-65139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B64F85487E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0658F1F21D42
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332161B5B2;
	Wed, 14 Feb 2024 11:36:16 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966771B5AA;
	Wed, 14 Feb 2024 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910575; cv=none; b=Z4xw6xzdYi1TKIJtGkqW+cGLLEne7/D+OYPoIiJk9A1Rq+sIDEKqPJJHLajwCYtPJPwEyNDhpJbC6HPObwOtr40qXY85mpBOmZ1wwXLLKGJTMIDb3vrVdf4IbxaPAvLI+olwSOrIhSspZaCchTKh3vi9F5JuPy/hpUVU16J5tr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910575; c=relaxed/simple;
	bh=BhUpmPPCX9aFET6nbzIg0SSMZ201vmY12lSaJWzujcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gp9xTl8yvutEr8RaMNMsuiZqs9IIZGCEG5BAOSmcYvOUYdJQmXMHzWLRfzLPDoi9cAuGfoyQcsA0eKQYErmk0Sm0vwR22C7VdoB3grJ3HRdI3b0b4C2gk5amrE/eEFxKMq4hpC2ef+C0uUkfIeRKdArDNcCPyNmnvIlitqN3V+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TZbHz5GM5z9yLnN;
	Wed, 14 Feb 2024 19:17:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A0B5B1400DA;
	Wed, 14 Feb 2024 19:36:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAHshp7pcxlDJx9Ag--.51624S4;
	Wed, 14 Feb 2024 12:36:10 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Xin Li <xin3.li@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ze Gao <zegao2021@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <jroedel@suse.de>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH v1 2/8] sbm: x86: execute target function on sandbox mode stack
Date: Wed, 14 Feb 2024 12:35:10 +0100
Message-Id: <20240214113516.2307-3-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshp7pcxlDJx9Ag--.51624S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4rJFW3Cw18Xr1kAF48Crg_yoW7GF45pr
	9rAFn3GF40gasav3sxJr18ury5Zws2ka1fGF9rGFy5Ja4jv3yUJr1v939Fqr4rX3ykGa4r
	KF4ruF1vkw4UJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjfUn3kuUUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Allocate and map a separate stack for sandbox mode in arch_sbm_init().
Switch to this stack in arch_sbm_exec(). Store the address of the stack as
arch-specific state.

On X86_64, RSP is never used to locate thread-specific data, so it is safe
to change its value. If the sandbox is preempted by an interrupt, RSP is
saved by switch_to() and restored when the sandbox task is scheduled
again. The original kernel stack pointer is restored when the sandbox
function returns.

Since the stack switch mechanism is implemented only for 64-bit, make
CONFIG_HAVE_ARCH_SBM depend on X86_64 for now. Leave it under "config X86",
because it would be possible to implement a 32-bit variant.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 arch/x86/Kconfig              |  2 +-
 arch/x86/include/asm/sbm.h    |  2 ++
 arch/x86/kernel/sbm/Makefile  |  6 ++++++
 arch/x86/kernel/sbm/call_64.S | 40 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/sbm/core.c    | 17 ++++++++++++++-
 5 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/kernel/sbm/call_64.S

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 41fa4ab84c15..090d46c7ee7c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -188,7 +188,7 @@ config X86
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
-	select HAVE_ARCH_SBM
+	select HAVE_ARCH_SBM			if X86_64
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_STACKLEAK
diff --git a/arch/x86/include/asm/sbm.h b/arch/x86/include/asm/sbm.h
index 01c8d357550b..ed214c17af06 100644
--- a/arch/x86/include/asm/sbm.h
+++ b/arch/x86/include/asm/sbm.h
@@ -16,12 +16,14 @@
 /**
  * struct x86_sbm_state - Run-time state of the environment.
  * @pgd:         Sandbox mode page global directory.
+ * @stack:       Sandbox mode stack.
  *
  * One instance of this union is allocated for each sandbox and stored as SBM
  * instance private data.
  */
 struct x86_sbm_state {
 	pgd_t *pgd;
+	unsigned long stack;
 };
 
 #endif /* defined(CONFIG_HAVE_ARCH_SBM) && defined(CONFIG_SANDBOX_MODE) */
diff --git a/arch/x86/kernel/sbm/Makefile b/arch/x86/kernel/sbm/Makefile
index 92d368b526cd..62c3e85c14a4 100644
--- a/arch/x86/kernel/sbm/Makefile
+++ b/arch/x86/kernel/sbm/Makefile
@@ -8,3 +8,9 @@
 #
 
 obj-y := core.o
+
+###
+# 64 bit specific files
+ifeq ($(CONFIG_X86_64),y)
+	obj-y += call_64.o
+endif
diff --git a/arch/x86/kernel/sbm/call_64.S b/arch/x86/kernel/sbm/call_64.S
new file mode 100644
index 000000000000..245d0dddce73
--- /dev/null
+++ b/arch/x86/kernel/sbm/call_64.S
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Petr Tesarik <petr.tesarik1@huawei-partners.com>
+ *
+ * SandBox Mode (SBM) low-level x86_64 assembly.
+ */
+
+#include <linux/linkage.h>
+#include <asm/nospec-branch.h>
+
+.code64
+.section .entry.text, "ax"
+
+/*
+ * arguments:
+ * rdi  .. SBM state (kernel address)
+ * rsi  .. func
+ * rdx  .. args
+ * rcx  .. top of sandbox stack
+ */
+SYM_FUNC_START(x86_sbm_exec)
+	/*
+	 * Set up the sandbox stack:
+	 * 1. Store the old stack pointer at the top of the sandbox stack,
+	 *    where various unwinders can find it and link back to the
+	 *    kernel stack.
+	 */
+	sub	$8, %rcx
+	mov	%rsp, (%rcx)
+	mov	%rcx, %rsp
+
+	mov	%rdx, %rdi	/* args */
+	CALL_NOSPEC rsi
+
+	pop	%rsp
+
+	RET
+SYM_FUNC_END(x86_sbm_exec)
diff --git a/arch/x86/kernel/sbm/core.c b/arch/x86/kernel/sbm/core.c
index b775e3b387b1..de6986801148 100644
--- a/arch/x86/kernel/sbm/core.c
+++ b/arch/x86/kernel/sbm/core.c
@@ -17,6 +17,9 @@
 #define GFP_SBM_PGTABLE	(GFP_KERNEL | __GFP_ZERO)
 #define PGD_ORDER	get_order(sizeof(pgd_t) * PTRS_PER_PGD)
 
+asmlinkage int x86_sbm_exec(struct x86_sbm_state *state, sbm_func func,
+			    void *args, unsigned long sbm_tos);
+
 static inline phys_addr_t page_to_ptval(struct page *page)
 {
 	return PFN_PHYS(page_to_pfn(page)) | _PAGE_TABLE;
@@ -182,6 +185,15 @@ int arch_sbm_init(struct sbm *sbm)
 	if (err)
 		return err;
 
+	state->stack = __get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER);
+	if (!state->stack)
+		return -ENOMEM;
+
+	err = map_range(state, state->stack, state->stack + THREAD_SIZE,
+			PAGE_SHARED);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -238,11 +250,14 @@ void arch_sbm_destroy(struct sbm *sbm)
 		free_pgd(state->pgd);
 		free_pages((unsigned long)state->pgd, PGD_ORDER);
 	}
+	free_pages(state->stack, THREAD_SIZE_ORDER);
 	free_page((unsigned long)state);
 	sbm->private = NULL;
 }
 
 int arch_sbm_exec(struct sbm *sbm, sbm_func func, void *args)
 {
-	return func(args);
+	struct x86_sbm_state *state = sbm->private;
+
+	return x86_sbm_exec(state, func, args, state->stack + THREAD_SIZE);
 }
-- 
2.34.1


