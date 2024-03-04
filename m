Return-Path: <linux-kernel+bounces-91161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19980870A46
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EB0282117
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AFC7BAED;
	Mon,  4 Mar 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCmDNTRU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC297A71E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579544; cv=none; b=L+sLZQrtK/Iwn5g+zw3XSsOpzoLsKqZ9qB9c1t85J7yHhRSB+wzwuc0ArQsZgKSSH/05RWQWJmDTDr5Ce3id/IiCSEMGMKSrw5RrxYiaOUR+DVQm35Cgaj66RIYSBwb05njAW1jFXc+hHmu81ehnOHzJvJeT8Ibw8TlvmG1hIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579544; c=relaxed/simple;
	bh=YQOUYGH92NEcitg/ruLuF4nrJWBx8Imk1eZ2XcovxQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aj5hMaEZBh2hfYZO/in3ZzUC+AXf07w/qoDUWWxxvMHNpS9eN8TF7ECQ9Th089QWu5fh//KsXAdZmpY2r5EQVn6W1Tw9S6hAeQvGq0sz7Oev3Ip5kTdj0Vo4horyDc6X6oSplryrOFM39jVkgyClc1FPBwkbPVmB6zyIzKf16Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCmDNTRU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709579542; x=1741115542;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YQOUYGH92NEcitg/ruLuF4nrJWBx8Imk1eZ2XcovxQo=;
  b=iCmDNTRUyVtlznMs0I30QdHpvfry0w7ODWjic53Fzxq7wdx/JuwWCIWL
   iPtO5JtVrhE+otEV2hnX0fnFnNz9TCoye1i1Q2n3DB0kH9PE1ceJiXfxU
   rWDIf/7YlyJHf8G5l/bRZRcfHFeVw30dPxr5iW1FIuDKCbHyn5mtVMJ9M
   bVWVKvps6gJo0RpL03aJrWsS5lbDv+DEfCklSFMxWkuX1UJcTl7sCXbNa
   Je7V2E9dGKA/N1eEA3HPe3cjWrkgyXsPgZ10DEhuqibO4WVcMihxa6z6N
   OA7TCjU1kBVHfE04ppN1p4avf2S0wSQDQEGDwudDo/TK54XUsEf3hN2Lx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4017493"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4017493"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:12:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="13596038"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 04 Mar 2024 11:12:19 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rhDjV-0002iP-1C;
	Mon, 04 Mar 2024 19:12:17 +0000
Date: Tue, 5 Mar 2024 03:11:46 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>
Subject: drivers/iommu/io-pgtable-arm.c:330:13: error: void value not ignored
 as it ought to be
Message-ID: <202403050319.iEyasXif-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90d35da658da8cff0d4ecbb5113f5fac9d00eb72
commit: 9257959a6e5b4fca6fc8e985790bff62c2046f20 locking/atomic: scripts: restructure fallback ifdeffery
date:   9 months ago
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20240305/202403050319.iEyasXif-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240305/202403050319.iEyasXif-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403050319.iEyasXif-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
>> drivers/iommu/io-pgtable-arm.c:330:13: error: void value not ignored as it ought to be
     330 |         old = cmpxchg64_relaxed(ptep, curr, new);
         |             ^
--
   drivers/iommu/io-pgtable-dart.c: In function 'dart_install_table':
>> drivers/iommu/io-pgtable-dart.c:168:13: error: void value not ignored as it ought to be
     168 |         old = cmpxchg64_relaxed(ptep, curr, new);
         |             ^
   drivers/iommu/io-pgtable-dart.c:157:25: warning: variable 'new' set but not used [-Wunused-but-set-variable]
     157 |         dart_iopte old, new;
         |                         ^~~


vim +330 drivers/iommu/io-pgtable-arm.c

c896c132b01895 Laurent Pinchart   2014-12-14  310  
fb3a95795da53d Robin Murphy       2017-06-22  311  static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
fb3a95795da53d Robin Murphy       2017-06-22  312  					     arm_lpae_iopte *ptep,
2c3d273eabe8b1 Robin Murphy       2017-06-22  313  					     arm_lpae_iopte curr,
9abe2ac834851a Hector Martin      2021-11-20  314  					     struct arm_lpae_io_pgtable *data)
fb3a95795da53d Robin Murphy       2017-06-22  315  {
2c3d273eabe8b1 Robin Murphy       2017-06-22  316  	arm_lpae_iopte old, new;
9abe2ac834851a Hector Martin      2021-11-20  317  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
e1d3c0fd701df8 Will Deacon        2014-11-14  318  
9abe2ac834851a Hector Martin      2021-11-20  319  	new = paddr_to_iopte(__pa(table), data) | ARM_LPAE_PTE_TYPE_TABLE;
fb3a95795da53d Robin Murphy       2017-06-22  320  	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
fb3a95795da53d Robin Murphy       2017-06-22  321  		new |= ARM_LPAE_PTE_NSTABLE;
e1d3c0fd701df8 Will Deacon        2014-11-14  322  
77f3445866c39d Will Deacon        2017-06-23  323  	/*
77f3445866c39d Will Deacon        2017-06-23  324  	 * Ensure the table itself is visible before its PTE can be.
77f3445866c39d Will Deacon        2017-06-23  325  	 * Whilst we could get away with cmpxchg64_release below, this
77f3445866c39d Will Deacon        2017-06-23  326  	 * doesn't have any ordering semantics when !CONFIG_SMP.
77f3445866c39d Will Deacon        2017-06-23  327  	 */
77f3445866c39d Will Deacon        2017-06-23  328  	dma_wmb();
2c3d273eabe8b1 Robin Murphy       2017-06-22  329  
2c3d273eabe8b1 Robin Murphy       2017-06-22 @330  	old = cmpxchg64_relaxed(ptep, curr, new);
2c3d273eabe8b1 Robin Murphy       2017-06-22  331  
4f41845b340783 Will Deacon        2019-06-25  332  	if (cfg->coherent_walk || (old & ARM_LPAE_PTE_SW_SYNC))
2c3d273eabe8b1 Robin Murphy       2017-06-22  333  		return old;
2c3d273eabe8b1 Robin Murphy       2017-06-22  334  
2c3d273eabe8b1 Robin Murphy       2017-06-22  335  	/* Even if it's not ours, there's no point waiting; just kick it */
41e1eb2546e9c8 Isaac J. Manjarres 2021-06-16  336  	__arm_lpae_sync_pte(ptep, 1, cfg);
2c3d273eabe8b1 Robin Murphy       2017-06-22  337  	if (old == curr)
2c3d273eabe8b1 Robin Murphy       2017-06-22  338  		WRITE_ONCE(*ptep, new | ARM_LPAE_PTE_SW_SYNC);
2c3d273eabe8b1 Robin Murphy       2017-06-22  339  
2c3d273eabe8b1 Robin Murphy       2017-06-22  340  	return old;
e1d3c0fd701df8 Will Deacon        2014-11-14  341  }
e1d3c0fd701df8 Will Deacon        2014-11-14  342  

:::::: The code at line 330 was first introduced by commit
:::::: 2c3d273eabe8b1ed3b3cffe2c79643b1bf7e2d4a iommu/io-pgtable-arm: Support lockless operation

:::::: TO: Robin Murphy <robin.murphy@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

