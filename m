Return-Path: <linux-kernel+bounces-91001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CFF870846
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023B91F21992
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7788612E6;
	Mon,  4 Mar 2024 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaENhO+H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF931FA4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573445; cv=none; b=XkYzyS8VNasjwMIj2rbcUR05Y4LFpd83O6o34w4uYQ2bqxDr5U6jPH+5QatJus7ttIkEAcDGkOzBIZH+p6IUxmZjhrOhX8+OwqLruOQjtdhT6NMohVmPDbe+cFMwyNWRJ7jrDQSRGOTMx4h9xdqj5Dzh8rPs/HzanPNhfrWS7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573445; c=relaxed/simple;
	bh=Thvin4gP8F/3yYNjx8BrANVx2rQSjekJfXDeJRJJxAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sg2BrCz9+Q5rT+KxS1lh6A6iUamVP/H2+Q8TBbhDRJukeBGgwMdV6h18IQ9q/e0sPrAbrjsO4wJ8oD0X6jZmYrSoEwnQOfoxXwASoFCN5MnJC5ymRAhMzOH1Lk/HyKVbAO/ajb8LiXtAxRvfW8wC74PJwrqbk9YA6LQwl/tVsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UaENhO+H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709573442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uFWbnFLtGusu7xGp1IkZwKttQMXEWBJPKXby4dEuZP0=;
	b=UaENhO+HsL0E1YwByWvhZ9q0eUzPVzJuSNDC7s8Wx+resbUWdIXRT7jLOmVwz8+aPu4GhA
	3wesPvIWkm13UnuC/xRlsOpAtUueEj+jY8cYZbLkUebizzuDLGTMBpY2ckK+px8IjZ6hbF
	oQuI9ThUfAGQc/EZj29lRNIpGIH9lqg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-lS2VwdQSOtaHda6QhEdkJg-1; Mon, 04 Mar 2024 12:30:41 -0500
X-MC-Unique: lS2VwdQSOtaHda6QhEdkJg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e53200380so31145365e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709573440; x=1710178240;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFWbnFLtGusu7xGp1IkZwKttQMXEWBJPKXby4dEuZP0=;
        b=pZ13nAqbE2Rjdx8ugBmaUaLt1F3jalNs2l0xFlFuGzd9jAufdytYrmdYmruM7wjDWJ
         botV/OIMgkrVEvCXZ/xhuZugRMclNUC3jbrl+DC90CqKaDQjBYhuv4A41E7DbfLJj0y8
         Uyy0NI7oesi9uMZE+X1GtA0WK8UI2YURm+K5oQR9szqyYwgB7TFLSr2Jb+n/r/mgEuV5
         RjPj4HDMmV+AQzbgyqZ1Jt7aaojbwFO/IBpjU0O6T+akNURGnWHpzlhemvg/iTWuojBx
         3DKFZ4L1nXoWsvLTyg58H8AD5/cMzR9GmtdzZwzYIAStsojUnhnEQaigUm92PUSzOZ3g
         NO0w==
X-Gm-Message-State: AOJu0Ywx14JSYZhgaHIU+kSzQi9ldv+m2EmA89b6quiGHeudHUsUWwHZ
	HfSYzYJInDHwCfd1JLMYaIQtNLuf5lIIJjUEoi88Rt5gGDeStTZPWZsOLKxCVftCJI70rQw712k
	+jWaohALGcQfX+RGphRNUICREh5X2h0SxyzBXp1rVqvVdN6J8WWJaqghkE70+VQ==
X-Received: by 2002:a05:600c:1c89:b0:412:d0ab:a34a with SMTP id k9-20020a05600c1c8900b00412d0aba34amr5366577wms.31.1709573440239;
        Mon, 04 Mar 2024 09:30:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKtFiSDUb0J9aIgh663YLP1ncleBHq2g0VxwsnxJW6x46pjlgYUbFlbzx/Sdm0QTpdNkcJOQ==
