Return-Path: <linux-kernel+bounces-90292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137E586FCFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE246283905
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A79F21109;
	Mon,  4 Mar 2024 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvJ7VwuX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD851B802
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543838; cv=none; b=B4dRk9u5wCHkb66G8Db0oH85Zo8+s1XMtXVhw1vi4G7pionkGfOQts9bu6Y4Hh80OhoWxeHDZlZkcJemAoG05PvinYxS5OyztrfKtnuiL4Ayw0C95BU22vi3lXgT9tL42xH5foqs9eRmBBPFq1b3dYtFdg2U8gbWHS1/8fNLpZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543838; c=relaxed/simple;
	bh=VeLOYp/p9EaWMUp4kqmEC8sW5wLAzpeD/82oXw0aAAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpADG1OSRsUjb0deV8amiH+INEiR/efhmiG7wfyD1PSi+NEek8wqfk6PllniBwbPMRtxXoFnuWS9z0BSAwfuQW2JeP7ZIpqhQPPu4RPHh0J2GC6ju8QtTgt+it1+J2UTe96f/mqTVw3x8M01gxs+7jN5axCjboZkMRTBlOw1lMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VvJ7VwuX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709543835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RNkPkgC8ivGoJULggJ10W91KOeY0Do4uHjNmj4BHL4A=;
	b=VvJ7VwuX8KKZmdYua5uW5nQUvQJytDeex5QjpZQdl+GDhbuhVaLyXLxDman7PXsOqT5aUs
	j3hwuxH5zaXmROelL1bO9SrMGr3ycvoNFXlT1bO1tWv63ib2brhw0ZOZ1IGTdWM3R3Hggq
	TVut7NKDwvx8SisDS/TuAc7Epd5l1/Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-fZaq72NpPP6exHXJ1NI8MA-1; Mon, 04 Mar 2024 04:17:14 -0500
X-MC-Unique: fZaq72NpPP6exHXJ1NI8MA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5132bd3e068so2998729e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709543833; x=1710148633;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNkPkgC8ivGoJULggJ10W91KOeY0Do4uHjNmj4BHL4A=;
        b=v0EEJg24NGIxAfk/hQ+hyBXW9MNuHgv5d7KB0U74r5vxDO459y5HyyIt5mrGoX4R8J
         7maVIQc9BYNQb5yZEJu1nGsxvb3JdMEpRWTyITWWLw7GuDQ8kXsxBR8/n6ZSYEQWsoOU
         YJiYVEDGsl4ilHpgwbS/k+Db6JnJpGXnK7SNlbR5/EYkzJVnfON2NljJIJg3jRq5QQMK
         JgWZb7j7LL7sEcXhoyHv8mHpEDAVZlQGLIYMdCICqqhdIYCFSqLGvVVuOLD7f4Brxw0Y
         PLcs41IIQ7XEWq3ViHucENENt4x+WucLJsJzXokEzvjnhzHBX54Gdg3kZisD+7mVswfB
         zKug==
X-Forwarded-Encrypted: i=1; AJvYcCU+lEwE03B5HODy1l04DQ3KDFGs4w7gy2cVMRg/pzSL/0RE+38cNJ3Qti2ha3nCwukTH/381etrKsLRmRa5E/IyEAzRiEZMLFfTt9Pf
X-Gm-Message-State: AOJu0YzlXUEwZ/fGFa13nlOeeyjqWpEi0iwMtlV3FCYo7COBOhc5Qsa8
	xLDzv9rPgEiYYOv3eT8GT9waYMT8XEEbAubVKVZQ43VcFUvkHI3DDA4Ed7oT9HOY2W5ik8x/2sV
	+3LYTuINhOkNPCJijLrl0+H015cJDy97PbfnR3GUJ86j1C35GziOd+wi9hxL7FQ==
X-Received: by 2002:ac2:5a0a:0:b0:513:e21:2a64 with SMTP id q10-20020ac25a0a000000b005130e212a64mr4773696lfn.31.1709543832763;
        Mon, 04 Mar 2024 01:17:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER/u3vwdc4n5xAH0V/rt9cXdiT4IY7HwMUwvDqfzdaIdm0897DDPsGiBVITi7ndSJOtRi7Mw==
