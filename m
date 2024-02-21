Return-Path: <linux-kernel+bounces-74151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE4D85D080
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763971F2433D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EEE22618;
	Wed, 21 Feb 2024 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dnxuGOqj"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C224A1D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497223; cv=none; b=Svl25o6hUjAvzrN5iGUZVV/oZHs1cGbI1L3dbo3cHDx80Mg+yu5uBAo6HmRfqNszekCInP5Sdf71hYU4fOcWRA5P6b3cef3KBRd8/IvFv8orfEH5f0jxOfJcNyCXl4hwskmsxLaWSJs0pzdAvLoQgkmWdsZIM/JyB+5JmGHwBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497223; c=relaxed/simple;
	bh=9U1qnNv3hOvzoqGjHv7re9Rl7YDROl8tLzYgiXvD8C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgnUcHoXRz1qM2Sy8fFtq/ZsCUi9AOm8QAQWpkIwlZHrmjhMt2GQIZYi5rSvyIHLCx4YMj+CgqtoI/rbMSSVpugiho6IkdgFD4DrF42EZU8pBaXT0MzRfjUUy3sMEniCayxkZVwY25XhYPqxffO6wBszqBYYOsHrvpxfl2cpUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dnxuGOqj; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e461a9e40eso603966a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708497220; x=1709102020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzG1h3rFdE35vHs4nCO34Dzxpa3CLJjuLbNEkFJHymk=;
        b=dnxuGOqjQYE1lvChAb1rUVy8+8bd0kZhJXAef+kOuUKVHoC4IyZ5hfd/qZMjiTAfBx
         Bjvw8nzmeVSi0XwZPS+VKmR/4CVOdIt75fwcaciPxVIAfZye+e6mEGh+jTuO7c0PBQPQ
         yG+NxBxgHMo4vbbyXpP8gK/QtXWUWA/VvOw+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708497220; x=1709102020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzG1h3rFdE35vHs4nCO34Dzxpa3CLJjuLbNEkFJHymk=;
        b=cKt1Bmc88qc4h4I0SemCN2Kb/i2nS9N8sQkX9SQ2jAu0k1eW22dph5ReEYNx/yM1gJ
         qlIC3QY0oLKzaVzMLHDytjpecsP75l2JUpa2CaCmyDWeGfsxX5bOy6AENK137Tp1BfUY
         6KJfscDF/hwhx4+gMQ65tNi4RK4p3LEdUjvT0F83xOuat09fV7lyooSTiD/SFvfFayDA
         /KwrjqI0ht1MT4qHRn3Q9SUkepXf63Li6dw3xgPtrkX46gZy0wkCclpugy1iZp9VV9ok
         dT+OJ5OcMKxQLQV8hyeUG0ZB523L02E86n3erDP4OidayF19gsx6bxMcjlNzMOzXDQPU
         +hiw==
X-Forwarded-Encrypted: i=1; AJvYcCXmjpjfFvTXaPKuFRVCf1fkZtZbLdt8ZqecwE8BGglUS61uY5vEqqg9JsxW71ko46EO683sRresWXnEiNBp2Xz1MKGry8lfhLENv4vx
X-Gm-Message-State: AOJu0YxN1Jcy7Pqd55dQ3Gg6Ij9qrMTmJvTTNiFo8lLdqDWfID+hbHKn
	ztZucCyVggvjUKJRRVO7ENV+J40Fptsfocop9bUPizYX49jEeTf5KxfFtb0tfw==
X-Google-Smtp-Source: AGHT+IHS0EkkrYoLQUwOe/rW4LoTJCwu0I6ZorfS97z10oAfJ3Ro71jhHZu8xNKWwV345YFzvVeUNg==
X-Received: by 2002:a05:6871:3a2a:b0:21e:d654:5c3f with SMTP id pu42-20020a0568713a2a00b0021ed6545c3fmr8228175oac.37.1708497220277;
        Tue, 20 Feb 2024 22:33:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n14-20020a635c4e000000b005dc2ca5b667sm6682307pgm.10.2024.02.20.22.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:33:39 -0800 (PST)
