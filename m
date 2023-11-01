Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31FB7DDAF6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjKACYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjKACX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:23:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DB4F3;
        Tue, 31 Oct 2023 19:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698805433; x=1730341433;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=FJQjB45qiCqnh/iEHCzCeeIgns3EtrKJXHjHxjc0/Bg=;
  b=SEwdhUwdgVQEP2rqp3S/oD/545Okl2swdIUoUMfaaS0TEDxJYtkIZkpl
   a5GUSoCIGBlbMpNibAl/xmz/gCPBr0pHRhZKursWfErzvwfQIS/Ghvrhq
   RyPsOFDhVaV9Srs+7BWIjjGgpTiAB5eeWrpNoA2jm1AaVbnQyLuCQjWp7
   9Z0kBayMu0Os9RpZZTjyTWLA/P9V7ZA4AznBJ5xKKelMye/xoB5CwlUIf
   gJ6pCjW8Bw+G2uys8yF1FKpFUmUSDOVvfQjZkwcNN/U0r1jsfyd5K1bgL
   5Mp1utoWVYNihq+FILhv8qbSFZZ+KcNxqFTqz7K4MGoS7yF00Udu0ni0P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="385598226"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="385598226"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 19:23:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="831228900"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="831228900"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 19:23:48 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, weixugc@google.com, apopple@nvidia.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, shy828301@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
In-Reply-To: <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
        (Michal Hocko's message of "Tue, 31 Oct 2023 16:56:27 +0100")
References: <20231031003810.4532-1-gregory.price@memverge.com>
        <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
        <20231031152142.GA3029315@cmpxchg.org>
        <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
Date:   Wed, 01 Nov 2023 10:21:47 +0800
Message-ID: <87msvy6wn8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Tue 31-10-23 11:21:42, Johannes Weiner wrote:
>> On Tue, Oct 31, 2023 at 10:53:41AM +0100, Michal Hocko wrote:
>> > On Mon 30-10-23 20:38:06, Gregory Price wrote:
>> > > This patchset implements weighted interleave and adds a new sysfs
>> > > entry: /sys/devices/system/node/nodeN/accessM/il_weight.
>> > > 
>> > > The il_weight of a node is used by mempolicy to implement weighted
>> > > interleave when `numactl --interleave=...` is invoked.  By default
>> > > il_weight for a node is always 1, which preserves the default round
>> > > robin interleave behavior.
>> > > 
>> > > Interleave weights may be set from 0-100, and denote the number of
>> > > pages that should be allocated from the node when interleaving
>> > > occurs.
>> > > 
>> > > For example, if a node's interleave weight is set to 5, 5 pages
>> > > will be allocated from that node before the next node is scheduled
>> > > for allocations.
>> > 
>> > I find this semantic rather weird TBH. First of all why do you think it
>> > makes sense to have those weights global for all users? What if
>> > different applications have different view on how to spred their
>> > interleaved memory?
>> > 
>> > I do get that you might have a different tiers with largerly different
>> > runtime characteristics but why would you want to interleave them into a
>> > single mapping and have hard to predict runtime behavior?
>> > 
>> > [...]
>> > > In this way it becomes possible to set an interleaving strategy
>> > > that fits the available bandwidth for the devices available on
>> > > the system. An example system:
>> > > 
>> > > Node 0 - CPU+DRAM, 400GB/s BW (200 cross socket)
>> > > Node 1 - CPU+DRAM, 400GB/s BW (200 cross socket)
>> > > Node 2 - CXL Memory. 64GB/s BW, on Node 0 root complex
>> > > Node 3 - CXL Memory. 64GB/s BW, on Node 1 root complex
>> > > 
>> > > In this setup, the effective weights for nodes 0-3 for a task
>> > > running on Node 0 may be [60, 20, 10, 10].
>> > > 
>> > > This spreads memory out across devices which all have different
>> > > latency and bandwidth attributes at a way that can maximize the
>> > > available resources.
>> > 
>> > OK, so why is this any better than not using any memory policy rely
>> > on demotion to push out cold memory down the tier hierarchy?
>> > 
>> > What is the actual real life usecase and what kind of benefits you can
>> > present?
>> 
>> There are two things CXL gives you: additional capacity and additional
>> bus bandwidth.
>> 
>> The promotion/demotion mechanism is good for the capacity usecase,
>> where you have a nice hot/cold gradient in the workingset and want
>> placement accordingly across faster and slower memory.
>> 
>> The interleaving is useful when you have a flatter workingset
>> distribution and poorer access locality. In that case, the CPU caches
>> are less effective and the workload can be bus-bound. The workload
>> might fit entirely into DRAM, but concentrating it there is
>> suboptimal. Fanning it out in proportion to the relative performance
>> of each memory tier gives better resuls.
>> 
>> We experimented with datacenter workloads on such machines last year
>> and found significant performance benefits:
>> 
>> https://lore.kernel.org/linux-mm/YqD0%2FtzFwXvJ1gK6@cmpxchg.org/T/
>
> Thanks, this is a useful insight.
>  
>> This hopefully also explains why it's a global setting. The usecase is
>> different from conventional NUMA interleaving, which is used as a
>> locality measure: spread shared data evenly between compute
>> nodes. This one isn't about locality - the CXL tier doesn't have local
>> compute. Instead, the optimal spread is based on hardware parameters,
>> which is a global property rather than a per-workload one.
>
> Well, I am not convinced about that TBH. Sure it is probably a good fit
> for this specific CXL usecase but it just doesn't fit into many others I
> can think of - e.g. proportional use of those tiers based on the
> workload - you get what you pay for.

For "pay", per my understanding, we need some cgroup based
per-memory-tier (or per-node) usage limit.  The following patchset is
the first step for that.

https://lore.kernel.org/linux-mm/cover.1655242024.git.tim.c.chen@linux.intel.com/

--
Best Regards,
Huang, Ying
