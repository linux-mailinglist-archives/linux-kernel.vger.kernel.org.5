Return-Path: <linux-kernel+bounces-127154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB2894781
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3DBB21EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2262356773;
	Mon,  1 Apr 2024 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iap+bcp1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D733982
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712012184; cv=none; b=L8pyORg8IkZYbBH1gPEK9i1WvWyOeHTGWdk3PcozZAOl9FyAA0HjAtyWA+czSYi6QHfUR++PZ/wPmnsLmarIuMG/J2fmFVBrOMjENC+0X1SF11y7AdvISlyktXXTMB9fzmJPLIz5ZbuAadNCRIbBkxZqWFvZE/xmSCboeQrmFKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712012184; c=relaxed/simple;
	bh=HWcoYzLcadqjzv5w1Vao0XZJvifGka4oNIEPmv5U5BI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=am4XKGGaP4VU7DBReNit63Mz+UxVsPvRf2Gny0gr9J+h9+rzmS97Z3v9b/VpYtIriYAVrfXaktmcCPDXCGSwuuSDg3dDz+VCNp7slC27g3/VOS6Z3lt5vTG5+GSDrNQRSeo8T4PYVwWA3jqF89Z0bdSv5kmr0NjBs72Y+wyjXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iap+bcp1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712012183; x=1743548183;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HWcoYzLcadqjzv5w1Vao0XZJvifGka4oNIEPmv5U5BI=;
  b=Iap+bcp15sIELO9S0sGuY/Tj0opjeekfRc60ODYxZ7UkjhsFBXv4imtF
   M7DArZxtadIEyhi90NOQgmQ2uzwTIW/igs0gV3q6Xp87IfXwXPDxcnnNc
   bzo71aQ0RWB7dWE50UL80xwbdKya7LHB+WAfD6SCIaFQXr/decZ4a+Jl6
   Ty+mqfyLdfRaYC6eKhlnT5ERS4TJG+pge3FbjbRvfhI0B7X6LZUCAfzn+
   CDheWX1K9POR9i0rxGqx9q3NqlgTXHMprouaeCO5oq1O0QCc83k4MZvNq
   DDdxreqQIYrQ3/t5TaICPnJh+Z/QVnk2p7HbJUQX6bWmxESDCp241dk4c
   g==;
X-CSE-ConnectionGUID: hbCRBgUJQgWtfe/pwCTzBw==
X-CSE-MsgGUID: jrMheJ0GRSmnxkGoMcKceA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7276144"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7276144"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 15:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="22594009"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 01 Apr 2024 15:56:15 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrQZW-0000el-2e;
	Mon, 01 Apr 2024 22:56:11 +0000
Date: Tue, 2 Apr 2024 06:55:34 +0800
From: kernel test robot <lkp@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: drivers/pci/pci.h:343:17: sparse: sparse: cast from restricted
 pci_channel_state_t
Message-ID: <202404020648.ZvydnKCR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   026e680b0a08a62b1d948e5a8ca78700bfac0e6e
commit: c82458101d5490230d735caecce14c9c27b1010c PCI/PM: Mark devices disconnected if upstream PCIe link is down on resume
date:   6 months ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20240402/202404020648.ZvydnKCR-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240402/202404020648.ZvydnKCR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404020648.ZvydnKCR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/pci/pci-driver.c:522:42: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci-driver.c:522:61: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci-driver.c:757:28: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci-driver.c:757:46: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci-driver.c: note: in included file:
>> drivers/pci/pci.h:343:17: sparse: sparse: cast from restricted pci_channel_state_t
>> drivers/pci/pci.h:343:17: sparse: sparse: cast to restricted pci_channel_state_t
   drivers/pci/pci.h:346:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/pci.h:346:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/pci.h:346:23: sparse: sparse: cast to restricted pci_channel_state_t
   drivers/pci/pci.h:350:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/pci.h:350:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/pci.h:350:23: sparse: sparse: cast to restricted pci_channel_state_t

vim +343 drivers/pci/pci.h

ac04840350e2c2 Lukas Wunner         2023-03-11  324  
a6bd101b8f84f9 Keith Busch          2018-09-20  325  /**
a6bd101b8f84f9 Keith Busch          2018-09-20  326   * pci_dev_set_io_state - Set the new error state if possible.
a6bd101b8f84f9 Keith Busch          2018-09-20  327   *
347269c113f10f Krzysztof Wilczyński 2021-07-03  328   * @dev: PCI device to set new error_state
347269c113f10f Krzysztof Wilczyński 2021-07-03  329   * @new: the state we want dev to be in
a6bd101b8f84f9 Keith Busch          2018-09-20  330   *
74ff8864cc842b Lukas Wunner         2023-01-20  331   * If the device is experiencing perm_failure, it has to remain in that state.
74ff8864cc842b Lukas Wunner         2023-01-20  332   * Any other transition is allowed.
a6bd101b8f84f9 Keith Busch          2018-09-20  333   *
a6bd101b8f84f9 Keith Busch          2018-09-20  334   * Returns true if state has been changed to the requested state.
a6bd101b8f84f9 Keith Busch          2018-09-20  335   */
a6bd101b8f84f9 Keith Busch          2018-09-20  336  static inline bool pci_dev_set_io_state(struct pci_dev *dev,
a6bd101b8f84f9 Keith Busch          2018-09-20  337  					pci_channel_state_t new)
a6bd101b8f84f9 Keith Busch          2018-09-20  338  {
74ff8864cc842b Lukas Wunner         2023-01-20  339  	pci_channel_state_t old;
a6bd101b8f84f9 Keith Busch          2018-09-20  340  
a6bd101b8f84f9 Keith Busch          2018-09-20  341  	switch (new) {
a6bd101b8f84f9 Keith Busch          2018-09-20  342  	case pci_channel_io_perm_failure:
74ff8864cc842b Lukas Wunner         2023-01-20 @343  		xchg(&dev->error_state, pci_channel_io_perm_failure);
74ff8864cc842b Lukas Wunner         2023-01-20  344  		return true;
a6bd101b8f84f9 Keith Busch          2018-09-20  345  	case pci_channel_io_frozen:
74ff8864cc842b Lukas Wunner         2023-01-20  346  		old = cmpxchg(&dev->error_state, pci_channel_io_normal,
74ff8864cc842b Lukas Wunner         2023-01-20  347  			      pci_channel_io_frozen);
74ff8864cc842b Lukas Wunner         2023-01-20  348  		return old != pci_channel_io_perm_failure;
a6bd101b8f84f9 Keith Busch          2018-09-20  349  	case pci_channel_io_normal:
74ff8864cc842b Lukas Wunner         2023-01-20  350  		old = cmpxchg(&dev->error_state, pci_channel_io_frozen,
74ff8864cc842b Lukas Wunner         2023-01-20  351  			      pci_channel_io_normal);
74ff8864cc842b Lukas Wunner         2023-01-20  352  		return old != pci_channel_io_perm_failure;
74ff8864cc842b Lukas Wunner         2023-01-20  353  	default:
74ff8864cc842b Lukas Wunner         2023-01-20  354  		return false;
a6bd101b8f84f9 Keith Busch          2018-09-20  355  	}
a6bd101b8f84f9 Keith Busch          2018-09-20  356  }
89ee9f7680031d Keith Busch          2017-03-29  357  

:::::: The code at line 343 was first introduced by commit
:::::: 74ff8864cc842be994853095dba6db48e716400a PCI: hotplug: Allow marking devices as disconnected during bind/unbind

:::::: TO: Lukas Wunner <lukas@wunner.de>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

