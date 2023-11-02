Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024AC7DECF2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjKBGnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBGnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:43:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165DF125;
        Wed,  1 Nov 2023 23:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698907390; x=1730443390;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=eFzutUwI91AlprFudf7uXPVWde/i5DfJ1a5Vzf3IEHM=;
  b=DBBfIHJrEAcsME4CLAzNvgjMAbnWGkNG3lVW6oVO9u52dEwoXYo+OM7E
   bqEl1Cn57FmuQaUUKERqXpL9orCgCNbnzdFNU8gmn6f8lGoq0nyXQh1YC
   b8EpHspZqQW4MdNvHOSXebAJed+O5DZYPQlKll/R/lG/DU7FyK9MxRB0W
   oJN4s6nY0SJtQyVoEBOYCD/3dBPx6S/QeCkXMkXTeboaIa2WodnSjyeNV
   ed2TOsY3SaJKDfk0x0/SZs0MyPd8oRElGtsuGOKjn8m65mhEoSyY2+8vr
   w24B36Vl1mQ/LYLyxCOqmmYfX58Z3okAlBRfN1DuzdGPoUKj7ots07wek
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="474887758"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="474887758"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 23:43:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711040332"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="711040332"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 23:43:05 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ravi Jonnalagadda <ravis.opensrc@micron.com>
Cc:     <akpm@linux-foundation.org>, <aneesh.kumar@linux.ibm.com>,
        <apopple@nvidia.com>, <dave.hansen@intel.com>,
        <gourry.memverge@gmail.com>, <gregkh@linuxfoundation.org>,
        <gregory.price@memverge.com>, <hannes@cmpxchg.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mhocko@suse.com>, <rafael@kernel.org>,
        <shy828301@gmail.com>, <tim.c.chen@intel.com>, <weixugc@google.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
In-Reply-To: <20231101092923.283-1-ravis.opensrc@micron.com> (Ravi
        Jonnalagadda's message of "Wed, 1 Nov 2023 14:59:23 +0530")
References: <87il6m6w2j.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20231101092923.283-1-ravis.opensrc@micron.com>
Date:   Thu, 02 Nov 2023 14:41:03 +0800
Message-ID: <87a5rw1wu8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Jonnalagadda <ravis.opensrc@micron.com> writes:

>>> On Tue, Oct 31, 2023 at 04:56:27PM +0100, Michal Hocko wrote:
>>>> On Tue 31-10-23 11:21:42, Johannes Weiner wrote:
>>>> > On Tue, Oct 31, 2023 at 10:53:41AM +0100, Michal Hocko wrote:
>>>> > > On Mon 30-10-23 20:38:06, Gregory Price wrote:
>>
>>[snip]
>>
>>>>
>>>> > This hopefully also explains why it's a global setting. The usecase is
>>>> > different from conventional NUMA interleaving, which is used as a
>>>> > locality measure: spread shared data evenly between compute
>>>> > nodes. This one isn't about locality - the CXL tier doesn't have local
>>>> > compute. Instead, the optimal spread is based on hardware parameters,
>>>> > which is a global property rather than a per-workload one.
>>>>
>>>> Well, I am not convinced about that TBH. Sure it is probably a good fit
>>>> for this specific CXL usecase but it just doesn't fit into many others I
>>>> can think of - e.g. proportional use of those tiers based on the
>>>> workload - you get what you pay for.
>>>>
>>>> Is there any specific reason for not having a new interleave interface
>>>> which defines weights for the nodemask? Is this because the policy
>>>> itself is very dynamic or is this more driven by simplicity of use?
>>>
>>> A downside of *requiring* weights to be paired with the mempolicy is
>>> that it's then the application that would have to figure out the
>>> weights dynamically, instead of having a static host configuration. A
>>> policy of "I want to be spread for optimal bus bandwidth" translates
>>> between different hardware configurations, but optimal weights will
>>> vary depending on the type of machine a job runs on.
>>>
>>> That doesn't mean there couldn't be usecases for having weights as
>>> policy as well in other scenarios, like you allude to above. It's just
>>> so far such usecases haven't really materialized or spelled out
>>> concretely. Maybe we just want both - a global default, and the
>>> ability to override it locally.
>>
>>I think that this is a good idea.  The system-wise configuration with
>>reasonable default makes applications life much easier.  If more control
>>is needed, some kind of workload specific configuration can be added.
>
> Glad that we are in agreement here. For bandwidth expansion use cases
> that this interleave patchset is trying to cater to, most applications
> would have to follow the "reasanable defaults" for weights.
> The necessity for applications to choose different weights while
> interleaving would probably be to do capacity expansion which the
> default memory tiering implementation would anyway support and provide
> better latency.
>
>>And, instead of adding another memory policy, a cgroup-wise
>>configuration may be easier to be used.  The per-workload weight may
>>need to be adjusted when we deploying different combination of workloads
>>in the system.
>>
>>Another question is that should the weight be per-memory-tier or
>>per-node?  In this patchset, the weight is per-source-target-node
>>combination.  That is, the weight becomes a matrix instead of a vector.
>>IIUC, this is used to control cross-socket memory access in addition to
>>per-memory-type memory access.  Do you think the added complexity is
>>necessary?
>
> Pros and Cons of Node based interleave:
> Pros:
> 1. Weights can be defined for devices with different bandwidth and latency
> characteristics individually irrespective of which tier they fall into.
> 2. Defining the weight per-source-target-node would be necessary for multi
> socket systems where few devices may be closer to one socket rather than other.
> Cons:
> 1. Weights need to be programmed for all the nodes which can be tedious for
> systems with lot of NUMA nodes.

2. More complex, so need justification, for example, practical use case.

> Pros and Cons of Memory Tier based interleave:
> Pros:
> 1. Programming weight per initiator would apply for all the nodes in the tier.
> 2. Weights can be calculated considering the cumulative bandwidth of all
> the nodes in the tier and need to be programmed once for all the nodes in a
> given tier.
> 3. It may be useful in cases where numa nodes with similar latency and bandwidth
> characteristics increase, possibly with pooling use cases.

4. simpler.

> Cons:
> 1. If nodes with different bandwidth and latency characteristics are placed
> in same tier as seen in the current mainline kernel, it will be difficult to
> apply a correct interleave weight policy.
> 2. There will be a need for functionality to move nodes between different tiers
> or create new tiers to place such nodes for programming correct interleave weights.
> We are working on a patch to support it currently.

Thanks!  If we have such system, we will need this.

> 3. For systems where each numa node is having different characteristics,
> a single node might end up existing in different memory tier, which would be
> equivalent to node based interleaving.

No.  A node can only exist in one memory tier.

> On newer systems where all CXL memory from different devices under a
> port are combined to form single numa node, this scenario might be
> applicable.

You mean the different memory ranges of a NUMA node may have different
performance?  I don't think that we can deal with this.

> 4. Users may need to keep track of different memory tiers and what nodes are present
> in each tier for invoking interleave policy.

I don't think this is a con.  With node based solution, you need to know
your system too.

>>
>>> Could you elaborate on the 'get what you pay for' usecase you
>>> mentioned?
>>

--
Best Regards,
Huang, Ying
