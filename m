Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAAB7FAF97
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjK1Bem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjK1Bek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:34:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5C8BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701135287; x=1732671287;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Tl3AvovjiESLHonnvMLH73/h4wwAe/SrzZTRfaFMmQ0=;
  b=HmgKH5xd/5DYcScNM32p+BHtO/C9wCO6Gf4npkN7inGvunKxSmi9XVLp
   LC2mV23Z0xDLkRj9NBXTrNEXf9XNTLKDsTX4X1CtVLGXupSSJWA/sWctt
   Oj+SNaOyIles66JDqgb6t51jEv6d/3Xq74CYKw/ZlC6jyAR17PP/Eo69r
   Q6FaO68wfQ/QDQ8PgOAGDw3/4NHSUgXEfE6hvMcBniSpoEqfHTgsTugBd
   ugH7rIJsEekGPC+D20sXk+eY6hD+qzyt8KoBtE4pi87MWnWTdbL2gwcVc
   +Jy+9tapS/oNPIk2Maje+3xn/vbJwP3dASEreCZoL/ZwoaJGI1Qid+Vse
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="389982082"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="389982082"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 17:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="744758293"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="744758293"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 17:33:06 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
In-Reply-To: <ZWRdG49vlGzSY_Uj@tiehlicka> (Michal Hocko's message of "Mon, 27
        Nov 2023 10:10:51 +0100")
References: <ZVyp5eETLTT0PCYj@tiehlicka>
        <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
        <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
        <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka>
        <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
        <ZV3_6UH28KMt0ZDb@tiehlicka>
        <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZWDPuR5Ssx07nBHb@tiehlicka>
        <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZWRdG49vlGzSY_Uj@tiehlicka>
Date:   Tue, 28 Nov 2023 09:31:06 +0800
Message-ID: <87r0ka64v9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Mon 27-11-23 10:34:46, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Thu 23-11-23 14:15:59, Huang, Ying wrote:
>> >> Michal Hocko <mhocko@suse.com> writes:
>> > [...]
>> >> > Yes swapcache pages are indeed more complicated but most of the time
>> >> > they just go away as well, no?
>> >> 
>> >> When we swapin a page, we will put it in swapcache too.  And the page
>> >> can be in that state for long time if there is more than 50% free space
>> >> in the swap device.
>> >
>> > True, but why is that a problem? If you encounter such a swapped in page
>> > on the file LRU then the page should be referened and as such should be
>> > activated, no?
>> 
>> This just means that anonymous pages in file LRU aren't temporary or
>> short-term.  So we need to consider that.
>
> Right. On the other hand we could be more aggressive when dropping the
> swapcache. Is there any actual reason why we cannot try to folio_free_swap
> even when mem_cgroup_swap_full == F?

If there are plenty free space in swap device, why not take advantage of
it?  If the page is in swap cache and clean, we can discard it when it
is reclaimed, or avoid to allocate swap entry for it.

--
Best Regards,
Huang, Ying
