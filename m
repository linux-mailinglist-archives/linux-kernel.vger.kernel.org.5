Return-Path: <linux-kernel+bounces-65277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1C4854A78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022DB28A873
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E89D5467A;
	Wed, 14 Feb 2024 13:25:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819587499
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707917151; cv=none; b=Z6EqRUfz3rDlswYB3TyebOqm5kig9xpnL+soKiSZLo3OU6tGE6H9NZo1KZAT0QY5hVeOh7KRnAQRdE5SmZQ0c2QAdjBAHSAUQG+4yHh3WOMZiYXQn4y8RfyZTrWSVR65bNx6538mCU57oVu8p7Lc4yuX6heZRA6k/y+Df2ezt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707917151; c=relaxed/simple;
	bh=hRdhPklLiRJFunCmr63f+3rRwn2AAXUVqCCfSHmiAcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFEQ/jp2++IIxJacxdgnVfyita6Klv7MK/1GB8xLf/WauLX5K8oTVAZeOhMy7ga25tujZvqm7tg2O68EnBHcOQbTk+pUvdTZle8axqIJAB9oruOMrircktjknr0vp4yrPvhYvbX81zO+xABHdvhtYN/831SjkXme+vuHF+ySIoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C058F1FB;
	Wed, 14 Feb 2024 05:26:22 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.64.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 935313F5A1;
	Wed, 14 Feb 2024 05:25:36 -0800 (PST)
Date: Wed, 14 Feb 2024 13:25:32 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH 17/30] x86/thread_info: define TIF_NEED_RESCHED_LAZY
Message-ID: <Zcy_TJt9L0EXcsVM@FVFF77S0Q05N>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-18-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213055554.1802415-18-ankur.a.arora@oracle.com>

Hi Ankur,

On Mon, Feb 12, 2024 at 09:55:41PM -0800, Ankur Arora wrote:
> Define TIF_NEED_RESCHED_LAZY which, with TIF_NEED_RESCHED provides the
> scheduler with two kinds of rescheduling intent: TIF_NEED_RESCHED,
> for the usual rescheduling at the next safe preemption point;
> TIF_NEED_RESCHED_LAZY expressing an intent to reschedule at some
> time in the future while allowing the current task to run to
> completion.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/x86/Kconfig                   |  1 +
>  arch/x86/include/asm/thread_info.h | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5edec175b9bf..ab58558068a4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -275,6 +275,7 @@ config X86
>  	select HAVE_STATIC_CALL
>  	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
>  	select HAVE_PREEMPT_DYNAMIC_CALL
> +	select HAVE_PREEMPT_AUTO
>  	select HAVE_RSEQ
>  	select HAVE_RUST			if X86_64
>  	select HAVE_SYSCALL_TRACEPOINTS
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index d63b02940747..88c1802185fc 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -81,8 +81,11 @@ struct thread_info {
>  #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
>  #define TIF_SIGPENDING		2	/* signal pending */
>  #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
> -#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
> -#define TIF_SSBD		5	/* Speculative store bypass disable */
> +#ifdef CONFIG_PREEMPT_AUTO
> +#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling */
> +#endif
> +#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
> +#define TIF_SSBD		6	/* Speculative store bypass disable */

It's a bit awkward/ugly to conditionally define the TIF_* bits in arch code,
and we don't do that for other bits that are only used in some configurations
(e.g. TIF_UPROBE). That's not just for aesthetics -- for example, on arm64 we
try to keep the TIF_WORK_MASK bits contiguous, which is difficult if a bit in
the middle doesn't exist in some configurations.

Is it painful to organise the common code so that arch code can define
TIF_NEED_RESCHED_LAZY regardless of whether CONFIG_PREEMPT_AUTO is selected?

Mark.

>  #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
>  #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
>  #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
> @@ -104,6 +107,9 @@ struct thread_info {
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> +#ifdef CONFIG_PREEMPT_AUTO
> +#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
> +#endif
>  #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>  #define _TIF_SSBD		(1 << TIF_SSBD)
>  #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
> -- 
> 2.31.1
> 

