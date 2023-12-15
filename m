Return-Path: <linux-kernel+bounces-1501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2C3814F70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515C21C2339E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79AA30130;
	Fri, 15 Dec 2023 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eTnHlTcH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SWok+9gS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22CD30101;
	Fri, 15 Dec 2023 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702663499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BsQkgGa4kFZd/QzP7dWUDY7LN64MdMPvZdypP4NCXM=;
	b=eTnHlTcHAA6aFUIYuefhJE5Tg/B6rIrLsCqceQkx/6TsyoS5nHgvlF32Fkzr7aqd4vGclw
	3tmac3gI56i7rNW022mne+CBg9DrhNts5hTmYbZ/OnQByLj1DmaIE9lNQ1QmzmnyeaOkAl
	YzWD+GgBI6ndXgbA6/pz6O3gOId5/Hw3qBmrc6tDcvKvGIZg6fqnoX1gDT3xRjJpxeR/bI
	mx0ajxulLWmsCu3LyxFeXG/v3RBp3Gmo2HDjr61VEaMWarmKMFSu+pzKjThHnq5XnYIx+l
	Hvfhr+MZISO/GuNco+cvh5vZZ+75aNR0RjZecWyQO3EzCuqZIx5qM32RZNMj7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702663499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BsQkgGa4kFZd/QzP7dWUDY7LN64MdMPvZdypP4NCXM=;
	b=SWok+9gSW5dSAdMGoLKeZ9wnwH8813dZnUW5u7iJCaDV9NsYCzYcsofeCBgut3ImUex4O1
	3pSUKF+O9XWcn1DA==
To: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
 reibax@gmail.com, davem@davemloft.net, rrameshbabu@nvidia.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 maheshb@google.com, maimon.sagi@gmail.com
Subject: Re: [PATCH v2] posix-timers: add multi_clock_gettime system call
In-Reply-To: <20231127153901.6399-1-maimon.sagi@gmail.com>
References: <20231127153901.6399-1-maimon.sagi@gmail.com>
Date: Fri, 15 Dec 2023 19:04:59 +0100
Message-ID: <87wmtfmjec.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 27 2023 at 17:39, Sagi Maimon wrote:
>  Some user space applications need to read some clocks.
>  Each read requires moving from user space to kernel space.
>  This asymmetry causes the measured offset to have a significant
>  error.

I can't figure out what you want to tell me here. Where is an asymmetry?

>  Introduce a new system call multi_clock_gettime, which can be used to measure
>  the offset between multiple clocks, from variety of types: PHC, virtual PHC
>  and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
>  The offset includes the total time that the driver needs to read the clock
>  timestamp.

What for? You still fail to explain the problem this is trying to solve.

> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -260,4 +260,28 @@ void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
>  int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
>  
>  void posixtimer_rearm(struct kernel_siginfo *info);
> +
> +#define MULTI_PTP_MAX_CLOCKS 12 /* Max number of clocks */
> +#define MULTI_PTP_MAX_SAMPLES 10 /* Max allowed offset measurement samples. */
> +
> +struct __ptp_multi_clock_get {
> +	unsigned int n_clocks; /* Desired number of clocks. */
> +	unsigned int n_samples; /* Desired number of measurements per clock. */
> +	const clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock IDs */
> +	/*
> +	 * Array of list of n_clocks clocks time samples n_samples times.
> +	 */
> +	struct  __kernel_timespec ts[MULTI_PTP_MAX_SAMPLES][MULTI_PTP_MAX_CLOCKS];
> +};
> +
> +struct __ptp_multi_clock_get32 {
> +	unsigned int n_clocks; /* Desired number of clocks. */
> +	unsigned int n_samples; /* Desired number of measurements per clock. */
> +	const clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock IDs */
> +	/*
> +	 * Array of list of n_clocks clocks time samples n_samples times.
> +	 */
> +	struct  old_timespec32
>  ts[MULTI_PTP_MAX_SAMPLES][MULTI_PTP_MAX_CLOCKS];

Seriously now. We are not adding new syscalls which take compat
timespecs. Any user space application which wants to use a new syscall
which takes a timespec needs to use the Y2038 safe variant.

Aside of that you define a data structure for a syscall in a kernel only
header. How is user space supposed to know the struct?

>  
> +SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get __user *, ptp_multi_clk_get)
> +{
> +	const struct k_clock *kc;
> +	struct timespec64 kernel_tp;
> +	struct __ptp_multi_clock_get multi_clk_get;
> +	int error;
> +	unsigned int i, j;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +
> +	if (copy_from_user(&multi_clk_get, ptp_multi_clk_get, sizeof(multi_clk_get)))
> +		return -EFAULT;
> +
> +	if (multi_clk_get.n_samples > MULTI_PTP_MAX_SAMPLES)
> +		return -EINVAL;
> +	if (multi_clk_get.n_clocks > MULTI_PTP_MAX_CLOCKS)
> +		return -EINVAL;
> +
> +	for (j = 0; j < multi_clk_get.n_samples; j++) {
> +		for (i = 0; i < multi_clk_get.n_clocks; i++) {
> +			kc = clockid_to_kclock(multi_clk_get.clkid_arr[i]);
> +			if (!kc)
> +				return -EINVAL;
> +			error = kc->clock_get_timespec(multi_clk_get.clkid_arr[i], &kernel_tp);
> +			if (!error && put_timespec64(&kernel_tp, (struct __kernel_timespec __user *)
> +						     &ptp_multi_clk_get->ts[j][i]))
> +				error = -EFAULT;

So this reads a clock from a specific clock id and stores the timestamp
in that user space array.

And how is this solving any of the claims you make in the changelog:

    >  Introduce a new system call multi_clock_gettime, which can be used to measure
    >  the offset between multiple clocks, from variety of types: PHC, virtual PHC
    >  and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
    >  The offset includes the total time that the driver needs to read the clock
    >  timestamp.

That whole thing is not really different from N consecutive syscalls as
it does not provide and guarantee vs. the gaps between the readouts.

The common case might be closer to what you try to measure, as it avoids
the syscall overhead (which is marginal) but other than that it's
subject to be interrupted and preempted. So the worst case gaps between
the indiviual clock reads is unspecified.

IOW, this is nothing else than wishful thinking and does not solve any real
world problem at all.

Thanks,

        tglx

