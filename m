Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE1766CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbjG1MNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjG1MNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:13:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FDC2686;
        Fri, 28 Jul 2023 05:12:59 -0700 (PDT)
Message-ID: <20230728120930.336948106@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Xnwiz9iCKI1I53auLbuHOTbXvl9rMUcrLr9wRf4UYHw=;
        b=LvbYQBqh7dAF6kKAjxl7XESs0XMnvTsqMsSZP0EV1lffMeyQKTIC4CbUsc8yF+urEOEuPF
        NmLeSFNl0OQ6Mwl/4BvBXXxt3SraXjp8O1LekLczKSo1rFf1HpA7jHHjKBnPbfCkwi5S7Z
        OOG+MuAZbzpvayKr2UrizrWCc5+dbFSRTFTCiSPJPyloDX7zDj4ZhSCSutn745gbB09ei6
        Yjm0WZ71EArV/06E+tW3Ur5nhLRfke3HTRXRCQJ4J3CYs9oEEpyDRdTO3Ts631YA/zduVx
        F/L0V1p+fHyWEyBalv6hEtaROaKoM2p3V1WJ/EViLSbbm/B1WZA/i4lXLWRMYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Xnwiz9iCKI1I53auLbuHOTbXvl9rMUcrLr9wRf4UYHw=;
        b=oVSdjxtYMK03GOfqCK+pyrNwThne8WeNYDCRLs3SBbR/aENC+i0fMI9VB5annhKkjaaVuZ
        KqwcGDZpbRTlgfDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch v2 12/38] x86/apic: Use u32 for APIC IDs in global data
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:12:57 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APIC IDs are used with random data types u16, u32, int, unsigned int,
unsigned long.

Make it all consistently use u32 because that reflects the hardware
register width and fixup the most obvious usage sites of that.

The APIC callbacks will be addressed separately.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h      |    2 +-
 arch/x86/include/asm/mpspec.h    |    2 +-
 arch/x86/include/asm/processor.h |    4 ++--
 arch/x86/include/asm/smp.h       |    2 +-
 arch/x86/kernel/apic/apic.c      |   12 ++++++------
 arch/x86/kernel/kvm.c            |    6 +++---
 arch/x86/mm/numa.c               |    4 ++--
 7 files changed, 16 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -54,7 +54,7 @@ extern int local_apic_timer_c2_ok;
 extern bool apic_is_disabled;
 extern unsigned int lapic_timer_period;
 
-extern int cpuid_to_apicid[];
+extern u32 cpuid_to_apicid[];
 
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -37,7 +37,7 @@ extern int mp_bus_id_to_type[MAX_MP_BUSS
 
 extern DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
 
-extern unsigned int boot_cpu_physical_apicid;
+extern u32 boot_cpu_physical_apicid;
 extern u8 boot_cpu_apic_version;
 
 #ifdef CONFIG_X86_LOCAL_APIC
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -691,12 +691,12 @@ extern int set_tsc_mode(unsigned int val
 
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
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -18,7 +18,7 @@ DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
 
-DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
+DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
 
 struct task_struct;
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -70,7 +70,7 @@ unsigned int num_processors;
 unsigned disabled_cpus;
 
 /* Processor that is doing the boot up */
-unsigned int boot_cpu_physical_apicid __ro_after_init = BAD_APICID;
+u32 boot_cpu_physical_apicid __ro_after_init = BAD_APICID;
 EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
 
 u8 boot_cpu_apic_version __ro_after_init;
@@ -85,7 +85,7 @@ physid_mask_t phys_cpu_present_map;
  * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
  * avoid undefined behaviour caused by sending INIT from AP to BSP.
  */
-static unsigned int disabled_cpu_apicid __ro_after_init = BAD_APICID;
+static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
 
 /*
  * This variable controls which CPUs receive external NMIs.  By default,
@@ -109,7 +109,7 @@ static inline bool apic_accessible(void)
 /*
  * Map cpu index to physical APIC ID
  */
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid, BAD_APICID);
+DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid, BAD_APICID);
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, U32_MAX);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
@@ -2316,11 +2316,11 @@ static int nr_logical_cpuids = 1;
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
@@ -2380,7 +2380,7 @@ static int allocate_logical_cpuid(int ap
 	return nr_logical_cpuids++;
 }
 
-static void cpu_update_apic(int cpu, int apicid)
+static void cpu_update_apic(int cpu, u32 apicid)
 {
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -500,13 +500,13 @@ static bool pv_sched_yield_supported(voi
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
@@ -1030,8 +1030,8 @@ arch_initcall(activate_jump_labels);
 /* Kick a cpu by its apicid. Used to wake up a halted vcpu */
 static void kvm_kick_cpu(int cpu)
 {
-	int apicid;
 	unsigned long flags = 0;
+	u32 apicid;
 
 	apicid = per_cpu(x86_cpu_to_apicid, cpu);
 	kvm_hypercall2(KVM_HC_KICK_CPU, flags, apicid);
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
 

