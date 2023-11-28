Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8C7FB1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343631AbjK1GD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343576AbjK1GDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:03:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DFC1B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701151408; x=1732687408;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=GDhbfX3yxDNw6VIdEgaKxTC6cvAf9bK9F2hht6HPDjI=;
  b=Heqf17j7Ev5K5VnpCwC9AAQNsKeMq2//NtBjMUhjAz0aPS7UtoOpwwfa
   tqC+tVmsiVLYvCmK6hNwYqC5RyDSH1Z1/cGKj1FsrwC/uR6eYEv7Vkfhu
   6fgFOEn644wu1rsVJSTVB69osWBqIRXDKw6OEnxZl+2p2dzY2UuXYADo6
   VEwK97VXoe13LuHP63ek/H+KYrSX31wP+y2E4hHwo7pB5n7OYTaEn/pJT
   Ev5iFGgffIxLu16KrchOoQMLlsDaA2nF2L10z2iqs6G6ApAwD/Tf8+5j0
   c46/kt3FVG4Jn047ZPHg5BlnQfiaAudNG0HPZqvBDT4GrEF3I71PeuItC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="390013390"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="390013390"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 21:54:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="859310234"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="859310234"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 21:54:42 -0800
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
In-Reply-To: <CAJD7tkbgPo1_Gij+EL==tedRh=nJe_etuZors-6Y-obYu44FMQ@mail.gmail.com>
        (Yosry Ahmed's message of "Mon, 27 Nov 2023 21:41:54 -0800")
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
        <87msuy5zuv.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAJD7tkZmyzohNRqgvZvZC5L7OFHzDRm-Y3JEQHiDYcwTCz-FBQ@mail.gmail.com>
        <87fs0q5xsq.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAJD7tkZKS=1BSoaCnF5wkto5z3-_sx=6GSVqdhXz=Dcw_-C3BA@mail.gmail.com>
        <87bkbe5tha.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAJD7tkbgPo1_Gij+EL==tedRh=nJe_etuZors-6Y-obYu44FMQ@mail.gmail.com>
Date:   Tue, 28 Nov 2023 13:52:42 +0800
Message-ID: <875y1m5sr9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yosry Ahmed <yosryahmed@google.com> writes:

> On Mon, Nov 27, 2023 at 9:39=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Yosry Ahmed <yosryahmed@google.com> writes:
>>
>> > On Mon, Nov 27, 2023 at 8:05=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Yosry Ahmed <yosryahmed@google.com> writes:
>> >>
>> >> > On Mon, Nov 27, 2023 at 7:21=E2=80=AFPM Huang, Ying <ying.huang@int=
el.com> wrote:
>> >> >>
>> >> >> Yosry Ahmed <yosryahmed@google.com> writes:
>> >> >>
>> >> >> > On Mon, Nov 27, 2023 at 1:32=E2=80=AFPM Minchan Kim <minchan@ker=
nel.org> wrote:
>> >> >> >>
>> >> >> >> On Mon, Nov 27, 2023 at 12:22:59AM -0800, Chris Li wrote:
>> >> >> >> > On Mon, Nov 27, 2023 at 12:14=E2=80=AFAM Huang, Ying <ying.hu=
ang@intel.com> wrote:
>> >> >> >> > > >  I agree with Ying that anonymous pages typically have di=
fferent page
>> >> >> >> > > > access patterns than file pages, so we might want to trea=
t them
>> >> >> >> > > > differently to reclaim them effectively.
>> >> >> >> > > > One random idea:
>> >> >> >> > > > How about we put the anonymous page in a swap cache in a =
different LRU
>> >> >> >> > > > than the rest of the anonymous pages. Then shrinking agai=
nst those
>> >> >> >> > > > pages in the swap cache would be more effective.Instead o=
f having
>> >> >> >> > > > [anon, file] LRU, now we have [anon not in swap cache, an=
on in swap
>> >> >> >> > > > cache, file] LRU
>> >> >> >> > >
>> >> >> >> > > I don't think that it is necessary.  The patch is only for =
a special use
>> >> >> >> > > case.  Where the swap device is used up while some pages ar=
e in swap
>> >> >> >> > > cache.  The patch will kill performance, but it is used to =
avoid OOM
>> >> >> >> > > only, not to improve performance.  Per my understanding, we=
 will not use
>> >> >> >> > > up swap device space in most cases.  This may be true for Z=
RAM, but will
>> >> >> >> > > we keep pages in swap cache for long when we use ZRAM?
>> >> >> >> >
>> >> >> >> > I ask the question regarding how many pages can be freed by t=
his patch
>> >> >> >> > in this email thread as well, but haven't got the answer from=
 the
>> >> >> >> > author yet. That is one important aspect to evaluate how valu=
able is
>> >> >> >> > that patch.
>> >> >> >>
>> >> >> >> Exactly. Since swap cache has different life time with page cac=
he, they
>> >> >> >> would be usually dropped when pages are unmapped(unless they ar=
e shared
>> >> >> >> with others but anon is usually exclusive private) so I wonder =
how much
>> >> >> >> memory we can save.
>> >> >> >
>> >> >> > I think the point of this patch is not saving memory, but rather
>> >> >> > avoiding an OOM condition that will happen if we have no swap sp=
ace
>> >> >> > left, but some pages left in the swap cache. Of course, the OOM
>> >> >> > avoidance will come at the cost of extra work in reclaim to swap=
 those
>> >> >> > pages out.
>> >> >> >
>> >> >> > The only case where I think this might be harmful is if there's =
plenty
>> >> >> > of pages to reclaim on the file LRU, and instead we opt to chase=
 down
>> >> >> > the few swap cache pages. So perhaps we can add a check to only =
set
>> >> >> > sc->swapcache_only if the number of pages in the swap cache is m=
ore
>> >> >> > than the number of pages on the file LRU or similar? Just make s=
ure we
>> >> >> > don't chase the swapcache pages down if there's plenty to scan o=
n the
>> >> >> > file LRU?
>> >> >>
>> >> >> The swap cache pages can be divided to 3 groups.
>> >> >>
>> >> >> - group 1: pages have been written out, at the tail of inactive LR=
U, but
>> >> >>   not reclaimed yet.
>> >> >>
>> >> >> - group 2: pages have been written out, but were failed to be recl=
aimed
>> >> >>   (e.g., were accessed before reclaiming)
>> >> >>
>> >> >> - group 3: pages have been swapped in, but were kept in swap cache=
.  The
>> >> >>   pages may be in active LRU.
>> >> >>
>> >> >> The main target of the original patch should be group 1.  And the =
pages
>> >> >> may be cheaper to reclaim than file pages.
>> >> >>
>> >> >> Group 2 are hard to be reclaimed if swap_count() isn't 0.
>> >> >>
>> >> >> Group 3 should be reclaimed in theory, but the overhead may be hig=
h.
>> >> >> And we may need to reclaim the swap entries instead of pages if th=
e pages
>> >> >> are hot.  But we can start to reclaim the swap entries before the =
swap
>> >> >> space is run out.
>> >> >>
>> >> >> So, if we can count group 1, we may use that as indicator to scan =
anon
>> >> >> pages.  And we may add code to reclaim group 3 earlier.
>> >> >>
>> >> >
>> >> > My point was not that reclaiming the pages in the swap cache is more
>> >> > expensive that reclaiming the pages in the file LRU. In a lot of
>> >> > cases, as you point out, the pages in the swap cache can just be
>> >> > dropped, so they may be as cheap or cheaper to reclaim than the pag=
es
>> >> > in the file LRU.
>> >> >
>> >> > My point was that scanning the anon LRU when swap space is exhausted
>> >> > to get to the pages in the swap cache may be much more expensive,
>> >> > because there may be a lot of pages on the anon LRU that are not in
>> >> > the swap cache, and hence are not reclaimable, unlike pages in the
>> >> > file LRU, which should mostly be reclaimable.
>> >> >
>> >> > So what I am saying is that maybe we should not do the effort of
>> >> > scanning the anon LRU in the swapcache_only case unless there aren'=
t a
>> >> > lot of pages to reclaim on the file LRU (relatively). For example, =
if
>> >> > we have a 100 pages in the swap cache out of 10000 pages in the anon
>> >> > LRU, and there are 10000 pages in the file LRU, it's probably not
>> >> > worth scanning the anon LRU.
>> >>
>> >> For group 1 pages, they are at the tail of the anon inactive LRU, so =
the
>> >> scan overhead is low too.  For example, if number of group 1 pages is
>> >> 100, we just need to scan 100 pages to reclaim them.  We can choose to
>> >> stop scanning when the number of the non-group-1 pages reached some
>> >> threshold.
>> >>
>> >
>> > We should still try to reclaim pages in groups 2 & 3 before OOMing
>> > though. Maybe the motivation for this patch is group 1, but I don't
>> > see why we should special case them. Pages in groups 2 & 3 should be
>> > roughly equally cheap to reclaim. They may have higher refault cost,
>> > but IIUC we should still try to reclaim them before OOMing.
>>
>> The scan cost of group 3 may be high, you may need to scan all anonymous
>> pages to identify them.  The reclaim cost of group 2 may be high, it may
>> just cause trashing (shared pages that are accessed by just one
>> process).  So I think that we can allow reclaim group 1 in all cases.
>> Try to reclaim swap entries for group 3 during normal LRU scanning after
>> more than half of swap space of limit is used.  As a last resort before
>> OOM, try to reclaim group 2 and group 3.  Or, limit scan count for group
>> 2 and group 3.
>
> It would be nice if this can be done auto-magically without having to
> keep track of the groups separately.

Some rough idea may be

- trying to scan anon LRU if there are swap cache pages.

- if some number of pages other than group 1 encountered, stop scanning
  anon LRU list.

- the threshold to stopping can be tuned according to whether we are
  going to OOM.

We can try to reclaim swap entries for group 3 when we haven't run out
of swap space yet.

>>
>> BTW, in some situation, OOM is not the worst situation.  For example,
>> trashing may kill interaction latency, while killing the memory hog (may
>> be caused by memory leak) saves system response time.
>
> I agree that in some situations OOMs are better than thrashing, it's
> not an easy problem.

--
Best Regards,
Huang, Ying
