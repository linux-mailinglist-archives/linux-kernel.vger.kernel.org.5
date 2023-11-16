Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3507B7EE270
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjKPOQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjKPOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A5D4B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700144154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=1Lk6j0r/0akS8fsmcFzL8BwndIPL6eNJbCF3tgd0Zgw=;
        b=GghzTpuCT6FysV3/JzSt1Ms2rcxExFn8LCI8xsPoXjm42TX3/ULsDmfgm9p6JU004v2Brm
        7wRtE92NxH2jKTK2UubDQ9c3v3vLnVdakINIiOMbHBPTSlQ2jRDMzuSgx1ASLmoGP1NoFh
        EGtzYDAKtv2gtbhUkskt9nAMuiDnai0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-RIDxEBGcPAqCV5EfHyoxTA-1; Thu, 16 Nov 2023 09:15:53 -0500
X-MC-Unique: RIDxEBGcPAqCV5EfHyoxTA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c6ed6f7146so7847751fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700144151; x=1700748951;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Lk6j0r/0akS8fsmcFzL8BwndIPL6eNJbCF3tgd0Zgw=;
        b=bJB6OV1+80ofOMWLXyHkoY1ES9e9a6qkoKCboq0a4s6vcBCtO1QecffeJRcEtzmaB7
         MjbW9JhB8oIknFikXEKfnruIvGXxk+MNF8bJCJ88gh1oEELa/oj6pC6v1AmusYB17PpW
         y8uJJgBug52iMluwR/DErUic8SNe8H5eunAXhxtID71xNSGf1pq9QpEk29J93xCDKP4S
         p8AUVLkd4nA0IkMdtRsq2LYXSJ1YRpu1WJPbKmPYGnelh2/gidGQih3Wkwir4eiIr7V1
         cy13xMCE76guNO9PZ9AY6YYO9AGEiCdP1cOKpUiViPg6PebH55lKmNxU0OWLWF5YzLkb
         zUGw==
X-Gm-Message-State: AOJu0Yys3kTUzMjxuVkd1fD3JsgtMDPn+i9SiMLDumQLekl7AbcHxXcx
        ZTbipmeyy6TB2+ukGa/UDy46qKRuYdFDX+xyjzJYYA9yE3nzBLxp8w8LfiKy1SdrzzFZ8wfLv5U
        NeF6a4dVOAL3dSyfnKgM847p7
X-Received: by 2002:a2e:a98b:0:b0:2c8:39fc:acf5 with SMTP id x11-20020a2ea98b000000b002c839fcacf5mr7889316ljq.2.1700144151302;
        Thu, 16 Nov 2023 06:15:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrVtq+o9aft9Cq1p61zHkYRXLve3VB2JIrxtNdCtZWUBjfMFgn13jgFyL5PlMon25oiwIUYA==
X-Received: by 2002:a2e:a98b:0:b0:2c8:39fc:acf5 with SMTP id x11-20020a2ea98b000000b002c839fcacf5mr7889293ljq.2.1700144150746;
        Thu, 16 Nov 2023 06:15:50 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b0040a4cc876e0sm3832909wmq.40.2023.11.16.06.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:15:50 -0800 (PST)
Message-ID: <d639ab17-8f6b-438d-bdcd-91924185b462@redhat.com>
Date:   Thu, 16 Nov 2023 15:15:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-2-ryan.roberts@arm.com>
 <89a9fe07-a5c5-4a99-b588-e6145053c58f@redhat.com>
 <1459f78b-e80c-4f21-bc65-f0ab259d348a@arm.com>
 <08ef2c36-2b9c-4b96-9d1d-68cca0f68ba5@redhat.com>
 <2d027a8d-adfb-481d-89ea-c99139e669aa@arm.com>
 <2618b024-6a95-4bfc-a08d-59d86e9931e5@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2618b024-6a95-4bfc-a08d-59d86e9931e5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.23 15:13, David Hildenbrand wrote:
> On 16.11.23 14:49, Ryan Roberts wrote:
>> On 16/11/2023 13:20, David Hildenbrand wrote:
>>> On 16.11.23 12:20, Ryan Roberts wrote:
>>>> On 16/11/2023 11:03, David Hildenbrand wrote:
>>>>> On 15.11.23 17:30, Ryan Roberts wrote:
>>>>>> Convert copy_pte_range() to copy a set of ptes in a batch. A given batch
>>>>>> maps a physically contiguous block of memory, all belonging to the same
>>>>>> folio, with the same permissions, and for shared mappings, the same
>>>>>> dirty state. This will likely improve performance by a tiny amount due
>>>>>> to batching the folio reference count management and calling set_ptes()
>>>>>> rather than making individual calls to set_pte_at().
>>>>>>
>>>>>> However, the primary motivation for this change is to reduce the number
>>>>>> of tlb maintenance operations that the arm64 backend has to perform
>>>>>> during fork, as it is about to add transparent support for the
>>>>>> "contiguous bit" in its ptes. By write-protecting the parent using the
>>>>>> new ptep_set_wrprotects() (note the 's' at the end) function, the
>>>>>> backend can avoid having to unfold contig ranges of PTEs, which is
>>>>>> expensive, when all ptes in the range are being write-protected.
>>>>>> Similarly, by using set_ptes() rather than set_pte_at() to set up ptes
>>>>>> in the child, the backend does not need to fold a contiguous range once
>>>>>> they are all populated - they can be initially populated as a contiguous
>>>>>> range in the first place.
>>>>>>
>>>>>> This change addresses the core-mm refactoring only, and introduces
>>>>>> ptep_set_wrprotects() with a default implementation that calls
>>>>>> ptep_set_wrprotect() for each pte in the range. A separate change will
>>>>>> implement ptep_set_wrprotects() in the arm64 backend to realize the
>>>>>> performance improvement as part of the work to enable contpte mappings.
>>>>>>
>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>> ---
>>>>>>      include/linux/pgtable.h |  13 +++
>>>>>>      mm/memory.c             | 175 +++++++++++++++++++++++++++++++---------
>>>>>>      2 files changed, 150 insertions(+), 38 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>> index af7639c3b0a3..1c50f8a0fdde 100644
>>>>>> --- a/include/linux/pgtable.h
>>>>>> +++ b/include/linux/pgtable.h
>>>>>> @@ -622,6 +622,19 @@ static inline void ptep_set_wrprotect(struct mm_struct
>>>>>> *mm, unsigned long addres
>>>>>>      }
>>>>>>      #endif
>>>>>>      +#ifndef ptep_set_wrprotects
>>>>>> +struct mm_struct;
>>>>>> +static inline void ptep_set_wrprotects(struct mm_struct *mm,
>>>>>> +                unsigned long address, pte_t *ptep,
>>>>>> +                unsigned int nr)
>>>>>> +{
>>>>>> +    unsigned int i;
>>>>>> +
>>>>>> +    for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
>>>>>> +        ptep_set_wrprotect(mm, address, ptep);
>>>>>> +}
>>>>>> +#endif
>>>>>> +
>>>>>>      /*
>>>>>>       * On some architectures hardware does not set page access bit when
>>>>>> accessing
>>>>>>       * memory page, it is responsibility of software setting this bit. It brings
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index 1f18ed4a5497..b7c8228883cf 100644
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -921,46 +921,129 @@ copy_present_page(struct vm_area_struct *dst_vma,
>>>>>> struct vm_area_struct *src_vma
>>>>>>              /* Uffd-wp needs to be delivered to dest pte as well */
>>>>>>              pte = pte_mkuffd_wp(pte);
>>>>>>          set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
>>>>>> -    return 0;
>>>>>> +    return 1;
>>>>>> +}
>>>>>> +
>>>>>> +static inline unsigned long page_cont_mapped_vaddr(struct page *page,
>>>>>> +                struct page *anchor, unsigned long anchor_vaddr)
>>>>>> +{
>>>>>> +    unsigned long offset;
>>>>>> +    unsigned long vaddr;
>>>>>> +
>>>>>> +    offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
>>>>>> +    vaddr = anchor_vaddr + offset;
>>>>>> +
>>>>>> +    if (anchor > page) {
>>>>>> +        if (vaddr > anchor_vaddr)
>>>>>> +            return 0;
>>>>>> +    } else {
>>>>>> +        if (vaddr < anchor_vaddr)
>>>>>> +            return ULONG_MAX;
>>>>>> +    }
>>>>>> +
>>>>>> +    return vaddr;
>>>>>> +}
>>>>>> +
>>>>>> +static int folio_nr_pages_cont_mapped(struct folio *folio,
>>>>>> +                      struct page *page, pte_t *pte,
>>>>>> +                      unsigned long addr, unsigned long end,
>>>>>> +                      pte_t ptent, bool *any_dirty)
>>>>>> +{
>>>>>> +    int floops;
>>>>>> +    int i;
>>>>>> +    unsigned long pfn;
>>>>>> +    pgprot_t prot;
>>>>>> +    struct page *folio_end;
>>>>>> +
>>>>>> +    if (!folio_test_large(folio))
>>>>>> +        return 1;
>>>>>> +
>>>>>> +    folio_end = &folio->page + folio_nr_pages(folio);
>>>>>> +    end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
>>>>>> +    floops = (end - addr) >> PAGE_SHIFT;
>>>>>> +    pfn = page_to_pfn(page);
>>>>>> +    prot = pte_pgprot(pte_mkold(pte_mkclean(ptent)));
>>>>>> +
>>>>>> +    *any_dirty = pte_dirty(ptent);
>>>>>> +
>>>>>> +    pfn++;
>>>>>> +    pte++;
>>>>>> +
>>>>>> +    for (i = 1; i < floops; i++) {
>>>>>> +        ptent = ptep_get(pte);
>>>>>> +        ptent = pte_mkold(pte_mkclean(ptent));
>>>>>> +
>>>>>> +        if (!pte_present(ptent) || pte_pfn(ptent) != pfn ||
>>>>>> +            pgprot_val(pte_pgprot(ptent)) != pgprot_val(prot))
>>>>>> +            break;
>>>>>> +
>>>>>> +        if (pte_dirty(ptent))
>>>>>> +            *any_dirty = true;
>>>>>> +
>>>>>> +        pfn++;
>>>>>> +        pte++;
>>>>>> +    }
>>>>>> +
>>>>>> +    return i;
>>>>>>      }
>>>>>>        /*
>>>>>> - * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
>>>>>> - * is required to copy this pte.
>>>>>> + * Copy set of contiguous ptes.  Returns number of ptes copied if succeeded
>>>>>> + * (always gte 1), or -EAGAIN if one preallocated page is required to copy the
>>>>>> + * first pte.
>>>>>>       */
>>>>>>      static inline int
>>>>>> -copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct
>>>>>> *src_vma,
>>>>>> -         pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
>>>>>> -         struct folio **prealloc)
>>>>>> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct
>>>>>> *src_vma,
>>>>>> +          pte_t *dst_pte, pte_t *src_pte,
>>>>>> +          unsigned long addr, unsigned long end,
>>>>>> +          int *rss, struct folio **prealloc)
>>>>>>      {
>>>>>>          struct mm_struct *src_mm = src_vma->vm_mm;
>>>>>>          unsigned long vm_flags = src_vma->vm_flags;
>>>>>>          pte_t pte = ptep_get(src_pte);
>>>>>>          struct page *page;
>>>>>>          struct folio *folio;
>>>>>> +    int nr = 1;
>>>>>> +    bool anon;
>>>>>> +    bool any_dirty = pte_dirty(pte);
>>>>>> +    int i;
>>>>>>            page = vm_normal_page(src_vma, addr, pte);
>>>>>> -    if (page)
>>>>>> +    if (page) {
>>>>>>              folio = page_folio(page);
>>>>>> -    if (page && folio_test_anon(folio)) {
>>>>>> -        /*
>>>>>> -         * If this page may have been pinned by the parent process,
>>>>>> -         * copy the page immediately for the child so that we'll always
>>>>>> -         * guarantee the pinned page won't be randomly replaced in the
>>>>>> -         * future.
>>>>>> -         */
>>>>>> -        folio_get(folio);
>>>>>> -        if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
>>>>>> -            /* Page may be pinned, we have to copy. */
>>>>>> -            folio_put(folio);
>>>>>> -            return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
>>>>>> -                         addr, rss, prealloc, page);
>>>>>> +        anon = folio_test_anon(folio);
>>>>>> +        nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr,
>>>>>> +                        end, pte, &any_dirty);
>>>>>> +
>>>>>> +        for (i = 0; i < nr; i++, page++) {
>>>>>> +            if (anon) {
>>>>>> +                /*
>>>>>> +                 * If this page may have been pinned by the
>>>>>> +                 * parent process, copy the page immediately for
>>>>>> +                 * the child so that we'll always guarantee the
>>>>>> +                 * pinned page won't be randomly replaced in the
>>>>>> +                 * future.
>>>>>> +                 */
>>>>>> +                if (unlikely(page_try_dup_anon_rmap(
>>>>>> +                        page, false, src_vma))) {
>>>>>> +                    if (i != 0)
>>>>>> +                        break;
>>>>>> +                    /* Page may be pinned, we have to copy. */
>>>>>> +                    return copy_present_page(
>>>>>> +                        dst_vma, src_vma, dst_pte,
>>>>>> +                        src_pte, addr, rss, prealloc,
>>>>>> +                        page);
>>>>>> +                }
>>>>>> +                rss[MM_ANONPAGES]++;
>>>>>> +                VM_BUG_ON(PageAnonExclusive(page));
>>>>>> +            } else {
>>>>>> +                page_dup_file_rmap(page, false);
>>>>>> +                rss[mm_counter_file(page)]++;
>>>>>> +            }
>>>>>>              }
>>>>>> -        rss[MM_ANONPAGES]++;
>>>>>> -    } else if (page) {
>>>>>> -        folio_get(folio);
>>>>>> -        page_dup_file_rmap(page, false);
>>>>>> -        rss[mm_counter_file(page)]++;
>>>>>> +
>>>>>> +        nr = i;
>>>>>> +        folio_ref_add(folio, nr);
>>>>>>          }
>>>>>>            /*
>>>>>> @@ -968,24 +1051,28 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct
>>>>>> vm_area_struct *src_vma,
>>>>>>           * in the parent and the child
>>>>>>           */
>>>>>>          if (is_cow_mapping(vm_flags) && pte_write(pte)) {
>>>>>> -        ptep_set_wrprotect(src_mm, addr, src_pte);
>>>>>> +        ptep_set_wrprotects(src_mm, addr, src_pte, nr);
>>>>>>              pte = pte_wrprotect(pte);
>>>>>
>>>>> You likely want an "any_pte_writable" check here instead, no?
>>>>>
>>>>> Any operations that target a single indiividual PTE while multiple PTEs are
>>>>> adjusted are suspicious :)
>>>>
>>>> The idea is that I've already constrained the batch of pages such that the
>>>> permissions are all the same (see folio_nr_pages_cont_mapped()). So if the first
>>>> pte is writable, then they all are - something has gone badly wrong if some are
>>>> writable and others are not.
>>>
>>> I wonder if it would be cleaner and easier to not do that, though.
>>>
>>> Simply record if any pte is writable. Afterwards they will *all* be R/O and you
>>> can set the cont bit, correct?
>>
>> Oh I see what you mean - that only works for cow mappings though. If you have a
>> shared mapping, you won't be making it read-only at fork. So if we ignore
>> pte_write() state when demarking the batches, we will end up with a batch of
>> pages with a mix of RO and RW in the parent, but then we set_ptes() for the
>> child and those pages will all have the permissions of the first page of the batch.
> 
> I see what you mean.
> 
> After fork(), all anon pages will be R/O in the parent and the child.
> Easy. If any PTE is writable, wrprotect all in the parent and the child.
> 
> After fork(), all shared pages can be R/O or R/W in the parent. For
> simplicity, I think you can simply set them all R/O in the child. So if
> any PTE is writable, wrprotect all in the child.

Or better: if any is R/O, set them all R/O. Otherwise just leave them as is.

But devil is in the detail.

-- 
Cheers,

David / dhildenb

