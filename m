Return-Path: <linux-kernel+bounces-1997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 643F18156D2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1478B24287
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71FC23D4;
	Sat, 16 Dec 2023 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlsddIeC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C8535263
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702697283; x=1734233283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vbBASBiJaH4THpMtwHkToEZ+1eMr/8HKB5TNd5kuKi0=;
  b=PlsddIeCQUFLNasBUTOVp8F87Siew7dCbxvvbKCKyt9WCmkoQIoYFWkk
   n2rCbeOMZvmdID9+TE+A2HDjbo+o9DjqYOYF+QyPH98cdVjavW3P7lZx0
   nS93M3zLN9K1tlrjomzq9hYGbNSzu7I00ulrIQ0cOB6Hmxm79N91plCK5
   mOXEFggWjih700k/lA18uJPxLxK68iuMRCBMT2mTIm09cUFUuhoS2cqnX
   Wlz5ozZKfkdemGnLxrkoJerewL+6bZJRmL1Wu5UEg1HpNa0wuynloo9B+
   YiQeW56qO0dEDIW84yuMG9RT89GRSdeFeH/0/by+o6ynsbGOQR2VreYCP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="8712139"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="8712139"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 19:28:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="1106321452"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="1106321452"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Dec 2023 19:27:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rELLI-00016E-2j;
	Sat, 16 Dec 2023 03:27:56 +0000
Date: Sat, 16 Dec 2023 11:27:36 +0800
From: kernel test robot <lkp@intel.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>,
	linux-kernel@vger.kernel.org, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davydov-max@yandex-team.ru,
	den-plotnikov@yandex-team.ru, tony.luck@intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH] x86/split_lock: add split lock counter
Message-ID: <202312161122.4Y1qkw0S-lkp@intel.com>
References: <20231215140113.57173-1-davydov-max@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215140113.57173-1-davydov-max@yandex-team.ru>

Hi Maksim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on tip/master tip/sched/core linus/master tip/auto-latest v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maksim-Davydov/x86-split_lock-add-split-lock-counter/20231215-220639
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20231215140113.57173-1-davydov-max%40yandex-team.ru
patch subject: [PATCH] x86/split_lock: add split lock counter
config: um-defconfig (https://download.01.org/0day-ci/archive/20231216/202312161122.4Y1qkw0S-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161122.4Y1qkw0S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161122.4Y1qkw0S-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/proc/base.c:101:
>> arch/x86/include/asm/cpu.h:36:31: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
      36 | int mwait_usable(const struct cpuinfo_x86 *);
         |                               ^~~~~~~~~~~
   arch/x86/include/asm/cpu.h:42:37: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
      42 | extern void __init sld_setup(struct cpuinfo_x86 *c);
         |                                     ^~~~~~~~~~~
   arch/x86/include/asm/cpu.h:85:32: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
      85 | void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
         |                                ^~~~~~~~~~~


vim +36 arch/x86/include/asm/cpu.h

bb6e89df9028b2 Thomas Gleixner        2022-04-15  35  
1c9d16e3591109 Borislav Petkov        2011-02-11 @36  int mwait_usable(const struct cpuinfo_x86 *);
6d652ea1d05639 Jaswinder Singh Rajput 2009-01-07  37  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