X-Received: by 2002:a05:600c:1c89:b0:412:d0ab:a34a with SMTP id k9-20020a05600c1c8900b00412d0aba34amr5366556wms.31.1709573439787;
        Mon, 04 Mar 2024 09:30:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c733:f100:75e7:a0a4:9ac2:1abb? (p200300cbc733f10075e7a0a49ac21abb.dip0.t-ipconnect.de. [2003:cb:c733:f100:75e7:a0a4:9ac2:1abb])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c1d9400b00412e795f270sm1931414wms.22.2024.03.04.09.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:30:39 -0800 (PST)
Message-ID: <949b6c22-d737-4060-9ca1-a69d8e986d90@redhat.com>
Date: Mon, 4 Mar 2024 18:30:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b642c7ff-c452-4066-ac12-dbf05e215cb9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.03.24 17:03, Ryan Roberts wrote:
> On 28/02/2024 12:12, David Hildenbrand wrote:
>>>> How relevant is it? Relevant enough that someone decided to put that
>>>> optimization in? I don't know :)
>>>
>>> I'll have one last go at convincing you: Huang Ying (original author) commented
>>> "I believe this should be OK.  Better to compare the performance too." at [1].
>>> That implies to me that perhaps the optimization wasn't in response to a
>>> specific problem after all. Do you have any thoughts, Huang?
>>
>> Might make sense to include that in the patch description!
>>
>>> OK so if we really do need to keep this optimization, here are some ideas:
>>>
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
>> Taking a step back: what about we simply batch unmapping of swap entries?
>>
>> That is, if we're unmapping a PTE range, we'll collect swap entries (under PT
>> lock) that reference consecutive swap offsets in the same swap file.
>>
>> There, we can then first decrement all the swap counts, and then try minimizing
>> how often we actually have to try reclaiming swap space (lookup folio, see it's
>> a large folio that we cannot reclaim or could reclaim, ...).
>>
>> Might need some fine-tuning in swap code to "advance" to the next entry to try
>> freeing up, but we certainly can do better than what we would do right now.
>>
> 
> Hi,
> 
> I'm struggling to convince myself that free_swap_and_cache() can't race with
> with swapoff(). Can anyone explain that this is safe?
> 
> I *think* they are both serialized by the PTL, since all callers of
> free_swap_and_cache() (except shmem) have the PTL, and swapoff() calls
> try_to_unuse() early on, which takes the PTL as it iterates over every vma in
> every mm. It looks like shmem is handled specially by a call to shmem_unuse(),
> but I can't see the exact serialization mechanism.

As get_swap_device() documents:

"if there aren't some other ways to prevent swapoff, such as the folio 
in swap cache is locked, page table lock is held, etc., the swap entry 
may become invalid because of swapoff"

PTL it is, in theory. But I'm afraid that's half the story.

> 
> I've implemented a batching function, as David suggested above, but I'm trying
> to convince myself that it is safe for it to access si->swap_map[] without a
> lock (i.e. that swapoff() can't concurrently free it). But I think
> free_swap_and_cache() as it already exists depends on being able to access the
> si without an explicit lock, so I'm assuming the same mechanism will protect my
> new changes. But I want to be sure I understand the mechanism...

Very valid concern.

> 
> 
> This is the existing free_swap_and_cache(). I think _swap_info_get() would break
> if this could race with swapoff(), and __swap_entry_free() looks up the cluster
> from an array, which would also be freed by swapoff if racing:
> 
> int free_swap_and_cache(swp_entry_t entry)
> {
> 	struct swap_info_struct *p;
> 	unsigned char count;
> 
> 	if (non_swap_entry(entry))
> 		return 1;
> 
> 	p = _swap_info_get(entry);
> 	if (p) {
> 		count = __swap_entry_free(p, entry);

If count dropped to 0 and

> 		if (count == SWAP_HAS_CACHE)


count is now SWAP_HAS_CACHE, there is in fact no swap entry anymore. We 
removed it. That one would have to be reclaimed asynchronously.

The existing code we would call swap_page_trans_huge_swapped() with the 
SI it obtained via _swap_info_get().

I also don't see what should be left protecting the SI. It's not locked 
anymore, the swapcounts are at 0. We don't hold the folio lock.

try_to_unuse() will stop as soon as si->inuse_pages is at 0. Hm ...

Would performing the overall operation under lock_cluster_or_swap_info 
help? Not so sure :(

-- 
Cheers,

David / dhildenb


