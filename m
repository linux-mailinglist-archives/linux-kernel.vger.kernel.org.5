Return-Path: <linux-kernel+bounces-158166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 146DE8B1C72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FC7B210CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6616F06A;
	Thu, 25 Apr 2024 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rzsc8BWt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5316EB4C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032404; cv=none; b=r1eEkw9Nzs20yVLx2FKWyKCk4uT57/TKZfE4KJjLlg3B1Y9A6NolOW0qLE4vdWOTJZkKaWtV5D905nab8idhBpc42zJinpwzMnP0joaGYHdHd6ruVy2VH4PjNTzAKvZFtkD5yOqNGMym7tPu3kp/AQqpy5NMLGR751IK3x2vg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032404; c=relaxed/simple;
	bh=OqEPL91s2VrIxiNSjTnTjf14Lr1dsIy3upe55GQbW30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ez9914fz1p9jb2dOYge+TVeVjFDLFVhR33T+wHak2l7IaxYdLCuPMRqrC2KvflDIPyC+c3DR+Lx6Xt79aJXF/JH+aRpqQSFsC7qLWvgiKjxl8W6gFIsfWb3lKaIXtGef4BDO9vL1L8zvlzW0aETjqC5jnhAzLt8+4/yAm/Pgo4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rzsc8BWt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714032400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AlYC1p9SeArngQ8uAx8l/CabDGlblHf7nYuOZx9ycV0=;
	b=Rzsc8BWtwwxgDxGTsOT3Ie+cpp0xKIBc7TMJlAivevpGCgphekI+BxQQImqGXli3WG2vzM
	H21pzvmbn2fywsln+fKb+mgegYIdsccIIne35vfoyHzoXz7UvlXjCaOTu50VBF4xje8ruU
	U7N36EW8DpubQsDcNHk+aiw3Pp+6SNw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-FYjBJ0QRM8SOv9DbOVWEag-1; Thu, 25 Apr 2024 04:06:38 -0400
X-MC-Unique: FYjBJ0QRM8SOv9DbOVWEag-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4147de378b9so3340625e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714032397; x=1714637197;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AlYC1p9SeArngQ8uAx8l/CabDGlblHf7nYuOZx9ycV0=;
        b=Sr6Zre3Mhd3g5nPS2CBr8DRvAdtQ6I+K6HXosADI5WRB4VuSLRX8Byt5093W2I2WCN
         cDQWjGK3E4n3thwPouhDdiZrfyKXJAB90wOqJdvyR8kwBF4Sl3SWbPiI1DWuhYHTIXBK
         T/6ldcA2DGryLHRpL7nzBkaC5Tkok9EY54rmrY/jxWP7dhCYhoVBpqLVeL8nuSz30SOs
         xccKU+V6uRWmCL37T+cZ1g8NH1nrVM6z3fP17XEO20KSFGe0RnjdmoOSYxfXwQw6YKHr
         ltz+qPOB3s2iI+Poww4jBuv34lT0NiOYJgQNSvQ68/1Y3P0ywc7dwIalcLHdDH8LDTh9
         G5wg==
X-Gm-Message-State: AOJu0YzXbKkwWSighuxzq7KikhvW4zwIMMx3rQg7Ibj7iX/PE/Hb0xDN
	ExZUMjrvyANDlHXPKyIyjorEeRueTyObhTnn7xHUjN8TsHnmVskC+yq/RK15tM9wAh/ZBJ3YUqg
	l85LTEdzYMZCmwnvKFD23bw1tH5Da/N3FOfGvP0gmWE4dFStjnzZuHyEkJLrTzodhWXfTdg==
X-Received: by 2002:a05:600c:1f91:b0:418:b74f:5a4f with SMTP id je17-20020a05600c1f9100b00418b74f5a4fmr3935884wmb.9.1714032397117;
        Thu, 25 Apr 2024 01:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVZhqhQTaJKR4TQWxl76yxcQxJtWDJoi6nmyJ960xJIV/eSJgKgWfuhvma0mXTjk0ii3k5jg==
X-Received: by 2002:a05:600c:1f91:b0:418:b74f:5a4f with SMTP id je17-20020a05600c1f9100b00418b74f5a4fmr3935854wmb.9.1714032396582;
        Thu, 25 Apr 2024 01:06:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id e15-20020a05600c218f00b004146e58cc35sm29610967wme.46.2024.04.25.01.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 01:06:36 -0700 (PDT)
Message-ID: <7273b0d6-06e7-4741-b77b-b49949c46d63@redhat.com>
Date: Thu, 25 Apr 2024 10:06:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/khugepaged: replace page_mapcount() check by
 folio_likely_mapped_shared()
