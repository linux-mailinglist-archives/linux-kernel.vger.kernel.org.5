Return-Path: <linux-kernel+bounces-91914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2379387184D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D1FB2154C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFC03A1D9;
	Tue,  5 Mar 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f80fuWE9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9388249F1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627751; cv=none; b=cnXIzcEuUF2uxNEf10CLwnSYcaWagV8eCCP079iUk+ljvDKU7FqGOsIX2G23qt0U6AkvQZ2RO0rkFyonyj//Uuqq1ddsczvO31BhKNmi6BJp4pjepwalh1ZZxLJfFSAwf47qZm3bfqsmPnWlscujRA0AyKUmAVgOUuvg0xzDB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627751; c=relaxed/simple;
	bh=HmSZWFhu3yDaImEBouH4zjOoFs+69G17QxKKmJOPmkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k49rK8kkKQqJ4glxoq1g1pBLF6zDXuXZ9BHQwDxuRApPbqS+VN4+wIjvTVNdesFd0Jyt+NT7oPgGx4kd05Yz1UvFE6hh7hly4vhk9rpoduPKph5jOhmZiRB7hyl7YySq3LWAT7jL3mHzpCYUPZz+hu3TZi4hZbufH9o2ykkQaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f80fuWE9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709627748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8d1YUHodfZWTVLWvoDOTeK1aIx0Y+TAs7cm2fq84YPM=;
	b=f80fuWE9U0wIDS/QleVAxyvNw4bo6rT2JIv/+c21b71RuL4sCovhfuvNS92CszwUV1HBVd
	W9RbHB1lAb5BQ760RWTtWSNjCpsLG6zOqAoRfgDqrE0ci9slWvcbB7ewuijrT4q9QLc72O
	yhb93OeqwHZsmEZPV8yWRg4ultV8jGA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-nyyVugeBM3-l7waLKVfyhQ-1; Tue, 05 Mar 2024 03:35:46 -0500
X-MC-Unique: nyyVugeBM3-l7waLKVfyhQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33e0edcf4f4so1806489f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709627746; x=1710232546;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8d1YUHodfZWTVLWvoDOTeK1aIx0Y+TAs7cm2fq84YPM=;
        b=llTaaZ3Z/P8r+8Qphl+GBcRpyGk+Cz78Lp2D2SiUlb8i6vMrsRToQPhvhBOmrJ3bBD
         6riicalsSW8JQjKj6VHuTskohT9WXvhaTMed8W4uYtZEV+XLq0g6BytzVbghzD1sm0mi
         aHjz86hapnwXiTPl4onjhnXR49jw6HGyuEj2+WDq7sd3H8nK+OEmzQHeOAFiTEunaCMs
         vKrRxa+ScV58nelQHwYw7/Vtz5eIw82wrxsB8Go9+PZTJuh2UNCkDcuQ0Yvt8zLA3Rpc
         wPyHu1Jv+bwsa/hsTVxNbwOOY8cd7vGvM0n/UBZJdNtNeCZjPcuij7Heh+X+MIHDNrgR
         tcCg==
X-Forwarded-Encrypted: i=1; AJvYcCVIY5wAkBOLoCYpKOYrX+R4lKPIDi0L52PsaTIsSNlHCxCNEHYrMv3wGAc98Tl9rTRmBzKuuqR6eJnA5u8PPK5E4/ERTgjlxz5hjiWT
X-Gm-Message-State: AOJu0Yw8KlbWfb2Qn78OIF3lB9eGcCtLQYN3ZKMIYP+FAoKV7qqG6mOU
	fgri605A7aDVhHdWFk8b3/Fd5S3/7HGA0Aqymto36YDSxG1xusBv+BAqdLttQ2ppmkwOJtatHQf
	axmrPNVkK5CrGfTgZ5hqhTG3moh038DCXDRWVobjAVEroQFLnSU28BuHrxLGdNQ==
X-Received: by 2002:adf:e310:0:b0:33d:b627:c3ec with SMTP id b16-20020adfe310000000b0033db627c3ecmr8518467wrj.44.1709627745670;
        Tue, 05 Mar 2024 00:35:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZBtQKdW2t1vKhHjG/Koq/hUA7dl61rlzq8BNHioqIvkHGlzTSVprfjWax7VJPSYecDmi8Og==
