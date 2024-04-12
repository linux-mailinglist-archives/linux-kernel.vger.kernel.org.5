Return-Path: <linux-kernel+bounces-143262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C418A3669
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02CA0B23E86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DA414F9F8;
	Fri, 12 Apr 2024 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLGuANWk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208BC142E78
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950385; cv=none; b=Z7SB2fFRCm3oYcUSIdeOg5foR8rYugtWohe+IF7wjO2HIQmttMzwxcN4GWz762uUZhiJxVjVi3Gams0TIHvFhkWn6mhCbEZ7qRZY/QIS18pMWRtOMqA9R9hiFTqf/71yTfuCwyuOXjwsRHtOcN64korVtALVsUi0kDFPMpoE0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950385; c=relaxed/simple;
	bh=TQgp2LeXvYGKmLL+6vG5B5BrpIoPPoFAR0FU9DorSdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hY8dlNt9CkHpibPfTaq1nkdwF6+I/NpIW6Xm1p6q1JzLfEbP/1XpSWSMfBHMaUf8vPIIN2DeUn6R3Zi5bC89VSABCJF25frENtkObKpq/I+tlubbdmpp8OqmkvXKUt4Do11efHJDXWvLerlz4UPGxs+gDnS5uKBUSXKPhc/P6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLGuANWk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712950382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=530p2kJHJyGsx7M4tsUIH7AbksMfeY1vZMdC3f72yYQ=;
	b=XLGuANWk3kSHvKUPo+MrXaDF90nEtoEnMEChuM7GOLu7h16p1bk3Rb4WygQNt66fMMxnsO
	ANc8lLHboykIU1i4MEgcb7gI+IDsl60ziLYGMoFl90OY49XDNRpKjhK6DIpzOe+O//UHR4
	jCsl/jhhWde405nHL8Gi7f/6umdKVmw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-YdMBjY_2Pbm2SLbGodFp4Q-1; Fri, 12 Apr 2024 15:33:01 -0400
X-MC-Unique: YdMBjY_2Pbm2SLbGodFp4Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343da0a889dso784365f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712950380; x=1713555180;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=530p2kJHJyGsx7M4tsUIH7AbksMfeY1vZMdC3f72yYQ=;
        b=eOXocOZEbYVIELFQfx3e66JroK9g8QnShKYKFKlJYqcFXM+MUrntLgMmV2cZkyCdig
         /2nMV1MUnvVT5Ue8BxLclh09NB0JiEuDHFJrmegBGeXqVuMJL9/8NX0uU3HiKsXpo7Wo
         uEIz1P2mulLepzNcHqrPb2pLilgy6F9OKYRUqS5C3Cg6UORpHS4S+cuu6vKjqNji5czT
         /muDca0tay9UniQN+kNlCw36N/ipaq7bUCKdshoEmOsG0IW05CQFvE8JW47VLUBJrGhQ
         y5KBoJTwPWTsqFyPi276DJ5WuNVqrrzIBYaZwuRiDt0Q6+jtOczRztWjEZwcT/i4bUPn
         pzcw==
X-Forwarded-Encrypted: i=1; AJvYcCV1ayvLuZ1u2pM9pOhjJQmY9+dExAo+sravbAknvdL8BSP8yixH058bIOc4GkylvzSl7tK9Vabb8AvYhATF3X67iwZ0w04wJdpgzpRR
X-Gm-Message-State: AOJu0YzFrRsvOFaEsboL03y3cbOPQpUpA1/3gGob6O+xnqc6N8oTtMpl
	Vx6S57tj0g4gj6hGrQy16ELcyVpc9lbXewimug3z5zJks7X4OlMXtlt6DOULZq82ore2bqvxuXz
	95Dl19BfHqEpMuCxF+LWo13zD5mDVs8dqdae1X65kFbS3bDF8BqSrdnT1GqY7rg==
X-Received: by 2002:adf:a397:0:b0:33d:26b1:c460 with SMTP id l23-20020adfa397000000b0033d26b1c460mr2538033wrb.39.1712950379899;
        Fri, 12 Apr 2024 12:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsil4fbsPURDy5PgN4g+rIpcenpger+bm2UhrHS7PhLVoGZ2tG+uy2Z6MDHc2HVxP2UUYHSA==
