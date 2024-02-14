Return-Path: <linux-kernel+bounces-64782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16568542C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BFC286DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28E411701;
	Wed, 14 Feb 2024 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZE0FCLB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF13111AD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707891921; cv=none; b=f/jHzX4xYW3SLIsGJD38kzjjQQif/OFtF+e1z2+dC+zNrYiqrTYnvYVlkfp67SNVIy9YNIjC6NOVMyE0RBSrqISB35UNXlpvkV5Sx8b3/o0RctdVhdG21rPDBGDjWl6q6kcoywS5juppDhKsb5EnAKBWpx44CrtS5pr8CQGmOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707891921; c=relaxed/simple;
	bh=JCLQwyKKczURua+OeVxn90sXLdCKa2iAwXHB5Pscyns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rmyf7OLoyt5E7a6PWccCsWy2FhYflkIZL9ynK7lQYKQ4oPdWPSTSZqKhkNMY2d1GPYcY2W4rd4XIaZSNAb+cAMS+0Po3UqH7kvyw2SbBBum2APXur0vZvC8wtfNwCGNK9gtTeWU93BOPXdhXdpdpZvghCvOznezxeaDtwYvGjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZE0FCLB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707891919; x=1739427919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JCLQwyKKczURua+OeVxn90sXLdCKa2iAwXHB5Pscyns=;
  b=EZE0FCLBlKpUzc3X7S9cQGf3i7qGTFNM3hfyBmDJJSdBx2azdm7UPFJ1
   K2K3qY6uldVPczV1Wv3tz7ELdhrA1yr4XnFcEGv8GX9qQLbDo3gN2Lj5H
   3i7oHbvQ/IqVPHXxRivaIcOPImA/KIB9sZJilp0G+apIfdvfzJeZ8mpWa
   B9Ju3IvH/7SVPeiijf3ZLCj1H2DP/o1/yx/H9fbpmYHXCvukMwDtqXAnV
   leEPrqjiIpzjb0C5cwl2YKK3L3kEN+IKtolB1DGxXl8Mo74IfwgyMhf3q
   AgeSp2Cd5CpTrGYf2iAHtR7ODeb0Hrfb2lo8H374XHXu434yQKcFqlGJz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1794453"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1794453"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 22:25:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7754944"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Feb 2024 22:25:16 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ra8hm-0008XA-09;
	Wed, 14 Feb 2024 06:25:14 +0000
Date: Wed, 14 Feb 2024 14:24:25 +0800
From: kernel test robot <lkp@intel.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [tip:timers/core 3/3] kernel/time/hrtimer.c:2224:56: error: implicit
 declaration of function 'housekeeping'
Message-ID: <202402141402.ktGAGpFN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
head:   86342554e102b0d18d50abec43d40f4fc92f1993
commit: 86342554e102b0d18d50abec43d40f4fc92f1993 [3/3] hrtimer: Select housekeeping CPU during migration
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240214/202402141402.ktGAGpFN-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402141402.ktGAGpFN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402141402.ktGAGpFN-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/time/hrtimer.c:120:35: warning: initialized field overwritten [-Woverride-init]
     120 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:120:35: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
   kernel/time/hrtimer.c:121:35: warning: initialized field overwritten [-Woverride-init]
     121 |         [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:35: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
   kernel/time/hrtimer.c:122:35: warning: initialized field overwritten [-Woverride-init]
     122 |         [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:35: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
   kernel/time/hrtimer.c:123:35: warning: initialized field overwritten [-Woverride-init]
     123 |         [CLOCK_TAI]             = HRTIMER_BASE_TAI,
         |                                   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:35: note: (near initialization for 'hrtimer_clock_to_base_table[11]')
   In file included from arch/loongarch/include/asm/processor.h:9,
                    from arch/loongarch/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:6,
                    from ./arch/loongarch/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from kernel/time/hrtimer.c:25:
   kernel/time/hrtimer.c: In function 'hrtimers_cpu_dying':
>> kernel/time/hrtimer.c:2224:56: error: implicit declaration of function 'housekeeping' [-Werror=implicit-function-declaration]
    2224 |         int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
         |                                                        ^~~~~~~~~~~~
   include/linux/cpumask.h:774:67: note: in definition of macro 'cpumask_any_and'
     774 | #define cpumask_any_and(mask1, mask2) cpumask_first_and((mask1), (mask2))
         |                                                                   ^~~~~
>> kernel/time/hrtimer.c:2224:69: error: 'HK_TYPE_TIMER' undeclared (first use in this function)
    2224 |         int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
         |                                                                     ^~~~~~~~~~~~~
   include/linux/cpumask.h:774:67: note: in definition of macro 'cpumask_any_and'
     774 | #define cpumask_any_and(mask1, mask2) cpumask_first_and((mask1), (mask2))
         |                                                                   ^~~~~
   kernel/time/hrtimer.c:2224:69: note: each undeclared identifier is reported only once for each function it appears in
    2224 |         int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
         |                                                                     ^~~~~~~~~~~~~
   include/linux/cpumask.h:774:67: note: in definition of macro 'cpumask_any_and'
     774 | #define cpumask_any_and(mask1, mask2) cpumask_first_and((mask1), (mask2))
         |                                                                   ^~~~~
   cc1: some warnings being treated as errors


vim +/housekeeping +2224 kernel/time/hrtimer.c

  2221	
  2222	int hrtimers_cpu_dying(unsigned int dying_cpu)
  2223	{
> 2224		int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
  2225		struct hrtimer_cpu_base *old_base, *new_base;
  2226	
  2227		tick_cancel_sched_timer(dying_cpu);
  2228	
  2229		old_base = this_cpu_ptr(&hrtimer_bases);
  2230		new_base = &per_cpu(hrtimer_bases, ncpu);
  2231	
  2232		/*
  2233		 * The caller is globally serialized and nobody else
  2234		 * takes two locks at once, deadlock is not possible.
  2235		 */
  2236		raw_spin_lock(&old_base->lock);
  2237		raw_spin_lock_nested(&new_base->lock, SINGLE_DEPTH_NESTING);
  2238	
  2239		for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
  2240			migrate_hrtimer_list(&old_base->clock_base[i],
  2241					     &new_base->clock_base[i]);
  2242		}
  2243	
  2244		/*
  2245		 * The migration might have changed the first expiring softirq
  2246		 * timer on this CPU. Update it.
  2247		 */
  2248		__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
  2249		/* Tell the other CPU to retrigger the next event */
  2250		smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
  2251	
  2252		raw_spin_unlock(&new_base->lock);
  2253		raw_spin_unlock(&old_base->lock);
  2254	
  2255		return 0;
  2256	}
  2257	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

