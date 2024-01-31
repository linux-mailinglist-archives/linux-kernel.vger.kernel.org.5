Return-Path: <linux-kernel+bounces-45847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA31843703
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FC51C262AA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08F15102E;
	Wed, 31 Jan 2024 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtZ0BqXl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAFE5024D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684055; cv=none; b=LXB8H7OJEyBbHR8YqY63bnG0TRJi0+51lRzDt4MLgldtyKd1zdOv1EGjFHYmT70f+H9C4KzCuy6mgSA1eP8/RDsVXhkEjfivoU17NRlCk7knGLRBY6uwfiaH1oQyGGVbsxQww6lMhNDFVqi8dX2YSawnivheHs3bMj31pQiOrqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684055; c=relaxed/simple;
	bh=/F/ertmwsCGvy8CX6KW93prCcPXDnU1V09z8hHjJkU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fCsXFw/0YoKp2z9NWcDqzwkL1FmgTPqssTjv8PnSiqPy9t9SjZ6AO68z0NUrkWb0bxEddXbwVozil+5hvYXDXbJQiscnF6u8+TjYprG7p4xJwe9fux7cpsW3qaeA06lS61A41jYnWoArixp9BaBrNVl35iB7qk6ng03ZlDstbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtZ0BqXl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706684054; x=1738220054;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/F/ertmwsCGvy8CX6KW93prCcPXDnU1V09z8hHjJkU0=;
  b=KtZ0BqXl/AGHr7lyoxDr/a+LzLccUQvDwgVMbZFfmjqbyo2/fvvLBfgZ
   9iypPGAdxgIfnita7UnkhsX/mQAitaZqkY5YU1Fv/lklCqp+TxLeOqIaD
   AQ1pjKZFXKta72CxwxCgaBOUNVFRND9QJJe2Gp0l82mZv8JnGLcffsKAW
   OJKVP7f8RhW3qupeDBQLw346sI1J2aK9q2jEiR85P1h2gWaaX49JQOPG3
   ti6T0jv2Bjl1auSuW3yGTmzZQDkLQ9SJTdfuUSwaBFkU7613XvjY5Wos+
   YY1I9y22lYLENNkwiRAnuWWZy2MtcrvyurWg6FAf6lRDjmGWBE6JcYLcO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3353179"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3353179"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:54:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="30391993"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:54:11 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "rafael@kernel.org" <rafael@kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys
 infterface
