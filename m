Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788DF78DDFC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbjH3S4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244603AbjH3N1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:27:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F3D137
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:27:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693402026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uv6OYWY0nm1PUIFRYH+6I4631UZPqwdrqQwv+spjLMU=;
        b=ZYyJ5C+O53DaCqYMddolXPDB4+lzKuIjc+h55b3QPs01lNwQ07Y9xJqu249Ce4iLvN9sDK
        L2OKzu/v1tXHlFDsXeIjwIsWbn5wAIBuEvCu1/+9cF7wQiqsJDHbwJL6i1hL3X5ZV/88yN
        kv2xghyXKhoOIkLXKVU07qiRO+1ztckncZNVmyTeF1IXFKYyYAS8aFM/Ur/FslB2gVR4Ww
        q7RtPFLxz3IR4ALQ9DaFCz34pDUheaU/FlC0Uumldc7S/P2foLECcBTiVnfWzZArz/xdHe
        Hh27nv+FPXjaV3j7f6aJRUkGB2m/I2gUqjnLeqM7griV2H0Nc92NUuS0FUV7jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693402026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uv6OYWY0nm1PUIFRYH+6I4631UZPqwdrqQwv+spjLMU=;
        b=t64J0lZGWReNgTa7VD9SLvuBU7rYWV/haRNse47QRYZHMV903trbG6L75LDRDIFD9QRqnr
        zeFwjyvApRrAKLBw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull V2] x86/core for v6.6-rc1
Message-ID: <169340012555.478565.16044726088347432378.tglx@xen13.tec.linutronix.de>
References: <169339202558.475946.15795543318941920393.tglx@xen13>
In-Reply-To: <169339202558.475946.15795543318941920393.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Wed, 30 Aug 2023 15:27:05 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-08=
-30-v2

up to:  b65413768abd: x86/kprobes: Prohibit probing on compiler generated CFI=
 checking code


X86 core updates:

  - Prevent kprobes on compiler generated CFI checking code.

    The compiler generates a instruction sequence for indirect call
    checks. If this sequence is modified with a kprobe, then the check
    fails. So the instructions must be protected against probing.

  - A few minor cleanups for the SMP code

Thanks,

	tglx

Thanks,

	tglx

------------------>
Masami Hiramatsu (1):
      x86/kprobes: Prohibit probing on compiler generated CFI checking code

Sohil Mehta (3):
      x86/smpboot: Remove a stray comment about CPU hotplug
      x86/smp: Remove a non-existent function declaration
      x86/smpboot: Change smp_store_boot_cpu_info() to static


 arch/x86/include/asm/smp.h     |  3 ---
 arch/x86/kernel/kprobes/core.c | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c      |  6 ++----
 include/linux/cfi.h            |  4 +++-
 4 files changed, 39 insertions(+), 8 deletions(-)

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

