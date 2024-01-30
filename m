Return-Path: <linux-kernel+bounces-44543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F73F842400
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FE82898E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DCE67E69;
	Tue, 30 Jan 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp8N5znL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3E67A19
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615014; cv=none; b=XzmdCbq8GTH/bdEqtYpU6br7MDg2nTBujwtGz34+pVyh6Te5xk2AlPh9YNKnF7U8H7xAtoG9lioBUWj1COis0NF3wkCQ9l3lTUIphqbK57UG2sWNWOdTsA4cFi80UFg4S733+lHnZnFeh6MZa66O0jW4e0YAhOsmy+1eQYT0GJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615014; c=relaxed/simple;
	bh=1dvspfcJflTfBs11wiC68BBxE/i2yh/F5YLwP7Tw4mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzbheVo33uPgqEGX5ndp+00A2WTcg//uCef35dYbt0bWRyE3lQKBs3EHh6sZgWozOWVuH2XOSOWfVXhjkekpKT//W1CD9DVlBR27odN7xYuTl42imnyLHSUdIbCvy3HqKylefSHmL9vXOSWFoa2i7FGA++MnR5z2OlZMly1v6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp8N5znL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808ECC433F1;
	Tue, 30 Jan 2024 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706615014;
	bh=1dvspfcJflTfBs11wiC68BBxE/i2yh/F5YLwP7Tw4mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jp8N5znLrchQW7iQQFTKbpb455YiKpVWmC2a96EWlFM2XehFfkc5+M2RDR2OcG0dy
	 ekgA/SJ68RF1kQSb8q2wpNOpWX/9ry/nzv4+NjK1fCgaEnbShPFVLMf+X86KBDNzxB
	 GPF+8bbGMHRhf0TLxcacVIfmcc3td0bU1Qtj5wJUku5E9qlg4E3nry9a6Nrm9Hzz9j
	 ByFXdex/dIT7RE4ozYSKyeMZll6aTcvvWs7YtAHTgwuCeffG9/bq/FXJvc1qb9iJ/7
	 wYKi0RiLZX0yY2Q2H+pxX8uDgNFxn1dZO2bn5KgB5CMTuxl4zxSHEmCGGHTwUhhy9Q
	 XiPWxhcLiPLfA==
Date: Tue, 30 Jan 2024 19:30:43 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Matteo Croce <mcroce@microsoft.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] riscv: optimized memmove
Message-ID: <Zbjd43y3s6PDfQE0@xhacker>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-3-jszhang@kernel.org>
 <59bed43df37b4361a8a1cb31b8582e9b@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59bed43df37b4361a8a1cb31b8582e9b@AcuMS.aculab.com>

On Sun, Jan 28, 2024 at 12:47:00PM +0000, David Laight wrote:
> From: Jisheng Zhang
> > Sent: 28 January 2024 11:10
> > 
> > When the destination buffer is before the source one, or when the
> > buffers doesn't overlap, it's safe to use memcpy() instead, which is
> > optimized to use a bigger data size possible.
> > 
> ...
> > + * Simply check if the buffer overlaps an call memcpy() in case,
> > + * otherwise do a simple one byte at time backward copy.
> 
> I'd at least do a 64bit copy loop if the addresses are aligned.
> 
> Thinks a bit more....
> 
> Put the copy 64 bytes code (the body of the memcpy() loop)
> into it an inline function and call it with increasing addresses
> in memcpy() are decrementing addresses in memmove.

Hi David,

Besides the 64 bytes copy, there's another optimization in __memcpy:
word-by-word copy even if s and d are not aligned.
So if we make the two optimizd copy as inline functions and call them
in memmove(), we almost duplicate the __memcpy code, so I think
directly calling __memcpy is a bit better.

Thanks
> 
> So memcpy() contains:
> 	src_lim = src_lim + count;
> 	... alignment copy
> 	for (; src + 64 <= src_lim; src += 64; dest += 64)
> 		copy_64_bytes(dest, src);
> 	... tail copy
> 
> Then you can do something very similar for backwards copies.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

