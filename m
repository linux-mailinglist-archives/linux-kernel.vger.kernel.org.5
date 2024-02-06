Return-Path: <linux-kernel+bounces-55688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D40E84BFFA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D361C2224C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499541BF37;
	Tue,  6 Feb 2024 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RV4AwnG1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227101B948
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258324; cv=none; b=mhW35a4NJUJk0vgJfP7b/nBxtBWkrKPTmo8OMgdnG3Z3Rjc57JOivIanSgCB1ucsG8zCEarBLvudHc9bKcS0WSuwDPpIF0hPGPjTAxQetw1zK4fEGuRKkVtFqxuxOJyznVPAMmU3kSNfxD8zK5nfGhZLnDJT8itlg+nJPXpBBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258324; c=relaxed/simple;
	bh=nE2Jyb3mZEhs8pykJcflzPw6M+vxgI3FSTgsd5Q54Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PIWA9qHudR5UWtkHG5p1Y8lqomrZqWAXi7xsFWM/vrag1jHgMai7XrbTDPpJXEC6VrlHkc+5g9eQ9oXR9mXqq+vkiX4Hi2yLHvM28yZHz7cLONVmCdpfEsk+LClCc+hbP9NxI2GSIIT7L0p1m4+dWefd0ZNqxl7hZ7LaZc/e7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RV4AwnG1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707258323; x=1738794323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nE2Jyb3mZEhs8pykJcflzPw6M+vxgI3FSTgsd5Q54Kc=;
  b=RV4AwnG1ZWzJV7QQs6nWR2ROh1XUnHSnQAIyBpv2OAwVpaXZZAj6QYhA
   KF2BSbsUhplCUMo3Rp/QLctmO9c0w+Bkx4mJLKth2/Q64xbydoLFCxZtm
   73JsGVfS+PA0YA0FEbsFh5adf+Ty9SVg9r/wY7XjSJ3CigdznDkrzlzQs
   WZPULKEAs/wXQNKBFTSvhQ3pS+QyG9+JS0Ph5Chwvq4wB91v29z1ZtCJv
   cbt9XPfwY5ff5Z00WAGwQBVVgE3M9wAdXEgxaIeYG4LFSV4qESug1jn4z
   4G30pVHZpFxcLBs56ep2A9ZR4WpqCnE83vOS/0UA3//WbUDOStkOrZ6MK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1132627"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1132627"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 14:25:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="933595128"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="933595128"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Feb 2024 14:25:21 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXTsU-0001po-2w;
	Tue, 06 Feb 2024 22:25:18 +0000
Date: Wed, 7 Feb 2024 06:24:40 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: ld: drivers/net/ethernet/adi/adin1110.c:1609: undefined reference to
 `phy_connect'
Message-ID: <202402070626.eZsfVHG5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99bd3cb0d12e85d5114425353552121ec8f93adc
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   1 year ago
config: x86_64-randconfig-013-20240206 (https://download.01.org/0day-ci/archive/20240207/202402070626.eZsfVHG5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402070626.eZsfVHG5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402070626.eZsfVHG5-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_net_open':
   drivers/net/ethernet/adi/adin1110.c:933: undefined reference to `phy_start'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_probe_netdevs':
   drivers/net/ethernet/adi/adin1110.c:1603: undefined reference to `get_phy_device'
>> ld: drivers/net/ethernet/adi/adin1110.c:1609: undefined reference to `phy_connect'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_disconnect_phy':
   drivers/net/ethernet/adi/adin1110.c:1226: undefined reference to `phy_disconnect'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `devm_mdiobus_alloc':
   include/linux/phy.h:455: undefined reference to `devm_mdiobus_alloc_size'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_register_mdiobus':
   drivers/net/ethernet/adi/adin1110.c:529: undefined reference to `__devm_mdiobus_register'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_net_stop':
   drivers/net/ethernet/adi/adin1110.c:958: undefined reference to `phy_stop'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_disconnect_phy':
   drivers/net/ethernet/adi/adin1110.c:1226: undefined reference to `phy_disconnect'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_adjust_link':
   drivers/net/ethernet/adi/adin1110.c:1077: undefined reference to `phy_print_status'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_ioctl':
   drivers/net/ethernet/adi/adin1110.c:790: undefined reference to `phy_do_ioctl'
   ld: drivers/net/ethernet/adi/adin1110.o:(.rodata+0xf60): undefined reference to `phy_ethtool_get_link_ksettings'
   ld: drivers/net/ethernet/adi/adin1110.o:(.rodata+0xf68): undefined reference to `phy_ethtool_set_link_ksettings'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

