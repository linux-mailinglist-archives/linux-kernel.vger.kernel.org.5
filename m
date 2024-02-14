Return-Path: <linux-kernel+bounces-65141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BF3854884
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220E21F21FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAAF1B801;
	Wed, 14 Feb 2024 11:36:55 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34D51B5AA;
	Wed, 14 Feb 2024 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910614; cv=none; b=pWNf9XAyfPYrXv5H9tPtDOHROvAHmNgncvjmDSyy0sKoRO9Xl8mrds0GzHtY5nisZu4fUYxs0Pw6K8JkfsRDRymdmm2FMwvPQZ04KMYVdpSa0q6uZQ0vAqf5tlXU7o2AqOUWrTx0ZMjxnbZwLQrHZJOFZVYBjUVtm8pbbCqI3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910614; c=relaxed/simple;
	bh=mFrRekuBTReiOEFHzPYdRM8Hp3OlzszAWd9vJqfTtwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ICJ8vlGkCPKGpQVdUi0eM9/ajAQ1P7bKszSvYh1R2wP21ezJCOT7myfZphdf1DnS1d743K9drOOiMw4Sty5kOxmFs6CjMmlLCSfvtL7JzIuDDpEd9u4SGXx7SpHos0srh9iLlC7hu81kiO11kuS80gLocHMvg3moxxo2ipxg+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TZbPC5Fjhz9yMLZ;
	Wed, 14 Feb 2024 19:21:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id C3545140661;
	Wed, 14 Feb 2024 19:36:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAHshp7pcxlDJx9Ag--.51624S6;
	Wed, 14 Feb 2024 12:36:40 +0100 (CET)
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
Subject: [PATCH v1 4/8] sbm: x86: allocate and map an exception stack
Date: Wed, 14 Feb 2024 12:35:12 +0100
Message-Id: <20240214113516.2307-5-petrtesarik@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHshp7pcxlDJx9Ag--.51624S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw48Gw47KFW8KFWxCF45Jrb_yoW7uw4rpF
	WDA3WkKF4Y9as3Zr9rJr4vvr9xZr4v9r43GF9rK345ZF1Utw15Xrn7KF9Fqr45ZrZ8Ga1Y
	qFWFqr4DCan8JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUml14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_
	Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
	JbIYCTnIWIevJa73UjIFyTuYvjfUnzVbDUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Sandbox mode should run with CPL 3. It is treated as user mode by the CPU,
so non-IST interrupts will load RSP from TSS. This is the trampoline stack
and that one is fine. However, the interrupt entry code then moves to the
thread stack, assuming that it cannot be currently in use, since the task
was executing in user mode. This assumption is not valid for sandbox mode,
because the code was originally called from kernel mode, and the thread
stack contains precious data of the sandbox mode callers.

Allocate a separate exception stack for sandbox and use it instead of the
thread stack in interrupt handlers while sandbox mode is active. To find
the sandbox exception stack from interrupt entry, store a pointer to the
state page in struct thread_info. This pointer is non-NULL if the current
task is running in sandbox mode. It is also non-NULL during the transition
from/to sandbox mode. The sandbox exception stack is valid in either case.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 arch/x86/include/asm/sbm.h         | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/thread_info.h |  3 +++
 arch/x86/kernel/sbm/call_64.S      |  1 +
 arch/x86/kernel/sbm/core.c         | 21 ++++++++++++++++++++-
 arch/x86/kernel/traps.c            |  3 ++-
 5 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sbm.h b/arch/x86/include/asm/sbm.h
index ed214c17af06..ca4741b449e8 100644
--- a/arch/x86/include/asm/sbm.h
+++ b/arch/x86/include/asm/sbm.h
@@ -9,6 +9,8 @@
 #ifndef __ASM_SBM_H
 #define __ASM_SBM_H
 
+#include <asm/processor.h>
+
 #if defined(CONFIG_HAVE_ARCH_SBM) && defined(CONFIG_SANDBOX_MODE)
 
 #include <asm/pgtable_types.h>
@@ -17,6 +19,7 @@
  * struct x86_sbm_state - Run-time state of the environment.
  * @pgd:         Sandbox mode page global directory.
  * @stack:       Sandbox mode stack.
+ * @exc_stack:   Exception and IRQ stack.
  *
  * One instance of this union is allocated for each sandbox and stored as SBM
  * instance private data.
