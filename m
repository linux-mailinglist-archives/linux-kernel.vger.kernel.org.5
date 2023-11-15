Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DDE7ED369
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjKOUvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjKOUvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:51:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF95C8F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700081509; x=1731617509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gEmSesFKnrmpRA25UkqersrEcx6SvM/BHS3f/SD5mrQ=;
  b=bBn/Nv0RcDHcbjZZazsI7c0RVmCOun47/pdvHKbXqoWjmxWcyMN6i8Ec
   3rsZ1lPUmNKuvt6qNYJu7hwotflM1NV+RtrB9szSBAJ/qDGKWxn42EL7f
   Bk9hn/6W9rkfUGrDvI+4ZdBIi4gyGjJidx9NnKuGxs9Umqnd6FLh5HhEZ
   xC0olg2G6RpCireRxMLtJr2c+P0PsxKsLPvLOJuLImfkLgNZNoPxSartC
   zIQu/MzENurBGYOBebvHncof8xeG4mjQwmnAB/7LKtZq399cLiXP66Tsl
   zhZnoYVybddjqbgjYLZqqBWCnfs0YrdQQxtcpkD4Vtjfzd9Uev2kiW8dA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389810508"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="389810508"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 12:51:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="882508058"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="882508058"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2023 12:51:45 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3MrP-0000oZ-1N;
        Wed, 15 Nov 2023 20:51:43 +0000
Date:   Thu, 16 Nov 2023 04:51:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] sched/fair: introduce core_vruntime and
 core_min_vruntime
Message-ID: <202311160442.IBG98IUu-lkp@intel.com>
References: <20231115113341.13261-4-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115113341.13261-4-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cruz,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc1 next-20231115]
[cannot apply to tip/sched/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cruz-Zhao/sched-core-introduce-core_id-to-struct-rq/20231115-193559
base:   linus/master
patch link:    https://lore.kernel.org/r/20231115113341.13261-4-CruzZhao%40linux.alibaba.com
patch subject: [PATCH 3/4] sched/fair: introduce core_vruntime and core_min_vruntime
config: i386-buildonly-randconfig-005-20231116 (https://download.01.org/0day-ci/archive/20231116/202311160442.IBG98IUu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160442.IBG98IUu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160442.IBG98IUu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/fair.c:54:
   kernel/sched/fair.c: In function 'update_min_vruntime':
>> kernel/sched/fair.c:802:37: error: 'struct cfs_rq' has no member named 'core_min_vruntime_copy'; did you mean 'core_min_vruntime'?
     802 |         u64_u32_store(cfs_rq->core->core_min_vruntime,
         |                                     ^~~~~~~~~~~~~~~~~
   kernel/sched/sched.h:528:9: note: in definition of macro 'u64_u32_store_copy'
     528 |         copy = __val;                                                   \
         |         ^~~~
   kernel/sched/fair.c:802:9: note: in expansion of macro 'u64_u32_store'
     802 |         u64_u32_store(cfs_rq->core->core_min_vruntime,
         |         ^~~~~~~~~~~~~
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:12462:6: warning: no previous prototype for 'sched_core_init_cfs_rq' [-Wmissing-prototypes]
   12462 | void sched_core_init_cfs_rq(struct task_group *tg, struct cfs_rq *cfs_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: In function 'init_cfs_rq':
   kernel/sched/fair.c:12698:31: error: 'struct cfs_rq' has no member named 'core_min_vruntime_copy'; did you mean 'core_min_vruntime'?
   12698 |         u64_u32_store(cfs_rq->core_min_vruntime, (u64)(-(1LL << 20)));
         |                               ^~~~~~~~~~~~~~~~~
   kernel/sched/sched.h:528:9: note: in definition of macro 'u64_u32_store_copy'
     528 |         copy = __val;                                                   \
         |         ^~~~
   kernel/sched/fair.c:12698:9: note: in expansion of macro 'u64_u32_store'
   12698 |         u64_u32_store(cfs_rq->core_min_vruntime, (u64)(-(1LL << 20)));
         |         ^~~~~~~~~~~~~
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:12985:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
   12985 | void free_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:12987:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
   12987 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:12992:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
   12992 | void online_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:12994:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
   12994 | void unregister_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +802 kernel/sched/fair.c

   772	
   773		if (curr) {
   774			if (curr->on_rq) {
   775				vruntime = curr->vruntime;
   776	#ifdef CONFIG_SCHED_CORE
   777				core_vruntime = curr->core_vruntime;
   778	#endif
   779			} else {
   780				curr = NULL;
   781			}
   782		}
   783	
   784		if (se) {
   785			if (!curr) {
   786				vruntime = se->vruntime;
   787	#ifdef CONFIG_SCHED_CORE
   788				core_vruntime = se->core_vruntime;
   789	#endif
   790			} else {
   791				vruntime = min_vruntime(vruntime, se->vruntime);
   792	#ifdef CONFIG_SCHED_CORE
   793				core_vruntime = min_vruntime(core_vruntime, se->core_vruntime);
   794	#endif
   795			}
   796		}
   797	
   798		/* ensure we never gain time by being placed backwards. */
   799		u64_u32_store(cfs_rq->min_vruntime,
   800			      __update_min_vruntime(cfs_rq, vruntime));
   801	#ifdef CONFIG_SCHED_CORE
 > 802		u64_u32_store(cfs_rq->core->core_min_vruntime,
   803			     __update_core_min_vruntime(cfs_rq->core, vruntime));
   804	#endif
   805	}
   806	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
