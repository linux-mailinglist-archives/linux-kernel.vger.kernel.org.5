Return-Path: <linux-kernel+bounces-145499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7928A56F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F891F2296F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C125C7CF16;
	Mon, 15 Apr 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIOKpiZ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406847F490
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196955; cv=none; b=RiapgHj9or+8gkTsoLpeC9PI5QTpk7UVtRINul1mRR+zUXM1dqU5FxBcU/ByBC0NtT2j9xSm6WEUf59dvQsssIJZHZiltv3cMKM/6blhkSbJXXbo3PLiegYvEgrVdSySOhjbwm9c/A4qlQiS1uQjc9F6KEYstdJRjqA3HQc5SVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196955; c=relaxed/simple;
	bh=cl5WBWviIU0Mw1ZExh0tD+xzkFGkwSD45sUBOwUVm6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbME5w9nKiuOYYbFp7Si31vyFihsurT9c1wD8JwDml3z5M6RNzWzbHKM2Fjwd6ezDCCrhF4tns3sT6EOVgWp232i+gXTmOl9u9t3/i3LDaueI3GeiJ/UJO9JU8xBPU3z5s0miQy9Lh5tn0WGK/AKyNBCSS/3WoOLm12vtf4mQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIOKpiZ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713196952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zXE906H3fuZsmm3fetxI7aX0o0Q77mLxPPNeSWk0lQk=;
	b=ZIOKpiZ6Pxcr7SwHuuV30dMh3g3a0949xJjHZ+MTQP3Xp59fONrSiD6tL0Wiu1t0+z9hNE
	FDdwZ2T/q5rWR11G2l24ORgMZ53HiQ+O68UDYpbZ/qKVzWDP4wJxdsJf1iq28NTyClt+Bv
	SHp38tV8CKj5Hac1vhR9aeHF1X5ccWQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-yhBD91gIN6OG4WyRkfI05Q-1; Mon, 15 Apr 2024 12:02:30 -0400
X-MC-Unique: yhBD91gIN6OG4WyRkfI05Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343ee356227so2136407f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713196949; x=1713801749;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zXE906H3fuZsmm3fetxI7aX0o0Q77mLxPPNeSWk0lQk=;
        b=IZtlxGd/RQlt1Lv9irb1NkLGg/nlhdu3bpjSGPWTO8pCH27M3/Es9Ln9jPi3KML/Wo
         01KlzPiwizHOQIoqWej5g66X2hhp2I4PZRem5WWzDRDSd82wORSgIlj5KsYw23kca3rL
         FFFNEP/CirP0Pjd2JYYsEHIAxqbbDuaYr9bHH6W2iovYBF1ICYwbg49qdZPpFSFLDUuk
         WHmDphdDyDeFzQd8Qczt2Xa3fOnm07t6XymgX2vN7AlZ7jrzOnYbJYEaNJ/jtCtg9WHM
         uzW5z5QOVhh/4OqmBEOgZ+0PYHYMaCvSEWUUZU6Gr8XkdD0aY3CrLXgXRcBPlH82KLT8
         o18Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuDyQj9Wle+aNQ5cy1luyzZnEbe3Y5gHRKy/4b7hbiGhr+SKuaCXDuycdu/ec0c8/DRhUDciZyeA8kKqJlx+a8GBb4J9oXQ164kXxr
X-Gm-Message-State: AOJu0YxPwz2Tuw03g61VFijm65bLjSjvnKAVQiZyveWI3HgqdXwdqJGU
	ERxIB7lUi7TsPtE50DF1pS4cYenSh+m/pIwIrYV+VpR8TfocvdT4yuDRSHkyDahuwfcg6oA/Q8Y
	Kk1XC0YRi45uvOdrL/2C3Q7nltVUgldBCP838PKk4j/xmgsEWHFUpVvbQUr4CwMxr6Wa2gg==
X-Received: by 2002:a05:6000:bca:b0:345:edfd:9529 with SMTP id dm10-20020a0560000bca00b00345edfd9529mr5907463wrb.29.1713196948977;
        Mon, 15 Apr 2024 09:02:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeLpeqDIjR0x4VRGhylPjLUc6KpyZYO+kJPyDkXYnHbIVY3O7JoYuBWnxQEJ9czEWbc73X3A==
X-Received: by 2002:a05:6000:bca:b0:345:edfd:9529 with SMTP id dm10-20020a0560000bca00b00345edfd9529mr5907448wrb.29.1713196948496;
        Mon, 15 Apr 2024 09:02:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:d800:568a:6ea7:5272:797c? (p200300cbc706d800568a6ea75272797c.dip0.t-ipconnect.de. [2003:cb:c706:d800:568a:6ea7:5272:797c])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d4045000000b00346ceb9e060sm11638411wrp.103.2024.04.15.09.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 09:02:28 -0700 (PDT)
