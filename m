Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357517EBCE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 06:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjKOF7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 00:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOF7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 00:59:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E5E8E;
        Tue, 14 Nov 2023 21:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700027939; x=1731563939;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=NQ+2z4Rav2ZbtZH8OQfdAniDcS40hfa5W0SOiCZegZ4=;
  b=ToJD1HbZ/UdqNEC/Ka2FUr+u241GhxeyQB0/cnMp57Lv1OypsiyOi+K7
   73ySd4EFvpH/DxYOoMEndJa575ltwodKP4jQpLfK0HeOx6Hoz6POmMwx3
   YoNOTJ+i/PCAKnOCXENh/XrwNugLIeVut80Qfi1IqsNomSv40Tohk2iup
   ymA9RsWuKqdSBPOrkTdDRzHS+aH9aGXwurzZ9XrpnLgiJPKFDxi12cefe
   5D009BqSGrdtWWo0Vm8uE82Xoxz0dQK86wGX6+JN7nlTHA77ps6sEDWza
   BwObLscnfvPiHa2PfN07ji3X7oCOrI7GElzNUrvxHu9rsnFefbeFlfDSH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="381212929"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="381212929"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 21:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1012165444"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="1012165444"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 21:58:54 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, John Groves <john@jagalactic.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "jgroves@micron.com" <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
In-Reply-To: <ZVOzMEtDYB4l8qFy@memverge.com> (Gregory Price's message of "Tue,
        14 Nov 2023 12:49:36 -0500")
References: <20231109002517.106829-1-gregory.price@memverge.com>
        <klhcqksrg7uvdrf6hoi5tegifycjltz2kx2d62hapmw3ulr7oa@woibsnrpgox4>
        <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
        <ZU6pR46kiuzPricM@slm.duckdns.org> <ZU6uxSrj75EiXise@memverge.com>
        <ZU7vjsSkGbRLza-K@slm.duckdns.org> <ZU74L9oxWOoTTfpM@memverge.com>
        <ZVNBMW8iJIGDyp0y@tiehlicka> <ZVOXWx8XNJJNC23A@memverge.com>
        <ZVOn2T_Qg_NTKlB2@tiehlicka> <ZVOzMEtDYB4l8qFy@memverge.com>
Date:   Wed, 15 Nov 2023 13:56:53 +0800
Message-ID: <87o7fveeze.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Nov 14, 2023 at 06:01:13PM +0100, Michal Hocko wrote:
>> On Tue 14-11-23 10:50:51, Gregory Price wrote:
>> > On Tue, Nov 14, 2023 at 10:43:13AM +0100, Michal Hocko wrote:
>> [...]
>> > > That being said, I still believe that a cgroup based interface is a much
>> > > better choice over a global one. Cpusets seem to be a good fit as the
>> > > controller does control memory placement wrt NUMA interfaces.
>> > 
>> > I think cpusets is a non-starter due to the global spinlock required when
>> > reading informaiton from it:
>> > 
>> > https://elixir.bootlin.com/linux/latest/source/kernel/cgroup/cpuset.c#L391
>> 
>> Right, our current cpuset implementation indeed requires callback lock
>> from the page allocator. But that is an implementation detail. I do not
>> remember bug reports about the lock being a bottle neck though. If
>> anything cpusets lock optimizations would be win also for users who do
>> not want to use weighted interleave interface.
>
> Definitely agree, but that's a rather large increase of scope :[
>
> We could consider a push-model similar to how cpuset nodemasks are
> pushed down to mempolicies, rather than a pull-model of having
> mempolicy read directly from cpusets, at least until cpusets lock
> optimization is undertaken.
>
> This pattern looks like a wart to me, which is why I avoided it, but the
> locking implications on the pull-model make me sad.
>
> Would like to point out that Tejun pushed back on implementing weights
> in cgroups (regardless of subcomponent), so I think we need to come
> to a consensus on where this data should live in a "more global"
> context (cpusets, memcg, nodes, etc) before I go mucking around
> further.
>
> So far we have:
> * mempolicy: updating weights is a very complicated undertaking,
>              and no (good) way to do this from outside the task.
> 	     would be better to have a coarser grained control.
>
>              New syscall is likely needed to add/set weights in the
> 	     per-task mempolicy, or bite the bullet on set_mempolicy2
> 	     and make the syscall extensible for the future.
>
> * memtiers: tier=node when devices are already interleaved or when all
>             devices are different, so why add yet another layer of
> 	    complexity if other constructs already exist.  Additionally,
> 	    you lose task-placement relative weighting (or it becomes
> 	    very complex to implement.

Because we usually have multiple nodes in one mem-tier, I still think
mem-tier-based interface is simpler than node-based.  But, it seems more
complex to introduce mem-tier into mempolicy.  Especially if we have
per-task weights.  So, I am fine to go with node-based interface.

> * cgroups: "this doesn't involve dynamic resource accounting /
>             enforcement at all" and "these aren't resource
> 	    allocations, it's unclear what the hierarchical
> 	    relationship mean".
>
> * node: too global, explore smaller scope first then expand.

Why is it too global?  I understand that it doesn't cover all possible
use cases (although I don't know whether these use cases are practical
or not).  But it can provide a reasonable default per-node weight based
on available node performance information (such as, HMAT, CDAT, etc.).
And, quite some workloads can just use it.  I think this is an useful
feature.

> For now I think there is consensus that mempolicy should have weights
> per-task regardless of how the more-global mechanism is defined, so i'll
> go ahead and put up another RFC for some options on that in the next
> week or so.
>
> The limitations on the first pass will be that only the task is capable
> of re-weighting should cpusets.mems or the nodemask change.

--
Best Regards,
Huang, Ying
