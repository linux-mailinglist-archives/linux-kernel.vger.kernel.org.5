Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4B7C8245
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjJMJie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjJMJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D1CC;
        Fri, 13 Oct 2023 02:38:09 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hf0nF5oI9DzmZM3QQTkjQpQqpegaP3Bo8zjxnWE8LB8=;
        b=S40r+7ElNCWtwx6KAv+XoNx6hPbL0bRPsu6SZu3RL9/o2S4r1ff2w8aihm+40bd1L0Xe+F
        cy1w00bzD3ph/Mdb9ch2bBO+K+LfpGNKYzTs92Tqk215U2rPHbT/t1awq1EyJhgyX3l3qA
        QHOc09p26yMMo8naEO42Pvv9b8trIANRtLT/w/F5Tu5IHjM2E0WiVKmgEnqjjTpoFEs2I+
        y5sy4ccyJ/SsqLRDRAfbVyq8dkyrl80HJTM9VdNtTH5FiYQLhWmLrx//moFaXqxiPLvCpF
        AeqFGFYOM5i0JnJm/liFxtYx1gTjrksuHhARPpzSwJTY+BWAjedup+o4eEJ8ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hf0nF5oI9DzmZM3QQTkjQpQqpegaP3Bo8zjxnWE8LB8=;
        b=vHiP3VGa1UVz+aymuLMF/Kf+A1GEOQgr0d9fLkQWXZN5oKG1HrPiPL7VVPCZsK3qxrU/yC
        xtAY/2zMRHvKgnCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/apic: Use u32 for APIC IDs in global data
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085112.922905727@linutronix.de>
References: <20230814085112.922905727@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988672.3135.4246765143260520683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     4705243d237ab6abd8696e9672ad3fb36587c6f6
Gitweb:        https://git.kernel.org/tip/4705243d237ab6abd8696e9672ad3fb36587c6f6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:18 +02:00

x86/apic: Use u32 for APIC IDs in global data

APIC IDs are used with random data types u16, u32, int, unsigned int,
unsigned long.

Make it all consistently use u32 because that reflects the hardware
register width and fixup the most obvious usage sites of that.

The APIC callbacks will be addressed separately.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085112.922905727@linutronix.de

---
 arch/x86/include/asm/apic.h      |  8 ++++----
 arch/x86/include/asm/mpspec.h    |  2 +-
 arch/x86/include/asm/processor.h |  4 ++--
 arch/x86/include/asm/smp.h       |  2 +-
 arch/x86/kernel/apic/apic.c      | 16 ++++++++--------
 arch/x86/kernel/apic/ipi.c       |  5 +++--
 arch/x86/kernel/kvm.c            |  6 +++---
 arch/x86/mm/numa.c               |  4 ++--
 8 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 5af4ec1..a7ac05c 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -54,7 +54,7 @@ extern int local_apic_timer_c2_ok;
 extern bool apic_is_disabled;
 extern unsigned int lapic_timer_period;
 
-extern int cpuid_to_apicid[];
+extern u32 cpuid_to_apicid[];
 
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
@@ -517,9 +517,9 @@ extern void generic_bigsmp_probe(void);
 
 extern struct apic apic_noop;
 
-static inline unsigned int read_apic_id(void)
+static inline u32 read_apic_id(void)
 {
-	unsigned int reg = apic_read(APIC_ID);
+	u32 reg = apic_read(APIC_ID);
 
 	return apic->get_apic_id(reg);
 }
@@ -544,7 +544,7 @@ extern int default_cpu_present_to_apicid(int mps_cpu);
 
 #else /* CONFIG_X86_LOCAL_APIC */
 
-static inline unsigned int read_apic_id(void) { return 0; }
+static inline u32 read_apic_id(void) { return 0; }
 
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index f46df83..4b0f98a 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -37,7 +37,7 @@ extern int mp_bus_id_to_type[MAX_MP_BUSSES];
 
 extern DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
 
-extern unsigned int boot_cpu_physical_apicid;
+extern u32 boot_cpu_physical_apicid;
 extern u8 boot_cpu_apic_version;
 
 #ifdef CONFIG_X86_LOCAL_APIC
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d529d8a..ffd0312 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -693,12 +693,12 @@ extern int set_tsc_mode(unsigned int val);
 
 DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 
-static inline u16 per_cpu_llc_id(unsigned int cpu)
+static inline u32 per_cpu_llc_id(unsigned int cpu)
 {
 	return per_cpu(cpu_info.topo.llc_id, cpu);
 }
 
-static inline u16 per_cpu_l2c_id(unsigned int cpu)
+static inline u32 per_cpu_l2c_id(unsigned int cpu)
 {
 	return per_cpu(cpu_info.topo.l2c_id, cpu);
 }
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index b291db4..eb74097 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -18,7 +18,7 @@ DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
 
-DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
+DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
 
 struct task_struct;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d2b1d60..41093cf 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -72,7 +72,7 @@ unsigned int num_processors;
 unsigned disabled_cpus;
 
 /* Processor that is doing the boot up */
