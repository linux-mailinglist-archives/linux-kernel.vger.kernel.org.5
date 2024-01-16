Return-Path: <linux-kernel+bounces-26945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E082E85F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3D62848FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE179C6;
	Tue, 16 Jan 2024 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGRIb1np"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999777483
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705377821; x=1736913821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bQklZx8MUUH6f3JRo0qIL2LIBLnHFaBAF16W7UNNJJU=;
  b=bGRIb1npJeN7Mpxspl8qd5vEfqLFen/4BE+wT0I97WV95kP2MmTzn071
   NBLWrZiUKRUOdghZOxzkWQJZSmYrLG5iN5CfTOJvvx8btEizx3gVteVbI
   n5fUSpHpgmhze4Y750aWrTwOOnPJ/1O7VJQmLhqjJodGzrgDpxYIiUbdt
   H+YtSrdVJ0qnTdLgD3aozslCg5tO7pE4Vc6YOEOxPmo1+55TnVLGMtU+o
   cnMhnkCYfZ5wvNdGDG+O5t4VdevNGUnRukp8jHyDCBxM7QqGs83arpxQz
   locjzI2zzBE5RMtqqiQSi327wowvnJ3SSX6aUwLxfFmosbteUaXKpnfCl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6844629"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="6844629"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 20:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="927310271"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="927310271"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2024 20:03:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPafJ-000Cwg-39;
	Tue, 16 Jan 2024 04:03:15 +0000
Date: Tue, 16 Jan 2024 11:56:07 +0800
From: kernel test robot <lkp@intel.com>
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v2 1/3] sched/topology: Annotate RCU pointers properly
Message-ID: <202401161144.OJH5PySm-lkp@intel.com>
References: <20240115143427.1820628-2-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115143427.1820628-2-pierre.gondois@arm.com>

Hi Pierre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pierre-Gondois/sched-topology-Annotate-RCU-pointers-properly/20240115-223658
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20240115143427.1820628-2-pierre.gondois%40arm.com
patch subject: [PATCH v2 1/3] sched/topology: Annotate RCU pointers properly
config: arm64-randconfig-r133-20240116 (https://download.01.org/0day-ci/archive/20240116/202401161144.OJH5PySm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240116/202401161144.OJH5PySm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161144.OJH5PySm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/debug.c:468:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/debug.c:468:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/debug.c:468:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/debug.c:793:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/debug.c:793:9: sparse:     expected struct task_struct *tsk
   kernel/sched/debug.c:793:9: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/debug.c:793:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/debug.c:793:9: sparse:     expected struct task_struct *tsk
   kernel/sched/debug.c:793:9: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/stats.c:148:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/stats.c:148:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/stats.c:148:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/topology.c:107:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:107:56: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:107:56: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:126:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:126:60: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:126:60: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:149:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:149:20: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:149:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:485:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct perf_domain *pd @@     got struct perf_domain [noderef] __rcu *pd @@
   kernel/sched/topology.c:485:19: sparse:     expected struct perf_domain *pd
   kernel/sched/topology.c:485:19: sparse:     got struct perf_domain [noderef] __rcu *pd
   kernel/sched/topology.c:647:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:647:49: sparse:     expected struct sched_domain *parent
   kernel/sched/topology.c:647:49: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:732:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:732:50: sparse:     expected struct sched_domain *parent
   kernel/sched/topology.c:732:50: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:740:55: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *[noderef] __rcu child @@     got struct sched_domain *[assigned] tmp @@
   kernel/sched/topology.c:740:55: sparse:     expected struct sched_domain [noderef] __rcu *[noderef] __rcu child
   kernel/sched/topology.c:740:55: sparse:     got struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:753:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:753:29: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:753:29: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:758:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:758:20: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:758:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:779:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *sd @@
   kernel/sched/topology.c:779:13: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:779:13: sparse:     got struct sched_domain [noderef] __rcu *sd
   kernel/sched/topology.c:941:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:941:70: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:941:70: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:970:59: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:970:59: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:970:59: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1016:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1016:57: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1016:57: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1018:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sibling @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1018:25: sparse:     expected struct sched_domain *sibling
   kernel/sched/topology.c:1018:25: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1026:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1026:55: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1026:55: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1028:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sibling @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1028:25: sparse:     expected struct sched_domain *sibling
   kernel/sched/topology.c:1028:25: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1098:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1098:62: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1098:62: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1202:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1202:40: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:1202:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1622:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain [noderef] __rcu *child @@     got struct sched_domain *child @@
   kernel/sched/topology.c:1622:43: sparse:     expected struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1622:43: sparse:     got struct sched_domain *child
>> kernel/sched/topology.c:2006:24: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/sched/topology.c:2014:24: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/sched/topology.c:2321:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *parent @@     got struct sched_domain *sd @@
   kernel/sched/topology.c:2321:31: sparse:     expected struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2321:31: sparse:     got struct sched_domain *sd
   kernel/sched/topology.c:2425:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2425:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2425:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2446:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:2446:56: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:2446:56: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:2445:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2445:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2445:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2500:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2500:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2500:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/core_sched.c:276:37: sparse: sparse: incompatible types in conditional expression (different address spaces):
   kernel/sched/core_sched.c:276:37: sparse:    struct task_struct *
   kernel/sched/core_sched.c:276:37: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/sched.h:2142:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2142:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2142:25: sparse:    struct task_struct *

vim +/__rcu +2006 kernel/sched/topology.c

  1987	
  1988	
  1989	static void sched_reset_numa(void)
  1990	{
  1991		int nr_levels, __rcu *distances;
  1992		struct cpumask ** __rcu *masks;
  1993	
  1994		nr_levels = sched_domains_numa_levels;
  1995		sched_domains_numa_levels = 0;
  1996		sched_max_numa_distance = 0;
  1997		sched_numa_topology_type = NUMA_DIRECT;
  1998		distances = sched_domains_numa_distance;
  1999		rcu_assign_pointer(sched_domains_numa_distance, NULL);
  2000		masks = sched_domains_numa_masks;
  2001		rcu_assign_pointer(sched_domains_numa_masks, NULL);
  2002		if (distances || masks) {
  2003			int i, j;
  2004	
  2005			synchronize_rcu();
> 2006			kfree((void *)distances);
  2007			for (i = 0; i < nr_levels && masks; i++) {
  2008				if (!masks[i])
  2009					continue;
  2010				for_each_node(j)
  2011					kfree(masks[i][j]);
  2012				kfree(masks[i]);
  2013			}
  2014			kfree((void *)masks);
  2015		}
  2016		if (sched_domain_topology_saved) {
  2017			kfree(sched_domain_topology);
  2018			sched_domain_topology = sched_domain_topology_saved;
  2019			sched_domain_topology_saved = NULL;
  2020		}
  2021	}
  2022	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

