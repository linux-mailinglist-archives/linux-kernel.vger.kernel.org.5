Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342EF7AE1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjIYWWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIYWWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:22:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D6E107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=igN5+zK37ol5ClF0Mp4pRyBssbWi6Pl+w3dqFJhRiHw=; b=qRqa4eH3r6DVlOYQBhH0CMCIxQ
        03OwsKs7lVSp0WqBKvCeNU/d+D9ZSa2gMf0LvOQ6PKyquIpznVHy4ZU3cmvg7LQiV5VJePGAVl/8K
        0N6rjZBsdz6YxRY1WebwWCefITT5jmBEmUFDqKyz5An1QMlsZEGWGRLR3LI5GK8sgl7SDd2rvapl2
        p4BZKSE37glpKUG1WXAo6r9eBMt9mfXg5qLqMtnHeruwfnQFusFKQWvS47iyvg9tQ9BFzOV2JuJEQ
        sowiU/pz8uO145PBBou+Yu6aH7C/6Nw4tH8UR9VQUFwf1Y7+hpdc+RQGnGY/JkKlgVa9/KoD1ouZw
        Sw6mfEAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qktyC-0040bK-Op; Mon, 25 Sep 2023 22:22:24 +0000
Date:   Mon, 25 Sep 2023 23:22:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 03/12] mempolicy: fix migrate_pages(2) syscall return
 nr_failed
Message-ID: <ZRIIIFm5IMnkGh3T@casper.infradead.org>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
 <ddad2cee-cbad-7b5d-935a-59f961b7c3a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddad2cee-cbad-7b5d-935a-59f961b7c3a@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:24:02AM -0700, Hugh Dickins wrote:
> "man 2 migrate_pages" says "On success migrate_pages() returns the number
> of pages that could not be moved".  Although 5.3 and 5.4 commits fixed
> mbind(MPOL_MF_STRICT|MPOL_MF_MOVE*) to fail with EIO when not all pages
> could be moved (because some could not be isolated for migration),
> migrate_pages(2) was left still reporting only those pages failing at the
> migration stage, forgetting those failing at the earlier isolation stage.
> 
> Fix that by accumulating a long nr_failed count in struct queue_pages,
> returned by queue_pages_range() when it's not returning an error, for
> adding on to the nr_failed count from migrate_pages() in mm/migrate.c.
> A count of pages?  It's more a count of folios, but changing it to pages
> would entail more work (also in mm/migrate.c): does not seem justified.

I certainly see what you're saying.  If a folio is only partially mapped
(in an extreme case, the VMA is PAGE_SIZE and maps one page of a 512-page
folio), then setting nr_failed to folio_nr_pages() is misleading at best.

> +static void queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>  				unsigned long end, struct mm_walk *walk)
> -	__releases(ptl)
>  {
> -	int ret = 0;
>  	struct folio *folio;
>  	struct queue_pages *qp = walk->private;
> -	unsigned long flags;
>  
>  	if (unlikely(is_pmd_migration_entry(*pmd))) {
> -		ret = -EIO;
> -		goto unlock;
> +		qp->nr_failed++;
> +		return;
>  	}
>  	folio = pfn_folio(pmd_pfn(*pmd));
>  	if (is_huge_zero_page(&folio->page)) {
>  		walk->action = ACTION_CONTINUE;
> -		goto unlock;
> +		return;
>  	}
>  	if (!queue_folio_required(folio, qp))
> -		goto unlock;
> -
> -	flags = qp->flags;
> -	/* go to folio migration */
> -	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> -		if (!vma_migratable(walk->vma) ||
> -		    migrate_folio_add(folio, qp->pagelist, flags)) {
> -			ret = 1;
> -			goto unlock;
> -		}
> -	} else
> -		ret = -EIO;
> -unlock:
> -	spin_unlock(ptl);
> -	return ret;
> +		return;
> +	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
> +	    !vma_migratable(walk->vma) ||
> +	    !migrate_folio_add(folio, qp->pagelist, qp->flags))
> +		qp->nr_failed++;

However, I think here, we would do well to increment by HPAGE_PMD_NR.
Or whatever equivalent is flavour of the week.

Bravo to the other changes.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
