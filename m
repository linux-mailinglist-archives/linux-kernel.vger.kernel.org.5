Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D5680EF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376435AbjLLPCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346684AbjLLPCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1D5ED
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702393362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=pd+2BJ89l5gV7XQZROFyWY0zE3vo5AEgALgsi5pHZ+A=;
        b=Lpm6uXwT+sI1GibXwZRjEoG7jM6OxgzrVuh60VpliSQZso8G20DVcn0dZydDQsnYznqrWC
        toCyaoISk3emPrvzphsMjqN95UGEG3Wv5UQ5d0rSEa1D3kh+fPRU4m5gKTxC+x7H//qDsV
        RViM49fsv+t0xJYreDV8WwkRABNFwY0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-WK0QGqJFOvKUaZUdfOdzIw-1; Tue, 12 Dec 2023 10:02:40 -0500
X-MC-Unique: WK0QGqJFOvKUaZUdfOdzIw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50bfae5b114so5056764e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393359; x=1702998159;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd+2BJ89l5gV7XQZROFyWY0zE3vo5AEgALgsi5pHZ+A=;
        b=KJLAT4rQIFdEiVJXRvbua3BSF5tbJgToO8PGS88CpoDi6UNKiwC0sa1x4uN4+LOTOs
         tCNAVU+FtXYi9c/NL3FAnRYcG6QpKk00D//P+bzIX/auq9OR5oCIenxvtaXbBRrBnM0F
         O1OrUO3TVzAdlvHkvNwktXh2zzGNxypVha1CeqlGwojzXbW404Zi8O1cgZ0xSIAGbP2f
         HbDFOG43tV5nNyMdLnbvW3IY2/43D8+y/h7Gfn0t+0sp9Zr/Kvr2mVA8YrUld3FJFE+0
         /6cRFctokThBLdrEu7R99S7sOnK8CJph2G9p9Znq9Xc4R915fCnKVpwjHquPdEkk+EVR
         Wekw==
X-Gm-Message-State: AOJu0YzpEQLOD7cWNKW9xtnAANY6kVceoI//VbrMtILPoUaki0J2iHGZ
        EHK+DoUlh8MsmGDyNV7uQ1ChI6eYlzfBWEMq8KBwuBlgevX8rxO8MvnbUuSEBI20+j4PdM7KdtB
        pQ+Cd1loJAZ/rz92zie3SDqel
X-Received: by 2002:ac2:424d:0:b0:50b:f864:dbab with SMTP id m13-20020ac2424d000000b0050bf864dbabmr1194299lfl.237.1702393358787;
        Tue, 12 Dec 2023 07:02:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM2E9EYPBMSZqa4AVbro5zznKGu3v1rbt6OU/+Dh3D93lvE2ucox7XLK9HXTt1RRk+6+M9ww==
X-Received: by 2002:ac2:424d:0:b0:50b:f864:dbab with SMTP id m13-20020ac2424d000000b0050bf864dbabmr1194293lfl.237.1702393358346;
        Tue, 12 Dec 2023 07:02:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:ca00:4ca2:ff2c:9092:f070? (p200300cbc74bca004ca2ff2c9092f070.dip0.t-ipconnect.de. [2003:cb:c74b:ca00:4ca2:ff2c:9092:f070])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600c450b00b0040c495b1c90sm6451920wmo.11.2023.12.12.07.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 07:02:37 -0800 (PST)
Message-ID: <2bebcf33-e8b7-468d-86cc-31d6eb355b66@redhat.com>
Date:   Tue, 12 Dec 2023 16:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-5-ryan.roberts@arm.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231207161211.2374093-5-ryan.roberts@arm.com>
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

On 07.12.23 17:12, Ryan Roberts wrote:
> Introduce the logic to allow THP to be configured (through the new sysfs
> interface we just added) to allocate large folios to back anonymous
> memory, which are larger than the base page size but smaller than
> PMD-size. We call this new THP extension "multi-size THP" (mTHP).
> 
> mTHP continues to be PTE-mapped, but in many cases can still provide
> similar benefits to traditional PMD-sized THP: Page faults are
> significantly reduced (by a factor of e.g. 4, 8, 16, etc. depending on
> the configured order), but latency spikes are much less prominent
> because the size of each page isn't as huge as the PMD-sized variant and
> there is less memory to clear in each page fault. The number of per-page
> operations (e.g. ref counting, rmap management, lru list management) are
> also significantly reduced since those ops now become per-folio.

I'll note that with always-pte-mapped-thp it will be much easier to support
incremental page clearing (e.g., zero only parts of the folio and map the
remainder in a pro-non-like fashion whereby we'll zero on the next page fault).
With a PMD-sized thp, you have to eventually place/rip out page tables to
achieve that.

> 
> Some architectures also employ TLB compression mechanisms to squeeze
> more entries in when a set of PTEs are virtually and physically
> contiguous and approporiately aligned. In this case, TLB misses will
> occur less often.
> 
> The new behaviour is disabled by default, but can be enabled at runtime
> by writing to /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled
> (see documentation in previous commit). The long term aim is to change
> the default to include suitable lower orders, but there are some risks
> around internal fragmentation that need to be better understood first.
> 
> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   include/linux/huge_mm.h |   6 ++-
>   mm/memory.c             | 111 ++++++++++++++++++++++++++++++++++++----
>   2 files changed, 106 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 609c153bae57..fa7a38a30fc6 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
>   #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)

[...]

> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	unsigned long orders;
> +	struct folio *folio;
> +	unsigned long addr;
> +	pte_t *pte;
> +	gfp_t gfp;
> +	int order;
> +
> +	/*
> +	 * If uffd is active for the vma we need per-page fault fidelity to
> +	 * maintain the uffd semantics.
> +	 */
> +	if (unlikely(userfaultfd_armed(vma)))
> +		goto fallback;
> +
> +	/*
> +	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
> +	 * for this vma. Then filter out the orders that can't be allocated over
> +	 * the faulting address and still be fully contained in the vma.
> +	 */
> +	orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
> +					  BIT(PMD_ORDER) - 1);
> +	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
> +
> +	if (!orders)
> +		goto fallback;
> +
> +	pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> +	if (!pte)
> +		return ERR_PTR(-EAGAIN);
> +
> +	/*
> +	 * Find the highest order where the aligned range is completely
> +	 * pte_none(). Note that all remaining orders will be completely
> +	 * pte_none().
> +	 */
> +	order = highest_order(orders);
> +	while (orders) {
> +		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> +		if (pte_range_none(pte + pte_index(addr), 1 << order))
> +			break;
> +		order = next_order(&orders, order);
> +	}
> +
> +	pte_unmap(pte);
> +
> +	/* Try allocating the highest of the remaining orders. */
> +	gfp = vma_thp_gfp_mask(vma);
> +	while (orders) {
> +		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> +		folio = vma_alloc_folio(gfp, order, vma, addr, true);
> +		if (folio) {
> +			clear_huge_page(&folio->page, vmf->address, 1 << order);
> +			return folio;
> +		}
> +		order = next_order(&orders, order);
> +	}
> +
> +fallback:
> +	return vma_alloc_zeroed_movable_folio(vma, vmf->address);
> +}
> +#else
> +#define alloc_anon_folio(vmf) \
> +		vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->address)
> +#endif

A neater alternative might be

static struct folio *alloc_anon_folio(struct vm_fault *vmf)
{
#ifdef CONFIG_TRANSPARENT_HUGEPAGE
	/* magic */
fallback:
#endif
	return vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->address):
}

[...]

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

