Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802D57868E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbjHXHpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbjHXHop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:44:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A7E1708
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692863082; x=1724399082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KjXKLMK+N4GSRL7HZ1n601Fx0NCTEWQ6GDChxqLcKWM=;
  b=i/BaHIhbBp7aWFunCnQ1+e02tgp/lMvHSnBo+A6UWm9UA4lcWbFRNoVa
   EVt32JhUk5CoCx5X0VIvZbRIT5BlSqAF+HJR8FTBJHq+CVhhkAuWW/xgH
   hNHYUQbzVtDpP5SoPjfyFy81fTmJQLRXXccJ5m91C/hkHskbvK0nTrv7k
   8bU+mjkCohzwnQW+3NIWXOVyuOdoBB3T9q48GPjtFyk4Yg0Wf1H5/35KR
   GNfe288omnU8N12ORoMmwNExloTR9HHce5shgJG6gGwJxKUKBlZTWC8ga
   mQxqw4sdY6Y2BDT9+m0LWkGHHia+sOG8PfIBpL6lT1o0PjzExFxFg3h8t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="374341867"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="374341867"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 00:44:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880706428"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 00:44:42 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZ51B-0001qc-0z;
        Thu, 24 Aug 2023 07:44:37 +0000
Date:   Thu, 24 Aug 2023 15:43:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hao Jia <jiahao.os@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, pauld@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hao Jia <jiahao.os@bytedance.com>
Subject: Re: [PATCH 1/2] sched/core: Introduce sched_class::can_stop_tick()
Message-ID: <202308241526.be4l9ROa-lkp@intel.com>
References: <20230821094927.51079-2-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821094927.51079-2-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on next-20230824]
[cannot apply to linus/master v6.5-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hao-Jia/sched-core-Introduce-sched_class-can_stop_tick/20230821-175200
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20230821094927.51079-2-jiahao.os%40bytedance.com
patch subject: [PATCH 1/2] sched/core: Introduce sched_class::can_stop_tick()
config: arm64-randconfig-r122-20230824 (https://download.01.org/0day-ci/archive/20230824/202308241526.be4l9ROa-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230824/202308241526.be4l9ROa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308241526.be4l9ROa-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/fair.c:702:6: sparse: sparse: symbol 'update_entity_lag' was not declared. Should it be static?
   kernel/sched/fair.c:1140:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity const *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:1140:34: sparse:     expected struct sched_entity const *se
   kernel/sched/fair.c:1140:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:12087:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:12087:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:12087:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:5674:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:5674:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:5674:22: sparse:    struct task_struct *
>> kernel/sched/fair.c:6336:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:6336:56: sparse:     expected struct task_struct *p
   kernel/sched/fair.c:6336:56: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:6337:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:6337:47: sparse:     expected struct task_struct *p
   kernel/sched/fair.c:6337:47: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:6438:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:6438:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:6438:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7738:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:7738:20: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:7738:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:7940:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:7940:9: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/fair.c:7940:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:8039:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:8039:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:8039:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:8319:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:8319:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:8319:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:9312:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair.c:9312:40: sparse:     expected struct sched_domain *child
   kernel/sched/fair.c:9312:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/fair.c:9939:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:9939:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:9939:22: sparse:    struct task_struct *
   kernel/sched/fair.c:11359:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11359:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:11359:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:11018:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *sd_parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11018:44: sparse:     expected struct sched_domain *sd_parent
   kernel/sched/fair.c:11018:44: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:11455:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11455:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:11455:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2130:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2130:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2130:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2296:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2296:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2296:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2130:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2130:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2130:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2130:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2130:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2130:25: sparse:    struct task_struct *

vim +6336 kernel/sched/fair.c

  6321	
  6322	static bool can_stop_tick_fair(struct rq *rq, int *stop_next)
  6323	{
  6324		if (rq->nr_running > 1) {
  6325			*stop_next = 1;
  6326			return false;
  6327		}
  6328	
  6329		/*
  6330		 * If there is one task and it has CFS runtime bandwidth constraints
  6331		 * and it's on the cpu now we don't want to stop the tick.
  6332		 * This check prevents clearing the bit if a newly enqueued task here is
  6333		 * dequeued by migrating while the constrained task continues to run.
  6334		 * E.g. going from 2->1 without going through pick_next_task().
  6335		 */
> 6336		if (sched_feat(HZ_BW) && __need_bw_check(rq, rq->curr)) {
  6337			if (cfs_task_bw_constrained(rq->curr)) {
  6338				*stop_next = 1;
  6339				return false;
  6340			}
  6341		}
  6342	
  6343		return true;
  6344	}
  6345	#endif
  6346	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
