Return-Path: <linux-kernel+bounces-91298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E211D870C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C3A1F26EF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6633B795;
	Mon,  4 Mar 2024 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="El15yIhS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1251F95E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587527; cv=none; b=SgA4w9ZktgwilrhuhpT4hF9ebXsSaicyV2SLtrPcN4XFR7MHHauppwDqofOWPp3g1U/fnfd2SzUOdsMJmDja8STUxNmg//rE5azdVNvwfzTp2IPC/z26cTwP/c5KW+NenbTVZpPS+jZpCp1yo47R0hTUwllzKk2lE4xmRo0LmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587527; c=relaxed/simple;
	bh=0TWUKCDgxRZFqQLCQUzZZnZ4A3GPQ9+rr11L3/1F5iE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PkzFywpeNx2z+szbuUNwfQt3/aazaHOrDynCkuf8t3VBTYUY6vaLxLtJujOafKnxubUct7sZkLiIMdmUXoIlpIXPjt18aSgso0UmnOZphmBPg3rkHuG+svZhsyheIdCKzVHu5iHesUG3ict4Hc2EGs3fteNbHcPB24Z84UxBk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=El15yIhS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587526; x=1741123526;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0TWUKCDgxRZFqQLCQUzZZnZ4A3GPQ9+rr11L3/1F5iE=;
  b=El15yIhSiCdvwteExWrriLndsXjE5z1pOCgSr99Zt0URP7OS58+fKaba
   I4K30JpeYiXGmYdnG8yiCCXi4NV8ajr73TqiLT4KJhzQAsJb3o8p8KWv2
   Pe/6gICzTlORF+wWgrLtWO9BiDU5iMvPOEc39fu2DU3pDTk6kRIj0RWdh
   jNzCHv3LwYa404sTlt/NctaX4vCQnUPX90XrIAqW7DMivSf4olCIcyKNz
   v8tX3vMU2CCELKbAn+5JcIcAe6QobiaVCvtOWsSbNYXDE7XFvRNSEqhiX
   lXGAP5x30QQ9FRfhoPhv7xF7Cwk81grxC3Swh6amwQIuTb7K9GPmGZZnQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3962079"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3962079"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:25:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9076106"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Mar 2024 13:25:23 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rhFoH-0002mT-0I;
	Mon, 04 Mar 2024 21:25:21 +0000
Date: Tue, 5 Mar 2024 05:25:11 +0800
From: kernel test robot <lkp@intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: drivers/platform/x86/intel/pmc/core_ssram.c:98:25: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202403050547.qnZtuNlN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90d35da658da8cff0d4ecbb5113f5fac9d00eb72
commit: a01486dc4bb17de976c6d0a4b1ad5f8106525dfb platform/x86/intel/pmc: Cleanup SSRAM discovery
date:   3 months ago
config: x86_64-randconfig-r111-20240304 (https://download.01.org/0day-ci/archive/20240305/202403050547.qnZtuNlN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240305/202403050547.qnZtuNlN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403050547.qnZtuNlN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/intel/pmc/core_ssram.c:98:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *val @@     got void [noderef] __iomem *__val @@
   drivers/platform/x86/intel/pmc/core_ssram.c:98:25: sparse:     expected void const volatile *val
   drivers/platform/x86/intel/pmc/core_ssram.c:98:25: sparse:     got void [noderef] __iomem *__val

vim +98 drivers/platform/x86/intel/pmc/core_ssram.c

    70	
    71	static int
    72	pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
    73	{
    74		struct pci_dev *ssram_pcidev = pmcdev->ssram_pcidev;
    75		void __iomem __free(pmc_core_iounmap) *tmp_ssram = NULL;
    76		void __iomem __free(pmc_core_iounmap) *ssram = NULL;
    77		const struct pmc_reg_map *map;
    78		u64 ssram_base, pwrm_base;
    79		u16 devid;
    80	
    81		if (!pmcdev->regmap_list)
    82			return -ENOENT;
    83	
    84		ssram_base = ssram_pcidev->resource[0].start;
    85		tmp_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
    86	
    87		if (pmc_idx != PMC_IDX_MAIN) {
    88			/*
    89			 * The secondary PMC BARS (which are behind hidden PCI devices)
    90			 * are read from fixed offsets in MMIO of the primary PMC BAR.
    91			 */
    92			ssram_base = get_base(tmp_ssram, offset);
    93			ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
    94			if (!ssram)
    95				return -ENOMEM;
    96	
    97		} else {
  > 98			ssram = no_free_ptr(tmp_ssram);
    99		}
   100	
   101		pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
   102		devid = readw(ssram + SSRAM_DEVID_OFFSET);
   103	
   104		map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
   105		if (!map)
   106			return -ENODEV;
   107	
   108		return pmc_core_pmc_add(pmcdev, pwrm_base, map, PMC_IDX_MAIN);
   109	}
   110	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

