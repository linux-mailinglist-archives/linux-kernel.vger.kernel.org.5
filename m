Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E499878D9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjH3Se4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243321AbjH3Kkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:40:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270A31BB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:40:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693392047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r8b7q01/CSji9EDx9SVhYs9VQunuFz6x42iSDbWHg+U=;
        b=mlZff6Sot6+6Wnvea1gTgRa9azbi8amZvwqdkTfKJB4TowAJ3cggIn5+Ch0+l0vwXcKgsu
        xIApiuuf+MpcvfhR+Gk6Tua0i4/5HgRXSnm22PHKqcNU46GS9wCCOiUEDh6Y/p5PjkIp62
        7rV/p9uqOHrKxkYZ6YWtQfNzUpDpGmWdX49sz+5cvQ+BUr7q36/3MGf9URm9s0Ugw8irYd
        JFa4PDj49blAYpbPmODF1/CUaJtyOC4lcrUILu01d91Hq+8EcHYpJc8xp5eUIOmzQapCa7
        eid3pQ1BOXbOdPASDBhIh2ZysMqgTFVCAzOqTy+3L9zJIe/t7XMukB1oRwrNEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693392047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r8b7q01/CSji9EDx9SVhYs9VQunuFz6x42iSDbWHg+U=;
        b=swi7EmPkDjV9Nf5ZO540VDNguwhZbwoeIwrLgqGmzLVO7SQ0aDI2oiwwVDV8F739qwexHG
        IWwpWpMNO2o7o0DQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/core for v6.6-rc1
Message-ID: <169339202558.475946.15795543318941920393.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Wed, 30 Aug 2023 12:40:46 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-08=
-30

up to:  029239c5b0e6: x86/retpoline,kprobes: Skip optprobe check for indirect=
 jumps with retpolines and IBT


X86 core updates:

  - Prevent kprobes on compiler generated CFI checking code.

    The compiler generates a instruction sequence for indirect call
    checks. If this sequence is modified with a kprobe, then the check
    fails. So the instructions must be protected against probing.

  - Fix the linker script so CLANG LTO does not merge thunk sections into
    the general .text section.

  - Skip indirect jump limitations for optimized kprobes when the kernel is
    built with retpolines or IBT.

    The indirect jump check prevents optimize kprobes to prevent that an
    indirect jump which originates from a jump table ends up in the middle
    of the optimized probe.

    Retpoline and IBT enabled builds disable jump table generation, so the
    check ends up searching for a non-existing problem

  - A few minor cleanups for the SMP code

Thanks,

	tglx

------------------>
Masami Hiramatsu (1):
      x86/kprobes: Prohibit probing on compiler generated CFI checking code

Petr Pavlu (2):
      x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_C=
LANG
      x86/retpoline,kprobes: Skip optprobe check for indirect jumps with retp=
olines and IBT

Sohil Mehta (3):
      x86/smpboot: Remove a stray comment about CPU hotplug
      x86/smp: Remove a non-existent function declaration
      x86/smpboot: Change smp_store_boot_cpu_info() to static


 arch/x86/include/asm/nospec-branch.h |  3 ---
 arch/x86/include/asm/smp.h           |  3 ---
 arch/x86/kernel/kprobes/core.c       | 34 ++++++++++++++++++++++++++++++
 arch/x86/kernel/kprobes/opt.c        | 40 +++++++++++++++-------------------=
--
 arch/x86/kernel/smpboot.c            |  6 ++----
 arch/x86/kernel/vmlinux.lds.S        |  4 +---
 arch/x86/lib/retpoline.S             |  4 ++--
 include/linux/cfi.h                  |  4 +++-
 tools/objtool/check.c                |  2 +-
 tools/perf/util/thread-stack.c       |  4 +---
 10 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nosp=
ec-branch.h
index 1a65cf4acb2b..db460e610a17 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -465,9 +465,6 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_SECCOMP,
 };
