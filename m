Return-Path: <linux-kernel+bounces-85229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6710586B285
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC4A1F26E90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C21C15B0FF;
	Wed, 28 Feb 2024 14:59:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A0E73531
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132376; cv=none; b=GSWxXkiLkQQIfVDXoJZMIICzIwY7JN0WXKakM7rF+84GlRRwSAQRsKgDYTH3v/KMbr28QgugPVN3zXOBXK2GxE51EIm0GF1xLa54SAKus6TKOD1DgGA/66zDhFM1KTBNOePKWTl2QFRdmYEAw4PJH7rgCy6auhe9zFtYimJouZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132376; c=relaxed/simple;
	bh=gYL/LGvFvwpN3CtLDtVeVHzxeWkGqY6Q4q1PntanCMc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C84vi1QJldhVJ5ik4EsOxqYqk/4aTtX0oSitl421OQzY1e1K0JBSeQgRB7Zt3FqtpCCGBsnakuuUKyt20htvlQurGWofZxmauEsRG5hr3F7MBAn5he0y1uFR5gSUrUPcBWnc/Zafw7WTZgcgWcHlZrVagM5KeEJg3XNzptFZJl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E40391FB;
	Wed, 28 Feb 2024 07:00:10 -0800 (PST)
Received: from [10.1.38.163] (XHFQ2J9959.cambridge.arm.com [10.1.38.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4800C3F73F;
	Wed, 28 Feb 2024 06:59:30 -0800 (PST)
Message-ID: <531c6702-1389-42c5-9cdd-062989d40133@arm.com>
Date: Wed, 28 Feb 2024 14:59:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying
 <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-2-ryan.roberts@arm.com>
 <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
 <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
 <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
 <049818ca-e656-44e4-b336-934992c16028@arm.com>
 <Zd82FqN7qxuBUSvl@casper.infradead.org>
 <f94ca70a-d033-4323-8815-240bfa895013@arm.com>
In-Reply-To: <f94ca70a-d033-4323-8815-240bfa895013@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 14:24, Ryan Roberts wrote:
> On 28/02/2024 13:33, Matthew Wilcox wrote:
>> On Wed, Feb 28, 2024 at 09:37:06AM +0000, Ryan Roberts wrote:
>>> Fundamentally, we would like to be able to figure out the size of the swap slot
>>> from the swap entry. Today swap supports 2 sizes; PAGE_SIZE and PMD_SIZE. For
>>> PMD_SIZE, it always uses a full cluster, so can easily add a flag to the cluster
>>> to mark it as PMD_SIZE.
>>>
>>> Going forwards, we want to support all sizes (power-of-2). Most of the time, a
>>> cluster will contain only one size of THPs, but this is not the case when a THP
>>> in the swapcache gets split or when an order-0 slot gets stolen. We expect these
>>> cases to be rare.
>>>
>>> 1) Keep the size of the smallest swap entry in the cluster header. Most of the
>>> time it will be the full size of the swap entry, but sometimes it will cover
>>> only a portion. In the latter case you may see a false negative for
>>> swap_page_trans_huge_swapped() meaning we take the slow path, but that is rare.
>>> There is one wrinkle: currently the HUGE flag is cleared in put_swap_folio(). We
>>> wouldn't want to do the equivalent in the new scheme (i.e. set the whole cluster
>>> to order-0). I think that is safe, but haven't completely convinced myself yet.
>>>
>>> 2) allocate 4 bits per (small) swap slot to hold the order. This will give
>>> precise information and is conceptually simpler to understand, but will cost
>>> more memory (half as much as the initial swap_map[] again).
>>>
>>> I still prefer to avoid this at all if we can (and would like to hear Huang's
>>> thoughts). But if its a choice between 1 and 2, I prefer 1 - I'll do some
>>> prototyping.
>>
>> I can't quite bring myself to look up the encoding of swap entries
>> but as long as we're willing to restrict ourselves to naturally aligning
>> the clusters, there's an encoding (which I believe I invented) that lets
>> us encode arbitrary power-of-two sizes with a single bit.
>>
>> I describe it here:
>> https://kernelnewbies.org/MatthewWilcox/NaturallyAlignedOrder
>>
>> Let me know if it's not clear.
> 
> Ahh yes, I'm familiar with this encoding scheme from other settings. Although
> I've previously thought of it as having a bit to indicate whether the scheme is
> enabled or not, and if it is enabled then the encoded PFN is:
> 
> PFNe = PFNd | (1 << (log2(n) - 1))
> 
> Where n is the power-of-2 page count.
> 
> Same thing, I think.
> 
> I think we would have to steal a bit from the offset to make this work, and it
> looks like the size of that is bottlnecked on the arch's swp_entry PTE
> representation. Looks like there is a MIPS config that only has 17 bits for
> offset to begin with, so I doubt we would be able to spare a bit here? Although
> it looks possible that there are some unused low bits that could be used...
> 

I think the other problem with this is that it won't tell us which slot in the
"swap slot block" each entry is targetting?


