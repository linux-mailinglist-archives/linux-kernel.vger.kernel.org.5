Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDAE8056E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345568AbjLEOMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345617AbjLEOMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D091A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701785539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=j6ZWmvdL2M5giY5DfM1bOBrBHushHtnFQNlYHZ0swW0=;
        b=KcflhWsSRsBBROtF3+lClKqsQnQGeikc+7d0P/8hL/FG5+vMdXvn8RY+r2D5kr1SVmsmd4
        D1CwLXz1a7Yhy11ed9KXDiDIt6qF0Px4rDyg6Vy53PMxs7w69eGCh7Hl8mgjnn5B/caJvO
        kjrR8RyO7jDW118XrNgc4S0DucABcFM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-jD0VhQVNPXmIhNP78qEBUg-1; Tue, 05 Dec 2023 09:12:17 -0500
X-MC-Unique: jD0VhQVNPXmIhNP78qEBUg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b3dae2285so43203765e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 06:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701785536; x=1702390336;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6ZWmvdL2M5giY5DfM1bOBrBHushHtnFQNlYHZ0swW0=;
        b=rR5k7NXpV25UtS/Uu5CpFx6HuLJ/OYUTz5Av0rTQa2Frp73wvDNahhsjbDXxY7Onp0
         ExhT22v1oFcsefx4xYyyCV2Zdx6KM+rXvV/+6PSwUYPK4QQWqySV0rlapdqdUaNd2v1M
         u9s9jz14xywHwfW1ViCTa72HhVoIXaoi4KcQNlV/94EycHiN19VVhKZDwsaTu36+o4Yk
         XxpFDccTPxyG2miWBWfgH6B292PK95aUKMzm7PuEHHTDspzly5MoXjN32yicBxUarFrm
         UylqoTliU5pXeLl4f/tvPu80xt/VAgmXkBAz4SSSgaIYdaCQTyezvo66OKOmNFaPz1on
         ZGKQ==
X-Gm-Message-State: AOJu0YyqXyjG8yIVlLXSQypcYrY6LAbn7mCYGcba9n9Vz6i1AWSt4/ws
        kKPOXnAdSgIxxa43p1KDaQaAX/xq/TWHK1p6u9BBQqDC+K35gjM01Qf+vNidGUxIqqJ8Udm6k8D
        wasLe1U3fz2qIC9O4tXyPXSqY
X-Received: by 2002:a7b:cbc7:0:b0:40b:5e1e:fb8b with SMTP id n7-20020a7bcbc7000000b0040b5e1efb8bmr330467wmi.64.1701785536613;
        Tue, 05 Dec 2023 06:12:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIWFHBqMN/4hzAVDgjFXqQGV9Z7L/e8MF2uI4XA6V3Tl3Fg6Q6W05nifFZEU0IbDeuGRT0yQ==
X-Received: by 2002:a7b:cbc7:0:b0:40b:5e1e:fb8b with SMTP id n7-20020a7bcbc7000000b0040b5e1efb8bmr330449wmi.64.1701785536152;
        Tue, 05 Dec 2023 06:12:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id ay10-20020a05600c1e0a00b0040b397787d3sm22603236wmb.24.2023.12.05.06.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 06:12:15 -0800 (PST)
