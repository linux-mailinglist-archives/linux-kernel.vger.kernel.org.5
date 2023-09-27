Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A44C7AFD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjI0IEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjI0IEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:04:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6186D11D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801873; x=1727337873;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=4ssXfO+y2+JpAP312sZUv6BF1d72CXPnupgjhUbSN5M=;
  b=DpQopCij2ELiaQxr6M11WiuvzO5lIBIHxiAPUI+y0TN7/9WA2cwoh9f2
   MTqyNpZxedy0T0InQ0T7P6+SNmpIGjPXM8iUbBNTFbP0OaMMv52UqsHRz
   tFNZ7kHFftwIHS+gB8rukP3sbioI7zpE8U2Wyn16UVLdIXv6CeCSeqmXw
   Xgg6XEermfMC8Ro7JqljHJstXlTHDNtr7lf45mci+RjNCSVhtCKoTH5WI
   sX6PXuZ2AAqVS9/KatY1v4FU7f31ZB2SOE6jcQD/6z6J15rJwvv/OtbQZ
   xC5MwL4N+ClsZ7O1cEJ582xkNwv02x55gUnD2WsqyDXQf70Fu3JHfcCZ6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384544671"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="384544671"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 01:04:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="749100752"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="749100752"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 01:04:27 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
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
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
        <ddad2cee-cbad-7b5d-935a-59f961b7c3a@google.com>
Date:   Wed, 27 Sep 2023 16:02:19 +0800
In-Reply-To: <ddad2cee-cbad-7b5d-935a-59f961b7c3a@google.com> (Hugh Dickins's
        message of "Mon, 25 Sep 2023 01:24:02 -0700 (PDT)")
