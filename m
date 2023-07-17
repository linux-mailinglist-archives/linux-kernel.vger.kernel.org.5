Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B5375684A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGQPte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjGQPtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:49:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81CA0E7F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:49:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F01FC15;
        Mon, 17 Jul 2023 08:50:05 -0700 (PDT)
Received: from [10.57.76.30] (unknown [10.57.76.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCFC43F738;
        Mon, 17 Jul 2023 08:49:20 -0700 (PDT)
Message-ID: <adac1493-da6d-4581-b8b1-e5911b68cdd7@arm.com>
Date:   Mon, 17 Jul 2023 16:49:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/3] mm: Implement folio_remove_rmap_range()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-3-ryan.roberts@arm.com>
 <ZLVZTupQXt7pAqt8@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZLVZTupQXt7pAqt8@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 16:07, Matthew Wilcox wrote:
> On Mon, Jul 17, 2023 at 03:31:09PM +0100, Ryan Roberts wrote:
>> +/*
>> + * folio_remove_rmap_range - take down pte mappings from a range of pages
>> + * belonging to a folio. All pages are accounted as small pages.
>> + * @folio:	folio that all pages belong to
>> + * @page:       first page in range to remove mapping from
>> + * @nr:		number of pages in range to remove mapping from
>> + * @vma:        the vm area from which the mapping is removed
>> + *
>> + * The caller needs to hold the pte lock.
>> + */
> 
> This could stand a little reworking.  How about this?
> 
> /**
>  * folio_remove_rmap_range - Take down PTE mappings from a range of pages.
>  * @folio: Folio containing all pages in range.
>  * @page: First page in range to unmap.
>  * @nr: Number of pages to unmap.
>  * @vma: The VM area containing the range.
>  *
>  * All pages in the range must belong to the same VMA & folio.  They
>  * must be mapped with PTEs, not a PMD.
>  *
>  * Context: Caller holds the pte lock.
>  */

LGTM! thanks.

> 
>> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
>> +					int nr, struct vm_area_struct *vma)
>> +{
>> +	atomic_t *mapped = &folio->_nr_pages_mapped;
>> +	int nr_unmapped = 0;
>> +	int nr_mapped;
>> +	bool last;
>> +	enum node_stat_item idx;
>> +
>> +	if (unlikely(folio_test_hugetlb(folio))) {
>> +		VM_WARN_ON_FOLIO(1, folio);
>> +		return;
>> +	}
>> +
>> +	if (!folio_test_large(folio)) {
>> +		/* Is this the page's last map to be removed? */
>> +		last = atomic_add_negative(-1, &page->_mapcount);
>> +		nr_unmapped = last;
>> +	} else {
>> +		for (; nr != 0; nr--, page++) {
>> +			/* Is this the page's last map to be removed? */
>> +			last = atomic_add_negative(-1, &page->_mapcount);
>> +			if (last) {
>> +				/* Page still mapped if folio mapped entirely */
>> +				nr_mapped = atomic_dec_return_relaxed(mapped);
> 
> We're still doing one atomic op per page on the folio's nr_pages_mapped
> ... is it possible to batch this and use atomic_sub_return_relaxed()?

Good spot, something like this:

	} else {
		for (; nr != 0; nr--, page++) {
			/* Is this the page's last map to be removed? */
			last = atomic_add_negative(-1, &page->_mapcount);
			if (last)
				nr_unmapped++;
		}

		/* Pages still mapped if folio mapped entirely */
		nr_mapped = atomic_sub_return_relaxed(nr_unmapped, mapped);
		if (nr_mapped >= COMPOUND_MAPPED)
			nr_unmapped = 0;
	}


