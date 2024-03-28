Return-Path: <linux-kernel+bounces-122863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E888FEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B69B2220E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D444D7E77B;
	Thu, 28 Mar 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Otlj+ZUr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269444E1DA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627651; cv=none; b=MS5IoMMFFRjfJ2ENUuBymH4XHS4s+mhFHL2KNlKwxqcFfWvM5pHOb3MxvTJktBRdlsUmSrRXcADzy8PzAE3IFpyF/Qb1x5ZYaEIHHxOus2Lxk2vFhhNC09Q+WRUH+EP48nYLdEn/XRTJLdNri5Kk5Ub8AtX1eG+6dZyBzE0oA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627651; c=relaxed/simple;
	bh=tXeJk7C/kdJN/2H4eNcyoGu3WSsxdEVM3DUc9cLIg5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSwX7zLOVMi0tLGyniB4zggt61ucogK85RvDKdupIaLihsOA5nENsK20AEjKRpNX3iZiZeiCxvTfy1tZG2ND3D/1yo2g5y45/bgrbdf8antZjpevwiO1x85jMD7arLk/jw/FzbJU+SOyxlr2nbHMtedRF4LBVqMuWszLYeOQy9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Otlj+ZUr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711627649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iYu82gHHwrSB284do9I9UqefSWCjwW/kjouao+ArIlg=;
	b=Otlj+ZUr94SA2FwylBNJN640Gki/zbjHd4ouqSIpHW2PC1Wg9VWv2d19pKqIv91/cINUGf
	yYOXp7cGmOrEex5OqWmK/UTzPQxgvcWYoyv1JpJIBNVtFRKxmha813u5MrDfFQoTfqRsiP
	A9F49hD15gLcQnNIcPVSRVDr775LYaM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-5y6kvnp_OC6YVvYn5Hf21g-1; Thu, 28 Mar 2024 08:07:27 -0400
X-MC-Unique: 5y6kvnp_OC6YVvYn5Hf21g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34172041676so946548f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711627646; x=1712232446;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYu82gHHwrSB284do9I9UqefSWCjwW/kjouao+ArIlg=;
        b=K7cm5YoGr5O6wHiX4729PpbhpuNbZFQWZMldaFMoV8nX+EyNETL7KqmRM8RKP9rO8/
         M8wmGwSU0QHDIgBLaPeGz4zvDZAUS/zjuNmj8ZNYmVW3Q/o2yC2kw+mvA7D24aptUTpn
         oJyQ6btbNOIH00cDkkL9Sx5L3fTIcygljleSMjc01Cp3mWYgU7bKppYfv5YBrx22lVCx
         fx7x8CcVntSGK3/zn6SmaIuUMSBTSxJiDNml31teNdkXJ0/x/gqNitooLTunJvvKb8H4
         dKQ4h3yuSNWnebrstO0DzTayPoIjAbfANduyvplWzzWwAti/ECKdL+8NeXcEbPt/M3vf
         Ucow==
X-Forwarded-Encrypted: i=1; AJvYcCUmnfFnEkSVux3p6cz4Ghirw+d3Ex3OUfGQz9opnyWhqjEM/5EJWc/kkqqijcX1fYpTkPA7lDPX6Yx55ortjbgyVOzEsLi6oFlbz+6z
X-Gm-Message-State: AOJu0YwH1h6CRXr3be/uK5FuL66mFFaazcB4bKmKkvg3VqCFR7FAd3Eq
	MK9kHJGZN3uZUXiQZHooxVLdBpVZ53FvQzaQ7+if2CUjXuBDklsAxbDFk8j0YI6MphzNj+JIm0Q
	6VUaeoQpFwDN+k+lc5W1OigVCdGcZCVt8Ve6bA+yPTRzmOgEX8Va4irH4igzRfw==
X-Received: by 2002:a5d:4ccc:0:b0:33e:c0fc:5e4b with SMTP id c12-20020a5d4ccc000000b0033ec0fc5e4bmr1875009wrt.2.1711627646577;
        Thu, 28 Mar 2024 05:07:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzzodA1oUWd0U36S1DLK088PQ3IoeX4kqkebY6SblkeT6VYHSyVSgkztZse3VDCAaTbYW9xw==
X-Received: by 2002:a5d:4ccc:0:b0:33e:c0fc:5e4b with SMTP id c12-20020a5d4ccc000000b0033ec0fc5e4bmr1874982wrt.2.1711627646150;
        Thu, 28 Mar 2024 05:07:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:3600:8033:4189:6bd4:ea29? (p200300cbc7143600803341896bd4ea29.dip0.t-ipconnect.de. [2003:cb:c714:3600:8033:4189:6bd4:ea29])
        by smtp.gmail.com with ESMTPSA id bt30-20020a056000081e00b00341b9e11b11sm1633389wrb.24.2024.03.28.05.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 05:07:25 -0700 (PDT)
Message-ID: <760800b1-c708-4c1d-b153-c252ab21938a@redhat.com>
Date: Thu, 28 Mar 2024 13:07:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: support multi-size THP numa balancing
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: mgorman@techsingularity.net, wangkefeng.wang@huawei.com,
 jhubbard@nvidia.com, ying.huang@intel.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1711453317.git.baolin.wang@linux.alibaba.com>
 <dee4268f1797f31c6bb6bdab30f8ad3df9053d3d.1711453317.git.baolin.wang@linux.alibaba.com>
 <adf36acf-19b9-49fc-b9f3-138fd66de2da@redhat.com>
 <0baa443a-7872-4ded-94c6-06af88a6a943@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0baa443a-7872-4ded-94c6-06af88a6a943@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.03.24 12:34, Baolin Wang wrote:
