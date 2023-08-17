Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E856077EF87
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347846AbjHQD2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347842AbjHQD2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:28:32 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1428910E6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 20:28:27 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx2erak91k61sZAA--.47147S3;
        Thu, 17 Aug 2023 11:28:26 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbSPZk91kLHRcAA--.46854S2;
        Thu, 17 Aug 2023 11:28:25 +0800 (CST)
From:   Hui Li <lihui@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3] LoongArch: Add KGDB support
Date:   Thu, 17 Aug 2023 11:28:25 +0800
Message-Id: <20230817032825.22974-1-lihui@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxbSPZk91kLHRcAA--.46854S2
X-CM-SenderInfo: 5olk3xo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfuF15tryxZF4UuF4fAF1rZrc_yoW5Xw4xJo
        W5Aa1kK348Gr1vkFZ3Jrn8WF1DXa409a4kAFWrursxu3Z0yr15WrWfK3WUZry3ur18trZr
        u34YqasYvas2qr1rl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
        9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
        UjIYCTnIWjp_UUUY17kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
        8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kgdb is intended to be used as a source level debugger for the Linux
kernel. It is used along with gdb to debug a Linux kernel. gdb can be
used to "break in" to the kernel to inspect memory, variables and regs
similar to the way an application developer would use gdb to debug an
application.

Implement the following features for LoongArch:

(1) Connect to the kernel on the target machine through GDB on the
    development machine.

(2) The debugged kernel can be inserted the software breakpoint.

(3) The debugged kernel can run and stop at the breakpoint.

(4) The debugged kernel can resume running from the breakpoint.

(5) The debugged kernel can be removed breakpoints.

(6) Query the value of the general register of the kernel on target
    machine through GDB on the development machine.

(7) When GDB on the development machine exits debugging, the kernel
    on target machine can resume execution normally.

(8) Add hardware breakpoints/watchpoints support.

(9) Add Software single-step support for KDB.

Co-developed-by: Qing Zhang <zhangqing@loongson.cn>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
Co-developed-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Hui Li <lihui@loongson.cn>
---
 arch/loongarch/Kconfig                  |   1 +
 arch/loongarch/include/asm/kgdb.h       | 106 ++++
 arch/loongarch/include/asm/stackframe.h |   4 +
 arch/loongarch/kernel/Makefile          |   2 +
 arch/loongarch/kernel/entry.S           |   5 +
 arch/loongarch/kernel/kgdb.c            | 749 ++++++++++++++++++++++++
 arch/loongarch/kernel/traps.c           |   8 +
 7 files changed, 875 insertions(+)
 create mode 100644 arch/loongarch/include/asm/kgdb.h
 create mode 100644 arch/loongarch/kernel/kgdb.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index c379951adb30..46b4c217da14 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -95,6 +95,7 @@ config LOONGARCH
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN
 	select HAVE_ARCH_KFENCE
