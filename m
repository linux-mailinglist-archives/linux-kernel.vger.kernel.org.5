Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9425B7E9871
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjKMI54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjKMI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:57:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FE846B8;
        Mon, 13 Nov 2023 00:56:59 -0800 (PST)
Date:   Mon, 13 Nov 2023 08:56:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699865817;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvP2CLC5WYXiLN+zcrrNY85pJG8RZXtL20sLADnsYN8=;
        b=1dFiShgsj+SuEbW7/SZfzyG/BUdSnZYKTtmjP1ZP+buvtlE0vLOIhFWbuuIrNosRSB8rEk
        ZtmNL0A/szP+Q8zxs/ysK2SaH2C23O/BuKSfz8NFRwXziBs7wCcf7/B5qnPGdrfRFJX5OI
        wGlLZwrUymGzKwPYOkQ5bZaVJLAxeley1oQxAEkojSk6+l771DQWOXLeFTopJldTwK+wAU
        O6Jt1rOW4pV2YeyXkOAlRQOmgSyZp3fsZGAJNrZMkplArZfyOEc2nXhcys5X/3IMqCTeQ/
        ul28XpHAI6ymo0/STScZGy6epn5F6eASospkDwkE9MDLHJtgmkzYfe0qFQ7EmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699865817;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvP2CLC5WYXiLN+zcrrNY85pJG8RZXtL20sLADnsYN8=;
        b=Je1r0jaDz9PFbv+qhaeRmzZHIYyftdvK41p9QB9KTzS535yrvJwjcmhT9xfh2nSdVQoftH
        nhychoAE0/jzQmBw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/barrier: Do not serialize MSR accesses on AMD
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230622095212.20940-1-bp@alien8.de>
References: <20230622095212.20940-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <169986581656.3135.2819708380071395214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ff7b6bee2b25e278d5cd24cc30abb76faaab7fbf
Gitweb:        https://git.kernel.org/tip/ff7b6bee2b25e278d5cd24cc30abb76faaab7fbf
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 27 Oct 2023 14:24:16 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Nov 2023 09:41:42 +01:00

x86/barrier: Do not serialize MSR accesses on AMD

AMD does not have the requirement for a synchronization barrier when
acccessing a certain group of MSRs. Do not incur that unnecessary
penalty there.

There will be a CPUID bit which explicitly states that a WRMSR is not
needed. Once that bit is added to the APM, this will be extended with
it.

While at it, move to processor.h to avoid include hell. Untangling that
file properly is a matter for another day.

Some notes on the performance aspect of why this is relevant, courtesy
of Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>:

On a AMD Zen4 system with 96 cores, a modified ipi-bench[1] on a VM
shows x2AVIC IPI rate is 3% to 4% lower than AVIC IPI rate. The
ipi-bench is modified so that the IPIs are sent between two vCPUs in the
same CCX. This also requires to pin the vCPU to a physical core to
prevent any latencies. This simulates the use case of pinning vCPUs to
the thread of a single CCX to avoid interrupt IPI latency.

In order to avoid run-to-run variance (for both x2AVIC and AVIC), the
below configurations are done:

  1) Disable Power States in BIOS (to prevent the system from going to
     lower power state)

  2) Run the system at fixed frequency 2500MHz (to prevent the system
     from increasing the frequency when the load is more)

With the above configuration:

*) Performance measured using ipi-bench for AVIC:
  Average Latency:  1124.98ns [Time to send IPI from one vCPU to another vCPU]

  Cumulative throughput: 42.6759M/s [Total number of IPIs sent in a second from
  				     48 vCPUs simultaneously]

*) Performance measured using ipi-bench for x2AVIC:
  Average Latency:  1172.42ns [Time to send IPI from one vCPU to another vCPU]

  Cumulative throughput: 40.9432M/s [Total number of IPIs sent in a second from
  				     48 vCPUs simultaneously]

>From above, x2AVIC latency is ~4% more than AVIC. However, the expectation is
x2AVIC performance to be better or equivalent to AVIC. Upon analyzing
the perf captures, it is observed significant time is spent in
weak_wrmsr_fence() invoked by x2apic_send_IPI().

With the fix to skip weak_wrmsr_fence()

*) Performance measured using ipi-bench for x2AVIC:
  Average Latency:  1117.44ns [Time to send IPI from one vCPU to another vCPU]

  Cumulative throughput: 42.9608M/s [Total number of IPIs sent in a second from
  				     48 vCPUs simultaneously]

Comparing the performance of x2AVIC with and without the fix, it can be seen
the performance improves by ~4%.

