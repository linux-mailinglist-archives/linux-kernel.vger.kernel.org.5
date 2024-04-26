Return-Path: <linux-kernel+bounces-159624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EEB8B313A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C85F282D26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A907E13BC26;
	Fri, 26 Apr 2024 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVc7mFz6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5CA13BAE9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115961; cv=none; b=Ux5+Vhnfxk9Mv47jNAVCa0w2pKaNGpbTpyGPwll0Eh3/Q6EA4xOHytgjdtBegIQuSE1g7MTaI4pv8SG+8Nxh4yQbJKLAqVnhyTnKNltKNxrMy94qYasYlUubEJLlcxRPyzCVfJPvrFXGRPDBQ8Y+dhOVS6ixRKhMQt858s4YGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115961; c=relaxed/simple;
	bh=kIjY7hC6gXdgsns5ngMGCPVw08yU9SbKFBz0fNFADQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEwsKhlJ5aNzUEvAyUt3UreH4RUpYCqwLt+LIrdNjShog0w0Nj+0AwNKx7+buZxXGojcmd3h7CVfFf2C0pXz4oYqDlkdV4+lrgfyrXOSiamgp2iuWkEYbayTFReVZHMfYFvXwaulR9lccm1jIGU+WTYe5eeUGSfsK57/sW0BTWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVc7mFz6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714115958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bl8MntV5VcxHO9VKG8Q88/xgI2XsqnYUyfS3p7aHw8k=;
	b=TVc7mFz6VtgiTC+mAFxaOXygNoOxAiwcN9AWR2byHRdAG91NLG6uu4jr9dzzaPUuh+HPoi
	6+N1tWU5brCq4eyXHTRw21QkyJvpWKS4iBDKNAECRh3cWjde86UjUTiEmwVBjN6x1SK+Rm
	mDQ0r3haA9l/VFuYPmUUuv80ehPqQq0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-14pDRWnLNEGo0yy5BpYOYw-1; Fri, 26 Apr 2024 03:19:16 -0400
X-MC-Unique: 14pDRWnLNEGo0yy5BpYOYw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343e46df264so1194192f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115956; x=1714720756;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bl8MntV5VcxHO9VKG8Q88/xgI2XsqnYUyfS3p7aHw8k=;
        b=pXCRH46OTQK14DoQceGzWfEyBhUdxUSmn+RIbkO7yKisqTVRw1kbjhmyPQtpwAz8FE
         ThKsVJTWhkJLs/Gh8jyjF17UW+ksy4FRaFBcMHmAw0ZN/C2UrHS31JjBDEkEJ4vSO4Zy
         8ZZqsLo2hcqLasMEVmX7AuuYhI8zhe1fCqSOvAR3BNHgD+xwXGPtoRxnc3h0XJhfucuK
         j5QDgjpNofmj4ZTDaOXIh2yKfZj2ReN3X70PjyOOUwBZoe3Lau56ZY51pf3mD6CC7DpK
         PiGZ1t4yyjpZkBt/7VNQbrK7Yg1XcV4grCn+pAYVtpbmd8IBecsiuY70eZJHDjtkTE1T
         wysw==
X-Forwarded-Encrypted: i=1; AJvYcCU7wOAU6jcs6Fsox3RaVhvleN2iBOStk7wdIqh7fM0Y/tUlOo90kPEx/AhGIBnqbyd/yRoN8BznzeuNkzDIZ+uKV4lZHxG2PqMxUvMi
X-Gm-Message-State: AOJu0YwVO/X+hq/a1KbG/a9jCPIi6eUyYJ+wswfxLU6tenCvSN+lFvVa
	MfQ8gTeplayclU3Ov+UmxurdX9pUs2dcBPFrQQVMs8l2+whu2h/baEx40q5PB8tdSKYSG95AOPL
	A2+lxuljWfzr100PDdEwhvzB+8GCCv+IxM4p5LgknEUWbRmA0fhPNg0xyCcBFQA==
X-Received: by 2002:a5d:4386:0:b0:34b:8bf:6019 with SMTP id i6-20020a5d4386000000b0034b08bf6019mr1063508wrq.70.1714115955683;
        Fri, 26 Apr 2024 00:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmNarM/+lgHFG/LmjDwFSKC75Bu61cm+rPNgANlY0Fxvb2qyQPAYPuYu24sPzMbxDgDJ9OcQ==
X-Received: by 2002:a5d:4386:0:b0:34b:8bf:6019 with SMTP id i6-20020a5d4386000000b0034b08bf6019mr1063486wrq.70.1714115955168;
        Fri, 26 Apr 2024 00:19:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6100:20f2:6848:5b74:ca82? (p200300cbc726610020f268485b74ca82.dip0.t-ipconnect.de. [2003:cb:c726:6100:20f2:6848:5b74:ca82])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d4604000000b00343826878e8sm21609461wrq.38.2024.04.26.00.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 00:19:14 -0700 (PDT)
