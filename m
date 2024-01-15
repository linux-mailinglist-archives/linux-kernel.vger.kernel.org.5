Return-Path: <linux-kernel+bounces-26581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF8482E3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7581F247C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE41E1B94E;
	Mon, 15 Jan 2024 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsEEMpzw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3121B81E;
	Mon, 15 Jan 2024 23:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F455C43390;
	Mon, 15 Jan 2024 23:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361277;
	bh=WGHTNelBBfnwMX2Ah17/Q5b7qsOGb2mCsm2SJ6sugys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tsEEMpzwHQFihp6hBihN+7NE1+gNKgNCjxKlxFx6kkDlqfocySdqu00KapeHojj1l
	 IcRAFJ/AN47S1tVJ33BhCvKpN3qEYynEONKtgTNQPCz1sfr3t0WmChuDYp7F+05aWi
	 LfinKRlt86FSY3qWuE8LpwE3aJJ3UYljw+n+/G0ikfKWvq/x5QAuocGqVwBATuKfTw
	 v5D44m/fw5GerEHySsaUEMWcQz4dF2OE0lI+15J8UI/VhPgDsNjcPQGiyGZXq9xDTN
	 H4Hrrz1BIHthJl3XBEHSHgNxfmTD7hEA9Boy+5YZery5VG7xyXspL/7aeSYjS6PpDh
	 jMLgdaFhJAK+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	puwen@hygon.cn,
	seanjc@google.com,
	kim.phillips@amd.com,
	jmattson@google.com,
	babu.moger@amd.com,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	brgerst@gmail.com,
	ashok.raj@intel.com,
	mjguzik@gmail.com,
	jpoimboe@kernel.org,
	nik.borisov@suse.com,
	aik@amd.com,
	vegard.nossum@oracle.com,
	daniel.sneddon@linux.intel.com,
	acdunlap@google.com
Subject: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR accesses on AMD
Date: Mon, 15 Jan 2024 18:26:56 -0500
Message-ID: <20240115232718.209642-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232718.209642-1-sashal@kernel.org>
References: <20240115232718.209642-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

[ Upstream commit 04c3024560d3a14acd18d0a51a1d0a89d29b7eb5 ]

AMD does not have the requirement for a synchronization barrier when
acccessing a certain group of MSRs. Do not incur that unnecessary
penalty there.

There will be a CPUID bit which explicitly states that a MFENCE is not
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

From above, x2AVIC latency is ~4% more than AVIC. However, the expectation is
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/barrier.h     | 18 ------------------
 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/include/asm/processor.h   | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/amd.c          |  3 +++
 arch/x86/kernel/cpu/common.c       |  7 +++++++
 arch/x86/kernel/cpu/hygon.c        |  3 +++
 6 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 3ba772a69cc8..dab2db15a8c4 100644
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
index d6089072ee41..dd6f714c215e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -305,10 +305,10 @@
 
 
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
-
 #define X86_FEATURE_SRSO		(11*32+24) /* "" AMD BTB untrain RETs */
 #define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs through aliasing */
 #define X86_FEATURE_IBPB_ON_VMEXIT	(11*32+26) /* "" Issue an IBPB only on VMEXIT */
+#define X86_FEATURE_APIC_MSRS_FENCE	(11*32+27) /* "" IA32_TSC_DEADLINE and X2APIC MSRs need fencing */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index bbbf27cfe701..52329752dd4f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -861,4 +861,22 @@ enum mds_mitigations {
 
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
index dba7fe7ecea9..06186b7d0ed0 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1158,6 +1158,9 @@ static void init_amd(struct cpuinfo_x86 *c)
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
 	     cpu_has_amd_erratum(c, amd_erratum_1485))
 		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
+
+	/* AMD CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
+	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 01c4f8f45b83..1e870f6dd51c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1687,6 +1687,13 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
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
index 9e8380bd4fb9..8a80d5343f3a 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -347,6 +347,9 @@ static void init_hygon(struct cpuinfo_x86 *c)
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
 
 	check_null_seg_clears_base(c);
+
+	/* Hygon CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
+	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
 }
 
 static void cpu_detect_tlb_hygon(struct cpuinfo_x86 *c)
-- 
2.43.0


