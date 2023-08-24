Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48917786E13
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbjHXLfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241193AbjHXLfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:35:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F212115
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692876882; x=1724412882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CrnoNF/qGMXjiWOVC2r0bJQWdRM/pmr5B5MUn/sQ93Q=;
  b=Jg2knqxIQx5Wlbfay/W6Sr2MWdBqe3Sm5MxrcZyUeYkBgsiS2Ltv7Ruo
   kMDaKbMHNxnUvO3BRnUeIAIShwfNdjddYll4IdsxDOKwRNSNLYkMv0xju
   ISSFqvUysV1oW2b3dAGGaA9VHkxCkvp1Mas9iQRjCU5Re2MfC1sJUqhDr
   HOSNY/sLo/3CmV0h541mKnP3lWdpCOUZ5tLbFULzwfQUquM4hFVXj71Dv
   3viY0DYGu1s+6oWuq2N3PrFfWG+waZUQBBV8r4mpQNLl0ll/+/Wgc4oWd
   /UFksm9UuUyO587gsQP/8o60KPoXXYn1gjXIyuu0prPd4xWzcoRUsWLLt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="460771723"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="460771723"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:34:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880770237"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 04:34:39 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZ8be-0001zY-0M;
        Thu, 24 Aug 2023 11:34:30 +0000
Date:   Thu, 24 Aug 2023 19:34:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v5 15/19] sched: Add proxy deactivate helper
Message-ID: <202308241905.goxohVDL-lkp@intel.com>
References: <20230819060915.3001568-16-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819060915.3001568-16-jstultz@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on linus/master tip/auto-latest v6.5-rc7]
[cannot apply to tip/sched/core tip/master next-20230824]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Stultz/sched-Unify-runtime-accounting-across-classes/20230821-121604
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20230819060915.3001568-16-jstultz%40google.com
patch subject: [PATCH v5 15/19] sched: Add proxy deactivate helper
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230824/202308241905.goxohVDL-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230824/202308241905.goxohVDL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308241905.goxohVDL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/sched/core.c:6565:6: warning: no previous prototype for 'try_to_deactivate_task' [-Wmissing-prototypes]
    6565 | bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/core.c:6603:6: warning: no previous prototype for 'proxy_deactivate' [-Wmissing-prototypes]
    6603 | bool proxy_deactivate(struct rq *rq, struct task_struct *next)
         |      ^~~~~~~~~~~~~~~~


vim +/proxy_deactivate +6603 kernel/sched/core.c

  6564	
> 6565	bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
  6566				    unsigned long state, bool deactivate_cond)
  6567	{
  6568		if (signal_pending_state(state, p)) {
  6569			WRITE_ONCE(p->__state, TASK_RUNNING);
  6570		} else if (deactivate_cond) {
  6571			p->sched_contributes_to_load =
  6572				(state & TASK_UNINTERRUPTIBLE) &&
  6573				!(state & TASK_NOLOAD) &&
  6574				!(state & TASK_FROZEN);
  6575	
  6576			if (p->sched_contributes_to_load)
  6577				rq->nr_uninterruptible++;
  6578	
  6579			/*
  6580			 * __schedule()			ttwu()
  6581			 *   prev_state = prev->state;    if (p->on_rq && ...)
  6582			 *   if (prev_state)		    goto out;
  6583			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
  6584			 *				  p->state = TASK_WAKING
  6585			 *
  6586			 * Where __schedule() and ttwu() have matching control dependencies.
  6587			 *
  6588			 * After this, schedule() must not care about p->state any more.
  6589			 */
  6590			deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
  6591	
  6592			if (p->in_iowait) {
  6593				atomic_inc(&rq->nr_iowait);
  6594				delayacct_blkio_start();
  6595			}
  6596			return true;
  6597		}
  6598		return false;
  6599	}
  6600	
  6601	#ifdef CONFIG_PROXY_EXEC
  6602	
> 6603	bool proxy_deactivate(struct rq *rq, struct task_struct *next)
  6604	{
  6605		unsigned long state = READ_ONCE(next->__state);
  6606	
  6607		/* Don't deactivate if the state has been changed to TASK_RUNNING */
  6608		if (!state)
  6609			return false;
  6610		if (!try_to_deactivate_task(rq, next, state, true))
  6611			return false;
  6612		put_prev_task(rq, next);
  6613		rq_set_selected(rq, rq->idle);
  6614		resched_curr(rq);
  6615		return true;
  6616	}
  6617	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
