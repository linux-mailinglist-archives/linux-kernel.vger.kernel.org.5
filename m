Return-Path: <linux-kernel+bounces-91260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01985870BDA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2600B1C22DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBF3F9C1;
	Mon,  4 Mar 2024 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sd2EIgIe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200DE7BAFD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585435; cv=none; b=fFL2h8ZnJ7dygs7j/27O/QwiaOM5NOxBjl292rgYCeC8G3KVXS00rarxy4UXHJvCg0b+3NPg4KizVpPNjEdf9h3bI6JfY5lcjDipj/N1CK99T3DoCe9TxdP+L0v8OIJ1Bi4Tz/j7BGBGyLM/d1InhkO4fMuLNh43ioZGpPPNrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585435; c=relaxed/simple;
	bh=IsLf76Eyl7E0VZayCjrrvgWZD5Kpro2wKpfMqSyXb7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXcgP6Ph12HuvQ7UvIWCqaIlv3Q+mt2ZyYk0MOx7Mq8tRn2iI5ygifbOUOujL+KCVuyIe4zMfg8h7jObuGAL9LcucQgkPeG5KbV9ui3XBRr5fusSA2LWeB9y0giWv6nZOYue/V/70HeypHRrxaMZYjNjT5LffLOZymsYPCFr4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sd2EIgIe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709585432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6DYpcOSX0Dj2QMKmrWqiQ2oqf39pVlAfafp1htaOgpc=;
	b=Sd2EIgIe1KnQ6tV2tnKOYUieZLm7S8fR5rN3zJRIYIz4Fd3Dd0Ow65I6+QRxi/ep54Fju4
	x/sokR6ktcCLRZny2rzTZAMoyehGNeARToPwsyHJbyr8e/UF1cdGerh97J/suAZTXooWZo
	Q3FEkEOeNEO5brfI7jE/f/1e7C9Hn/Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-ysuiX52TPNWMzuny4DVtdw-1; Mon, 04 Mar 2024 15:50:31 -0500
X-MC-Unique: ysuiX52TPNWMzuny4DVtdw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d841c7a3dso2014354f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 12:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709585430; x=1710190230;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DYpcOSX0Dj2QMKmrWqiQ2oqf39pVlAfafp1htaOgpc=;
        b=QHhqLoaTcKYIyPlhHgfjEUP1145rEIYAOxj8LTeguaZsc9UT7k9jTJVZKaeWyYSnJO
         EXfl9+ZsrMa7RTIFroktjGEd2+DI+HQonv0EYHohTCJosKoj7TfEDVvEEBTz5PWaHyN2
         PJ3xXgB2MxCbVEvkFrnYidr+FkukE6zgOtaZWTKgHdX3f2+377IZru+qIMnMz+vt4vWX
         X1coauW55NYwfhVl7fwiDxLxMr0PF1lrJl8keT7RJS/JHmiI8kk7x1VMEWerv1D2+Acw
         apBX4uBQc1DY26MaTNeCfW/uqvgdN8vre5xUMfXURfnvd+Q8/QaTYN0xSvi0WFmJRzOF
         eOFA==
X-Gm-Message-State: AOJu0Yz5+7wZNUit4BAHb+Nty4M1RK38wrkaAn1aox0kbu/3VmIPkB9W
	6jX+0scWQjy4MgS0Cl1NAICOqIqt5TVfVx8C0erSvHssIa3VFQorRz6P2bFjs7UfHC+SrZeIpcS
	ep8wlH9sWRmYKEQndLfjeWnvNy/Q5NMyat8pA1yvoeLy7PTOcXs435XTdXnq1jw==
X-Received: by 2002:adf:9dc3:0:b0:33e:3ec2:a22f with SMTP id q3-20020adf9dc3000000b0033e3ec2a22fmr2197029wre.42.1709585429886;
        Mon, 04 Mar 2024 12:50:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOlUAYn4iIJeCR6/g69lKDXFCXqN/IYQ0XAiXt5nzVRI0u7E9GPfO6axC8eebXrf16i7lVRg==