To: John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20240424122630.495788-1-david@redhat.com>
 <73de5556-e574-4ed7-a7fb-c4648e46206b@nvidia.com>
 <ZinZSDTMXjPjAHLe@casper.infradead.org>
 <18b9acc9-9dc8-4857-83d1-952c94b69e01@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
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
In-Reply-To: <18b9acc9-9dc8-4857-83d1-952c94b69e01@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.04.24 07:40, John Hubbard wrote:
> On 4/24/24 9:17 PM, Matthew Wilcox wrote:
>> On Wed, Apr 24, 2024 at 09:00:50PM -0700, John Hubbard wrote:
>>>> We want to limit the use of page_mapcount() to places where absolutely
>>>> required, to prepare for kernel configs where we won't keep track of
>>>> per-page mapcounts in large folios.
>>>
>>>
>>> Just curious, can you elaborate on the motivation? I probably missed
>>> the discussions that explained why page_mapcount() in large folios
>>> is not desirable. Are we getting rid of a field in struct page/folio?
>>> Some other reason?

Thanks for looking into this!

>>
>> Two reasons.  One is that, regardless of anything else, folio_mapcount()
>> is expensive on large folios as it has to walk every page in the folio
>> summing the mapcounts.  The more important reason is that when we move
>> to separately allocated folios, we don't want to allocate an array of
>> mapcounts in order to maintain a per-page mapcount.
>>
>> So we're looking for a more compact scheme to avoid maintaining a
>> per-page mapcount.
>>
> 
> I see. Thanks for explaining the story.

We'll talk more about all that at LSF/MM in the mapcount session. A spoiler:

page_mapcount() in the context of large folios:
* Is a misunderstood function (e.g., page_mapcount() vs page_count()
   checks, mapped = !page_mapcount() checks).
* Is a misleading function (e.g., page_mapped() == folio_mapped() but
   page_mapcount() != folio_mapcount())

We could just rename it to "folio_precise_page_mapcount()", but then, 
once we tackle the subpage mapcount optimizations (initially using a 
separate kernel config toggle), we'll have to teach each caller about an 
alternative that gets the job done, and it's not that easy to prevent 
further reuse around the kernel.

If you look at linux-next, we're down to 5 page_mapcount() calls in 
fs/proc/, so I'll relocate it to fs/proc/internal.h to prevent any 
further use - once the s390x change lands in the next merge window.

Regarding the subpage mapcount optimizations, I can further add:
* (un)map performance improvements for PTE-mapped THP
* Preparation for folio_order() > PMD_ORDER, where the current scheme
   won't scale and needs further adjustments/complexity to even keep it
   working
* Preparation for hugetlb-like vmemmap optimizations until we have
   memdescs / dynamically allocated folios
* (Paving the way for partially mapping hugetlb folios that faced
    similar issues? Not sure if that ever gets real, though)

Is this patch ahead of its time? LSF/MM is just around the corner, and 
I'm planning on posting the other relevant patches in the next months.

> 
>>>> The khugepage MM selftests keep working as expected, including:
>>>>
>>>> 	Run test: collapse_max_ptes_shared (khugepaged:anon)
>>>> 	Allocate huge page... OK
>>>> 	Share huge page over fork()... OK
>>>> 	Trigger CoW on page 255 of 512... OK
>>>> 	Maybe collapse with max_ptes_shared exceeded.... OK
>>>> 	Trigger CoW on page 256 of 512... OK
>>>> 	Collapse with max_ptes_shared PTEs shared.... OK
>>>> 	Check if parent still has huge page... OK
>>>
>>> Well, a word of caution! These tests do not (yet) cover either of
>>> the interesting new cases that folio_likely_mapped_shared() presents:
>>> KSM or hugetlbfs interactions. In other words, false positives.
>>
>> Hmm ... KSM never uses large folios and hugetlbfs is disjoint from
>> khugepaged?

Right, folio_likely_mapped_shared() behaves exactly like page_mapcount() 
would for (small) KSM folios, so no change for them.

Thankfully, hugetlb is out of the picture this time.

>>
> 
> Oh good. I thought we might have had a testing hole, but no.

Thanks for having a look!

I'm only a bit concerned about folio_likely_mapped_shared() "false 
negatives" (detecting exclusive although shared), until we have a more 
precise folio_likely_mapped_shared() variant to not unexpectedly waste 
memory.

Imagine someone would be setting "khugepaged_max_ptes_shared=0", and 
then we have an area where (I think this is the extreme case):

* We map 256 subpages of a 2M folio that are shared 256 times with a
   child process.
* We don't map the first subpage.
* One PTE maps another page and is pte_write().
* 255 PTEs are pte_none().

folio_likely_mapped_shared() would return "false".

But then my thinking is:
* We are already wasting 256 subpages that are free in the 2M folio.
   Sure, we might be able to relaim it when deferred splitting.
* Why would someone set khugepaged_max_ptes_shared=0 but leave
   khugepaged_max_ptes_none set that high that we would allow 255
   pte_none?
* If the child is a short-living subprocess, we don't really care
* Any futher writes to unbacked/R/O PTEs in that PMD area would COW and
   consume memory.

So I had to use more and more "ifs" to construct a scenario where we 
might end up wasting 1M of memory, at which point I decided "this is 
really a corner case" and likely not worth the worry.

If we run into real issues, though, it will be easy to just inline 
page_mapcount() here to resolve it; but the less special-casing the better.

-- 
Cheers,

David / dhildenb


