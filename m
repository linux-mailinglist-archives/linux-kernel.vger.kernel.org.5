Return-Path: <linux-kernel+bounces-88355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADFB86E068
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BC128B4A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE16BFDB;
	Fri,  1 Mar 2024 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tHhkWxji";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11jtywQ/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4314438E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292818; cv=none; b=WG03bUO8eN7r32xRcmFsY1ZpYsDstPhlbZTgp7Zr9whdCpPgBn9irUoZoHmn/yWv/rEMSCM0zyAk9tAe9sQJgFuS+T4toMO7ANdqr8Hbtkg8C0lKksrbz0uISMiltwUN8e61vwXqoUC/btX7Bjbq01RK4k6eqc7VCifonsyNFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292818; c=relaxed/simple;
	bh=FQMGv7PmATC7VR1MwAuQvuUYpMVWZ8wkTcljl9/Xkqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A9VMfYjpv74Z1/Mu3g1PsmnsBnGkbzeftGwQjjmN37F5VVw3Nucg2ogxItEPQ8furu1wuqM+t2iOrkDR6sJvl2szBOGBXJ5PgHXlgE2j4xlLDAj0nJBNh3CDvjfNRIJ3hX7I6B0IHd3wPlhbKfFjleFBTjPR9thq7SOYcztNWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tHhkWxji; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11jtywQ/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709292814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KaJW+PGzJMPU08LMdd6ra/36/s+8KlMVMHUHupu24Eg=;
	b=tHhkWxjiL3c61ImcYSTznqHlgWNCQnTKobQr4ISvWMHLSdKyqIGYptR9XmejVhx+mO4clg
	BsUEj1z/J/2pt5d2b3c/qj1a50ycqlnXcNtoYAzOKw/RvITpPZZwz8Loips0sNQU/8vJOD
	SzpOOQEdUMW2tgDuvQxGpd01+43FphTnHPQR2LsOaFyuMiaL0kDUVv0plu9Ep0mFnNeAta
	Eh7rVfhNipqbkuSSCnVZwgaAVM42iFWvWzV4QE5Y2t9jK6TLI8Vm9RDaTelyO5ymjMsatX
	PpO0QK1FNbkrWlZEB0bLnwIM/5UI9gFms2MxG9h6QxEtN4dm7dC/FxGoMw85kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709292814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KaJW+PGzJMPU08LMdd6ra/36/s+8KlMVMHUHupu24Eg=;
	b=11jtywQ/wCzJUZQ+4YoHyF3vDjw1g6gaP3O+1SjMhUUl1Zp5GVwZUPFSophNsbooZx9I3E
	dw+zegdZptEPzpDA==
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Paul E. McKenney"
 <paulmck@kernel.org>
Subject: Re: [patch 6/6] x86/idle: Select idle routine only once
In-Reply-To: <87h6hq74j0.ffs@tglx>
References: <20240229141407.283316443@linutronix.de>
 <20240229142248.582321500@linutronix.de> <87h6hq74j0.ffs@tglx>
Date: Fri, 01 Mar 2024 12:33:33 +0100
Message-ID: <87edcu6vaq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 01 2024 at 09:14, Thomas Gleixner wrote:
> On Thu, Feb 29 2024 at 15:23, Thomas Gleixner wrote:
>>  
>> -	if (x86_idle_set())
>> -		return;
>> -
>
> Bah. With XEN=n this results in a defined but not used warning.
> Updated version below.

I'm a moron. xen_set_default_idle() is invoked very early on, so
select_idle_routine() has to keep the check. Sigh.

Fixed it and added an comment to that effect.

---
Subject: x86/idle: Select idle routine only once
From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 28 Feb 2024 23:20:32 +0100

The idle routine selection is done on every CPU bringup operation and has a
guard in place which is effective after the first invocation, which is a
pointless exercise.

Invoke it once on the boot CPU and mark the related functions __init.
The guard check has to stay as xen_set_default_idle() runs early.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V1b: Keep the x86_idle_set() check so XEN keeps working
V1a: Move x86_idle_set() into the only usage site (0day)
---
 arch/x86/include/asm/processor.h |    2 +-
 arch/x86/kernel/cpu/common.c     |    4 ++--
 arch/x86/kernel/process.c        |    8 +++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

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
@@ -853,8 +853,9 @@ void __noreturn stop_this_cpu(void *dumm
  * Do not prefer MWAIT if MONITOR instruction has a bug or idle=nomwait
  * is passed to kernel commandline parameter.
  */
-static bool prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
+static __init bool prefer_mwait_c1_over_halt(void)
 {
+	const struct cpuinfo_x86 *c = &boot_cpu_data;
 	u32 eax, ebx, ecx, edx;
 
 	/* If override is enforced on the command line, fall back to HALT. */
@@ -908,7 +909,7 @@ static __cpuidle void mwait_idle(void)
 	__current_clr_polling();
 }
 
-void select_idle_routine(const struct cpuinfo_x86 *c)
+void __init select_idle_routine(void)
 {
 	if (boot_option_idle_override == IDLE_POLL) {
 		if (IS_ENABLED(CONFIG_SMP) && smp_num_siblings > 1)
@@ -916,10 +917,11 @@ void select_idle_routine(const struct cp
 		return;
 	}
 
+	/* Required to guard against xen_set_default_idle() */
 	if (x86_idle_set())
 		return;
 
-	if (prefer_mwait_c1_over_halt(c)) {
+	if (prefer_mwait_c1_over_halt()) {
 		pr_info("using mwait in idle threads\n");
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {

