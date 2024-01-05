Return-Path: <linux-kernel+bounces-18426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CD0825D42
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0194E284115
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C749364BF;
	Fri,  5 Jan 2024 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NtYdnV6s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF69364BA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Jan 2024 23:53:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704498795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCwg2KhbBxczqWivmS+HLDaOklrbO1Me0OlTSs5JdVM=;
	b=NtYdnV6sjgsbe1UXJefyHcbFa1lwJJL4d2o6kHmnw5N3UxwkTtKAY+8cQXjPmcI7Cd00d+
	CZvi6peHaoJgx8x4a+/kT/VkhX6Ajj7tpbiJm89QYpKxGD7N0iEu/AVAwYMJ+nkm5/E8LH
	7d8qZJg0YbXvmJPHbsOrIy82Nubj7yc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] KVM: arm64: Workaround for Ampere AC03_CPU_36
 (exception taken to an incorrect EL)
Message-ID: <ZZiWZkNP8Owytecw@linux.dev>
References: <20240105213251.4141-1-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105213251.4141-1-ilkka@os.amperecomputing.com>
X-Migadu-Flow: FLOW_OUT

Hi Ilkka,

On Fri, Jan 05, 2024 at 01:32:51PM -0800, Ilkka Koskinen wrote:
> Due to erratum AC03_CPU_36 on AmpereOne, if an Asynchronous Exception
> (interrupts or SErrors) occurs to EL2, while EL2 software is modifying
> system register bits that control EL2 exception behavior, the processor
> may take an exception to an incorrect Exception Level.
> 
> The affected system registers are HCR_EL2 and SCTLR_EL2, which contain
> control bits for routing and enabling of EL2 exceptions.
> 
> The issue is triggered when HGE.TGE bit is cleared while having
> AMO/IMO/FMO bits cleared too. To avoid the exception getting taken
> at a wrong Exception Level, we set AMO/IMO/FMO.

We toggle HCR_EL2 for other things besides TLB invalidations, and the
changelog does not describe why they're apparently unaffected.

> Suggested-by: D Scott Phillips <scott@os.amperecomputing.com>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

This isn't an acceptable way to go about errata mitigations. Besides
extremely unusual circumstances, the pattern is to use a cpucap &&
alternatives to only enable the workaround on affected designs. We then
document the errata in the expected places (Kconfig and kernel
documentation) such that the folks saddled with maintaining this stuff
know how to handle it years down the line.

