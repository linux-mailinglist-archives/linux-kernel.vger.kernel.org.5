Return-Path: <linux-kernel+bounces-83300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028E9869186
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCDF1C24D29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F3613B295;
	Tue, 27 Feb 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGGGVaDR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F054FA5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039759; cv=none; b=YMv+6Zx9wa1FujAQn17xBNVzOJaMnSGq1uhmou9oZHQed911C9eLWxZq68fVlAah7p0StC+8UUMiBhSx5vLNM+crdGMS3xaABMp1rOqmTQNJ2VImRozy+pH3pNU9ibdbBZRsfWj2ro6aYUjILQmQ7gs5Owhr97JeFf5+FulbCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039759; c=relaxed/simple;
	bh=rCIU0Zj7PXbmREBLucDBH0OTYNzq901f8bhyFpF7D74=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sz+/HAH7anCI5yml4OHNJMnHhiXUB9OUurYgrflliLIinB4ecC1TPQKAuCu/3gZCO9ii5I0IlzxaDsnUr0D8tOib1RvkH7vno3WMPFaScIACqVOCOT3ufOZKNrsesLK9ARy9rWZ0bGbjMHBHuzln8Fccy4/VcfMtj3INWkTUCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGGGVaDR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709039756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tJVCdXMjUEnkLyKhEaXEMubhEfpRJE8p7wNvsup3Hd8=;
	b=cGGGVaDRSiIT8YRD4IMxQY5DVjCxGUICXzXGB6I1mb2lDJ7WupHtPq6xn5XaEF2XNbWh5b
	vBaWQ9flG6mHPgfy4FOH8eGb22USkx375/PlSI42/cBgtRmfMvXAOaDxWPPrJWY8Lnpwdw
	GDTC+hXbxeIwCMZavlN3VlES6/PakkE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-c0XQqDFsNFCaSdCTOar9uA-1; Tue, 27 Feb 2024 08:15:55 -0500
X-MC-Unique: c0XQqDFsNFCaSdCTOar9uA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d22b3462a0so32677041fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039753; x=1709644553;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tJVCdXMjUEnkLyKhEaXEMubhEfpRJE8p7wNvsup3Hd8=;
        b=OZGngAT2iD/2oUr9j9uBqGiZlXJGVPJEMynMwCHj/FTiPDqIcYAoVn8jSh+1WppV20
         uceQak5TQ4gTfNxkqe/r1+Pee+qVHCfOzzB07NKTHEONSK+22x5XQEPU9xgG3lTJW36A
         j8gGh/yIzdLSy577puH5vYZqze3d2YAMvDB5hP8Bv8tp1+nCp8IgKmThstkoIru7GXdC
         hD3RMr3gzZbAPCtMqu72nS7RLDoHGfLH7TaPqjmYmthK2RBBGsyz5v+nDYarNvs2ycRN
         FK6Jev8NJvE7df3gCDGl8xDz1pOkLlOKovAwy9evF/AW2sor3cJAciVo0hiZUSYhXisA
         wGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzEtVd6O88eeZ+HUgM4CdFlTizbAtOzKDgct7eeiHwJSOj91CI6HJHnM85m3mjTCJlVC+NmmTmCEH3jEFmCiH1GEKCIQmlrDxabgYQ
X-Gm-Message-State: AOJu0YwiBhDV9P28Uqyz2tsh7xtbM8z4zamm9U4zyEutq3PGU4ZS3yF4
	U0tLfM61X03xCdrPPj05yUOAX5NqfBZ9lkoncebodWuKRYZnop3VWb2qDvZcbSECNksWqHiZw63
	11EDC4inPOFnBh5gUiZIE3AAmCiQi4TlSVTXyzbnWM7VViinqR/o9FYZmYba46A==
X-Received: by 2002:a2e:8813:0:b0:2d2:64ca:7a2d with SMTP id x19-20020a2e8813000000b002d264ca7a2dmr5828556ljh.31.1709039753535;
        Tue, 27 Feb 2024 05:15:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSbbDENkJ0M/TBSeHMiNqEgEPWJVvJiR6V/XwnyEuFDVSOCC8q3A+xAtG9mkLLbhL8wZhBdQ==
X-Received: by 2002:a2e:8813:0:b0:2d2:64ca:7a2d with SMTP id x19-20020a2e8813000000b002d264ca7a2dmr5828536ljh.31.1709039753073;
        Tue, 27 Feb 2024 05:15:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9? (p200300cbc70776005c185a7dc5b7e7a9.dip0.t-ipconnect.de. [2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9])
        by smtp.gmail.com with ESMTPSA id hi17-20020a05600c535100b0041290251dc2sm14694835wmb.14.2024.02.27.05.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 05:15:52 -0800 (PST)
Message-ID: <de0cc6e0-dd15-40b6-89c2-c8e83fd6f587@redhat.com>
Date: Tue, 27 Feb 2024 14:15:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] CoW on VM_PFNMAP vma during write fault
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org,
 khlebnikov@openvz.org, jaredeh@gmail.com, linmiaohe@huawei.com, hpa@zytor.com
Cc: dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
 peterz@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 mingo@redhat.com, rdunlap@infradead.org, bhelgaas@google.com,
 linux-mm@kvack.org
References: <20240227122814.3781907-1-mawupeng1@huawei.com>
 <a74c8b96-3fc5-44ff-949c-6e5c5e05e122@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a74c8b96-3fc5-44ff-949c-6e5c5e05e122@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.02.24 14:00, David Hildenbrand wrote:
