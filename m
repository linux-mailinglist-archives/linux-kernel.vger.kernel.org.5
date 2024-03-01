Return-Path: <linux-kernel+bounces-88402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F52886E11D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDFA2B239FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F246F15AB;
	Fri,  1 Mar 2024 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SCzk2GHv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ivFkNYlT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E315A8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296416; cv=none; b=JFdZrFHpivuEVWAx8LHsRSlgIgoUwl0wGz9w4iQLPFrKmzzXawGzZDvRMipUG4H4NRo+2P1xIuKLkC6W4dr9JlSlktIzKfV0tSvgAmbAUB3n6jgDwiMJ7LaagpArb6iXZBUUfYkiH+CHcRtVdsdbuRzC5OSlD380G3OCCnl1TrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296416; c=relaxed/simple;
	bh=9aaVI+QCiELUQc5x7vswneVSAIlNS3AKLaXtKHeoono=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KVW+ZbdQIhVpFVwbRn814xLMRtlFaII62e+XF86+aA8RDC7VCQaYhpzL6qQAYvkzcLCM7EuN+KC2NCGZqRZM4Iyu2jpXeZ/JrcmeNJD2zqZd1/mMWmQ4nMNHGuIh/siPAhxZ1jeiIy+ttRT0dVxgC2+H2JV/fFNtPs5tyYqRLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SCzk2GHv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ivFkNYlT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709296412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1VRFKDbKgX/iGQexdLI2ObrYutdC/7TU9qqLp+5nYU=;
	b=SCzk2GHvfZLR5sN9guctTe1Q+RfGzeifEaLS2Rvv2qnrYlytQky5Z214TO9OnWnE9cTWVx
	fWnh/7cAxRw9QrBDN5PQ/Qs3i8GAk0BGoklSbaiuIpc7p2uY8GI4/zfjqSo+/QXnqTPDV+
	WAtj+lhKmBxYGkIzi/Ib7gamCuwJdL0BrBlndzFGWD/CtvHQMAXerzvGm0xtuAUhzp9xJB
	5UhO38bkiZ5LDkbJ3E6AlfI1bzjuU7/TBiYF7j7WR71o7XpTZxlYKU1AEM8z5Oqp2RWeS1
	hwZLr5AyDTkoZ5/Ym7cWxXqBQiLbvZ3ddk+MxCGaeHbCl4qz6J+Dl/3/AMJZjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709296412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1VRFKDbKgX/iGQexdLI2ObrYutdC/7TU9qqLp+5nYU=;
	b=ivFkNYlTZ0yW/tHrdc/8fFys1qU4QM6WWd8oywvTt5513DtEF12zUK7TPj543pTyPLbVS4
	qGxS8MWbBJ6zNaDA==
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [patch 2/6] x86/idle: Sanitize X86_BUG_AMD_E400 handling
In-Reply-To: <20240229142248.329708185@linutronix.de>
References: <20240229141407.283316443@linutronix.de>
 <20240229142248.329708185@linutronix.de>
Date: Fri, 01 Mar 2024 13:33:31 +0100
Message-ID: <877cim6sis.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 29 2024 at 15:23, Thomas Gleixner wrote:
> @@ -985,7 +958,9 @@ void __init arch_post_acpi_subsys_init(v
>  
>  	if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
>  		mark_tsc_unstable("TSC halt in AMD C1E");
> -	pr_info("System has AMD C1E enabled\n");
> +
> +	static_branch_enable(&arch_needs_tick_broadcast);
> +	pr_info("System has AMD C1E erratum E400. Workaround enabled.\n");
>  }

Breaks the 32-bit build with APIC=n :(

---
Subject: x86/idle: Sanitize X86_BUG_AMD_E400 handling
From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 28 Feb 2024 23:13:00 +0100

amd_e400_idle(), the idle routine for AMD CPUs which are affected by
erratum 400 violates the RCU constraints by invoking tick_broadcast_enter()
and tick_broadcast_exit() after the core code has marked RCU non-idle.  The
functions can end up in lockdep or tracing, which rightfully triggers a
RCU warning.

The core code provides now a static branch conditional invocation of the
broadcast functions.

Remove amd_e400_idle(), enforce default_idle() and enable the static branch
on affected CPUs to cure this.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V1b: Fix 32bit built with APIC=n (0-day)
---
 arch/x86/Kconfig          |    1 +
 arch/x86/kernel/process.c |   42 +++++++++---------------------------------
 2 files changed, 10 insertions(+), 33 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -147,6 +147,7 @@ config X86
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
+	select GENERIC_CLOCKEVENTS_BROADCAST_IDLE	if GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CLOCKEVENTS_MIN_ADJUST
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -846,31 +846,6 @@ void __noreturn stop_this_cpu(void *dumm
 }
 
 /*
- * AMD Erratum 400 aware idle routine. We handle it the same way as C3 power
- * states (local apic timer and TSC stop).
- *
- * XXX this function is completely buggered vs RCU and tracing.
- */
-static void amd_e400_idle(void)
-{
-	/*
-	 * We cannot use static_cpu_has_bug() here because X86_BUG_AMD_APIC_C1E
-	 * gets set after static_cpu_has() places have been converted via
-	 * alternatives.
-	 */
-	if (!boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E)) {
-		default_idle();
-		return;
-	}
-
-	tick_broadcast_enter();
-
-	default_idle();
-
-	tick_broadcast_exit();
-}
-
-/*
  * Prefer MWAIT over HALT if MWAIT is supported, MWAIT_CPUID leaf
  * exists and whenever MONITOR/MWAIT extensions are present there is at
  * least one C1 substate.
@@ -890,8 +865,8 @@ static int prefer_mwait_c1_over_halt(con
 	if (!cpu_has(c, X86_FEATURE_MWAIT))
 		return 0;
 
-	/* Monitor has a bug. Fallback to HALT */
-	if (boot_cpu_has_bug(X86_BUG_MONITOR))
+	/* Monitor has a bug or APIC stops in C1E. Fallback to HALT */
+	if (boot_cpu_has_bug(X86_BUG_MONITOR) || boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E))
 		return 0;
 
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
@@ -942,17 +917,15 @@ void select_idle_routine(const struct cp
 	if (x86_idle_set() || boot_option_idle_override == IDLE_POLL)
 		return;
 
-	if (boot_cpu_has_bug(X86_BUG_AMD_E400)) {
-		pr_info("using AMD E400 aware idle routine\n");
-		static_call_update(x86_idle, amd_e400_idle);
-	} else if (prefer_mwait_c1_over_halt(c)) {
+	if (prefer_mwait_c1_over_halt(c)) {
 		pr_info("using mwait in idle threads\n");
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
 		static_call_update(x86_idle, tdx_safe_halt);
-	} else
+	} else {
 		static_call_update(x86_idle, default_idle);
+	}
 }
 
 void amd_e400_c1e_apic_setup(void)
@@ -985,7 +958,10 @@ void __init arch_post_acpi_subsys_init(v
 
 	if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
 		mark_tsc_unstable("TSC halt in AMD C1E");
-	pr_info("System has AMD C1E enabled\n");
+
+	if (IS_ENABLED(GENERIC_CLOCKEVENTS_BROADCAST_IDLE))
+		static_branch_enable(&arch_needs_tick_broadcast);
+	pr_info("System has AMD C1E erratum E400. Workaround enabled.\n");
 }
 
 static int __init idle_setup(char *str)

