Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FC87DECBC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjKBGAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjKBGAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:00:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09451186
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 23:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698904840; x=1730440840;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=+Ub5rXV4gU4qWNncHCmz5ntRW6Mg4aPIijG5wpwL/jA=;
  b=ZHARV9yf51g8XT7MpVOr6GsI7tQ766s/KgUjN2tE0dOxmpZNAewJTISg
   2/9QZBr5q8sfVvWYzRtahiNE3Fi9FXtTqtaRBiNFjaOLMRTKF+BSHWv4P
   0OEvf6FkdayJZe/Pi/W3e/Dfs1qg0k0lnIkbith/wAO0ONvdsvhr1RmTl
   x4eo54sLXNvxxXJ+pQ9l1TsH9J+ivQh6FxODzQYWlC/he5+pA6y5fy3g+
   KY5lqesqs0uqEZu96qKoCGlsU+4ruJIQrqzTWu81k1yMNbdsbuUlPOIwj
   CcQCyl63VcJRI5PR2q5vYEj+InY3qlmL+VAVg8buwtUZrruQPfK/PQu8S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1510147"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="1510147"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 23:00:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1092603797"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="1092603797"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 23:00:37 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys
 infterface
In-Reply-To: <b9057753-393d-4703-b445-4eb0b9cb5b3a@fujitsu.com> (Zhijian Li's
        message of "Thu, 2 Nov 2023 05:54:47 +0000")
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
        <20231102025648.1285477-2-lizhijian@fujitsu.com>
        <878r7g3ktj.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <OS0PR01MB5442868460921E488B525176A5A6A@OS0PR01MB5442.jpnprd01.prod.outlook.com>
        <87zfzw20nd.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <b9057753-393d-4703-b445-4eb0b9cb5b3a@fujitsu.com>
Date:   Thu, 02 Nov 2023 13:58:36 +0800
Message-ID: <87msvw1ysz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 02/11/2023 13:18, Huang, Ying wrote:
>> "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:
>>=20
>>>> We have /sys/devices/virtual/memory_tiering/memory_tier*/nodelist
>>>> already.  A node in a higher tier can demote to any node in the lower
>>>> tiers.  What's more need to be displayed in nodeX/demotion_nodes?
>>>
>>> IIRC, they are not the same. memory_tier[number], where the number is s=
hared by
>>> the memory using the same memory driver(dax/kmem etc). Not reflect the =
actual distance
>>> across nodes(different distance will be grouped into the same memory_ti=
er).
>>> But demotion will only select the nearest nodelist to demote.
>>=20
>> In the following patchset, we will use the performance information from
>> HMAT to place nodes using the same memory driver into different memory
>> tiers.
>>=20
>> https://lore.kernel.org/all/20230926060628.265989-1-ying.huang@intel.com/
>
> Thanks for your reminder. It seems like I've fallen behind the world by m=
onths.
> I will rebase on it later if this patch is still needed.
>
>>=20
>> The patch is in mm-stable tree.
>>=20
>>> Below is an example, node0 node1 are DRAM, node2 node3 are PMEM, but di=
stance to DRAM nodes
>>> are different.
>>>=20=20=20
>>> # numactl -H
>>> available: 4 nodes (0-3)
>>> node 0 cpus: 0
>>> node 0 size: 964 MB
>>> node 0 free: 746 MB
>>> node 1 cpus: 1
>>> node 1 size: 685 MB
>>> node 1 free: 455 MB
>>> node 2 cpus:
>>> node 2 size: 896 MB
>>> node 2 free: 897 MB
>>> node 3 cpus:
>>> node 3 size: 896 MB
>>> node 3 free: 896 MB
>>> node distances:
>>> node   0   1   2   3
>>>    0:  10  20  20  25
>>>    1:  20  10  25  20
>>>    2:  20  25  10  20
>>>    3:  25  20  20  10
>>> # cat /sys/devices/system/node/node0/demotion_nodes
>>> 2
>>=20
>> node 2 is only the preferred demotion target.  In fact, memory in node 0
>> can be demoted to node 2,3.  Please check demote_folio_list() for
>> details.
>
> Have I missed something, at least the on master tree, nd->preferred only =
include the
> nearest ones(by specific algorithms), so in above numa topology, nd->pref=
erred of
> node0 is node2 only. node0 distance to node3 is 25 greater than to node2(=
20).
>
>> 1657         int target_nid =3D next_demotion_node(pgdat->node_id);
>
> So target_nid cannot be node3 IIUC.
>
> (I cooked this patches weeks ago, maybe something has changed, i will als=
o take a deep look later.)
>
> 1650 /*
> 1651  * Take folios on @demote_folios and attempt to demote them to anoth=
er node.
> 1652  * Folios which are not demoted are left on @demote_folios.
> 1653  */
> 1654 static unsigned int demote_folio_list(struct list_head *demote_folio=
s,
> 1655                                      struct pglist_data *pgdat)
> 1656 {
> 1657         int target_nid =3D next_demotion_node(pgdat->node_id);
> 1658         unsigned int nr_succeeded;
> 1659         nodemask_t allowed_mask;
> 1660
> 1661         struct migration_target_control mtc =3D {
> 1662                 /*
> 1663                  * Allocate from 'node', or fail quickly and quietly.
> 1664                  * When this happens, 'page' will likely just be dis=
carded
> 1665                  * instead of migrated.
> 1666                  */
> 1667                 .gfp_mask =3D (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM=
) | __GFP_NOWARN |
> 1668                         __GFP_NOMEMALLOC | GFP_NOWAIT,
> 1669                 .nid =3D target_nid,
> 1670                 .nmask =3D &allowed_mask
> 1671         };
> 1672
> 1673         if (list_empty(demote_folios))
> 1674                 return 0;
> 1675
> 1676         if (target_nid =3D=3D NUMA_NO_NODE)
> 1677                 return 0;
> 1678
> 1679         node_get_allowed_targets(pgdat, &allowed_mask);
> 1680
> 1681         /* Demotion ignores all cpuset and mempolicy settings */
> 1682         migrate_pages(demote_folios, alloc_demote_folio, NULL,
> 1683                       (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTIO=
N,
> 1684                       &nr_succeeded);
>

In alloc_demote_folio(), target_nid is tried firstly. Then, if
allocation fails, any node in allowed_mask will be tried.

--
Best Regards,
Huang, Ying

>>=20
>>> # cat /sys/devices/system/node/node1/demotion_nodes
>>> 3
>>> # cat /sys/devices/virtual/memory_tiering/memory_tier22/nodelist
>>> 2-3
>>>
>>> Thanks
>>> Zhijian
>>>
>>> (I hate the outlook native reply composition format.)
>>> ________________________________________
>>> From: Huang, Ying <ying.huang@intel.com>
>>> Sent: Thursday, November 2, 2023 11:17
>>> To: Li, Zhijian/=E6=9D=8E =E6=99=BA=E5=9D=9A
>>> Cc: Andrew Morton; Greg Kroah-Hartman; rafael@kernel.org; linux-mm@kvac=
k.org; Gotou, Yasunori/=E4=BA=94=E5=B3=B6 =E5=BA=B7=E6=96=87; linux-kernel@=
vger.kernel.org
>>> Subject: Re: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys =
infterface
>>>
>>> Li Zhijian <lizhijian@fujitsu.com> writes:
>>>
>>>> It shows the demotion target nodes of a node. Export this information =
to
>>>> user directly.
>>>>
>>>> Below is an example where node0 node1 are DRAM, node3 is a PMEM node.
>>>> - Before PMEM is online, no demotion_nodes for node0 and node1.
>>>> $ cat /sys/devices/system/node/node0/demotion_nodes
>>>>   <show nothing>
>>>> - After node3 is online as kmem
>>>> $ daxctl reconfigure-device --mode=3Dsystem-ram --no-online dax0.0 && =
daxctl online-memory dax0.0
>>>> [
>>>>    {
>>>>      "chardev":"dax0.0",
>>>>      "size":1054867456,
>>>>      "target_node":3,
>>>>      "align":2097152,
>>>>      "mode":"system-ram",
>>>>      "online_memblocks":0,
>>>>      "total_memblocks":7
>>>>    }
>>>> ]
>>>> $ cat /sys/devices/system/node/node0/demotion_nodes
>>>> 3
>>>> $ cat /sys/devices/system/node/node1/demotion_nodes
>>>> 3
>>>> $ cat /sys/devices/system/node/node3/demotion_nodes
>>>>   <show nothing>
>>>
>>> We have /sys/devices/virtual/memory_tiering/memory_tier*/nodelist
>>> already.  A node in a higher tier can demote to any node in the lower
>>> tiers.  What's more need to be displayed in nodeX/demotion_nodes?
>>>
>>> --
>>> Best Regards,
>>> Huang, Ying
>>>
>>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>>> ---
>>>>   drivers/base/node.c          | 13 +++++++++++++
>>>>   include/linux/memory-tiers.h |  6 ++++++
>>>>   mm/memory-tiers.c            |  8 ++++++++
>>>>   3 files changed, 27 insertions(+)
>>>>
>>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>>> index 493d533f8375..27e8502548a7 100644
>>>> --- a/drivers/base/node.c
>>>> +++ b/drivers/base/node.c
>>>> @@ -7,6 +7,7 @@
>>>>   #include <linux/init.h>
>>>>   #include <linux/mm.h>
>>>>   #include <linux/memory.h>
>>>> +#include <linux/memory-tiers.h>
>>>>   #include <linux/vmstat.h>
>>>>   #include <linux/notifier.h>
>>>>   #include <linux/node.h>
>>>> @@ -569,11 +570,23 @@ static ssize_t node_read_distance(struct device =
*dev,
>>>>   }
>>>>   static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>>>>
>>>> +static ssize_t demotion_nodes_show(struct device *dev,
>>>> +                          struct device_attribute *attr, char *buf)
>>>> +{
>>>> +     int ret;
>>>> +     nodemask_t nmask =3D next_demotion_nodes(dev->id);
>>>> +
>>>> +     ret =3D sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&nmask));
>>>> +     return ret;
>>>> +}
>>>> +static DEVICE_ATTR_RO(demotion_nodes);
>>>> +
>>>>   static struct attribute *node_dev_attrs[] =3D {
>>>>        &dev_attr_meminfo.attr,
>>>>        &dev_attr_numastat.attr,
>>>>        &dev_attr_distance.attr,
>>>>        &dev_attr_vmstat.attr,
>>>> +     &dev_attr_demotion_nodes.attr,
>>>>        NULL
>>>>   };
>>>>
>>>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers=
.h
>>>> index 437441cdf78f..8eb04923f965 100644
>>>> --- a/include/linux/memory-tiers.h
>>>> +++ b/include/linux/memory-tiers.h
>>>> @@ -38,6 +38,7 @@ void init_node_memory_type(int node, struct memory_d=
ev_type *default_type);
>>>>   void clear_node_memory_type(int node, struct memory_dev_type *memtyp=
e);
>>>>   #ifdef CONFIG_MIGRATION
>>>>   int next_demotion_node(int node);
>>>> +nodemask_t next_demotion_nodes(int node);
>>>>   void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
>>>>   bool node_is_toptier(int node);
>>>>   #else
>>>> @@ -46,6 +47,11 @@ static inline int next_demotion_node(int node)
>>>>        return NUMA_NO_NODE;
>>>>   }
>>>>
>>>> +static inline next_demotion_nodes next_demotion_nodes(int node)
>>>> +{
>>>> +     return NODE_MASK_NONE;
>>>> +}
>>>> +
>>>>   static inline void node_get_allowed_targets(pg_data_t *pgdat, nodema=
sk_t *targets)
>>>>   {
>>>>        *targets =3D NODE_MASK_NONE;
>>>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>>>> index 37a4f59d9585..90047f37d98a 100644
>>>> --- a/mm/memory-tiers.c
>>>> +++ b/mm/memory-tiers.c
>>>> @@ -282,6 +282,14 @@ void node_get_allowed_targets(pg_data_t *pgdat, n=
odemask_t *targets)
>>>>        rcu_read_unlock();
>>>>   }
>>>>
>>>> +nodemask_t next_demotion_nodes(int node)
>>>> +{
>>>> +     if (!node_demotion)
>>>> +             return NODE_MASK_NONE;
>>>> +
>>>> +     return node_demotion[node].preferred;
>>>> +}
>>>> +
>>>>   /**
>>>>    * next_demotion_node() - Get the next node in the demotion path
>>>>    * @node: The starting node to lookup the next node
