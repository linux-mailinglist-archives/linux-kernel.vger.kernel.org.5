Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6493079872A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbjIHMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjIHMjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:39:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D431BD3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xCpYqtznfwbFxqa9emaame4xf/442knA7YwfsM5Nb38=; b=kB5bXns9t0q+gY9eZbUlQaiRpV
        Gj7MzWSasDOMgn74WG5UGcn7mGR9iYrqujeEFHw92vhUN3yBd8+9cLbmAsUJkVddTrSAjtnugCERy
        4+9lvmP/hKyTqQqG2aWUiPmOc/vtc7wdvsDb/X17gN/vgODy1q7cu2gY+yHiSvnve/1y6sem+UHii
        /D7gMozVR0t00DQXlQFIUXLSnOfXNi+BBiZqM41M7W9ifxb0jz8msaUpvCGZhwPUR8LwbAoREatuo
        gDXkmsia3RiWbLQKaXex6sSOVyDtsgM24NgQQcWO0oPX9v+C2OJ5sz+k3t5EfVQqbywwGrh0fFXYV
        J+h/JZLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeake-0009AV-0H; Fri, 08 Sep 2023 12:38:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7451300472; Fri,  8 Sep 2023 14:38:19 +0200 (CEST)
Date:   Fri, 8 Sep 2023 14:38:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 6/9] x86/clear_huge_page: multi-page clearing
Message-ID: <20230908123819.GB19320@noisy.programming.kicks-ass.net>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-7-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830184958.2333078-7-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:49:55AM -0700, Ankur Arora wrote:

> +#ifndef CONFIG_HIGHMEM

I'm thinking this wants to be: #ifdef CONFIG_X86_64. All the previous
stuff was 64bit specific.

> +static void clear_contig_region(struct page *page, unsigned int npages)
> +{
> +	clear_pages(page_address(page), npages);
> +}

I'm not sure about the naming of this helper -- but whatever.

> +
> +/*
> + * clear_huge_page(): multi-page clearing variant of clear_huge_page().
> + *
> + * Taking inspiration from the common code variant, we split the zeroing in
> + * three parts: left of the fault, right of the fault, and up to 5 pages
> + * in the immediate neighbourhood of the target page.
> + *
> + * Cleared in that order to keep cache lines of the target region hot.
> + *
> + * For gigantic pages, there is no expectation of cache locality so we do a
> + * straight zeroing.
> + */
> +void clear_huge_page(struct page *page,
> +		     unsigned long addr_hint, unsigned int pages_per_huge_page)
> +{
> +	unsigned long addr = addr_hint &
> +		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
> +	const long pgidx = (addr_hint - addr) / PAGE_SIZE;
> +	const int first_pg = 0, last_pg = pages_per_huge_page - 1;
> +	const int width = 2; /* pages cleared last on either side */
> +	int sidx[3], eidx[3];
> +	int i, n;
> +
> +	if (pages_per_huge_page > MAX_ORDER_NR_PAGES)
> +		return clear_contig_region(page, pages_per_huge_page);
> +
> +	/*
> +	 * Neighbourhood of the fault. Cleared at the end to ensure
> +	 * it sticks around in the cache.
> +	 */
> +	n = 2;
> +	sidx[n] = (pgidx - width) < first_pg ? first_pg : (pgidx - width);
> +	eidx[n] = (pgidx + width) > last_pg  ? last_pg  : (pgidx + width);
> +
> +	sidx[0] = first_pg;	/* Region to the left of the fault */
> +	eidx[0] = sidx[n] - 1;
> +
> +	sidx[1] = eidx[n] + 1;	/* Region to the right of the fault */
> +	eidx[1] = last_pg;
> +
> +	for (i = 0; i <= 2; i++) {
> +		if (eidx[i] >= sidx[i])
> +			clear_contig_region(page + sidx[i],
> +					    eidx[i] - sidx[i] + 1);

Since the if has a multi-line statement it needs { } per coding style.

> +	}
> +}
> +#endif /* CONFIG_HIGHMEM */
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
>  #ifdef CONFIG_X86_64
> -- 
> 2.31.1
> 
