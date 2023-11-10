Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93F67E8032
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjKJSHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbjKJSEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:04:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562A73AE2F;
        Fri, 10 Nov 2023 07:32:33 -0800 (PST)
Date:   Fri, 10 Nov 2023 16:32:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699630350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5pONqvq00ZWF43iaVMB/aICHR3Gy9ZQ2cA4AU79+avw=;
        b=AVSJcxZ0BIrak3EOz0DPbG025+17yvRHntHyW/MInhViNlBEyO9OaVnnxvs/zpkTI1krYe
        UaJkaoTS3DKrJ55tTLZN9Fok/yfr7lAEafLpn/zTEeF7tjiR5BSV48XN2KM9rnqoRakld7
        22cXz0LIroJwob+HpxgfgyH5EA1BYmcBzU4xlaVu+o313u06Mjy9xAPq0oqnF3T15XCzII
        ajh2oPOCKItoo9qL6TBPyTlF7QgvZwZVY/JOD1ZoHHxTjno0rICV2vFoi8upbBRQhLsRNt
        kGHEls9NLSzw2Qt2mbEmMrDmqQzrIEv2ETJGM/T5DfKsCMIy7HRIjObPdU2syw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699630350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5pONqvq00ZWF43iaVMB/aICHR3Gy9ZQ2cA4AU79+avw=;
        b=NI6/hrxldYS+udzE50hjCw5dwcgEOJirkhTXJPk7TpX4ZFMAL8Yds/BDybwfGA0F9nsjhw
        r6iYfZGlUbapU5Aw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.6-rt14
Message-ID: <20231110153229.9CLWVN0E@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.6-rt14 patch set. 

Changes since v6.6-rt13:

  - The kernel test robot reported a compile warning in the !PRINTK
    case. Patch by John Ogness.

  - The PREEMPT_RT patch can be enabled on RiscV. It has been reported
    by a few people that it works without any warnings. Tests by a wider 
    user base is appreciated.

Known issues
     Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
     hist" as trigger. It is not yet understood. The report is at
	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

The delta patch against v6.6-rt13 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/incr/patch-6.6-rt13-rt14.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.6-rt14

The RT patch against v6.6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6-rt14.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patches-6.6-rt14.tar.xz

Sebastian

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9c48fecc67191..ecf9db99a9272 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -48,6 +48,7 @@ config RISCV
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USES_CFI_TRAPS if CFI_CLANG
@@ -135,6 +136,7 @@ config RISCV
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_PREEMPT_DYNAMIC_KEY if !XIP_KERNEL
+	select HAVE_PREEMPT_AUTO
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_RSEQ
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index d0345bd659c94..23fed53b88157 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -30,6 +30,4 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
-void check_unaligned_access(int cpu);
-
 #endif
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 1833beb00489c..c5aebcdafd7b2 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -85,6 +85,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
  * - pending work-to-be-done flags are in lowest half-word
  * - other flags in upper half-word(s)
  */
+#define TIF_ARCH_RESCHED_LAZY	0	/* Lazy rescheduling */
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
@@ -99,6 +100,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
+#define _TIF_ARCH_RESCHED_LAZY	(1 << TIF_ARCH_RESCHED_LAZY)
 
 #define _TIF_WORK_MASK \
 	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1cfbba65d11ae..07c7baac014db 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -8,6 +8,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/cpuhotplug.h>
 #include <linux/ctype.h>
 #include <linux/log2.h>
 #include <linux/memory.h>
@@ -29,6 +30,7 @@
 
 #define MISALIGNED_ACCESS_JIFFIES_LG2 1
 #define MISALIGNED_BUFFER_SIZE 0x4000
+#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
 #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
 
 unsigned long elf_hwcap __read_mostly;
