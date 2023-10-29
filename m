Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDA57DABF4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 11:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjJ2KGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 06:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2KGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 06:06:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BABBB0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698573963; x=1730109963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=22IFjif+Zaay2bxS/UIgYdVCPDzNfUS2BDcTun2d/kY=;
  b=WdM/tIsqlpvQO5cflpyW/nMQISGyjoED2eCuFKdXwsX3QjsiCnIsCDOp
   8y6sDbuOF5vh3vqkcEfYtpXYSuNvrlyj62Pd2txeOGc0O0ZAgoTLl6ZD5
   jjEZFdo9ISix7HJOBeH9sQI+mTVEGroSHblfgS8FA2x9b+gLlzn67o3Ob
   wAfJWmoBU3XDkVZMzG0clJNUXjpCQcPVcip7Ny6+oFQ2iw8LRr8tqAnjU
   CYQi5Y8gzYTP0XJPCZ9LJVfH/52aicKn7tiJ74MR6F5dCL/nDJPOjSEBj
   cBu27dJCQGf3xOv5Q/gJe22Fc8KsxpxOOkq96Qz10CQwRnHcvzMZZHVAu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="6573438"
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="6573438"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 03:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="753534148"
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="753534148"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Oct 2023 03:05:56 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qx2g6-000CTl-18;
        Sun, 29 Oct 2023 10:05:54 +0000