X-Received: by 2002:adf:9dc3:0:b0:33e:3ec2:a22f with SMTP id q3-20020adf9dc3000000b0033e3ec2a22fmr2197013wre.42.1709585429310;
        Mon, 04 Mar 2024 12:50:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c733:f100:75e7:a0a4:9ac2:1abb? (p200300cbc733f10075e7a0a49ac21abb.dip0.t-ipconnect.de. [2003:cb:c733:f100:75e7:a0a4:9ac2:1abb])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c4fd100b00412d68dbf75sm8668421wmq.35.2024.03.04.12.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 12:50:28 -0800 (PST)
Message-ID: <65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com>
Date: Mon, 4 Mar 2024 21:50:27 +0100
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
 <949b6c22-d737-4060-9ca1-a69d8e986d90@redhat.com>
 <9ed743a7-0c5d-49d9-b8b2-d58364df1f5f@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9ed743a7-0c5d-49d9-b8b2-d58364df1f5f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>>
>>> This is the existing free_swap_and_cache(). I think _swap_info_get() would break
>>> if this could race with swapoff(), and __swap_entry_free() looks up the cluster
>>> from an array, which would also be freed by swapoff if racing:
>>>
>>> int free_swap_and_cache(swp_entry_t entry)
>>> {
>>>      struct swap_info_struct *p;
>>>      unsigned char count;
>>>
>>>      if (non_swap_entry(entry))
>>>          return 1;
>>>
>>>      p = _swap_info_get(entry);
>>>      if (p) {
>>>          count = __swap_entry_free(p, entry);
>>
>> If count dropped to 0 and
>>
>>>          if (count == SWAP_HAS_CACHE)
>>
>>
>> count is now SWAP_HAS_CACHE, there is in fact no swap entry anymore. We removed
>> it. That one would have to be reclaimed asynchronously.
>>
>> The existing code we would call swap_page_trans_huge_swapped() with the SI it
>> obtained via _swap_info_get().
>>
>> I also don't see what should be left protecting the SI. It's not locked anymore,
>> the swapcounts are at 0. We don't hold the folio lock.
>>
>> try_to_unuse() will stop as soon as si->inuse_pages is at 0. Hm ...
> 
> But, assuming the caller of free_swap_and_cache() acquires the PTL first, I
> think this all works out ok? While free_swap_and_cache() is running,
> try_to_unuse() will wait for the PTL. Or if try_to_unuse() runs first, then
> free_swap_and_cache() will never be called because the swap entry will have been
> removed from the PTE?

But can't try_to_unuse() run, detect !si->inuse_pages and not even 
bother about scanning any further page tables?

But my head hurts from digging through that code.

Let me try again:

__swap_entry_free() might be the last user and result in "count == 
SWAP_HAS_CACHE".

swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.


So the question is: could someone reclaim the folio and turn 
si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().

Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are 
still references by swap entries.

Process 1 still references subpage 0 via swap entry.
Process 2 still references subpage 1 via swap entry.

Process 1 quits. Calls free_swap_and_cache().
-> count == SWAP_HAS_CACHE
[then, preempted in the hypervisor etc.]

Process 2 quits. Calls free_swap_and_cache().
-> count == SWAP_HAS_CACHE

Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls 
__try_to_reclaim_swap().

__try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->put_swap_folio()->
free_swap_slot()->swapcache_free_entries()->swap_entry_free()->swap_range_free()->
..
WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);


What stops swapoff to succeed after process 2 reclaimed the swap cache 
but before process 1 finished its call to swap_page_trans_huge_swapped()?



> 
> That just leaves shmem... I suspected there might be some serialization between
> shmem_unuse() (called from try_to_unuse()) and the shmem free_swap_and_cache()
> callsites, but I can't see it. Hmm...
> 
>>
>> Would performing the overall operation under lock_cluster_or_swap_info help? Not
>> so sure :(
> 
> No - that function relies on being able to access the cluster from the array in
> the swap_info and lock it. And I think that array has the same lifetime as
> swap_map, so same problem. You'd need get_swap_device()/put_swap_device() and a
> bunch of refactoring for the internals not to take the locks, I guess. I think
> its doable, just not sure if neccessary...

Agreed.

-- 
Cheers,

David / dhildenb


