Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3610803922
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343545AbjLDPrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343626AbjLDPrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:47:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D8AB0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701704844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=oBQ3kxMeEX0MkLexh5z/xY/8Y7o+wrS/jT1s5nqJL7I=;
        b=J7ou+4C6rzqynX7ByTGkpQuxXqQ0457pXi87kt7QbPHYgQeK1UcbGGGyahL5irz4miSIsT
        p/bOorqzo6IGwpDP2DagiGMTW3u03J76zW583RA6hRe17qSqFKU5Zjq5BjaR9PCz1P9yBq
        t7XhU3k9wh9pVYxCgy4YtNHawth6qZY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-WG0_LvCeM3iNExS6jWqTMA-1; Mon, 04 Dec 2023 10:47:21 -0500
X-MC-Unique: WG0_LvCeM3iNExS6jWqTMA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c0a1726cfso10032135e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 07:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704840; x=1702309640;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBQ3kxMeEX0MkLexh5z/xY/8Y7o+wrS/jT1s5nqJL7I=;
        b=AfJI3JsLxEwH3fMEb7mbkVkhKAGY9lfZe7Qy0KCMTytpDqeGyRfHu6AQ7I8X/AfBn7
         7n8eoqkgLIP5ylLx0qrW5YGMK35h3xuBHvTAKb07O9g306WLnH59sCvqskipVVg7Xxmw
         gXWoY4ovz2d9Jbke+GYQkGBK51zWfefpmDj3ybsl7Bsc98ziuS6+ERjVqII/NWWIfhrv
         zDCmJuU2oxpm4nn16rQdmox+wansIIhUCo1QTzh7xn73DHHrqBpz7BdnfF7N7i8ruUGe
         YI6vzhcD8oj2TyMi+x/NCJ2FB3nl84ba18kX72CPLHo4jUn5C9dLav0KPB8CJ4OwAhaX
         EdOA==
X-Gm-Message-State: AOJu0YwJsHRV5aHGVcZoXfAaZE8rDYdCRNRW3kF1YfSpQXsXXy9IUYpM
        MCNI+kf5XzCSVXq7VaMN83QJSnOnAPs7snkWSoUX/uK8ES3Kmv8jrSOSlxKqw/0C9IUkk5BQKPO
        d6e2YbjJv1FuEdGfRmxoFwyn+
X-Received: by 2002:a05:600c:32a7:b0:40c:f7b:67e5 with SMTP id t39-20020a05600c32a700b0040c0f7b67e5mr192900wmp.37.1701704840203;
        Mon, 04 Dec 2023 07:47:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHke2Dv/svx+55pl8aNw1fbHNQVD01MujPPLuBthvXKPyQT7Y+f6k6lI4DHUs2BDf9eTb0UfQ==
X-Received: by 2002:a05:600c:32a7:b0:40c:f7b:67e5 with SMTP id t39-20020a05600c32a700b0040c0f7b67e5mr192889wmp.37.1701704839719;
        Mon, 04 Dec 2023 07:47:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c722:3700:6501:8925:6f9:fcdc? (p200300cbc72237006501892506f9fcdc.dip0.t-ipconnect.de. [2003:cb:c722:3700:6501:8925:6f9:fcdc])
        by smtp.gmail.com with ESMTPSA id iv7-20020a05600c548700b00405959469afsm15440924wmb.3.2023.12.04.07.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 07:47:19 -0800 (PST)