Message-ID: <87sf70rqlw.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hughd@google.com> writes:

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
>
> queue_pages_range() itself should only return -EIO in the "strictly
> unmovable" case (STRICT without any MOVEs): in that case it's best to
> break out as soon as nr_failed gets set; but otherwise it should continue
> to isolate pages for MOVing even when nr_failed - as the mbind(2) manpage
> promises.  This fixes mbind(MPOL_MF_STRICT|MPOL_MF_MOVE*) behavior left
> over from 5.3 and 5.4, and the recent syzbot need for vma_start_write()
> before mbind_range(): but both of those may be fixed by smaller patches.
>
> There's a case when nr_failed should be incremented when it was missed:
> queue_folios_pte_range() and queue_folios_hugetlb() count the transient
> migration entries, like queue_folios_pmd() already did.  And there's a
> case when nr_failed should not be incremented when it would have been:
> in meeting later PTEs of the same large folio, which can only be isolated
> once: fixed by recording the current large folio in struct queue_pages.
>
> Clean up the affected functions, fixing or updating many comments.  Bool
> migrate_folio_add(), without -EIO: true if adding, or if skipping shared
> (but its arguable folio_estimated_sharers() heuristic left unchanged).
> Use MPOL_MF_WRLOCK flag to queue_pages_range(), instead of bool lock_vma.
> Use explicit STRICT|MOVE* flags where queue_pages_test_walk() checks for
> skipping, instead of hiding them behind MPOL_MF_VALID.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/mempolicy.c | 322 +++++++++++++++++++++++--------------------------
>  1 file changed, 149 insertions(+), 173 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..937386409c28 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -111,7 +111,8 @@
>  
>  /* Internal flags */
>  #define MPOL_MF_DISCONTIG_OK (MPOL_MF_INTERNAL << 0)	/* Skip checks for continuous vmas */
> -#define MPOL_MF_INVERT (MPOL_MF_INTERNAL << 1)		/* Invert check for nodemask */
> +#define MPOL_MF_INVERT       (MPOL_MF_INTERNAL << 1)	/* Invert check for nodemask */
> +#define MPOL_MF_WRLOCK       (MPOL_MF_INTERNAL << 2)	/* Write-lock walked vmas */
>  
>  static struct kmem_cache *policy_cache;
>  static struct kmem_cache *sn_cache;
> @@ -416,9 +417,19 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
>  	},
>  };
>  
> -static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
> +static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
>  				unsigned long flags);
>  
> +static bool strictly_unmovable(unsigned long flags)
> +{
> +	/*
> +	 * STRICT without MOVE flags lets do_mbind() fail immediately with -EIO
> +	 * if any misplaced page is found.
> +	 */
> +	return (flags & (MPOL_MF_STRICT | MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ==
> +			 MPOL_MF_STRICT;
> +}
> +
>  struct queue_pages {
>  	struct list_head *pagelist;
>  	unsigned long flags;
> @@ -426,6 +437,8 @@ struct queue_pages {
>  	unsigned long start;
>  	unsigned long end;
>  	struct vm_area_struct *first;
> +	struct folio *large;		/* note last large folio on pagelist */
> +	long nr_failed;			/* could not be isolated at this time */
>  };
>  
>  /*
> @@ -443,50 +456,27 @@ static inline bool queue_folio_required(struct folio *folio,
>  	return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
>  }
>  
> -/*
> - * queue_folios_pmd() has three possible return values:
> - * 0 - folios are placed on the right node or queued successfully, or
> - *     special page is met, i.e. huge zero page.
> - * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> - *     specified.
> - * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
> - *        existing folio was already on a node that does not follow the
> - *        policy.
> - */
> -static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
> +static void queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,

I don't find that "ptl" is used in the function now.  So, remove it?

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
>  }
>  
>  /*
> @@ -496,8 +486,6 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>   * queue_folios_pte_range() has three possible return values:
>   * 0 - folios are placed on the right node or queued successfully, or
>   *     special page is met, i.e. zero page.
> - * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> - *     specified.
>   * -EIO - only MPOL_MF_STRICT was specified and an existing folio was already
>   *        on a node that does not follow the policy.
>   */
> @@ -508,14 +496,16 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
>  	struct folio *folio;
>  	struct queue_pages *qp = walk->private;
>  	unsigned long flags = qp->flags;
> -	bool has_unmovable = false;
>  	pte_t *pte, *mapped_pte;
>  	pte_t ptent;
>  	spinlock_t *ptl;
>  
>  	ptl = pmd_trans_huge_lock(pmd, vma);
> -	if (ptl)
> -		return queue_folios_pmd(pmd, ptl, addr, end, walk);
> +	if (ptl) {
> +		queue_folios_pmd(pmd, ptl, addr, end, walk);
> +		spin_unlock(ptl);
> +		goto out;
> +	}
>  
>  	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>  	if (!pte) {
> @@ -524,8 +514,13 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
>  	}
>  	for (; addr != end; pte++, addr += PAGE_SIZE) {
>  		ptent = ptep_get(pte);
> -		if (!pte_present(ptent))
> +		if (pte_none(ptent))
>  			continue;
> +		if (!pte_present(ptent)) {
> +			if (is_migration_entry(pte_to_swp_entry(ptent)))
> +				qp->nr_failed++;
> +			continue;
> +		}
>  		folio = vm_normal_folio(vma, addr, ptent);
>  		if (!folio || folio_is_zone_device(folio))
>  			continue;
> @@ -537,97 +532,82 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
>  			continue;
>  		if (!queue_folio_required(folio, qp))
>  			continue;
> -		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> -			/* MPOL_MF_STRICT must be specified if we get here */
> -			if (!vma_migratable(vma)) {
> -				has_unmovable = true;
> +		if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
> +		    !vma_migratable(vma)) {
> +			qp->nr_failed++;
> +			if (strictly_unmovable(flags))
>  				break;
> -			}
> -
> +		}

IIUC, even if !(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) or
!vma_migratable(vma), the folio will be isolated in migrate_folio_add()
below.  Is this the expected behavior?

> +		if (migrate_folio_add(folio, qp->pagelist, flags)) {
>  			/*
> -			 * Do not abort immediately since there may be
> -			 * temporary off LRU pages in the range.  Still
> -			 * need migrate other LRU pages.
> +			 * A large folio can only be isolated from LRU once,
> +			 * but may be mapped by many PTEs (and Copy-On-Write may
> +			 * intersperse PTEs of other folios).  This is a common
> +			 * case, so don't mistake it for failure (but of course
> +			 * there can be other cases of multi-mapped pages which
> +			 * this quick check does not help to filter out - and a
> +			 * search of the pagelist might grow to be prohibitive).
>  			 */
> -			if (migrate_folio_add(folio, qp->pagelist, flags))
> -				has_unmovable = true;
> -		} else
> -			break;
> +			if (folio_test_large(folio))
> +				qp->large = folio;
> +		} else if (folio != qp->large) {
> +			qp->nr_failed++;
> +			if (strictly_unmovable(flags))
> +				break;
> +		}
>  	}
>  	pte_unmap_unlock(mapped_pte, ptl);
>  	cond_resched();
> -
> -	if (has_unmovable)
> -		return 1;
> -
> -	return addr != end ? -EIO : 0;
> +out:
> +	if (qp->nr_failed && strictly_unmovable(flags))
> +		return -EIO;
> +	return 0;
>  }
>  
>  static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
>  			       unsigned long addr, unsigned long end,
>  			       struct mm_walk *walk)
>  {
> -	int ret = 0;
>  #ifdef CONFIG_HUGETLB_PAGE
>  	struct queue_pages *qp = walk->private;
> -	unsigned long flags = (qp->flags & MPOL_MF_VALID);
> +	unsigned long flags = qp->flags;
>  	struct folio *folio;
>  	spinlock_t *ptl;
>  	pte_t entry;
>  
>  	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
>  	entry = huge_ptep_get(pte);
> -	if (!pte_present(entry))
> +	if (!pte_present(entry)) {
> +		if (unlikely(is_hugetlb_entry_migration(entry)))
> +			qp->nr_failed++;
>  		goto unlock;
> +	}
>  	folio = pfn_folio(pte_pfn(entry));
>  	if (!queue_folio_required(folio, qp))
>  		goto unlock;
> -
> -	if (flags == MPOL_MF_STRICT) {
> -		/*
> -		 * STRICT alone means only detecting misplaced folio and no
> -		 * need to further check other vma.
> -		 */
> -		ret = -EIO;
> +	if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
> +	    !vma_migratable(walk->vma)) {
> +		qp->nr_failed++;
>  		goto unlock;
>  	}
> -
> -	if (!vma_migratable(walk->vma)) {
> -		/*
> -		 * Must be STRICT with MOVE*, otherwise .test_walk() have
> -		 * stopped walking current vma.
> -		 * Detecting misplaced folio but allow migrating folios which
> -		 * have been queued.
> -		 */
> -		ret = 1;
> -		goto unlock;
> -	}
> -
>  	/*
> -	 * With MPOL_MF_MOVE, we try to migrate only unshared folios. If it
> -	 * is shared it is likely not worth migrating.
> +	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
> +	 * Choosing not to migrate a shared folio is not counted as a failure.
>  	 *
>  	 * To check if the folio is shared, ideally we want to make sure
>  	 * every page is mapped to the same process. Doing that is very
> -	 * expensive, so check the estimated mapcount of the folio instead.
> +	 * expensive, so check the estimated sharers of the folio instead.
>  	 */
> -	if (flags & (MPOL_MF_MOVE_ALL) ||
> -	    (flags & MPOL_MF_MOVE && folio_estimated_sharers(folio) == 1 &&
> -	     !hugetlb_pmd_shared(pte))) {
> -		if (!isolate_hugetlb(folio, qp->pagelist) &&
> -			(flags & MPOL_MF_STRICT))
> -			/*
> -			 * Failed to isolate folio but allow migrating pages
> -			 * which have been queued.
> -			 */
> -			ret = 1;
> -	}
> +	if ((flags & MPOL_MF_MOVE_ALL) ||
> +	    (folio_estimated_sharers(folio) == 1 && !hugetlb_pmd_shared(pte)))
> +		if (!isolate_hugetlb(folio, qp->pagelist))
> +			qp->nr_failed++;
>  unlock:
>  	spin_unlock(ptl);
> -#else
> -	BUG();
> +	if (qp->nr_failed && strictly_unmovable(flags))
> +		return -EIO;
>  #endif
> -	return ret;
> +	return 0;
>  }
>  
>  #ifdef CONFIG_NUMA_BALANCING
> @@ -708,8 +688,11 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
>  		return 1;
>  	}
>  
> -	/* queue pages from current vma */
> -	if (flags & MPOL_MF_VALID)
> +	/*
> +	 * Check page nodes, and queue pages to move, in the current vma.
> +	 * But if no moving, and no strict checking, the scan can be skipped.
> +	 */
> +	if (flags & (MPOL_MF_STRICT | MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
>  		return 0;
>  	return 1;
>  }
> @@ -731,22 +714,22 @@ static const struct mm_walk_ops queue_pages_lock_vma_walk_ops = {
>  /*
>   * Walk through page tables and collect pages to be migrated.
>   *
> - * If pages found in a given range are on a set of nodes (determined by
> - * @nodes and @flags,) it's isolated and queued to the pagelist which is
> - * passed via @private.
> + * If pages found in a given range are not on the required set of @nodes,
> + * and migration is allowed, they are isolated and queued to the pagelist
> + * which is passed via @private.

s/@private/@pagelist/

>   *
> - * queue_pages_range() has three possible return values:
> - * 1 - there is unmovable page, but MPOL_MF_MOVE* & MPOL_MF_STRICT were
> - *     specified.
> - * 0 - queue pages successfully or no misplaced page.
> - * errno - i.e. misplaced pages with MPOL_MF_STRICT specified (-EIO) or
> - *         memory range specified by nodemask and maxnode points outside
> - *         your accessible address space (-EFAULT)
> + * queue_pages_range() may return:
> + * 0 - all pages already on the right node, or successfully queued for moving
> + *     (or neither strict checking nor moving requested: only range checking).
> + * >0 - this number of misplaced folios could not be queued for moving
> + *      (a hugetlbfs page or a transparent huge page being counted as 1).
> + * -EIO - a misplaced page found, when MPOL_MF_STRICT specified without MOVEs.
> + * -EFAULT - a hole in the memory range, when MPOL_MF_DISCONTIG_OK unspecified.
>   */
> -static int
> +static long
>  queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
>  		nodemask_t *nodes, unsigned long flags,
> -		struct list_head *pagelist, bool lock_vma)
> +		struct list_head *pagelist)
>  {
>  	int err;
>  	struct queue_pages qp = {
> @@ -757,7 +740,7 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
>  		.end = end,
>  		.first = NULL,
>  	};
> -	const struct mm_walk_ops *ops = lock_vma ?
> +	const struct mm_walk_ops *ops = (flags & MPOL_MF_WRLOCK) ?
>  			&queue_pages_lock_vma_walk_ops : &queue_pages_walk_ops;
>  
>  	err = walk_page_range(mm, start, end, ops, &qp);
> @@ -766,7 +749,7 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
>  		/* whole range in hole */
>  		err = -EFAULT;
>  
> -	return err;
> +	return err ? : qp.nr_failed;
>  }
>  
>  /*
> @@ -1029,16 +1012,16 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  }
>  
>  #ifdef CONFIG_MIGRATION
> -static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
> +static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
>  				unsigned long flags)
>  {
>  	/*
> -	 * We try to migrate only unshared folios. If it is shared it
> -	 * is likely not worth migrating.
> +	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
> +	 * Choosing not to migrate a shared folio is not counted as a failure.
>  	 *
>  	 * To check if the folio is shared, ideally we want to make sure
>  	 * every page is mapped to the same process. Doing that is very
> -	 * expensive, so check the estimated mapcount of the folio instead.
> +	 * expensive, so check the estimated sharers of the folio instead.
>  	 */
>  	if ((flags & MPOL_MF_MOVE_ALL) || folio_estimated_sharers(folio) == 1) {
>  		if (folio_isolate_lru(folio)) {
> @@ -1046,32 +1029,31 @@ static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
>  			node_stat_mod_folio(folio,
>  				NR_ISOLATED_ANON + folio_is_file_lru(folio),
>  				folio_nr_pages(folio));
> -		} else if (flags & MPOL_MF_STRICT) {
> +		} else {
>  			/*
>  			 * Non-movable folio may reach here.  And, there may be
>  			 * temporary off LRU folios or non-LRU movable folios.
>  			 * Treat them as unmovable folios since they can't be
> -			 * isolated, so they can't be moved at the moment.  It
> -			 * should return -EIO for this case too.
> +			 * isolated, so they can't be moved at the moment.
>  			 */
> -			return -EIO;
> +			return false;
>  		}
>  	}
> -
> -	return 0;
> +	return true;
>  }
>  
>  /*
>   * Migrate pages from one node to a target node.
>   * Returns error or the number of pages not migrated.
>   */
> -static int migrate_to_node(struct mm_struct *mm, int source, int dest,
> -			   int flags)
> +static long migrate_to_node(struct mm_struct *mm, int source, int dest,
> +			    int flags)
>  {
>  	nodemask_t nmask;
>  	struct vm_area_struct *vma;
>  	LIST_HEAD(pagelist);
> -	int err = 0;
> +	long nr_failed;
> +	long err = 0;
>  	struct migration_target_control mtc = {
>  		.nid = dest,
>  		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
> @@ -1080,23 +1062,27 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
>  	nodes_clear(nmask);
>  	node_set(source, nmask);
>  
> -	/*
> -	 * This does not "check" the range but isolates all pages that
> -	 * need migration.  Between passing in the full user address
> -	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
> -	 */
> -	vma = find_vma(mm, 0);
>  	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
> -	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
> -			flags | MPOL_MF_DISCONTIG_OK, &pagelist, false);
> +	vma = find_vma(mm, 0);
> +
> +	/*
> +	 * This does not migrate the range, but isolates all pages that
> +	 * need migration.  Between passing in the full user address
> +	 * space range and MPOL_MF_DISCONTIG_OK, this call cannot fail,
> +	 * but passes back the count of pages which could not be isolated.
> +	 */
> +	nr_failed = queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
> +				      flags | MPOL_MF_DISCONTIG_OK, &pagelist);
>  
>  	if (!list_empty(&pagelist)) {
>  		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
> -				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL);
> +			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL);
>  		if (err)
>  			putback_movable_pages(&pagelist);
>  	}
>  
> +	if (err >= 0)
> +		err += nr_failed;
>  	return err;
>  }
>  
> @@ -1109,8 +1095,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
>  int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
>  		     const nodemask_t *to, int flags)
>  {
> -	int busy = 0;
> -	int err = 0;
> +	long nr_failed = 0;
> +	long err = 0;
>  	nodemask_t tmp;
>  
>  	lru_cache_disable();
> @@ -1192,7 +1178,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
>  		node_clear(source, tmp);
>  		err = migrate_to_node(mm, source, dest, flags);
>  		if (err > 0)
> -			busy += err;
> +			nr_failed += err;
>  		if (err < 0)
>  			break;
>  	}
> @@ -1201,8 +1187,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
>  	lru_cache_enable();
>  	if (err < 0)
>  		return err;
> -	return busy;
> -
> +	return (nr_failed < INT_MAX) ? nr_failed : INT_MAX;

        return min_t(long, nr_failed, INT_MAX);
