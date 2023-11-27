Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C3E7F978A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjK0Cgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0Cgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:36:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A2692
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701052610; x=1732588610;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Vdreomub8NHFmoat9JWzIcBhL7kgSS2yHmpZZrgfHJA=;
  b=jNEUHckxVpqJomvGJjONKHOtBzuRF7uq4p2p89YtpCkkySkjOuNm8m/P
   r/KxxKdNYoOnO5AoypBED5FJo9RWZMXqw8GQXIjJqIME+hqDAIPrbwK/4
   7XwaOkHk4JX34A4bFOezkcJv5iVzBE9TO/Z0MLHhypF57kzN+vusW6vQc
   HYAg4BOEKTu5AY69NzKiU9krXY8prcMMi4OFe312Wrq9N+8P55I4UkA9J
   YKJAgKnIq+yvTzAL18diodm6dH2Nw7p1WF0D8pJCzBvUU52r5NG/ymlFE
   2NIOscAFqGcVKjMTTBP28Z4nXbuSHTtxSkhDatCIXfBV9oswXTagKEgiX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="392379442"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="392379442"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 18:36:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="941426287"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="941426287"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 18:36:47 -0800
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
In-Reply-To: <ZWDPuR5Ssx07nBHb@tiehlicka> (Michal Hocko's message of "Fri, 24
        Nov 2023 17:30:49 +0100")
References: <20231121090624.1814733-1-liushixin2@huawei.com>
        <ZVyp5eETLTT0PCYj@tiehlicka>
        <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
        <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
        <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka>
        <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
        <ZV3_6UH28KMt0ZDb@tiehlicka>
        <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZWDPuR5Ssx07nBHb@tiehlicka>
Date:   Mon, 27 Nov 2023 10:34:46 +0800
Message-ID: <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Thu 23-11-23 14:15:59, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
> [...]
>> > Yes swapcache pages are indeed more complicated but most of the time
>> > they just go away as well, no?
>> 
>> When we swapin a page, we will put it in swapcache too.  And the page
>> can be in that state for long time if there is more than 50% free space
>> in the swap device.
>
> True, but why is that a problem? If you encounter such a swapped in page
> on the file LRU then the page should be referened and as such should be
> activated, no?

This just means that anonymous pages in file LRU aren't temporary or
short-term.  So we need to consider that.  For example, the original
method to balance between anonymous pages and file pages need to be
re-designed.  The anonymous pages are considered hotter than file pages
in general.

--
Best Regards,
Huang, Ying
