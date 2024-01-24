Return-Path: <linux-kernel+bounces-36799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCB883A6D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B473B28559
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC6EF9D8;
	Wed, 24 Jan 2024 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJ/1OJgf"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC0DF5E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092328; cv=none; b=CllTOqm0hnyt8M0iaSd+/KxnkEQjnjuZP+UeXE9YeDPE0imhHZ6glajUqwAyQwvEhCvtqGHA89a8TMGO8kfuBVByGYALfdjeW6QAdv8RJzrNEegeXLENZEA8jEeg6wFM1Gb7HdZWOdcqMZcS8gYkMpAYPITa7q21Nd7LIgzeg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092328; c=relaxed/simple;
	bh=KYCb3LqD6tfjAM7lgE/WGEoMo5rePEzuJxNBnqVyeAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JhBSY4J6Q3DShfeFCKiSQcnT1jJ6fk8dPeKGSTGyfCIGg+E9lnIUgc2hyZJhqS1mp3NF+dJck5cviiL9Ad666sQvLGGQxrA93q7Xv6OOWdCJ1Ay5rXbUiVd4aUUDQk41hxTUphAZW4DRayX4GgAQUFvS1REz5So+RtLuW1WmWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJ/1OJgf; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706092323; x=1737628323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KYCb3LqD6tfjAM7lgE/WGEoMo5rePEzuJxNBnqVyeAw=;
  b=MJ/1OJgfFuKC4zQlkhWcQLTYjYjKVg+qskCwk17ohjJQKQF1wgey0d8H
   U7S05XspxoKEA9IoNGUhQjkdhlXe4dNGnuBTtguxEanMuMiN2pR62Rj/I
   wjbmIvGNu+YPRKRRq7Ssmtr5PmJlCC1FkmXfhvEftgRs5A/gKKmUa87o9
   SbAvV6v6/WT+QDUM5hxyqIcvTftuvExLn03sRU6PPd4VpfFi5lTw7sfuE
   gOp+QiL7p11Pc3cO4J+TE/dXtqMv2pMoyMVQJt307VSMEKQJz/zfh3fpn
   z9CQlYlwejlxUv4+1WQXndfYP3hlqhudaWX+xJZwyC19sY8sipch1PSTT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="398961968"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="398961968"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 02:32:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1834246"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 24 Jan 2024 02:32:00 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSaY1-00083t-1L;
	Wed, 24 Jan 2024 10:31:57 +0000
Date: Wed, 24 Jan 2024 18:31:41 +0800
From: kernel test robot <lkp@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>,
	Reinette Chatre <reinette.chatre@intel.com>
Subject: [tip:x86/cache 3/3] arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8:
 Unneeded variable: "ret". Return "  0" on line 1655
Message-ID: <202401241810.jbd8Ipa1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
head:   54e35eb8611cce5550d3d7689679b1a91c864f28
commit: 54e35eb8611cce5550d3d7689679b1a91c864f28 [3/3] x86/resctrl: Read supported bandwidth sources from CPUID
config: x86_64-randconfig-102-20240124 (https://download.01.org/0day-ci/archive/20240124/202401241810.jbd8Ipa1-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401241810.jbd8Ipa1-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret". Return "  0" on line 1655

vim +1621 arch/x86/kernel/cpu/resctrl/rdtgroup.c

92bd5a1390335b Babu Moger 2023-01-13  1616  
92bd5a1390335b Babu Moger 2023-01-13  1617  static int mbm_config_write_domain(struct rdt_resource *r,
92bd5a1390335b Babu Moger 2023-01-13  1618  				   struct rdt_domain *d, u32 evtid, u32 val)
92bd5a1390335b Babu Moger 2023-01-13  1619  {
92bd5a1390335b Babu Moger 2023-01-13  1620  	struct mon_config_info mon_info = {0};
92bd5a1390335b Babu Moger 2023-01-13 @1621  	int ret = 0;
92bd5a1390335b Babu Moger 2023-01-13  1622  
92bd5a1390335b Babu Moger 2023-01-13  1623  	/*
92bd5a1390335b Babu Moger 2023-01-13  1624  	 * Read the current config value first. If both are the same then
92bd5a1390335b Babu Moger 2023-01-13  1625  	 * no need to write it again.
92bd5a1390335b Babu Moger 2023-01-13  1626  	 */
92bd5a1390335b Babu Moger 2023-01-13  1627  	mon_info.evtid = evtid;
92bd5a1390335b Babu Moger 2023-01-13  1628  	mondata_config_read(d, &mon_info);
92bd5a1390335b Babu Moger 2023-01-13  1629  	if (mon_info.mon_config == val)
92bd5a1390335b Babu Moger 2023-01-13  1630  		goto out;
92bd5a1390335b Babu Moger 2023-01-13  1631  
92bd5a1390335b Babu Moger 2023-01-13  1632  	mon_info.mon_config = val;
92bd5a1390335b Babu Moger 2023-01-13  1633  
92bd5a1390335b Babu Moger 2023-01-13  1634  	/*
92bd5a1390335b Babu Moger 2023-01-13  1635  	 * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
92bd5a1390335b Babu Moger 2023-01-13  1636  	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
92bd5a1390335b Babu Moger 2023-01-13  1637  	 * are scoped at the domain level. Writing any of these MSRs
92bd5a1390335b Babu Moger 2023-01-13  1638  	 * on one CPU is observed by all the CPUs in the domain.
92bd5a1390335b Babu Moger 2023-01-13  1639  	 */
92bd5a1390335b Babu Moger 2023-01-13  1640  	smp_call_function_any(&d->cpu_mask, mon_event_config_write,
92bd5a1390335b Babu Moger 2023-01-13  1641  			      &mon_info, 1);
92bd5a1390335b Babu Moger 2023-01-13  1642  
92bd5a1390335b Babu Moger 2023-01-13  1643  	/*
92bd5a1390335b Babu Moger 2023-01-13  1644  	 * When an Event Configuration is changed, the bandwidth counters
92bd5a1390335b Babu Moger 2023-01-13  1645  	 * for all RMIDs and Events will be cleared by the hardware. The
92bd5a1390335b Babu Moger 2023-01-13  1646  	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
92bd5a1390335b Babu Moger 2023-01-13  1647  	 * every RMID on the next read to any event for every RMID.
92bd5a1390335b Babu Moger 2023-01-13  1648  	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
92bd5a1390335b Babu Moger 2023-01-13  1649  	 * cleared while it is tracked by the hardware. Clear the
92bd5a1390335b Babu Moger 2023-01-13  1650  	 * mbm_local and mbm_total counts for all the RMIDs.
92bd5a1390335b Babu Moger 2023-01-13  1651  	 */
92bd5a1390335b Babu Moger 2023-01-13  1652  	resctrl_arch_reset_rmid_all(r, d);
92bd5a1390335b Babu Moger 2023-01-13  1653  
92bd5a1390335b Babu Moger 2023-01-13  1654  out:
92bd5a1390335b Babu Moger 2023-01-13 @1655  	return ret;
92bd5a1390335b Babu Moger 2023-01-13  1656  }
92bd5a1390335b Babu Moger 2023-01-13  1657  

:::::: The code at line 1621 was first introduced by commit
:::::: 92bd5a1390335bb3cc76bdf1b4356edbc94d408d x86/resctrl: Add interface to write mbm_total_bytes_config

:::::: TO: Babu Moger <babu.moger@amd.com>
:::::: CC: Borislav Petkov (AMD) <bp@alien8.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

