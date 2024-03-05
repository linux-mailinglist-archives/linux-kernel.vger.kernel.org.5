Return-Path: <linux-kernel+bounces-93104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5C5872B15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC661C2479A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081FD12D74B;
	Tue,  5 Mar 2024 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDoNyAqj"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54A12D219
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681639; cv=none; b=TESK1X8pkJmPXqUAhInkXw0Kdl5syKYlZvPzz/NU82jOt37+kglfDOLQ/wBwjBigVEbNV2XO30q0FNAMeBouRkoSOzmQiczBaq1LO5VXdIRWTzkbDeSBOT/Sa2Bo1Nz7lTgrPXzSAX6ujXglFd+8MqdXBt7IKLMsUT14DJzwe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681639; c=relaxed/simple;
	bh=1SnJ59Ps7URmLCLfC/TBTkRIQ6+QZh83O+LxVECZ4eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUyMe5lON+6H/vxT48pv9uxL0pJ6Vb3K1PTSpqEl5v1uAyGJw9wNkj6Hq+lNrNzuN9tMDJPHyHyS4IYKdw710fZdb7+z7z/1QWXDibdMn2UjTDmQC+XLY1qpMSZ61jqeRShPlQRbyTebNUa8eQapprIGKVdD4F/G7KfBpurCGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YDoNyAqj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6381df003so273172b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709681637; x=1710286437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVqJYG4NwJpbVhIQ4ejb78hlZKAflZdt5zQRCQZdbhg=;
        b=YDoNyAqjT4+JsgTrVnl6OAgF1k64GJMlbCpU5D4eDqNf2O9lAGCgFz+aAhOLoIHwhd
         TD7DBSOjOK4eP0tZwdcV4Mv0gyUEaI4uyNQ2nrVSa7h412iV3qbbB3tAONSQjBafu044
         us7oVi+DRKkVfH+7Aq5xqFtH94K1j+tykG6J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681637; x=1710286437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVqJYG4NwJpbVhIQ4ejb78hlZKAflZdt5zQRCQZdbhg=;
        b=tO7fbsBE8tWePQyv0vSAJRzCtxT8bhPE5Y0xaTgNDoWB7sjwtdCKVLnsrZvcls8STG
         5gEUonJPMcHjw/4rgu0zvizMug39LjEA2JNXrFKQTDo/yNJkojwhukWXNFDpS4trb3H9
         6Kj6f32eAHDAysDXL5AV+QRHaNHT/LKY2011fcgquFU+7KFAyHAQsBzxhYhbdBy2qMlG
         AFHkQ1wEDl9Kj1686ijYgQ1PhjGiFix8rIObCKVEcWXfyjb7z5NcgoP++ZZxRitzop/y
         lyEJKsUW+8n5TxdnBgxsgxhnwX+Y9Vt0dQQ2QS7sjAtM7ibJNSiYw4MGDHhhhkQgwe45
         Etgw==
X-Forwarded-Encrypted: i=1; AJvYcCWcpETU4ORr+9x2CN6pyKIcGS80E/aqQN21AGavYuHIQDWQGc0t010cqJEAKrM+Om91VD4HS/k0AQv+G2zLfYMPnb5sxO0ttNM1vGEM
X-Gm-Message-State: AOJu0YzSEle0M8Js+tAnPMFIjfEgn1SmdJKzcQcqdjXTUO8T/Mk4Eeex
	1dkg41YvWa/6Xq5HXwEpeTxl0kFna5jHrwd9uxplnXcbuxgZgj3Wq1YaG4gm6g==
X-Google-Smtp-Source: AGHT+IHQdYS5+xMryfTT1IOdZhcc6rZew5WCVjHi9VllATBYGMQVhc0/wPSb9IRr0q52NcbVnxEBdQ==
X-Received: by 2002:a05:6a00:1ac7:b0:6e6:27d3:96ab with SMTP id f7-20020a056a001ac700b006e627d396abmr6963065pfv.16.1709681636969;
        Tue, 05 Mar 2024 15:33:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r5-20020aa79885000000b006e530aca55asm9524721pfl.123.2024.03.05.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:33:55 -0800 (PST)
Date: Tue, 5 Mar 2024 15:33:54 -0800
From: Kees Cook <keescook@chromium.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, Jason@zx2c4.com, gustavoars@kernel.org,
	mark.rutland@arm.com, rostedt@goodmis.org, arnd@arndb.de,
	broonie@kernel.org, guohui@uniontech.com, Manoj.Iyer@arm.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	James Yang <james.yang@arm.com>,
	Shiyou Huang <shiyou.huang@arm.com>
Subject: Re: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
Message-ID: <202403051526.0BE26F99E@keescook>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305221824.3300322-2-jeremy.linton@arm.com>

On Tue, Mar 05, 2024 at 04:18:24PM -0600, Jeremy Linton wrote:
> The existing arm64 stack randomization uses the kernel rng to acquire
> 5 bits of address space randomization. This is problematic because it
> creates non determinism in the syscall path when the rng needs to be
> generated or reseeded. This shows up as large tail latencies in some
> benchmarks and directly affects the minimum RT latencies as seen by
> cyclictest.
> 
> Other architectures are using timers/cycle counters for this function,
> which is sketchy from a randomization perspective because it should be
> possible to estimate this value from knowledge of the syscall return
> time, and from reading the current value of the timer/counters.
> 
> So, a poor rng should be better than the cycle counter if it is hard
> to extract the stack offsets sufficiently to be able to detect the
> PRNG's period. Lets downgrade from get_random_u16() to
> prandom_u32_state() under the theory that the danger of someone
> guessing the 1 in 32 per call offset, is larger than that of being
> able to extract sufficient history to accurately predict future
> offsets. Further it should be safer to run with prandom_u32_state than
> disabling stack randomization for those subset of applications where the
> difference in latency is on the order of ~5X worse.
> 
> Reported-by: James Yang <james.yang@arm.com>
> Reported-by: Shiyou Huang <shiyou.huang@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/syscall.c | 42 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 9a70d9746b66..33b3ea4adff8 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -5,6 +5,7 @@
>  #include <linux/errno.h>
>  #include <linux/nospec.h>
>  #include <linux/ptrace.h>
> +#include <linux/prandom.h>
>  #include <linux/randomize_kstack.h>
>  #include <linux/syscalls.h>
>  
> @@ -37,6 +38,45 @@ static long __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
>  	return syscall_fn(regs);
>  }
>  
> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> +DEFINE_PER_CPU(struct rnd_state, kstackrng);
> +
> +static u16 kstack_rng(void)
> +{
> +	u32 rng = prandom_u32_state(this_cpu_ptr(&kstackrng));
> +
> +	return rng & 0x1ff;
> +}
> +
> +/* Should we reseed? */
> +static int kstack_rng_setup(unsigned int cpu)
> +{
> +	u32 rng_seed;
> +
> +	/* zero should be avoided as a seed */
> +	do {
> +		rng_seed = get_random_u32();
> +	} while (!rng_seed);
> +	prandom_seed_state(this_cpu_ptr(&kstackrng), rng_seed);
> +	return 0;
> +}
> +
> +static int kstack_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/cpuinfo:kstackrandomize",
> +				kstack_rng_setup, NULL);

This will run initial seeding, but don't we need to reseed this with
some kind of frequency?

Otherwise, seems fine to me.

-- 
Kees Cook

