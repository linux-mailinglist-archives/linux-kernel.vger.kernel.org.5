Return-Path: <linux-kernel+bounces-89482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A2286F0EC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD651C20CD5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EDF1864A;
	Sat,  2 Mar 2024 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ziSldsjq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V40k6IqK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4415EA2;
	Sat,  2 Mar 2024 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709394283; cv=none; b=eOjvtL4b0afQdIQ1fuUpkLmAmrfz4k77Iokyi7jqIVsW7TmPizsnnlCwnx0Gt4zg/43H+ZDhKjGhF7G8yLCGYw5ufyFQwlVI8ehCrzjVIbnkiJfy6oBWn/IGw9oD4oxDZSmzmbW+rd+peYPJsNPOXXONNrV9/3G3Z5dU6voyBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709394283; c=relaxed/simple;
	bh=TskC+2UB4/YKNGUUx8m0F58Sby2AwZxAK0fNnFdkKTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GMktnt2/cD58Kcd8h9dNVTDygO9lvmJRRPly9mDdujvBmHi3cIcM4z75TZe0Sq8OnOuAr4t15VTMfbbnbY9gJ3YFUUlCfxg7G8khG5YsEOosDc6XE8FSUYRQtkwA/Q2IS4hWtWrzZOGxYpXk/xXnB+MNOWyii658mjjBWEy7rfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ziSldsjq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V40k6IqK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709394278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEk0nhqpXzWPv87Fil6HUhoXoeaUFEg75KKKSeUcIrU=;
	b=ziSldsjq4RibzYhyYPfUEKLTXyMDsi2oNbAzeBIn6zW8Hi5r22wOSwq4RYAU5S9bzXSLjj
	qO1VyV23Cje6Q7uYmZgspqA7G/+ChU9UZYfwZDum7CZlnbqlwcBdIiosVnls5o/HP8Ri+q
	iN3tLKxKx8zjTq985J26MJyXeFjoFZBYOzEPfHnon0+Sl3iU8dGkoCePkb8OVKEz92Uooj
	lH/YwtUBg+cz8zoLGxAaBFHMBKSVkPQeYOf4P6DnqJ71uSK2S/yXcC2zuqOQpblVbylv9E
	a8eDoznn0We5QrkA9KNDBn4C0emC+YX3RmbZ95qW+B2AnvaMuqwtjrHN8aErqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709394278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEk0nhqpXzWPv87Fil6HUhoXoeaUFEg75KKKSeUcIrU=;
	b=V40k6IqK/LDIFwaAQIRSKvKxWLymsJyi9ZQ0wKnFy8hfbsA4TjlyaaTnr/m0gVptr7sACa
	TyWM8qhpRNCEy6Aw==
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Arjan van
 de Ven <arjan@linux.intel.com>, x86@kernel.org, "Luc Van Oostenryck"
 <luc.vanoostenryck@gmail.com>, Sparse Mailing-list
 <linux-sparse@vger.kernel.org>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
In-Reply-To: <87y1b0vp8m.ffs@tglx>
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx>
Date: Sat, 02 Mar 2024 16:44:37 +0100
Message-ID: <87sf18vdsq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 02 2024 at 12:37, Thomas Gleixner wrote:
> Bah. sparse is actually right. I completely missed the fact that this is
> an UP build which has:
>
> extern struct cpuinfo_x86	boot_cpu_data;
>
> #define cpu_info		boot_cpu_data
>
> So any access with this_cpu*(), per_cpu*() etc. is actually incorrect from
> sparse's point of view.
>
> From a compiler point of view it just works because __percpu dissolves
> and the whole thing produces correct code magically.
>
> Most places in x86 use cpu_data(cpu) to access per cpu data which is
> defined as per_cpu(cpu_info, cpu) for SMP and boot_cpu_info for UP.
>
> That's fine, but there are places like the MCE code which really needs
> raw_cpu_ptr(). Sure we can write ugly wrappers for that and for some
> other accessors. But that's all just wrong and ugly.
>
> The proper solution would be to force SMP for x86, but Linus shot it
> down when I wanted to do that last time.
>
> Let me think about it.

