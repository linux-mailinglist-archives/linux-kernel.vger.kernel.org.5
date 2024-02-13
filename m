Return-Path: <linux-kernel+bounces-62859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4BD8526EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0435F28567C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F584F501;
	Tue, 13 Feb 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2la5CqQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA6E543
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787453; cv=none; b=preF6XDsg5o/8bp8sRmOHAa5XuQziUPsBX+DFUPmQ6EwB3ub8BAAokDVZMcs0AIAw5WUDDG3nQ5JZWQtySxhCcMThYeXva7KDqN+UPjE8/QtcS8QwO6F030fuFUeXPQ1WbulEa7GrmULU/LBEOzU+XhYozZI1JA7C3nMSqXlM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787453; c=relaxed/simple;
	bh=sRF+gCs4sH/iPmHfvzjt9ga8h2QTVOthUP9QuuyfsdA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aEe3B89grs6RpuNmowqbaeuS323FayRgaSXpV0tC8q6ZdxkeXfbVY3tgVaUaavf1MbaxWDytOu3muixKc6KnUSUjFIMy4xCZ/f2NxDiURd03q+QG0rj3x2ziaqC7ItjXeFo1pazuJHaPOrRwZuQ08EawVs+HC1WWE6DvGnAlHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2la5CqQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707787451; x=1739323451;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sRF+gCs4sH/iPmHfvzjt9ga8h2QTVOthUP9QuuyfsdA=;
  b=E2la5CqQXWAvFn4TyU9003/SURrojmGXXmCYaDL8DvUqbl76AUfWmhFX
   a/fGf5ndzOhm37LGFh/HiTg0xOkiDZ1HD6ItXDvLEgJ+B0PIg6yuipDfP
   gyZHjO+ZmQhLinLKfl0qDaLPzx5Feuc+9r9HFlll68VkHg80qMNFKqf3x
   Nki38FfIiO2wvjZkgGZjEqdFYGCBKE2CPPMPFrI69fkUJKDQxtIgpg36G
   usrO0jpEsl0JeiH9OcxZxk8QAHAoHJLrjFEAYynTW9WbrzLpbrzh6KroP
   jmZVazHyw/74qyxJNxfFWAJLA2xxRvgGy/2PhuPPXR1u/KhwJPzLNBx1h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="24255821"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="24255821"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 17:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2730754"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 12 Feb 2024 17:24:09 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZhWo-0007RW-1N;
	Tue, 13 Feb 2024 01:24:06 +0000
Date: Tue, 13 Feb 2024 09:23:56 +0800
From: kernel test robot <lkp@intel.com>
To: Ashish Kalra <ashish.kalra@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>,
	Michael Roth <michael.roth@amd.com>
Subject: [tip:x86/sev 22/33] drivers/crypto/ccp/sev-dev.c:1672: undefined
 reference to `amd_iommu_snp_disable'
Message-ID: <202402130940.IHNXTMSN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
head:   45ba5b3c0a02949a4da74ead6e11c43e9b88bdca
commit: f366a8dac1b8fef28a470d4e67b9843ebb8e2a1f [22/33] iommu/amd: Clean up RMP entries for IOMMU pages during SNP shutdown
config: x86_64-randconfig-072-20240212 (https://download.01.org/0day-ci/archive/20240213/202402130940.IHNXTMSN-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240213/202402130940.IHNXTMSN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402130940.IHNXTMSN-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/crypto/ccp/sev-dev.o: in function `__sev_snp_shutdown_locked':
>> drivers/crypto/ccp/sev-dev.c:1672: undefined reference to `amd_iommu_snp_disable'


vim +1672 drivers/crypto/ccp/sev-dev.c

  1626	
  1627	static int __sev_snp_shutdown_locked(int *error)
  1628	{
  1629		struct sev_device *sev = psp_master->sev_data;
  1630		struct sev_data_snp_shutdown_ex data;
  1631		int ret;
  1632	
  1633		if (!sev->snp_initialized)
  1634			return 0;
  1635	
  1636		memset(&data, 0, sizeof(data));
  1637		data.len = sizeof(data);
  1638		data.iommu_snp_shutdown = 1;
  1639	
  1640		wbinvd_on_all_cpus();
  1641	
  1642		ret = __sev_do_cmd_locked(SEV_CMD_SNP_SHUTDOWN_EX, &data, error);
  1643		/* SHUTDOWN may require DF_FLUSH */
  1644		if (*error == SEV_RET_DFFLUSH_REQUIRED) {
  1645			ret = __sev_do_cmd_locked(SEV_CMD_SNP_DF_FLUSH, NULL, NULL);
  1646			if (ret) {
  1647				dev_err(sev->dev, "SEV-SNP DF_FLUSH failed\n");
  1648				return ret;
  1649			}
  1650			/* reissue the shutdown command */
  1651			ret = __sev_do_cmd_locked(SEV_CMD_SNP_SHUTDOWN_EX, &data,
  1652						  error);
  1653		}
  1654		if (ret) {
  1655			dev_err(sev->dev, "SEV-SNP firmware shutdown failed\n");
  1656			return ret;
  1657		}
  1658	
  1659		/*
  1660		 * SNP_SHUTDOWN_EX with IOMMU_SNP_SHUTDOWN set to 1 disables SNP
  1661		 * enforcement by the IOMMU and also transitions all pages
  1662		 * associated with the IOMMU to the Reclaim state.
  1663		 * Firmware was transitioning the IOMMU pages to Hypervisor state
  1664		 * before version 1.53. But, accounting for the number of assigned
  1665		 * 4kB pages in a 2M page was done incorrectly by not transitioning
  1666		 * to the Reclaim state. This resulted in RMP #PF when later accessing
  1667		 * the 2M page containing those pages during kexec boot. Hence, the
  1668		 * firmware now transitions these pages to Reclaim state and hypervisor
  1669		 * needs to transition these pages to shared state. SNP Firmware
  1670		 * version 1.53 and above are needed for kexec boot.
  1671		 */
> 1672		ret = amd_iommu_snp_disable();
  1673		if (ret) {
  1674			dev_err(sev->dev, "SNP IOMMU shutdown failed\n");
  1675			return ret;
  1676		}
  1677	
  1678		sev->snp_initialized = false;
  1679		dev_dbg(sev->dev, "SEV-SNP firmware shutdown\n");
  1680	
  1681		return ret;
  1682	}
  1683	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

