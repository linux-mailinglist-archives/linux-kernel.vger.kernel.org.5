Return-Path: <linux-kernel+bounces-70597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA838599A9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89B5B20CEA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1000A1E86E;
	Sun, 18 Feb 2024 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpiAHHfg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576A6F07C
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708293849; cv=none; b=bv09yr2yMPLOWdcoiflySOLmGPl1IR1n5hsibfXdQQwznAGs512jlz//FLDEB2lvBYam4+G7a5brvvO2zCdJKgE7hYanWDPvp71qwgQAECSU8dMt9ycbGh5Dy3RoYX30TkiaLmzUQ/Bnqdzs2V8doxgFKNmxKyvgXVogzHQSiZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708293849; c=relaxed/simple;
	bh=cuSyQRH7bwhvjr0XgDK18ejsQwITuzTRYw+briicG0k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IUJE4459A4ADQpfahalofNPnkWY7w3f20Xc8Ko6QdrMBYNrtlAxP1eJq2bRUR/hHeOlJxVv5fN32xTbBh978cl/HTXri9OlXX/jh4HsMllkNpNlW+sCwJf4srwhBDk1bf+FIGDleITpKZf23tLrtQI5JfXijfFWnrAb+43au5PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BpiAHHfg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708293848; x=1739829848;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cuSyQRH7bwhvjr0XgDK18ejsQwITuzTRYw+briicG0k=;
  b=BpiAHHfgANwbLVnc4ptCygqcWgZmJnU4Ad55Xk18CKg+o3XNFd30cwRF
   1DztKJzpmM/sAvjAeb5+NB5dv8P02X8f5N2L9AnGMdYG/CqzUXvvhoqcF
   yMjbwVPtDoke54WCanN7JYBXvyE2o5U+fQ0ON5JTOWuLISnKPuKTgLHef
   xo5K+T1geQAJ+rqugj+D6MbLDmWBAyoCB/aM2sZ9xs/T+6W6TWoO43CRa
   V8Oun4puEp568uNAos9+4eVFaU8BjQNL+YG1goNwoG5xZ10Lbi4FkNs7r
   Pv8M128A0g7ZoxwtunkvPW3Px6wUv6m1BBU1RX3G4q5jy7ku5A41QnnTj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2226678"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2226678"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 14:04:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="9008214"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 18 Feb 2024 14:04:05 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbpGI-0003KC-1e;
	Sun, 18 Feb 2024 22:03:53 +0000
Date: Mon, 19 Feb 2024 06:01:08 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/hwtracing/intel_th/core.c:812: warning: Function parameter
 or member 'ndevres' not described in 'intel_th_alloc'
Message-ID: <202402190552.9D7I1cA3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexander,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6c160f16be5df1f66f6afe186c961ad446d7f94b
commit: db73a059de00eed721f13051c0d6ff3e7de90fe8 intel_th: Rework resource passing between glue layers and core
date:   4 years, 10 months ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20240219/202402190552.9D7I1cA3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402190552.9D7I1cA3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402190552.9D7I1cA3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwtracing/intel_th/core.c:812: warning: Function parameter or member 'drvdata' not described in 'intel_th_alloc'
>> drivers/hwtracing/intel_th/core.c:812: warning: Function parameter or member 'ndevres' not described in 'intel_th_alloc'


vim +812 drivers/hwtracing/intel_th/core.c

