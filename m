Return-Path: <linux-kernel+bounces-39753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B5483D5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F4028A033
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5862030A;
	Fri, 26 Jan 2024 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ix9GQ10p"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDD12E7D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256942; cv=none; b=NOvuYc0q3JE6Vryu0wL4dKLNUuc/dM0CHlCs6hkWMrVWec+JRtT5c2oRbJe25zGOYHGPuBD5e2LwaE2sVZ47GU/6HpJMoMCn9pG7F8zB82d/UFH7TmuUAFSRZIcQXs3+fg2Jy+yV5HDsfx/GUIjBg4KSDYr6AyVP/ojZ3gpDTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256942; c=relaxed/simple;
	bh=HGv9MFuipz7qlfRad5Kn9QJpzNtljsHTLz2asR69Sbs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RWPg5kzE2n2CZQ1/rUXinDA+L4R83JQvAdyzW6cZivbQ8vwjzq0aJ4i29UaDe8YaAO+TKgA2adXML6CDkqKDOL37XMYhdECvZOP7YJaF3kYFqi2Mb8dZKA/vYiJNZe/Pu7It8UNzz096/HWILdNqJl+DJw/03i+fItNvT6F6UDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ix9GQ10p; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706256940; x=1737792940;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HGv9MFuipz7qlfRad5Kn9QJpzNtljsHTLz2asR69Sbs=;
  b=ix9GQ10pUaz0ATkz2cH9MQcEcmzjV8QNAXFtKKNd6tCJZBJh3xI5yrqM
   MNsyLWv7lBSO03+HShpBsurDbVeysXb9bGph/WdkYrzXDESY9MsS+QHCO
   7WJYBUInVMEL0CTQJi4Ai7sAweRDn8IYZgqaKG48tRxpZZjgEu23Fp/0y
   tObaJh1RemL3pTmu6yxOPrbuLJZrTO5a0BuboC30KM9LxwqsmRmMBR19n
   Iq9GlM8pia7MyR4apHXn2D9J8k7bkmpaJ4DqX73Ff5FFJIpIzq6KwUOOP
   9tD7sXiStONnGmNgv2st8f8YZG3mFfDJeLKi2/EfUZVd99lkoM13QcPAX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="401266490"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401266490"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 00:15:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="910265733"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="910265733"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2024 00:15:37 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTHN9-0000po-2a;
	Fri, 26 Jan 2024 08:15:35 +0000
Date: Fri, 26 Jan 2024 16:14:38 +0800
From: kernel test robot <lkp@intel.com>
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: drivers/fpga/versal-fpga.c:78:34: warning: unused variable
 'versal_fpga_of_match'
Message-ID: <202401261611.Ee3FjLdD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
commit: 01c54e628932c655e4cd2c6ed0cc688ec6e6f96b fpga: versal-fpga: Add versal fpga manager driver
date:   2 years, 6 months ago
config: x86_64-buildonly-randconfig-003-20240107 (https://download.01.org/0day-ci/archive/20240126/202401261611.Ee3FjLdD-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401261611.Ee3FjLdD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401261611.Ee3FjLdD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/fpga/versal-fpga.c:78:34: warning: unused variable 'versal_fpga_of_match' [-Wunused-const-variable]
      78 | static const struct of_device_id versal_fpga_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/versal_fpga_of_match +78 drivers/fpga/versal-fpga.c

    77	
  > 78	static const struct of_device_id versal_fpga_of_match[] = {
    79		{ .compatible = "xlnx,versal-fpga", },
    80		{},
    81	};
    82	MODULE_DEVICE_TABLE(of, versal_fpga_of_match);
    83	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

