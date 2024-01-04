Return-Path: <linux-kernel+bounces-16160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CACB8239EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30631F26201
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8716CA5F;
	Thu,  4 Jan 2024 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8Dddwex"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0624C60
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 00:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704329896; x=1735865896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kuPO/ygUFhOPX+r28k8ARKm1znELW4OW2JdTkaViLuw=;
  b=k8DddwexBBLdvU8wBVJ8LicC3/SRe5zqz1P6uTvCdCLYEv6MmHHrUpJv
   udOHLfbWBIbs0luNDcrW1ySmwb0KI4rUVpK6xn60zopyL9+yFwXrCsZ80
   x3QWJTkDtyn3fWl5mpADwlUcZ/rqliDoyyHHQQfyhXSEzYLBEfGKbHuZ0
   hb803n3zaQD8CI4hCNYV9GWM9ypZaMmS63GGTx+npHz5d9/Nm30zMc1Nf
   QtoRqvm60kNEDGC1OoKI6r7Fh9TVJl9mmPXreL7S3ZGFxBV+FM7F/xNEs
   WNY38aMH6Wbz/iunhzdDh/FZ73a9mJ4eNNf1tj3jWu94JEn2PA2NqVjg8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="3909467"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="3909467"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 16:58:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="773304508"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="773304508"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Jan 2024 16:58:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLC3l-000Mjy-2E;
	Thu, 04 Jan 2024 00:58:09 +0000
