Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373D9808B48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442716AbjLGPB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjLGPB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:01:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2A919A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701961322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=b5609l3hqnZFEBLNm0HPIXRfQhPwFCzdwaBzbTijeO0=;
        b=O+wsjpYaWxSNvTLTwyjRaZdtbAvKjWPmGfc8ZF1s8/YVjIHhmkSQiWdwPo7/T9xNTEv1u1
        Y+6AalFv8E0SDPXUhagQeYsCil9E5/+YQGyW0S9FR1pdejCPfjIa4GfJ1QdVphAWI5YiCw
        hhBmTJCj9JAr9zycPgqzBp6fphqJf6I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-k_8vRgA-MK2pBdvsR0BlfA-1; Thu, 07 Dec 2023 10:02:00 -0500
X-MC-Unique: k_8vRgA-MK2pBdvsR0BlfA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b349b9711so9480505e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 07:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701961319; x=1702566119;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5609l3hqnZFEBLNm0HPIXRfQhPwFCzdwaBzbTijeO0=;
        b=fXEau50SMUZ/OOPMulFN6KDBi4szW1MuYeadlcunmJsVNzoU5C49kPBWpnQGF8zr6E
         o8jqZ+zVJfnjob9TWYB94w2yr16EkDPbMbA8u8z2ZO8n8CvTTj/eMEZQsnTdEBETJRc6
         j2o5maG3YZOhRcaYsSsVSZbpqhi6SEl07/d2YH4O4T8Ssad0U8xzdFtDzMqay/a9bx90
         rTk2Qat9CWOzqWQQdtNVXGw9w5vLizAvbeGK42FcWAbYGo38m8Qlq+dit2ALrSHyMuC5
         Ko8bREWtfca2/VWL974WNHWrBb/vNgRxdEz4pXSi9J0plxS0NG4/wBI6F58UJGj8jz8y
         BLbA==
X-Gm-Message-State: AOJu0YxpmHpu+p5E1pGLPWDrmtFTuDZiB8CMypNDcxtfk46rHBGrDqwd
        SxqmfZHhEx923LhsVLl2Dn3WrVAPl0Nsx5de13wJPp8Qel50Vwha9XSM4GAwVs34GLP3OVcKdqu
        noko5wDtseKAAjWtXHxI6fFgo
X-Received: by 2002:a1c:7914:0:b0:40b:5e59:ccd8 with SMTP id l20-20020a1c7914000000b0040b5e59ccd8mr1939654wme.185.1701961319091;
        Thu, 07 Dec 2023 07:01:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6JA4DgIixBBsgeC+wuqSu5jWTfOXeyYdYUoA2VG/tZDV05kdh0OGPMDC5X5Ah202IlyuThg==
X-Received: by 2002:a1c:7914:0:b0:40b:5e59:ccd8 with SMTP id l20-20020a1c7914000000b0040b5e59ccd8mr1939618wme.185.1701961318608;
        Thu, 07 Dec 2023 07:01:58 -0800 (PST)
Received: from [192.168.3.108] (p5b0c66df.dip0.t-ipconnect.de. [91.12.102.223])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b0040b3e26872dsm2270835wms.8.2023.12.07.07.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 07:01:57 -0800 (PST)
Message-ID: <369ec8d3-ef6a-4a4e-84e2-2c91b8293929@redhat.com>
Date:   Thu, 7 Dec 2023 16:01:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-5-ryan.roberts@arm.com>
 <71040a8c-4ea1-4f21-8ac8-65f7c25c217e@redhat.com>
 <f2896d7f-183b-48fb-a3aa-d21bf2257043@arm.com>
 <ca649aad-7b76-4c6d-b513-26b3d58f8e68@redhat.com>
 <126c3b71-1acc-4851-9986-4228cb8a8660@arm.com>
 <94806b4f-2370-4999-9586-2c936955cb87@redhat.com>
 <3d49bcbf-1f9b-48e8-a91a-ede0762b795c@arm.com>
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
In-Reply-To: <3d49bcbf-1f9b-48e8-a91a-ede0762b795c@arm.com>
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

