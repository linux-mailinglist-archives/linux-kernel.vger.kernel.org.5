Return-Path: <linux-kernel+bounces-95968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C26875578
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BE91F212B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB693130E35;
	Thu,  7 Mar 2024 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiCSn3uK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348B12DDBA;
	Thu,  7 Mar 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833537; cv=none; b=ChOYYCKO45IfitYVwrVfSJin17wHUXwFEGpAkgpbFNvKj8IFdWYsyBzqDd67ar4oWBmpNrhwUbwH2iPpkOeYnMfpEQsrBWyZdhUTpc1HIsCXKD6tFIqedw3NDzqVKk6sV6Jl8GYdu9Q5RDbBtoNY95X7C2XPylzzzhGEbMbA6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833537; c=relaxed/simple;
	bh=fmex7ycV6097BZ7cnW/vpknMTfZttQAd8IWkJXjDdCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAON2q1S79nMPvjr/s/yU8WfgPFoDOs2pecCBYj8e6Vf6iMQ2kCdQCRpIa3CNz7X0pLuS7oE8tWHFcQ9+PNthczQblx9AMiodH1hMVo7oR9tUK5aNli9NQCa87YzYbLPeMt8onHpN+HvIeD1hKzy7zvr2NZDKJJ48NitqEmf9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiCSn3uK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64B6C433F1;
	Thu,  7 Mar 2024 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709833536;
	bh=fmex7ycV6097BZ7cnW/vpknMTfZttQAd8IWkJXjDdCU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uiCSn3uK2PCOZObe2iBQiz8z8ovbR3APKhEbgSFMsKF+lqN9MRj/o281oUEJsWaAc
	 tp2ZiipVpH8YuCFs8ZoJ7D9ajIbkOA8Qd5awOXmmEcmhDlULZnDfyj4jSD7fybuyST
	 2l/+GTSHtx3wCFmJTIv0Bb8/K58F1oCm8ZLx3Ye2vPL/57axVKdR186mG6Sj+zoZo9
	 hW4lfEgFZdSUsJ30JRV51IR+akc/5QoyUaKfF0fmTbYRpSDuiUFvBv1J284+3ZDRNK
	 TbmnASiMNsRXGSkA+caxy9I/iYXAPOleFcyCkFSoZoj/j3d40oZClTge5S7QwjRhYQ
	 Ff8X0vdcoKZsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 44C51CE0F1D; Thu,  7 Mar 2024 09:45:36 -0800 (PST)
Date: Thu, 7 Mar 2024 09:45:36 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
Message-ID: <49792f54-fa11-4984-8611-84ba640a2b86@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307160951.3607374-1-stefan.wiehler@nokia.com>

On Thu, Mar 07, 2024 at 05:09:51PM +0100, Stefan Wiehler wrote:
> With CONFIG_PROVE_RCU_LIST=y and by executing
> 
>   $ echo 0 > /sys/devices/system/cpu/cpu1/online
> 
> one can trigger the following Lockdep-RCU splat on ARM:
> 
>   =============================
>   WARNING: suspicious RCU usage
>   6.8.0-rc7-00001-g0db1d0ed8958 #10 Not tainted
>   -----------------------------
>   kernel/locking/lockdep.c:3762 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   RCU used illegally from offline CPU!
>   rcu_scheduler_active = 2, debug_locks = 1
>   no locks held by swapper/1/0.
> 
>   stack backtrace:
>   CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-rc7-00001-g0db1d0ed8958 #10
>   Hardware name: Allwinner sun8i Family
>    unwind_backtrace from show_stack+0x10/0x14
>    show_stack from dump_stack_lvl+0x60/0x90
>    dump_stack_lvl from lockdep_rcu_suspicious+0x150/0x1a0
>    lockdep_rcu_suspicious from __lock_acquire+0x11fc/0x29f8
>    __lock_acquire from lock_acquire+0x10c/0x348
>    lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
>    _raw_spin_lock_irqsave from check_and_switch_context+0x7c/0x4a8
>    check_and_switch_context from arch_cpu_idle_dead+0x10/0x7c
>    arch_cpu_idle_dead from do_idle+0xbc/0x138
>    do_idle from cpu_startup_entry+0x28/0x2c
>    cpu_startup_entry from secondary_start_kernel+0x11c/0x124
>    secondary_start_kernel from 0x401018a0
> 
> The CPU is already reported as offline from RCU perspective in
> cpuhp_report_idle_dead() before arch_cpu_idle_dead() is invoked. Above
> RCU-Lockdep splat is then triggered by check_and_switch_context() acquiring the
> ASID spinlock.
> 
> Avoid the false-positive Lockdep-RCU splat by briefly reporting the CPU as
> online again while the spinlock is held.
> 
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>

From an RCU perspective, this looks plausible.  One question
below.

						Thanx, Paul

> ---
>  arch/arm/kernel/smp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 3431c0553f45..6875e2c5dd50 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -319,7 +319,14 @@ void __noreturn arch_cpu_idle_dead(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  
> +	/*
> +	 * Briefly report CPU as online again to avoid false positive
> +	 * Lockdep-RCU splat when check_and_switch_context() acquires ASID
> +	 * spinlock.
> +	 */
> +	rcutree_report_cpu_starting(cpu);
>  	idle_task_exit();
> +	rcutree_report_cpu_dead();
>  
>  	local_irq_disable();

Both rcutree_report_cpu_starting() and rcutree_report_cpu_dead() complain
bitterly via lockdep if interrupts are enabled.  And the call sites have
interrupts disabled.  So I don't understand what this local_irq_disable()
is needed for.

