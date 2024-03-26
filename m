Return-Path: <linux-kernel+bounces-118589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8FF88BCF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F33529E155
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797428DCB;
	Tue, 26 Mar 2024 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3YzFoqC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202118E1F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443483; cv=none; b=hhnMR+wp1VBx+pu9aAPKMAXt76JoAI5kmKHOVmS/G+7vklhn9zB9buDpyP/Yl2ndmua6uPzqay11gBpnSISDyJD9FcK5M86qGnCYJw5v6Xo3l1pzPy4zRg2O3h0R2idzKpUh8Pi+glGcryNd+uN5QRWpy7/6211T0gGeTVcQXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443483; c=relaxed/simple;
	bh=Ix+UPcle/E/fMYgV+13iDftdD9mjhca2WVoZ4HkE0WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTdVgY5n8dCxKRZT8CtAnLKrU1LlPbkAD8STapvJjh8r9qkrte2c1jEFBLRifz2pHbJNCh8Tpmz1vIQnmWFAHtB3VBcdwNKewH0FslvPrgHVRaZSRQ0h9MQvg6l2ZEgnRT7nEtQrB3HtAbjF5SCcjSsn5JCriSzJ0jEs7bj48Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3YzFoqC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711443481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p+12NdtXjNmDCwUHcMM8w074mdhtnNuNl46WZXArv94=;
	b=N3YzFoqCt7xj1t6CrincDMPVJnC6uVRvq1PdL/aTn4ZvePbIpBCEsZE14XmMgk8oaxwpGw
	cdx30tfC+OYI0Xn8koFIGEdnXBeOp230bFylejYkZwJClojarNkg+a3XZJZYNS7IbJwkMh
	td6Si5IMxiphfdtr/SvzCG5Eze6gRDQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-Qf3wGip6M56RJQSlj0uZmw-1; Tue, 26 Mar 2024 04:57:58 -0400
X-MC-Unique: Qf3wGip6M56RJQSlj0uZmw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ed44854ddso2831961f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443477; x=1712048277;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+12NdtXjNmDCwUHcMM8w074mdhtnNuNl46WZXArv94=;
        b=ndNByRuIOheeIf3g1XL2TZ3wIZq6SasUY97ePZAW09pU/MMkygTR/rneaNeNSd0Z5W
         S3L9HjN3RLxPW9QtVCC0UHvPO9lIBe3nNRs6dh+sucVqjVWOdhj1WcfQHojmJXJCa2Zn
         NhGvYDNoqsXvhVnRSLgdBZZd+OtsholRmVCKrOyJcw2bYJK9eOVf+FWmdJNZidCXK7AJ
         cYnx1B/NkAD1is2tC6V1KtGFR0Zsp2NvQyjngSaOU+itxzamtZCtfctMfccxZGXl/zcK
         +hl+wp91d9W98m57SdPPdhDwK01FX3ZWSk6ZfG+haIYw1TDcCQq2v5nRmJOZho30Uc8v
         IOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNYQWh1qLxXk6cehyOu8cAg89u9KiPUus0LtcZiMr2LQTYEkLb7JAKwpJ/RfIeqqGUQf5BL/ex8EvdfMO+/OTU90kXGfAu7kHaod6d
X-Gm-Message-State: AOJu0Yyq7W00l1ffIwhwaMMzj+lOCht7yZGpQZZBpN8WeaSnkZQX75vt
	lQtCNBGZT9hDcyRnycrOPOQY3M7wKEarYTM77fcCzTdOsLMT7obXNP115N6n/tCn/mRIrLeFF2j
	PfkAalCfAZewLfl3sy1poupQfKjc0/6l1QKQdpAfBEyvkRM/6x/CiyB1MhfTVRA==
X-Received: by 2002:adf:ce01:0:b0:33e:7865:cf67 with SMTP id p1-20020adfce01000000b0033e7865cf67mr6285797wrn.55.1711443477406;
        Tue, 26 Mar 2024 01:57:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMyGSbClJ8MlXSnpVLJew0lUNg8xPVUJ//sXPvxKa6xCcUWcZyXTsmxXRds3wruL5JEf5Z/A==