-unsigned int boot_cpu_physical_apicid __ro_after_init = BAD_APICID;
+u32 boot_cpu_physical_apicid __ro_after_init = BAD_APICID;
 EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
 
 u8 boot_cpu_apic_version __ro_after_init;
@@ -87,7 +87,7 @@ physid_mask_t phys_cpu_present_map;
  * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
  * avoid undefined behaviour caused by sending INIT from AP to BSP.
  */
-static unsigned int disabled_cpu_apicid __ro_after_init = BAD_APICID;
+static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
 
 /*
  * This variable controls which CPUs receive external NMIs.  By default,
@@ -111,7 +111,7 @@ static inline bool apic_accessible(void)
 /*
  * Map cpu index to physical APIC ID
  */
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid, BAD_APICID);
+DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid, BAD_APICID);
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, U32_MAX);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
@@ -1765,7 +1765,7 @@ static void __x2apic_enable(void)
 static int __init setup_nox2apic(char *str)
 {
 	if (x2apic_enabled()) {
-		int apicid = native_apic_msr_read(APIC_ID);
+		u32 apicid = native_apic_msr_read(APIC_ID);
 
 		if (apicid >= 255) {
 			pr_warn("Apicid: %08x, cannot enforce nox2apic\n",
@@ -2318,11 +2318,11 @@ static int nr_logical_cpuids = 1;
 /*
  * Used to store mapping between logical CPU IDs and APIC IDs.
  */
-int cpuid_to_apicid[] = { [0 ... NR_CPUS - 1] = BAD_APICID, };
+u32 cpuid_to_apicid[] = { [0 ... NR_CPUS - 1] = BAD_APICID, };
 
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
-	return phys_id == cpuid_to_apicid[cpu];
+	return phys_id == (u64)cpuid_to_apicid[cpu];
 }
 
 #ifdef CONFIG_SMP
@@ -2391,7 +2391,7 @@ static int allocate_logical_cpuid(int apicid)
 	return nr_logical_cpuids++;
 }
 
-static void cpu_update_apic(int cpu, int apicid)
+static void cpu_update_apic(int cpu, u32 apicid)
 {
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
@@ -2544,7 +2544,7 @@ static struct {
 	 */
 	int active;
 	/* r/w apic fields */
-	unsigned int apic_id;
+	u32 apic_id;
 	unsigned int apic_taskpri;
 	unsigned int apic_ldr;
 	unsigned int apic_dfr;
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index a44ba72..0078730 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -281,7 +281,7 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 }
 
 #ifdef CONFIG_SMP
-static int convert_apicid_to_cpu(int apic_id)
+static int convert_apicid_to_cpu(u32 apic_id)
 {
 	int i;
 
@@ -294,7 +294,8 @@ static int convert_apicid_to_cpu(int apic_id)
 
 int safe_smp_processor_id(void)
 {
-	int apicid, cpuid;
+	u32 apicid;
+	int cpuid;
 
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return 0;
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index b8ab9ee..0ddb3bd 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -500,13 +500,13 @@ static bool pv_sched_yield_supported(void)
 static void __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	unsigned long flags;
-	int cpu, apic_id, icr;
-	int min = 0, max = 0;
+	int cpu, min = 0, max = 0;
 #ifdef CONFIG_X86_64
 	__uint128_t ipi_bitmap = 0;
 #else
 	u64 ipi_bitmap = 0;
 #endif
+	u32 apic_id, icr;
 	long ret;
 
 	if (cpumask_empty(mask))
@@ -1028,8 +1028,8 @@ arch_initcall(activate_jump_labels);
 /* Kick a cpu by its apicid. Used to wake up a halted vcpu */
 static void kvm_kick_cpu(int cpu)
 {
-	int apicid;
 	unsigned long flags = 0;
+	u32 apicid;
 
 	apicid = per_cpu(x86_cpu_to_apicid, cpu);
 	kvm_hypercall2(KVM_HC_KICK_CPU, flags, apicid);
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb20..02ee0d1 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -56,7 +56,7 @@ s16 __apicid_to_node[MAX_LOCAL_APIC] = {
 
 int numa_cpu_node(int cpu)
 {
-	int apicid = early_per_cpu(x86_cpu_to_apicid, cpu);
+	u32 apicid = early_per_cpu(x86_cpu_to_apicid, cpu);
 
 	if (apicid != BAD_APICID)
 		return __apicid_to_node[apicid];
@@ -786,7 +786,7 @@ void __init init_gi_nodes(void)
 void __init init_cpu_to_node(void)
 {
 	int cpu;
-	u16 *cpu_to_apicid = early_per_cpu_ptr(x86_cpu_to_apicid);
+	u32 *cpu_to_apicid = early_per_cpu_ptr(x86_cpu_to_apicid);
 
 	BUG_ON(cpu_to_apicid == NULL);
 
