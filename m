Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E647E8AB9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 12:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjKKL1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 06:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjKKL1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 06:27:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67F7EA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 03:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699702036; x=1731238036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rgIfOEiOZ989bKZFuB0N80EYz/nbfjUxtRAMd7EDRDw=;
  b=if9YYYtVs38+6fi7K+rgnxk02n8cYv9iHq18N9sGwCTRd4l7a6jz3bBk
   PLIgAn3i/cETFPxkAcVWINpff/LgNfa5XaoNBhendtsDDpaX2IjLQDTl6
   6PPz7Qc2Y9YB9iBhbJyTrnBwLLvyUkB8gOsnA0Ytxigui6ISrvQSo6AN+
   wrReZT4mtuw0V6e8fjuA7GyGBRqrDn4MYfQbG0MdLhHVE19myBqopORs/
   DGbobmQOpVhkdznDNNf9TXZe2s90FRAtCzmT0JdL1BRbVoxJhHZ+7QnT4
   bcS+HwnExz22xnW/R0C9+xgitl1Yl9LNXA8TUJschxkzpUEwBVNguI3Gx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="11820606"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="11820606"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 03:27:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="1095362252"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="1095362252"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2023 03:27:10 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1m8p-000AOy-1u;
        Sat, 11 Nov 2023 11:27:07 +0000
Date:   Sat, 11 Nov 2023 19:26:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH v6 12/20] sched: Fix runtime accounting w/ split exec &
 sched contexts
Message-ID: <202311111917.FfLLB7kQ-lkp@intel.com>
References: <20231106193524.866104-13-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106193524.866104-13-jstultz@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on v6.6]
[cannot apply to tip/sched/core tip/master linus/master tip/auto-latest next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Stultz/sched-Unify-runtime-accounting-across-classes/20231107-033946
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20231106193524.866104-13-jstultz%40google.com
patch subject: [PATCH v6 12/20] sched: Fix runtime accounting w/ split exec & sched contexts
config: x86_64-randconfig-121-20231111 (https://download.01.org/0day-ci/archive/20231111/202311111917.FfLLB7kQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111917.FfLLB7kQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111917.FfLLB7kQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/sched/fair.c:1116:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *running @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:1116:49: sparse:     expected struct task_struct *running
   kernel/sched/fair.c:1116:49: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:1145:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:1145:36: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:1145:36: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:1191:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity const *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:1191:32: sparse:     expected struct sched_entity const *se
   kernel/sched/fair.c:1191:32: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:8053:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:8053:36: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:8053:36: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:8086:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:8086:37: sparse:     expected struct task_struct *tsk
   kernel/sched/fair.c:8086:37: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:8333:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:8333:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:8333:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:6369:35: sparse: sparse: marked inline, but without a definition
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2344:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2166:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct *
   kernel/sched/sched.h:2166:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct *

vim +1116 kernel/sched/fair.c

  1102	
  1103	static s64 update_curr_se(struct rq *rq, struct sched_entity *se)
  1104	{
  1105		u64 now = rq_clock_task(rq);
  1106		s64 delta_exec;
  1107	
  1108		/* Calculate the delta from selected se */
  1109		delta_exec = now - se->exec_start;
  1110		if (unlikely(delta_exec <= 0))
  1111			return delta_exec;
  1112	
  1113		/* Update selected se's exec_start */
  1114		se->exec_start = now;
  1115		if (entity_is_task(se)) {
> 1116			struct task_struct *running = rq->curr;
  1117			/*
  1118			 * If se is a task, we account the time
  1119			 * against the running task, as w/ proxy-exec
  1120			 * they may not be the same.
  1121			 */
  1122			running->se.exec_start = now;
  1123			running->se.sum_exec_runtime += delta_exec;
  1124		} else {
  1125			/* If not task, account the time against se */
  1126			se->sum_exec_runtime += delta_exec;
  1127		}
  1128	
  1129		if (schedstat_enabled()) {
  1130			struct sched_statistics *stats;
  1131	
  1132			stats = __schedstats_from_se(se);
  1133			__schedstat_set(stats->exec_max,
  1134					max(delta_exec, stats->exec_max));
  1135		}
  1136	
  1137		return delta_exec;
  1138	}
  1139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