+	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/loongarch/include/asm/kgdb.h b/arch/loongarch/include/asm/kgdb.h
new file mode 100644
index 000000000000..df46afe9114a
--- /dev/null
+++ b/arch/loongarch/include/asm/kgdb.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef _ASM_LOONGARCH_KGDB_H
+#define _ASM_LOONGARCH_KGDB_H
+
+#define GDB_SIZEOF_REG		sizeof(u64)
+
+/* gdb remote procotol expects the following register layout. */
+
+/*
+ * General purpose regs:
+ *     r0-r31: 64 bit
+ *     orig_a0: 64 bit
+ *     pc : 64 bit
+ *     csr_badvaddr: 64 bit
+ */
+#define DBG_PT_REGS_BASE	0
+#define DBG_PT_REGS_NUM		35
+#define DBG_PT_REGS_END		(DBG_PT_REGS_BASE + DBG_PT_REGS_NUM - 1)
+
+/*
+ * Floating point regs:
+ *     f0-f31: 64 bit
+ */
+#define DBG_FPR_BASE		(DBG_PT_REGS_END + 1)
+#define DBG_FPR_NUM		32
+#define DBG_FPR_END		(DBG_FPR_BASE + DBG_FPR_NUM - 1)
+
+/*
+ * Condition Flag regs:
+ *     fcc0-fcc8: 1 bit
+ */
+#define DBG_FCC_BASE		(DBG_FPR_END + 1)
+#define DBG_FCC_NUM		8
+#define DBG_FCC_END		(DBG_FCC_BASE + DBG_FCC_NUM - 1)
+
+/*
+ * Floating-point Control and Status reg:
+ *     fcsr: 32 bit
+ */
+#define DBG_FCSR_NUM		1
+#define DBG_FCSR		(DBG_FCC_END + 1)
+
+#define DBG_SCR_BASE		(DBG_FCSR + 1)
+#define DBG_SCR_NUM		4
+#define DBG_SCR_END		(DBG_SCR_BASE + DBG_SCR_NUM - 1)
+
+#define DBG_MAX_REG_NUM		(DBG_SCR_END + 1)
+
+/*
+ * Size of I/O buffer for gdb packet.
+ * considering to hold all register contents, size is set
+ */
+#define BUFMAX			2048
+
+/*
+ * Number of bytes required for gdb_regs buffer.
+ * PT_REGS and FPR: 8 bytes; FCSR: 4 bytes; FCC: 1 bytes.
+ * GDB fails to connect for size beyond this with error
+ * "'g' packet reply is too long"
+ */
+#define NUMREGBYTES		((DBG_PT_REGS_NUM + DBG_FPR_NUM) * sizeof(GDB_SIZEOF_REG) + \
+				1 + DBG_FCSR_NUM * 4)
+
+#define BREAK_INSTR_SIZE	4
+#define CACHE_FLUSH_IS_SAFE	0
+
+/* Register numbers of various important registers. */
+enum dbg_loongarch_regnum {
+	DBG_LOONGARCH_ZERO = 0,
+	DBG_LOONGARCH_RA,
+	DBG_LOONGARCH_TP,
+	DBG_LOONGARCH_SP,
+	DBG_LOONGARCH_A0,
+	DBG_LOONGARCH_FP = 22,
+	DBG_LOONGARCH_S0,
+	DBG_LOONGARCH_S1,
+	DBG_LOONGARCH_S2,
+	DBG_LOONGARCH_S3,
+	DBG_LOONGARCH_S4,
+	DBG_LOONGARCH_S5,
+	DBG_LOONGARCH_S6,
+	DBG_LOONGARCH_S7,
+	DBG_LOONGARCH_S8,
+	DBG_LOONGARCH_ORIG_A0 = 32,
+	DBG_LOONGARCH_PC,
+	DBG_LOONGARCH_BADV = 34,
+	DBG_LOONGARCH_SCR0 = 76,
+	DBG_LOONGARCH_SCR1,
+	DBG_LOONGARCH_SCR2,
+	DBG_LOONGARCH_SCR3 = 79
+};
+
+#ifdef CONFIG_KGDB
+void arch_kgdb_breakpoint(void);
+void kgdb_compiled_break(void);
+bool kgdb_breakpoint_handler(struct pt_regs *regs);
+extern int dbg_kdb_mode;
+#else /* !CONFIG_KGDB */
+static inline bool kgdb_breakpoint_handler(struct pt_regs *regs) { return false; }
+#endif /* CONFIG_KGDB */
+
+#endif /* __ASM_KGDB_H_ */
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 7df80e6ae9d2..4fb1e6408b98 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -158,6 +158,10 @@
 	cfi_st  u0, PT_R21, \docfi
 	csrrd	u0, PERCPU_BASE_KS
 9:
+#ifdef CONFIG_KGDB
+	li.w	t0, CSR_CRMD_WE
+	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
+#endif
 	.endm
 
 	.macro	SAVE_ALL docfi=0
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 6601b6d00738..c44ecd27b52c 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -68,4 +68,6 @@ obj-$(CONFIG_UPROBES)		+= uprobes.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
+obj-$(CONFIG_KGDB)		+= kgdb.o
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index d737e3cf42d3..00654322348e 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -58,6 +58,11 @@ SYM_FUNC_START(handle_syscall)
 
 	SAVE_STATIC
 
+#ifdef CONFIG_KGDB
+	li.w	t1, CSR_CRMD_WE
+	csrxchg	t1, t1, LOONGARCH_CSR_CRMD
+#endif
+
 	move		u0, t0
 	li.d		tp, ~_THREAD_MASK
 	and		tp, tp, sp
