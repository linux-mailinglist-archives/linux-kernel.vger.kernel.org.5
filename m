Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6D7D84C5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345285AbjJZObt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345268AbjJZObg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:31:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB924D45
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:31:30 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bbbe81185dso2627761fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698330689; x=1698935489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nvd5tbkx0wONJ7FbBv/unJCvEEp3cB9Z1bFC9KGhtGY=;
        b=uNJYBRbiotxkDHzYaor9yVbHjcudmDoNlkesIkKdZYCSSH7VOjqREJDzKLGFKA5M4B
         Ffv+7heiSvN3dBdNAFxJXccW1Yl/utflIZolN2gWHemAzKBiAg5rs1GykxzBAZ9mmgHy
         99QtBrKwkZnhfFnEdU6oSPnkR4U4DJZ6DAsZ+F3JAoqgw6pvUB/lj21AaxyBDE+16PtX
         vfeJ0noCnzK6qP5RH96W2yruO6OoVyCXuVevRlzLrVBep4eh7U6anl9hXP3SequtQWji
         DMM3eY2I9IfB323YaXrGclRAZ77YY63KPYzL1rXnkESEqiWhN3iOJRLaAEHmf2O2i8gI
         nuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330689; x=1698935489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvd5tbkx0wONJ7FbBv/unJCvEEp3cB9Z1bFC9KGhtGY=;
        b=CcYkld4LmwO3cwCE1GOH2qneCQMjpQwLTTtBIGMViSFzSKDTpZ1elJfS2so6h+AhHK
         +A8wc9lQCVddg+0sF5UKCTwUUqiWD5PJ8K9diwW8UzwrBYwMZbpaIWNji9rXZNopq8kh
         IMoI++ByeTh8h2C3QU0sjerlp8pZhyGKAEau9gEKB4F7R09eCuM9Qahy5OXQaWNIhboD
         O4bVU8t3kcobc/nFlByZLv8fvRSrRqc9+EkToRwUIK0LbNSYA37nLJ2tkNBOOYvMNplQ
         aFM1Lc8BfEDVNU5jXiyfeRomC+SV9AeqiwuGxP5NcHNKmk4JClAuBZZ2CVIIHNE7RC+k
         pzoQ==
X-Gm-Message-State: AOJu0YyE16TWKwxyVhDiluF8Y+Wa6aI8wSXc2ICEoaIc37h2PR6U5Nr+
        5M+v0Y8DcSVMG6lIf0HxCYTw6w==
X-Google-Smtp-Source: AGHT+IEzIEnFSzmI/Tg0p7jPQew3DnzNQ6cc0DjpVqoBm2XA6DIq4tK1MVZEgLYHIWJEz75gYyTVDw==
X-Received: by 2002:a2e:9943:0:b0:2c0:7d6:1349 with SMTP id r3-20020a2e9943000000b002c007d61349mr13112934ljj.0.1698330688753;
        Thu, 26 Oct 2023 07:31:28 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:b380:32be:257:5381])
        by smtp.gmail.com with ESMTPSA id r9-20020a056000014900b003232f167df5sm14316589wrx.108.2023.10.26.07.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:31:28 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Himanshu Chauhan <hchauhan@ventanamicro.com>,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH 2/3] riscv: add support for SBI Supervisor Software Events extension
Date:   Thu, 26 Oct 2023 16:31:21 +0200
Message-ID: <20231026143122.279437-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026143122.279437-1-cleger@rivosinc.com>
References: <20231026143122.279437-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBI SSE extension allows the supervisor software to be notified by
the SBI of specific events that are not maskable. The context switch is
handled entirely by the firmware which will save all registers into a
supervisor provided context and restore a set of registers from this
same context. This context contains all the RV GP registers and thus
will also switch the stack.

Since each events (and each CPU for local events) have their own
context (and thus their own set of register), allocate a stack for each
event (and for each cpu for local events). This can be modified if
needed to use a single stack per cpu for SSE event but will require a
bit more additional plumbing.

When completing the event, if we were coming from kernel with interrupts
disabled, simply return there. If coming from userspace or kernel with
interrupts enabled, simulate an interrupt exception to allow delivery of
signal to user task. For instance this can happen, when a RAS event has
been generated and a SIGBUS has been sent to a task.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/asm-prototypes.h |   5 +
 arch/riscv/include/asm/sse.h            |  94 +++++
 arch/riscv/kernel/Makefile              |   1 +
 arch/riscv/kernel/asm-offsets.c         |  17 +
 arch/riscv/kernel/entry.S               | 156 ++++++++
 arch/riscv/kernel/sse.c                 |  97 +++++
 arch/riscv/kernel/stacktrace.c          |  13 +
 arch/riscv/kernel/vmlinux.lds.S         |   6 +
 drivers/firmware/Kconfig                |  10 +
 drivers/firmware/Makefile               |   1 +
 drivers/firmware/riscv_sse.c            | 496 ++++++++++++++++++++++++
 include/linux/riscv_sse.h               |  56 +++
 12 files changed, 952 insertions(+)
 create mode 100644 arch/riscv/include/asm/sse.h
 create mode 100644 arch/riscv/kernel/sse.c
 create mode 100644 drivers/firmware/riscv_sse.c
 create mode 100644 include/linux/riscv_sse.h

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index 61ba8ed43d8f..c622ed1db33c 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -3,6 +3,8 @@
 #define _ASM_RISCV_PROTOTYPES_H
 
 #include <linux/ftrace.h>
