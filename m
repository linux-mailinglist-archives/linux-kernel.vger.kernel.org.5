Return-Path: <linux-kernel+bounces-67969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6299A8573B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1796BB2133E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBD1FBE9;
	Fri, 16 Feb 2024 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8uUU6A7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B8FBF7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049764; cv=none; b=ck3cdvs2/QLAkvY6tmE4PxMwGH0kKd9UWviXBbWH090DHFu/iE42Sg/qFbP/hXfQBPZATMB6wp+1Vg//cOlQ1CtOjD3KqAwIhJFFFWzUTnD+gBJh4i9DkiHygik9BpSBwkTCw7RmId/9bN+7mfJ0x2U7vsvLYd4qToofv+nwAp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049764; c=relaxed/simple;
	bh=/B7/cwDvy9M2TT+TON0r/UhDVdY/tJaNubLEm1GVSFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RMQl7tYYKqBT5+ij3tNKPhwZMcDw0ViM3GWcmRVJAn2AXmCWH3Io9VTXctXK/ksDIM0kXmaia+OMlymhPDgdiaQROgoj+LamTcjYCbumVHdsmZCQJhaRpU+MLz47BjOj1fomyA/ab6BC44fGRR86QgZVBDvMUhM4qZB6PZkDlvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8uUU6A7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708049760; x=1739585760;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/B7/cwDvy9M2TT+TON0r/UhDVdY/tJaNubLEm1GVSFs=;
  b=n8uUU6A70ZlRIk5I3jLQewCZeM6h2doBcwyFvrKYBwm9B6wCDWoLKBnx
   Fm2OmCFqDeIp5LUk6kBJtTxnkKlk6mANRMWOPm1TPrF/Orro2Nq3YhMWz
   yfScpA+bWMAOsRmfG1D8l8f0CoMRPWcDjvUKB3hpPiA/VhZGsSnGLuIH5
   yCB6iub4mk038FmQRFj9Kvk7pfgKFSvfjyHb6naeFXWg2jMxw/o39njXR
   smgTeNx4/2YFgVTCy8Xoipl7OZ63NgInozOHP5bWBxc8fVhifkOOIokCH
   7WekBx737XptfJOsYOMdWgw2v0lM3SxSHdDQMPxN6GjzV3IbHKyRR30TW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2079990"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="2079990"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 18:15:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="3647355"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 15 Feb 2024 18:15:57 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ranlb-0000wo-0a;
	Fri, 16 Feb 2024 02:15:55 +0000
Date: Fri, 16 Feb 2024 10:15:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240215 1/1]
 arch/powerpc/perf/core-book3s.c:2315:64: error: passing argument 3 of
 'perf_sample_save_brstack' from incompatible pointer type
Message-ID: <202402161030.MBBR7fdm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240215
head:   2b08fd9386dd05331a6f385d45ea7272536123ec
commit: 34a5c90f36e0238bfc95cda9e2eccf7e610bff1a [1/1] treewide: Address -Wflexible-array-member-not-at-end warnings
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240216/202402161030.MBBR7fdm-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240216/202402161030.MBBR7fdm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402161030.MBBR7fdm-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/perf/core-book3s.c: In function 'record_and_restart':
>> arch/powerpc/perf/core-book3s.c:2315:64: error: passing argument 3 of 'perf_sample_save_brstack' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2315 |                         perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack, NULL);
         |                                                                ^~~~~~~~~~~~~~~~~~
         |                                                                |
         |                                                                struct perf_branch_stack_tag *
   In file included from arch/powerpc/perf/core-book3s.c:10:
   include/linux/perf_event.h:1269:71: note: expected 'struct perf_branch_stack *' but argument is of type 'struct perf_branch_stack_tag *'
    1269 |                                             struct perf_branch_stack *brs,
         |                                             ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors
--
   drivers/crypto/nx/nx-842.c: In function 'nx842_crypto_compress':
