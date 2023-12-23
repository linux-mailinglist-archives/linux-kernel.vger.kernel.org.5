Return-Path: <linux-kernel+bounces-10329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EED81D2D0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68665B22B2E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0257C6FD7;
	Sat, 23 Dec 2023 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6h5MHP4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C58F56
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703315171; x=1734851171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QGkzxEg8js+36dWHINWFxuQNLBNir00DHutmA1XCpyY=;
  b=C6h5MHP4Aa3dPoEpDCUtRS/eGTDR1nNiHLhfBQvCNshrYX3SMSym5TmA
   +ATUEFUCThV0DREd7KnMBf5+yV71QHKgOVroZbtVj6A+3OPZesttLCl0C
   kX11T/409hTpeNAe+uiUGyg5LKgNrgyB/lzz6ODPOdr9zuYHzmtWb0FE0
   JekXrVvBOes6ypA7tIWYW3uVeSVp755qPJFFhi87qUKf4M3vmD2vbTVeW
   grSc8MepB3sZ7KgYx/8IBwqs8w1C1E8EAHr6kt1Jgb5HIVopQ98ZjtQU+
   3TvidH6fMBiDsjeE6HzxKtpEwHJ0tEN9GPC16dJLsIwVW+Sh5Vwihcx4v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="460516031"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="460516031"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 23:06:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="18971630"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 22 Dec 2023 23:06:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGw5A-000AOo-0R;
	Sat, 23 Dec 2023 07:06:03 +0000
Date: Sat, 23 Dec 2023 15:04:54 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	imran.f.khan@oracle.com, aaron.lu@intel.com,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Fix tg->load when offlining a CPU
Message-ID: <202312231446.A3g5SiOr-lkp@intel.com>
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
config: arc-defconfig (https://download.01.org/0day-ci/archive/20231223/202312231446.A3g5SiOr-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312231446.A3g5SiOr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312231446.A3g5SiOr-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'rq_offline_fair':
>> kernel/sched/fair.c:12498:9: error: implicit declaration of function 'clear_tg_offline_cfs_rqs'; did you mean 'unthrottle_offline_cfs_rqs'? [-Werror=implicit-function-declaration]
   12498 |         clear_tg_offline_cfs_rqs(rq);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         unthrottle_offline_cfs_rqs
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:13124:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
   13124 | void free_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:13126:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
   13126 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:13131:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
   13131 | void online_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:13133:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
   13133 | void unregister_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +12498 kernel/sched/fair.c

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

