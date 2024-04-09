Return-Path: <linux-kernel+bounces-136731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC3E89D7AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FDC1F25376
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75985C66;
	Tue,  9 Apr 2024 11:13:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA0E1E885
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661197; cv=none; b=Vx8VvMao5it6VeG34cTMNoRzz/PaTCWZzIgYLpnuIz9zz3Uyhf1GhW55nLs5hp/3RH0vdYQzt5tp8mI14kPUBC7SAjfMpmleBrZG3vyRUeOPyS0wx8G+S8Jr4Idq5rU/6wHW5MDq0NksIDxY7tYQMAa90qPABgd9MRXmj/nokY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661197; c=relaxed/simple;
	bh=Bx7LYEEXviSBci5d+o3P9tQEX5hyO8sOTt1r85E3LQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9ELK9Ug/SB+1hjVCjUn7TXVDMXzQ/HhuoWiQRa5LfjO/pUIzhnmrzNpDYOVqb+U4aoT2uiDuEKvRKo9eA9zZ0JvxbYYHm3ZunwcOVv7jANGeYWlfn3jypbh+Obp/5gB3AoydYQXMntAJh3iI4XLHkiMGbbTMgZd8Tbk2tMle3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 545F6DA7;
	Tue,  9 Apr 2024 04:13:45 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.248])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EBAD3F766;
	Tue,  9 Apr 2024 04:13:13 -0700 (PDT)
Date: Tue, 9 Apr 2024 12:13:10 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/6] locking/atomic/x86: Rewrite x86_32
 arch_atomic64_{,fetch}_{and,or,xor}() functions
Message-ID: <ZhUixk5I_n53dbBb@FVFF77S0Q05N>
References: <20240409100503.274629-1-ubizjak@gmail.com>
 <20240409100503.274629-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409100503.274629-3-ubizjak@gmail.com>

