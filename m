Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56157C7BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjJMDJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMDJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:09:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FAC91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697166545; x=1728702545;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=o/31H4jmTsoKxypwaT/p0YWnSttnLl3/KzbSB3YQFtU=;
  b=ScHmWAWWC8tn9vMkrNVxv7lhxPhLLjkLBXTKhv3u4ElQSvCX8uErI03e
   09D93kLTq5fel9xDOg5QxkuKeg3Ef+//D8EyM3HaJF5eZyGc4VTy70JA6
   8Kkkk34UojdXsmKAkZ6N3rCO5M7DX4HfFFNSkQpDw75DN6/u0IWawYPaT
   WwGsTLS1wzQULRT+CVlGIPGjH5kzmlKoeG0N0/NWGfUaxRvPPu6z0h0we
   4tMCU5zWSKbfEo8MVPRRm8uCCNn8yBWkVyEYa2F9Z9azisgMdgA3Qa1DM
   ur/AwCClyC9ip32B5lxj/yhr5WPgLIBKWEBAnwtTNxzs7odtOTGlxYxcj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="370163248"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="370163248"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 20:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="748168202"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="748168202"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 20:08:59 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Pavel Tatashin" <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 02/10] cacheinfo: calculate per-CPU data cache size
References: <20230920061856.257597-1-ying.huang@intel.com>
        <20230920061856.257597-3-ying.huang@intel.com>
        <20231011122027.pw3uw32sdxxqjsrq@techsingularity.net>
        <87h6mwf3gf.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20231012125253.fpeehd6362c5v2sj@techsingularity.net>
        <87v8bcdly7.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20231012152250.xuu5mvghwtonpvp2@techsingularity.net>
