Return-Path: <linux-kernel+bounces-165388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D14D8B8C21
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EFE283237
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5CE1DA24;
	Wed,  1 May 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+JDvGWe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF78E219F9;
	Wed,  1 May 2024 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574842; cv=none; b=fbH9C0xhvf272YA9+R+bBOpR6us/txaIZZk5xttUIzkBrJh+67xcYdfTTkAzzSUEyYEBVOl8HQtdfO02WjzH4vpeDhHnfeN3wDyaDF8m1f8QNEhLJDf2s528B5bfwL3Z0Vfzfk0BCmUN2YGhqNlichJ7A+JJjY2Zja9AAQ129Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574842; c=relaxed/simple;
	bh=CxsjO+HboT5eCDqADgM4r/KpEYfbC3WzDJ+JdCdDWXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUpYBs0C+6IPu+z4v1m/E2hCt0LW9NSz5+GTA36Q8xl71LNLYEH2X8Da3CAmIKgP2lX0XAD1oH4i3vAJqEv39rtQ8MvX68tcOAMFhS6bFRMEYK2GPa2mFBCRlAd0Kn5JQ3uL7oLFCDT7qjWvgsVohtt/oAODNZM3uU5YPC1XV70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+JDvGWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C68DC072AA;
	Wed,  1 May 2024 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714574842;
	bh=CxsjO+HboT5eCDqADgM4r/KpEYfbC3WzDJ+JdCdDWXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+JDvGWeiBPw+HG1hQllCw3rfJnF5mRHzQWJfYyVSdBnJeLo7AnBOHdKkuoGmKsHV
	 qWzIyIOfihVax38aOS+SQFJCa04Pg6k/PKHdS78FnNhpPx0Q7h/4fdlmkbJQeszChb
	 EIiTbSxcUuDz+zQZlfmHW/bzb18nVHNLU6E/IN359z2k0CYTIl1DLmdRTVH2RexV/9
	 CPAhScPdfqxzR3mALBaqDIaoV4ebN/V38X67L1EqbysDjO6YW1JtrE90edXoZMLrm0
	 XgonsNZ2vYedRTvQTybLYYZd23v2s7lXDWvCqz/E2oz/BXLCtP1sriqxNEltkCVH9w
	 3GWsjlCazIa5A==
Date: Wed, 1 May 2024 17:45:49 +0300
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
Message-ID: <ZjJVnZUX3NZiGW6q@kernel.org>
References: <20240409210254.660888920@goodmis.org>
 <20240409172358.34ea19f0@gandalf.local.home>
 <202404091519.B7B2221@keescook>
 <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <3391c693-cf54-526b-79a8-d565e7140947@igalia.com>
 <20240411154007.5bdf8d95@gandalf.local.home>
 <fa5fa4c6-2b02-f47e-b9ba-65cfd85f57f8@igalia.com>
 <20240412132243.053ad096@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412132243.053ad096@gandalf.local.home>

