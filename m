Return-Path: <linux-kernel+bounces-101457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8444B87A764
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA081F2402A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7383FB0F;
	Wed, 13 Mar 2024 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StyduBs2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F63FB1C;
	Wed, 13 Mar 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710331614; cv=none; b=XXXDpU5Wh5/zg/AXQfO6ttEm0EEoMX0hM3AHSd6RIv9Ta+ieJlF54jumEapcENKNmp3xescIkYHniDOabq8I8dcXKv8QBnDhewERP7yKJBd6jiogQyPwxvFKAoy9xNqrTf2ArLWHSAF7iA3A2o+TwJkEG4fVm6Mc6EszP6/IEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710331614; c=relaxed/simple;
	bh=M425A9spsJt2sc60u2h4SBdYauiKFkLuf2a5/almDhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGCZxos2dWviDmH4uC7vEyI9DG9ROCXYrlfC6SpigEGFpS0QnY1JZbRYuH/PHuxuCuRRULLBtN+lMrjksHTSCTxe+JDexGRWB1Bs4poPf7jhP7CE0poZGwDCh38QN+6YzdCfBrDNhTmklDgz+4q+Dis/hfSPR/a1UaWSnrtsl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StyduBs2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710331613; x=1741867613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M425A9spsJt2sc60u2h4SBdYauiKFkLuf2a5/almDhY=;
  b=StyduBs2bkVV/PgwKxmEW/FYiutthkBye8avcfcOkR0Ny8Ok8xgEg1p9
   VokH0NtsML/3hvyeE/UiaTxK8iUP0Ux9LEL99ZzeQ5CqJVZU4LBmd19Ba
   2ROfKMudXBqe9fEUxlAG6SMcn7EmyHkvN5RkNrz99s6FUabOLynuGAkVg
   WH23apmd6l29Hi4wlk8Kqb5iQbecEsYDoNeH3H4cOV59kusQnqN3jocPv
   kvtHr/RJRahhfYsz8T/+fdUwo3dfDwbx3YfgEA5n1zIRp2ha/dmC852M1
   ZHM5f9elAl1o7iI+EYuWX1q1/Pe3Kx8YMAwCtIrsu0QGpT6t6vWLthEr8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15724252"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="15724252"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 05:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16498296"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 Mar 2024 05:06:47 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkNNc-000CLb-2d;
	Wed, 13 Mar 2024 12:06:44 +0000
Date: Wed, 13 Mar 2024 20:05:54 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	x86@kernel.org, linux-perf-users@vger.kernel.org,
	jialong.yang@shingroup.cn
Subject: Re: [PATCH 04/10] perf: Rename PERF_PMU_CAP_NO_INTERRUPT
Message-ID: <202403131930.sz1VjXDw-lkp@intel.com>
References: <0999a39f0a068979dbcc6119380f63d706101b4f.1710257512.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0999a39f0a068979dbcc6119380f63d706101b4f.1710257512.git.robin.murphy@arm.com>

Hi Robin,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on perf-tools/perf-tools linus/master v6.8 next-20240313]
[cannot apply to acme/perf/core tip/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/perf-alibaba_uncore_drw-Use-correct-CPU-affinity/20240313-013915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/0999a39f0a068979dbcc6119380f63d706101b4f.1710257512.git.robin.murphy%40arm.com
patch subject: [PATCH 04/10] perf: Rename PERF_PMU_CAP_NO_INTERRUPT
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240313/202403131930.sz1VjXDw-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240313/202403131930.sz1VjXDw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403131930.sz1VjXDw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/events/core.c:1815:46: error: expected ';' after expression
    1815 |         pmu.capabilities |= PERF_PMU_CAP_NO_SAMPLING
         |                                                     ^
         |                                                     ;
   1 error generated.


vim +1815 arch/x86/events/core.c

  1799	
  1800	static void __init pmu_check_apic(void)
  1801	{
  1802		if (boot_cpu_has(X86_FEATURE_APIC))
  1803			return;
  1804	
  1805		x86_pmu.apic = 0;
  1806		pr_info("no APIC, boot with the \"lapic\" boot parameter to force-enable it.\n");
  1807		pr_info("no hardware sampling interrupt available.\n");
  1808	
  1809		/*
  1810		 * If we have a PMU initialized but no APIC
  1811		 * interrupts, we cannot sample hardware
  1812		 * events (user-space has to fall back and
  1813		 * sample via a hrtimer based software event):
  1814		 */
> 1815		pmu.capabilities |= PERF_PMU_CAP_NO_SAMPLING
  1816	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

