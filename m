Return-Path: <linux-kernel+bounces-165543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9723E8B8DC5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CFF1C213AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B28312FF76;
	Wed,  1 May 2024 16:08:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC78827;
	Wed,  1 May 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579705; cv=none; b=HcvFABegW9UXJJerf7k4jqkt45sovKg1IPyWXGaUHBcITKYpj+DheF7LGVq1mEwIIzRtzw/nwwVgQI//EhqiyhzuBKfu2Qu+5Gjlc2g3Q7KLIY83XVntZAzbVokaF7dRkFjkTNpmRIzQN0v804MLv/i5YgSwF2/a9WHYpDuFzIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579705; c=relaxed/simple;
	bh=2SspBcZpqjL2uiy7RfwIeISM+1+EsXvx/gfjXujlavw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F33cU1zh+mC52L9Cuvxt97rS32LWtADV+noxty/8VBfoN2sPuufiFCceljo7cJdaXQijEXNbt1LMPCLTuGxJVsfXc8ZZL4TY28uXEpQrR014B4mdBYDZZGdXNCD5mB/P+GbHvI6DLoGM8TKdriM9EepAoEIlEP/DjV1SiKOWgh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EE9C072AA;
	Wed,  1 May 2024 16:08:21 +0000 (UTC)
Date: Wed, 1 May 2024 12:09:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Luck, Tony"
 <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, Joel Fernandes
 <joel@joelfernandes.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, "linux-hardening@vger.kernel.org"
 <linux-hardening@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Ross
 Zwisler <zwisler@google.com>, "wklin@google.com" <wklin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Suleiman Souhlal
 <suleiman@google.com>, Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Message-ID: <20240501120904.61c7617c@gandalf.local.home>
In-Reply-To: <ZjJgIIOvvEdnisNA@kernel.org>
References: <20240409210254.660888920@goodmis.org>
	<20240409172358.34ea19f0@gandalf.local.home>
	<202404091519.B7B2221@keescook>
	<SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
	<3391c693-cf54-526b-79a8-d565e7140947@igalia.com>
	<20240411154007.5bdf8d95@gandalf.local.home>
	<fa5fa4c6-2b02-f47e-b9ba-65cfd85f57f8@igalia.com>
	<20240412132243.053ad096@gandalf.local.home>
	<ZjJVnZUX3NZiGW6q@kernel.org>
	<20240501105455.42b78a0b@gandalf.local.home>
	<ZjJgIIOvvEdnisNA@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 May 2024 18:30:40 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> > > /*
> > >  * Parse early_reserve_mem=nn:align:name
> > >  */
> > > static int __init early_reserve_mem(char *p)
> > > {
> > > 	phys_addr_t start, size, align;
> > > 	char *oldp;
> > > 	int err;
> > > 
> > > 	if (!p)
> > > 		return -EINVAL;
> > > 
> > > 	oldp = p;
> > > 	size = memparse(p, &p);
> > > 	if (p == oldp)
> > > 		return -EINVAL;
> > > 
> > > 	if (*p != ':')
> > > 		return -EINVAL;
> > > 
> > > 	align = memparse(p+1, &p);
> > > 	if (*p != ':')
> > > 		return -EINVAL;
> > > 
> > > 	start = memblock_phys_alloc(size, align);  
> > 
> > So this will allocate the same physical location for every boot, if booting
> > the same kernel and having the same physical memory layout?  
> 
> Up to kaslr that might use that location for the kernel image.
> But it's the same as allocating from e820 after kaslr.
> 
> And, TBH, I don't have good ideas how to ensure the same physical location
> with randomization of the physical address of the kernel image.

I'll try it out. Looking at arch/x86/boot/compressed/kaslr.c, if I read the
code correctly, it creates up to a 100 slots to store the kernel.

The method I used was to make sure that the allocation was always done at
the top address of memory, which I think would in most cases never be
assigned by KASLR.

This looks to just grab the next available physical address, which KASLR
can most definitely mess with.

I would still like to get the highest address possible.

-- Steve

