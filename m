Return-Path: <linux-kernel+bounces-146970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AA58A6DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977471C2168D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23161369A1;
	Tue, 16 Apr 2024 14:10:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DF612CDAF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276659; cv=none; b=P8HZYrjs7kGlDplu+LSWOrwxHnVlY8D3VldSjMHe7+tWQBifdhB18HnV7je0a/M5mFXaHG4vPr97/fRXzk4TfTSxC0PRrP6qyWZo238A93ZjtOJMgsSsCV+RlPxWwxQSPrrWq04mcCaRE/uqqrurWOi07RhoSIPcyES83MPhOW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276659; c=relaxed/simple;
	bh=aukE2VXAcMUvjs7ARrPKGU7Le/giScUEE4GV4g707EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOz+GaJYNAM/gdQRnB7LVr8kXkylaF+sMmsKXMBkPUlgY/eXmHBh19HnU6N8LjTR2aHLqNwX1cHtEorEhXdgXOylRDaiCNDzvm6UPAHkwmZFIqcC89YkXRMtw4AiAvSq4ahediDue+EOx8VKdF9ifvzYUPnTBAIaN51MLTjz0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92065339;
	Tue, 16 Apr 2024 07:11:18 -0700 (PDT)
Received: from [10.1.26.17] (e133047.arm.com [10.1.26.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F37A3F738;
	Tue, 16 Apr 2024 07:10:49 -0700 (PDT)
Message-ID: <f1685b30-9d0d-419e-b004-590edf21315a@arm.com>
Date: Tue, 16 Apr 2024 15:10:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched/core: split iowait state into two states
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de
References: <20240416121526.67022-1-axboe@kernel.dk>
 <20240416121526.67022-5-axboe@kernel.dk>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240416121526.67022-5-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2024 13:11, Jens Axboe wrote:
> iowait is a bogus metric, but it's helpful in the sense that it allows
> short waits to not enter sleep states that have a higher exit latency
> than would've otherwise have been picked for iowait'ing tasks. However,
> it's harmless in that lots of applications and monitoring assumes that
s/harmless/harmful ?
> iowait is busy time, or otherwise use it as a health metric.
> Particularly for async IO it's entirely nonsensical.
> 
> Split the iowait part into two parts - one that tracks whether the task
> needs boosting for short waits, and one that marks whether the task
> needs to be accounted as such. ->in_iowait_acct nests inside of
> ->in_iowait, both for efficiency reasons, but also so that the
> relationship between the two is clear. A waiter may set ->in_wait alone
s/in_wait/in_iowait/
> and not care about the accounting.
> 
> Existing users of nr_iowait() for accounting purposes are switched to
> use nr_iowait_acct(), which leaves the governor using nr_iowait() as it
> only cares about iowaiters, not the accounting side.
> 
> Utilize that there's enough space in rq->nr_iowait to store both values
> in there, shifting the accounting side by half the size of the type.
> Thank you to Thomas Gleixner for that [1] suggestion.
> 
> [1] https://lore.kernel.org/lkml/87sf1b6o9w.ffs@tglx/
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Again this is just a tiny symptom of iowait being bogus, but I understand
your problem and have nothing simple to offer you as of now.
Daniel's comment mentioned below is still spot on.
Any behavior piggybacked ontop of iowait is also non-sensical without
any definition of what "iowait" is actually supposed to mean.
Are we returning to the same rq real soon? Maybe, maybe not.
Are we on the critical path to higher IO throughput and should be run
with a high frequency after wakeup? Maybe, maybe not (Probably not?).
Apart from that obligatory nagging and my comments below this looks okay.

> ---
>  arch/s390/appldata/appldata_base.c |  2 +-
>  arch/s390/appldata/appldata_os.c   |  2 +-
>  fs/proc/stat.c                     |  2 +-
>  include/linux/sched.h              |  6 +++
>  include/linux/sched/stat.h         |  5 ++-
>  kernel/sched/core.c                | 62 +++++++++++++++++++++++-------
>  kernel/sched/sched.h               |  1 +
>  kernel/time/tick-sched.c           |  6 +--
>  8 files changed, 65 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
> index c2978cb03b36..6844b5294a8b 100644
> --- a/arch/s390/appldata/appldata_base.c
> +++ b/arch/s390/appldata/appldata_base.c
> @@ -423,4 +423,4 @@ EXPORT_SYMBOL_GPL(si_swapinfo);
>  #endif
>  EXPORT_SYMBOL_GPL(nr_threads);
>  EXPORT_SYMBOL_GPL(nr_running);
> -EXPORT_SYMBOL_GPL(nr_iowait);
> +EXPORT_SYMBOL_GPL(nr_iowait_acct);
> diff --git a/arch/s390/appldata/appldata_os.c b/arch/s390/appldata/appldata_os.c
> index a363d30ce739..fa4b278aca6c 100644
> --- a/arch/s390/appldata/appldata_os.c
> +++ b/arch/s390/appldata/appldata_os.c
> @@ -100,7 +100,7 @@ static void appldata_get_os_data(void *data)
>  
>  	os_data->nr_threads = nr_threads;
>  	os_data->nr_running = nr_running();
> -	os_data->nr_iowait  = nr_iowait();
> +	os_data->nr_iowait  = nr_iowait_acct();
>  	os_data->avenrun[0] = avenrun[0] + (FIXED_1/200);
>  	os_data->avenrun[1] = avenrun[1] + (FIXED_1/200);
>  	os_data->avenrun[2] = avenrun[2] + (FIXED_1/200);
> diff --git a/fs/proc/stat.c b/fs/proc/stat.c
> index da60956b2915..149be7a884fb 100644
> --- a/fs/proc/stat.c
> +++ b/fs/proc/stat.c
> @@ -180,7 +180,7 @@ static int show_stat(struct seq_file *p, void *v)
>  		(unsigned long long)boottime.tv_sec,
>  		total_forks,
>  		nr_running(),
> -		nr_iowait());
> +		nr_iowait_acct());
>  
>  	seq_put_decimal_ull(p, "softirq ", (unsigned long long)sum_softirq);
>  
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index dcfc2830ed8e..26c69db5484b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -924,7 +924,13 @@ struct task_struct {
>  
>  	/* Bit to tell TOMOYO we're in execve(): */
>  	unsigned			in_execve:1;
> +	/* task is in iowait */
>  	unsigned			in_iowait:1;
> +	/*
> +	 * task is in iowait and should be accounted as such. can only be set
> +	 * if ->in_iowait is also set.
> +	 */
> +	unsigned			in_iowait_acct:1;
>  #ifndef TIF_RESTORE_SIGMASK
>  	unsigned			restore_sigmask:1;
>  #endif
> diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
> index 0108a38bb64d..31e8a44b3d71 100644
> --- a/include/linux/sched/stat.h
> +++ b/include/linux/sched/stat.h
> @@ -19,8 +19,9 @@ DECLARE_PER_CPU(unsigned long, process_counts);
>  extern int nr_processes(void);
>  extern unsigned int nr_running(void);
>  extern bool single_task_running(void);
> -extern unsigned int nr_iowait(void);
> -extern unsigned int nr_iowait_cpu(int cpu);
> +unsigned int nr_iowait_acct(void);
> +unsigned int nr_iowait_acct_cpu(int cpu);
> +unsigned int nr_iowait_cpu(int cpu);
>  
>  static inline int sched_info_on(void)
>  {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 63f6d44f460c..d52d3118dd73 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3721,30 +3721,47 @@ static inline cpumask_t *alloc_user_cpus_ptr(int node)
>  
>  #endif /* !CONFIG_SMP */
>  
> +/*
> + * Store iowait and iowait_acct state in the same variable. The lower bits
> + * hold the iowait state, and the upper bits hold the iowait_acct state.
> + */
>  static void task_iowait_inc(struct task_struct *p)
>  {
>  #ifdef CONFIG_64BIT
> -	atomic_long_inc(&task_rq(p)->nr_iowait);
> +	long val = 1 + ((long) p->in_iowait_acct << 32);
Are we not doing declarations at the beginning of the block anymore?

> +	atomic_long_add(val, &task_rq(p)->nr_iowait);
>  #else
> -	atomic_inc(&task_rq(p)->nr_iowait);
> +	int val = 1 + ((int) p->in_iowait_acct << 16);
> +	atomic_add(val, &task_rq(p)->nr_iowait);
>  #endif
>  }
>  
>  static void task_iowait_dec(struct task_struct *p)
>  {
>  #ifdef CONFIG_64BIT
> -	atomic_long_dec(&task_rq(p)->nr_iowait);
> +	long val = 1 + ((long) p->in_iowait_acct << 32);
> +	atomic_long_sub(val, &task_rq(p)->nr_iowait);
>  #else
> -	atomic_dec(&task_rq(p)->nr_iowait);
> +	int val = 1 + ((int) p->in_iowait_acct << 16);
> +	atomic_sub(val, &task_rq(p)->nr_iowait);
>  #endif
>  }
>  
>  int rq_iowait(struct rq *rq)
>  {
>  #ifdef CONFIG_64BIT
> -	return atomic_long_read(&rq->nr_iowait);
> +	return atomic_long_read(&rq->nr_iowait) & ((1UL << 32) - 1);
> +#else
> +	return atomic_read(&rq->nr_iowait) & ((1U << 16) - 1);
> +#endif
> +}
> +
> +int rq_iowait_acct(struct rq *rq)
> +{
> +#ifdef CONFIG_64BIT
> +	return atomic_long_read(&rq->nr_iowait) >> 32;
>  #else
> -	return atomic_read(&rq->nr_iowait);
> +	return atomic_read(&rq->nr_iowait) >> 16;
>  #endif
>  }
>  
> @@ -5497,7 +5514,12 @@ unsigned long long nr_context_switches(void)
>   * it does become runnable.
>   */
>  
> -unsigned int nr_iowait_cpu(int cpu)
> +unsigned int nr_iowait_acct_cpu(int cpu)

There is a comment above here by Daniel referring to "these two
interfaces [...]", originally referring to nr_iowait_cpu() and
get_iowait_load().
get_iowait_load() was removed in commit a7fe5190c03f ("cpuidle: menu: Remove get_loadavg() from the performance multiplier")
but nr_iowait_cpu() remains, so the comment should remain above it.
Rewording is also way overdue, although that's hardly on your
patch ;)

> +{
> +	return rq_iowait_acct(cpu_rq(cpu));
> +}
> +
> +unsigned nr_iowait_cpu(int cpu)
unsigned int
>  {
>  	return rq_iowait(cpu_rq(cpu));
>  }
> @@ -5532,12 +5554,12 @@ unsigned int nr_iowait_cpu(int cpu)
>   * Task CPU affinities can make all that even more 'interesting'.
>   */
>  
> -unsigned int nr_iowait(void)
> +unsigned int nr_iowait_acct(void)
>  {
>  	unsigned int i, sum = 0;
>  
>  	for_each_possible_cpu(i)
> -		sum += nr_iowait_cpu(i);
> +		sum += nr_iowait_acct_cpu(i);
>  
>  	return sum;
>  }
> @@ -9032,18 +9054,32 @@ int __sched yield_to(struct task_struct *p, bool preempt)
>  }
>  EXPORT_SYMBOL_GPL(yield_to);
>  [snip]

