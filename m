Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79187DBE17
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjJ3Qik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjJ3Qij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:38:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA239B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698683914; x=1730219914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u6SqUiu0FM2kijlI3g60j+zFLDRgvLuLUPiDCHbJ84U=;
  b=LK/R4bGNxR2S8+gV6Xoyo7ho6CFLukJslMnWoOjq70JO7Fci4MZwG/Ok
   8HKOCIZRFh12eUcokVFv6f8ktlwSVc6ZTMMx8jybynz3Rl1joOwwU/ol6
   qgaVWtkhmItgyetM5v4ncLS6X6cOyLJZ9orvkm1CUEQ/07ly724AY15ar
   pRPEVvpHKRuCnuBDcdRPONqFoWNHVibGhKE0ie9DgZBCBN7+PVq8U3/NI
   iGPvzSsbiKIfiYudzQik2vMPAxsereiRkubLwGUUpav3nov652TgITuAr
   xuD9cWlIvNO8qgrNx/zrWauYEoqK10gT4YLLKhfflZwkSEgjpfzCG8ng0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="454576145"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="454576145"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 09:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789509061"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="789509061"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2023 09:38:13 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxVHG-000DPv-12;
        Mon, 30 Oct 2023 16:38:10 +0000
Date:   Tue, 31 Oct 2023 00:37:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2] lockdep: add lockdep_cleanup_dead_cpu()
Message-ID: <202310310038.MkdWejfv-lkp@intel.com>
References: <635fa006e8f3816b4a36b964d6281f0d8efa789b.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635fa006e8f3816b4a36b964d6281f0d8efa789b.camel@infradead.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/smp/core]
[also build test ERROR on tip/locking/core linus/master v6.6 next-20231030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Woodhouse/lockdep-add-lockdep_cleanup_dead_cpu/20231029-032722
base:   tip/smp/core
patch link:    https://lore.kernel.org/r/635fa006e8f3816b4a36b964d6281f0d8efa789b.camel%40infradead.org
patch subject: [PATCH v2] lockdep: add lockdep_cleanup_dead_cpu()
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20231031/202310310038.MkdWejfv-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310310038.MkdWejfv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310310038.MkdWejfv-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_64.h:52,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:22,
                    from arch/sparc/kernel/unaligned_64.c:12:
>> include/linux/irqflags.h:36:54: error: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_64.h:52,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from arch/sparc/kernel/adi_64.c:10:
>> include/linux/irqflags.h:36:54: error: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^~~~~~~~~~~
   arch/sparc/kernel/adi_64.c:124:21: error: no previous prototype for 'find_tag_store' [-Werror=missing-prototypes]
     124 | tag_storage_desc_t *find_tag_store(struct mm_struct *mm,
         |                     ^~~~~~~~~~~~~~
   arch/sparc/kernel/adi_64.c:156:21: error: no previous prototype for 'alloc_tag_store' [-Werror=missing-prototypes]
     156 | tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
         |                     ^~~~~~~~~~~~~~~
   arch/sparc/kernel/adi_64.c:299:6: error: no previous prototype for 'del_tag_store' [-Werror=missing-prototypes]
     299 | void del_tag_store(tag_storage_desc_t *tag_desc, struct mm_struct *mm)
         |      ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_64.h:52,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:22,
                    from arch/sparc/kernel/pcr.c:6:
>> include/linux/irqflags.h:36:54: error: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^~~~~~~~~~~
   arch/sparc/kernel/pcr.c:47:6: error: no previous prototype for 'arch_irq_work_raise' [-Werror=missing-prototypes]
      47 | void arch_irq_work_raise(void)
         |      ^~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from include/linux/moduleloader.h:6,
                    from arch/sparc/kernel/module.c:8:
>> include/linux/irqflags.h:36:54: error: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^~~~~~~~~~~
   arch/sparc/kernel/module.c: In function 'module_frob_arch_sections':
   arch/sparc/kernel/module.c:62:15: error: variable 'strtab' set but not used [-Werror=unused-but-set-variable]
      62 |         char *strtab;
         |               ^~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_64.h:52,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:22,
                    from arch/sparc/kernel/pci_sun4v.c:7:
>> include/linux/irqflags.h:36:54: error: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^~~~~~~~~~~
   arch/sparc/kernel/pci_sun4v.c:258:15: error: no previous prototype for 'dma_4v_iotsb_bind' [-Werror=missing-prototypes]
     258 | unsigned long dma_4v_iotsb_bind(unsigned long devhandle,
         |               ^~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_64.h:52,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:22,
                    from arch/sparc/kernel/uprobes.c:12:
>> include/linux/irqflags.h:36:54: error: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^~~~~~~~~~~
   arch/sparc/kernel/uprobes.c:237:17: error: no previous prototype for 'uprobe_trap' [-Werror=missing-prototypes]
     237 | asmlinkage void uprobe_trap(struct pt_regs *regs,
         |                 ^~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_64.h:52,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:22,
                    from include/linux/sched/mm.h:5,
                    from arch/sparc/kernel/traps_64.c:13:
>> include/linux/irqflags.h:36:54: error: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^~~~~~~~~~~
   arch/sparc/kernel/traps_64.c:252:6: error: no previous prototype for 'is_no_fault_exception' [-Werror=missing-prototypes]
     252 | bool is_no_fault_exception(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/sparc/kernel/traps_64.c:2034:6: error: no previous prototype for 'do_mcd_err' [-Werror=missing-prototypes]
    2034 | void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
         |      ^~~~~~~~~~
   arch/sparc/kernel/traps_64.c:2152:6: error: no previous prototype for 'sun4v_nonresum_error_user_handled' [-Werror=missing-prototypes]
    2152 | bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/sparc/kernel/traps_64.c:2839:13: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
    2839 | void __init trap_init(void)
         |             ^~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_64.h:52,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27,
                    from arch/sparc/include/asm/current.h:15,
                    from include/linux/sched.h:12,
                    from arch/sparc/kernel/setup_64.c:10:
>> include/linux/irqflags.h:36:54: error: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^~~~~~~~~~~
   arch/sparc/kernel/setup_64.c:615:13: error: no previous prototype for 'alloc_irqstack_bootmem' [-Werror=missing-prototypes]
     615 | void __init alloc_irqstack_bootmem(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_64.h:52,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27,
                    from arch/sparc/include/asm/current.h:15,
                    from include/linux/sched.h:12,
                    from arch/sparc/kernel/time_64.c:14:
>> include/linux/irqflags.h:36:54: error: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^~~~~~~~~~~
   arch/sparc/kernel/time_64.c:880:20: error: no previous prototype for 'sched_clock' [-Werror=missing-prototypes]
     880 | unsigned long long sched_clock(void)
         |                    ^~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_64.h:52,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:22,
                    from arch/sparc/mm/init_64.c:10:
>> include/linux/irqflags.h:36:54: error: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      36 |                                               struct task_struct *idle) {}
         |                                                      ^~~~~~~~~~~
   arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
   arch/sparc/mm/init_64.c:355:24: error: variable 'hv_pgsz_idx' set but not used [-Werror=unused-but-set-variable]
     355 |         unsigned short hv_pgsz_idx;
         |                        ^~~~~~~~~~~
   arch/sparc/mm/init_64.c: At top level:
   arch/sparc/mm/init_64.c:2630:6: error: no previous prototype for 'vmemmap_free' [-Werror=missing-prototypes]
    2630 | void vmemmap_free(unsigned long start, unsigned long end,
         |      ^~~~~~~~~~~~
   cc1: all warnings being treated as errors


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