Date: Tue, 20 Feb 2024 22:33:39 -0800
From: Kees Cook <keescook@chromium.org>
To: Jeremy Linton <jeremy.linton@arm.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, gustavoars@kernel.org, mark.rutland@arm.com,
	rostedt@goodmis.org, arnd@arndb.de, broonie@kernel.org,
	guohui@uniontech.com, Manoj.Iyer@arm.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	James Yang <james.yang@arm.com>,
	Shiyou Huang <shiyou.huang@arm.com>
Subject: Re: [RFC] arm64: syscall: Direct PRNG kstack randomization
Message-ID: <202402202226.A6817927@keescook>
References: <20240221020258.1210148-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221020258.1210148-1-jeremy.linton@arm.com>

On Tue, Feb 20, 2024 at 08:02:58PM -0600, Jeremy Linton wrote:
> The existing arm64 stack randomization uses the kernel rng to acquire
> 5 bits of address space randomization. This is problematic because it
> creates non determinism in the syscall path when the rng needs to be
> generated or reseeded. This shows up as large tail latencies in some
> benchmarks and directly affects the minimum RT latencies as seen by
> cyclictest.

Some questions:

- for benchmarks, why not disable kstack randomization?
- if the existing pRNG reseeding is a problem here, why isn't it a
  problem in the many other places it's used?
- I though the pRNG already did out-of-line reseeding?

> Other architectures are using timers/cycle counters for this function,
> which is sketchy from a randomization perspective because it should be
> possible to estimate this value from knowledge of the syscall return
> time, and from reading the current value of the timer/counters.

The expectation is that it would be, at best, unstable.

> So, a poor rng should be better than the cycle counter if it is hard
> to extract the stack offsets sufficiently to be able to detect the
> PRNG's period.
> 
> So, we can potentially choose a 'better' or larger PRNG, going as far
> as using one of the CSPRNGs already in the kernel, but the overhead
> increases appropriately. Further, there are a few options for
> reseeding, possibly out of the syscall path, but is it even useful in
> this case?

I'd love to find a way to avoid an pRNG that could be reconstructed
given enough samples. (But perhaps this xorshift RNG resists that?)

-Kees

> Reported-by: James Yang <james.yang@arm.com>
> Reported-by: Shiyou Huang <shiyou.huang@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/syscall.c | 55 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 9a70d9746b66..70143cb8c7be 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -37,6 +37,59 @@ static long __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
>  	return syscall_fn(regs);
>  }
>  
> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> +DEFINE_PER_CPU(u32, kstackrng);
> +static u32 xorshift32(u32 state)
> +{
> +	/*
> +	 * From top of page 4 of Marsaglia, "Xorshift RNGs"
> +	 * This algorithm is intended to have a period 2^32 -1
> +	 * And should not be used anywhere else outside of this
> +	 * code path.
> +	 */
> +	state ^= state << 13;
> +	state ^= state >> 17;
> +	state ^= state << 5;
> +	return state;
> +}
> +
> +static u16 kstack_rng(void)
> +{
> +	u32 rng = raw_cpu_read(kstackrng);
> +
> +	rng = xorshift32(rng);
> +	raw_cpu_write(kstackrng, rng);
> +	return rng & 0x1ff;
> +}
> +
> +/* Should we reseed? */
> +static int kstack_rng_setup(unsigned int cpu)
> +{
> +	u32 rng_seed;
> +
> +	do {
> +		rng_seed = get_random_u32();
> +	} while (!rng_seed);
> +	raw_cpu_write(kstackrng, rng_seed);
> +	return 0;
> +}
> +
> +static int kstack_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/cpuinfo:kstackrandomize",
> +				kstack_rng_setup, NULL);
> +	if (ret < 0)
> +		pr_err("kstack: failed to register rng callbacks.\n");
> +	return 0;
> +}
> +
> +arch_initcall(kstack_init);
> +#else
> +static u16 kstack_rng(void) { return 0; }
> +#endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
> +
>  static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  			   unsigned int sc_nr,
>  			   const syscall_fn_t syscall_table[])
> @@ -66,7 +119,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  	 *
>  	 * The resulting 5 bits of entropy is seen in SP[8:4].
>  	 */
> -	choose_random_kstack_offset(get_random_u16() & 0x1FF);
> +	choose_random_kstack_offset(kstack_rng());
>  }
>  
>  static inline bool has_syscall_work(unsigned long flags)
> -- 
> 2.43.0
> 

-- 
Kees Cook

