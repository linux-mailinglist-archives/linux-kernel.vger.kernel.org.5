Return-Path: <linux-kernel+bounces-96131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCC5875778
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207BF283109
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD68C138481;
	Thu,  7 Mar 2024 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFiB8Oqn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A9130AD0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840938; cv=none; b=AN2GCN9NhWm69Ez3vX/WPFiaNPr98Xzhyb8vedUftoy1LAinyi1AI2nuqm0WZwuJLqaJuzewwAQtun6IDPhO/zUIii7gS1CwMwriF1SYzRZoNMYC0dKJ3s4nfNFeF5UWCmkcJeq+0koF5VXfs+g8dqdlOs6xJgJ6bkfQPs17ygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840938; c=relaxed/simple;
	bh=npsV2UnBpjwjw3n2sQuYGauJXDaXVaiq+ae+LqhVGws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DniYqu5ZOHW+YecJwHqaDNyj+fgiizj+krlNfSpALD4UqufBFL/ZQbp/AM+NVr9y9mMirUpuf12e39oYtfDvgu8+BCYNwwm6oNn7UiFBXYEHzGDn/EvnhgA53pjAqAa6UCCZsD0qqSW9FRsLJUWxQjVQkjGhVGFsRUL24kKu1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFiB8Oqn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709840935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yiF1okAFqkpwbfTfbV1hW7AP3mO48Id2xuxKBejIZvU=;
	b=VFiB8OqnmxmG3j+PCpqDQRB5swKm7PVJyyVaSFv2Iz5N7gTM23Jnmq6bB7YUxF0w7/PSrK
	DRYWyz5UO2Llo4ldY41gcmujCCb/5l2dPoBdaBuKrpf/dNBct5tEiNZJgCoN4Nd6Ta9r+O
	NR847il+MMGvxNql6SqGNM1Bm0bGyiQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-uMjwWm9WMmOu-iRh-5QxTg-1; Thu, 07 Mar 2024 14:48:53 -0500
X-MC-Unique: uMjwWm9WMmOu-iRh-5QxTg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d8d208be9so25120f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709840932; x=1710445732;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiF1okAFqkpwbfTfbV1hW7AP3mO48Id2xuxKBejIZvU=;
        b=HSQLZOFny1LN9sdRuMmtv23JFqcAt2GH/tQOaV70Sb5UdGDSvYp0LvjsfmX3F91m6B
         tOC+BWEkXPQRKyUQlDFiK9gb61bx0OP9MCeiG+mKU2wGAkr/Eo2RINVn7Ps09k8vW0QZ
         0j3cycJEolGQCiqjpUJ1o+3jDXt1+z181T6iiUVskxkfl2g0vunzzfTW6h/4Ov17+gJ/
         bXElVfyha0qikm+3lpsm1bQt/MsEceu2wVVzCKoweDG3GWYTeMwIZUTcisv/2mnFJoMe
         RVlFZVfgmVIvj4ezm8BnKxmdQlVoRHa1KXPNChjRnP5aKpKv+Uqmd5ND6a1TkHW3xQ1Q
         /1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwidKNYIy4SpVW663R8+NjYdeUwd5FBv43fMzmQp4ZmZUBFRX/I1GL2gCs1/WClg86u4AeyxjJLNmeueMrvAVn36ZOvkBlrBRd4R83
X-Gm-Message-State: AOJu0YxpzuZpliyNhbTRmR11vZ+MeX/nT4hgO+WUMheZ4ffUt+dK5one
	xfW6Os4gRo7zCIBBXZspZ7PPe9Y5oGyiu9EqKKkDCR3epD8De0Juj6rN5NtDXDZ8TT9V6hAOWnf
	7Y/JmqH7eh/agD/4JPiImz4H/wFC3eZsWbb3soa50zKYD0pk3iBogsG2aEAls4Q==
X-Received: by 2002:a5d:4561:0:b0:33e:7564:ceb with SMTP id a1-20020a5d4561000000b0033e75640cebmr190557wrc.52.1709840932130;
        Thu, 07 Mar 2024 11:48:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG60NaZj4aKqWpJsBV5IHQCipxJhupwE33L1I5bt9b5ryojxNViS0E5J9Umw59PkLEQz+Snhg==
X-Received: by 2002:a5d:4561:0:b0:33e:7564:ceb with SMTP id a1-20020a5d4561000000b0033e75640cebmr190540wrc.52.1709840931665;
        Thu, 07 Mar 2024 11:48:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:6400:4867:4ed0:9726:a0c9? (p200300cbc74d640048674ed09726a0c9.dip0.t-ipconnect.de. [2003:cb:c74d:6400:4867:4ed0:9726:a0c9])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b0033e456848f4sm9661876wrf.82.2024.03.07.11.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 11:48:51 -0800 (PST)