On Fri, Apr 12, 2024 at 01:22:43PM -0400, Steven Rostedt wrote:
> On Fri, 12 Apr 2024 09:17:18 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
> > Thanks Steve, seems a good idea. With that, I could test on kdumpst (the
> > tool used on Steam Deck), since it relies on modular pstore/ram.
> 
> Something like this could work.
> 
> -- Steve
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index a8831ef30c73..878aee8b2399 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -16,6 +16,7 @@
>  #include <linux/firmware-map.h>
>  #include <linux/sort.h>
>  #include <linux/memory_hotplug.h>
> +#include <linux/mm.h>
>  
>  #include <asm/e820/api.h>
>  #include <asm/setup.h>
> @@ -64,61 +65,6 @@ struct e820_table *e820_table __refdata			= &e820_table_init;
>  struct e820_table *e820_table_kexec __refdata		= &e820_table_kexec_init;
>  struct e820_table *e820_table_firmware __refdata	= &e820_table_firmware_init;
>  
> -/* For wildcard memory requests, have a table to find them later */
> -#define E820_MAX_MAPS		8
> -#define E820_MAP_NAME_SIZE	16
> -struct e820_mmap_map {
> -	char			name[E820_MAP_NAME_SIZE];
> -	u64			start;
> -	u64			size;
> -};
> -static struct e820_mmap_map e820_mmap_list[E820_MAX_MAPS] __initdata;
> -static int e820_mmap_size				__initdata;
> -
> -/* Add wildcard region with a lookup name */
> -static int __init e820_add_mmap(u64 start, u64 size, const char *name)
> -{
> -	struct e820_mmap_map *map;
> -
> -	if (!name || !name[0] || strlen(name) >= E820_MAP_NAME_SIZE)
> -		return -EINVAL;
> -
> -	if (e820_mmap_size >= E820_MAX_MAPS)
> -		return -1;
> -
> -	map = &e820_mmap_list[e820_mmap_size++];
> -	map->start = start;
> -	map->size = size;
> -	strcpy(map->name, name);
> -	return 0;
> -}
> -
> -/**
> - * memmap_named - Find a wildcard region with a given name
> - * @name: The name that is attached to a wildcard region
> - * @start: If found, holds the start address
> - * @size: If found, holds the size of the address.
> - *
> - * Returns: 1 if found or 0 if not found.
> - */
> -int __init memmap_named(const char *name, u64 *start, u64 *size)
> -{
> -	struct e820_mmap_map *map;
> -	int i;
> -
> -	for (i = 0; i < e820_mmap_size; i++) {
> -		map = &e820_mmap_list[i];
> -		if (!map->size)
> -			continue;
> -		if (strcmp(name, map->name) == 0) {
> -			*start = map->start;
> -			*size = map->size;
> -			return 1;
> -		}
> -	}
> -	return 0;
> -}
> -
>  /* For PCI or other memory-mapped resources */
>  unsigned long pci_mem_start = 0xaeedbabe;
>  #ifdef CONFIG_PCI
> @@ -1024,6 +970,8 @@ static int __init parse_memmap_one(char *p)
>  		e820__range_add(start_at, mem_size, E820_TYPE_RESERVED);
>  	} else if (*p == '*') {
>  		u64 align;
> +		int ret;
> +
>  		/* Followed by alignment and ':' then the name */
>  		align = memparse(p+1, &p);
>  		start_at = e820__region(mem_size, align);
> @@ -1032,9 +980,10 @@ static int __init parse_memmap_one(char *p)
>  		if (*p != ':')
>  			return -EINVAL;
>  		p++;
> -		e820_add_mmap(start_at, mem_size, p);
> +		ret = memmap_add(start_at, mem_size, p);
>  		p += strlen(p);
> -		e820__range_add(start_at, mem_size, E820_TYPE_RESERVED);
> +		if (!ret)
> +			e820__range_add(start_at, mem_size, E820_TYPE_RESERVED);
>  	} else if (*p == '!') {
>  		start_at = memparse(p+1, &p);
>  		e820__range_add(start_at, mem_size, E820_TYPE_PRAM);
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index c200388399fb..22d2e2731dc2 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -919,7 +919,6 @@ static void __init ramoops_register_dummy(void)
>  {
>  	struct ramoops_platform_data pdata;
>  
> -#ifndef MODULE
>  	/* Only allowed when builtin */
>  	if (mem_name) {
>  		u64 start;
> @@ -930,7 +929,6 @@ static void __init ramoops_register_dummy(void)
>  			mem_size = size;
>  		}
>  	}
> -#endif
>  
>  	/*
>  	 * Prepare a dummy platform data structure to carry the module
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cf9b34454c6f..6ce1c6929d1f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4203,5 +4203,6 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
>  }
>  
>  int memmap_named(const char *name, u64 *start, u64 *size);
> +int memmap_add(long start, long size, const char *name);
>  
>  #endif /* _LINUX_MM_H */
> diff --git a/mm/memory.c b/mm/memory.c
> index 7a29f17df7c1..fe054e1bb678 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -120,12 +120,6 @@ static bool vmf_orig_pte_uffd_wp(struct vm_fault *vmf)
>  	return pte_marker_uffd_wp(vmf->orig_pte);
>  }
>  
> -int __init __weak memmap_named(const char *name, u64 *start, u64 *size)
> -{
> -	pr_info("Kernel command line: memmap=nn*align:name not supported on this kernel");
> -	/* zero means not found */
> -	return 0;
> -}
>  
>  /*
>   * A number of key systems in x86 including ioremap() rely on the assumption
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 549e76af8f82..e5b729b83fdc 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -154,6 +154,77 @@ static __init int set_mminit_loglevel(char *str)
>  early_param("mminit_loglevel", set_mminit_loglevel);
>  #endif /* CONFIG_DEBUG_MEMORY_INIT */
>  
> +/* For wildcard memory requests, have a table to find them later */
> +#define MAX_MAPS		8
> +#define MAP_NAME_SIZE	16
> +struct mmap_map {
> +	char			name[MAP_NAME_SIZE];
> +	long			start;
> +	long			size;
> +};
> +static struct mmap_map early_mmap_list[MAX_MAPS] __initdata;
> +static int early_mmap_size			__initdata;
> +static struct mmap_map *mmap_list;
> +
> +/* Add wildcard region with a lookup name */
> +int memmap_add(long start, long size, const char *name)
> +{
> +	struct mmap_map *map;
> +
> +	if (!name || !name[0] || strlen(name) >= MAP_NAME_SIZE)
> +		return -EINVAL;
> +
> +	if (early_mmap_size >= MAX_MAPS)
> +		return -1;
> +
> +	map = &early_mmap_list[early_mmap_size++];
> +	map->start = start;
> +	map->size = size;
> +	strcpy(map->name, name);
> +	return 0;
> +}
> +
> +static void __init memmap_copy(void)
> +{
> +	if (!early_mmap_size)
> +		return;
> +
> +	mmap_list = kcalloc(early_mmap_size + 1, sizeof(mmap_list), GFP_KERNEL);

We can keep early_mmap_size after boot and then we don't need to allocate
an extra element in the mmap_list. No strong feeling here, though.

> +	if (!mmap_list)
> +		return;
> +
> +	for (int i = 0; i < early_mmap_size; i++)
> +		mmap_list[i] = early_mmap_list[i];
> +}