On Tue, Apr 09, 2024 at 12:03:53PM +0200, Uros Bizjak wrote:
> Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}() functions to
> use arch_atomic64_try_cmpxchg.  This implementation avoids one extra
> trip through the cmpxchg loop.
> 
> The value preload before the cmpxchg loop does not need to be atomic,
> but should use READ_ONCE to prevent compiler from merging, refetching
> or reordering the read.
> 
> The generated code improves from:
> 
>   1917d5:	31 c9                	xor    %ecx,%ecx
>   1917d7:	31 db                	xor    %ebx,%ebx
>   1917d9:	89 4c 24 3c          	mov    %ecx,0x3c(%esp)
>   1917dd:	8b 74 24 24          	mov    0x24(%esp),%esi
>   1917e1:	89 c8                	mov    %ecx,%eax
>   1917e3:	89 5c 24 34          	mov    %ebx,0x34(%esp)
>   1917e7:	8b 7c 24 28          	mov    0x28(%esp),%edi
>   1917eb:	21 ce                	and    %ecx,%esi
>   1917ed:	89 74 24 4c          	mov    %esi,0x4c(%esp)
>   1917f1:	21 df                	and    %ebx,%edi
>   1917f3:	89 de                	mov    %ebx,%esi
>   1917f5:	89 7c 24 50          	mov    %edi,0x50(%esp)
>   1917f9:	8b 54 24 4c          	mov    0x4c(%esp),%edx
>   1917fd:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
>   191801:	8b 4c 24 50          	mov    0x50(%esp),%ecx
>   191805:	89 d3                	mov    %edx,%ebx
>   191807:	89 f2                	mov    %esi,%edx
>   191809:	f0 0f c7 0f          	lock cmpxchg8b (%edi)
>   19180d:	89 c1                	mov    %eax,%ecx
>   19180f:	8b 74 24 34          	mov    0x34(%esp),%esi
>   191813:	89 d3                	mov    %edx,%ebx
>   191815:	89 44 24 4c          	mov    %eax,0x4c(%esp)
>   191819:	8b 44 24 3c          	mov    0x3c(%esp),%eax
>   19181d:	89 df                	mov    %ebx,%edi
>   19181f:	89 54 24 44          	mov    %edx,0x44(%esp)
>   191823:	89 ca                	mov    %ecx,%edx
>   191825:	31 de                	xor    %ebx,%esi
>   191827:	31 c8                	xor    %ecx,%eax
>   191829:	09 f0                	or     %esi,%eax
>   19182b:	75 ac                	jne    1917d9 <...>
> 
> to:
> 
>   1912ba:	8b 06                	mov    (%esi),%eax
>   1912bc:	8b 56 04             	mov    0x4(%esi),%edx
>   1912bf:	89 44 24 3c          	mov    %eax,0x3c(%esp)
>   1912c3:	89 c1                	mov    %eax,%ecx
>   1912c5:	23 4c 24 34          	and    0x34(%esp),%ecx
>   1912c9:	89 d3                	mov    %edx,%ebx
>   1912cb:	23 5c 24 38          	and    0x38(%esp),%ebx
>   1912cf:	89 54 24 40          	mov    %edx,0x40(%esp)
>   1912d3:	89 4c 24 2c          	mov    %ecx,0x2c(%esp)
>   1912d7:	89 5c 24 30          	mov    %ebx,0x30(%esp)
>   1912db:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
>   1912df:	8b 4c 24 30          	mov    0x30(%esp),%ecx
>   1912e3:	f0 0f c7 0e          	lock cmpxchg8b (%esi)
>   1912e7:	0f 85 f3 02 00 00    	jne    1915e0 <...>
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/x86/include/asm/atomic64_32.h | 44 ++++++++++++------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
> index 11e817dab44a..84affd7a5d1c 100644
> --- a/arch/x86/include/asm/atomic64_32.h
> +++ b/arch/x86/include/asm/atomic64_32.h
> @@ -201,69 +201,61 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
>  
>  static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
>  {
> -	s64 old, c = 0;
> +	s64 val = __READ_ONCE(v->counter);

I reckon it's worth placing this in a helper with a big comment, e.g.

static __always_inline s64 arch_atomic64_read_tearable(atomic64_t *v)
{
	/*
	 * TODO: explain that this might be torn, but it occurs *once*, and can
	 * safely be consumed by atomic64_try_cmpxchg().
	 *
	 * TODO: point to the existing commentary regarding why we use
	 * __READ_ONCE() for KASAN reasons.
	 */
	return __READ_ONCE(v->counter);
}

.. and then use that in each of the instances below.

That way the subtlety is clearly documented, and it'd more clearly align with
the x86_64 verions.

Mark.

>  
> -	while ((old = arch_atomic64_cmpxchg(v, c, c & i)) != c)
> -		c = old;
> +	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
>  }
>  
>  static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
>  {
> -	s64 old, c = 0;
> +	s64 val = __READ_ONCE(v->counter);
>  
> -	while ((old = arch_atomic64_cmpxchg(v, c, c & i)) != c)
> -		c = old;
> +	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
>  
> -	return old;
> +	return val;
>  }
>  #define arch_atomic64_fetch_and arch_atomic64_fetch_and
>  
>  static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
>  {
> -	s64 old, c = 0;
> +	s64 val = __READ_ONCE(v->counter);
>  
> -	while ((old = arch_atomic64_cmpxchg(v, c, c | i)) != c)
> -		c = old;
> +	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
>  }
>  
>  static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
>  {
> -	s64 old, c = 0;
> +	s64 val = __READ_ONCE(v->counter);
>  
> -	while ((old = arch_atomic64_cmpxchg(v, c, c | i)) != c)
> -		c = old;
> +	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
>  
> -	return old;
> +	return val;
>  }
>  #define arch_atomic64_fetch_or arch_atomic64_fetch_or
>  
>  static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
>  {
> -	s64 old, c = 0;
> +	s64 val = __READ_ONCE(v->counter);
>  
> -	while ((old = arch_atomic64_cmpxchg(v, c, c ^ i)) != c)
> -		c = old;
> +	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
>  }
>  
>  static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
>  {
> -	s64 old, c = 0;
> +	s64 val = __READ_ONCE(v->counter);
>  
> -	while ((old = arch_atomic64_cmpxchg(v, c, c ^ i)) != c)
> -		c = old;
> +	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
>  
> -	return old;
> +	return val;
>  }
>  #define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
>  
>  static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
>  {
> -	s64 old, c = 0;
> +	s64 val = __READ_ONCE(v->counter);
>  
> -	while ((old = arch_atomic64_cmpxchg(v, c, c + i)) != c)
> -		c = old;
> -
> -	return old;
> +	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val + i));
> +	return val;
>  }
>  #define arch_atomic64_fetch_add arch_atomic64_fetch_add
>  
> -- 
> 2.44.0
> 
> 

