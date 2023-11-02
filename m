Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992DF7DEA81
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348220AbjKBCDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBCDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:03:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DF7E4;
        Wed,  1 Nov 2023 19:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698890606; x=1730426606;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=E2Mb/KvO9IGYgWWlhQaCJkJRm8aWbo+wV8m7MjhdsDI=;
  b=UiS6xHnIac2c2n6rfCWfdX7Lka/jsku+Ecj5/0a/ZRUKe3ABDucktzh8
   8aVyh9vf7e148tvrOWT1FJAgM/F2GpupzTPQ8+ijIdGtHzOU2Kx+TNkS6
   k1zNlmWlhIomCP3WPfSEtbPAp/bUnsoFHTiBCDOIIH5YaLb85ktdTPDAK
   VAAXfeSAWjchBM9vdNMEI/bOjXh4o0sVoZ4h9rZtB5mAxlMYdtKfqZNkK
   RYy5PX7tst7IyBadhzpn6+fQpqwGG2PltUopA61JqpcB7SSfNZbsQfUvA
   EAfeKlM3bAD3JleiTK7VDa3uChI9YyMm0DDhP9MNCZcVdtYR/WCcn5w2N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="392501357"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="392501357"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 19:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="826959147"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="826959147"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 19:03:21 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <weixugc@google.com>,
        <apopple@nvidia.com>, <tim.c.chen@intel.com>,
        <dave.hansen@intel.com>, <shy828301@gmail.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
In-Reply-To: <ZUCCGJgrqqk87aGN@memverge.com> (Gregory Price's message of "Tue,
        31 Oct 2023 00:27:04 -0400")
References: <20231031003810.4532-1-gregory.price@memverge.com>
        <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
        <20231031152142.GA3029315@cmpxchg.org>
        <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
        <ZUCCGJgrqqk87aGN@memverge.com>
Date:   Thu, 02 Nov 2023 10:01:20 +0800
Message-ID: <87cyws3ocv.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Oct 31, 2023 at 04:56:27PM +0100, Michal Hocko wrote:
>
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
>> 
>
> I had originally implemented it this way while experimenting with new
> mempolicies.
>
> https://lore.kernel.org/linux-cxl/20231003002156.740595-5-gregory.price@memverge.com/
>
> The downside of doing it in mempolicy is...
> 1) mempolicy is not sysfs friendly, and to make it sysfs friendly is a
>    non-trivial task.  It is very "current-task" centric.
>
> 2) Barring a change to mempolicy to be sysfs friendly, the options for
>    implementing weights in the mempolicy are either a) new flag and
>    setting every weight individually in many syscalls, or b) a new
>    syscall (set_mempolicy2), which is what I demonstrated in the RFC.
>
> 3) mempolicy is also subject to cgroup nodemasks, and as a result you
>    end up with a rats nest of interactions between mempolicy nodemasks
>    changing as a result of cgroup migrations, nodes potentially coming
>    and going (hotplug under CXL), and others I'm probably forgetting.
>
>    Basically:  If a node leaves the nodemask, should you retain the
>    weight, or should you reset it? If a new node comes into the node
>    mask... what weight should you set? I did not have answers to these
>    questions.
>
>
> It was recommended to explore placing it in tiers instead, so I took a
> crack at it here: 
>
> https://lore.kernel.org/linux-mm/20231009204259.875232-1-gregory.price@memverge.com/
>
> This had similar issue with the idea of hotplug nodes: if you give a
> tier a weight, and one or more of the nodes goes away/comes back... what
> should you do with the weight?  Split it up among the remaining nodes?
> Rebalance? Etc.

The weight of a tier can be defined as the weight of one node of the
tier instead of the weight of all nodes of the tier.  That is, for a
system as follows,

tier 0: node 0, node 1; weight=4
tier 1: node 2, node 3; weight=1

If you run workload with `numactl --weighted-interleave -n 0,2,3`, the
proportion will be: "4:0:1:1" on each node.

While for `numactl --weighted-interleave -n 0,2`, it will be: "4:0:1:0".

--
Best Regards,
Huang, Ying

> The result of this discussion lead us to simply say "What if we place
> the weights directly in the node".  And that lead us to this RFC.
>
>
> I am not against implementing it in mempolicy (as proof: my first RFC).
> I am simply searching for the acceptable way to implement it.
>
> One of the benefits of having it set as a global setting is that weights
> can be automatically generated from HMAT/HMEM information (ACPI tables)
> and programs already using MPOL_INTERLEAVE will have a direct benefit.
>
> I have been considering whether MPOL_WEIGHTED_INTERLEAVE should be added
> along side this patch so that MPOL_INTERLEAVE is left entirely alone.
>
> Happy to discuss more,
> ~Gregory