+#include <linux/riscv_sse.h>
+#include <asm/sse.h>
 #include <asm-generic/asm-prototypes.h>
 
 long long __lshrti3(long long a, int b);
@@ -29,5 +31,8 @@ asmlinkage unsigned long get_overflow_stack(void);
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
 asmlinkage void do_page_fault(struct pt_regs *regs);
 asmlinkage void do_irq(struct pt_regs *regs);
+asmlinkage unsigned long do_sse(unsigned long evt,
+				struct sse_interrupted_state *i_state,
+				sse_event_handler *handler, void *arg);
 
 #endif /* _ASM_RISCV_PROTOTYPES_H */
diff --git a/arch/riscv/include/asm/sse.h b/arch/riscv/include/asm/sse.h
new file mode 100644
index 000000000000..e663224296df
--- /dev/null
+++ b/arch/riscv/include/asm/sse.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+#ifndef __ASM_SSE_H
+#define __ASM_SSE_H
+
+#include <linux/riscv_sse.h>
+
+
+struct sse_interrupted_state {
+	unsigned long pc;
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long gp;
+	unsigned long tp;
+	unsigned long t0;
+	unsigned long t1;
+	unsigned long t2;
+	unsigned long s0;
+	unsigned long s1;
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long a2;
+	unsigned long a3;
+	unsigned long a4;
+	unsigned long a5;
+	unsigned long a6;
+	unsigned long a7;
+	unsigned long s2;
+	unsigned long s3;
+	unsigned long s4;
+	unsigned long s5;
+	unsigned long s6;
+	unsigned long s7;
+	unsigned long s8;
+	unsigned long s9;
+	unsigned long s10;
+	unsigned long s11;
+	unsigned long t3;
+	unsigned long t4;
+	unsigned long t5;
+	unsigned long t6;
+	unsigned long exec_mode;
+};
+
+struct sse_entry_state {
+	unsigned long pc;
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long gp;
+	unsigned long tp;
+	unsigned long t0;
+	unsigned long t1;
+	unsigned long t2;
+	unsigned long s0;
+	unsigned long s1;
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long a2;
+	unsigned long a3;
+	unsigned long a4;
+	unsigned long a5;
+	unsigned long a6;
+	unsigned long a7;
+	unsigned long s2;
+	unsigned long s3;
+	unsigned long s4;
+	unsigned long s5;
+	unsigned long s6;
+	unsigned long s7;
+	unsigned long s8;
+	unsigned long s9;
+	unsigned long s10;
+	unsigned long s11;
+	unsigned long t3;
+	unsigned long t4;
+	unsigned long t5;
+	unsigned long t6;
+};
+
+struct sse_handler_context {
+	struct sse_entry_state e_state;
+	struct sse_interrupted_state i_state;
+};
+
+unsigned long *sse_stack_alloc(unsigned int cpu, unsigned int size);
+void sse_stack_free(unsigned long *stack);
+
+struct sse_handler_context;
+void sse_handler_context_init(struct sse_handler_context *ctx, void *stack,
+			      u32 evt, sse_event_handler *handler, void *arg);
+
+#endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 95cf25d48405..571b2aaf669b 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
+obj-$(CONFIG_RISCV_SSE)		+= sse.o
 ifeq ($(CONFIG_RISCV_SBI), y)
 obj-$(CONFIG_SMP)		+= sbi-ipi.o
 obj-$(CONFIG_SMP) += cpu_ops_sbi.o
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index d6a75aac1d27..1776448e67d2 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -14,7 +14,10 @@
 #include <asm/thread_info.h>
 #include <asm/ptrace.h>
 #include <asm/cpu_ops_sbi.h>
+#include <asm/sbi.h>
+#include <asm/sse.h>
 #include <asm/suspend.h>
+#include <asm/stacktrace.h>
 
 void asm_offsets(void);
 
@@ -479,4 +482,18 @@ void asm_offsets(void)
 	OFFSET(KERNEL_MAP_VIRT_ADDR, kernel_mapping, virt_addr);
 	OFFSET(SBI_HART_BOOT_TASK_PTR_OFFSET, sbi_hart_boot_data, task_ptr);
 	OFFSET(SBI_HART_BOOT_STACK_PTR_OFFSET, sbi_hart_boot_data, stack_ptr);
