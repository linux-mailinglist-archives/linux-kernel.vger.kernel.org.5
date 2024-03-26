Return-Path: <linux-kernel+bounces-119491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B1288C9A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F245B2487A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7311757E;
	Tue, 26 Mar 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUgvsFer"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C45479F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471345; cv=none; b=OiI/zw0Q7LuQEHf4QsBUh2QDYfhwHpTY8nafnahQQzU0Im5LPjSqCiLF8zeodTcv3FqAQNa5hY0KwabJsbOEM3qOQ2mLCmQiNqu+2lZ+NVh+TIVJRr8LOOLj6PCdqVF5oa7fEKXupyBp6mkgcEXDhPyWiQx5foRcFHUN09CuW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471345; c=relaxed/simple;
	bh=lMhVc2v7bRz8k8LdU4TXbYBFsE7OwpYvUfGmmJADg0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF5vuo61l9ZpyyarhBp6bcCVvTvUNgWxCiEcDxIzzVuB7ynDrwh8ul5YdFC0/70CxchzJy6KBjn03dgMW3KQbo0aPJN8UN7xzOYT05kIRQ1mn/HLY134757yYTffqhRgkuuJoaCucDq7zlPydPc0kSM7nxIa1JIZg0xtvtl5Ke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUgvsFer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DEFC433C7;
	Tue, 26 Mar 2024 16:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711471345;
	bh=lMhVc2v7bRz8k8LdU4TXbYBFsE7OwpYvUfGmmJADg0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUgvsFercPZRojON0Wjsk9l8PnkwtZsfWQlIKS0uzTzIU8hz/uN1R63K895yLAx9U
	 PYFQBcCPS7dIZ3tLuFSCPgIEPBpqVFRfKbo5b1/TlPjnbly+XfT30dzn4g+vfVLfBo
	 2+EIUYJtEdL7wBPfsOeTvLiPHf0rhQx/lLKly6WBGWJ683Y6R5z0+C6Pi1ZA138gkQ
	 vSICCbX22K/35I09L8hhmzS5uxBSJk4o7aIQdkxZ2FXqpH1MDqcA7s/BXsD+VfVVxU
	 KAzcclVJR+ddKYpiq5uTViHU90bq9mnR9xj0TivnjmxBh9iLwrzRLnJFu4Wsgf6ZRv
	 KVIDbV3oJEkXA==
Date: Wed, 27 Mar 2024 00:29:08 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] riscv: nommu: use CSR_TIME* for get_cycles*
 implementation
Message-ID: <ZgL31BFWvaLwYQrN@xhacker>
References: <20240325164021.3229-1-jszhang@kernel.org>
 <20240325164021.3229-3-jszhang@kernel.org>
 <b063df9b-90b6-4f06-8be5-5a8c267e6c8d@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b063df9b-90b6-4f06-8be5-5a8c267e6c8d@sifive.com>

On Mon, Mar 25, 2024 at 09:39:26PM -0500, Samuel Holland wrote:
> Hi Jisheng,
> 
> On 2024-03-25 11:40 AM, Jisheng Zhang wrote:
> > Per riscv privileged spec, "The time CSR is a read-only shadow of the
> > memory-mapped mtime register", "On RV32I the timeh CSR is a read-only
> > shadow of the upper 32 bits of the memory-mapped mtime register, while
> > time shadows only the lower 32 bits of mtime." Since get_cycles() only
> > reads the timer, it's fine to use CSR_TIME to implement get_cycles().
> 
> Unfortunately there are various implementations (e.g. FU740/Unmatched, probably
> K210 which this code was originally used for) which do not implement the time
> CSR, relying on M-mode software to emulate the CSR so S-mode software doesn't
> notice. So this code is needed to support those platforms when running Linux in
> M-mode.

OOPS, I knew this for the first time there are such implementations
which doesn't implement the TIME CSR :(

> 
> Maybe there should be an option to assume the time CSR is/is not implemented,
> like there is for misaligned access?

Yep, this seems the only solution. Then which should be the default
choice? I.E

Assume all NOMMU goes through TIME CSR, and provide an option for
platform lacking of TIME CSR. This prefers TIME CSR.

VS.

By default, MTIME is used, and provide one Kconfig option for TIME CSR
usage. This prefers MTIME

which choice is better? Any suggestion?

Thanks in advance

> 
> Regards,
> Samuel
> 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/include/asm/timex.h | 40 ----------------------------------
> >  1 file changed, 40 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> > index a06697846e69..a3fb85d505d4 100644
> > --- a/arch/riscv/include/asm/timex.h
> > +++ b/arch/riscv/include/asm/timex.h
> > @@ -10,44 +10,6 @@
> >  
> >  typedef unsigned long cycles_t;
> >  
> > -#ifdef CONFIG_RISCV_M_MODE
> > -
> > -#include <asm/clint.h>
> > -
> > -#ifdef CONFIG_64BIT
> > -static inline cycles_t get_cycles(void)
> > -{
> > -	return readq_relaxed(clint_time_val);
> > -}
> > -#else /* !CONFIG_64BIT */
> > -static inline u32 get_cycles(void)
> > -{
> > -	return readl_relaxed(((u32 *)clint_time_val));
> > -}
> > -#define get_cycles get_cycles
> > -
> > -static inline u32 get_cycles_hi(void)
> > -{
> > -	return readl_relaxed(((u32 *)clint_time_val) + 1);
> > -}
> > -#define get_cycles_hi get_cycles_hi
> > -#endif /* CONFIG_64BIT */
> > -
> > -/*
> > - * Much like MIPS, we may not have a viable counter to use at an early point
> > - * in the boot process. Unfortunately we don't have a fallback, so instead
> > - * we just return 0.
> > - */
> > -static inline unsigned long random_get_entropy(void)
> > -{
> > -	if (unlikely(clint_time_val == NULL))
> > -		return random_get_entropy_fallback();
> > -	return get_cycles();
> > -}
> > -#define random_get_entropy()	random_get_entropy()
> > -
> > -#else /* CONFIG_RISCV_M_MODE */
> > -
> >  static inline cycles_t get_cycles(void)
> >  {
> >  	return csr_read(CSR_TIME);
> > @@ -60,8 +22,6 @@ static inline u32 get_cycles_hi(void)
> >  }
> >  #define get_cycles_hi get_cycles_hi
> >  
> > -#endif /* !CONFIG_RISCV_M_MODE */
> > -
> >  #ifdef CONFIG_64BIT
> >  static inline u64 get_cycles64(void)
> >  {
> 

