Return-Path: <linux-kernel+bounces-135080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D36189BADC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8F81F2472A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E82E3A1A2;
	Mon,  8 Apr 2024 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QJF7JzJY"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C84D9E2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566185; cv=none; b=A1Xs+9padG82GjGlrypD9J6lACZuSbLYWNrfMn48xHIVL+Vs/VGrq1jNiWOprOaDhC9nWe3eu6VNXfaddbLxZQuri8Fy3da0BpMxdmQ0JG7Bx8Fd724C0WE8+5Q94kBv2TDooYf/iGnIWbcq0ycuoYGq88Itq+XB+G9nWU+/igs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566185; c=relaxed/simple;
	bh=ksS9V6rjZbcOz0BAzPb9ZhWVdP5vQ7O1mBkSHOoIEJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOOTo2vDvSuFrXvX5q/UkBS9L4Eoj0GKfgEnwvVH8DGkAnt56tyqe/Dzh52os0mmnsScQx+PL94vHZi4Owr4a/TCeHBNp9Yx2xiR4GFapSWx8Bfa1V2+Pl7/6DFGr0o/k1VqSs/ylaG14wkxlUTdZRo9F1NaLLZieOMkcBgkd98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QJF7JzJY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4XFLlTZ7sqAhr2evVqUObGZY1eq6DtCDJp2B93uw0To=; b=QJF7JzJYRoCmIOdwpsHFwguU7+
	uwDm0S8nc6q4Asmah0DIA31uiqxKfRN/Dl2hZpPuKGSr9gbFCmb8ey5VdV2uOdYW0ww1Qj4rb0hTX
	kzgwQAd529Bq+fa2L9ecRoSHtGdsTw++ybt9Bb8rywa7v70ioE2QElAcdoeI0/crQQ1L5QaODQZKW
	RQ0WIo77twnDnWk50iY6tx9RfE2mg5ElDf3dlM3g+feSO1Vyayxfogf6OdzjxhcszEfZ3r+LGR5/f
	gFl+GPv6yH4HXiWDnnfmvvXvRzSRiA8gfCL5jcNMBEwPHupXUbvgSEaH8KzhAPvG1p9Os9ieyjmTO
	vOtG/V1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtkh4-000000073Nx-2VnA;
	Mon, 08 Apr 2024 08:49:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 40C203002A6; Mon,  8 Apr 2024 10:49:34 +0200 (CEST)
Date: Mon, 8 Apr 2024 10:49:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Anvin <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More annoying code generation by clang
Message-ID: <20240408084934.GC21904@noisy.programming.kicks-ass.net>
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

On Thu, Apr 04, 2024 at 03:53:49PM -0700, Linus Torvalds wrote:

> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 66e57c010392..6159d2cbbfde 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -33,20 +33,15 @@
>   * Returns:
>   *     0 - (index < size)
>   */
> +#define array_index_mask_nospec(idx,sz) ({	\
> +	typeof((idx)+(sz)) __idx = (idx);	\
> +	typeof(__idx) __sz = (sz);		\
> +	typeof(__idx) __mask;			\
> +	asm volatile ("cmp %1,%2; sbb %0,%0"	\
> +			:"=r" (__mask)		\
> +			:"ir"(__sz),"r" (__idx)	\
> +			:"cc");			\
> +	__mask; })

Should this not carry a comment about the "ir" constraint wanting to be
"g" except for clang being daft?

(I really wish clang would go fix this, it keeps coming up time and
again).

>  
>  /* Prevent speculative execution past this barrier. */
>  #define barrier_nospec() asm volatile("lfence":::"memory")


