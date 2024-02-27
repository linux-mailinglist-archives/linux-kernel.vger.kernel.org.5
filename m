Return-Path: <linux-kernel+bounces-83274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A66869126
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE19A1C2650B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C2113AA3D;
	Tue, 27 Feb 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeaBKt0P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B01E867
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038817; cv=none; b=CF+Ld5P4/aMdcAwqPOJQaDVr8+JaqUlxU9UV2ZYaK7hTCobGvURIS32n0gODyv4XQ8UfnZnXBzS3quhtInymkX9GCjCYHWoqNkPVv0JiIcFMhay6Fiiw48SoJ/JLifVGop8Eufd99NrhQfmWDZN94INeWzC3bkVFiOWgJw1ADIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038817; c=relaxed/simple;
	bh=VBG8q8iW0Pvm16P42fAasKh4m9oLvFUPg7LCZ/HicyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xx8V0xxGXRAwmTd2gG24TWcQ0DIbK5NervlUHEgHmxm+kapQaowGO8A8RNDQkEQmQCeJ2/WrfLhxiE5c27HlX4yuCUG/LQ6UatP6QLgKnR8sqU/pToUPwtHkgRCVPXdn6Y/2fi6j2pukoAdQSo3P3+82+5hZ0Dfzo+UI/0O0Y/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WeaBKt0P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709038814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iMwfPPLdrx4N3kQs7S1S0DcNWq/R0Yyib4SvmPmFOnM=;
	b=WeaBKt0PZfwbEdl3B39CoYGKUzoMF9cAiQy/zCXry3uUgfXEJQfTlUaqOdAi5ltOfNOGjG
	3FsZOnpTGmVFBwNV4CeJ+9a/5JpAUIeeagmNTzUy2cr1kSsVu1WPbXgKjVl7uCi7z+1QvA
	1sKji6S3yvq1Xgk3wHyPUJ/4qNk1D+o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-E6jKQgzZO6mpaT2BjkxsvQ-1; Tue, 27 Feb 2024 08:00:13 -0500
X-MC-Unique: E6jKQgzZO6mpaT2BjkxsvQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d7fcb70c2so1730783f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038812; x=1709643612;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMwfPPLdrx4N3kQs7S1S0DcNWq/R0Yyib4SvmPmFOnM=;
        b=jaZ1jRPnQybKLAX23CBLWvw5SAMJkSKAM+/nTtckcrGkuT1cYlgL7LfPEV6JSssGcp
         +qLvtsMJP662hbO0okxxK9M1lbzamjo+OFpvk6ttWp4pN0KKzKa9Asd7kdi2DzZjs72d
         VGCcHkMoNZ2hUaSWzZ7Ih7UubpO5ldWz9lPAvUYev+y1l+ltIN/Gzsul5e00pxbMovtj
         DhT0FY/Hz9ggYnkagMBqfrfhhYeXHOg21ydZgmCB2FT6N99m7iy5HCxKvAwAoA0w4yNG
         HV1N1HM3NZRUxRuPTMKF0QthXYNRA4ytis3C0xOUBSX8HL6Z9t7EqG2P9yBMxvJL5dEI
         mHeg==
X-Forwarded-Encrypted: i=1; AJvYcCX/CxM3pGXgUfzowXhnYu55dpoZqT8Hy5/GqPGC9ThqJCIifAIsGKeo+ngqMoXxhF63xFrgtiWAzi6ESGl5SGFdZAO/FAklpyTRmB0O
X-Gm-Message-State: AOJu0YzfBPnvV1YNX+49lWIoc8p9qw5oROwBZQZ0eBOnIlN5a5Pp33uM
	+bW9f+6DSRj5AvEeLWJMuGibdLojmN6F6ANbM9UO6ZL3hXF4FEHUPQOcnmdTke1wjsByNfXqLxr
	c2TbBs9/wAZJSZM/d59CmyhDeADUopu9IFruo61wmNjYDGqzf3PBgGjazcqGvtA==
X-Received: by 2002:a05:600c:3548:b0:412:a397:c8f2 with SMTP id i8-20020a05600c354800b00412a397c8f2mr5925195wmq.17.1709038811649;
        Tue, 27 Feb 2024 05:00:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwYxIlgbIGRRAV5yDZdlzFFEspCJkeYpp3vFsIoZ3Po7kBGUxqVZ1oQwjt1DL1tP+IBEWvDQ==
