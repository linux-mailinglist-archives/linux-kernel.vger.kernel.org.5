Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E0C75672C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjGQPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGQPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:08:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413CE10A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FJkSRlbAeg25OoqNJbBYzrKlW5abpmAKEGRQ5wp9m/c=; b=i7uXwN53gJ7/TWcMQ7ax1brcRZ
        X97cwzXOome2gz1cGC1Ti+JSjx4ULqsRRZ8CMtlgskl7e1oRbHszVktBmmlowPyp6wqEZrIMXSpz6
        Hub85H6Oejj6R4Wu9KOdPYIZC95EWoE0nz2PgsbYRKD+gxMlYW3RKQ7Pq/zb9s7qPGS6tYoBcFxy+
        kd2K2tboShXKJ9qY5fOZT+pI4USgLoRdkl46wlyQ6d6DOY63QEcpDSkZF5cqXMvlUBYj1u8ZO/Out
        WJae5/mCI0Tu7tpX3VTg/GwahqzFR8sChFZI8Smm/sB6+uZy9uxgTGTbYOZJDqvadRMBOUcCSk5WX
        qWgIDfPg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLPpO-0041Jy-Fb; Mon, 17 Jul 2023 15:07:58 +0000
Date:   Mon, 17 Jul 2023 16:07:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 2/3] mm: Implement folio_remove_rmap_range()
Message-ID: <ZLVZTupQXt7pAqt8@casper.infradead.org>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-3-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717143110.260162-3-ryan.roberts@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 03:31:09PM +0100, Ryan Roberts wrote:
> +/*
> + * folio_remove_rmap_range - take down pte mappings from a range of pages
> + * belonging to a folio. All pages are accounted as small pages.
> + * @folio:	folio that all pages belong to
> + * @page:       first page in range to remove mapping from
> + * @nr:		number of pages in range to remove mapping from
> + * @vma:        the vm area from which the mapping is removed
> + *
> + * The caller needs to hold the pte lock.
> + */

This could stand a little reworking.  How about this?

/**
 * folio_remove_rmap_range - Take down PTE mappings from a range of pages.
 * @folio: Folio containing all pages in range.
 * @page: First page in range to unmap.
 * @nr: Number of pages to unmap.
 * @vma: The VM area containing the range.
 *
 * All pages in the range must belong to the same VMA & folio.  They
 * must be mapped with PTEs, not a PMD.
 *
 * Context: Caller holds the pte lock.
 */

> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
> +					int nr, struct vm_area_struct *vma)
> +{
> +	atomic_t *mapped = &folio->_nr_pages_mapped;
> +	int nr_unmapped = 0;
> +	int nr_mapped;
> +	bool last;
> +	enum node_stat_item idx;
> +
> +	if (unlikely(folio_test_hugetlb(folio))) {
> +		VM_WARN_ON_FOLIO(1, folio);
> +		return;
> +	}
> +
> +	if (!folio_test_large(folio)) {
> +		/* Is this the page's last map to be removed? */
> +		last = atomic_add_negative(-1, &page->_mapcount);
> +		nr_unmapped = last;
> +	} else {
> +		for (; nr != 0; nr--, page++) {
> +			/* Is this the page's last map to be removed? */
> +			last = atomic_add_negative(-1, &page->_mapcount);
> +			if (last) {
> +				/* Page still mapped if folio mapped entirely */
> +				nr_mapped = atomic_dec_return_relaxed(mapped);

We're still doing one atomic op per page on the folio's nr_pages_mapped
... is it possible to batch this and use atomic_sub_return_relaxed()?

