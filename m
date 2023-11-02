Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3872D7DEC37
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348537AbjKBFVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348472AbjKBFVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:21:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5632C116
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 22:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698902475; x=1730438475;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=XjJIMBcU/lOPh1j2ffct2ioR/1Xofx7bdH3bKdf4IvY=;
  b=oIhHnrXIKfDsZ1OOeQMrfBz490XUBzNTVK8yv+cOStfybZseSRqxDT17
   KOedO2qyNKRCotk4RGKY4AlHdoxRiNM/97qchQuyH+NAkXym/1TECywlM
   fjZDwo25gy7C8CLgLjH7VL5Vez5N0qpLUf1KfZJbLD+WaM6bdSy6vMAFJ
   uYbBNHDmpQm8g6eE/k7DKPc0B3Vj2dHr2ZVKiDRqYdtyCoUna2UlHhal6
   dh09cNzNc4ar6PkcYUXm3QRp47gDFNjoeRAhCX9hZ9s0edVieXYz8JZDw
   mYfvOUNWS/B9auW6gH+9qkhZc8RK56nbzBjlqA1jpXyuJvC4beoHKt+Vy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="474878693"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="474878693"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 22:20:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1092599736"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="1092599736"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 22:20:48 -0700
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
In-Reply-To: <OS0PR01MB5442868460921E488B525176A5A6A@OS0PR01MB5442.jpnprd01.prod.outlook.com>
        (Zhijian Li's message of "Thu, 2 Nov 2023 03:39:58 +0000")
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
        <20231102025648.1285477-2-lizhijian@fujitsu.com>
        <878r7g3ktj.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <OS0PR01MB5442868460921E488B525176A5A6A@OS0PR01MB5442.jpnprd01.prod.outlook.com>
Date:   Thu, 02 Nov 2023 13:18:46 +0800
Message-ID: <87zfzw20nd.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

>> We have /sys/devices/virtual/memory_tiering/memory_tier*/nodelist
>> already.  A node in a higher tier can demote to any node in the lower
>> tiers.  What's more need to be displayed in nodeX/demotion_nodes?
>
> IIRC, they are not the same. memory_tier[number], where the number is sha=
red by
> the memory using the same memory driver(dax/kmem etc). Not reflect the ac=
tual distance
> across nodes(different distance will be grouped into the same memory_tier=
).
> But demotion will only select the nearest nodelist to demote.

In the following patchset, we will use the performance information from
HMAT to place nodes using the same memory driver into different memory
tiers.

https://lore.kernel.org/all/20230926060628.265989-1-ying.huang@intel.com/

The patch is in mm-stable tree.

> Below is an example, node0 node1 are DRAM, node2 node3 are PMEM, but dist=
ance to DRAM nodes
> are different.
>=20=20
> # numactl -H
> available: 4 nodes (0-3)
> node 0 cpus: 0
> node 0 size: 964 MB
> node 0 free: 746 MB
> node 1 cpus: 1
> node 1 size: 685 MB
> node 1 free: 455 MB
> node 2 cpus:
> node 2 size: 896 MB
> node 2 free: 897 MB
> node 3 cpus:
> node 3 size: 896 MB
> node 3 free: 896 MB
> node distances:
> node   0   1   2   3
>   0:  10  20  20  25
>   1:  20  10  25  20
>   2:  20  25  10  20
>   3:  25  20  20  10
> # cat /sys/devices/system/node/node0/demotion_nodes
> 2

node 2 is only the preferred demotion target.  In fact, memory in node 0
can be demoted to node 2,3.  Please check demote_folio_list() for
details.

--
Best Regards,
Huang, Ying

> # cat /sys/devices/system/node/node1/demotion_nodes
> 3
> # cat /sys/devices/virtual/memory_tiering/memory_tier22/nodelist
> 2-3
>
> Thanks
> Zhijian
>
> (I hate the outlook native reply composition format.)
> ________________________________________
> From: Huang, Ying <ying.huang@intel.com>
> Sent: Thursday, November 2, 2023 11:17
> To: Li, Zhijian/=E6=9D=8E =E6=99=BA=E5=9D=9A
> Cc: Andrew Morton; Greg Kroah-Hartman; rafael@kernel.org; linux-mm@kvack.=
org; Gotou, Yasunori/=E4=BA=94=E5=B3=B6 =E5=BA=B7=E6=96=87; linux-kernel@vg=
er.kernel.org
> Subject: Re: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys in=
fterface
>
> Li Zhijian <lizhijian@fujitsu.com> writes:
>
>> It shows the demotion target nodes of a node. Export this information to
>> user directly.
>>
>> Below is an example where node0 node1 are DRAM, node3 is a PMEM node.
>> - Before PMEM is online, no demotion_nodes for node0 and node1.
>> $ cat /sys/devices/system/node/node0/demotion_nodes
>>  <show nothing>
>> - After node3 is online as kmem
>> $ daxctl reconfigure-device --mode=3Dsystem-ram --no-online dax0.0 && da=
xctl online-memory dax0.0
>> [
>>   {
>>     "chardev":"dax0.0",
>>     "size":1054867456,
>>     "target_node":3,
>>     "align":2097152,
>>     "mode":"system-ram",
>>     "online_memblocks":0,
>>     "total_memblocks":7
>>   }
>> ]
>> $ cat /sys/devices/system/node/node0/demotion_nodes
>> 3
>> $ cat /sys/devices/system/node/node1/demotion_nodes
>> 3
>> $ cat /sys/devices/system/node/node3/demotion_nodes
>>  <show nothing>
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
>>  drivers/base/node.c          | 13 +++++++++++++
>>  include/linux/memory-tiers.h |  6 ++++++
>>  mm/memory-tiers.c            |  8 ++++++++
>>  3 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 493d533f8375..27e8502548a7 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/init.h>
>>  #include <linux/mm.h>
>>  #include <linux/memory.h>
>> +#include <linux/memory-tiers.h>
>>  #include <linux/vmstat.h>
>>  #include <linux/notifier.h>
>>  #include <linux/node.h>
>> @@ -569,11 +570,23 @@ static ssize_t node_read_distance(struct device *d=
ev,
>>  }
>>  static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>>
>> +static ssize_t demotion_nodes_show(struct device *dev,
>> +                          struct device_attribute *attr, char *buf)
>> +{
>> +     int ret;
>> +     nodemask_t nmask =3D next_demotion_nodes(dev->id);
>> +
>> +     ret =3D sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&nmask));
>> +     return ret;
>> +}
>> +static DEVICE_ATTR_RO(demotion_nodes);
>> +
>>  static struct attribute *node_dev_attrs[] =3D {
>>       &dev_attr_meminfo.attr,
>>       &dev_attr_numastat.attr,
>>       &dev_attr_distance.attr,
>>       &dev_attr_vmstat.attr,
>> +     &dev_attr_demotion_nodes.attr,
>>       NULL
>>  };
>>
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> index 437441cdf78f..8eb04923f965 100644
>> --- a/include/linux/memory-tiers.h
>> +++ b/include/linux/memory-tiers.h
>> @@ -38,6 +38,7 @@ void init_node_memory_type(int node, struct memory_dev=
_type *default_type);
>>  void clear_node_memory_type(int node, struct memory_dev_type *memtype);
>>  #ifdef CONFIG_MIGRATION
>>  int next_demotion_node(int node);
>> +nodemask_t next_demotion_nodes(int node);
>>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
>>  bool node_is_toptier(int node);
>>  #else
>> @@ -46,6 +47,11 @@ static inline int next_demotion_node(int node)
>>       return NUMA_NO_NODE;
>>  }
>>
>> +static inline next_demotion_nodes next_demotion_nodes(int node)
>> +{
>> +     return NODE_MASK_NONE;
>> +}
>> +
>>  static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_=
t *targets)
>>  {
>>       *targets =3D NODE_MASK_NONE;
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index 37a4f59d9585..90047f37d98a 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -282,6 +282,14 @@ void node_get_allowed_targets(pg_data_t *pgdat, nod=
emask_t *targets)
>>       rcu_read_unlock();
>>  }
>>
>> +nodemask_t next_demotion_nodes(int node)
>> +{
>> +     if (!node_demotion)
>> +             return NODE_MASK_NONE;
>> +
>> +     return node_demotion[node].preferred;
>> +}
>> +
>>  /**
>>   * next_demotion_node() - Get the next node in the demotion path
>>   * @node: The starting node to lookup the next node