The below addresses _all_ percpu related sparse warnings except
the ones in arch/x86/cpu/bugs.o but that's a sparse problem:

   The following is handled correctly:

	DECLARE_PER_CPU(u64, foo);
	this_cpu_read(foo);

   But this is not:

	DECLARE_PER_CPU(u64, foo);
	DEFINE_PER_CPU(u64, foo);
	this_cpu_read(foo);

arch/x86/kernel/cpu/bugs.c:71:9: sparse: warning: incorrect type in initializer (different address spaces)
arch/x86/kernel/cpu/bugs.c:71:9: sparse:    expected void const [noderef] __percpu *__vpp_verify
arch/x86/kernel/cpu/bugs.c:71:9: sparse:    got unsigned long long *

Commenting out the DEFINE_PER_CPU(u64, x86_spec_ctrl_current) in that
file makes sparse happy, but that's obviously not a solution :)

This problem is unrelated to the UP cpu_info issue, which made me look
at this mess in the first place. It happens on SMP too and both on 32
and 64 bit.

The other __percpu related sparse warnings are valid.

  - The UP cpu_info mechanics are just a horrible hackery.

    The cure is to "waste" one 'struct cpu_info' size of memory and
    provide the per CPU cpu_info in the same way as on SMP with
    DEFINE_PER_CPU() and copy the boot_cpu_data over at the same point
    in the boot process.

    With that the unholy #define hack goes away and _all_ per CPU
    accessors can now be used. That allows to get rid of the cpu_data()
    indirection which is just annoying for SMP because it creates
    suboptimal code.

  - smp-msr and amd uncore lack __percpu annotations in data structures
    and function arguments. That's not UP specific and just plain wrong.

While at it I fixed also the valid_user_address() complaint which lacks
a __force in the type cast.

The UP muck is only compiled and not boot tested. There might be a few
things which need to be adjusted, but from a quick scan I did not see
anything obvious.

I'll go and split it up into reviewable chunks and actually test UP
unless someone beats me to it and is brave enough to give the below a
test ride.

Thanks,

        tglx
---
 arch/alpha/kernel/smp.c           |    5 -----
 arch/arc/kernel/smp.c             |    5 -----
 arch/csky/kernel/smp.c            |    4 ----
 arch/hexagon/kernel/smp.c         |    4 ----
 arch/openrisc/kernel/smp.c        |    4 ----
 arch/riscv/kernel/smpboot.c       |    4 ----
 arch/sparc/kernel/smp_64.c        |    4 ----
 arch/x86/events/amd/uncore.c      |    2 +-
 arch/x86/include/asm/desc.h       |    4 ++--
 arch/x86/include/asm/msr.h        |   20 ++++++++++----------
 arch/x86/include/asm/processor.h  |    5 -----
 arch/x86/include/asm/smp.h        |    5 -----
 arch/x86/include/asm/uaccess_64.h |    2 +-
 arch/x86/kernel/setup.c           |   13 +++++++++++++
 arch/x86/kernel/smpboot.c         |    5 +++++
 arch/x86/lib/msr-smp.c            |    9 ++++-----
 arch/x86/lib/msr.c                |    2 +-
 include/linux/smp.h               |   13 ++++++-------
 init/main.c                       |    4 ++++
 19 files changed, 47 insertions(+), 67 deletions(-)

--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -467,11 +467,6 @@ smp_prepare_cpus(unsigned int max_cpus)
 	smp_num_cpus = smp_num_probed;
 }
 
-void
-smp_prepare_boot_cpu(void)
-{
-}
-
 int
 __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -39,11 +39,6 @@ struct plat_smp_ops  __weak plat_smp_ops
 /* XXX: per cpu ? Only needed once in early secondary boot */
 struct task_struct *secondary_idle_tsk;
 
