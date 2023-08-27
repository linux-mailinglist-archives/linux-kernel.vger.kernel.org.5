Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D3B789D0B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjH0Kr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjH0KrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:47:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9DE139;
        Sun, 27 Aug 2023 03:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693133218; x=1724669218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sDDzkQzb757ene7HMEX/SXvVxG8zNuK5WjwaRpDHGik=;
  b=aKQ1zVQcuj+9vDYqaBLgdsrsLh/oDO/rXaUWHH4SxRs92nSncx2mzDxm
   CvMcYdEenn24CXVkkeTmD6wxyW9Q70cB4xGijUKMsWir8m246sDN0xBdj
   hhFUYD0eW6QlWL9fdtqPh2tsnoHJ5r1vvlsaFiwswT3+GEIxL1S5x8UHf
   iot7eO7hf/MrP8PmLsZhFN2/mY2m5bNoc6Q6WJHqeNsfrV0LGa4gAA8/H
   Gz7RbCM7Yiod0vP6g2OVLPMOhQI1OPEcwsxH840wu/LwpWkmMoGb8nqim
   j/qy9MeWj6eQciU2rXBf5gONXd9Mi46/C0dR8rUjsPCjkOpW/uYDJf8Ny
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="359926531"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="359926531"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 03:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="731527841"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="731527841"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 27 Aug 2023 03:46:54 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaDI9-0005hL-2I;
        Sun, 27 Aug 2023 10:46:50 +0000
Date:   Sun, 27 Aug 2023 18:46:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Nam Cao <namcaov@gmail.com>
Subject: Re: [PATCH] riscv: Only consider swbp/ss handlers for correct
 privileged mode
Message-ID: <202308271841.HlnnHFL7-lkp@intel.com>
References: <20230827083949.204927-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230827083949.204927-1-bjorn@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Björn,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7d2f353b2682dcfe5f9bc71e5b61d5b61770d98e]

url:    https://github.com/intel-lab-lkp/linux/commits/Bj-rn-T-pel/riscv-Only-consider-swbp-ss-handlers-for-correct-privileged-mode/20230827-164313
base:   7d2f353b2682dcfe5f9bc71e5b61d5b61770d98e
patch link:    https://lore.kernel.org/r/20230827083949.204927-1-bjorn%40kernel.org
patch subject: [PATCH] riscv: Only consider swbp/ss handlers for correct privileged mode
config: riscv-randconfig-001-20230827 (https://download.01.org/0day-ci/archive/20230827/202308271841.HlnnHFL7-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230827/202308271841.HlnnHFL7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308271841.HlnnHFL7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:49:
   In file included from include/linux/kprobes.h:32:
>> arch/riscv/include/asm/kprobes.h:44:62: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
      44 | static inline bool kprobe_breakpoint_handler(struct pt_regs *)
         |                                                              ^
   arch/riscv/include/asm/kprobes.h:49:63: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
      49 | static inline bool kprobe_single_step_handler(struct pt_regs *)
         |                                                               ^
   kernel/sched/core.c:3695:20: warning: unused function 'rq_has_pinned_tasks' [-Wunused-function]
    3695 | static inline bool rq_has_pinned_tasks(struct rq *rq)
         |                    ^
   kernel/sched/core.c:5821:20: warning: unused function 'sched_tick_start' [-Wunused-function]
    5821 | static inline void sched_tick_start(int cpu) { }
         |                    ^
   kernel/sched/core.c:5822:20: warning: unused function 'sched_tick_stop' [-Wunused-function]
    5822 | static inline void sched_tick_stop(int cpu) { }
         |                    ^
   kernel/sched/core.c:6522:20: warning: unused function 'sched_core_cpu_starting' [-Wunused-function]
    6522 | static inline void sched_core_cpu_starting(unsigned int cpu) {}
         |                    ^
   kernel/sched/core.c:6523:20: warning: unused function 'sched_core_cpu_deactivate' [-Wunused-function]
    6523 | static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
         |                    ^
   kernel/sched/core.c:6524:20: warning: unused function 'sched_core_cpu_dying' [-Wunused-function]
    6524 | static inline void sched_core_cpu_dying(unsigned int cpu) {}
         |                    ^
   8 warnings generated.


vim +44 arch/riscv/include/asm/kprobes.h

    38	
    39	void arch_remove_kprobe(struct kprobe *p);
    40	int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
    41	bool kprobe_breakpoint_handler(struct pt_regs *regs);
    42	bool kprobe_single_step_handler(struct pt_regs *regs);
    43	#else
  > 44	static inline bool kprobe_breakpoint_handler(struct pt_regs *)
    45	{
    46		return false;
    47	}
    48	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
