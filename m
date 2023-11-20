Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450A07F163C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjKTOvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjKTOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E463A1BF7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700491767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=h09dJptIUW8lShCqB/JHJlG4YuuHK6xGW6edJE77rvw=;
        b=dqsajI55ZCkkJ4SLS0DJWlDmpxRmDwXiBwV8jUFdpP2YMoxL3RhEkRG0/fm1kDXVOX7EIq
        QR7bTXIvp//OQddtso5n240zaMN773fvUVKvm+pjli5s6ze2+H0HDDA8zYWGQgwIc2+55h
        okVcpEZ9SAFYLoHw+Cy0kt7ElOywY88=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-g4vkE6btNoKkGvdAz0ecvA-1; Mon, 20 Nov 2023 09:49:25 -0500
X-MC-Unique: g4vkE6btNoKkGvdAz0ecvA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-408597a1ae3so13794045e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700491764; x=1701096564;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h09dJptIUW8lShCqB/JHJlG4YuuHK6xGW6edJE77rvw=;
        b=AMaeO9odXJk0kUbLB838oYVYuukloxobmo1UHmYjOUvD6EXFZCJWETybvduMa59xKc
         Idnm1t4lR5rst7K6nLLdan04+5noaz1qmZG2A9cgK1bYCKLrLuHL9FiTqezdOeVzLBfz
         l/Ctn4FMeohTmpXECrLw9rAdaHvnmat+DAl+ZecttVhzTo5DPkHOr1ShKN8zz9ZAKPJB
         aq2MzZKZgdv7G5U3pjqXJ6KTo1yGReDowknbACyq2gi4wKAuuH+Sp9VtkuayQ3yvhj8m
         j7HSRVlI2BlcVSVYBV73gz6TneQHDdXpWgJw3IQzybzqEaTAZrU7PRU18QXjkaIhntKt
         cLXQ==
X-Gm-Message-State: AOJu0YzzZ72S3Jv/wGFT7xtw0pVCsBLNIw5nXWvHY41MeA8fYkRvcdK0
        2RNHidXN3cawqU4MiRfxRUWkf4Nx8gIAfmInVW3Mt6wqFG4zCn7iP7Pa/qR4vy5Z78g67gbWLIY
        tVATvWYbXXKh2W62ksZwoDD5199kQovTI
X-Received: by 2002:a05:600c:4e87:b0:401:bcd9:4871 with SMTP id f7-20020a05600c4e8700b00401bcd94871mr5958568wmq.21.1700491764184;
        Mon, 20 Nov 2023 06:49:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG85nbFpD5ft0UYna49OAK/ZEF1DumwHwbLRWtGtKaMckmofBaZdhjGE83lMdVAczBnGY9MUw==
X-Received: by 2002:a05:600c:4e87:b0:401:bcd9:4871 with SMTP id f7-20020a05600c4e8700b00401bcd94871mr5958556wmq.21.1700491763721;
        Mon, 20 Nov 2023 06:49:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:7700:9885:6589:b1e3:f74c? (p200300cbc746770098856589b1e3f74c.dip0.t-ipconnect.de. [2003:cb:c746:7700:9885:6589:b1e3:f74c])
        by smtp.gmail.com with ESMTPSA id k21-20020a7bc415000000b004042dbb8925sm17830675wmi.38.2023.11.20.06.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 06:49:23 -0800 (PST)
Message-ID: <8e2f3e24-e2b9-42ee-a401-6c4b681b9ad3@redhat.com>
Date:   Mon, 20 Nov 2023 15:49:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] s390/mm: implement MEM_PHYS_ONLINE MEM_PHYS_OFFLINE
 memory notifiers
Content-Language: en-US
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <20231114180238.1522782-7-sumanthk@linux.ibm.com>
 <458da84d-3838-4c5d-abda-1aebba676186@redhat.com>
 <ZVTTs2H6DgNGFPkF@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <dfa5eb84-270e-4c6b-b9a1-3bb66beed6a4@redhat.com>
 <20231117140027.00866eab@thinkpad-T15>
