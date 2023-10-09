Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB177BD41E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345382AbjJIHOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344984AbjJIHOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:14:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023F894
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 00:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696835679; x=1728371679;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=OgL+yegQ7yGiZSze3dAzzQralJ3UwM2bdojXS7B1kHM=;
  b=Q1B+o7h/Y+M9GQivWZW9tfcVPUSKrH1PxFqvkSM+MtzAn5YCIlCZuo8C
   ksOooOp3BJjZa1iXvPNOmtA08gaCqmukt2xPuSJEvL/MTlg3nRvO3p6GB
   hhgIDseWLHguupqAdhYoVahrSyyfUk9hLoEPVEDWU7tE8j87RVj92sA/k
   0zDK3TwI0/hf4ZZzUTdVynTUOcICuXaIJJllcNwGyW0JSoCWQfBpG0T7r
   0OsyB/dwJ59exBvgHtMPTaYg/SwN7/E2PCjoVed0CwUj/DGhLKNRH8j0I
   T+/t4QYVnEKf++xdCzfIlRmwR+5bbIAvStAQjcsUXRet3j59Qqwv5/b4P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="381350906"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="381350906"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 00:14:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="702789098"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="702789098"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 00:14:34 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <zi.yan@sent.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 0/4] Enable >0 order folio memory compaction
References: <20230912162815.440749-1-zi.yan@sent.com>
Date:   Mon, 09 Oct 2023 15:12:30 +0800
In-Reply-To: <20230912162815.440749-1-zi.yan@sent.com> (Zi Yan's message of
        "Tue, 12 Sep 2023 12:28:11 -0400")
Message-ID: <87a5ssjmld.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zi,

Thanks for your patch!

Zi Yan <zi.yan@sent.com> writes:

> From: Zi Yan <ziy@nvidia.com>
>
> Hi all,
>
> This patchset enables >0 order folio memory compaction, which is one of
> the prerequisitions for large folio support[1]. It is on top of
> mm-everything-2023-09-11-22-56.
>
> Overview
> ===
>
> To support >0 order folio compaction, the patchset changes how free pages used
> for migration are kept during compaction.

migrate_pages() can split the large folio for allocation failure.  So
the minimal implementation could be

- allow to migrate large folios in compaction
- return -ENOMEM for order > 0 in compaction_alloc()

The performance may be not desirable.  But that may be a baseline for
further optimization.

And, if we can measure the performance for each step of optimization,
that will be even better.

> Free pages used to be split into
> order-0 pages that are post allocation processed (i.e., PageBuddy flag cleared,
> page order stored in page->private is zeroed, and page reference is set to 1).
> Now all free pages are kept in a MAX_ORDER+1 array of page lists based
> on their order without post allocation process. When migrate_pages() asks for
> a new page, one of the free pages, based on the requested page order, is
> then processed and given out.
>
>
> Optimizations
> ===
>
> 1. Free page split is added to increase migration success rate in case
> a source page does not have a matched free page in the free page lists.
> Free page merge is possible but not implemented, since existing
> PFN-based buddy page merge algorithm requires the identification of
> buddy pages, but free pages kept for memory compaction cannot have
> PageBuddy set to avoid confusing other PFN scanners.
>
> 2. Sort source pages in ascending order before migration is added to

Trivial.

s/ascending/descending/

> reduce free page split. Otherwise, high order free pages might be
> prematurely split, causing undesired high order folio migration failures.
>
>
> TODOs
> ===
>
> 1. Refactor free page post allocation and free page preparation code so
> that compaction_alloc() and compaction_free() can call functions instead
> of hard coding.
>
> 2. One possible optimization is to allow migrate_pages() to continue
> even if get_new_folio() returns a NULL. In general, that means there is
> not enough memory. But in >0 order folio compaction case, that means
> there is no suitable free page at source page order. It might be better
> to skip that page and finish the rest of migration to achieve a better
> compaction result.

We can split the source folio if get_new_folio() returns NULL.  So, do
we really need this?

In general, we may reconsider all further optimizations given splitting
is available already.

> 3. Another possible optimization is to enable free page merge. It is
> possible that a to-be-migrated page causes free page split then fails to
> migrate eventually. We would lose a high order free page without free
> page merge function. But a way of identifying free pages for memory
> compaction is needed to reuse existing PFN-based buddy page merge.
>
> 4. The implemented >0 order folio compaction algorithm is quite naive
> and does not consider all possible situations. A better algorithm can
> improve compaction success rate.
>
>
> Feel free to give comments and ask questions.
>
> Thanks.
>
>
> [1] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/
>
> Zi Yan (4):
>   mm/compaction: add support for >0 order folio memory compaction.
>   mm/compaction: optimize >0 order folio compaction with free page
>     split.
>   mm/compaction: optimize >0 order folio compaction by sorting source
>     pages.
>   mm/compaction: enable compacting >0 order folios.
>
>  mm/compaction.c | 205 +++++++++++++++++++++++++++++++++++++++---------
>  mm/internal.h   |   7 +-
>  2 files changed, 176 insertions(+), 36 deletions(-)

--
Best Regards,
Huang, Ying