=20
-extern char __indirect_thunk_start[];
-extern char __indirect_thunk_end[];
-
 static __always_inline
 void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
 {
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 600cf25dbfc6..cf7217ad5701 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -132,11 +132,8 @@ void smp_kick_mwait_play_dead(void);
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
-void x86_idle_thread_init(unsigned int cpu, struct task_struct *idle);
=20
 bool smp_park_other_cpus_in_init(void);
-
-void smp_store_boot_cpu_info(void);
 void smp_store_cpu_info(int id);
=20
 asmlinkage __visible void smp_reboot_interrupt(void);
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index f7f6042eb7e6..e8babebad7b8 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -45,6 +45,7 @@
 #include <linux/vmalloc.h>
 #include <linux/pgtable.h>
 #include <linux/set_memory.h>
+#include <linux/cfi.h>
=20
 #include <asm/text-patching.h>
 #include <asm/cacheflush.h>
@@ -293,7 +294,40 @@ static int can_probe(unsigned long paddr)
 #endif
 		addr +=3D insn.length;
 	}
+	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
+		/*
+		 * The compiler generates the following instruction sequence
+		 * for indirect call checks and cfi.c decodes this;
+		 *
+		 *=C2=A0  movl    -<id>, %r10d       ; 6 bytes
+		 *   addl    -4(%reg), %r10d    ; 4 bytes
+		 *   je      .Ltmp1             ; 2 bytes
+		 *   ud2                        ; <- regs->ip
+		 *   .Ltmp1:
+		 *
+		 * Also, these movl and addl are used for showing expected
+		 * type. So those must not be touched.
+		 */
+		__addr =3D recover_probed_instruction(buf, addr);
+		if (!__addr)
+			return 0;
+
+		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
+			return 0;
+
+		if (insn.opcode.value =3D=3D 0xBA)
+			offset =3D 12;
+		else if (insn.opcode.value =3D=3D 0x3)
+			offset =3D 6;
+		else
+			goto out;
+
+		/* This movl/addl is used for decoding CFI. */
+		if (is_cfi_trap(addr + offset))
+			return 0;
+	}
=20
+out:
 	return (addr =3D=3D paddr);
 }
=20
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 57b0037d0a99..517821b48391 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -226,7 +226,7 @@ static int copy_optimized_instructions(u8 *dest, u8 *src,=
 u8 *real)
 }
=20
 /* Check whether insn is indirect jump */
