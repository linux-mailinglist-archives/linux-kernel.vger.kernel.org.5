Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1337FB092
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjK1DVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjK1DVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:21:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD47ECE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701141684; x=1732677684;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=uAyuEl4PRkvMBnAcgIlon89LF6qmybriGImNGAei/Ts=;
  b=dbCwV1WdhpKMiP2lV7zCJd7nVY36q0kV9EX9Fh307ofK2hiq1g9vl3CB
   MiEj6YLpuN3y9BHx6nabWh49bebhLN58hfW5UpqtfJjniKkbz9j3Sgut7
   P8fSoOIfC7op+LwaP2XuljC3yQ7shKjN6FnPauiMHRc1748QNdlNQZDIq
   sbeA80rVDyuHMNDwNqeSbr+XLjP3UCMypC+dxG1wAw6VdAY9ua4BCdEdT
   6rHFA102GfnlPfuxiXC+PQz7aBv8M5OWy8VX9LcDuKTsSluydrd2wjrSv
   lu7bMlvAEXq4+6CVyZn9BZ6PySaC9aXpt1tokUAlt4OxeqGX5PeXsZLI+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="457171853"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="457171853"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:21:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="891943316"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="891943316"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:21:20 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, Chris Li <chriscli@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
In-Reply-To: <CAJD7tkZNa_3mWYeix_Xc-BFRNVMkBF3uzL0JCkZOYw5ubAaj9w@mail.gmail.com>
        (Yosry Ahmed's message of "Mon, 27 Nov 2023 13:56:26 -0800")
References: <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka>
        <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
        <ZV3_6UH28KMt0ZDb@tiehlicka>
        <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZWDPuR5Ssx07nBHb@tiehlicka>
        <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
        <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAF8kJuNKH_vcF-=6nw3zP5cMaZHLudHZfxNDtHm0K2BXJ+EAgA@mail.gmail.com>
        <ZWUKziMl6cFV2uWN@google.com>
        <CAJD7tkZNa_3mWYeix_Xc-BFRNVMkBF3uzL0JCkZOYw5ubAaj9w@mail.gmail.com>
Date:   Tue, 28 Nov 2023 11:19:20 +0800
Message-ID: <87msuy5zuv.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yosry Ahmed <yosryahmed@google.com> writes:

> On Mon, Nov 27, 2023 at 1:32=E2=80=AFPM Minchan Kim <minchan@kernel.org> =
wrote:
>>
>> On Mon, Nov 27, 2023 at 12:22:59AM -0800, Chris Li wrote:
>> > On Mon, Nov 27, 2023 at 12:14=E2=80=AFAM Huang, Ying <ying.huang@intel=
.com> wrote:
>> > > >  I agree with Ying that anonymous pages typically have different p=
age
>> > > > access patterns than file pages, so we might want to treat them
>> > > > differently to reclaim them effectively.
>> > > > One random idea:
>> > > > How about we put the anonymous page in a swap cache in a different=
 LRU
>> > > > than the rest of the anonymous pages. Then shrinking against those
>> > > > pages in the swap cache would be more effective.Instead of having
>> > > > [anon, file] LRU, now we have [anon not in swap cache, anon in swap
>> > > > cache, file] LRU
>> > >
>> > > I don't think that it is necessary.  The patch is only for a special=
 use
>> > > case.  Where the swap device is used up while some pages are in swap
>> > > cache.  The patch will kill performance, but it is used to avoid OOM
>> > > only, not to improve performance.  Per my understanding, we will not=
 use
>> > > up swap device space in most cases.  This may be true for ZRAM, but =
will
>> > > we keep pages in swap cache for long when we use ZRAM?
>> >
>> > I ask the question regarding how many pages can be freed by this patch
>> > in this email thread as well, but haven't got the answer from the
>> > author yet. That is one important aspect to evaluate how valuable is
>> > that patch.
>>
>> Exactly. Since swap cache has different life time with page cache, they
>> would be usually dropped when pages are unmapped(unless they are shared
>> with others but anon is usually exclusive private) so I wonder how much
>> memory we can save.
>
> I think the point of this patch is not saving memory, but rather
> avoiding an OOM condition that will happen if we have no swap space
> left, but some pages left in the swap cache. Of course, the OOM
> avoidance will come at the cost of extra work in reclaim to swap those
> pages out.
>
> The only case where I think this might be harmful is if there's plenty
> of pages to reclaim on the file LRU, and instead we opt to chase down
> the few swap cache pages. So perhaps we can add a check to only set
> sc->swapcache_only if the number of pages in the swap cache is more
> than the number of pages on the file LRU or similar? Just make sure we
> don't chase the swapcache pages down if there's plenty to scan on the
> file LRU?

The swap cache pages can be divided to 3 groups.

- group 1: pages have been written out, at the tail of inactive LRU, but
  not reclaimed yet.

- group 2: pages have been written out, but were failed to be reclaimed
  (e.g., were accessed before reclaiming)

- group 3: pages have been swapped in, but were kept in swap cache.  The
  pages may be in active LRU.

The main target of the original patch should be group 1.  And the pages
may be cheaper to reclaim than file pages.

Group 2 are hard to be reclaimed if swap_count() isn't 0.

Group 3 should be reclaimed in theory, but the overhead may be high.
And we may need to reclaim the swap entries instead of pages if the pages
are hot.  But we can start to reclaim the swap entries before the swap
space is run out.

So, if we can count group 1, we may use that as indicator to scan anon
pages.  And we may add code to reclaim group 3 earlier.

>> > Regarding running out of swap space. That is a good point, in server
>> > workload we don't typically run out of swap device space anyway.

Think about this again.  In server workload, if we set some swap usage
limit for a memcg, we may run out of the limit.  Is it common for a
server workload run out of the swap usage limit of the memcg?

>> > Android uses ZRAM, the story might be different. Adding Minchan here.
>>
>> Swap is usually almost full in Android since it compacts(i.e., swapout)
>> background apps aggressively.

If my understanding were correct, because ZRAM has SWP_SYNCHRONOUS_IO
set, the anonymous pages will only be put in swap cache temporarily
during swap out.  So, the remaining swap cache pages in anon LRU should
not be a problem for ZRAM.

--
Best Regards,
Huang, Ying