X-Received: by 2002:adf:a397:0:b0:33d:26b1:c460 with SMTP id l23-20020adfa397000000b0033d26b1c460mr2538014wrb.39.1712950379464;
        Fri, 12 Apr 2024 12:32:59 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23ff1.dip0.t-ipconnect.de. [79.242.63.241])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4ccc000000b00343f662327bsm4898968wrt.77.2024.04.12.12.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 12:32:59 -0700 (PDT)
Message-ID: <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
Date: Fri, 12 Apr 2024 21:32:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Yang Shi <shy828301@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240411153232.169560-1-zi.yan@sent.com>
 <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.04.24 16:35, Zi Yan wrote:
> On 11 Apr 2024, at 11:46, David Hildenbrand wrote:
> 
>> On 11.04.24 17:32, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> In __folio_remove_rmap(), a large folio is added to deferred split list
>>> if any page in a folio loses its final mapping. It is possible that
>>> the folio is unmapped fully, but it is unnecessary to add the folio
>>> to deferred split list at all. Fix it by checking folio mapcount before
>>> adding a folio to deferred split list.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>    mm/rmap.c | 9 ++++++---
>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 2608c40dffad..d599a772e282 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>    		enum rmap_level level)
>>>    {
>>>    	atomic_t *mapped = &folio->_nr_pages_mapped;
>>> -	int last, nr = 0, nr_pmdmapped = 0;
>>> +	int last, nr = 0, nr_pmdmapped = 0, mapcount = 0;
>>>    	enum node_stat_item idx;
>>>     	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>    			break;
>>>    		}
>>>   -		atomic_sub(nr_pages, &folio->_large_mapcount);
>>> +		mapcount = atomic_sub_return(nr_pages,
>>> +					     &folio->_large_mapcount) + 1;
>>
>> That becomes a new memory barrier on some archs. Rather just re-read it below. Re-reading should be fine here.
> 
> Would atomic_sub_return_relaxed() work? Originally I was using atomic_read(mapped)
> below, but to save an atomic op, I chose to read mapcount here.

Some points:

(1) I suggest reading about atomic get/set vs. atomic RMW vs. atomic
RMW that return a value -- and how they interact with memory barriers.
Further, how relaxed variants are only optimized on some architectures.

atomic_read() is usually READ_ONCE(), which is just an "ordinary" memory
access that should not be refetched. Usually cheaper than most other stuff
that involves atomics.

(2) We can either use folio_large_mapcount() == 0 or !atomic_read(mapped)
to figure out if the folio is now completely unmapped.

(3) There is one fundamental issue: if we are not batch-unmapping the whole
thing, we will still add the folios to the deferred split queue. Migration
would still do that, or if there are multiple VMAs covering a folio.

(4) We should really avoid making common operations slower only to make
some unreliable stats less unreliable.


We should likely do something like the following, which might even be a bit
faster in some cases because we avoid a function call in case we unmap
individual PTEs by checking _deferred_list ahead of time

diff --git a/mm/rmap.c b/mm/rmap.c
index 2608c40dffad..356598b3dc3c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
                  * page of the folio is unmapped and at least one page
                  * is still mapped.
                  */
-               if (folio_test_large(folio) && folio_test_anon(folio))
-                       if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
-                               deferred_split_folio(folio);
+               if (folio_test_large(folio) && folio_test_anon(folio) &&
+                   (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped) &&
+                   atomic_read(mapped) &&
+                   data_race(list_empty(&folio->_deferred_list)))
+                       deferred_split_folio(folio);
         }
  

I also thought about handling the scenario where we unmap the whole
think in smaller chunks. We could detect "!atomic_read(mapped)" and
detect that it is on the deferred split list, and simply remove it
from that list incrementing an THP_UNDO_DEFERRED_SPLIT_PAGE event.

But it would be racy with concurrent remapping of the folio (might happen with
anon folios in corner cases I guess).

What we can do is the following, though:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index dc30139590e6..f05cba1807f2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3133,6 +3133,8 @@ void folio_undo_large_rmappable(struct folio *folio)
         ds_queue = get_deferred_split_queue(folio);
         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
         if (!list_empty(&folio->_deferred_list)) {
+               if (folio_test_pmd_mappable(folio))
+                       count_vm_event(THP_UNDO_DEFERRED_SPLIT_PAGE);
                 ds_queue->split_queue_len--;
                 list_del_init(&folio->_deferred_list);
         }

Adding the right event of course.


Then it's easy to filter out these "temporarily added to the list, but never split
before the folio was freed" cases.


-- 
Cheers,

David / dhildenb


