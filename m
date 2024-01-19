Return-Path: <linux-kernel+bounces-31265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D14832B66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BCE1F23ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8503353810;
	Fri, 19 Jan 2024 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naNkM+aY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D0524D4;
	Fri, 19 Jan 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705675046; cv=none; b=egQZjpuvYsFisz4knJoZ8h0a+QqFsR9jZeveuM6l4cRD5EFJmA5u45AKrSHunust1gK/2dlPf68pKVAm3EN9yGXU9LIsj0Fg7QC1X+VXlZS/Pn+pv0A6D6gasc7qxOZrT0qqg48qtZshIpvZDZoiPbgKh+tD1MN+msVpR00KhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705675046; c=relaxed/simple;
	bh=T2yJaX7UwbgDvliRWFpAINaJXHgC+01Fx7/x+PKmJMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFjBM1OoT9sgLNyJDyUiXgcM9/KBYzsqmeKdvItgrakMiCQAKQmz6PuoN4vGis+AMB3O7x7U09zva+Sh9pdrIhmoPPw0FGmP+jVuCzy/Y8i5pj3tBJXglGPFJgEjVQUCA/mNaUx74eNRefJxzgCwWE9D9Ph0xx4ncoeIiSSl3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naNkM+aY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C942C433C7;
	Fri, 19 Jan 2024 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705675046;
	bh=T2yJaX7UwbgDvliRWFpAINaJXHgC+01Fx7/x+PKmJMA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=naNkM+aYQI79/kTXGLkKhTgHzwe822Bnvpmyv2ZQ3BrQz17lQhrdoJOOathBQbPGX
	 yckHj1rsdksXD8wRDkgvLRfS9DTs5DwbQ+g/0wgkGh0Uf5+on1P6Xzjj06m81apWuy
	 eJgn1WjcEDqyWlR1obLE/zq/NHbBoNQ1tEs5LrxXnUDlBfXPCOewWjINgPOL0X6xXk
	 n4vWjiJ38qrSkqbbFodeS5h5Bsu76ffQIOHOxrBDwnl9ZR+1LO6KsFV0+dlaaBj9eW
	 tUO+3n3VUvewfjYW0gHbN1+GizeB1VTPMHO8OmBijxChuO471pmCI/56KYlJkzL2d+
	 Laqoe7MVKySpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 18B48CE04A0; Fri, 19 Jan 2024 06:37:26 -0800 (PST)
Date: Fri, 19 Jan 2024 06:37:26 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Chen Zhongjin <chenzhongjin@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	yangjihong1@huawei.com, naveen.n.rao@linux.ibm.com,
	anil.s.keshavamurthy@intel.com, davem@davemloft.net,
	mhiramat@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, pmladek@suse.com, dianders@chromium.org,
	npiggin@gmail.com, mpe@ellerman.id.au, jkl820.git@gmail.com,
	juerg.haefliger@canonical.com, rick.p.edgecombe@intel.com,
	eric.devolder@oracle.com, mic@digikod.net
Subject: Re: [PATCH v2] kprobes: Use synchronize_rcu_tasks_rude in
 kprobe_optimizer
Message-ID: <bc485622-2e69-46e6-b95f-c1b4868e8d53@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240118021842.290665-1-chenzhongjin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118021842.290665-1-chenzhongjin@huawei.com>

On Thu, Jan 18, 2024 at 02:18:42AM +0000, Chen Zhongjin wrote:
> There is a deadlock scenario in kprobe_optimizer():
> 
> pid A				pid B			pid C
> kprobe_optimizer()		do_exit()		perf_kprobe_init()
> mutex_lock(&kprobe_mutex)	exit_tasks_rcu_start()	mutex_lock(&kprobe_mutex)
> synchronize_rcu_tasks()		zap_pid_ns_processes()	// waiting kprobe_mutex
> // waiting tasks_rcu_exit_srcu	kernel_wait4()
> 				// waiting pid C exit
> 
> To avoid this deadlock loop, use synchronize_rcu_tasks_rude() in kprobe_optimizer()
> rather than synchronize_rcu_tasks(). synchronize_rcu_tasks_rude() can also promise
> that all preempted tasks have scheduled, but it will not wait tasks_rcu_exit_srcu.
> 
> Fixes: a30b85df7d59 ("kprobes: Use synchronize_rcu_tasks() for optprobe with CONFIG_PREEMPT=y")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

Just so you know, your email ends up in gmail's spam folder.  :-/

> ---
> v1 -> v2: Add Fixes tag
> ---
>  arch/Kconfig     | 2 +-
>  kernel/kprobes.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index f4b210ab0612..dc6a18854017 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
>  config OPTPROBES
>  	def_bool y
>  	depends on KPROBES && HAVE_OPTPROBES
> -	select TASKS_RCU if PREEMPTION
> +	select TASKS_RUDE_RCU
>  
>  config KPROBES_ON_FTRACE
>  	def_bool y
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index d5a0ee40bf66..09056ae50c58 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -623,7 +623,7 @@ static void kprobe_optimizer(struct work_struct *work)
>  	 * Note that on non-preemptive kernel, this is transparently converted
>  	 * to synchronoze_sched() to wait for all interrupts to have completed.
>  	 */
> -	synchronize_rcu_tasks();
> +	synchronize_rcu_tasks_rude();

Again, that comment reads in full as follows:

	/*
	 * Step 2: Wait for quiesence period to ensure all potentially
	 * preempted tasks to have normally scheduled. Because optprobe
	 * may modify multiple instructions, there is a chance that Nth
	 * instruction is preempted. In that case, such tasks can return
	 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
	 * Note that on non-preemptive kernel, this is transparently converted
	 * to synchronoze_sched() to wait for all interrupts to have completed.
	 */

Please note well that first sentence.

Unless that first sentence no longer holds, this patch cannot work
because synchronize_rcu_tasks_rude() will not (repeat, NOT) wait for
preempted tasks.

So how to safely break this deadlock?  Reproducing Chen Zhongjin's
diagram:

pid A				pid B			pid C
kprobe_optimizer()		do_exit()		perf_kprobe_init()
mutex_lock(&kprobe_mutex)	exit_tasks_rcu_start()	mutex_lock(&kprobe_mutex)
synchronize_rcu_tasks()		zap_pid_ns_processes()	// waiting kprobe_mutex
// waiting tasks_rcu_exit_srcu	kernel_wait4()
				// waiting pid C exit

We need to stop synchronize_rcu_tasks() from waiting on tasks like
pid B that are voluntarily blocked.  One way to do that is to replace
SRCU with a set of per-CPU lists.  Then exit_tasks_rcu_start() adds the
current task to this list and does ...

OK, this is getting a bit involved.  If you would like to follow along,
please feel free to look here:

https://docs.google.com/document/d/1MEHHs5qbbZBzhN8dGP17pt-d87WptFJ2ZQcqS221d9I/edit?usp=sharing

							Thanx, Paul

>  	/* Step 3: Optimize kprobes after quiesence period */
>  	do_optimize_kprobes();
> -- 
> 2.25.1
> 

