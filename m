Return-Path: <linux-kernel+bounces-60904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E181850ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24F7B21854
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0935D733;
	Sun, 11 Feb 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SL47cy30"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720D5C8FF
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707675612; cv=none; b=V+bMEaHkZgT/SZojAE9UntYw4ksLJFLZNV+dosG+Rg3ct6k98raFjhuFlTzByDRJzLxs6epFZa0mbDs1ZvQHDOER/AXLCjmxzgNDi0HUTPvBY963ZdFiQeUY1iQXCPkJiJL0y1taPR1XhOHi0F4GgZiQqvB+cSCrWMaC1wzm+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707675612; c=relaxed/simple;
	bh=PA2BZ5TXi0xwBP2uD3PLRyhk8HSniBCxLARn8zGUcs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtgnQxT5/XRv1J0NsxRRRIx4Z60es0YXWGfFmumwV4Dr9aNfTFpfBjILiYk+Y5VDjkk6KPFvNBzoIpfRt3lHHxb2wozYK5UuuegE3egYGT0/K6l87Cc4plJkAkBi4xfcONWP35xG60bIvvD4dmkWEhaO2H7k7jziIq5FGE4N/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SL47cy30; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707675607; x=1739211607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PA2BZ5TXi0xwBP2uD3PLRyhk8HSniBCxLARn8zGUcs4=;
  b=SL47cy30lx+00f2oLv+bdDE8DjNlBCd+e3tWi0Q8iH6ZY0nKuQwXxMCa
   Lw4cLe2s1Qy3gkEfchmmIHMSthNmnyXa4KBXvKXpnDr5J5ehsSftbFOWh
   hUaXJx953bf/dWLPVG5cnBIeFYe1fjlPqKvtwVwCOh0S3/eLEWwpckow8
   CWZD3N9ojqxyGVRVu0z6bqlmSnSQqdFih6TgpEf41/oKxuuGsdas3cTDL
   f8PWaZAqYT21BbvIA7py0pBJPmQdYVFwO2FyKaG+6sxZBulgcuQ3jakhH
   LkQDtoxyRz+o3kO+NdaRLnXNXzi6tD46i+hR5Z6tJpfHpMqd8t3xquKTd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1501622"
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="1501622"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 10:20:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="39856743"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Feb 2024 10:20:05 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZEQs-0006ik-1p;
	Sun, 11 Feb 2024 18:20:02 +0000
