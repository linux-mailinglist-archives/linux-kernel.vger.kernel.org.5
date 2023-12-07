Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC2380930C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443953AbjLGVHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjLGVGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:06:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D2F1716;
        Thu,  7 Dec 2023 13:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701983218; x=1733519218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dT5XsiaCZuIH5AbEKio7zI1H/A2Yq9DciOqCzZLbQFY=;
  b=g8xtsn4MBaLNBvmn7Zkm0XHzHGG5O0XKYQwwWzrXBkRBkPvcHSY3eTJw
   YZpPdcDJVa/PXmhzGsZf0AwPYrUOHILQF/5JoiID/BWsN6CsM4sKipx+3
   xn/hpydgj1Pw+i9jdncSwkmJxSb6qS7rlHTplkHBUXok81EncfIuYVH3n
   WcZSH53oDgV9YVHKk6olxspHfm6IUJN6xHxRYjhmTglitc7Ae1lWJU/Ou
   HPi/OQd5vpr7DaAoketBIrnnfiYn6I+XTclKoxWLMC44t3AWysl7rjLn0
   1cJA4PvPE7Qv4qe2IQWGQxabjNobn7pF2krtbpsQTpkDi+YR0MPtGWhgV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1184015"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1184015"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 13:06:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="19848139"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 07 Dec 2023 13:06:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBLa8-000CpJ-1m;
        Thu, 07 Dec 2023 21:06:52 +0000
Date:   Fri, 8 Dec 2023 05:06:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>, rafael@kernel.org,
        pavel@ucw.cz, len.brown@intel.com, peterz@infradead.org,
        mingo@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] freezer,sched: Move state information judgment outside
 task_call_func
Message-ID: <202312080436.VRc5l7Yc-lkp@intel.com>
References: <20231207111634.667057-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207111634.667057-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaolei,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc4 next-20231207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaolei-Wang/freezer-sched-Move-state-information-judgment-outside-task_call_func/20231207-191924
base:   linus/master
patch link:    https://lore.kernel.org/r/20231207111634.667057-1-xiaolei.wang%40windriver.com
patch subject: [PATCH] freezer,sched: Move state information judgment outside task_call_func
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231208/202312080436.VRc5l7Yc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312080436.VRc5l7Yc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080436.VRc5l7Yc-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/freezer.c: In function '__set_task_frozen':
>> kernel/freezer.c:125:35: error: 'struct task_struct' has no member named 'lockdep_depth'
     125 |         p_check->lockdep_depth = p->lockdep_depth;
         |                                   ^~


vim +125 kernel/freezer.c

   107	
   108	static int __set_task_frozen(struct task_struct *p, void *arg)
   109	{
   110		unsigned int state = READ_ONCE(p->__state);
   111		struct task_freeze_check *p_check = arg;
   112	
   113		if (p->on_rq)
   114			return 0;
   115	
   116		if (p != current && task_curr(p))
   117			return 0;
   118	
   119		if (!(state & (TASK_FREEZABLE | __TASK_STOPPED | __TASK_TRACED)))
   120			return 0;
   121	
   122		p->saved_state = p->__state;
   123		WRITE_ONCE(p->__state, TASK_FROZEN);
   124		p_check->state = p->__state;
 > 125		p_check->lockdep_depth = p->lockdep_depth;
   126		return TASK_FROZEN;
   127	}
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
