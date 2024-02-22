Return-Path: <linux-kernel+bounces-77422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8AF86050F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE201F26323
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B2E12D1F8;
	Thu, 22 Feb 2024 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="mrBXcDKo"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4DD12D1EC;
	Thu, 22 Feb 2024 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708638371; cv=none; b=cw6RKi133p0cw8aYz4OtDlmbhQLcKlZfDPGRyKtuNc1D3FZOgUsnQkz66AqfKJuyeycPWlzTvS9yAb4cVksrquUSD3zXkrn85EhG5J/a8isNX8FiEPnCLUOJA1tJDb0UfiZASxmiAg5L537pHuBjTww3WhV+hudRSbUNsXYKB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708638371; c=relaxed/simple;
	bh=Vv0fjC6tqv1JhbuXN2YbUo0rHfJfx129XJY3ZYuK4oA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TyIolSSc8bf6vVLhr1Zubt1tOrFYBoNQWe969QKuvJ6AedJweFLs2NqOnoHWwDTmfUA8DB+8ILdFZINi9HF+Ah0s6m9kwHK4rXRa2kbJG8abbwfTL3D+PUAS/VmKrj6NVrS246QDYi0DhbErgWX9rCCOTmv70f80k6PaHjTeEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=mrBXcDKo; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708638366;
	bh=0ZmYCz+SCJ0BgfLpkAxVCmJACnVsDgEoO+/yVn8yWFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mrBXcDKoRMVzrXITn1EEU+aj01MFFwaaItfCmGPweSRFKwRzLcFrm08tgcOcLlWJA
	 l2eyNdSEkpR2DlS+x9UTf3fBjeLznOezB2H2sPmWkxoHYsvum78te77NTYVGQ72b5Z
	 CVEEgBK1uLKYtUlWWFHG2X+4hMR3FaWFEKu8p5tfBQBb7WWEHLOLS2NGgBhUWVKimk
	 LR3hdv5kPUSRvtIZVCVTtelIO8HVofEcPEBj3IMCZwosQgrLhs/uITZSlXENkDNi/v
	 B6hn+dozf5ysqZeRXb3fVcwulhUZtxq0GTR9KnCjP6wC0bD1Qf5JUl1N3uoA4Wt8Mi
	 jW8vPcRVGIGrA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tgmt55rTGz4wcC;
	Fri, 23 Feb 2024 08:46:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander Gordeev <agordeev@linux.ibm.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Frederic
 Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 RESEND 2/5] sched/vtime: get rid of generic
 vtime_task_switch() implementation
In-Reply-To: <5e8f7cfc5b405b892d55c51023e8149dfd83b253.1708612016.git.agordeev@linux.ibm.com>
References: <cover.1708612016.git.agordeev@linux.ibm.com>
 <5e8f7cfc5b405b892d55c51023e8149dfd83b253.1708612016.git.agordeev@linux.ibm.com>
Date: Fri, 23 Feb 2024 08:46:03 +1100
Message-ID: <87zfvs9nqc.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Gordeev <agordeev@linux.ibm.com> writes:
> The generic vtime_task_switch() implementation gets built only
> if __ARCH_HAS_VTIME_TASK_SWITCH is not defined, but requires an
> architecture to implement arch_vtime_task_switch() callback at
> the same time, which is confusing.
>
> Further, arch_vtime_task_switch() is implemented for 32-bit PowerPC
> architecture only and vtime_task_switch() generic variant is rather
> superfluous.
>
> Simplify the whole vtime_task_switch() wiring by moving the existing
> generic implementation to PowerPC.
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/cputime.h | 13 -------------
>  arch/powerpc/kernel/time.c         | 22 ++++++++++++++++++++++
>  kernel/sched/cputime.c             | 13 -------------
>  3 files changed, 22 insertions(+), 26 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
> index 4961fb38e438..aff858ca99c0 100644
> --- a/arch/powerpc/include/asm/cputime.h
> +++ b/arch/powerpc/include/asm/cputime.h
> @@ -32,23 +32,10 @@
>  #ifdef CONFIG_PPC64
>  #define get_accounting(tsk)	(&get_paca()->accounting)
>  #define raw_get_accounting(tsk)	(&local_paca->accounting)
> -static inline void arch_vtime_task_switch(struct task_struct *tsk) { }
>  
>  #else
>  #define get_accounting(tsk)	(&task_thread_info(tsk)->accounting)
>  #define raw_get_accounting(tsk)	get_accounting(tsk)
> -/*
> - * Called from the context switch with interrupts disabled, to charge all
> - * accumulated times to the current process, and to prepare accounting on
> - * the next process.
> - */
> -static inline void arch_vtime_task_switch(struct task_struct *prev)
> -{
> -	struct cpu_accounting_data *acct = get_accounting(current);
> -	struct cpu_accounting_data *acct0 = get_accounting(prev);
> -
> -	acct->starttime = acct0->starttime;
> -}
>  #endif
>  
>  /*
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index df20cf201f74..c0fdc6d94fee 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -354,6 +354,28 @@ void vtime_flush(struct task_struct *tsk)
>  	acct->hardirq_time = 0;
>  	acct->softirq_time = 0;
>  }
> +
> +/*
> + * Called from the context switch with interrupts disabled, to charge all
> + * accumulated times to the current process, and to prepare accounting on
> + * the next process.
> + */
> +void vtime_task_switch(struct task_struct *prev)
> +{
> +	if (is_idle_task(prev))
> +		vtime_account_idle(prev);
> +	else
> +		vtime_account_kernel(prev);
> +
> +	vtime_flush(prev);
> +
> +	if (!IS_ENABLED(CONFIG_PPC64)) {
> +		struct cpu_accounting_data *acct = get_accounting(current);
> +		struct cpu_accounting_data *acct0 = get_accounting(prev);
> +
> +		acct->starttime = acct0->starttime;
> +	}
> +}
>  #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
>  
>  void __no_kcsan __delay(unsigned long loops)
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index af7952f12e6c..aa48b2ec879d 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -424,19 +424,6 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
>   */
>  #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
>  
> -# ifndef __ARCH_HAS_VTIME_TASK_SWITCH
> -void vtime_task_switch(struct task_struct *prev)
> -{
> -	if (is_idle_task(prev))
> -		vtime_account_idle(prev);
> -	else
> -		vtime_account_kernel(prev);
> -
> -	vtime_flush(prev);
> -	arch_vtime_task_switch(prev);
> -}
> -# endif
> -
>  void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
>  {
>  	unsigned int pc = irq_count() - offset;
> -- 
> 2.40.1

