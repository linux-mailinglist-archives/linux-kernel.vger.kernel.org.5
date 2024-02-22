Return-Path: <linux-kernel+bounces-76721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD8785FB83
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635C11F24C27
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8F41482F7;
	Thu, 22 Feb 2024 14:47:36 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C85146900
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613256; cv=none; b=ZjTFVwj2b1C887lXfFScV7hKOGUPPt4fN+rPgaoBMCmIOlIYV4tQqzDY9EtLFCTzQtsc+TLryeiKP40390t79jHESBkZVbKhXqjvYUCHrduRjCW6JAP2EKf0TsRqJmdJyz/4x10D99CHfrMbIAcUwewVIpqignqD3j4Ff3AtAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613256; c=relaxed/simple;
	bh=s08qFDFyauiHhIOYQ3iEIG+R2xyF6nr4Cusf4jErsCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PqVZ7NMKvOakcZlYAzlOANjwfikLENIgGn/kMB/ayhxCJkxmoIOycY7Lg66mzVWf0gRTgB5P7J0FfhJjaGHlM6IkOob1/008eycLj7NWq89dm5SO0m2ZwyVXFLnIULwTzvWJpPwX2TsENCQ0YK/BXV6G/D0VF06no53Xr27Pm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TgbXc0hsKz2Bcy6;
	Thu, 22 Feb 2024 22:45:20 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 04D321A0172;
	Thu, 22 Feb 2024 22:47:30 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 22:47:28 +0800
Message-ID: <fe85397a-ae81-49a2-9376-2166274d7337@huawei.com>
Date: Thu, 22 Feb 2024 22:47:27 +0800
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
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Yongqiang Liu <liuyongqiang13@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <yanaijie@huawei.com>,
	<zhangxiaoxu5@huawei.com>, <sunnanyong@huawei.com>, <rppt@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <keescook@chromium.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <willy@infradead.org>
References: <20240222140147.1880357-1-liuyongqiang13@huawei.com>
 <f795228c-9795-4449-abcb-b7ff0cb486fb@huawei.com>
 <ZddcSai76/KWxlMc@shell.armlinux.org.uk>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZddcSai76/KWxlMc@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/2/22 22:38, Russell King (Oracle) wrote:
> On Thu, Feb 22, 2024 at 10:06:04PM +0800, Kefeng Wang wrote:
>>
>>
>> On 2024/2/22 22:01, Yongqiang Liu wrote:
>>> Since commit a4d5613c4dc6 ("arm: extend pfn_valid to take into account
>>> freed memory map alignment") changes the semantics of pfn_valid() to check
>>> presence of the memory map for a PFN. A valid page for an address which
>>> is reserved but not mapped by the kernel[1].In Some uio case we will get
>>> a crash on a system with the following memory layout:
>>>
>>>    node   0: [mem 0x00000000c0a00000-0x00000000cc8fffff]
>>>    node   0: [mem 0x00000000d0000000-0x00000000da1fffff]
>>>    the uio layout is：0xc0900000, 0x100000
>>>
>>> the crash backtrace like:
>>>
>>>     Unable to handle kernel paging request at virtual address bff00000
>>>     [...]
>>>     CPU: 1 PID: 465 Comm: startapp.bin Tainted: G           O      5.10.0 #1
>>>     Hardware name: Generic DT based system
>>>     PC is at b15_flush_kern_dcache_area+0x24/0x3c
>>>     LR is at __sync_icache_dcache+0x6c/0x98
>>>     [...]
>>>      (b15_flush_kern_dcache_area) from (__sync_icache_dcache+0x6c/0x98)
>>>      (__sync_icache_dcache) from (set_pte_at+0x28/0x54)
>>>      (set_pte_at) from (remap_pfn_range+0x1a0/0x274)
>>>      (remap_pfn_range) from (uio_mmap+0x184/0x1b8 [uio])
>>>      (uio_mmap [uio]) from (__mmap_region+0x264/0x5f4)
>>>      (__mmap_region) from (__do_mmap_mm+0x3ec/0x440)
>>>      (__do_mmap_mm) from (do_mmap+0x50/0x58)
>>>      (do_mmap) from (vm_mmap_pgoff+0xfc/0x188)
>>>      (vm_mmap_pgoff) from (ksys_mmap_pgoff+0xac/0xc4)
>>>      (ksys_mmap_pgoff) from (ret_fast_syscall+0x0/0x5c)
>>>     Code: e0801001 e2423001 e1c00003 f57ff04f (ee070f3e)
>>>     ---[ end trace 09cf0734c3805d52 ]---
>>>     Kernel panic - not syncing: Fatal exception
>>>
>>> So check if PG_reserved was set to solve this issue.
>>>
>>> [1]: https://lore.kernel.org/lkml/Zbtdue57RO0QScJM@linux.ibm.com/
>>>
>>> Fixes: a4d5613c4dc6 ("arm: extend pfn_valid to take into account freed memory map alignment")
>>> Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
>>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>>> ---
>>>    arch/arm/mm/flush.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
>>> index d19d140a10c7..f2b99223a0ab 100644
>>> --- a/arch/arm/mm/flush.c
>>> +++ b/arch/arm/mm/flush.c
>>> @@ -15,6 +15,7 @@
>>>    #include <asm/smp_plat.h>
>>>    #include <asm/tlbflush.h>
>>>    #include <linux/hugetlb.h>
>>> +#include <linux/memblock.h>
>> 这个删掉吧然后发出去
> 
> Speak English so that everyone knows what you are saying. You are
> participating in an international community where English is the
> language that we use to communicate between ourselves.
> 
Sorry, I mistake for a internal mail

To Yongqiang, please drop the unnecessary include and as Matthew said,
please consider to use folio helper.

> Thanks.
> 

