Return-Path: <linux-kernel+bounces-39645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735B83D42F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1074AB23A81
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CC3134A0;
	Fri, 26 Jan 2024 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ne9mSEWs"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70911CBB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249260; cv=none; b=AuwjIAl/tlVFF80meJPxGFlaAtudTDdA/Jky4QnmZUomB7PzutMY30GBA9FAIvQt6efcLMDy9A8AAf5wuz7ZBRvGXOHaVaXquq2BLZUEb3cnNS+dIwu8XRj7pWLszwqRgwkeMSq8X0anYgqucQ41y5V30N5KvJy4IJ368n9D79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249260; c=relaxed/simple;
	bh=F2cuHQcISif+W/CbWE/dwHGmIuoKu9dc05sxpSmmUB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNaLXIn2AMVPDo4puLOY1FIN0qmNZ/ePuqH9aartb4n1CnySEyT2Jp10yCeeueun79zO8oA6lTV2KuSBf6m6Vd6exndx9a0stn4PNnyx9qpJu+ZgaHOqXHocZfK1JV3Ee7j9Y42PXhL+Ze1OC/f8RwtyCki+X4lHeTIuP+dVhRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ne9mSEWs; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706249258; x=1737785258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F2cuHQcISif+W/CbWE/dwHGmIuoKu9dc05sxpSmmUB8=;
  b=Ne9mSEWsqmBU25XBWC0Wblj+fm5S2Swgz9tNDMLYa8OpHsq4//u0Bqyk
   Le8ey+kQRKaT2EnPDVJZGACipyt69VCSHVq0phI0+SDGchRyxVBQKRda+
   BSL3TNlrx9IS4qgCYzMrNuUZMGXFo8zEFvyKW1Pb/cbRCldVqSZzluU6v
   2eaTy/+AAH9tWud97NF+OjDDRgsaU+UWr1fc/w3yki8VCfjuwvwVpakM6
   UBHt+td+Asmn3ekIN4YGYEkEQ6hDnMBfJcu4p5XAHm+uJLXv3TGnTcTmO
   VvQCLx08ONoxQn/tM60ytr/Nlto51EGAbPeAcxVJhtL99uPuGJZoVkRSG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="401245637"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401245637"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 22:07:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2519020"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Jan 2024 22:07:34 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTFNE-0000kY-0B;
	Fri, 26 Jan 2024 06:07:32 +0000
Date: Fri, 26 Jan 2024 14:07:26 +0800
From: kernel test robot <lkp@intel.com>
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
	akpm@linux-foundation.org, pmladek@suse.com, tglx@linutronix.de,
	maz@kernel.org, liusong@linux.alibaba.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCH 3/3] watchdog/softlockup: add parameter to control the
 reporting of time-consuming hardirq
Message-ID: <202401261322.fGeoPvI9-lkp@intel.com>
References: <20240123121223.22318-4-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123121223.22318-4-yaoma@linux.alibaba.com>

Hi Bitao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on akpm-mm/mm-everything linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitao-Hu/watchdog-softlockup-low-overhead-detection-of-interrupt-storm/20240123-201509
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20240123121223.22318-4-yaoma%40linux.alibaba.com
patch subject: [PATCH 3/3] watchdog/softlockup: add parameter to control the reporting of time-consuming hardirq
config: i386-randconfig-012-20240126 (https://download.01.org/0day-ci/archive/20240126/202401261322.fGeoPvI9-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401261322.fGeoPvI9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401261322.fGeoPvI9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/watchdog.c:1088:5: warning: no previous prototype for 'proc_softlockup_irqtrace' [-Wmissing-prototypes]
    1088 | int proc_softlockup_irqtrace(struct ctl_table *table, int write,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/proc_softlockup_irqtrace +1088 kernel/watchdog.c

  1084	
  1085	/*
  1086	 * /proc/sys/kernel/softlockup_irqtrace
  1087	 */
> 1088	int proc_softlockup_irqtrace(struct ctl_table *table, int write,
  1089				 void *buffer, size_t *lenp, loff_t *ppos)
  1090	{
  1091		int err, old;
  1092	
  1093		mutex_lock(&watchdog_mutex);
  1094	
  1095		old = READ_ONCE(softlockup_irqtrace);
  1096		err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
  1097	
  1098		if (!err && write && old != READ_ONCE(softlockup_irqtrace))
  1099			proc_watchdog_update();
  1100	
  1101		mutex_unlock(&watchdog_mutex);
  1102		return err;
  1103	}
  1104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

