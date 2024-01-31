Return-Path: <linux-kernel+bounces-46977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B63E844755
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062E51F2756B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BF71E495;
	Wed, 31 Jan 2024 18:39:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E13339AD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726378; cv=none; b=HDTypbYmSToQl5icJ8/cGxb42UX1nK6iQ14mpSCmg0Eq2IzkE2WikorOsnc0JY0U9ip7bqQOy1h/Yj3oglUasYlN9lD+3evo6THUv0egzBpU5dXK6OmN+g9wt8c1TAPjk9UIBvTzp9Q5Z+qgMJrRImS6yD7Jr5xLKUFJA7dekAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726378; c=relaxed/simple;
	bh=f9xeWX8e6b2YAjJDbH0LuQzsq+Kh61w41S8QbmNW8x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCGDIrgCCCR+0e3GVMxZHmwnEWCWSxUuj/WiJGy7oKnzU58rbhtItJPr9e4VwYnHL5uXHa+BWG1/HQ+1vMZQoigYmed3/qUchBQMjYRed3LsP8K56X2BeqfwACxgp5MNt+HwNmbQJvfAF1RGd5wQjHSc38RcJTnculRXcB/cQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 623E4DA7;
	Wed, 31 Jan 2024 10:40:18 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96CFF3F738;
	Wed, 31 Jan 2024 10:39:33 -0800 (PST)
Message-ID: <0da50102-3e87-49f7-b8f7-45cfcb4232d6@arm.com>
Date: Wed, 31 Jan 2024 18:39:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: flush: don't abuse pfn_valid() to check if pfn is in
 RAM
Content-Language: en-GB
To: Yongqiang Liu <liuyongqiang13@huawei.com>,
 linux-arm-kernel@lists.infradead.org
Cc: yanaijie@huawei.com, zhangxiaoxu5@huawei.com, wangkefeng.wang@huawei.com,
 sunnanyong@huawei.com, linux@armlinux.org.uk, rppt@linux.ibm.com,
 linux-kernel@vger.kernel.org, keescook@chromium.org, arnd@arndb.de,
 m.szyprowski@samsung.com, willy@infradead.org
References: <20240131125907.1006760-1-liuyongqiang13@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240131125907.1006760-1-liuyongqiang13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/01/2024 12:59 pm, Yongqiang Liu wrote:
> Since commit a4d5613c4dc6 ("arm: extend pfn_valid to take into account
> freed memory map alignment") changes the semantics of pfn_valid() to check
> presence of the memory map for a PFN. __sync_icache_dcache() should use
> memblock_is_map_memory() instead of pfn_valid() to check if a PFN is in
> RAM or not.In Some uio case we will get a crash on a system with the
> following memory layout:
> 
>   node   0: [mem 0x00000000c0a00000-0x00000000cc8fffff]
>   node   0: [mem 0x00000000d0000000-0x00000000da1fffff]
>   the uio layout is：0xc0900000, 0x100000
> 
> the crash backtrace like:
> 
>    Unable to handle kernel paging request at virtual address bff00000
>    [...]
>    CPU: 1 PID: 465 Comm: startapp.bin Tainted: G           O      5.10.0 #1
>    Hardware name: Generic DT based system
>    PC is at b15_flush_kern_dcache_area+0x24/0x3c
>    LR is at __sync_icache_dcache+0x6c/0x98
>    [...]
>     (b15_flush_kern_dcache_area) from (__sync_icache_dcache+0x6c/0x98)
>     (__sync_icache_dcache) from (set_pte_at+0x28/0x54)
>     (set_pte_at) from (remap_pfn_range+0x1a0/0x274)
>     (remap_pfn_range) from (uio_mmap+0x184/0x1b8 [uio])
>     (uio_mmap [uio]) from (__mmap_region+0x264/0x5f4)
>     (__mmap_region) from (__do_mmap_mm+0x3ec/0x440)
>     (__do_mmap_mm) from (do_mmap+0x50/0x58)
>     (do_mmap) from (vm_mmap_pgoff+0xfc/0x188)
>     (vm_mmap_pgoff) from (ksys_mmap_pgoff+0xac/0xc4)
>     (ksys_mmap_pgoff) from (ret_fast_syscall+0x0/0x5c)
>    Code: e0801001 e2423001 e1c00003 f57ff04f (ee070f3e)
>    ---[ end trace 09cf0734c3805d52 ]---
>    Kernel panic - not syncing: Fatal exception
> 
> Fixes: a4d5613c4dc6 ("arm: extend pfn_valid to take into account freed memory map alignment")
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> ---
>   arch/arm/mm/flush.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index d19d140a10c7..11ec6c5ff5fc 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -15,6 +15,7 @@
>   #include <asm/smp_plat.h>
>   #include <asm/tlbflush.h>
>   #include <linux/hugetlb.h>
> +#include <linux/memblock.h>
>   
>   #include "mm.h"
>   
> @@ -292,7 +293,7 @@ void __sync_icache_dcache(pte_t pteval)
>   		/* only flush non-aliasing VIPT caches for exec mappings */
>   		return;
>   	pfn = pte_pfn(pteval);
> -	if (!pfn_valid(pfn))
> +	if (!memblock_is_map_memory(PFN_PHYS(pfn)))
>   		return;
>   
>   	folio = page_folio(pfn_to_page(pfn));

Hmm, it's a bit odd in context, since pfn_valid() obviously pairs with 
this pfn_to_page(), whereas it's not necessarily clear that 
memblock_is_map_memory() implies pfn_valid().

However, in this case we're starting from a PTE - rather than going off 
to do a slow scan of memblock to determine whether a round-trip through 
page_address() is going to give back a mapped VA, can we not trivially 
identify that from whether the PTE itself is valid?

Thanks,
Robin.

