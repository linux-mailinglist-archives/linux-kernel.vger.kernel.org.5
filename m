Return-Path: <linux-kernel+bounces-76674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D865385FAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7872D1F26FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183614A4C7;
	Thu, 22 Feb 2024 14:06:14 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E087133408
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610773; cv=none; b=JeXr2YR4muqOkfS+aeSnlhPot7OlfD6gieS0iPVZkog00JU5vZZPVVctIiHDxMame8KYpX5BbodH8YULIWc0FSlX7qrWYGgpZcXj4kRD0yiO6bR39P9K2Hsz6tuuT8luqI87cz0bqP8prDGpzTBE2fzXBNWK8kEZdY+WsqhQNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610773; c=relaxed/simple;
	bh=JMuSVzb6yFklTV1JNBRqb15YMwdN2bK9kOexARPWUDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NZvETfYiz9YTZYfgGnb+gYCiUdtl1723iOrqptCr4f4188XCoc166E/N6uvkb4zeon2gM48TkdXUVAR41IKEEPcqm8t1/P68DSTdncbCdPgo56Pn/SqFbNk5elm69vATi7zCqlUrQzQNdNYyTDCEWdpplkMCM5bzoOSNT4yMWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TgZfg0TgGz1vv03;
	Thu, 22 Feb 2024 22:05:31 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B565D140429;
	Thu, 22 Feb 2024 22:06:05 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 22:06:05 +0800
Message-ID: <f795228c-9795-4449-abcb-b7ff0cb486fb@huawei.com>
Date: Thu, 22 Feb 2024 22:06:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: flush: check if the folio is reserved for IMO
 addresses
Content-Language: en-US
To: Yongqiang Liu <liuyongqiang13@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: <yanaijie@huawei.com>, <zhangxiaoxu5@huawei.com>, <sunnanyong@huawei.com>,
	<linux@armlinux.org.uk>, <rppt@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <keescook@chromium.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <willy@infradead.org>
References: <20240222140147.1880357-1-liuyongqiang13@huawei.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240222140147.1880357-1-liuyongqiang13@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/2/22 22:01, Yongqiang Liu wrote:
> Since commit a4d5613c4dc6 ("arm: extend pfn_valid to take into account
> freed memory map alignment") changes the semantics of pfn_valid() to check
> presence of the memory map for a PFN. A valid page for an address which
> is reserved but not mapped by the kernel[1].In Some uio case we will get
> a crash on a system with the following memory layout:
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
> So check if PG_reserved was set to solve this issue.
> 
> [1]: https://lore.kernel.org/lkml/Zbtdue57RO0QScJM@linux.ibm.com/
> 
> Fixes: a4d5613c4dc6 ("arm: extend pfn_valid to take into account freed memory map alignment")
> Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> ---
>   arch/arm/mm/flush.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index d19d140a10c7..f2b99223a0ab 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -15,6 +15,7 @@
>   #include <asm/smp_plat.h>
>   #include <asm/tlbflush.h>
>   #include <linux/hugetlb.h>
> +#include <linux/memblock.h>
这个删掉吧然后发出去
>   
>   #include "mm.h"
>   
> @@ -296,6 +297,9 @@ void __sync_icache_dcache(pte_t pteval)
>   		return;
>   
>   	folio = page_folio(pfn_to_page(pfn));
> +	if (test_bit(PG_reserved, &folio->flags))
> +		return;
> +
>   	if (cache_is_vipt_aliasing())
>   		mapping = folio_flush_mapping(folio);
>   	else