X-Received: by 2002:adf:e310:0:b0:33d:b627:c3ec with SMTP id b16-20020adfe310000000b0033db627c3ecmr8518445wrj.44.1709627745162;
        Tue, 05 Mar 2024 00:35:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c73c:8100:600:a1e5:da94:a13a? (p200300cbc73c81000600a1e5da94a13a.dip0.t-ipconnect.de. [2003:cb:c73c:8100:600:a1e5:da94:a13a])
        by smtp.gmail.com with ESMTPSA id d14-20020adf9c8e000000b0033e42ab5114sm3664191wre.2.2024.03.05.00.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:35:44 -0800 (PST)
Message-ID: <9a5cb081-c4f1-4abe-bb86-02aaca4e5433@redhat.com>
Date: Tue, 5 Mar 2024 09:35:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
To: "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-2-ryan.roberts@arm.com>
 <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
 <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
 <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
 <049818ca-e656-44e4-b336-934992c16028@arm.com>
 <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
 <b642c7ff-c452-4066-ac12-dbf05e215cb9@arm.com>
 <949b6c22-d737-4060-9ca1-a69d8e986d90@redhat.com>
 <9ed743a7-0c5d-49d9-b8b2-d58364df1f5f@arm.com>
 <65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com>
 <6cfc022a-0c7a-4fe6-aaa4-3d28aeacc982@arm.com>
 <3d47ae7d-297a-441e-941c-5b2e34ba8759@redhat.com>
 <3ae2da13-c33a-402f-9091-2c7328aea66a@arm.com>
 <87plw99phz.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87plw99phz.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.03.24 07:11, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> + Hugh