diff --git a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kgdb.c
new file mode 100644
index 000000000000..b1c5924c703e
--- /dev/null
+++ b/arch/loongarch/kernel/kgdb.c
@@ -0,0 +1,749 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * LoongArch KGDB support
+ *
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/hw_breakpoint.h>
+#include <linux/kdebug.h>
+#include <linux/kgdb.h>
+#include <linux/processor.h>
+#include <linux/ptrace.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+
+#include <asm/fpu.h>
+#include <asm/hw_breakpoint.h>
+#include <asm/inst.h>
+#include <asm/irq_regs.h>
+#include <asm/ptrace.h>
+#include <asm/sigcontext.h>
+
+int kgdb_watch_activated;
+static unsigned long stepped_address;
+static unsigned int stepped_opcode;
+
+struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
+	{ "r0", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[0]) },
+	{ "r1", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[1]) },
+	{ "r2", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[2]) },
+	{ "r3", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[3]) },
+	{ "r4", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[4]) },
+	{ "r5", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[5]) },
+	{ "r6", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[6]) },
+	{ "r7", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[7]) },
+	{ "r8", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[8]) },
+	{ "r9", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[9]) },
+	{ "r10", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[10]) },
+	{ "r11", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[11]) },
+	{ "r12", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[12]) },
+	{ "r13", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[13]) },
+	{ "r14", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[14]) },
+	{ "r15", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[15]) },
+	{ "r16", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[16]) },
+	{ "r17", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[17]) },
+	{ "r18", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[18]) },
+	{ "r19", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[19]) },
+	{ "r20", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[20]) },
+	{ "r21", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[21]) },
+	{ "r22", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[22]) },
+	{ "r23", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[23]) },
+	{ "r24", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[24]) },
+	{ "r25", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[25]) },
+	{ "r26", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[26]) },
+	{ "r27", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[27]) },
+	{ "r28", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[28]) },
+	{ "r29", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[29]) },
+	{ "r30", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[30]) },
+	{ "r31", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[31]) },
+	{ "orig_a0", GDB_SIZEOF_REG, offsetof(struct pt_regs, orig_a0) },
+	{ "pc", GDB_SIZEOF_REG, offsetof(struct pt_regs, csr_era) },
+	{ "badv", GDB_SIZEOF_REG, offsetof(struct pt_regs, csr_badvaddr) },
+	{ "f0", GDB_SIZEOF_REG, 0 },
+	{ "f1", GDB_SIZEOF_REG, 1 },
+	{ "f2", GDB_SIZEOF_REG, 2 },
+	{ "f3", GDB_SIZEOF_REG, 3 },
+	{ "f4", GDB_SIZEOF_REG, 4 },
+	{ "f5", GDB_SIZEOF_REG, 5 },
+	{ "f6", GDB_SIZEOF_REG, 6 },
+	{ "f7", GDB_SIZEOF_REG, 7 },
+	{ "f8", GDB_SIZEOF_REG, 8 },
+	{ "f9", GDB_SIZEOF_REG, 9 },
+	{ "f10", GDB_SIZEOF_REG, 10 },
+	{ "f11", GDB_SIZEOF_REG, 11 },
+	{ "f12", GDB_SIZEOF_REG, 12 },
+	{ "f13", GDB_SIZEOF_REG, 13 },
+	{ "f14", GDB_SIZEOF_REG, 14 },
+	{ "f15", GDB_SIZEOF_REG, 15 },
+	{ "f16", GDB_SIZEOF_REG, 16 },
+	{ "f17", GDB_SIZEOF_REG, 17 },
+	{ "f18", GDB_SIZEOF_REG, 18 },
+	{ "f19", GDB_SIZEOF_REG, 19 },
+	{ "f20", GDB_SIZEOF_REG, 20 },
+	{ "f21", GDB_SIZEOF_REG, 21 },
+	{ "f22", GDB_SIZEOF_REG, 22 },
+	{ "f23", GDB_SIZEOF_REG, 23 },
+	{ "f24", GDB_SIZEOF_REG, 24 },
+	{ "f25", GDB_SIZEOF_REG, 25 },
+	{ "f26", GDB_SIZEOF_REG, 26 },
+	{ "f27", GDB_SIZEOF_REG, 27 },
+	{ "f28", GDB_SIZEOF_REG, 28 },
+	{ "f29", GDB_SIZEOF_REG, 29 },
+	{ "f30", GDB_SIZEOF_REG, 30 },
+	{ "f31", GDB_SIZEOF_REG, 31 },
+	{ "fcc0", 1, 0 },
+	{ "fcc1", 1, 1 },
+	{ "fcc2", 1, 2 },
+	{ "fcc3", 1, 3 },
+	{ "fcc4", 1, 4 },
+	{ "fcc5", 1, 5 },
+	{ "fcc6", 1, 6 },
+	{ "fcc7", 1, 7 },
+	{ "fcsr", 4, 0 },
+	{ "scr0", GDB_SIZEOF_REG, offsetof(struct loongarch_lbt, scr0) },
+	{ "scr1", GDB_SIZEOF_REG, offsetof(struct loongarch_lbt, scr1) },
+	{ "scr2", GDB_SIZEOF_REG, offsetof(struct loongarch_lbt, scr2) },
+	{ "scr3", GDB_SIZEOF_REG, offsetof(struct loongarch_lbt, scr3) },
+};
+
+int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
+{
+	int reg_offset, reg_size;
+
+	if (regno < 0 || regno >= DBG_MAX_REG_NUM)
+		return -EINVAL;
+
+	reg_offset = dbg_reg_def[regno].offset;
+	reg_size = dbg_reg_def[regno].size;
+
+	if (reg_offset == -1)
+		return 0;
+
+	/* Handle general-purpose/orig_a0/pc/badv registers */
+	if (regno <= DBG_PT_REGS_END) {
+		memcpy((void *)regs + reg_offset, mem, reg_size);
+		return 0;
+	}
+
+	if (!current || !(regs->csr_euen & CSR_EUEN_FPEN))
+		return 0;
+
+	/* Handle FP registers */
+	switch (regno) {
+	case DBG_FCSR:				/* Process the fcsr/fsr */
+		memcpy((void *)&current->thread.fpu.fcsr, mem, reg_size);
+		break;
+	case DBG_FCC_BASE ... DBG_FCC_END:	/* Process the fcc */
+		memcpy((char *)&current->thread.fpu.fcc + reg_offset, mem, reg_size);
+		break;
+	case DBG_SCR_BASE ... DBG_SCR_END:	/* Process the scr */
+		memcpy((void *)&current->thread.lbt.scr0 + reg_offset, mem, reg_size);
+		break;
+	default:
+		memcpy((void *)&current->thread.fpu.fpr[reg_offset], mem, reg_size);
+	}
+
+	restore_fp(current);
+	return 0;
+}
+
+char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
+{
+	int reg_offset, reg_size;
+
+	if (regno < 0 || regno >= DBG_MAX_REG_NUM)
+		return NULL;
+
+	reg_offset = dbg_reg_def[regno].offset;
+	reg_size = dbg_reg_def[regno].size;
+
+	if (reg_offset == -1)
+		goto out;
+
+	/* Handle general-purpose/orig_a0/pc/badv registers */
+	if (regno <= DBG_PT_REGS_END) {
+		memcpy(mem, (void *)regs + reg_offset, reg_size);
+		goto out;
+	}
+
+	if (!current || !(regs->csr_euen & CSR_EUEN_FPEN))
+		goto out;
+
+	save_fp(current);
+
+	/* Handle FP registers */
+	switch (regno) {
+	case DBG_FCSR:				/* Process the fcsr/fsr */
+		memcpy(mem, (void *)&current->thread.fpu.fcsr, reg_size);
+		break;
+	case DBG_FCC_BASE ... DBG_FCC_END:	/* Process the fcc */
+		memcpy(mem, (char *)&current->thread.fpu.fcc + reg_offset, reg_size);
+		break;
+	case DBG_SCR_BASE ... DBG_SCR_END:	/* Process the scr */
+		memcpy(mem, (void *)&current->thread.lbt.scr0 + reg_offset, reg_size);
+		break;
+	default:
+		memcpy(mem, (void *)&current->thread.fpu.fpr[reg_offset], reg_size);
+	}
+
+out:
+	return dbg_reg_def[regno].name;
+}
+
+/*
+ * Similar to regs_to_gdb_regs() except that process is sleeping and so
+ * we may not be able to get all the info.
+ */
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+{
+	/* Initialize to zero */
+	memset((char *)gdb_regs, 0, NUMREGBYTES);
+
+	gdb_regs[DBG_LOONGARCH_RA] = p->thread.reg01;
+	gdb_regs[DBG_LOONGARCH_TP] = (long)p;
+	gdb_regs[DBG_LOONGARCH_SP] = p->thread.reg03;
+
+	/* S0 - S8 */
+	gdb_regs[DBG_LOONGARCH_S0] = p->thread.reg23;
+	gdb_regs[DBG_LOONGARCH_S1] = p->thread.reg24;
+	gdb_regs[DBG_LOONGARCH_S2] = p->thread.reg25;
+	gdb_regs[DBG_LOONGARCH_S3] = p->thread.reg26;
+	gdb_regs[DBG_LOONGARCH_S4] = p->thread.reg27;
+	gdb_regs[DBG_LOONGARCH_S5] = p->thread.reg28;
+	gdb_regs[DBG_LOONGARCH_S6] = p->thread.reg29;
+	gdb_regs[DBG_LOONGARCH_S7] = p->thread.reg30;
+	gdb_regs[DBG_LOONGARCH_S8] = p->thread.reg31;
+
+	/*
+	 * PC
+	 * use return address (RA), i.e. the moment after return from resume()
+	 */
+	gdb_regs[DBG_LOONGARCH_PC] = p->thread.reg01;
+
+	gdb_regs[DBG_LOONGARCH_SCR0] = p->thread.lbt.scr0;
+	gdb_regs[DBG_LOONGARCH_SCR1] = p->thread.lbt.scr1;
+	gdb_regs[DBG_LOONGARCH_SCR2] = p->thread.lbt.scr2;
+	gdb_regs[DBG_LOONGARCH_SCR3] = p->thread.lbt.scr3;
+}
+
+void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
+{
+	regs->csr_era = pc;
+}
+
+void arch_kgdb_breakpoint(void)
+{
+	__asm__ __volatile__ (				\
+		".globl kgdb_compiled_break\n\t"	\
+		"nop\n"					\
+		"kgdb_compiled_break:\tbreak 2\n\t");
+}
+
+/*
+ * Calls linux_debug_hook before the kernel dies. If KGDB is enabled,
+ * then try to fall into the debugger
+ */
+static int kgdb_loongarch_notify(struct notifier_block *self, unsigned long cmd, void *ptr)
+{
+	struct die_args *args = (struct die_args *)ptr;
+	struct pt_regs *regs = args->regs;
+
+	/* Userspace events, ignore. */
+	if (user_mode(regs))
+		return NOTIFY_DONE;
+
+	if (!kgdb_io_module_registered)
+		return NOTIFY_DONE;
+
+	if (atomic_read(&kgdb_active) != -1)
+		kgdb_nmicallback(smp_processor_id(), regs);
+
+	if (kgdb_handle_exception(args->trapnr, args->signr, cmd, regs))
+		return NOTIFY_DONE;
+
+	if (atomic_read(&kgdb_setting_breakpoint))
+		if (regs->csr_era == (unsigned long)&kgdb_compiled_break)
+			regs->csr_era += LOONGARCH_INSN_SIZE;
+
+	return NOTIFY_STOP;
+}
+
+bool kgdb_breakpoint_handler(struct pt_regs *regs)
+{
+	struct die_args args = {
+		.regs	= regs,
+		.str	= "Break",
+		.err	= BRK_KDB,
+		.trapnr = read_csr_excode(),
+		.signr	= SIGTRAP,
+
+	};
+
+	return (kgdb_loongarch_notify(NULL, DIE_TRAP, &args) == NOTIFY_STOP) ? true : false;
+}
+
+static struct notifier_block kgdb_notifier = {
+	.notifier_call = kgdb_loongarch_notify,
+};
+
+static inline void kgdb_arch_update_addr(struct pt_regs *regs,
+					 char *remcom_in_buffer)
+{
+	unsigned long addr;
+	char *ptr;
+
+	ptr = &remcom_in_buffer[1];
+	if (kgdb_hex2long(&ptr, &addr))
+		regs->csr_era = addr;
+}
+
+/* Calculate the new address for after a step */
+static int get_step_address(struct pt_regs *regs, unsigned long *next_addr)
+{
+	unsigned int si, si_l, si_h, rd, rj, cj;
+	char cj_val;
+	unsigned long pc = instruction_pointer(regs);
+	union loongarch_instruction *ip = (union loongarch_instruction *)pc;
+
+	if (pc & 3) {
+		pr_warn("%s: invalid pc 0x%lx\n", __func__, pc);
+		return -EINVAL;
+	}
+
+	*next_addr = pc + LOONGARCH_INSN_SIZE;
+
+	si_h = ip->reg0i26_format.immediate_h;
+	si_l = ip->reg0i26_format.immediate_l;
+	switch (ip->reg0i26_format.opcode) {
+	case b_op:
+		*next_addr = pc + sign_extend64((si_h << 16 | si_l) << 2, 27);
+		return 0;
+	case bl_op:
+		*next_addr = pc + sign_extend64((si_h << 16 | si_l) << 2, 27);
+		regs->regs[1] = pc + LOONGARCH_INSN_SIZE;
+		return 0;
+	}
+
+	si_l = ip->reg1i21_format.immediate_l;
+	si_h = ip->reg1i21_format.immediate_h;
+	rj = ip->reg1i21_format.rj;
+	switch (ip->reg1i21_format.opcode) {
+	case beqz_op:
+		if (regs->regs[rj] == 0)
+			*next_addr = pc + sign_extend64((si_h << 16 | si_l) << 2, 22);
+		return 0;
+	case bnez_op:
+		if (regs->regs[rj] != 0)
+			*next_addr = pc + sign_extend64((si_h << 16 | si_l) << 2, 22);
+		return 0;
+	/* bceqz_op = bcnez_op */
+	case bceqz_op:
+		/* bceqz */
+		if ((rj & 0x18) == 0x00)
+			if (cj_val == 0)
+				*next_addr = pc + sign_extend64((si_h << 16 | si_l) << 2, 22);
+		/* bcnez */
+		if ((rj & 0x18) == 0x08)
+			if (cj_val != 0)
+				*next_addr = pc + sign_extend64((si_h << 16 | si_l) << 2, 22);
+		return 0;
+	}
+
+	si = ip->reg2i16_format.immediate;
+	rj = ip->reg2i16_format.rj;
+	rd = ip->reg2i16_format.rd;
+	switch (ip->reg2i16_format.opcode) {
+	case beq_op:
+		if (regs->regs[rj] == regs->regs[rd])
+			*next_addr = pc + sign_extend64(si << 2, 17);
+		return 0;
+	case bne_op:
+		if (regs->regs[rj] != regs->regs[rd])
+			*next_addr = pc + sign_extend64(si << 2, 17);
+		return 0;
+	case blt_op:
+		if ((long)regs->regs[rj] < (long)regs->regs[rd])
+			*next_addr = pc + sign_extend64(si << 2, 17);
+		return 0;
+	case bge_op:
+		if ((long)regs->regs[rj] >= (long)regs->regs[rd])
+			*next_addr = pc + sign_extend64(si << 2, 17);
+		return 0;
+	case bltu_op:
+		if (regs->regs[rj] < regs->regs[rd])
+			*next_addr = pc + sign_extend64(si << 2, 17);
+		return 0;
+	case bgeu_op:
+		if (regs->regs[rj] >= regs->regs[rd])
+			*next_addr = pc + sign_extend64(si << 2, 17);
+		return 0;
+	case jirl_op:
+		regs->regs[rd] = pc + LOONGARCH_INSN_SIZE;
+		*next_addr = regs->regs[rj] + sign_extend64(si << 2, 17);
+		return 0;
+	}
+
+	return 0;
+}
+
+static int do_single_step(struct pt_regs *regs)
+{
+	/* Determine where the target instruction will send us to */
+	unsigned long addr = 0;
+	int error = 0;
+
+	if (!dbg_kdb_mode)
+		return 0;
+
+	error = get_step_address(regs, &addr);
+	if (error)
+		return error;
+
+	/* Store the opcode in the stepped address */
+	error = get_kernel_nofault(stepped_opcode, (void *)addr);
+	if (error)
+		return error;
+
+	stepped_address = addr;
+
+	/* Replace the opcode with the break instruction */
+	error = copy_to_kernel_nofault((void *)stepped_address,
+				       arch_kgdb_ops.gdb_bpt_instr,
+				       BREAK_INSTR_SIZE);
+
+	/* Flush and return */
+	if (!error) {
+		flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
+		kgdb_single_step = 1;
+		atomic_set(&kgdb_cpu_doing_single_step, raw_smp_processor_id());
+	} else {
+		stepped_address = 0;
+		stepped_opcode = 0;
+	}
+
+	return error;
+}
+
+/* Undo a single step */
+static void undo_single_step(struct pt_regs *regs)
+{
+	if (!dbg_kdb_mode)
+		return;
+
+	if (stepped_opcode != 0) {
+		copy_to_kernel_nofault((void *)stepped_address,
+				       (void *)&stepped_opcode, BREAK_INSTR_SIZE);
+		flush_icache_range(stepped_address,
+				   stepped_address + BREAK_INSTR_SIZE);
+	}
+
+	stepped_address = 0;
+	stepped_opcode = 0;
+	kgdb_single_step = 0;
+	atomic_set(&kgdb_cpu_doing_single_step, -1);
+}
+
+int kgdb_arch_handle_exception(int vector, int signo, int err_code,
+			       char *remcom_in_buffer, char *remcom_out_buffer,
+			       struct pt_regs *regs)
+{
+	int ret = 0;
+
+	undo_single_step(regs);
+
+	regs->csr_prmd |= CSR_PRMD_PWE;
+	switch (remcom_in_buffer[0]) {
+	case 'D':
+	case 'k':
+		regs->csr_prmd &= ~CSR_PRMD_PWE;
+		fallthrough;
+	case 'c':
+		kgdb_arch_update_addr(regs, remcom_in_buffer);
+		break;
+	case 's':
+		kgdb_arch_update_addr(regs, remcom_in_buffer);
+		ret = do_single_step(regs);
+		break;
+	default:
+		ret = -1;
+	}
+
+	return ret;
+}
+
+static struct hw_breakpoint {
+	unsigned int		enabled;
+	unsigned long		addr;
+	int			len;
+	int			type;
+	struct perf_event	* __percpu *pev;
+} breakinfo[LOONGARCH_MAX_BRP];
+
+static int hw_break_reserve_slot(int breakno)
+{
+	int cpu;
+	int cnt = 0;
+	struct perf_event **pevent;
+
+	for_each_online_cpu(cpu) {
+		cnt++;
+		pevent = per_cpu_ptr(breakinfo[breakno].pev, cpu);
+		if (dbg_reserve_bp_slot(*pevent))
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	for_each_online_cpu(cpu) {
+		cnt--;
+		if (!cnt)
+			break;
+		pevent = per_cpu_ptr(breakinfo[breakno].pev, cpu);
+		dbg_release_bp_slot(*pevent);
+	}
+
+	return -1;
+}
+
+static int hw_break_release_slot(int breakno)
+{
+	struct perf_event **pevent;
+	int cpu;
+
+	if (dbg_is_early)
+		return 0;
+
+	for_each_online_cpu(cpu) {
+		pevent = per_cpu_ptr(breakinfo[breakno].pev, cpu);
+		if (dbg_release_bp_slot(*pevent))
+			/*
+			 * The debugger is responsible for handing the retry on
+			 * remove failure.
+			 */
+			return -1;
+	}
+	return 0;
+}
+
+static int kgdb_set_hw_break(unsigned long addr, int len, enum kgdb_bptype bptype)
+{
+	int i;
+
+	for (i = 0; i < LOONGARCH_MAX_BRP; i++)
+		if (!breakinfo[i].enabled)
+			break;
+
+	if (i == LOONGARCH_MAX_BRP)
+		return -1;
+
+	switch (bptype) {
+	case BP_HARDWARE_BREAKPOINT:
+		breakinfo[i].type = HW_BREAKPOINT_X;
+		break;
+	case BP_READ_WATCHPOINT:
+		breakinfo[i].type = HW_BREAKPOINT_R;
+		break;
+	case BP_WRITE_WATCHPOINT:
+		breakinfo[i].type = HW_BREAKPOINT_W;
+		break;
+	case BP_ACCESS_WATCHPOINT:
+		breakinfo[i].type = HW_BREAKPOINT_RW;
+		break;
+	default:
+		return -1;
+	}
+
+	switch (len) {
+	case 1:
+		breakinfo[i].len = HW_BREAKPOINT_LEN_1;
+		break;
+	case 2:
+		breakinfo[i].len = HW_BREAKPOINT_LEN_2;
+		break;
+	case 4:
+		breakinfo[i].len = HW_BREAKPOINT_LEN_4;
+		break;
+	case 8:
+		breakinfo[i].len = HW_BREAKPOINT_LEN_8;
+		break;
+	default:
+		return -1;
+	}
+
+	breakinfo[i].addr = addr;
+	if (hw_break_reserve_slot(i)) {
+		breakinfo[i].addr = 0;
+		return -1;
+	}
+	breakinfo[i].enabled = 1;
+
+	return 0;
+}
+
+static int kgdb_remove_hw_break(unsigned long addr, int len, enum kgdb_bptype bptype)
+{
+	int i;
+
+	for (i = 0; i < LOONGARCH_MAX_BRP; i++)
+		if (breakinfo[i].addr == addr && breakinfo[i].enabled)
+			break;
+
+	if (i == LOONGARCH_MAX_BRP)
+		return -1;
+
+	if (hw_break_release_slot(i)) {
+		pr_err("Cannot remove hw breakpoint at %lx\n", addr);
+		return -1;
+	}
+	breakinfo[i].enabled = 0;
+
+	return 0;
+}
+
+static void kgdb_disable_hw_break(struct pt_regs *regs)
+{
+	int i;
+	int cpu = raw_smp_processor_id();
+	struct perf_event *bp;
+
+	for (i = 0; i < LOONGARCH_MAX_BRP; i++) {
+		if (!breakinfo[i].enabled)
+			continue;
+
+		bp = *per_cpu_ptr(breakinfo[i].pev, cpu);
+		if (bp->attr.disabled == 1)
+			continue;
+
+		arch_uninstall_hw_breakpoint(bp);
+		bp->attr.disabled = 1;
+	}
+
+	/* Disable hardware debugging while we are in kgdb: */
+	csr_xchg32(0, CSR_CRMD_WE, LOONGARCH_CSR_CRMD);
+	regs->csr_prmd &= ~CSR_PRMD_PWE;
+}
+
+static void kgdb_remove_all_hw_break(void)
+{
+	int i;
+	int cpu = raw_smp_processor_id();
+	struct perf_event *bp;
+
+	for (i = 0; i < LOONGARCH_MAX_BRP; i++) {
+		if (!breakinfo[i].enabled)
+			continue;
+
+		bp = *per_cpu_ptr(breakinfo[i].pev, cpu);
+		if (!bp->attr.disabled) {
+			arch_uninstall_hw_breakpoint(bp);
+			bp->attr.disabled = 1;
+			continue;
+		}
+
+		if (hw_break_release_slot(i))
+			pr_err("KGDB: hw bpt remove failed %lx\n", breakinfo[i].addr);
+		breakinfo[i].enabled = 0;
+	}
+
+	csr_xchg32(0, CSR_CRMD_WE, LOONGARCH_CSR_CRMD);
+	kgdb_watch_activated = 0;
+}
+
+static void kgdb_correct_hw_break(void)
+{
+	int i, activated = 0;
+
+	for (i = 0; i < LOONGARCH_MAX_BRP; i++) {
+		struct perf_event *bp;
+		struct arch_hw_breakpoint *info;
+		int val;
+		int cpu = raw_smp_processor_id();
+
+		if (!breakinfo[i].enabled)
+			continue;
+
+		bp = *per_cpu_ptr(breakinfo[i].pev, cpu);
+		info = counter_arch_bp(bp);
+		if (bp->attr.disabled != 1)
+			continue;
+
+		bp->attr.bp_addr = breakinfo[i].addr;
+		bp->attr.bp_len = breakinfo[i].len;
+		bp->attr.bp_type = breakinfo[i].type;
+		info->address = breakinfo[i].addr;
+		info->ctrl.len = breakinfo[i].len;
+		info->ctrl.type = breakinfo[i].type;
+		val = arch_install_hw_breakpoint(bp);
+		if (!val)
+			bp->attr.disabled = 0;
+		activated = 1;
+	}
+
+	csr_xchg32(activated ? CSR_CRMD_WE : 0, CSR_CRMD_WE, LOONGARCH_CSR_CRMD);
+	kgdb_watch_activated = activated;
+}
+
+const struct kgdb_arch arch_kgdb_ops = {
+	.gdb_bpt_instr		= {0x02, 0x00, break_op >> 1, 0x00},
+	.flags			= KGDB_HW_BREAKPOINT,
+	.set_hw_breakpoint	= kgdb_set_hw_break,
+	.remove_hw_breakpoint	= kgdb_remove_hw_break,
+	.disable_hw_break	= kgdb_disable_hw_break,
+	.remove_all_hw_break	= kgdb_remove_all_hw_break,
+	.correct_hw_break	= kgdb_correct_hw_break,
+};
+
+int kgdb_arch_init(void)
+{
+	return register_die_notifier(&kgdb_notifier);
+}
+
+void kgdb_arch_late(void)
+{
+	int i, cpu;
+	struct perf_event_attr attr;
+	struct perf_event **pevent;
+
+	hw_breakpoint_init(&attr);
+
+	attr.bp_addr = (unsigned long)kgdb_arch_init;
+	attr.bp_len = HW_BREAKPOINT_LEN_4;
+	attr.bp_type = HW_BREAKPOINT_W;
+	attr.disabled = 1;
+
+	for (i = 0; i < LOONGARCH_MAX_BRP; i++) {
+		if (breakinfo[i].pev)
+			continue;
+
+		breakinfo[i].pev = register_wide_hw_breakpoint(&attr, NULL, NULL);
+		if (IS_ERR((void * __force)breakinfo[i].pev)) {
+			pr_err("kgdb: Could not allocate hw breakpoints.\n");
+			breakinfo[i].pev = NULL;
+			return;
+		}
+
+		for_each_online_cpu(cpu) {
+			pevent = per_cpu_ptr(breakinfo[i].pev, cpu);
+			if (pevent[0]->destroy) {
+				pevent[0]->destroy = NULL;
+				release_bp_slot(*pevent);
+			}
+		}
+	}
+}
+
+void kgdb_arch_exit(void)
+{
+	int i;
+
+	for (i = 0; i < LOONGARCH_MAX_BRP; i++) {
+		if (breakinfo[i].pev) {
+			unregister_wide_hw_breakpoint(breakinfo[i].pev);
+			breakinfo[i].pev = NULL;
+		}
+	}
+
+	unregister_die_notifier(&kgdb_notifier);
+}
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 6838bea5ab64..c70370a94f61 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -720,6 +720,11 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
 			goto out;
 		else
 			break;
+	case BRK_KDB:
+		if (kgdb_breakpoint_handler(regs))
+			goto out;
+		else
+			break;
 	default:
 		current->thread.trap_nr = read_csr_excode();
 		if (notify_die(DIE_TRAP, "Break", regs, bcode,
@@ -766,6 +771,9 @@ asmlinkage void noinstr do_watch(struct pt_regs *regs)
 #ifndef CONFIG_HAVE_HW_BREAKPOINT
 	pr_warn("Hardware watch point handler not implemented!\n");
 #else
+	if (kgdb_breakpoint_handler(regs))
+		goto out;
+
 	if (test_tsk_thread_flag(current, TIF_SINGLESTEP)) {
 		int llbit = (csr_read32(LOONGARCH_CSR_LLBCTL) & 0x1);
 		unsigned long pc = instruction_pointer(regs);
-- 
2.38.1

