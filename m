Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5987680395D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343965AbjLDQAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjLDQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:00:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4D1C6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701705610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=xtR7yzFlWSpe5HTOGoad+k846bFOFJeFSSDdB+j627U=;
        b=I8NpNqHff/6nh7c4ygvF1SruPAALFrVGyDAh3LPSn2fe9yom6jqAsb7gJAlCfDPooazmPI
        f958G+ozqOxfBdVCmRi+/Hy8k0OXRPzNGeXONku+/oSvWNLMB6qiu9d1siwa8d0ovPyMET
        QVOT1dLEiRD3Te5rIZ974ZHT2AsphtM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-PupXm0czPWmdYdG0YqXnbA-1; Mon, 04 Dec 2023 11:00:08 -0500
X-MC-Unique: PupXm0czPWmdYdG0YqXnbA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-333524816e1so400146f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705607; x=1702310407;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xtR7yzFlWSpe5HTOGoad+k846bFOFJeFSSDdB+j627U=;
        b=qBvLxquQ9Z7f7R+6ewJqBajo6b70HzP+EDByCw3gYymh8OsfiibOZ+mylnH+1qQMXh
         IqLViyIG5YbKc9s6UVL75ycrfm4SoWzBAZ+mAatR6SExRKxAW2QGxoiT3Cl21rS1Ezdd
         xUFsjLNQal91PTEAxf4FuQv1qaFJUGhqm3lrE+H1gGl+OfDHiyCENLyTzf4MC+Ay5xHA
         rm3tgyMDaevpmPeMKidD1Fo/Jupuc0GZV6QmsMwfdMOWl2SzNmSfQCN0JnxjoaB1zCza
         uaLFqYmZaq85+eMEFAaZhLq+Z3TiQsiIZu3EkN+H5QNpbei/jhKzMDhalF272dt0w148
         vt9g==
X-Gm-Message-State: AOJu0YxYaAFI6asMuhKfp338CdtC1Edim9kBPV6IK8b21LCiqMjsPfkE
        b/vhqJLAxo7a3kIEj4ZbNjdZgaSqY0OXPV3JH3CKMbQA2HnyojgBm4Yf+s7Q9ii4j3TF/acScW7
        zf96iiHW3G7SMHTfVoDw/k/Le
X-Received: by 2002:a05:6000:4a:b0:333:2fd2:814a with SMTP id k10-20020a056000004a00b003332fd2814amr3137764wrx.103.1701705607425;
        Mon, 04 Dec 2023 08:00:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1AdBCBQJqupGBTrPwrYO3zYJLoVip0nJg8las7LgCMVdhqwbhNxaLvVGw9Ie1oBPxD6xP/Q==
X-Received: by 2002:a05:6000:4a:b0:333:2fd2:814a with SMTP id k10-20020a056000004a00b003332fd2814amr3137743wrx.103.1701705606899;
        Mon, 04 Dec 2023 08:00:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c722:3700:6501:8925:6f9:fcdc? (p200300cbc72237006501892506f9fcdc.dip0.t-ipconnect.de. [2003:cb:c722:3700:6501:8925:6f9:fcdc])
        by smtp.gmail.com with ESMTPSA id i7-20020adffc07000000b0033346408820sm4137550wrr.68.2023.12.04.08.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:00:06 -0800 (PST)
Message-ID: <104de2d6-ecf9-4b0c-a982-5bd8e1aea758@redhat.com>
Date:   Mon, 4 Dec 2023 17:00:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] mm: Batch-copy PTE ranges during fork()
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
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-2-ryan.roberts@arm.com>
 <a12ce4f8-feb0-4e35-8f55-9270fe5a808b@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a12ce4f8-feb0-4e35-8f55-9270fe5a808b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.23 16:47, David Hildenbrand wrote:
> On 04.12.23 11:54, Ryan Roberts wrote:
>> Convert copy_pte_range() to copy a set of ptes in a batch. A given batch
>> maps a physically contiguous block of memory, all belonging to the same
>> folio. This will likely improve performance by a tiny amount due to
>> batching the folio reference count management and calling set_ptes()
>> rather than making individual calls to set_pte_at().
>>
>> However, the primary motivation for this change is to reduce the number
>> of tlb maintenance operations that the arm64 backend has to perform
>> during fork, as it is about to add transparent support for the
>> "contiguous bit" in its ptes. By write-protecting the parent using the
>> new ptep_set_wrprotects() (note the 's' at the end) function, the
>> backend can avoid having to unfold contig ranges of PTEs, which is
>> expensive, when all ptes in the range are being write-protected.
>> Similarly, by using set_ptes() rather than set_pte_at() to set up ptes
>> in the child, the backend does not need to fold a contiguous range once
>> they are all populated - they can be initially populated as a contiguous
>> range in the first place.
>>
>> This change addresses the core-mm refactoring only, and introduces
>> ptep_set_wrprotects() with a default implementation that calls
>> ptep_set_wrprotect() for each pte in the range. A separate change will
>> implement ptep_set_wrprotects() in the arm64 backend to realize the
>> performance improvement as part of the work to enable contpte mappings.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>    include/linux/pgtable.h |  13 +++
>>    mm/memory.c             | 195 ++++++++++++++++++++++++++++++----------
>>    2 files changed, 162 insertions(+), 46 deletions(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index af7639c3b0a3..1c50f8a0fdde 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -622,6 +622,19 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
>>    }
>>    #endif
>>    
>> +#ifndef ptep_set_wrprotects
>> +struct mm_struct;
>> +static inline void ptep_set_wrprotects(struct mm_struct *mm,
>> +				unsigned long address, pte_t *ptep,
>> +				unsigned int nr)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
>> +		ptep_set_wrprotect(mm, address, ptep);
>> +}
>> +#endif
>> +
>>    /*
>>     * On some architectures hardware does not set page access bit when accessing
>>     * memory page, it is responsibility of software setting this bit. It brings
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 1f18ed4a5497..8a87a488950c 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -924,68 +924,162 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>>    	return 0;
>>    }
>>    
>> +static int folio_nr_pages_cont_mapped(struct folio *folio,
>> +				      struct page *page, pte_t *pte,
>> +				      unsigned long addr, unsigned long end,
>> +				      pte_t ptent, bool enforce_uffd_wp,
>> +				      int *dirty_nr, int *writable_nr)
>> +{
>> +	int floops;
>> +	int i;
>> +	unsigned long pfn;
>> +	bool prot_none;
>> +	bool uffd_wp;
>> +
>> +	if (!folio_test_large(folio))
>> +		return 1;
>> +
>> +	/*
>> +	 * Loop either to `end` or to end of folio if its contiguously mapped,
>> +	 * whichever is smaller.
>> +	 */
>> +	floops = (end - addr) >> PAGE_SHIFT;
>> +	floops = min_t(int, floops,
>> +		       folio_pfn(folio_next(folio)) - page_to_pfn(page));
>> +
>> +	pfn = page_to_pfn(page);
>> +	prot_none = pte_protnone(ptent);
>> +	uffd_wp = pte_uffd_wp(ptent);
>> +
>> +	*dirty_nr = !!pte_dirty(ptent);
>> +	*writable_nr = !!pte_write(ptent);
>> +
>> +	pfn++;
>> +	pte++;
>> +
>> +	for (i = 1; i < floops; i++) {
>> +		ptent = ptep_get(pte);
>> +
>> +		if (!pte_present(ptent) || pte_pfn(ptent) != pfn ||
>> +		    prot_none != pte_protnone(ptent) ||
>> +		    (enforce_uffd_wp && uffd_wp != pte_uffd_wp(ptent)))
>> +			break;
>> +
>> +		if (pte_dirty(ptent))
>> +			(*dirty_nr)++;
>> +		if (pte_write(ptent))
>> +			(*writable_nr)++;
>> +
>> +		pfn++;
>> +		pte++;
>> +	}
>> +
>> +	return i;
>> +}
>> +
>>    /*
>> - * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
>> - * is required to copy this pte.
>> + * Copy set of contiguous ptes.  Returns number of ptes copied if succeeded
>> + * (always gte 1), or -EAGAIN if one preallocated page is required to copy the
>> + * first pte.
>>     */
>>    static inline int
>> -copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>> -		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
>> -		 struct folio **prealloc)
>> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>> +		  pte_t *dst_pte, pte_t *src_pte,
>> +		  unsigned long addr, unsigned long end,
>> +		  int *rss, struct folio **prealloc)
>>    {
>>    	struct mm_struct *src_mm = src_vma->vm_mm;
>>    	unsigned long vm_flags = src_vma->vm_flags;
>>    	pte_t pte = ptep_get(src_pte);
>>    	struct page *page;
>>    	struct folio *folio;
>> +	int nr = 1;
>> +	bool anon = false;
>> +	bool enforce_uffd_wp = userfaultfd_wp(dst_vma);
>> +	int nr_dirty = !!pte_dirty(pte);
>> +	int nr_writable = !!pte_write(pte);
>> +	int i, ret;
>>    
>>    	page = vm_normal_page(src_vma, addr, pte);
>> -	if (page)
>> +	if (page) {
>>    		folio = page_folio(page);
>> -	if (page && folio_test_anon(folio)) {
>> -		/*
>> -		 * If this page may have been pinned by the parent process,
>> -		 * copy the page immediately for the child so that we'll always
>> -		 * guarantee the pinned page won't be randomly replaced in the
>> -		 * future.
>> -		 */
>> -		folio_get(folio);
>> -		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
>> -			/* Page may be pinned, we have to copy. */
>> -			folio_put(folio);
>> -			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
>> -						 addr, rss, prealloc, page);
>> +		anon = folio_test_anon(folio);
>> +		nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr, end,
>> +						pte, enforce_uffd_wp, &nr_dirty,
>> +						&nr_writable);
>> +		folio_ref_add(folio, nr);
>> +
>> +		for (i = 0; i < nr; i++, page++) {
>> +			if (anon) {
>> +				/*
>> +				 * If this page may have been pinned by the
>> +				 * parent process, copy the page immediately for
>> +				 * the child so that we'll always guarantee the
>> +				 * pinned page won't be randomly replaced in the
>> +				 * future.
>> +				 */
>> +				if (unlikely(page_try_dup_anon_rmap(
>> +						page, false, src_vma))) {
>> +					if (i != 0)
>> +						break;
>> +					/* Page may be pinned, we have to copy. */
>> +					folio_ref_sub(folio, nr);
>> +					ret = copy_present_page(
>> +						dst_vma, src_vma, dst_pte,
>> +						src_pte, addr, rss, prealloc,
>> +						page);
>> +					return ret == 0 ? 1 : ret;
>> +				}
>> +				rss[MM_ANONPAGES]++;
>> +				VM_BUG_ON(PageAnonExclusive(page));
>> +			} else {
>> +				page_dup_file_rmap(page, false);
>> +				rss[mm_counter_file(page)]++;
>> +			}
>>    		}
>> -		rss[MM_ANONPAGES]++;
>> -	} else if (page) {
>> -		folio_get(folio);
>> -		page_dup_file_rmap(page, false);
>> -		rss[mm_counter_file(page)]++;
>> -	}
> 
> This likely looks a lot neater if you keep the existing structure.
> 
> For example, you can simply have on the !anon path
> 
> } else if (page) {
> 	folio = page_folio(page);
> 	nr = folio_nr_pages_cont_mapped ...
> 	folio_ref_add(folio, nr);
> 	for (i = 0; i < nr; i++, page++)
> 		page_dup_file_rmap(page, false);
> 	rss[mm_counter_file(&folio->page)] += nr;
> }
> 

