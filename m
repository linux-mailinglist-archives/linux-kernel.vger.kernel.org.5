Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C8B7FCD50
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjK2DOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjK2DOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:14:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0311BC8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701227653; x=1732763653;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=f7evfONOTRdDT8DGaj9/5LbR0Nw4iuL7vChGwPlt1Ds=;
  b=G0KWzZZWQJ7rVXTw+xbnVuuPgd3jLNAttsfrzArM6wvFWi6FV5u/r3BH
   F7aMTwHkrDwEhRvzQzS3tT9e83eovkhzWWYpljWfK2M+HZ0HrKGLzSa9T
   JbF4lqm07izDceEFcfArTKEbiFmUGXXX1H9VgeR3YBrC6TwSEyvaJd4co
   EsqjFUWJAltktHyOGx6p636IWol3lF/s9GFYqe5P+OGVBfBEFIljoeqjD
   7dul/bkLr6AM1LnCyaAMl/cm2E0zJyHGoBBYiZ9agjJOpzDZghrdZxNW4
   baiijtyDEopmw+S42oOXtXNdlNs0OCc1vf8XnLlQGVZThKwu7djBekEQo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="459584457"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="459584457"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 19:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="797771575"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="797771575"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 19:14:04 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Chris Li <chriscli@google.com>, Michal Hocko <mhocko@suse.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
