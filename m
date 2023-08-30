Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB33278DF08
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243537AbjH3TNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245308AbjH3PIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:08:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75DAB8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qx6Hv03afYO2DcF1Co9RrVZaNbveLy1N2Smbr7cXGis=; b=Q19sOrtXU8MwQtRgcv5PdRPXVd
        ddLPWPMW4gFp2vQJueb1aicAe0VpSkCfd0ZSS+wHSXnIqP3YArq6Z5otRt3oHf+D3l4Kmb/UHj80q
        MwOuooHpWhFTZM4BEODK0tlxw3leCBja7a/f/8BIwIo3QtvhdJS8hEFHbiJ/c34Y4L1i0srn26Nul
        3J0IKX2ds+9SU94MLd3h/F/BQcqr674y9mxOpwpSEF+PpF1gYe3Xs2kbAMBe9kHi8awry/9ZfKIeY
        HNR+txmBfCS8yS+hnxf10DDhUuzNmBtpHiH3+dV5NpgI2MHxKsH+6pyDgJFM/c07v4IWf6xz0Tp5a
        ChGzQuTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qbMmf-00DQtC-B6; Wed, 30 Aug 2023 15:07:05 +0000
Date:   Wed, 30 Aug 2023 16:07:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] mm/mmu_gather: Store and process pages in contig
 ranges
Message-ID: <ZO9bGbsrveOIyeAA@casper.infradead.org>
References: <20230830095011.1228673-1-ryan.roberts@arm.com>
 <20230830095011.1228673-6-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830095011.1228673-6-ryan.roberts@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:50:11AM +0100, Ryan Roberts wrote:
> +++ b/include/asm-generic/tlb.h
> @@ -246,11 +246,11 @@ struct mmu_gather_batch {
>  	struct mmu_gather_batch	*next;
>  	unsigned int		nr;
>  	unsigned int		max;
> -	struct page		*pages[];
> +	struct pfn_range	folios[];

I think it's dangerous to call this 'folios' as it lets you think that
each entry is a single folio.  But as I understand this patch, you can
coagulate contiguous ranges across multiple folios.

> -void free_pages_and_swap_cache(struct page **pages, int nr)
> +void free_folios_and_swap_cache(struct pfn_range *folios, int nr)
>  {
>  	lru_add_drain();
>  	for (int i = 0; i < nr; i++)
> -		free_swap_cache(pages[i]);
> -	release_pages(pages, nr);
> +		free_swap_cache(pfn_to_page(folios[i].start));

... but here, you only put the swapcache for the first folio covered by
the range, not for each folio.

> +	folios_put_refs(folios, nr);

It's kind of confusing to have folios_put() which takes a struct folio *
and then folios_put_refs() which takes a struct pfn_range *.
pfn_range_put()?
