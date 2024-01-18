Return-Path: <linux-kernel+bounces-29657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F4D831164
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF981C22362
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F1A5390;
	Thu, 18 Jan 2024 02:25:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499C2115;
	Thu, 18 Jan 2024 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705544732; cv=none; b=ZZ9Mz7xeV4epI1hQ4y4+B9tm+XhINDHNw7xdm2+MUKi3iFno7IsqhkZwckFw/9xO7LMSoFuR5VYwSBgu8fqKmVMkoTS0i6C67Kkl/EH/3Bu3RH+QV7y1SfIYUSUzjPW54w4vQch2rqjy+Lm2/Zy8+C2joOeSTO2nrBQkbGUiLUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705544732; c=relaxed/simple;
	bh=8LBkJof5B327L1V0yCKArqI09jJkUVrtza9uTR4uueI=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=Hj4KJGrw7UpTZ1sfuohhyUu4JQWyixFoSpVtUKTwjQHAz6R7L2u3Z32Tkkh9a7FMSDrrdwiIMXZckDyAXkI5X5AiZ9GudKNHJkYEB8X+xcZ22U51on4dGnUG8vDS5foFAFcSOsUiU2fJxJwh1FbUB48r9GL9VF3Dn8tU+iPdRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633BFC433C7;
	Thu, 18 Jan 2024 02:25:29 +0000 (UTC)
Date: Wed, 17 Jan 2024 21:26:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Chen Zhongjin <chenzhongjin@huawei.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <yangjihong1@huawei.com>, <naveen.n.rao@linux.ibm.com>,
 <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
 <paulmck@kernel.org>, <mhiramat@kernel.org>, <akpm@linux-foundation.org>,
 <tglx@linutronix.de>, <peterz@infradead.org>, <pmladek@suse.com>,
 <dianders@chromium.org>, <npiggin@gmail.com>, <mpe@ellerman.id.au>,
 <jkl820.git@gmail.com>, <juerg.haefliger@canonical.com>,
 <rick.p.edgecombe@intel.com>, <eric.devolder@oracle.com>, <mic@digikod.net>
Subject: Re: [PATCH v2] kprobes: Use synchronize_rcu_tasks_rude in
 kprobe_optimizer
Message-ID: <20240117212646.5f0ddf0c@gandalf.local.home>
In-Reply-To: <20240118021842.290665-1-chenzhongjin@huawei.com>
References: <20240118021842.290665-1-chenzhongjin@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jan 2024 02:18:42 +0000
Chen Zhongjin <chenzhongjin@huawei.com> wrote:

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

Did lockdep detect this? If not, we should fix that.

I'm also thinking if we should find another solution, as this seems more of
a work around than a fix.

> Fixes: a30b85df7d59 ("kprobes: Use synchronize_rcu_tasks() for optprobe with CONFIG_PREEMPT=y")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
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

Is this still a bug if PREEMPTION is not enabled?

-- Steve

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
>  
>  	/* Step 3: Optimize kprobes after quiesence period */
>  	do_optimize_kprobes();


