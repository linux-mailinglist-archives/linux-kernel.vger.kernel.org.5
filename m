Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3834A7FAEE4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjK1AL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjK1ALz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:11:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14771B1;
        Mon, 27 Nov 2023 16:12:01 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cf974e87d9so7042725ad.1;
        Mon, 27 Nov 2023 16:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701130321; x=1701735121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v2cp0hCV3ukeXzrGKrc9yDyHnZlZPc+ZpdONAR2TiuI=;
        b=Yf7EBsopxpGqYHff2Y9+XDRga7aTmDoGrmfLWjiml81uwsKH3XeGP5uYwTVbdzjyFm
         DjRkBonS+qNUmBWEdpH2ItHsfXYy6y8GtrhHpTWps2jL7QN0v+j85zrvOk019ZQ2uDnZ
         Or1I8Wo5TQhF1nlgrCKddy5MfV8wGyKaGh9YQXiaSjkcGSn7KgSNZxr1EDVIPfL8Mi0r
         ftqP06WCf7cF4t1Pl3VuaJU8Ner2MSrphvhN4wHVwVVq64Y3dnWbrMRErPWTjcgezQtj
         sZznPjmwZUtWGkCoKRMZNXDtljgYCG3Fx6pcvSuIzCtjvHbHj8Ba6S49JK6yKXm2h58j
         j1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701130321; x=1701735121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2cp0hCV3ukeXzrGKrc9yDyHnZlZPc+ZpdONAR2TiuI=;
        b=d2YRu2vrMkhJvvkkRpljW3TSdDNI/B4P3/HgQuYuC3CcUsiUKVc5UjgzgvKSD2RJRJ
         GvYdxtx/5LHv33x8IC4shG/qkhWKolcE9feSXIoVwuxVxZs587BTH899sFenQxfjhg/1
         Sj7ObikQgvUragcNqD3xG1IhbhEajir6zurswxTMVlytRSGR5sIdJrdMx+P6p0yms0x3
         qqI6od6aSZWf1aZ7kTvHIoIBfUdZigVpexL2H2GizL1jZmaFMQm8gckU/a1yOXVNRdIz
         qvKi2Kb+gVGGa8YwbZJzWxeZRfNCM1myrA5RA7kpSrANbzE42EBXhXHkYFzmy6JM0sPy
         1vbw==
X-Gm-Message-State: AOJu0YwVucrjwP3AuOyGmlq1gHDw14PSIQN4hwVciY+oPdYWJe4QXUAe
        UduiKPKdlnMfBWoiRJAesog=
X-Google-Smtp-Source: AGHT+IHwEE6OZJkKu6cjd4labT8nhAMbaFsJBc/61pTVrwTlM5Oo8b5TPo9PljIBG5q1IjiUNainmA==
X-Received: by 2002:a17:902:f683:b0:1cf:c680:f37f with SMTP id l3-20020a170902f68300b001cfc680f37fmr6781580plg.2.1701130321121;
        Mon, 27 Nov 2023 16:12:01 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ec8500b001cfa718039bsm6739204plg.216.2023.11.27.16.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:12:00 -0800 (PST)
Date:   Mon, 27 Nov 2023 16:11:58 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Sagi Maimon <maimon.sagi@gmail.com>
Cc:     reibax@gmail.com, davem@davemloft.net, rrameshbabu@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maheshb@google.com, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>
Subject: Re: [PATCH v2] posix-timers: add multi_clock_gettime system call
Message-ID: <ZWUwTnWEHipJqHnk@hoboy.vegasvil.org>
References: <20231127153901.6399-1-maimon.sagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127153901.6399-1-maimon.sagi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 05:39:01PM +0200, Sagi Maimon wrote:
>  Some user space applications need to read some clocks.
>  Each read requires moving from user space to kernel space.
>  This asymmetry causes the measured offset to have a significant error.

Adding time/clock gurus (jstultz, tglx) on CC for visibility...

Thanks,
Richard


