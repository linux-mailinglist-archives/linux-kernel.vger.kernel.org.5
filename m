Return-Path: <linux-kernel+bounces-136726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E56089D79B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18091B21DCF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C7E85954;
	Tue,  9 Apr 2024 11:07:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160418173C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660835; cv=none; b=IQCWLXRkAZvojzaoUvKnrMbegWLHRYlLOu0yY5u5PnFQ3lpQYpQczFsTx9is8gSc6nHRWK+IjPHo/RGMsHLz3i0cL+5fVD16cp40C6HEq7q+PLgQ/MpSjsjk8s6Rq7dMia93ywSxRj/5NVuxu5vY4JCfmIUnnhoYa58VEO4WsGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660835; c=relaxed/simple;
	bh=S6gEhoz00AUAKLXpYmSVxgpwRPlTIEvkdS34TESD09A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX/O/3NNiayt4JIH77k6X/R807Nc7AigktA4vkmgQmkXoxmkzE5/+Sp5HiJSsSXz5dVgazqCzKxLeoX+IoUoDAzRvxTcfdUwPhUkZJKstBk4vk6gqJYdtlWCqur77ARXekPnzXoV+wmGWVyifOPwYhzJL48hjMQsXgVdP+887h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C511DA7;
	Tue,  9 Apr 2024 04:07:43 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.248])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E2653F766;
	Tue,  9 Apr 2024 04:07:11 -0700 (PDT)
Date: Tue, 9 Apr 2024 12:07:05 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/6] locking/atomic/x86: Use READ_ONCE before
 atomic{,64}_try_cmpxchg loops
Message-ID: <ZhUhWcjo556WoTF4@FVFF77S0Q05N>
References: <20240409100503.274629-1-ubizjak@gmail.com>
 <20240409100503.274629-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409100503.274629-4-ubizjak@gmail.com>

On Tue, Apr 09, 2024 at 12:03:54PM +0200, Uros Bizjak wrote:
> The value preload before the cmpxchg loop does not need to be atomic,
> but should use READ_ONCE to prevent compiler from merging, refetching
> or reordering the read.
> 

Yes, and that's what arch_atomic_read() and arch_atomic64_read() do...

> This patch unifies arch_atomic{,64}_{,fetch}_{and,or,xor}() macros
> between x86_32 and x86_64 targets.
> 
> No functional changes intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/x86/include/asm/atomic.h      |  8 ++++----
>  arch/x86/include/asm/atomic64_64.h | 20 ++++++++++----------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
> index 55a55ec04350..b166da21ee98 100644
> --- a/arch/x86/include/asm/atomic.h
> +++ b/arch/x86/include/asm/atomic.h
> @@ -20,7 +20,7 @@ static __always_inline int arch_atomic_read(const atomic_t *v)
>  	 * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
>  	 * it's non-inlined function that increases binary size and stack usage.
>  	 */
> -	return __READ_ONCE((v)->counter);
> +	return __READ_ONCE(v->counter);

Removing the unncessary brackets is fine, but the commit message didn't mention this.

[...]

>  static __always_inline int arch_atomic_fetch_and(int i, atomic_t *v)
>  {
> -	int val = arch_atomic_read(v);
> +	int val = __READ_ONCE(v->counter);

This is the wrong thing to do; arch_atomic_read() already has the required
semantic, and it more clearly aligns with the use of arch_atomic_try_cmpxchg()
below. It contains the documentation regarding why we use __READ_ONCE()
specifically (which we should probably note in arch_atomic64_read()).

Please leave this as-is, and likewise for the other cases below. Similarly, the
prior patch should use arch_atomic{,_64}_read() rather than using
__READ_ONCE().

[...]

>  static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
>  {
> -	s64 val = arch_atomic64_read(v);
> +	s64 val = __READ_ONCE(v->counter);
> +
> +	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
>  
> -	do {
> -	} while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
>  	return val;

I think this reformatting is what you meant in the commit message when you said:

| This patch unifies arch_atomic{,64}_{,fetch}_{and,or,xor}() macros
| between x86_32 and x86_64 targets.

Assuming so, can you please jsut do that, and say:

  This patch reformats the x86_64 arch_atomic{,64}_{,fetch}_{and,or,xor}()
  functions to match the x86_32 versions.

Mark.

