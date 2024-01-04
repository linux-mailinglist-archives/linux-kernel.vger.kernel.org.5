Return-Path: <linux-kernel+bounces-16156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF28239D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EE9288166
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF313FC8;
	Thu,  4 Jan 2024 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XN7hCTsq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0642564
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704329235; x=1735865235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q6XIzXOlMGohkMeKaFYAtgJiPUwhzK4lW758krf4mzM=;
  b=XN7hCTsqSJNTHHy8MjIGomU5QS2ANaTXvjv4dp2EeA2eaWex3j0mby61
   Qjsk5oMLeeFJ5u7+P4L9SpGOVat2GUt3V0+aCfM5tYmjivtpTyBSo+jw+
   v+E5CyMzC13ajtHVl1b5SdbX3hiDIrhq4ZmcegvsuoNWQfqIgeMkxaKpA
   /C8iM5rEgupMPTFTSVUuy+RRC6IP/r7jN5JXHT/fQ3ZnKUro3Xzg+o2n4
   Kwtvy5ESiZPKqQNMTp795TBW8REyAqNnG89eD3J5IcN3nu8UBDaE0w8iw
   QokFDchTX6GyHUJDCSNNPEKV7UWbEalr8cLB2pujgPoXE3Vk4cXfQBYun
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="394240125"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="394240125"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 16:47:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="903606869"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="903606869"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Jan 2024 16:47:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLBt7-000Miu-0R;
	Thu, 04 Jan 2024 00:47:09 +0000
Date: Thu, 4 Jan 2024 08:46:57 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Wiesner <jwiesner@suse.de>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <202401040845.lHig8Ei0-lkp@intel.com>
References: <20240103112113.GA6108@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103112113.GA6108@incl>

Hi Jiri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on linus/master v6.7-rc8 next-20240103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Wiesner/clocksource-Skip-watchdog-check-for-large-watchdog-intervals/20240103-192257
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20240103112113.GA6108%40incl
patch subject: [PATCH] clocksource: Skip watchdog check for large watchdog intervals
config: i386-buildonly-randconfig-001-20240104 (https://download.01.org/0day-ci/archive/20240104/202401040845.lHig8Ei0-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401040845.lHig8Ei0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401040845.lHig8Ei0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/dev_printk.h:14:0,
                    from include/linux/device.h:15,
                    from kernel/time/clocksource.c:10:
   kernel/time/clocksource.c: In function 'clocksource_watchdog':
>> kernel/time/clocksource.c:103:6: warning: integer overflow in expression [-Woverflow]
         * NSEC_PER_SEC / HZ)
         ^
   include/linux/compiler.h:77:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
   kernel/time/clocksource.c:486:27: note: in expansion of macro 'WATCHDOG_INTR_MAX_NS'
      if (unlikely(interval > WATCHDOG_INTR_MAX_NS)) {
                              ^~~~~~~~~~~~~~~~~~~~


vim +103 kernel/time/clocksource.c

    97	
    98	/*
    99	 * Interval: 0.5sec.
   100	 */
   101	#define WATCHDOG_INTERVAL	(HZ >> 1)
   102	#define WATCHDOG_INTR_MAX_NS	((WATCHDOG_INTERVAL + (WATCHDOG_INTERVAL >> 1))\
 > 103					 * NSEC_PER_SEC / HZ)
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

