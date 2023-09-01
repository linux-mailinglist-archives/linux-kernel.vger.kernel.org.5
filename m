Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96EC78F6E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 04:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345788AbjIACBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 22:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjIACBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 22:01:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D46E6E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 19:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693533688; x=1725069688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f+hcZwHqRipBmdIzwSiRguqreWh93XOxbhp1GVY9748=;
  b=DfcFTVatDadUKgZS+rYCR+YqnwKodGMUbsiMc+gI6bJhNjB1dP55ZioN
   NNecMqtaj80slcKUt5ycLYFMQmJaUeZIPUKLt6YdgLYbkk+1IQpjmiXEm
   33zb6NbL6rny+SrE2jP1Lv61BK4vQGb5qizsmh5EsAFL7q6v8cNg4MufF
   Qii+cQ2qjJK6wzayHPOeCKehL1cerajnA6Ew/kCgcRUQMwwBRigHiwV1/
   E5HUopYb6iGU3oWEp/OoMcu+FFabxPritKfk5vWjOckCFfujbagIifknU
   ZWDZhvd9+2zvDLg5I4p3tbc7uavTLDZHqzgH60vvtyApanMPE0Y3YM8W9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373510782"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="373510782"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 19:01:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="739764209"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="739764209"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2023 19:01:18 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbtTH-0000l3-1x;
        Fri, 01 Sep 2023 02:01:15 +0000
Date:   Fri, 1 Sep 2023 10:01:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, bristot@kernel.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v4 7/7] sched/fair: Fair server interface
Message-ID: <202309010917.ryl6BbIf-lkp@intel.com>
References: <db775d65b18ddac4a75faad6761c6c2abf3efb78.1693510979.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db775d65b18ddac4a75faad6761c6c2abf3efb78.1693510979.git.bristot@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on tip/master linus/master next-20230831]
[cannot apply to tip/auto-latest v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Bristot-de-Oliveira/sched-Unify-runtime-accounting-across-classes/20230901-043307
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/db775d65b18ddac4a75faad6761c6c2abf3efb78.1693510979.git.bristot%40kernel.org
patch subject: [PATCH v4 7/7] sched/fair: Fair server interface
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230901/202309010917.ryl6BbIf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230901/202309010917.ryl6BbIf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309010917.ryl6BbIf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:73:
>> kernel/sched/debug.c:386:56: warning: integer overflow in expression of type 'long int' results in '-100663296' [-Woverflow]
     386 | static unsigned int fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
         |                                                        ^
>> kernel/sched/debug.c:491:6: warning: no previous prototype for 'debugfs_fair_server_init' [-Wmissing-prototypes]
     491 | void debugfs_fair_server_init(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


vim +386 kernel/sched/debug.c

   385	
 > 386	static unsigned int fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
   387	static unsigned int fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
   388	
   389	static ssize_t
   390	sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
   391				       size_t cnt, loff_t *ppos)
   392	{
   393		long cpu = (long) ((struct seq_file *) filp->private_data)->private;
   394		struct rq *rq = cpu_rq(cpu);
   395		unsigned long flags;
   396		u64 period;
   397		int err;
   398	
   399		err = kstrtoull_from_user(ubuf, cnt, 10, &period);
   400		if (err)
   401			return err;
   402	
   403		if (period < fair_server_period_min || period > fair_server_period_max)
   404			return -EINVAL;
   405	
   406		raw_spin_rq_lock_irqsave(rq, flags);
   407		if (period < rq->fair_server.dl_runtime)
   408			err = -EINVAL;
   409		else
   410			rq->fair_server.dl_period = period;
   411		raw_spin_rq_unlock_irqrestore(rq, flags);
   412	
   413		if (err)
   414			return err;
   415	
   416		*ppos += cnt;
   417		return cnt;
   418	}
   419	
   420	static int sched_fair_server_period_show(struct seq_file *m, void *v)
   421	{
   422		unsigned long cpu = (unsigned long) m->private;
   423		struct rq *rq = cpu_rq(cpu);
   424	
   425		seq_printf(m, "%llu\n", rq->fair_server.dl_period);
   426		return 0;
   427	}
   428	
   429	static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
   430	{
   431		return single_open(filp, sched_fair_server_period_show, inode->i_private);
   432	}
   433	
   434	static const struct file_operations fair_server_period_fops = {
   435		.open		= sched_fair_server_period_open,
   436		.write		= sched_fair_server_period_write,
   437		.read		= seq_read,
   438		.llseek		= seq_lseek,
   439		.release	= single_release,
   440	};
   441	
   442	static ssize_t
   443	sched_fair_server_defer_write(struct file *filp, const char __user *ubuf,
   444				      size_t cnt, loff_t *ppos)
   445	{
   446		long cpu = (long) ((struct seq_file *) filp->private_data)->private;
   447		struct rq *rq = cpu_rq(cpu);
   448		unsigned long flags;
   449		u64 defer;
   450		int err;
   451	
   452		err = kstrtoull_from_user(ubuf, cnt, 10, &defer);
   453		if (err)
   454			return err;
   455	
   456		if (defer < 0 || defer > 1)
   457			return -EINVAL;
   458	
   459		raw_spin_rq_lock_irqsave(rq, flags);
   460		rq->fair_server_defer = defer;
   461		raw_spin_rq_unlock_irqrestore(rq, flags);
   462	
   463		*ppos += cnt;
   464		return cnt;
   465	}
   466	
   467	static int sched_fair_server_defer_show(struct seq_file *m, void *v)
   468	{
   469		unsigned long cpu = (unsigned long) m->private;
   470		struct rq *rq = cpu_rq(cpu);
   471	
   472		seq_printf(m, "%d\n", rq->fair_server_defer);
   473		return 0;
   474	}
   475	
   476	static int sched_fair_server_defer_open(struct inode *inode, struct file *filp)
   477	{
   478		return single_open(filp, sched_fair_server_defer_show, inode->i_private);
   479	}
   480	
   481	static const struct file_operations fair_server_defer_fops = {
   482		.open		= sched_fair_server_defer_open,
   483		.write		= sched_fair_server_defer_write,
   484		.read		= seq_read,
   485		.llseek		= seq_lseek,
   486		.release	= single_release,
   487	};
   488	
   489	static struct dentry *debugfs_sched;
   490	
 > 491	void debugfs_fair_server_init(void)
   492	{
   493		long cpu;
   494		struct dentry *rq_dentry;
   495	
   496		rq_dentry = debugfs_create_dir("rq", debugfs_sched);
   497		if (!rq_dentry)
   498			return;
   499	
   500		for_each_possible_cpu(cpu) {
   501			struct dentry *d_cpu;
   502			char buf[32];
   503	
   504			snprintf(buf, sizeof(buf), "cpu%ld", cpu);
   505			d_cpu = debugfs_create_dir(buf, rq_dentry);
   506	
   507			debugfs_create_file("fair_server_runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);
   508			debugfs_create_file("fair_server_period", 0644, d_cpu, (void *) cpu, &fair_server_period_fops);
   509			debugfs_create_file("fair_server_defer", 0644, d_cpu, (void *) cpu, &fair_server_defer_fops);
   510		}
   511	}
   512	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
