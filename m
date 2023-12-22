Return-Path: <linux-kernel+bounces-10123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CFE81D08D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944DD285A28
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6063B364CC;
	Fri, 22 Dec 2023 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRC6qPnw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECED036091
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703288487; x=1734824487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BKjLPR1XFtYzZGRa6QjbRckx/IglWwU8GkTNRWNre7k=;
  b=fRC6qPnwPxfL1f74qO4G5MgsncXFFkqFeQa19ZjGUHYffi48BAwm/HLx
   wkmYopZgZkvSKw0r8rRMTh10qy/5iFYZ/rCBlbT04xtmdRWM76E8G5NhJ
   YDQZR57CsoJdNm/aW1FigvoPdhFklOzAxH7Xl+3esn8vWKpT6WfJB5kv4
   Eov3J+J8/J7UlBw4xhHuHvDnx4c8llF2CcwgaVYgmRD5aIJjQbo4OkmmK
   86UoX737CojlfOOc+0BhXFAFGLbW7GhEkBJjMabeiIVdmOSqGBdZtFg0e
   tCo9D5wZM5f9QYsB8sLhrGhl6Ytx9TgOKByNuiY3EObvFqVw9aXpCvmLP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="482347685"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="482347685"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:41:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="806114428"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="806114428"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 22 Dec 2023 15:41:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGp8m-000A0Q-1m;
	Fri, 22 Dec 2023 23:41:18 +0000
Date: Sat, 23 Dec 2023 07:39:31 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	imran.f.khan@oracle.com, aaron.lu@intel.com,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Fix tg->load when offlining a CPU
Message-ID: <202312230731.vxFaJB7G-lkp@intel.com>
References: <20231221164014.447122-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221164014.447122-1-vincent.guittot@linaro.org>

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on peterz-queue/sched/core linus/master v6.7-rc6 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Guittot/sched-Fix-tg-load-when-offlining-a-CPU/20231222-172438
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20231221164014.447122-1-vincent.guittot%40linaro.org
patch subject: [PATCH] sched: Fix tg->load when offlining a CPU
config: hexagon-defconfig (https://download.01.org/0day-ci/archive/20231223/202312230731.vxFaJB7G-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project d3ef86708241a3bee902615c190dead1638c4e09)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312230731.vxFaJB7G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312230731.vxFaJB7G-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/fair.c:28:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from kernel/sched/fair.c:28:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/sched/fair.c:28:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> kernel/sched/fair.c:12498:2: error: call to undeclared function 'clear_tg_offline_cfs_rqs'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    12498 |         clear_tg_offline_cfs_rqs(rq);
          |         ^
   kernel/sched/fair.c:12498:2: note: did you mean 'unthrottle_offline_cfs_rqs'?
   kernel/sched/fair.c:6620:20: note: 'unthrottle_offline_cfs_rqs' declared here
    6620 | static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
         |                    ^
   kernel/sched/fair.c:13124:6: warning: no previous prototype for function 'free_fair_sched_group' [-Wmissing-prototypes]
    13124 | void free_fair_sched_group(struct task_group *tg) { }
          |      ^
   kernel/sched/fair.c:13124:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    13124 | void free_fair_sched_group(struct task_group *tg) { }
          | ^
          | static 
   kernel/sched/fair.c:13126:5: warning: no previous prototype for function 'alloc_fair_sched_group' [-Wmissing-prototypes]
    13126 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
          |     ^
   kernel/sched/fair.c:13126:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    13126 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
          | ^
          | static 
   kernel/sched/fair.c:13131:6: warning: no previous prototype for function 'online_fair_sched_group' [-Wmissing-prototypes]
    13131 | void online_fair_sched_group(struct task_group *tg) { }
          |      ^
   kernel/sched/fair.c:13131:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    13131 | void online_fair_sched_group(struct task_group *tg) { }
          | ^
          | static 
   kernel/sched/fair.c:13133:6: warning: no previous prototype for function 'unregister_fair_sched_group' [-Wmissing-prototypes]
    13133 | void unregister_fair_sched_group(struct task_group *tg) { }
          |      ^
   kernel/sched/fair.c:13133:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    13133 | void unregister_fair_sched_group(struct task_group *tg) { }
          | ^
          | static 
   10 warnings and 1 error generated.


vim +/clear_tg_offline_cfs_rqs +12498 kernel/sched/fair.c

 12489	
 12490	static void rq_offline_fair(struct rq *rq)
 12491	{
 12492		update_sysctl();
 12493	
 12494		/* Ensure any throttled groups are reachable by pick_next_task */
 12495		unthrottle_offline_cfs_rqs(rq);
 12496	
 12497		/* Ensure that we remove rq contribution to group share */
 12498		clear_tg_offline_cfs_rqs(rq);
 12499	}
 12500	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