+
+	OFFSET(SSE_INTERRUPTED_EXEC_MODE, sse_interrupted_state, exec_mode);
+	OFFSET(SSE_INTERRUPTED_S0, sse_interrupted_state, s0);
+	OFFSET(SSE_INTERRUPTED_TP, sse_interrupted_state, tp);
+	OFFSET(SSE_INTERRUPTED_PC, sse_interrupted_state, pc);
+
+	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe),
+					       STACK_ALIGN));
+	OFFSET(STACKFRAME_FP, stackframe, fp);
+	OFFSET(STACKFRAME_RA, stackframe, ra);
+	DEFINE(SBI_EXT_SSE, SBI_EXT_SSE);
+	DEFINE(SBI_SSE_EVENT_COMPLETE, SBI_SSE_EVENT_COMPLETE);
+
+	DEFINE(ASM_PAGE_OFFSET, CONFIG_PAGE_OFFSET);
 }
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 143a2bb3e697..4adf7b21a568 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -14,17 +14,49 @@
 #include <asm/asm-offsets.h>
 #include <asm/errata_list.h>
 
+#ifdef CONFIG_RISCV_SSE
+#define IN_TP			0
+#define IN_SSCRATCH		1
+#define PRV_U_TASK_LOC(loc)	(loc << 0)
+#define PRV_S_TASK_LOC(loc)	(loc << 1)
+#define TASK_LOC(s_loc, u_loc)	(PRV_U_TASK_LOC(u_loc) | PRV_S_TASK_LOC(s_loc))
+#define TASK_LOC_ENTRY_SIZE	(RISCV_SZPTR + 1)
+
+/* __SSE_TASK_LOC - Annotate e'xception code with the location of current task
+ *		    struct when coming from S/U mode
+ *
+ * When entering handle_exception(), the current task struct is located either
+ * in tp or sscratch depending on interrupted mode. Since SSE handlers can be
+ * triggered at any time during the execution of the kernel, we need to be able
+ * to retrieve the current task struct even if in handle_exception. This macro
+ * create an entry into the __task_loc section that holds the location of
+ * the current task struct for the subsequent assembly located after that up to
+ * _ret_from_exception_end or the next __TASK_LOC.
+ */
+#define __SSE_TASK_LOC(s_loc, u_loc)			\
+	.pushsection __task_loc,"a";	\
+	RISCV_PTR 99f;				\
+	.byte TASK_LOC(s_loc, u_loc);		\
+	.popsection;				\
+	99:
+#else
+#define __SSE_TASK_LOC(s_loc, u_loc)
+#endif
+
 SYM_CODE_START(handle_exception)
 	/*
 	 * If coming from userspace, preserve the user thread pointer and load
 	 * the kernel thread pointer.  If we came from the kernel, the scratch
 	 * register will contain 0, and we should continue on the current TP.
 	 */
+__SSE_TASK_LOC(IN_TP, IN_SSCRATCH)
 	csrrw tp, CSR_SCRATCH, tp
+__SSE_TASK_LOC(IN_SSCRATCH, IN_TP)
 	bnez tp, _save_context
 
 _restore_kernel_tpsp:
 	csrr tp, CSR_SCRATCH
+__SSE_TASK_LOC(IN_TP, IN_TP)
 	REG_S sp, TASK_TI_KERNEL_SP(tp)
 
 #ifdef CONFIG_VMAP_STACK
@@ -151,6 +183,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	REG_SC x0, a2, PT_EPC(sp)
 
 	csrw CSR_STATUS, a0
+__SSE_TASK_LOC(IN_TP, IN_SSCRATCH)
 	csrw CSR_EPC, a2
 
 	REG_L x1,  PT_RA(sp)
@@ -166,6 +199,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 #else
 	sret
 #endif
+_ret_from_exception_end:
 SYM_CODE_END(ret_from_exception)
 
 #ifdef CONFIG_VMAP_STACK
@@ -268,6 +302,125 @@ SYM_CODE_START(ret_from_fork)
 	tail syscall_exit_to_user_mode
 SYM_CODE_END(ret_from_fork)
 