-/* Called from start_kernel */
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 static int __init arc_get_cpu_map(const char *name, struct cpumask *cpumask)
 {
 	unsigned long dt_root = of_get_flat_dt_root();
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -152,10 +152,6 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 }
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -114,10 +114,6 @@ void send_ipi(const struct cpumask *cpum
 	local_irq_restore(flags);
 }
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 /*
  * interrupts should already be disabled from the VM
  * SP should already be correct; need to set THREADINFO_REG
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -57,10 +57,6 @@ static void boot_secondary(unsigned int
 	spin_unlock(&boot_lock);
 }
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_init_cpus(void)
 {
 	struct device_node *cpu;
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -42,10 +42,6 @@
 
 static DECLARE_COMPLETION(cpu_running);
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpuid;
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1206,10 +1206,6 @@ void __init smp_prepare_cpus(unsigned in
 {
 }
 
-void smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_setup_processor_id(void)
 {
 	if (tlb_type == spitfire)
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -71,7 +71,7 @@ union amd_uncore_info {
 };
 
 struct amd_uncore {
-	union amd_uncore_info * __percpu info;
+	union amd_uncore_info  __percpu *info;
 	struct amd_uncore_pmu *pmus;
 	unsigned int num_pmus;
 	bool init_done;
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -51,13 +51,13 @@ DECLARE_INIT_PER_CPU(gdt_page);
 /* Provide the original GDT */
 static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
 {
-	return per_cpu(gdt_page, cpu).gdt;
+	return per_cpu(gdt_page.gdt, cpu);
 }
 
 /* Provide the current original GDT */
 static inline struct desc_struct *get_current_gdt_rw(void)
 {
-	return this_cpu_ptr(&gdt_page)->gdt;
+	return this_cpu_ptr(gdt_page.gdt);
 }
 
 /* Provide the fixmap address of the remapped GDT */
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -13,10 +13,10 @@
 #include <asm/shared/msr.h>
 
 struct msr_info {
-	u32 msr_no;
-	struct msr reg;
-	struct msr *msrs;
-	int err;
+	u32			msr_no;
+	struct msr		reg;
+	struct msr __percpu	*msrs;
+	int			err;
 };
 
 struct msr_regs_info {
@@ -315,8 +315,8 @@ int rdmsr_on_cpu(unsigned int cpu, u32 m
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
-void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs);
-void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs);
+void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
+void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
@@ -345,14 +345,14 @@ static inline int wrmsrl_on_cpu(unsigned
 	return 0;
 }
 static inline void rdmsr_on_cpus(const struct cpumask *m, u32 msr_no,
-				struct msr *msrs)
+				struct msr __percpu *msrs)
 {
-	rdmsr_on_cpu(0, msr_no, &(msrs[0].l), &(msrs[0].h));
+	rdmsr_on_cpu(0, msr_no, this_cpu_ptr(&msrs->l), this_cpu_ptr(&msrs->h));
 }
 static inline void wrmsr_on_cpus(const struct cpumask *m, u32 msr_no,
-				struct msr *msrs)
+				struct msr __percpu *msrs)
 {
-	wrmsr_on_cpu(0, msr_no, msrs[0].l, msrs[0].h);
+	wrmsr_on_cpu(0, msr_no, this_cpu_read(msrs->l), this_cpu_read(msrs->h));
 }
 static inline int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no,
 				    u32 *l, u32 *h)
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -186,13 +186,8 @@ extern struct cpuinfo_x86	new_cpu_data;
 extern __u32			cpu_caps_cleared[NCAPINTS + NBUGINTS];
 extern __u32			cpu_caps_set[NCAPINTS + NBUGINTS];
 
-#ifdef CONFIG_SMP
 DECLARE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 #define cpu_data(cpu)		per_cpu(cpu_info, cpu)
-#else
-#define cpu_info		boot_cpu_data
-#define cpu_data(cpu)		boot_cpu_data
-#endif
 
 extern const struct seq_operations cpuinfo_op;
 
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -59,11 +59,6 @@ static inline void stop_other_cpus(void)
 	smp_ops.stop_other_cpus(1);
 }
 