>>
>> On 04/03/2024 22:02, David Hildenbrand wrote:
>>> On 04.03.24 22:55, Ryan Roberts wrote:
>>>> On 04/03/2024 20:50, David Hildenbrand wrote:
>>>>>>>>
>>>>>>>> This is the existing free_swap_and_cache(). I think _swap_info_get() would
>>>>>>>> break
>>>>>>>> if this could race with swapoff(), and __swap_entry_free() looks up the
>>>>>>>> cluster
>>>>>>>> from an array, which would also be freed by swapoff if racing:
>>>>>>>>
>>>>>>>> int free_swap_and_cache(swp_entry_t entry)
>>>>>>>> {
>>>>>>>>        struct swap_info_struct *p;
>>>>>>>>        unsigned char count;
>>>>>>>>
>>>>>>>>        if (non_swap_entry(entry))
>>>>>>>>            return 1;
>>>>>>>>
>>>>>>>>        p = _swap_info_get(entry);
>>>>>>>>        if (p) {
>>>>>>>>            count = __swap_entry_free(p, entry);
>>>>>>>
>>>>>>> If count dropped to 0 and
>>>>>>>
>>>>>>>>            if (count == SWAP_HAS_CACHE)
>>>>>>>
>>>>>>>
>>>>>>> count is now SWAP_HAS_CACHE, there is in fact no swap entry anymore. We
>>>>>>> removed
>>>>>>> it. That one would have to be reclaimed asynchronously.
>>>>>>>
>>>>>>> The existing code we would call swap_page_trans_huge_swapped() with the SI it
>>>>>>> obtained via _swap_info_get().
>>>>>>>
>>>>>>> I also don't see what should be left protecting the SI. It's not locked
>>>>>>> anymore,
>>>>>>> the swapcounts are at 0. We don't hold the folio lock.
>>>>>>>
>>>>>>> try_to_unuse() will stop as soon as si->inuse_pages is at 0. Hm ...
>>>>>>
>>>>>> But, assuming the caller of free_swap_and_cache() acquires the PTL first, I
>>>>>> think this all works out ok? While free_swap_and_cache() is running,
>>>>>> try_to_unuse() will wait for the PTL. Or if try_to_unuse() runs first, then
>>>>>> free_swap_and_cache() will never be called because the swap entry will have
>>>>>> been
>>>>>> removed from the PTE?
>>>>>
>>>>> But can't try_to_unuse() run, detect !si->inuse_pages and not even bother about
>>>>> scanning any further page tables?
>>>>>
>>>>> But my head hurts from digging through that code.
>>>>
>>>> Yep, glad I'm not the only one that gets headaches from swapfile.c.
>>>>
>>>>>
>>>>> Let me try again:
>>>>>
>>>>> __swap_entry_free() might be the last user and result in "count ==
>>>>> SWAP_HAS_CACHE".
>>>>>
>>>>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>>>>
>>>>>
>>>>> So the question is: could someone reclaim the folio and turn si->inuse_pages==0,
>>>>> before we completed swap_page_trans_huge_swapped().
>>>>>
>>>>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are still
>>>>> references by swap entries.
>>>>>
>>>>> Process 1 still references subpage 0 via swap entry.
>>>>> Process 2 still references subpage 1 via swap entry.
>>>>>
>>>>> Process 1 quits. Calls free_swap_and_cache().
>>>>> -> count == SWAP_HAS_CACHE
>>>>> [then, preempted in the hypervisor etc.]
>>>>>
>>>>> Process 2 quits. Calls free_swap_and_cache().
>>>>> -> count == SWAP_HAS_CACHE
>>>>>
>>>>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>>>>> __try_to_reclaim_swap().
>>>>>
>>>>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->put_swap_folio()->
>>>>> free_swap_slot()->swapcache_free_entries()->swap_entry_free()->swap_range_free()->
>>>>> ...
>>>>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>>>>
>>>>>
>>>>> What stops swapoff to succeed after process 2 reclaimed the swap cache but
>>>>> before process 1 finished its call to swap_page_trans_huge_swapped()?
>>>>
>>>> Assuming you are talking about anonymous memory, process 1 has the PTL while
>>>> it's executing free_swap_and_cache(). try_to_unuse() iterates over every vma in
>>>> every mm, and it swaps-in a page for every PTE that holds a swap entry for the
>>>> device being swapoff'ed. It takes the PTL while converting the swap entry to
>>>> present PTE - see unuse_pte(). Process 1 must have beaten try_to_unuse() to the
>>>> particular pte, because if try_to_unuse() got there first, it would have
>>>> converted it from a swap entry to present pte and process 1 would never even
>>>> have called free_swap_and_cache(). So try_to_unuse() will eventually wait on the
>>>> PTL until process 1 has released it after free_swap_and_cache() completes. Am I
>>>> missing something? Because that part feels pretty clear to me.
>>>
>>> Why should try_to_unuse() do *anything* if it already finds
>>> si->inuse_pages == 0 because we (p1 } p2) just freed the swapentries and process
>>> 2 managed to free the last remaining swapcache entry?
>>
>> Yeah ok. For some reason I thought unuse_mm() was iterating over all mms and so
>> the `while (READ_ONCE(si->inuse_pages))` was only evaluated after iterating over
>> every mm. Oops.
>>
>> So yes, I agree with you; I think this is broken. And I'm a bit worried this
>> could be a can of worms; By the same logic, I think folio_free_swap(),
>> swp_swapcount() and probably others are broken in the same way.
> 
> Don't worry too much :-), we have get_swap_device() at least.  We can
> insert it anywhere we want because it's quite lightweight.  And, because
> swapoff() is so rare, the race is theoretical only.
> 
> For this specific case, I had thought that PTL is enough.  But after
> looking at this more, I found a race here too.  Until
> __swap_entry_free() return, we are OK, nobody can reduce the swap count
> because we held the PTL.  But, after that, even if its return value is
> SWAP_HAS_CACHE (that is, in swap cache), parallel swap_unuse() or
> __try_to_reclaim_swap() may remove the folio from swap cache, so free
> the swap entry.  So, swapoff() can proceed to free the data structures
> in parallel.
> 
> To fix the race, we can add get/put_swap_device() in
> free_swap_and_cache().
> 
> For other places, we can check whether get/put_swap_device() has been
> called in callers, and the swap reference we held has been decreased
> (e.g., swap count protected by PTL, SWAP_HAS_CACHE protected by folio
> lock).

Yes, sounds reasonable. We should likely update the documentation of 
get_swap_device(), that after decrementing the refcount, the SI might 
become stale and should not be touched without a prior get_swap_device().

-- 
Cheers,

David / dhildenb