@@ -24,8 +27,29 @@
 struct x86_sbm_state {
 	pgd_t *pgd;
 	unsigned long stack;
+	unsigned long exc_stack;
 };
 
+/**
+ * top_of_intr_stack() - Get address interrupt stack.
+ *
+ */
+static inline unsigned long top_of_intr_stack(void)
+{
+	struct x86_sbm_state *sbm = current_thread_info()->sbm_state;
+
+	if (sbm)
+		return sbm->exc_stack + EXCEPTION_STKSZ;
+	return current_top_of_stack();
+}
+
+#else /* defined(CONFIG_HAVE_ARCH_SBM) && defined(CONFIG_SANDBOX_MODE) */
+
+static inline unsigned long top_of_intr_stack(void)
+{
+	return current_top_of_stack();
+}
+
 #endif /* defined(CONFIG_HAVE_ARCH_SBM) && defined(CONFIG_SANDBOX_MODE) */
 
 #endif /* __ASM_SBM_H */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d63b02940747..95b1acffb78a 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -60,6 +60,9 @@ struct thread_info {
 #ifdef CONFIG_SMP
 	u32			cpu;		/* current CPU */
 #endif
+#ifdef CONFIG_SANDBOX_MODE
+	struct x86_sbm_state	*sbm_state;	/* SandBox mode state page */
+#endif
 };
 
 #define INIT_THREAD_INFO(tsk)			\
diff --git a/arch/x86/kernel/sbm/call_64.S b/arch/x86/kernel/sbm/call_64.S
index 245d0dddce73..1b232c8d15b7 100644
--- a/arch/x86/kernel/sbm/call_64.S
+++ b/arch/x86/kernel/sbm/call_64.S
@@ -9,6 +9,7 @@
 
 #include <linux/linkage.h>
 #include <asm/nospec-branch.h>
+#include <asm/percpu.h>
 
 .code64
 .section .entry.text, "ax"
diff --git a/arch/x86/kernel/sbm/core.c b/arch/x86/kernel/sbm/core.c
index f3a123d64afc..81f1b0093537 100644
--- a/arch/x86/kernel/sbm/core.c
+++ b/arch/x86/kernel/sbm/core.c
@@ -264,6 +264,14 @@ int arch_sbm_init(struct sbm *sbm)
 	if (err)
 		return err;
 
+	state->exc_stack = __get_free_pages(GFP_KERNEL, EXCEPTION_STACK_ORDER);
+	if (err)
+		return err;
+	err = map_range(state, state->exc_stack,
+			state->exc_stack + EXCEPTION_STKSZ, PAGE_KERNEL);
+	if (err)
+		return err;
+
 	err = map_cpu_data(state);
 	if (err)
 		return err;
@@ -324,6 +332,7 @@ void arch_sbm_destroy(struct sbm *sbm)
 		free_pgd(state->pgd);
 		free_pages((unsigned long)state->pgd, PGD_ORDER);
 	}
+	free_pages(state->exc_stack, EXCEPTION_STACK_ORDER);
 	free_pages(state->stack, THREAD_SIZE_ORDER);
 	free_page((unsigned long)state);
 	sbm->private = NULL;
@@ -332,6 +341,16 @@ void arch_sbm_destroy(struct sbm *sbm)
 int arch_sbm_exec(struct sbm *sbm, sbm_func func, void *args)
 {
 	struct x86_sbm_state *state = sbm->private;
+	int err;
+
+	/* let interrupt handlers use the sandbox state page */
+	barrier();
+	WRITE_ONCE(current_thread_info()->sbm_state, state);
+
+	err = x86_sbm_exec(state, func, args, state->stack + THREAD_SIZE);
+
+	/* NULLify the state page pointer before it becomes stale */
+	WRITE_ONCE(current_thread_info()->sbm_state, NULL);
 
-	return x86_sbm_exec(state, func, args, state->stack + THREAD_SIZE);
+	return err;
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c3b2f863acf0..b9c9c74314e7 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -66,6 +66,7 @@
 #include <asm/vdso.h>
 #include <asm/tdx.h>
 #include <asm/cfi.h>
+#include <asm/sbm.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -773,7 +774,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
  */
 asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 {
-	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(pcpu_hot.top_of_stack) - 1;
+	struct pt_regs *regs = (struct pt_regs *)top_of_intr_stack() - 1;
 	if (regs != eregs)
 		*regs = *eregs;
 	return regs;
-- 
2.34.1


