Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ABF7A9E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjIUUDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjIUUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:02:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E295493E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316636; x=1726852636;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ftW/+CKi2mW4lDelhCa9qIoImXCyTfRFXibv41RPhmk=;
  b=jV4RE860v8fVBNx/Fn64HAbCo2NXv12LNYxvc+CwCWOAzecMVQDkzP/H
   Bg6I0Kx4HS8TmC69mBdJnBgS0USncqt6EQZkTMD82AYaiRi+XFeJHFJqp
   HRnrtgaRt11YI1GEWX+be9omdmT2b/2s9LE2rNcjYyWsGVVzFk/AoSVk+
   ssXHjPPbfXExVTtpC6ekDjN1yKIMGiSZv9+5QMGpGNi8k2av38Bqo2E8E
   IOWMgN7Xl5GRW+K0VADIymkH5nSkzEXGEBt2uUm/GUwPCi95twg1Wt6//
   uCPzeGQ2pvrGLzGSqB9MTotKLJ7BHfFM7C3/ntqiQeikeKDdFfAye0BC7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="444641997"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="444641997"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 06:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="812646899"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="812646899"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 06:34:45 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 00/10] mm: PCP high auto-tuning
References: <20230920061856.257597-1-ying.huang@intel.com>
        <20230920094118.8b8f739125c6aede17c627e0@linux-foundation.org>
Date:   Thu, 21 Sep 2023 21:32:35 +0800
In-Reply-To: <20230920094118.8b8f739125c6aede17c627e0@linux-foundation.org>
        (Andrew Morton's message of "Wed, 20 Sep 2023 09:41:18 -0700")
Message-ID: <87leczwt1o.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 20 Sep 2023 14:18:46 +0800 Huang Ying <ying.huang@intel.com> wrote:
>
>> The page allocation performance requirements of different workloads
>> are often different.  So, we need to tune the PCP (Per-CPU Pageset)
>> high on each CPU automatically to optimize the page allocation
>> performance.
>
> Some of the performance changes here are downright scary.
>
> I've never been very sure that percpu pages was very beneficial (and
> hey, I invented the thing back in the Mesozoic era).  But these numbers
> make me think it's very important and we should have been paying more
> attention.
>
>> The list of patches in series is as follows,
>> 
>>  1 mm, pcp: avoid to drain PCP when process exit
>>  2 cacheinfo: calculate per-CPU data cache size
>>  3 mm, pcp: reduce lock contention for draining high-order pages
>>  4 mm: restrict the pcp batch scale factor to avoid too long latency
>>  5 mm, page_alloc: scale the number of pages that are batch allocated
>>  6 mm: add framework for PCP high auto-tuning
>>  7 mm: tune PCP high automatically
>>  8 mm, pcp: decrease PCP high if free pages < high watermark
>>  9 mm, pcp: avoid to reduce PCP high unnecessarily
>> 10 mm, pcp: reduce detecting time of consecutive high order page freeing
>> 
>> Patch 1/2/3 optimize the PCP draining for consecutive high-order pages
>> freeing.
>> 
>> Patch 4/5 optimize batch freeing and allocating.
>> 
>> Patch 6/7/8/9 implement and optimize a PCP high auto-tuning method.
>> 
>> Patch 10 optimize the PCP draining for consecutive high order page
>> freeing based on PCP high auto-tuning.
>> 
>> The test results for patches with performance impact are as follows,
>> 
>> kbuild
>> ======
>> 
>> On a 2-socket Intel server with 224 logical CPU, we tested kbuild on
>> one socket with `make -j 112`.
>> 
>> 	build time	zone lock%	free_high	alloc_zone
>> 	----------	----------	---------	----------
>> base	     100.0	      43.6          100.0            100.0
>> patch1	      96.6	      40.3	     49.2	      95.2
>> patch3	      96.4	      40.5	     11.3	      95.1
>> patch5	      96.1	      37.9	     13.3	      96.8
>> patch7	      86.4	       9.8	      6.2	      22.0
>> patch9	      85.9	       9.4	      4.8	      16.3
>> patch10	      87.7	      12.6	     29.0	      32.3
>
> You're seriously saying that kbuild got 12% faster?
>
> I see that [07/10] (autotuning) alone sped up kbuild by 10%?

Thank you very much for questioning!

I double-checked the my test results and configuration and found that I
used an uncommon configuration.  So the description of the test should
have been,

On a 2-socket Intel server with 224 logical CPU, we tested kbuild with
`numactl -m 1 -- make -j 112`.

This will make processes running on socket 0 to use the normal zone of
socket 1.  The remote accessing to zone->lock cause heavy lock
contention.

I apologize for any confusing caused by the above test results.

If we test kbuild with `make -j 224` on the machine, the test results
becomes,

	build time	     lock%	free_high	alloc_zone
	----------	----------	---------	----------
base	     100.0	      16.8          100.0            100.0
patch5	      99.2	      13.9	      9.5	      97.0
patch7	      98.5	       5.4	      4.8	      19.2

Although lock contention cycles%, draining PCP for high order freeing,
and allocating from zone reduces greatly, the build time almost doesn't
change.

We also tested kbuild in the following way, created 8 cgroup, and run
`make -j 28` in each cgroup.  That is, the total parallel is same, but
LRU lock contention can be eliminated via cgroup.  And, the
single-process link stage take less proportion to the parallel compiling
stage.  This isn't common for personal usage.  But it can be used by
something like 0Day kbuild service.  The test result is as follows,

	build time	     lock%	free_high	alloc_zone
	----------	----------	---------	----------
base	     100.0	      14.2          100.0            100.0
patch5	      98.5	       8.5	      8.1	      97.1
patch7	      95.0	       0.7	      3.0	      19.0

The lock contention cycles% reduces to nearly 0, because LRU lock
contention is eliminated too.  The build time reduction becomes visible
too.  We will continue to do a full test with this configuration.

> Other thoughts:
>
> - What if any facilities are provided to permit users/developers to
>   monitor the operation of the autotuning algorithm?

/proc/zoneinfo can be used to observe PCP high and count for each CPU.

> - I'm not seeing any Documentation/ updates.  Surely there are things
>   we can tell users?

I will think about that.

> - This:
>
>   : It's possible that PCP high auto-tuning doesn't work well for some
>   : workloads.  So, when PCP high is tuned by hand via the sysctl knob,
>   : the auto-tuning will be disabled.  The PCP high set by hand will be
>   : used instead.
>
>   Is it a bit hacky to disable autotuning when the user alters
>   pcp-high?  Would it be cleaner to have a separate on/off knob for
>   autotuning?

This was suggested by Mel Gormon,

https://lore.kernel.org/linux-mm/20230714140710.5xbesq6xguhcbyvi@techsingularity.net/

"
I'm not opposed to having an adaptive pcp->high in concept. I think it would
be best to disable adaptive tuning if percpu_pagelist_high_fraction is set
though. I expect that users of that tunable are rare and that if it *is*
used that there is a very good reason for it.
"

Do you think that this is reasonable?

>   And how is the user to determine that "PCP high auto-tuning doesn't work
>   well" for their workload?

One way is to check the perf profiling results.  If there is heavy zone
lock contention, the PCP high auto-tuning doesn't work well enough to
eliminate the zone lock contention.  Users may try to tune PCP high by
hand.

--
Best Regards,
Huang, Ying