Date: Thu, 4 Jan 2024 08:57:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Wiesner <jwiesner@suse.de>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <202401040837.eAbo53gs-lkp@intel.com>
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
config: i386-randconfig-r071-20240104 (https://download.01.org/0day-ci/archive/20240104/202401040837.eAbo53gs-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401040837.eAbo53gs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401040837.eAbo53gs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/time/clocksource.c:486:27: warning: overflow in expression; result is -1978561024 with type 'long' [-Winteger-overflow]
     486 |                 if (unlikely(interval > WATCHDOG_INTR_MAX_NS)) {
         |                                         ^
   kernel/time/clocksource.c:103:6: note: expanded from macro 'WATCHDOG_INTR_MAX_NS'
     103 |                                  * NSEC_PER_SEC / HZ)
         |                                  ^
   1 warning generated.


vim +/long +486 kernel/time/clocksource.c

   400	
   401	
   402	static void clocksource_watchdog(struct timer_list *unused)
   403	{
   404		u64 csnow, wdnow, cslast, wdlast, delta;
   405		int next_cpu, reset_pending;
   406		int64_t wd_nsec, cs_nsec, interval;
   407		struct clocksource *cs;
   408		enum wd_read_status read_ret;
   409		unsigned long extra_wait = 0;
   410		u32 md;
   411	
   412		spin_lock(&watchdog_lock);
   413		if (!watchdog_running)
   414			goto out;
   415	
   416		reset_pending = atomic_read(&watchdog_reset_pending);
   417	
   418		list_for_each_entry(cs, &watchdog_list, wd_list) {
   419	
   420			/* Clocksource already marked unstable? */
   421			if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
   422				if (finished_booting)
   423					schedule_work(&watchdog_work);
   424				continue;
   425			}
   426	
   427			read_ret = cs_watchdog_read(cs, &csnow, &wdnow);
   428	
   429			if (read_ret == WD_READ_UNSTABLE) {
   430				/* Clock readout unreliable, so give it up. */
   431				__clocksource_unstable(cs);
   432				continue;
   433			}
   434	
   435			/*
   436			 * When WD_READ_SKIP is returned, it means the system is likely
   437			 * under very heavy load, where the latency of reading
   438			 * watchdog/clocksource is very big, and affect the accuracy of
   439			 * watchdog check. So give system some space and suspend the
   440			 * watchdog check for 5 minutes.
   441			 */
   442			if (read_ret == WD_READ_SKIP) {
   443				/*
   444				 * As the watchdog timer will be suspended, and
   445				 * cs->last could keep unchanged for 5 minutes, reset
   446				 * the counters.
   447				 */
   448				clocksource_reset_watchdog();
   449				extra_wait = HZ * 300;
   450				break;
   451			}
   452	
   453			/* Clocksource initialized ? */
   454			if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
   455			    atomic_read(&watchdog_reset_pending)) {
   456				cs->flags |= CLOCK_SOURCE_WATCHDOG;
   457				cs->wd_last = wdnow;
   458				cs->cs_last = csnow;
   459				continue;
   460			}
   461	
   462			delta = clocksource_delta(wdnow, cs->wd_last, watchdog->mask);
   463			wd_nsec = clocksource_cyc2ns(delta, watchdog->mult,
   464						     watchdog->shift);
   465	
   466			delta = clocksource_delta(csnow, cs->cs_last, cs->mask);
   467			cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
   468			wdlast = cs->wd_last; /* save these in case we print them */
   469			cslast = cs->cs_last;
   470			cs->cs_last = csnow;
   471			cs->wd_last = wdnow;
   472	
   473			if (atomic_read(&watchdog_reset_pending))
   474				continue;
   475	
   476			/*
   477			 * The processing of timer softirqs can get delayed (usually
   478			 * on account of ksoftirqd not getting to run in a timely
   479			 * manner), which causes the watchdog interval to stretch.
   480			 * Some clocksources, e.g. acpi_pm, cannot tolerate
   481			 * watchdog intervals longer than a few seconds.
   482			 * Skew detection may fail for longer watchdog intervals
   483			 * on account of fixed margins being used.
   484			 */
   485			interval = max(cs_nsec, wd_nsec);
 > 486			if (unlikely(interval > WATCHDOG_INTR_MAX_NS)) {
   487				if (system_state > SYSTEM_SCHEDULING &&
   488				    interval > 2 * watchdog_max_intr) {
   489					watchdog_max_intr = interval;
   490					pr_warn("Skipping watchdog check: cs_nsec: %lld wd_nsec: %lld\n",
   491						cs_nsec, wd_nsec);
   492				}
   493				watchdog_timer.expires = jiffies;
   494				continue;
   495			}
   496	
   497			/* Check the deviation from the watchdog clocksource. */
   498			md = cs->uncertainty_margin + watchdog->uncertainty_margin;
   499			if (abs(cs_nsec - wd_nsec) > md) {
   500				s64 cs_wd_msec;
   501				s64 wd_msec;
   502				u32 wd_rem;
   503	
   504				pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
   505					smp_processor_id(), cs->name);
   506				pr_warn("                      '%s' wd_nsec: %lld wd_now: %llx wd_last: %llx mask: %llx\n",
   507					watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
   508				pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %llx mask: %llx\n",
   509					cs->name, cs_nsec, csnow, cslast, cs->mask);
   510				cs_wd_msec = div_s64_rem(cs_nsec - wd_nsec, 1000 * 1000, &wd_rem);
   511				wd_msec = div_s64_rem(wd_nsec, 1000 * 1000, &wd_rem);
   512				pr_warn("                      Clocksource '%s' skewed %lld ns (%lld ms) over watchdog '%s' interval of %lld ns (%lld ms)\n",
   513					cs->name, cs_nsec - wd_nsec, cs_wd_msec, watchdog->name, wd_nsec, wd_msec);
   514				if (curr_clocksource == cs)
   515					pr_warn("                      '%s' is current clocksource.\n", cs->name);
   516				else if (curr_clocksource)
   517					pr_warn("                      '%s' (not '%s') is current clocksource.\n", curr_clocksource->name, cs->name);
   518				else
   519					pr_warn("                      No current clocksource.\n");
   520				__clocksource_unstable(cs);
   521				continue;
   522			}
   523	
   524			if (cs == curr_clocksource && cs->tick_stable)
   525				cs->tick_stable(cs);
   526	
   527			if (!(cs->flags & CLOCK_SOURCE_VALID_FOR_HRES) &&
   528			    (cs->flags & CLOCK_SOURCE_IS_CONTINUOUS) &&
   529			    (watchdog->flags & CLOCK_SOURCE_IS_CONTINUOUS)) {
   530				/* Mark it valid for high-res. */
   531				cs->flags |= CLOCK_SOURCE_VALID_FOR_HRES;
   532	
   533				/*
   534				 * clocksource_done_booting() will sort it if
   535				 * finished_booting is not set yet.
   536				 */
   537				if (!finished_booting)
   538					continue;
   539	
   540				/*
   541				 * If this is not the current clocksource let
   542				 * the watchdog thread reselect it. Due to the
   543				 * change to high res this clocksource might
   544				 * be preferred now. If it is the current
   545				 * clocksource let the tick code know about
   546				 * that change.
   547				 */
   548				if (cs != curr_clocksource) {
   549					cs->flags |= CLOCK_SOURCE_RESELECT;
   550					schedule_work(&watchdog_work);
   551				} else {
   552					tick_clock_notify();
   553				}
   554			}
   555		}
   556	
   557		/*
   558		 * We only clear the watchdog_reset_pending, when we did a
   559		 * full cycle through all clocksources.
   560		 */
   561		if (reset_pending)
   562			atomic_dec(&watchdog_reset_pending);
   563	
   564		/*
   565		 * Cycle through CPUs to check if the CPUs stay synchronized
   566		 * to each other.
   567		 */
   568		next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
   569		if (next_cpu >= nr_cpu_ids)
   570			next_cpu = cpumask_first(cpu_online_mask);
   571	
   572		/*
   573		 * Arm timer if not already pending: could race with concurrent
   574		 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
   575		 */
   576		if (!timer_pending(&watchdog_timer)) {
   577			watchdog_timer.expires += WATCHDOG_INTERVAL + extra_wait;
   578			add_timer_on(&watchdog_timer, next_cpu);
   579		}
   580	out:
   581		spin_unlock(&watchdog_lock);
   582	}
   583	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

