Return-Path: <linux-kernel+bounces-44182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B19841E73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F0828C597
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FF059167;
	Tue, 30 Jan 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="s48meHNh"
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3D57864
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604802; cv=none; b=OqM2eNNPhjzQWMH+8bv5JADRncWxCnJm/fupQapaZt+6oP8jaylV2CnDPqHdSMxvNqqcm6Zjwzifg0qLXY0JEuvVh9sKWcLupbx2Yx/DS6v1BFLkmPE7OARBR5trRaTYJOeeGAfk/CcHHkPeKTVxQdZyoGIHKTTzq2RQmK4sQI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604802; c=relaxed/simple;
	bh=PYrUS3/+Y771ILCs3sTwuOn/MKRq3WY1J8faebJpjzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wv+1571DuaKxxP+YOkICq5aJcYQaGYuPLvjZB5GJgOJX+gPCDxTDAF3oa45XSjOems7434tLx/B/lW2ciAsoXNt862NRK3+gcTPWYo7AclvgtWY4wwEJTmOKFT12MXIrhU7ve/nTRyQsvUMWWR0EijcIu83YVqFYbG3zh89/DLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=s48meHNh; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706604800; x=1738140800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PYrUS3/+Y771ILCs3sTwuOn/MKRq3WY1J8faebJpjzI=;
  b=s48meHNhXWuUS4dTu4E2U4O0DyymAAgNGlzc/G2HAM4w1D2EKPIuqa6K
   K9UHYM/MhFQHwwJnqEREAhSfi9R72j9olXeSLMgEeW0CAjfHKL+po0Y5+
   0dKENGNCGAJxL78ltCnezzjfZGXU+2MgfKHseUaMxKz+/fyyQ7SwDH8My
   0djxiVglG+vPiGeZ9whSMT6BYKElAefB7pn5fnyzEOkiQDWCeLm+jJg3u
   gCscQRneZMaV89+WdJ+Q/vXGpG5CRSOmcSXLq2xFjHLMga76IL1q06G00
   MsbZHJ3zkkH5b9d5ciXfRTyegbEFOdEhxfKFpn8GXNurXYG8tIUJ49oB8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="149466937"
