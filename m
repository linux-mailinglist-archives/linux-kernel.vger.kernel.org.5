Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39167E00F2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346258AbjKCHr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjKCHr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:47:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C69283;
        Fri,  3 Nov 2023 00:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698997640; x=1730533640;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rezhK3cP/BaT5BMnIYABwg8Q2dxJJQOxJ5jTfjavXtc=;
  b=OL0p8vjiy3mxdGqiL+T1JYH3K7/re15pbHqasa9ZMaEx/J0fnO2xl/tw
   kQWRVUAhXEMRNZ9UaS6FvM4Gh4HV/eyB0g5zQfSA7kti9QEfEUC5ZYMC0
   gbi6WezKopXsypFk2VWCE/mltkbIktJtwUJe9eQj/uvwfnZhBIGzA0PfJ
   RoswxILS8EbFMgAB02fYcKgYLYrRU63z37O51jbKPl5t87O5p7/dAxLZV
   tuCG+zSQmLKPrCmhTV62RlYrJqFgKsTUCxElMh5FLd39NaLJBlrvYI1aC
   E1EwFjesdvK94Uk1IPtUpTT/UmYrB3S08acV3MCuRT5GiuRcCXr5/ErJy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="10430963"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="10430963"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 00:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="761535270"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="761535270"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 00:47:15 -0700
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
In-Reply-To: <ZUMVI4YG7mB54u0D@memverge.com> (Gregory Price's message of "Wed,
        1 Nov 2023 23:18:59 -0400")
References: <20231031003810.4532-1-gregory.price@memverge.com>
        <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
        <20231031152142.GA3029315@cmpxchg.org>
        <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
        <ZUCCGJgrqqk87aGN@memverge.com>
        <pmxrljwp4ayl3fcu7rxm6prbumgb5l3lwb75lqfipmxxxwnqfo@nb5qjcxw22gp>
        <ZUKDz5NpMsoyzWtZ@memverge.com>
        <a4f5das6ckw5lwj3qv2eaygx4nypb762b6mdnxivrjjndqlhjk@zpjao2ewfdoc>
        <ZUMVI4YG7mB54u0D@memverge.com>
Date:   Fri, 03 Nov 2023 15:45:13 +0800
Message-ID: <87fs1nz3ee.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Price <gregory.price@memverge.com> writes:

> On Thu, Nov 02, 2023 at 10:47:33AM +0100, Michal Hocko wrote:
>> On Wed 01-11-23 12:58:55, Gregory Price wrote:
>> > Basically consider: `numactl --interleave=all ...`
>> > 
>> > If `--weights=...`: when a node hotplug event occurs, there is no
>> > recourse for adding a weight for the new node (it will default to 1).
>> 
>> Correct and this is what I was asking about in an earlier email. How
>> much do we really need to consider this setup. Is this something nice to
>> have or does the nature of the technology requires to be fully dynamic
>> and expect new nodes coming up at any moment?
>>  
>
> Dynamic Capacity is expected to cause a numa node to change size (in
> number of memory blocks) rather than cause numa nodes to come and go, so
> maybe handling the full node hotplug is a bit of an overreach.

Will node max bandwidth change with the number of memory blocks?

> Good call, I'll stop considering this problem for now.
>
>> > If the node is removed from the system, I believe (need to validate
>> > this, but IIRC) the node will be removed from any registered cpusets.
>> > As a result, that falls down to mempolicy, and the node is removed.
>> 
>> I do not think we do anything like that. Userspace might decide to
>> change the numa mask when a node is offlined but I do not think we do
>> anything like that automagically.
>>
>
> mpol_rebind_policy called by update_tasks_nodemask
> https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L319
> https://elixir.bootlin.com/linux/latest/source/kernel/cgroup/cpuset.c#L2016
>
> falls down from cpuset_hotplug_workfn:
> https://elixir.bootlin.com/linux/latest/source/kernel/cgroup/cpuset.c#L3771
>
> /*
>  * Keep top_cpuset.mems_allowed tracking node_states[N_MEMORY].
>  * Call this routine anytime after node_states[N_MEMORY] changes.
>  * See cpuset_update_active_cpus() for CPU hotplug handling.
>  */
> static int cpuset_track_online_nodes(struct notifier_block *self,
> 				unsigned long action, void *arg)
> {
> 	schedule_work(&cpuset_hotplug_work);
> 	return NOTIFY_OK;
> }
>
> void __init cpuset_init_smp(void)
> {
> ...
> 	hotplug_memory_notifier(cpuset_track_online_nodes, CPUSET_CALLBACK_PRI);
> }
>
>
> Causes 1 of 3 situations:
> MPOL_F_STATIC_NODES:   overwrite with (old & new)
> MPOL_F_RELATIVE_NODES: overwrite with a "relative" nodemask (fold+onto?)
> Default:               either does a remap or replaces old with new.
>
> My assumption based on this is that a hot-unplugged node would completely
> be removed.  Doesn't look like hot-add is handled at all, so I can just
> drop that entirely for now (except add default weight of 1 incase it is
> ever added in the future).
>
> I've been pushing agianst the weights being in memory-tiers.c for this
> reason, as a weight set per-tier is meaningless if a node disappears.
>
> Example: Tier has 2 nodes with some weight N split between them, such
> that interleave gives each node N/2 pages.  If 1 node is removed, the
> remaining node gets N pages, which is twice the allocation. Presumably
> a node is an abstraction of 1 or more devices, therefore if the node is
> removed, the weight should change.

The per-tier weight can be defined as interleave weight of each node of
the tier.  Tier just groups NUMA nodes with similar performance.  The
performance (including bandwidth) is still per-node in the context of
tier.

If we have multiple nodes in one tier, this makes weight definition
easier.

> You could handle hotplug in tiers, but if a node being hotplugged forcibly
> removes the node from cpusets and mempolicy nodemasks, then it's
> irrelevant since the node can never get selected for allocation anyway.
>
> It's looking more like cgroups is the right place to put this.

Have a cgroup/task level interface doesn't prevent us to have a system
level interface to provide default for cgroups/tasks.  Where performance
information (e.g., from HMAT) can help define a reasonable default
automatically.

>> 
>> Moving the global policy to cgroups would make the main cocern of
>> different workloads looking for different policy less problamatic.
>> I didn't have much time to think that through but the main question is
>> how to sanely define hierarchical properties of those weights? This is
>> more of a resource distribution than enforcement so maybe a simple
>> inherit or overwrite (if you have a more specific needs) semantic makes
>> sense and it is sufficient.
>>
>
> As a user I would assume it would operate much the same way as other
> nested cgroups, which is inherit by default (with subsets) or an
> explicit overwrite that can't exceed the higher level settings.
>
> Weights could arguably allow different settings than capacity controls,
> but that could be an extension.
>
>> This is not as much about the code as it is about the proper interface
>> because that will get cast in stone once introduced. It would be really
>> bad to realize that we have a global policy that doesn't fit well and
>> have hard time to work it around without breaking anybody.
>
> o7 I concur now.  I'll take some time to rework this into a
> cgroups+mempolicy proposal based on my earlier RFCs.

--
Best Regards,
Huang, Ying
