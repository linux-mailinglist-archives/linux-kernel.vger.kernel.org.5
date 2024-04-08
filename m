Return-Path: <linux-kernel+bounces-135581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE9F89C7EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF50C1C218B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F2013F44E;
	Mon,  8 Apr 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuFyeavA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C713F439
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589216; cv=none; b=s5ICSBnTIr/QV1EgLZamf6IQcAf06lvXu4avUBL8+lAPP+FObXJ6+GCUsEqrJkEa6pJk0XzdQFJIHUEWSpC3YhtwRCKbru0ebiqUqQO7qSKLMLFPtC30nmr2RX0+3rxZJrhYFBbitmN9atUSrHglcSMUqFyIuWWXRGm0qBIJFNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589216; c=relaxed/simple;
	bh=RSGkctc+iuDpqgyLP+NKBAc8loa23BAp4vUDHCBFuA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jk2w2Sk2QKwqqeH0XG+F+CnGWw30/Vg0J7dL4pPUTTD4yFJYx2sigcZAaJxy/P/+vGok7/Vl2FQ06oSaNHIpGe/42B9l8jrVBRUwjKUhjmME1YGYamx12sUnP1/E8ayVcqaDyv0XNxUs6viM+lHkyy2NYRi/DBILunRdqkQwSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UuFyeavA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712589214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FQxnCR2hhRsqV7rjNthbeUSLOg/1ik/UqgM9Jy0S5NQ=;
	b=UuFyeavAVWsswsnh2Th/HiAaigC5Rl47NBO2GSroPnhPTCX9urbfKecQPIBt3jJll5aAil
	jHJDoLHIOcqlFDNLzc4rSWGpPg8X77F3ue/xv4hYjuZTiL0gDvRwKyM3ug3aJq6UG/nL7j
	XKJQLL8QvBvB008xXFA+SqN9go9Q+/M=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-Kv_3NkZWOzeFOE02eps3Pw-1; Mon, 08 Apr 2024 11:13:32 -0400
X-MC-Unique: Kv_3NkZWOzeFOE02eps3Pw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d85e1bd6edso32219731fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 08:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712589211; x=1713194011;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FQxnCR2hhRsqV7rjNthbeUSLOg/1ik/UqgM9Jy0S5NQ=;
        b=MbAVg3FM/KQHUqEb1ZM1eKUoYMLV+gaIGUQHZNxLDQV+RBEWVsot8M4U7iUn6e+wXx
         wxintVf0AVN/3dXzoQ5T5TutliDAgoqYo+cN3n7tyApeJdYPM1GWRJPnUkfT8cI52efU
         BSrcmH9+wwe03I89q+8rszB6q2P3a8WvrbPj9gB/Bmg+lalWM3CRnIoxoiAqVt8NLG/5
         MYRwg6bHa9y/yLi6o5CIMic59C52RHaGYjryko9ZYfcN+OpQ6yp+/iRQpt+0MiUyEgrU
         IthMKnLkmQQF+QHFOqveP48AKZPdzmGjNtxMqqWiAc+MnY52QYqG0jfIyoNRNuD3bhfA
         bwcw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Sdt6CVSgE5ZeVU6MyYFyr6g+VHC0nzoErxw6xxJWqkAy6MZcK5l3meTLHu9M8HYzZub/P2WZ4rm78EvatLTzncQYKAPje+mOv+Uk
X-Gm-Message-State: AOJu0YyAKooX0kikG4IhVZFD0Jtba6AJOXkNxsYOtley8JR7/YkrkIHO
	mcvIAU/kkcKCnhhQnZPg0fN/jKZXr5baMKUsHbJfwOGRscSchdYjCcINGa945dRg/N8gkcmwC0x
	aSqBVb6LzsjaDY7yXnYl5ANXkMOWMKmwXMQ/Ix1SLglyUtSLwEMfseAjONp2FRA==
X-Received: by 2002:a2e:9b8e:0:b0:2d8:58ca:39ff with SMTP id z14-20020a2e9b8e000000b002d858ca39ffmr6757274lji.9.1712589211344;
        Mon, 08 Apr 2024 08:13:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLhFeKUloD73IlTPGouL+pyJFXGlEI3cUESPCOuCP3kPx5Lx6wH2ASEqA34jqXHPB/sRarkQ==
X-Received: by 2002:a2e:9b8e:0:b0:2d8:58ca:39ff with SMTP id z14-20020a2e9b8e000000b002d858ca39ffmr6757243lji.9.1712589210807;
        Mon, 08 Apr 2024 08:13:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id iv9-20020a05600c548900b004162ce49719sm14694586wmb.6.2024.04.08.08.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 08:13:30 -0700 (PDT)
