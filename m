Return-Path: <linux-kernel+bounces-38702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8A683C44F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B10DB24232
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79F163112;
	Thu, 25 Jan 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXO/aL+7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C27C62818
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191622; cv=none; b=BbV/ANTYoTt9JAIORB9Dl5+mJyLFgSHphVPEX68fBhzahKqeBTmJNxsI4l3th04fE+83VqzIw9s+9ElLDVP+Q3PbdIEP1wAhYXY0+QRzPuzWpQdBqvFbfai6ATBVme1iIfbR7nTIpVwGmC9g5Rt8Z+cudw7xBPIlfabKo6ht6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191622; c=relaxed/simple;
	bh=Bnf9zh9MGENs+PV4j2hnfu2O+KyAlO2ynzyKnkhPhuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJXoJaMAuDn3++KohXKdCZDZ0siBQktkyvpiNVCWulMyJlFeuB/37HPtrcBHSm8bgRAsPJ2yyEM8BNX8qmmoffwicJDhPElG3gTw0sTb6h3+mQmaZhcoprcXnLsX9/AlxNuVHk6e4f5bJOKrM+uNHywN1Wk0vDypzyDQs+kr+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXO/aL+7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706191617; x=1737727617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bnf9zh9MGENs+PV4j2hnfu2O+KyAlO2ynzyKnkhPhuo=;
  b=fXO/aL+7UrjC6qUOk5nQ4Db9GD55fqgcFkGu8jq4ez1CqQ4YWCS7R5l1
   A2L3qtVxMSPhPmIoJxXO6xNIEB1rrZHgm6805v0n4C2k9r4bgCWgPKfyP
   Qi/DDmE3GXHvAq3DSXWgOrd6zA52bYTpmb9UB8xtQ3P//hNE/NaV8DpQL
   IpBQtTkK2MmFCaMTZWmD0ssmjG8DacpCdY3xlvryzP2fyQAm1fL4lDiRH
   T98OrTn/mAos8dzyC5elzZIqSSBiIDG8gUrhioVcpTlBN9RAGH6SIX0bA
   Axq+NCgfaN99FZpYTrEsCH2CGgRusvwefRkEkwR7c2WIlZW8h7nschOgk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9547442"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9547442"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 06:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2254523"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Jan 2024 06:06:51 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rT0NU-000032-2k;
	Thu, 25 Jan 2024 14:06:48 +0000
Date: Thu, 25 Jan 2024 22:06:31 +0800
From: kernel test robot <lkp@intel.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>, will@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	sgoutham@marvell.com, bbhushan2@marvell.com,
	george.cherian@marvell.com,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: Re: [PATCH v3 1/2] perf/marvell: Odyssey DDR Performance monitor
 support
Message-ID: <202401252104.CFnKSeTe-lkp@intel.com>
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
config: s390-randconfig-001-20240125 (https://download.01.org/0day-ci/archive/20240125/202401252104.CFnKSeTe-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project a31a60074717fc40887cfe132b77eec93bedd307)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240125/202401252104.CFnKSeTe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401252104.CFnKSeTe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/perf/marvell_cn10k_ddr_pmu.c:9:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/perf/marvell_cn10k_ddr_pmu.c:9:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/perf/marvell_cn10k_ddr_pmu.c:9:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/perf/marvell_cn10k_ddr_pmu.c:179:43: warning: unused variable 'cn10k_ddr_pmu_pdata' [-Wunused-const-variable]
     179 | static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
         |                                           ^~~~~~~~~~~~~~~~~~~
>> drivers/perf/marvell_cn10k_ddr_pmu.c:195:43: warning: unused variable 'odyssey_ddr_pmu_pdata' [-Wunused-const-variable]
     195 | static const struct ddr_pmu_platform_data odyssey_ddr_pmu_pdata = {
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   14 warnings generated.


vim +/cn10k_ddr_pmu_pdata +179 drivers/perf/marvell_cn10k_ddr_pmu.c

   178	
 > 179	static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
   180		.counter_overflow_val =  BIT_ULL(48),
   181		.counter_max_val = GENMASK_ULL(48, 0),
   182		.ddrc_perf_cnt_base = CN10K_DDRC_PERF_CNT_VALUE_BASE,
   183		.ddrc_perf_cfg_base = CN10K_DDRC_PERF_CFG_BASE,
   184		.ddrc_perf_cnt_op_mode_ctrl = CN10K_DDRC_PERF_CNT_OP_MODE_CTRL,
   185		.ddrc_perf_cnt_start_op_ctrl = CN10K_DDRC_PERF_CNT_START_OP_CTRL,
   186		.ddrc_perf_cnt_end_op_ctrl = CN10K_DDRC_PERF_CNT_END_OP_CTRL,
   187		.ddrc_perf_cnt_end_status = CN10K_DDRC_PERF_CNT_END_STATUS,
   188		.ddrc_perf_cnt_freerun_en = CN10K_DDRC_PERF_CNT_FREERUN_EN,
   189		.ddrc_perf_cnt_freerun_ctrl = CN10K_DDRC_PERF_CNT_FREERUN_CTRL,
   190		.ddrc_perf_cnt_freerun_clr = 0,
   191		.ddrc_perf_cnt_value_wr_op = CN10K_DDRC_PERF_CNT_VALUE_WR_OP,
   192		.ddrc_perf_cnt_value_rd_op = CN10K_DDRC_PERF_CNT_VALUE_RD_OP,
   193	};
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