Message-ID: <abc3f45e-3bb9-44b8-ac87-c988e4de706c@redhat.com>
Date: Mon, 15 Apr 2024 18:02:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Reduce cost of ptep_get_lockless on arm64
To: Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
 <a41b0534-b841-42c2-8c06-41337c35347d@arm.com>
 <8bd9e136-8575-4c40-bae2-9b015d823916@redhat.com>
 <86680856-2532-495b-951a-ea7b2b93872f@arm.com>
 <35236bbf-3d9a-40e9-84b5-e10e10295c0c@redhat.com>
 <dbc5083b-bf8c-4869-8dc7-5fbf2c88cce8@arm.com>
 <f2aad459-e19c-45e2-a7ab-35383e8c3ba5@redhat.com>
 <4fba71aa-8a63-4a27-8eaf-92a69b2cff0d@arm.com>
 <5a23518b-7974-4b03-bd6e-80ecf6c39484@redhat.com>
 <81aa23ca-18b1-4430-9ad1-00a2c5af8fc2@arm.com>
 <70a36403-aefd-4311-b612-84e602465689@redhat.com>
 <f13d1e4d-1eea-4379-b683-4d736ad99c2c@arm.com>
 <3e50030d-2289-4470-a727-a293baa21618@redhat.com>
 <772de69a-27fa-4d39-a75d-54600d767ad1@arm.com>
 <969dc6c3-2764-4a35-9fa6-7596832fb2a3@redhat.com>
 <e0b34a1f-ef2e-484e-8d56-4901101dbdbf@arm.com>
 <11b1c25b-3e20-4acf-9be5-57b508266c5b@redhat.com>
 <89e04df9-6a2f-409c-ae7d-af1f91d0131e@arm.com>
 <ecd6e3e5-8617-42bd-bed4-3f97577934f9@redhat.com>
 <c880ba19-93ab-492b-a720-7272a1f8756d@arm.com>
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
In-Reply-To: <c880ba19-93ab-492b-a720-7272a1f8756d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> The potential problem I see with this is that the Arm ARM doesn't specify which
>>> PTE of a contpte block the HW stores a/d in. So the HW _could_ update them
>>> randomly and this could spuriously increase your check failure rate. In reality
>>> I believe most implementations will update the PTE for the address that caused
>>> the TLB to be populated. But in some cases, you could have eviction (due to
>>> pressure or explicit invalidation) followed by re-population due to faulting on
>>> a different page of the contpte block. In this case you would see this type of
>>> problem too.
>>>
>>> But ultimately, isn't this basically equivalent to ptep_get_lockless() returning
>>> potentially false-negatives for access and dirty? Just with a much higher chance
>>> of getting a false-negative. How is this helping?
>>
>> You are performing an atomic read like GUP-fast wants you to. So there are no
>> races to worry about like on other architectures: HW might *set* the dirty bit
>> concurrently, but that's just fine.
> 
> But you can still see false-negatives for access and dirty...

Yes.

> 
>>
>> The whole races you describe with concurrent folding/unfolding/ ... are irrelevant.
> 
> And I think I convinced myself that you will only see false-negatives with
> today's arm64 ptep_get(). But an order or magnitude fewer than with your
> proposal (assuming 16 ptes per contpte block, and the a/d bits are in one of those).
> 
>>
>> To me that sounds ... much simpler ;) But again, just something I've been
>> thinking about.
> 
> OK so this approach upgrades my "I'm fairly sure we never see false-positives"
> to "we definitely never see false-positives". But it certainly increases the
> quantity of false-negatives.

Yes.

> 
>>
>> The reuse of pte_get_lockless() outside GUP code might not have been the wisest
>> choice.
>>
> 
> If you want to go down the ptep_get_gup_fast() route, you've still got to be
> able to spec it, and I think it will land pretty close to my most recent stab at
> respec'ing ptep_get_lockless() a couple of replies up on this thread.
> 
> Where would your proposal leave the KVM use case? If you call it
> ptep_get_gup_fast() presumably you wouldn't want to use it for KVM? So it would
> be left with ptep_get()...

It's using GUP-fast.

> 
> Sorry this thread is getting so long. Just to summarise, I think there are
> currently 3 solutions on the table:
> 
>    - ptep_get_lockless() remains as is
>    - ptep_get_lockless() wraps ptep_get()
>    - ptep_get_lockless() wraps __ptep_get() (and gets a gup_fast rename)
> 
> Based on discussion so far, that's also the order of my preference.

(1) seems like the easiest thing to do.

> 
> Perhaps its useful to enumerate why we dislike the current ptep_get_lockless()?

Well, you sent that patch series with "that aims to reduce the cost and 
complexity of ptep_get_lockless() for arm64". (2) and (3) would achieve 
that. :)

-- 
Cheers,

David / dhildenb


