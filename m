Return-Path: <linux-kernel+bounces-60478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D5F850572
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DA11F23795
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ED65C900;
	Sat, 10 Feb 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOU2g3ZS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C975C8E0
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583901; cv=none; b=PcCM5OSX+MqoQNSsgZF5M7jUBX8OuqBEKSnhH+oVeCvE46ZvqXxo9ElYwEm4ncQUmKoh9/2JicPR8H9/X7LDm3uYcmpazQ9BgnLKUiJku7aEkDi52rR+mwSYHuCT25KVVeGPOhK/up5N4zmCb/42uDVJ1isrELQxRyP9zXv9pas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583901; c=relaxed/simple;
	bh=YEIY1/rIwl/UaRivphA+86Ks5PinOnmYvKZCME1bB5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pdjjpi8/OPqsPTOLaeCiVHRsOf9cI9WkRdzgXVyKhWXPMnS4s3Fl4lVR2kt3vJ0le32aEbeMpfGe+lU8GNJmauH0ELon5ZsZ7hf7j1kd4PXwGBwEzaoJu14C6HoYGzXamXiwveBapd+xl6E07LoFugaZxUpzNxFir4tiLBzURTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOU2g3ZS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707583899; x=1739119899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YEIY1/rIwl/UaRivphA+86Ks5PinOnmYvKZCME1bB5c=;
  b=HOU2g3ZSwLc09KRnC8nHmD9p0y4ZiCtVpFStfc/g630rTb/x9Z+fA8MD
   jQC90KITGu+p3yfHyKOF5Nels81C6FUvGMX7XZRXX3o9DT8j5iDvcq8pf
   lurssuWuTAe9kJigEizN/HoCs385xpmqi4gH+E5yWj7F9UYbHHUZcWYsB
   v7Vnd0m89iZ6UA5t8/LBZr6MJDhJBBa7Ba93dxTrjcYerZoQ/QO0IKI6v
   /m8Do4Mw1rUouf+5lYL6G9EkeaGApZg20mtTdQBMWHMFTe4dTvTmR9Zwz
   9RvXE3W6W7A0fAcobfxhwRBpPsgMehTU1uZSAsWzSOE1qWzsG7jdtNtY3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1478828"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1478828"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 08:51:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="32983960"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Feb 2024 08:51:31 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYqZb-0005sM-2w;
	Sat, 10 Feb 2024 16:51:27 +0000