>> drivers/crypto/nx/nx-842.c:254:43: error: initialization of 'struct nx842_crypto_header *' from incompatible pointer type 'struct nx842_crypto_header_tag *' [-Werror=incompatible-pointer-types]
     254 |         struct nx842_crypto_header *hdr = &ctx->header;
         |                                           ^
   drivers/crypto/nx/nx-842.c: In function 'nx842_crypto_decompress':
>> drivers/crypto/nx/nx-842.c:493:13: error: assignment to 'struct nx842_crypto_header *' from incompatible pointer type 'struct nx842_crypto_header_tag *' [-Werror=incompatible-pointer-types]
     493 |         hdr = &ctx->header;
         |             ^
   cc1: some warnings being treated as errors


vim +/perf_sample_save_brstack +2315 arch/powerpc/perf/core-book3s.c

b0a873ebbf87bf arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-06-11  2228  
4cb6a42e4c4bc1 arch/powerpc/perf/core-book3s.c    Kan Liang                  2020-10-01  2229  #define PERF_SAMPLE_ADDR_TYPE  (PERF_SAMPLE_ADDR |		\
4cb6a42e4c4bc1 arch/powerpc/perf/core-book3s.c    Kan Liang                  2020-10-01  2230  				PERF_SAMPLE_PHYS_ADDR |		\
4cb6a42e4c4bc1 arch/powerpc/perf/core-book3s.c    Kan Liang                  2020-10-01  2231  				PERF_SAMPLE_DATA_PAGE_SIZE)
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2232  /*
57c0c15b524432 arch/powerpc/kernel/perf_event.c   Ingo Molnar                2009-09-21  2233   * A counter has overflowed; update its count and record
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2234   * things if requested.  Note that interrupts are hard-disabled
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2235   * here so there is no possibility of being interrupted.
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2236   */
cdd6c482c9ff9c arch/powerpc/kernel/perf_event.c   Ingo Molnar                2009-09-21  2237  static void record_and_restart(struct perf_event *event, unsigned long val,
a8b0ca17b80e92 arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2011-06-27  2238  			       struct pt_regs *regs)
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2239  {
cdd6c482c9ff9c arch/powerpc/kernel/perf_event.c   Ingo Molnar                2009-09-21  2240  	u64 period = event->hw.sample_period;
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2241  	s64 prev, delta, left;
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2242  	int record = 0;
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2243  
a4eaf7f14675cb arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-06-16  2244  	if (event->hw.state & PERF_HES_STOPPED) {
a4eaf7f14675cb arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-06-16  2245  		write_pmc(event->hw.idx, 0);
a4eaf7f14675cb arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-06-16  2246  		return;
a4eaf7f14675cb arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-06-16  2247  	}
a4eaf7f14675cb arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-06-16  2248  
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2249  	/* we don't have to worry about interrupts here */
e78505958cf123 arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-05-21  2250  	prev = local64_read(&event->hw.prev_count);
86c74ab317c1ef arch/powerpc/kernel/perf_event.c   Eric B Munson              2011-04-15  2251  	delta = check_and_compute_delta(prev, val);
e78505958cf123 arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-05-21  2252  	local64_add(delta, &event->count);
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2253  
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2254  	/*
cdd6c482c9ff9c arch/powerpc/kernel/perf_event.c   Ingo Molnar                2009-09-21  2255  	 * See if the total period for this event has expired,
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2256  	 * and update for the next period.
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2257  	 */
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2258  	val = 0;
e78505958cf123 arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-05-21  2259  	left = local64_read(&event->hw.period_left) - delta;
e13e895f8430d8 arch/powerpc/perf/core-book3s.c    Michael Neuling            2012-11-05  2260  	if (delta == 0)
e13e895f8430d8 arch/powerpc/perf/core-book3s.c    Michael Neuling            2012-11-05  2261  		left++;
60db5e09c13109 arch/powerpc/kernel/perf_counter.c Peter Zijlstra             2009-05-15  2262  	if (period) {
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2263  		if (left <= 0) {
60db5e09c13109 arch/powerpc/kernel/perf_counter.c Peter Zijlstra             2009-05-15  2264  			left += period;
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2265  			if (left <= 0)
60db5e09c13109 arch/powerpc/kernel/perf_counter.c Peter Zijlstra             2009-05-15  2266  				left = period;
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2267  
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2268  			/*
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2269  			 * If address is not requested in the sample via
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2270  			 * PERF_SAMPLE_IP, just record that sample irrespective
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2271  			 * of SIAR valid check.
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2272  			 */
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2273  			if (event->attr.sample_type & PERF_SAMPLE_IP)
e6878835ac4794 arch/powerpc/perf/core-book3s.c    sukadev@linux.vnet.ibm.com 2012-09-18  2274  				record = siar_valid(regs);
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2275  			else
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2276  				record = 1;
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2277  
4bca770ede796a arch/powerpc/kernel/perf_event.c   Anton Blanchard            2011-01-17  2278  			event->hw.last_period = event->hw.sample_period;
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2279  		}
98fb1807b97e3e arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-06-17  2280  		if (left < 0x80000000LL)
98fb1807b97e3e arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-06-17  2281  			val = 0x80000000LL - left;
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2282  	}
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2283  
a4eaf7f14675cb arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-06-16  2284  	write_pmc(event->hw.idx, val);
a4eaf7f14675cb arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-06-16  2285  	local64_set(&event->hw.prev_count, val);
a4eaf7f14675cb arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-06-16  2286  	local64_set(&event->hw.period_left, left);
a4eaf7f14675cb arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-06-16  2287  	perf_event_update_userpage(event);
a4eaf7f14675cb arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-06-16  2288  
aa8e21c053d72b arch/powerpc/perf/core-book3s.c    Athira Rajeev              2020-11-25  2289  	/*
aa8e21c053d72b arch/powerpc/perf/core-book3s.c    Athira Rajeev              2020-11-25  2290  	 * Due to hardware limitation, sometimes SIAR could sample a kernel
aa8e21c053d72b arch/powerpc/perf/core-book3s.c    Athira Rajeev              2020-11-25  2291  	 * address even when freeze on supervisor state (kernel) is set in
aa8e21c053d72b arch/powerpc/perf/core-book3s.c    Athira Rajeev              2020-11-25  2292  	 * MMCR2. Check attr.exclude_kernel and address to drop the sample in
aa8e21c053d72b arch/powerpc/perf/core-book3s.c    Athira Rajeev              2020-11-25  2293  	 * these cases.
aa8e21c053d72b arch/powerpc/perf/core-book3s.c    Athira Rajeev              2020-11-25  2294  	 */
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2295  	if (event->attr.exclude_kernel &&
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2296  	    (event->attr.sample_type & PERF_SAMPLE_IP) &&
d137845c973147 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-02-05  2297  	    is_kernel_addr(mfspr(SPRN_SIAR)))
aa8e21c053d72b arch/powerpc/perf/core-book3s.c    Athira Rajeev              2020-11-25  2298  		record = 0;
aa8e21c053d72b arch/powerpc/perf/core-book3s.c    Athira Rajeev              2020-11-25  2299  
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2300  	/*
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2301  	 * Finally record data if requested.
4574910e508708 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-01-09  2302  	 */
0bbd0d4be8d5d3 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-05-14  2303  	if (record) {
dc1d628a67a8f0 arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-03-03  2304  		struct perf_sample_data data;
dc1d628a67a8f0 arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-03-03  2305  
fd0d000b2c34aa arch/powerpc/perf/core-book3s.c    Robert Richter             2012-04-02  2306  		perf_sample_data_init(&data, ~0ULL, event->hw.last_period);
df1a132bf3d350 arch/powerpc/kernel/perf_counter.c Peter Zijlstra             2009-06-10  2307  
4cb6a42e4c4bc1 arch/powerpc/perf/core-book3s.c    Kan Liang                  2020-10-01  2308  		if (event->attr.sample_type & PERF_SAMPLE_ADDR_TYPE)
da97e18458fb42 arch/powerpc/perf/core-book3s.c    Joel Fernandes (Google     2019-10-14  2309) 			perf_get_data_addr(event, regs, &data.addr);
98fb1807b97e3e arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-06-17  2310  
3925f46bb5902b arch/powerpc/perf/core-book3s.c    Anshuman Khandual          2013-04-22  2311  		if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
3925f46bb5902b arch/powerpc/perf/core-book3s.c    Anshuman Khandual          2013-04-22  2312  			struct cpu_hw_events *cpuhw;
69111bac42f5ce arch/powerpc/perf/core-book3s.c    Christoph Lameter          2014-10-21  2313  			cpuhw = this_cpu_ptr(&cpu_hw_events);
da97e18458fb42 arch/powerpc/perf/core-book3s.c    Joel Fernandes (Google     2019-10-14  2314) 			power_pmu_bhrb_read(event, cpuhw);
571d91dcadfa3c arch/powerpc/perf/core-book3s.c    Kan Liang                  2023-10-25 @2315  			perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack, NULL);
3925f46bb5902b arch/powerpc/perf/core-book3s.c    Anshuman Khandual          2013-04-22  2316  		}
3925f46bb5902b arch/powerpc/perf/core-book3s.c    Anshuman Khandual          2013-04-22  2317  
79e96f8f930d42 arch/powerpc/perf/core-book3s.c    Madhavan Srinivasan        2017-04-11  2318  		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
e16fd7f2cb1a65 arch/powerpc/perf/core-book3s.c    Kan Liang                  2022-09-01  2319  						ppmu->get_mem_data_src) {
79e96f8f930d42 arch/powerpc/perf/core-book3s.c    Madhavan Srinivasan        2017-04-11  2320  			ppmu->get_mem_data_src(&data.data_src, ppmu->flags, regs);
e16fd7f2cb1a65 arch/powerpc/perf/core-book3s.c    Kan Liang                  2022-09-01  2321  			data.sample_flags |= PERF_SAMPLE_DATA_SRC;
e16fd7f2cb1a65 arch/powerpc/perf/core-book3s.c    Kan Liang                  2022-09-01  2322  		}
79e96f8f930d42 arch/powerpc/perf/core-book3s.c    Madhavan Srinivasan        2017-04-11  2323  
af31fd0c9107e4 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-03-22  2324  		if (event->attr.sample_type & PERF_SAMPLE_WEIGHT_TYPE &&
2abe681da0a192 arch/powerpc/perf/core-book3s.c    Kan Liang                  2022-09-01  2325  						ppmu->get_mem_weight) {
af31fd0c9107e4 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2021-03-22  2326  			ppmu->get_mem_weight(&data.weight.full, event->attr.sample_type);
2abe681da0a192 arch/powerpc/perf/core-book3s.c    Kan Liang                  2022-09-01  2327  			data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
2abe681da0a192 arch/powerpc/perf/core-book3s.c    Kan Liang                  2022-09-01  2328  		}
a8b0ca17b80e92 arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2011-06-27  2329  		if (perf_event_overflow(event, &data, regs))
a4eaf7f14675cb arch/powerpc/kernel/perf_event.c   Peter Zijlstra             2010-06-16  2330  			power_pmu_stop(event, 0);
17899eaf88d689 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2020-08-06  2331  	} else if (period) {
17899eaf88d689 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2020-08-06  2332  		/* Account for interrupt in case of invalid SIAR */
17899eaf88d689 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2020-08-06  2333  		if (perf_event_account_interrupt(event))
17899eaf88d689 arch/powerpc/perf/core-book3s.c    Athira Rajeev              2020-08-06  2334  			power_pmu_stop(event, 0);
8a7b8cb91f26a6 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-05-26  2335  	}
0bbd0d4be8d5d3 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-05-14  2336  }
0bbd0d4be8d5d3 arch/powerpc/kernel/perf_counter.c Paul Mackerras             2009-05-14  2337  

:::::: The code at line 2315 was first introduced by commit
:::::: 571d91dcadfa3cef499010b4eddb9b58b0da4d24 perf: Add branch stack counters

:::::: TO: Kan Liang <kan.liang@linux.intel.com>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

