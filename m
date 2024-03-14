Return-Path: <linux-kernel+bounces-103585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F5087C171
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928451F21A03
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926F67352C;
	Thu, 14 Mar 2024 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlFySStF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE271E480
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434547; cv=none; b=OP3SR+oNaMaQCDr5xt5wIa7qpUJqyFOGyMTkwafhU9f3pZHVyIEw9G258DXFCTJ+b/rPKtjN/rBwnotW2wsddzxCfKpBktTI9w/uHN/fzPlz26lga6oNP2bZt5T7qGwm4DtNhS8ZJgUL5rotFs9LsB/J2oL6xfWqUmcvppiFumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434547; c=relaxed/simple;
	bh=YKzRMgIfzlyfRzInzCXhlKp56/llBAiBK342zYGkXkg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BTjzaMUcAcOdCiJ66T4JPcYwnfTF98sgppXbwsb+M35ok8VbQW5r2zSymJ8S30Y7bW9FVhs+D2DLiDLVuMSvGg4wJ0G5YMNiyLeCeooIWb1mHyJ4XBD+IOD/QxWxkHCAuT13W1eSKnMExP+99h3JsEKGJzlZXNrQl9HBdO3R8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlFySStF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710434545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sixi7qBIO0KgmAD6JY5YHs0YPFdGVi8xhVX/DMw9B9s=;
	b=XlFySStFYQEzzS0ROVLska/NLMhqeO+LeVoCP52JuYaWKT8M1GdRzQBRu85f3K5qHmJQIm
	6H2eh4h/N+0GqqNNzl+10zeYodkamR7fLuzmbgT6NJFekyDSfisfFdgYfWY71eR3Ks6cCM
	A+JnQK7u+CnqvJFeCZL6RMbinH1xSLM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-GqB_DhSSMPun3p9cDXA8Mg-1; Thu, 14 Mar 2024 12:42:23 -0400
X-MC-Unique: GqB_DhSSMPun3p9cDXA8Mg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4130b4b6676so5918135e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710434542; x=1711039342;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sixi7qBIO0KgmAD6JY5YHs0YPFdGVi8xhVX/DMw9B9s=;
        b=om/Krjf8sCKf9SIrQ/5f+at67rTdsldgN3xy4uYZf1s2eTclvU6OJljHKH+3ws/3R1
         0HIdvSfNIZv/zeas4uVzxsYoqAZgHcDZNI8HUNFDJXnaaor8W0qYEH2NNIn5YhOK2TtR
         YW6+QlBXgmeqi+dXSl+Wl0uBNl8E2RQ9HYYcQuctqohImU0674L3IyjmNEIZ5f/8ZKmG
         Do/fdXW9ilyB2gWr7ilTw29O6P0QMiVu5Rid9jO21jExMjz0kLBhSX/QQ6riZPICqO97
         N3pV/rOnF34mKbvaUDHkT91ODB9p0R1WsI19ioFulCXKPWmEEFoahyiGm/exEAWzTQ4V
         nl4A==
X-Gm-Message-State: AOJu0Yy18NXMvs0pnZVnzcARLVWLMSyQzmzRgXdWHrPfygvX6tSC1qjM
	rFPhIXCv6HhFppNikZDj/crQIGRCwU0wWWxfFjxKXx19cOcNxN+CXhg1TLrBluqDJrwIU27NTBp
	aS9XlT843O8sNbeWheJvq0moCtYuJV3914DzztRL8UkhLOAHRr+eKvLvRLZpvJQ==
X-Received: by 2002:a05:600c:1e0f:b0:413:f034:da6d with SMTP id ay15-20020a05600c1e0f00b00413f034da6dmr1973204wmb.33.1710434542152;
        Thu, 14 Mar 2024 09:42:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8h8Emg/Cpc1mQHtB+StYkxSmE284u93z+Kc7ACJqNEFqtWRWUp+0VCCHzVTIRDza+C44qzg==
X-Received: by 2002:a05:600c:1e0f:b0:413:f034:da6d with SMTP id ay15-20020a05600c1e0f00b00413f034da6dmr1973187wmb.33.1710434541715;
        Thu, 14 Mar 2024 09:42:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:a00:7d7d:3665:5fe4:7127? (p200300cbc7090a007d7d36655fe47127.dip0.t-ipconnect.de. [2003:cb:c709:a00:7d7d:3665:5fe4:7127])
        by smtp.gmail.com with ESMTPSA id bi17-20020a05600c3d9100b00413f50e944fsm1814148wmb.45.2024.03.14.09.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 09:42:21 -0700 (PDT)
Message-ID: <1f2a8ed4-aaff-4be7-b3b6-63d2841a2908@redhat.com>
Date: Thu, 14 Mar 2024 17:42:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling in COW mappings
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 Wupeng Ma <mawupeng1@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240312181118.318701-1-david@redhat.com>
 <ZfCrkL-Aieer2EAg@casper.infradead.org>
 <5bc9de2f-c3ba-46e7-a234-3d3a46e53ba1@redhat.com>
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
In-Reply-To: <5bc9de2f-c3ba-46e7-a234-3d3a46e53ba1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.03.24 20:38, David Hildenbrand wrote:
> On 12.03.24 20:22, Matthew Wilcox wrote:
>> On Tue, Mar 12, 2024 at 07:11:18PM +0100, David Hildenbrand wrote:
>>> PAT handling won't do the right thing in COW mappings: the first PTE
>>> (or, in fact, all PTEs) can be replaced during write faults to point at
>>> anon folios. Reliably recovering the correct PFN and cachemode using
>>> follow_phys() from PTEs will not work in COW mappings.
>>
>> I guess the first question is: Why do we want to support COW mappings
>> of VM_PAT areas?  What breaks if we just disallow it?
> 
> Well, that was my first approach. Then I decided to be less radical (IOW
> make my life easier by breaking less user space) and "fix it" with
> minimal effort.
> 
> Chances of breaking some weird user space is possible, although I
> believe for most such mappings MAP_PRIVATE doesn't make too much sense
> sense.
> 
> Nasty COW support for VM_PFNMAP mappings dates back forever. So does PAT
> support.
> 
> I can try finding digging through some possible user space users tomorrow.

As discussed, MAP_PRIVATE doesn't make too much sense for most PFNMAP 
mappings.

However, /dev/mem and /proc/vmcore are still used with MAP_PRIVATE in 
some cases.

Side note: /proc/vmcore is a bit weird: mmap_vmcore() sets VM_MIXEDMAP, 
and then we might call remap_pfn_range(), which sets VM_PFNMAP. I'm not 
so sure if that's what we want to happen ...

As far as I can see, makedumpfile always mmap's memory to be dumped 
(/dev/mem, /proc/vmcore) using PROT_READ+MAP_PRIVATE, resulting in a COW 
mapping.


In my opinion, we should use this fairly simple fix to keep it working 
for now and look into disabling any MAP_PRIVATE of VM_PFNMAP separately, 
for all architectures.

But I'll leave the decision to x86 maintainers.

-- 
Cheers,

David / dhildenb