+#ifdef CONFIG_RISCV_SSE
+SYM_CODE_START(handle_sse)
+	move s3, a0
+	/*
+	 * Depending on where the sse event interrupted the kernel execution,
+	 * sscratch content might be 0 or not even if kernel was interrupted.
+	 * This might happen if the sse event was triggered while in
+	 * handle_exception() right after entry. In that case, sscratch might
+	 * contain 0 if coming from kernel. In order to handle that easily,
+	 * simply save sscratch content and restore it when returning from sse
+	 * event.
+	 */
+	csrr s4, CSR_SSCRATCH
+	/*
+	 * Save CAUSE and TVAL in case of nested exceptions, EPC/STATUS are
+	 * already saved/restored by handle_exception() for nested exceptions.
+	 */
+	csrr s5, CSR_SCAUSE
+	csrr s6, CSR_STVAL
+	REG_L t0, SSE_INTERRUPTED_EXEC_MODE(a1)
+	andi t1, t0, 0x1
+
+	/* Userspace was interrupted, simply restore TP from scratch */
+	bnez t1, _sse_from_kernel
+	move tp, s4
+	j _call_do_sse
+
+_sse_from_kernel:
+	REG_L t0, SSE_INTERRUPTED_PC(a1)
+#ifdef CONFIG_FRAME_POINTER
+	/*
+	 * Else, kernel was interrupted and we will create a correct stack frame
+	 * from interrupted context.
+	 */
+	addi sp, sp, -(STACKFRAME_SIZE_ON_STACK)
+	REG_L t2, SSE_INTERRUPTED_S0(a1)
+	REG_S t2, STACKFRAME_FP(sp)
+	REG_S t0, STACKFRAME_RA(sp)
+	addi s0, sp, STACKFRAME_SIZE_ON_STACK
+#endif
+	REG_L tp, SSE_INTERRUPTED_TP(a1)
+
+	/*
+	 * If interrupting the kernel during exception handling
+	 * (see handle_exception), then, we might have tp either in SSCRATCH or
+	 * in tp, this part is non regular and requires some more work to
+	 * determine were is located the current task.
+	 */
+	la t1, handle_exception
+	la t2, _ret_from_exception_end
+	bltu t0, t1, _call_do_sse
+	bltu t0, t2, _sse_exception_slow_path
+
+_call_do_sse:
+
+	/* TODO: remove this sanity check once sure everything works ! */
+	li t1, ASM_PAGE_OFFSET
+	bgeu tp, t1, _tp_ok
+	la tp, init_task
+	la a0, sse_panic_string
+	la t0, panic
+	jalr t0
+_tp_ok:
+
+	csrw CSR_SCRATCH, x0
+	la ra, ret_from_sse
+	tail do_sse
+
+.global ret_from_sse
+ret_from_sse:
+	/* Restore saved CSRs */
+	csrw CSR_SSCRATCH, s4
+	csrw CSR_SCAUSE, s5
+	csrw CSR_STVAL, s6
+	li a2, 0
+	move a1, a0
+	move a0, s3
+	li a7, SBI_EXT_SSE
+	li a6, SBI_SSE_EVENT_COMPLETE
+	ecall
+
+/*
+ * t0 contains interrupted pc
+ * t1 contains handle_exception address
+ * When called, t0 must be in [handle_exception, _ret_from_exception_end[
+ */
+_sse_exception_slow_path:
+	la t3, __stop___task_loc
+	add t3, t3, -TASK_LOC_ENTRY_SIZE
+	la t4, __start___task_loc
+	/*
+	 * Reverse iterate the task location section to find where is located
+	 * the task struct
+	 */
+1:
+	REG_L	t2, 0(t3)
+	bgeu t0, t2, 2f
+	add t3, t3, -TASK_LOC_ENTRY_SIZE
+	bgeu t3, t4, 1b
+
+2:
+	lbu t2, RISCV_SZPTR(t3)
+
+	/* Get the value of SR_SPP */
+	csrr t1, CSR_SSTATUS
+	andi t1, t1, SR_SPP
+	snez t1, t1
+
+	srl t2, t2, t1
+	andi t2, t2, 1
+	beqz t2, _call_do_sse
+
+_restore_tp_from_sscratch:
+	csrr tp, CSR_SCRATCH
+	j _call_do_sse
+
+SYM_CODE_END(handle_sse)
+#endif
+
 /*
  * Integer register context switch
  * The callee-saved registers must be saved and restored.
@@ -351,3 +504,6 @@ SYM_CODE_START(__user_rt_sigreturn)
 	ecall
 SYM_CODE_END(__user_rt_sigreturn)
 #endif
+
+sse_panic_string:
+    .ascii "SSE TP is invalid, last state %px"
diff --git a/arch/riscv/kernel/sse.c b/arch/riscv/kernel/sse.c
new file mode 100644
index 000000000000..69c2607d9dbf
--- /dev/null
+++ b/arch/riscv/kernel/sse.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+#include <linux/nmi.h>
+#include <linux/bitfield.h>
+#include <linux/riscv_sse.h>
+
+#include <asm/irq_stack.h>
+#include <asm/sbi.h>
+#include <asm/sse.h>
+
+#define SSE_PRIVILEGE_MODE_BIT			BIT(0)
+#define SSE_SPIE_BIT				BIT(2)
+
+#define sse_privilege_mode(exec_mode)	FIELD_GET(SSE_PRIVILEGE_MODE_BIT, exec_mode)
+#define sse_spie(exec_mode)		FIELD_GET(SSE_SPIE_BIT, exec_mode)
+
+register unsigned long gp_in_global __asm__("gp");
+
+extern asmlinkage void handle_exception(void);
+extern asmlinkage void handle_sse(unsigned long evt,
+				  struct sse_interrupted_state *i_state,
+				  sse_event_handler *handler, void *arg);
+
+static void sse_get_pt_regs(struct sse_interrupted_state *i_state,
+			    struct pt_regs *regs)
+{
+	unsigned long sstatus = csr_read(CSR_SSTATUS);
+
+	memcpy(regs, i_state, offsetof(struct sse_interrupted_state, exec_mode));
+	regs->status = sstatus & ~SR_SPP;
+	regs->status |= FIELD_PREP(SR_SPP, sse_privilege_mode(i_state->exec_mode));
+}
+
+unsigned long do_sse(unsigned long evt, struct sse_interrupted_state *i_state,
+		     sse_event_handler *handler, void *arg)
+{
+	int ret;
+	struct pt_regs regs;
+
+	nmi_enter();
+
+	sse_get_pt_regs(i_state, &regs);
+	ret = handler(evt, arg, &regs);
+	if (ret)
+		pr_warn("event %lx handler failed with error %d\n", evt, ret);
+
+	/* The SSE delivery path does not uses the "standard" exception path and
+	 * thus does not process any pending signal/softirqs. Some drivers might
+	 * enqueue pending work that needs to be handled as soon as possible.
+	 * For that purpose, set the software interrupt pending bit
+	 */
+	csr_set(CSR_IP, IE_SIE);
+
+	nmi_exit();
+
+	return ret ? SBI_SSE_HANDLER_FAILED : SBI_SSE_HANDLER_SUCCESS;
+}
+
+#ifdef CONFIG_VMAP_STACK
+unsigned long *sse_stack_alloc(unsigned int cpu, unsigned int size)
+{
+	return arch_alloc_vmap_stack(size, cpu_to_node(cpu));
+}
+
+void sse_stack_free(unsigned long *stack)
+{
+	vfree(stack);
+}
+#else /* CONFIG_VMAP_STACK */
+
+unsigned long *sse_stack_alloc(unsigned int cpu, unsigned int size)
+{
+	return kmalloc(size, GFP_KERNEL);
+}
+
+void sse_stack_free(unsigned long *stack)
+{
+	kfree(stack);
+}
+
+#endif /* CONFIG_VMAP_STACK */
+
+void sse_handler_context_init(struct sse_handler_context *ctx, void *stack,
+			      u32 evt, sse_event_handler *handler, void *arg)
+{
+	ctx->e_state.pc = (unsigned long)handle_sse;
+	ctx->e_state.gp = gp_in_global;
+	ctx->e_state.sp = (unsigned long)stack + THREAD_SIZE;
+
+	/* This must match handle_sse expected parameter order */
+	ctx->e_state.a0 = evt;
+	ctx->e_state.a1 = (unsigned long)&ctx->i_state;
+	ctx->e_state.a2 = (unsigned long)handler;
+	ctx->e_state.a3 = (unsigned long)arg;
+}
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 64a9c093aef9..a3d08792e3b5 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -17,6 +17,7 @@
 #ifdef CONFIG_FRAME_POINTER
 
 extern asmlinkage void ret_from_exception(void);
