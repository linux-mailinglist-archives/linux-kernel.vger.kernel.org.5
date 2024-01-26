Return-Path: <linux-kernel+bounces-40091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C315883DA1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315A22822DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D471B59B;
	Fri, 26 Jan 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQx6XClJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683761B582
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272040; cv=none; b=APjeXCQacZ7J343Ivk6c/iYT65krzz8HLodsbJ5/CmVpS2mE8emhagmhNP7B6b7RF90Hh/rz2WRoNLN77+HlLRB3KI6/IRGEBURnXSCWj1IEUdWJPGZcao/ka/V5juD3Zx2le8dCqGNjPvEJYxM7GrUiv7+H/qC+3+EfLhL02Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272040; c=relaxed/simple;
	bh=MS6t5nrb2+qmuyRPa+6i0fcFSOifJWg8C7bRDoDElgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5SxX8qqlOmz/+bry2DGepgQlKKU6ls3UWsT8Hiy2+JLIoFPwkg0SCTqRBogaI8qokf1SC00AczF8sdHoBLf8bQbZrH7zqmFI3QXQlSjlvKZNxHkfdTzcvL9uI+JFrq9eiPKsa6ry8pQNjOqQs9ugGGanauhY4sMOLpQf+kxAts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQx6XClJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA31C433F1;
	Fri, 26 Jan 2024 12:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706272039;
	bh=MS6t5nrb2+qmuyRPa+6i0fcFSOifJWg8C7bRDoDElgA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VQx6XClJg+EHecouMGKVXlu66uSDNTd1qlM5qzftdFJRHCmYnO3gadEn1FE8LgPG3
	 KBxTxHBJxuAIDbIJEhDXuwcHxBiVg8Ggw092V7g+/XBSLUOEfXXLnbcmX/trJLqPYB
	 Dc66uyh1F5vKxE9IJQ0KKEV1+gnIWkUg58MbW5T3VGfPegZqnRaLwlFQtUZN7U3QOu
	 3Tsx/LF2GwzTIIyscs/DrM/r5DmlymR+1ILPB5SkWZO98HEQrkTPLFZ4L7S7JVyirm
	 Ok8z5VrhJYC/BLxXVLtfg8ztUzX6FFJiEpJm1kUQXgMdZdjtbmpAQu195wXFL/qnQM
	 Ym3/LHh+kbFiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6DD87CE190E; Fri, 26 Jan 2024 04:27:19 -0800 (PST)
Date: Fri, 26 Jan 2024 04:27:19 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Feng Tang <feng.tang@intel.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Jin Wang <jin1.wang@intel.com>
Subject: Re: [PATCH] clocksource: Scale the max retry number of watchdog read
 according to CPU numbers
Message-ID: <3b3d9499-dc7a-4ea0-9615-526940f5fcf2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240126091250.79985-1-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126091250.79985-1-feng.tang@intel.com>

On Fri, Jan 26, 2024 at 05:12:50PM +0800, Feng Tang wrote:
> There was a bug on one 8-socket server that the TSC is wrongly marked as
> 'unstable' and disabled during boot time. (reproduce rate is every 120
> rounds of reboot tests), with log:
> 
>     clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
>     wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
>     tsc: Marking TSC unstable due to clocksource watchdog
>     TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
>     sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
>     clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
>     clocksource: Switched to clocksource hpet
> 
> The reason is for platform with lots of CPU, there are sporadic big or huge
> read latency of read watchog/clocksource during boot or when system is under
> stress work load, and the frequency and maximum value of the latency goes up
> with the increasing of CPU numbers. Current code already has logic to detect
> and filter such high latency case by reading 3 times of watchdog, and check
> the 2 deltas. Due to the randomness of the latency, there is a low possibility
> situation that the first delta (latency) is big, but the second delta is small
> and looks valid, which can escape from the check, and there is a
> 'max_cswd_read_retries' for retrying that check covering this case, whose
> default value is only 2 and may be not enough for machines with huge number
> of CPUs.
> 
> So scale and enlarge the max retry number according to CPU number to better
> filter those latency noise on large system, which has been verified fine in
> 4 days and 670 rounds of reboot test on the 8-socket machine.
> 
> Tested-by: Jin Wang <jin1.wang@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  kernel/time/clocksource.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index c108ed8a9804..f15283101906 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -226,6 +226,15 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>  	u64 wd_end, wd_end2, wd_delta;
>  	int64_t wd_delay, wd_seq_delay;
>  
> +	/*
> +	 * If no user changes the default value, scale the retry threshold
> +	 * according to CPU numbers. As per test, the more CPU a platform has,
> +	 * the bigger read latency is found during boot time or under stress
> +	 * work load. Increase the try nubmer to reduce false alarms.
> + 	 */
> +	if (max_cswd_read_retries == 2)

I like the self-adjusting behavior!

But why not make max_cswd_read_retries be a long (instead of a ulong)
defaulting to -1.  Then when someone sets it to a specific positive
value, they get exactly that value, while leaving it -1 gets the default
CPU-scaling behavior.  Zero and other negative values should get a
warning in order to reserve the for possible future use.

I also suggest doing the adjustment at boot time, for example, using
an early_initcall().  That way the test code also sees the scaled value.

							Thanx, Paul

> +		max_cswd_read_retries = max(2, ilog2(num_online_cpus()));
> +
>  	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
>  		local_irq_disable();
>  		*wdnow = watchdog->read(watchdog);
> -- 
> 2.34.1
> 

