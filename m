Return-Path: <linux-kernel+bounces-50689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B199D847CDE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ACD9B21E02
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4229126F37;
	Fri,  2 Feb 2024 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMK3mHZn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4ED839E1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914864; cv=none; b=GYzbiELWt7pjTArcmkF/M7AXuz4L2p6VnAWoaZLf1K0romU7Otfew2xSz6xljb5HGAcAknkbXiVGIwTjWCH5IibwVwV4n5dNnvLuIn7ooClldb5Oi3cqU3CEK4eR2lXptuFsTMAU/FB0YxXzszFYEawZsY1qMFch+Qc3i96LoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914864; c=relaxed/simple;
	bh=aT1AHnBF7mBOjZaTwOi86ygyf4KXlSwVYeC30/NWI1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw3CZOYbcW83xIukiYJ4fINFFC1yjajzRTjMfCjZlaJS1b4bq35hfMoytv1Env63gJX+u2ar/PLrCZWIwijcHGrpcoSliink7jxL6qOvEpntB0f8+uZKoyfoVvDj3dWxWzpPKSnsIpu/OH86LygEbYazoJWlBwlHSh2Tm2LzvB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMK3mHZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD12C433F1;
	Fri,  2 Feb 2024 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706914863;
	bh=aT1AHnBF7mBOjZaTwOi86ygyf4KXlSwVYeC30/NWI1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMK3mHZnugD1ntQHv4RfpdjacKnxdBJLv428m5TiYZRfxaJSBXQNUxebJ9F9TIV9g
	 qbwTlqDqHtXH4v2RS9JMeEI1FB0eqTQdEdm+XOkP0dlGgICsz3ijIzDJyEDQ/n2P3b
	 2zuF6xor+J5yAXtjfc/BvM3RlTcZC4Dv0q68Y4go2DH7qU/LKsk7ml9dZjNZG7rQp6
	 IuHA/1oWEKtL3iihOl5cakXkdxj8+sgfywvhDL3Z2SRHOLps0WXwATFGpInmuyC8+f
	 v7EM7ciRL0VXiHhU64qij2v12OneZzmljOiB86uJaTNym4mg7eKvs5c8hQWCgMXcSd
	 aiwIoUqJvm8fA==
Date: Fri, 2 Feb 2024 15:01:01 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: Disable misaligned access probe when
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <20240202230101.GB2055@sol.localdomain>
References: <20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com>
 <20240201-disable_misaligned_probe_config-v2-2-77c368bed7b2@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-disable_misaligned_probe_config-v2-2-77c368bed7b2@rivosinc.com>

On Thu, Feb 01, 2024 at 03:30:46PM -0800, Charlie Jenkins wrote:
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index eb3ac304fc42..3a29d8e30e05 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -51,6 +51,7 @@ static inline bool check_unaligned_access_emulated(int cpu)
>  static inline void unaligned_emulation_finish(void) {}
>  #endif
>  
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS

#ifdef..#else..#endif is more readable than #ifndef..#else..#endif.

> diff --git a/arch/riscv/include/asm/misaligned_access_speed.h b/arch/riscv/include/asm/misaligned_access_speed.h
> new file mode 100644
> index 000000000000..81df2aa6fa6b
> --- /dev/null
> +++ b/arch/riscv/include/asm/misaligned_access_speed.h

This new header file isn't included from anywhere.

> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f71910718053..8be7f17da9ab 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -62,6 +62,9 @@ obj-y	+= tests/
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>  
>  obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
> +ifneq ($(RISCV_EFFICIENT_UNALIGNED_ACCESS), y)
> +obj-y	+= misaligned_access_speed.o
> +endif

CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS

> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index a7c56b41efd2..3f1a6edfdb08 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -149,6 +149,7 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
>  
>  static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  {
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	int cpu;
>  	u64 perf = -1ULL;
>  
> @@ -168,6 +169,9 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
>  
>  	return perf;
> +#else
> +	return RISCV_HWPROBE_MISALIGNED_FAST;
> +#endif

#ifdef..#else..#endif is more readable than #ifndef..#else..#endif.

- Eric