+extern asmlinkage void ret_from_sse(void);
 
 void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(void *, unsigned long), void *arg)
@@ -68,6 +69,18 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 
 				pc = ((struct pt_regs *)sp)->epc;
 				fp = ((struct pt_regs *)sp)->s0;
+			} else if (pc == (unsigned long)ret_from_sse) {
+				if (unlikely(!fn(arg, pc)))
+					break;
+				/* We don't have pt_regs when handling SSE
+				 * events but we build a custom stackframe,
+				 * moreover, the stack changes across boundaries
+				 * so update it to avoid failing the checks above
+				 */
+				frame = (struct stackframe *)fp - 1;
+				fp = frame->fp;
+				pc = frame->ra;
+				sp = fp - sizeof(struct stackframe);
 			}
 		}
 
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 492dd4b8f3d6..f7e9cde2e832 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -120,6 +120,12 @@ SECTIONS
 	/* Start of data section */
 	_sdata = .;
 	RO_DATA(SECTION_ALIGN)
+
+#ifdef CONFIG_RISCV_SSE
+	__task_loc : {
+		BOUNDED_SECTION_BY(__task_loc, ___task_loc)
+	}
+#endif
 	.srodata : {
 		*(.srodata*)
 	}
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..1749595b4150 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -226,6 +226,16 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 
 	  Say Y here to enable "download mode" by default.
 
+config RISCV_SSE
+	bool
+	depends on RISCV_SBI
+	default y
+	help
+	  The Supervisor Software Events support allow the SBI to deliver
+	  NMI-like notifications to the supervisor mode software. When enable,
+	  this option provides support to register callbacks on specific SSE
+	  events.
+
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 28fcddcd688f..b0fcb0a74642 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
 qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
+obj-$(CONFIG_RISCV_SSE)		+= riscv_sse.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
 obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