X-Received: by 2002:adf:ce01:0:b0:33e:7865:cf67 with SMTP id p1-20020adfce01000000b0033e7865cf67mr6285789wrn.55.1711443476983;
        Tue, 26 Mar 2024 01:57:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id q2-20020adfcd82000000b0033e7603987dsm11635262wrj.12.2024.03.26.01.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 01:57:56 -0700 (PDT)
Message-ID: <2420ca24-b475-45ba-bab9-66c11b8cf484@redhat.com>
Date: Tue, 26 Mar 2024 09:57:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling in COW mappings
Content-Language: en-US
To: Ingo Molnar <mingo@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, Wupeng Ma <mawupeng1@huawei.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240312181118.318701-1-david@redhat.com>
 <ZfCrkL-Aieer2EAg@casper.infradead.org>
 <5bc9de2f-c3ba-46e7-a234-3d3a46e53ba1@redhat.com>
 <ZgKIVogEUEnUMgpF@gmail.com>
 <922c5f99-1194-4118-9fe2-09b4f4a8cf04@redhat.com>
 <ZgKNIezvm7tPVuYj@gmail.com>
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
In-Reply-To: <ZgKNIezvm7tPVuYj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> try the trivial restriction approach first, and only go with your original
>>> patch if that fails?
>>
>> Which version would you prefer, I had two alternatives (excluding comment
>> changes, white-space expected to be broken).
>>
>>
>> 1) Disallow when we would have set VM_PAT on is_cow_mapping()
>>
>> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
>> index 0d72183b5dd0..6979912b1a5d 100644
>> --- a/arch/x86/mm/pat/memtype.c
>> +++ b/arch/x86/mm/pat/memtype.c
>> @@ -994,6 +994,9 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>>                                  && size == (vma->vm_end - vma->vm_start))) {
>>                  int ret;
>> +               if (is_cow_mapping(vma->vm_flags))
>> +                       return -EINVAL;
>> +
>>                  ret = reserve_pfn_range(paddr, size, prot, 0);
>>                  if (ret == 0 && vma)
>>                          vm_flags_set(vma, VM_PAT);
>>
>>
>> 2) Fallback to !VM_PAT
>>
>> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
>> index 0d72183b5dd0..8e97156c9be8 100644
>> --- a/arch/x86/mm/pat/memtype.c
>> +++ b/arch/x86/mm/pat/memtype.c
>> @@ -990,8 +990,8 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>>          enum page_cache_mode pcm;
>>          /* reserve the whole chunk starting from paddr */
>> -       if (!vma || (addr == vma->vm_start
>> -                               && size == (vma->vm_end - vma->vm_start))) {
>> +       if (!vma || (!is_cow_mapping(vma->vm_flags) && addr == vma->vm_start &&
>> +                    size == (vma->vm_end - vma->vm_start))) {
>>                  int ret;
>>                  ret = reserve_pfn_range(paddr, size, prot, 0);
>>
>>
>>
>> Personally, I'd go for 2).
> 
> So what's the advantage of #2? This is clearly something the user didn't
> really intend or think about much. Isn't explicitly failing that mapping a
> better option than silently downgrading it to !VM_PAT?
> 
> (If I'm reading it right ...)

I think a simple mmap(MAP_PRIVATE) of /dev/mem will unconditionally fail 
with 1), while it keeps on working for 2).

Note that I think we currently set VM_PAT on each and every system if 
remap_pfn_range() will cover the whole VMA, even if pat is not actually 
enabled.

It's all a bit of a mess TBH, but I got my hands dirty enough on that.

So 1) can be rather destructive ... 2) at least somehow keeps it working.

For that reason I went with the current patch, because it's hard to tell 
which use case you will end up breaking ... :/

-- 
Cheers,

David / dhildenb


