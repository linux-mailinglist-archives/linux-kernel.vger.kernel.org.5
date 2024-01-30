Return-Path: <linux-kernel+bounces-44698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2035A842626
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01B528B4BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ED46BB36;
	Tue, 30 Jan 2024 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZaWbzdN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D066B51
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706621094; cv=none; b=Myx5g+DHeaYiiFp+/o6S9BsxiO1TvM5e0ricdNZfKfXw7c/CBDytZ9rqKTBiCDFlFmtCP27eyfnN0ystq2V15Q9ZEHZY4olppTM4pt1sV4SJxf/8Wijm7CkrLhdIVp8MGxAJjcHhFEXzi1xTqsFkoBFIw+ayPLkLgRcgrNeohrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706621094; c=relaxed/simple;
	bh=u2/EtGgKHfzM35W18xHX1KvyJ0d2ZoEG7yO9aWLn5E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyGDN8N8U3Bx0y01MX9Pqvtjs5XorL5+A+AnF+yHS1XnKY3/f1Z8R8rGDKGjnll7Q2aDIUJwtIg6cU9z9K32NxSF0Erh6fXswSs2ccqo1aiJJZExcUNcZTu0exGU+zlKm+JOoXfZijF3BweMKDLvUTlpl4U1/eHgewUbrhPFa70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZaWbzdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC81C433F1;
	Tue, 30 Jan 2024 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706621094;
	bh=u2/EtGgKHfzM35W18xHX1KvyJ0d2ZoEG7yO9aWLn5E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZaWbzdNChbyXG+ahuq7EytUvzRdZGDvruqZR11EZP6KTpKu3lWN/qaKKHbKMmAac
	 edrLPNAUV3JEw7LNJZYEtY41NODu+IuPpTTB+MXn0rcibGvRZZ6TSVZU/X1ajBNnK2
	 yaVvQBdAQhPeoy2yJmanm0awSjpJSBJYJeMrGWBfDCsOmppHRgQBv927XnZtM62RLp
	 H2qFTf/lKAOkPMRb027X03Vzmx9K2okqjDdgglg+LiVXFAEsmXtiA84jM77PTSXlvf
	 fNrB4cxOyLO8nYqGR9iC8qKkkFJ35Eorggm/AWzX+Sd6Yb6jWtf6l2lS9tl6KuIveF
	 M4SW6Z8UDW+ig==
Date: Tue, 30 Jan 2024 21:12:03 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Nick Kossifidis <mick@ics.forth.gr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Matteo Croce <mcroce@microsoft.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] riscv: optimized memmove
Message-ID: <Zbj1o6VAsk8Tn2ab@xhacker>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-3-jszhang@kernel.org>
 <fa36b871-43d7-413c-82a2-0ecc0ebce9b4@ics.forth.gr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa36b871-43d7-413c-82a2-0ecc0ebce9b4@ics.forth.gr>

On Tue, Jan 30, 2024 at 01:39:10PM +0200, Nick Kossifidis wrote:
> On 1/28/24 13:10, Jisheng Zhang wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> > 
> > When the destination buffer is before the source one, or when the
> > buffers doesn't overlap, it's safe to use memcpy() instead, which is
> > optimized to use a bigger data size possible.
> > 
> > Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> I'd expect to have memmove handle both fw/bw copying and then memcpy being
> an alias to memmove, to also take care when regions overlap and avoid
> undefined behavior.

Hi Nick,

Here is somthing from man memcpy:

"void *memcpy(void dest[restrict .n], const void src[restrict .n],
                    size_t n);

The  memcpy()  function copies n bytes from memory area src to memory area dest.
The memory areas must not overlap.  Use memmove(3) if the memory areas do  over‐
lap."

IMHO, the "restrict" implies that there's no overlap. If overlap
happens, the manual doesn't say what will happen.

From another side, I have a concern: currently, other arch don't have
this alias behavior, IIUC(at least, per my understanding of arm and arm64
memcpy implementations)they just copy forward. I want to keep similar behavior
for riscv.

So I want to hear more before going towards alias-memcpy-to-memmove direction.

Thanks
> 
> 
> > --- a/arch/riscv/lib/string.c
> > +++ b/arch/riscv/lib/string.c
> > @@ -119,3 +119,28 @@ void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy)
> >   EXPORT_SYMBOL(memcpy);
> >   void *__pi_memcpy(void *dest, const void *src, size_t count) __alias(__memcpy);
> >   void *__pi___memcpy(void *dest, const void *src, size_t count) __alias(__memcpy);
> > +
> > +/*
> > + * Simply check if the buffer overlaps an call memcpy() in case,
> > + * otherwise do a simple one byte at time backward copy.
> > + */
> > +void *__memmove(void *dest, const void *src, size_t count)
> > +{
> > +	if (dest < src || src + count <= dest)
> > +		return __memcpy(dest, src, count);
> > +
> > +	if (dest > src) {
> > +		const char *s = src + count;
> > +		char *tmp = dest + count;
> > +
> > +		while (count--)
> > +			*--tmp = *--s;
> > +	}
> > +	return dest;
> > +}
> > +EXPORT_SYMBOL(__memmove);
> > +
> 
> Here is an approach for the backwards case to get things started...
> 
> static void
> copy_bw(void *dst_ptr, const void *src_ptr, size_t len)
> {
> 	union const_data src = { .as_bytes = src_ptr + len };
> 	union data dst = { .as_bytes = dst_ptr + len };
> 	size_t remaining = len;
> 	size_t src_offt = 0;
> 
> 	if (len < 2 * WORD_SIZE)
> 		goto trailing_bw;
> 
> 	for(; dst.as_uptr & WORD_MASK; remaining--)
> 		*--dst.as_bytes = *--src.as_bytes;
> 
> 	src_offt = src.as_uptr & WORD_MASK;
> 	if (!src_offt) {
> 		for (; remaining >= WORD_SIZE; remaining -= WORD_SIZE)
> 			*--dst.as_ulong = *--src.as_ulong;
> 	} else {
> 		unsigned long cur, prev;
> 		src.as_bytes -= src_offt;
> 		for (; remaining >= WORD_SIZE; remaining -= WORD_SIZE) {
> 			cur = *src.as_ulong;
> 			prev = *--src.as_ulong;
> 			*--dst.as_ulong = cur << ((WORD_SIZE - src_offt) * 8) |
> 					  prev >> (src_offt * 8);
> 		}
> 		src.as_bytes += src_offt;
> 	}
> 
>  trailing_bw:
> 	while (remaining-- > 0)
> 		*--dst.as_bytes = *--src.as_bytes;
> }
> 
> Regards,
> Nick

