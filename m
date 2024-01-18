Return-Path: <linux-kernel+bounces-30551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8910483205C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F1B2273B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB1A2E82C;
	Thu, 18 Jan 2024 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eUagBR5W"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680102E823
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608895; cv=none; b=fPaGksAdJdlQTTAgyGq65Z7i3Yf369Q9DRSSTUseHhpuuTb+yoGQo5EqSh789AN91qB653l+HBzzX0U0sfIq9FxMJKe1A8UY5vNdWEI3JfdHxLvD+Ktv2NvRXm4GXUNk9xxl9D1elJlTx4zItRJo/gIUQ4HQVqp51NJFYltwhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608895; c=relaxed/simple;
	bh=LZWv3GLEUX9es9p0Zg0IvfsZJulKGaX4e2YwY5PrDro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL1cKsHzU5LbDqnnyOmT0P16PkBF9Akw7ejuTL65rp/ibcn33ZB0Sj6vw+beuCCfFflgM8fIDHSsRc3+7R1MJb2fJ2i5qsAznMpHgPESGJ6jygdzS2+0VQeusSwSMNpWDHhl1utQQCK+eqlomFcydrOf99uUQ1hbkIn3s8Msn1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eUagBR5W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fIydFx0OSBHgPD2051KnTvD/KFPotO06W3HkqDQgy2s=; b=eUagBR5W8+3ds2el02+kYSRMO4
	sDhrWWjaiJRLFxxONOyP7LGYUIYn1zA0mACvJ6vKOyIuV1WRPj125e8q40TcClO7wXKjN8gbefgt6
	wyqOgl0W66laxqFOLAw+B4PnmEsd+3XCswkF4tOHZXVdokHLCoOAGFrHaOh0c0+thbB+a58b2WGOg
	FABZMQDZhlvN7qQk5bO9U2FWTFYipy2oAPoB6V0SCgdPUNLa4PON8AKXb1sLLD/V9TkyHn6K/9gAc
	Bj7qiBS8PWWGdMHE36mSfPvpTT7kQfu1RSDiAsnUqXG/CyKw1Xkya011su1JAOgfn42UDvPncZGZ6
	Z/O3BByg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQYmh-0000000323y-3WgP;
	Thu, 18 Jan 2024 20:14:43 +0000
Date: Thu, 18 Jan 2024 20:14:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yang Shi <shy828301@gmail.com>
Cc: jirislaby@kernel.org, surenb@google.com, riel@surriel.com, cl@linux.com,
	akpm@linux-foundation.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
Message-ID: <ZamGsyJ5JTQ9GYNL@casper.infradead.org>
References: <20240118133504.2910955-1-shy828301@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118133504.2910955-1-shy828301@gmail.com>

On Thu, Jan 18, 2024 at 05:35:04AM -0800, Yang Shi wrote:
> It doesn't make too much sense to force huge page alignment on 32 bit
> system due to the constrained virtual address space.
> 
> [1] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com/T/#mf211643a0427f8d6495b5b53f8132f453d60ab95
> [2] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com/T/#me93dff2ccbd9902c3e395e1c022fb454e48ecb1d

I feel sure there are shorter URLs for those messages ...

> @@ -811,6 +812,14 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
>  	loff_t off_align = round_up(off, size);
>  	unsigned long len_pad, ret;
>  
> +	/*
> +	 * It doesn't make too much sense to froce huge page alignment on
> +	 * 32 bit system or compat userspace due to the contrained virtual
> +	 * address space and address entropy.
> +	 */

I honestly wouldn't even comment this.  But if you must,

	/* Using THP alignment is not as important as address randomisation */

> +	if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> +		return 0;
> +
>  	if (off_end <= off_align || (off_end - off_align) < size)
>  		return 0;
>  
> -- 
> 2.41.0
> 

