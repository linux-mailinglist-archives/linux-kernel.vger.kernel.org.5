Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D787C4D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjJKI1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjJKI1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:27:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E10EB9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697012857; x=1728548857;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=9SZZmxJ+tbIuLaOY3+H+4YhYCxcRI83XYjwfpeAK8oI=;
  b=kiNwohn3ASCdLFmBSxeqghoEtU3Ey1P1XuobNnvc5g2QRCQzRUG3469M
   1enf7+eCuicsUfzqWZZDrqp18Jf/pC5OUbwfXGXek5u3WUTO7hpjmnQlv
   UgpjRqjecckmWXYq3cLtNLuvdkWbp/Xi+R42o+kfWBgOlYjuBteoscwRv
   oEeYjEz46bLcRU3dTwLapfvW6kGb2SCaaMbVkWkWNTnRhofUV5uDy1QQd
   Xo9a+FSwrlsunbS2AlhzmHawATw3aqTBdND4O0IC9NXIVsRr2oX+nRjPx
   JDfUhUZOJSPJqL2gMcbjs2UlW1TirkfdNjn4hc6SLm4ziSGOHHEcE1Eje
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="363968433"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="363968433"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="927479544"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="927479544"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:27:33 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 2/2] mm: swap: Swap-out small-sized THP without
 splitting
References: <20231010142111.3997780-1-ryan.roberts@arm.com>
        <20231010142111.3997780-3-ryan.roberts@arm.com>
Date:   Wed, 11 Oct 2023 16:25:25 +0800
In-Reply-To: <20231010142111.3997780-3-ryan.roberts@arm.com> (Ryan Roberts's
        message of "Tue, 10 Oct 2023 15:21:11 +0100")
Message-ID: <87r0m1ftvu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> The upcoming anonymous small-sized THP feature enables performance
> improvements by allocating large folios for anonymous memory. However
> I've observed that on an arm64 system running a parallel workload (e.g.
> kernel compilation) across many cores, under high memory pressure, the
> speed regresses. This is due to bottlenecking on the increased number of
> TLBIs added due to all the extra folio splitting.
>
> Therefore, solve this regression by adding support for swapping out
> small-sized THP without needing to split the folio, just like is already
> done for PMD-sized THP. This change only applies when CONFIG_THP_SWAP is
> enabled, and when the swap backing store is a non-rotating block device
> - these are the same constraints as for the existing PMD-sized THP
> swap-out support.
>
> Note that no attempt is made to swap-in THP here - this is still done
> page-by-page, like for PMD-sized THP.
>
> The main change here is to improve the swap entry allocator so that it
> can allocate any power-of-2 number of contiguous entries between [4, (1
> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
> order and allocating sequentially from it until the cluster is full.
> This ensures that we don't need to search the map and we get no
> fragmentation due to alignment padding for different orders in the
> cluster. If there is no current cluster for a given order, we attempt to
> allocate a free cluster from the list. If there are no free clusters, we
> fail the allocation and the caller falls back to splitting the folio and
> allocates individual entries (as per existing PMD-sized THP fallback).
>
> As far as I can tell, this should not cause any extra fragmentation
> concerns, given how similar it is to the existing PMD-sized THP
> allocation mechanism. There will be up to (PMD_ORDER-1) clusters in
> concurrent use though. In practice, the number of orders in use will be
> small though.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/swap.h |  7 ++++++
>  mm/swapfile.c        | 60 +++++++++++++++++++++++++++++++++-----------
>  mm/vmscan.c          | 10 +++++---
>  3 files changed, 59 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a073366a227c..fc55b760aeff 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -320,6 +320,13 @@ struct swap_info_struct {
>  					 */
>  	struct work_struct discard_work; /* discard worker */
>  	struct swap_cluster_list discard_clusters; /* discard clusters list */
> +	unsigned int large_next[PMD_ORDER]; /*
> +					     * next free offset within current
> +					     * allocation cluster for large
> +					     * folios, or UINT_MAX if no current
> +					     * cluster. Index is (order - 1).
> +					     * Only when cluster_info is used.
> +					     */

I think that it is better to make this per-CPU.  That is, extend the
percpu_cluster mechanism.  Otherwise, we may have scalability issue.

And this should be enclosed in CONFIG_THP_SWAP.

>  	struct plist_node avail_lists[]; /*
>  					   * entries in swap_avail_heads, one
>  					   * entry per node.

--
Best Regards,
Huang, Ying
