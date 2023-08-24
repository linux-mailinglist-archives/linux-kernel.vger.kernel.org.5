Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE89786446
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 02:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbjHXAf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 20:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbjHXAfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 20:35:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8994210D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 17:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692837342; x=1724373342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fLmhUzL/MeUrvdUoqFUQx93UlfX+PWDtxxYHmtQBJ/0=;
  b=iFxTVQ0w8srU7Y1cdxNvxtz/H88dkOccDWpetiCD/llrSyZq8IP8NWIG
   +Pdh8RLExm2zyj55S8HHxqofRtMzQgVyS/VuOMa0Rx49eX05HiqUo2/1M
   OvuCFypxBpX88+7ykucCkfaTvlQPMPmmGEIAbr4Twv7k4Im1i5kZIID8w
   wls2kFExLQ0UE7Eg1984xNGBCtm358TGjHdPE7dcW+f+Qt3lLd1qTeMJh
   h5F4LJqTbYk6wf5rXeJsqi09KohK+8fqrUO3ny/+cZp/c+PvYnj60+MVK
   YPgq62Y7177QMqFzCffVqY+ax5LmN3mhJd6t9P4J3CnDoIC+xd6gVMRgB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="438237980"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438237980"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 17:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="860520213"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="860520213"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2023 17:35:36 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYyK0-0001cf-0d;
        Thu, 24 Aug 2023 00:35:36 +0000
Date:   Thu, 24 Aug 2023 08:34:57 +0800
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
Subject: Re: [PATCH v5 13/19] sched: Split out __sched() deactivate task
 logic into a helper
Message-ID: <202308240824.ugWLq8LH-lkp@intel.com>
References: <20230819060915.3001568-14-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819060915.3001568-14-jstultz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on linus/master tip/auto-latest v6.5-rc7]
[cannot apply to tip/sched/core tip/master next-20230823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Stultz/sched-Unify-runtime-accounting-across-classes/20230821-121604
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20230819060915.3001568-14-jstultz%40google.com
patch subject: [PATCH v5 13/19] sched: Split out __sched() deactivate task logic into a helper
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230824/202308240824.ugWLq8LH-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230824/202308240824.ugWLq8LH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308240824.ugWLq8LH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/sched/core.c:6565:6: warning: no previous declaration for 'try_to_deactivate_task' [-Wmissing-declarations]
    bool try_to_deactivate_task(struct rq *rq, struct task_struct *p, unsigned long state)
         ^~~~~~~~~~~~~~~~~~~~~~


vim +/try_to_deactivate_task +6565 kernel/sched/core.c

  6564	
> 6565	bool try_to_deactivate_task(struct rq *rq, struct task_struct *p, unsigned long state)
  6566	{
  6567		if (signal_pending_state(state, p)) {
  6568			WRITE_ONCE(p->__state, TASK_RUNNING);
  6569		} else {
  6570			p->sched_contributes_to_load =
  6571				(state & TASK_UNINTERRUPTIBLE) &&
  6572				!(state & TASK_NOLOAD) &&
  6573				!(state & TASK_FROZEN);
  6574	
  6575			if (p->sched_contributes_to_load)
  6576				rq->nr_uninterruptible++;
  6577	
  6578			/*
  6579			 * __schedule()			ttwu()
  6580			 *   prev_state = prev->state;    if (p->on_rq && ...)
  6581			 *   if (prev_state)		    goto out;
  6582			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
  6583			 *				  p->state = TASK_WAKING
  6584			 *
  6585			 * Where __schedule() and ttwu() have matching control dependencies.
  6586			 *
  6587			 * After this, schedule() must not care about p->state any more.
  6588			 */
  6589			deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
  6590	
  6591			if (p->in_iowait) {
  6592				atomic_inc(&rq->nr_iowait);
  6593				delayacct_blkio_start();
  6594			}
  6595			return true;
  6596		}
  6597		return false;
  6598	}
  6599	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
