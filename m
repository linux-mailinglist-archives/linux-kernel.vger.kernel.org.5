Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CD87FEA3B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344836AbjK3IJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344771AbjK3IJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:09:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82574A3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701331793; x=1732867793;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=PKVoZ9djdZtpGvrMsD7HbjOpC4RtvE9RcR4+08QTQtI=;
  b=h7OKKLTvJ/Xyie1UsCnrCUJBUV1hlZreBUsDdDjb5MUBxtFtVNIwse0Z
   pOFNslSmNqkUuavpdW2+Jl2S+PBze1Pv7PvSiP6Y7tP2+w2hxZS7uLYLo
   Xd+6HHn1vCrNeDE3d9PJT+fAKYZnYBcsZEx5uEyeXZAXCDgTaTmuU9nFv
   Po5ncOyyVq4VVV1RbW6TqoRpa9hdLjZZal1ImYXhNn5gf7zexFP0Tp6sF
   HsCzKqEc/NccvFKexn+EQIbPdDyGihXkeRzKkF/Sl5KkelLvX6PtQ/99l
   4Cz7n4rsWj5wrk44MtqFbdYP7iRLOWhJaSyziUTY0P2weHuxedbthdn/4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="424437360"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="424437360"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 00:09:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798199887"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="798199887"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 00:09:49 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Chris Li <chriscli@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
In-Reply-To: <ZWcQ315wxPJW9GXX@tiehlicka> (Michal Hocko's message of "Wed, 29
        Nov 2023 11:22:23 +0100")
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
        <ZWcQ315wxPJW9GXX@tiehlicka>
Date:   Thu, 30 Nov 2023 16:07:48 +0800
Message-ID: <875y1j4qaz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Tue 28-11-23 11:19:20, Huang, Ying wrote:
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
> Thanks this is really useful summary. And it begs question. How are we
> telling those different types from each other? vmstat counter is
> certainly not sufficient and that means we might be scanning a lot
> without actually making any progress. And doing that repeatedly.

We don't have counters for pages in individual groups.  Pages in group 1
and some pages in group 2 are always at the tail of inactive LRU.  So,
we can identify them relatively easily.  So a simple method could be, if
there are swap cache, try scan the tail of inactive LRU to free pages in
group 1 and move pages in group 2.  If we found some pages aren't in
swap cache, there may be no pages in group 1.  Then, we may give up
scanning if the memory pressure isn't too large.

One possible issue is that some pages (map count =3D=3D 1) may be swapped
out, swapped in, then deleted from swap cache.  So, some pages not in
swap cache may be at the end of inactive LRU too.

--
Best Regards,
Huang, Ying