Date:   Fri, 13 Oct 2023 11:06:51 +0800
In-Reply-To: <20231012152250.xuu5mvghwtonpvp2@techsingularity.net> (Mel
        Gorman's message of "Thu, 12 Oct 2023 16:22:50 +0100")
Message-ID: <87pm1jcjas.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Thu, Oct 12, 2023 at 09:12:00PM +0800, Huang, Ying wrote:
>> Mel Gorman <mgorman@techsingularity.net> writes:
>> 
>> > On Thu, Oct 12, 2023 at 08:08:32PM +0800, Huang, Ying wrote:
>> >> Mel Gorman <mgorman@techsingularity.net> writes:
>> >> 
>> >> > On Wed, Sep 20, 2023 at 02:18:48PM +0800, Huang Ying wrote:
>> >> >> Per-CPU data cache size is useful information.  For example, it can be
>> >> >> used to determine per-CPU cache size.  So, in this patch, the data
>> >> >> cache size for each CPU is calculated via data_cache_size /
>> >> >> shared_cpu_weight.
>> >> >> 
>> >> >> A brute-force algorithm to iterate all online CPUs is used to avoid
>> >> >> to allocate an extra cpumask, especially in offline callback.
>> >> >> 
>> >> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> >> >
>> >> > It's not necessarily relevant to the patch, but at least the scheduler
>> >> > also stores some per-cpu topology information such as sd_llc_size -- the
>> >> > number of CPUs sharing the same last-level-cache as this CPU. It may be
>> >> > worth unifying this at some point if it's common that per-cpu
>> >> > information is too fine and per-zone or per-node information is too
>> >> > coarse. This would be particularly true when considering locking
>> >> > granularity,
>> >> >
>> >> >> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> >> >> Cc: Andrew Morton <akpm@linux-foundation.org>
>> >> >> Cc: Mel Gorman <mgorman@techsingularity.net>
>> >> >> Cc: Vlastimil Babka <vbabka@suse.cz>
>> >> >> Cc: David Hildenbrand <david@redhat.com>
>> >> >> Cc: Johannes Weiner <jweiner@redhat.com>
>> >> >> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> >> >> Cc: Michal Hocko <mhocko@suse.com>
>> >> >> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> >> >> Cc: Matthew Wilcox <willy@infradead.org>
>> >> >> Cc: Christoph Lameter <cl@linux.com>
>> >> >> ---
>> >> >>  drivers/base/cacheinfo.c  | 42 ++++++++++++++++++++++++++++++++++++++-
>> >> >>  include/linux/cacheinfo.h |  1 +
>> >> >>  2 files changed, 42 insertions(+), 1 deletion(-)
>> >> >> 
>> >> >> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>> >> >> index cbae8be1fe52..3e8951a3fbab 100644
>> >> >> --- a/drivers/base/cacheinfo.c
>> >> >> +++ b/drivers/base/cacheinfo.c
>> >> >> @@ -898,6 +898,41 @@ static int cache_add_dev(unsigned int cpu)
>> >> >>  	return rc;
>> >> >>  }
>> >> >>  
>> >> >> +static void update_data_cache_size_cpu(unsigned int cpu)
>> >> >> +{
>> >> >> +	struct cpu_cacheinfo *ci;
>> >> >> +	struct cacheinfo *leaf;
>> >> >> +	unsigned int i, nr_shared;
>> >> >> +	unsigned int size_data = 0;
>> >> >> +
>> >> >> +	if (!per_cpu_cacheinfo(cpu))
>> >> >> +		return;
>> >> >> +
>> >> >> +	ci = ci_cacheinfo(cpu);
>> >> >> +	for (i = 0; i < cache_leaves(cpu); i++) {
>> >> >> +		leaf = per_cpu_cacheinfo_idx(cpu, i);
>> >> >> +		if (leaf->type != CACHE_TYPE_DATA &&
>> >> >> +		    leaf->type != CACHE_TYPE_UNIFIED)
>> >> >> +			continue;
>> >> >> +		nr_shared = cpumask_weight(&leaf->shared_cpu_map);
>> >> >> +		if (!nr_shared)
>> >> >> +			continue;
>> >> >> +		size_data += leaf->size / nr_shared;
>> >> >> +	}
>> >> >> +	ci->size_data = size_data;
>> >> >> +}
>> >> >
>> >> > This needs comments.
>> >> >
>> >> > It would be nice to add a comment on top describing the limitation of
>> >> > CACHE_TYPE_UNIFIED here in the context of
>> >> > update_data_cache_size_cpu().
>> >> 
>> >> Sure.  Will do that.
>> >> 
>> >
>> > Thanks.
>> >
>> >> > The L2 cache could be unified but much smaller than a L3 or other
>> >> > last-level-cache. It's not clear from the code what level of cache is being
>> >> > used due to a lack of familiarity of the cpu_cacheinfo code but size_data
>> >> > is not the size of a cache, it appears to be the share of a cache a CPU
>> >> > would have under ideal circumstances.
>> >> 
>> >> Yes.  And it isn't for one specific level of cache.  It's sum of per-CPU
>> >> shares of all levels of cache.  But the calculation is inaccurate.  More
>> >> details are in the below reply.
>> >> 
>> >> > However, as it appears to also be
>> >> > iterating hierarchy then this may not be accurate. Caches may or may not
>> >> > allow data to be duplicated between levels so the value may be inaccurate.
>> >> 
>> >> Thank you very much for pointing this out!  The cache can be inclusive
>> >> or not.  So, we cannot calculate the per-CPU slice of all-level caches
>> >> via adding them together blindly.  I will change this in a follow-on
>> >> patch.
>> >> 
>> >
>> > Please do, I would strongly suggest basing this on LLC only because it's
>> > the only value you can be sure of. This change is the only change that may
>> > warrant a respin of the series as the history will be somewhat confusing
>> > otherwise.
>> 
>> I am still checking whether it's possible to get cache inclusive
>> information via cpuid.
>> 
>
> cpuid may be x86-specific so that potentially leads to different behaviours
> on different architectures.
>
>> If there's no reliable way to do that.  We can use the max value of
>> per-CPU share of each level of cache.  For inclusive cache, that will be
>> the value of LLC.  For non-inclusive cache, the value will be more
>> accurate.  For example, on Intel Sapphire Rapids, the L2 cache is 2 MB
>> per core, while LLC is 1.875 MB per core according to [1].
>> 
>
> Be that as it may, it still opens the possibility of significantly different
> behaviour depending on the CPU family. I would strongly recommend that you
> start with LLC only because LLC is also the topology level of interest used
> by the scheduler and it's information that is generally available. Trying
> to get accurate information on every level and the complexity of dealing
> with inclusive vs exclusive cache or write-back vs write-through should
> be a separate patch, with separate justification and notes on how it can
> lead to behaviour specific to the CPU family or architecture.

IMHO, we should try to optimize for as many CPUs as possible.  The size
of the per-CPU (HW thread for SMT) slice of LLC of latest Intel server
CPUs is as follows,

Icelake: 0.75 MB
Sapphire Rapids: 0.9375 MB

While pcp->batch is 63 * 4 / 1024 = 0.2461 MB.

In [03/10], only if "per_cpu_cache_slice > 4 * pcp->batch", we will cache
pcp->batch before draining the PCP.  This makes the optimization
unavailable for a significant portion of the server CPUs.

In theory, if "per_cpu_cache_slice > 2 * pcp->batch", we can reuse
cache-hot pages between CPUs.  So, if we change the condition to
"per_cpu_cache_slice > 3 * pcp->batch", I think that we are still safe.

As for other CPUs, according to [2], AMD CPUs have larger per-CPU LLC.
So, it's OK for them.  ARM CPUs has much smaller per-CPU LLC, so some
further optimization is needed.

[2] https://www.anandtech.com/show/16594/intel-3rd-gen-xeon-scalable-review/2

So, I suggest to use "per_cpu_cache_slice > 3 * pcp->batch" in [03/10],
and use LLC in this patch [02/10].  Then, we can optimize the per-CPU
slice of cache calculation in the follow-up patches.

--
Best Regards,
Huang, Ying

