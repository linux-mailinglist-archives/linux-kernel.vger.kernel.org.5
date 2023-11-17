Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9587EF80A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjKQTve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjKQTvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:51:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17380D75
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700250689; x=1731786689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yTxmtNEZC638iRDw+CuND0SC/pliVjKHtJoEC5MSOj0=;
  b=lg2b2bVDly0VI3O+bjhu6+KNKQ12ldqhoVoAwc+wM8+XF98PBZI73fcy
   /qqT9qQw9sHXcxiBuD8DW+wJXDsQhZVESdIYyKMXrCNoovt+HVfgyro07
   1MSLVosqsZZkbz8U/aQPaYCHQvVuvIeZrbkEjsj4U8qtwl0ROYP67NIq1
   KWKXuNAQGA5Vaz1NLyr5pWhuuUJjVK4Paor8W9/B6NLP3VyVvlCWMUQd5
   cgWEXzpKEeYu9q3xPkd1rEvbIH8khvLf88OY9VCQr8As5lI0cUrw1JO4C
   iy8IRJBHek4V0oaFU11IkppbfGm94TPRdv3js8ebzR3LqI31YSZ2oMzj9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="457859778"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="457859778"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 11:51:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="13586975"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 17 Nov 2023 11:51:25 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r44s6-00035j-1I;
        Fri, 17 Nov 2023 19:51:22 +0000
Date:   Sat, 18 Nov 2023 03:50:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: fix incorrect cpustat[CPUTIME_FORCEIDLE]
 update
Message-ID: <202311180359.AFGF0rnk-lkp@intel.com>
References: <20231117125624.16745-1-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117125624.16745-1-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cruz,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cruz-Zhao/sched-core-fix-incorrect-cpustat-CPUTIME_FORCEIDLE-update/20231117-205845
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20231117125624.16745-1-CruzZhao%40linux.alibaba.com
patch subject: [PATCH] sched/core: fix incorrect cpustat[CPUTIME_FORCEIDLE] update
config: x86_64-buildonly-randconfig-004-20231118 (https://download.01.org/0day-ci/archive/20231118/202311180359.AFGF0rnk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311180359.AFGF0rnk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311180359.AFGF0rnk-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:52:
   kernel/sched/cputime.c: In function '__account_forceidle_time':
>> kernel/sched/cputime.c:247:41: error: 'index' undeclared (first use in this function)
     247 |         cgroup_account_cputime_field(p, index, tmp);
         |                                         ^~~~~
   kernel/sched/cputime.c:247:41: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/sched/cputime.c:247:48: error: 'tmp' undeclared (first use in this function); did you mean 'tms'?
     247 |         cgroup_account_cputime_field(p, index, tmp);
         |                                                ^~~
         |                                                tms


vim +/index +247 kernel/sched/cputime.c

   232	
   233	
   234	#ifdef CONFIG_SCHED_CORE
   235	/*
   236	 * Account for forceidle time due to core scheduling.
   237	 *
   238	 * REQUIRES: schedstat is enabled.
   239	 */
   240	void __account_forceidle_time(struct task_struct *p, u64 delta)
   241	{
   242		unsigned int cpu = task_cpu(p);
   243	
   244		__schedstat_add(p->stats.core_forceidle_sum, delta);
   245	
   246		kcpustat_cpu(cpu).cpustat[CPUTIME_FORCEIDLE] += delta;
 > 247		cgroup_account_cputime_field(p, index, tmp);
   248	}
   249	#endif
   250	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
