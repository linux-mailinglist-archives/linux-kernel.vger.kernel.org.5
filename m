Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7B77C6DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378072AbjJLML2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347228AbjJLMLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:11:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E31ADE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697112645; x=1728648645;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=aGPNyyHZGclj4QMEorBt1ru1JxmaLGUFsATG3irdAdM=;
  b=KoSppk8UxUr2NW5mSTT+aImNavOxWfVXgiDYMKXVfcSsxM0CFskm9lTR
   rDQjykf5IBSdnrIF/sCEW04+Sq/OwVg0+1hg/rLRTcwnST0P2cSdKOPk7
   NGkSea/GiY7UyOBG8ejODxVzP2fqAWBFOBtLznql6g99ByQ5qgJXinqZ2
   sCQDddGCg2SXJ5i/QQBn8Ms7ldVul3JXOUWCkOaSjwBmjO24mw1D72VoJ
   BWbL1iQu4U8kVPakbTT83b8OBrjDxsi+jXz8Qavrv3l8DqffpeRI1UlE4
   L2lzBouC5sfvL2I6ZoV1yUvXLfIikrDXVYcvF0cODFybX0c5EgdAlCNdc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3495978"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="3495978"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="730899713"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="730899713"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:10:40 -0700
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
Date:   Thu, 12 Oct 2023 20:08:32 +0800
In-Reply-To: <20231011122027.pw3uw32sdxxqjsrq@techsingularity.net> (Mel
        Gorman's message of "Wed, 11 Oct 2023 13:20:27 +0100")
Message-ID: <87h6mwf3gf.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, Sep 20, 2023 at 02:18:48PM +0800, Huang Ying wrote:
>> Per-CPU data cache size is useful information.  For example, it can be
>> used to determine per-CPU cache size.  So, in this patch, the data
>> cache size for each CPU is calculated via data_cache_size /
>> shared_cpu_weight.
>> 
>> A brute-force algorithm to iterate all online CPUs is used to avoid
>> to allocate an extra cpumask, especially in offline callback.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>
> It's not necessarily relevant to the patch, but at least the scheduler
> also stores some per-cpu topology information such as sd_llc_size -- the
> number of CPUs sharing the same last-level-cache as this CPU. It may be
> worth unifying this at some point if it's common that per-cpu
> information is too fine and per-zone or per-node information is too
> coarse. This would be particularly true when considering locking
> granularity,
>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Johannes Weiner <jweiner@redhat.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Christoph Lameter <cl@linux.com>
>> ---
>>  drivers/base/cacheinfo.c  | 42 ++++++++++++++++++++++++++++++++++++++-
>>  include/linux/cacheinfo.h |  1 +
>>  2 files changed, 42 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>> index cbae8be1fe52..3e8951a3fbab 100644
>> --- a/drivers/base/cacheinfo.c
>> +++ b/drivers/base/cacheinfo.c
>> @@ -898,6 +898,41 @@ static int cache_add_dev(unsigned int cpu)
>>  	return rc;
>>  }
>>  
>> +static void update_data_cache_size_cpu(unsigned int cpu)
>> +{
>> +	struct cpu_cacheinfo *ci;
>> +	struct cacheinfo *leaf;
>> +	unsigned int i, nr_shared;
>> +	unsigned int size_data = 0;
>> +
>> +	if (!per_cpu_cacheinfo(cpu))
>> +		return;
>> +
>> +	ci = ci_cacheinfo(cpu);
>> +	for (i = 0; i < cache_leaves(cpu); i++) {
>> +		leaf = per_cpu_cacheinfo_idx(cpu, i);
>> +		if (leaf->type != CACHE_TYPE_DATA &&
>> +		    leaf->type != CACHE_TYPE_UNIFIED)
>> +			continue;
>> +		nr_shared = cpumask_weight(&leaf->shared_cpu_map);
>> +		if (!nr_shared)
>> +			continue;
>> +		size_data += leaf->size / nr_shared;
>> +	}
>> +	ci->size_data = size_data;
>> +}
>
> This needs comments.
>
> It would be nice to add a comment on top describing the limitation of
> CACHE_TYPE_UNIFIED here in the context of
> update_data_cache_size_cpu().

Sure.  Will do that.

> The L2 cache could be unified but much smaller than a L3 or other
> last-level-cache. It's not clear from the code what level of cache is being
> used due to a lack of familiarity of the cpu_cacheinfo code but size_data
> is not the size of a cache, it appears to be the share of a cache a CPU
> would have under ideal circumstances.

Yes.  And it isn't for one specific level of cache.  It's sum of per-CPU
shares of all levels of cache.  But the calculation is inaccurate.  More
details are in the below reply.

> However, as it appears to also be
> iterating hierarchy then this may not be accurate. Caches may or may not
> allow data to be duplicated between levels so the value may be inaccurate.

Thank you very much for pointing this out!  The cache can be inclusive
or not.  So, we cannot calculate the per-CPU slice of all-level caches
via adding them together blindly.  I will change this in a follow-on
patch.

> A respin of the patch is not necessary but a follow-on patch adding
> clarifing comments would be very welcome covering
>
> o What levels of cache are being used
> o Describe what size_data actually is and preferably rename the field
>   to be more explicit as "size" could be the total cache capacity, the
>   cache slice under ideal circumstances or even the number of CPUs sharing
>   that cache.

Sure.

> The cache details *may* need a follow-on patch if the size_data value is
> misleading. If it is a hierarchy and the value does not always represent
> the slice of cache a CPU could have under ideal circumstances then the
> value should be based on the LLC only so that it is predictable across
> architectures.

Sure.

--
Best Regards,
Huang, Ying
