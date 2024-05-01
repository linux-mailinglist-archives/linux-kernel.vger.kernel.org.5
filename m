Return-Path: <linux-kernel+bounces-165391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD98B8C2A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBE41C211C5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41C612EBDB;
	Wed,  1 May 2024 14:54:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B2312E6A;
	Wed,  1 May 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575255; cv=none; b=T9+smeqho1vhoq/Na6f6EOPC5pdietggFKCDzFSLz7SB5rdyyTtIuJyOeqJfNolUBW0f+5xa1tJJSccK1H0LzuIAYV5KyotyA0NqBEbS696IFQ7MBlBDCdh+YKNQIVhEmhj99EtUigFvPuJlWXwuWrWIRc/C5Spp3G1FVXlFa5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575255; c=relaxed/simple;
	bh=kh+wjNGTe3rkosFU5tIMQvZ6bZ/Ezmwl/V7rTuuidyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWhH+HRD0AAZVDgvTPZqmmn+ZgWpydlRgySV4ZEl6NuRNCtm0JybYp+axPeLcy5eZxwg02Lyjxx+9GE37JovOMTH6hWtBDwsw4ulo5KQYQfZfS8h5M0b/4XW8AgmLWjOOGPHkCQ4nsuhjJZxXRlyu1Wvec5MayUTDoZ0MmJkQh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE7DC072AA;
	Wed,  1 May 2024 14:54:11 +0000 (UTC)
Date: Wed, 1 May 2024 10:54:55 -0400
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
Message-ID: <20240501105455.42b78a0b@gandalf.local.home>
In-Reply-To: <ZjJVnZUX3NZiGW6q@kernel.org>
References: <20240409210254.660888920@goodmis.org>
	<20240409172358.34ea19f0@gandalf.local.home>
	<202404091519.B7B2221@keescook>
	<SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
	<3391c693-cf54-526b-79a8-d565e7140947@igalia.com>
	<20240411154007.5bdf8d95@gandalf.local.home>
	<fa5fa4c6-2b02-f47e-b9ba-65cfd85f57f8@igalia.com>
	<20240412132243.053ad096@gandalf.local.home>
	<ZjJVnZUX3NZiGW6q@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 May 2024 17:45:49 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> > +static void __init memmap_copy(void)
> > +{
> > +	if (!early_mmap_size)
> > +		return;
> > +
> > +	mmap_list = kcalloc(early_mmap_size + 1, sizeof(mmap_list), GFP_KERNEL);  
> 
> We can keep early_mmap_size after boot and then we don't need to allocate
> an extra element in the mmap_list. No strong feeling here, though.
> 
> > +	if (!mmap_list)
> > +		return;
> > +
> > +	for (int i = 0; i < early_mmap_size; i++)
> > +		mmap_list[i] = early_mmap_list[i];
> > +}  
> 
> With something like this
> 
> /*
>  * Parse early_reserve_mem=nn:align:name
>  */
> static int __init early_reserve_mem(char *p)
> {
> 	phys_addr_t start, size, align;
> 	char *oldp;
> 	int err;
> 
> 	if (!p)
> 		return -EINVAL;
> 
> 	oldp = p;
> 	size = memparse(p, &p);
> 	if (p == oldp)
> 		return -EINVAL;
> 
> 	if (*p != ':')
> 		return -EINVAL;
> 
> 	align = memparse(p+1, &p);
> 	if (*p != ':')
> 		return -EINVAL;
> 
> 	start = memblock_phys_alloc(size, align);

So this will allocate the same physical location for every boot, if booting
the same kernel and having the same physical memory layout?

-- Steve


> 	if (!start)
> 		return -ENOMEM;
> 
> 	p++;
> 	err = memmap_add(start, size, p);
> 	if (err) {
> 		memblock_phys_free(start, size);
> 		return err;
> 	}
> 
> 	p += strlen(p);
> 
> 	return *p == '\0' ? 0: -EINVAL;
> }
> __setup("early_reserve_mem=", early_reserve_mem);
> 
> you don't need to touch e820 and it will work the same for all
> architectures.
> 
> We'd need a better naming, but I couldn't think of something better yet.
> 
> > +
> > +/**
> > + * memmap_named - Find a wildcard region with a given name
> > + * @name: The name that is attached to a wildcard region
> > + * @start: If found, holds the start address
> > + * @size: If found, holds the size of the address.
> > + *
> > + * Returns: 1 if found or 0 if not found.
> > + */
> > +int memmap_named(const char *name, u64 *start, u64 *size)
> > +{
> > +	struct mmap_map *map;
> > +
> > +	if (!mmap_list)
> > +		return 0;
> > +
> > +	for (int i = 0; mmap_list[i].name[0]; i++) {
> > +		map = &mmap_list[i];
> > +		if (!map->size)
> > +			continue;
> > +		if (strcmp(name, map->name) == 0) {
> > +			*start = map->start;
> > +			*size = map->size;
> > +			return 1;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> >  struct kobject *mm_kobj;
> >  
> >  #ifdef CONFIG_SMP
> > @@ -2793,4 +2864,5 @@ void __init mm_core_init(void)
> >  	pti_init();
> >  	kmsan_init_runtime();
> >  	mm_cache_init();
> > +	memmap_copy();
> >  }  
> 