X-IronPort-AV: E=Sophos;i="6.05,707,1701097200"; 
   d="scan'208";a="149466937"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 17:53:16 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id EDD39D4800
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:53:12 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 284C3D5B3C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:53:12 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id B97BE20083888
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:53:11 +0900 (JST)
Received: from [10.167.226.45] (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E16711A006A;
	Tue, 30 Jan 2024 16:53:10 +0800 (CST)
Message-ID: <d1d5add8-8f4a-4578-8bf0-2cbe79b09989@fujitsu.com>
Date: Tue, 30 Jan 2024 16:53:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys
 infterface
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
 linux-mm@kvack.org, y-goto@fujitsu.com, linux-kernel@vger.kernel.org
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
 <20231102025648.1285477-2-lizhijian@fujitsu.com>
 <878r7g3ktj.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <878r7g3ktj.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28150.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28150.005
X-TMASE-Result: 10--28.496600-10.000000
X-TMASE-MatchedRID: UomY2wWC/KyPvrMjLFD6eJTQgFTHgkhZsBSA1tuZVSbtP4RQ+dxonQVM
	9kPsaYx4vtqCRGwbz0Fkjvv21BvS6hH6a53AZfDxR+GtoiXVeDHYUDvAr2Y/1zpnHdhQ1BMbe0K
	jC/8CK0pVZIN0tHD4H+AbxsLrrMxv0FQxfjRHOzjN+qWlu2ZxaLFcDzCo2ZtWCxzju735hWTAwJ
	WfIE4NHs1j70qfy418woo+ldrMeVCwHb9D99XpM6zGfgakLdjawdP+8YXeAclOaDdl7pggvRFEt
	97pQ+C8kf935YO20KhO9mtymj1NEjN1VvnSogA6A9lly13c/gEINLW/nC4hC/dt0QHl1BcpA3DT
	3VehETp72aKohPmGR81qGMpNtFmr+UviL1yO5g3NgrlT5Ajc7sMKxxeacM3vKxnRjlf7+WsYODB
	tbaa9ST+Ok6f9gUlFtdh2oL28A44v+0FNnM7lDR+0aBf65h9MWQ3R4k5PTnC4GyTmeN+AbKDpIN
	QWjbma6wtGsupCFkWaspefDToLzTcpdZ3fQiLdOX/V8P8ail1ZDL1gLmoa/ALDAYP4AXVR7nY51
	lwLq0+8QIu4z6HhEH7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Hi Ying


I need to pick up this thread/patch again.

> We have /sys/devices/virtual/memory_tiering/memory_tier*/nodelist
> already.  A node in a higher tier can demote to any node in the lower
> tiers.  What's more need to be displayed in nodeX/demotion_nodes?
> 

Yes, it's believed that /sys/devices/virtual/memory_tiering/memory_tierN/nodelist
are intended to show nodes in memory_tierN. But IMHO, it's not enough, especially
for the preferred demotion node(s).

Currently, when a demotion occurs, it will prioritize selecting a node
from the preferred nodes as the destination node for the demotion. If
the preferred nodes does not meet the requirements, it will try from all
the lower memory tier nodes until it finds a suitable demotion destination
node or ultimately fails.
                                                                                 
However, currently it only lists the nodes of each tier. If the
administrators want to know all the possible demotion destinations for a
given node, they need to calculate it themselves:
Step 1, find the memory tier where the given node is located
Step 2, list all nodes under all its lower tiers
                                                                                    
It will be even more difficult to know the preferred nodes which depend on
more factors, distance etc. For the following example, we may have 6 nodes
splitting into three memory tiers.
                                                                                 
For emulated hmat numa topology example:
> $ numactl -H                                                                  
> available: 6 nodes (0-5)                                                      
> node 0 cpus: 0                                                                
> node 0 size: 1974 MB                                                          
> node 0 free: 1767 MB                                                             
> node 1 cpus: 1                                                                
> node 1 size: 1694 MB                                                          
> node 1 free: 1454 MB                                                          
> node 2 cpus:                                                                  
> node 2 size: 896 MB                                                           
> node 2 free: 896 MB                                                           
> node 3 cpus:                                                                  
> node 3 size: 896 MB                                                           
> node 3 free: 896 MB                                                           
> node 4 cpus:                                                                  
> node 4 size: 896 MB                                                           
> node 4 free: 896 MB                                                           
> node 5 cpus:                                                                  
> node 5 size: 896 MB                                                           
> node 5 free: 896 MB                                                           
> node distances:                                                               
> node   0   1   2   3   4   5                                                  
>   0:  10  31  21  41  21  41                                                  
>   1:  31  10  41  21  41  21                                                  
>   2:  21  41  10  51  21  51                                                  
>   3:  31  21  51  10  51  21                                                  
>   4:  21  41  21  51  10  51                                                  
>   5:  31  21  51  21  51  10                                                  
>                                                                               
> $ cat memory_tier4/nodelist                                                   
> 0-1                                                                           
> $ cat memory_tier12/nodelist                                                  
> 2,5
> $ cat memory_tier54/nodelist                                                  
> 3-4                                                                           
                                                                                 
For above topology, memory-tier will build the demotion path for each node
like this:
node[0].preferred = 2
node[0].demotion_targets = 2-5
node[1].preferred = 5
node[1].demotion_targets = 2-5
node[2].preferred = 4
node[2].demotion_targets = 3-4
node[3].preferred = <empty>
node[3].demotion_targets = <empty>
node[4].preferred = <empty>
node[4].demotion_targets = <empty>
node[5].preferred = 3
node[5].demotion_targets = 3-4
                                                                          
But this demotion path is not explicitly known to administrator. And with the
feedback from our customers, they also think it is helpful to know demotion
path built by kernel to understand the demotion behaviors.

So i think we should have 2 new interfaces for each node:

/sys/devices/system/node/nodeN/demotion_allowed_nodes
/sys/devices/system/node/nodeN/demotion_preferred_nodes

I value your opinion, and I'd like to know what you think about...


Thanks
Zhijian


On 02/11/2023 11:17, Huang, Ying wrote:
> Li Zhijian <lizhijian@fujitsu.com> writes:
> 
>> It shows the demotion target nodes of a node. Export this information to
>> user directly.
>>
>> Below is an example where node0 node1 are DRAM, node3 is a PMEM node.
>> - Before PMEM is online, no demotion_nodes for node0 and node1.
>> $ cat /sys/devices/system/node/node0/demotion_nodes
>>   <show nothing>
>> - After node3 is online as kmem
>> $ daxctl reconfigure-device --mode=system-ram --no-online dax0.0 && daxctl online-memory dax0.0
>> [
>>    {
>>      "chardev":"dax0.0",
>>      "size":1054867456,
>>      "target_node":3,
>>      "align":2097152,
>>      "mode":"system-ram",
>>      "online_memblocks":0,
>>      "total_memblocks":7
>>    }
>> ]
>> $ cat /sys/devices/system/node/node0/demotion_nodes
>> 3
>> $ cat /sys/devices/system/node/node1/demotion_nodes
>> 3
>> $ cat /sys/devices/system/node/node3/demotion_nodes
>>   <show nothing>
> 
> We have /sys/devices/virtual/memory_tiering/memory_tier*/nodelist
> already.  A node in a higher tier can demote to any node in the lower
> tiers.  What's more need to be displayed in nodeX/demotion_nodes?
> 
> --
> Best Regards,
> Huang, Ying
> 
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> ---
>>   drivers/base/node.c          | 13 +++++++++++++
>>   include/linux/memory-tiers.h |  6 ++++++
>>   mm/memory-tiers.c            |  8 ++++++++
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 493d533f8375..27e8502548a7 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/init.h>
>>   #include <linux/mm.h>
>>   #include <linux/memory.h>
>> +#include <linux/memory-tiers.h>
>>   #include <linux/vmstat.h>
>>   #include <linux/notifier.h>
>>   #include <linux/node.h>
>> @@ -569,11 +570,23 @@ static ssize_t node_read_distance(struct device *dev,
>>   }
>>   static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>>   
>> +static ssize_t demotion_nodes_show(struct device *dev,
>> +			     struct device_attribute *attr, char *buf)
>> +{
>> +	int ret;
>> +	nodemask_t nmask = next_demotion_nodes(dev->id);
>> +
>> +	ret = sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&nmask));
>> +	return ret;
>> +}
>> +static DEVICE_ATTR_RO(demotion_nodes);
>> +
>>   static struct attribute *node_dev_attrs[] = {
>>   	&dev_attr_meminfo.attr,
>>   	&dev_attr_numastat.attr,
>>   	&dev_attr_distance.attr,
>>   	&dev_attr_vmstat.attr,
>> +	&dev_attr_demotion_nodes.attr,
>>   	NULL
>>   };
>>   
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> index 437441cdf78f..8eb04923f965 100644
>> --- a/include/linux/memory-tiers.h
>> +++ b/include/linux/memory-tiers.h
>> @@ -38,6 +38,7 @@ void init_node_memory_type(int node, struct memory_dev_type *default_type);
>>   void clear_node_memory_type(int node, struct memory_dev_type *memtype);
>>   #ifdef CONFIG_MIGRATION
>>   int next_demotion_node(int node);
>> +nodemask_t next_demotion_nodes(int node);
>>   void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
>>   bool node_is_toptier(int node);
>>   #else
>> @@ -46,6 +47,11 @@ static inline int next_demotion_node(int node)
>>   	return NUMA_NO_NODE;
>>   }
>>   
>> +static inline next_demotion_nodes next_demotion_nodes(int node)
>> +{
>> +	return NODE_MASK_NONE;
>> +}
>> +
>>   static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
>>   {
>>   	*targets = NODE_MASK_NONE;
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index 37a4f59d9585..90047f37d98a 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -282,6 +282,14 @@ void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
>>   	rcu_read_unlock();
>>   }
>>   
>> +nodemask_t next_demotion_nodes(int node)
>> +{
>> +	if (!node_demotion)
>> +		return NODE_MASK_NONE;
>> +
>> +	return node_demotion[node].preferred;
>> +}
>> +
>>   /**
>>    * next_demotion_node() - Get the next node in the demotion path
>>    * @node: The starting node to lookup the next node

