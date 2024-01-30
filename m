Return-Path: <linux-kernel+bounces-44704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6531D842641
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF561B2F270
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6A86D1A2;
	Tue, 30 Jan 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsj9h8iZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F7938DD3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706621926; cv=none; b=R/DYA4um+XzyiiNSIxJGBRwOreAa/yE0qrArUpTNz+zY4K//ZZTOAOHlbkrUcuTfFBE3zqIyjWwFxCI2SAOZEb+d2trRmW8DPDAzZ+Mn8k6qZDyucaKZR4jzyaKYjtfxbDHEPS0u2+Dbna8wXyjg42S5IdL3Tv15jQ1qm+CCRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706621926; c=relaxed/simple;
	bh=xay3PI/Hwj0fNnXBZKE/+lBBhM3wX3Wp31e3E0sjX4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDM383fSYIYgdWerhPh2UlnERK5ox9uSEwAq6LSj5ObcCRtyEIFtwmSHgTUPaNwlAQ7I0nExXAtVTJE3kfqx/127yXCZDGfmpEFT4dqcA6Nmga/BS68TikwcLyjwI4Zm3ufAJ/nxAdZN+FEWDu1yInQMcA7ocaK8umhtRTg6ezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsj9h8iZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3111C433C7;
	Tue, 30 Jan 2024 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706621925;
	bh=xay3PI/Hwj0fNnXBZKE/+lBBhM3wX3Wp31e3E0sjX4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tsj9h8iZY2aMJC53CXOKLFz4LsJq8oqWRAzzEC9+cXF9Xa8WkvaoGPhVxmuq9pzj/
	 7NcOiH14E7UmFWhgy/q292BEONRVoNwEDs9zTNO2PtpMOIMW2yWdi0BiQxnKDGpf4B
	 KB60EB9a1dXdw9GA9SkEfIBPHzy0LjBojp50r6D0Jvzln7hmuSrbZ0F444RTnYWrOQ
	 5+kHe28ToY98XUgNITCAeoog14Dp8FA/7AX1WYuj5ANgqVB6WFFKULJLvTi1Bele5j
	 SnqIu6dXFD3QcfcDVZepw+rQ9YddMAZE9wVoY6HkKqtHpFtttTpL31BXS3oZFO2V15
	 UByrHn9TCNV3g==
Date: Tue, 30 Jan 2024 21:25:54 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Nick Kossifidis <mick@ics.forth.gr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Matteo Croce <mcroce@microsoft.com>
Subject: Re: [PATCH 3/3] riscv: optimized memset
Message-ID: <Zbj44v8QsQPtQ_jD@xhacker>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-4-jszhang@kernel.org>
 <b7ae944c-2b7c-4c8d-8623-a8387b8d4e02@ics.forth.gr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7ae944c-2b7c-4c8d-8623-a8387b8d4e02@ics.forth.gr>

On Tue, Jan 30, 2024 at 02:07:37PM +0200, Nick Kossifidis wrote:
> On 1/28/24 13:10, Jisheng Zhang wrote:
> > diff --git a/arch/riscv/lib/string.c b/arch/riscv/lib/string.c
> > index 20677c8067da..022edda68f1c 100644
> > --- a/arch/riscv/lib/string.c
> > +++ b/arch/riscv/lib/string.c
> > @@ -144,3 +144,44 @@ void *memmove(void *dest, const void *src, size_t count) __weak __alias(__memmov
> >   EXPORT_SYMBOL(memmove);
> >   void *__pi_memmove(void *dest, const void *src, size_t count) __alias(__memmove);
> >   void *__pi___memmove(void *dest, const void *src, size_t count) __alias(__memmove);
> > +
> > +void *__memset(void *s, int c, size_t count)
> > +{
> > +	union types dest = { .as_u8 = s };
> > +
> > +	if (count >= MIN_THRESHOLD) {
> > +		unsigned long cu = (unsigned long)c;
> > +
> > +		/* Compose an ulong with 'c' repeated 4/8 times */
> > +#ifdef CONFIG_ARCH_HAS_FAST_MULTIPLIER
> > +		cu *= 0x0101010101010101UL;

Here we need to check BITS_PER_LONG, use 0x01010101UL for rv32

> > +#else
> > +		cu |= cu << 8;
> > +		cu |= cu << 16;
> > +		/* Suppress warning on 32 bit machines */
> > +		cu |= (cu << 16) << 16;
> > +#endif
> 
> I guess you could check against __SIZEOF_LONG__ here.

Hmm I believe we can remove the | and shift totally, and fall
back to ARCH_HAS_FAST_MULTIPLIER, see
https://lore.kernel.org/linux-riscv/20240125145703.913-1-jszhang@kernel.org/

> 
> > +		if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
> > +			/*
> > +			 * Fill the buffer one byte at time until
> > +			 * the destination is word aligned.
> > +			 */
> > +			for (; count && dest.as_uptr & WORD_MASK; count--)
> > +				*dest.as_u8++ = c;
> > +		}
> > +
> > +		/* Copy using the largest size allowed */
> > +		for (; count >= BYTES_LONG; count -= BYTES_LONG)
> > +			*dest.as_ulong++ = cu;
> > +	}
> > +
> > +	/* copy the remainder */
> > +	while (count--)
> > +		*dest.as_u8++ = c;
> > +
> > +	return s;
> > +}
> > +EXPORT_SYMBOL(__memset);
> 
> BTW a similar approach could be used for memchr, e.g.:
> 
> #if __SIZEOF_LONG__ == 8
> #define HAS_ZERO(_x) (((_x) - 0x0101010101010101ULL) & ~(_x) &
> 0x8080808080808080ULL)
> #else
> #define HAS_ZERO(_x) (((_x) - 0x01010101UL) & ~(_x) & 0x80808080UL)
> #endif
> 
> void *
> memchr(const void *src_ptr, int c, size_t len)
> {
> 	union const_data src = { .as_bytes = src_ptr };
> 	unsigned char byte = (unsigned char) c;
> 	unsigned long mask = (unsigned long) c;
> 	size_t remaining = len;
> 
> 	/* Nothing to do */
> 	if (!src_ptr || !len)
> 		return NULL;
> 
> 	if (len < 2 * WORD_SIZE)
> 		goto trailing;
> 
> 	mask |= mask << 8;
> 	mask |= mask << 16;
> #if __SIZEOF_LONG__ == 8
> 	mask |= mask << 32;
> #endif
> 
> 	/* Search by byte up to the src's alignment boundary */
> 	for(; src.as_uptr & WORD_MASK; remaining--, src.as_bytes++) {
> 		if (*src.as_bytes == byte)
> 			return (void*) src.as_bytes;
> 	}
> 
> 	/* Search word by word using the mask */
> 	for(; remaining >= WORD_SIZE; remaining -= WORD_SIZE, src.as_ulong++) {
> 		unsigned long check = *src.as_ulong ^ mask;
> 		if(HAS_ZERO(check))
> 			break;
> 	}
> 
>  trailing:
> 	for(; remaining > 0; remaining--, src.as_bytes++) {
> 		if (*src.as_bytes == byte)
> 			return (void*) src.as_bytes;
> 	}
> 
> 	return NULL;
> }
> 
> Regards,
> Nick