> On 27.02.24 13:28, Wupeng Ma wrote:
>> We find that a warn will be produced during our test, the detail log is
>> shown in the end.
>>
>> The core problem of this warn is that the first pfn of this pfnmap vma is
>> cleared during memory-failure. Digging into the source we find that this
>> problem can be triggered as following:
>>
>> // mmap with MAP_PRIVATE and specific fd which hook mmap
>> mmap(MAP_PRIVATE, fd)
>>     __mmap_region
>>       remap_pfn_range
>>       // set vma with pfnmap and the prot of pte is read only
>> 	
> 
> Okay, so we get a MAP_PRIVATE VM_PFNMAP I assume.
> 
> What fd is that exactly? Often, we disallow private mappings in the
> mmap() callback (for a good reason).
> 
>> // memset this memory with trigger fault
>> handle_mm_fault
>>     __handle_mm_fault
>>       handle_pte_fault
>>         // write fault and !pte_write(entry)
>>         do_wp_page
>>           wp_page_copy // this will alloc a new page with valid page struct
>>                        // for this pfnmap vma
> 
> Here we replace the mapped PFNMAP thingy by a proper anon folio.
> 
>>
>> // inject a hwpoison to the first page of this vma
> 
> I assume this is an anon folio?
> 
>> madvise_inject_error
>>     memory_failure
>>       hwpoison_user_mappings
>>         try_to_unmap_one
>>           // mark this pte as invalid (hwpoison)
>>           mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
>>                   address, range.end);
>>
>> // during unmap vma, the first pfn of this pfnmap vma is invalid
>> vm_mmap_pgoff
>>     do_mmap
>>       __do_mmap_mm
>>         __mmap_region
>>           __do_munmap
>>             unmap_region
>>               unmap_vmas
>>                 unmap_single_vma
>>                   untrack_pfn
>>                     follow_phys // pte is already invalidate, WARN_ON here
> 
> unmap_single_vma()->...->zap_pte_range() should do the right thing when
> calling vm_normal_page().
> 
> untrack_pfn() is the problematic part.
> 
>>
>> CoW with a valid page for pfnmap vma is weird to us. Can we use
>> remap_pfn_range for private vma(read only)? Once CoW happens on a pfnmap
>> vma during write fault, this page is normal(page flag is valid) for most mm
>> subsystems, such as memory failure in thais case and extra should be done to
>> handle this special page.
>>
>> During unmap, if this vma is pfnmap, unmap shouldn't be done since page
>> should not be touched for pfnmap vma.
>>
>> But the root problem is that can we insert a valid page for pfnmap vma?
>>
>> Any thoughts to solve this warn?
> 
> vm_normal_page() documentation explains how that magic is supposed to
> work. vm_normal_page() should be able to correctly identify whether we
> want to look at the struct page for an anon folio that was COWed.
> 
> 
> untrack_pfn() indeed does not seem to be well prepared for handling
> MAP_PRIVATE mappings where we end up having anon folios.
> 
> I think it will already *completely mess up* simply when unmapping the
> range without the memory failure involved.
> 
> See, follow_phys() would get the PFN of the anon folio and then
> untrack_pfn() would do some nonesense with that. Completely broken.
> 
> The WARN is just a side-effect of the brokenness.
> 
> In follow_phys(), we'd likely have to call vm_normal_page(). If we get a
> page back, we'd likely have to fail follow_phys() instead of returning a
> PFN of an anon folio.
> 
> Now, how do we fix untrack_pfn() ? I really don't know. In theory, we
> might no longer have *any* PFNMAP PFN in there after COW'ing everything.
> 
> Sounds like MAP_PRIVATE VM_PFNMAP + __HAVE_PFNMAP_TRACKING is some
> broken garbage (sorry). Can we disallow it?

Staring at track_pfn_copy(), it's maybe similarly broken?

I think we want to do:

diff --git a/mm/memory.c b/mm/memory.c
index 098356b8805ae..da5d1e37c5534 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6050,6 +6050,10 @@ int follow_phys(struct vm_area_struct *vma,
                 goto out;
         pte = ptep_get(ptep);
  
+       /* Never return addresses of COW'ed anon folios. */
+       if (vm_normal_page(vma, address, pte))
+               goto unlock;
+
         if ((flags & FOLL_WRITE) && !pte_write(pte))
                 goto unlock;
  

And then, just disallow it with PAT involved:

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 0904d7e8e1260..e4d2b2e8c0281 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -997,6 +997,15 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
                                 && size == (vma->vm_end - vma->vm_start))) {
                 int ret;
  
+               /*
+                * untrack_pfn() and friends cannot handl regions that suddenly
+                * contain anon folios after COW. In particular, follow_phys()
+                * will fail when we have an anon folio at the beginning og the
+                * VMA.
+                */
+               if (vma && is_cow_mapping(vma->vm_flags))
+                       return -EINVAL;
+
                 ret = reserve_pfn_range(paddr, size, prot, 0);
                 if (ret == 0 && vma)
                         vm_flags_set(vma, VM_PAT);


I'm afraid that will break something. But well, it's already semi-broken.

As long as VM_PAT is not involved, it should work as expected.

In an ideal world, we'd get rid of follow_phys() completely and just
derive that information from the VMA?

-- 
Cheers,

David / dhildenb


