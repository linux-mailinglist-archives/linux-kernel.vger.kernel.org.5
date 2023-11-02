Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF9D7DEB47
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348338AbjKBDT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348268AbjKBDTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:19:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2C89F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 20:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698895189; x=1730431189;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=iBLPvwCSOspG+bzCGzZm2j9t2qHkZ+ra3oCn0zk86X0=;
  b=HrsdzAPWnT0rf8czxfMmzonEGuPfAK7biSvH8Ab9+lTsSVe2BPZfQlXi
   apIcwWFMTuFHeiMDDnZUC3tIOHZ+aUOd3as2ftIP3cUn+YLusC4HSR9Pk
   3J5tBaWH1kTAYnU2Tp0A7+eT0FC/FY5FY24Z2Y3bmYDaA+BtinJ/2oGRR
   q+NCHB4lbtbL6aDT4vInwknGG2ynPyyTGE8bcaSHmRgyZ+YZny9tYNtvg
   OdXcWOrPaXgjYXOJPz/G8xlwVcDdM5qTPku9I0nn3xTFkwVOyTqGNmjtN
   7nPfeFepZWfWg6bfJI0a4/PR/hWb2uO/6PNZknzLU9ngg+ZE1c3+jYwyE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="7264557"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="7264557"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 20:19:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="737609632"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="737609632"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 20:19:46 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-mm@kvack.org>, <y-goto@fujitsu.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys
 infterface
In-Reply-To: <20231102025648.1285477-2-lizhijian@fujitsu.com> (Li Zhijian's
        message of "Thu, 2 Nov 2023 10:56:45 +0800")
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
        <20231102025648.1285477-2-lizhijian@fujitsu.com>
Date:   Thu, 02 Nov 2023 11:17:44 +0800
Message-ID: <878r7g3ktj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li Zhijian <lizhijian@fujitsu.com> writes:

> It shows the demotion target nodes of a node. Export this information to
> user directly.
>
> Below is an example where node0 node1 are DRAM, node3 is a PMEM node.
> - Before PMEM is online, no demotion_nodes for node0 and node1.
> $ cat /sys/devices/system/node/node0/demotion_nodes
>  <show nothing>
> - After node3 is online as kmem
> $ daxctl reconfigure-device --mode=system-ram --no-online dax0.0 && daxctl online-memory dax0.0
> [
>   {
>     "chardev":"dax0.0",
>     "size":1054867456,
>     "target_node":3,
>     "align":2097152,
>     "mode":"system-ram",
>     "online_memblocks":0,
>     "total_memblocks":7
>   }
> ]
> $ cat /sys/devices/system/node/node0/demotion_nodes
> 3
> $ cat /sys/devices/system/node/node1/demotion_nodes
> 3
> $ cat /sys/devices/system/node/node3/demotion_nodes
>  <show nothing>

We have /sys/devices/virtual/memory_tiering/memory_tier*/nodelist
already.  A node in a higher tier can demote to any node in the lower
tiers.  What's more need to be displayed in nodeX/demotion_nodes?

--
Best Regards,
Huang, Ying

> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/base/node.c          | 13 +++++++++++++
>  include/linux/memory-tiers.h |  6 ++++++
>  mm/memory-tiers.c            |  8 ++++++++
>  3 files changed, 27 insertions(+)
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 493d533f8375..27e8502548a7 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -7,6 +7,7 @@
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/memory.h>
> +#include <linux/memory-tiers.h>
>  #include <linux/vmstat.h>
>  #include <linux/notifier.h>
>  #include <linux/node.h>
> @@ -569,11 +570,23 @@ static ssize_t node_read_distance(struct device *dev,
>  }
>  static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>  
> +static ssize_t demotion_nodes_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	nodemask_t nmask = next_demotion_nodes(dev->id);
> +
> +	ret = sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&nmask));
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(demotion_nodes);
> +
>  static struct attribute *node_dev_attrs[] = {
>  	&dev_attr_meminfo.attr,
>  	&dev_attr_numastat.attr,
>  	&dev_attr_distance.attr,
>  	&dev_attr_vmstat.attr,
> +	&dev_attr_demotion_nodes.attr,
>  	NULL
>  };
>  
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 437441cdf78f..8eb04923f965 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -38,6 +38,7 @@ void init_node_memory_type(int node, struct memory_dev_type *default_type);
>  void clear_node_memory_type(int node, struct memory_dev_type *memtype);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
> +nodemask_t next_demotion_nodes(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
>  bool node_is_toptier(int node);
>  #else
> @@ -46,6 +47,11 @@ static inline int next_demotion_node(int node)
>  	return NUMA_NO_NODE;
>  }
>  
> +static inline next_demotion_nodes next_demotion_nodes(int node)
> +{
> +	return NODE_MASK_NONE;
> +}
> +
>  static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
>  {
>  	*targets = NODE_MASK_NONE;
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 37a4f59d9585..90047f37d98a 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -282,6 +282,14 @@ void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
>  	rcu_read_unlock();
>  }
>  
> +nodemask_t next_demotion_nodes(int node)
> +{
> +	if (!node_demotion)
> +		return NODE_MASK_NONE;
> +
> +	return node_demotion[node].preferred;
> +}
> +
>  /**
>   * next_demotion_node() - Get the next node in the demotion path
>   * @node: The starting node to lookup the next node