Message-ID: <a12ce4f8-feb0-4e35-8f55-9270fe5a808b@redhat.com>
Date:   Mon, 4 Dec 2023 16:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] mm: Batch-copy PTE ranges during fork()
Content-Language: en-US
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
From:   David Hildenbrand <david@redhat.com>
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
In-Reply-To: <20231204105440.61448-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.23 11:54, Ryan Roberts wrote:
> Convert copy_pte_range() to copy a set of ptes in a batch. A given batch
> maps a physically contiguous block of memory, all belonging to the same
> folio. This will likely improve performance by a tiny amount due to
> batching the folio reference count management and calling set_ptes()
> rather than making individual calls to set_pte_at().
> 
> However, the primary motivation for this change is to reduce the number
> of tlb maintenance operations that the arm64 backend has to perform
> during fork, as it is about to add transparent support for the
> "contiguous bit" in its ptes. By write-protecting the parent using the
> new ptep_set_wrprotects() (note the 's' at the end) function, the
> backend can avoid having to unfold contig ranges of PTEs, which is
> expensive, when all ptes in the range are being write-protected.
> Similarly, by using set_ptes() rather than set_pte_at() to set up ptes
> in the child, the backend does not need to fold a contiguous range once
> they are all populated - they can be initially populated as a contiguous
> range in the first place.
> 
> This change addresses the core-mm refactoring only, and introduces
> ptep_set_wrprotects() with a default implementation that calls
> ptep_set_wrprotect() for each pte in the range. A separate change will
> implement ptep_set_wrprotects() in the arm64 backend to realize the
> performance improvement as part of the work to enable contpte mappings.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   include/linux/pgtable.h |  13 +++
>   mm/memory.c             | 195 ++++++++++++++++++++++++++++++----------
>   2 files changed, 162 insertions(+), 46 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index af7639c3b0a3..1c50f8a0fdde 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -622,6 +622,19 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
>   }
>   #endif
>   
> +#ifndef ptep_set_wrprotects
> +struct mm_struct;
> +static inline void ptep_set_wrprotects(struct mm_struct *mm,
> +				unsigned long address, pte_t *ptep,
> +				unsigned int nr)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
> +		ptep_set_wrprotect(mm, address, ptep);
> +}
> +#endif
> +
>   /*
>    * On some architectures hardware does not set page access bit when accessing
>    * memory page, it is responsibility of software setting this bit. It brings
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f18ed4a5497..8a87a488950c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -924,68 +924,162 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>   	return 0;
>   }
>   
> +static int folio_nr_pages_cont_mapped(struct folio *folio,
> +				      struct page *page, pte_t *pte,
> +				      unsigned long addr, unsigned long end,
> +				      pte_t ptent, bool enforce_uffd_wp,
> +				      int *dirty_nr, int *writable_nr)
> +{
> +	int floops;
> +	int i;
> +	unsigned long pfn;
> +	bool prot_none;
> +	bool uffd_wp;
> +
> +	if (!folio_test_large(folio))
> +		return 1;
> +
> +	/*
> +	 * Loop either to `end` or to end of folio if its contiguously mapped,
> +	 * whichever is smaller.
> +	 */
> +	floops = (end - addr) >> PAGE_SHIFT;
> +	floops = min_t(int, floops,
> +		       folio_pfn(folio_next(folio)) - page_to_pfn(page));
> +
> +	pfn = page_to_pfn(page);
> +	prot_none = pte_protnone(ptent);
> +	uffd_wp = pte_uffd_wp(ptent);
> +
> +	*dirty_nr = !!pte_dirty(ptent);
> +	*writable_nr = !!pte_write(ptent);
> +
> +	pfn++;
> +	pte++;
> +
> +	for (i = 1; i < floops; i++) {
> +		ptent = ptep_get(pte);
> +
> +		if (!pte_present(ptent) || pte_pfn(ptent) != pfn ||
> +		    prot_none != pte_protnone(ptent) ||
> +		    (enforce_uffd_wp && uffd_wp != pte_uffd_wp(ptent)))
> +			break;
> +
> +		if (pte_dirty(ptent))
> +			(*dirty_nr)++;
> +		if (pte_write(ptent))
> +			(*writable_nr)++;
> +
> +		pfn++;
> +		pte++;
> +	}
> +
> +	return i;
> +}
> +
>   /*
> - * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
> - * is required to copy this pte.
> + * Copy set of contiguous ptes.  Returns number of ptes copied if succeeded
> + * (always gte 1), or -EAGAIN if one preallocated page is required to copy the
> + * first pte.
>    */
>   static inline int
> -copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> -		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
> -		 struct folio **prealloc)
> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> +		  pte_t *dst_pte, pte_t *src_pte,
> +		  unsigned long addr, unsigned long end,
> +		  int *rss, struct folio **prealloc)
>   {
>   	struct mm_struct *src_mm = src_vma->vm_mm;
>   	unsigned long vm_flags = src_vma->vm_flags;
>   	pte_t pte = ptep_get(src_pte);
>   	struct page *page;
>   	struct folio *folio;
> +	int nr = 1;
> +	bool anon = false;
> +	bool enforce_uffd_wp = userfaultfd_wp(dst_vma);
> +	int nr_dirty = !!pte_dirty(pte);
> +	int nr_writable = !!pte_write(pte);
> +	int i, ret;
>   
>   	page = vm_normal_page(src_vma, addr, pte);
> -	if (page)
> +	if (page) {
>   		folio = page_folio(page);
> -	if (page && folio_test_anon(folio)) {
> -		/*
> -		 * If this page may have been pinned by the parent process,
> -		 * copy the page immediately for the child so that we'll always
> -		 * guarantee the pinned page won't be randomly replaced in the
> -		 * future.
> -		 */
> -		folio_get(folio);
> -		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
> -			/* Page may be pinned, we have to copy. */
> -			folio_put(folio);
> -			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
> -						 addr, rss, prealloc, page);
> +		anon = folio_test_anon(folio);
> +		nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr, end,
> +						pte, enforce_uffd_wp, &nr_dirty,
> +						&nr_writable);
> +		folio_ref_add(folio, nr);
> +
> +		for (i = 0; i < nr; i++, page++) {
> +			if (anon) {
> +				/*
> +				 * If this page may have been pinned by the
> +				 * parent process, copy the page immediately for
> +				 * the child so that we'll always guarantee the
> +				 * pinned page won't be randomly replaced in the
> +				 * future.
> +				 */
> +				if (unlikely(page_try_dup_anon_rmap(
> +						page, false, src_vma))) {
> +					if (i != 0)
> +						break;
> +					/* Page may be pinned, we have to copy. */
> +					folio_ref_sub(folio, nr);
> +					ret = copy_present_page(
> +						dst_vma, src_vma, dst_pte,
> +						src_pte, addr, rss, prealloc,
> +						page);
> +					return ret == 0 ? 1 : ret;
> +				}
> +				rss[MM_ANONPAGES]++;
> +				VM_BUG_ON(PageAnonExclusive(page));
> +			} else {
> +				page_dup_file_rmap(page, false);
> +				rss[mm_counter_file(page)]++;
> +			}
>   		}
> -		rss[MM_ANONPAGES]++;
> -	} else if (page) {
> -		folio_get(folio);
> -		page_dup_file_rmap(page, false);
> -		rss[mm_counter_file(page)]++;
> -	}

This likely looks a lot neater if you keep the existing structure.

For example, you can simply have on the !anon path

} else if (page) {
	folio = page_folio(page);
	nr = folio_nr_pages_cont_mapped ...
	folio_ref_add(folio, nr);
	for (i = 0; i < nr; i++, page++)
		page_dup_file_rmap(page, false);
	rss[mm_counter_file(&folio->page)] += nr;
}

-- 
Cheers,

David / dhildenb