> ---
>  arch/arm64/kvm/hyp/vhe/tlb.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/vhe/tlb.c b/arch/arm64/kvm/hyp/vhe/tlb.c
> index b32e2940df7d..c72fdd2e4549 100644
> --- a/arch/arm64/kvm/hyp/vhe/tlb.c
> +++ b/arch/arm64/kvm/hyp/vhe/tlb.c
> @@ -61,9 +61,15 @@ static void __tlb_switch_to_guest(struct kvm_s2_mmu *mmu,
>  	 * has an ISB in order to deal with this.
>  	 */
>  	__load_stage2(mmu, mmu->arch);
> -	val = read_sysreg(hcr_el2);
> -	val &= ~HCR_TGE;
> -	write_sysreg(val, hcr_el2);
> +
> +	/*
> +	 * With {E2H,TGE} == {1,0}, IMO == 1 is required so that IRQs are not
> +	 * all masked.

Huh? HCR_EL2.IMO affects the *routing* of IRQs at exception levels
*lower than* EL2.

> This also works around AmpereOne erratum AC03_CPU_36
> +	 * which can incorrectly route an IRQ to EL1 when HCR_EL2.{E2H,TGE} is
> +	 * written from {1,1} to {1,0} with interrupts unmasked.
> +	 */
> +	sysreg_clear_set(hcr_el2, HCR_TGE, HCR_AMO | HCR_IMO | HCR_FMO);
> +

Rather than further modifying the exception controls, why not mask DAIF
like we do on guest entry/exit? AFAICT that is the only reason KVM_RUN
is unaffected by this erratum.

This is what I have been using on a few AmpereOne systems:

From 265cb193190c13c651d8e008d34d1d18505d4804 Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Fri, 5 Jan 2024 23:18:14 +0000
Subject: [PATCH] KVM: arm64: Mitigate AmpereOne erratum AC03_CPU_36

The AmpereOne design suffers from an erratum where if an asynchronous
exception arrives while EL2 is modifying hypervisor exception controls
(i.e. HCR_EL2, SCTLR_EL2) the PE may take an invalid exception to
another EL.

KVM's guest entry/exit path is unaffected because DAIF is already masked
when modifying HCR_EL2. However, KVM only masks IRQs when switching to
the guest MMU context for a TLB invalidation, meaning it is possible for
an intervening exception to trigger the erratum. This becomes
immediately obvious when profiling a KVM VM with pseudo-NMIs enabled,
such as:

  perf record ./dirty_log_perf_test -m 2 -s anonymous_thp -v 4 -b 4G

Mitigate the erratum by masking DAIF completely before switching to the
guest MMU context.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 16 ++++++++++++++++
 arch/arm64/kernel/cpu_errata.c              |  7 +++++++
 arch/arm64/kvm/hyp/vhe/tlb.c                | 20 ++++++++++++++++++--
 arch/arm64/tools/cpucaps                    |  1 +
 5 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index f47f63bcf67c..aea7a75ae434 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -52,6 +52,8 @@ stable kernels.
 | Allwinner      | A64/R18         | UNKNOWN1        | SUN50I_ERRATUM_UNKNOWN1     |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
+| Ampere         | AmpereOne       | AC03_CPU_36     | AMPERE_ERRATUM_AC03_CPU_36  |
++----------------+-----------------+-----------------+-----------------------------+
 | Ampere         | AmpereOne       | AC03_CPU_38     | AMPERE_ERRATUM_AC03_CPU_38  |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..9ba04b90e945 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -434,6 +434,22 @@ config AMPERE_ERRATUM_AC03_CPU_38
 
 	  If unsure, say Y.
 
+config AMPERE_ERRATUM_AC03_CPU_36
+	bool "AmpereOne: AC03_CPU_36: CPU takes invalid asynchronous exception while changing exception controls"
+	default y
+	help
+	  This option adds an alternative code sequence to work around Ampere
+	  erratum AC03_CPU_36 on AmpereOne parts.
+
+	  The affected designs can take an invalid exception to an incorrect
+	  exception level if an asynchronous exception arrives while software
+	  is changing the EL2 exception controls (i.e. HCR_EL2, SCTLR_EL2).
+
+	  The workaround forces KVM to mask all asynchronous exception sources
+	  when switching to the guest MMU context for TLB invalidations.
+
+	  If unsure, say Y.
+
 config ARM64_WORKAROUND_CLEAN_CACHE
 	bool
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index e29e0fea63fb..7e2856360f38 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -727,6 +727,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.capability = ARM64_WORKAROUND_AMPERE_AC03_CPU_38,
 		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1),
 	},
+#endif
+#ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_36
+	{
+		.desc = "AmpereOne erratum AC03_CPU_36",
+		.capability = ARM64_WORKAROUND_AMPERE_AC03_CPU_36,
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/kvm/hyp/vhe/tlb.c b/arch/arm64/kvm/hyp/vhe/tlb.c
index b636b4111dbf..cedfb0a32fa0 100644
--- a/arch/arm64/kvm/hyp/vhe/tlb.c
+++ b/arch/arm64/kvm/hyp/vhe/tlb.c
@@ -17,13 +17,29 @@ struct tlb_inv_context {
 	u64			sctlr;
 };
 
+#define __tlb_daif_save(flags)						\
+({									\
+	if (cpus_have_final_cap(ARM64_WORKAROUND_AMPERE_AC03_CPU_36))	\
+		flags = local_daif_save();				\
+	else								\
+		local_irq_save(flags);					\
+})
+
+#define __tlb_daif_restore(flags)					\
+({									\
+	if (cpus_have_final_cap(ARM64_WORKAROUND_AMPERE_AC03_CPU_36))	\
+		local_daif_restore(flags);				\
+	else								\
+		local_irq_restore(flags);				\
+})
+
 static void __tlb_switch_to_guest(struct kvm_s2_mmu *mmu,
 				  struct tlb_inv_context *cxt)
 {
 	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
 	u64 val;
 
-	local_irq_save(cxt->flags);
+	__tlb_daif_save(cxt->flags);
 
 	if (vcpu && mmu != vcpu->arch.hw_mmu)
 		cxt->mmu = vcpu->arch.hw_mmu;
@@ -86,7 +102,7 @@ static void __tlb_switch_to_host(struct tlb_inv_context *cxt)
 		write_sysreg_el1(cxt->sctlr, SYS_SCTLR);
 	}
 
-	local_irq_restore(cxt->flags);
+	__tlb_daif_restore(cxt->flags);
 }
 
 void __kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu,
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index b98c38288a9d..cfaae3b4d2d0 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -85,6 +85,7 @@ WORKAROUND_2457168
 WORKAROUND_2645198
 WORKAROUND_2658417
 WORKAROUND_2966298
+WORKAROUND_AMPERE_AC03_CPU_36
 WORKAROUND_AMPERE_AC03_CPU_38
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
-- 
2.43.0.472.g3155946c3a-goog

-- 
Thanks,
Oliver