-static int __insn_is_indirect_jump(struct insn *insn)
+static int insn_is_indirect_jump(struct insn *insn)
 {
 	return ((insn->opcode.bytes[0] =3D=3D 0xff &&
 		(X86_MODRM_REG(insn->modrm.value) & 6) =3D=3D 4) || /* Jump */
@@ -260,26 +260,6 @@ static int insn_jump_into_range(struct insn *insn, unsig=
ned long start, int len)
 	return (start <=3D target && target <=3D start + len);
 }
=20
-static int insn_is_indirect_jump(struct insn *insn)
-{
-	int ret =3D __insn_is_indirect_jump(insn);
-
-#ifdef CONFIG_RETPOLINE
-	/*
-	 * Jump to x86_indirect_thunk_* is treated as an indirect jump.
-	 * Note that even with CONFIG_RETPOLINE=3Dy, the kernel compiled with
-	 * older gcc may use indirect jump. So we add this check instead of
-	 * replace indirect-jump check.
-	 */
-	if (!ret)
-		ret =3D insn_jump_into_range(insn,
-				(unsigned long)__indirect_thunk_start,
-				(unsigned long)__indirect_thunk_end -
-				(unsigned long)__indirect_thunk_start);
-#endif
-	return ret;
-}
-
 /* Decode whole function to ensure any instructions don't jump into target */
 static int can_optimize(unsigned long paddr)
 {
@@ -334,9 +314,21 @@ static int can_optimize(unsigned long paddr)
 		/* Recover address */
 		insn.kaddr =3D (void *)addr;
 		insn.next_byte =3D (void *)(addr + insn.length);
-		/* Check any instructions don't jump into target */
-		if (insn_is_indirect_jump(&insn) ||
-		    insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
+		/*
+		 * Check any instructions don't jump into target, indirectly or
+		 * directly.
+		 *
+		 * The indirect case is present to handle a code with jump
+		 * tables. When the kernel uses retpolines, the check should in
+		 * theory additionally look for jumps to indirect thunks.
+		 * However, the kernel built with retpolines or IBT has jump
+		 * tables disabled so the check can be skipped altogether.
+		 */
+		if (!IS_ENABLED(CONFIG_RETPOLINE) &&
+		    !IS_ENABLED(CONFIG_X86_KERNEL_IBT) &&
+		    insn_is_indirect_jump(&insn))
+			return 0;
+		if (insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
 					 DISP32_SIZE))
 			return 0;
 		addr +=3D insn.length;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e1aa2cd7734b..28c590b4b1b1 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -422,7 +422,7 @@ int topology_update_die_map(unsigned int die, unsigned in=
t cpu)
 	return 0;
 }
=20
-void __init smp_store_boot_cpu_info(void)
+static void __init smp_store_boot_cpu_info(void)
 {
 	int id =3D 0; /* CPU 0 */
 	struct cpuinfo_x86 *c =3D &cpu_data(id);
@@ -1614,9 +1614,7 @@ void play_dead_common(void)
 	idle_task_exit();
=20
 	cpuhp_ap_report_dead();
-	/*
-	 * With physical CPU hotplug, we should halt the cpu
-	 */
+
 	local_irq_disable();
 }
=20
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 03c885d3640f..dd5b0a68cf84 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -133,9 +133,7 @@ SECTIONS
 		KPROBES_TEXT
 		SOFTIRQENTRY_TEXT
 #ifdef CONFIG_RETPOLINE
-		__indirect_thunk_start =3D .;
-		*(.text.__x86.*)
-		__indirect_thunk_end =3D .;
+		*(.text..__x86.*)
 #endif
 		STATIC_CALL_TEXT
=20
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 3fd066d42ec0..3bea96341d00 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -12,7 +12,7 @@
 #include <asm/percpu.h>
 #include <asm/frame.h>
=20
-	.section .text.__x86.indirect_thunk
+	.section .text..__x86.indirect_thunk
=20
=20
 .macro POLINE reg
@@ -131,7 +131,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  */
 #ifdef CONFIG_RETHUNK
=20
-	.section .text.__x86.return_thunk
+	.section .text..__x86.return_thunk
=20
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 5e134f4ce8b7..3552ec82b725 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -19,11 +19,13 @@ static inline enum bug_trap_type report_cfi_failure_noadd=
r(struct pt_regs *regs,
 {
 	return report_cfi_failure(regs, addr, NULL, 0);
 }
+#endif /* CONFIG_CFI_CLANG */
=20
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
 bool is_cfi_trap(unsigned long addr);
+#else
+static inline bool is_cfi_trap(unsigned long addr) { return false; }
 #endif
-#endif /* CONFIG_CFI_CLANG */
=20
 #ifdef CONFIG_MODULES
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8936a05f0e5a..e096eb325acd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -389,7 +389,7 @@ static int decode_instructions(struct objtool_file *file)
 		if (!strcmp(sec->name, ".noinstr.text") ||
 		    !strcmp(sec->name, ".entry.text") ||
 		    !strcmp(sec->name, ".cpuidle.text") ||
-		    !strncmp(sec->name, ".text.__x86.", 12))
+		    !strncmp(sec->name, ".text..__x86.", 12))
 			sec->noinstr =3D true;
=20
 		/*
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 374d142e7390..c6a0a27b12c2 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -1038,9 +1038,7 @@ static int thread_stack__trace_end(struct thread_stack =
*ts,
=20
 static bool is_x86_retpoline(const char *name)
 {
-	const char *p =3D strstr(name, "__x86_indirect_thunk_");
-
-	return p =3D=3D name || !strcmp(name, "__indirect_thunk_start");
+	return strstr(name, "__x86_indirect_thunk_") =3D=3D name;
 }
=20
 /*

