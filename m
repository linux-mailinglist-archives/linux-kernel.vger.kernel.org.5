Return-Path: <linux-kernel+bounces-165495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1368B8D3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843A528B0BC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D98135A5D;
	Wed,  1 May 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXnzuEXF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E4130E2C;
	Wed,  1 May 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577533; cv=none; b=CoM7/X5AYuQkyVtgO946Lx8MJgRQ3VQq2E4Dr8jZX6ac5yeRTbqhSa1r9m0yjkXkr7BxfmYa+m1UjfQFrfV2/BhFCtLA1pZNBy/npELw54Zii5bZrWGhEkKIOUojB++nFAEqCJ1J99IbefxYnygdC93ojHRT8RyKDGtPa3CvQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577533; c=relaxed/simple;
	bh=8WVzesDRY59eAiPcjnXVtYZdjfYneGgUndVN5TPMtzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2yfTwAV5BjBgaoQx/75YLzZ8us9SkC4kDu3lUMpZ+bDRXOHWu07HnOMnxTd+wUEgpRULxgxfAxsiwH0vP8aKZMTYOtmty/CjACWEBAMptmqsuS48pi7364aHKVID/vXZffFpSdJQt9TwIa9fDokl8RgwaKcRkyj908rZXZ+I7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXnzuEXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B21C072AA;
	Wed,  1 May 2024 15:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714577533;
	bh=8WVzesDRY59eAiPcjnXVtYZdjfYneGgUndVN5TPMtzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXnzuEXFOzVTCgd5UODHWCQzEQeUrDLX81JT65/GEltCEd/tyHH+BLaUsWjdag4di
	 hsX4FvfdNTemCxIOYPGYVnar8IwFthSkq78k64ASXt1W4BaEW83jvwX7uPMusoACjZ
	 j66Fnuw8uVy+mpqhmjsjezyatLL2rRq2GpADPntHrJEffjsa7c8328QtaelxsbUBHV
	 2BDotzuP4B4uSEaplwH/uB4AdWjTqDZbsLgMkR0ZjGJ6S91803rYH7gOGjIopFU4Hf
	 vQAKQgn9iCejJaFuT+QjyBrJ5fyl5Y+JgcaveC2Ih9v84TKeo+134tMrmAC49RAzXj
	 BYWWsYFZ7UZQA==
Date: Wed, 1 May 2024 18:30:40 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>,
	"wklin@google.com" <wklin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Message-ID: <ZjJgIIOvvEdnisNA@kernel.org>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501105455.42b78a0b@gandalf.local.home>

On Wed, May 01, 2024 at 10:54:55AM -0400, Steven Rostedt wrote:
> On Wed, 1 May 2024 17:45:49 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > > +static void __init memmap_copy(void)
> > > +{
> > > +	if (!early_mmap_size)
> > > +		return;
> > > +
> > > +	mmap_list = kcalloc(early_mmap_size + 1, sizeof(mmap_list), GFP_KERNEL);  
> > 
> > We can keep early_mmap_size after boot and then we don't need to allocate
> > an extra element in the mmap_list. No strong feeling here, though.
> > 
> > > +	if (!mmap_list)
> > > +		return;
> > > +
> > > +	for (int i = 0; i < early_mmap_size; i++)
> > > +		mmap_list[i] = early_mmap_list[i];
> > > +}  
> > 
> > With something like this
> > 
> > /*
> >  * Parse early_reserve_mem=nn:align:name
> >  */
> > static int __init early_reserve_mem(char *p)
> > {
> > 	phys_addr_t start, size, align;
> > 	char *oldp;
> > 	int err;
> > 
> > 	if (!p)
> > 		return -EINVAL;
> > 
> > 	oldp = p;
> > 	size = memparse(p, &p);
> > 	if (p == oldp)
> > 		return -EINVAL;
> > 
> > 	if (*p != ':')
> > 		return -EINVAL;
> > 
> > 	align = memparse(p+1, &p);
> > 	if (*p != ':')
> > 		return -EINVAL;
> > 
> > 	start = memblock_phys_alloc(size, align);
> 
> So this will allocate the same physical location for every boot, if booting
> the same kernel and having the same physical memory layout?

Up to kaslr that might use that location for the kernel image.
But it's the same as allocating from e820 after kaslr.

And, TBH, I don't have good ideas how to ensure the same physical location
with randomization of the physical address of the kernel image.
 
> -- Steve
> 
> 
> > 	if (!start)
> > 		return -ENOMEM;
> > 
> > 	p++;
> > 	err = memmap_add(start, size, p);
> > 	if (err) {
> > 		memblock_phys_free(start, size);
> > 		return err;
> > 	}
> > 
> > 	p += strlen(p);
> > 
> > 	return *p == '\0' ? 0: -EINVAL;
> > }
> > __setup("early_reserve_mem=", early_reserve_mem);
> > 
> > you don't need to touch e820 and it will work the same for all
> > architectures.
> > 
> > We'd need a better naming, but I couldn't think of something better yet.
> > 
> > > +
> > > +/**
> > > + * memmap_named - Find a wildcard region with a given name
> > > + * @name: The name that is attached to a wildcard region
> > > + * @start: If found, holds the start address
> > > + * @size: If found, holds the size of the address.
> > > + *
> > > + * Returns: 1 if found or 0 if not found.
> > > + */
> > > +int memmap_named(const char *name, u64 *start, u64 *size)
> > > +{
> > > +	struct mmap_map *map;
> > > +
> > > +	if (!mmap_list)
> > > +		return 0;
> > > +
> > > +	for (int i = 0; mmap_list[i].name[0]; i++) {
> > > +		map = &mmap_list[i];
> > > +		if (!map->size)
> > > +			continue;
> > > +		if (strcmp(name, map->name) == 0) {
> > > +			*start = map->start;
> > > +			*size = map->size;
> > > +			return 1;
> > > +		}
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > >  struct kobject *mm_kobj;
> > >  
> > >  #ifdef CONFIG_SMP
> > > @@ -2793,4 +2864,5 @@ void __init mm_core_init(void)
> > >  	pti_init();
> > >  	kmsan_init_runtime();
> > >  	mm_cache_init();
> > > +	memmap_copy();
> > >  }  
> > 
> 

-- 
Sincerely yours,
Mike.