-static inline void smp_prepare_boot_cpu(void)
-{
-	smp_ops.smp_prepare_boot_cpu();
-}
-
 static inline void smp_prepare_cpus(unsigned int max_cpus)
 {
 	smp_ops.smp_prepare_cpus(max_cpus);
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -54,7 +54,7 @@ static inline unsigned long __untagged_a
  * half and a user half.  When cast to a signed type, user pointers
  * are positive and kernel pointers are negative.
  */
-#define valid_user_address(x) ((long)(x) >= 0)
+#define valid_user_address(x) ((__force long)(x) >= 0)
 
 /*
  * User pointers can have tag bits on x86-64.  This scheme tolerates
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1211,6 +1211,19 @@ void __init i386_reserve_resources(void)
 
 #endif /* CONFIG_X86_32 */
 
+#ifndef CONFIG_SMP
+DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
+EXPORT_PER_CPU_SYMBOL(cpu_info);
+
+void __init smp_prepare_boot_cpu(void)
+{
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	*c = boot_cpu_data;
+	c->initialized = true;
+}
+#endif
+
 static struct notifier_block kernel_offset_notifier = {
 	.notifier_call = dump_kernel_offset
 };
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1187,6 +1187,11 @@ void __init smp_prepare_cpus_common(void
 	set_cpu_sibling_map(0);
 }
 
+void __init smp_prepare_boot_cpu(void)
+{
+	smp_ops.smp_prepare_boot_cpu();
+}
+
 #ifdef CONFIG_X86_64
 /* Establish whether parallel bringup can be supported. */
 bool __init arch_cpuhp_init_parallel_bringup(void)
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -9,10 +9,9 @@ static void __rdmsr_on_cpu(void *info)
 {
 	struct msr_info *rv = info;
 	struct msr *reg;
-	int this_cpu = raw_smp_processor_id();
 
 	if (rv->msrs)
-		reg = per_cpu_ptr(rv->msrs, this_cpu);
+		reg = this_cpu_ptr(rv->msrs);
 	else
 		reg = &rv->reg;
 
@@ -97,7 +96,7 @@ int wrmsrl_on_cpu(unsigned int cpu, u32
 EXPORT_SYMBOL(wrmsrl_on_cpu);
 
 static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
-			    struct msr *msrs,
+			    struct msr __percpu *msrs,
 			    void (*msr_func) (void *info))
 {
 	struct msr_info rv;
@@ -124,7 +123,7 @@ static void __rwmsr_on_cpus(const struct
  * @msrs:       array of MSR values
  *
  */
-void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs)
+void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs)
 {
 	__rwmsr_on_cpus(mask, msr_no, msrs, __rdmsr_on_cpu);
 }
@@ -138,7 +137,7 @@ EXPORT_SYMBOL(rdmsr_on_cpus);
  * @msrs:       array of MSR values
  *
  */
-void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs)
+void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs)
 {
 	__rwmsr_on_cpus(mask, msr_no, msrs, __wrmsr_on_cpu);
 }
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -8,7 +8,7 @@
 
 struct msr *msrs_alloc(void)
 {
-	struct msr *msrs = NULL;
+	struct msr __percpu *msrs = NULL;
 
 	msrs = alloc_percpu(struct msr);
 	if (!msrs) {
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -105,6 +105,12 @@ static inline void on_each_cpu_cond(smp_
 	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
 }
 
+/*
+ * Architecture specific boot CPU setup.  Defined as empty weak function in
+ * init/main.c. Architectures can override it.
+ */
+void smp_prepare_boot_cpu(void);
+
 #ifdef CONFIG_SMP
 
 #include <linux/preempt.h>
@@ -171,12 +177,6 @@ void generic_smp_call_function_single_in
 #define generic_smp_call_function_interrupt \
 	generic_smp_call_function_single_interrupt
 
-/*
- * Mark the boot cpu "online" so that it can call console drivers in
- * printk() and can access its per-cpu storage.
- */
-void smp_prepare_boot_cpu(void);
-
 extern unsigned int setup_max_cpus;
 extern void __init setup_nr_cpu_ids(void);
 extern void __init smp_init(void);
@@ -203,7 +203,6 @@ static inline void up_smp_call_function(
 			(up_smp_call_function(func, info))
 
 static inline void smp_send_reschedule(int cpu) { }
-#define smp_prepare_boot_cpu()			do {} while (0)
 #define smp_call_function_many(mask, func, info, wait) \
 			(up_smp_call_function(func, info))
 static inline void call_function_init(void) { }
--- a/init/main.c
+++ b/init/main.c
@@ -776,6 +776,10 @@ void __init __weak smp_setup_processor_i
 {
 }
 
+void __init __weak smp_prepare_boot_cpu(void)
+{
+}
+
 # if THREAD_SIZE >= PAGE_SIZE
 void __init __weak thread_stack_cache_init(void)
 {

