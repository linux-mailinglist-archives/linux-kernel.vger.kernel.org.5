Return-Path: <linux-kernel+bounces-47746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7AD845249
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35305290B66
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BABB158D67;
	Thu,  1 Feb 2024 08:00:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD22E63510
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774430; cv=none; b=sVv2VDlXCCmjjYNM7NzzN8wMY/MuaRJ13HUMJ/vXpvCDIUQMUp9TXCSnDkjlMIhLpzPecL4JiomxZ3o9voz7/r0t0U7E88FFgYMSzUc1nzymgRQFuY+XGSCgFGWr65eNuVbRcyquBd7eV7XEwZyz1OiN4RFCgQdMbmaIqHIBaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774430; c=relaxed/simple;
	bh=EOBqEFNHpWJcp9aw08HIF/reV3lCMQn+l0U0oavj4wI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=e0dU2phdAGoIYB3jPsCfS/rgnqOji2A0GHWtVcm1YBGeJ6Ug59H0VWGVqipnnOnIPM8QiosPeEUHLvYk1lLwirqLzGdG9f/rgOofCOeEsjYgObEPeSt5HbeqS6OUmGFscN+3sNdRTLVhLoNA+ce6nghbzKdrbfOO8fwBtup221o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TQWW748dfzvVQk;
	Thu,  1 Feb 2024 15:58:43 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (unknown [7.185.36.59])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D532140118;
	Thu,  1 Feb 2024 16:00:24 +0800 (CST)
Received: from [10.174.178.155] (10.174.178.155) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 16:00:23 +0800
Subject: Re: [PATCH] arm: flush: don't abuse pfn_valid() to check if pfn is in
 RAM
To: Robin Murphy <robin.murphy@arm.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <yanaijie@huawei.com>,
	<zhangxiaoxu5@huawei.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <rppt@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <keescook@chromium.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <willy@infradead.org>
References: <20240131125907.1006760-1-liuyongqiang13@huawei.com>
 <0da50102-3e87-49f7-b8f7-45cfcb4232d6@arm.com>
 <ZbqY12U/CXwAAu7A@shell.armlinux.org.uk>
 <edc4e8fa-af0a-46c2-bf07-20a0c4e20af5@arm.com>
From: Yongqiang Liu <liuyongqiang13@huawei.com>
Message-ID: <8b50ca93-c164-ddfc-cd79-8f8525198a96@huawei.com>
Date: Thu, 1 Feb 2024 16:00:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <edc4e8fa-af0a-46c2-bf07-20a0c4e20af5@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500005.china.huawei.com (7.185.36.59)

Very appreciate it for extra explanation. Notice that commit 024591f9a6e0

("arm: ioremap: don't abuse pfn_valid() to check if pfn is in RAM") use

memblock_is_map_memory() instead of pfn_valid() to check if a PFN is in

RAM or not, so I wrote the patch to solve this case.  Otherwise, when we

use pageblock align(4M) address of memory or uio, like :

      node   0: [mem 0x00000000c0c00000-0x00000000cc8fffff]
      node   0: [mem 0x00000000d0000000-0x00000000da1fffff]

or uio address set like:

    0xc0400000, 0x100000

the pfn_valid will return false as memblock_is_map_memory.

在 2024/2/1 5:20, Robin Murphy 写道:
> On 2024-01-31 7:00 pm, Russell King (Oracle) wrote:
>> On Wed, Jan 31, 2024 at 06:39:31PM +0000, Robin Murphy wrote:
>>> On 31/01/2024 12:59 pm, Yongqiang Liu wrote:
>>>> @@ -292,7 +293,7 @@ void __sync_icache_dcache(pte_t pteval)
>>>>            /* only flush non-aliasing VIPT caches for exec mappings */
>>>>            return;
>>>>        pfn = pte_pfn(pteval);
>>>> -    if (!pfn_valid(pfn))
>>>> +    if (!memblock_is_map_memory(PFN_PHYS(pfn)))
>>>>            return;
>>>>        folio = page_folio(pfn_to_page(pfn));
>>>
>>> Hmm, it's a bit odd in context, since pfn_valid() obviously pairs 
>>> with this
>>> pfn_to_page(), whereas it's not necessarily clear that
>>> memblock_is_map_memory() implies pfn_valid().
>>>
>>> However, in this case we're starting from a PTE - rather than going 
>>> off to
>>> do a slow scan of memblock to determine whether a round-trip through
>>> page_address() is going to give back a mapped VA, can we not trivially
>>> identify that from whether the PTE itself is valid?
>>
>> Depends what you mean by "valid". If you're referring to pte_valid()
>> and L_PTE_VALID then no.
>>
>> On 32-bit non-LPAE, the valid bit is the same as the present bit, and
>> needs to be set for the PTE to not fault. Any PTE that is mapping
>> something will be "valid" whether it is memory or not, whether it is
>> backed by a page or not.
>>
>> pfn_valid() should be telling us whether the PFN is suitable to be
>> passed to pfn_to_page(), and if we have a situation where pfn_valid()
>> returns true, but pfn_to_page() returns an invalid page, then that in
>> itself is a bug that needs to be fixed and probably has far reaching
>> implications for the stability of the kernel.
>
> Right, the problem here seems to be the opposite one, wherein we *do* 
> often have a valid struct page for an address which is reserved and 
> thus not mapped by the kernel, but seemingly we then take it down a 
> path which assumes anything !PageHighmem() is lowmem and dereferences 
> page_address() without looking.
>
> However I realise I should have looked closer at the caller, and my 
> idea is futile since the PTE here is for a userspace mapping, not a 
> kernel VA, and is already pte_valid_user() && !pte_special(). Plus the 
> fact that the stack trace indicates an mmap() path suggests it most 
> likely is a legitimate mapping of some no-map carveout or MMIO region. 
> Oh well. My first point still stands, though - I think at least a 
> comment to clarify that assumption would be warranted.
>
> Thanks,
> Robin.
> .

