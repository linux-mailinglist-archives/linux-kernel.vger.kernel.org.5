Return-Path: <linux-kernel+bounces-88057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC086DCD0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F333B288AE7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEE569D1A;
	Fri,  1 Mar 2024 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="reiKqrSc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/AiQxsPe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896969968
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280856; cv=none; b=YI4m9T0fTLJqaT98zW54qWOpc5ngCkLUfqpJ5XvUkxBRpG4k9UGg5jlNABPlfIfVRlQcLUkelSoIeXHCrRa/CRMldfpRZ9hPWol/RCt02VQ2cQji8CBq39zUDj+56WMZIxuYkXq+Y08BC19BzTpf2tN6rzYhwSMnP9miAQ2eRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280856; c=relaxed/simple;
	bh=jaP5tyZRYYfMcaJ7grKsHD19hayDCXPmT0t3bv6/8bY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MBBcq+TIIZO9kuuTessy5MjfXMEhxRkvL6SDPwjp4Wa255NbbSgHxfMF6TAw1wjxqTYq3ZNhYgHW40TPYTrH9XcFanIXMoUc02oAOUD6XKtMIaSStVOYpJX4hugC6Sx65LbLQijM02KtmCrEnIZtwYyx3qXHOBd9tMBldpmd87g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=reiKqrSc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/AiQxsPe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709280852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUXcVZzlTt019jlXW5vVIeqdQ7GFrCPz8tzw8VHsJvc=;
	b=reiKqrScZQuDrP55pZfFXab9Y1omzvIjkor1bG7gh7QnekkTD/xJFJkqBRaEA6qn9fTmwl
	oLZKRLpGil5H1f8K17BjaSHLQNzFMnIyIIH9lT+oKSkkd5khFF28d0hsKTjteGUMKQq//z
	TTMY9aoH66EhJ++ClqY39L1haWplsmUb5eg3mlpeYDwaA1w5SThZW/kJ1w5mWtUkBiKmcH
	+NC6O4TJNMW0u460D3rZVcvh7Csi+E2sz05MI4U3iALOWZY6/cm+D+T7dISKfcMToFdRmU
	B3WrrcKKN0G/LdsA4I1mIfbHoMsEhEoAvIZqzRmdZ59PWF3q9IeV6w3TQHfGuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709280852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUXcVZzlTt019jlXW5vVIeqdQ7GFrCPz8tzw8VHsJvc=;
	b=/AiQxsPeY9WI5tmRqkD1+p6T/kT+YtfPLxS/AssP7CS/4ev4cnOT8BVBJqM7fkIE6ndhTR
	0jjGFF/PG6Er0FCA==
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Paul E. McKenney"
 <paulmck@kernel.org>
Subject: Re: [patch 6/6] x86/idle: Select idle routine only once
In-Reply-To: <20240229142248.582321500@linutronix.de>
References: <20240229141407.283316443@linutronix.de>
 <20240229142248.582321500@linutronix.de>
Date: Fri, 01 Mar 2024 09:14:11 +0100
Message-ID: <87h6hq74j0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 29 2024 at 15:23, Thomas Gleixner wrote:
>  
> -	if (x86_idle_set())
> -		return;
> -

Bah. With XEN=n this results in a defined but not used warning.
Updated version below.

---
Subject: x86/idle: Select idle routine only once
From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 28 Feb 2024 23:20:32 +0100

The idle routine selection is done on every CPU bringup operation and has a
guard in place which is effective after the first invocation, which is a
pointless exercise.

Invoke it once on the boot CPU and mark the related functions __init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V1a: Move x86_idle_set() into the only usage site (0day)
---
 arch/x86/include/asm/processor.h |    2 +-
 arch/x86/kernel/cpu/common.c     |    4 ++--
 arch/x86/kernel/process.c        |   18 +++++-------------
 3 files changed, 8 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -555,7 +555,7 @@ static inline void load_sp0(unsigned lon
 
 unsigned long __get_wchan(struct task_struct *p);
 
-extern void select_idle_routine(const struct cpuinfo_x86 *c);
+extern void select_idle_routine(void);
 extern void amd_e400_c1e_apic_setup(void);
 
 extern unsigned long		boot_option_idle_override;
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1938,8 +1938,6 @@ static void identify_cpu(struct cpuinfo_
 	/* Init Machine Check Exception if available. */
 	mcheck_cpu_init(c);
 
-	select_idle_routine(c);
-
 #ifdef CONFIG_NUMA
 	numa_add_cpu(smp_processor_id());
 #endif
@@ -2343,6 +2341,8 @@ void __init arch_cpu_finalize_init(void)
 {
 	identify_boot_cpu();
 
+	select_idle_routine();
+
 	/*
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -748,11 +748,6 @@ EXPORT_SYMBOL(default_idle);
 
 DEFINE_STATIC_CALL_NULL(x86_idle, default_idle);
 
-static bool x86_idle_set(void)
-{
-	return !!static_call_query(x86_idle);
-}
-
 #ifndef CONFIG_SMP
 static inline void __noreturn play_dead(void)
 {
@@ -783,10 +778,9 @@ EXPORT_SYMBOL_GPL(arch_cpu_idle);
 #ifdef CONFIG_XEN
 bool xen_set_default_idle(void)
 {
-	bool ret = x86_idle_set();
+	bool ret = !!static_call_query(x86_idle);
 
 	static_call_update(x86_idle, default_idle);
-
 	return ret;
 }
 #endif
@@ -853,8 +847,9 @@ void __noreturn stop_this_cpu(void *dumm
  * Do not prefer MWAIT if MONITOR instruction has a bug or idle=nomwait
  * is passed to kernel commandline parameter.
  */
-static bool prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
+static __init bool prefer_mwait_c1_over_halt(void)
 {
+	const struct cpuinfo_x86 *c = &boot_cpu_data;
 	u32 eax, ebx, ecx, edx;
 
 	/* If override is enforced on the command line, fall back to HALT. */
@@ -908,7 +903,7 @@ static __cpuidle void mwait_idle(void)
 	__current_clr_polling();
 }
 
-void select_idle_routine(const struct cpuinfo_x86 *c)
+void __init select_idle_routine(void)
 {
 	if (boot_option_idle_override == IDLE_POLL) {
 		if (IS_ENABLED(CONFIG_SMP) && smp_num_siblings > 1)
@@ -916,10 +911,7 @@ void select_idle_routine(const struct cp
 		return;
 	}
 
-	if (x86_idle_set())
-		return;
-
-	if (prefer_mwait_c1_over_halt(c)) {
+	if (prefer_mwait_c1_over_halt()) {
 		pr_info("using mwait in idle threads\n");
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {

