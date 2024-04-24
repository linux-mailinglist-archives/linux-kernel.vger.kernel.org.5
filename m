Return-Path: <linux-kernel+bounces-157710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B818B14F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D168284CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AAC156973;
	Wed, 24 Apr 2024 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cODVlp3v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62EA156966
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992161; cv=none; b=gjWw0xmiJfCGyk+0o8DO0Uoh2VltfiXbLwv0hsjo4Yb8wxhusA1ZMheV/vrVTo2wpBw9zu6dtcHt+55vkew4qz2R/Bz43tnWXDxsK50b8ZFNVm8aihFsV/1cGr7tQ9n4fmtS5AuBnkhhVhce095yz4Lh1RFElyaQ41Ptc5uz5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992161; c=relaxed/simple;
	bh=w5zEssd+Z/vjP/3OsMpVa7aIy7cenpP2ZfPBUPA93Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eyy0h8T7Lzej+SvAyu4zZJJeu9C/bcihDb1XagrHiw0Fam/E9kX5/PKnZV7H5WL0p0KNHikjUD2nqEmARxc8bfns02Uy9jdZR/AzPYGJtEohZz2SbYI88zPAfn2AAkap1pfaukn7MB3jL2PxBNW5zVAikYSJNF2pcE2JnefVkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cODVlp3v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713992158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pwf1N0pqao7hHUJlsTVeqzeGDUAlXHRYWippfBfxMg0=;
	b=cODVlp3vT0J2CqdqOIONh9MgsUhrEVnFEZNbtw39Tx9DpYXeBuwrPeJy1bSTYswrMlV2Ne
	7+h2F5VgMejlOs2vLH3tRQCExREuk/3fR+gytzgLpILlIqkkDEVl6hETDKl8bliBNL4IX4
	8qT5VlzAtK9i0PyurZwnByCtG/CvPPo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-nKM17sckNputeiY5rQG09g-1; Wed, 24 Apr 2024 16:55:57 -0400
X-MC-Unique: nKM17sckNputeiY5rQG09g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4183d08093bso1117085e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713992156; x=1714596956;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwf1N0pqao7hHUJlsTVeqzeGDUAlXHRYWippfBfxMg0=;
        b=PCYhGumZRyCzmLWNH1sS0+VEJ9ZTI3S+DyZ0G9ptoGV/eEndkygzsuRut124GD3RS4
         sBt58dKO++93Rn0co74R7TuRHXQRcQtDKsAlOaD9QfbUwHTkqFKTq1co8HWM697yNdm1
         mZ6F/woDMbf2vJmXP9io+3U2Fb1b24/t1RFIYwX+ZL70VvfW6Dizd2W8Xx2JAz5dVW09
         T0IPKpp6GKXB17BzLpyTTUpj1/zRnf4rzyv0qU/dhUOEVVsebnO8lw1app9g3nb1EwJB
         REwYfe41/kLPSne0VbGsj9tIMITWsWD6lRmyYv3Gzdy6jEUWvwbXe9FmxrRz5oYBjs6r
         IV+A==
X-Forwarded-Encrypted: i=1; AJvYcCW6jSXLVX0aPL+W1l+Xxr9MBfCnALgOU54ZF5jitNlqwwK8hAOpcgJhTvFecRpDJ8Xj0lGenwqeKqDjss3iEEok2D1MgoqsCFC2HPop
X-Gm-Message-State: AOJu0YwjWKSh9XzEk2z1l398rz/494rTUuLt8x7HJiUIR3KrK2e+AGOq
	oWu3D4KmrUepwYa6oYXYMdU+hDU8KfMXPGPS/f+L+8fqwTJUR6CkTgr7fcMD++whRxs/vOdjLiC
	+3/jAzbW+r0ia3rk688nrqFl6wBG/Dp2JY8OLp/xP5j8SO8EPjO+JRWL+IZzmEg==
X-Received: by 2002:a05:600c:190d:b0:418:fea2:ed94 with SMTP id j13-20020a05600c190d00b00418fea2ed94mr2750208wmq.23.1713992156338;
        Wed, 24 Apr 2024 13:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEozGXAqQGOfJt3u+VhzyJaF4t4KYaq0an+quDHunqz+3ck5Ll/n4JuxU/7P2GqC7u7V0lcbQ==
X-Received: by 2002:a05:600c:190d:b0:418:fea2:ed94 with SMTP id j13-20020a05600c190d00b00418fea2ed94mr2750193wmq.23.1713992155893;
        Wed, 24 Apr 2024 13:55:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id je12-20020a05600c1f8c00b004183edc31adsm28634639wmb.44.2024.04.24.13.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 13:55:55 -0700 (PDT)
Message-ID: <04137a08-8918-422c-8512-beb2074a427e@redhat.com>
Date: Wed, 24 Apr 2024 22:55:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
 linux-mm@kvack.org
References: <20240423232728.1492340-1-vdonnefort@google.com>
 <20240423232728.1492340-3-vdonnefort@google.com>
 <f972ce5a-0351-450c-98a2-38188eae5001@redhat.com>
 <ZilsIJYbJ-JN4elq@google.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZilsIJYbJ-JN4elq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.04.24 22:31, Vincent Donnefort wrote:
> Hi David,
> 
> Thanks for your quick response.
> 
> On Wed, Apr 24, 2024 at 05:26:39PM +0200, David Hildenbrand wrote:
>>
>> I gave it some more thought, and I think we are still missing something (I
>> wish PFNMAP/MIXEDMAP wouldn't be that hard).
>>
>>> +
>>> +/*
>>> + *   +--------------+  pgoff == 0
>>> + *   |   meta page  |
>>> + *   +--------------+  pgoff == 1
>>> + *   | subbuffer 0  |
>>> + *   |              |
>>> + *   +--------------+  pgoff == (1 + (1 << subbuf_order))
>>> + *   | subbuffer 1  |
>>> + *   |              |
>>> + *         ...
>>> + */
>>> +#ifdef CONFIG_MMU
>>> +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
>>> +			struct vm_area_struct *vma)
>>> +{
>>> +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
>>> +	unsigned int subbuf_pages, subbuf_order;
>>> +	struct page **pages;
>>> +	int p = 0, s = 0;
>>> +	int err;
>>> +
>>
>> I'd add some comments here like
>>
>> /* Refuse any MAP_PRIVATE or writable mappings. */
>>> +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
>>> +	    !(vma->vm_flags & VM_MAYSHARE))
>>> +		return -EPERM;
>>> +
>>
>> /*
>>   * Make sure the mapping cannot become writable later. Also, tell the VM
>>   * to not touch these pages pages (VM_DONTCOPY | VM_DONTDUMP) and tell
>>   * GUP to leave them alone as well (VM_IO).
>>   */
>>> +	vm_flags_mod(vma,
>>> +		     VM_MIXEDMAP | VM_PFNMAP |
>>> +		     VM_DONTCOPY | VM_DONTDUMP | VM_DONTEXPAND | VM_IO,
>>> +		     VM_MAYWRITE);
>>
>> I am still really unsure about VM_PFNMAP ... it's not a PFNMAP at all and,
>> as stated, vm_insert_pages() even complains quite a lot when it would have
>> to set VM_MIXEDMAP and VM_PFNMAP is already set, likely for a very good
>> reason.
>>
>> Can't we limit ourselves to VM_IO?
>>
>> But then, I wonder if it really helps much regarding GUP: yes, it blocks
>> ordinary GUP (see check_vma_flags()) but as insert_page_into_pte_locked()
>> does *not* set pte_special(), GUP-fast (gup_fast_pte_range()) will not
>> reject it.
>>
>> Really, if you want GUP-fast to reject it, remap_pfn_range() and friends are
>> the way to go, that will set pte_special() such that also GUP-fast will
>> leave it alone, just like vm_normal_page() would.
>>
>> So ... I know Linus recommended VM_PFNMAP/VM_IO to stop GUP, but it alone
>> won't stop all of GUP. We really have to mark the PTE as special, which
>> vm_insert_page() must not do (because it is refcounted!).
> 
> Hum, apologies, I am not sure to follow the connection here. Why do you think
> the recommendation was to prevent GUP?

Ah, I'm hallucinating! :) "not let people play games with the mapping" to me
implied "make sure nobody touches it". If GUP is acceptable that makes stuff
a lot easier. VM_IO will block some GUP, but not all of it.

> 
>>
>> Which means: do we really have to stop GUP from grabbing that page?
>>
>> Using vm_insert_page() only with VM_MIXEDMAP (and without VM_PFNMAP|VM_IO)
>> would be better.
> 
> Under the assumption we do not want to stop all GUP, why not using VM_IO over
> VM_MIXEDMAP which is I believe more restrictive?

VM_MIXEDMAP will be implicitly set by vm_insert_page(). There is a lengthy comment
for vm_normal_page() that explains all this madness. VM_MIXEDMAP is primarily
relevant for COW mappings, which you just forbid completely.

remap_pfn_range_notrack() documents the semantics of some of the other flags:

	 *   VM_IO tells people not to look at these pages
	 *	(accesses can have side effects).
	 *   VM_PFNMAP tells the core MM that the base pages are just
	 *	raw PFN mappings, and do not have a "struct page" associated
	 *	with them.
	 *   VM_DONTEXPAND
	 *      Disable vma merging and expanding with mremap().
	 *   VM_DONTDUMP
	 *      Omit vma from core dump, even when VM_IO turned off.

VM_PFNMAP is very likely really not what we want, unless we really perform raw
PFN mappings ... VM_IO we can set without doing much harm.

So I would suggest dropping VM_PFNMAP when using vm_insert_pages(), using only VM_IO
and likely just letting vm_insert_pages() set VM_MIXEDMAP for you.

[...]

>>
>> vm_insert_pages() documents: "In case of error, we may have mapped a subset
>> of the provided pages. It is the caller's responsibility to account for this
>> case."
>>
>> Which could for example happen, when allocating a page table fails.
>>
>> Would we able to deal with that here?
> 
> As we are in the mmap path, on an error, I would expect the vma to be destroyed
> and those pages whom insertion succeeded to be unmapped?
> 

Ah, we simply fail ->mmap().

In mmap_region(), if call_mmap() failed, we "goto unmap_and_free_vma" where we have

/* Undo any partial mapping done by a device driver. */
unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start, vma->vm_end, vma->vm_end, true);


> But perhaps shall we proactively zap_page_range_single()?

No mmap_region() should indeed be handling it correctly already!

-- 
Cheers,

David / dhildenb


