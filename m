Return-Path: <linux-kernel+bounces-140702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8817E8A17F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4284E284283
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C9FDF43;
	Thu, 11 Apr 2024 14:57:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6717DDB3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847429; cv=none; b=UM2r95Ggm549A2n0qBrqOBwh2zkZ1n6owA09l0XyDm5ZnsP3tK6rTtMC2zQki5/EnQy37Qi9boYvyqjeMWEBAAzVx7LaNe4DAThjmVAQZSqsPWPUf6lPAXgdaSH5M1WXqkJqkzKyrkF/6RBzyNfLWH0P/kVMDeurMeVhCYD9FZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847429; c=relaxed/simple;
	bh=a2M7BUpxQHgNp9nwEuklEobokTxst/uAol9oGZetN8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0n8Kc+goYpHlfWGarO6mxPgK7HKZtU7wbiBzcF8M6h+6g2ExT6C+10eCM5PLdUBhBJxdPyRsERE8FYAye1BIhAc0IZO6RKQtfo3q2ntGz1c2hylX+n+5GYc1tEG3TYmzNjREeL6S1tDGBTWtXwyyQ2AlP2Tjve39xE3vn6QHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 915EE113E;
	Thu, 11 Apr 2024 07:57:36 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EF6C3F6C4;
	Thu, 11 Apr 2024 07:57:05 -0700 (PDT)
Message-ID: <d9582c0e-af24-46a1-9c3e-b9dc68af20d8@arm.com>
Date: Thu, 11 Apr 2024 15:57:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: mm: Don't remap pgtables for allocate vs
 populate
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, David Hildenbrand <david@redhat.com>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Itaru Kitayama <itaru.kitayama@fujitsu.com>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <20240404143308.2224141-4-ryan.roberts@arm.com>
 <ZhffSyrqCQsMV2pG@FVFF77S0Q05N>
 <37d4c278-3780-49ce-bd7e-e8f2ff4501fd@arm.com>
 <Zhf4LqNhQFN8ezx1@FVFF77S0Q05N>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zhf4LqNhQFN8ezx1@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 15:48, Mark Rutland wrote:
> On Thu, Apr 11, 2024 at 02:37:49PM +0100, Ryan Roberts wrote:
>> On 11/04/2024 14:02, Mark Rutland wrote:
>>> On Thu, Apr 04, 2024 at 03:33:07PM +0100, Ryan Roberts wrote:
>>>> During linear map pgtable creation, each pgtable is fixmapped /
>>>> fixunmapped twice; once during allocation to zero the memory, and a
>>>> again during population to write the entries. This means each table has
>>>> 2 TLB invalidations issued against it. Let's fix this so that each table
>>>> is only fixmapped/fixunmapped once, halving the number of TLBIs, and
>>>> improving performance.
>>>>
>>>> Achieve this by abstracting pgtable allocate, map and unmap operations
>>>> out of the main pgtable population loop code and into a `struct
>>>> pgtable_ops` function pointer structure. This allows us to formalize the
>>>> semantics of "alloc" to mean "alloc and map", requiring an "unmap" when
>>>> finished. So "map" is only performed (and also matched by "unmap") if
>>>> the pgtable has already been allocated.
>>>>
>>>> As a side effect of this refactoring, we no longer need to use the
>>>> fixmap at all once pages have been mapped in the linear map because
>>>> their "map" operation can simply do a __va() translation. So with this
>>>> change, we are down to 1 TLBI per table when doing early pgtable
>>>> manipulations, and 0 TLBIs when doing late pgtable manipulations.
>>>>
>>>> Execution time of map_mem(), which creates the kernel linear map page
>>>> tables, was measured on different machines with different RAM configs:
>>>>
>>>>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>>>>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
>>>> ---------------|-------------|-------------|-------------|-------------
>>>>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
>>>> ---------------|-------------|-------------|-------------|-------------
>>>> before         |   13   (0%) |  162   (0%) |  655   (0%) |  1656   (0%)
>>>> after          |   11 (-15%) |  109 (-33%) |  449 (-31%) |  1257 (-24%)
>>>
>>> Do we know how much of that gain is due to the early pgtable creation doing
>>> fewer fixmap/fixunmap ops vs the later operations using the linear map?
>>>
>>> I suspect that the bulk of that is down to the early pgtable creation, and if
>>> so I think that we can get most of the benefit with a simpler change (see
>>> below).
>>
>> All of this improvement is due to early pgtable creation doing fewer
>> fixmap/fixunmaps; I'm only measuring the execution time of map_mem(), which only
>> uses the early ops.
>>
>> I haven't even looked to see if there are any hot paths where the late ops
>> benefit. I just saw it as a happy side-effect.
> 
> Ah, of course. I skimmed this and forgot this was just timing map_mem().
> 
> [...]
> 
>>> There's a lot of boilerplate that results from having the TYPE_Pxx enumeration
>>> and needing to handle that in the callbacks, and it's somewhat unfortunate that
>>> the callbacks can't use the enum type directly (becuase the KPTI allocator is
>>> in another file).
>>>
>>> I'm not too keen on all of that.
>>
>> Yes, I agree its quite a big change. And all the switches are naff. But I
>> couldn't see a way to avoid it and still get all the "benefits".
>>
>>> As above, I suspect that most of the benefit comes from minimizing the
>>> map/unmap calls in the early table creation, and I think that we can do that
>>> without needing all this infrastructure if we keep the fixmapping explciit
>>> in the alloc_init_pXX() functions, but factor that out of
>>> early_pgtable_alloc().
>>>
>>> Does something like the below look ok to you? 
>>
>> Yes this is actually quite similar to my first attempt, but then I realised I
>> could get rid of the redudancies too.
>>
>>> The trade-off performance-wise is
>>> that late uses will still use the fixmap, and will redundantly zero the tables,
>>
>> I think we can mitigate the redudant zeroing for most kernel configs; tell the
>> allocator we don't need it to be zeroed. There are some obscure configs where
>> pages are zeroed on free instead of on alloc IIRC, so those would still have a
>> redundant clear but they are not widely used AIUI. (see bleow).
> 
> That sounds fine to me; minor comment below.
> 
>>> but the logic remains fairly simple, and I suspect the overhead for late
>>> allocations might not matter since the bulk of late changes are non-allocating.
>>
>> Its just the fixmap overhead that remains...
> 
> True; my thinking there is that almost all of the later changes are for smaller
> ranges than the linear map (~10s of MB vs GBs in your test data), so I'd expect
> the overhead of those to be dominated by the cost of mappin the linear map.
> 
> The only big exception is arch_add_memory(), but memory hotplug is incredibly
> rare, and we're not making it massively slower than it already was...

What about something like coco guest mem (or whatever its called). Isn't that
scrubbed out of the linear map? So if a coco VM is started with GBs of memory,
could that be a real case we want to optimize?

> 
>> I'll benchmark with your below change, and also have a deeper look to check if
>> there are real places where fixmap might cause slowness for late ops.
> 
> Thanks!
> 
> [...]
> 
>>> @@ -475,8 +491,6 @@ static phys_addr_t __pgd_pgtable_alloc(int shift)
>>>  	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL);
>>
>> How about:
>>
>> 	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL & ~__GFP_ZERO);
> 
> Looks good to me, assuming we add a comment to say it'll be zeroed in
> init_clear_pgtable().

Sure.

> 
> Mark.