Message-ID: <385d3516-95bb-4ff9-9d60-ac4e46104130@redhat.com>
Date: Fri, 26 Apr 2024 09:19:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
To: Guillaume Morin <guillaume@morinfr.org>
Cc: oleg@redhat.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, muchun.song@linux.dev
References: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
 <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>
 <ZiaoZlGc_8ZV3736@bender.morinfr.org>
 <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
 <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>
 <Zirw0uINbP6GxFiK@bender.morinfr.org>
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
In-Reply-To: <Zirw0uINbP6GxFiK@bender.morinfr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.04.24 02:09, Guillaume Morin wrote:
> On 25 Apr 21:56, David Hildenbrand wrote:
>>
>> On 25.04.24 17:19, Guillaume Morin wrote:
>>> On 24 Apr 23:00, David Hildenbrand wrote:
>>>>> One issue here is that FOLL_FORCE|FOLL_WRITE is not implemented for
>>>>> hugetlb mappings. However this was also on my TODO and I have a draft
>>>>> patch that implements it.
>>>>
>>>> Yes, I documented it back then and added sanity checks in GUP code to fence
>>>> it off. Shouldn't be too hard to implement (famous last words) and would be
>>>> the cleaner thing to use here once I manage to switch over to
>>>> FOLL_WRITE|FOLL_FORCE to break COW.
>>>
>>> Yes, my patch seems to be working. The hugetlb code is pretty simple.
>>> And it allows ptrace and the proc pid mem file to work on the executable
>>> private hugetlb mappings.
>>>
>>> There is one thing I am unclear about though. hugetlb enforces that
>>> huge_pte_write() is true on FOLL_WRITE in both the fault and
>>> follow_page_mask paths. I am not sure if we can simply assume in the
>>> hugetlb code that if the pte is not writable and this is a write fault
>>> then we're in the FOLL_FORCE|FOLL_WRITE case.  Or do we want to keep the
>>> checks simply not enforce it for FOLL_FORCE|FOLL_WRITE?
>>>
>>> The latter is more complicated in the fault path because there is no
>>> FAULT_FLAG_FORCE flag.
>>>
>>
>> I just pushed something to
>> 	https://github.com/davidhildenbrand/linux/tree/uprobes_cow
>>
>> Only very lightly tested so far. Expect the worst :)
> 
> 
> I'll try it out and send you the hugetlb bits
> 
>>
>> I still detest having the zapping logic there, but to get it all right I
>> don't see a clean way around that.
>>
>>
>> For hugetlb, we'd primarily have to implement the
>> mm_walk_ops->hugetlb_entry() callback (well, and FOLL_FORCE).
> 
> For FOLL_FORCE, heer is my draft. Let me know if this is what you had in
> mind.
> 
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 1611e73b1121..ac60e0ae64e8 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1056,9 +1056,6 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>   		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
>   			if (!(gup_flags & FOLL_FORCE))
>   				return -EFAULT;
> -			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
> -			if (is_vm_hugetlb_page(vma))
> -				return -EFAULT;
>   			/*
>   			 * We used to let the write,force case do COW in a
>   			 * VM_MAYWRITE VM_SHARED !VM_WRITE vma, so ptrace could
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3548eae42cf9..73f86eddf888 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5941,7 +5941,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   		       struct folio *pagecache_folio, spinlock_t *ptl,
>   		       struct vm_fault *vmf)
>   {
> -	const bool unshare = flags & FAULT_FLAG_UNSHARE;
> +	const bool make_writable = !(flags & FAULT_FLAG_UNSHARE) &&
> +		(vma->vm_flags & VM_WRITE);
>   	pte_t pte = huge_ptep_get(ptep);
>   	struct hstate *h = hstate_vma(vma);
>   	struct folio *old_folio;
> @@ -5959,16 +5960,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   	 * can trigger this, because hugetlb_fault() will always resolve
>   	 * uffd-wp bit first.
>   	 */
> -	if (!unshare && huge_pte_uffd_wp(pte))
> +	if (make_writable && huge_pte_uffd_wp(pte))
>   		return 0;
>   
> -	/*
> -	 * hugetlb does not support FOLL_FORCE-style write faults that keep the
> -	 * PTE mapped R/O such as maybe_mkwrite() would do.
> -	 */
> -	if (WARN_ON_ONCE(!unshare && !(vma->vm_flags & VM_WRITE)))
> -		return VM_FAULT_SIGSEGV;
> -
>   	/* Let's take out MAP_SHARED mappings first. */
>   	if (vma->vm_flags & VM_MAYSHARE) {
>   		set_huge_ptep_writable(vma, haddr, ptep);
> @@ -5989,7 +5983,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   			folio_move_anon_rmap(old_folio, vma);
>   			SetPageAnonExclusive(&old_folio->page);
>   		}
> -		if (likely(!unshare))
> +		if (likely(make_writable))
>   			set_huge_ptep_writable(vma, haddr, ptep);

Maybe we want to refactor that similarly into a 
set_huge_ptep_maybe_writable, and handle the VM_WRITE check internally.

Then, here you'd do

if (unshare)
	set_huge_ptep(vma, haddr, ptep);
else
	set_huge_ptep_maybe_writable(vma, haddr, ptep);

Something like that.



>   		/* Break COW or unshare */
>   		huge_ptep_clear_flush(vma, haddr, ptep);
> @@ -6883,6 +6878,17 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>   }
>   #endif /* CONFIG_USERFAULTFD */
>   
> +static bool is_force_follow(struct vm_area_struct* vma, unsigned int flags,
> +			     struct page* page) {
> +	if (vma->vm_flags & VM_WRITE)
> +		return false;
> +
> +	if (!(flags & FOLL_FORCE))
> +		return false;
> +
> +	return page && PageAnon(page) && page_mapcount(page) == 1;
> +}

A couple of points:

a) Don't use page_mapcount(). Either folio_mapcount(), but likely you 
want to check PageAnonExclusive.

b) If you're not following the can_follow_write_pte/_pmd model, you are 
doing something wrong :)

c) The code was heavily changed in mm/mm-unstable. It was merged with t
the common code.

Likely, in mm/mm-unstable, the existing can_follow_write_pte and 
can_follow_write_pmd checks will already cover what you want in most cases.

We'd need a can_follow_write_pud() to cover follow_huge_pud() and 
(unfortunately) something to handle follow_hugepd() as well similarly.

Copy-pasting what we do in can_follow_write_pte() and adjusting for 
different PTE types is the right thing to do. Maybe now it's time to 
factor out the common checks into a separate helper.


-- 
Cheers,

David / dhildenb