39f4034693b7c7 Alexander Shishkin 2015-09-22  802  
39f4034693b7c7 Alexander Shishkin 2015-09-22  803  /**
39f4034693b7c7 Alexander Shishkin 2015-09-22  804   * intel_th_alloc() - allocate a new Intel TH device and its subdevices
39f4034693b7c7 Alexander Shishkin 2015-09-22  805   * @dev:	parent device
db73a059de00ee Alexander Shishkin 2019-05-03  806   * @devres:	resources indexed by th_mmio_idx
39f4034693b7c7 Alexander Shishkin 2015-09-22  807   * @irq:	irq number
39f4034693b7c7 Alexander Shishkin 2015-09-22  808   */
39f4034693b7c7 Alexander Shishkin 2015-09-22  809  struct intel_th *
3321371b5d6484 Alexander Shishkin 2017-08-18  810  intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
3321371b5d6484 Alexander Shishkin 2017-08-18  811  	       struct resource *devres, unsigned int ndevres, int irq)
39f4034693b7c7 Alexander Shishkin 2015-09-22 @812  {
39f4034693b7c7 Alexander Shishkin 2015-09-22  813  	struct intel_th *th;
661b0df8489a35 Alexander Shishkin 2017-08-23  814  	int err, r;
661b0df8489a35 Alexander Shishkin 2017-08-23  815  
db73a059de00ee Alexander Shishkin 2019-05-03  816  	if (ndevres < TH_MMIO_END)
db73a059de00ee Alexander Shishkin 2019-05-03  817  		return ERR_PTR(-EINVAL);
39f4034693b7c7 Alexander Shishkin 2015-09-22  818  
39f4034693b7c7 Alexander Shishkin 2015-09-22  819  	th = kzalloc(sizeof(*th), GFP_KERNEL);
39f4034693b7c7 Alexander Shishkin 2015-09-22  820  	if (!th)
39f4034693b7c7 Alexander Shishkin 2015-09-22  821  		return ERR_PTR(-ENOMEM);
39f4034693b7c7 Alexander Shishkin 2015-09-22  822  
39f4034693b7c7 Alexander Shishkin 2015-09-22  823  	th->id = ida_simple_get(&intel_th_ida, 0, 0, GFP_KERNEL);
39f4034693b7c7 Alexander Shishkin 2015-09-22  824  	if (th->id < 0) {
39f4034693b7c7 Alexander Shishkin 2015-09-22  825  		err = th->id;
39f4034693b7c7 Alexander Shishkin 2015-09-22  826  		goto err_alloc;
39f4034693b7c7 Alexander Shishkin 2015-09-22  827  	}
39f4034693b7c7 Alexander Shishkin 2015-09-22  828  
39f4034693b7c7 Alexander Shishkin 2015-09-22  829  	th->major = __register_chrdev(0, 0, TH_POSSIBLE_OUTPUTS,
39f4034693b7c7 Alexander Shishkin 2015-09-22  830  				      "intel_th/output", &intel_th_output_fops);
39f4034693b7c7 Alexander Shishkin 2015-09-22  831  	if (th->major < 0) {
39f4034693b7c7 Alexander Shishkin 2015-09-22  832  		err = th->major;
39f4034693b7c7 Alexander Shishkin 2015-09-22  833  		goto err_ida;
39f4034693b7c7 Alexander Shishkin 2015-09-22  834  	}
39f4034693b7c7 Alexander Shishkin 2015-09-22  835  	th->dev = dev;
3321371b5d6484 Alexander Shishkin 2017-08-18  836  	th->drvdata = drvdata;
39f4034693b7c7 Alexander Shishkin 2015-09-22  837  
db73a059de00ee Alexander Shishkin 2019-05-03  838  	for (r = 0; r < ndevres; r++)
db73a059de00ee Alexander Shishkin 2019-05-03  839  		th->resource[r] = devres[r];
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  840  	th->num_resources = ndevres;
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  841  	th->irq = irq;
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  842  
d7b1787161b78a Alexander Shishkin 2016-02-15  843  	dev_set_drvdata(dev, th);
d7b1787161b78a Alexander Shishkin 2016-02-15  844  
142dfeb2020960 Alexander Shishkin 2016-06-22  845  	pm_runtime_no_callbacks(dev);
142dfeb2020960 Alexander Shishkin 2016-06-22  846  	pm_runtime_put(dev);
142dfeb2020960 Alexander Shishkin 2016-06-22  847  	pm_runtime_allow(dev);
142dfeb2020960 Alexander Shishkin 2016-06-22  848  
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  849  	err = intel_th_populate(th);
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  850  	if (err) {
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  851  		/* free the subdevices and undo everything */
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  852  		intel_th_free(th);
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  853  		return ERR_PTR(err);
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  854  	}
39f4034693b7c7 Alexander Shishkin 2015-09-22  855  
39f4034693b7c7 Alexander Shishkin 2015-09-22  856  	return th;
39f4034693b7c7 Alexander Shishkin 2015-09-22  857  
39f4034693b7c7 Alexander Shishkin 2015-09-22  858  err_ida:
39f4034693b7c7 Alexander Shishkin 2015-09-22  859  	ida_simple_remove(&intel_th_ida, th->id);
39f4034693b7c7 Alexander Shishkin 2015-09-22  860  
39f4034693b7c7 Alexander Shishkin 2015-09-22  861  err_alloc:
39f4034693b7c7 Alexander Shishkin 2015-09-22  862  	kfree(th);
39f4034693b7c7 Alexander Shishkin 2015-09-22  863  
39f4034693b7c7 Alexander Shishkin 2015-09-22  864  	return ERR_PTR(err);
39f4034693b7c7 Alexander Shishkin 2015-09-22  865  }
39f4034693b7c7 Alexander Shishkin 2015-09-22  866  EXPORT_SYMBOL_GPL(intel_th_alloc);
39f4034693b7c7 Alexander Shishkin 2015-09-22  867  

:::::: The code at line 812 was first introduced by commit
:::::: 39f4034693b7c7bd1fe4cb58c93259d600f55561 intel_th: Add driver infrastructure for Intel(R) Trace Hub devices

:::::: TO: Alexander Shishkin <alexander.shishkin@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