Message-ID: <6ea2d90c-8a94-4361-af71-1a990bbe7096@redhat.com>
Date: Mon, 8 Apr 2024 17:13:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-3-ryan.roberts@arm.com>
 <051052af-3b56-4290-98d3-fd5a1eb11ce1@redhat.com>
 <4110bb1d-65e5-4cf0-91ad-62749975829d@arm.com>
 <be096120-4dd1-4a10-b283-779d23c2811b@arm.com>
 <2cfa542a-ae38-4867-a64b-621e7778fdf7@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2cfa542a-ae38-4867-a64b-621e7778fdf7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.04.24 15:27, Ryan Roberts wrote:
> On 08/04/2024 13:47, Ryan Roberts wrote:
>> On 08/04/2024 13:07, Ryan Roberts wrote:
>>> [...]
>>>>
>>>> [...]
>>>>
>>>>> +
>>>>> +/**
>>>>> + * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
>>>>> + * @start_ptep: Page table pointer for the first entry.
>>>>> + * @max_nr: The maximum number of table entries to consider.
>>>>> + * @entry: Swap entry recovered from the first table entry.
>>>>> + *
>>>>> + * Detect a batch of contiguous swap entries: consecutive (non-present) PTEs
>>>>> + * containing swap entries all with consecutive offsets and targeting the same
>>>>> + * swap type.
>>>>> + *
>>>>
>>>> Likely you should document that any swp pte bits are ignored? ()
>>>
>>> Now that I understand what swp pte bits are, I think the simplest thing is to
>>> just make this function always consider the pte bits by using pte_same() as you
>>> suggest below? I don't think there is ever a case for ignoring the swp pte bits?
>>> And then I don't need to do anything special for uffd-wp either (below you
>>> suggested not doing batching when the VMA has uffd enabled).
>>>
>>> Any concerns?
>>>
>>>>
>>>>> + * max_nr must be at least one and must be limited by the caller so scanning
>>>>> + * cannot exceed a single page table.
>>>>> + *
>>>>> + * Return: the number of table entries in the batch.
>>>>> + */
>>>>> +static inline int swap_pte_batch(pte_t *start_ptep, int max_nr,
>>>>> +                 swp_entry_t entry)
>>>>> +{
>>>>> +    const pte_t *end_ptep = start_ptep + max_nr;
>>>>> +    unsigned long expected_offset = swp_offset(entry) + 1;
>>>>> +    unsigned int expected_type = swp_type(entry);
>>>>> +    pte_t *ptep = start_ptep + 1;
>>>>> +
>>>>> +    VM_WARN_ON(max_nr < 1);
>>>>> +    VM_WARN_ON(non_swap_entry(entry));
>>>>> +
>>>>> +    while (ptep < end_ptep) {
>>>>> +        pte_t pte = ptep_get(ptep);
>>>>> +
>>>>> +        if (pte_none(pte) || pte_present(pte))
>>>>> +            break;
>>>>> +
>>>>> +        entry = pte_to_swp_entry(pte);
>>>>> +
>>>>> +        if (non_swap_entry(entry) ||
>>>>> +            swp_type(entry) != expected_type ||
>>>>> +            swp_offset(entry) != expected_offset)
>>>>> +            break;
>>>>> +
>>>>> +        expected_offset++;
>>>>> +        ptep++;
>>>>> +    }
>>>>> +
>>>>> +    return ptep - start_ptep;
>>>>> +}
>>>>
>>>> Looks very clean :)
>>>>
>>>> I was wondering whether we could similarly construct the expected swp PTE and
>>>> only check pte_same.
>>>>
>>>> expected_pte = __swp_entry_to_pte(__swp_entry(expected_type, expected_offset));
>>>
>>> So planning to do this.
>>
>> Of course this clears all the swp pte bits in expected_pte. So need to do something a bit more complex.
>>
>> If we can safely assume all offset bits are contiguous in every per-arch representation then we can do:
> 
> Looks like at least csky and hexagon store the offset in discontiguous regions.
> So it will have to be the second approach if we want to avoid anything
> arch-specific. I'll assume that for now; we can always specialize
> pte_next_swp_offset() per-arch in the future if needed.

Sounds good. Just have a generic variant as you proposed, and add the 
per-arch one if really required later.

-- 
Cheers,

David / dhildenb