Message-ID: <6f0c75cd-bbfd-4b7b-b022-75f7aa577ddd@redhat.com>
Date: Thu, 7 Mar 2024 20:48:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Lance Yang <ioworker0@gmail.com>, Vishal Moola <vishal.moola@gmail.com>,
 akpm@linux-foundation.org, zokeefe@google.com, shy828301@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, xiehuan09@gmail.com,
 wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240307061425.21013-1-ioworker0@gmail.com>
 <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
 <CAK1f24k2G_DSEjuqqqPyY0f7+btpYbjfoyMH7btLfP8nkasCTQ@mail.gmail.com>
 <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
 <03458c20-5544-411b-9b8d-b4600a9b802f@arm.com>
 <CAGsJ_4zp1MXTjG=4gBO+J3owg7sHDgDJ8Ut51i1RBSnKnK0BfQ@mail.gmail.com>
 <501c9f77-1459-467a-8619-78e86b46d300@arm.com>
 <8f84c7d6-982a-4933-a7a7-3f640df64991@redhat.com>
 <e6bc142e-113d-4034-b92c-746b951a27ed@redhat.com>
 <d24f8553-33f2-4ae7-a06d-badaf9462d84@arm.com>
 <CAGsJ_4za-2xpg21phWi2WWLF1iPXhoc1xM__FDTwYYBBKsTPgw@mail.gmail.com>
 <a07deb2c-49e1-4324-8e70-e897605faa9d@redhat.com>
 <b1bf4b62-8e9b-470f-a300-d13c24177688@arm.com>
 <b174d4e1-e1ef-4766-91bc-de822eee30fb@redhat.com>
 <CAGsJ_4xXS0MsxRVTbf74DY_boQVUE2oP=AP6JmdXZSqsAOZzRQ@mail.gmail.com>
 <f3b1cb43-cb33-4db4-a3dd-0c787e30b113@arm.com>
 <CAGsJ_4wGe9SdMvojw_2XchEttrbww3RttoOENoF-O4bLWUd_rw@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4wGe9SdMvojw_2XchEttrbww3RttoOENoF-O4bLWUd_rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.03.24 19:54, Barry Song wrote:
> On Fri, Mar 8, 2024 at 12:31 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 07/03/2024 12:01, Barry Song wrote:
>>> On Thu, Mar 7, 2024 at 7:45 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 07.03.24 12:42, Ryan Roberts wrote:
>>>>> On 07/03/2024 11:31, David Hildenbrand wrote:
>>>>>> On 07.03.24 12:26, Barry Song wrote:
>>>>>>> On Thu, Mar 7, 2024 at 7:13 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>>
>>>>>>>> On 07/03/2024 10:54, David Hildenbrand wrote:
>>>>>>>>> On 07.03.24 11:54, David Hildenbrand wrote:
>>>>>>>>>> On 07.03.24 11:50, Ryan Roberts wrote:
>>>>>>>>>>> On 07/03/2024 09:33, Barry Song wrote:
>>>>>>>>>>>> On Thu, Mar 7, 2024 at 10:07 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 07/03/2024 08:10, Barry Song wrote:
>>>>>>>>>>>>>> On Thu, Mar 7, 2024 at 9:00 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Hey Barry,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks for taking time to review!
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Thu, Mar 7, 2024 at 3:00 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Thu, Mar 7, 2024 at 7:15 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> [...]
>>>>>>>>>>>>>>>>> +static inline bool can_mark_large_folio_lazyfree(unsigned long addr,
>>>>>>>>>>>>>>>>> +                                                struct folio *folio,
>>>>>>>>>>>>>>>>> pte_t *start_pte)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +       int nr_pages = folio_nr_pages(folio);
>>>>>>>>>>>>>>>>> +       fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +       for (int i = 0; i < nr_pages; i++)
>>>>>>>>>>>>>>>>> +               if (page_mapcount(folio_page(folio, i)) != 1)
>>>>>>>>>>>>>>>>> +                       return false;
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> we have moved to folio_estimated_sharers though it is not precise, so
>>>>>>>>>>>>>>>> we don't do
>>>>>>>>>>>>>>>> this check with lots of loops and depending on the subpage's mapcount.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> If we don't check the subpage’s mapcount, and there is a cow folio
>>>>>>>>>>>>>>> associated
>>>>>>>>>>>>>>> with this folio and the cow folio has smaller size than this folio,
>>>>>>>>>>>>>>> should we still
>>>>>>>>>>>>>>> mark this folio as lazyfree?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I agree, this is true. However, we've somehow accepted the fact that
>>>>>>>>>>>>>> folio_likely_mapped_shared
>>>>>>>>>>>>>> can result in false negatives or false positives to balance the
>>>>>>>>>>>>>> overhead.  So I really don't know :-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Maybe David and Vishal can give some comments here.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> BTW, do we need to rebase our work against David's changes[1]?
>>>>>>>>>>>>>>>> [1]
>>>>>>>>>>>>>>>> https://lore.kernel.org/linux-mm/20240227201548.857831-1-david@redhat.com/
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Yes, we should rebase our work against David’s changes.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +       return nr_pages == folio_pte_batch(folio, addr, start_pte,
>>>>>>>>>>>>>>>>> +                                        ptep_get(start_pte), nr_pages,
>>>>>>>>>>>>>>>>> flags, NULL);
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>       static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>>>>>>>>>>>>>>>>                                      unsigned long end, struct mm_walk
>>>>>>>>>>>>>>>>> *walk)
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t *pmd,
>>>>>>>>>>>>>>>>> unsigned long addr,
>>>>>>>>>>>>>>>>>                       */
>>>>>>>>>>>>>>>>>                      if (folio_test_large(folio)) {
>>>>>>>>>>>>>>>>>                              int err;
>>>>>>>>>>>>>>>>> +                       unsigned long next_addr, align;
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> -                       if (folio_estimated_sharers(folio) != 1)
>>>>>>>>>>>>>>>>> -                               break;
>>>>>>>>>>>>>>>>> -                       if (!folio_trylock(folio))
>>>>>>>>>>>>>>>>> -                               break;
>>>>>>>>>>>>>>>>> +                       if (folio_estimated_sharers(folio) != 1 ||
>>>>>>>>>>>>>>>>> +                           !folio_trylock(folio))
>>>>>>>>>>>>>>>>> +                               goto skip_large_folio;
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I don't think we can skip all the PTEs for nr_pages, as some of them
>>>>>>>>>>>>>>>> might be
>>>>>>>>>>>>>>>> pointing to other folios.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> for example, for a large folio with 16PTEs, you do MADV_DONTNEED(15-16),
>>>>>>>>>>>>>>>> and write the memory of PTE15 and PTE16, you get page faults, thus PTE15
>>>>>>>>>>>>>>>> and PTE16 will point to two different small folios. We can only skip
>>>>>>>>>>>>>>>> when we
>>>>>>>>>>>>>>>> are sure nr_pages == folio_pte_batch() is sure.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Agreed. Thanks for pointing that out.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +                       align = folio_nr_pages(folio) * PAGE_SIZE;
>>>>>>>>>>>>>>>>> +                       next_addr = ALIGN_DOWN(addr + align, align);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +                       /*
>>>>>>>>>>>>>>>>> +                        * If we mark only the subpages as lazyfree, or
>>>>>>>>>>>>>>>>> +                        * cannot mark the entire large folio as
>>>>>>>>>>>>>>>>> lazyfree,
>>>>>>>>>>>>>>>>> +                        * then just split it.
>>>>>>>>>>>>>>>>> +                        */
>>>>>>>>>>>>>>>>> +                       if (next_addr > end || next_addr - addr !=
>>>>>>>>>>>>>>>>> align ||
>>>>>>>>>>>>>>>>> +                           !can_mark_large_folio_lazyfree(addr, folio,
>>>>>>>>>>>>>>>>> pte))
>>>>>>>>>>>>>>>>> +                               goto split_large_folio;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +                       /*
>>>>>>>>>>>>>>>>> +                        * Avoid unnecessary folio splitting if the
>>>>>>>>>>>>>>>>> large
>>>>>>>>>>>>>>>>> +                        * folio is entirely within the given range.
>>>>>>>>>>>>>>>>> +                        */
>>>>>>>>>>>>>>>>> +                       folio_clear_dirty(folio);
>>>>>>>>>>>>>>>>> +                       folio_unlock(folio);
>>>>>>>>>>>>>>>>> +                       for (; addr != next_addr; pte++, addr +=
>>>>>>>>>>>>>>>>> PAGE_SIZE) {
>>>>>>>>>>>>>>>>> +                               ptent = ptep_get(pte);
>>>>>>>>>>>>>>>>> +                               if (pte_young(ptent) ||
>>>>>>>>>>>>>>>>> pte_dirty(ptent)) {
>>>>>>>>>>>>>>>>> +                                       ptent =
>>>>>>>>>>>>>>>>> ptep_get_and_clear_full(
>>>>>>>>>>>>>>>>> +                                               mm, addr, pte,
>>>>>>>>>>>>>>>>> tlb->fullmm);
>>>>>>>>>>>>>>>>> +                                       ptent = pte_mkold(ptent);
>>>>>>>>>>>>>>>>> +                                       ptent = pte_mkclean(ptent);
>>>>>>>>>>>>>>>>> +                                       set_pte_at(mm, addr, pte,
>>>>>>>>>>>>>>>>> ptent);
>>>>>>>>>>>>>>>>> +                                       tlb_remove_tlb_entry(tlb, pte,
>>>>>>>>>>>>>>>>> addr);
>>>>>>>>>>>>>>>>> +                               }
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Can we do this in batches? for a CONT-PTE mapped large folio, you are
>>>>>>>>>>>>>>>> unfolding
>>>>>>>>>>>>>>>> and folding again. It seems quite expensive.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'm not convinced we should be doing this in batches. We want the initial
>>>>>>>>>>>>> folio_pte_batch() to be as loose as possible regarding permissions so
>>>>>>>>>>>>> that we
>>>>>>>>>>>>> reduce our chances of splitting folios to the min. (e.g. ignore SW bits
>>>>>>>>>>>>> like
>>>>>>>>>>>>> soft dirty, etc). I think it might be possible that some PTEs are RO and
>>>>>>>>>>>>> other
>>>>>>>>>>>>> RW too (e.g. due to cow - although with the current cow impl, probably not.
>>>>>>>>>>>>> But
>>>>>>>>>>>>> its fragile to assume that). Anyway, if we do an initial batch that ignores
>>>>>>>>>>>>> all
>>>>>>>>>>>>
>>>>>>>>>>>> You are correct. I believe this scenario could indeed occur. For instance,
>>>>>>>>>>>> if process A forks process B and then unmaps itself, leaving B as the
>>>>>>>>>>>> sole process owning the large folio.  The current wp_page_reuse() function
>>>>>>>>>>>> will reuse PTE one by one while the specific subpage is written.
>>>>>>>>>>>
>>>>>>>>>>> Hmm - I thought it would only reuse if the total mapcount for the folio
>>>>>>>>>>> was 1.
>>>>>>>>>>> And since it is a large folio with each page mapped once in proc B, I thought
>>>>>>>>>>> every subpage write would cause a copy except the last one? I haven't
>>>>>>>>>>> looked at
>>>>>>>>>>> the code for a while. But I had it in my head that this is an area we need to
>>>>>>>>>>> improve for mTHP.
>>>>>>>
>>>>>>> So sad I am wrong again 😢
>>>>>>>
>>>>>>>>>>
>>>>>>>>>> wp_page_reuse() will currently reuse a PTE part of a large folio only if
>>>>>>>>>> a single PTE remains mapped (refcount == 0).
>>>>>>>>>
>>>>>>>>> ^ == 1
>>>>>>>
>>>>>>> seems this needs improvement. it is a waste the last subpage can
>>>>>>
>>>>>> My take that is WIP:
>>>>>>
>>>>>> https://lore.kernel.org/all/20231124132626.235350-1-david@redhat.com/T/#u
>>>>>>
>>>>>>> reuse the whole large folio. i was doing it in a quite different way,
>>>>>>> if the large folio had only one subpage left, i would do copy and
>>>>>>> released the large folio[1]. and if i could reuse the whole large folio
>>>>>>> with CONT-PTE, i would reuse the whole large folio[2]. in mainline,
>>>>>>> we don't have this cont-pte luxury exposed to mm, so i guess we can
>>>>>>> not do [2] easily, but [1] seems to be an optimization.
>>>>>>
>>>>>> Yeah, I had essentially the same idea: just free up the large folio if most of
>>>>>> the stuff is unmapped. But that's rather a corner-case optimization, so I did
>>>>>> not proceed with that.
>>>>>>
>>>>>
>>>>> I'm not sure it's a corner case, really? - process forks, then both parent and
>>>>> child and write to all pages in what was previously a fully & contiguously
>>>>> mapped large folio?
>>>>
>>>> Well, with 2 MiB my assumption was that while it can happen, it's rather
>>>> rare. With smaller THP it might get more likely, agreed.
>>>>
>>>>>
>>>>> Reggardless, why is it an optimization to do the copy for the last subpage and
>>>>> syncrhonously free the large folio? It's already partially mapped so is on the
>>>>> deferred split list and can be split if memory is tight.
>>>
>>> we don't want reclamation overhead later. and we want memories immediately
>>> available to others.
>>
>> But by that logic, you also don't want to leave the large folio partially mapped
>> all the way until the last subpage is CoWed. Surely you would want to reclaim it
>> when you reach partial map status?
> 
> To some extent, I agree. But then we will have two many copies. The last
> subpage is small, and a safe place to copy instead.

Right, it's essentially a simplistic page migration at a point where you 
know you can safely replace the page (PAE not set, so it cannot be 
pinned using FOLL_PIN). No rmap walk, no migration entries, no worry 
about additional page references.

-- 
Cheers,

David / dhildenb


