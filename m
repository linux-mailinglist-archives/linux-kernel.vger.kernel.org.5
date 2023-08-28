Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9825C78B7C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjH1TCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjH1TBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:01:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B01E0;
        Mon, 28 Aug 2023 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693249291; x=1724785291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KZPfLYpGnJSu/C8KGBRwKECa7cxJe+NwZDmDiVii1JA=;
  b=h6yayN5tWLhqY10XMaQmmyaHwv1Luwb4E2VhzZ8uOg6hPd7P+UiAy7wW
   6HRMJlKb0phl/pPvSRllsvNJOgvKkPogjH/c8EIP8GcNZdMIhEQO1mx4E
   OQWGKawIi2tedClJTRW84RnC2S+vnuujtDdx2tVEHeclz8CpqDyjD3jat
   aaKs3CS61eWIRSby0oE4WUpvlbs2BgJ/8Cx+U+vSfgevaXwz8Q1h0LQMV
   m7dntPLPzFpQsby19CgvBgkatS5neoyoIQitAKL96QSZtWEPlfSDGckBV
   tTvSoSpi0TkCNmT4lzCw0KIX1UBgjj9RxN2wSwciNHi2C+4pnflvTSPga
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="378961561"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="378961561"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 12:01:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="715220950"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="715220950"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 12:01:30 -0700
Date:   Mon, 28 Aug 2023 12:01:28 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v4 5/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Message-ID: <ZOzvCHcDy6xaEsB8@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-6-tony.luck@intel.com>
 <7c8650d5-eb69-dd28-81fc-7a97d45f9bfb@intel.com>
 <ZOjpugXNDVx/cGRl@agluck-desk3>
 <15b289cd-3e9c-3757-c1b0-7f5f79244564@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15b289cd-3e9c-3757-c1b0-7f5f79244564@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:05:50AM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/25/2023 10:49 AM, Tony Luck wrote:
> > On Fri, Aug 11, 2023 at 10:32:29AM -0700, Reinette Chatre wrote:
> >> On 7/22/2023 12:07 PM, Tony Luck wrote:
> 
> ...
> 
> >>> +static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
> >>> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
> >>> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
> >>> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
> >>> +	{}
> >>> +};
> >>> +
> >>> +/*
> >>> + * There isn't a simple enumeration bit to show whether SNC mode
> >>> + * is enabled. Look at the ratio of number of NUMA nodes to the
> >>> + * number of distinct L3 caches. Take care to skip memory-only nodes.
> >>> + */
> >>> +static __init int get_snc_config(void)
> >>> +{
> >>> +	unsigned long *node_caches;
> >>> +	int mem_only_nodes = 0;
> >>> +	int cpu, node, ret;
> >>> +
> >>> +	if (!x86_match_cpu(snc_cpu_ids))
> >>> +		return 1;
> >>> +
> >>> +	node_caches = kcalloc(BITS_TO_LONGS(nr_node_ids), sizeof(*node_caches), GFP_KERNEL);
> >>> +	if (!node_caches)
> >>> +		return 1;
> >>> +
> >>> +	cpus_read_lock();
> >>> +	for_each_node(node) {
> >>> +		cpu = cpumask_first(cpumask_of_node(node));
> >>> +		if (cpu < nr_cpu_ids)
> >>> +			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
> >>> +		else
> >>> +			mem_only_nodes++;
> >>> +	}
> >>> +	cpus_read_unlock();
> >>
> >> I am not familiar with the numa code at all so please correct me
> >> where I am wrong. I do see that nr_node_ids is initialized with __init code
> >> so it should be accurate at this point. It looks to me like this initialization
> >> assumes that at least one CPU per node will be online at the time it is run.
> >> It is not clear to me that this assumption would always be true. 
> > 
> > Resctrl initialization is kicked off as a late_initcall(). So all CPUs
> > and devices are fully initialized before this code runs.
> > 
> > Resctrl can't be moved to an "init" state before CPUs are brought online
> > because it makes a call to cpuhp_setup_state() to get callbacks for
> > online/offline CPU events ... that call can't be done early.
> 
> Apologies but this is not so obvious to me. From what I understand a
> system need not be booted with all CPUs online. CPUs can be brought
> online at any time.

So you are concerned about the case where the system was booted with a
maxcpus=N boot argument, and additional CPUs are brought online later?

My code will fail to detect SNC mode if someone does that. I don't see
any possible way to recover from this in a safe way later when additional
CPUs are brought online. Those CPUs could be brought online in any order
by the user, and there is no way to know when they are all done. Without an
explicit enumeration of SNC mode there is no fool-proof way to detect
SNC mode in the face of CPU hot plug post-boot.

I could add a pr_warn() into this code:

 915 static int __init nrcpus(char *str)
 916 {
 917         int nr_cpus;
 918
 919         if (get_option(&str, &nr_cpus) && nr_cpus > 0 && nr_cpus < nr_cpu_ids)
 920                 set_nr_cpu_ids(nr_cpus);
 921
 922         return 0;
 923 }
 924
 925 early_param("nr_cpus", nrcpus);

But this feels like a "user shot themself in the foot" case. I don't
think it necessary to add checks and warnings for every possible strange
way a user could configure a system.

> >>> +
> >>> +	ret = (nr_node_ids - mem_only_nodes) / bitmap_weight(node_caches, nr_node_ids);
> >>> +	kfree(node_caches);
> >>> +
> >>> +	if (ret > 1)
> >>> +		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = MON_SCOPE_NODE;
> >>> +
> >>> +	return ret;
> >>> +}
> >>> +

-Tony