X-Received: by 2002:ac2:5a0a:0:b0:513:e21:2a64 with SMTP id q10-20020ac25a0a000000b005130e212a64mr4773681lfn.31.1709543832373;
        Mon, 04 Mar 2024 01:17:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c733:f100:75e7:a0a4:9ac2:1abb? (p200300cbc733f10075e7a0a49ac21abb.dip0.t-ipconnect.de. [2003:cb:c733:f100:75e7:a0a4:9ac2:1abb])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c4fd100b00412d68dbf75sm6948374wmq.35.2024.03.04.01.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 01:17:11 -0800 (PST)
Message-ID: <d0b19fb4-ee05-4109-9b06-5cdeabc0fcff@redhat.com>
Date: Mon, 4 Mar 2024 10:17:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] CoW on VM_PFNMAP vma during write fault
Content-Language: en-US
To: mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org,
 khlebnikov@openvz.org, jaredeh@gmail.com, linmiaohe@huawei.com,
 hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, cotte@de.ibm.com, npiggin@suse.de
Cc: luto@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, rdunlap@infradead.org, bhelgaas@google.com,
 linux-mm@kvack.org
References: <20240227122814.3781907-1-mawupeng1@huawei.com>
 <a74c8b96-3fc5-44ff-949c-6e5c5e05e122@redhat.com>
 <de0cc6e0-dd15-40b6-89c2-c8e83fd6f587@redhat.com>
 <fa8f9f3b-e01e-4662-a2d5-77caeeb7b9f5@huawei.com>
 <234a5423-8d6d-444a-a27c-c772a71c9871@huawei.com>
 <6e948123-df3a-4450-8fd3-76b9131a35a0@redhat.com>
 <fefd4a04-0af3-4135-9e98-c983ee321e52@huawei.com>
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
In-Reply-To: <fefd4a04-0af3-4135-9e98-c983ee321e52@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.03.24 10:04, mawupeng wrote:
> 
> 
> On 2024/3/4 16:57, David Hildenbrand wrote:
>> On 04.03.24 09:47, mawupeng wrote:
>>> Hi Maintainers, kindly ping...
>>>
>>> On 2024/2/28 9:55, mawupeng wrote:
>>>>
>>>>
>>>> On 2024/2/27 21:15, David Hildenbrand wrote:
>>>>> On 27.02.24 14:00, David Hildenbrand wrote:
>>>>>> On 27.02.24 13:28, Wupeng Ma wrote:
>>>>>>> We find that a warn will be produced during our test, the detail log is
>>>>>>> shown in the end.
>>>>>>>
>>>>>>> The core problem of this warn is that the first pfn of this pfnmap vma is
>>>>>>> cleared during memory-failure. Digging into the source we find that this
>>>>>>> problem can be triggered as following:
>>>>>>>
>>>>>>> // mmap with MAP_PRIVATE and specific fd which hook mmap
>>>>>>> mmap(MAP_PRIVATE, fd)
>>>>>>>       __mmap_region
>>>>>>>         remap_pfn_range
>>>>>>>         // set vma with pfnmap and the prot of pte is read only
>>>>>>>       
>>>>>>
>>>>>> Okay, so we get a MAP_PRIVATE VM_PFNMAP I assume.
>>>>>>
>>>>>> What fd is that exactly? Often, we disallow private mappings in the
>>>>>> mmap() callback (for a good reason).
>>>
>>> We found this problem in 5.10, Commit 9f78bf330a66 ("xsk: support use vaddr as ring") Fix this
>>> problem during supporting vaddr by remap VM_PFNMAP by VM_MIXEDMAP. But other modules which
>>> use remap_pfn_range may still have this problem.
>>
>> I wrote a simple reproducer using MAP_PRIVATE of iouring queues on Friday.
>>
>>>
>>> It do seems wired for private mappings, What is the good reason?
>>
>> I'm sure there are some use cases that require MAP_PRIVATE of such areas, and usually there is nothing wrong with that.
> 
> So MAP_PRIVATE for VM_PFNMAP area with write access is ok? What is the user case for this situation?
I recall that MAP_PRIVATE /dev/mem mappings were required for some use 
cases. No details/ideas about other users, though.

Likely sufficient use case that people really thought about ways to get 
it working -- see vm_normal_page() :)

-- 
Cheers,

David / dhildenb


