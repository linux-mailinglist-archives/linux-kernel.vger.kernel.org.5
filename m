Return-Path: <linux-kernel+bounces-14771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8157D8221FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F8228416F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E4915E94;
	Tue,  2 Jan 2024 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AGKUIlWB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1683B16401;
	Tue,  2 Jan 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (c-73-239-240-195.hsd1.wa.comcast.net [73.239.240.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 13EF120B3CC1;
	Tue,  2 Jan 2024 11:29:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13EF120B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704223757;
	bh=NWTVgm1Yghg6D+rhM1rcN+66tvwgyzPsGZv9i/VSt6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGKUIlWB2Mm3FV6uXLBIaYKw+ZOwF2oq+eG0GukNiGT0FaLu/cVNCJon1WWLrmbVf
	 J0hpNTn0r5lQ7JZB7M+RoCQjykomiAtupbkO2imOrk6t0a4a8otvll3IN45v8vvg9M
	 ESzfuKVdNYd5yhrMIDgJwHYz4CZGB1jbtbq0mHws=
Date: Sun, 31 Dec 2023 19:01:41 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Alexander Graf <graf@amazon.com>, ""@skinsburskii
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, arnd@arndb.de,
	pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 02/17] memblock: Declare scratch memory as CMA
Message-ID: <20240101030141.GA723@skinsburskii.>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222193607.15474-3-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222193607.15474-3-graf@amazon.com>

On Fri, Dec 22, 2023 at 07:35:52PM +0000, Alexander Graf wrote:
> When we finish populating our memory, we don't want to lose the scratch
> region as memory we can use for useful data. Do do that, we mark it as
> CMA memory. That means that any allocation within it only happens with
> movable memory which we can then happily discard for the next kexec.
> 
> That way we don't lose the scratch region's memory anymore for
> allocations after boot.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---
> 
> v1 -> v2:
> 
>   - test bot warning fix
> ---
>  mm/memblock.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e89e6c8f9d75..3700c2c1a96d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -16,6 +16,7 @@
>  #include <linux/kmemleak.h>
>  #include <linux/seq_file.h>
>  #include <linux/memblock.h>
> +#include <linux/page-isolation.h>
>  
>  #include <asm/sections.h>
>  #include <linux/io.h>
> @@ -1100,10 +1101,6 @@ static bool should_skip_region(struct memblock_type *type,
>  	if ((flags & MEMBLOCK_SCRATCH) && !memblock_is_scratch(m))
>  		return true;
>  
> -	/* Leave scratch memory alone after scratch-only phase */
> -	if (!(flags & MEMBLOCK_SCRATCH) && memblock_is_scratch(m))
> -		return true;
> -
>  	return false;
>  }
>  
> @@ -2153,6 +2150,20 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
>  	}
>  }
>  
> +#ifdef CONFIG_MEMBLOCK_SCRATCH
> +static void reserve_scratch_mem(phys_addr_t start, phys_addr_t end)

nit: the function name doesn't look reasonable as it has nothing
limiting it to neither reservation nor scratch mem.
Perhaps something like "set_mem_cma_type" would be a better fit.

> +{
> +	ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
> +	ulong end_pfn = pageblock_align(PFN_UP(end));
> +	ulong pfn;
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
> +		/* Mark as CMA to prevent kernel allocations in it */

nit: the comment above looks irrelevant/redundant.

> +		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_CMA);
> +	}
> +}
> +#endif
> +
>  static unsigned long __init __free_memory_core(phys_addr_t start,
>  				 phys_addr_t end)
>  {
> @@ -2214,6 +2225,17 @@ static unsigned long __init free_low_memory_core_early(void)
>  
>  	memmap_init_reserved_pages();
>  
> +#ifdef CONFIG_MEMBLOCK_SCRATCH
> +	/*
> +	 * Mark scratch mem as CMA before we return it. That way we ensure that
> +	 * no kernel allocations happen on it. That means we can reuse it as
> +	 * scratch memory again later.
> +	 */
> +	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> +			     MEMBLOCK_SCRATCH, &start, &end, NULL)
> +		reserve_scratch_mem(start, end);
> +#endif
> +
>  	/*
>  	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
>  	 *  because in some case like Node0 doesn't have RAM installed
> -- 
> 2.40.1
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 

