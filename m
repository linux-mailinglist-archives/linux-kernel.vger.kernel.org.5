Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF368051D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442034AbjLELQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346820AbjLELQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:16:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364001A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701774978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=KA72dmduq3WWvtCL+i9U52miPFZfqgHPOVL29iB/JGo=;
        b=MTm4CbvWZJU8PV7nr4EeXVs69XdrqVafn2GzSg1owY693UvNd3mzG7vePwQ2RH8p2iQYT8
        yYXHCuHfdPXNQNiQhBqoCVcaCokLGCl7Qt+SKgHLQ8nAVrFrarTKYqq2HDrZY7wqCumBLL
        L3oUTKQEJGZty2mRbFILXYbNmyKzMwk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-vrfFTip3P9S3UdtuWGYyKQ-1; Tue, 05 Dec 2023 06:16:17 -0500
X-MC-Unique: vrfFTip3P9S3UdtuWGYyKQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33342edbd15so1630621f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 03:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701774976; x=1702379776;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA72dmduq3WWvtCL+i9U52miPFZfqgHPOVL29iB/JGo=;
        b=qtAqHopnSI0jvGDFoYXpb+LdInb4WY+1rV4Q+LE6sY3ZUD3EZzvqEOBANFjwVhaEda
         QXlacl13T7AqX/iorm6GNj3wTx9KDK4JqM8rvViE23huq3AVR9XzVsFZrXjI72nCyZdE
         9usSKFCWxVQVxLjTTjXWGhcfZKbUnguK7WUSvWRW9AxHaQJ44VCCQ82Oe8FIzFYuIsbG
         AGVMePZc6GshzWBFS+bBVuFE8GMY3toL5qx5dFdO7Mpb1Rm5ZOaE558gx6F15aa3hj1o
         xLn37hJA8nJ7DUhJEjdxjixu32D9SPXLy29F8oQA+O4TKiMH9n7bkC4cDVhmIpJBvCk9
         PAgg==
X-Gm-Message-State: AOJu0Yz02d3VILkYDoXu4UvJvklNssT+GT8EDFS31ZplbH/kLaFwMOo7
        QeLf5Od0BqQlPXuZpYEl5o+v4oStQKrChoeOrobPHzObepHaTTk7+mxW/fYP/tlwh6oBeggiflO
        x33Ngk9560t54m2cl2OfrhBoy
X-Received: by 2002:a5d:4aca:0:b0:333:2fd2:814b with SMTP id y10-20020a5d4aca000000b003332fd2814bmr4159648wrs.104.1701774975802;
        Tue, 05 Dec 2023 03:16:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOg5w1vupRe8EODW3q7dm0zTA9Ty+yM8CQ2GHbMtDZZORDAhjkd3zE6kgfg7+F9T2yqbZQhA==
X-Received: by 2002:a5d:4aca:0:b0:333:2fd2:814b with SMTP id y10-20020a5d4aca000000b003332fd2814bmr4159622wrs.104.1701774975318;
        Tue, 05 Dec 2023 03:16:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id dm11-20020a0560000bcb00b0033334625bdbsm10550488wrb.13.2023.12.05.03.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 03:16:14 -0800 (PST)
Message-ID: <20c867c9-9206-47b5-baf4-ddb748a43370@redhat.com>
Date:   Tue, 5 Dec 2023 12:16:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-5-ryan.roberts@arm.com>
 <CAGsJ_4zG6W_Z-u+3QcRDn4ByoeqUXjMusNS0RotfRMSqo8RCHg@mail.gmail.com>
 <CAGsJ_4zYhJWGx1DnHTiDnP3h1m8_rr6ZT6fXt8pO=jzs9QZS-A@mail.gmail.com>
 <5216caaf-1fcf-4715-99c3-521e2a1cc756@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5216caaf-1fcf-4715-99c3-521e2a1cc756@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.23 11:48, Ryan Roberts wrote:
> On 05/12/2023 01:24, Barry Song wrote:
>> On Tue, Dec 5, 2023 at 9:15 AM Barry Song <21cnbao@gmail.com> wrote:
>>>
>>> On Mon, Dec 4, 2023 at 6:21 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> Introduce the logic to allow THP to be configured (through the new sysfs
>>>> interface we just added) to allocate large folios to back anonymous
>>>> memory, which are larger than the base page size but smaller than
>>>> PMD-size. We call this new THP extension "multi-size THP" (mTHP).
>>>>
>>>> mTHP continues to be PTE-mapped, but in many cases can still provide
>>>> similar benefits to traditional PMD-sized THP: Page faults are
>>>> significantly reduced (by a factor of e.g. 4, 8, 16, etc. depending on
>>>> the configured order), but latency spikes are much less prominent
>>>> because the size of each page isn't as huge as the PMD-sized variant and
>>>> there is less memory to clear in each page fault. The number of per-page
>>>> operations (e.g. ref counting, rmap management, lru list management) are
>>>> also significantly reduced since those ops now become per-folio.
>>>>
>>>> Some architectures also employ TLB compression mechanisms to squeeze
>>>> more entries in when a set of PTEs are virtually and physically
>>>> contiguous and approporiately aligned. In this case, TLB misses will
>>>> occur less often.
>>>>
>>>> The new behaviour is disabled by default, but can be enabled at runtime
>>>> by writing to /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled
>>>> (see documentation in previous commit). The long term aim is to change
>>>> the default to include suitable lower orders, but there are some risks
>>>> around internal fragmentation that need to be better understood first.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>   include/linux/huge_mm.h |   6 ++-
>>>>   mm/memory.c             | 106 ++++++++++++++++++++++++++++++++++++----
>>>>   2 files changed, 101 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index bd0eadd3befb..91a53b9835a4 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
>>>>   #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>>>>
>>>>   /*
>>>> - * Mask of all large folio orders supported for anonymous THP.
>>>> + * Mask of all large folio orders supported for anonymous THP; all orders up to
>>>> + * and including PMD_ORDER, except order-0 (which is not "huge") and order-1
>>>> + * (which is a limitation of the THP implementation).
>>>>    */
>>>> -#define THP_ORDERS_ALL_ANON    BIT(PMD_ORDER)
>>>> +#define THP_ORDERS_ALL_ANON    ((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
>>>>
>>>>   /*
>>>>    * Mask of all large folio orders supported for file THP.
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 3ceeb0f45bf5..bf7e93813018 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4125,6 +4125,84 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>          return ret;
>>>>   }
>>>>
>>>> +static bool pte_range_none(pte_t *pte, int nr_pages)
>>>> +{
>>>> +       int i;
>>>> +
>>>> +       for (i = 0; i < nr_pages; i++) {
>>>> +               if (!pte_none(ptep_get_lockless(pte + i)))
>>>> +                       return false;
>>>> +       }
>>>> +
>>>> +       return true;
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>>>> +{
>>>> +       gfp_t gfp;
>>>> +       pte_t *pte;
>>>> +       unsigned long addr;
>>>> +       struct folio *folio;
>>>> +       struct vm_area_struct *vma = vmf->vma;
>>>> +       unsigned long orders;
>>>> +       int order;
>>>> +
>>>> +       /*
>>>> +        * If uffd is active for the vma we need per-page fault fidelity to
>>>> +        * maintain the uffd semantics.
>>>> +        */
>>>> +       if (userfaultfd_armed(vma))
>>>> +               goto fallback;
>>>> +
>>>> +       /*
>>>> +        * Get a list of all the (large) orders below PMD_ORDER that are enabled
>>>> +        * for this vma. Then filter out the orders that can't be allocated over
>>>> +        * the faulting address and still be fully contained in the vma.
>>>> +        */
>>>> +       orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
>>>> +                                         BIT(PMD_ORDER) - 1);
>>>> +       orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>>>> +
>>>> +       if (!orders)
>>>> +               goto fallback;
>>>> +
>>>> +       pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>>> +       if (!pte)
>>>> +               return ERR_PTR(-EAGAIN);
>>>> +
>>>> +       order = first_order(orders);
>>>> +       while (orders) {
>>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>>> +               vmf->pte = pte + pte_index(addr);
>>>> +               if (pte_range_none(vmf->pte, 1 << order))
>>>> +                       break;
>>>> +               order = next_order(&orders, order);
>>>> +       }
>>>> +
>>>> +       vmf->pte = NULL;
>>>> +       pte_unmap(pte);
>>>> +
>>>> +       gfp = vma_thp_gfp_mask(vma);
>>>> +
>>>> +       while (orders) {
>>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>>> +               folio = vma_alloc_folio(gfp, order, vma, addr, true);
>>>> +               if (folio) {
>>>> +                       clear_huge_page(&folio->page, addr, 1 << order);
>>>
>>> Minor.
>>>
>>> Do we have to constantly clear a huge page? Is it possible to let
>>> post_alloc_hook()
>>> finish this job by using __GFP_ZERO/__GFP_ZEROTAGS as
>>> vma_alloc_zeroed_movable_folio() is doing?
> 
> I'm currently following the same allocation pattern as is done for PMD-sized
> THP. In earlier versions of this patch I was trying to be smarter and use the
> __GFP_ZERO/__GFP_ZEROTAGS as you suggest, but I was advised to keep it simple
> and follow the existing pattern.

Yes, this should be optimized on top IMHO.

-- 
Cheers,

David / dhildenb