On 07.12.23 15:45, Ryan Roberts wrote:
> On 07/12/2023 13:28, David Hildenbrand wrote:
>>>>
>>>> Right, but you know from the first loop which order is applicable (and will be
>>>> fed to the second loop) and could just pte_unmap(pte) + tryalloc. If that fails,
>>>> remap and try with the next orders.
>>>
>>> You mean something like this?
>>>
>>>      pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>>      if (!pte)
>>>          return ERR_PTR(-EAGAIN);
>>>
>>>      order = highest_order(orders);
>>>      while (orders) {
>>>          addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>>          if (!pte_range_none(pte + pte_index(addr), 1 << order)) {
>>>              order = next_order(&orders, order);
>>>              continue;
>>>          }
>>>
>>>          pte_unmap(pte);
>>>         
>>>          folio = vma_alloc_folio(gfp, order, vma, addr, true);
>>>          if (folio) {
>>>              clear_huge_page(&folio->page, vmf->address, 1 << order);
>>>              return folio;
>>>          }
>>>
>>>          pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>>          if (!pte)
>>>              return ERR_PTR(-EAGAIN);
>>>
>>>          order = next_order(&orders, order);
>>>      }
>>>
>>>      pte_unmap(pte);
>>>
>>> I don't really like that because if high order folio allocations fail, then you
>>> are calling pte_range_none() again for the next lower order; once that check has
>>> succeeded for an order it shouldn't be required for any lower orders. In this
>>> case you also have lots of pte map/unmap.
>>
>> I see what you mean.
>>
>>>
>>> The original version feels more efficient to me.
>> Yes it is. Adding in some comments might help, like
>>
>> /*
>>   * Find the largest order where the aligned range is completely prot_none(). Note
>>   * that all remaining orders will be completely prot_none().
>>   */
>> ...
>>
>> /* Try allocating the largest of the remaining orders. */
> 
> OK added.
> 
>>
>>>
>>>>
>>>> That would make the code certainly easier to understand. That "orders" magic of
>>>> constructing, filtering, walking is confusing :)
>>>>
>>>>
>>>> I might find some time today to see if there is an easy way to cleanup all what
>>>> I spelled out above. It really is a mess. But likely that cleanup could be
>>>> deferred (but you're touching it, so ... :) ).
>>>
>>> I'm going to ignore the last 5 words. I heard the "that cleanup could be
>>> deferred" part loud and clear though :)
>>
>> :)
>>
>> If we could stop passing orders into thp_vma_allowable_orders(), that would
>> probably
>> be the biggest win. It's just all a confusing mess.
> 
> 
> 
> I tried an approach like you suggested in the other thread originally, but I
> struggled to define exactly what "thp_vma_configured_orders()" should mean;
> Ideally, I just want "all the THP orders that are currently enabled for this
> VMA+flags". But some callers want to enforce_sysfs and others don't, so you
> probably have to at least pass that flag. Then you have DAX which explicitly

Yes, the flags would still be passed. It's kind of the "context".

> ignores enforce_sysfs, but only in a page fault. And shmem, which ignores
> enforce_sysfs, but only outside of a page fault. So it quickly becomes pretty
> complex. It is basically thp_vma_allowable_orders() as currently defined.

Yeah, but moving the "can we actually fit a THP in there" check out of 
the picture.

> 
> If this could be a simple function then it could be inline and as you say, we
> can do the masking in the caller and exit early for the order-0 case. But it is
> very complex (at least if you want to retain the equivalent logic to what
> thp_vma_allowable_orders() has) so I'm not sure how to do the order-0 early exit
> without passing in the orders bitfield. And we are unlikely to exit early
> because PMD-sized THP is likely enabled and because we didn't pass in a orders
> bitfield, that wasn't filtered out.
> 
> In short, I can't see a solution that's better than the one I have. But if you
> have something in mind, if you can spell it out, then I'll have a go at tidying
> it up and integrating it into the series. Otherwise I really would prefer to
> leave it for a separate series.

I'm playing with some cleanups, but they can all be built on top if they 
materialize.

-- 
Cheers,

David / dhildenb