From:   David Hildenbrand <david@redhat.com>
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
In-Reply-To: <20231117140027.00866eab@thinkpad-T15>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[catching up on mails]

>>> This new approach has the advantage that we do not need to allocate any
>>> additional memory during online phase, neither for direct mapping page
>>> tables nor struct pages, so that memory hotplug can never fail.
>>
>> Right, just like any other architecture that (triggered by whatever
>> mechanism) ends up calling add_memory() and friends.
> 
> Just for better understanding, are page tables for identity and also
> vmemmap mapping not allocated from system memory on other archs? I.e.
> no altmap support for that, only for struct pages (so far)?

Yes, only the actual "memmap ("struct page")" comes from altmap space, 
everything else comes from the buddy during memory hotplug.

> 
>>
>>>
>>> The old approach (without altmap) is already a hack, because we add
>>> the memmap / struct pages, but for memory that is not really accessible.
>>
>> Yes, it's disgusting. And you still allocate other things like memory
>> block devices or the identify map.
> 
> I would say it is special :-). And again, for understanding, all other

:)

> things apart from struct pages, still would need to be allocated from
> system memory on other archs?

Yes!

> 
> Of course, struct pages would be by far the biggest part, so having
> altmap support for that helps a lot. Doing the other allocations also
> via altmap would feel natural, but it is not possible yet, or did we
> miss something?

The tricky part is making sure ahead of time that that we set aside the 
required number of pageblocks, to properly control during memory 
onlining what to set aside and what to expose to the buddy.

See mhp_supports_memmap_on_memory() / 
memory_block_memmap_on_memory_pages() for the dirty details :)

> 
>>
>>> And with all the disadvantage of pre-allocating struct pages from system
>>> memory.
>>
>> Jep. It never should have been done like that.
> 
> At that time, it gave the benefit over all others, that we do not need
> to allocate struct pages from system memory, at the time of memory online,
> when memory pressure might be high and such allocations might fail.

Agreed. Having the memmap already around can be helpful. But not for all 
standby memory, that's just pure waste.

... but as memory onlining is triggered by user space, it's likely that 
that user space cannot even make progress (e.g., start a process to set 
memory online) to actually trigger memory onlining in serious low-memory 
situations.

> 
> I guess you can say that it should have been done "right" at that time,
> e.g. by already adding something like altmap support, instead of our own
> hack.

Probably yes. IMHO, relying on the existing memory block interface was 
the low hanging fruit. Now, s390x is just special.

> 
>>
>>>
>>> The new approach allows to better integrate s390 to the existing
>>> interface, and also make use of altmap support, which would eliminate
>>> the major disadvantage of the old behaviour. So from s390 perspective,
>>> this new mechanism would be preferred, provided that there is no
>>> functional issue with the "added memory blocks without a memmap"
>>> approach.
>>
>> It achieves that by s390x specific hacks in common code :) Instead of
>> everybody else that simply uses add_memory() and friends.
>>
>>>
>>> Do you see any functional issues, e.g. conflict with common
>>> code?
>>
>> I don't see functional issues right now, just the way it is done to
>> implement support for a new feature is a hack IMHO. Replacing hack #1 by
>> hack #2 is not really something reasonable. Let's try to remove hacks.
> 
> Ok, sounds reasonable, let's try that. Introducing some new s390-specific
> interface also feels a bit hacky, or ugly, but we'll see if we find a
> way so that it is only "special" :-)

As proposed in my other mail, I think there are ways to make s390x happy 
first and look into a cleaner approach long-term.

> Reminds me a bit of that "probe" attribute, that also was an arch-specific
> hack initially, IIRC, and is now to be deprecated...

Yeah, that was for interfaces where the kernel has absolutely no clue 
where/what/how memory gets hotplugged. ARM64 without ACPI.

s390x is completely different though: you know exactly which standby 
memory exists, where it resides, in which granularity in can be 
enabled/disabled, ... you don't have to play dangerous "I'm pretty sure 
there is memory out there although nobody can check so I crash the 
kernel" games.

-- 
Cheers,

David / dhildenb