In-Reply-To: <TYWPR01MB100828CBEE3E032C191C6D08E907C2@TYWPR01MB10082.jpnprd01.prod.outlook.com>
	(Yasunori Gotou's message of "Wed, 31 Jan 2024 06:23:12 +0000")
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
	<20231102025648.1285477-2-lizhijian@fujitsu.com>
	<878r7g3ktj.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<d1d5add8-8f4a-4578-8bf0-2cbe79b09989@fujitsu.com>
	<87fryegv9c.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<TYWPR01MB100828CBEE3E032C191C6D08E907C2@TYWPR01MB10082.jpnprd01.prod.outlook.com>
Date: Wed, 31 Jan 2024 14:52:15 +0800
Message-ID: <8734uegfkw.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com> writes:

> Hello,
>
>> Li Zhijian <lizhijian@fujitsu.com> writes:
>> 
>> > Hi Ying
>> >
>> > I need to pick up this thread/patch again.
>> >
>> >> We have /sys/devices/virtual/memory_tiering/memory_tier*/nodelist
>> >> already.  A node in a higher tier can demote to any node in the lower
>> >> tiers.  What's more need to be displayed in nodeX/demotion_nodes?
>> >>
>> >
>> > Yes, it's believed that
>> > /sys/devices/virtual/memory_tiering/memory_tierN/nodelist
>> > are intended to show nodes in memory_tierN. But IMHO, it's not enough,
>> > especially for the preferred demotion node(s).
>> >
>> > Currently, when a demotion occurs, it will prioritize selecting a node
>> > from the preferred nodes as the destination node for the demotion. If
>> > the preferred nodes does not meet the requirements, it will try from
>> > all the lower memory tier nodes until it finds a suitable demotion
>> > destination node or ultimately fails.
>> >
>> > However, currently it only lists the nodes of each tier. If the
>> > administrators want to know all the possible demotion destinations for
>> > a given node, they need to calculate it themselves:
>> > Step 1, find the memory tier where the given node is located Step 2,
>> > list all nodes under all its lower tiers
>> >
>> > It will be even more difficult to know the preferred nodes which
>> > depend on more factors, distance etc. For the following example, we
>> > may have 6 nodes splitting into three memory tiers.
>> >
>> > For emulated hmat numa topology example:
>> >> $ numactl -H
>> >> available: 6 nodes (0-5)
>> >> node 0 cpus: 0
>> >> node 0 size: 1974 MB
>> >> node 0 free: 1767 MB
>> >> node 1 cpus: 1
>> >> node 1 size: 1694 MB
>> >> node 1 free: 1454 MB
>> >> node 2 cpus:
>> >> node 2 size: 896 MB
>> >> node 2 free: 896 MB
>> >> node 3 cpus:
>> >> node 3 size: 896 MB
>> >> node 3 free: 896 MB
>> >> node 4 cpus:
>> >> node 4 size: 896 MB
>> >> node 4 free: 896 MB
>> >> node 5 cpus:
>> >> node 5 size: 896 MB
>> >> node 5 free: 896 MB
>> >> node distances:
>> >> node   0   1   2   3   4   5
>> >> 0:  10  31  21  41  21  41
>> >> 1:  31  10  41  21  41  21
>> >> 2:  21  41  10  51  21  51
>> >> 3:  31  21  51  10  51  21
>> >> 4:  21  41  21  51  10  51
>> >> 5:  31  21  51  21  51  10
>> >> $ cat memory_tier4/nodelist
>> >> 0-1
>> >> $ cat memory_tier12/nodelist
>> >> 2,5
>> >> $ cat memory_tier54/nodelist
>> >> 3-4
>> >
>> > For above topology, memory-tier will build the demotion path for each
>> > node like this:
>> > node[0].preferred = 2
>> > node[0].demotion_targets = 2-5
>> > node[1].preferred = 5
>> > node[1].demotion_targets = 2-5
>> > node[2].preferred = 4
>> > node[2].demotion_targets = 3-4
>> > node[3].preferred = <empty>
>> > node[3].demotion_targets = <empty>
>> > node[4].preferred = <empty>
>> > node[4].demotion_targets = <empty>
>> > node[5].preferred = 3
>> > node[5].demotion_targets = 3-4
>> >
>> > But this demotion path is not explicitly known to administrator. And
>> > with the feedback from our customers, they also think it is helpful to
>> > know demotion path built by kernel to understand the demotion
>> > behaviors.
>> >
>> > So i think we should have 2 new interfaces for each node:
>> >
>> > /sys/devices/system/node/nodeN/demotion_allowed_nodes
>> > /sys/devices/system/node/nodeN/demotion_preferred_nodes
>> >
>> > I value your opinion, and I'd like to know what you think about...
>> 
>> Per my understanding, we will not expose everything inside kernel to user
>> space.  For page placement in a tiered memory system, demotion is just a part
>> of the story.  For example, if the DRAM of a system becomes full, new page
>> allocation will fall back to the CXL memory.  Have we exposed the default page
>> allocation fallback order to user space?
>
> In extreme terms, users want to analyze all the memory behaviors of memory management
> while executing their workload, and want to trace ALL of them if possible.
> Of course, it is impossible due to the heavy load, then users want to have other ways as
> a compromise. Our request, the demotion target information, is just one of them.
>
> In my impression, users worry about the impact of the CXL memory device on their workload, 
> and want to have a way to understand the impact.
> If they know there is no information to remove their anxious, they may avoid to buy CXL memory.
>
> In addition, our support team also needs to have clues to solve users' performance problems. 
> Even if new page allocation will fall back to the CXL memory, we need to explain why it would
> happen as accountability.

I guess

/proc/<PID>/numa_maps
/sys/fs/cgroup/<CGNAME>/memory.numa_stat

may help to understand system behavior.

--
Best Regards,
Huang, Ying

>> 
>> All in all, in my opinion, we only expose as little as possible to user space
>> because we need to maintain the ABI for ever.
>
> I can understand there is a compatibility problem by our propose, and kernel may
> change its logic in future. This is a tug-of-war situation between kernel developers
> and users or support engineers. I suppose It often occurs in many place...
>
> Hmm... I hope there is a new idea to solve this situation even if our proposal is rejected..
> Anyone?
>
> Thanks,
> ----
> Yasunori Goto
>
>> 
>> --
>> Best Regards,
>> Huang, Ying
>> 
>> >
>> > On 02/11/2023 11:17, Huang, Ying wrote:
>> >> Li Zhijian <lizhijian@fujitsu.com> writes:
>> >>
>> >>> It shows the demotion target nodes of a node. Export this
>> >>> information to user directly.
>> >>>
>> >>> Below is an example where node0 node1 are DRAM, node3 is a PMEM
>> node.
>> >>> - Before PMEM is online, no demotion_nodes for node0 and node1.
>> >>> $ cat /sys/devices/system/node/node0/demotion_nodes
>> >>>   <show nothing>
>> >>> - After node3 is online as kmem
>> >>> $ daxctl reconfigure-device --mode=system-ram --no-online dax0.0 &&
>> >>> daxctl online-memory dax0.0 [
>> >>>    {
>> >>>      "chardev":"dax0.0",
>> >>>      "size":1054867456,
>> >>>      "target_node":3,
>> >>>      "align":2097152,
>> >>>      "mode":"system-ram",
>> >>>      "online_memblocks":0,
>> >>>      "total_memblocks":7
>> >>>    }
>> >>> ]
>> >>> $ cat /sys/devices/system/node/node0/demotion_nodes
>> >>> 3
>> >>> $ cat /sys/devices/system/node/node1/demotion_nodes
>> >>> 3
>> >>> $ cat /sys/devices/system/node/node3/demotion_nodes
>> >>>   <show nothing>
>> >> We have /sys/devices/virtual/memory_tiering/memory_tier*/nodelist
>> >> already.  A node in a higher tier can demote to any node in the lower
>> >> tiers.  What's more need to be displayed in nodeX/demotion_nodes?
>> >> --
>> >> Best Regards,
>> >> Huang, Ying
>> >>
>> >>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> >>> ---
>> >>>   drivers/base/node.c          | 13 +++++++++++++
>> >>>   include/linux/memory-tiers.h |  6 ++++++
>> >>>   mm/memory-tiers.c            |  8 ++++++++
>> >>>   3 files changed, 27 insertions(+)
>> >>>
>> >>> diff --git a/drivers/base/node.c b/drivers/base/node.c index
>> >>> 493d533f8375..27e8502548a7 100644
>> >>> --- a/drivers/base/node.c
>> >>> +++ b/drivers/base/node.c
>> >>> @@ -7,6 +7,7 @@
>> >>>   #include <linux/init.h>
>> >>>   #include <linux/mm.h>
>> >>>   #include <linux/memory.h>
>> >>> +#include <linux/memory-tiers.h>
>> >>>   #include <linux/vmstat.h>
>> >>>   #include <linux/notifier.h>
>> >>>   #include <linux/node.h>
>> >>> @@ -569,11 +570,23 @@ static ssize_t node_read_distance(struct device
>> *dev,
>> >>>   }
>> >>>   static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>> >>>   +static ssize_t demotion_nodes_show(struct device *dev,
>> >>> +			     struct device_attribute *attr, char *buf) {
>> >>> +	int ret;
>> >>> +	nodemask_t nmask = next_demotion_nodes(dev->id);
>> >>> +
>> >>> +	ret = sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&nmask));
>> >>> +	return ret;
>> >>> +}
>> >>> +static DEVICE_ATTR_RO(demotion_nodes);
>> >>> +
>> >>>   static struct attribute *node_dev_attrs[] = {
>> >>>   	&dev_attr_meminfo.attr,
>> >>>   	&dev_attr_numastat.attr,
>> >>>   	&dev_attr_distance.attr,
>> >>>   	&dev_attr_vmstat.attr,
>> >>> +	&dev_attr_demotion_nodes.attr,
>> >>>   	NULL
>> >>>   };
>> >>>   diff --git a/include/linux/memory-tiers.h
>> >>> b/include/linux/memory-tiers.h index 437441cdf78f..8eb04923f965
>> >>> 100644
>> >>> --- a/include/linux/memory-tiers.h
>> >>> +++ b/include/linux/memory-tiers.h
>> >>> @@ -38,6 +38,7 @@ void init_node_memory_type(int node, struct
>> memory_dev_type *default_type);
>> >>>   void clear_node_memory_type(int node, struct memory_dev_type
>> *memtype);
>> >>>   #ifdef CONFIG_MIGRATION
>> >>>   int next_demotion_node(int node);
>> >>> +nodemask_t next_demotion_nodes(int node);
>> >>>   void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t
>> *targets);
>> >>>   bool node_is_toptier(int node);
>> >>>   #else
>> >>> @@ -46,6 +47,11 @@ static inline int next_demotion_node(int node)
>> >>>   	return NUMA_NO_NODE;
>> >>>   }
>> >>>   +static inline next_demotion_nodes next_demotion_nodes(int node)
>> >>> +{
>> >>> +	return NODE_MASK_NONE;
>> >>> +}
>> >>> +
>> >>>   static inline void node_get_allowed_targets(pg_data_t *pgdat,
>> nodemask_t *targets)
>> >>>   {
>> >>>   	*targets = NODE_MASK_NONE;
>> >>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c index
>> >>> 37a4f59d9585..90047f37d98a 100644
>> >>> --- a/mm/memory-tiers.c
>> >>> +++ b/mm/memory-tiers.c
>> >>> @@ -282,6 +282,14 @@ void node_get_allowed_targets(pg_data_t *pgdat,
>> nodemask_t *targets)
>> >>>   	rcu_read_unlock();
>> >>>   }
>> >>>   +nodemask_t next_demotion_nodes(int node)
>> >>> +{
>> >>> +	if (!node_demotion)
>> >>> +		return NODE_MASK_NONE;
>> >>> +
>> >>> +	return node_demotion[node].preferred; }
>> >>> +
>> >>>   /**
>> >>>    * next_demotion_node() - Get the next node in the demotion path
>> >>>    * @node: The starting node to lookup the next node

