Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B3B7C6E81
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347198AbjJLMxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343867AbjJLMxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:53:00 -0400
Received: from outbound-smtp51.blacknight.com (outbound-smtp51.blacknight.com [46.22.136.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A890391
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:52:56 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp51.blacknight.com (Postfix) with ESMTPS id 1AE37FB058
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:52:55 +0100 (IST)
Received: (qmail 5844 invoked from network); 12 Oct 2023 12:52:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Oct 2023 12:52:54 -0000
Date:   Thu, 12 Oct 2023 13:52:53 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 02/10] cacheinfo: calculate per-CPU data cache size
Message-ID: <20231012125253.fpeehd6362c5v2sj@techsingularity.net>
References: <20230920061856.257597-1-ying.huang@intel.com>
 <20230920061856.257597-3-ying.huang@intel.com>
 <20231011122027.pw3uw32sdxxqjsrq@techsingularity.net>
 <87h6mwf3gf.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87h6mwf3gf.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 08:08:32PM +0800, Huang, Ying wrote:
> Mel Gorman <mgorman@techsingularity.net> writes:
> 
> > On Wed, Sep 20, 2023 at 02:18:48PM +0800, Huang Ying wrote:
> >> Per-CPU data cache size is useful information.  For example, it can be
> >> used to determine per-CPU cache size.  So, in this patch, the data
> >> cache size for each CPU is calculated via data_cache_size /
> >> shared_cpu_weight.
> >> 
> >> A brute-force algorithm to iterate all online CPUs is used to avoid
> >> to allocate an extra cpumask, especially in offline callback.
> >> 
> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> >
> > It's not necessarily relevant to the patch, but at least the scheduler
> > also stores some per-cpu topology information such as sd_llc_size -- the
> > number of CPUs sharing the same last-level-cache as this CPU. It may be
> > worth unifying this at some point if it's common that per-cpu
> > information is too fine and per-zone or per-node information is too
> > coarse. This would be particularly true when considering locking
> > granularity,
> >
> >> Cc: Sudeep Holla <sudeep.holla@arm.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Mel Gorman <mgorman@techsingularity.net>
> >> Cc: Vlastimil Babka <vbabka@suse.cz>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Johannes Weiner <jweiner@redhat.com>
> >> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> >> Cc: Matthew Wilcox <willy@infradead.org>
> >> Cc: Christoph Lameter <cl@linux.com>
> >> ---
> >>  drivers/base/cacheinfo.c  | 42 ++++++++++++++++++++++++++++++++++++++-
> >>  include/linux/cacheinfo.h |  1 +
> >>  2 files changed, 42 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> >> index cbae8be1fe52..3e8951a3fbab 100644
> >> --- a/drivers/base/cacheinfo.c
> >> +++ b/drivers/base/cacheinfo.c
> >> @@ -898,6 +898,41 @@ static int cache_add_dev(unsigned int cpu)
> >>  	return rc;
> >>  }
> >>  
> >> +static void update_data_cache_size_cpu(unsigned int cpu)
> >> +{
> >> +	struct cpu_cacheinfo *ci;
> >> +	struct cacheinfo *leaf;
> >> +	unsigned int i, nr_shared;
> >> +	unsigned int size_data = 0;
> >> +
> >> +	if (!per_cpu_cacheinfo(cpu))
> >> +		return;
> >> +
> >> +	ci = ci_cacheinfo(cpu);
> >> +	for (i = 0; i < cache_leaves(cpu); i++) {
> >> +		leaf = per_cpu_cacheinfo_idx(cpu, i);
> >> +		if (leaf->type != CACHE_TYPE_DATA &&
> >> +		    leaf->type != CACHE_TYPE_UNIFIED)
> >> +			continue;
> >> +		nr_shared = cpumask_weight(&leaf->shared_cpu_map);
> >> +		if (!nr_shared)
> >> +			continue;
> >> +		size_data += leaf->size / nr_shared;
> >> +	}
> >> +	ci->size_data = size_data;
> >> +}
> >
> > This needs comments.
> >
> > It would be nice to add a comment on top describing the limitation of
> > CACHE_TYPE_UNIFIED here in the context of
> > update_data_cache_size_cpu().
> 
> Sure.  Will do that.
> 

Thanks.

> > The L2 cache could be unified but much smaller than a L3 or other
> > last-level-cache. It's not clear from the code what level of cache is being
> > used due to a lack of familiarity of the cpu_cacheinfo code but size_data
> > is not the size of a cache, it appears to be the share of a cache a CPU
> > would have under ideal circumstances.
> 
> Yes.  And it isn't for one specific level of cache.  It's sum of per-CPU
> shares of all levels of cache.  But the calculation is inaccurate.  More
> details are in the below reply.
> 
> > However, as it appears to also be
> > iterating hierarchy then this may not be accurate. Caches may or may not
> > allow data to be duplicated between levels so the value may be inaccurate.
> 
> Thank you very much for pointing this out!  The cache can be inclusive
> or not.  So, we cannot calculate the per-CPU slice of all-level caches
> via adding them together blindly.  I will change this in a follow-on
> patch.
> 

Please do, I would strongly suggest basing this on LLC only because it's
the only value you can be sure of. This change is the only change that may
warrant a respin of the series as the history will be somewhat confusing
otherwise.

-- 
Mel Gorman
SUSE Labs
