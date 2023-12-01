Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D22800052
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377456AbjLAAhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377446AbjLAAhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:37:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D815110DE;
        Thu, 30 Nov 2023 16:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701391040; x=1732927040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OAXgylAvqbL36kLJ778XRMQl7eMkZD8otzMFMN2gudo=;
  b=gMNA2r6oqUgmg9LRxDTmyLraXwvXsPw95rtgV9bDggFNuLF0mQwE3pC/
   8YiTmhfIYqYI17VVtrJ7NzrDj5F9bYWojS3lr5tDKag/SMTXGGG6iFcWU
   I/cFKxjK6HptuSNaJy9rQAasP2kagSVEGm2Xdskhu3ZUOZUrr0CYG/gRQ
   a4XYt7KyQStNku1+A47IZ0VFX56h+MgOU7lWgueIgnE5660xS1QGvcHor
   UW1TR8OZ1X5wAvZn7oR5Prx16JEs6yy77K5tMjEBxFeKb0fzJmMdbsgq4
   UFLET5wN1B/yuVrrKNRfgvmyO7FQYIAq/0IULLABk3z9wT4C2vDtrlo85
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="311715"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="311715"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 16:37:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="839984290"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="839984290"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 16:37:20 -0800
Date:   Thu, 30 Nov 2023 16:37:19 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fam Zheng <fam@euphon.net>, Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v12 7/8] x86/resctrl: Sub NUMA Cluster detection and
 enable
Message-ID: <ZWkqv+egQuph03Bm@agluck-desk3>
References: <20231109230915.73600-1-tony.luck@intel.com>
 <20231130003418.89964-1-tony.luck@intel.com>
 <20231130003418.89964-8-tony.luck@intel.com>
 <ZWjOBw0Ygyw226Cc@dell>
 <ZWj3NdI/qLNOgyg0@agluck-desk3>
 <1c1a16a5-f235-4179-9d0f-1556e11d9c11@intel.com>
 <ZWkQBwwtSae4nGgH@agluck-desk3>
 <5078f930-e56e-45b5-9df3-99e88c0858dd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5078f930-e56e-45b5-9df3-99e88c0858dd@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 03:40:52PM -0800, Reinette Chatre wrote:
> Hi Tony,
> 
> On 11/30/2023 2:43 PM, Tony Luck wrote:
> > On Thu, Nov 30, 2023 at 01:47:10PM -0800, Reinette Chatre wrote:
> 
> ...
> 
> >>>  	if (!x86_match_cpu(snc_cpu_ids))
> >>>  		return 1;
> >>
> >> I understand and welcome this change as motivated by robustness. Apart
> >> from that, with this being a model specific feature for this particular
> >> group of systems, it it not clear to me in which scenarios this could
> >> run on a system where a present CPU does not have access to L3 cache.
> > 
> > Agreed that on these systems there should always be an L3 cache. Should
> > I drop the check for "-1"?
> 
> Please do keep it. I welcome the additional robustness. The static checker I
> tried did not complain about this but I expect that it is something that
> could trigger checks.
> 
> > 
> >>>  
> >>> -	node_caches = bitmap_zalloc(nr_node_ids, GFP_KERNEL);
> >>> +	node_caches = bitmap_zalloc(num_online_cpus(), GFP_KERNEL);
> >>
> >> Please do take care to take new bitmap size into account in all
> >> places. From what I can tell there is a later bitmap_weight() call that
> >> still uses nr_node_ids as size.
> > 
> > Oops. I was also using num_online_cpus() before cpus_read_lock(), so
> > things could theoretically change before the bitmap_weight() call.
> > I switched to using num_present_cpus() in both places.
> 
> Thanks for catching this. I am not sure if num_present_cpus() is the right
> choice. I found its comment to say "If HOTPLUG is enabled, then cpu_present_mask
> varies dynamically ...". num_possible_cpus() seems more appropriate when looking

I can size the bitmask based on num_possible_cpus().

> for something that does not change while not holding the hotplug lock. Reading its
> description more closely also makes me wonder if the later
> 	num_online_cpus() != num_present_cpus()
> should also maybe be 
> 	num_online_cpus() != num_possible_cpus() ?
> It seems to more closely match the intention.

This seems problematic. On a system that does support physical CPU
hotplug num_possible_cpus() may be some very large number. Reserving
space for CPUs that can be added later. None of those CPUs can be online
(obviously!). So this test would fail on such a system.

> >>>  	if (!node_caches)
> >>>  		return 1;
> >>>  
> >>> @@ -1072,10 +1073,13 @@ static __init int snc_get_config(void)
> >>>  
> >>>  	for_each_node(node) {
> >>>  		cpu = cpumask_first(cpumask_of_node(node));
> >>> -		if (cpu < nr_cpu_ids)
> >>> -			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
> >>> -		else
> >>> +		if (cpu < nr_cpu_ids) {
> >>> +			cache_id = get_cpu_cacheinfo_id(cpu, 3);
> >>> +			if (cache_id != -1)
> >>> +				set_bit(cache_id, node_caches);
> >>> +		} else {
> >>>  			mem_only_nodes++;
> >>> +		}
> >>>  	}
> >>>  	cpus_read_unlock();
> >>>  
> >>
> >> Could this code be made even more robust by checking the computed
> >> snc_nodes_per_l3_cache against the limited actually possible values?
> >> Forcing it to 1 if something went wrong?
> > 
> > Added a couple of extra sanity checks. See updated incremental patch
> > below.
> 
> Thank you very much. The additional checks look good to me.
> 
> Reinette

Thanks for looking at this. I'm applying changes to my local tree. I'll
give folks a little more time to find additonal issues in v12 and post
v13 next week.

-Tony
