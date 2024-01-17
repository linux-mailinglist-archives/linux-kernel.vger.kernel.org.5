Return-Path: <linux-kernel+bounces-28397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD3582FE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D64C1C23DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A0310F7;
	Wed, 17 Jan 2024 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7Sitg07"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3263A;
	Wed, 17 Jan 2024 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705452226; cv=none; b=KQoP/MAPCPsoq8fEny9wc3MQm+WENrq3Aub9lBdttIlssDn64rpBZMw3YocAaFQVGcrGIUxNVCP1VaPSHz5Nvtdqeo+TZoTEv8Efam34QRb9YIWo9puCs96IoVddx10+jfe5BInyI+cpzYBBnZBdooRdX+tA0bq6nD1d6UHC48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705452226; c=relaxed/simple;
	bh=Fd1/m6W/7fQ9XN1TYZqc9RLgN+U7zTJsTX6ScmfLWYY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=SY5NPctRsJaa11OMhdPQr2nH+tdzY0MQsfiyFm0uM1wuRQkSqjjLed9PAIZ2mlT4YhXoeZHCum5pfigUsUO/L5DKDz8NMXJjrJMrbOuEC5Ypw/ZoOUKpWQTWaJORmrICjB/qcOjBTQvBnVwsITKEnJLoBVkRUMVFCuHeIzoNtp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7Sitg07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E06C433F1;
	Wed, 17 Jan 2024 00:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705452225;
	bh=Fd1/m6W/7fQ9XN1TYZqc9RLgN+U7zTJsTX6ScmfLWYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7Sitg07xOY91zBapUfyHoEiSypKN33bESw8zBP0x2z1bFXn1ZeWuzlUoOHDOUGBU
	 prdXYzQ4xY2Ec5CqF7gHIkkYeqgyf0LDrHPhtESZxBAM3sowZ+bsHEmOqIpDebdNtJ
	 M3io07zoT09M5Vs/8iFOTO+jzZD+stXWlEDkPfVdI5UMwyV8eBY20uY3cdS1nhD23Q
	 rrLnpkMDLcqSNa5+QqEA6Xz0H8wFTrNGjX9Ng/9ebLwUAbGRRDGl87oFYJzkdHlEyD
	 cA8Mz9wCQCNzFs4xSx2+P8AdQi1adtjGwO6chdD3QOwqn4UXm3ItItcSfrNEoh+BW7
	 yXfnt0Jmc6HFw==
Date: Wed, 17 Jan 2024 01:43:41 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] tick-sched: fix idle and iowait sleeptime accounting vs
 CPU hotplug
Message-ID: <ZacivexXEcL1KvOc@pavilion.home>
References: <20240115163555.1004144-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115163555.1004144-1-hca@linux.ibm.com>

Le Mon, Jan 15, 2024 at 05:35:55PM +0100, Heiko Carstens a écrit :
> When offlining and onlining CPUs the overall reported idle and iowait
> times as reported by /proc/stat jump backward and forward:
> 
> > cat /proc/stat
> cpu  132 0 176 225249 47 6 6 21 0 0
> cpu0 80 0 115 112575 33 3 4 18 0 0
> cpu1 52 0 60 112673 13 3 1 2 0 0
> 
> > chcpu -d 1
> > cat /proc/stat
> cpu  133 0 177 226681 47 6 6 21 0 0
> cpu0 80 0 116 113387 33 3 4 18 0 0
> 
> > chcpu -e 1
> > cat /proc/stat
> cpu  133 0 178 114431 33 6 6 21 0 0 <---- jump backward
> cpu0 80 0 116 114247 33 3 4 18 0 0
> cpu1 52 0 61 183 0 3 1 2 0 0        <---- idle + iowait start with 0
> 
> > chcpu -d 1
> > cat /proc/stat
> cpu  133 0 178 228956 47 6 6 21 0 0 <---- jump forward
> cpu0 81 0 117 114929 33 3 4 18 0 0
> 
> Reason for this is that get_idle_time() in fs/proc/stat.c has different
> sources for both values depending on if a CPU is online or offline:
> 
> - if a CPU is online the values may be taken from its per cpu
>   tick_cpu_sched structure
> 
> - if a CPU is offline the values are taken from its per cpu cpustat
>   structure
> 
> The problem is that the per cpu tick_cpu_sched structure is set to zero on
> CPU offline. See tick_cancel_sched_timer() in kernel/time/tick-sched.c.
> 
> Therefore when a CPU is brought offline and online afterwards both its idle
> and iowait sleeptime will be zero, causing a jump backward in total system
> idle and iowait sleeptime. In a similar way if a CPU is then brought
> offline again the total idle and iowait sleeptimes will jump forward.
> 
> It looks like this behavior was introduced with commit 4b0c0f294f60
> ("tick: Cleanup NOHZ per cpu data on cpu down").
> 
> This was only noticed now on s390, since we switched to generic idle time
> reporting with commit be76ea614460 ("s390/idle: remove arch_cpu_idle_time()
> and corresponding code").
> 
> Fix this by preserving the values of idle_sleeptime and iowait_sleeptime
> members of the per-cpu tick_sched structure on CPU hotplug.
> 
> Fixes: 4b0c0f294f60 ("tick: Cleanup NOHZ per cpu data on cpu down")
> Reported-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  kernel/time/tick-sched.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index a17d26002831..d2501673028d 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1576,13 +1576,18 @@ void tick_setup_sched_timer(void)
>  void tick_cancel_sched_timer(int cpu)
>  {
>  	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
> +	ktime_t idle_sleeptime, iowait_sleeptime;
>  
>  # ifdef CONFIG_HIGH_RES_TIMERS
>  	if (ts->sched_timer.base)
>  		hrtimer_cancel(&ts->sched_timer);
>  # endif
>  
> +	idle_sleeptime = ts->idle_sleeptime;
> +	iowait_sleeptime = ts->iowait_sleeptime;
>  	memset(ts, 0, sizeof(*ts));
> +	ts->idle_sleeptime = idle_sleeptime;
> +	ts->iowait_sleeptime = iowait_sleeptime;

And this is safe because it is in global stop machine. So we are
guaranteed that nobody sees the transitionning state. In the worst
case ts->idle_sleeptime_seq is observed as changed to 0 in read_seqcount_retry()
and the values are simply fetched again.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

This makes me think that we should always use cpustat[CPUTIME_IDLE] instead of
maintaining this separate ts->idle_sleeptime field. kcpustat even has a seqcount
that would make ts->idle_sleeptime_seq obsolete. Then the tick based idle accounting
could disappear on nohz, along with a few hacks. Instead of that we are
currently maintaining two different idle accounting that are roughly the same.

But anyway this is all a different story, just mumbling to myself for the next
nohz cleanups.

Thanks!