> 
> 
> On 2024/3/28 17:25, David Hildenbrand wrote:
>> On 26.03.24 12:51, Baolin Wang wrote:
>>> Now the anonymous page allocation already supports multi-size THP (mTHP),
>>> but the numa balancing still prohibits mTHP migration even though it
>>> is an
>>> exclusive mapping, which is unreasonable.
>>>
>>> Allow scanning mTHP:
>>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
>>> pages") skips shared CoW pages' NUMA page migration to avoid shared data
>>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
>>> NUMA-migrate COW pages that have other uses") change to use page_count()
>>> to avoid GUP pages migration, that will also skip the mTHP numa scaning.
>>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>>> issue, although there is still a GUP race, the issue seems to have been
>>> resolved by commit 80d47f5de5e3. Meanwhile, use the
>>> folio_likely_mapped_shared()
>>> to skip shared CoW pages though this is not a precise sharers count. To
>>> check if the folio is shared, ideally we want to make sure every page is
>>> mapped to the same process, but doing that seems expensive and using
>>> the estimated mapcount seems can work when running autonuma benchmark.
>>>
>>> Allow migrating mTHP:
>>> As mentioned in the previous thread[1], large folios (including THP) are
>>> more susceptible to false sharing issues among threads than 4K base page,
>>> leading to pages ping-pong back and forth during numa balancing, which is
>>> currently not easy to resolve. Therefore, as a start to support mTHP numa
>>> balancing, we can follow the PMD mapped THP's strategy, that means we can
>>> reuse the 2-stage filter in should_numa_migrate_memory() to check if the
>>> mTHP is being heavily contended among threads (through checking the
>>> CPU id
>>> and pid of the last access) to avoid false sharing at some degree. Thus,
>>> we can restore all PTE maps upon the first hint page fault of a large
>>> folio
>>> to follow the PMD mapped THP's strategy. In the future, we can
>>> continue to
>>> optimize the NUMA balancing algorithm to avoid the false sharing issue
>>> with
>>> large folios as much as possible.
>>>
>>> Performance data:
>>> Machine environment: 2 nodes, 128 cores Intel(R) Xeon(R) Platinum
>>> Base: 2024-03-25 mm-unstable branch
>>> Enable mTHP to run autonuma-benchmark
>>>
>>> mTHP:16K
>>> Base                Patched
>>> numa01                numa01
>>> 224.70                137.23
>>> numa01_THREAD_ALLOC        numa01_THREAD_ALLOC
>>> 118.05                50.57
>>> numa02                numa02
>>> 13.45                9.30
>>> numa02_SMT            numa02_SMT
>>> 14.80                7.43
>>>
>>> mTHP:64K
>>> Base                Patched
>>> numa01                numa01
>>> 216.15                135.20
>>> numa01_THREAD_ALLOC        numa01_THREAD_ALLOC
>>> 115.35                46.93
>>> numa02                numa02
>>> 13.24                9.24
>>> numa02_SMT            numa02_SMT
>>> 14.67                7.31
>>>
>>> mTHP:128K
>>> Base                Patched
>>> numa01                numa01
>>> 205.13                140.41
>>> numa01_THREAD_ALLOC        numa01_THREAD_ALLOC
>>> 112.93                44.78
>>> numa02                numa02
>>> 13.16                9.19
>>> numa02_SMT            numa02_SMT
>>> 14.81                7.39
>>>
>>> [1]
>>> https://lore.kernel.org/all/20231117100745.fnpijbk4xgmals3k@techsingularity.net/
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>    mm/memory.c   | 56 +++++++++++++++++++++++++++++++++++++++++++--------
>>>    mm/mprotect.c |  3 ++-
>>>    2 files changed, 50 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index c30fb4b95e15..36191a9c799c 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -5068,16 +5068,55 @@ static void numa_rebuild_single_mapping(struct
>>> vm_fault *vmf, struct vm_area_str
>>>        update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>>>    }
>>> +static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct
>>> vm_area_struct *vma,
>>> +                       struct folio *folio, pte_t fault_pte, bool
>>> ignore_writable)
>>> +{
>>> +    int nr = pte_pfn(fault_pte) - folio_pfn(folio);
>>> +    unsigned long start = max(vmf->address - nr * PAGE_SIZE,
>>> vma->vm_start);
>>> +    unsigned long end = min(start + folio_nr_pages(folio) *
>>> PAGE_SIZE, vma->vm_end);
>>> +    pte_t *start_ptep = vmf->pte - (vmf->address - start) / PAGE_SIZE;
>>> +    bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
>>> +    unsigned long addr;
>>> +
>>> +    /* Restore all PTEs' mapping of the large folio */
>>> +    for (addr = start; addr != end; start_ptep++, addr += PAGE_SIZE) {
>>> +        pte_t pte, old_pte;
>>> +        pte_t ptent = ptep_get(start_ptep);
>>> +        bool writable = false;
>>> +
>>> +        if (!pte_present(ptent) || !pte_protnone(ptent))
>>> +            continue;
>>> +
>>> +        if (vm_normal_folio(vma, addr, ptent) != folio)
>>> +            continue;
>>> +
>>
>> Should you be using folio_pte_batch() in the caller to collect all
>> applicable PTEs and then only have function that batch-changes a given
>> nr of PTEs?
>>
>> (just like we are now batching other stuff)
> 
> Seems folio_pte_batch() is not suitable for numa balancing, since we did
> not care about other PTE bits, only care about the protnone bits. And

You should be able to ignore most bits we care about, which case are you 
concerned about folio_pte_batch() would miss. Hand crafting own 
functions to cover some corner cases nobody cares about is likely a bad 
idea.

> after more thinking, I think I can drop the vm_normal_folio()
> validation, since all PTEs are ensured to be within the range of the
> folio size.

Are you sure about that?

-- 
Cheers,

David / dhildenb


