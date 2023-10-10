Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100717BF2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442167AbjJJGK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376502AbjJJGKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:10:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9D99D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696918222; x=1728454222;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=TUsCoEHWVSmVfCipsR2h51CAEI1MELGWQx6Zwd1DQwM=;
  b=QSqYqNauM799KSvHJU4yHDK4Cm6HjUW7aFebEytwP4kpRhg8lVGvCmFP
   meKwiPoi0BbUG6b4aY4/HgfnjqYFskSDCW5iLlxKvhneZ33gnhlDxp2Fa
   xsvWSnsjmowyQFSRWT+ed8kCpcj5n+2eaO2zSNZplHW1diJ9XROx2spcn
   eXwhzJl8RZnKqczhtjc37q0lVb4/UCh9C1n8ULajE76R0+0J39s1Dtqu2
   FyzxmorxRXVYyJkKDM87unhve9nV5QO9c9m/WzHJUlF65iq9Jog+edYH7
   ef3JybnSjDbiJxJD/jpoW5uFEw14ItxTb0gRDQDoWlyekQ4qs8W1BxkzE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="381577429"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="381577429"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 23:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="819100631"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="819100631"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 23:10:17 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Rohan Puri" <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 0/4] Enable >0 order folio memory compaction
References: <20230912162815.440749-1-zi.yan@sent.com>
        <87a5ssjmld.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <14089E95-251E-43A4-AF32-C9773723C810@nvidia.com>
Date:   Tue, 10 Oct 2023 14:08:08 +0800
In-Reply-To: <14089E95-251E-43A4-AF32-C9773723C810@nvidia.com> (Zi Yan's
        message of "Mon, 09 Oct 2023 09:43:38 -0400")
Message-ID: <87r0m3ggc7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Something wrong with my mail box.  Sorry, if you received duplicated
mail.

Zi Yan <ziy@nvidia.com> writes:

> On 9 Oct 2023, at 3:12, Huang, Ying wrote:
>
>> Hi, Zi,
>>
>> Thanks for your patch!
>>
>> Zi Yan <zi.yan@sent.com> writes:
>>
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> Hi all,
>>>
>>> This patchset enables >0 order folio memory compaction, which is one of
>>> the prerequisitions for large folio support[1]. It is on top of
>>> mm-everything-2023-09-11-22-56.
>>>
>>> Overview
>>> ===
>>>
>>> To support >0 order folio compaction, the patchset changes how free pages used
>>> for migration are kept during compaction.
>>
>> migrate_pages() can split the large folio for allocation failure.  So
>> the minimal implementation could be
>>
>> - allow to migrate large folios in compaction
>> - return -ENOMEM for order > 0 in compaction_alloc()
>>
>> The performance may be not desirable.  But that may be a baseline for
>> further optimization.
>
> I would imagine it might cause a regression since compaction might gradually
> split high order folios in the system.

I may not call it a pure regression, since large folio can be migrated
during compaction with that, but it's possible that this hurts
performance.

Anyway, this can be a not-so-good minimal baseline.

> But I can move Patch 4 first to make this the baseline and see how
> system performance changes.

Thanks!

>>
>> And, if we can measure the performance for each step of optimization,
>> that will be even better.
>
> Do you have any benchmark in mind for the performance tests? vm-scalability?

I remember Mel Gorman has done some tests for defragmentation before.
But that's for order-0 pages.

>>> Free pages used to be split into
>>> order-0 pages that are post allocation processed (i.e., PageBuddy flag cleared,
>>> page order stored in page->private is zeroed, and page reference is set to 1).
>>> Now all free pages are kept in a MAX_ORDER+1 array of page lists based
>>> on their order without post allocation process. When migrate_pages() asks for
>>> a new page, one of the free pages, based on the requested page order, is
>>> then processed and given out.
>>>
>>>
>>> Optimizations
>>> ===
>>>
>>> 1. Free page split is added to increase migration success rate in case
>>> a source page does not have a matched free page in the free page lists.
>>> Free page merge is possible but not implemented, since existing
>>> PFN-based buddy page merge algorithm requires the identification of
>>> buddy pages, but free pages kept for memory compaction cannot have
>>> PageBuddy set to avoid confusing other PFN scanners.
>>>
>>> 2. Sort source pages in ascending order before migration is added to
>>
>> Trivial.
>>
>> s/ascending/descending/
>>
>>> reduce free page split. Otherwise, high order free pages might be
>>> prematurely split, causing undesired high order folio migration failures.
>>>
>>>
>>> TODOs
>>> ===
>>>
>>> 1. Refactor free page post allocation and free page preparation code so
>>> that compaction_alloc() and compaction_free() can call functions instead
>>> of hard coding.
>>>
>>> 2. One possible optimization is to allow migrate_pages() to continue
>>> even if get_new_folio() returns a NULL. In general, that means there is
>>> not enough memory. But in >0 order folio compaction case, that means
>>> there is no suitable free page at source page order. It might be better
>>> to skip that page and finish the rest of migration to achieve a better
>>> compaction result.
>>
>> We can split the source folio if get_new_folio() returns NULL.  So, do
>> we really need this?
>
> It depends. The situation it can benefit is that when the system is going
> to allocate a high order free page and trigger a compaction, it is possible to
> get the high order free page by migrating a bunch of base pages instead of
> splitting a existing high order folio.
>
>>
>> In general, we may reconsider all further optimizations given splitting
>> is available already.
>
> In my mind, split should be avoided as much as possible.

If so, should we use "nosplit" logic in migrate_pages_batch() in some
situation?

> But it really depends
> on the actual situation, e.g., how much effort and cost the compaction wants
> to pay to get memory defragmented. If the system really wants to get a high
> order free page at any cost, split can be used without any issue. But applications
> might lose performance because existing large folios are split just to a
> new one.

Is it possible that splitting is desirable in some situation?  For
example, allocate some large DMA buffers at the cost of large anonymous
folios?

> Like I said in the email, there are tons of optimizations and policies for us
> to explore. We can start with the bare minimum support (if no performance
> regression is observed, we can even start with split all high folios like you
> suggested) and add optimizations one by one.

Sound good to me!  Thanks!

>>
>>> 3. Another possible optimization is to enable free page merge. It is
>>> possible that a to-be-migrated page causes free page split then fails to
>>> migrate eventually. We would lose a high order free page without free
>>> page merge function. But a way of identifying free pages for memory
>>> compaction is needed to reuse existing PFN-based buddy page merge.
>>>
>>> 4. The implemented >0 order folio compaction algorithm is quite naive
>>> and does not consider all possible situations. A better algorithm can
>>> improve compaction success rate.
>>>
>>>
>>> Feel free to give comments and ask questions.
>>>
>>> Thanks.
>>>
>>>
>>> [1] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/
>>>
>>> Zi Yan (4):
>>>   mm/compaction: add support for >0 order folio memory compaction.
>>>   mm/compaction: optimize >0 order folio compaction with free page
>>>     split.
>>>   mm/compaction: optimize >0 order folio compaction by sorting source
>>>     pages.
>>>   mm/compaction: enable compacting >0 order folios.
>>>
>>>  mm/compaction.c | 205 +++++++++++++++++++++++++++++++++++++++---------
>>>  mm/internal.h   |   7 +-
>>>  2 files changed, 176 insertions(+), 36 deletions(-)

--
Best Regards,
Huang, Ying
