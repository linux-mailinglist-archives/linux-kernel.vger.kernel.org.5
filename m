Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC297FA4FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjK0Pm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjK0PmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:42:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEDA138
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701099750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=OVf8K+prFpGafX82AZowc/KDxLm5HF1BmxSsG5DRVSQ=;
        b=anH1NPYL7U7TycdP/KctXLNy5yRcDC19StVoMx8TgDlsUGbpBsUeDxtT+TDBrASmy+fSDE
        +6bCK+9lsAWL7Z1EsVojhgBdf6uiZqA9V931C8slYUbz/RJtovVlDolJ5IfflPEERr8KtA
        DNukDsyeKVNkFC3jzGUFW2omjuuP954=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-7cN76Lm-PbOYRJZFmmhuSg-1; Mon, 27 Nov 2023 10:42:28 -0500
X-MC-Unique: 7cN76Lm-PbOYRJZFmmhuSg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c89230b1fdso50038851fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099747; x=1701704547;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OVf8K+prFpGafX82AZowc/KDxLm5HF1BmxSsG5DRVSQ=;
        b=ShRZYyHWmNQ6twDLqw6fKoCXKCnMpPEaZA1pzJ+fWop32PDNvMisPSksa6tYP7AkE9
         AUKvHiI30QPvUeLTrdmyQl+/6VHnS+sR/KmD0aS8eLGhq2HuANRhuWHKkwR65Z9TMPX6
         9I9a0Gjso+ZyhnRfqN3F/STkgHPjYtSwjxJCRuKNiWQAT+FXBQDoDtofjU8Jalv+1fL5
         eaaznPMMLGfk8DRU+h0OZfNX8h6IaIsdN1Fwq7/nnFqkuZe1ik88fKJvqXhTT5eOXo3N
         mpkt0WP811ptKUwP6QY3mIwnhV00zCpYNjTxtLWfRnUPVPRCSinBf76nMvT7fKJf5jM4
         ZL4w==
X-Gm-Message-State: AOJu0YwaYP9Au2PL0A/AhhLVGOwLmW6N3dagpdCfDFEuAJZzRE1sv+st
        BzOR93YEtLAjZ1TmRX/NIfiRXvywnqs8neLOoh3lhovhzniin/ZHITH35R5PdfG06FP6zxrpYYm
        818tmWVLYywfrYTmxACNKVxj0NHGsCgYz
X-Received: by 2002:a2e:b54d:0:b0:2c9:9982:69ed with SMTP id a13-20020a2eb54d000000b002c9998269edmr4414733ljn.22.1701099747413;
        Mon, 27 Nov 2023 07:42:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX1sUPzTB9UIhFtamzt74jbXxZum++CuA+wVkI9DJYiHjAuRNNTiqdmsikyHpS0dTS11u73Q==
X-Received: by 2002:a2e:b54d:0:b0:2c9:9982:69ed with SMTP id a13-20020a2eb54d000000b002c9998269edmr4414707ljn.22.1701099747001;
        Mon, 27 Nov 2023 07:42:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3? (p200300cbc7452a00d74aa8c520b63ec3.dip0.t-ipconnect.de. [2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b003143867d2ebsm12380949wrz.63.2023.11.27.07.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 07:42:26 -0800 (PST)
Message-ID: <4ca4a5af-accb-4424-a5fb-e1e561900348@redhat.com>
Date:   Mon, 27 Nov 2023 16:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   David Hildenbrand <david@redhat.com>
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Barry Song <21cnbao@gmail.com>,
        Steven Price <steven.price@arm.com>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@suse.com, shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com
References: <20231114014313.67232-1-v-songbaohua@oppo.com>
 <864489b3-5d85-4145-b5bb-5d8a74b9b92d@redhat.com>
 <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
 <CAGsJ_4w4VgpO02YUVEn4pbKThg+SszD_bDpBGbKC9d2G90MpGA@mail.gmail.com>
 <8c7f1a2f-57d2-4f20-abb2-394c7980008e@redhat.com>
 <CAGsJ_4zqAehJSY9aAQEKkp9+JvuxtJuF1c7OBCxmaG8ZeEze_Q@mail.gmail.com>
 <e1e6dba5-8702-457e-b149-30b2e43156cf@redhat.com>
 <fb34d312-1049-4932-8f2b-d7f33cfc297c@arm.com>
 <CAGsJ_4zNOCa-bLkBdGXmOAGSZkJQZ0dTe-YWBubkdHmOyOimWg@mail.gmail.com>
 <5de66ff5-b6c8-4ffc-acd9-59aec4604ca4@redhat.com>
 <bab848b8-edd3-4c57-9a96-f17a33e030d0@arm.com>
 <71c4b8b2-512a-4e50-9160-6ee77a5ec0a4@arm.com>
 <CAGsJ_4yoYowJLm+cC8i-HujLcNJKGut+G-NnjRhg2eGkYvXz8Q@mail.gmail.com>
 <679a144a-db47-4d05-bbf7-b6a0514f5ed0@arm.com>
 <c5c82611-3153-4d56-b799-a1df3c953efe@redhat.com>
 <8aa8f095-1840-4a2e-ad06-3f375282ab6a@arm.com>
 <7065bbd3-64b3-4cd6-a2cd-146c556aac66@redhat.com>
 <74596ea2-e7e5-4161-9600-ad1a69b6a6fe@arm.com>
Content-Language: en-US
In-Reply-To: <74596ea2-e7e5-4161-9600-ad1a69b6a6fe@arm.com>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Are you referring to Steven's suggestion of reading the tag to see if it's
>>> zeros? I think that demonstrates my point that this has to be done per-page and
>>
>> Yes.
> 
> OK I'm obviously being thick, because checking a page's tag to see if its zero
> seems logically equivalent to checking the existing per-page flag, just more
> expensive. Yes we could make that change but I don't see how it helps solve the
> real problem at hand. Unless you are also deliberately trying to remove the
> per-page flag at the same time, as per Matthew's master plan?

I think a per-folio interface is cleaner and more future-proof, and 
removing the per-page flag might be a nice side product of that.

Anyhow, just some thoughts from my side if it could be easily/cleanly done.

At least the "easy" part does not seem to be the case, so I'm fine with 
deferring anything like that for now.

[...]

>>
>> We can identify in 1) the subpages by reading the tag from HW,
> 
> I don't think this actually works; I'm pretty sure the optimization to clear the
> tag at the same time as the page clearing only happens for small pages. I don't
> think this will be done when allocating a THP today. Obviously that could change.
> 

Could be, absolutely no expert. I was primarily on the "It would be 
possible to reverse this scheme - we could drop the page
flag and just look at the actual tag storage. If it's all zeros then
obviously there's no point in storing it." comment from Steven.

>> and on 2) by
>> checking the datastructure. For 3), there is nothing to check.
>>
>> On swapout of a large folio:
>>
>> * For 3) we don't do anything
>> * For 2) we don't do anything
>> * For 1) we store all tags that are non-zero (reading all tags) and
>>    transition to 2).
> 
> Given a tag architecturally exists for every page even when unused, and we think
> a folio being partially mte-tagged is the corner case, could you simplify this
> further and just write out all the tags for the folio and not care if some are
> not in use?

Likely this could be simplified, yes.

-- 
Cheers,

David / dhildenb