Date: Sun, 11 Feb 2024 00:51:25 +0800
From: kernel test robot <lkp@intel.com>
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>,
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
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [PATCH v8 7/7] sched: Split scheduler and execution contexts
Message-ID: <202402110009.Pd1PVwG6-lkp@intel.com>
References: <20240210002328.4126422-8-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210002328.4126422-8-jstultz@google.com>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on tip/master linus/master v6.8-rc3 next-20240209]
[cannot apply to tip/locking/core tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Stultz/locking-mutex-Remove-wakeups-from-under-mutex-wait_lock/20240210-082732
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20240210002328.4126422-8-jstultz%40google.com
patch subject: [PATCH v8 7/7] sched: Split scheduler and execution contexts
config: x86_64-randconfig-r121-20240210 (https://download.01.org/0day-ci/archive/20240211/202402110009.Pd1PVwG6-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240211/202402110009.Pd1PVwG6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402110009.Pd1PVwG6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/core.c:264:56: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:264:56: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:264:56: sparse:    struct task_struct *
   kernel/sched/core.c:796:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:796:55: sparse:     expected struct task_struct *p
   kernel/sched/core.c:796:55: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1042:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1042:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:1042:38: sparse:     got struct task_struct [noderef] __rcu *curr
>> kernel/sched/core.c:2240:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *selected @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2240:40: sparse:     expected struct task_struct *selected
   kernel/sched/core.c:2240:40: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2251:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2251:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2251:68: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:3745:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:3745:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:3745:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:3952:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:3952:36: sparse:     expected struct task_struct const *p
   kernel/sched/core.c:3952:36: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:9472:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *push_task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:9472:43: sparse:     expected struct task_struct *push_task
   kernel/sched/core.c:9472:43: sparse:     got struct task_struct [noderef] __rcu *curr
>> kernel/sched/core.c:5671:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *selected @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5671:18: sparse:     expected struct task_struct *selected
   kernel/sched/core.c:5671:18: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6315:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:6315:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:6315:32: sparse:    struct task_struct *
   kernel/sched/core.c:6346:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:6346:23: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:6346:23: sparse:    struct task_struct *
   kernel/sched/core.c:6354:46: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:6354:46: sparse:    struct task_struct *
   kernel/sched/core.c:6354:46: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:6414:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:6414:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:6414:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:6667:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6667:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6667:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:7201:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7201:17: sparse:    struct task_struct *
   kernel/sched/core.c:7201:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7416:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7416:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7416:22: sparse:    struct task_struct *
   kernel/sched/core.c:7463:48: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7463:48: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7463:48: sparse:    struct task_struct *
   kernel/sched/core.c:11505:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11505:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11505:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:338:9: sparse: sparse: context imbalance in 'sched_core_lock' - different lock contexts for basic block
   kernel/sched/core.c:348:17: sparse: sparse: context imbalance in 'sched_core_unlock' - unexpected unlock
   kernel/sched/core.c:551:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/core.c:584:23: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:600:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:1619:9: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/sched.h:1619:9: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/pelt.h:97:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/pelt.h:97:13: sparse:     expected struct task_struct const *p
   kernel/sched/pelt.h:97:13: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:796:9: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1502:13: sparse: sparse: context imbalance in 'uclamp_update_util_min_rt_default' - wrong count at exit
   kernel/sched/core.c:1834:9: sparse: sparse: context imbalance in 'uclamp_sync_util_min_rt_default' - wrong count at exit
   kernel/sched/core.c:2321:35: sparse: sparse: context imbalance in 'wait_task_inactive' - different lock contexts for basic block
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2163:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2163:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2163:32: sparse:    struct task_struct *
   kernel/sched/sched.h:2335:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct *
   kernel/sched/core.c:2215:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:2215:38: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:2215:38: sparse:    struct task_struct const *
   kernel/sched/sched.h:2163:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2163:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2163:32: sparse:    struct task_struct *
   kernel/sched/sched.h:2335:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2335:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2335:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2335:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2163:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2163:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2163:32: sparse:    struct task_struct *
   kernel/sched/sched.h:2335:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2163:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2163:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2163:32: sparse:    struct task_struct *
   kernel/sched/sched.h:2335:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2163:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2163:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2163:32: sparse:    struct task_struct *
   kernel/sched/sched.h:2335:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2335:9: sparse:    struct task_struct *
   kernel/sched/core.c: note: in included file (through arch/x86/include/asm/uaccess.h, include/linux/uaccess.h, include/linux/sched/task.h, ...):
   arch/x86/include/asm/uaccess_64.h:88:24: sparse: sparse: cast removes address space '__user' of expression
   kernel/sched/core.c:8333:5: sparse: sparse: context imbalance in 'dl_task_check_affinity' - wrong count at exit
   kernel/sched/core.c:8437:9: sparse: sparse: context imbalance in 'sched_setaffinity' - different lock contexts for basic block
   kernel/sched/core.c:8499:6: sparse: sparse: context imbalance in 'sched_getaffinity' - wrong count at exit
   kernel/sched/core.c:8662:28: sparse: sparse: context imbalance in '__cond_resched_lock' - unexpected unlock
   kernel/sched/core.c:8680:17: sparse: sparse: context imbalance in '__cond_resched_rwlock_read' - unexpected unlock
   kernel/sched/core.c:8698:17: sparse: sparse: context imbalance in '__cond_resched_rwlock_write' - unexpected unlock
   kernel/sched/core.c:11670:5: sparse: sparse: context imbalance in '__sched_mm_cid_migrate_from_fetch_cid' - different lock contexts for basic block

vim +2240 kernel/sched/core.c

  2237	
  2238	void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
  2239	{
> 2240		struct task_struct *selected = rq_selected(rq);
  2241	
  2242		if (p->sched_class == selected->sched_class)
  2243			selected->sched_class->wakeup_preempt(rq, p, flags);
  2244		else if (sched_class_above(p->sched_class, selected->sched_class))
  2245			resched_curr(rq);
  2246	
  2247		/*
  2248		 * A queue event has occurred, and we're going to schedule.  In
  2249		 * this case, we can save a useless back to back clock update.
  2250		 */
  2251		if (task_on_rq_queued(selected) && test_tsk_need_resched(rq->curr))
  2252			rq_clock_skip_update(rq);
  2253	}
  2254	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

