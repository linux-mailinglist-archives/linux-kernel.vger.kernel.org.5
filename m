Return-Path: <linux-kernel+bounces-47152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920AE8449E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9A52835C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA01F3B29D;
	Wed, 31 Jan 2024 21:20:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA28D3B2A1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736057; cv=none; b=V8ZpUYV2yIGMjhIriGa7YEJMbER/CX5ozEPXO1pLg7mTYBnGl70/YZy8H6RvlkLoXCNXVLOul9hxDhc7f1orV4cuYgv1IrDxHgwOG8Sg8yEVOZo3oJsYWPn1th/PGWmrn0qXyQmBenNfppqk38AnCKloAIDqNVH5uuggiFJIHjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736057; c=relaxed/simple;
	bh=e37xxEqCXgrSoXUtHNE3d3iD3PvqiDlJCMjxG5NFxRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6webLTbUve/ny2VIst0S+37qjbMVsUam8Rmnv4rNFQD6EbzWPCLbjJ8cEzGe1OSDsMQzl9nZgnQnIqvlelbulZ01RGUBK3PBL75UJxIX653v72F3WgVZLmB2S2N1nv6SXrGhDyutoLRghqyCxU7HNVDY7aqZEBc3QhRc8WP+is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8AB6DA7;
	Wed, 31 Jan 2024 13:21:36 -0800 (PST)
Received: from [10.57.90.248] (unknown [10.57.90.248])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B21C3F738;
	Wed, 31 Jan 2024 13:20:51 -0800 (PST)
Message-ID: <edc4e8fa-af0a-46c2-bf07-20a0c4e20af5@arm.com>
Date: Wed, 31 Jan 2024 21:20:49 +0000
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
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Yongqiang Liu <liuyongqiang13@huawei.com>,
 linux-arm-kernel@lists.infradead.org, yanaijie@huawei.com,
 zhangxiaoxu5@huawei.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
 rppt@linux.ibm.com, linux-kernel@vger.kernel.org, keescook@chromium.org,
 arnd@arndb.de, m.szyprowski@samsung.com, willy@infradead.org
References: <20240131125907.1006760-1-liuyongqiang13@huawei.com>
 <0da50102-3e87-49f7-b8f7-45cfcb4232d6@arm.com>
 <ZbqY12U/CXwAAu7A@shell.armlinux.org.uk>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZbqY12U/CXwAAu7A@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-31 7:00 pm, Russell King (Oracle) wrote:
> On Wed, Jan 31, 2024 at 06:39:31PM +0000, Robin Murphy wrote:
>> On 31/01/2024 12:59 pm, Yongqiang Liu wrote:
>>> @@ -292,7 +293,7 @@ void __sync_icache_dcache(pte_t pteval)
>>>    		/* only flush non-aliasing VIPT caches for exec mappings */
>>>    		return;
>>>    	pfn = pte_pfn(pteval);
>>> -	if (!pfn_valid(pfn))
>>> +	if (!memblock_is_map_memory(PFN_PHYS(pfn)))
>>>    		return;
>>>    	folio = page_folio(pfn_to_page(pfn));
>>
>> Hmm, it's a bit odd in context, since pfn_valid() obviously pairs with this
>> pfn_to_page(), whereas it's not necessarily clear that
>> memblock_is_map_memory() implies pfn_valid().
>>
>> However, in this case we're starting from a PTE - rather than going off to
>> do a slow scan of memblock to determine whether a round-trip through
>> page_address() is going to give back a mapped VA, can we not trivially
>> identify that from whether the PTE itself is valid?
> 
> Depends what you mean by "valid". If you're referring to pte_valid()
> and L_PTE_VALID then no.
> 
> On 32-bit non-LPAE, the valid bit is the same as the present bit, and
> needs to be set for the PTE to not fault. Any PTE that is mapping
> something will be "valid" whether it is memory or not, whether it is
> backed by a page or not.
> 
> pfn_valid() should be telling us whether the PFN is suitable to be
> passed to pfn_to_page(), and if we have a situation where pfn_valid()
> returns true, but pfn_to_page() returns an invalid page, then that in
> itself is a bug that needs to be fixed and probably has far reaching
> implications for the stability of the kernel.

Right, the problem here seems to be the opposite one, wherein we *do* 
often have a valid struct page for an address which is reserved and thus 
not mapped by the kernel, but seemingly we then take it down a path 
which assumes anything !PageHighmem() is lowmem and dereferences 
page_address() without looking.

However I realise I should have looked closer at the caller, and my idea 
is futile since the PTE here is for a userspace mapping, not a kernel 
VA, and is already pte_valid_user() && !pte_special(). Plus the fact 
that the stack trace indicates an mmap() path suggests it most likely is 
a legitimate mapping of some no-map carveout or MMIO region. Oh well. My 
first point still stands, though - I think at least a comment to clarify 
that assumption would be warranted.

Thanks,
Robin.