Performance captured using an unmodified ipi-bench using the 'mesh-ipi' option
with and without weak_wrmsr_fence() on a Zen4 system also showed significant
performance improvement without weak_wrmsr_fence(). The 'mesh-ipi' option ignores
CCX or CCD and just picks random vCPU.

  Average throughput (10 iterations) with weak_wrmsr_fence(),
        Cumulative throughput: 4933374 IPI/s

  Average throughput (10 iterations) without weak_wrmsr_fence(),
        Cumulative throughput: 6355156 IPI/s

[1] https://github.com/bytedance/kvm-utils/tree/master/microbenchmark/ipi-bench

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230622095212.20940-1-bp@alien8.de
---
 arch/x86/include/asm/barrier.h     | 18 ------------------
 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/include/asm/processor.h   | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/amd.c          |  3 +++
 arch/x86/kernel/cpu/common.c       |  7 +++++++
 arch/x86/kernel/cpu/hygon.c        |  3 +++
 6 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 35389b2..0216f63 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -81,22 +81,4 @@ do {									\
 
 #include <asm-generic/barrier.h>
 
-/*
- * Make previous memory operations globally visible before
- * a WRMSR.
- *
- * MFENCE makes writes visible, but only affects load/store
- * instructions.  WRMSR is unfortunately not a load/store
- * instruction and is unaffected by MFENCE.  The LFENCE ensures
- * that the WRMSR is not reordered.
- *
- * Most WRMSRs are full serializing instructions themselves and
- * do not require this barrier.  This is only required for the
- * IA32_TSC_DEADLINE and X2APIC MSRs.
- */
-static inline void weak_wrmsr_fence(void)
-{
-	asm volatile("mfence; lfence" : : : "memory");
-}
-
 #endif /* _ASM_X86_BARRIER_H */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 4af140c..3e973ff 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -308,10 +308,10 @@
 #define X86_FEATURE_SMBA		(11*32+21) /* "" Slow Memory Bandwidth Allocation */
 #define X86_FEATURE_BMEC		(11*32+22) /* "" Bandwidth Monitoring Event Configuration */
 #define X86_FEATURE_USER_SHSTK		(11*32+23) /* Shadow stack support for user mode applications */
-
 #define X86_FEATURE_SRSO		(11*32+24) /* "" AMD BTB untrain RETs */
 #define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs through aliasing */
 #define X86_FEATURE_IBPB_ON_VMEXIT	(11*32+26) /* "" Issue an IBPB only on VMEXIT */
+#define X86_FEATURE_APIC_MSRS_FENCE	(11*32+27) /* "" IA32_TSC_DEADLINE and X2APIC MSRs need fencing */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index ae81a71..26620d7 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -749,4 +749,22 @@ enum mds_mitigations {
 
 extern bool gds_ucode_mitigated(void);
 
+/*
+ * Make previous memory operations globally visible before
+ * a WRMSR.
+ *
+ * MFENCE makes writes visible, but only affects load/store
+ * instructions.  WRMSR is unfortunately not a load/store
+ * instruction and is unaffected by MFENCE.  The LFENCE ensures
+ * that the WRMSR is not reordered.
+ *
+ * Most WRMSRs are full serializing instructions themselves and
+ * do not require this barrier.  This is only required for the
+ * IA32_TSC_DEADLINE and X2APIC MSRs.
+ */
+static inline void weak_wrmsr_fence(void)
+{
+	alternative("mfence; lfence", "", ALT_NOT(X86_FEATURE_APIC_MSRS_FENCE));
+}
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a7eab05..841e212 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1162,6 +1162,9 @@ static void init_amd(struct cpuinfo_x86 *c)
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
 	     cpu_has_amd_erratum(c, amd_erratum_1485))
 		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
+
+	/* AMD CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
+	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b14fc8c..98f7ea6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1856,6 +1856,13 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
 #endif
 
+
+	/*
+	 * Set default APIC and TSC_DEADLINE MSR fencing flag. AMD and
+	 * Hygon will clear it in ->c_init() below.
+	 */
+	set_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
+
 	/*
 	 * Vendor-specific initialization.  In this section we
 	 * canonicalize the feature flags, meaning if there are
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 6f247d6..f0cd955 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -354,6 +354,9 @@ static void init_hygon(struct cpuinfo_x86 *c)
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
 
 	check_null_seg_clears_base(c);
+
+	/* Hygon CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
+	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
 }
 
 static void cpu_detect_tlb_hygon(struct cpuinfo_x86 *c)
