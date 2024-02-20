Return-Path: <linux-kernel+bounces-72955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2751485BB14
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 784CCB236F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417D267C46;
	Tue, 20 Feb 2024 11:55:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD4367A1A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430144; cv=none; b=oRLVz4qNZQRq+4RsaGcjFznVqvUp+mi1hA8646DpVWVHKBfJ2cLJZXz0b3zr9B+PerDLgdTUginCaUlOALhKi4vxwN6JW7WEdvPVv0H43MGBPhAraHhWIQQs1b2ZKQ78ROpaij7sPp1UJZD4MtwR+6hx8HB4Lg3kpXPiolr/tvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430144; c=relaxed/simple;
	bh=iyps2MSntJU+TM6ZHqBgvov246vG4jGhQZQGmhn7v4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEoewZOfjhSOG1RUxcMnYkDVPCtH5E/FQb8WXy651Ipg9g/3Z8IRA5wzAj/y3+Fs2rw8y7KTB4MbgagNjbj6DiXakQYcxroWb5Edzfyrn12gouO6N4gKtIUutZ6geBwlWs8U8drLW1hzTPJCSfywDbMXbpEtdiQ+Dbm5upSI4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D15ABFEC;
	Tue, 20 Feb 2024 03:56:20 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B38453F762;
	Tue, 20 Feb 2024 03:55:40 -0800 (PST)
Date: Tue, 20 Feb 2024 11:55:30 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: skseofh@gmail.com, catalin.marinas@arm.com, will@kernel.org,
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add early fixmap initialization flag
Message-ID: <ZdSTMgxcWYsT9ECs@FVFF77S0Q05N.cambridge.arm.com>
References: <20240217140326.2367186-1-skseofh@gmail.com>
 <ZdMx-svsHgrfguxX@FVFF77S0Q05N>
 <ZdPyWkOlUan5AI9r@vm3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdPyWkOlUan5AI9r@vm3>

On Tue, Feb 20, 2024 at 09:29:14AM +0900, Itaru Kitayama wrote:
> On Mon, Feb 19, 2024 at 10:48:26AM +0000, Mark Rutland wrote:
> > On Sat, Feb 17, 2024 at 11:03:26PM +0900, skseofh@gmail.com wrote:
> > > From: Daero Lee <skseofh@gmail.com>
> > > 
> > > early_fixmap_init may be called multiple times. Since there is no
> > > change in the page table after early fixmap initialization, an
> > > initialization flag was added.
> > 
> > Why is that better?
> > 
> > We call early_fixmap_init() in two places:
> > 
> > * early_fdt_map()
> > * setup_arch()
> > 
> > ... and to get to setup_arch() we *must* have gone through early_fdt_map(),
> > since __primary_switched() calls that before going to setup_arch().
> > 
> > So AFAICT we can remove the second call to early_fixmap_init() in setup_arch(),
> > and rely on the earlier one in early_fdt_map().
> 
> Removing the second call makes the code base a bit harder to understand
> as the functions related to DT and ACPI setup are not separated cleanly.
> I prefer calling the early_fixmap_init() in setup_arch() as well.

I appreciate what you're saying here, but I don't think that it's better to
keep the second call in setup_arch().

We rely on having a (stub) DT in order to find UEFI and ACPI tables, so the DT
and ACPI setup can never be truly separated. We always need to map that DT in
order to find the UEFI+ACPI tables, and in order to do that we must initialize
the fixmap first.

I don't think there's any good reason to keep a redundant call in setup_arch();
that's just misleading and potentially problematic if we ever change
early_fixmap_init() so that it's not idempotent.

I agree it's somewhat a layering violation for  early_fdt_map() to be
responsible for initialising the fixmap, so how about we just pull that out,
e.g. as below?

Mark.

---->8----
From 5f07f9c1d352f760fa7aba97f1b4f42d9cb99496 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 20 Feb 2024 11:09:17 +0000
Subject: [PATCH] arm64: clean up fixmap initalization

Currently we have redundant initialization of the fixmap, first in
early_fdt_map(), and then again in setup_arch() before we call
early_ioremap_init(). This redundant initialization isn't harmful, as
early_fixmap_init() happens to be idempotent, but it's redundant and
potentially confusing.

We need to call early_fixmap_init() before we map the FDT and before we
call early_ioremap_init(). Ideally we'd place early_fixmap_init() and
early_ioremap_init() in the same caller as early_ioremap_init() is
somewhat coupled with the fixmap code.

Clean this up by moving the calls to early_fixmap_init() and
early_ioremap_init() into a new early_mappings_init() function, and
calling this once in __primary_switched() before we call
early_fdt_map(). This means we initialize the fixmap once, and keep
early_fixmap_init() and early_ioremap_init() together.

This is a cleanup, not a fix, and does not need to be backported to
stable kernels.

Reported-by: Daero Lee <skseofh@gmail.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/setup.h |  1 +
 arch/arm64/kernel/head.S       |  2 ++
 arch/arm64/kernel/setup.c      | 11 ++++++-----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index 2e4d7da74fb87..c8ba018bcc09f 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -9,6 +9,7 @@
 
 void *get_early_fdt_ptr(void);
 void early_fdt_map(u64 dt_phys);
+void early_mappings_init(void);
 
 /*
  * These two variables are used in the head.S file.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cab7f91949d8f..c60c5454c5704 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -510,6 +510,8 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
+	bl	early_mappings_init
+
 	mov	x0, x21				// pass FDT address in x0
 	bl	early_fdt_map			// Try mapping the FDT early
 	mov	x0, x20				// pass the full boot status
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 42c690bb2d608..7a539534ced78 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -176,8 +176,6 @@ void __init *get_early_fdt_ptr(void)
 asmlinkage void __init early_fdt_map(u64 dt_phys)
 {
 	int fdt_size;
-
-	early_fixmap_init();
 	early_fdt_ptr = fixmap_remap_fdt(dt_phys, &fdt_size, PAGE_KERNEL);
 }
 
@@ -290,6 +288,12 @@ u64 cpu_logical_map(unsigned int cpu)
 	return __cpu_logical_map[cpu];
 }
 
+asmlinkage void __init early_mappings_init(void)
+{
+	early_fixmap_init();
+	early_ioremap_init();
+}
+
 void __init __no_sanitize_address setup_arch(char **cmdline_p)
 {
 	setup_initial_init_mm(_stext, _etext, _edata, _end);
@@ -305,9 +309,6 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	 */
 	arm64_use_ng_mappings = kaslr_requires_kpti();
 
-	early_fixmap_init();
-	early_ioremap_init();
-
 	setup_machine_fdt(__fdt_pointer);
 
 	/*
-- 
2.30.2


