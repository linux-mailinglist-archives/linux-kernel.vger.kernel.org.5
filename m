Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0E37771C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjHJHnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjHJHnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:43:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218EA2698
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691653417; x=1723189417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dKy7mwmPFBwZ2LYDUuqKy0yI1zE3l+vLPVJsVtkZ/7o=;
  b=fPYPJ+yrNDj+SmO9oVEB2hw83N43UApT4zzt1FVCk75zzyslMLBzg48b
   QwiJ2CCu2brzoGPvzFwuBUPgyxGGkxV5iHqPj5hYstvhIW4OKoa2CnMFm
   8/YMk619Et1977ESamQ80rgPbKP6/9DbBy0Q6mIzCa+QULHWTVSCsg9ru
   hLMg8E1fOf6gabqRPVNIokZBla53BTLNH8xvnGOV4m6jCUFTDpTvidOnD
   oNHYlxisnzh6q8g/3Nl6HOmxUZtejqn4YhWstoQ+iEjUFBugVZ08aq3Yv
   vcduBbGJIdgOMqLycRSKXVwjUacDszK6epZtwWRs0/T0LOQ1SW1eKq81m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="351625937"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="351625937"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 00:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="905950466"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="905950466"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2023 00:43:03 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qU0Jy-0006pY-1o;
        Thu, 10 Aug 2023 07:43:02 +0000
Date:   Thu, 10 Aug 2023 15:41:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: Re: [PATCH v3 6/7] sched: Implement shared runqueue in CFS
Message-ID: <202308101547.1n2K9PyC-lkp@intel.com>
References: <20230809221218.163894-7-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809221218.163894-7-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[cannot apply to linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Vernet/sched-Expose-move_queued_task-from-core-c/20230810-061611
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20230809221218.163894-7-void%40manifault.com
patch subject: [PATCH v3 6/7] sched: Implement shared runqueue in CFS
config: hexagon-randconfig-r045-20230809 (https://download.01.org/0day-ci/archive/20230810/202308101547.1n2K9PyC-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230810/202308101547.1n2K9PyC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308101547.1n2K9PyC-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:9:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
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
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/sched/core.c:9:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> kernel/sched/core.c:9768:6: warning: no previous prototype for function 'sched_update_domains' [-Wmissing-prototypes]
    9768 | void sched_update_domains(void)
         |      ^
   kernel/sched/core.c:9768:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    9768 | void sched_update_domains(void)
         | ^
         | static 
   kernel/sched/core.c:2467:20: warning: unused function 'rq_has_pinned_tasks' [-Wunused-function]
    2467 | static inline bool rq_has_pinned_tasks(struct rq *rq)
         |                    ^
   kernel/sched/core.c:5818:20: warning: unused function 'sched_tick_stop' [-Wunused-function]
    5818 | static inline void sched_tick_stop(int cpu) { }
         |                    ^
   kernel/sched/core.c:6519:20: warning: unused function 'sched_core_cpu_deactivate' [-Wunused-function]
    6519 | static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
         |                    ^
   kernel/sched/core.c:6520:20: warning: unused function 'sched_core_cpu_dying' [-Wunused-function]
    6520 | static inline void sched_core_cpu_dying(unsigned int cpu) {}
         |                    ^
   kernel/sched/core.c:9570:20: warning: unused function 'balance_hotplug_wait' [-Wunused-function]
    9570 | static inline void balance_hotplug_wait(void)
         |                    ^
   12 warnings generated.
--
   In file included from kernel/sched/build_utility.c:15:
   In file included from include/linux/sched/isolation.h:6:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from kernel/sched/build_utility.c:15:
   In file included from include/linux/sched/isolation.h:6:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/sched/build_utility.c:15:
   In file included from include/linux/sched/isolation.h:6:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from kernel/sched/build_utility.c:89:
>> kernel/sched/topology.c:2580:3: error: call to undeclared function 'sched_update_domains'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2580 |                 sched_update_domains();
         |                 ^
   kernel/sched/topology.c:2746:2: error: call to undeclared function 'sched_update_domains'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2746 |         sched_update_domains();
         |         ^
   6 warnings and 2 errors generated.


vim +/sched_update_domains +2580 kernel/sched/topology.c

  2558	
  2559	/*
  2560	 * Set up scheduler domains and groups.  For now this just excludes isolated
  2561	 * CPUs, but could be used to exclude other special cases in the future.
  2562	 */
  2563	int __init sched_init_domains(const struct cpumask *cpu_map)
  2564	{
  2565		int err;
  2566	
  2567		zalloc_cpumask_var(&sched_domains_tmpmask, GFP_KERNEL);
  2568		zalloc_cpumask_var(&sched_domains_tmpmask2, GFP_KERNEL);
  2569		zalloc_cpumask_var(&fallback_doms, GFP_KERNEL);
  2570	
  2571		arch_update_cpu_topology();
  2572		asym_cpu_capacity_scan();
  2573		ndoms_cur = 1;
  2574		doms_cur = alloc_sched_domains(ndoms_cur);
  2575		if (!doms_cur)
  2576			doms_cur = &fallback_doms;
  2577		cpumask_and(doms_cur[0], cpu_map, housekeeping_cpumask(HK_TYPE_DOMAIN));
  2578		err = build_sched_domains(doms_cur[0], NULL);
  2579		if (!err)
> 2580			sched_update_domains();
  2581	
  2582		return err;
  2583	}
  2584	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
