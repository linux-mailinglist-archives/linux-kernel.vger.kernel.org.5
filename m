Return-Path: <linux-kernel+bounces-133892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5EC89AA70
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A9A1C20F09
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F622C194;
	Sat,  6 Apr 2024 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpAl6fDc"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786441BC5C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712400994; cv=none; b=qhUx9eiboWqklAGk042MeSK/6GAQheZFktc9uFDx8tJzasKu9cfKNBI5bLVJs8QSAiP0oAR3uEYaWfOEdDHeGCgLHnAl4+ehfVDDfsszDi8G/pruuWjsAWGhxYIqgJiLUehYZ0/Qn8e7dQKL0i8NASrB/kj57wk/gW5fAzbLyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712400994; c=relaxed/simple;
	bh=y8O8G+3kOQCWVxdgMJ3mY7gQ52SMfiNWa3C+f2jS3iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7LW05ImI+cojJD8PrHZgOP9NPQA50RN0173qWNoMGn+d8/coR1JC0gYDwwQVWnrxC1lBPRPHeWn/f3TRXFUaEtEsf1qg08q/X0G6U0246VQdCU1B6WqeRTSZJJwTO0AOkgfjvbzbZdG4zWSUevYNTHwKdUA8XD2r+vA/bqmB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpAl6fDc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e0e1d162bso3067718a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 03:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712400991; x=1713005791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGWRMtYacfvyoOeBa2p0kVj2hyRfXcYrzhawh81Vrzo=;
        b=PpAl6fDc9t1CNhEZ62SkxiOthmr7XHB0w7GyQ2TztXKd9MZBVLHkW2HMpXhxFTGTfc
         kaEzK3fpvHJZhviY2lJAFyhq2Fiyo8BI6RqPIELE0ils1aON0Y3Iu21+1N14ID2NExaC
         FuUPqaKFdyAPUPasG3K59bjHQdXlgoVHBtxBIAbnzFNDUswjEquLrFDE7kOeWddFmFdZ
         Pfk/8CFLDKbzfGNYrKLPsucT8vl+NY6VvBl2G9eLkpT9BAJBrfbwJYodkjJcCgdPpiiH
         RApoQdR2a/2Co2OTtnDdzARe2DfbzhVA/GeVZYXbVRHF2ylGTaXcjmYz6eb41xfYy7Wg
         ct6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712400991; x=1713005791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGWRMtYacfvyoOeBa2p0kVj2hyRfXcYrzhawh81Vrzo=;
        b=kvM1KzSpG3lVQe5FjAFDAsL3S+byqVer22fhDDh3UANpLv+n73XWvK82bZpMWoJWVV
         bC3MdxN7lLpnYfWAmWPHQEQFWDcDu5Ef9SiktwzNM0eeJr+nT2nIA82KGuLXiqO+mcM3
         CGZmZt6B8UZmjzB622qa4x6rb2mfEXtpkDbkcRiTiViHOXsPIhoDsKV8DK09wQEqvgMF
         ZW43EXTfvdcXXyIaIAup6Y3O81Nd2dMcl/ZwRHJ9yg1zsdTCScv0ehCVdPBOWU4F2sJc
         dkALFp+/0GTB/5okW1yqAmkZ0cKupUZQPm/4EAjlM39nw+mivVgL3gn6cdK66/J1LLAi
         RyAw==
X-Forwarded-Encrypted: i=1; AJvYcCWgd2TbX5khJp4hvxv0MVBeOB7HXn1mnn7pgw0A7X2GUxFOchkJCBlWzgme60+3xLEF+oKzd5FZvE79wxb7Gk9yumD7zmnSZ26ZC9SI
X-Gm-Message-State: AOJu0Ywc63QCsSjGtcMV7tAIsCUmfajLcvJb/K9lPBnhdEaf1GfHh7Jn
	3/B1iK09+sdS1izOegeqNyODSLiNeAAsFftjpq30pWNtn5AfD5QR
X-Google-Smtp-Source: AGHT+IFgwM98BdZ4333a8NdCvMdQ2OQsz+Suxo4WEZWny+o4s9RAm5tqa/ExSou1ZNrOJ8RNLlBrUw==
X-Received: by 2002:a50:8753:0:b0:56d:ece8:a5e8 with SMTP id 19-20020a508753000000b0056dece8a5e8mr2672083edv.14.1712400990488;
        Sat, 06 Apr 2024 03:56:30 -0700 (PDT)
Received: from gmail.com (84-236-113-28.pool.digikabel.hu. [84.236.113.28])
        by smtp.gmail.com with ESMTPSA id x1-20020a056402414100b0056e307db93dsm1693155eda.86.2024.04.06.03.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 03:56:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 6 Apr 2024 12:56:27 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More annoying code generation by clang
Message-ID: <ZhEqW748nht2M4Si@gmail.com>
References: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>


