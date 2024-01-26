Return-Path: <linux-kernel+bounces-39599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5B483D362
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9903228C161
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E1B654;
	Fri, 26 Jan 2024 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnLQv6k1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EAB662
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706242476; cv=none; b=hb8Vev7+fy4syQj47MXzY0Z4TJVrBCabV7VLq8zfxbtfwg/Xobbc9LUGsilewxWwfz7dTcpBiEG9RD+/ukUP3NZvQobC2KkY62fyh920REEt2Yxe4Q+CrGP6D1gP0/IKpzfSeQz8rsaX+Nzdc8XMKiArIqYDsuxNcK8SJ7Q1fAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706242476; c=relaxed/simple;
	bh=ZUKyYewBETI6rlR1K+soZAWriSUyacb4wVhoBhe5tTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T28tk7ceON6Ta8A90EqZs5blBDXpbdXu+pYeS4l3zmPGPdLYZl4X3v68AZaVZ77to5eLxdhsVTH3MeE0tJgR/IpqiynBIrTvY5MY5vcuLALohwU9OjcitLJgyR1xOpOXQNxY1YdFTUPWA/HFXlRGZ7cnbUiKeE4xe4+FB0/B9Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnLQv6k1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706242475; x=1737778475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZUKyYewBETI6rlR1K+soZAWriSUyacb4wVhoBhe5tTA=;
  b=lnLQv6k1neglh+oWphTTV+P9jM/65qSqKoL+BqBTK1XSiiTtStbc8iVP
   ByebZUh44DMNWv7udCuUfRbXBuJSLiLG6800/bYTMBF9/M7GV3SxdPEcG
   sAPDuec3J5uBeXnWOqse7/9/k5yESOMke8SJnQccUxwhKclb6Vtl3Qh3K
   rV1VqC3qTN+NmQ/d1PqSILjifhnOhTbKvreRJxTqcLKtU9iohLqxT22EP
   ux/2HLzEoh55QFDLHT6ZE5hGkmTBg2TTPJNwY3EoXiQjZNP+4vIFklDuT
   /Koie9s82DNzNfUUY+/nuXfLTq9zsxhdY+BmNYmd05jeoNVI/tFiNlIkj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15745209"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15745209"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 20:14:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="21292265"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 25 Jan 2024 20:14:31 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTDbp-0000g4-1c;
	Fri, 26 Jan 2024 04:14:29 +0000
Date: Fri, 26 Jan 2024 12:13:32 +0800
From: kernel test robot <lkp@intel.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>, will@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sgoutham@marvell.com,
	bbhushan2@marvell.com, george.cherian@marvell.com,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: Re: [PATCH v3 1/2] perf/marvell: Odyssey DDR Performance monitor
 support
Message-ID: <202401261154.gKVsomua-lkp@intel.com>
References: <20240122124933.1311925-2-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122124933.1311925-2-gthiagarajan@marvell.com>

Hi Gowthami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gowthami-Thiagarajan/perf-marvell-Odyssey-DDR-Performance-monitor-support/20240122-205209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240122124933.1311925-2-gthiagarajan%40marvell.com
patch subject: [PATCH v3 1/2] perf/marvell: Odyssey DDR Performance monitor support
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240126/202401261154.gKVsomua-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401261154.gKVsomua-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401261154.gKVsomua-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/perf/marvell_cn10k_ddr_pmu.c:195:43: warning: 'odyssey_ddr_pmu_pdata' defined but not used [-Wunused-const-variable=]
     195 | static const struct ddr_pmu_platform_data odyssey_ddr_pmu_pdata = {
         |                                           ^~~~~~~~~~~~~~~~~~~~~


vim +/odyssey_ddr_pmu_pdata +195 drivers/perf/marvell_cn10k_ddr_pmu.c

   194	
 > 195	static const struct ddr_pmu_platform_data odyssey_ddr_pmu_pdata = {
   196		.counter_overflow_val = 0,
   197		.counter_max_val = GENMASK_ULL(63, 0),
   198		.ddrc_perf_cnt_base = ODY_DDRC_PERF_CNT_VALUE_BASE,
   199		.ddrc_perf_cfg_base = ODY_DDRC_PERF_CFG_BASE,
   200		.ddrc_perf_cnt_op_mode_ctrl = ODY_DDRC_PERF_CNT_OP_MODE_CTRL,
   201		.ddrc_perf_cnt_start_op_ctrl = ODY_DDRC_PERF_CNT_START_OP_CTRL,
   202		.ddrc_perf_cnt_end_op_ctrl = ODY_DDRC_PERF_CNT_END_OP_CTRL,
   203		.ddrc_perf_cnt_end_status = ODY_DDRC_PERF_CNT_END_STATUS,
   204		.ddrc_perf_cnt_freerun_en = 0,
   205		.ddrc_perf_cnt_freerun_ctrl = ODY_DDRC_PERF_CNT_FREERUN_CTRL,
   206		.ddrc_perf_cnt_freerun_clr = ODY_DDRC_PERF_CNT_FREERUN_CLR,
   207		.ddrc_perf_cnt_value_wr_op = ODY_DDRC_PERF_CNT_VALUE_WR_OP,
   208		.ddrc_perf_cnt_value_rd_op = ODY_DDRC_PERF_CNT_VALUE_RD_OP,
   209	};
   210	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

