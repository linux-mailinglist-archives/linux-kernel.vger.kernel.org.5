Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D563F7F9B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjK0IN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjK0INz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:13:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE9113A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701072842; x=1732608842;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=/gVTlgLrTSDTMo/7KNUnEHr8qrr6Id/gcu9gUpWeGvQ=;
  b=EygwzVfr+UYwPzAfocbZ3vmfO+4NaqJMujWgkEAUP/exLbBnpHwKDZ8X
   m+QGxcJFSU6Xj9ISjhy6xZya7uL4EytErgSNvOWo8ZdNcIKCRa0+TCgDC
   IwUciyNX3KZa6SLg4lconOxNdz7twlx/GsoPRqHb7qzC3bCCLirtehxcB
   A39Q2OrU7gbkvt2W6z+aTe7CrnNl1FZIbn1L4PKDo9cMz+E0YQiFxh+MT
   dEvzPGDGE9z0z7S4TgrGIrHSU7U/pwunGQ3/ey2nLgvdUvhWq3OncJpUE
   K83wDwB0U1dyR+0ZIZKaDMoJaC1QIYZZb3+fHj+72F3bwrW2F47wlCVqX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="11356536"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="11356536"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 00:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="768101582"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="768101582"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 00:13:58 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Chris Li <chrisl@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
In-Reply-To: <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
        (Chris Li's message of "Sun, 26 Nov 2023 23:42:11 -0800")
References: <20231121090624.1814733-1-liushixin2@huawei.com>
        <ZVyp5eETLTT0PCYj@tiehlicka>
        <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
        <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
        <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka>
        <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
        <ZV3_6UH28KMt0ZDb@tiehlicka>
        <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZWDPuR5Ssx07nBHb@tiehlicka>
        <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
Date:   Mon, 27 Nov 2023 16:11:57 +0800
Message-ID: <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Li <chrisl@kernel.org> writes:

> Hi Ying,
>
> On Sun, Nov 26, 2023 at 6:36=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Michal Hocko <mhocko@suse.com> writes:
>>
>> > On Thu 23-11-23 14:15:59, Huang, Ying wrote:
>> >> Michal Hocko <mhocko@suse.com> writes:
>> > [...]
>> >> > Yes swapcache pages are indeed more complicated but most of the time
>> >> > they just go away as well, no?
>> >>
>> >> When we swapin a page, we will put it in swapcache too.  And the page
>> >> can be in that state for long time if there is more than 50% free spa=
ce
>> >> in the swap device.
>> >
>> > True, but why is that a problem? If you encounter such a swapped in pa=
ge
>> > on the file LRU then the page should be referened and as such should be
>> > activated, no?
>>
>> This just means that anonymous pages in file LRU aren't temporary or
>> short-term.  So we need to consider that.  For example, the original
>> method to balance between anonymous pages and file pages need to be
>> re-designed.  The anonymous pages are considered hotter than file pages
>> in general.
>
>  I agree with Ying that anonymous pages typically have different page
> access patterns than file pages, so we might want to treat them
> differently to reclaim them effectively.
> One random idea:
> How about we put the anonymous page in a swap cache in a different LRU
> than the rest of the anonymous pages. Then shrinking against those
> pages in the swap cache would be more effective.Instead of having
> [anon, file] LRU, now we have [anon not in swap cache, anon in swap
> cache, file] LRU

I don't think that it is necessary.  The patch is only for a special use
case.  Where the swap device is used up while some pages are in swap
cache.  The patch will kill performance, but it is used to avoid OOM
only, not to improve performance.  Per my understanding, we will not use
up swap device space in most cases.  This may be true for ZRAM, but will
we keep pages in swap cache for long when we use ZRAM?

--
Best Regards,
Huang, Ying