Date: Mon, 12 Feb 2024 02:19:38 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v3 02/35] include: remove unnecessary #include directives
Message-ID: <202402120237.PykM6rKl-lkp@intel.com>
References: <20240211123000.3359365-3-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211123000.3359365-3-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240209]
[cannot apply to drm-misc/drm-misc-next media-tree/master mkp-scsi/for-next linus/master v6.8-rc3 v6.8-rc2 v6.8-rc1 v6.8-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240211-204508
base:   next-20240209
patch link:    https://lore.kernel.org/r/20240211123000.3359365-3-max.kellermann%40ionos.com
patch subject: [PATCH v3 02/35] include: remove unnecessary #include directives
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240212/202402120237.PykM6rKl-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240212/202402120237.PykM6rKl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402120237.PykM6rKl-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/iommu/msm_iommu.c: In function 'insert_iommu_master':
>> drivers/iommu/msm_iommu.c:608:46: error: invalid use of undefined type 'struct of_phandle_args'
     608 |                 if (master->mids[sid] == spec->args[0]) {
         |                                              ^~
   drivers/iommu/msm_iommu.c:614:48: error: invalid use of undefined type 'struct of_phandle_args'
     614 |         master->mids[master->num_mids++] = spec->args[0];
         |                                                ^~
   drivers/iommu/msm_iommu.c: In function 'qcom_iommu_of_xlate':
   drivers/iommu/msm_iommu.c:627:47: error: invalid use of undefined type 'struct of_phandle_args'
     627 |                 if (iter->dev->of_node == spec->np) {
         |                                               ^~
   drivers/iommu/msm_iommu.c: In function 'msm_iommu_probe':
>> drivers/iommu/msm_iommu.c:755:15: error: implicit declaration of function 'of_property_read_u32' [-Werror=implicit-function-declaration]
     755 |         ret = of_property_read_u32(iommu->dev->of_node, "qcom,ncb", &val);
         |               ^~~~~~~~~~~~~~~~~~~~
   drivers/iommu/msm_iommu.c: At top level:
>> drivers/iommu/msm_iommu.c:812:34: error: array type has incomplete element type 'struct of_device_id'
     812 | static const struct of_device_id msm_iommu_dt_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~
>> drivers/iommu/msm_iommu.c:812:34: warning: 'msm_iommu_dt_match' defined but not used [-Wunused-variable]
   cc1: some warnings being treated as errors


vim +608 drivers/iommu/msm_iommu.c

0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  588  
bb5bdc5ab7f133 drivers/iommu/msm_iommu.c Xiaoke Wang           2022-04-28  589  static int insert_iommu_master(struct device *dev,
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  590  				struct msm_iommu_dev **iommu,
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  591  				struct of_phandle_args *spec)
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  592  {
4bbe0c7ccc431d drivers/iommu/msm_iommu.c Joerg Roedel          2020-06-25  593  	struct msm_iommu_ctx_dev *master = dev_iommu_priv_get(dev);
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  594  	int sid;
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  595  
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  596  	if (list_empty(&(*iommu)->ctx_list)) {
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  597  		master = kzalloc(sizeof(*master), GFP_ATOMIC);
bb5bdc5ab7f133 drivers/iommu/msm_iommu.c Xiaoke Wang           2022-04-28  598  		if (!master) {
bb5bdc5ab7f133 drivers/iommu/msm_iommu.c Xiaoke Wang           2022-04-28  599  			dev_err(dev, "Failed to allocate iommu_master\n");
bb5bdc5ab7f133 drivers/iommu/msm_iommu.c Xiaoke Wang           2022-04-28  600  			return -ENOMEM;
bb5bdc5ab7f133 drivers/iommu/msm_iommu.c Xiaoke Wang           2022-04-28  601  		}
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  602  		master->of_node = dev->of_node;
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  603  		list_add(&master->list, &(*iommu)->ctx_list);
4bbe0c7ccc431d drivers/iommu/msm_iommu.c Joerg Roedel          2020-06-25  604  		dev_iommu_priv_set(dev, master);
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  605  	}
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  606  
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  607  	for (sid = 0; sid < master->num_mids; sid++)
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13 @608  		if (master->mids[sid] == spec->args[0]) {
f066b8f7d961b0 drivers/iommu/msm_iommu.c Justin Stitt          2022-07-21  609  			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  610  				 sid);
bb5bdc5ab7f133 drivers/iommu/msm_iommu.c Xiaoke Wang           2022-04-28  611  			return 0;
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  612  		}
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  613  
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  614  	master->mids[master->num_mids++] = spec->args[0];
bb5bdc5ab7f133 drivers/iommu/msm_iommu.c Xiaoke Wang           2022-04-28  615  	return 0;
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  616  }
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  617  
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  618  static int qcom_iommu_of_xlate(struct device *dev,
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  619  			       struct of_phandle_args *spec)
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  620  {
8b9ad480bd1dd2 drivers/iommu/msm_iommu.c Xiaomeng Tong         2022-05-01  621  	struct msm_iommu_dev *iommu = NULL, *iter;
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  622  	unsigned long flags;
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  623  	int ret = 0;
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  624  
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  625  	spin_lock_irqsave(&msm_iommu_lock, flags);
8b9ad480bd1dd2 drivers/iommu/msm_iommu.c Xiaomeng Tong         2022-05-01  626  	list_for_each_entry(iter, &qcom_iommu_devices, dev_node) {
8b9ad480bd1dd2 drivers/iommu/msm_iommu.c Xiaomeng Tong         2022-05-01  627  		if (iter->dev->of_node == spec->np) {
8b9ad480bd1dd2 drivers/iommu/msm_iommu.c Xiaomeng Tong         2022-05-01  628  			iommu = iter;
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  629  			break;
8b9ad480bd1dd2 drivers/iommu/msm_iommu.c Xiaomeng Tong         2022-05-01  630  		}
8b9ad480bd1dd2 drivers/iommu/msm_iommu.c Xiaomeng Tong         2022-05-01  631  	}
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  632  
8b9ad480bd1dd2 drivers/iommu/msm_iommu.c Xiaomeng Tong         2022-05-01  633  	if (!iommu) {
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  634  		ret = -ENODEV;
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  635  		goto fail;
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  636  	}
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  637  
bb5bdc5ab7f133 drivers/iommu/msm_iommu.c Xiaoke Wang           2022-04-28  638  	ret = insert_iommu_master(dev, &iommu, spec);
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  639  fail:
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  640  	spin_unlock_irqrestore(&msm_iommu_lock, flags);
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  641  
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  642  	return ret;
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  643  }
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  644  
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  645  irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  646  {
109bd48ea2e1fb drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  647  	struct msm_iommu_dev *iommu = dev_id;
33069739d1c2f0 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-11-12  648  	unsigned int fsr;
a43d8c101eb71b arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2011-02-24  649  	int i, ret;
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  650  
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  651  	spin_lock(&msm_iommu_lock);
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  652  
109bd48ea2e1fb drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  653  	if (!iommu) {
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  654  		pr_err("Invalid device ID in context interrupt handler\n");
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  655  		goto fail;
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  656  	}
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  657  
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  658  	pr_err("Unexpected IOMMU page fault!\n");
109bd48ea2e1fb drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  659  	pr_err("base = %08x\n", (unsigned int)iommu->base);
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  660  
109bd48ea2e1fb drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  661  	ret = __enable_clocks(iommu);
41f3f5138a5ea7 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2011-02-24  662  	if (ret)
41f3f5138a5ea7 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2011-02-24  663  		goto fail;
41f3f5138a5ea7 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2011-02-24  664  
109bd48ea2e1fb drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  665  	for (i = 0; i < iommu->ncb; i++) {
109bd48ea2e1fb drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  666  		fsr = GET_FSR(iommu->base, i);
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  667  		if (fsr) {
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  668  			pr_err("Fault occurred in context %d.\n", i);
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  669  			pr_err("Interesting registers:\n");
109bd48ea2e1fb drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  670  			print_ctx_regs(iommu->base, i);
109bd48ea2e1fb drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  671  			SET_FSR(iommu->base, i, 0x4000000F);
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  672  		}
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  673  	}
109bd48ea2e1fb drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  674  	__disable_clocks(iommu);
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  675  fail:
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  676  	spin_unlock(&msm_iommu_lock);
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  677  	return 0;
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  678  }
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  679  
f78ebca8ff3d61 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  680  static struct iommu_ops msm_iommu_ops = {
78fc30b4bb3540 drivers/iommu/msm_iommu.c Jason Gunthorpe       2023-09-13  681  	.identity_domain = &msm_iommu_identity_domain,
4efd98d41ea718 drivers/iommu/msm_iommu.c Jason Gunthorpe       2023-09-13  682  	.domain_alloc_paging = msm_iommu_domain_alloc_paging,
9a630a4b41a263 drivers/iommu/msm_iommu.c Lu Baolu              2022-02-16  683  	.probe_device = msm_iommu_probe_device,
9a630a4b41a263 drivers/iommu/msm_iommu.c Lu Baolu              2022-02-16  684  	.device_group = generic_device_group,
9a630a4b41a263 drivers/iommu/msm_iommu.c Lu Baolu              2022-02-16  685  	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
9a630a4b41a263 drivers/iommu/msm_iommu.c Lu Baolu              2022-02-16  686  	.of_xlate = qcom_iommu_of_xlate,
9a630a4b41a263 drivers/iommu/msm_iommu.c Lu Baolu              2022-02-16  687  	.default_domain_ops = &(const struct iommu_domain_ops) {
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  688  		.attach_dev	= msm_iommu_attach_dev,
8b35cdcf9bf820 drivers/iommu/msm_iommu.c Robin Murphy          2022-11-15  689  		.map_pages	= msm_iommu_map,
8b35cdcf9bf820 drivers/iommu/msm_iommu.c Robin Murphy          2022-11-15  690  		.unmap_pages	= msm_iommu_unmap,
e953f7f2fa78d1 drivers/iommu/msm_iommu.c Will Deacon           2019-07-02  691  		/*
e953f7f2fa78d1 drivers/iommu/msm_iommu.c Will Deacon           2019-07-02  692  		 * Nothing is needed here, the barrier to guarantee
e953f7f2fa78d1 drivers/iommu/msm_iommu.c Will Deacon           2019-07-02  693  		 * completion of the tlb sync operation is implicitly
e953f7f2fa78d1 drivers/iommu/msm_iommu.c Will Deacon           2019-07-02  694  		 * taken care when the iommu client does a writel before
e953f7f2fa78d1 drivers/iommu/msm_iommu.c Will Deacon           2019-07-02  695  		 * kick starting the other master.
e953f7f2fa78d1 drivers/iommu/msm_iommu.c Will Deacon           2019-07-02  696  		 */
e953f7f2fa78d1 drivers/iommu/msm_iommu.c Will Deacon           2019-07-02  697  		.iotlb_sync	= NULL,
c867c78acae96f drivers/iommu/msm_iommu.c Robin Murphy          2021-01-27  698  		.iotlb_sync_map	= msm_iommu_sync_map,
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  699  		.iova_to_phys	= msm_iommu_iova_to_phys,
9a630a4b41a263 drivers/iommu/msm_iommu.c Lu Baolu              2022-02-16  700  		.free		= msm_iommu_domain_free,
9a630a4b41a263 drivers/iommu/msm_iommu.c Lu Baolu              2022-02-16  701  	}
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  702  };
0720d1f052dc15 arch/arm/mach-msm/iommu.c Stepan Moskovchenko   2010-08-24  703  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  704  static int msm_iommu_probe(struct platform_device *pdev)
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  705  {
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  706  	struct resource *r;
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  707  	resource_size_t ioaddr;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  708  	struct msm_iommu_dev *iommu;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  709  	int ret, par, val;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  710  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  711  	iommu = devm_kzalloc(&pdev->dev, sizeof(*iommu), GFP_KERNEL);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  712  	if (!iommu)
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  713  		return -ENODEV;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  714  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  715  	iommu->dev = &pdev->dev;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  716  	INIT_LIST_HEAD(&iommu->ctx_list);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  717  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  718  	iommu->pclk = devm_clk_get(iommu->dev, "smmu_pclk");
a063158b20afea drivers/iommu/msm_iommu.c David Heidelberg      2022-02-06  719  	if (IS_ERR(iommu->pclk))
a063158b20afea drivers/iommu/msm_iommu.c David Heidelberg      2022-02-06  720  		return dev_err_probe(iommu->dev, PTR_ERR(iommu->pclk),
a063158b20afea drivers/iommu/msm_iommu.c David Heidelberg      2022-02-06  721  				     "could not get smmu_pclk\n");
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  722  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  723  	ret = clk_prepare(iommu->pclk);
a063158b20afea drivers/iommu/msm_iommu.c David Heidelberg      2022-02-06  724  	if (ret)
a063158b20afea drivers/iommu/msm_iommu.c David Heidelberg      2022-02-06  725  		return dev_err_probe(iommu->dev, ret,
a063158b20afea drivers/iommu/msm_iommu.c David Heidelberg      2022-02-06  726  				     "could not prepare smmu_pclk\n");
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  727  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  728  	iommu->clk = devm_clk_get(iommu->dev, "iommu_clk");
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  729  	if (IS_ERR(iommu->clk)) {
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  730  		clk_unprepare(iommu->pclk);
a063158b20afea drivers/iommu/msm_iommu.c David Heidelberg      2022-02-06  731  		return dev_err_probe(iommu->dev, PTR_ERR(iommu->clk),
a063158b20afea drivers/iommu/msm_iommu.c David Heidelberg      2022-02-06  732  				     "could not get iommu_clk\n");
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  733  	}
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  734  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  735  	ret = clk_prepare(iommu->clk);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  736  	if (ret) {
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  737  		clk_unprepare(iommu->pclk);
a063158b20afea drivers/iommu/msm_iommu.c David Heidelberg      2022-02-06  738  		return dev_err_probe(iommu->dev, ret, "could not prepare iommu_clk\n");
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  739  	}
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  740  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  741  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  742  	iommu->base = devm_ioremap_resource(iommu->dev, r);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  743  	if (IS_ERR(iommu->base)) {
a063158b20afea drivers/iommu/msm_iommu.c David Heidelberg      2022-02-06  744  		ret = dev_err_probe(iommu->dev, PTR_ERR(iommu->base), "could not get iommu base\n");
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  745  		goto fail;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  746  	}
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  747  	ioaddr = r->start;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  748  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  749  	iommu->irq = platform_get_irq(pdev, 0);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  750  	if (iommu->irq < 0) {
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  751  		ret = -ENODEV;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  752  		goto fail;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  753  	}
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  754  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13 @755  	ret = of_property_read_u32(iommu->dev->of_node, "qcom,ncb", &val);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  756  	if (ret) {
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  757  		dev_err(iommu->dev, "could not get ncb\n");
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  758  		goto fail;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  759  	}
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  760  	iommu->ncb = val;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  761  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  762  	msm_iommu_reset(iommu->base, iommu->ncb);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  763  	SET_M(iommu->base, 0, 1);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  764  	SET_PAR(iommu->base, 0, 0);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  765  	SET_V2PCFG(iommu->base, 0, 1);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  766  	SET_V2PPR(iommu->base, 0, 0);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  767  	par = GET_PAR(iommu->base, 0);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  768  	SET_V2PCFG(iommu->base, 0, 0);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  769  	SET_M(iommu->base, 0, 0);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  770  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  771  	if (!par) {
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  772  		pr_err("Invalid PAR value detected\n");
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  773  		ret = -ENODEV;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  774  		goto fail;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  775  	}
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  776  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  777  	ret = devm_request_threaded_irq(iommu->dev, iommu->irq, NULL,
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  778  					msm_iommu_fault_handler,
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  779  					IRQF_ONESHOT | IRQF_SHARED,
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  780  					"msm_iommu_secure_irpt_handler",
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  781  					iommu);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  782  	if (ret) {
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  783  		pr_err("Request IRQ %d failed with ret=%d\n", iommu->irq, ret);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  784  		goto fail;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  785  	}
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  786  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  787  	list_add(&iommu->dev_node, &qcom_iommu_devices);
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  788  
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  789  	ret = iommu_device_sysfs_add(&iommu->iommu, iommu->dev, NULL,
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  790  				     "msm-smmu.%pa", &ioaddr);
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  791  	if (ret) {
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  792  		pr_err("Could not add msm-smmu at %pa to sysfs\n", &ioaddr);
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  793  		goto fail;
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  794  	}
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  795  
2d471b20c55e13 drivers/iommu/msm_iommu.c Robin Murphy          2021-04-01  796  	ret = iommu_device_register(&iommu->iommu, &msm_iommu_ops, &pdev->dev);
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  797  	if (ret) {
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  798  		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  799  		goto fail;
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  800  	}
42df43b36163ed drivers/iommu/msm_iommu.c Joerg Roedel          2017-02-02  801  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  802  	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  803  		iommu->base, iommu->irq, iommu->ncb);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  804  
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  805  	return ret;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  806  fail:
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  807  	clk_unprepare(iommu->clk);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  808  	clk_unprepare(iommu->pclk);
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  809  	return ret;
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  810  }
f7f125ef0b0210 drivers/iommu/msm_iommu.c Sricharan Ramabadhran 2016-06-13  811  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

