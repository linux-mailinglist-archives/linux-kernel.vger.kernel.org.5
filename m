Return-Path: <linux-kernel+bounces-136699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8591589D737
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8509C1C22417
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D7181725;
	Tue,  9 Apr 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oeyVf0/D"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED574297
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659553; cv=none; b=EAEebu0hGeM6o37AszPOGoGiwlvk3SZR/fwrDV/6AszlQqZl2skCnVgxPSNAsVSBprXGNmy9Hzvq9lGvqpOvcBilksxoZ1AIgFnQwrviZ6IF+GGNbOoyJmGOr9tjchiL52CG1hRrOF4UdhQFTi1h75RxVa4wAWDSSdL5JF8N+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659553; c=relaxed/simple;
	bh=kz4QEQGLnaTtmAdU23voim6CEsajFJQHvrUTNojptU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ8ud6EAQhpp3p12KjcsuWrKj6wEv/rRGE+Wm/a5ZmFt6XnvmQ7uf8OxqY7TNwXCjDMU5Ls2I+kYnwRbhv35p9+ebOp6OdmGqkVUZSg0qaJ5EUO65e2tS9ENMvAlmlbFiEV1siosJx7ItcIC16xB0xag8WaZMufjffGVGCXGGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oeyVf0/D; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1CfiDre3glGgbUafmq0aj30+LgqY9W5fCVFvwgyph6E=; b=oeyVf0/DYPwlJ/nS8v+YP7Bgq7
	NFDzt5W3FCdI9onQ1a3Wlo5sD9Cd5GLGOBSMY6htjtXI7Zf1KJwuDBPQutbF1Mrr2hkwrL+GZWrrQ
	uA8I3EAvRJxNHKd5S4Q8pO8phz1jDqL/6zq4ltSA7u3rQZ14sK2+5L5VblKE3OwK3sesYixKzwdHM
	874c8kqqHPIFt8RmGcKWAsaL9sQP1EoNbL0Q6K0QLkU1Iz6eoskZPxYBxb7mDYL+AMuE67swYUiQ+
	jdTxRd4/rSYh4tua/vQk1XTGcTOBdS3Olb3Bp/5zOY4TE26XbdC3Ksc6VhXFySTGVV7qq/BHCzpsv
	P9PB3HdA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru8yy-00000007Z53-3gmD;
	Tue, 09 Apr 2024 10:45:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7620A30040C; Tue,  9 Apr 2024 12:45:40 +0200 (CEST)
Date: Tue, 9 Apr 2024 12:45:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Anvin <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: More annoying code generation by clang
Message-ID: <20240409104540.GB21779@noisy.programming.kicks-ass.net>
References: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>
 <20240408084934.GC21904@noisy.programming.kicks-ass.net>
 <CAHk-=witEwVvJ6Wh4xdP-sUkLQSwcRTtg_NSuGMMgvYmcs3teQ@mail.gmail.com>
 <CAHk-=wg=Wdct5f9W2-tvwfRefv3xmw1-9Ko+RG+6=xjLu4ndFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg=Wdct5f9W2-tvwfRefv3xmw1-9Ko+RG+6=xjLu4ndFg@mail.gmail.com>

On Mon, Apr 08, 2024 at 12:42:31PM -0700, Linus Torvalds wrote:

> Actually, one of the github issues pages has more of an explanation
> (and yes, it's tied to impedance issues between the inline asm syntax
> and how clang works):
> 
>       https://github.com/llvm/llvm-project/issues/20571#issuecomment-980933442
> 

So that same issue seems to suggest Nick is actually working on this and
got stuff merged. Nick, what is the status of your efforts and should we
indeed do the below as Linus suggests or should he upgrade his compiler?

> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 49feac0162a5..0dee061fd7a6 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -118,3 +118,15 @@
>  
>  #define __diag_ignore_all(option, comment) \
>  	__diag_clang(13, ignore, option)
> +
> +/*
> + * clang has horrible behavior with "g" or "rm" constraints for asm
> + * inputs, turning them into something worse than "m". Avoid using
> + * constraints with multiple possible uses (but "ir" seems to be ok):
> + *
> + *	https://github.com/llvm/llvm-project/issues/20571
> + *	https://github.com/llvm/llvm-project/issues/30873
> + *	https://github.com/llvm/llvm-project/issues/34837
> + */
> +#define ASM_INPUT_G "ir"
> +#define ASM_INPUT_RM "r"
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 2abaa3a825a9..e53acd310545 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -380,6 +380,15 @@ struct ftrace_likely_data {
>  #define asm_goto_output(x...) asm volatile goto(x)
>  #endif
>  
> +/*
> + * Clang has trouble with constraints with multiple
> + * alternative behaviors (mainly "g" and "rm").
> + */
> +#ifndef ASM_INPUT_G
> +  #define ASM_INPUT_G "g"
> +  #define ASM_INPUT_RM "rm"
> +#endif
> +
>  #ifdef CONFIG_CC_HAS_ASM_INLINE
>  #define asm_inline asm __inline
>  #else
> -- 
> 2.44.0.330.g4d18c88175
> 


