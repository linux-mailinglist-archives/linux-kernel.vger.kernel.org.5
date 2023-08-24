Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C81786434
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 02:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbjHXAB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 20:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbjHXAB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 20:01:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9021910E4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 17:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692835285; x=1724371285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nhyqneDoLJjZ/M+Loz6bMRFomtPYuD47bFXLTP1ffc0=;
  b=CANAgcWrKv0+Mf05SatpLjPCycT+HFXYqY9xbLkqIpy0x8DfQl8Xllls
   CYQdkGN7lg+LAz8S8ZLYLK6nfpm5S8WM8Wm6vb3XS2+5TXN36TP2Oxp3y
   pRAgSq9uf6rQLIk3S31LBCjWbIri9YHxHZo5B+QJGfx9L4OMAuiZsvu5O
   fxA3NIY0AYAV8mVcvIBFHqw/3+XFT5QCLRzA0FMVNCZjRgrjLLRQjgU/L
   xxWJlap3gjbmBkef9V+v5N22ryITFKOKjmAD9XVCd+Ieg2kZvY0z7Vv2q
   mwuKvxhtWFab34xe+dtSX9B9DILpGHTYodlHXDIOVYwwkQIotYkqhockT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="364477166"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364477166"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 17:01:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="771905331"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="771905331"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 23 Aug 2023 17:01:16 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYxmm-0001bA-16;
        Thu, 24 Aug 2023 00:01:16 +0000
Date:   Thu, 24 Aug 2023 08:00:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        John Stultz <jstultz@google.com>,
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
Message-ID: <202308240712.RzqTiO81-lkp@intel.com>
References: <20230819060915.3001568-14-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819060915.3001568-14-jstultz@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20230824/202308240712.RzqTiO81-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230824/202308240712.RzqTiO81-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308240712.RzqTiO81-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:9:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from kernel/sched/core.c:9:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/sched/core.c:9:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> kernel/sched/core.c:6565:6: warning: no previous prototype for function 'try_to_deactivate_task' [-Wmissing-prototypes]
    6565 | bool try_to_deactivate_task(struct rq *rq, struct task_struct *p, unsigned long state)
         |      ^
   kernel/sched/core.c:6565:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    6565 | bool try_to_deactivate_task(struct rq *rq, struct task_struct *p, unsigned long state)
         | ^
         | static 
   kernel/sched/core.c:3697:20: warning: unused function 'rq_has_pinned_tasks' [-Wunused-function]
    3697 | static inline bool rq_has_pinned_tasks(struct rq *rq)
         |                    ^
   kernel/sched/core.c:5834:20: warning: unused function 'sched_tick_start' [-Wunused-function]
    5834 | static inline void sched_tick_start(int cpu) { }
         |                    ^
   kernel/sched/core.c:5835:20: warning: unused function 'sched_tick_stop' [-Wunused-function]
    5835 | static inline void sched_tick_stop(int cpu) { }
         |                    ^
   kernel/sched/core.c:6535:20: warning: unused function 'sched_core_cpu_starting' [-Wunused-function]
    6535 | static inline void sched_core_cpu_starting(unsigned int cpu) {}
         |                    ^
   kernel/sched/core.c:6536:20: warning: unused function 'sched_core_cpu_deactivate' [-Wunused-function]
    6536 | static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
         |                    ^
   kernel/sched/core.c:6537:20: warning: unused function 'sched_core_cpu_dying' [-Wunused-function]
    6537 | static inline void sched_core_cpu_dying(unsigned int cpu) {}
         |                    ^
   19 warnings generated.


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