diff --git a/drivers/firmware/riscv_sse.c b/drivers/firmware/riscv_sse.c
new file mode 100644
index 000000000000..5447ed0d3ae4
--- /dev/null
+++ b/drivers/firmware/riscv_sse.c
@@ -0,0 +1,496 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+#define pr_fmt(fmt) "sse: " fmt
+
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+#include <linux/hardirq.h>
+#include <linux/list.h>
+#include <linux/percpu-defs.h>
+#include <linux/riscv_sse.h>
+#include <linux/slab.h>
+
+#include <asm/sbi.h>
+#include <asm/sse.h>
+
+struct sse_registered_event {
+	struct sse_handler_context ctx;
+	unsigned long *stack;
+};
+
+struct sse_event {
+	struct list_head list;
+	u32 evt;
+	u32 priority;
+	unsigned int cpu;
+
+	union {
+		struct sse_registered_event *global;
+		struct sse_registered_event __percpu *local;
+	};
+};
+
+static bool sse_available;
+static DEFINE_SPINLOCK(events_list_lock);
+static LIST_HEAD(events);
+static DEFINE_MUTEX(sse_mutex);
+
+static struct sbiret sbi_sse_ecall(int fid, unsigned long arg0,
+				   unsigned long arg1, unsigned long arg2)
+{
+	return sbi_ecall(SBI_EXT_SSE, fid, arg0, arg1, arg2, 0, 0, 0);
+}
+
+static bool sse_event_is_global(u32 evt)
+{
+	return !!(evt & SBI_SSE_EVENT_GLOBAL);
+}
+
+static
+struct sse_event *sse_event_get(u32 evt)
+{
+	struct sse_event *sse_evt = NULL, *tmp;
+
+	spin_lock(&events_list_lock);
+	list_for_each_entry(tmp, &events, list) {
+		if (tmp->evt == evt) {
+			sse_evt = tmp;
+			break;
+		}
+	}
+	spin_unlock(&events_list_lock);
+
+	return sse_evt;
+}
+
+static int sse_event_set_target_cpu_nolock(struct sse_event *event, unsigned int cpu)
+{
+	unsigned int hart_id = cpuid_to_hartid_map(cpu);
+	u32 evt = event->evt;
+	struct sbiret sret;
+
+	if (!sse_event_is_global(evt))
+		return -EINVAL;
+
+	do {
+		sret = sbi_sse_ecall(SBI_SSE_EVENT_ATTR_SET, evt,
+				     SBI_SSE_EVENT_ATTR_HART_ID, hart_id);
+		if (sret.error && sret.error != SBI_ERR_BUSY) {
+			pr_err("Failed to set event %x hart id, error %ld\n", evt,
+			       sret.error);
+			return sbi_err_map_linux_errno(sret.error);
+		}
+	} while (sret.error);
+
+	event->cpu = cpu;
+
+	return 0;
+}
+
+
+int sse_event_set_target_cpu(struct sse_event *event, unsigned int cpu)
+{
+	int ret;
+
+	mutex_lock(&sse_mutex);
+	ret = sse_event_set_target_cpu_nolock(event, cpu);
+	mutex_unlock(&sse_mutex);
+
+	return ret;
+}
+
+static int sse_event_init_registered(unsigned int cpu, u32 evt,
+				     struct sse_registered_event *reg_evt,
+				     sse_event_handler *handler, void *arg)
+{
+	unsigned long *stack;
+
+	stack = sse_stack_alloc(cpu, THREAD_SIZE);
+	if (!stack)
+		return -ENOMEM;
+
+	reg_evt->stack = stack;
+
+	sse_handler_context_init(&reg_evt->ctx, stack, evt, handler, arg);
+
+	return 0;
+}
+
+static struct sse_event *sse_event_alloc(u32 evt,
+					 u32 priority,
+					 sse_event_handler *handler, void *arg)
+{
+	int err;
+	unsigned int cpu;
+	struct sse_event *event;
+	struct sse_registered_event __percpu *reg_evts;
+	struct sse_registered_event *reg_evt;
+
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event)
+		return ERR_PTR(-ENOMEM);
+
+	event->evt = evt;
+	event->priority = priority;
+
+	if (sse_event_is_global(evt)) {
+		reg_evt = kzalloc(sizeof(*reg_evt), GFP_KERNEL);
+		if (!reg_evt) {
+			err = -ENOMEM;
+			goto err_alloc_reg_evt;
+		}
+
+		event->global = reg_evt;
+		err = sse_event_init_registered(smp_processor_id(), evt,
+						reg_evt, handler, arg);
+		if (err)
+			goto err_alloc_reg_evt;
+
+
+	} else {
+		reg_evts = alloc_percpu(struct sse_registered_event);
+		if (!reg_evts) {
+			err = -ENOMEM;
+			goto err_alloc_reg_evt;
+		}
+
+		event->local = reg_evts;
+
+		for_each_possible_cpu(cpu) {
+			reg_evt = per_cpu_ptr(reg_evts, cpu);
+
+			err = sse_event_init_registered(cpu, evt, reg_evt,
+							handler, arg);
+			if (err)
+				goto err_alloc_reg_evt;
+
+		}
+	}
+
+	return event;
+
+err_alloc_reg_evt:
+	kfree(event);
+
+	return ERR_PTR(err);
+}
+
+static int sse_sbi_register_event(struct sse_event *event,
+				  struct sse_registered_event *reg_evt)
+{
+	struct sbiret ret;
+	phys_addr_t phys;
+	u32 evt = event->evt;
+
+	ret = sbi_sse_ecall(SBI_SSE_EVENT_ATTR_SET, evt,
+			    SBI_SSE_EVENT_ATTR_PRIORITY, event->priority);
+	if (ret.error) {
+		pr_err("Failed to set event %x priority, error %ld\n", evt,
+		       ret.error);
+		return sbi_err_map_linux_errno(ret.error);
+	}
+
+	if (sse_event_is_global(event->evt))
+		phys = virt_to_phys(&reg_evt->ctx);
+	else
+		phys = per_cpu_ptr_to_phys(&reg_evt->ctx);
+
+	ret = sbi_sse_ecall(SBI_SSE_EVENT_REGISTER, evt, phys, 0);
+	if (ret.error)
+		pr_err("Failed to register event %d, error %ld\n", evt,
+		       ret.error);
+
+	return sbi_err_map_linux_errno(ret.error);
+}
+
+static int sse_sbi_event_func(struct sse_event *event, unsigned long func)
+{
+	struct sbiret ret;
+	u32 evt = event->evt;
+
+	ret = sbi_sse_ecall(func, evt, 0, 0);
+	if (ret.error)
+		pr_err("Failed to execute func %lx, event %d, error %ld\n", func,
+		       evt, ret.error);
+
+	return sbi_err_map_linux_errno(ret.error);
+}
+
+static int sse_event_register_local(struct sse_event *event)
+{
+	int ret;
+	struct sse_registered_event *reg_evt = per_cpu_ptr(event->local,
+							   smp_processor_id());
+
+	ret = sse_sbi_register_event(event, reg_evt);
+	if (ret)
+		pr_err("Failed to register event %x: err %d\n", event->evt,
+		       ret);
+
+	return ret;
+}
+
+static int sse_sbi_disable_event(struct sse_event *event)
+{
+	return sse_sbi_event_func(event, SBI_SSE_EVENT_DISABLE);
+}
+
+static int sse_sbi_enable_event(struct sse_event *event)
+{
+	return sse_sbi_event_func(event, SBI_SSE_EVENT_ENABLE);
+}
+
+static int sse_sbi_unregister_event(struct sse_event *event)
+{
+	return sse_sbi_event_func(event, SBI_SSE_EVENT_UNREGISTER);
+}
+
+struct sse_per_cpu_evt {
+	struct sse_event *event;
+	unsigned long func;
+	int error;
+};
+
+static void sse_event_per_cpu_func(void *info)
+{
+	int ret;
+	struct sse_per_cpu_evt *cpu_evt = info;
+
+	if (cpu_evt->func == SBI_SSE_EVENT_REGISTER)
+		ret = sse_event_register_local(cpu_evt->event);
+	else
+		ret = sse_sbi_event_func(cpu_evt->event, cpu_evt->func);
+
+	if (ret)
+		WRITE_ONCE(cpu_evt->error, 1);
+}
+
+static void sse_event_free(struct sse_event *event)
+{
+	unsigned int cpu;
+	struct sse_registered_event *reg_evt;
+
+	if (sse_event_is_global(event->evt)) {
+		sse_stack_free(event->global->stack);
+	} else {
+		for_each_possible_cpu(cpu) {
+			reg_evt = per_cpu_ptr(event->local, cpu);
+			sse_stack_free(reg_evt->stack);
+		}
+		free_percpu(event->local);
+	}
+
+	kfree(event);
+}
+
+int sse_event_enable(struct sse_event *event)
+{
+	int ret = 0;
+	struct sse_per_cpu_evt cpu_evt;
+
+	mutex_lock(&sse_mutex);
+
+	cpus_read_lock();
+	if (sse_event_is_global(event->evt)) {
+		/* Global events can only be unregister from target hart */
+		ret = sse_event_set_target_cpu_nolock(event, smp_processor_id());
+		if (ret)
+			goto out;
+
+		ret = sse_sbi_enable_event(event);
+		if (ret)
+			goto out;
+
+	} else {
+		cpu_evt.event = event;
+		cpu_evt.error = 0;
+		cpu_evt.func = SBI_SSE_EVENT_ENABLE;
+		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+		if (READ_ONCE(cpu_evt.error)) {
+			cpu_evt.func = SBI_SSE_EVENT_DISABLE;
+			on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+			goto out;
+		}
+	}
+	cpus_read_unlock();
+
+out:
+	mutex_unlock(&sse_mutex);
+
+	return ret;
+}
+
+void sse_event_disable(struct sse_event *event)
+{
+	struct sse_per_cpu_evt cpu_evt;
+
+	mutex_lock(&sse_mutex);
+
+	if (sse_event_is_global(event->evt)) {
+		sse_sbi_disable_event(event);
+	} else {
+		cpu_evt.event = event;
+		cpu_evt.func = SBI_SSE_EVENT_DISABLE;
+		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+	}
+
+	mutex_unlock(&sse_mutex);
+}
+
+struct sse_event *sse_event_register(u32 evt, u32 priority,
+				     sse_event_handler *handler, void *arg)
+{
+	struct sse_per_cpu_evt cpu_evt;
+	struct sse_event *event;
+	int ret = 0;
+
+	mutex_lock(&sse_mutex);
+	if (sse_event_get(evt)) {
+		pr_err("Event %x already registered\n", evt);
+		ret = -EEXIST;
+		goto out_unlock;
+	}
+
+	event = sse_event_alloc(evt, priority, handler, arg);
+	if (IS_ERR(event)) {
+		ret = PTR_ERR(event);
+		goto out_unlock;
+	}
+
+	cpus_read_lock();
+	if (sse_event_is_global(evt)) {
+		/* SSE spec mandates that the CPU registering the global event be the
+		 * one set as the target hart, plus we don't know initial value
+		 */
+		ret = sse_event_set_target_cpu_nolock(event, smp_processor_id());
+		if (ret)
+			goto err_event_free;
+
+		ret = sse_sbi_register_event(event, event->global);
+		if (ret)
+			goto err_event_free;
+
+	} else {
+		cpu_evt.event = event;
+		cpu_evt.error = 0;
+		cpu_evt.func = SBI_SSE_EVENT_REGISTER;
+		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+		if (READ_ONCE(cpu_evt.error)) {
+			cpu_evt.func = SBI_SSE_EVENT_UNREGISTER;
+			on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+			goto err_event_free;
+		}
+	}
+	cpus_read_unlock();
+
+	spin_lock(&events_list_lock);
+	list_add(&event->list, &events);
+	spin_unlock(&events_list_lock);
+
+	mutex_unlock(&sse_mutex);
+
+	return event;
+
+err_event_free:
+	cpus_read_unlock();
+	sse_event_free(event);
+out_unlock:
+	mutex_unlock(&sse_mutex);
+
+	return ERR_PTR(ret);
+}
+
+void sse_event_unregister(struct sse_event *event)
+{
+	int ret;
+	struct sse_per_cpu_evt cpu_evt;
+
+	mutex_lock(&sse_mutex);
+
+	if (sse_event_is_global(event->evt)) {
+		/* Global events can only be unregister from target hart */
+		ret = sse_event_set_target_cpu_nolock(event, smp_processor_id());
+		WARN_ON(ret);
+		sse_sbi_unregister_event(event);
+	} else {
+		cpu_evt.event = event;
+		cpu_evt.func = SBI_SSE_EVENT_UNREGISTER;
+		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+	}
+
+	spin_lock(&events_list_lock);
+	list_del(&event->list);
+	spin_unlock(&events_list_lock);
+
+	sse_event_free(event);
+
+	mutex_unlock(&sse_mutex);
+}
+
+static int sse_cpu_online(unsigned int cpu)
+{
+	struct sse_event *sse_evt;
+
+	spin_lock(&events_list_lock);
+	list_for_each_entry(sse_evt, &events, list) {
+		if (sse_event_is_global(sse_evt->evt))
+			continue;
+
+		sse_event_register_local(sse_evt);
+	}
+
+	spin_unlock(&events_list_lock);
+
+	return 0;
+}
+
+static int sse_cpu_teardown(unsigned int cpu)
+{
+	unsigned int next_cpu;
+	struct sse_event *sse_evt;
+
+	spin_lock(&events_list_lock);
+	list_for_each_entry(sse_evt, &events, list) {
+		if (!sse_event_is_global(sse_evt->evt)) {
+			sse_sbi_unregister_event(sse_evt);
+			continue;
+		}
+
+		if (sse_evt->cpu != smp_processor_id())
+			continue;
+
+		/* Update destination hart */
+		next_cpu = cpumask_any_but(cpu_online_mask, cpu);
+		sse_event_set_target_cpu(sse_evt, next_cpu);
+	}
+	spin_unlock(&events_list_lock);
+
+	return 0;
+}
+
+static int __init sse_init(void)
+{
+	int cpu, ret;
+
+	if (sbi_probe_extension(SBI_EXT_SSE) <= 0) {
+		pr_err("Missing SBI SSE extension\n");
+		return -EOPNOTSUPP;
+	}
+	pr_info("SBI SSE extension detected\n");
+
+	for_each_possible_cpu(cpu)
+		INIT_LIST_HEAD(&events);
+
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv/sse:online",
+					sse_cpu_online, sse_cpu_teardown);
+	if (ret < 0)
+		return ret;
+
+	sse_available = true;
+
+	return 0;
+}
+device_initcall(sse_init);
diff --git a/include/linux/riscv_sse.h b/include/linux/riscv_sse.h
new file mode 100644
index 000000000000..3ca145368c50
--- /dev/null
+++ b/include/linux/riscv_sse.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+#ifndef __LINUX_RISCV_SSE_H
+#define __LINUX_RISCV_SSE_H
+
+#include <linux/types.h>
+#include <linux/linkage.h>
+
+struct sse_interrupted_state;
+struct sse_event;
+struct pt_regs;
+
+typedef int (sse_event_handler)(u32 event_num, void *arg, struct pt_regs *regs);
+
+#ifdef CONFIG_RISCV_SSE
+
+struct sse_event *sse_event_register(u32 event_num, u32 priority,
+				     sse_event_handler *handler, void *arg);
+
+void sse_event_unregister(struct sse_event *evt);
+
+int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
+
+int sse_event_enable(struct sse_event *sse_evt);
+
+void sse_event_disable(struct sse_event *sse_evt);
+
+#else
+static inline int sse_event_register(struct sse_event *evt, u32 priority,
+				     sse_event_handler *handler, void *arg)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void sse_event_unregister(struct sse_event *evt) {}
+
+static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
+					   unsigned int cpu)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int sse_event_enable(struct sse_event *sse_evt)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void sse_event_disable(struct sse_event *sse_evt) {}
+
+
+#endif
+
+#endif /* __LINUX_RISCV_SSE_H */
-- 
2.42.0

