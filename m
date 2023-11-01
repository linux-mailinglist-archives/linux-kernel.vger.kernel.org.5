Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F238C7DDB0C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbjKACg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344958AbjKACgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:36:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E30102;
        Tue, 31 Oct 2023 19:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698806179; x=1730342179;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=CN4PDYT+KcfignHaXej0DYuB1qouUibKHlCbKBw8oZ4=;
  b=gQc/s7GKMisukvnLGgKJsbIqLUbiLhfBvIhbqK6PCNErbLExr4Kx9Dz3
   DKBjnpMOXpP0g4LfXXSrMSLUrSjuj0lZBo66DNYYAFt2/00+rXV4jE8Ad
   4PMkLcaPSYWNeCe0CEQ1iAdkl1CQNiK4Na9B/cOJRtT/FXIj1zX2YToXM
   rREPSvzQKeKMKz2ZeHKptfgnCsqp7orpNgAjsWHVmSfxzxm2ei0/oBdwv
   LwU46mePbmMNgqyR499pP9x2dgkpZx6JHZlFdO0WGdC96Qwflmh3YfQCE
   X0FuhlIjW0i15t2J6lFgUOtt29aBOMidx7ZsLk9mgpJZaFDDjKk7p8OMv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="385599662"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="385599662"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 19:36:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="1954297"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 19:36:15 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, weixugc@google.com, apopple@nvidia.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, shy828301@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
In-Reply-To: <20231031162216.GB3029315@cmpxchg.org> (Johannes Weiner's message
        of "Tue, 31 Oct 2023 12:22:16 -0400")
References: <20231031003810.4532-1-gregory.price@memverge.com>
        <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
        <20231031152142.GA3029315@cmpxchg.org>
        <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
        <20231031162216.GB3029315@cmpxchg.org>
Date:   Wed, 01 Nov 2023 10:34:12 +0800
Message-ID: <87il6m6w2j.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Tue, Oct 31, 2023 at 04:56:27PM +0100, Michal Hocko wrote:
>> On Tue 31-10-23 11:21:42, Johannes Weiner wrote:
>> > On Tue, Oct 31, 2023 at 10:53:41AM +0100, Michal Hocko wrote:
>> > > On Mon 30-10-23 20:38:06, Gregory Price wrote:

[snip]

>>  
>> > This hopefully also explains why it's a global setting. The usecase is
>> > different from conventional NUMA interleaving, which is used as a
>> > locality measure: spread shared data evenly between compute
>> > nodes. This one isn't about locality - the CXL tier doesn't have local
>> > compute. Instead, the optimal spread is based on hardware parameters,
>> > which is a global property rather than a per-workload one.
>> 
>> Well, I am not convinced about that TBH. Sure it is probably a good fit
>> for this specific CXL usecase but it just doesn't fit into many others I
>> can think of - e.g. proportional use of those tiers based on the
>> workload - you get what you pay for.
>> 
>> Is there any specific reason for not having a new interleave interface
>> which defines weights for the nodemask? Is this because the policy
>> itself is very dynamic or is this more driven by simplicity of use?
>
> A downside of *requiring* weights to be paired with the mempolicy is
> that it's then the application that would have to figure out the
> weights dynamically, instead of having a static host configuration. A
> policy of "I want to be spread for optimal bus bandwidth" translates
> between different hardware configurations, but optimal weights will
> vary depending on the type of machine a job runs on.
>
> That doesn't mean there couldn't be usecases for having weights as
> policy as well in other scenarios, like you allude to above. It's just
> so far such usecases haven't really materialized or spelled out
> concretely. Maybe we just want both - a global default, and the
> ability to override it locally.

I think that this is a good idea.  The system-wise configuration with
reasonable default makes applications life much easier.  If more control
is needed, some kind of workload specific configuration can be added.
And, instead of adding another memory policy, a cgroup-wise
configuration may be easier to be used.  The per-workload weight may
need to be adjusted when we deploying different combination of workloads
in the system.

Another question is that should the weight be per-memory-tier or
per-node?  In this patchset, the weight is per-source-target-node
combination.  That is, the weight becomes a matrix instead of a vector.
IIUC, this is used to control cross-socket memory access in addition to
per-memory-type memory access.  Do you think the added complexity is
necessary?

> Could you elaborate on the 'get what you pay for' usecase you
> mentioned?

--
Best Regards,
Huang, Ying
