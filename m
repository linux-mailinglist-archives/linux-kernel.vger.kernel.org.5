Return-Path: <linux-kernel+bounces-122766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F93388FCE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AD42990E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73167BB1C;
	Thu, 28 Mar 2024 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQK7GBDe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C114654B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621497; cv=none; b=jJ043T9uiH2QpOtJRM4iAxicnP50Vui36QL5DfJdjyjaAjIYagPntVic/df7jt6SjBMDgS4KREsEW9gHU5aPxjPMkw2QpdSmy2cOR4IcLWKOfl5pyxqHSXkPvb4KrQtJBExYEF4q7Ha7QZ9gTxqWXqfs+v0uAsrEsENONtCY87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621497; c=relaxed/simple;
	bh=1cx1Xifn9yhAxfZ5u2l/0D09nOJTgLrcayVsJ8qGHPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0g35GBHV4g0Q4BSmXcM6eLdlQrpQgx5bqtw1xDqOjKZ9q2TOHwzEKAxEjohW/+lMxRb1EBuBj8zrZUTDw4P8yRoPbQB0NR6QRezXS2HMaALgB1+jl1zH8gNjdgam7IO5LyXi63S/3xCybRZgDVQwabz/mpQ1BvFHfWq69/PkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQK7GBDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B64C433C7;
	Thu, 28 Mar 2024 10:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711621496;
	bh=1cx1Xifn9yhAxfZ5u2l/0D09nOJTgLrcayVsJ8qGHPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQK7GBDe1wsZlOAAMHiYgXEi6nC6ZSDIE6GsMksCXpsOEpueKiDPu5ma+SruGSoG4
	 KNMXCq9vhjZxFpBvLiUb5jo4C/VoUsNzUxxG/WyH2EueJBJCfhm4iStVss2jpxgxQm
	 1JKVnc+QMLCG9HnxTccidaDLw6C8XpFTf9hx8aKXCMyAPbI2kmybqdd5xsbZnzKmHf
	 Vs+nQrtEbfk4sUxsTJ8IfmF0AGLdmxDhUEgVhK2NQ2NL004wgjOAbyf61BHvtyfd2p
	 OLHoBf5AvQ29YSeymdVlGwpxcJKBIS1xdg/kkGsmatLvyja00DlrNZnIV0PupaMFIl
	 9PhTfVXgLKj7A==
Date: Thu, 28 Mar 2024 18:11:32 +0800
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
Message-ID: <ZgVCVKu5YaBDUULB@xhacker>
References: <20240325164021.3229-1-jszhang@kernel.org>
 <20240325164021.3229-3-jszhang@kernel.org>
 <b063df9b-90b6-4f06-8be5-5a8c267e6c8d@sifive.com>
 <ZgL31BFWvaLwYQrN@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgL31BFWvaLwYQrN@xhacker>

On Wed, Mar 27, 2024 at 12:29:13AM +0800, Jisheng Zhang wrote:
> On Mon, Mar 25, 2024 at 09:39:26PM -0500, Samuel Holland wrote:
> > Hi Jisheng,
> > 
> > On 2024-03-25 11:40 AM, Jisheng Zhang wrote:
> > > Per riscv privileged spec, "The time CSR is a read-only shadow of the
> > > memory-mapped mtime register", "On RV32I the timeh CSR is a read-only
> > > shadow of the upper 32 bits of the memory-mapped mtime register, while
> > > time shadows only the lower 32 bits of mtime." Since get_cycles() only
> > > reads the timer, it's fine to use CSR_TIME to implement get_cycles().
> > 
> > Unfortunately there are various implementations (e.g. FU740/Unmatched, probably
> > K210 which this code was originally used for) which do not implement the time
> > CSR, relying on M-mode software to emulate the CSR so S-mode software doesn't
> > notice. So this code is needed to support those platforms when running Linux in
> > M-mode.
> 
> OOPS, I knew this for the first time there are such implementations
> which doesn't implement the TIME CSR :(
> 
> > 
> > Maybe there should be an option to assume the time CSR is/is not implemented,
> > like there is for misaligned access?
> 
> Yep, this seems the only solution. Then which should be the default
> choice? I.E
> 
> Assume all NOMMU goes through TIME CSR, and provide an option for
> platform lacking of TIME CSR. This prefers TIME CSR.

Hi all,

v2 will prefer TIME CSR.

Thanks

> 
> VS.
> 
> By default, MTIME is used, and provide one Kconfig option for TIME CSR
> usage. This prefers MTIME
> 
> which choice is better? Any suggestion?
> 
> Thanks in advance
> 
> > 
> > Regards,
> > Samuel
> > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/riscv/include/asm/timex.h | 40 ----------------------------------
> > >  1 file changed, 40 deletions(-)
> > > 
> > > diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> > > index a06697846e69..a3fb85d505d4 100644
> > > --- a/arch/riscv/include/asm/timex.h
> > > +++ b/arch/riscv/include/asm/timex.h
> > > @@ -10,44 +10,6 @@
> > >  
> > >  typedef unsigned long cycles_t;
> > >  
> > > -#ifdef CONFIG_RISCV_M_MODE
> > > -
> > > -#include <asm/clint.h>
> > > -
> > > -#ifdef CONFIG_64BIT
> > > -static inline cycles_t get_cycles(void)
> > > -{
> > > -	return readq_relaxed(clint_time_val);
> > > -}
> > > -#else /* !CONFIG_64BIT */
> > > -static inline u32 get_cycles(void)
> > > -{
> > > -	return readl_relaxed(((u32 *)clint_time_val));
> > > -}
> > > -#define get_cycles get_cycles
> > > -
> > > -static inline u32 get_cycles_hi(void)
> > > -{
> > > -	return readl_relaxed(((u32 *)clint_time_val) + 1);
> > > -}
> > > -#define get_cycles_hi get_cycles_hi
> > > -#endif /* CONFIG_64BIT */
> > > -
> > > -/*
> > > - * Much like MIPS, we may not have a viable counter to use at an early point
> > > - * in the boot process. Unfortunately we don't have a fallback, so instead
> > > - * we just return 0.
> > > - */
> > > -static inline unsigned long random_get_entropy(void)
> > > -{
> > > -	if (unlikely(clint_time_val == NULL))
> > > -		return random_get_entropy_fallback();
> > > -	return get_cycles();
> > > -}
> > > -#define random_get_entropy()	random_get_entropy()
> > > -
> > > -#else /* CONFIG_RISCV_M_MODE */
> > > -
> > >  static inline cycles_t get_cycles(void)
> > >  {
> > >  	return csr_read(CSR_TIME);
> > > @@ -60,8 +22,6 @@ static inline u32 get_cycles_hi(void)
> > >  }
> > >  #define get_cycles_hi get_cycles_hi
> > >  
> > > -#endif /* !CONFIG_RISCV_M_MODE */
> > > -
> > >  #ifdef CONFIG_64BIT
> > >  static inline u64 get_cycles64(void)
> > >  {
> > 

