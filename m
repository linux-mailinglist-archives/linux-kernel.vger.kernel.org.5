Return-Path: <linux-kernel+bounces-64757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6B385427E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD131F21ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FF9D310;
	Wed, 14 Feb 2024 05:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHLncSwx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B80C8DD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707889459; cv=none; b=T+Pb9JYH5nd8BkH0idg8mIkeLJ5xaTyzqGzW7yTpyt/tSlY41qByS8xZwMyck/EBUXSD95aqH5YWOMGBu3MZNV/3/kF/1S2hCvBnE363KKNcrmmkgLX3jVUlg0GJUgo/jYjt369GkOAuPAoH+V4aPdxl6O3D98BwmCTG3XXqlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707889459; c=relaxed/simple;
	bh=H3x+Tu/KUfIIvKBCAtwFdznjT/Eao+QusDRfpypQgsg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G/12rV4So39YLHCYE9BDQpIO/tcJ6YRphscd4yxQ+TnJD42ZkLwr9Lb2dG5KxYuVi8VFkJFo8sybZEG0UDx2Yq9H8DZbIxGNsYdu1Wv79ljpgz1r7ObvoGP7bKRV+SyVl5EpCt1TplnGMyjy3BZL9tKBiPwyldMSZ/MkwsyeP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHLncSwx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707889457; x=1739425457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H3x+Tu/KUfIIvKBCAtwFdznjT/Eao+QusDRfpypQgsg=;
  b=gHLncSwx8AYBFYIy9fAWnWPvGHIdsRDGwKEK2Yv3p8/DxXofeSs4CgWG
   48UHBIfL84Hvc/lu+/ufsl12YIW+PceLXa4yDrhXMiBBLynrgzjUlRSXy
   /3F0B4/obIo/77gKIbcaRfd7tbl8u2csikgQXY05HCDM+cHsgIDPS9ttz
   GXHnj4JfFQr3pyLCd1S8Q4lOv44c+VqsqAStDNq+6KeQowzF1UIQgkBme
   ZsPBnRBBZzq08cm0G9oh3uOBeupvTJij+zAkqhOBj1F+8akCkE7QXc5NX
   OFigXq6xT/t+r9EZGFoS1xP1z42X62JBUjNfvP1jy/RcGqYmfVm01v5JU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1792426"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1792426"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 21:44:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7741521"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Feb 2024 21:44:14 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ra844-0008Vs-1b;
	Wed, 14 Feb 2024 05:44:12 +0000
Date: Wed, 14 Feb 2024 13:43:24 +0800
From: kernel test robot <lkp@intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/opp/debugfs.c:48:54: warning: '%d' directive output may be
 truncated writing between 1 and 11 bytes into a region of size 8
Message-ID: <202402141313.81ltVF5g-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Viresh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e90b5c295ec1e47c8ad865429f046970c549a66
commit: 46f48aca2e5aef3f430e95d1a5fb68227ec8ec85 OPP: Fix missing debugfs supply directory for OPPs
date:   5 years ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20240214/202402141313.81ltVF5g-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402141313.81ltVF5g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402141313.81ltVF5g-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/opp/debugfs.c: In function 'opp_debug_create_one':
>> drivers/opp/debugfs.c:48:54: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Wformat-truncation=]
      48 |                 snprintf(name, sizeof(name), "supply-%d", i);
         |                                                      ^~
   In function 'opp_debug_create_supplies',
       inlined from 'opp_debug_create_one' at drivers/opp/debugfs.c:119:7:
   drivers/opp/debugfs.c:48:46: note: directive argument in the range [-2147483644, 2147483646]
      48 |                 snprintf(name, sizeof(name), "supply-%d", i);
         |                                              ^~~~~~~~~~~
   drivers/opp/debugfs.c:48:17: note: 'snprintf' output between 9 and 19 bytes into a destination of size 15
      48 |                 snprintf(name, sizeof(name), "supply-%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +48 drivers/opp/debugfs.c

deaa51465105a7 drivers/base/power/opp/debugfs.c Viresh Kumar 2015-11-11  37  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  38  static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  39  				      struct opp_table *opp_table,
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  40  				      struct dentry *pdentry)
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  41  {
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  42  	struct dentry *d;
1fae788ed640e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2017-05-23  43  	int i;
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  44  
1fae788ed640e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2017-05-23  45  	for (i = 0; i < opp_table->regulator_count; i++) {
d741029a239040 drivers/opp/debugfs.c            Arvind Yadav 2017-09-21  46  		char name[15];
d741029a239040 drivers/opp/debugfs.c            Arvind Yadav 2017-09-21  47  
d741029a239040 drivers/opp/debugfs.c            Arvind Yadav 2017-09-21 @48  		snprintf(name, sizeof(name), "supply-%d", i);
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  49  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  50  		/* Create per-opp directory */
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  51  		d = debugfs_create_dir(name, pdentry);
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  52  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  53  		if (!d)
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  54  			return false;
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  55  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  56  		if (!debugfs_create_ulong("u_volt_target", S_IRUGO, d,
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  57  					  &opp->supplies[i].u_volt))
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  58  			return false;
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  59  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  60  		if (!debugfs_create_ulong("u_volt_min", S_IRUGO, d,
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  61  					  &opp->supplies[i].u_volt_min))
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  62  			return false;
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  63  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  64  		if (!debugfs_create_ulong("u_volt_max", S_IRUGO, d,
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  65  					  &opp->supplies[i].u_volt_max))
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  66  			return false;
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  67  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  68  		if (!debugfs_create_ulong("u_amp", S_IRUGO, d,
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  69  					  &opp->supplies[i].u_amp))
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  70  			return false;
1fae788ed640e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2017-05-23  71  	}
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  72  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  73  	return true;
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  74  }
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  75  

:::::: The code at line 48 was first introduced by commit
:::::: d741029a2390406d4d94279ae5b346831a9e61e6 PM / OPP: Use snprintf() to avoid kasprintf() and kfree()

:::::: TO: Arvind Yadav <arvind.yadav.cs@gmail.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

