Return-Path: <linux-kernel+bounces-50940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E87E84840C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 07:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3C81F2721D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 06:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3148E11725;
	Sat,  3 Feb 2024 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HA/98oyb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7095111AE
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706940356; cv=none; b=qT3yCs2ZmCb7JXW272XunRwxi2YMpaBTdm1ziUE2Mej9DO7j4/jdwX2AC718i1e64HA2CsXd5ToPnXYtV31GfO+5b4YRC+pCJvx4xdnBgrreBsgT+h7h+w5XIrH9x6YJxcRPlVgxV7pG1eucZ1Vo1nPSm3LP5r1CZt6G1RfnxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706940356; c=relaxed/simple;
	bh=SU4UxvavEjTqMN5PNvoZtPbihV3+kp8uz40/wRkea2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AqfyGXC4c3a3zgZndVHGptoh6B7fgxqR2CVlxDU/VwVAfkp+dxLI306WYoWjVMUcpGNQCy8+79692+/9TAIJnw0Uk1hpICHo5vjF9Bhr+PtMOXRc40+FZbKRxAb/PfLByrAUdAQOWlLVAVciz/iZoZ2Gk/dcL8Izw4AyPDgLE0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HA/98oyb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706940355; x=1738476355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SU4UxvavEjTqMN5PNvoZtPbihV3+kp8uz40/wRkea2g=;
  b=HA/98oyb/NVzDkcYL861x+6rH+O1mJU9ViMA+ejuAzE6D7j4imWr+ANu
   RNizBnjbuhucp2z7lDZ4AdyN5+iYM9rVVyJuHvj9mWRMLmkGddKDwi6s6
   EnBX5j2sxLDkERsCej+zxzg5pSE6Eo4NJOeejgh/fgdaLTD5xA2FHiuVW
   MibAQuobez1EOXBPPqGpuzrZNSyvTGJ6E6l+UwyTwUf3gTyP4gNuJ2zWw
   k/h3pvC34by+qGzS2Q1wuJf5y5KiZTnqEcYGrZuDS8oHJL8ulvzvu80NT
   t/7a3eMKNv1xaTqGPF5gn97fDX2j1WiSQau2XBDRCLdj8fM+rhBNNc5t5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11038609"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="11038609"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 22:05:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="37690769"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 02 Feb 2024 22:05:51 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rW99u-0004gr-2p;
	Sat, 03 Feb 2024 06:05:47 +0000
Date: Sat, 3 Feb 2024 14:04:48 +0800
From: kernel test robot <lkp@intel.com>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Jarkko Sakkinen <jarkko@profian.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [tip:x86/sev 16/29] drivers/crypto/ccp/sev-dev.c:93:28: sparse:
 sparse: symbol 'snp_range_list' was not declared. Should it be static?
Message-ID: <202402031410.GTE3PJ1Y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
head:   1bfca8d2800ab5ef0dfed335a2a29d1632c99411
commit: 1ca5614b84eed5904f65f143e0e7aaab0ac4c6b2 [16/29] crypto: ccp: Add support to initialize the AMD-SP for SEV-SNP
config: x86_64-randconfig-r131-20240203 (https://download.01.org/0day-ci/archive/20240203/202402031410.GTE3PJ1Y-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402031410.GTE3PJ1Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402031410.GTE3PJ1Y-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/crypto/ccp/sev-dev.c:93:28: sparse: sparse: symbol 'snp_range_list' was not declared. Should it be static?

vim +/snp_range_list +93 drivers/crypto/ccp/sev-dev.c

    87	
    88	/*
    89	 * SEV_DATA_RANGE_LIST:
    90	 *   Array containing range of pages that firmware transitions to HV-fixed
    91	 *   page state.
    92	 */
  > 93	struct sev_data_range_list *snp_range_list;
    94	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