> 
>  Introduce a new system call multi_clock_gettime, which can be used to measure
>  the offset between multiple clocks, from variety of types: PHC, virtual PHC
>  and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
>  The offset includes the total time that the driver needs to read the clock
>  timestamp.
> 
>  New system call allows the reading of a list of clocks - up to PTP_MAX_CLOCKS.
>  Supported clocks IDs: PHC, virtual PHC and various system clocks.
>  Up to PTP_MAX_SAMPLES times (per clock) in a single system call read.
>  The system call returns n_clocks timestamps for each measurement:
>  - clock 0 timestamp
>  - ...
>  - clock n timestamp
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
>  Addressed comments from:
>  - Richard Cochran : https://www.spinics.net/lists/netdev/msg951723.html
>           
>  Changes since version 1:
>  - Change multi PHC ioctl implamantation into systemcall.
>  
>  arch/x86/entry/syscalls/syscall_32.tbl |  1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  include/linux/posix-timers.h           | 24 ++++++++++
>  include/linux/syscalls.h               |  3 +-
>  include/uapi/asm-generic/unistd.h      | 12 ++++-
>  kernel/sys_ni.c                        |  1 +
>  kernel/time/posix-timers.c             | 62 ++++++++++++++++++++++++++
>  7 files changed, 102 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index c8fac5205803..070efd266e7e 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -461,3 +461,4 @@
>  454	i386	futex_wake		sys_futex_wake
>  455	i386	futex_wait		sys_futex_wait
>  456	i386	futex_requeue		sys_futex_requeue
> +457	i386	multi_clock_gettime		sys_multi_clock_gettime32
> \ No newline at end of file
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 8cb8bf68721c..f790330244bb 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -378,6 +378,7 @@
>  454	common	futex_wake		sys_futex_wake
>  455	common	futex_wait		sys_futex_wait
>  456	common	futex_requeue		sys_futex_requeue
> +457	common	multi_clock_gettime		sys_multi_clock_gettime
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
> index d607f51404fc..426a45441ab5 100644
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
> +	struct  old_timespec32 ts[MULTI_PTP_MAX_SAMPLES][MULTI_PTP_MAX_CLOCKS];
> +};
> +
>  #endif
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index fd9d12de7e92..afcf68e83d63 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1161,7 +1161,8 @@ asmlinkage long sys_mmap_pgoff(unsigned long addr, unsigned long len,
>  			unsigned long prot, unsigned long flags,
>  			unsigned long fd, unsigned long pgoff);
>  asmlinkage long sys_old_mmap(struct mmap_arg_struct __user *arg);
> -
> +asmlinkage long sys_multi_clock_gettime(struct __ptp_multi_clock_get __user * ptp_multi_clk_get);
> +asmlinkage long sys_multi_clock_gettime32(struct __ptp_multi_clock_get32 __user * ptp_multi_clk_get);
>  
>  /*
>   * Not a real system call, but a placeholder for syscalls which are
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 756b013fb832..3ebcaa052650 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -829,8 +829,18 @@ __SYSCALL(__NR_futex_wait, sys_futex_wait)
>  #define __NR_futex_requeue 456
>  __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
>  
> +#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
> +#define __NR_multi_clock_gettime 457
> +__SC_3264(__NR_multi_clock_gettime, sys_multi_clock_gettime32, sys_multi_clock_gettime)
> +#endif
> +
> +#if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
> +#define __NR_multi_clock_gettime64 458
> +__SYSCALL(__NR_multi_clock_gettime64, sys_multi_clock_gettime)
> +#endif
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 457
> +#define __NR_syscalls 459
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index e1a6e3c675c0..8ed1c22f40ac 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -335,6 +335,7 @@ COND_SYSCALL(ppoll_time32);
>  COND_SYSCALL_COMPAT(ppoll_time32);
>  COND_SYSCALL(utimensat_time32);
>  COND_SYSCALL(clock_adjtime32);
> +COND_SYSCALL(multi_clock_gettime32);
>  
>  /*
>   * The syscalls below are not found in include/uapi/asm-generic/unistd.h
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index b924f0f096fa..517558af2479 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -1426,6 +1426,68 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
>  
>  #endif
>  
> +SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get __user *, ptp_multi_clk_get)
> +{
> +	const struct k_clock *kc;
> +	struct timespec64 kernel_tp;
> +	struct __ptp_multi_clock_get multi_clk_get;
> +	int error;
> +	unsigned int i, j;
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
> +		}
> +	}
> +
> +	return error;
> +}
> +
> +SYSCALL_DEFINE1(multi_clock_gettime32, struct __ptp_multi_clock_get32 __user *, ptp_multi_clk_get)
> +{
> +	const struct k_clock *kc;
> +	struct timespec64 kernel_tp;
> +	struct __ptp_multi_clock_get multi_clk_get;
> +	int error;
> +	unsigned int i, j;
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
> +			if (!error && put_old_timespec32(&kernel_tp, (struct old_timespec32 __user *)
> +							&ptp_multi_clk_get->ts[j][i]))
> +				error = -EFAULT;
> +		}
> +	}
> +
> +	return error;
> +}
> +
>  static const struct k_clock clock_realtime = {
>  	.clock_getres		= posix_get_hrtimer_res,
>  	.clock_get_timespec	= posix_get_realtime_timespec,
> -- 
> 2.26.3
> 