Message-ID: <9d3eb1e5-9fbb-487d-8fe9-066387671357@redhat.com>
Date:   Tue, 5 Dec 2023 15:12:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 34/39] mm/rmap: introduce
 folio_try_dup_anon_rmap_[pte|ptes|pmd]()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-35-david@redhat.com>
 <b7ef017b-f651-40f3-a2bd-70ebe9411dc1@arm.com>
 <88a341bf-0b6a-454a-aeb1-0699233eb37c@redhat.com>
 <bb8e060f-74f0-4b1f-9003-40b2757295ca@redhat.com>
 <181a1623-9285-415e-9ec6-6b6548ca7487@arm.com>
 <0f2bc27e-af1a-4590-985a-dc6bacdbcd57@redhat.com>
 <dd4adcdf-4e46-4763-a4a9-59240ab85423@arm.com>
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
In-Reply-To: <dd4adcdf-4e46-4763-a4a9-59240ab85423@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.23 15:02, Ryan Roberts wrote:
> On 05/12/2023 13:50, David Hildenbrand wrote:
>> On 05.12.23 14:40, Ryan Roberts wrote:
>>> On 05/12/2023 13:18, David Hildenbrand wrote:
>>>> On 05.12.23 14:17, David Hildenbrand wrote:
>>>>> On 05.12.23 14:12, Ryan Roberts wrote:
>>>>>> On 04/12/2023 14:21, David Hildenbrand wrote:
>>>>>>> The last user of page_needs_cow_for_dma() and __page_dup_rmap() are gone,
>>>>>>> remove them.
>>>>>>>
>>>>>>> Add folio_try_dup_anon_rmap_ptes() right away, we want to perform rmap
>>>>>>> baching during fork() soon.
>>>>>>>
>>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>>> ---
>>>>>>>      include/linux/mm.h   |   6 --
>>>>>>>      include/linux/rmap.h | 145 +++++++++++++++++++++++++++++--------------
>>>>>>>      2 files changed, 100 insertions(+), 51 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>>> index 24c1c7c5a99c0..f7565b35ae931 100644
>>>>>>> --- a/include/linux/mm.h
>>>>>>> +++ b/include/linux/mm.h
>>>>>>> @@ -1964,12 +1964,6 @@ static inline bool folio_needs_cow_for_dma(struct
>>>>>>> vm_area_struct *vma,
>>>>>>>          return folio_maybe_dma_pinned(folio);
>>>>>>>      }
>>>>>>>      -static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>>>>>>> -                      struct page *page)
>>>>>>> -{
>>>>>>> -    return folio_needs_cow_for_dma(vma, page_folio(page));
>>>>>>> -}
>>>>>>> -
>>>>>>>      /**
>>>>>>>       * is_zero_page - Query if a page is a zero page
>>>>>>>       * @page: The page to query
>>>>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>>>>> index 21d72cc602adc..84439f7720c62 100644
>>>>>>> --- a/include/linux/rmap.h
>>>>>>> +++ b/include/linux/rmap.h
>>>>>>> @@ -354,68 +354,123 @@ static inline void folio_dup_file_rmap_pmd(struct
>>>>>>> folio *folio,
>>>>>>>      #endif
>>>>>>>      }
>>>>>>>      -static inline void __page_dup_rmap(struct page *page, bool compound)
>>>>>>> +static inline int __folio_try_dup_anon_rmap(struct folio *folio,
>>>>>>
>>>>>> __always_inline?
>>>>>
>>>>> Yes.
>>>>
>>>> Ah, no, I did this for a reason. This function lives in a header, so it will
>>>> always be inlined.
>>>>
>>>
>>> Really? It will certainly be duplicated across every compilation unit, but
>>> that's separate from being inlined - if the optimizer is off, won't it just end
>>> up as an out-of-line function in every compilation unit?
>>
>> Good point, I didn't really consider that here, and thinking about it it makes
>> perfect sense.
>>
>> I think the compiler might even ignore "always_inline". I read that especially
>> with recursion the compiler might ignore that. But people can then complain to
>> the compiler writers about performance issues here, we told the compiler what we
>> think is best.
>>
> 
> To be honest, my comment assumed that you had a good reason for using
> __always_inline, and in that case then you should be consistent. But if you
> don't have a good reason, you should probably just use inline and let the
> compiler do what it thinks best?

I think __always_inline is the right thing to do here, we really want 
the compiler to generate specialized code. I was just somehow ignoring 
the scenario you described :)

__always_inline it is.

-- 
Cheers,

David / dhildenb