In-Reply-To: <ZWZrqFC-Wc92UBou@google.com> (Minchan Kim's message of "Tue, 28
        Nov 2023 14:37:28 -0800")
References: <ZV3_6UH28KMt0ZDb@tiehlicka>
        <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZWDPuR5Ssx07nBHb@tiehlicka>
        <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
        <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAF8kJuNKH_vcF-=6nw3zP5cMaZHLudHZfxNDtHm0K2BXJ+EAgA@mail.gmail.com>
        <ZWUKziMl6cFV2uWN@google.com>
        <CAJD7tkZNa_3mWYeix_Xc-BFRNVMkBF3uzL0JCkZOYw5ubAaj9w@mail.gmail.com>
        <87msuy5zuv.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZWZrqFC-Wc92UBou@google.com>
Date:   Wed, 29 Nov 2023 11:12:03 +0800
Message-ID: <87leah45j0.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Minchan Kim <minchan@kernel.org> writes:

> On Tue, Nov 28, 2023 at 11:19:20AM +0800, Huang, Ying wrote:
>> Yosry Ahmed <yosryahmed@google.com> writes:
>>=20
>> > On Mon, Nov 27, 2023 at 1:32=E2=80=AFPM Minchan Kim <minchan@kernel.or=
g> wrote:
>> >>
>> >> On Mon, Nov 27, 2023 at 12:22:59AM -0800, Chris Li wrote:
>> >> > On Mon, Nov 27, 2023 at 12:14=E2=80=AFAM Huang, Ying <ying.huang@in=
tel.com> wrote:
>> >> > > >  I agree with Ying that anonymous pages typically have differen=
t page
>> >> > > > access patterns than file pages, so we might want to treat them
>> >> > > > differently to reclaim them effectively.
>> >> > > > One random idea:
>> >> > > > How about we put the anonymous page in a swap cache in a differ=
ent LRU
>> >> > > > than the rest of the anonymous pages. Then shrinking against th=
ose
>> >> > > > pages in the swap cache would be more effective.Instead of havi=
ng
>> >> > > > [anon, file] LRU, now we have [anon not in swap cache, anon in =
swap
>> >> > > > cache, file] LRU
>> >> > >
>> >> > > I don't think that it is necessary.  The patch is only for a spec=
ial use
>> >> > > case.  Where the swap device is used up while some pages are in s=
wap
>> >> > > cache.  The patch will kill performance, but it is used to avoid =
OOM
>> >> > > only, not to improve performance.  Per my understanding, we will =
not use
>> >> > > up swap device space in most cases.  This may be true for ZRAM, b=
ut will
>> >> > > we keep pages in swap cache for long when we use ZRAM?
>> >> >
>> >> > I ask the question regarding how many pages can be freed by this pa=
tch
>> >> > in this email thread as well, but haven't got the answer from the
>> >> > author yet. That is one important aspect to evaluate how valuable is
>> >> > that patch.
>> >>
>> >> Exactly. Since swap cache has different life time with page cache, th=
ey
>> >> would be usually dropped when pages are unmapped(unless they are shar=
ed
>> >> with others but anon is usually exclusive private) so I wonder how mu=
ch
>> >> memory we can save.
>> >
>> > I think the point of this patch is not saving memory, but rather
>> > avoiding an OOM condition that will happen if we have no swap space
>> > left, but some pages left in the swap cache. Of course, the OOM
>> > avoidance will come at the cost of extra work in reclaim to swap those
>> > pages out.
>> >
>> > The only case where I think this might be harmful is if there's plenty
>> > of pages to reclaim on the file LRU, and instead we opt to chase down
>> > the few swap cache pages. So perhaps we can add a check to only set
>> > sc->swapcache_only if the number of pages in the swap cache is more
>> > than the number of pages on the file LRU or similar? Just make sure we
>> > don't chase the swapcache pages down if there's plenty to scan on the
>> > file LRU?
>>=20
>> The swap cache pages can be divided to 3 groups.
>>=20
>> - group 1: pages have been written out, at the tail of inactive LRU, but
>>   not reclaimed yet.
>>=20
>> - group 2: pages have been written out, but were failed to be reclaimed
>>   (e.g., were accessed before reclaiming)
>>=20
>> - group 3: pages have been swapped in, but were kept in swap cache.  The
>>   pages may be in active LRU.
>>=20
>> The main target of the original patch should be group 1.  And the pages
>> may be cheaper to reclaim than file pages.
>
> Yeah, that's common for asynchronous swap devices and that's popular. The=
n,
> How about freeing those memory as soon as the writeback is done instead of
> keep adding more tricks to solve the issue?
>
> https://lkml.kernel.org/linux-mm/1368411048-3753-1-git-send-email-minchan=
@kernel.org/
>
> I remember it's under softIRQ context so there were some issues to change
> locking rules for memcg and swap. And there was some concern to increase
> softirq latency due to page freeing but both were not the main obstacle to
> be fixed.

Thanks for sharing.  It's good to avoid to add the pages back to LRU,
then isolate them from LRU.  I have concerns that is it possible that
too many pages are reclaimed?  For example, to reclaim a small number of
pages, too many pages were written to disk because the performance
difference between CPU and storage.  Originally, we still only reclaim
requested number of pages although much more were written.  But with the
change, we may reclaim them all.

>>=20
>> Group 2 are hard to be reclaimed if swap_count() isn't 0.
>
> "were accessed before reclaiming" would be rare.

If page reclaiming algorithm works well enough, that should be true.

>>=20
>> Group 3 should be reclaimed in theory, but the overhead may be high.
>> And we may need to reclaim the swap entries instead of pages if the pages
>> are hot.  But we can start to reclaim the swap entries before the swap
>> space is run out.
>
> I thought the swap-in path will reclaim the swap slots once it detects
> swapspace wasn't enough(e.g., vm_swap_full or mem_cgroup_swap-full)?

Yes.  You are right.  But before swap space wasn't enough, we may keep
quite some pages in swap cache.  But these pages may becomes hot later.
Then we have no opportunity to reclaim these swap space.  So, we may
need to add some code to check this situation at appropriate places.
For example, when we scan pages in active list, or activate pages in
inactive list.

>>=20
>> So, if we can count group 1, we may use that as indicator to scan anon
>> pages.  And we may add code to reclaim group 3 earlier.

--
Best Regards,
Huang, Ying
