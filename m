Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E3E763C93
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjGZQfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjGZQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:35:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1386121
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5538961BC8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 16:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17485C433C7;
        Wed, 26 Jul 2023 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690389335;
        bh=jlbUsxhE1Kw4jT3bQNU5znOmEYFI18LLahkZP9kmWFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VKuDov1k6TPOVrIzj4yFQh0WyZjBJ4dmwDyjr4xm8XBe+nXmozVO+nBcoZlfGFhpF
         SsHFdLZP1USUm3kt8mbHfyWGmCF/cZvzvPEnCJYSvaViBNA3c1k+QPQrpwg/i+embi
         B8vsMI19PAcbZNiratLGgo23mo6Z8/5b+kuxRar8G6CITV7FgeZMGdT71k6CNeiCln
         icBgLdWwBFgz5aKsDpHf3MecXRNOJ53uDLQrg0JKJ4k5vw1UmiPpZlr01tKXamQlUe
         D9XRL0j+CZeZQnqwLTKY2oAN+AJHEYUxjmziOYxWp9KSy08cE1F//WWlACUI/1/sgX
         o+oT5YJcMFFNg==
Date:   Wed, 26 Jul 2023 09:35:33 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] mm: Batch-zap large anonymous folio PTE mappings
Message-ID: <20230726163533.GA1147341@dev-arch.thelio-3990X>
References: <20230720112955.643283-1-ryan.roberts@arm.com>
 <20230720112955.643283-4-ryan.roberts@arm.com>
 <20230726161942.GA1123863@dev-arch.thelio-3990X>
 <188251d8-32c4-846f-8ca9-8a7c635d6172@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <188251d8-32c4-846f-8ca9-8a7c635d6172@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 05:32:07PM +0100, Ryan Roberts wrote:
> On 26/07/2023 17:19, Nathan Chancellor wrote:
> > Hi Ryan,
> > 
> > On Thu, Jul 20, 2023 at 12:29:55PM +0100, Ryan Roberts wrote:
> >> This allows batching the rmap removal with folio_remove_rmap_range(),
> >> which means we avoid spuriously adding a partially unmapped folio to the
> >> deferred split queue in the common case, which reduces split queue lock
> >> contention.
> >>
> >> Previously each page was removed from the rmap individually with
> >> page_remove_rmap(). If the first page belonged to a large folio, this
> >> would cause page_remove_rmap() to conclude that the folio was now
> >> partially mapped and add the folio to the deferred split queue. But
> >> subsequent calls would cause the folio to become fully unmapped, meaning
> >> there is no value to adding it to the split queue.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  mm/memory.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 120 insertions(+)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 01f39e8144ef..189b1cfd823d 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -1391,6 +1391,94 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> >>  	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
> >>  }
> >>  
> >> +static inline unsigned long page_cont_mapped_vaddr(struct page *page,
> >> +				struct page *anchor, unsigned long anchor_vaddr)
> >> +{
> >> +	unsigned long offset;
> >> +	unsigned long vaddr;
> >> +
> >> +	offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
> >> +	vaddr = anchor_vaddr + offset;
> >> +
> >> +	if (anchor > page) {
> >> +		if (vaddr > anchor_vaddr)
> >> +			return 0;
> >> +	} else {
> >> +		if (vaddr < anchor_vaddr)
> >> +			return ULONG_MAX;
> >> +	}
> >> +
> >> +	return vaddr;
> >> +}
> >> +
> >> +static int folio_nr_pages_cont_mapped(struct folio *folio,
> >> +				      struct page *page, pte_t *pte,
> >> +				      unsigned long addr, unsigned long end)
> >> +{
> >> +	pte_t ptent;
> >> +	int floops;
> >> +	int i;
> >> +	unsigned long pfn;
> >> +	struct page *folio_end;
> >> +
> >> +	if (!folio_test_large(folio))
> >> +		return 1;
> >> +
> >> +	folio_end = &folio->page + folio_nr_pages(folio);
> >> +	end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
> >> +	floops = (end - addr) >> PAGE_SHIFT;
> >> +	pfn = page_to_pfn(page);
> >> +	pfn++;
> >> +	pte++;
> >> +
> >> +	for (i = 1; i < floops; i++) {
> >> +		ptent = ptep_get(pte);
> >> +
> >> +		if (!pte_present(ptent) || pte_pfn(ptent) != pfn)
> >> +			break;
> >> +
> >> +		pfn++;
> >> +		pte++;
> >> +	}
> >> +
> >> +	return i;
> >> +}
> >> +
> >> +static unsigned long try_zap_anon_pte_range(struct mmu_gather *tlb,
> >> +					    struct vm_area_struct *vma,
> >> +					    struct folio *folio,
> >> +					    struct page *page, pte_t *pte,
> >> +					    unsigned long addr, int nr_pages,
> >> +					    struct zap_details *details)
> >> +{
> >> +	struct mm_struct *mm = tlb->mm;
> >> +	pte_t ptent;
> >> +	bool full;
> >> +	int i;
> >> +
> >> +	for (i = 0; i < nr_pages;) {
> >> +		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
> >> +		tlb_remove_tlb_entry(tlb, pte, addr);
> >> +		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
> >> +		full = __tlb_remove_page(tlb, page, 0);
> >> +
> >> +		if (unlikely(page_mapcount(page) < 1))
> >> +			print_bad_pte(vma, addr, ptent, page);
> >> +
> >> +		i++;
> >> +		page++;
> >> +		pte++;
> >> +		addr += PAGE_SIZE;
> >> +
> >> +		if (unlikely(full))
> >> +			break;
> >> +	}
> >> +
> >> +	folio_remove_rmap_range(folio, page - i, i, vma);
> >> +
> >> +	return i;
> >> +}
> >> +
> >>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >>  				struct vm_area_struct *vma, pmd_t *pmd,
> >>  				unsigned long addr, unsigned long end,
> >> @@ -1428,6 +1516,38 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >>  			page = vm_normal_page(vma, addr, ptent);
> >>  			if (unlikely(!should_zap_page(details, page)))
> >>  				continue;
> >> +
> >> +			/*
> >> +			 * Batch zap large anonymous folio mappings. This allows
> >> +			 * batching the rmap removal, which means we avoid
> >> +			 * spuriously adding a partially unmapped folio to the
> >> +			 * deferrred split queue in the common case, which
> >> +			 * reduces split queue lock contention.
> >> +			 */
> >> +			if (page && PageAnon(page)) {
> >> +				struct folio *folio = page_folio(page);
> >> +				int nr_pages_req, nr_pages;
> >> +
> >> +				nr_pages_req = folio_nr_pages_cont_mapped(
> >> +						folio, page, pte, addr, end);
> >> +
> >> +				nr_pages = try_zap_anon_pte_range(tlb, vma,
> >> +						folio, page, pte, addr,
> >> +						nr_pages_req, details);
> >> +
> >> +				rss[mm_counter(page)] -= nr_pages;
> >> +				nr_pages--;
> >> +				pte += nr_pages;
> >> +				addr += nr_pages << PAGE_SHIFT;
> >> +
> >> +				if (unlikely(nr_pages < nr_pages_req)) {
> >> +					force_flush = 1;
> >> +					addr += PAGE_SIZE;
> >> +					break;
> >> +				}
> >> +				continue;
> >> +			}
> >> +
> >>  			ptent = ptep_get_and_clear_full(mm, addr, pte,
> >>  							tlb->fullmm);
> >>  			tlb_remove_tlb_entry(tlb, pte, addr);
> >> -- 
> >> 2.25.1
> >>
> > 
> > After this change in -next as commit 904d9713b3b0 ("mm: batch-zap large
> > anonymous folio PTE mappings"), I see the following splats several times
> > when booting Debian's s390x configuration (which I have mirrored at [1])
> > in QEMU (bisect log below):
> 
> Thanks for the bug report and sorry for the inconvenience. I'm going to need a
> little time to figure out a build environment for s390x and get it reproducing.
> Hopefully I can come back to you tomorrow with a fix.

No worries! For what it's worth, if you are not already aware of it,
there are GCC toolchains on kernel.org, which is what I use in general
and in this particular case:

https://kernel.org/pub/tools/crosstool/

You can just download them to somewhere on your drive then use
CROSS_COMPILE=.../bin/s390-linux-gnu-, rather than downloading a bunch
of distribution packages.

Cheers,
Nathan

For what it's worth, I just use the GCC toolchains that are on
kernel.org:


