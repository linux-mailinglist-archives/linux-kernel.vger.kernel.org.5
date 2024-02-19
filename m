Return-Path: <linux-kernel+bounces-71836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D385AB48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87AE7B2368C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB064E1CD;
	Mon, 19 Feb 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsveKdaJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E554D580
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368157; cv=none; b=kR8Coy3DJJUIlYcL7OEegSFbuexKkwYllQ91CjVySz7MoaLGFtHBjKQ7zXrQv1GkCaeHo7AGgC3oYCQj3s5D1SBOBjbavDi0l5qGEJ0OLyPNhpjXYIboxztrkVU+WJvWLA8gnrzh0RiOx3dL+UEJeBYyrydiMGs+8ZquMeuIi0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368157; c=relaxed/simple;
	bh=9uUd9LrHCpG4quaufBsXEBoYDhhQ7BMvMMujM+1I/5s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lmNhp91KWxDGjX/mzkFM/yUfD40yi9GRxwBPxN3X25ArRqIdNJmntbaLKhxuXTSWW9GeQ9EkphHt5EuOVNJ5j70TzqHp/EDPKwVd7E/073COQss917WEkLpjsNLucwBSlfnmycYi3cPLntkM5Dcjv4wLqBT0W5YOYUHIUbPWtUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsveKdaJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708368154; x=1739904154;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9uUd9LrHCpG4quaufBsXEBoYDhhQ7BMvMMujM+1I/5s=;
  b=dsveKdaJ91mPzElU6g38q2Go4aa6qK3MeyCdnF+FzUsZKRqx33nCwwPP
   xo0xN0qjDAYXekgpvK83iMaNiAAzs9nR8+0O3Hqa3eSQW/6btIzpYW2Nm
   GpoGSxBkIwbvE/CH4jwuC64IdtKOHE6LifzYiySdsp4NBtpQffQCdue2E
   PWGBI77poapBBAGQ5OaqE5r6kWdBAG1zQs30hEM8jplaIG8Eq0vQIFSQW
   PraYnGlGRWmAjLms+ol7ClIou5GG7YtKEBVNG0Nj0iaDZoXHIi8wj3D6a
   o/uJ19rRezw94quakACB+8TwTDP7S3mwjcVFk53FnX/JChfWIUiMXO/Fd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13855114"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13855114"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 10:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4526465"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 19 Feb 2024 10:42:32 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rc8b0-00040Y-0Q;
	Mon, 19 Feb 2024 18:42:30 +0000
Date: Tue, 20 Feb 2024 02:41:30 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/hwtracing/intel_th/core.c:838: warning: Excess function
 parameter 'irq' description in 'intel_th_alloc'
Message-ID: <202402200202.TzVSNB1m-lkp@intel.com>
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
head:   b401b621758e46812da61fa58a67c3fd8d91de0d
commit: 62a593022c32380d040303a5e3d6b67fd9c415bc intel_th: Communicate IRQ via resource
date:   4 years, 10 months ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20240220/202402200202.TzVSNB1m-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240220/202402200202.TzVSNB1m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402200202.TzVSNB1m-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwtracing/intel_th/core.c:838: warning: Function parameter or member 'drvdata' not described in 'intel_th_alloc'
   drivers/hwtracing/intel_th/core.c:838: warning: Function parameter or member 'ndevres' not described in 'intel_th_alloc'
>> drivers/hwtracing/intel_th/core.c:838: warning: Excess function parameter 'irq' description in 'intel_th_alloc'


vim +838 drivers/hwtracing/intel_th/core.c

