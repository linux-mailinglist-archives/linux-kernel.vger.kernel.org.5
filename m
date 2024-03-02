Return-Path: <linux-kernel+bounces-89294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A039D86EDEA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52361281D42
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC92B6FC7;
	Sat,  2 Mar 2024 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtkCJ88i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338C28F8
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709343169; cv=none; b=O59mVZAA6DVNucvEc8/TmHftsMWWJbXy/FiSJxHWHkn2rctGrfV+6fZiA3vuXTO9O8VY4xuXu0zFXh2hKbkaLZllwmc8603BIjbBjhdaATENGvOmU8vcgLy5p1UiTGNSGtc8pJzMVjdhXyRwh+OEkth8zJtfssZq05zsiJLWLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709343169; c=relaxed/simple;
	bh=DaGHktFENi2ZJYLcY73o0fUZ5OobUE3Tlbzhy1KTogY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XkpSMOpcgvH2rNkSjuUVIqMA0Fga6PHi9WVX7qGkLuybUlArTptcPyQsznyAM6yPAztKwSsG09yolpqnRjLKBxlapfbUjSr93Pw/uTMs7Ijj+22C6qzj55GJ+lcyd7IoPVcxSTG3eufV1Gv0LMtZ+HJ6JsoUe7I4HOau2/KE8zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtkCJ88i; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709343167; x=1740879167;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DaGHktFENi2ZJYLcY73o0fUZ5OobUE3Tlbzhy1KTogY=;
  b=PtkCJ88iSl/K+fJjUgRr3/x9LSne0MGng92y1aqSeemBhrHGI9Ce8Njg
   qqciWt0eArLaALNIj6rdjaXd6/0xWRmwI+WPN1cl41T5EJCvh9DxY1CGx
   HJNE4jzSFmzqz8N53ufeH+pgSqNZGb1Y7LF7UdxArAuc/uqS0lWC1qu0d
   RcSr5lIbjqjBlJ37yjdikjkQ86c1adtbBlgpwyWmu9bGuBHIKRuICdgan
   uRoKpnhAUN4HWTwyYFOI+4CieY0HjMtrf3ArbngCUHBSjoqTlA2WQI98S
   vzDp14kECzQNr6aVX2Fh0DDLSRWdbvPhADRWfcRjwM9FF9gzmQvY6l7hi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="21356784"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="21356784"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 17:32:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="12894512"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 01 Mar 2024 17:32:44 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgEF0-000EDN-2S;
	Sat, 02 Mar 2024 01:32:42 +0000
Date: Sat, 2 Mar 2024 09:32:05 +0800
From: kernel test robot <lkp@intel.com>
To: Sandipan Das <sandipan.das@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: arch/x86/events/amd/uncore.c:601:10: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202403020941.UCnNA0rh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d17468c6f1f49e6259698f6401b8d7a5b90eac68
commit: 07888daa056e809de0b6b234116b575c11f9f99d perf/x86/amd/uncore: Move discovery and registration
date:   5 months ago
config: x86_64-randconfig-r122-20240301 (https://download.01.org/0day-ci/archive/20240302/202403020941.UCnNA0rh-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403020941.UCnNA0rh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403020941.UCnNA0rh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)


vim +601 arch/x86/events/amd/uncore.c

   582	
   583	static
   584	void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
   585	{
   586		union cpuid_0x80000022_ebx ebx;
   587		union amd_uncore_info info;
   588	
   589		if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
   590			return;
   591	
   592		info.split.aux_data = 0;
   593		info.split.num_pmcs = NUM_COUNTERS_NB;
   594		info.split.cid = topology_die_id(cpu);
   595	
   596		if (pmu_version >= 2) {
   597			ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
   598			info.split.num_pmcs = ebx.split.num_df_pmc;
   599		}
   600	
 > 601		*per_cpu_ptr(uncore->info, cpu) = info;
   602	}
   603	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

