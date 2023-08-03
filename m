Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BDE76EAE4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjHCNoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjHCNnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202DA59E8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691069894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4LdCOYEIp5EKMcN/eAa9kzzi2QRfegY2bb0j77Ga9CQ=;
        b=blCzPpQx7pe8i70z8ymiy96SMnGlZzi5UfhR76V3Nmofp0FL5EzoCE45cHRCMC0Ar2iwBZ
        qhQNVzUeBU8oPHy9MzL999TFfjm64jD8zAMi52r+mVaArWYulwHLcStBR4mwLEeTOGp0DR
        4YrFD002npfCKV6tfzI+uPDjDxBrwjc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-sf3BnlxnMqSaGSfFpNfT2A-1; Thu, 03 Aug 2023 09:38:13 -0400
X-MC-Unique: sf3BnlxnMqSaGSfFpNfT2A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe210c47acso6068355e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691069892; x=1691674692;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LdCOYEIp5EKMcN/eAa9kzzi2QRfegY2bb0j77Ga9CQ=;
        b=N/xz3B0x77mQvjkYlIUzdSb02ixr303B10o/LzSRPlHspNGeURyG2U3wBzIZhSHBrG
         ppuSF3Rsb/9EIYOhMkig5GiQUpm3qQwywvyqDi7n87j1tzCLIWKhjVyej4hLyQHPGn+K
         LnG+Plbz1jiDOAAgLqjaiv9kt9kkeaisXl1jJf74ZgEoZ9kOujwiDSu5krcCJDOs484T
         iKF/gOAXpeV/a+ppkbC2aoeeQLwyjX/rPiBULub/F4WpQ9abnE+W1vvcWhLbAerEnCLz
         j3+G+Xq+Mfk3p/MyjovIzwvrPxYbKzmo1RsxHRtDvucKCJ4WlzjZAQ1XAbhOmZkMQHZh
         ylHw==
X-Gm-Message-State: ABy/qLY5Y7VsijGmm8GkmTDLFcm7qpbjMq1BUMFgknnvU2+uI7eC3+a5
        pi1Cwr6Fgjac/7hkkSXmYdf7NuOkkRzlak7yd4g6OELpn+wrVIfX9EbJS2wy85JjC6viLPeDVSd
        VEb13d80gM/y6vTCVTFHGaihv
X-Received: by 2002:a1c:f70f:0:b0:3fe:1f80:7d92 with SMTP id v15-20020a1cf70f000000b003fe1f807d92mr7553916wmh.8.1691069892390;
        Thu, 03 Aug 2023 06:38:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE5zo8NVBdJ99WdYuTitMtVNIGysr42vSLSInOY1ml9vS6uWQFfAhmIUWYV3tm0hhlXpmN+KQ==
X-Received: by 2002:a1c:f70f:0:b0:3fe:1f80:7d92 with SMTP id v15-20020a1cf70f000000b003fe1f807d92mr7553891wmh.8.1691069891987;
        Thu, 03 Aug 2023 06:38:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9a00:a5f5:5315:b9fa:64df? (p200300cbc7189a00a5f55315b9fa64df.dip0.t-ipconnect.de. [2003:cb:c718:9a00:a5f5:5315:b9fa:64df])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b003145559a691sm21890432wrs.41.2023.08.03.06.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:38:11 -0700 (PDT)
Message-ID: <6cda91b3-bb7a-4c4c-a618-2572b9c8bbf9@redhat.com>
Date:   Thu, 3 Aug 2023 15:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/3] mm: Batch-zap large anonymous folio PTE mappings
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230727141837.3386072-1-ryan.roberts@arm.com>
 <20230727141837.3386072-4-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230727141837.3386072-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.23 16:18, Ryan Roberts wrote:
> This allows batching the rmap removal with folio_remove_rmap_range(),
> which means we avoid spuriously adding a partially unmapped folio to the
> deferred split queue in the common case, which reduces split queue lock
> contention.
> 
> Previously each page was removed from the rmap individually with
> page_remove_rmap(). If the first page belonged to a large folio, this
> would cause page_remove_rmap() to conclude that the folio was now
> partially mapped and add the folio to the deferred split queue. But
> subsequent calls would cause the folio to become fully unmapped, meaning
> there is no value to adding it to the split queue.
> 
> A complicating factor is that for platforms where MMU_GATHER_NO_GATHER
> is enabled (e.g. s390), __tlb_remove_page() drops a reference to the
> page. This means that the folio reference count could drop to zero while
> still in use (i.e. before folio_remove_rmap_range() is called). This
> does not happen on other platforms because the actual page freeing is
> deferred.
> 
> Solve this by appropriately getting/putting the folio to guarrantee it
> does not get freed early. Given the need to get/put the folio in the
> batch path, we stick to the non-batched path if the folio is not large.
> While the batched path is functionally correct for a folio with 1 page,
> it is unlikely to be as efficient as the existing non-batched path in
> this case.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   mm/memory.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 132 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 01f39e8144ef..d35bd8d2b855 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1391,6 +1391,99 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>   	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>   }
>   
> +static inline unsigned long page_cont_mapped_vaddr(struct page *page,
> +				struct page *anchor, unsigned long anchor_vaddr)
> +{
> +	unsigned long offset;
> +	unsigned long vaddr;
> +
> +	offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
> +	vaddr = anchor_vaddr + offset;
> +
> +	if (anchor > page) {
> +		if (vaddr > anchor_vaddr)
> +			return 0;
> +	} else {
> +		if (vaddr < anchor_vaddr)
> +			return ULONG_MAX;
> +	}
> +
> +	return vaddr;
> +}
> +
> +static int folio_nr_pages_cont_mapped(struct folio *folio,
> +				      struct page *page, pte_t *pte,
> +				      unsigned long addr, unsigned long end)
> +{
> +	pte_t ptent;
> +	int floops;
> +	int i;
> +	unsigned long pfn;
> +	struct page *folio_end;
> +
> +	if (!folio_test_large(folio))
> +		return 1;
> +
> +	folio_end = &folio->page + folio_nr_pages(folio);
> +	end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
> +	floops = (end - addr) >> PAGE_SHIFT;
> +	pfn = page_to_pfn(page);
> +	pfn++;
> +	pte++;
> +
> +	for (i = 1; i < floops; i++) {
> +		ptent = ptep_get(pte);
> +
> +		if (!pte_present(ptent) || pte_pfn(ptent) != pfn)
> +			break;
> +
> +		pfn++;
> +		pte++;
> +	}
> +
> +	return i;
> +}
> +
> +static unsigned long try_zap_anon_pte_range(struct mmu_gather *tlb,
> +					    struct vm_area_struct *vma,
> +					    struct folio *folio,
> +					    struct page *page, pte_t *pte,
> +					    unsigned long addr, int nr_pages,
> +					    struct zap_details *details)
> +{
> +	struct mm_struct *mm = tlb->mm;
> +	pte_t ptent;
> +	bool full;
> +	int i;
> +
> +	/* __tlb_remove_page may drop a ref; prevent going to 0 while in use. */
> +	folio_get(folio);

Is there no way around that? It feels wrong and IMHO a bit ugly.

With this patch, you'll might suddenly have mapcount > refcount for a 
folio, or am I wrong?

> +
> +	for (i = 0; i < nr_pages;) {
> +		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
> +		tlb_remove_tlb_entry(tlb, pte, addr);
> +		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
> +		full = __tlb_remove_page(tlb, page, 0);
> +
> +		if (unlikely(page_mapcount(page) < 1))
> +			print_bad_pte(vma, addr, ptent, page);

Can we avoid new users of page_mapcount() outside rmap code, please? :)

-- 
Cheers,

David / dhildenb