[ I've Cc:-ed a few more people who might be interested in this. ]
[ Copy of Linus's email below. ]

* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So this doesn't really matter in any real life situation, but it
> really grated on me.
> 
> Clang has this nasty habit of taking our nice asm constraints, and
> turning them into worst-case garbage. It's been reported a couple of
> times where we use "g" to tell the compiler that pretty much any
> source to the asm works, and then clang takes that to mean "I will
> take that to use 'memory'" even when that makes no sense what-so-ever.
> 
> See for example
> 
>     https://lore.kernel.org/all/CAHk-=wgobnShg4c2yyMbk2p=U-wmnOmX_0=b3ZY_479Jjey2xw@mail.gmail.com/
> 
> where I was ranting about clang just doing pointlessly stupid things.
> 
> However, I found a case where yes, clang does pointlessly stupid
> things, but it's at least _partly_ our fault, and gcc can't generate
> optimal code either.
> 
> We have this fairly critical code in __fget_files_rcu() to look up a
> 'struct file *' from an fd, and it does this:
> 
>                 /* Mask is a 0 for invalid fd's, ~0 for valid ones */
>                 nospec_mask = array_index_mask_nospec(fd, fdt->max_fds);
> 
> and clang makes a *horrid* mess of it, generating this code:
> 
>         movl    %edi, %r14d
>         movq    32(%rbx), %rdx
>         movl    (%rdx), %eax
>         movq    %rax, 8(%rsp)
>         cmpq    8(%rsp), %r14
>         sbbq    %rcx, %rcx
> 
> which is just crazy. Notice how it does that "move rax to stack, then
> do the compare against the stack", instead of just using %rax.
> 
> In fact, that function shouldn't have a stack frame at all, and the
> only reason it is generated is because of this whole oddity.
> 
> All clang's fault, right?
> 
> Yeah, mostly. But it turns out that what really messes with clangs
> little head is that the x86 array_index_mask_nospec() function is
> being a bit annoying.
> 
> This is what we do:
> 
>   static __always_inline unsigned long
> array_index_mask_nospec(unsigned long index,
>                 unsigned long size)
>   {
>         unsigned long mask;
> 
>         asm volatile ("cmp %1,%2; sbb %0,%0;"
>                         :"=r" (mask)
>                         :"g"(size),"r" (index)
>                         :"cc");
>         return mask;
>   }
> 
> and look at the use again:
> 
>         nospec_mask = array_index_mask_nospec(fd, fdt->max_fds);
> 
> here all the values are actually 'unsigned int'. So what happens is
> that clang can't just use the fdt->max_fds value *directly* from
> memory, because it needs to be expanded from 32-bit to 64-bit because
> we've made our array_index_mask_nospec() function only work on 64-bit
> 'unsigned long' values.
> 
> So it turns out that by massaging this a bit, and making it just be a
> macro - so that the asm can decide that "I can do this in 32-bit" - I
> can get clang to generate much better code.
> 
> Clang still absolutely hates the "g" constraint, so to get clang to
> really get this right I have to use "ir" instead of "g". Which is
> wrong. Because gcc does this right, and could use the memory op
> directly. But even gcc cannot do that with our *current* function,
> because of that "the memory value is 32-bit, we require a 64-bit
> value"
> 
> Anyway, I can get gcc to generate the right code:
> 
>         movq    32(%r13), %rdx
>         cmp (%rdx),%ebx
>         sbb %esi,%esi
> 
> which is basically the right code for the six crazy instructions clang
> generates. And if I make the "g" be "ir", I can get clang to generate
> 
>         movq    32(%rdi), %rcx
>         movl    (%rcx), %eax
>         cmpl    %eax, %esi
>         sbbl    %esi, %esi
> 
> which is the same thing, but with that (pointless) load to a register.
> 
> And now clang doesn't generate that stack frame at all.
> 
> Anyway, this was a long email to explain the odd attached patch.
> 
> Comments? Note that this patch is *entirely* untested, I have done
> this purely by looking at the code generation in fs/file.c.
> 
>                 Linus

>  arch/x86/include/asm/barrier.h | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 66e57c010392..6159d2cbbfde 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -33,20 +33,15 @@
>   * Returns:
>   *     0 - (index < size)
>   */
> -static __always_inline unsigned long array_index_mask_nospec(unsigned long index,
> -		unsigned long size)
> -{
> -	unsigned long mask;
> -
> -	asm volatile ("cmp %1,%2; sbb %0,%0;"
> -			:"=r" (mask)
> -			:"g"(size),"r" (index)
> -			:"cc");
> -	return mask;
> -}
> -
> -/* Override the default implementation from linux/nospec.h. */
> -#define array_index_mask_nospec array_index_mask_nospec
> +#define array_index_mask_nospec(idx,sz) ({	\
> +	typeof((idx)+(sz)) __idx = (idx);	\
> +	typeof(__idx) __sz = (sz);		\
> +	typeof(__idx) __mask;			\
> +	asm volatile ("cmp %1,%2; sbb %0,%0"	\
> +			:"=r" (__mask)		\
> +			:"ir"(__sz),"r" (__idx)	\
> +			:"cc");			\
> +	__mask; })
>  
>  /* Prevent speculative execution past this barrier. */
>  #define barrier_nospec() asm volatile("lfence":::"memory")