With something like this

/*
 * Parse early_reserve_mem=nn:align:name
 */
static int __init early_reserve_mem(char *p)
{
	phys_addr_t start, size, align;
	char *oldp;
	int err;

	if (!p)
		return -EINVAL;

	oldp = p;
	size = memparse(p, &p);
	if (p == oldp)
		return -EINVAL;

	if (*p != ':')
		return -EINVAL;

	align = memparse(p+1, &p);
	if (*p != ':')
		return -EINVAL;

	start = memblock_phys_alloc(size, align);
	if (!start)
		return -ENOMEM;

	p++;
	err = memmap_add(start, size, p);
	if (err) {
		memblock_phys_free(start, size);
		return err;
	}

	p += strlen(p);

	return *p == '\0' ? 0: -EINVAL;
}
__setup("early_reserve_mem=", early_reserve_mem);

you don't need to touch e820 and it will work the same for all
architectures.

We'd need a better naming, but I couldn't think of something better yet.

> +
> +/**
> + * memmap_named - Find a wildcard region with a given name
> + * @name: The name that is attached to a wildcard region
> + * @start: If found, holds the start address
> + * @size: If found, holds the size of the address.
> + *
> + * Returns: 1 if found or 0 if not found.
> + */
> +int memmap_named(const char *name, u64 *start, u64 *size)
> +{
> +	struct mmap_map *map;
> +
> +	if (!mmap_list)
> +		return 0;
> +
> +	for (int i = 0; mmap_list[i].name[0]; i++) {
> +		map = &mmap_list[i];
> +		if (!map->size)
> +			continue;
> +		if (strcmp(name, map->name) == 0) {
> +			*start = map->start;
> +			*size = map->size;
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
>  struct kobject *mm_kobj;
>  
>  #ifdef CONFIG_SMP
> @@ -2793,4 +2864,5 @@ void __init mm_core_init(void)
>  	pti_init();
>  	kmsan_init_runtime();
>  	mm_cache_init();
> +	memmap_copy();
>  }

-- 
Sincerely yours,
Mike.