?

>  }
>  
>  /*
> @@ -1241,10 +1226,10 @@ static struct folio *new_folio(struct folio *src, unsigned long start)
>  }
>  #else
>  
> -static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
> +static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
>  				unsigned long flags)
>  {
> -	return -EIO;
> +	return false;
>  }
>  
>  int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
> @@ -1268,8 +1253,8 @@ static long do_mbind(unsigned long start, unsigned long len,
>  	struct vma_iterator vmi;
>  	struct mempolicy *new;
>  	unsigned long end;
> -	int err;
> -	int ret;
> +	long err;
> +	long nr_failed;
>  	LIST_HEAD(pagelist);
>  
>  	if (flags & ~(unsigned long)MPOL_MF_VALID)
> @@ -1309,10 +1294,8 @@ static long do_mbind(unsigned long start, unsigned long len,
>  		 start, start + len, mode, mode_flags,
>  		 nmask ? nodes_addr(*nmask)[0] : NUMA_NO_NODE);
>  
> -	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> -
> +	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
>  		lru_cache_disable();
> -	}
>  	{
>  		NODEMASK_SCRATCH(scratch);
>  		if (scratch) {
> @@ -1328,44 +1311,37 @@ static long do_mbind(unsigned long start, unsigned long len,
>  		goto mpol_out;
>  
>  	/*
> -	 * Lock the VMAs before scanning for pages to migrate, to ensure we don't
> -	 * miss a concurrently inserted page.
> +	 * Lock the VMAs before scanning for pages to migrate,
> +	 * to ensure we don't miss a concurrently inserted page.
>  	 */
> -	ret = queue_pages_range(mm, start, end, nmask,
> -			  flags | MPOL_MF_INVERT, &pagelist, true);
> +	nr_failed = queue_pages_range(mm, start, end, nmask,
> +			flags | MPOL_MF_INVERT | MPOL_MF_WRLOCK, &pagelist);
>  
> -	if (ret < 0) {
> -		err = ret;
> -		goto up_out;
> -	}
> -
> -	vma_iter_init(&vmi, mm, start);
> -	prev = vma_prev(&vmi);
> -	for_each_vma_range(vmi, vma, end) {
> -		err = mbind_range(&vmi, vma, &prev, start, end, new);
> -		if (err)
> -			break;
> +	if (nr_failed < 0) {
> +		err = nr_failed;
> +	} else {
> +		vma_iter_init(&vmi, mm, start);
> +		prev = vma_prev(&vmi);
> +		for_each_vma_range(vmi, vma, end) {
> +			err = mbind_range(&vmi, vma, &prev, start, end, new);
> +			if (err)
> +				break;
> +		}
>  	}
>  
>  	if (!err) {
> -		int nr_failed = 0;
> -
>  		if (!list_empty(&pagelist)) {
>  			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
> -			nr_failed = migrate_pages(&pagelist, new_folio, NULL,
> +			nr_failed |= migrate_pages(&pagelist, new_folio, NULL,
>  				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND, NULL);
> -			if (nr_failed)
> -				putback_movable_pages(&pagelist);
>  		}
> -
> -		if ((ret > 0) || (nr_failed && (flags & MPOL_MF_STRICT)))
> +		if (nr_failed && (flags & MPOL_MF_STRICT))
>  			err = -EIO;
> -	} else {
> -up_out:
> -		if (!list_empty(&pagelist))
> -			putback_movable_pages(&pagelist);
>  	}
>  
> +	if (!list_empty(&pagelist))
> +		putback_movable_pages(&pagelist);
> +
>  	mmap_write_unlock(mm);
>  mpol_out:
>  	mpol_put(new);

--
Best Regards,
Huang, Ying