Date:   Sun, 29 Oct 2023 18:05:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2] lockdep: add lockdep_cleanup_dead_cpu()
Message-ID: <202310291748.ld6JE1m3-lkp@intel.com>
References: <635fa006e8f3816b4a36b964d6281f0d8efa789b.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635fa006e8f3816b4a36b964d6281f0d8efa789b.camel@infradead.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/smp/core]
[also build test WARNING on tip/locking/core linus/master v6.6-rc7 next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Woodhouse/lockdep-add-lockdep_cleanup_dead_cpu/20231029-032722
base:   tip/smp/core
patch link:    https://lore.kernel.org/r/635fa006e8f3816b4a36b964d6281f0d8efa789b.camel%40infradead.org
patch subject: [PATCH v2] lockdep: add lockdep_cleanup_dead_cpu()
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231029/202310291748.ld6JE1m3-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231029/202310291748.ld6JE1m3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310291748.ld6JE1m3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from init/init_task.c:2:
   In file included from include/linux/init_task.h:5:
   In file included from include/linux/rcupdate.h:26:
>> include/linux/irqflags.h:36:19: warning: declaration of 'struct task_struct' will not be visible outside of this function [-Wvisibility]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^
   In file included from init/init_task.c:2:
   In file included from include/linux/init_task.h:9:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
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
   In file included from init/init_task.c:2:
   In file included from include/linux/init_task.h:9:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
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
   In file included from init/init_task.c:2:
   In file included from include/linux/init_task.h:9:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
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
   13 warnings generated.
--
   In file included from arch/um/kernel/reboot.c:6:
   In file included from include/linux/sched/signal.h:5:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:26:
>> include/linux/irqflags.h:36:19: warning: declaration of 'struct task_struct' will not be visible outside of this function [-Wvisibility]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^
   arch/um/kernel/reboot.c:45:6: warning: no previous prototype for function 'machine_restart' [-Wmissing-prototypes]
      45 | void machine_restart(char * __unused)
         |      ^
   arch/um/kernel/reboot.c:45:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      45 | void machine_restart(char * __unused)
         | ^
         | static 
   arch/um/kernel/reboot.c:51:6: warning: no previous prototype for function 'machine_power_off' [-Wmissing-prototypes]
      51 | void machine_power_off(void)
         |      ^
   arch/um/kernel/reboot.c:51:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      51 | void machine_power_off(void)
         | ^
         | static 
   arch/um/kernel/reboot.c:57:6: warning: no previous prototype for function 'machine_halt' [-Wmissing-prototypes]
      57 | void machine_halt(void)
         |      ^
   arch/um/kernel/reboot.c:57:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      57 | void machine_halt(void)
         | ^
         | static 
   4 warnings generated.
--
   In file included from arch/um/kernel/early_printk.c:7:
   In file included from include/linux/console.h:19:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:26:
>> include/linux/irqflags.h:36:19: warning: declaration of 'struct task_struct' will not be visible outside of this function [-Wvisibility]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^
   1 warning generated.
--
   In file included from kernel/irq_work.c:12:
   In file included from include/linux/irq_work.h:6:
   In file included from include/linux/rcuwait.h:5:
   In file included from include/linux/rcupdate.h:26:
>> include/linux/irqflags.h:36:19: warning: declaration of 'struct task_struct' will not be visible outside of this function [-Wvisibility]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^
   In file included from kernel/irq_work.c:14:
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
   In file included from kernel/irq_work.c:14:
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
   In file included from kernel/irq_work.c:14:
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
   kernel/irq_work.c:72:13: warning: no previous prototype for function 'arch_irq_work_raise' [-Wmissing-prototypes]
      72 | void __weak arch_irq_work_raise(void)
         |             ^
   kernel/irq_work.c:72:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      72 | void __weak arch_irq_work_raise(void)
         | ^
         | static 
   14 warnings generated.
--
   In file included from lib/maple_tree.c:54:
   In file included from include/linux/maple_tree.h:12:
   In file included from include/linux/rcupdate.h:26:
>> include/linux/irqflags.h:36:19: warning: declaration of 'struct task_struct' will not be visible outside of this function [-Wvisibility]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^
   lib/maple_tree.c:331:21: warning: unused function 'mte_set_full' [-Wunused-function]
     331 | static inline void *mte_set_full(const struct maple_enode *node)
         |                     ^
   lib/maple_tree.c:336:21: warning: unused function 'mte_clear_full' [-Wunused-function]
     336 | static inline void *mte_clear_full(const struct maple_enode *node)
         |                     ^
   lib/maple_tree.c:341:20: warning: unused function 'mte_has_null' [-Wunused-function]
     341 | static inline bool mte_has_null(const struct maple_enode *node)
         |                    ^
   lib/maple_tree.c:672:29: warning: unused function 'mas_pivot' [-Wunused-function]
     672 | static inline unsigned long mas_pivot(struct ma_state *mas, unsigned char piv)
         |                             ^
   lib/maple_tree.c:4319:20: warning: stack frame size (1064) exceeds limit (1024) in 'mas_wr_modify' [-Wframe-larger-than]
    4319 | static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
         |                    ^
   6 warnings generated.


vim +36 include/linux/irqflags.h

    19	
    20	/* Currently lockdep_softirqs_on/off is used only by lockdep */
    21	#ifdef CONFIG_PROVE_LOCKING
    22	  extern void lockdep_softirqs_on(unsigned long ip);
    23	  extern void lockdep_softirqs_off(unsigned long ip);
    24	  extern void lockdep_hardirqs_on_prepare(void);
    25	  extern void lockdep_hardirqs_on(unsigned long ip);
    26	  extern void lockdep_hardirqs_off(unsigned long ip);
    27	  extern void lockdep_cleanup_dead_cpu(unsigned int cpu,
    28					       struct task_struct *idle);
    29	#else
    30	  static inline void lockdep_softirqs_on(unsigned long ip) { }
    31	  static inline void lockdep_softirqs_off(unsigned long ip) { }
    32	  static inline void lockdep_hardirqs_on_prepare(void) { }
    33	  static inline void lockdep_hardirqs_on(unsigned long ip) { }
    34	  static inline void lockdep_hardirqs_off(unsigned long ip) { }
    35	  static inline void lockdep_cleanup_dead_cpu(unsigned int cpu,
  > 36						      struct task_struct *idle) {}
    37	#endif
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