X-Received: by 2002:a05:600c:3548:b0:412:a397:c8f2 with SMTP id i8-20020a05600c354800b00412a397c8f2mr5925166wmq.17.1709038811181;
        Tue, 27 Feb 2024 05:00:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9? (p200300cbc70776005c185a7dc5b7e7a9.dip0.t-ipconnect.de. [2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c225400b00410df4bf22esm15060125wmm.38.2024.02.27.05.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 05:00:10 -0800 (PST)
Message-ID: <a74c8b96-3fc5-44ff-949c-6e5c5e05e122@redhat.com>
Date: Tue, 27 Feb 2024 14:00:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] CoW on VM_PFNMAP vma during write fault
Content-Language: en-US
To: Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org,
 khlebnikov@openvz.org, jaredeh@gmail.com, linmiaohe@huawei.com, hpa@zytor.com
Cc: dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
 peterz@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 mingo@redhat.com, rdunlap@infradead.org, bhelgaas@google.com,
 linux-mm@kvack.org
References: <20240227122814.3781907-1-mawupeng1@huawei.com>
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
In-Reply-To: <20240227122814.3781907-1-mawupeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.02.24 13:28, Wupeng Ma wrote:
> We find that a warn will be produced during our test, the detail log is
> shown in the end.
> 
> The core problem of this warn is that the first pfn of this pfnmap vma is
> cleared during memory-failure. Digging into the source we find that this
> problem can be triggered as following:
> 
> // mmap with MAP_PRIVATE and specific fd which hook mmap
> mmap(MAP_PRIVATE, fd)
>    __mmap_region
>      remap_pfn_range
>      // set vma with pfnmap and the prot of pte is read only
> 	

Okay, so we get a MAP_PRIVATE VM_PFNMAP I assume.

What fd is that exactly? Often, we disallow private mappings in the 
mmap() callback (for a good reason).

> // memset this memory with trigger fault
> handle_mm_fault
>    __handle_mm_fault
>      handle_pte_fault
>        // write fault and !pte_write(entry)
>        do_wp_page
>          wp_page_copy // this will alloc a new page with valid page struct
>                       // for this pfnmap vma

Here we replace the mapped PFNMAP thingy by a proper anon folio.

> 
> // inject a hwpoison to the first page of this vma

I assume this is an anon folio?

> madvise_inject_error
>    memory_failure
>      hwpoison_user_mappings
>        try_to_unmap_one
>          // mark this pte as invalid (hwpoison)
>          mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
>                  address, range.end);
> 
> // during unmap vma, the first pfn of this pfnmap vma is invalid
> vm_mmap_pgoff
>    do_mmap
>      __do_mmap_mm
>        __mmap_region
>          __do_munmap
>            unmap_region
>              unmap_vmas
>                unmap_single_vma
>                  untrack_pfn
>                    follow_phys // pte is already invalidate, WARN_ON here

unmap_single_vma()->...->zap_pte_range() should do the right thing when 
calling vm_normal_page().

untrack_pfn() is the problematic part.

> 
> CoW with a valid page for pfnmap vma is weird to us. Can we use
> remap_pfn_range for private vma(read only)? Once CoW happens on a pfnmap
> vma during write fault, this page is normal(page flag is valid) for most mm
> subsystems, such as memory failure in thais case and extra should be done to
> handle this special page.
> 
> During unmap, if this vma is pfnmap, unmap shouldn't be done since page
> should not be touched for pfnmap vma.
> 
> But the root problem is that can we insert a valid page for pfnmap vma?
> 
> Any thoughts to solve this warn?

vm_normal_page() documentation explains how that magic is supposed to 
work. vm_normal_page() should be able to correctly identify whether we 
want to look at the struct page for an anon folio that was COWed.


untrack_pfn() indeed does not seem to be well prepared for handling 
MAP_PRIVATE mappings where we end up having anon folios.

I think it will already *completely mess up* simply when unmapping the 
range without the memory failure involved.

See, follow_phys() would get the PFN of the anon folio and then 
untrack_pfn() would do some nonesense with that. Completely broken.

The WARN is just a side-effect of the brokenness.

In follow_phys(), we'd likely have to call vm_normal_page(). If we get a 
page back, we'd likely have to fail follow_phys() instead of returning a 
PFN of an anon folio.

Now, how do we fix untrack_pfn() ? I really don't know. In theory, we 
might no longer have *any* PFNMAP PFN in there after COW'ing everything.

Sounds like MAP_PRIVATE VM_PFNMAP + __HAVE_PFNMAP_TRACKING is some 
broken garbage (sorry). Can we disallow it?

-- 
Cheers,

David / dhildenb