With rmap batching from [1] -- rebased+changed on top of that -- we could turn
that into an effective (untested):

         if (page && folio_test_anon(folio)) {
+               nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr, end,
+                                               pte, enforce_uffd_wp, &nr_dirty,
+                                               &nr_writable);
                 /*
                  * If this page may have been pinned by the parent process,
                  * copy the page immediately for the child so that we'll always
                  * guarantee the pinned page won't be randomly replaced in the
                  * future.
                  */
-               folio_get(folio);
-               if (unlikely(folio_try_dup_anon_rmap_pte(folio, page, src_vma))) {
+               folio_ref_add(folio, nr);
+               if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page, nr, src_vma))) {
                         /* Page may be pinned, we have to copy. */
-                       folio_put(folio);
-                       return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
-                                                addr, rss, prealloc, page);
+                       folio_ref_sub(folio, nr);
+                       ret = copy_present_page(dst_vma, src_vma, dst_pte,
+                                               src_pte, addr, rss, prealloc,
+                                               page);
+                       return ret == 0 ? 1 : ret;
                 }
-               rss[MM_ANONPAGES]++;
+               rss[MM_ANONPAGES] += nr;
         } else if (page) {
-               folio_get(folio);
-               folio_dup_file_rmap_pte(folio, page);
-               rss[mm_counter_file(page)]++;
+               nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr, end,
+                                               pte, enforce_uffd_wp, &nr_dirty,
+                                               &nr_writable);
+               folio_ref_add(folio, nr);
+               folio_dup_file_rmap_ptes(folio, page, nr);
+               rss[mm_counter_file(page)] += nr;
         }


We'll have to test performance, but it could be that we want to specialize
more on !folio_test_large(). That code is very performance-sensitive.


[1] https://lkml.kernel.org/r/20231204142146.91437-1-david@redhat.com

-- 
Cheers,

David / dhildenb