39f4034693b7c7 Alexander Shishkin 2015-09-22  828  
39f4034693b7c7 Alexander Shishkin 2015-09-22  829  /**
39f4034693b7c7 Alexander Shishkin 2015-09-22  830   * intel_th_alloc() - allocate a new Intel TH device and its subdevices
39f4034693b7c7 Alexander Shishkin 2015-09-22  831   * @dev:	parent device
db73a059de00ee Alexander Shishkin 2019-05-03  832   * @devres:	resources indexed by th_mmio_idx
39f4034693b7c7 Alexander Shishkin 2015-09-22  833   * @irq:	irq number
39f4034693b7c7 Alexander Shishkin 2015-09-22  834   */
39f4034693b7c7 Alexander Shishkin 2015-09-22  835  struct intel_th *
3321371b5d6484 Alexander Shishkin 2017-08-18  836  intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
62a593022c3238 Alexander Shishkin 2019-05-03  837  	       struct resource *devres, unsigned int ndevres)
39f4034693b7c7 Alexander Shishkin 2015-09-22 @838  {
62a593022c3238 Alexander Shishkin 2019-05-03  839  	int err, r, nr_mmios = 0;
39f4034693b7c7 Alexander Shishkin 2015-09-22  840  	struct intel_th *th;
661b0df8489a35 Alexander Shishkin 2017-08-23  841  
39f4034693b7c7 Alexander Shishkin 2015-09-22  842  	th = kzalloc(sizeof(*th), GFP_KERNEL);
39f4034693b7c7 Alexander Shishkin 2015-09-22  843  	if (!th)
39f4034693b7c7 Alexander Shishkin 2015-09-22  844  		return ERR_PTR(-ENOMEM);
39f4034693b7c7 Alexander Shishkin 2015-09-22  845  
39f4034693b7c7 Alexander Shishkin 2015-09-22  846  	th->id = ida_simple_get(&intel_th_ida, 0, 0, GFP_KERNEL);
39f4034693b7c7 Alexander Shishkin 2015-09-22  847  	if (th->id < 0) {
39f4034693b7c7 Alexander Shishkin 2015-09-22  848  		err = th->id;
39f4034693b7c7 Alexander Shishkin 2015-09-22  849  		goto err_alloc;
39f4034693b7c7 Alexander Shishkin 2015-09-22  850  	}
39f4034693b7c7 Alexander Shishkin 2015-09-22  851  
39f4034693b7c7 Alexander Shishkin 2015-09-22  852  	th->major = __register_chrdev(0, 0, TH_POSSIBLE_OUTPUTS,
39f4034693b7c7 Alexander Shishkin 2015-09-22  853  				      "intel_th/output", &intel_th_output_fops);
39f4034693b7c7 Alexander Shishkin 2015-09-22  854  	if (th->major < 0) {
39f4034693b7c7 Alexander Shishkin 2015-09-22  855  		err = th->major;
39f4034693b7c7 Alexander Shishkin 2015-09-22  856  		goto err_ida;
39f4034693b7c7 Alexander Shishkin 2015-09-22  857  	}
62a593022c3238 Alexander Shishkin 2019-05-03  858  	th->irq = -1;
39f4034693b7c7 Alexander Shishkin 2015-09-22  859  	th->dev = dev;
3321371b5d6484 Alexander Shishkin 2017-08-18  860  	th->drvdata = drvdata;
39f4034693b7c7 Alexander Shishkin 2015-09-22  861  
db73a059de00ee Alexander Shishkin 2019-05-03  862  	for (r = 0; r < ndevres; r++)
62a593022c3238 Alexander Shishkin 2019-05-03  863  		switch (devres[r].flags & IORESOURCE_TYPE_BITS) {
62a593022c3238 Alexander Shishkin 2019-05-03  864  		case IORESOURCE_MEM:
62a593022c3238 Alexander Shishkin 2019-05-03  865  			th->resource[nr_mmios++] = devres[r];
62a593022c3238 Alexander Shishkin 2019-05-03  866  			break;
62a593022c3238 Alexander Shishkin 2019-05-03  867  		case IORESOURCE_IRQ:
62a593022c3238 Alexander Shishkin 2019-05-03  868  			if (th->irq == -1)
62a593022c3238 Alexander Shishkin 2019-05-03  869  				th->irq = devres[r].start;
62a593022c3238 Alexander Shishkin 2019-05-03  870  			break;
62a593022c3238 Alexander Shishkin 2019-05-03  871  		default:
62a593022c3238 Alexander Shishkin 2019-05-03  872  			dev_warn(dev, "Unknown resource type %lx\n",
62a593022c3238 Alexander Shishkin 2019-05-03  873  				 devres[r].flags);
62a593022c3238 Alexander Shishkin 2019-05-03  874  			break;
62a593022c3238 Alexander Shishkin 2019-05-03  875  		}
62a593022c3238 Alexander Shishkin 2019-05-03  876  
62a593022c3238 Alexander Shishkin 2019-05-03  877  	th->num_resources = nr_mmios;
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  878  
d7b1787161b78a Alexander Shishkin 2016-02-15  879  	dev_set_drvdata(dev, th);
d7b1787161b78a Alexander Shishkin 2016-02-15  880  
142dfeb2020960 Alexander Shishkin 2016-06-22  881  	pm_runtime_no_callbacks(dev);
142dfeb2020960 Alexander Shishkin 2016-06-22  882  	pm_runtime_put(dev);
142dfeb2020960 Alexander Shishkin 2016-06-22  883  	pm_runtime_allow(dev);
142dfeb2020960 Alexander Shishkin 2016-06-22  884  
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  885  	err = intel_th_populate(th);
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  886  	if (err) {
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  887  		/* free the subdevices and undo everything */
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  888  		intel_th_free(th);
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  889  		return ERR_PTR(err);
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  890  	}
39f4034693b7c7 Alexander Shishkin 2015-09-22  891  
39f4034693b7c7 Alexander Shishkin 2015-09-22  892  	return th;
39f4034693b7c7 Alexander Shishkin 2015-09-22  893  
39f4034693b7c7 Alexander Shishkin 2015-09-22  894  err_ida:
39f4034693b7c7 Alexander Shishkin 2015-09-22  895  	ida_simple_remove(&intel_th_ida, th->id);
39f4034693b7c7 Alexander Shishkin 2015-09-22  896  
39f4034693b7c7 Alexander Shishkin 2015-09-22  897  err_alloc:
39f4034693b7c7 Alexander Shishkin 2015-09-22  898  	kfree(th);
39f4034693b7c7 Alexander Shishkin 2015-09-22  899  
39f4034693b7c7 Alexander Shishkin 2015-09-22  900  	return ERR_PTR(err);
39f4034693b7c7 Alexander Shishkin 2015-09-22  901  }
39f4034693b7c7 Alexander Shishkin 2015-09-22  902  EXPORT_SYMBOL_GPL(intel_th_alloc);
39f4034693b7c7 Alexander Shishkin 2015-09-22  903  

:::::: The code at line 838 was first introduced by commit
:::::: 39f4034693b7c7bd1fe4cb58c93259d600f55561 intel_th: Add driver infrastructure for Intel(R) Trace Hub devices

:::::: TO: Alexander Shishkin <alexander.shishkin@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