@@ -556,24 +558,19 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
-void check_unaligned_access(int cpu)
+static int check_unaligned_access(void *param)
 {
+	int cpu = smp_processor_id();
 	u64 start_cycles, end_cycles;
 	u64 word_cycles;
 	u64 byte_cycles;
 	int ratio;
 	unsigned long start_jiffies, now;
-	struct page *page;
+	struct page *page = param;
 	void *dst;
 	void *src;
 	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
 
-	page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
-	if (!page) {
-		pr_warn("Can't alloc pages to measure memcpy performance");
-		return;
-	}
-
 	/* Make an unaligned destination buffer. */
 	dst = (void *)((unsigned long)page_address(page) | 0x1);
 	/* Unalign src as well, but differently (off by 1 + 2 = 3). */
@@ -626,7 +623,7 @@ void check_unaligned_access(int cpu)
 		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
 			cpu);
 
-		goto out;
+		return 0;
 	}
 
 	if (word_cycles < byte_cycles)
@@ -640,18 +637,83 @@ void check_unaligned_access(int cpu)
 		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
 
 	per_cpu(misaligned_access_speed, cpu) = speed;
-
-out:
-	__free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
-}
-
-static int check_unaligned_access_boot_cpu(void)
-{
-	check_unaligned_access(0);
 	return 0;
 }
 
-arch_initcall(check_unaligned_access_boot_cpu);
+static void check_unaligned_access_nonboot_cpu(void *param)
+{
+	unsigned int cpu = smp_processor_id();
+	struct page **pages = param;
+
+	if (smp_processor_id() != 0)
+		check_unaligned_access(pages[cpu]);
+}
+
+static int riscv_online_cpu(unsigned int cpu)
+{
+	static struct page *buf;
+
+	/* We are already set since the last check */
+	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
+		return 0;
+
+	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
+	if (!buf) {
+		pr_warn("Allocation failure, not measuring misaligned performance\n");
+		return -ENOMEM;
+	}
+
+	check_unaligned_access(buf);
+	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
+	return 0;
+}
+
+/* Measure unaligned access on all CPUs present at boot in parallel. */
+static int check_unaligned_access_all_cpus(void)
+{
+	unsigned int cpu;
+	unsigned int cpu_count = num_possible_cpus();
+	struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
+				     GFP_KERNEL);
+
+	if (!bufs) {
+		pr_warn("Allocation failure, not measuring misaligned performance\n");
+		return 0;
+	}
+
+	/*
+	 * Allocate separate buffers for each CPU so there's no fighting over
+	 * cache lines.
+	 */
+	for_each_cpu(cpu, cpu_online_mask) {
+		bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
+		if (!bufs[cpu]) {
+			pr_warn("Allocation failure, not measuring misaligned performance\n");
+			goto out;
+		}
+	}
+
+	/* Check everybody except 0, who stays behind to tend jiffies. */
+	on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
+
+	/* Check core 0. */
+	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
+
+	/* Setup hotplug callback for any new CPUs that come online. */
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
+				  riscv_online_cpu, NULL);
+
+out:
+	for_each_cpu(cpu, cpu_online_mask) {
+		if (bufs[cpu])
+			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
+	}
+
+	kfree(bufs);
+	return 0;
+}
+
+arch_initcall(check_unaligned_access_all_cpus);
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
 /*
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 1b8da4e40a4d6..2cb5e651412cb 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -246,7 +246,6 @@ asmlinkage __visible void smp_callin(void)
 
 	numa_add_cpu(curr_cpuid);
 	set_cpu_online(curr_cpuid, 1);
-	check_unaligned_access(curr_cpuid);
 
 	if (has_vector()) {
 		if (riscv_v_setup_vsize())
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index db8329091bb82..a3ae0710346cd 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -178,7 +178,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
-enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
+static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_all(void) { }
 static bool nbcon_atomic_emit_next_record(struct console *con) { return false; }
 
diff --git a/localversion-rt b/localversion-rt
index 9f7d0bdbffb18..08b3e75841adc 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14
