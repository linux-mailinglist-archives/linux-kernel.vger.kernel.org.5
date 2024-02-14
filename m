Return-Path: <linux-kernel+bounces-64981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28CD85462C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B516B25D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A584E1947D;
	Wed, 14 Feb 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8FC5ItF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB77F134A3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903292; cv=none; b=TgT38P0l98SyfinJin6LguS+yBtfCljf9WOFAgFRT2VOgbRpsXYj5umUOdg/0YPcv22r7ZS+mPjjceUVMVAGlkoygPJJISjTB6DuRK3DPdlBXKmlntF/kqVyhn4Fj4zf/9HYdITII0UP3SigIKVO7jsuSamppj21aR9zD+b2FHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903292; c=relaxed/simple;
	bh=eWkspjNzFtYVtL67xcsvO3+T3IJryy3wrpfEPZSaC6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MZJ5diDIu/Vq1/HvZtMgNhm2cFoTIKbugz/l71kTtDQmBi7JLzHzvhBoPmGmmQNl4mchEGdIh9JXHnygdoplTIUVVvHvXGG7vrBZxbIn2NxCjNWHoK/2ZfQHE/H+22gPXoDNV5FsjeRZdt53dQefvbTTT/MpV0YzA5mMTV+SyYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8FC5ItF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707903290; x=1739439290;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eWkspjNzFtYVtL67xcsvO3+T3IJryy3wrpfEPZSaC6Q=;
  b=f8FC5ItFuk0gb4jwwnaPgyr6P9USjYSOTwhenUlFHfPMvpSlYsF16Twa
   qOGCUukrW7VRHNJ69g+fBx3juw5d0j+os+DlP9gzhC1xoblHiEYuE/BhS
   GcAEr5AOrqC6z/86Oo0MVMOXOwFfx27pyNvWT8q/rqCJu2YEKKVevX/fq
   fNNFFh81w2xx6CBSEDoUz2LQlU5rq4JhvtBw5dYIfy30pvyaMiYf+DK70
   Bue3pKTsoX0EYuCBhFiGSpkSo62Xis2fOWpBpyWgawIGuHjLYzcLgH799
   /2Rg41DTT+ckQvAAg/x4Z3PtJuO8dWfcT6vMNN7+45SA0b189q767zLY/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1848358"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1848358"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 01:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3115962"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2024 01:34:44 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1raBf7-0008dU-2i;
	Wed, 14 Feb 2024 09:34:41 +0000
Date: Wed, 14 Feb 2024 17:33:56 +0800
From: kernel test robot <lkp@intel.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [tip:timers/core 3/3] kernel/time/hrtimer.c:2224:49: error: implicit
 declaration of function 'housekeeping' is invalid in C99
Message-ID: <202402141742.oYY6J3lC-lkp@intel.com>
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240214/202402141742.oYY6J3lC-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402141742.oYY6J3lC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402141742.oYY6J3lC-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/time/hrtimer.c:1651:7: warning: variable 'expires_in_hardirq' set but not used [-Wunused-but-set-variable]
           bool expires_in_hardirq;
                ^
>> kernel/time/hrtimer.c:2224:49: error: implicit declaration of function 'housekeeping' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
                                                          ^
>> kernel/time/hrtimer.c:2224:62: error: use of undeclared identifier 'HK_TYPE_TIMER'
           int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
                                                                       ^
   1 warning and 2 errors generated.


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

